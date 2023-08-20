Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB58781EC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Aug 2023 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjHTPpm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Aug 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHTPpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Aug 2023 11:45:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E525426AB;
        Sun, 20 Aug 2023 08:40:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77FF8611AB;
        Sun, 20 Aug 2023 15:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D2FC433C8;
        Sun, 20 Aug 2023 15:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692546057;
        bh=nnMn04l46pm24Th66mLVDuSFB48Gl6uzuRYiqFrGvoM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AzzFwDkv4BHFy9bRDTGCv1hNHbPJSuOpglVOcB9HyE8u09ZjDQS97A7h4LewcZIfP
         Oy1jgsz38cXtZ0tqkWSm7xlWFLrww5Exzz7GVLjUonv5hp5o6t6+aK0gsyK+H0IMfj
         75wSiHyvBiAyqdLS8GpsoGUPuFJ6visXtba0Baepj6AZNK7oxsNRxL1p2rOL/KyPDp
         U5TtwEbbifQG8zmlCmweFaAb43+v+DNL2bGzgigA1oqYdQCf4fm8Pyuk5n7EzWhyiR
         TkWmTtyGrxaaPOCJNCk5nsLpRt8EqANJ9Vt8AYcMsHi9y9iqIC7M2DCERIq8V4IHA5
         omxfZReYZQgFA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 56C04CE039C; Sun, 20 Aug 2023 08:40:57 -0700 (PDT)
Date:   Sun, 20 Aug 2023 08:40:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
        arnd@kernel.org, ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <b8040a0b-d247-484e-b09a-204387ef3030@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <db2617d2-589d-47c1-a0cc-e8aeca58710a@p183>
 <9a42de2a-7d9f-4be3-b6c8-9f3e8a092c4d@paulmck-laptop>
 <20230807114455.b4bab41d771556d086e8bdf4@kernel.org>
 <7c81c63b-7097-4d28-864e-f364eaafc5a0@paulmck-laptop>
 <24ec9c40-7310-4544-8c3f-81f2a756aead@paulmck-laptop>
 <79d0ddcf-3b20-48f5-89f6-7eb5c3fa4c88@paulmck-laptop>
 <20230816184003.6e0831cbe1bc7ab9a1af9a39@kernel.org>
 <20230817001731.35d15591bfd749c7f8fa371e@kernel.org>
 <c93ad091-761c-4a07-b2ba-bb25b46c795e@paulmck-laptop>
 <20230820231401.7e6829426a3ff6baadb0b39a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230820231401.7e6829426a3ff6baadb0b39a@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 20, 2023 at 11:14:01PM +0900, Masami Hiramatsu wrote:
