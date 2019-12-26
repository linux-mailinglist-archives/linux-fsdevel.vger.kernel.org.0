Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C428112ACC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfLZOFd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbfLZOFd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:05:33 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A8E2075E;
        Thu, 26 Dec 2019 14:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369132;
        bh=AptXWeZLhmRfKkmn151XsAbDhtvwaLQcq80+lRPwK6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rh6uNjeR7xy1xDarqXP2fw+IOIBfR/Nzhcp6ooON8IiVOO36t/80hRw4sIstKnZSw
         MKorP8TtmD60OtwJO3YYTZMo/4EsnHeH4oculbo+pVjLwoRA5KqNyDXD+JMJNU7UQf
         4iY4I9ZVkRkLmXjMUPSxx4lL91YtGmErBgEwdJ8M=
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
Subject: [PATCH v5 08/22] bootconfig: init: Allow admin to use bootconfig for init command line
Date:   Thu, 26 Dec 2019 23:05:24 +0900
Message-Id: <157736912400.11126.16848304105001022239.stgit@devnote2>
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

Since the current kernel command line is too short to describe
long and many options for init (e.g. systemd command line options),
this allows admin to use boot config for init command line.

All init command line under "init." keywords will be passed to
init.

For example,

init.systemd {
	unified_cgroup_hierarchy = 1
	debug_shell
	default_timeout_start_sec = 60
}

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/init/main.c b/init/main.c
index d7e37b431883..0beb6b76c913 100644
--- a/init/main.c
+++ b/init/main.c
@@ -140,6 +140,8 @@ char *saved_command_line;
 static char *static_command_line;
 /* Untouched extra command line */
 static char *extra_command_line;
+/* Extra init arguments */
+static char *extra_init_args;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -373,6 +375,8 @@ static void __init setup_boot_config(void)
 		pr_info("Load boot config: %d bytes\n", size);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
+		/* Also, "init." keys are init arguments */
+		extra_init_args = xbc_make_cmdline("init");
 	}
 }
 #else
@@ -508,16 +512,18 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  */
 static void __init setup_command_line(char *command_line)
 {
-	size_t len, xlen = 0;
+	size_t len, xlen = 0, ilen = 0;
 
 	if (extra_command_line)
 		xlen = strlen(extra_command_line);
+	if (extra_init_args)
+		ilen = strlen(extra_init_args) + 4; /* for " -- " */
 
 	len = xlen + strlen(boot_command_line) + 1;
 
-	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
+	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
 
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
@@ -534,6 +540,22 @@ static void __init setup_command_line(char *command_line)
 	}
 	strcpy(saved_command_line + xlen, boot_command_line);
 	strcpy(static_command_line + xlen, command_line);
+
+	if (ilen) {
+		/*
+		 * Append supplemental init boot args to saved_command_line
+		 * so that user can check what command line options passed
+		 * to init.
+		 */
+		len = strlen(saved_command_line);
+		if (!strstr(boot_command_line, " -- ")) {
+			strcpy(saved_command_line + len, " -- ");
+			len += 4;
+		} else
+			saved_command_line[len++] = ' ';
+
+		strcpy(saved_command_line + len, extra_init_args);
+	}
 }
 
 /*
@@ -760,6 +782,9 @@ asmlinkage __visible void __init start_kernel(void)
 	if (!IS_ERR_OR_NULL(after_dashes))
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
+	if (extra_init_args)
+		parse_args("Setting extra init args", extra_init_args,
+			   NULL, 0, -1, -1, NULL, set_init_arg);
 
 	/*
 	 * These use large bootmem allocations and must precede

