Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAD12DFA5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Dec 2020 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgLUJsA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 04:48:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:38070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgLUJof (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 04:44:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A0714AD10;
        Mon, 21 Dec 2020 09:11:27 +0000 (UTC)
Date:   Mon, 21 Dec 2020 10:11:23 +0100
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
Subject: Re: [PATCH v10 03/11] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201221091123.GB14343@linux>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-4-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121303.13386-4-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 08:12:55PM +0800, Muchun Song wrote:
> +static inline void free_bootmem_page(struct page *page)
> +{
> +	unsigned long magic = (unsigned long)page->freelist;
> +
> +	/*
> +	 * The reserve_bootmem_region sets the reserved flag on bootmem
> +	 * pages.
> +	 */
> +	VM_WARN_ON(page_ref_count(page) != 2);
> +
> +	if (magic == SECTION_INFO || magic == MIX_SECTION_INFO)
> +		put_page_bootmem(page);
> +	else
> +		VM_WARN_ON(1);

Ideally, I think we want to see what how the page looks since its state
is not what we expected, so maybe join both conditions and use dump_page().

> + * By removing redundant page structs for HugeTLB pages, memory can returned to
                                                                     ^^ be
> + * the buddy allocator for other uses.

[...]

> +void free_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return;
> +
> +	vmemmap_remap_free(vmemmap_addr + RESERVE_VMEMMAP_SIZE,
> +			   free_vmemmap_pages_size_per_hpage(h));

I am not sure what others think, but I would like to see vmemmap_remap_free taking
three arguments: start, end, and reuse addr, e.g:

 void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
      unsigned long vmemmap_addr = (unsigned long)head;
      unsigned long vmemmap_end, vmemmap_reuse;
      
      if (!free_vmemmap_pages_per_hpage(h))
              return;

      vmemmap_addr += RESERVE_MEMMAP_SIZE;
      vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
      vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
 
      vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
 }

The reason for me to do this is to let the callers of vmemmap_remap_free decide
__what__ they want to remap.

More on this below.


> +static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
> +			      unsigned long end,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	pte_t *pte;
> +
> +	pte = pte_offset_kernel(pmd, addr);
> +
> +	if (walk->reuse_addr == addr) {
> +		BUG_ON(pte_none(*pte));
> +		walk->reuse_page = pte_page(*pte++);
> +		addr += PAGE_SIZE;
> +	}

Although it is quite obvious, a brief comment here pointing out what are we
doing and that this is meant to be set only once would be nice.


> +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	unsigned long addr = start - PAGE_SIZE;
> +	unsigned long next;
> +	pgd_t *pgd;
> +
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +
> +	walk->reuse_page = NULL;
> +	walk->reuse_addr = addr;

With the change I suggested above, struct vmemmap_remap_walk should be
initialitzed at once in vmemmap_remap_free, so this should not longer be needed.
(And btw, you do not need to set reuse_page to NULL, the way you init the struct
in vmemmap_remap_free makes sure to null any field you do not explicitly set).


> +static void vmemmap_remap_pte(pte_t *pte, unsigned long addr,
> +			      struct vmemmap_remap_walk *walk)
> +{
> +	/*
> +	 * Make the tail pages are mapped with read-only to catch
> +	 * illegal write operation to the tail pages.
        "Remap the tail pages as read-only to ..."

> +	 */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(walk->reuse_page, pgprot);
> +	struct page *page;
> +
> +	page = pte_page(*pte);

 struct page *page = pte_page(*pte);

since you did the same for the other two.

> +	list_add(&page->lru, walk->vmemmap_pages);
> +
> +	set_pte_at(&init_mm, addr, pte, entry);
> +}
> +
> +/**
> + * vmemmap_remap_free - remap the vmemmap virtual address range
> + *                      [start, start + size) to the page which
> + *                      [start - PAGE_SIZE, start) is mapped,
> + *                      then free vmemmap pages.
> + * @start:	start address of the vmemmap virtual address range
> + * @size:	size of the vmemmap virtual address range
> + */
> +void vmemmap_remap_free(unsigned long start, unsigned long size)
> +{
> +	unsigned long end = start + size;
> +	LIST_HEAD(vmemmap_pages);
> +
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_remap_pte,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};

As stated above, this would become:

 void vmemmap_remap_free(unsigned long start, unsigned long end,
                         usigned long reuse)
 {
       LIST_HEAD(vmemmap_pages);
       struct vmemmap_remap_walk walk = {
               .reuse_addr = reuse,
               .remap_pte = vmemmap_remap_pte,
               .vmemmap_pages = &vmemmap_pages,
       };

  You might have had your reasons to do this way, but this looks more natural
  to me, with the plus that callers of vmemmap_remap_free can specify
  what they want to remap.


-- 
Oscar Salvador
SUSE L3
