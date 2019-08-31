Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07253A4489
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 15:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfHaNCa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 09:02:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:37216 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfHaNCa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 09:02:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA634B023;
        Sat, 31 Aug 2019 13:02:25 +0000 (UTC)
Date:   Sat, 31 Aug 2019 15:02:18 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>,
        Michael Neuling <mikey@neuling.org>,
        Diana Craciun <diana.craciun@nxp.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 4/6] powerpc/64: make buildable without CONFIG_COMPAT
Message-ID: <20190831150218.0d7cb7d3@naga>
In-Reply-To: <ad58f65b5ebaf9f3eb257ebd3e00ddd8eef273d1.1567198491.git.msuchanek@suse.de>
References: <cover.1567198491.git.msuchanek@suse.de>
        <ad58f65b5ebaf9f3eb257ebd3e00ddd8eef273d1.1567198491.git.msuchanek@suse.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Aug 2019 23:03:41 +0200
Michal Suchanek <msuchanek@suse.de> wrote:

> There are numerous references to 32bit functions in generic and 64bit
> code so ifdef them out.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2:
> - fix 32bit ifdef condition in signal.c
> - simplify the compat ifdef condition in vdso.c - 64bit is redundant
> - simplify the compat ifdef condition in callchain.c - 64bit is redundant
> v3:
> - use IS_ENABLED and maybe_unused where possible
> - do not ifdef declarations
> - clean up Makefile
> v4:
> - further makefile cleanup
> - simplify is_32bit_task conditions
> - avoid ifdef in condition by using return
> v5:
> - avoid unreachable code on 32bit
> - make is_current_64bit constant on !COMPAT
> - add stub perf_callchain_user_32 to avoid some ifdefs
> v6:
> - consolidate current_is_64bit
> v7:
> - remove leftover perf_callchain_user_32 stub from previous series version

removed too much stuff here

