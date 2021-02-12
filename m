Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A6831A1BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 16:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhBLPdY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 10:33:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:54994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbhBLPdP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 10:33:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613143949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sz9isorLitO6+MUwRfzG4d+ngvLUmm93AgjGBsOwKxU=;
        b=NQFIpsht5R8CYBdP29r7QuSh8xFKjDnFvyWczXw2qhMx0h5DJV2E0hbTnJHzVsLWCnPW/h
        fUKCMiIHUHpf17evOuH6L7eqIrEe463x0HpUMjljIPGsL1x/f3VXY/PO91PEzCKiqvWKbB
        xHUcXgycKFZm5Uhlp5UuiIkmNfoz9CY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC145AD29;
        Fri, 12 Feb 2021 15:32:28 +0000 (UTC)
Date:   Fri, 12 Feb 2021 16:32:26 +0100
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
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 4/8] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <YCafit5ruRJ+SL8I@dhcp22.suse.cz>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
 <20210208085013.89436-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208085013.89436-5-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-02-21 16:50:09, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we should allocate the
> vmemmap pages associated with it. But we may cannot allocate vmemmap pages
> when the system is under memory pressure, in this case, we just refuse to
> free the HugeTLB page instead of looping forever trying to allocate the
> pages.

Thanks for simplifying the implementation from your early proposal!

This will not be looping for ever. The allocation will usually trigger
the OOM killer and sooner or later there will be a memory to allocate
from or the system panics when there are no eligible tasks to kill. This
is just a side note.

I think the changelog could benefit from a more explicit documentation
of those error failures. There are different cases when the hugetlb page
is freed. It can be due to an admin intervention (decrease the pool),
overcommit, migration, dissolving and likely some others. Most of them
should be fine to stay in the pool which would just increase the surplus
pages in the pool. I am not so sure about dissolving path.
[...]
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 0209b736e0b4..3d85e3ab7caa 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -169,6 +169,8 @@
>   * (last) level. So this type of HugeTLB page can be optimized only when its
>   * size of the struct page structs is greater than 2 pages.
>   */
> +#define pr_fmt(fmt)	"HugeTLB: " fmt
> +
>  #include "hugetlb_vmemmap.h"
>  
>  /*
> @@ -198,6 +200,34 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
>  	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
>  }
>  
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
> +{
> +	int ret;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return 0;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +
> +	/*
> +	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> +	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> +	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
> +	 * When a HugeTLB page is freed to the buddy allocator, previously
> +	 * discarded vmemmap pages must be allocated and remapping.
> +	 */
> +	ret = vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> +				  GFP_ATOMIC | __GFP_NOWARN | __GFP_THISNODE);

I do not think that this is a good allocation mode. GFP_ATOMIC is a non
sleeping allocation and a medium memory pressure might cause it to
fail prematurely. I do not think this is really an atomic context which
couldn't afford memory reclaim. I also do not think we want to grant
access to memory reserve is reasonable. Just think of a huge number of
hugetlb pages being freed which can deplete the memory reserve for
atomic allocations. I think that you want 
	GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN | __GFP_THISNODE

for an initial implementation. The justification being that the
allocation should at least try to reclaim but it shouldn't cause any
major disruption because the failure is not fatal. If the failure rate
would be impractically high then just drop NORETRY part. You can replace
it by __GFP_RETRY_MAYFAIL but that shouldn't be strictly necessary
because __GFP_THISNODE on its own implies on OOM killer, but that is
kinda ugly to rely on.
-- 
Michal Hocko
SUSE Labs
