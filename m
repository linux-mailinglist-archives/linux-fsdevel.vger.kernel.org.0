Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41B18A45D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2019 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfHaSva convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 31 Aug 2019 14:51:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726705AbfHaSva (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 31 Aug 2019 14:51:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8AEC9B0B6;
        Sat, 31 Aug 2019 18:51:25 +0000 (UTC)
Date:   Sat, 31 Aug 2019 20:51:22 +0200
From:   Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Breno Leitao <leitao@debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Stanley <joel@jms.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Diana Craciun <diana.craciun@nxp.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Hildenbrand <david@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] powerpc/perf: split callchain.c by bitness
Message-ID: <20190831205122.1b6c6bff@naga>
In-Reply-To: <6e90d79f122529751aa9726ba26af603b6bfbfcd.1567198492.git.msuchanek@suse.de>
References: <cover.1567198491.git.msuchanek@suse.de>
        <6e90d79f122529751aa9726ba26af603b6bfbfcd.1567198492.git.msuchanek@suse.de>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 30 Aug 2019 23:03:43 +0200
Michal Suchanek <msuchanek@suse.de> wrote:

> Building callchain.c with !COMPAT proved quite ugly with all the
> defines. Splitting out the 32bit and 64bit parts looks better.
> 
> No code change intended.

