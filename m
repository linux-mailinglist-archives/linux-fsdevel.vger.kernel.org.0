Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE48F76A4E0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 01:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjGaXbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 19:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjGaXbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7DB0;
        Mon, 31 Jul 2023 16:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6CD61344;
        Mon, 31 Jul 2023 23:31:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9CBC433C8;
        Mon, 31 Jul 2023 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690846292;
        bh=oBlm+F0ijC5y9fHYb2ho/VBeeyMvwj2PDTDIl0glh0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QLJjIaah3/akgIa59dh1oK+umdaeOkJa7PujX/sI4ogfjwWtneSQt8NYmf2LiITM1
         tQ+Y3GPbMMKGw4odgc/2a9Ikw2j0fvzKhbYSIzGAvu9ecI6tQSB0n6XnxTRC5T7/iB
         v5PJrDo/8ZtGZGr64a+vulEx0oSH1nLnMtwC6PUQlP3CYYqa0yCe1FJ892NTUsCfod
         8k//LrxEdlfLTDR078y69GN1kwj002Ol2TaUPj/HKH7tIG4fqcY6GIVgwZ7+zpo2fD
         CIgbi0YcxHint6U3kVnSZEuOKfQy/TvAv7yiO8x/vj13c2gCaRux+Nr5gQ4lcy+fai
         I3nLu02nMS5mw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DC2CBCE1066; Mon, 31 Jul 2023 16:31:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     akpm@linux-foundation.org, adobriyan@gmail.com, mhiramat@kernel.org
Cc:     arnd@kernel.org, ndesaulniers@google.com, paulmck@kernel.org,
        sfr@canb.auug.org.au, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH RFC v2 bootconfig 2/3] fs/proc: Add /proc/cmdline_load for boot loader arguments
Date:   Mon, 31 Jul 2023 16:31:29 -0700
Message-Id: <20230731233130.424913-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
References: <db98cbbf-2205-40d2-9fa1-f1c135cc151c@paulmck-laptop>
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
It is also useful when booting the next kernel via kexec(), in which
case it is necessary to supply only those kernel command-line arguments
from the boot loader, and most definitely not those that were embedded
into the current kernel.

Therefore, provide a /proc/cmdline_load file that shows only those kernel
boot parameters supplied by the boot loader.

Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
it makes sense to put it in the same place that /proc/cmdline is located.

[ sfr: Apply kernel test robot feedback. ]
[ paulmck: Apply Randy Dunlap feedback. ]

Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Co-developed-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: <linux-fsdevel@vger.kernel.org>
---
 Documentation/filesystems/proc.rst |  1 +
 fs/proc/cmdline.c                  | 13 +++++++++++++
 include/linux/init.h               |  3 ++-
 init/main.c                        |  2 +-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 75a8c899ebcc..c2aee55248a8 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -688,6 +688,7 @@ files are there, and which are missing.
  bus          Directory containing bus specific information
  cmdline      Kernel command line, both from bootloader and embedded
  	      in the kernel image.
+ cmdline_load Kernel command line obtained from kernel image	(6.6)
  cpuinfo      Info about the CPU
  devices      Available devices (block and character)
  dma          Used DMS channels
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

