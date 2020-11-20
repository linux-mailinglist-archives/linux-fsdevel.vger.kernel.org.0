Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA102BA494
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgKTIYB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:24:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:40280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgKTIYB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:24:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHnP+yX2N2LZSSewnqFwv1a+NYYLkuguHW8g8xxywSE=;
        b=siOCTUSEgBxmOgufcaTFbod3WpqPrULS0gegbW3G1+ijWH+xyX1WvCFHWmWJ6nTFcdxPuA
        seRKapRQYCiGLLy0S2dIVLo0UnoRXf6ua5/g23M0hgg4opl1vv2fmtD/IZ1AraSJOnoNG2
        vk1CHdCtXkwwnmNurkdkXlQgTFSwo/0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADA76ACB0;
        Fri, 20 Nov 2020 08:23:59 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:23:58 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 18/21] mm/hugetlb: Merge pte to huge pmd only for
 gigantic page
Message-ID: <20201120082358.GH3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-19-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-19-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:22, Muchun Song wrote:
> Merge pte to huge pmd if it has ever been split. Now only support
> gigantic page which's vmemmap pages size is an integer multiple of
> PMD_SIZE. This is the simplest case to handle.

I think it would be benefitial for anybody who plan to implement this
for normal PMDs to document challenges while you still have them fresh
in your mind.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/x86/include/asm/hugetlb.h |   8 +++
>  mm/hugetlb_vmemmap.c           | 118 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 124 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index c601fe042832..1de1c519a84a 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -12,6 +12,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
>  {
>  	return pmd_large(*pmd);
>  }
> +
> +#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
> +static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
> +{
> +	pte_t entry = pfn_pte(page_to_pfn(page), PAGE_KERNEL_LARGE);
> +
> +	return __pmd(pte_val(entry));
> +}
>  #endif
>  
>  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c958699d1393..bf2b6b3e75af 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -144,6 +144,14 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
>  }
>  #endif
>  
> +#ifndef vmemmap_pmd_mkhuge
> +#define vmemmap_pmd_mkhuge vmemmap_pmd_mkhuge
> +static inline pmd_t vmemmap_pmd_mkhuge(struct page *page)
> +{
> +	return pmd_mkhuge(mk_pmd(page, PAGE_KERNEL));
> +}
> +#endif
> +
>  static bool hugetlb_free_vmemmap_disabled __initdata;
>  
>  static int __init early_hugetlb_free_vmemmap_param(char *buf)
> @@ -422,6 +430,104 @@ static void __remap_huge_page_pte_vmemmap(struct page *reuse, pte_t *ptep,
>  	}
>  }
>  
> +static void __replace_huge_page_pte_vmemmap(pte_t *ptep, unsigned long start,
> +					    unsigned int nr, struct page *huge,
> +					    struct list_head *free_pages)
> +{
> +	unsigned long addr;
> +	unsigned long end = start + (nr << PAGE_SHIFT);
> +	pgprot_t pgprot = PAGE_KERNEL;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE, ptep++) {
> +		struct page *page;
> +		pte_t old = *ptep;
> +		pte_t entry;
> +
> +		prepare_vmemmap_page(huge);
> +
> +		entry = mk_pte(huge++, pgprot);
> +		VM_WARN_ON(!pte_present(old));
> +		page = pte_page(old);
> +		list_add(&page->lru, free_pages);
> +
> +		set_pte_at(&init_mm, addr, ptep, entry);
> +	}
> +}
> +
> +static void replace_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
> +					  struct page *huge,
> +					  struct list_head *free_pages)
> +{
> +	unsigned long end = start + VMEMMAP_HPAGE_SIZE;
> +
> +	flush_cache_vunmap(start, end);
> +	__replace_huge_page_pte_vmemmap(pte_offset_kernel(pmd, start), start,
> +					VMEMMAP_HPAGE_NR, huge, free_pages);
> +	flush_tlb_kernel_range(start, end);
> +}
> +
> +static pte_t *merge_vmemmap_pte(pmd_t *pmdp, unsigned long addr)
> +{
> +	pte_t *pte;
> +	struct page *page;
> +
> +	pte = pte_offset_kernel(pmdp, addr);
> +	page = pte_page(*pte);
> +	set_pmd(pmdp, vmemmap_pmd_mkhuge(page));
> +
> +	return pte;
> +}
> +
> +static void merge_huge_page_pmd_vmemmap(pmd_t *pmd, unsigned long start,
> +					struct page *huge,
> +					struct list_head *free_pages)
> +{
> +	replace_huge_page_pmd_vmemmap(pmd, start, huge, free_pages);
> +	pte_free_kernel(&init_mm, merge_vmemmap_pte(pmd, start));
> +	flush_tlb_kernel_range(start, start + VMEMMAP_HPAGE_SIZE);
> +}
> +
> +static inline void dissolve_compound_page(struct page *page, unsigned int order)
> +{
> +	int i;
> +	unsigned int nr_pages = 1 << order;
> +
> +	for (i = 1; i < nr_pages; i++)
> +		set_page_count(page + i, 1);
> +}
> +
> +static void merge_gigantic_page_vmemmap(struct hstate *h, struct page *head,
> +					pmd_t *pmd)
> +{
> +	LIST_HEAD(free_pages);
> +	unsigned long addr = (unsigned long)head;
> +	unsigned long end = addr + vmemmap_pages_size_per_hpage(h);
> +
> +	for (; addr < end; addr += VMEMMAP_HPAGE_SIZE) {
> +		void *to;
> +		struct page *page;
> +
> +		page = alloc_pages(GFP_VMEMMAP_PAGE & ~__GFP_NOFAIL,
> +				   VMEMMAP_HPAGE_ORDER);
> +		if (!page)
> +			goto out;
> +
> +		dissolve_compound_page(page, VMEMMAP_HPAGE_ORDER);
> +		to = page_to_virt(page);
> +		memcpy(to, (void *)addr, VMEMMAP_HPAGE_SIZE);
> +
> +		/*
> +		 * Make sure that any data that writes to the
> +		 * @to is made visible to the physical page.
> +		 */
> +		flush_kernel_vmap_range(to, VMEMMAP_HPAGE_SIZE);
> +
> +		merge_huge_page_pmd_vmemmap(pmd++, addr, page, &free_pages);
> +	}
> +out:
> +	free_vmemmap_page_list(&free_pages);
> +}
> +
>  static inline void alloc_vmemmap_pages(struct hstate *h, struct list_head *list)
>  {
>  	int i;
> @@ -454,10 +560,18 @@ void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
>  				    __remap_huge_page_pte_vmemmap);
>  	if (!freed_vmemmap_hpage_dec(pmd_page(*pmd)) && pmd_split(pmd)) {
>  		/*
> -		 * Todo:
> -		 * Merge pte to huge pmd if it has ever been split.
> +		 * Merge pte to huge pmd if it has ever been split. Now only
> +		 * support gigantic page which's vmemmap pages size is an
> +		 * integer multiple of PMD_SIZE. This is the simplest case
> +		 * to handle.
>  		 */
>  		clear_pmd_split(pmd);
> +
> +		if (IS_ALIGNED(vmemmap_pages_per_hpage(h), VMEMMAP_HPAGE_NR)) {
> +			spin_unlock(ptl);
> +			merge_gigantic_page_vmemmap(h, head, pmd);
> +			return;
> +		}
>  	}
>  	spin_unlock(ptl);
>  }
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