valid_user_sp is broken in compat. It needs to be ifdefed for the 32bit
case.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v6:
>  - move current_is_64bit consolidetaion to earlier patch
>  - move defines to the top of callchain_32.c
>  - Makefile cleanup
> ---
>  arch/powerpc/perf/Makefile       |   5 +-
>  arch/powerpc/perf/callchain.c    | 365 +------------------------------
>  arch/powerpc/perf/callchain.h    |  11 +
>  arch/powerpc/perf/callchain_32.c | 204 +++++++++++++++++
>  arch/powerpc/perf/callchain_64.c | 185 ++++++++++++++++
>  5 files changed, 405 insertions(+), 365 deletions(-)
>  create mode 100644 arch/powerpc/perf/callchain.h
>  create mode 100644 arch/powerpc/perf/callchain_32.c
>  create mode 100644 arch/powerpc/perf/callchain_64.c
> 
> diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> index c155dcbb8691..53d614e98537 100644
> --- a/arch/powerpc/perf/Makefile
> +++ b/arch/powerpc/perf/Makefile
> @@ -1,6 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -obj-$(CONFIG_PERF_EVENTS)	+= callchain.o perf_regs.o
> +obj-$(CONFIG_PERF_EVENTS)	+= callchain.o callchain_$(BITS).o perf_regs.o
> +ifdef CONFIG_COMPAT
> +obj-$(CONFIG_PERF_EVENTS)	+= callchain_32.o
> +endif
>  
>  obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o bhrb.o
>  obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
> diff --git a/arch/powerpc/perf/callchain.c b/arch/powerpc/perf/callchain.c
> index 9b8dc822f531..8f30f1b47c78 100644
> --- a/arch/powerpc/perf/callchain.c
> +++ b/arch/powerpc/perf/callchain.c
> @@ -15,11 +15,9 @@
>  #include <asm/sigcontext.h>
>  #include <asm/ucontext.h>
>  #include <asm/vdso.h>
> -#ifdef CONFIG_COMPAT
> -#include "../kernel/ppc32.h"
> -#endif
>  #include <asm/pte-walk.h>
>  
> +#include "callchain.h"
>  
>  /*
>   * Is sp valid as the address of the next kernel stack frame after prev_sp?
> @@ -102,367 +100,6 @@ perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *re
>  	}
>  }
>  
> -#ifdef CONFIG_PPC64
> -/*
> - * On 64-bit we don't want to invoke hash_page on user addresses from
> - * interrupt context, so if the access faults, we read the page tables
> - * to find which page (if any) is mapped and access it directly.
> - */
> -static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> -{
> -	int ret = -EFAULT;
> -	pgd_t *pgdir;
> -	pte_t *ptep, pte;
> -	unsigned shift;
> -	unsigned long addr = (unsigned long) ptr;
> -	unsigned long offset;
> -	unsigned long pfn, flags;
> -	void *kaddr;
> -
> -	pgdir = current->mm->pgd;
> -	if (!pgdir)
> -		return -EFAULT;
> -
> -	local_irq_save(flags);
> -	ptep = find_current_mm_pte(pgdir, addr, NULL, &shift);
> -	if (!ptep)
> -		goto err_out;
> -	if (!shift)
> -		shift = PAGE_SHIFT;
> -
> -	/* align address to page boundary */
> -	offset = addr & ((1UL << shift) - 1);
> -
> -	pte = READ_ONCE(*ptep);
> -	if (!pte_present(pte) || !pte_user(pte))
> -		goto err_out;
> -	pfn = pte_pfn(pte);
> -	if (!page_is_ram(pfn))
> -		goto err_out;
> -
> -	/* no highmem to worry about here */
> -	kaddr = pfn_to_kaddr(pfn);
> -	memcpy(buf, kaddr + offset, nb);
> -	ret = 0;
> -err_out:
> -	local_irq_restore(flags);
> -	return ret;
> -}
> -
> -static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
> -{
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
> -	    ((unsigned long)ptr & 7))
> -		return -EFAULT;
> -
> -	pagefault_disable();
> -	if (!__get_user_inatomic(*ret, ptr)) {
> -		pagefault_enable();
> -		return 0;
> -	}
> -	pagefault_enable();
> -
> -	return read_user_stack_slow(ptr, ret, 8);
> -}
> -
> -static inline int valid_user_sp(unsigned long sp, int is_64)
> -{
> -	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
> -		return 0;
> -	return 1;
> -}
> -
> -/*
> - * 64-bit user processes use the same stack frame for RT and non-RT signals.
> - */
> -struct signal_frame_64 {
> -	char		dummy[__SIGNAL_FRAMESIZE];
> -	struct ucontext	uc;
> -	unsigned long	unused[2];
> -	unsigned int	tramp[6];
> -	struct siginfo	*pinfo;
> -	void		*puc;
> -	struct siginfo	info;
> -	char		abigap[288];
> -};
> -
> -static int is_sigreturn_64_address(unsigned long nip, unsigned long fp)
> -{
> -	if (nip == fp + offsetof(struct signal_frame_64, tramp))
> -		return 1;
> -	if (vdso64_rt_sigtramp && current->mm->context.vdso_base &&
> -	    nip == current->mm->context.vdso_base + vdso64_rt_sigtramp)
> -		return 1;
> -	return 0;
> -}
> -
> -/*
> - * Do some sanity checking on the signal frame pointed to by sp.
> - * We check the pinfo and puc pointers in the frame.
> - */
> -static int sane_signal_64_frame(unsigned long sp)
> -{
> -	struct signal_frame_64 __user *sf;
> -	unsigned long pinfo, puc;
> -
> -	sf = (struct signal_frame_64 __user *) sp;
> -	if (read_user_stack_64((unsigned long __user *) &sf->pinfo, &pinfo) ||
> -	    read_user_stack_64((unsigned long __user *) &sf->puc, &puc))
> -		return 0;
> -	return pinfo == (unsigned long) &sf->info &&
> -		puc == (unsigned long) &sf->uc;
> -}
> -
> -static void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> -				   struct pt_regs *regs)
> -{
> -	unsigned long sp, next_sp;
> -	unsigned long next_ip;
> -	unsigned long lr;
> -	long level = 0;
> -	struct signal_frame_64 __user *sigframe;
> -	unsigned long __user *fp, *uregs;
> -
> -	next_ip = perf_instruction_pointer(regs);
> -	lr = regs->link;
> -	sp = regs->gpr[1];
> -	perf_callchain_store(entry, next_ip);
> -
> -	while (entry->nr < entry->max_stack) {
> -		fp = (unsigned long __user *) sp;
> -		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
> -			return;
> -		if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
> -			return;
> -
> -		/*
> -		 * Note: the next_sp - sp >= signal frame size check
> -		 * is true when next_sp < sp, which can happen when
> -		 * transitioning from an alternate signal stack to the
> -		 * normal stack.
> -		 */
> -		if (next_sp - sp >= sizeof(struct signal_frame_64) &&
> -		    (is_sigreturn_64_address(next_ip, sp) ||
> -		     (level <= 1 && is_sigreturn_64_address(lr, sp))) &&
> -		    sane_signal_64_frame(sp)) {
> -			/*
> -			 * This looks like an signal frame
> -			 */
> -			sigframe = (struct signal_frame_64 __user *) sp;
> -			uregs = sigframe->uc.uc_mcontext.gp_regs;
> -			if (read_user_stack_64(&uregs[PT_NIP], &next_ip) ||
> -			    read_user_stack_64(&uregs[PT_LNK], &lr) ||
> -			    read_user_stack_64(&uregs[PT_R1], &sp))
> -				return;
> -			level = 0;
> -			perf_callchain_store_context(entry, PERF_CONTEXT_USER);
> -			perf_callchain_store(entry, next_ip);
> -			continue;
> -		}
> -
> -		if (level == 0)
> -			next_ip = lr;
> -		perf_callchain_store(entry, next_ip);
> -		++level;
> -		sp = next_sp;
> -	}
> -}
> -
> -#else  /* CONFIG_PPC64 */
> -static int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_PPC64 */
> -
> -/*
> - * On 32-bit we just access the address and let hash_page create a
> - * HPTE if necessary, so there is no need to fall back to reading
> - * the page tables.  Since this is called at interrupt level,
> - * do_page_fault() won't treat a DSI as a page fault.
> - */
> -static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> -{
> -	int rc;
> -
> -	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> -	    ((unsigned long)ptr & 3))
> -		return -EFAULT;
> -
> -	pagefault_disable();
> -	rc = __get_user_inatomic(*ret, ptr);
> -	pagefault_enable();
> -
> -	if (IS_ENABLED(CONFIG_PPC64) && rc)
> -		return read_user_stack_slow(ptr, ret, 4);
> -	return rc;
> -}
> -
> -#ifndef CONFIG_PPC64
> -static inline void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> -					  struct pt_regs *regs)
> -{
> -}
> -
> -static inline int valid_user_sp(unsigned long sp, int is_64)
> -{
> -	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> -		return 0;
> -	return 1;
> -}
> -
> -#define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
> -#define sigcontext32		sigcontext
> -#define mcontext32		mcontext
> -#define ucontext32		ucontext
> -#define compat_siginfo_t	struct siginfo
> -
> -#endif /* CONFIG_PPC64 */
> -
> -#if defined(CONFIG_PPC32) || defined(CONFIG_COMPAT)
> -/*
> - * Layout for non-RT signal frames
> - */
> -struct signal_frame_32 {
> -	char			dummy[__SIGNAL_FRAMESIZE32];
> -	struct sigcontext32	sctx;
> -	struct mcontext32	mctx;
> -	int			abigap[56];
> -};
> -
> -/*
> - * Layout for RT signal frames
> - */
> -struct rt_signal_frame_32 {
> -	char			dummy[__SIGNAL_FRAMESIZE32 + 16];
> -	compat_siginfo_t	info;
> -	struct ucontext32	uc;
> -	int			abigap[56];
> -};
> -
> -static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
> -{
> -	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
> -		return 1;
> -	if (vdso32_sigtramp && current->mm->context.vdso_base &&
> -	    nip == current->mm->context.vdso_base + vdso32_sigtramp)
> -		return 1;
> -	return 0;
> -}
> -
> -static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
> -{
> -	if (nip == fp + offsetof(struct rt_signal_frame_32,
> -				 uc.uc_mcontext.mc_pad))
> -		return 1;
> -	if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
> -	    nip == current->mm->context.vdso_base + vdso32_rt_sigtramp)
> -		return 1;
> -	return 0;
> -}
> -
> -static int sane_signal_32_frame(unsigned int sp)
> -{
> -	struct signal_frame_32 __user *sf;
> -	unsigned int regs;
> -
> -	sf = (struct signal_frame_32 __user *) (unsigned long) sp;
> -	if (read_user_stack_32((unsigned int __user *) &sf->sctx.regs, &regs))
> -		return 0;
> -	return regs == (unsigned long) &sf->mctx;
> -}
> -
> -static int sane_rt_signal_32_frame(unsigned int sp)
> -{
> -	struct rt_signal_frame_32 __user *sf;
> -	unsigned int regs;
> -
> -	sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
> -	if (read_user_stack_32((unsigned int __user *) &sf->uc.uc_regs, &regs))
> -		return 0;
> -	return regs == (unsigned long) &sf->uc.uc_mcontext;
> -}
> -
> -static unsigned int __user *signal_frame_32_regs(unsigned int sp,
> -				unsigned int next_sp, unsigned int next_ip)
> -{
> -	struct mcontext32 __user *mctx = NULL;
> -	struct signal_frame_32 __user *sf;
> -	struct rt_signal_frame_32 __user *rt_sf;
> -
> -	/*
> -	 * Note: the next_sp - sp >= signal frame size check
> -	 * is true when next_sp < sp, for example, when
> -	 * transitioning from an alternate signal stack to the
> -	 * normal stack.
> -	 */
> -	if (next_sp - sp >= sizeof(struct signal_frame_32) &&
> -	    is_sigreturn_32_address(next_ip, sp) &&
> -	    sane_signal_32_frame(sp)) {
> -		sf = (struct signal_frame_32 __user *) (unsigned long) sp;
> -		mctx = &sf->mctx;
> -	}
> -
> -	if (!mctx && next_sp - sp >= sizeof(struct rt_signal_frame_32) &&
> -	    is_rt_sigreturn_32_address(next_ip, sp) &&
> -	    sane_rt_signal_32_frame(sp)) {
> -		rt_sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
> -		mctx = &rt_sf->uc.uc_mcontext;
> -	}
> -
> -	if (!mctx)
> -		return NULL;
> -	return mctx->mc_gregs;
> -}
> -
> -static void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> -				   struct pt_regs *regs)
> -{
> -	unsigned int sp, next_sp;
> -	unsigned int next_ip;
> -	unsigned int lr;
> -	long level = 0;
> -	unsigned int __user *fp, *uregs;
> -
> -	next_ip = perf_instruction_pointer(regs);
> -	lr = regs->link;
> -	sp = regs->gpr[1];
> -	perf_callchain_store(entry, next_ip);
> -
> -	while (entry->nr < entry->max_stack) {
> -		fp = (unsigned int __user *) (unsigned long) sp;
> -		if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
> -			return;
> -		if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
> -			return;
> -
> -		uregs = signal_frame_32_regs(sp, next_sp, next_ip);
> -		if (!uregs && level <= 1)
> -			uregs = signal_frame_32_regs(sp, next_sp, lr);
> -		if (uregs) {
> -			/*
> -			 * This looks like an signal frame, so restart
> -			 * the stack trace with the values in it.
> -			 */
> -			if (read_user_stack_32(&uregs[PT_NIP], &next_ip) ||
> -			    read_user_stack_32(&uregs[PT_LNK], &lr) ||
> -			    read_user_stack_32(&uregs[PT_R1], &sp))
> -				return;
> -			level = 0;
> -			perf_callchain_store_context(entry, PERF_CONTEXT_USER);
> -			perf_callchain_store(entry, next_ip);
> -			continue;
> -		}
> -
> -		if (level == 0)
> -			next_ip = lr;
> -		perf_callchain_store(entry, next_ip);
> -		++level;
> -		sp = next_sp;
> -	}
> -}
> -#endif /* 32bit */
> -
>  static inline int current_is_64bit(void)
>  {
>  	if (!IS_ENABLED(CONFIG_COMPAT))
> diff --git a/arch/powerpc/perf/callchain.h b/arch/powerpc/perf/callchain.h
> new file mode 100644
> index 000000000000..63ffb43f3668
> --- /dev/null
> +++ b/arch/powerpc/perf/callchain.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _POWERPC_PERF_CALLCHAIN_H
> +#define _POWERPC_PERF_CALLCHAIN_H
> +
> +int read_user_stack_slow(void __user *ptr, void *buf, int nb);
> +void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> +			    struct pt_regs *regs);
> +void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> +			    struct pt_regs *regs);
> +
> +#endif /* _POWERPC_PERF_CALLCHAIN_H */
> diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
> new file mode 100644
> index 000000000000..01a38d929078
> --- /dev/null
> +++ b/arch/powerpc/perf/callchain_32.c
> @@ -0,0 +1,204 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Performance counter callchain support - powerpc architecture code
> + *
> + * Copyright © 2009 Paul Mackerras, IBM Corporation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/perf_event.h>
> +#include <linux/percpu.h>
> +#include <linux/uaccess.h>
> +#include <linux/mm.h>
> +#include <asm/ptrace.h>
> +#include <asm/pgtable.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ucontext.h>
> +#include <asm/vdso.h>
> +#include <asm/pte-walk.h>
> +
> +#include "callchain.h"
> +
> +#ifdef CONFIG_PPC64
> +#include "../kernel/ppc32.h"
> +#else  /* CONFIG_PPC64 */
> +
> +#define __SIGNAL_FRAMESIZE32	__SIGNAL_FRAMESIZE
> +#define sigcontext32		sigcontext
> +#define mcontext32		mcontext
> +#define ucontext32		ucontext
> +#define compat_siginfo_t	struct siginfo
> +
> +#endif /* CONFIG_PPC64 */
> +
> +/*
> + * On 32-bit we just access the address and let hash_page create a
> + * HPTE if necessary, so there is no need to fall back to reading
> + * the page tables.  Since this is called at interrupt level,
> + * do_page_fault() won't treat a DSI as a page fault.
> + */
> +static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
> +{
> +	int rc;
> +
> +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned int) ||
> +	    ((unsigned long)ptr & 3))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	rc = __get_user_inatomic(*ret, ptr);
> +	pagefault_enable();
> +
> +	if (IS_ENABLED(CONFIG_PPC64) && rc)
> +		return read_user_stack_slow(ptr, ret, 4);
> +	return rc;
> +}
> +
> +static inline int valid_user_sp(unsigned long sp, int is_64)
> +{
> +	if (!sp || (sp & 7) || sp > TASK_SIZE - 32)
> +		return 0;
> +	return 1;
> +}
> +
> +/*
> + * Layout for non-RT signal frames
> + */
> +struct signal_frame_32 {
> +	char			dummy[__SIGNAL_FRAMESIZE32];
> +	struct sigcontext32	sctx;
> +	struct mcontext32	mctx;
> +	int			abigap[56];
> +};
> +
> +/*
> + * Layout for RT signal frames
> + */
> +struct rt_signal_frame_32 {
> +	char			dummy[__SIGNAL_FRAMESIZE32 + 16];
> +	compat_siginfo_t	info;
> +	struct ucontext32	uc;
> +	int			abigap[56];
> +};
> +
> +static int is_sigreturn_32_address(unsigned int nip, unsigned int fp)
> +{
> +	if (nip == fp + offsetof(struct signal_frame_32, mctx.mc_pad))
> +		return 1;
> +	if (vdso32_sigtramp && current->mm->context.vdso_base &&
> +	    nip == current->mm->context.vdso_base + vdso32_sigtramp)
> +		return 1;
> +	return 0;
> +}
> +
> +static int is_rt_sigreturn_32_address(unsigned int nip, unsigned int fp)
> +{
> +	if (nip == fp + offsetof(struct rt_signal_frame_32,
> +				 uc.uc_mcontext.mc_pad))
> +		return 1;
> +	if (vdso32_rt_sigtramp && current->mm->context.vdso_base &&
> +	    nip == current->mm->context.vdso_base + vdso32_rt_sigtramp)
> +		return 1;
> +	return 0;
> +}
> +
> +static int sane_signal_32_frame(unsigned int sp)
> +{
> +	struct signal_frame_32 __user *sf;
> +	unsigned int regs;
> +
> +	sf = (struct signal_frame_32 __user *) (unsigned long) sp;
> +	if (read_user_stack_32((unsigned int __user *) &sf->sctx.regs, &regs))
> +		return 0;
> +	return regs == (unsigned long) &sf->mctx;
> +}
> +
> +static int sane_rt_signal_32_frame(unsigned int sp)
> +{
> +	struct rt_signal_frame_32 __user *sf;
> +	unsigned int regs;
> +
> +	sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
> +	if (read_user_stack_32((unsigned int __user *) &sf->uc.uc_regs, &regs))
> +		return 0;
> +	return regs == (unsigned long) &sf->uc.uc_mcontext;
> +}
> +
> +static unsigned int __user *signal_frame_32_regs(unsigned int sp,
> +				unsigned int next_sp, unsigned int next_ip)
> +{
> +	struct mcontext32 __user *mctx = NULL;
> +	struct signal_frame_32 __user *sf;
> +	struct rt_signal_frame_32 __user *rt_sf;
> +
> +	/*
> +	 * Note: the next_sp - sp >= signal frame size check
> +	 * is true when next_sp < sp, for example, when
> +	 * transitioning from an alternate signal stack to the
> +	 * normal stack.
> +	 */
> +	if (next_sp - sp >= sizeof(struct signal_frame_32) &&
> +	    is_sigreturn_32_address(next_ip, sp) &&
> +	    sane_signal_32_frame(sp)) {
> +		sf = (struct signal_frame_32 __user *) (unsigned long) sp;
> +		mctx = &sf->mctx;
> +	}
> +
> +	if (!mctx && next_sp - sp >= sizeof(struct rt_signal_frame_32) &&
> +	    is_rt_sigreturn_32_address(next_ip, sp) &&
> +	    sane_rt_signal_32_frame(sp)) {
> +		rt_sf = (struct rt_signal_frame_32 __user *) (unsigned long) sp;
> +		mctx = &rt_sf->uc.uc_mcontext;
> +	}
> +
> +	if (!mctx)
> +		return NULL;
> +	return mctx->mc_gregs;
> +}
> +
> +void perf_callchain_user_32(struct perf_callchain_entry_ctx *entry,
> +			    struct pt_regs *regs)
> +{
> +	unsigned int sp, next_sp;
> +	unsigned int next_ip;
> +	unsigned int lr;
> +	long level = 0;
> +	unsigned int __user *fp, *uregs;
> +
> +	next_ip = perf_instruction_pointer(regs);
> +	lr = regs->link;
> +	sp = regs->gpr[1];
> +	perf_callchain_store(entry, next_ip);
> +
> +	while (entry->nr < entry->max_stack) {
> +		fp = (unsigned int __user *) (unsigned long) sp;
> +		if (!valid_user_sp(sp, 0) || read_user_stack_32(fp, &next_sp))
> +			return;
> +		if (level > 0 && read_user_stack_32(&fp[1], &next_ip))
> +			return;
> +
> +		uregs = signal_frame_32_regs(sp, next_sp, next_ip);
> +		if (!uregs && level <= 1)
> +			uregs = signal_frame_32_regs(sp, next_sp, lr);
> +		if (uregs) {
> +			/*
> +			 * This looks like an signal frame, so restart
> +			 * the stack trace with the values in it.
> +			 */
> +			if (read_user_stack_32(&uregs[PT_NIP], &next_ip) ||
> +			    read_user_stack_32(&uregs[PT_LNK], &lr) ||
> +			    read_user_stack_32(&uregs[PT_R1], &sp))
> +				return;
> +			level = 0;
> +			perf_callchain_store_context(entry, PERF_CONTEXT_USER);
> +			perf_callchain_store(entry, next_ip);
> +			continue;
> +		}
> +
> +		if (level == 0)
> +			next_ip = lr;
> +		perf_callchain_store(entry, next_ip);
> +		++level;
> +		sp = next_sp;
> +	}
> +}
> diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
> new file mode 100644
> index 000000000000..60308c2221a8
> --- /dev/null
> +++ b/arch/powerpc/perf/callchain_64.c
> @@ -0,0 +1,185 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Performance counter callchain support - powerpc architecture code
> + *
> + * Copyright © 2009 Paul Mackerras, IBM Corporation.
> + */
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/perf_event.h>
> +#include <linux/percpu.h>
> +#include <linux/uaccess.h>
> +#include <linux/mm.h>
> +#include <asm/ptrace.h>
> +#include <asm/pgtable.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ucontext.h>
> +#include <asm/vdso.h>
> +#include <asm/pte-walk.h>
> +
> +#include "callchain.h"
> +
> +/*
> + * On 64-bit we don't want to invoke hash_page on user addresses from
> + * interrupt context, so if the access faults, we read the page tables
> + * to find which page (if any) is mapped and access it directly.
> + */
> +int read_user_stack_slow(void __user *ptr, void *buf, int nb)
> +{
> +	int ret = -EFAULT;
> +	pgd_t *pgdir;
> +	pte_t *ptep, pte;
> +	unsigned int shift;
> +	unsigned long addr = (unsigned long) ptr;
> +	unsigned long offset;
> +	unsigned long pfn, flags;
> +	void *kaddr;
> +
> +	pgdir = current->mm->pgd;
> +	if (!pgdir)
> +		return -EFAULT;
> +
> +	local_irq_save(flags);
> +	ptep = find_current_mm_pte(pgdir, addr, NULL, &shift);
> +	if (!ptep)
> +		goto err_out;
> +	if (!shift)
> +		shift = PAGE_SHIFT;
> +
> +	/* align address to page boundary */
> +	offset = addr & ((1UL << shift) - 1);
> +
> +	pte = READ_ONCE(*ptep);
> +	if (!pte_present(pte) || !pte_user(pte))
> +		goto err_out;
> +	pfn = pte_pfn(pte);
> +	if (!page_is_ram(pfn))
> +		goto err_out;
> +
> +	/* no highmem to worry about here */
> +	kaddr = pfn_to_kaddr(pfn);
> +	memcpy(buf, kaddr + offset, nb);
> +	ret = 0;
> +err_out:
> +	local_irq_restore(flags);
> +	return ret;
> +}
> +
> +static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
> +{
> +	if ((unsigned long)ptr > TASK_SIZE - sizeof(unsigned long) ||
> +	    ((unsigned long)ptr & 7))
> +		return -EFAULT;
> +
> +	pagefault_disable();
> +	if (!__get_user_inatomic(*ret, ptr)) {
> +		pagefault_enable();
> +		return 0;
> +	}
> +	pagefault_enable();
> +
> +	return read_user_stack_slow(ptr, ret, 8);
> +}
> +
> +static inline int valid_user_sp(unsigned long sp, int is_64)
> +{
> +	if (!sp || (sp & 7) || sp > (is_64 ? TASK_SIZE : 0x100000000UL) - 32)
> +		return 0;
> +	return 1;
> +}
> +
> +/*
> + * 64-bit user processes use the same stack frame for RT and non-RT signals.
> + */
> +struct signal_frame_64 {
> +	char		dummy[__SIGNAL_FRAMESIZE];
> +	struct ucontext	uc;
> +	unsigned long	unused[2];
> +	unsigned int	tramp[6];
> +	struct siginfo	*pinfo;
> +	void		*puc;
> +	struct siginfo	info;
> +	char		abigap[288];
> +};
> +
> +static int is_sigreturn_64_address(unsigned long nip, unsigned long fp)
> +{
> +	if (nip == fp + offsetof(struct signal_frame_64, tramp))
> +		return 1;
> +	if (vdso64_rt_sigtramp && current->mm->context.vdso_base &&
> +	    nip == current->mm->context.vdso_base + vdso64_rt_sigtramp)
> +		return 1;
> +	return 0;
> +}
> +
> +/*
> + * Do some sanity checking on the signal frame pointed to by sp.
> + * We check the pinfo and puc pointers in the frame.
> + */
> +static int sane_signal_64_frame(unsigned long sp)
> +{
> +	struct signal_frame_64 __user *sf;
> +	unsigned long pinfo, puc;
> +
> +	sf = (struct signal_frame_64 __user *) sp;
> +	if (read_user_stack_64((unsigned long __user *) &sf->pinfo, &pinfo) ||
> +	    read_user_stack_64((unsigned long __user *) &sf->puc, &puc))
> +		return 0;
> +	return pinfo == (unsigned long) &sf->info &&
> +		puc == (unsigned long) &sf->uc;
> +}
> +
> +void perf_callchain_user_64(struct perf_callchain_entry_ctx *entry,
> +			    struct pt_regs *regs)
> +{
> +	unsigned long sp, next_sp;
> +	unsigned long next_ip;
> +	unsigned long lr;
> +	long level = 0;
> +	struct signal_frame_64 __user *sigframe;
> +	unsigned long __user *fp, *uregs;
> +
> +	next_ip = perf_instruction_pointer(regs);
> +	lr = regs->link;
> +	sp = regs->gpr[1];
> +	perf_callchain_store(entry, next_ip);
> +
> +	while (entry->nr < entry->max_stack) {
> +		fp = (unsigned long __user *) sp;
> +		if (!valid_user_sp(sp, 1) || read_user_stack_64(fp, &next_sp))
> +			return;
> +		if (level > 0 && read_user_stack_64(&fp[2], &next_ip))
> +			return;
> +
> +		/*
> +		 * Note: the next_sp - sp >= signal frame size check
> +		 * is true when next_sp < sp, which can happen when
> +		 * transitioning from an alternate signal stack to the
> +		 * normal stack.
> +		 */
> +		if (next_sp - sp >= sizeof(struct signal_frame_64) &&
> +		    (is_sigreturn_64_address(next_ip, sp) ||
> +		     (level <= 1 && is_sigreturn_64_address(lr, sp))) &&
> +		    sane_signal_64_frame(sp)) {
> +			/*
> +			 * This looks like an signal frame
> +			 */
> +			sigframe = (struct signal_frame_64 __user *) sp;
> +			uregs = sigframe->uc.uc_mcontext.gp_regs;
> +			if (read_user_stack_64(&uregs[PT_NIP], &next_ip) ||
> +			    read_user_stack_64(&uregs[PT_LNK], &lr) ||
> +			    read_user_stack_64(&uregs[PT_R1], &sp))
> +				return;
> +			level = 0;
> +			perf_callchain_store_context(entry, PERF_CONTEXT_USER);
> +			perf_callchain_store(entry, next_ip);
> +			continue;
> +		}
> +
> +		if (level == 0)
> +			next_ip = lr;
> +		perf_callchain_store(entry, next_ip);
> +		++level;
> +		sp = next_sp;
> +	}
> +}

