Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598BA310730
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBEIz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 03:55:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:52188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229702AbhBEIzY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 03:55:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CF55EAD37;
        Fri,  5 Feb 2021 08:54:42 +0000 (UTC)
Date:   Fri, 5 Feb 2021 09:54:37 +0100
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
Subject: Re: [PATCH v14 3/8] mm: hugetlb: free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210205085437.GB13848@linux>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204035043.36609-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:50:38AM +0800, Muchun Song wrote:
> Every HugeTLB has more than one struct page structure. We __know__ that
> we only use the first 4(HUGETLB_CGROUP_MIN_ORDER) struct page structures
> to store metadata associated with each HugeTLB.
> 
> There are a lot of struct page structures associated with each HugeTLB
> page. For tail pages, the value of compound_head is the same. So we can
> reuse first page of tail page structures. We map the virtual addresses
> of the remaining pages of tail page structures to the first tail page
> struct, and then free these page frames. Therefore, we need to reserve
> two pages as vmemmap areas.
> 
> When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> pages associated with each HugeTLB page. It is more appropriate to do it
> in the prep_new_huge_page().
> 
> The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> pages associated with a HugeTLB page can be freed, returns zero for
> now, which means the feature is disabled. We will enable it once all
> the infrastructure is there.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

[...]

> +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
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
> +	/*
> +	 * Remap the vmemmap virtual address range [@vmemmap_addr, @vmemmap_end)
> +	 * to the page which @vmemmap_reuse is mapped to, then free the vmemmap
> +	 * pages which the range are mapped to.

"then free the pages which the range [@vmemmap_addr, @vmemmap_end] is mapped to."

I am not a native but sounds better to me.

> +	 */
> +	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
> +}
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> new file mode 100644
> index 000000000000..6923f03534d5
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.h

[...]

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 16183d85a7d5..50c1dc00b686 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -27,8 +27,215 @@
>  #include <linux/spinlock.h>
>  #include <linux/vmalloc.h>
>  #include <linux/sched.h>
> +#include <linux/pgtable.h>
> +#include <linux/bootmem_info.h>
> +
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> +#include <asm/tlbflush.h>
> +
> +/**
> + * vmemmap_remap_walk - walk vmemmap page table
> + *
> + * @remap_pte:		called for each non-empty PTE (lowest-level) entry.

Well, we BUG_ON on empty PTE, so not sure that pointing out here is worth.
It sounds like we do nothing when it's empty.
Maybe:

"called for each lowest-level entry (PTE)"

> + * @reuse_page:		the page which is reused for the tail vmemmap pages.
> + * @reuse_addr:		the virtual address of the @reuse_page page.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + */
> +struct vmemmap_remap_walk {
> +	void (*remap_pte)(pte_t *pte, unsigned long addr,
> +			  struct vmemmap_remap_walk *walk);
> +	struct page *reuse_page;
> +	unsigned long reuse_addr;
> +	struct list_head *vmemmap_pages;
> +};
> +
> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	pte_t *pte;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +
> +	/*
> +	 * The reuse_page is found 'first' in table walk before we start
> +	 * remapping (which is calling @walk->remap_pte).
> +	 */
> +	if (!walk->reuse_page) {
> +		BUG_ON(pte_none(*pte) || walk->reuse_addr != addr);

I would rather have them in separate lines:
BUG_ON(pte_none(*pte));
BUG_ON(walk->reuse_addr != addr));

It helps when trying to figure out when we explode. One could dig in the
registers, but let's make it easier to find out.

> +

[...]


> +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	unsigned long addr = start;
> +	unsigned long next;
> +	pgd_t *pgd;
> +
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
> +	pgd = pgd_offset_k(addr);
> +	do {
> +		BUG_ON(pgd_none(*pgd));
> +
> +		next = pgd_addr_end(addr, end);
> +		vmemmap_p4d_range(pgd, addr, next, walk);
> +	} while (pgd++, addr = next, addr != end);
> +
> +	/*
> +	 * We do not change the mapping of the vmemmap virtual address range
> +	 * [@start, @start + PAGE_SIZE) which belongs to the reuse range.
> +	 * So we not need to flush the TLB.
> +	 */
> +	flush_tlb_kernel_range(start + PAGE_SIZE, end);

I find that comment a bit confusing. I would rather describe what are we
flushing instead of what we are not.


> +}
> +
> +/*
> + * Free a vmemmap page. A vmemmap page can be allocated from the memblock
> + * allocator or buddy allocator. If the PG_reserved flag is set, it means
> + * that it allocated from the memblock allocator, just free it via the
> + * free_bootmem_page(). Otherwise, use __free_page().
> + */
> +static inline void free_vmemmap_page(struct page *page)
> +{
> +	if (PageReserved(page))
> +		free_bootmem_page(page);
> +	else
> +		__free_page(page);
> +}
> +
> +/* Free a list of the vmemmap pages */
> +static void free_vmemmap_page_list(struct list_head *list)
> +{
> +	struct page *page, *next;
> +
> +	list_for_each_entry_safe(page, next, list, lru) {
> +		list_del(&page->lru);
> +		free_vmemmap_page(page);
> +	}
> +}
> +
> +static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	/*
> +	 * Remap the tail pages as read-only to catch illegal write operation
> +	 * to the tail pages.
> +	 */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(walk->reuse_page, pgprot);
> +	struct page *page = pte_page(*pte);
> +
> +	list_add(&page->lru, walk->vmemmap_pages);
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +
> +/**
> + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> + *			to the page which @reuse is mapped to, then free vmemmap
> + *			which the range are mapped to.
> + * @start:	start address of the vmemmap virtual address range that we want
> + *		to remap.
> + * @end:	end address of the vmemmap virtual address range that we want to
> + *		remap.
> + * @reuse:	reuse address.
> + *
> + * Note: This function depends on vmemmap being base page mapped. Please make
> + * sure that the architecture disables PMD mapping of vmemmap pages when calling
> + * this function.

Well, we do not really depend on the architecture to not map the vmemmap range
with PMDs, right? IIUC, that is driven by your boot parameter (patch#5), which
overrides whatever the architecture can do.

Functional changes look good to me, so with all the above fixes, you can add:

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE L3
