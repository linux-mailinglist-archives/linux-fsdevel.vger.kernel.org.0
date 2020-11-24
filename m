Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD23F2C22EC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgKXK2Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 05:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgKXK2Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:28:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE15C0613D6;
        Tue, 24 Nov 2020 02:28:16 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F96F1EC0258;
        Tue, 24 Nov 2020 11:28:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1iD6gApHU/j5+m+pR3M2pYpCc5CocFQKVTv8UeDApE=;
        b=oxFEsy1xk2af1Zv9kcv9IDxeON6BmmZshHoR+RFqMzeKov/OtvquRS1f0VwWN7SDXZuTBs
        3tmvJmv3fWOjuMnLqJVmfbIBkUULqOJ4TdxeeMraENvmrx9cehfmVe5TWqwx/pVeyfrgxS
        i9wcUT2ECgbm5jEFSB/e5bSFj3iSOBw=
Date:   Tue, 24 Nov 2020 11:28:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Jan Kara <jack@suse.cz>
Cc:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201124102814.GE4009@zn.tnic>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com>
 <20201124084507.GA4009@zn.tnic>
 <20201124102033.GA19336@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124102033.GA19336@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:20:33AM +0100, Jan Kara wrote:
> On Tue 24-11-20 09:45:07, Borislav Petkov wrote:
> > On Mon, Nov 23, 2020 at 11:46:51PM +0100, Paweł Jasiak wrote:
> > > On 23/11/20, Jan Kara wrote:
> > > > OK, with a help of Boris Petkov I think I have a fix that looks correct
> > > > (attach). Can you please try whether it works for you? Thanks!
> > > 
> > > Unfortunately I am getting a linker error.
> > > 
> > > ld: arch/x86/entry/syscall_32.o:(.rodata+0x54c): undefined reference to `__ia32_sys_ia32_fanotify_mark'
> > 
> > Because CONFIG_COMPAT is not set in your .config.
> > 
> > Jan, look at 121b32a58a3a and especially this hunk
> > 
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 9b294c13809a..b8f89f78b8cd 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -53,6 +53,8 @@ obj-y                 += setup.o x86_init.o i8259.o irqinit.o
> >  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
> >  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
> >  obj-y                  += probe_roms.o
> > +obj-$(CONFIG_X86_32)   += sys_ia32.o
> > +obj-$(CONFIG_IA32_EMULATION)   += sys_ia32.o
> > 
> > how it enables the ia32 syscalls depending on those config items. Now,
> > you have
> > 
> >  #ifdef CONFIG_COMPAT
> > -COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> > +SYSCALL_DEFINE6(ia32_fanotify_mark,
> > 
> > which is under CONFIG_COMPAT which is not set in Paweł's config.
> > 
> > config COMPAT
> >         def_bool y
> >         depends on IA32_EMULATION || X86_X32
> > 
> > but it depends on those two config items.
> > 
> > However, it looks to me like ia32_fanotify_mark's definition should be
> > simply under CONFIG_X86_32 because:
> > 
> > IA32_EMULATION is 32-bit emulation on 64-bit kernels
> > X86_X32 is for the x32 ABI
> 
> Thanks for checking! I didn't realize I needed to change the ifdefs as well
> (I missed that bit in 121b32a58a3a). So do I understand correctly that
> whenever the kernel is 64-bit, 64-bit syscall args (e.g. defined as u64) are
> passed just fine regardless of whether the userspace is 32-bit or not?
> 
> Also how about other 32-bit archs? Because I now realized that
> CONFIG_COMPAT as well as the COMPAT_SYSCALL_DEFINE6() is also utilized by
> other 32-bit archs (I can see a reference to compat_sys_fanotify_mark e.g.
> in sparc, powerpc, and other args). So I probably need to actually keep
> that for other archs but do the modification only for x86, don't I?

Hmm, you raise a good point and looking at that commit again, the
intention is to supply those ia32 wrappers as both 32-bit native *and*
32-bit emulation ones.

So I think this

> -#ifdef CONFIG_COMPAT
> +#if defined(CONFIG_COMPAT) || defined(CONFIG_X86_32)
> +#ifdef CONFIG_X86_32
> +SYSCALL_DEFINE6(ia32_fanotify_mark,
> +#elif CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> +#endif

should be

if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
SYSCALL_DEFINE6(ia32_fanotify_mark,
#elif CONFIG_COMPAT
COMPAT_SYSCALL_DEFINE6(fanotify_mark,
#endif

or so.

Meaning that 32-bit native or 32-bit emulation supplies
ia32_fanotify_mark() as a syscall wrapper and other arches doing
CONFIG_COMPAT, still do the COMPAT_SYSCALL_DEFINE6() thing.

But I'd prefer if someone more knowledgeable than me in that whole
syscall macros muck to have a look...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
