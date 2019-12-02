Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64E10E863
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfLBKOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:14:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:59386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbfLBKOn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:14:43 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5927215E5;
        Mon,  2 Dec 2019 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281682;
        bh=flZsKPFvhi5bIl3NAIILfEMV0OWHn/g6mqGgP+7m/9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A36UNFy0KYuZ0O+EhubItxlNsOD8irw5VrQ2vK6Crcl5Rij+M/f4q4fx2CTrwTvFq
         kVTit7ajK9Wo71i3FKBpwa/8+4ORtloSGS8djdHaEaI8Iehxzyj20adVEf4EMxHtln
         ApYcVKjVilCYgcF8nD5MBpwvDSFpjfGXtT/3h2s0=
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
Subject: [RFC PATCH v4 07/22] bootconfig: init: Allow admin to use bootconfig for kernel command line
Date:   Mon,  2 Dec 2019 19:14:37 +0900
Message-Id: <157528167750.22451.6203524785012814947.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157528159833.22451.14878731055438721716.stgit@devnote2>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the current kernel command line is too short to describe
many options which supported by kernel, allow user to use boot
config to setup (add) the command line options.

All kernel parameters under "kernel." keywords will be used
for setting up extra kernel command line.

For example,

kernel {
	audit = on
	audit_backlog_limit = 256
}

Note that you can not specify some early parameters
(like console etc.) by this method, since it is
loaded after early parameters parsed.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index b6fd906e7714..b2aac7ec2862 100644
--- a/init/main.c
+++ b/init/main.c
@@ -137,6 +137,8 @@ char __initdata boot_command_line[COMMAND_LINE_SIZE];
 char *saved_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
+/* Untouched extra command line */
+static char *extra_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -245,6 +247,83 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BOOT_CONFIG
+
+char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+
+#define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
+
+static int __init xbc_snprint_cmdline(char *buf, size_t size,
+				      struct xbc_node *root)
+{
+	struct xbc_node *knode, *vnode;
+	char *end = buf + size;
+	char c = '\"';
+	const char *val;
+	int ret;
+
+	xbc_node_for_each_key_value(root, knode, val) {
+		ret = xbc_node_compose_key_after(root, knode,
+					xbc_namebuf, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			return ret;
+
+		vnode = xbc_node_get_child(knode);
+		ret = snprintf(buf, rest(buf, end), "%s%c", xbc_namebuf,
+				vnode ? '=' : ' ');
+		if (ret < 0)
+			return ret;
+		buf += ret;
+		if (!vnode)
+			continue;
+
+		c = '\"';
+		xbc_array_for_each_value(vnode, val) {
+			ret = snprintf(buf, rest(buf, end), "%c%s", c, val);
+			if (ret < 0)
+				return ret;
+			buf += ret;
+			c = ',';
+		}
+		if (rest(buf, end) > 2)
+			strcpy(buf, "\" ");
+		buf += 2;
+	}
+
+	return buf - (end - size);
+}
+#undef rest
+
+/* Make an extra command line under given key word */
+static char * __init xbc_make_cmdline(const char *key)
+{
+	struct xbc_node *root;
+	char *new_cmdline;
+	int ret, len = 0;
+
+	root = xbc_find_node(key);
+	if (!root)
+		return NULL;
+
+	/* Count required buffer size */
+	len = xbc_snprint_cmdline(NULL, 0, root);
+	if (len <= 0)
+		return NULL;
+
+	new_cmdline = memblock_alloc(len + 1, SMP_CACHE_BYTES);
+	if (!new_cmdline) {
+		pr_err("Failed to allocate memory for extra kernel cmdline.\n");
+		return NULL;
+	}
+
+	ret = xbc_snprint_cmdline(new_cmdline, len + 1, root);
+	if (ret < 0 || ret > len) {
+		pr_err("Failed to print extra kernel cmdline.\n");
+		return NULL;
+	}
+
+	return new_cmdline;
+}
+
 u32 boot_config_checksum(unsigned char *p, u32 size)
 {
 	u32 ret = 0;
@@ -289,8 +368,11 @@ static void __init setup_boot_config(void)
 
 	if (xbc_init(copy) < 0)
 		pr_err("Failed to parse boot config\n");
-	else
+	else {
 		pr_info("Load boot config: %d bytes\n", size);
+		/* keys starting with "kernel." are passed via cmdline */
+		extra_command_line = xbc_make_cmdline("kernel");
+	}
 }
 #else
 #define setup_boot_config()	do { } while (0)
@@ -425,7 +507,12 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	size_t len = strlen(boot_command_line) + 1;
+	size_t len, xlen = 0;
+
+	if (extra_command_line)
+		xlen = strlen(extra_command_line);
+
+	len = xlen + strlen(boot_command_line) + 1;
 
 	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!saved_command_line)
@@ -435,8 +522,17 @@ static void __init setup_command_line(char *command_line)
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
-	strcpy(saved_command_line, boot_command_line);
-	strcpy(static_command_line, command_line);
+	if (xlen) {
+		/*
+		 * We have to put extra_command_line before boot command
+		 * lines because there could be dashes (separator of init
+		 * command line) in the command lines.
+		 */
+		strcpy(saved_command_line, extra_command_line);
+		strcpy(static_command_line, extra_command_line);
+	}
+	strcpy(saved_command_line + xlen, boot_command_line);
+	strcpy(static_command_line + xlen, command_line);
 }
 
 /*
@@ -652,7 +748,7 @@ asmlinkage __visible void __init start_kernel(void)
 	build_all_zonelists(NULL);
 	page_alloc_init();
 
-	pr_notice("Kernel command line: %s\n", boot_command_line);
+	pr_notice("Kernel command line: %s\n", saved_command_line);
 	/* parameters may set static keys */
 	jump_label_init();
 	parse_early_param();

