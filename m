Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDB61AEAA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 10:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgDRIFe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 04:05:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:7106 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgDRIFe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:05:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49459h05LLz9txXw;
        Sat, 18 Apr 2020 10:05:28 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=PRb7ziKc; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 88HgkiXZBaj0; Sat, 18 Apr 2020 10:05:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49459g5qG5z9txXv;
        Sat, 18 Apr 2020 10:05:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587197127; bh=eYFvX9PUHCxTTuXy9c9FJ+5YeTg8dwkbC0BOPikIolI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PRb7ziKcBPPHvQNn6ZND93ScBv1HV+KFZHgPLqCgcoRiPlr60EAAMT8LIWoJ7sGtq
         /UyPHtcYH1AED4GIZ6+f1mh2u0t+LjHhiVIuaV8WMCJIF39zm5Ql+eQ80FECbo1Dvf
         ghEG5THJ0t47/CEzV3YdJaXN5dEMEUTxYd9OKmXo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0EF48B772;
        Sat, 18 Apr 2020 10:05:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OLa1DQYE8a_C; Sat, 18 Apr 2020 10:05:28 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 453B68B75E;
        Sat, 18 Apr 2020 10:05:27 +0200 (CEST)
Subject: Re: [PATCH 1/2] signal: Factor copy_siginfo_to_external32 from
 copy_siginfo_to_user32
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Jeremy Kerr <jk@ozlabs.org>
References: <20200414070142.288696-1-hch@lst.de>
 <20200414070142.288696-3-hch@lst.de> <87pnc5akhk.fsf@x220.int.ebiederm.org>
 <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c51c6192-2ea4-62d8-dd22-305f7a1e0dd3@c-s.fr>
Date:   Sat, 18 Apr 2020 10:05:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87k12dakfx.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 17/04/2020 à 23:09, Eric W. Biederman a écrit :
> 
> To remove the use of set_fs in the coredump code there needs to be a
> way to convert a kernel siginfo to a userspace compat siginfo.
> 
> Call that function copy_siginfo_to_compat and factor it out of
> copy_siginfo_to_user32.

I find it a pitty to do that.

The existing function could have been easily converted to using 
user_access_begin() + user_access_end() and use unsafe_put_user() to 
copy to userspace to avoid copying through a temporary structure on the 
stack.

With your change, it becomes impossible to do that.

Is that really an issue to use that set_fs() in the coredump code ?

Christophe

