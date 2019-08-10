Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDDE088731
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfHJASf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:18:35 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:10947 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfHJASf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:18:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4e0d5a0000>; Fri, 09 Aug 2019 17:18:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 17:18:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 09 Aug 2019 17:18:32 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 10 Aug
 2019 00:18:32 +0000
Subject: Re: [RFC PATCH v2 11/19] mm/gup: Pass follow_page_context further
 down the call stack
To:     <ira.weiny@intel.com>, Andrew Morton <akpm@linux-foundation.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190809225833.6657-1-ira.weiny@intel.com>
 <20190809225833.6657-12-ira.weiny@intel.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <57000521-cc09-9c33-9fa4-1fae5a3972c2@nvidia.com>
Date:   Fri, 9 Aug 2019 17:18:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-12-ira.weiny@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565396314; bh=QUPX6W6Ja5LCLWg61hPTCdEnk8Lrgk/e4K1x4QMxbBc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TtNjM3ra9Lz+zuhx3QLylPbxdiMF9vyMzN2B8p4ZK/noyxXhJT4PrS1As7dPQi1Ah
         Y8sNnmF1wIVgb25p0oQCgwaHitWn6mvl6DovAPzkMIn5tRdzVxwy8Wh60FNpa71RKu
         Kkgd8iYQQmXJjURe3A1uLIdrQd0f0L4TccxSlNgB+Gk/edvuYb4+Z1GYrKg18ewY0L
         kSl1uZ33dZhqjF0VJ1Ujh6T7yST7jI2KtFY2M9KQCteuSxJzVCGn+wMgCTReUeqD0j
         Cyz8TXl3ph3d2I7Nt3C5zTtAN7n8m7+CzXByC8jDGPDCvs5YbBM0Pyke8RWoHMk3Dz
         qVlTKTXHBY1rw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In preparation for passing more information (vaddr_pin) into
