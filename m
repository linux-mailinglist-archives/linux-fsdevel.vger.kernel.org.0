Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D382E5E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfE2UMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:12:44 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34722 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfE2UMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:12:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so2358860pfa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vtTPUOYXY5m0og1DQAYrqLBzmvmQTdaSbXXOGkCnX6o=;
        b=izbZjIiWQ/Fv+WJjP0wMfQyIRynGOeA9yHGwPdpR+4dMfnlaOa+dgNEd4aH312MAjZ
         yJ/Qg2ba0BERrllHazRza8HCzJl+Yano/A/AxV+iSxxaRczv4GSf15ykGnmVxhSaqQXJ
         KI6O1c8xPunR6Hc1q6mMiS6EKhlrE6pHuf7so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vtTPUOYXY5m0og1DQAYrqLBzmvmQTdaSbXXOGkCnX6o=;
        b=cYf+BmwJw7LuozWETVYHpNEqOX4REr2nxmP7BCdzgf/jkKU8Pf8/p8YruafvxInZLS
         R4Cj2PLjRI6civTo1H2MTCmf5lvodvUWJdGwICm48CVog/JNucRAZIO6q6HhSJFTkQE3
         64d1zOz4Gu9oiZkn39tt4y6NYfTT5uMsiGeCyf5wL3KlyPmpDEV4/Qzf1n9SD8WSAwdh
         NgoLdClyQksOtKkE1j3aILhImKjolCG8XBSrBxpuPpE0zRfvLoI3XNbkUiH4lDFlp0vM
         iYjlZpCvvfVgmG/8a6ySNRFBTE+5JdlnpXNkEvMIGyuhoVN1G9JKc1dehjWdRNDazTci
         vzTA==
X-Gm-Message-State: APjAAAXHYQl0s2kEw2HP04EpYPzVF0T+emfMvfyskVdy2adHFflD+Z80
        aMPEa25hEC48o1+0A2mHWKBN2g==
X-Google-Smtp-Source: APXvYqwSS4yekoOSF9l1S+1nXL3eNKPkVkTIYLpbKGbaMM40b95uuvY6kdgpWvWD6BW1Ys75eZ2ZkA==
X-Received: by 2002:a63:2b8a:: with SMTP id r132mr30768540pgr.196.1559160763943;
        Wed, 29 May 2019 13:12:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q28sm522752pfn.106.2019.05.29.13.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:12:43 -0700 (PDT)
Date:   Wed, 29 May 2019 13:12:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 13/14] mips: Use generic mmap top-down layout and brk
 randomization
