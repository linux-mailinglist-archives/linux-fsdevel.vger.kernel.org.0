Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A82C22C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 11:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbgKXKUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:40396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731973AbgKXKUf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8CADAC66;
        Tue, 24 Nov 2020 10:20:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4B5A51E130F; Tue, 24 Nov 2020 11:20:33 +0100 (CET)
Date:   Tue, 24 Nov 2020 11:20:33 +0100
From:   Jan Kara <jack@suse.cz>
To:     Borislav Petkov <bp@alien8.de>
Cc:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201124102033.GA19336@quack2.suse.cz>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
 <20201123224651.GA27809@gmail.com>
 <20201124084507.GA4009@zn.tnic>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124084507.GA4009@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue 24-11-20 09:45:07, Borislav Petkov wrote:
> On Mon, Nov 23, 2020 at 11:46:51PM +0100, Paweł Jasiak wrote:
> > On 23/11/20, Jan Kara wrote:
> > > OK, with a help of Boris Petkov I think I have a fix that looks correct
> > > (attach). Can you please try whether it works for you? Thanks!
> > 
> > Unfortunately I am getting a linker error.
> > 
> > ld: arch/x86/entry/syscall_32.o:(.rodata+0x54c): undefined reference to `__ia32_sys_ia32_fanotify_mark'
> 
> Because CONFIG_COMPAT is not set in your .config.
> 
> Jan, look at 121b32a58a3a and especially this hunk
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 9b294c13809a..b8f89f78b8cd 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -53,6 +53,8 @@ obj-y                 += setup.o x86_init.o i8259.o irqinit.o
>  obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
>  obj-$(CONFIG_IRQ_WORK)  += irq_work.o
>  obj-y                  += probe_roms.o
> +obj-$(CONFIG_X86_32)   += sys_ia32.o
> +obj-$(CONFIG_IA32_EMULATION)   += sys_ia32.o
> 
> how it enables the ia32 syscalls depending on those config items. Now,
> you have
> 
>  #ifdef CONFIG_COMPAT
> -COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> +SYSCALL_DEFINE6(ia32_fanotify_mark,
> 
> which is under CONFIG_COMPAT which is not set in Paweł's config.
> 
> config COMPAT
>         def_bool y
>         depends on IA32_EMULATION || X86_X32
> 
> but it depends on those two config items.
> 
> However, it looks to me like ia32_fanotify_mark's definition should be
> simply under CONFIG_X86_32 because:
> 
> IA32_EMULATION is 32-bit emulation on 64-bit kernels
> X86_X32 is for the x32 ABI

Thanks for checking! I didn't realize I needed to change the ifdefs as well
(I missed that bit in 121b32a58a3a). So do I understand correctly that
whenever the kernel is 64-bit, 64-bit syscall args (e.g. defined as u64) are
passed just fine regardless of whether the userspace is 32-bit or not?

Also how about other 32-bit archs? Because I now realized that
CONFIG_COMPAT as well as the COMPAT_SYSCALL_DEFINE6() is also utilized by
other 32-bit archs (I can see a reference to compat_sys_fanotify_mark e.g.
in sparc, powerpc, and other args). So I probably need to actually keep
that for other archs but do the modification only for x86, don't I?

So something like attached patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--OXfL5xGRrasGEqWY
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename="0001-fanotify-Fix-fanotify_mark-on-32-bit-x86.patch"
Content-Transfer-Encoding: 8bit

From 20d2ddf37c01e91ca18d415a59b3488a394acd8f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 23 Nov 2020 17:37:00 +0100
Subject: [PATCH] fanotify: Fix fanotify_mark() on 32-bit x86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit converting syscalls taking 64-bit arguments to new scheme of compat
handlers omitted converting fanotify_mark(2) which then broke the
syscall for 32-bit x86 builds. Add missed conversion. It is somewhat
cumbersome since we need to keep the original compat handler for all the
other 32-bit archs.

CC: Brian Gerst <brgerst@gmail.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 fs/notify/fanotify/fanotify_user.c     | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 0d0667a9fbd7..b2ec6ff88307 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -350,7 +350,7 @@
 336	i386	perf_event_open		sys_perf_event_open
 337	i386	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
 338	i386	fanotify_init		sys_fanotify_init
-339	i386	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+339	i386	fanotify_mark		sys_ia32_fanotify_mark
 340	i386	prlimit64		sys_prlimit64
 341	i386	name_to_handle_at	sys_name_to_handle_at
 342	i386	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..54a36d4bd116 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1292,8 +1292,12 @@ SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) || defined(CONFIG_X86_32)
+#ifdef CONFIG_X86_32
+SYSCALL_DEFINE6(ia32_fanotify_mark,
+#elif CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(fanotify_mark,
+#endif
 				int, fanotify_fd, unsigned int, flags,
 				__u32, mask0, __u32, mask1, int, dfd,
 				const char  __user *, pathname)
-- 
2.16.4


--OXfL5xGRrasGEqWY--
