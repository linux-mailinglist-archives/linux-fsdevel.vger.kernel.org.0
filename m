Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C5530390C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 10:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbhAZJc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 04:32:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:39178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391084AbhAZJae (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:30:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F58DACF4;
        Tue, 26 Jan 2021 09:29:52 +0000 (UTC)
Date:   Tue, 26 Jan 2021 10:29:46 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
Message-ID: <20210126092942.GA10602@linux>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117151053.24600-6-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 17, 2021 at 11:10:46PM +0800, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. We can do that in the __free_hugepage()
> before freeing it to buddy.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

This series has grown a certain grade of madurity and improvment, but it seems
to me that we have been stuck in this patch (and patch#4) for quite some time.

Would it be acceptable for a first implementation to not let hugetlb pages to
be freed when this feature is in use?
This would simplify things for now, as we could get rid of patch#4 and patch#5.
We can always extend functionality once this has been merged, right?

Of course, this means that e.g: memory-hotplug (hot-remove) will not fully work
when this in place, but well.

I would like to hear what others think, but in my opinion it would be a big step
to move on.



> ---
>  include/linux/mm.h   |  2 ++
>  mm/hugetlb.c         |  2 ++
>  mm/hugetlb_vmemmap.c | 15 ++++++++++
>  mm/hugetlb_vmemmap.h |  5 ++++
>  mm/sparse-vmemmap.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f928994ed273..16b55d13b0ab 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3007,6 +3007,8 @@ static inline void print_vma_addr(char *prefix, unsigned long rip)
>  
>  void vmemmap_remap_free(unsigned long start, unsigned long end,
>  			unsigned long reuse);
> +void vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			 unsigned long reuse);
>  
>  void *sparse_buffer_alloc(unsigned long size);
>  struct page * __populate_section_memmap(unsigned long pfn,
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c165186ec2cf..d11c32fcdb38 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1326,6 +1326,8 @@ static void update_hpage_vmemmap_workfn(struct work_struct *work)
>  		page->mapping = NULL;
>  		h = page_hstate(page);
>  
> +		alloc_huge_page_vmemmap(h, page);
> +
>  		spin_lock(&hugetlb_lock);
>  		__free_hugepage(h, page);
>  		spin_unlock(&hugetlb_lock);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 19f1898aaede..6108ae80314f 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -183,6 +183,21 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> +void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +
> +	vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> +}
> +
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  	unsigned long vmemmap_addr = (unsigned long)head;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 01f8637adbe0..b2c8d2f11d48 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -11,6 +11,7 @@
>  #include <linux/hugetlb.h>
>  
>  #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +void alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
>  
>  /*
> @@ -25,6 +26,10 @@ static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  	return 0;
>  }
>  #else
> +static inline void alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +}
> +
>  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  }
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index ce4be1fa93c2..3b146d5949f3 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/delay.h>
>  
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> @@ -40,7 +41,8 @@
>   * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
>   * @reuse_page:		the page which is reused for the tail vmemmap pages.
>   * @reuse_addr:		the virtual address of the @reuse_page page.
> - * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
> + *			or is mapped from.
>   */
>  struct vmemmap_remap_walk {
>  	void (*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
>  	struct list_head *vmemmap_pages;
>  };
>  
> +/* The gfp mask of allocating vmemmap page */
> +#define GFP_VMEMMAP_PAGE		\
> +	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
> +
>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>  			      unsigned long end,
>  			      struct vmemmap_remap_walk *walk)
> @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>  	free_vmemmap_page_list(&vmemmap_pages);
>  }
>  
> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	struct page *page;
> +	void *to;
> +
> +	BUG_ON(pte_page(*pte) != walk->reuse_page);
> +
> +	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> +	list_del(&page->lru);
> +	to = page_to_virt(page);
> +	copy_page(to, (void *)walk->reuse_addr);
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +}
> +
> +static void alloc_vmemmap_page_list(struct list_head *list,
> +				    unsigned long start, unsigned long end)
> +{
> +	unsigned long addr;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE) {
> +		struct page *page;
> +		int nid = page_to_nid((const void *)addr);
> +
> +retry:
> +		page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
> +		if (unlikely(!page)) {
> +			msleep(100);
> +			/*
> +			 * We should retry infinitely, because we cannot
> +			 * handle allocation failures. Once we allocate
> +			 * vmemmap pages successfully, then we can free
> +			 * a HugeTLB page.
> +			 */
> +			goto retry;
> +		}
> +		list_add_tail(&page->lru, list);
> +	}
> +}
> +
> +/**
> + * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
> + *			 to the page which is from the @vmemmap_pages
> + *			 respectively.
> + * @start:	start address of the vmemmap virtual address range.
> + * @end:	end address of the vmemmap virtual address range.
> + * @reuse:	reuse address.
> + */
> +void vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			 unsigned long reuse)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_restore_pte,
> +		.reuse_addr	= reuse,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	might_sleep();
> +
> +	/* See the comment in the vmemmap_remap_free(). */
> +	BUG_ON(start - reuse != PAGE_SIZE);
> +
> +	alloc_vmemmap_page_list(&vmemmap_pages, start, end);
> +	vmemmap_remap_range(reuse, end, &walk);
> +}
> +
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
>   * or to back the page tables that are used to create the mapping.
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE L3