Message-ID: <201905291312.A4D2DEE4@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-14-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-14-alex@ghiti.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:45AM -0400, Alexandre Ghiti wrote:
> mips uses a top-down layout by default that exactly fits the generic
> functions, so get rid of arch specific code and use the generic version
> by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
> As ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT selects ARCH_HAS_ELF_RANDOMIZE,
> use the generic version of arch_randomize_brk since it also fits.
> Note that this commit also removes the possibility for mips to have elf
> randomization and no MMU: without MMU, the security added by randomization
> is worth nothing.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/Kconfig                 |  2 +-
>  arch/mips/include/asm/processor.h |  5 --
>  arch/mips/mm/mmap.c               | 96 -------------------------------
>  3 files changed, 1 insertion(+), 102 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 70d3200476bf..da15b02bbe23 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -5,7 +5,6 @@ config MIPS
>  	select ARCH_32BIT_OFF_T if !64BIT
>  	select ARCH_BINFMT_ELF_STATE if MIPS_FP_SUPPORT
>  	select ARCH_CLOCKSOURCE_DATA
> -	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_SUPPORTS_UPROBES
> @@ -13,6 +12,7 @@ config MIPS
>  	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_USE_QUEUED_SPINLOCKS
> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select BUILDTIME_EXTABLE_SORT
>  	select CLONE_BACKWARDS
> diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/processor.h
> index aca909bd7841..fba18d4a9190 100644
> --- a/arch/mips/include/asm/processor.h
> +++ b/arch/mips/include/asm/processor.h
> @@ -29,11 +29,6 @@
>  
>  extern unsigned int vced_count, vcei_count;
>  
> -/*
> - * MIPS does have an arch_pick_mmap_layout()
> - */
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT 1
> -
>  #ifdef CONFIG_32BIT
>  #ifdef CONFIG_KVM_GUEST
>  /* User space process size is limited to 1GB in KVM Guest Mode */
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index 900670ea8531..c2effe535484 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -16,49 +16,10 @@
>  #include <linux/random.h>
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
> -#include <linux/sizes.h>
> -#include <linux/compat.h>
>  
>  unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
>  
> -/* gap between mmap and stack */
> -#define MIN_GAP		(128*1024*1024UL)
> -#define MAX_GAP		((STACK_TOP)/6*5)
> -#define STACK_RND_MASK	(0x7ff >> (PAGE_SHIFT - 12))
> -
> -static int mmap_is_legacy(struct rlimit *rlim_stack)
> -{
> -	if (current->personality & ADDR_COMPAT_LAYOUT)
> -		return 1;
> -
> -	if (rlim_stack->rlim_cur == RLIM_INFINITY)
> -		return 1;
> -
> -	return sysctl_legacy_va_layout;
> -}
> -
> -static unsigned long mmap_base(unsigned long rnd, struct rlimit *rlim_stack)
> -{
> -	unsigned long gap = rlim_stack->rlim_cur;
> -	unsigned long pad = stack_guard_gap;
> -
> -	/* Account for stack randomization if necessary */
> -	if (current->flags & PF_RANDOMIZE)
> -		pad += (STACK_RND_MASK << PAGE_SHIFT);
> -
> -	/* Values close to RLIM_INFINITY can overflow. */
> -	if (gap + pad > gap)
> -		gap += pad;
> -
> -	if (gap < MIN_GAP)
> -		gap = MIN_GAP;
> -	else if (gap > MAX_GAP)
> -		gap = MAX_GAP;
> -
> -	return PAGE_ALIGN(STACK_TOP - gap - rnd);
> -}
> -
>  #define COLOUR_ALIGN(addr, pgoff)				\
>  	((((addr) + shm_align_mask) & ~shm_align_mask) +	\
>  	 (((pgoff) << PAGE_SHIFT) & shm_align_mask))
> @@ -156,63 +117,6 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>  			addr0, len, pgoff, flags, DOWN);
>  }
>  
> -unsigned long arch_mmap_rnd(void)
> -{
> -	unsigned long rnd;
> -
> -#ifdef CONFIG_COMPAT
> -	if (TASK_IS_32BIT_ADDR)
> -		rnd = get_random_long() & ((1UL << mmap_rnd_compat_bits) - 1);
> -	else
> -#endif /* CONFIG_COMPAT */
> -		rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
> -
> -	return rnd << PAGE_SHIFT;
> -}
> -
> -void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
> -{
> -	unsigned long random_factor = 0UL;
> -
> -	if (current->flags & PF_RANDOMIZE)
> -		random_factor = arch_mmap_rnd();
> -
> -	if (mmap_is_legacy(rlim_stack)) {
> -		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
> -		mm->get_unmapped_area = arch_get_unmapped_area;
> -	} else {
> -		mm->mmap_base = mmap_base(random_factor, rlim_stack);
> -		mm->get_unmapped_area = arch_get_unmapped_area_topdown;
> -	}
> -}
> -
> -static inline unsigned long brk_rnd(void)
> -{
> -	unsigned long rnd = get_random_long();
> -
> -	rnd = rnd << PAGE_SHIFT;
> -	/* 32MB for 32bit, 1GB for 64bit */
> -	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
> -		rnd = rnd & SZ_32M;
> -	else
> -		rnd = rnd & SZ_1G;
> -
> -	return rnd;
> -}
> -
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -	unsigned long base = mm->brk;
> -	unsigned long ret;
> -
> -	ret = PAGE_ALIGN(base + brk_rnd());
> -
> -	if (ret < mm->brk)
> -		return mm->brk;
> -
> -	return ret;
> -}
> -
>  int __virt_addr_valid(const volatile void *kaddr)
>  {
>  	return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
> -- 
> 2.20.1
> 

-- 
Kees Cook
