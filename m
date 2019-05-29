Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B60AC2E53D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 21:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2T0O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 15:26:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38513 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2T0O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 15:26:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id a186so1569834pfa.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 12:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MqvScE+mpTeungkeSlvv3Q/uzBYTV0O7Qr5Vox35/hw=;
        b=Buw3FXSp4ANIXhiVaYcFq7ueT4hHfJzssIhWbmrncc4YnHk0oVg8OvJ0WvauqQALhB
         sBghG+54cb3Hrx24CLKE7D0oxQLoKUXTBDFyYSm5aD1WKGg3/759D66vG6dvvqaZZSbX
         RMrPVBwObsIhqMoSQcIrTNLUVIJxzJvUk8a8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MqvScE+mpTeungkeSlvv3Q/uzBYTV0O7Qr5Vox35/hw=;
        b=UGUoBgKJArELgVAfSUFKmM6neUD3lLmGzSrCl7X9hpUjtgzxBc2oE+5+3AKLVp/2eX
         +2RDMckDOs5Z26AlW5j1rL4e8R/HUeY/hH1bN8cdwdnPW4V4LODYJJwsT9AWAbDbJY9X
         P6dgugGIsWF4OLohHMxJUTpUsYhfu9Mtgx/F1O24gxOaf7rMR98o0jn7O+3mh93Tr80O
         b3PNg7K4ShUg0pOFoXee2S+EHtRWFBhiKB8suhDdaUvY+KAmr5OLFvvTc6rXLGozTRjm
         3rjxyxj4rZdN15ZG9oVXzFVt5u6kl4SGa0EygnRYjmsGDOcjZNREE21YttnL0R6Y/7RV
         3LLg==
X-Gm-Message-State: APjAAAXB62HOCHDTnnSUmqsFA/WVRjMzqz5BnBxXxD35iD97/VTBPQOA
        bSQPg00IqKqMiS9gcT9+kJnOSA==
X-Google-Smtp-Source: APXvYqwq6lC0O0O/2wGuHUis8CaujTzg5ED6XBldzBsiAKxCW18NlPMCdk/8ggb/wiv8TlnrM8H9eg==
X-Received: by 2002:a62:585:: with SMTP id 127mr130528149pff.231.1559157973778;
        Wed, 29 May 2019 12:26:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q17sm480361pfq.74.2019.05.29.12.26.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 12:26:12 -0700 (PDT)
Date:   Wed, 29 May 2019 12:26:11 -0700
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
Subject: Re: [PATCH v4 08/14] arm: Use generic mmap top-down layout and brk
 randomization
Message-ID: <201905291222.595685C3F0@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-9-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-9-alex@ghiti.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:40AM -0400, Alexandre Ghiti wrote:
> arm uses a top-down mmap layout by default that exactly fits the generic
> functions, so get rid of arch specific code and use the generic version
> by selecting ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT.
> As ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT selects ARCH_HAS_ELF_RANDOMIZE,
> use the generic version of arch_randomize_brk since it also fits.
> Note that this commit also removes the possibility for arm to have elf
> randomization and no MMU: without MMU, the security added by randomization
> is worth nothing.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Acked-by: Kees Cook <keescook@chromium.org>

It may be worth noting that STACK_RND_MASK is safe to remove here
because it matches the default that now exists in mm/util.c.

-Kees

> ---
>  arch/arm/Kconfig                 |  2 +-
>  arch/arm/include/asm/processor.h |  2 --
>  arch/arm/kernel/process.c        |  5 ---
>  arch/arm/mm/mmap.c               | 62 --------------------------------
>  4 files changed, 1 insertion(+), 70 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 8869742a85df..27687a8c9fb5 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -6,7 +6,6 @@ config ARM
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
> -	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_FORTIFY_SOURCE
>  	select ARCH_HAS_KEEPINITRD
>  	select ARCH_HAS_KCOV
> @@ -29,6 +28,7 @@ config ARM
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF
> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_IPC_PARSE_VERSION
>  	select BUILDTIME_EXTABLE_SORT if MMU
>  	select CLONE_BACKWARDS
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 5d06f75ffad4..95b7688341c5 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -143,8 +143,6 @@ static inline void prefetchw(const void *ptr)
>  #endif
>  #endif
>  
> -#define HAVE_ARCH_PICK_MMAP_LAYOUT
> -
>  #endif
>  
>  #endif /* __ASM_ARM_PROCESSOR_H */
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 72cc0862a30e..19a765db5f7f 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -322,11 +322,6 @@ unsigned long get_wchan(struct task_struct *p)
>  	return 0;
>  }
>  
> -unsigned long arch_randomize_brk(struct mm_struct *mm)
> -{
> -	return randomize_page(mm->brk, 0x02000000);
> -}
> -
>  #ifdef CONFIG_MMU
>  #ifdef CONFIG_KUSER_HELPERS
>  /*
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 0b94b674aa91..b8d912ac9e61 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -17,43 +17,6 @@
>  	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
>  	 (((pgoff)<<PAGE_SHIFT) & (SHMLBA-1)))
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
>  /*
>   * We need to ensure that shared mappings are correctly aligned to
>   * avoid aliasing issues with VIPT caches.  We need to ensure that
> @@ -181,31 +144,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
>  	return addr;
>  }
>  
> -unsigned long arch_mmap_rnd(void)
> -{
> -	unsigned long rnd;
> -
> -	rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);
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
>  /*
>   * You really shouldn't be using read() or write() on /dev/mem.  This
>   * might go away in the future.
> -- 
> 2.20.1
> 

-- 
Kees Cook