> On Wed, 16 Aug 2023 09:13:30 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Thu, Aug 17, 2023 at 12:17:31AM +0900, Masami Hiramatsu wrote:
> > > On Wed, 16 Aug 2023 18:40:03 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > > > On Mon, 14 Aug 2023 16:08:29 -0700
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > On Sat, Aug 12, 2023 at 04:30:41PM -0700, Paul E. McKenney wrote:
> > > > > > On Sun, Aug 06, 2023 at 09:39:28PM -0700, Paul E. McKenney wrote:
> > > > > > > On Mon, Aug 07, 2023 at 11:44:55AM +0900, Masami Hiramatsu wrote:
> > > > > > > > On Fri, 4 Aug 2023 10:36:17 -0700
> > > > > > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > > > > > > On Fri, Aug 04, 2023 at 08:23:20PM +0300, Alexey Dobriyan wrote:
> > > > > > > > > > On Thu, Jul 27, 2023 at 08:37:00PM -0700, Paul E. McKenney wrote:
> > > > > > > > > > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > > > > > > > > > show all kernel boot parameters, both those supplied by the boot loader
> > > > > > > > > > > and those embedded in the kernel image.  This works well for those who
> > > > > > > > > > > just want to see all of the kernel boot parameters, but is not helpful to
> > > > > > > > > > > those who need to see only those parameters supplied by the boot loader.
> > > > > > > > > > > This is especially important when these parameters are presented to the
> > > > > > > > > > > boot loader by automation that might gather them from diverse sources.
> > > > > > > > > > > 
> > > > > > > > > > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > > > > > > > > > boot parameters supplied by the boot loader.
> > > > > > > > > > 
> > > > > > > > > > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > > > > > > > > > +{
> > > > > > > > > > > +	seq_puts(m, boot_command_line);
> > > > > > > > > > > +	seq_putc(m, '\n');
> > > > > > > > > > > +	return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +
> > > > > > > > > > >  static int __init proc_cmdline_init(void)
> > > > > > > > > > >  {
> > > > > > > > > > >  	struct proc_dir_entry *pde;
> > > > > > > > > > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > > > > > > > > > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > > > > > > > > > >  	pde_make_permanent(pde);
> > > > > > > > > > >  	pde->size = saved_command_line_len + 1;
> > > > > > > > > > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > > > > > > > > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > > > > > > > > > +		pde_make_permanent(pde);
> > > > > > > > > > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > > > > > > > > > +	}
> > > > > > > > > > 
> > > > > > > > > > Please add it as separate fs/proc/cmdline_load.c file so that name of
> > > > > > > > > > the file matches name of the /proc file.
> > > > > > > > > 
> > > > > > > > > Thank you, will do!
> > > > > > > > > 
> > > > > > > > > > The name "cmdline_load" is kind of non-descriptive. Mentioning "bootloader"
> > > > > > > > > > somewhere should improve things.
> > > > > > > > > 
> > > > > > > > > If we can all quickly come to agreement on a name, I can of course easily
> > > > > > > > > change it.
> > > > > > > > > 
> > > > > > > > > /proc/cmdline_bootloader?  Better than /proc/cmdline_from_bootloader,
> > > > > > > > > I suppose.  /proc/cmdline_bootldr?  /proc/bootloader by analogy with
> > > > > > > > > /proc/bootconfig?  Something else?
> > > > > > > > 
> > > > > > > > What about "/proc/raw_cmdline" ?
> > > > > > > 
> > > > > > > That would work of me!
> > > > > > > 
> > > > > > > Any objections to /proc/raw_cmdline?
> > > > > > > 
> > > > > > > Going once...
> > > > > > 
> > > > > > Going twice...
> > > > > > 
> > > > > > If I don't hear otherwise, /proc/raw_cmdline is is on Monday August 14 PDT.
> > > > > 
> > > > > And gone!
> > > > > 
> > > > > Please see below for the updated version.
> > > > 
> > > > OK, I'll pick this.
> > > 
> > > Wait, is it OK to push this through bootconfig tree? Since this is not directly
> > > related to the bootconfig, fsdevel maintainer can pick this.
> > > I would like to ping to fsdevel people at first.
> > 
> > Whichever path works best works for me!
> > 
> > Here are the three commits I have queued, just please let me know when any
> > of them are pulled into some other tree and I will drop them from -rcu.
> > 
> > 97edd1291847 ("doc: Update /proc/cmdline documentation to include boot config")
> > 0fe10f0d1873 ("fs/proc: Add /proc/raw_cmdline for boot loader arguments")
> > 9192c6ac7516 ("doc: Add /proc/bootconfig to proc.rst")
> 
> OK, I picked and pushed to linux-trace's bootconfig/for-next branch.

Thank you, and I will drop them from -rcu on my next rebase.

							Thanx, Paul

> > > Thank you,
> > > 
> > > > 
> > > > Thanks!
> > > > 
> > > > > 
> > > > > 								Thanx, Paul
> > > > > 
> > > > > ------------------------------------------------------------------------
> > > > > 
> > > > > commit 0fe10f0d1873a6f6e287c0c5b45e9203b0e33c83
> > > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > > Date:   Fri Jul 21 16:05:38 2023 -0700
> > > > > 
> > > > >     fs/proc: Add /proc/raw_cmdline for boot loader arguments
> > > > >     
> > > > >     In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > > >     show all kernel boot parameters, both those supplied by the boot loader
> > > > >     and those embedded in the kernel image.  This works well for those who
> > > > >     just want to see all of the kernel boot parameters, but is not helpful to
> > > > >     those who need to see only those parameters supplied by the boot loader.
> > > > >     This is especially important when these parameters are presented to the
> > > > >     boot loader by automation that might gather them from diverse sources.
> > > > >     It is also useful when booting the next kernel via kexec(), in which
> > > > >     case it is necessary to supply only those kernel command-line arguments
> > > > >     from the boot loader, and most definitely not those that were embedded
> > > > >     into the current kernel.
> > > > >     
> > > > >     Therefore, provide a /proc/raw_cmdline file that shows only those kernel
> > > > >     boot parameters supplied by the boot loader.
> > > > >     
> > > > >     Why put this in /proc?  Because it is quite similar to /proc/cmdline,
> > > > >     and /proc/bootconfig, so it makes sense to put it in the same place that
> > > > >     those files are located.
> > > > >     
> > > > >     [ sfr: Apply kernel test robot feedback. ]
> > > > >     [ paulmck: Apply Randy Dunlap feedback. ]
> > > > >     [ paulmck: Apply naming feedback from Alexey Dobriyan and Masami Hiramatsu. ]
> > > > >     
> > > > >     Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > >     Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > >     Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > >     Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > >     Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > > >     Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > >     Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > > > >     Cc: <linux-fsdevel@vger.kernel.org>
> > > > > 
> > > > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > > > index 75a8c899ebcc..61419270c38f 100644
> > > > > --- a/Documentation/filesystems/proc.rst
> > > > > +++ b/Documentation/filesystems/proc.rst
> > > > > @@ -723,6 +723,7 @@ files are there, and which are missing.
> > > > >   partitions   Table of partitions known to the system
> > > > >   pci 	      Deprecated info of PCI bus (new way -> /proc/bus/pci/,
> > > > >                decoupled by lspci				(2.4)
> > > > > + raw_cmdline  Kernel command line obtained from kernel image	(6.6)
> > > > >   rtc          Real time clock
> > > > >   scsi         SCSI info (see text)
> > > > >   slabinfo     Slab pool info
> > > > > diff --git a/fs/proc/Makefile b/fs/proc/Makefile
> > > > > index bd08616ed8ba..6182296f3c6b 100644
> > > > > --- a/fs/proc/Makefile
> > > > > +++ b/fs/proc/Makefile
> > > > > @@ -34,3 +34,4 @@ proc-$(CONFIG_PROC_VMCORE)	+= vmcore.o
> > > > >  proc-$(CONFIG_PRINTK)	+= kmsg.o
> > > > >  proc-$(CONFIG_PROC_PAGE_MONITOR)	+= page.o
> > > > >  proc-$(CONFIG_BOOT_CONFIG)	+= bootconfig.o
> > > > > +proc-$(CONFIG_BOOT_CONFIG_FORCE)	+= raw_cmdline.o
> > > > > diff --git a/fs/proc/raw_cmdline.c b/fs/proc/raw_cmdline.c
> > > > > new file mode 100644
> > > > > index 000000000000..2e19eb89fc8e
> > > > > --- /dev/null
> > > > > +++ b/fs/proc/raw_cmdline.c
> > > > > @@ -0,0 +1,25 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +#include <linux/fs.h>
> > > > > +#include <linux/init.h>
> > > > > +#include <linux/proc_fs.h>
> > > > > +#include <linux/seq_file.h>
> > > > > +#include <asm/setup.h>
> > > > > +#include "internal.h"
> > > > > +
> > > > > +static int raw_cmdline_proc_show(struct seq_file *m, void *v)
> > > > > +{
> > > > > +	seq_puts(m, boot_command_line);
> > > > > +	seq_putc(m, '\n');
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > > > +static int __init proc_raw_cmdline_init(void)
> > > > > +{
> > > > > +	struct proc_dir_entry *pde;
> > > > > +
> > > > > +	pde = proc_create_single("raw_cmdline", 0, NULL, raw_cmdline_proc_show);
> > > > > +	pde_make_permanent(pde);
> > > > > +	pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > > > +	return 0;
> > > > > +}
> > > > > +fs_initcall(proc_raw_cmdline_init);
> > > > > diff --git a/include/linux/init.h b/include/linux/init.h
> > > > > index 266c3e1640d4..29e75bbe7984 100644
> > > > > --- a/include/linux/init.h
> > > > > +++ b/include/linux/init.h
> > > > > @@ -112,6 +112,7 @@
> > > > >  #define __REFCONST       .section       ".ref.rodata", "a"
> > > > >  
> > > > >  #ifndef __ASSEMBLY__
> > > > > +
> > > > >  /*
> > > > >   * Used for initialization calls..
> > > > >   */
> > > > > @@ -143,7 +144,7 @@ struct file_system_type;
> > > > >  
> > > > >  /* Defined in init/main.c */
> > > > >  extern int do_one_initcall(initcall_t fn);
> > > > > -extern char __initdata boot_command_line[];
> > > > > +extern char boot_command_line[];
> > > > >  extern char *saved_command_line;
> > > > >  extern unsigned int saved_command_line_len;
> > > > >  extern unsigned int reset_devices;
> > > > > diff --git a/init/main.c b/init/main.c
> > > > > index ad920fac325c..2121685c479a 100644
> > > > > --- a/init/main.c
> > > > > +++ b/init/main.c
> > > > > @@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
> > > > >  void (*__initdata late_time_init)(void);
> > > > >  
> > > > >  /* Untouched command line saved by arch-specific code. */
> > > > > -char __initdata boot_command_line[COMMAND_LINE_SIZE];
> > > > > +char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
> > > > >  /* Untouched saved command line (eg. for /proc) */
> > > > >  char *saved_command_line __ro_after_init;
> > > > >  unsigned int saved_command_line_len __ro_after_init;
> > > > 
> > > > 
> > > > -- 
> > > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
