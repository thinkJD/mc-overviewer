FROM	debian:jessie-backports

RUN	apt-get update && apt-get install -y wget

RUN	echo "deb http://overviewer.org/debian ./" >> /etc/apt/sources.list
RUN 	wget -O - http://overviewer.org/debian/overviewer.gpg.asc | apt-key add -
RUN	apt-get update && apt-get install -y minecraft-overviewer && apt-get clean

RUN	mkdir /var/minecraft-overviewer && \
		cd /var/minecraft-overviewer && \
		mkdir world map

COPY	minecraft-overviewer.config /var/minecraft-overviewer/
RUN	wget https://s3.amazonaws.com/Minecraft.Download/versions/1.8/1.8.jar -P ~/.minecraft/versions/1.8/

VOLUME	["/var/minecraft-overviewer/world", "/var/minecraft-overviewer/map"]

ENTRYPOINT	["/usr/bin/overviewer.py"]
CMD		["--config", "/var/minecraft-overviewer/minecraft-overviewer.config"]
