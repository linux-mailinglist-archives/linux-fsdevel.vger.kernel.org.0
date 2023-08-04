Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB7777081E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 20:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjHDSns (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjHDSnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:43:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D546B2;
        Fri,  4 Aug 2023 11:43:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83177620F5;
        Fri,  4 Aug 2023 18:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00C9C433C8;
        Fri,  4 Aug 2023 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691174622;
        bh=tE3RdQBl89VvXPLghQzSjkSIzG6lje0YiOUVHgPhae8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bMcMiiJyBvBE4GGuodwYhv/flRnIOsbx/RH1ymw8R9a33abKVAoZIf5hsunloPzrV
         9/2NQ/x1zar/cRHPi3SzXn3yFElj680lzNBMNGHPEqt0iHxMd069uJcIcSj0WpcaHw
         ee7c56iCxJaJtJjq3FY5+zrGB+HgequxQXmOzjesCvTOYGGdYkBzEp7RHTNxCycS9q
         uJ8PXfK+WWr5fIwpXEzWBRXCxYHZcj/R0WnqBox6QO8YS+qXMaraclQhzUJge7vtAp
         oUrn9Cjh7hnTClPlcgO7hxj2fH9+DGXYvV1JH2oEIndlBhc6Tz/KEdkcUfnR68xuM+
         mVxXDSe8BJ7qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 619CCCE0591; Fri,  4 Aug 2023 11:43:42 -0700 (PDT)
Date:   Fri, 4 Aug 2023 11:43:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <e0a1a4b6-7339-4fb9-aaad-3a3390a76491@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
 <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:36:17AM -0700, Paul E. McKenney wrote:
> On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> > On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > show all kernel boot parameters, both those supplied by the boot loader
> > > and those embedded in the kernel image.  This works well for those who
> > > just want to see all of the kernel boot parameters, but is not helpful to
> > > those who need to see only those parameters supplied by the boot loader.
> > > This is especially important when these parameters are presented to the
> > > boot loader by automation that might gather them from diverse sources.
> > > 
> > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > boot parameters supplied by the boot loader.
> > 
> > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > +{
> > > +	seq_puts(m, boot_command_line);
> > > +	seq_putc(m, '\n');
> > > +	return 0;
> > > +}
> > > +
> > >  static int __init proc_cmdline_init(void)
> > >  {
> > >  	struct proc_dir_entry *pde;
> > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > >  	pde_make_permanent(pde);
> > >  	pde->size = saved_command_line_len + 1;
> > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > +		pde_make_permanent(pde);
> > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > +	}
> > 
> > Please add it as separate fs/proc/cmdline_load.c file so that name of
> > the file matches name of the /proc file.
> 
> Thank you, will do!

And here is an untested sneak preview, which I will fold into the original
after testing.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/fs/proc/Makefile b/fs/proc/Makefile
index bd08616ed8ba..094f3102eb9f 100644
--- a/fs/proc/Makefile
+++ b/fs/proc/Makefile
@@ -34,3 +34,4 @@ proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
 proc-$(CONFIG_PRINTK)	+= kmsg.o
 proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
 proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
+proc-$(CONFIG_BOOT_CONFIG_FORCE)	+= cmdline_load.o
diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
index 1d0ef9d2949d..082def2c1cc6 100644
--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -13,13 +13,6 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int cmdline_load_proc_show(struct seq_file *m, void *v)
-{
-	seq_puts(m, boot_command_line);
-	seq_putc(m, '\n');
-	return 0;
-}
-
 static int __init proc_cmdline_init(void)
 {
 	struct proc_dir_entry *pde;
@@ -27,11 +20,6 @@ static int __init proc_cmdline_init(void)
 	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
 	pde_make_permanent(pde);
 	pde->size = saved_command_line_len + 1;
-	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
-		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
-		pde_make_permanent(pde);
-		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
-	}
 	return 0;
 }
 fs_initcall(proc_cmdline_init);
diff --git a/fs/proc/cmdline_load.c b/fs/proc/cmdline_load.c
new file mode 100644
index 000000000000..e3dccb3441ce
--- /dev/null
+++ b/fs/proc/cmdline_load.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <asm/setup.h>
+#include "internal.h"
+
+static int cmdline_load_proc_show(struct seq_file *m, void *v)
+{
+	seq_puts(m, boot_command_line);
+	seq_putc(m, '\n');
+	return 0;
+}
+
+static int __init proc_cmdline_load_init(void)
+{
+	struct proc_dir_entry *pde;
+
+	pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
+	pde_make_permanent(pde);
+	pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
+	return 0;
+}
+fs_initcall(proc_cmdline_load_init);