> ---
>  arch/powerpc/include/asm/thread_info.h |  4 ++--
>  arch/powerpc/kernel/Makefile           |  7 +++---
>  arch/powerpc/kernel/entry_64.S         |  2 ++
>  arch/powerpc/kernel/signal.c           |  3 +--
>  arch/powerpc/kernel/syscall_64.c       |  6 ++---
>  arch/powerpc/kernel/vdso.c             |  5 ++---
>  arch/powerpc/perf/callchain.c          | 31 +++++++++++++-------------
>  7 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 8e1d0195ac36..c128d8a48ea3 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -144,10 +144,10 @@ static inline bool test_thread_local_flags(unsigned int flags)
>  	return (ti->local_flags & flags) != 0;
>  }
>  
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT
>  #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
>  #else
> -#define is_32bit_task()	(1)
> +#define is_32bit_task()	(IS_ENABLED(CONFIG_PPC32))
>  #endif
>  
>  #if defined(CONFIG_PPC64)
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 1d646a94d96c..9d8772e863b9 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -44,16 +44,15 @@ CFLAGS_btext.o += -DDISABLE_BRANCH_PROFILING
>  endif
>  
>  obj-y				:= cputable.o ptrace.o syscalls.o \
> -				   irq.o align.o signal_32.o pmc.o vdso.o \
> +				   irq.o align.o signal_$(BITS).o pmc.o vdso.o \
>  				   process.o systbl.o idle.o \
>  				   signal.o sysfs.o cacheinfo.o time.o \
>  				   prom.o traps.o setup-common.o \
>  				   udbg.o misc.o io.o misc_$(BITS).o \
>  				   of_platform.o prom_parse.o
> -obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
> -				   signal_64.o ptrace32.o \
> -				   paca.o nvram_64.o firmware.o \
> +obj-$(CONFIG_PPC64)		+= setup_64.o paca.o nvram_64.o firmware.o \
>  				   syscall_64.o
> +obj-$(CONFIG_COMPAT)		+= sys_ppc32.o ptrace32.o signal_32.o
>  obj-$(CONFIG_VDSO32)		+= vdso32/
>  obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 2ec825a85f5b..a2dbf216f607 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -51,8 +51,10 @@
>  SYS_CALL_TABLE:
>  	.tc sys_call_table[TC],sys_call_table
>  
> +#ifdef CONFIG_COMPAT
>  COMPAT_SYS_CALL_TABLE:
>  	.tc compat_sys_call_table[TC],compat_sys_call_table
> +#endif
>  
>  /* This value is used to mark exception frames on the stack. */
>  exception_marker:
> diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
> index 60436432399f..61678cb0e6a1 100644
> --- a/arch/powerpc/kernel/signal.c
> +++ b/arch/powerpc/kernel/signal.c
> @@ -247,7 +247,6 @@ static void do_signal(struct task_struct *tsk)
>  	sigset_t *oldset = sigmask_to_save();
>  	struct ksignal ksig = { .sig = 0 };
>  	int ret;
> -	int is32 = is_32bit_task();
>  
>  	BUG_ON(tsk != current);
>  
> @@ -277,7 +276,7 @@ static void do_signal(struct task_struct *tsk)
>  
>  	rseq_signal_deliver(&ksig, tsk->thread.regs);
>  
> -	if (is32) {
> +	if (is_32bit_task()) {
>          	if (ksig.ka.sa.sa_flags & SA_SIGINFO)
>  			ret = handle_rt_signal32(&ksig, oldset, tsk);
>  		else
> diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
> index 98ed970796d5..0d5cbbe54cf1 100644
> --- a/arch/powerpc/kernel/syscall_64.c
> +++ b/arch/powerpc/kernel/syscall_64.c
> @@ -38,7 +38,6 @@ typedef long (*syscall_fn)(long, long, long, long, long, long);
>  
>  long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8, unsigned long r0, struct pt_regs *regs)
>  {
> -	unsigned long ti_flags;
>  	syscall_fn f;
>  
>  	BUG_ON(!(regs->msr & MSR_PR));
> @@ -83,8 +82,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
>  	 */
>  	regs->softe = IRQS_ENABLED;
>  
> -	ti_flags = current_thread_info()->flags;
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(current_thread_info()->flags & _TIF_SYSCALL_DOTRACE)) {
>  		/*
>  		 * We use the return value of do_syscall_trace_enter() as the
>  		 * syscall number. If the syscall was rejected for any reason
> @@ -100,7 +98,7 @@ long system_call_exception(long r3, long r4, long r5, long r6, long r7, long r8,
>  	/* May be faster to do array_index_nospec? */
>  	barrier_nospec();
>  
> -	if (unlikely(ti_flags & _TIF_32BIT)) {
> +	if (unlikely(is_32bit_task())) {
>  		f = (void *)compat_sys_call_table[r0];
>  
>  		r3 &= 0x00000000ffffffffULL;
> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
> index d60598113a9f..6d4a077f74d6 100644
> --- a/arch/powerpc/kernel/vdso.c
> +++ b/arch/powerpc/kernel/vdso.c
> @@ -667,9 +667,7 @@ static void __init vdso_setup_syscall_map(void)
>  {
>  	unsigned int i;
>  	extern unsigned long *sys_call_table;
> -#ifdef CONFIG_PPC64
>  	extern unsigned long *compat_sys_call_table;
> -#endif
>  	extern unsigned long sys_ni_syscall;
>  
>  
> @@ -678,7 +676,8 @@ static void __init vdso_setup_syscall_map(void)
>  		if (sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_64[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
> -		if (compat_sys_call_table[i] != sys_ni_syscall)
> +		if (IS_ENABLED(CONFIG_COMPAT) &&
> +		    compat_sys_call_table[i] != sys_ni_syscall)
>  			vdso_data->syscall_map_32[i >> 5] |=
>  				0x80000000UL >> (i & 0x1f);
>  #else /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index b7cdcce20280..9b8dc822f531 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -15,7 +15,7 @@
>  #include <asm/sigcontext.h>
>  #include <asm/ucontext.h>
>  #include <asm/vdso.h>
> -#ifdef CONFIG_PPC64
> +#ifdef CONFIG_COMPAT
>  #include "../kernel/ppc32.h"
>  #endif
>  #include <asm/pte-walk.h>
> @@ -268,16 +268,6 @@ static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
>  	}
>  }
>  
> -static inline int current_is_64bit(void)
> -{
> -	/*
> -	 * We can't use test_thread_flag() here because we may be on an
> -	 * interrupt stack, and the thread flags don't get copied over
> -	 * from the thread_info on the main stack to the interrupt stack.
> -	 */
> -	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> -}
> -
>  #else  /* CONFIG_PPC64 */
>  static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
>  {
> @@ -314,11 +304,6 @@ static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry
>  {
>  }
>  
> -static inline int current_is_64bit(void)
> -{
> -	return 0;
> -}
> -
>  static inline int valid_user_sp(unsigned long sp, int is_64)
>  {
>  	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> @@ -334,6 +319,7 @@ static inline int valid_user_sp(unsigned long sp, int is_64)
>  
>  #endif /* CONFIG_PPC64 */
>  
> +#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
>  /*
>   * Layout for non-RT signal frames
>   */
> @@ -475,6 +461,19 @@ static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
>  		sp = next_sp;
>  	}
>  }
> +#endif /* 32bit */
> +
> +static inline int current_is_64bit(void)
> +{
> +	if (!IS_ENABLED(CONFIG_COMPAT))
> +		return IS_ENABLED(CONFIG_PPC64);
> +	/*
> +	 * We can't use test_thread_flag() here because we may be on an
> +	 * interrupt stack, and the thread flags don't get copied over
> +	 * from the thread_info on the main stack to the interrupt stack.
> +	 */
> +	return !test_ti_thread_flag(task_thread_info(current), TIF_32BIT);
> +}
>  
>  void
>  perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs)

