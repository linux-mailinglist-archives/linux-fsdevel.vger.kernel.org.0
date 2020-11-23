Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0C72C1106
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 17:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390190AbgKWQqZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 11:46:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:46238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbgKWQqZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 11:46:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C2A1AC24;
        Mon, 23 Nov 2020 16:46:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A0FE81E130F; Mon, 23 Nov 2020 17:46:22 +0100 (CET)
Date:   Mon, 23 Nov 2020 17:46:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201123164622.GJ27294@quack2.suse.cz>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103211747.GA3688@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue 03-11-20 22:17:47, Paweł Jasiak wrote:
> I have written small patch that fixes problem for me and doesn't break
> x86_64.

OK, with a help of Boris Petkov I think I have a fix that looks correct
(attach). Can you please try whether it works for you? Thanks!

								Honza

> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3e01d8f2ab90..cf0b97309975 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1285,12 +1285,27 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	return ret;
>  }
>  
> +#if defined(CONFIG_X86) && !defined(CONFIG_64BIT)
> +SYSCALL_DEFINE6(fanotify_mark,
> +			int, fanotify_fd, unsigned int, flags, __u32, mask0,
> +			__u32, mask1, int, dfd, const char  __user *, pathname)
> +{
> +	return do_fanotify_mark(fanotify_fd, flags,
> +#ifdef __BIG_ENDIAN
> +				((__u64)mask0 << 32) | mask1,
> +#else
> +				((__u64)mask1 << 32) | mask0,
> +#endif
> +				 dfd, pathname);
> +}
> +#else
>  SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
>  			      __u64, mask, int, dfd,
>  			      const char  __user *, pathname)
>  {
>  	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
>  }
> +#endif
>  
>  #ifdef CONFIG_COMPAT
>  COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> 
> 
> -- 
> 
> Paweł Jasiak
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--Fba/0zbH8Xs+Fj9o
Content-Type: text/x-patch; charset=utf-8
Content-Disposition: attachment; filename="0001-fanotify-Fix-fanotify_mark-on-32-bit-archs.patch"
Content-Transfer-Encoding: 8bit

From fc9104a50a774ec198c1e3a145372cde77df7967 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 23 Nov 2020 17:37:00 +0100
Subject: [PATCH] fanotify: Fix fanotify_mark() on 32-bit archs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit converting syscalls taking 64-bit arguments to new scheme of compat
handlers omitted converting fanotify_mark(2) which then broke the
syscall for 32-bit ABI. Add missed conversion.

CC: Brian Gerst <brgerst@gmail.com>
Suggested-by: Borislav Petkov <bp@suse.de>
Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 fs/notify/fanotify/fanotify_user.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
index 3e01d8f2ab90..e20e7b53a87f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1293,7 +1293,7 @@ SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 }
 
 #ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(fanotify_mark,
+SYSCALL_DEFINE6(ia32_fanotify_mark,
 				int, fanotify_fd, unsigned int, flags,
 				__u32, mask0, __u32, mask1, int, dfd,
 				const char  __user *, pathname)
-- 
2.16.4


--Fba/0zbH8Xs+Fj9o--
