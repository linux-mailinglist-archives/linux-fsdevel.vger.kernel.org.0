Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8522F29A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392207AbhALIFo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 03:05:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:45038 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbhALIFo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:05:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADD64AC8F;
        Tue, 12 Jan 2021 08:05:02 +0000 (UTC)
Date:   Tue, 12 Jan 2021 09:04:58 +0100
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
Subject: Re: [PATCH v12 04/13] mm/hugetlb: Free the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210112080453.GA10895@linux>
References: <20210106141931.73931-1-songmuchun@bytedance.com>
 <20210106141931.73931-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106141931.73931-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 06, 2021 at 10:19:22PM +0800, Muchun Song wrote:
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

My memory may betray me after vacation, so bear with me.

> +/*
> + * Any memory allocated via the memblock allocator and not via the
> + * buddy will be marked reserved already in the memmap. For those
> + * pages, we can call this function to free it to buddy allocator.
> + */
> +static inline void free_bootmem_page(struct page *page)
> +{
> +	unsigned long magic = (unsigned long)page->freelist;
> +
> +	/*
> +	 * The reserve_bootmem_region sets the reserved flag on bootmem
> +	 * pages.
> +	 */
> +	VM_WARN_ON_PAGE(page_ref_count(page) != 2, page);

I have been thinking about this some more.
And while I think that this macro might have its room somewhere, I do not
think this is the case.

Here, if we see that page's refcount differs from 2 it means that we had an
earlier corruption.
Now, as a person that has dealt with debugging memory corruptions, I think it
is of no use to proceed further if such corruption happened, as this can lead
to problems somewhere else that can manifest in funny ways, and you will find
yourself scratching your head and trying to work out what happened.

I am aware that this is not the root of the problem here, as someone might have
had to decrease the refcount, but I would definitely change this to its
VM_BUG_ON_* variant.

> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.c

[...]

> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> new file mode 100644
> index 000000000000..6923f03534d5
> --- /dev/null
> +++ b/mm/hugetlb_vmemmap.h

[...]

> +/**
> + * vmemmap_remap_free - remap the vmemmap virtual address range [@start, @end)
> + *			to the page which @reuse is mapped, then free vmemmap
> + *			pages.
> + * @start:	start address of the vmemmap virtual address range.
> + * @end:	end address of the vmemmap virtual address range.
> + * @reuse:	reuse address.
> + */
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
> +	BUG_ON(start != reuse + PAGE_SIZE);

It seems a bit odd to only pass "start" for the BUG_ON.
Also, I kind of dislike the "addr += PAGE_SIZE" in vmemmap_pte_range.

I wonder if adding a ".remap_start_addr" would make more sense.
And adding it here with the vmemmap_remap_walk init.
 

-- 
Oscar Salvador
SUSE L3
