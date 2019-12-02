Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB4F10E85F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2019 11:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfLBKOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Dec 2019 05:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfLBKOd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:14:33 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7D10217D9;
        Mon,  2 Dec 2019 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281672;
        bh=mv23QpR0UZRd2huPYgplFV3TLKM6Bswzr0oUDmadTVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbpSJKDEUiPK9aCWC9n5+H3AQVtezubrDqGHZ+ScVWMHKKa9/tjfwl5g+kvvZd17q
         +Ozg2lodnfbazr/EC3Or5Qpz35RCYFtMGSCpfVu5h5YDH+xz4FUSKHQQA5mI6ggIrG
         kzoAc4+oURxG+nbX3YHXxjAcWcZ9zkPskhpfyUg8=
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
Subject: [RFC PATCH v4 06/22] init/main.c: Alloc initcall_command_line in do_initcall() and free it
Date:   Mon,  2 Dec 2019 19:14:26 +0900
Message-Id: <157528166664.22451.16147144831500689849.stgit@devnote2>
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

Since initcall_command_line is used as a temporary buffer,
it could be freed after usage. Allocate it in do_initcall()
and free it after used.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 init/main.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/init/main.c b/init/main.c
index 27f70fa37b18..b6fd906e7714 100644
--- a/init/main.c
+++ b/init/main.c
@@ -137,8 +137,6 @@ char __initdata boot_command_line[COMMAND_LINE_SIZE];
 char *saved_command_line;
 /* Command line for parameter parsing */
 static char *static_command_line;
-/* Command line for per-initcall parameter parsing */
-static char *initcall_command_line;
 
 static char *execute_command;
 static char *ramdisk_execute_command;
@@ -433,10 +431,6 @@ static void __init setup_command_line(char *command_line)
 	if (!saved_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
-	initcall_command_line =	memblock_alloc(len, SMP_CACHE_BYTES);
-	if (!initcall_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
-
 	static_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!static_command_line)
 		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
@@ -1044,13 +1038,12 @@ static const char *initcall_level_names[] __initdata = {
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
@@ -1063,9 +1056,20 @@ static void __init do_initcall_level(int level)
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

