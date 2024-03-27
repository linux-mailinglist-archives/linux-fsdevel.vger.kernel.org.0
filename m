Return-Path: <linux-fsdevel+bounces-15443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D061888E82B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 16:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D9DD2C75B9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017A852F86;
	Wed, 27 Mar 2024 14:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndZafUL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70D131197;
	Wed, 27 Mar 2024 14:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550684; cv=none; b=RPFfnjEzJLMtmJ82F+59UQJ2D3RAWGLpmMpy2L7bX5OqkpBddg/CNIz1eMXegbt7uYi8Mkp01ZIurzOh40qStk71v40B5XWOhgDrw2UfqLHbQ/SVmtUcFXZI6E5IN1bwm7EiR/m3IfPHZjXrMeW5pz0GJmjY2q6aqFAiGEdVRK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550684; c=relaxed/simple;
	bh=AS8Dn6hQC+bzM3iGPLZ41ITzx0BRa6l0wc10olNRkwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwLQXMGXLsPKUkkQzlRb/xOwDr1vdFEe7KR8F5wPSJzTxaZK0M7ckDuXzLpjU5j19d0Su03hbgcmv19SaHU/YQuBCurwUbe5yE/Mq058M55x6U2W3rzhFZWUPuWnJKbz5xd0rRMA3W3ezFq10yRXMVuOziCp7DCunTa2gloO64c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndZafUL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17213C43390;
	Wed, 27 Mar 2024 14:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550683;
	bh=AS8Dn6hQC+bzM3iGPLZ41ITzx0BRa6l0wc10olNRkwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ndZafUL0QM8QCzypjZH0wZgKxdqEHr9XRPhCrlkfLwntuquujRofS0S5C2WWIqsCV
	 V2bKW99mbBdAlpAu/NwWySWq8O9P1YZZnN+A0qOSU6DAR8KF6AD8S3fPIgv52DjAxw
	 OgXCj7s8RjLDGaB/im47wtIsu7s9yTswQv2+x7Xpa1gkVKHHBbnuQ2giwwbua/SK2q
	 iNdYSynD8+XvCNxRdN0SLlwnzJLeOOx54qgBsRT3SBcdbnBfTwXmM9VG/RKNM9zmjF
	 n+kFsMUR6imG1H5ITg6Y0BcMllo7sbpCn2zhDW1r6Wi3/VIysl/e4tmVC0TIZseIa3
	 dlTmvQuOBFXtg==
Date: Wed, 27 Mar 2024 16:43:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH RFC 1/3] mm/gup: consistently name GUP-fast functions
Message-ID: <ZgQwrlyGpvgxwufT@kernel.org>
References: <20240327130538.680256-1-david@redhat.com>
 <20240327130538.680256-2-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327130538.680256-2-david@redhat.com>

On Wed, Mar 27, 2024 at 02:05:36PM +0100, David Hildenbrand wrote:
> Let's consistently call the "fast-only" part of GUP "GUP-fast" and rename
> all relevant internal functions to start with "gup_fast", to make it
> clearer that this is not ordinary GUP. The current mixture of
> "lockless", "gup" and "gup_fast" is confusing.
> 
> Further, avoid the term "huge" when talking about a "leaf" -- for
> example, we nowadays check pmd_leaf() because pmd_huge() is gone. For the
> "hugepd"/"hugepte" stuff, it's part of the name ("is_hugepd"), so that
> says.

typo: stays

