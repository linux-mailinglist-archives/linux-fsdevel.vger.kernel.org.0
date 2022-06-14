Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4435F54B409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jun 2022 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbiFNPAM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiFNPAH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:00:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941A834BBE;
        Tue, 14 Jun 2022 08:00:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 45AEA21B4B;
        Tue, 14 Jun 2022 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655218805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwSuqF6uTnS9sycd/ZJ331jl24Tu4wAfnf0GrdtvgFI=;
        b=tvnoBCuSzrCFCB353tSo9EkgEeRe5we+JE3IpEBg4bAQRLHOKldQvFY6Pa1uofwv2haix9
        9bn6RaNQpO2dAGw/Jg/TtUWH4QzS9B2t8hr5YKcTAT6pF2Oz2zMmF/zlkbk/CSp+2tPWq2
        +fJQuIJW4CCQbEW4R1BBwufeAiPpPms=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D40702C141;
        Tue, 14 Jun 2022 15:00:04 +0000 (UTC)
Date:   Tue, 14 Jun 2022 17:00:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     jack@suse.cz, sunjunchao2870@gmail.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Message-ID: <YqiidNPMUZQPRIvy@alley>
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
 <Yqh9xIwBVcabpSLe@alley>
 <YqiJH1phG/LWu9bs@monolith.localdoman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqiJH1phG/LWu9bs@monolith.localdoman>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 2022-06-14 14:23:42, Alexandru Elisei wrote:
> With this change:
> 
> diff --git a/init/main.c b/init/main.c
> index 0ee39cdcfcac..a245982eb8a2 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1057,6 +1057,8 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> 
>         kmem_cache_init_late();
> 
> +       lockdep_init();
> +
>         /*
>          * HACK ALERT! This is early. We're enabling the console before
>          * we've done PCI setups etc, and console_init() must be aware of
> @@ -1067,8 +1069,6 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>                 panic("Too many boot %s vars at `%s'", panic_later,
>                       panic_param);
> 
> -       lockdep_init();
> -
>         /*
>          * Need to run this when irqs are enabled, because it wants
>          * to self-test [hard/soft]-irqs on/off lock inversion bugs
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ea3dd55709e7..aa7684c6745d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2705,7 +2705,10 @@ static int console_cpu_notify(unsigned int cpu)
>   */
>  void console_lock(void)
>  {
> +       pr_info("before might_sleep()");
>         might_sleep();
> +       pr_info("before down_console_sem()");
> +       pr_info("before down_console_sem()");
> 
>         down_console_sem();
>         if (console_suspended)
> @@ -3508,12 +3511,18 @@ int unregister_console(struct console *console)
>         if (console->exit)
>                 res = console->exit(console);
> 
> +       pr_info("Exiting from unregister_console(), res = %d", res);
> +       pr_info("Exiting from unregister_console(), res = %d", res);
> +
>         return res;
> 
>  out_disable_unlock:
>         console->flags &= ~CON_ENABLED;
>         console_unlock();
> 
> +       pr_info("Exiting from unregister_console(), res = %d", res);
> +       pr_info("Exiting from unregister_console(), res = %d", res);
> +
>         return res;
>  }
>  EXPORT_SYMBOL(unregister_console);
> 
> Some of the pr_info statements are duplicated to see the output just before
> the console hangs (I assume they're needed to force a buffer flush).
> 
> This is what I got:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.19.0-rc2-dirty (alex@monolith) (aarch64-linux-gnu-gcc (GCC) 12.1.0, GNU ld (GNU Binutils) 2.38) #106 SMP PREEMPT Tue Jun 14 14:03:30 BST 2022
> [    0.000000] Machine model: Pine64 RockPro64 v2.0
> [    0.000000] efi: UEFI not found.
> [    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options '1500000n8')
> [    0.000000] printk: before might_sleep()
> [    0.000000] printk: before down_console_sem()
> [    0.000000] printk: before down_console_sem()
> [    0.000000] printk: bootconsole [uart0] enabled
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem 0x0000000000200000-0x00000000f7ffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0xf77cef40-0xf77d0fff]
[...]
> [    0.000001] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
> [    0.005602] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
> [    0.006373] ... MAX_LOCKDEP_SUBCLASSES:  8
> [    0.006789] ... MAX_LOCK_DEPTH:          48
> [    0.007212] ... MAX_LOCKDEP_KEYS:        8192
> [    0.007651] ... CLASSHASH_SIZE:          4096
> [    0.008088] ... MAX_LOCKDEP_ENTRIES:     32768
> [    0.008535] ... MAX_LOCKDEP_CHAINS:      65536
> [    0.008981] ... CHAINHASH_SIZE:          32768
> [    0.009428]  memory used by lock dependency info: 6365 kB
> [    0.010018]  memory used for stack traces: 4224 kB
> [    0.010500]  per task-struct memory footprint: 1920 bytes
> [    0.011059] printk: before might_sleep()
> [    0.011079] printk: before down_console_sem()
> [    0.011477] printk: before down_console_sem()
> [    0.012112] Console: colour dummy device 80x25
> [    0.012984] printk: before might_sleep()
> [    0.013003] printk: before down_console_sem()
> [    0.013399] printk: before down_console_sem()
> [    0.013860] printk: console [tty0] enabled
> [    0.014986] printk: bootconsole [uart0] disabled
> [    0.015564] printk: before might_sleep()
> [    0.015582] printk: before down_console_sem()

I think that it did not print the 2nd "printk: before
down_console_sem()" because there was missing newline "\n".

printk() keeps such a line open because pr_cont() might append
to it. The message will get printed to the console only when
pr_cont("bla bla \n") is called or when another non-continuous
printk() is called.

> > Does the system boot when you avoid "earlycon" parameter?
> 
> It doesn't boot, it hangs and I don't get any output.

The difference might be that earlycon uses the serial port.
While the normal console is terminal "tty0".

Does it help to configure also the normal serial console.
I mean booting with something like:

earlycon console=uart,mmio32,0x00000000ff1a0000,1500000n8 console=tty0

I am not completely sure about the console=uart parameter. It is a
shame but I have never used it. I took the format from
Documentation/admin-guide/kernel-parameters.txt and the values
from your boot log:

[    0.000000] earlycon: uart0 at MMIO32 0x00000000ff1a0000 (options '1500000n8')

> > > I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the offending
> > > commit fiddles with locks, but no splat was produced that would explain the
> > > hang. I've also tried to boot a v5,19-rc2 kernel on my odroid-c4, the board
> > > is booting just fine, so I'm guessing it only affects of subset of arm64
> > > boards.
> > 
> > You might try to switch the order of console_init() and lockdep_init()
> > in start_kernel() in init/main.c
> 
> Did so above.

Unfortunately, it did not print anything :-(

Best Regards,
Petr
