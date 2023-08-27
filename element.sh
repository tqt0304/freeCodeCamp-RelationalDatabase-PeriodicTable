#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
char_count=`echo "$1" | wc -m`

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]+$ ]] #index
then

  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  NAME=$(echo "$NAME" | sed 's/^ *//g')
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  SYMBOL=$(echo "$SYMBOL" | sed 's/^ *//g')
  ATOMIC_NUMBER=$1
  TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$1")
  TYPE=$(echo "$TYPE" | sed 's/^ *//g')
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  MASS=$(echo "$MASS" | sed 's/^ *//g')
  MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  MELTING=$(echo "$MELTING" | sed 's/^ *//g')
  BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
  BOILING=$(echo "$BOILING" | sed 's/^ *//g')
  if [[ -z $MASS ]]
  then 
    echo -e "I could not find that element in the database."
  else
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
elif [[ $char_count -lt 4 ]] #symbol
then

  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  ATOMIC_NUMBER=$(echo "$ATOMIC_NUMBER" | sed 's/^ *//g')
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo -e "I could not find that element in the database."
  else
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    NAME=$(echo "$NAME" | sed 's/^ *//g')
    SYMBOL=$1
    TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$(echo "$TYPE" | sed 's/^ *//g')
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MASS=$(echo "$MASS" | sed 's/^ *//g')
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING=$(echo "$MELTING" | sed 's/^ *//g')
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING=$(echo "$BOILING" | sed 's/^ *//g')
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi

else #name

  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE  name='$1'")
  ATOMIC_NUMBER=$(echo "$ATOMIC_NUMBER" | sed 's/^ *//g')
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo -e "I could not find that element in the database."
  else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
    SYMBOL=$(echo "$SYMBOL" | sed 's/^ *//g')
    NAME=$1
    TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ATOMIC_NUMBER")
    TYPE=$(echo "$TYPE" | sed 's/^ *//g')
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MASS=$(echo "$MASS" | sed 's/^ *//g')
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    MELTING=$(echo "$MELTING" | sed 's/^ *//g')
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
    BOILING=$(echo "$BOILING" | sed 's/^ *//g')
    echo -e "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
  fi
fi


