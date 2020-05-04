#!/bin/bash

HOMEDIR="HOMEDIR"
USER="GITUSER"
REPO="GITREPO"
TOKEN="GITTOKEN"
DCFILE="docker-compose.yml"
EXT=".last"

cd $HOMEDIR
rm -rf $HOMEDIR/$REPO$EXT
mv $HOMEDIR/$REPO $HOMEDIR/$REPO$EXT

git clone https://$TOKEN@github.com/$USER/$REPO.git

result=$(diff $HOMEDIR/$REPO/$DCFILE $HOMEDIR/$REPO$EXT/$DCFILE)

if [ ${#result} -eq 0 ]
then
echo $(date "+%Y.%m.%d-%H.%M.%S") " - No need to deploy." 
echo $(date "+%Y.%m.%d-%H.%M.%S") " - No need to deploy." >>deploy.log
else
echo $(date "+%Y.%m.%d-%H.%M.%S") " - Deploy!"
echo $(date "+%Y.%m.%d-%H.%M.%S") " - Deploy!" >>deploy.log
cd $HOMEDIR/$REPO
/usr/local/bin/docker-compose up -d --force-recreate --remove-orphans 
fi

