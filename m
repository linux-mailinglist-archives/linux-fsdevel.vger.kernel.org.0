Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6812B137229
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAJQEP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 11:04:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728636AbgAJQEP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:04:15 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B88A20838;
        Fri, 10 Jan 2020 16:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578672254;
        bh=pPzpewqjP/Yg7UZcZrKRtClVFAqh4OnbfAcOXYIoK2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DD8oCWhWznUo0xTxHtcXuTJDt++u2DTxJKr4XM2TfXHbN2LWOGHlomgPKJuCpqT9N
         z6JbH8BgCi/zM72kyGmsBEFssYbWwuQ1m4iX3Dy8bUrxRcbJcHeyEzjBR79CNnPVCR
         hREwGuDJvVUy13lptRkZa9d9jB4JQnXtd7QGTcnc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/22] tools: bootconfig: Add bootconfig test script
Date:   Sat, 11 Jan 2020 01:04:07 +0900
Message-Id: <157867224728.17873.18114241801246589416.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157867220019.17873.13377985653744804396.stgit@devnote2>
References: <157867220019.17873.13377985653744804396.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a bootconfig test script to ensure the tool and
boot config parser are working correctly.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v6:
  - Add some testcases for value parser
  - Add a test case for checking delete old bootconfig
 Changes in v5:
  - Show test target bootconfig name
  - Add printables testcases
  - Add bad array testcase
---
 tools/bootconfig/Makefile                          |    3 +
 .../samples/bad-array-space-comment.bconf          |    5 +
 tools/bootconfig/samples/bad-array.bconf           |    2 
 tools/bootconfig/samples/bad-dotword.bconf         |    4 +
 tools/bootconfig/samples/bad-empty.bconf           |    1 
 tools/bootconfig/samples/bad-keyerror.bconf        |    2 
 tools/bootconfig/samples/bad-longkey.bconf         |    1 
 tools/bootconfig/samples/bad-manywords.bconf       |    1 
 tools/bootconfig/samples/bad-no-keyword.bconf      |    2 
 tools/bootconfig/samples/bad-nonprintable.bconf    |    2 
 tools/bootconfig/samples/bad-spaceword.bconf       |    2 
 tools/bootconfig/samples/bad-tree.bconf            |    5 +
 tools/bootconfig/samples/bad-value.bconf           |    3 +
 tools/bootconfig/samples/escaped.bconf             |    3 +
 .../samples/good-array-space-comment.bconf         |    4 +
 .../samples/good-comment-after-value.bconf         |    1 
 tools/bootconfig/samples/good-printables.bconf     |    2 
 tools/bootconfig/samples/good-simple.bconf         |   11 ++
 tools/bootconfig/samples/good-single.bconf         |    4 +
 .../samples/good-space-after-value.bconf           |    1 
 tools/bootconfig/samples/good-tree.bconf           |   12 ++
 tools/bootconfig/test-bootconfig.sh                |  105 ++++++++++++++++++++
 22 files changed, 176 insertions(+)
 create mode 100644 tools/bootconfig/samples/bad-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/bad-array.bconf
 create mode 100644 tools/bootconfig/samples/bad-dotword.bconf
 create mode 100644 tools/bootconfig/samples/bad-empty.bconf
 create mode 100644 tools/bootconfig/samples/bad-keyerror.bconf
 create mode 100644 tools/bootconfig/samples/bad-longkey.bconf
 create mode 100644 tools/bootconfig/samples/bad-manywords.bconf
 create mode 100644 tools/bootconfig/samples/bad-no-keyword.bconf
 create mode 100644 tools/bootconfig/samples/bad-nonprintable.bconf
 create mode 100644 tools/bootconfig/samples/bad-spaceword.bconf
 create mode 100644 tools/bootconfig/samples/bad-tree.bconf
 create mode 100644 tools/bootconfig/samples/bad-value.bconf
 create mode 100644 tools/bootconfig/samples/escaped.bconf
 create mode 100644 tools/bootconfig/samples/good-array-space-comment.bconf
 create mode 100644 tools/bootconfig/samples/good-comment-after-value.bconf
 create mode 100644 tools/bootconfig/samples/good-printables.bconf
 create mode 100644 tools/bootconfig/samples/good-simple.bconf
 create mode 100644 tools/bootconfig/samples/good-single.bconf
 create mode 100644 tools/bootconfig/samples/good-space-after-value.bconf
 create mode 100644 tools/bootconfig/samples/good-tree.bconf
 create mode 100755 tools/bootconfig/test-bootconfig.sh

