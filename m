Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A589C7A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfHZDQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfHZDQd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:16:33 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2A1F2168B;
        Mon, 26 Aug 2019 03:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789391;
        bh=uWC/H1l7v6d+/MwTfG766K9JXtMKh6YTaqA+3BYw+7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LY8BlqA7MeEPLijQUsaoCM5739rOMHUHX8tuJTSV1xWTYqHVPwt4LXiU9F5SPf1z7
         A/8GRdiGRwkfvOFaUkmuc3x7JRamQ6mk5CoblNiWYzcwusDUpaq9ZKAxP3PNG+gTHI
         IGDBnjQuz+aYkrql7nqEiNeNYkug3LQwmxVgKuRA=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
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
Subject: [RFC PATCH v3 04/19] Documentation: skc: Add a doc for supplemental kernel cmdline
Date:   Mon, 26 Aug 2019 12:16:25 +0900
Message-Id: <156678938543.21459.628373407524491520.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156678933823.21459.4100380582025186209.stgit@devnote2>
References: <156678933823.21459.4100380582025186209.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a documentation for supplemental kernel cmdline under
admin-guide, since it is including the syntax of SKC file.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/index.rst             |    1 
 Documentation/admin-guide/kernel-parameters.txt |    1 
 Documentation/admin-guide/skc.rst               |  123 +++++++++++++++++++++++
 MAINTAINERS                                     |    1 
 4 files changed, 126 insertions(+)
 create mode 100644 Documentation/admin-guide/skc.rst

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 33feab2f4084..44b4cb61003a 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -106,6 +106,7 @@ configure specific aspects of kernel behavior to your liking.
    rtc
    svga
    video-output
+   skc
 
 .. only::  subproject and html
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9a955b1bd1bf..334ce59de23a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4277,6 +4277,7 @@
 			Pass the physical memory address and size of loaded
 			supplemental kernel cmdline (SKC) text. This will
 			be treated by bootloader which loads the SKC file.
+			See Documentation/admin-guide/skc.rst.
 
 	slram=		[HW,MTD]
 
diff --git a/Documentation/admin-guide/skc.rst b/Documentation/admin-guide/skc.rst
new file mode 100644
index 000000000000..dc6f7ba8e1d7
--- /dev/null
+++ b/Documentation/admin-guide/skc.rst
@@ -0,0 +1,123 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
+Supplemental Kernel Commandline
+================================
+
+:Author: Masami Hiramatsu <mhiramat@kernel.org>
+
+Overview
+========
+
+Supplemental Kernel Commandline (SKC) is expanding current kernel cmdline
+to support additional key-value data when boot the kernel in efficient way.
+This allows adoministrators to pass a tree-structured key-value text file
+(SKC file) via bootloaders.
+
+SKC File Syntax
+===============
+
+SKC basic syntax is simple. Each key consists of dot-connected-words, and
+key and value are connected by "=". The value has to be terminated by semi-
+colon (";"). For array value, array entries are separated by comma (",").
+
+KEY[.WORD[...]] = VALUE[, VALUE2[...]];
+
+Each key word only contains alphabet, number, dash ("-") or underscore ("_").
+If a value need to contain the delimiters, you can use double-quotes to
+quote it. A double quote in VALUE can be escaped by backslash. There can
+be a key which doesn't have value or has an empty value. Those keys are
+used for checking the key exists or not (like a boolean).
+
+Tree Structure
+--------------
+
+SKC allows user to merge partially same word keys by brace. For example,
+
+foo.bar.baz = value1;
+foo.bar.qux.quux = value2;
+
+These can be written also in
+
+foo.bar {
+   baz = value1;
+   qux.quux = value2;
+}
+
+In both style, same key words are automatically merged when parsing it
+at boot time. So you can append similar trees or key-values.
+
+SKC File Limitation
+===================
+
+Currently the maximum SKC file size is 32KB and the total key-words (not
+key-value entries) must be under 512 nodes.
+
+/proc/sup_cmdline
+=================
+
+/proc/sup_cmdline is the user-space interface of supplemental kernel
+cmdline. Unlike /proc/cmdline, this file shows the key-value style list.
+Each key-value pair is shown in each line with following style.
+
+KEY[.WORDS...] = "[VALUE]"[,"VALUE2"...];
+
+How to Pass at Boot
+===================
+
+SKC file is passed to kernel via memory, so the boot loader must support
+loading SKC file. After loading the SKC file on memory, the boot loader
+has to add "skc=PADDR,SIZE" argument to kernel cmdline, where the PADDR
+is the physical address of the memory block and SIZE is the size of SKC
+file.
+
+SKC APIs
+========
+
+User can query or loop on key-value pairs, also it is possible to find
+a root (prefix) key node and find key-values under that node.
+
+If you have a key string, you can query the value directly with the key
+using skc_find_value(). If you want to know what keys exist in the SKC
+tree, you can use skc_for_each_key_value() to iterate key-value pairs.
+Note that you need to use skc_array_for_each_value() for accessing
+each arraies value, e.g.
+
+::
+
+ vnode = NULL;
+ skc_find_value("key.word", &vnode);
+ if (vnode && skc_node_is_array(vnode))
+    skc_array_for_each_value(vnode, value) {
+      printk("%s ", value);
+    }
+
+If you want to focus on keys which has a prefix string, you can use
+skc_find_node() to find a node which prefix key words, and iterate
+keys under the prefix node with skc_node_for_each_key_value().
+
+But the most typical usage is to get the named value under prefix
+or get the named array under prefix as below.
+
+::
+
+ root = skc_find_node("key.prefix");
+ value = skc_node_find_value(root, "option", &vnode);
+ ...
+ skc_node_for_each_array_value(root, "array-option", value, anode) {
+    ...
+ }
+
+This accesses a value of "key.prefix.option" and an array of
+"key.prefix.array-option".
+
+Locking is not needed, since after initialized, SKC becomes readonly.
+All data and keys must be copied if you need to modify it.
+
+
+Functions and structures
+========================
+
+.. kernel-doc:: include/linux/skc.h
+.. kernel-doc:: lib/skc.c
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 10dd38311d96..9c0b97643515 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15368,6 +15368,7 @@ S:	Maintained
 F:	lib/skc.c
 F:	fs/proc/sup_cmdline.c
 F:	include/linux/skc.h
+F:	Documentation/admin-guide/skc.rst
 
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>