> 
> The existence of x32 complicates this code.  On x32 SIGCHLD uses 64bit
> times for utime and stime.  As only SIGCHLD is affected and SIGCHLD
> never causes a coredump I have avoided handling that case.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
>   include/linux/compat.h |   1 +
>   kernel/signal.c        | 108 +++++++++++++++++++++++------------------
>   2 files changed, 63 insertions(+), 46 deletions(-)
> 
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 0480ba4db592..4962b254e550 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -402,6 +402,7 @@ long compat_get_bitmap(unsigned long *mask, const compat_ulong_t __user *umask,
>   		       unsigned long bitmap_size);
>   long compat_put_bitmap(compat_ulong_t __user *umask, unsigned long *mask,
>   		       unsigned long bitmap_size);
> +void copy_siginfo_to_external32(struct compat_siginfo *to, const struct kernel_siginfo *from);
>   int copy_siginfo_from_user32(kernel_siginfo_t *to, const struct compat_siginfo __user *from);
>   int copy_siginfo_to_user32(struct compat_siginfo __user *to, const kernel_siginfo_t *from);
>   int get_compat_sigevent(struct sigevent *event,
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e58a6c619824..578f196898cb 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3235,90 +3235,106 @@ int copy_siginfo_from_user(kernel_siginfo_t *to, const siginfo_t __user *from)
>   }
>   
>   #ifdef CONFIG_COMPAT
> -int copy_siginfo_to_user32(struct compat_siginfo __user *to,
> -			   const struct kernel_siginfo *from)
> -#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
> +void copy_siginfo_to_external32(struct compat_siginfo *to,
> +				const struct kernel_siginfo *from)
>   {
> -	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
> -}
> -int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> -			     const struct kernel_siginfo *from, bool x32_ABI)
> -#endif
> -{
> -	struct compat_siginfo new;
> -	memset(&new, 0, sizeof(new));
> +	/*
> +	 * This function does not work properly for SIGCHLD on x32,
> +	 * but it does not need to as SIGCHLD never causes a coredump.
> +	 */
> +	memset(to, 0, sizeof(*to));
>   
> -	new.si_signo = from->si_signo;
> -	new.si_errno = from->si_errno;
> -	new.si_code  = from->si_code;
> +	to->si_signo = from->si_signo;
> +	to->si_errno = from->si_errno;
> +	to->si_code  = from->si_code;
>   	switch(siginfo_layout(from->si_signo, from->si_code)) {
>   	case SIL_KILL:
> -		new.si_pid = from->si_pid;
> -		new.si_uid = from->si_uid;
> +		to->si_pid = from->si_pid;
> +		to->si_uid = from->si_uid;
>   		break;
>   	case SIL_TIMER:
> -		new.si_tid     = from->si_tid;
> -		new.si_overrun = from->si_overrun;
> -		new.si_int     = from->si_int;
> +		to->si_tid     = from->si_tid;
> +		to->si_overrun = from->si_overrun;
> +		to->si_int     = from->si_int;
>   		break;
>   	case SIL_POLL:
> -		new.si_band = from->si_band;
> -		new.si_fd   = from->si_fd;
> +		to->si_band = from->si_band;
> +		to->si_fd   = from->si_fd;
>   		break;
>   	case SIL_FAULT:
> -		new.si_addr = ptr_to_compat(from->si_addr);
> +		to->si_addr = ptr_to_compat(from->si_addr);
>   #ifdef __ARCH_SI_TRAPNO
> -		new.si_trapno = from->si_trapno;
> +		to->si_trapno = from->si_trapno;
>   #endif
>   		break;
>   	case SIL_FAULT_MCEERR:
> -		new.si_addr = ptr_to_compat(from->si_addr);
> +		to->si_addr = ptr_to_compat(from->si_addr);
>   #ifdef __ARCH_SI_TRAPNO
> -		new.si_trapno = from->si_trapno;
> +		to->si_trapno = from->si_trapno;
>   #endif
> -		new.si_addr_lsb = from->si_addr_lsb;
> +		to->si_addr_lsb = from->si_addr_lsb;
>   		break;
>   	case SIL_FAULT_BNDERR:
> -		new.si_addr = ptr_to_compat(from->si_addr);
> +		to->si_addr = ptr_to_compat(from->si_addr);
>   #ifdef __ARCH_SI_TRAPNO
> -		new.si_trapno = from->si_trapno;
> +		to->si_trapno = from->si_trapno;
>   #endif
> -		new.si_lower = ptr_to_compat(from->si_lower);
> -		new.si_upper = ptr_to_compat(from->si_upper);
> +		to->si_lower = ptr_to_compat(from->si_lower);
> +		to->si_upper = ptr_to_compat(from->si_upper);
>   		break;
>   	case SIL_FAULT_PKUERR:
> -		new.si_addr = ptr_to_compat(from->si_addr);
> +		to->si_addr = ptr_to_compat(from->si_addr);
>   #ifdef __ARCH_SI_TRAPNO
> -		new.si_trapno = from->si_trapno;
> +		to->si_trapno = from->si_trapno;
>   #endif
> -		new.si_pkey = from->si_pkey;
> +		to->si_pkey = from->si_pkey;
>   		break;
>   	case SIL_CHLD:
> -		new.si_pid    = from->si_pid;
> -		new.si_uid    = from->si_uid;
> -		new.si_status = from->si_status;
> +		to->si_pid    = from->si_pid;
> +		to->si_uid    = from->si_uid;
> +		to->si_status = from->si_status;
> +		to->si_utime = from->si_utime;
> +		to->si_stime = from->si_stime;
>   #ifdef CONFIG_X86_X32_ABI
>   		if (x32_ABI) {
> -			new._sifields._sigchld_x32._utime = from->si_utime;
> -			new._sifields._sigchld_x32._stime = from->si_stime;
> +			to->_sifields._sigchld_x32._utime = from->si_utime;
> +			to->_sifields._sigchld_x32._stime = from->si_stime;
>   		} else
>   #endif
>   		{
> -			new.si_utime = from->si_utime;
> -			new.si_stime = from->si_stime;
>   		}
>   		break;
>   	case SIL_RT:
> -		new.si_pid = from->si_pid;
> -		new.si_uid = from->si_uid;
> -		new.si_int = from->si_int;
> +		to->si_pid = from->si_pid;
> +		to->si_uid = from->si_uid;
> +		to->si_int = from->si_int;
>   		break;
>   	case SIL_SYS:
> -		new.si_call_addr = ptr_to_compat(from->si_call_addr);
> -		new.si_syscall   = from->si_syscall;
> -		new.si_arch      = from->si_arch;
> +		to->si_call_addr = ptr_to_compat(from->si_call_addr);
> +		to->si_syscall   = from->si_syscall;
> +		to->si_arch      = from->si_arch;
>   		break;
>   	}
> +}
> +
> +int copy_siginfo_to_user32(struct compat_siginfo __user *to,
> +			   const struct kernel_siginfo *from)
> +#if defined(CONFIG_X86_X32_ABI) || defined(CONFIG_IA32_EMULATION)
> +{
> +	return __copy_siginfo_to_user32(to, from, in_x32_syscall());
> +}
> +int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
> +			     const struct kernel_siginfo *from, bool x32_ABI)
> +#endif
> +{
> +	struct compat_siginfo new;
> +	copy_siginfo_to_external32(&new, from);
> +#ifdef CONFIG_X86_X32_ABI
> +	if (x32_ABI && from->si_signo == SIGCHLD) {
> +		new._sifields._sigchld_x32._utime = from->si_utime;
> +		new._sifields._sigchld_x32._stime = from->si_stime;
> +	}
> +#endif
>   
>   	if (copy_to_user(to, &new, sizeof(struct compat_siginfo)))
>   		return -EFAULT;
> 