diff --git a/tools/bootconfig/Makefile b/tools/bootconfig/Makefile
index 681b7aef3e44..a6146ac64458 100644
--- a/tools/bootconfig/Makefile
+++ b/tools/bootconfig/Makefile
@@ -16,5 +16,8 @@ bootconfig: ../../lib/bootconfig.c main.c $(HEADER)
 install: $(PROGS)
 	install bootconfig $(DESTDIR)$(bindir)
 
+test: bootconfig
+	./test-bootconfig.sh
+
 clean:
 	$(RM) -f *.o bootconfig
diff --git a/tools/bootconfig/samples/bad-array-space-comment.bconf b/tools/bootconfig/samples/bad-array-space-comment.bconf
new file mode 100644
index 000000000000..fda19e47d0db
--- /dev/null
+++ b/tools/bootconfig/samples/bad-array-space-comment.bconf
@@ -0,0 +1,5 @@
+key =	# comment
+	"value1",	  # comment1
+	"value2" 	  # comment2
+,
+	"value3"
diff --git a/tools/bootconfig/samples/bad-array.bconf b/tools/bootconfig/samples/bad-array.bconf
new file mode 100644
index 000000000000..0174af019d7f
--- /dev/null
+++ b/tools/bootconfig/samples/bad-array.bconf
@@ -0,0 +1,2 @@
+# Array must be comma separated.
+key = "value1" "value2"
diff --git a/tools/bootconfig/samples/bad-dotword.bconf b/tools/bootconfig/samples/bad-dotword.bconf
new file mode 100644
index 000000000000..ba5557b2bdd3
--- /dev/null
+++ b/tools/bootconfig/samples/bad-dotword.bconf
@@ -0,0 +1,4 @@
+# do not start keyword with .
+key {
+  .word = 1
+}
diff --git a/tools/bootconfig/samples/bad-empty.bconf b/tools/bootconfig/samples/bad-empty.bconf
new file mode 100644
index 000000000000..2ba3f6cc6a47
--- /dev/null
+++ b/tools/bootconfig/samples/bad-empty.bconf
@@ -0,0 +1 @@
+# Wrong boot config: comment only
diff --git a/tools/bootconfig/samples/bad-keyerror.bconf b/tools/bootconfig/samples/bad-keyerror.bconf
new file mode 100644
index 000000000000..b6e247a099d0
--- /dev/null
+++ b/tools/bootconfig/samples/bad-keyerror.bconf
@@ -0,0 +1,2 @@
+# key word can not contain ","
+key,word
diff --git a/tools/bootconfig/samples/bad-longkey.bconf b/tools/bootconfig/samples/bad-longkey.bconf
new file mode 100644
index 000000000000..eb97369f91a8
--- /dev/null
+++ b/tools/bootconfig/samples/bad-longkey.bconf
@@ -0,0 +1 @@
+key_word_is_too_long01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345
diff --git a/tools/bootconfig/samples/bad-manywords.bconf b/tools/bootconfig/samples/bad-manywords.bconf
new file mode 100644
index 000000000000..8db81967c48a
--- /dev/null
+++ b/tools/bootconfig/samples/bad-manywords.bconf
@@ -0,0 +1 @@
+key1.is2.too3.long4.5.6.7.8.9.10.11.12.13.14.15.16.17
diff --git a/tools/bootconfig/samples/bad-no-keyword.bconf b/tools/bootconfig/samples/bad-no-keyword.bconf
new file mode 100644
index 000000000000..eff26808566c
--- /dev/null
+++ b/tools/bootconfig/samples/bad-no-keyword.bconf
@@ -0,0 +1,2 @@
+# No keyword
+{}
diff --git a/tools/bootconfig/samples/bad-nonprintable.bconf b/tools/bootconfig/samples/bad-nonprintable.bconf
new file mode 100644
index 000000000000..3bb1a2864e52
--- /dev/null
+++ b/tools/bootconfig/samples/bad-nonprintable.bconf
@@ -0,0 +1,2 @@
+# Non printable
+key = ""
diff --git a/tools/bootconfig/samples/bad-spaceword.bconf b/tools/bootconfig/samples/bad-spaceword.bconf
new file mode 100644
index 000000000000..90c703d32a9a
--- /dev/null
+++ b/tools/bootconfig/samples/bad-spaceword.bconf
@@ -0,0 +1,2 @@
+# No space between words
+key . word
diff --git a/tools/bootconfig/samples/bad-tree.bconf b/tools/bootconfig/samples/bad-tree.bconf
new file mode 100644
index 000000000000..5a6038edcd55
--- /dev/null
+++ b/tools/bootconfig/samples/bad-tree.bconf
@@ -0,0 +1,5 @@
+# brace is not closing
+tree {
+  node {
+    value = 1
+}
diff --git a/tools/bootconfig/samples/bad-value.bconf b/tools/bootconfig/samples/bad-value.bconf
new file mode 100644
index 000000000000..a1217fed86cc
--- /dev/null
+++ b/tools/bootconfig/samples/bad-value.bconf
@@ -0,0 +1,3 @@
+# Quotes error
+value = "data
+
diff --git a/tools/bootconfig/samples/escaped.bconf b/tools/bootconfig/samples/escaped.bconf
new file mode 100644
index 000000000000..9f72043b3216
--- /dev/null
+++ b/tools/bootconfig/samples/escaped.bconf
@@ -0,0 +1,3 @@
+key1 = "A\B\C"
+key2 = '\'\''
+key3 = "\\"
diff --git a/tools/bootconfig/samples/good-array-space-comment.bconf b/tools/bootconfig/samples/good-array-space-comment.bconf
new file mode 100644
index 000000000000..45b938dc0695
--- /dev/null
+++ b/tools/bootconfig/samples/good-array-space-comment.bconf
@@ -0,0 +1,4 @@
+key =	# comment
+	"value1",	  # comment1
+	"value2"	 , # comment2
+	"value3"
diff --git a/tools/bootconfig/samples/good-comment-after-value.bconf b/tools/bootconfig/samples/good-comment-after-value.bconf
new file mode 100644
index 000000000000..0d92a853df72
--- /dev/null
+++ b/tools/bootconfig/samples/good-comment-after-value.bconf
@@ -0,0 +1 @@
+key = "value"  # comment
diff --git a/tools/bootconfig/samples/good-printables.bconf b/tools/bootconfig/samples/good-printables.bconf
new file mode 100644
index 000000000000..91b90073c0f8
--- /dev/null
+++ b/tools/bootconfig/samples/good-printables.bconf
@@ -0,0 +1,2 @@
+key = "	
+ !#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
diff --git a/tools/bootconfig/samples/good-simple.bconf b/tools/bootconfig/samples/good-simple.bconf
new file mode 100644
index 000000000000..37dd6d21c176
--- /dev/null
+++ b/tools/bootconfig/samples/good-simple.bconf
@@ -0,0 +1,11 @@
+# A good simple bootconfig
+
+key.word1 = 1
+key.word2=2
+key.word3 = 3;
+
+key {
+word4 = 4 }
+
+key { word5 = 5; word6 = 6 }
+
diff --git a/tools/bootconfig/samples/good-single.bconf b/tools/bootconfig/samples/good-single.bconf
new file mode 100644
index 000000000000..98e55ad8b711
--- /dev/null
+++ b/tools/bootconfig/samples/good-single.bconf
@@ -0,0 +1,4 @@
+# single key style
+key = 1
+key2 = 2
+key3 = "alpha", "beta"
diff --git a/tools/bootconfig/samples/good-space-after-value.bconf b/tools/bootconfig/samples/good-space-after-value.bconf
new file mode 100644
index 000000000000..56c15cbc5741
--- /dev/null
+++ b/tools/bootconfig/samples/good-space-after-value.bconf
@@ -0,0 +1 @@
+key = "value"   
diff --git a/tools/bootconfig/samples/good-tree.bconf b/tools/bootconfig/samples/good-tree.bconf
new file mode 100644
index 000000000000..f2ddefc8b52a
--- /dev/null
+++ b/tools/bootconfig/samples/good-tree.bconf
@@ -0,0 +1,12 @@
+key {
+  word {
+    tree {
+      value = "0"}
+  }
+  word2 {
+    tree {
+      value = 1,2 }
+  }
+}
+other.tree {
+  value = 2; value2 = 3;}
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
new file mode 100755
index 000000000000..87725e8723f8
--- /dev/null
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -0,0 +1,105 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+echo "Boot config test script"
+
+BOOTCONF=./bootconfig
+INITRD=`mktemp initrd-XXXX`
+TEMPCONF=`mktemp temp-XXXX.bconf`
+NG=0
+
+cleanup() {
+  rm -f $INITRD $TEMPCONF
+  exit $NG
+}
+
+trap cleanup EXIT TERM
+
+NO=1
+
+xpass() { # pass test command
+  echo "test case $NO ($3)... "
+  if ! ($@ && echo "\t\t[OK]"); then
+     echo "\t\t[NG]"; NG=$((NG + 1))
+  fi
+  NO=$((NO + 1))
+}
+
+xfail() { # fail test command
+  echo "test case $NO ($3)... "
+  if ! (! $@ && echo "\t\t[OK]"); then
+     echo "\t\t[NG]"; NG=$((NG + 1))
+  fi
+  NO=$((NO + 1))
+}
+
+echo "Basic command test"
+xpass $BOOTCONF $INITRD
+
+echo "Delete command should success without bootconfig"
+xpass $BOOTCONF -d $INITRD
+
+dd if=/dev/zero of=$INITRD bs=4096 count=1
+echo "key = value;" > $TEMPCONF
+bconf_size=$(stat -c %s $TEMPCONF)
+initrd_size=$(stat -c %s $INITRD)
+
+echo "Apply command test"
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+new_size=$(stat -c %s $INITRD)
+
+echo "File size check"
+xpass test $new_size -eq $(expr $bconf_size + $initrd_size + 9)
+
+echo "Apply command repeat test"
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+
+echo "File size check"
+xpass test $new_size -eq $(stat -c %s $INITRD)
+
+echo "Delete command check"
+xpass $BOOTCONF -d $INITRD
+
+echo "File size check"
+new_size=$(stat -c %s $INITRD)
+xpass test $new_size -eq $initrd_size
+
+echo "Max node number check"
+
+echo -n > $TEMPCONF
+for i in `seq 1 1024` ; do
+   echo "node$i" >> $TEMPCONF
+done
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+
+echo "badnode" >> $TEMPCONF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
+echo "Max filesize check"
+
+# Max size is 32767 (including terminal byte)
+echo -n "data = \"" > $TEMPCONF
+dd if=/dev/urandom bs=768 count=32 | base64 -w0 >> $TEMPCONF
+echo "\"" >> $TEMPCONF
+xfail $BOOTCONF -a $TEMPCONF $INITRD
+
+truncate -s 32764 $TEMPCONF
+echo "\"" >> $TEMPCONF	# add 2 bytes + terminal ('\"\n\0')
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+
+echo "=== expected failure cases ==="
+for i in samples/bad-* ; do
+  xfail $BOOTCONF -a $i $INITRD
+done
+
+echo "=== expected success cases ==="
+for i in samples/good-* ; do
+  xpass $BOOTCONF -a $i $INITRD
+done
+
+echo
+if [ $NG -eq 0 ]; then
+	echo "All tests passed"
+else
+	echo "$NG tests failed"
+fi

