Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDEA0227
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 14:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfH1MtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 08:49:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30278 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1MtT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:49:19 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46JQY75bnJz9txm8;
        Wed, 28 Aug 2019 14:49:15 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WvTDiYtP; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id m7bd0W0Uqtud; Wed, 28 Aug 2019 14:49:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46JQY74Bh8z9txm7;
        Wed, 28 Aug 2019 14:49:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1566996555; bh=hjs1GSNdUdwzKHEdxEl72TsSfRO1liap1wA03hPf1Jk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WvTDiYtPN2FCuSeiNwOx6rUaE0l1kT7IOpImFYxV4y00H6bk9YOBAsdhCsbmpwnew
         y3vVnGVaOXyFwo8/zKRsZyLU51JRsspD6rWjeuRwfNeDXK773NciZUARkCrTC8xp4D
         o44zbJzyHTBa1B39IjdMnnyPhoFEdSt9UUhN98eI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F252A8B88E;
        Wed, 28 Aug 2019 14:49:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Zu2RyGK9ljTL; Wed, 28 Aug 2019 14:49:16 +0200 (CEST)
Received: from [172.25.230.105] (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A6DDA8B885;
        Wed, 28 Aug 2019 14:49:16 +0200 (CEST)
Subject: Re: [PATCH v2 3/4] powerpc/64: make buildable without CONFIG_COMPAT
To:     Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1566987936.git.msuchanek@suse.de>
 <fbf3f09d2f01e53aceea448ac42578251f424829.1566987936.git.msuchanek@suse.de>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fb471a46-5598-1c5c-911f-499b1aad259c@c-s.fr>
Date:   Wed, 28 Aug 2019 14:49:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <fbf3f09d2f01e53aceea448ac42578251f424829.1566987936.git.msuchanek@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



Le 28/08/2019 à 12:30, Michal Suchanek a écrit :
> There are numerous references to 32bit functions in generic and 64bit
> code so ifdef them out.

As far as possible, avoid opting things out with ifdefs. Ref 
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

See comment below.

> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - fix 32bit ifdef condition in signal.c
> - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> ---
>   arch/powerpc/include/asm/syscall.h |  2 ++
>   arch/powerpc/kernel/Makefile       | 15 ++++++++++++---
>   arch/powerpc/kernel/entry_64.S     |  2 ++
>   arch/powerpc/kernel/signal.c       |  5 +++--
>   arch/powerpc/kernel/syscall_64.c   |  5 +++--
>   arch/powerpc/kernel/vdso.c         |  4 +++-
>   arch/powerpc/perf/callchain.c      | 14 ++++++++++----
>   7 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
> index 38d62acfdce7..3ed3b75541a1 100644
> --- a/arch/powerpc/include/asm/syscall.h
> +++ b/arch/powerpc/include/asm/syscall.h
> @@ -16,7 +16,9 @@
>   
>   /* ftrace syscalls requires exporting the sys_call_table */
>   extern const unsigned long sys_call_table[];
> +#ifdef CONFIG_COMPAT
>   extern const unsigned long compat_sys_call_table[];
> +#endif

Leaving the declaration should be harmless.

>   
>   static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
>   {
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1d646a94d96c..b0db365b83d8 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -44,16 +44,25 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
>   endif
>   
>   obj-y				:= cputable.o ptrace.o syscalls.o \
> -				   irq.o align.o signal_32.o pmc.o vdso.o \
> +				   irq.o align.o pmc.o vdso.o \
>   				   process.o systbl.o idle.o \
>   				   signal.o sysfs.o cacheinfo.o time.o \
>   				   prom.o traps.o setup-common.o \
>   				   udbg.o misc.o io.o misc_$(BITS).o \
>   				   of_platform.o prom_parse.o
> -obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
> -				   signal_64.o ptrace32.o \
> +ifndef CONFIG_PPC64
> +obj-y				+= signal_32.o
> +else
> +ifdef CONFIG_COMPAT
> +obj-y				+= signal_32.o
> +endif
> +endif
> +obj-$(CONFIG_PPC64)		+= setup_64.o signal_64.o \
>   				   paca.o nvram_64.o firmware.o \
>   				   syscall_64.o

That's still a bit messy. You could have:

obj-y = +=signal_$(BITS).o
obj-$(CONFIG_COMPAT) += signal_32.o

> +ifdef CONFIG_COMPAT
> +obj-$(CONFIG_PPC64)		+= sys_ppc32.o ptrace32.o
> +endif

AFAIK, CONFIG_COMPAT is only defined when CONFIG_PP64 is defined, so 
could be:

obj-$(CONFIG_COMPAT)		+= sys_ppc32.o ptrace32.o

And could be grouped with the above signal_32.o


>   obj-$(CONFIG_VDSO32)		+= vdso32/
>   obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
>   obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 2ec825a85f5b..a2dbf216f607 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -51,8 +51,10 @@
>   SYS_CALL_TABLE:
>   	.tc sys_call_table[TC],sys_call_table
>   
> +#ifdef CONFIG_COMPAT
>   COMPAT_SYS_CALL_TABLE:
>   	.tc compat_sys_call_table[TC],compat_sys_call_table
> +#endif

Can we avoid this ifdef ?

>   
>   /* This value is used to mark exception frames on the stack. */
>   exception_marker:
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 60436432399f..ffd045e9fb57 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -277,14 +277,15 @@ static void do_signal(struct task_struct *tsk)
>   
>   	rseq_signal_deliver(&ksig, tsk->thread.regs);
>   
> +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)
>   	if (is32) {
>           	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>   			ret = handle_rt_signal32(&ksig, oldset, tsk);
>   		else
>   			ret = handle_signal32(&ksig, oldset, tsk);
> -	} else {
> +	} else

" if only one branch of a conditional statement is a single statement 
[...] use braces in both branches"

Ref 
https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces

> +#endif /* 32bit */

Having an #ifdef in a middle of a if/else is gross.

Check what are the possible values for is32. It will be always true 
which CONFIG_PPC32.
If you can make sure it is always false without CONFIG_COMPAT, you are 
done. If not, then combine the if(is32) with something involving 
IS_ENABLED(CONFIG_COMPAT).

>   		ret = handle_rt_signal64(&ksig, oldset, tsk);
> -	}
>   
>   	tsk->thread.regs->trap = 0;
>   	signal_setup_done(ret, &ksig, test_thread_flag(TIF_SINGLESTEP));
> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> index 98ed970796d5..3f48262b512d 100644
> --- a/arch/powerpc/kernel/syscall_64.c
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -100,6 +100,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
>   	/* May be faster to do array_index_nospec? */
>   	barrier_nospec();
>   
> +#ifdef CONFIG_COMPAT
>   	if (unlikely(ti_flags & _TIF_32BIT)) {
>   		f = (void *)compat_sys_call_table[r0];

Don't opt out compat_sys_call_table[] declaration in .h file, and use:

	if (IS_ENABLED(CONFIG_COMPAT) && unlikely(ti_flags & _TIF_32BIT)) {

>   
> @@ -110,9 +111,9 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
>   		r7 &= 0x00000000ffffffffULL;
>   		r8 &= 0x00000000ffffffffULL;
>   
> -	} else {
> +	} else
> +#endif /* CONFIG_COMPAT */

Same comment above braces and #ifdefs in the middle of an if/else

>   		f = (void *)sys_call_table[r0];
> -	}
>   
>   	return f(r3, r4, r5, r6, r7, r8);
>   }
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index d60598113a9f..a991b5d69010 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -667,7 +667,7 @@ static void __init vdso_setup_syscall_map(void)
>   {
>   	unsigned int i;
>   	extern unsigned long *sys_call_table;
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT

It should be possible to get rid of that #ifdef completely.

>   	extern unsigned long *compat_sys_call_table;
>   #endif
>   	extern unsigned long sys_ni_syscall;
> @@ -678,9 +678,11 @@ static void __init vdso_setup_syscall_map(void)
>   		if (sys_call_table[i] != sys_ni_syscall)
>   			vdso_data->syscall_map_64[i >> 5] |=
>   				0x80000000UL >> (i & 0x1f);
> +#ifdef CONFIG_COMPAT

Use if (IS_ENABLED(CONFIG_COMPAT && compat_sys_call_table[i] != 
sys_ni_syscall)

>   		if (compat_sys_call_table[i] != sys_ni_syscall)
>   			vdso_data->syscall_map_32[i >> 5] |=
>   				0x80000000UL >> (i & 0x1f);
> +#endif /* CONFIG_COMPAT */
>   #else /* CONFIG_PPC64 */
>   		if (sys_call_table[i] != sys_ni_syscall)
>   			vdso_data->syscall_map_32[i >> 5] |=
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index c84bbd4298a0..b3dacc8bc98d 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -15,7 +15,7 @@
>   #include <asm/sigcontext.h>
>   #include <asm/ucontext.h>
>   #include <asm/vdso.h>
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT
>   #include "../kernel/ppc32.h"
>   #endif
>   #include <asm/pte-walk.h>
> @@ -165,6 +165,7 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
>   	return read_user_stack_slow(ptr, ret, 8);
>   }
>   
> +#ifdef CONFIG_COMPAT

Unneeded #ifdef

>   static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>   {
>   	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> @@ -180,6 +181,7 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
>   
>   	return read_user_stack_slow(ptr, ret, 4);
>   }
> +#endif
>   
>   static inline int valid_user_sp(unsigned long sp, int is_64)
>   {
> @@ -341,6 +343,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
>   
>   #endif /* CONFIG_PPC64 */
>   
> +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)

You don't need to opt that out.

>   /*
>    * Layout for non-RT signal frames
>    */
> @@ -482,12 +485,15 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>   		sp = next_sp;
>   	}
>   }
> +#endif /* 32bit */
>   
>   void
>   perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)
>   {
> -	if (current_is_64bit())
> -		perf_callchain_user_64(entry, regs);
> -	else
> +#if !defined(CONFIG_PPC64) || defined(CONFIG_COMPAT)
> +	if (!current_is_64bit())
>   		perf_callchain_user_32(entry, regs);
> +	else
> +#endif
> +		perf_callchain_user_64(entry, regs);

Please rewrite using  IS_ENABLED() instead of #ifdefs.

Christophe

