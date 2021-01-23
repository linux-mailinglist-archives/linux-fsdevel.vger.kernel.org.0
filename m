Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D19301769
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Jan 2021 18:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbhAWRxx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Jan 2021 12:53:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39526 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAWRxt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Jan 2021 12:53:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14175AD18;
        Sat, 23 Jan 2021 17:53:07 +0000 (UTC)
Date:   Sat, 23 Jan 2021 18:52:59 +0100
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
Subject: Re: [PATCH v13 03/12] mm: hugetlb: free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210123175259.GA3555@localhost.localdomain>
References: <20210117151053.24600-1-songmuchun@bytedance.com>
 <20210117151053.24600-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117151053.24600-4-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jan 17, 2021 at 11:10:44PM +0800, Muchun Song wrote:
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

Overall looks good to me.
A few nits below, plus what Mike has already said.

I was playing the other day (just for un) to see how hard would be to adapt
this to ppc64 but did not have the time :-)

> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Free some vmemmap pages of HugeTLB
> + *
> + * Copyright (c) 2020, Bytedance. All rights reserved.
> + *
> + *     Author: Muchun Song <songmuchun@bytedance.com>
> + *
> + * The struct page structures (page structs) are used to describe a physical
> + * page frame. By default, there is a one-to-one mapping from a page frame to
> + * it's corresponding page struct.
> + *
> + * The HugeTLB pages consist of multiple base page size pages and is supported
"HugeTLB pages ..."

> + * When the system boot up, every HugeTLB page has more than one struct page
> + * structs whose size is (unit: pages):
              ^^^^ which?
> + *
> + *    struct_size = HugeTLB_Size / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> + *
> + * Where HugeTLB_Size is the size of the HugeTLB page. We know that the size
> + * of the HugeTLB page is always n times PAGE_SIZE. So we can get the following
> + * relationship.
> + *
> + *    HugeTLB_Size = n * PAGE_SIZE
> + *
> + * Then,
> + *
> + *    struct_size = n * PAGE_SIZE / PAGE_SIZE * sizeof(struct page) / PAGE_SIZE
> + *                = n * sizeof(struct page) / PAGE_SIZE
> + *
> + * We can use huge mapping at the pud/pmd level for the HugeTLB page.
> + *
> + * For the HugeTLB page of the pmd level mapping, then
> + *
> + *    struct_size = n * sizeof(struct page) / PAGE_SIZE
> + *                = PAGE_SIZE / sizeof(pte_t) * sizeof(struct page) / PAGE_SIZE
> + *                = sizeof(struct page) / sizeof(pte_t)
> + *                = 64 / 8
> + *                = 8 (pages)
> + *
> + * Where n is how many pte entries which one page can contains. So the value of
> + * n is (PAGE_SIZE / sizeof(pte_t)).
> + *
> + * This optimization only supports 64-bit system, so the value of sizeof(pte_t)
> + * is 8. And this optimization also applicable only when the size of struct page
> + * is a power of two. In most cases, the size of struct page is 64 (e.g. x86-64
> + * and arm64). So if we use pmd level mapping for a HugeTLB page, the size of
> + * struct page structs of it is 8 pages whose size depends on the size of the
> + * base page.
> + *
> + * For the HugeTLB page of the pud level mapping, then
> + *
> + *    struct_size = PAGE_SIZE / sizeof(pmd_t) * struct_size(pmd)
> + *                = PAGE_SIZE / 8 * 8 (pages)
> + *                = PAGE_SIZE (pages)

I would try to condense above information and focus on what are the
key points you want people to get.
E.g: A 2MB HugeTLB page on x86_64 consists in 8 page frames while 1GB
HugeTLB page consists in 4096.
If you do not want to be that specific you can always write down the
formula, and maybe put the X86_64 example at the end.
But as I said, I would try to make it more brief.

Maybe others disagree though.


> + *
> + * Where the struct_size(pmd) is the size of the struct page structs of a
> + * HugeTLB page of the pmd level mapping.

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

I would like to see a comment there explaining why those variables get
they value they do.

> +/**
> + * vmemmap_remap_walk - walk vmemmap page table
> + *
> + * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
> + * @reuse_page:		the page which is reused for the tail vmemmap pages.
> + * @reuse_addr:		the virtual address of the @reuse_page page.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.

Let us align the tabs there.

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
> +	if (walk->reuse_addr == addr) {
> +		BUG_ON(pte_none(*pte));

If it is found first, would not be

        if (!walk->reuse_page) {
                BUG_ON(walk->reuse_addr != addr)
                ...
        }

more intuitive?


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
> +	 * [@start, @start + PAGE_SIZE) which is belong to the reuse range.
                                        "which belongs to"

> +	 * So we not need to flush the TLB.
> +	 */
> +	flush_tlb_kernel_range(start - PAGE_SIZE, end);

you already commented on on this one.

> +/**
> + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> + *			to the page which @reuse is mapped, then free vmemmap
> + *			pages.
> + * @start:	start address of the vmemmap virtual address range.

Well, it is the start address of the range we want to remap.
Reading it made me think that it is really the __start__ address
of the vmemmap range.

> +void vmemmap_remap_free(unsigned long start, unsigned long end,
> +			unsigned long reuse)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_remap_pte,
> +		.reuse_addr	= reuse,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	/*
> +	 * In order to make remapping routine most efficient for the huge pages,
> +	 * the routine of vmemmap page table walking has the following rules
> +	 * (see more details from the vmemmap_pte_range()):
> +	 *
> +	 * - The @reuse address is part of the range that we are walking.
> +	 * - The @reuse address is the first in the complete range.
> +	 *
> +	 * So we need to make sure that @start and @reuse meet the above rules.

You say that "reuse" and "start" need to meet some  rules, but in the
paragraph above you only seem to point "reuse" rules?


-- 
Oscar Salvador
SUSE L3
