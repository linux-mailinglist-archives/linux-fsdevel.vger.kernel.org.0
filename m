Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D2D768719
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Jul 2023 20:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjG3SRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Jul 2023 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3SRp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Jul 2023 14:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53864BB;
        Sun, 30 Jul 2023 11:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD3260CEC;
        Sun, 30 Jul 2023 18:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF2BC433C8;
        Sun, 30 Jul 2023 18:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690741063;
        bh=QjUZjEw1F51W0Eeyt5ZfnNs5KyebGUK0k84riJGi6UM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f0gGiGSuUv5+bFP1swcXx8SOcwmzm5hJ6nYlex8CKQdbhS4BJgvSTQrqi8DtbcTOP
         6HVOU6yO+IMbxCgkIBGyCcYKHyrupqpBRIvPqk7lc24yVlCYb1msgsgNi4JIEJJZWQ
         g0J3gu/ken1NM7ViA8tNp1doleNUlA25yAeifMxlpn+WCoYpDD5j6wd61UVoSmfB67
         4hzhEnSgi8Mio5HgHSq4lZyrz0LGc9AxuddoXwKcE3OPPYVM9bgX64fsXLw1HZ1Nce
         5OHjZ3r98pNjNagqgItWevvMWizfHX9vwGS8Eap4vqToAMBXEkxEgj+tQLN3pR6viY
         hO/A+iUemLZ9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C8EBFCE0DEB; Sun, 30 Jul 2023 11:17:42 -0700 (PDT)
Date:   Sun, 30 Jul 2023 11:17:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com, arnd@kernel.org,
        ndesaulniers@google.com, sfr@canb.auug.org.au,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH RFC bootconfig] 1/2] fs/proc: Add /proc/cmdline_load for
 boot loader arguments
Message-ID: <182ca5f1-c3f9-4ed6-9f8a-3244b2683ce9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <197cba95-3989-4d2f-a9f1-8b192ad08c49@paulmck-laptop>
 <20230728033701.817094-1-paulmck@kernel.org>
 <20230729232929.a3e962f46c16973031bb466c@kernel.org>
 <fc4a8339-9fb0-47ef-9b6e-5f3cdde82658@paulmck-laptop>
 <20230730105844.ab4ad370a30be8f56db3a488@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730105844.ab4ad370a30be8f56db3a488@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 30, 2023 at 10:58:44AM +0900, Masami Hiramatsu wrote:
> On Sat, 29 Jul 2023 09:16:56 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Sat, Jul 29, 2023 at 11:29:29PM +0900, Masami Hiramatsu wrote:
> > > Hi Paul,
> > > 
> > > On Thu, 27 Jul 2023 20:37:00 -0700
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > 
> > > > In kernels built with CONFIG_BOOT_CONFIG_FORCE=y, /proc/cmdline will
> > > > show all kernel boot parameters, both those supplied by the boot loader
> > > > and those embedded in the kernel image.  This works well for those who
> > > > just want to see all of the kernel boot parameters, but is not helpful to
> > > > those who need to see only those parameters supplied by the boot loader.
> > > > This is especially important when these parameters are presented to the
> > > > boot loader by automation that might gather them from diverse sources.
> > > > 
> > > > Therefore, provide a /proc/cmdline_load file that shows only those kernel
> > > > boot parameters supplied by the boot loader.
> > > 
> > > If I understand correctly, /proc/cmdline_load is something like
> > > /proc/cmdline_load - `/proc/bootconfig | grep ^kernel\\.`.
> 
> ^^^ /proc/cmdline - `/proc/bootconfig | grep ^kernel\\.`

Heh!  My mind autocorrected without me noticing.  ;-)

> > Yes, very much something like that.
> > 
> > For one use case, suppose you have a kernel that gets some boot parameters
> > from the boot loader and some from bootconfig.  If you want to kexec()
> > into a new kernel, you must tell kexec() what the kernel boot parameters
> > are.  However, you must *not* tell kexec() about any of the current
> > kernel's parameters that came from bootconfig, because those should
> > instead be supplied by the new kernel being kexec()ed into.
> > 
> > So you must pass in only those parameters that came from the boot loader,
> > hence my proposed /proc/cmdline_load.
> 
> Ah, I got it. Indeed, for kexec, we need to drop the options from
> the bootconfig.
> 
> > > BTW, what about CONFIG_CMDLINE? We already have that Kconfig and it is also
> > > merged with the command line specified by boot loader. Should we also
> > > expose that? (when CONFIG_CMDLINE_OVERRIDE=y, we don't need it because
> > > cmdline is always overridden by the CONFIG_CMDLINE) Unfortunatelly, this
> > > option is implemented in each arch init, so we have to change all of them...
> > 
> > The use case is embedded systems, right?  I have no idea whether they
> > have a use case requiring this.  Do those sorts of embedded systems
> > use kexec()?  (I don't know of any that do, but then again, I haven't
> > been looking.)
> 
> Not sure, I guess it is possible to use kexec() for kdump or warm reboot,
> but it should be rare and we can expand this if someone need it.

Works for me!

