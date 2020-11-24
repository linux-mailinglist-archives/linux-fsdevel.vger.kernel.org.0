Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815912C2056
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 09:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730831AbgKXIpP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 03:45:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34112 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730819AbgKXIpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:45:14 -0500
Received: from zn.tnic (p200300ec2f0e3600a9cb1df0e98d070c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:a9cb:1df0:e98d:70c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D971B1EC0518;
        Tue, 24 Nov 2020 09:45:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606207513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qk/rtkgVHsqU9L7OtuJVSvuNtsGHxul1K7rInoMCT2s=;
        b=ZLb8X5GuVxUYNkwKcOVo7jR1ByRYqvMv+vcQmPlcBhQoZLvyYBGhKF07gKosuGzD8x2T+F
        nItRi1UG5UzwjSJnJsNVm7Jxu8VyL05pfhvyDNw2OdO2mISX/mmaGvJRuFgbhVE757CviR
        d9SRjGmpihHomImQ05zVk7Vf9kcxVGw=
Date:   Tue, 24 Nov 2020 09:45:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201124084507.GA4009@zn.tnic>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123224651.GA27809@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 23, 2020 at 11:46:51PM +0100, Paweł Jasiak wrote:
> On 23/11/20, Jan Kara wrote:
> > OK, with a help of Boris Petkov I think I have a fix that looks correct
> > (attach). Can you please try whether it works for you? Thanks!
> 
> Unfortunately I am getting a linker error.
> 
> ld: arch/x86/entry/syscall_32.o:(.rodata+0x54c): undefined reference to `__ia32_sys_ia32_fanotify_mark'

Because CONFIG_COMPAT is not set in your .config.

Jan, look at 121b32a58a3a and especially this hunk

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 9b294c13809a..b8f89f78b8cd 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -53,6 +53,8 @@ obj-y                 += setup.o x86_init.o i8259.o irqinit.o
 obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
 obj-$(CONFIG_IRQ_WORK)  += irq_work.o
 obj-y                  += probe_roms.o
+obj-$(CONFIG_X86_32)   += sys_ia32.o
+obj-$(CONFIG_IA32_EMULATION)   += sys_ia32.o

how it enables the ia32 syscalls depending on those config items. Now,
you have

 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(fanotify_mark,
+SYSCALL_DEFINE6(ia32_fanotify_mark,

which is under CONFIG_COMPAT which is not set in Paweł's config.

config COMPAT
        def_bool y
        depends on IA32_EMULATION || X86_X32

but it depends on those two config items.

However, it looks to me like ia32_fanotify_mark's definition should be
simply under CONFIG_X86_32 because:

IA32_EMULATION is 32-bit emulation on 64-bit kernels
X86_X32 is for the x32 ABI

But I could be missing an angle...

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
