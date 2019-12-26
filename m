Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75FE12ACB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLZOE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:04:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLZOE4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:04:56 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68BB92075E;
        Thu, 26 Dec 2019 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369094;
        bh=6qaC4q1gYtqR/yYPdgRTo0Vdaxw17g6SP+EuGETAvvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jf8vEoQHX6HTolE14Nf+3unyCWhS8b1L+uvw6I5TxCr/wkAj3qOwUAL7jqF02nsmq
         DwFHNQI3qjWTtuyMmc/ix+qBYqJvZMx/9/Iu27UV7eLhhMH6nv7uGGCkTZvFlM3mBH
         +9N8iC9VaDmIwmeHrQxHIZWkMoVrMV1kwzgLaays=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH v5 05/22] proc: bootconfig: Add /proc/bootconfig to show boot config list
Date:   Thu, 26 Dec 2019 23:04:48 +0900
Message-Id: <157736908816.11126.18219614958177954231.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157736902773.11126.2531161235817081873.stgit@devnote2>
References: <157736902773.11126.2531161235817081873.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add /proc/bootconfig which shows the list of key-value pairs
in boot config. Since after boot, all boot configs and tree
are removed, this interface just keep a copy of key-value
pairs in text.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v4:
  - Remove ; in the end of lines.
  - Rename /proc/supp_cmdline to /proc/bootconfig
  - Simplify code.
---
 0 files changed

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a0acbc968d6..9dc69bb6856f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15773,6 +15773,7 @@ EXTRA BOOT CONFIG
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
 F:	lib/bootconfig.c
+F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
 F:	tools/bootconfig/*
 
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..bd08616ed8ba 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -33,3 +33,4 @@ proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
new file mode 100644
index 000000000000..9955d75c0585
--- /dev/null
+++ b/fs/proc/bootconfig.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * /proc/bootconfig - Extra boot configuration
+ */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/bootconfig.h>
+#include <linux/slab.h>
+
+static char *saved_boot_config;
+
+static int boot_config_proc_show(struct seq_file *m, void *v)
+{
+	if (saved_boot_config)
+		seq_puts(m, saved_boot_config);
+	return 0;
+}
+
+/* Rest size of buffer */
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+/* Return the needed total length if @size is 0 */
+static int __init copy_xbc_key_value_list(char *dst, size_t size)
+{
+	struct xbc_node *leaf, *vnode;
+	const char *val;
+	char *key, *end = dst + size;
+	int ret = 0;
+
+	key = kzalloc(XBC_KEYLEN_MAX, GFP_KERNEL);
+
+	xbc_for_each_key_value(leaf, val) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			break;
+		ret = snprintf(dst, rest(dst, end), "%s = ", key);
+		if (ret < 0)
+			break;
+		dst += ret;
+		vnode = xbc_node_get_child(leaf);
+		if (vnode && xbc_node_is_array(vnode)) {
+			xbc_array_for_each_value(vnode, val) {
+				ret = snprintf(dst, rest(dst, end), "\"%s\"%s",
+					val, vnode->next ? ", " : "\n");
+				if (ret < 0)
+					goto out;
+				dst += ret;
+			}
+		} else {
+			ret = snprintf(dst, rest(dst, end), "\"%s\"\n", val);
+			if (ret < 0)
+				break;
+			dst += ret;
+		}
+	}
+out:
+	kfree(key);
+
+	return ret < 0 ? ret : dst - (end - size);
+}
+
+static int __init proc_boot_config_init(void)
+{
+	int len;
+
+	len = copy_xbc_key_value_list(NULL, 0);
+	if (len < 0)
+		return len;
+
+	if (len > 0) {
+		saved_boot_config = kzalloc(len + 1, GFP_KERNEL);
+		if (!saved_boot_config)
+			return -ENOMEM;
+
+		len = copy_xbc_key_value_list(saved_boot_config, len + 1);
+		if (len < 0) {
+			kfree(saved_boot_config);
+			return len;
+		}
+	}
+
+	proc_create_single("bootconfig", 0, NULL, boot_config_proc_show);
+
+	return 0;
+}
+fs_initcall(proc_boot_config_init);

