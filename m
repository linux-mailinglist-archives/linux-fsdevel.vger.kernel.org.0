Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8DC39C798
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 05:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfHZDQJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Aug 2019 23:16:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfHZDQJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Aug 2019 23:16:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2274A21744;
        Mon, 26 Aug 2019 03:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566789368;
        bh=wXFjl0zCbPJZwn2CEfUDC+aWkXCG/asIDm0k7WxJxXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CrHbAvOKb8sl5AtIIw8tSiWwAZ9CXJtXpmAfUUfZAtvlh5j1VDF5sDwpCTHlGbPuD
         RRb0XGrjL6SkBuzlQ4DMUaAP0fNmY7nvKHn/ZZH8nlYIrC4ORmzFQPirseye23qfTk
         9pmg9mELNZTxjRK3hq2kBZgpG3jVmZkzbq3bTqfw=
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
Subject: [RFC PATCH v3 02/19] skc: Add /proc/sup_cmdline to show SKC key-value list
Date:   Mon, 26 Aug 2019 12:16:01 +0900
Message-Id: <156678936178.21459.13301820262182543136.stgit@devnote2>
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

Add /proc/sup_cmdline which shows the list of key-value pairs
in SKC data. Since after boot, all SKC data and tree are
removed, this interface just keep a copy of key-value
pairs in text.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 MAINTAINERS           |    1 
 fs/proc/Makefile      |    1 
 fs/proc/sup_cmdline.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+)
 create mode 100644 fs/proc/sup_cmdline.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 67590c0e37c5..10dd38311d96 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15366,6 +15366,7 @@ SUPPLEMENTAL KERNEL CMDLINE
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 S:	Maintained
 F:	lib/skc.c
+F:	fs/proc/sup_cmdline.c
 F:	include/linux/skc.h
 
 SUN3/3X
diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index ead487e80510..a5d018f9422c 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -33,3 +33,4 @@ proc-$(CONFIG_PROC_KCORE)	+= kcore.o
 proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
+proc-$(CONFIG_SKC)	+= sup_cmdline.o
diff --git a/fs/proc/sup_cmdline.c b/fs/proc/sup_cmdline.c
new file mode 100644
index 000000000000..97bc40f0c9dd
--- /dev/null
+++ b/fs/proc/sup_cmdline.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * /proc/sup_cmdline - Supplemental kernel command line
+ */
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/skc.h>
+#include <linux/slab.h>
+
+static char *saved_sup_cmdline;
+
+static int skc_proc_show(struct seq_file *m, void *v)
+{
+	if (saved_sup_cmdline)
+		seq_puts(m, saved_sup_cmdline);
+	else
+		seq_putc(m, '\n');
+	return 0;
+}
+
+static int __init update_snprintf(char **dstp, size_t *sizep,
+				  const char *fmt, ...)
+{
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+	ret = vsnprintf(*dstp, *sizep, fmt, args);
+	va_end(args);
+
+	if (*sizep && ret > 0) {
+		*sizep -= ret;
+		*dstp += ret;
+	}
+
+	return ret;
+}
+
+/* Return the needed total length if @size is 0 */
+static int __init copy_skc_key_value_list(char *dst, size_t size)
+{
+	struct skc_node *leaf, *vnode;
+	const char *val;
+	int len = 0, ret = 0;
+	char *key;
+
+	key = kzalloc(SKC_KEYLEN_MAX, GFP_KERNEL);
+
+	skc_for_each_key_value(leaf, val) {
+		ret = skc_node_compose_key(leaf, key, SKC_KEYLEN_MAX);
+		if (ret < 0)
+			break;
+		ret = update_snprintf(&dst, &size, "%s = ", key);
+		if (ret < 0)
+			break;
+		len += ret;
+		vnode = skc_node_get_child(leaf);
+		if (vnode && skc_node_is_array(vnode)) {
+			skc_array_for_each_value(vnode, val) {
+				ret = update_snprintf(&dst, &size, "\"%s\"%s",
+					val, vnode->next ? ", " : ";\n");
+				if (ret < 0)
+					goto out;
+				len += ret;
+			}
+		} else {
+			ret = update_snprintf(&dst, &size, "\"%s\";\n", val);
+			if (ret < 0)
+				break;
+			len += ret;
+		}
+	}
+out:
+	kfree(key);
+
+	return ret < 0 ? ret : len;
+}
+
+static int __init proc_skc_init(void)
+{
+	int len;
+
+	len = copy_skc_key_value_list(NULL, 0);
+	if (len < 0)
+		return len;
+
+	if (len > 0) {
+		saved_sup_cmdline = kzalloc(len + 1, GFP_KERNEL);
+		if (!saved_sup_cmdline)
+			return -ENOMEM;
+
+		len = copy_skc_key_value_list(saved_sup_cmdline, len + 1);
+		if (len < 0) {
+			kfree(saved_sup_cmdline);
+			return len;
+		}
+	}
+
+	proc_create_single("sup_cmdline", 0, NULL, skc_proc_show);
+
+	return 0;
+}
+fs_initcall(proc_skc_init);

