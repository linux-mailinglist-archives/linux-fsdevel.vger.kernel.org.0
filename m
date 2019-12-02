Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C46D610E86B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfLBKOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:14:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:59740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfLBKOy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:14:54 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D80321835;
        Mon,  2 Dec 2019 10:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281693;
        bh=+yEowJLKOMjPDHTuH6PUsFeC4DPmKVnwMvOyi0ajpUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNQipn6AS5mrhjEskiiRKRXsIG9NqPoabSId7LAF4Ew0nm+N8Gw6J+2fmv17rR/a7
         YE0QnmfYoLbFJzY+UtDP6W4t3iLOcbRW77SrJ8U47mKOvGwXPvlnomIH3TqzDM2eXW
         CkxiCxbS8nVSP/6EbMCY2h5uu2KuO1YoJj8j/xg4=
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
Subject: [RFC PATCH v4 08/22] bootconfig: init: Allow admin to use bootconfig for init command line
Date:   Mon,  2 Dec 2019 19:14:48 +0900
Message-Id: <157528168803.22451.13616097455333249096.stgit@devnote2>
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
 init/main.c |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index b2aac7ec2862..c138b2068602 100644
--- a/init/main.c
+++ b/init/main.c
@@ -139,6 +139,8 @@ char *saved_command_line;
 static char *static_command_line;
 /* Untouched extra command line */
 static char *extra_command_line;
+/* Extra init arguments */
+static char *extra_init_args;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -372,6 +374,8 @@ static void __init setup_boot_config(void)
 		pr_info("Load boot config: %d bytes\n", size);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
+		/* Also, "init." keys are init arguments */
+		extra_init_args = xbc_make_cmdline("init");
 	}
 }
 #else
@@ -507,16 +511,18 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
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
@@ -533,6 +539,22 @@ static void __init setup_command_line(char *command_line)
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
@@ -759,6 +781,9 @@ asmlinkage __visible void __init start_kernel(void)
 	if (!IS_ERR_OR_NULL(after_dashes))
 		parse_args("Setting init args", after_dashes, NULL, 0, -1, -1,
 			   NULL, set_init_arg);
+	if (extra_init_args)
+		parse_args("Setting extra init args", extra_init_args,
+			   NULL, 0, -1, -1, NULL, set_init_arg);
 
 	/*
 	 * These use large bootmem allocations and must precede

