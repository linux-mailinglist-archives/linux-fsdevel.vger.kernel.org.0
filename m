Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49388718
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 02:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfHJAHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 20:07:00 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17739 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfHJAHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 20:07:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4e0aac0000>; Fri, 09 Aug 2019 17:07:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 09 Aug 2019 17:06:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 09 Aug 2019 17:06:57 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 10 Aug
 2019 00:06:57 +0000
Subject: Re: [RFC PATCH v2 10/19] mm/gup: Pass a NULL vaddr_pin through GUP
 fast
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
 <20190809225833.6657-11-ira.weiny@intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8b3cdb1b-863c-b904-edb5-0f7b35038fdf@nvidia.com>
Date:   Fri, 9 Aug 2019 17:06:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809225833.6657-11-ira.weiny@intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565395628; bh=Cy1zdJSEqwoFmqaSThScUQztNmSg0xcFlEeyeXrzPSw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=P4Y3ZDhiJjHcGxAywNBs2eKVTUoFGEhA9Arh8zru3uY0gREK0eEPAv5G+sn4KFS5I
         mq+G1pPBSkaaqKg9Ar8MmvUf3ktvgBeuCIfqC22uKLN8NkyYskKoB7LkrEpTdtj9ie
         QW3k6GODwUpZOzs9K65RDKHhyCsAnLzpTxaZyt5LYqqSmAMQm2DsOnocxdOMCEuufm
         S92A5gwM4CMdk4mFIVatj9lQwRjz4T12twW3kHBW48zM3oCWwf6LfFd7QAmW3pGQl0
         nEEOUt1PZzygXDpyX66jzHDn7obVo7Fth1CDX+KbpJgLIc8nEgjU0kKSMiA5f8usAK
         e12cg3hpYVjag==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/19 3:58 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Internally GUP fast needs to know that fast users will not support file
