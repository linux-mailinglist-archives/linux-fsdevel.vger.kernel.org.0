Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A13A2D5E33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 15:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbgLJOny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 09:43:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:50308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391041AbgLJOnm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:43:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A76BCAE87;
        Thu, 10 Dec 2020 14:43:00 +0000 (UTC)
Date:   Thu, 10 Dec 2020 15:42:56 +0100
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
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 04/12] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20201210144256.GB8538@localhost.localdomain>
References: <20201210035526.38938-1-songmuchun@bytedance.com>
 <20201210035526.38938-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210035526.38938-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 10, 2020 at 11:55:18AM +0800, Muchun Song wrote:
> The free_vmemmap_pages_per_hpage() which indicate that how many vmemmap
> pages associated with a HugeTLB page that can be freed to the buddy
> allocator just returns zero now, because all infrastructure is not
> ready. Once all the infrastructure is ready, we will rework this
> function to support the feature.

I would reword the above to:

"free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
 pages associated with a HugeTLB page can be freed, returns zero for
 now, which means the feature is disabled.
 We will enable it once all the infrastructure is there."

 Or something along those lines.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Overall this looks good to me, and it has seen a considerable
simplification, which is good.
Some nits/questions below:


> +#define vmemmap_hpage_addr_end(addr, end)				 \
> +({									 \
> +	unsigned long __boundary;					 \
> +	__boundary = ((addr) + VMEMMAP_HPAGE_SIZE) & VMEMMAP_HPAGE_MASK; \
> +	(__boundary - 1 < (end) - 1) ? __boundary : (end);		 \
> +})

Maybe add a little comment explaining what are you trying to get here.

> +/*
> + * Walk a vmemmap address to the pmd it maps.
> + */
> +static pmd_t *vmemmap_to_pmd(unsigned long addr)
> +{
> +	pgd_t *pgd;
> +	p4d_t *p4d;
> +	pud_t *pud;
> +	pmd_t *pmd;
> +
> +	pgd = pgd_offset_k(addr);
> +	if (pgd_none(*pgd))
> +		return NULL;
> +
> +	p4d = p4d_offset(pgd, addr);
> +	if (p4d_none(*p4d))
> +		return NULL;
> +
> +	pud = pud_offset(p4d, addr);
> +	if (pud_none(*pud))
> +		return NULL;
> +
> +	pmd = pmd_offset(pud, addr);
> +	if (pmd_none(*pmd))
> +		return NULL;
> +
> +	return pmd;
> +}

I saw that some people suggested to put all the non-hugetlb vmemmap
functions under sparsemem-vmemmap.c, which makes some sense if some
feature is going to re-use this code somehow. (I am not sure if the
recent patches that take advantage of this feature for ZONE_DEVICE needs
something like this).

I do not have a strong opinion on this though.

> +static void vmemmap_reuse_pte_range(struct page *reuse, pte_t *pte,
> +				    unsigned long start, unsigned long end,
> +				    struct list_head *vmemmap_pages)
> +{
> +	/*
> +	 * Make the tail pages are mapped with read-only to catch
> +	 * illegal write operation to the tail pages.
> +	 */
> +	pgprot_t pgprot = PAGE_KERNEL_RO;
> +	pte_t entry = mk_pte(reuse, pgprot);
> +	unsigned long addr;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE, pte++) {
> +		struct page *page;
> +
> +		VM_BUG_ON(pte_none(*pte));

If it is none, page will be NULL and we will crash in the list_add
below?

> +static void vmemmap_remap_range(unsigned long start, unsigned long end,
> +				struct list_head *vmemmap_pages)
> +{
> +	pmd_t *pmd;
> +	unsigned long next, addr = start;
> +	struct page *reuse = NULL;
> +
> +	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
> +	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
> +	VM_BUG_ON((start >> PUD_SHIFT) != (end >> PUD_SHIFT));
This last VM_BUG_ON, is to see if both fall under the same PUD table?

> +
> +	pmd = vmemmap_to_pmd(addr);
> +	BUG_ON(!pmd);

Which is the criteria you followed to make this BUG_ON and VM_BUG_ON
in the check from vmemmap_reuse_pte_range? 

-- 
Oscar Salvador
SUSE L3
