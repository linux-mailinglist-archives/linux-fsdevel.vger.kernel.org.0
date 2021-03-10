Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AC3334037
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 15:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232861AbhCJOV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 09:21:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:51996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232776AbhCJOVH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:21:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC7A2AF0D;
        Wed, 10 Mar 2021 14:21:05 +0000 (UTC)
Date:   Wed, 10 Mar 2021 15:21:02 +0100
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
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
Message-ID: <20210310142057.GA12777@linux>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-5-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 08, 2021 at 06:28:02PM +0800, Muchun Song wrote:
> When we free a HugeTLB page to the buddy allocator, we need to allocate
> the vmemmap pages associated with it. However, we may not be able to
> allocate the vmemmap pages when the system is under memory pressure. In
> this case, we just refuse to free the HugeTLB page. This changes behavior
> in some corner cases as listed below:
> 
>  1) Failing to free a huge page triggered by the user (decrease nr_pages).
> 
>     User needs to try again later.
> 
>  2) Failing to free a surplus huge page when freed by the application.
> 
>     Try again later when freeing a huge page next time.
> 
>  3) Failing to dissolve a free huge page on ZONE_MOVABLE via
>     offline_pages().
> 
>     This can happen when we have plenty of ZONE_MOVABLE memory, but
>     not enough kernel memory to allocate vmemmmap pages.  We may even
>     be able to migrate huge page contents, but will not be able to
>     dissolve the source huge page.  This will prevent an offline
>     operation and is unfortunate as memory offlining is expected to
>     succeed on movable zones.  Users that depend on memory hotplug
>     to succeed for movable zones should carefully consider whether the
>     memory savings gained from this feature are worth the risk of
>     possibly not being able to offline memory in certain situations.

This is nice to have it here, but a normal user won't dig in the kernel to
figure this out, so my question is: Do we have this documented somewhere under
Documentation/?
If not, could we document it there? It is nice to warn about this things were
sysadmins can find them.

>  4) Failing to dissolve a huge page on CMA/ZONE_MOVABLE via
>     alloc_contig_range() - once we have that handling in place. Mainly
>     affects CMA and virtio-mem.
> 
>     Similar to 3). virito-mem will handle migration errors gracefully.
>     CMA might be able to fallback on other free areas within the CMA
>     region.
> 
> Vmemmap pages are allocated from the page freeing context. In order for
> those allocations to be not disruptive (e.g. trigger oom killer)
> __GFP_NORETRY is used. hugetlb_lock is dropped for the allocation
> because a non sleeping allocation would be too fragile and it could fail
> too easily under memory pressure. GFP_ATOMIC or other modes to access
> memory reserves is not used because we want to prevent consuming
> reserves under heavy hugetlb freeing.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>

Sorry for jumping in late.
It looks good to me:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Minor request above and below:

> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst |  8 +++
>  include/linux/mm.h                           |  2 +
>  mm/hugetlb.c                                 | 92 +++++++++++++++++++++-------
>  mm/hugetlb_vmemmap.c                         | 32 ++++++----
>  mm/hugetlb_vmemmap.h                         | 23 +++++++
>  mm/sparse-vmemmap.c                          | 75 ++++++++++++++++++++++-
>  6 files changed, 197 insertions(+), 35 deletions(-)

[...]



Could we place a brief comment about what we expect to return here?

> -static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> +int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
> -	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
> +	unsigned long vmemmap_addr = (unsigned long)head;
> +	unsigned long vmemmap_end, vmemmap_reuse;
> +
> +	if (!free_vmemmap_pages_per_hpage(h))
> +		return 0;
> +
> +	vmemmap_addr += RESERVE_VMEMMAP_SIZE;
> +	vmemmap_end = vmemmap_addr + free_vmemmap_pages_size_per_hpage(h);
> +	vmemmap_reuse = vmemmap_addr - PAGE_SIZE;
> +	/*
> +	 * The pages which the vmemmap virtual address range [@vmemmap_addr,
> +	 * @vmemmap_end) are mapped to are freed to the buddy allocator, and
> +	 * the range is mapped to the page which @vmemmap_reuse is mapped to.
> +	 * When a HugeTLB page is freed to the buddy allocator, previously
> +	 * discarded vmemmap pages must be allocated and remapping.
> +	 */
> +	return vmemmap_remap_alloc(vmemmap_addr, vmemmap_end, vmemmap_reuse,
> +				   GFP_KERNEL | __GFP_NORETRY | __GFP_THISNODE);
>  }

-- 
Oscar Salvador
SUSE L3