> pins.  Pass NULL for vaddr_pin through the fast call stack so that the
> pin code can return an error if it encounters file backed memory within
> the address range.
> 

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/gup.c | 65 ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 40 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7a449500f0a6..504af3e9a942 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1813,7 +1813,8 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>  
>  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>  static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +			 unsigned int flags, struct page **pages, int *nr,
> +			 struct vaddr_pin *vaddr_pin)
>  {
>  	struct dev_pagemap *pgmap = NULL;
>  	int nr_start = *nr, ret = 0;
> @@ -1894,7 +1895,8 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   * useful to have gup_huge_pmd even if we can't operate on ptes.
>   */
>  static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +			 unsigned int flags, struct page **pages, int *nr,
> +			 struct vaddr_pin *vaddr_pin)
>  {
>  	return 0;
>  }
> @@ -1903,7 +1905,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  #if defined(CONFIG_ARCH_HAS_PTE_DEVMAP) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
>  static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr,
> -		unsigned int flags)
> +		unsigned int flags, struct vaddr_pin *vaddr_pin)
>  {
>  	int nr_start = *nr;
>  	struct dev_pagemap *pgmap = NULL;
> @@ -1938,13 +1940,14 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
>  
>  static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr,
> -		unsigned int flags)
> +		unsigned int flags, struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pmd_pfn(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
> +	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags,
> +			       vaddr_pin))
>  		return 0;
>  
>  	if (unlikely(pmd_val(orig) != pmd_val(*pmdp))) {
> @@ -1957,13 +1960,14 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  
>  static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr,
> -		unsigned int flags)
> +		unsigned int flags, struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long fault_pfn;
>  	int nr_start = *nr;
>  
>  	fault_pfn = pud_pfn(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> -	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags))
> +	if (!__gup_device_huge(fault_pfn, addr, end, pages, nr, flags,
> +			       vaddr_pin))
>  		return 0;
>  
>  	if (unlikely(pud_val(orig) != pud_val(*pudp))) {
> @@ -1975,7 +1979,7 @@ static int __gup_device_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  #else
>  static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr,
> -		unsigned int flags)
> +		unsigned int flags, struct vaddr_pin *vaddr_pin)
>  {
>  	BUILD_BUG();
>  	return 0;
> @@ -1983,7 +1987,7 @@ static int __gup_device_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  
>  static int __gup_device_huge_pud(pud_t pud, pud_t *pudp, unsigned long addr,
>  		unsigned long end, struct page **pages, int *nr,
> -		unsigned int flags)
> +		unsigned int flags, struct vaddr_pin *vaddr_pin)
>  {
>  	BUILD_BUG();
>  	return 0;
> @@ -2075,7 +2079,8 @@ static inline int gup_huge_pd(hugepd_t hugepd, unsigned long addr,
>  #endif /* CONFIG_ARCH_HAS_HUGEPD */
>  
>  static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
> -		unsigned long end, unsigned int flags, struct page **pages, int *nr)
> +		unsigned long end, unsigned int flags, struct page **pages,
> +		int *nr, struct vaddr_pin *vaddr_pin)
>  {
>  	struct page *head, *page;
>  	int refs;
> @@ -2087,7 +2092,7 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
>  		return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr,
> -					     flags);
> +					     flags, vaddr_pin);
>  	}
>  
>  	refs = 0;
> @@ -2117,7 +2122,8 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>  }
>  
>  static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
> -		unsigned long end, unsigned int flags, struct page **pages, int *nr)
> +		unsigned long end, unsigned int flags, struct page **pages, int *nr,
> +		struct vaddr_pin *vaddr_pin)
>  {
>  	struct page *head, *page;
>  	int refs;
> @@ -2129,7 +2135,7 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>  		if (unlikely(flags & FOLL_LONGTERM))
>  			return 0;
>  		return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr,
> -					     flags);
> +					     flags, vaddr_pin);
>  	}
>  
>  	refs = 0;
> @@ -2196,7 +2202,8 @@ static int gup_huge_pgd(pgd_t orig, pgd_t *pgdp, unsigned long addr,
>  }
>  
>  static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
> -		unsigned int flags, struct page **pages, int *nr)
> +		unsigned int flags, struct page **pages, int *nr,
> +		struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long next;
>  	pmd_t *pmdp;
> @@ -2220,7 +2227,7 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  				return 0;
>  
>  			if (!gup_huge_pmd(pmd, pmdp, addr, next, flags,
> -				pages, nr))
> +				pages, nr, vaddr_pin))
>  				return 0;
>  
>  		} else if (unlikely(is_hugepd(__hugepd(pmd_val(pmd))))) {
> @@ -2231,7 +2238,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
>  					 PMD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> +		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr,
> +					  vaddr_pin))
>  			return 0;
>  	} while (pmdp++, addr = next, addr != end);
>  
> @@ -2239,7 +2247,8 @@ static int gup_pmd_range(pud_t pud, unsigned long addr, unsigned long end,
>  }
>  
>  static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +			 unsigned int flags, struct page **pages, int *nr,
> +			 struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long next;
>  	pud_t *pudp;
> @@ -2253,13 +2262,14 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>  			return 0;
>  		if (unlikely(pud_huge(pud))) {
>  			if (!gup_huge_pud(pud, pudp, addr, next, flags,
> -					  pages, nr))
> +					  pages, nr, vaddr_pin))
>  				return 0;
>  		} else if (unlikely(is_hugepd(__hugepd(pud_val(pud))))) {
>  			if (!gup_huge_pd(__hugepd(pud_val(pud)), addr,
>  					 PUD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr))
> +		} else if (!gup_pmd_range(pud, addr, next, flags, pages, nr,
> +					  vaddr_pin))
>  			return 0;
>  	} while (pudp++, addr = next, addr != end);
>  
> @@ -2267,7 +2277,8 @@ static int gup_pud_range(p4d_t p4d, unsigned long addr, unsigned long end,
>  }
>  
>  static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +			 unsigned int flags, struct page **pages, int *nr,
> +			 struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long next;
>  	p4d_t *p4dp;
> @@ -2284,7 +2295,8 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
>  			if (!gup_huge_pd(__hugepd(p4d_val(p4d)), addr,
>  					 P4D_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr))
> +		} else if (!gup_pud_range(p4d, addr, next, flags, pages, nr,
> +					  vaddr_pin))
>  			return 0;
>  	} while (p4dp++, addr = next, addr != end);
>  
> @@ -2292,7 +2304,8 @@ static int gup_p4d_range(pgd_t pgd, unsigned long addr, unsigned long end,
>  }
>  
>  static void gup_pgd_range(unsigned long addr, unsigned long end,
> -		unsigned int flags, struct page **pages, int *nr)
> +		unsigned int flags, struct page **pages, int *nr,
> +		struct vaddr_pin *vaddr_pin)
>  {
>  	unsigned long next;
>  	pgd_t *pgdp;
> @@ -2312,7 +2325,8 @@ static void gup_pgd_range(unsigned long addr, unsigned long end,
>  			if (!gup_huge_pd(__hugepd(pgd_val(pgd)), addr,
>  					 PGDIR_SHIFT, next, flags, pages, nr))
>  				return;
> -		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr))
> +		} else if (!gup_p4d_range(pgd, addr, next, flags, pages, nr,
> +					  vaddr_pin))
>  			return;
>  	} while (pgdp++, addr = next, addr != end);
>  }
> @@ -2374,7 +2388,8 @@ int __get_user_pages_fast(unsigned long start, int nr_pages, int write,
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
>  		local_irq_save(flags);
> -		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr);
> +		gup_pgd_range(start, end, write ? FOLL_WRITE : 0, pages, &nr,
> +			      NULL);
>  		local_irq_restore(flags);
>  	}
>  
> @@ -2445,7 +2460,7 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>  	if (IS_ENABLED(CONFIG_HAVE_FAST_GUP) &&
>  	    gup_fast_permitted(start, end)) {
>  		local_irq_disable();
> -		gup_pgd_range(addr, end, gup_flags, pages, &nr);
> +		gup_pgd_range(addr, end, gup_flags, pages, &nr, NULL);
>  		local_irq_enable();
>  		ret = nr;
>  	}
> 