> > This arch init is in setup_arch(), correct?  If so, one option is to
> > make start_kernel() or something that it invokes make a copy of the
> > command line just before invoking setup_arch().  Full disclosure: I
> > have not yet looked at all the ins and outs of CONFIG_CMDLINE, so this
> > suggestion should be viewed with appropriate skepticism.
> 
> Yeah, maybe it is the best way to do.
> Anyway, I understand the reason why we need this interface.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you!  I will apply your Acked-by on my next rebase.

							Thanx, Paul

> Thank you!
> 
> > 
> > > Thank you,
> > > 
> > > > 
> > > > Why put this in /proc?  Because it is quite similar to /proc/cmdline, so
> > > > it makes sense to put it in the same place that /proc/cmdline is located.
> > > > 
> > > > [ sfr: Apply kernel test robot feedback. ]
> > > > 
> > > > Co-developed-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Alexey Dobriyan <adobriyan@gmail.com>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: <linux-fsdevel@vger.kernel.org>
> > > > ---
> > > >  fs/proc/cmdline.c    | 13 +++++++++++++
> > > >  include/linux/init.h |  3 ++-
> > > >  init/main.c          |  2 +-
> > > >  3 files changed, 16 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/proc/cmdline.c b/fs/proc/cmdline.c
> > > > index a6f76121955f..1d0ef9d2949d 100644
> > > > --- a/fs/proc/cmdline.c
> > > > +++ b/fs/proc/cmdline.c
> > > > @@ -3,6 +3,7 @@
> > > >  #include <linux/init.h>
> > > >  #include <linux/proc_fs.h>
> > > >  #include <linux/seq_file.h>
> > > > +#include <asm/setup.h>
> > > >  #include "internal.h"
> > > >  
> > > >  static int cmdline_proc_show(struct seq_file *m, void *v)
> > > > @@ -12,6 +13,13 @@ static int cmdline_proc_show(struct seq_file *m, void *v)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int cmdline_load_proc_show(struct seq_file *m, void *v)
> > > > +{
> > > > +	seq_puts(m, boot_command_line);
> > > > +	seq_putc(m, '\n');
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int __init proc_cmdline_init(void)
> > > >  {
> > > >  	struct proc_dir_entry *pde;
> > > > @@ -19,6 +27,11 @@ static int __init proc_cmdline_init(void)
> > > >  	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
> > > >  	pde_make_permanent(pde);
> > > >  	pde->size = saved_command_line_len + 1;
> > > > +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE)) {
> > > > +		pde = proc_create_single("cmdline_load", 0, NULL, cmdline_load_proc_show);
> > > > +		pde_make_permanent(pde);
> > > > +		pde->size = strnlen(boot_command_line, COMMAND_LINE_SIZE) + 1;
> > > > +	}
> > > >  	return 0;
> > > >  }
> > > >  fs_initcall(proc_cmdline_init);
> > > > diff --git a/include/linux/init.h b/include/linux/init.h
> > > > index 266c3e1640d4..29e75bbe7984 100644
> > > > --- a/include/linux/init.h
> > > > +++ b/include/linux/init.h
> > > > @@ -112,6 +112,7 @@
> > > >  #define __REFCONST       .section       ".ref.rodata", "a"
> > > >  
> > > >  #ifndef __ASSEMBLY__
> > > > +
> > > >  /*
> > > >   * Used for initialization calls..
> > > >   */
> > > > @@ -143,7 +144,7 @@ struct file_system_type;
> > > >  
> > > >  /* Defined in init/main.c */
> > > >  extern int do_one_initcall(initcall_t fn);
> > > > -extern char __initdata boot_command_line[];
> > > > +extern char boot_command_line[];
> > > 
> > > FYI, boot_command_line[] is mixture of built-in cmdline string with
> > > bootloader cmdline string.
> > 
> > So if we also need to separate out the CONFIG_CMDLINE arguments, then
> > /proc/cmdline_load will need to come from some string saved off before
> > the CONFIG_CMDLINE processing, correct?  I would expect that to be a
> > separate patch series, but if it is needed, I would be happy to look
> > into setting it up, as long as I am in the area.
> > 
> > My tests indicate that boot_command_line[] doesn't contain any bootconfig
> > (and opposed to CONFIG_CMDLINE) arguments, but I could easily have missed
> > some other corner-case configuration.
> > 
> > And thank you for looking this over!
> > 
> > 							Thanx, Paul
> > 
> > > >  extern char *saved_command_line;
> > > >  extern unsigned int saved_command_line_len;
> > > >  extern unsigned int reset_devices;
> > > > diff --git a/init/main.c b/init/main.c
> > > > index ad920fac325c..2121685c479a 100644
> > > > --- a/init/main.c
> > > > +++ b/init/main.c
> > > > @@ -135,7 +135,7 @@ EXPORT_SYMBOL(system_state);
> > > >  void (*__initdata late_time_init)(void);
> > > >  
> > > >  /* Untouched command line saved by arch-specific code. */
> > > > -char __initdata boot_command_line[COMMAND_LINE_SIZE];
> > > > +char boot_command_line[COMMAND_LINE_SIZE] __ro_after_init;
> > > >  /* Untouched saved command line (eg. for /proc) */
> > > >  char *saved_command_line __ro_after_init;
> > > >  unsigned int saved_command_line_len __ro_after_init;
> > > > -- 
> > > > 2.40.1
> > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