> follow_page_pte(), follow_devmap_pud(), and follow_devmap_pmd().
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  include/linux/huge_mm.h | 17 -----------------
>  mm/gup.c                | 31 +++++++++++++++----------------
>  mm/huge_memory.c        |  6 ++++--
>  mm/internal.h           | 28 ++++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 45ede62aa85b..b01a20ce0bb9 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -233,11 +233,6 @@ static inline int hpage_nr_pages(struct page *page)
>  	return 1;
>  }
>  
> -struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> -		pmd_t *pmd, int flags, struct dev_pagemap **pgmap);
> -struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> -		pud_t *pud, int flags, struct dev_pagemap **pgmap);
> -
>  extern vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t orig_pmd);
>  
>  extern struct page *huge_zero_page;
> @@ -375,18 +370,6 @@ static inline void mm_put_huge_zero_page(struct mm_struct *mm)
>  	return;
>  }
>  
> -static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> -	unsigned long addr, pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
> -{
> -	return NULL;
> -}
> -
> -static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
> -	unsigned long addr, pud_t *pud, int flags, struct dev_pagemap **pgmap)
> -{
> -	return NULL;
> -}
> -
>  static inline bool thp_migration_supported(void)
>  {
>  	return false;
> diff --git a/mm/gup.c b/mm/gup.c
> index 504af3e9a942..a7a9d2f5278c 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -24,11 +24,6 @@
>  
>  #include "internal.h"
>  
> -struct follow_page_context {
> -	struct dev_pagemap *pgmap;
> -	unsigned int page_mask;
> -};
> -
>  /**
>   * put_user_pages_dirty_lock() - release and optionally dirty gup-pinned pages
>   * @pages:  array of pages to be maybe marked dirty, and definitely released.
> @@ -172,8 +167,9 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
>  
>  static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		unsigned long address, pmd_t *pmd, unsigned int flags,
> -		struct dev_pagemap **pgmap)
> +		struct follow_page_context *ctx)
>  {
> +	struct dev_pagemap **pgmap = &ctx->pgmap;
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct page *page;
>  	spinlock_t *ptl;
> @@ -363,13 +359,13 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  	}
>  	if (pmd_devmap(pmdval)) {
>  		ptl = pmd_lock(mm, pmd);
> -		page = follow_devmap_pmd(vma, address, pmd, flags, &ctx->pgmap);
> +		page = follow_devmap_pmd(vma, address, pmd, flags, ctx);
>  		spin_unlock(ptl);
>  		if (page)
>  			return page;
>  	}
>  	if (likely(!pmd_trans_huge(pmdval)))
> -		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> +		return follow_page_pte(vma, address, pmd, flags, ctx);
>  
>  	if ((flags & FOLL_NUMA) && pmd_protnone(pmdval))
>  		return no_page_table(vma, flags);
> @@ -389,7 +385,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  	}
>  	if (unlikely(!pmd_trans_huge(*pmd))) {
>  		spin_unlock(ptl);
> -		return follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> +		return follow_page_pte(vma, address, pmd, flags, ctx);
>  	}
>  	if (flags & (FOLL_SPLIT | FOLL_SPLIT_PMD)) {
>  		int ret;
> @@ -419,7 +415,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>  		}
>  
>  		return ret ? ERR_PTR(ret) :
> -			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
> +			follow_page_pte(vma, address, pmd, flags, ctx);
>  	}
>  	page = follow_trans_huge_pmd(vma, address, pmd, flags);
>  	spin_unlock(ptl);
> @@ -456,7 +452,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>  	}
>  	if (pud_devmap(*pud)) {
>  		ptl = pud_lock(mm, pud);
> -		page = follow_devmap_pud(vma, address, pud, flags, &ctx->pgmap);
> +		page = follow_devmap_pud(vma, address, pud, flags, ctx);
>  		spin_unlock(ptl);
>  		if (page)
>  			return page;
> @@ -786,7 +782,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
>  static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  		unsigned long start, unsigned long nr_pages,
>  		unsigned int gup_flags, struct page **pages,
> -		struct vm_area_struct **vmas, int *nonblocking)
> +		struct vm_area_struct **vmas, int *nonblocking,
> +		struct vaddr_pin *vaddr_pin)

I didn't expect to see more vaddr_pin arg passing, based on the commit
description. Did you want this as part of patch 9 or 10 instead? If not,
then let's mention it in the commit description.

>  {
>  	long ret = 0, i = 0;
>  	struct vm_area_struct *vma = NULL;
> @@ -797,6 +794,8 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  
>  	VM_BUG_ON(!!pages != !!(gup_flags & FOLL_GET));
>  
> +	ctx.vaddr_pin = vaddr_pin;
> +
>  	/*
>  	 * If FOLL_FORCE is set then do not force a full fault as the hinting
>  	 * fault information is unrelated to the reference behaviour of a task
> @@ -1025,7 +1024,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  	lock_dropped = false;
>  	for (;;) {
>  		ret = __get_user_pages(tsk, mm, start, nr_pages, flags, pages,
> -				       vmas, locked);
> +				       vmas, locked, vaddr_pin);
>  		if (!locked)
>  			/* VM_FAULT_RETRY couldn't trigger, bypass */
>  			return ret;
> @@ -1068,7 +1067,7 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  		lock_dropped = true;
>  		down_read(&mm->mmap_sem);
>  		ret = __get_user_pages(tsk, mm, start, 1, flags | FOLL_TRIED,
> -				       pages, NULL, NULL);
> +				       pages, NULL, NULL, vaddr_pin);
>  		if (ret != 1) {
>  			BUG_ON(ret > 1);
>  			if (!pages_done)
> @@ -1226,7 +1225,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
>  	 * not result in a stack expansion that recurses back here.
>  	 */
>  	return __get_user_pages(current, mm, start, nr_pages, gup_flags,
> -				NULL, NULL, nonblocking);
> +				NULL, NULL, nonblocking, NULL);
>  }
>  
>  /*
> @@ -1311,7 +1310,7 @@ struct page *get_dump_page(unsigned long addr)
>  
>  	if (__get_user_pages(current, current->mm, addr, 1,
>  			     FOLL_FORCE | FOLL_DUMP | FOLL_GET, &page, &vma,
> -			     NULL) < 1)
> +			     NULL, NULL) < 1)
>  		return NULL;
>  	flush_cache_page(vma, addr, page_to_pfn(page));
>  	return page;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bc1a07a55be1..7e09f2f17ed8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -916,8 +916,9 @@ static void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
>  }
>  
>  struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> -		pmd_t *pmd, int flags, struct dev_pagemap **pgmap)
> +		pmd_t *pmd, int flags, struct follow_page_context *ctx)
>  {
> +	struct dev_pagemap **pgmap = &ctx->pgmap;
>  	unsigned long pfn = pmd_pfn(*pmd);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct page *page;
> @@ -1068,8 +1069,9 @@ static void touch_pud(struct vm_area_struct *vma, unsigned long addr,
>  }
>  
>  struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> -		pud_t *pud, int flags, struct dev_pagemap **pgmap)
> +		pud_t *pud, int flags, struct follow_page_context *ctx)
>  {
> +	struct dev_pagemap **pgmap = &ctx->pgmap;
>  	unsigned long pfn = pud_pfn(*pud);
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct page *page;
> diff --git a/mm/internal.h b/mm/internal.h
> index 0d5f720c75ab..46ada5279856 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -12,6 +12,34 @@
>  #include <linux/pagemap.h>
>  #include <linux/tracepoint-defs.h>
>  
> +struct follow_page_context {
> +	struct dev_pagemap *pgmap;
> +	unsigned int page_mask;
> +	struct vaddr_pin *vaddr_pin;
> +};
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
> +		pmd_t *pmd, int flags, struct follow_page_context *ctx);
> +struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
> +		pud_t *pud, int flags, struct follow_page_context *ctx);
> +#else
> +static inline struct page *follow_devmap_pmd(struct vm_area_struct *vma,
> +	unsigned long addr, pmd_t *pmd, int flags,
> +	struct follow_page_context *ctx)
> +{
> +	return NULL;
> +}
> +
> +static inline struct page *follow_devmap_pud(struct vm_area_struct *vma,
> +	unsigned long addr, pud_t *pud, int flags,
> +	struct follow_page_context *ctx)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +
>  /*
>   * The set of flags that only affect watermark checking and reclaim
>   * behaviour. This is used by the MM to obey the caller constraints
> 




thanks,
-- 
John Hubbard
NVIDIA