> What remains is the "external" interface:
> * get_user_pages_fast_only()
> * get_user_pages_fast()
> * pin_user_pages_fast()
> 
> And the "internal" interface that handles GUP-fast + fallback:
> * internal_get_user_pages_fast()
> 
> The high-level internal function for GUP-fast is now:
> * gup_fast()
> 
> The basic GUP-fast walker functions:
> * gup_pgd_range() -> gup_fast_pgd_range()
> * gup_p4d_range() -> gup_fast_p4d_range()
> * gup_pud_range() -> gup_fast_pud_range()
> * gup_pmd_range() -> gup_fast_pmd_range()
> * gup_pte_range() -> gup_fast_pte_range()
> * gup_huge_pgd()  -> gup_fast_pgd_leaf()
> * gup_huge_pud()  -> gup_fast_pud_leaf()
> * gup_huge_pmd()  -> gup_fast_pmd_leaf()
> 
> The weird hugepd stuff:
> * gup_huge_pd() -> gup_fast_hugepd()
> * gup_hugepte() -> gup_fast_hugepte()
> 
> The weird devmap stuff:
> * __gup_device_huge_pud() -> gup_fast_devmap_pud_leaf()
> * __gup_device_huge_pmd   -> gup_fast_devmap_pmd_leaf()
> * __gup_device_huge()     -> gup_fast_devmap_leaf()
> 
> Helper functions:
> * unpin_user_pages_lockless() -> gup_fast_unpin_user_pages()
> * gup_fast_folio_allowed() is already properly named
> * gup_fast_permitted() is already properly named
> 
> With "gup_fast()", we now even have a function that is referred to in
> comment in mm/mmu_gather.c.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  mm/gup.c | 164 ++++++++++++++++++++++++++++---------------------------
>  1 file changed, 84 insertions(+), 80 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 03b74b148e30..c293aff30c5d 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -440,7 +440,7 @@ void unpin_user_page_range_dirty_lock(struct page *page, unsigned long npages,
>  }
>  EXPORT_SYMBOL(unpin_user_page_range_dirty_lock);
>  
> -static void unpin_user_pages_lockless(struct page **pages, unsigned long npages)
> +static void gup_fast_unpin_user_pages(struct page **pages, unsigned long npages)
>  {
>  	unsigned long i;
>  	struct folio *folio;
> @@ -2431,7 +2431,7 @@ long get_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
>  EXPORT_SYMBOL(get_user_pages_unlocked);
>  
>  /*
> - * Fast GUP
> + * GUP-fast
>   *
>   * get_user_pages_fast attempts to pin user pages by walking the page
>   * tables directly and avoids taking locks. Thus the walker needs to be
> @@ -2445,7 +2445,7 @@ EXPORT_SYMBOL(get_user_pages_unlocked);
>   *
>   * Another way to achieve this is to batch up page table containing pages
>   * belonging to more than one mm_user, then rcu_sched a callback to free those
> - * pages. Disabling interrupts will allow the fast_gup walker to both block
> + * pages. Disabling interrupts will allow the gup_fast() walker to both block
>   * the rcu_sched callback, and an IPI that we broadcast for splitting THPs
>   * (which is a relatively rare event). The code below adopts this strategy.
>   *
> @@ -2589,9 +2589,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>   * also check pmd here to make sure pmd doesn't change (corresponds to
>   * pmdp_collapse_flush() in the THP collapse code path).
>   */
> -static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> -			 unsigned long end, unsigned int flags,
> -			 struct page **pages, int *nr)
> +static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	struct dev_pagemap *pgmap = NULL;
>  	int nr_start = *nr, ret = 0;
> @@ -2688,20 +2688,19 @@ static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>   *
>   * For a futex to be placed on a THP tail page, get_futex_key requires a
>   * get_user_pages_fast_only implementation that can pin pages. Thus it's still
> - * useful to have gup_huge_pmd even if we can't operate on ptes.
> + * useful to have gup_fast_pmd_leaf even if we can't operate on ptes.
>   */
> -static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> -			 unsigned long end, unsigned int flags,
> -			 struct page **pages, int *nr)
> +static int gup_fast_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	return 0;
>  }
>  #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
>  
>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> -static int __gup_device_huge(unsigned long pfn, unsigned long addr,
> -			     unsigned long end, unsigned int flags,
> -			     struct page **pages, int *nr)
> +static int gup_fast_devmap_leaf(unsigned long pfn, unsigned long addr,
> +	unsigned long end, unsigned int flags, struct page **pages, int *nr)
>  {
>  	int nr_start = *nr;
>  	struct dev_pagemap *pgmap = NULL;
> @@ -2734,15 +2733,15 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  	return addr == end;
>  }
>  
> -static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -				 unsigned long end, unsigned int flags,
> -				 struct page **pages, int *nr)
> +static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
> +	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> @@ -2752,15 +2751,15 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	return 1;
>  }
>  
> -static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> -				 unsigned long end, unsigned int flags,
> -				 struct page **pages, int *nr)
> +static int gup_fast_devmap_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, flags, pages, nr))
> +	if (!gup_fast_devmap_leaf(fault_pfn, addr, end, flags, pages, nr))
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> @@ -2770,17 +2769,17 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	return 1;
>  }
>  #else
> -static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -				 unsigned long end, unsigned int flags,
> -				 struct page **pages, int *nr)
> +static int gup_fast_devmap_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	BUILD_BUG();
>  	return 0;
>  }
>  
> -static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
> -				 unsigned long end, unsigned int flags,
> -				 struct page **pages, int *nr)
> +static int gup_fast_devmap_pud_leaf(pud_t pud, pud_t *pudp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	BUILD_BUG();
>  	return 0;
> @@ -2806,9 +2805,9 @@ static unsigned long hugepte_addr_end(unsigned long addr, unsigned long end,
>  	return (__boundary - 1 < end - 1) ? __boundary : end;
>  }
>  
> -static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> -		       unsigned long end, unsigned int flags,
> -		       struct page **pages, int *nr)
> +static int gup_fast_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long pte_end;
>  	struct page *page;
> @@ -2855,7 +2854,7 @@ static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
>  	return 1;
>  }
>  
> -static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
> +static int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
>  		unsigned int pdshift, unsigned long end, unsigned int flags,
>  		struct page **pages, int *nr)
>  {
> @@ -2866,14 +2865,14 @@ static int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  	ptep = hugepte_offset(hugepd, addr, pdshift);
>  	do {
>  		next = hugepte_addr_end(addr, end, sz);
> -		if (!gup_hugepte(ptep, sz, addr, end, flags, pages, nr))
> +		if (!gup_fast_hugepte(ptep, sz, addr, end, flags, pages, nr))
>  			return 0;
>  	} while (ptep++, addr = next, addr != end);
>  
>  	return 1;
>  }
>  #else
> -static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
> +static inline int gup_fast_hugepd(hugepd_t hugepd, unsigned long addr,
>  		unsigned int pdshift, unsigned long end, unsigned int flags,
>  		struct page **pages, int *nr)
>  {
> @@ -2881,9 +2880,9 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  }
>  #endif /* CONFIG_ARCH_HAS_HUGEPD */
>  
> -static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -			unsigned long end, unsigned int flags,
> -			struct page **pages, int *nr)
> +static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	struct page *page;
>  	struct folio *folio;
> @@ -2895,8 +2894,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	if (pmd_devmap(orig)) {
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
> -		return __gup_device_huge_pmd(orig, pmdp, addr, end, flags,
> -					     pages, nr);
> +		return gup_fast_devmap_pmd_leaf(orig, pmdp, addr, end, flags,
> +					        pages, nr);
>  	}
>  
>  	page = nth_page(pmd_page(orig), (addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -2925,9 +2924,9 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  	return 1;
>  }
>  
> -static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> -			unsigned long end, unsigned int flags,
> -			struct page **pages, int *nr)
> +static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	struct page *page;
>  	struct folio *folio;
> @@ -2939,8 +2938,8 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	if (pud_devmap(orig)) {
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
> -		return __gup_device_huge_pud(orig, pudp, addr, end, flags,
> -					     pages, nr);
> +		return gup_fast_devmap_pud_leaf(orig, pudp, addr, end, flags,
> +					        pages, nr);
>  	}
>  
>  	page = nth_page(pud_page(orig), (addr & ~PUD_MASK) >> PAGE_SHIFT);
> @@ -2970,9 +2969,9 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  	return 1;
>  }
>  
> -static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
> -			unsigned long end, unsigned int flags,
> -			struct page **pages, int *nr)
> +static int gup_fast_pgd_leaf(pgd_t orig, pgd_t *pgdp, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	int refs;
>  	struct page *page;
> @@ -3010,8 +3009,9 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  	return 1;
>  }
>  
> -static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned long end,
> -		unsigned int flags, struct page **pages, int *nr)
> +static int gup_fast_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long next;
>  	pmd_t *pmdp;
> @@ -3025,11 +3025,11 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>  			return 0;
>  
>  		if (unlikely(pmd_leaf(pmd))) {
> -			/* See gup_pte_range() */
> +			/* See gup_fast_pte_range() */
>  			if (pmd_protnone(pmd))
>  				return 0;
>  
> -			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
> +			if (!gup_fast_pmd_leaf(pmd, pmdp, addr, next, flags,
>  				pages, nr))
>  				return 0;
>  
> @@ -3038,18 +3038,20 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>  			 * architecture have different format for hugetlbfs
>  			 * pmd format and THP pmd format
>  			 */
> -			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
> -					 PMD_SHIFT, next, flags, pages, nr))
> +			if (!gup_fast_hugepd(__hugepd(pmd_val(pmd)), addr,
> +					     PMD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
> +		} else if (!gup_fast_pte_range(pmd, pmdp, addr, next, flags,
> +					       pages, nr))
>  			return 0;
>  	} while (pmdp++, addr = next, addr != end);
>  
>  	return 1;
>  }
>  
> -static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_fast_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long next;
>  	pud_t *pudp;
> @@ -3062,22 +3064,24 @@ static int gup_pud_range(p4d_t *p4dp, p4d_t p4d, unsigned long addr, unsigned lo
>  		if (unlikely(!pud_present(pud)))
>  			return 0;
>  		if (unlikely(pud_leaf(pud))) {
> -			if (!gup_huge_pud(pud, pudp, addr, next, flags,
> -					  pages, nr))
> +			if (!gup_fast_pud_leaf(pud, pudp, addr, next, flags,
> +					       pages, nr))
>  				return 0;
>  		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
> -			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
> -					 PUD_SHIFT, next, flags, pages, nr))
> +			if (!gup_fast_hugepd(__hugepd(pud_val(pud)), addr,
> +					     PUD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pmd_range(pudp, pud, addr, next, flags, pages, nr))
> +		} else if (!gup_fast_pmd_range(pudp, pud, addr, next, flags,
> +					       pages, nr))
>  			return 0;
>  	} while (pudp++, addr = next, addr != end);
>  
>  	return 1;
>  }
>  
> -static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_fast_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr,
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr)
>  {
>  	unsigned long next;
>  	p4d_t *p4dp;
> @@ -3091,17 +3095,18 @@ static int gup_p4d_range(pgd_t *pgdp, pgd_t pgd, unsigned long addr, unsigned lo
>  			return 0;
>  		BUILD_BUG_ON(p4d_leaf(p4d));
>  		if (unlikely(is_hugepd(__hugepd(p4d_val(p4d))))) {
> -			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
> -					 P4D_SHIFT, next, flags, pages, nr))
> +			if (!gup_fast_hugepd(__hugepd(p4d_val(p4d)), addr,
> +					     P4D_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pud_range(p4dp, p4d, addr, next, flags, pages, nr))
> +		} else if (!gup_fast_pud_range(p4dp, p4d, addr, next, flags,
> +					       pages, nr))
>  			return 0;
>  	} while (p4dp++, addr = next, addr != end);
>  
>  	return 1;
>  }
>  
> -static void gup_pgd_range(unsigned long addr, unsigned long end,
> +static void gup_fast_pgd_range(unsigned long addr, unsigned long end,
>  		unsigned int flags, struct page **pages, int *nr)
>  {
>  	unsigned long next;
> @@ -3115,19 +3120,20 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
>  		if (pgd_none(pgd))
>  			return;
>  		if (unlikely(pgd_leaf(pgd))) {
> -			if (!gup_huge_pgd(pgd, pgdp, addr, next, flags,
> -					  pages, nr))
> +			if (!gup_fast_pgd_leaf(pgd, pgdp, addr, next, flags,
> +					       pages, nr))
>  				return;
>  		} else if (unlikely(is_hugepd(__hugepd(pgd_val(pgd))))) {
> -			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
> -					 PGDIR_SHIFT, next, flags, pages, nr))
> +			if (!gup_fast_hugepd(__hugepd(pgd_val(pgd)), addr,
> +					      PGDIR_SHIFT, next, flags, pages, nr))
>  				return;
> -		} else if (!gup_p4d_range(pgdp, pgd, addr, next, flags, pages, nr))
> +		} else if (!gup_fast_p4d_range(pgdp, pgd, addr, next, flags,
> +					       pages, nr))
>  			return;
>  	} while (pgdp++, addr = next, addr != end);
>  }
>  #else
> -static inline void gup_pgd_range(unsigned long addr, unsigned long end,
> +static inline void gup_fast_pgd_range(unsigned long addr, unsigned long end,
>  		unsigned int flags, struct page **pages, int *nr)
>  {
>  }
> @@ -3144,10 +3150,8 @@ static bool gup_fast_permitted(unsigned long start, unsigned long end)
>  }
>  #endif
>  
> -static unsigned long lockless_pages_from_mm(unsigned long start,
> -					    unsigned long end,
> -					    unsigned int gup_flags,
> -					    struct page **pages)
> +static unsigned long gup_fast(unsigned long start, unsigned long end,
> +		unsigned int gup_flags, struct page **pages)
>  {
>  	unsigned long flags;
>  	int nr_pinned = 0;
> @@ -3175,16 +3179,16 @@ static unsigned long lockless_pages_from_mm(unsigned long start,
>  	 * that come from THPs splitting.
>  	 */
>  	local_irq_save(flags);
> -	gup_pgd_range(start, end, gup_flags, pages, &nr_pinned);
> +	gup_fast_pgd_range(start, end, gup_flags, pages, &nr_pinned);
>  	local_irq_restore(flags);
>  
>  	/*
>  	 * When pinning pages for DMA there could be a concurrent write protect
> -	 * from fork() via copy_page_range(), in this case always fail fast GUP.
> +	 * from fork() via copy_page_range(), in this case always fail GUP-fast.
>  	 */
>  	if (gup_flags & FOLL_PIN) {
>  		if (read_seqcount_retry(&current->mm->write_protect_seq, seq)) {
> -			unpin_user_pages_lockless(pages, nr_pinned);
> +			gup_fast_unpin_user_pages(pages, nr_pinned);
>  			return 0;
>  		} else {
>  			sanity_check_pinned_pages(pages, nr_pinned);
> @@ -3224,7 +3228,7 @@ static int internal_get_user_pages_fast(unsigned long start,
>  	if (unlikely(!access_ok((void __user *)start, len)))
>  		return -EFAULT;
>  
> -	nr_pinned = lockless_pages_from_mm(start, end, gup_flags, pages);
> +	nr_pinned = gup_fast(start, end, gup_flags, pages);
>  	if (nr_pinned == nr_pages || gup_flags & FOLL_FAST_ONLY)
>  		return nr_pinned;
>  
> -- 
> 2.43.2
> 

-- 
Sincerely yours,
Mike.

