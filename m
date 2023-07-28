Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987D476627C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 05:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjG1DhM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 23:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjG1DhG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188EB2D57;
        Thu, 27 Jul 2023 20:37:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 966B161FC1;
        Fri, 28 Jul 2023 03:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB5CC433C7;
        Fri, 28 Jul 2023 03:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690515423;
        bh=yYAHFQ8WQBrz/CC6Vkb/vHbspAQ4nefCpRwy7WR+Fw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JO7VION8mjiQiuzspgR2aAxtRgPneF2pUuzlucgDDdgMgNTNY60HGw9UgmMY+Ma4K
         EItDVSyZpezCA23hsB+r6p5+OuTSP58+ULr3fujQ4+rOoi0hBgow4WWTvxWJu2+GK5
         CAlcxTw5/Ik+FcAer2aIulgAXikzhyKN93sMYCLczR6uHyIs6T76AYGlO3klq47sxe
         JZFiFxhadg3FEf9RtwsGKhyWFHu9Cb9IHMyJko5+GfghZxy5JQvJyQXIEVLguMTn/J
         csLRnMAeH50lYVyfzgZS+ARXRXOJQlshh7udKZNEbrr8yAoWvK4/jgxeVqYttZxpXs
         YkHPuS1ZETErw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 883BECE0AD7; Thu, 27 Jul 2023 20:37:02 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, paulmck@kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for boot loader arguments
Date:   Thu, 27 Jul 2023 20:37:00 -0700
Message-Id: <20230728033701.817094-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
show all kernel boot parameters, both those supplied by the boot loader
and those embedded in the kernel image.  This works well for those who
just want to see all of the kernel boot parameters, but is not helpful to
those who need to see only those parameters supplied by the boot loader.
This is especially important when these parameters are presented to the
boot loader by automation that might gather them from diverse sources.

Therefore, provide a /proc/cmdline_load file that shows only those kernel
boot parameters supplied by the boot loader.

Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
it makes sense to put it in the same place that /proc/cmdline is located.

[ sfr: Apply kernel test robot feedback. ]

Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/proc/cmdline.c    | 13 +++++++++++++
 include/linux/init.h |  3 ++-
 init/main.c          |  2 +-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
index a6f76121955f..1d0ef9d2949d 100644
--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -3,6 +3,7 @@
 #include <linux/init.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <asm/setup.h>
 #include "internal.h"
 
 static int cmdline_proc_show(struct seq_file *m, void *v)
@@ -12,6 +13,13 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int cmdline_load_proc_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, boot_command_line);
+	seq_putc(m, '\n');
+	return 0;
+}
+
 static int __init proc_cmdline_init(void)
 {
 	struct proc_dir_entry *pde;
@@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
 	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
 	pde_make_permanent(pde);
 	pde->size = saved_command_line_len + 1;
+	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
+		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
+		pde_make_permanent(pde);
+		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
+	}
 	return 0;
 }
 fs_initcall(proc_cmdline_init);
diff --git a/include/linux/init.h b/include/linux/init.h
index 266c3e1640d4..29e75bbe7984 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -112,6 +112,7 @@
 #define __REFCONST       .section       ".ref.rodata", "a"
 
 #ifndef __ASSEMBLY__
+
 /*
  * Used for initialization calls..
  */
@@ -143,7 +144,7 @@ struct file_system_type;
 
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
-extern char __initdata boot_command_line[];
+extern char boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
diff --git a/init/main.c b/init/main.c
index ad920fac325c..2121685c479a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
 void (*__initdata late_time_init)(void);
 
 /* Untouched command line saved by arch-specific code. */
-char __initdata boot_command_line[COMMAND_LINE_SIZE];
+char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
 /* Untouched saved command line (eg. for /proc) */
 char *saved_command_line __ro_after_init;
 unsigned int saved_command_line_len __ro_after_init;
-- 
2.40.1

