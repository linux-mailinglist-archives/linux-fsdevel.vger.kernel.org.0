Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D12612ACBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Dec 2019 15:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLZOFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Dec 2019 09:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfLZOFH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Dec 2019 09:05:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE7AC20CC7;
        Thu, 26 Dec 2019 14:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577369107;
        bh=QY76Hs0hSUfQ8Vu84T8I8Y51eyKVQZohwC0KG6uxJVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTqkr3ME6bBP3BuvuHjA8bOyG7Lap0+oQFe1eJmF636lMTf5yIjkIByqfJNHELDEr
         3Recsv/8DNdPLdvVJCneAPYmMobpxExaUEoS1IV9et5+/Rb0WDegDFDsUXdBQEjB5E
         8Fo2BaIYh7Dgl1akmHUa1U5AWqKvU03fNZSVRgXc=
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
Subject: [PATCH v5 06/22] init/main.c: Alloc initcall_command_line in do_initcall() and free it
Date:   Thu, 26 Dec 2019 23:05:00 +0900
Message-Id: <157736910004.11126.8700418489018796985.stgit@devnote2>
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

Since initcall_command_line is used as a temporary buffer,
it could be freed after usage. Allocate it in do_initcall()
and free it after used.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/init/main.c b/init/main.c
index a47a95076405..29830cb1b198 100644
--- a/init/main.c
+++ b/init/main.c
@@ -138,8 +138,6 @@ char __initdata boot_command_line[COMMAND_LINE_SIZE];
 char *saved_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
-/* Command line for per-initcall parameter parsing */
-static char *initcall_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -434,10 +432,6 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
-	initcall_command_line =	memblock_alloc(len, SMP_CACHE_BYTES);
-	if (!initcall_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
-
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
@@ -1045,13 +1039,12 @@ static const char *initcall_level_names[] __initdata = {
 	"late",
 };
 
-static void __init do_initcall_level(int level)
+static void __init do_initcall_level(int level, char *command_line)
 {
 	initcall_entry_t *fn;
 
-	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
-		   initcall_command_line, __start___param,
+		   command_line, __start___param,
 		   __stop___param - __start___param,
 		   level, level,
 		   NULL, &repair_env_string);
@@ -1064,9 +1057,20 @@ static void __init do_initcall_level(int level)
 static void __init do_initcalls(void)
 {
 	int level;
+	size_t len = strlen(saved_command_line) + 1;
+	char *command_line;
+
+	command_line = kzalloc(len, GFP_KERNEL);
+	if (!command_line)
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
+
+	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++) {
+		/* Parser modifies command_line, restore it each time */
+		strcpy(command_line, saved_command_line);
+		do_initcall_level(level, command_line);
+	}
 
-	for (level = 0; level < ARRAY_SIZE(initcall_levels) - 1; level++)
-		do_initcall_level(level);
+	kfree(command_line);
 }
 
 /*

