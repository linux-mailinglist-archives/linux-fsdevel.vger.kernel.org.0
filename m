Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378333341B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 16:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhCJPkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 10:40:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:52756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231150AbhCJPjw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:39:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615390791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mg9ts1yU6xrUwnU8b/NkRK6/aMveNTB6Z6AHbEN9iNQ=;
        b=O3VenPPRDcQspUbMJp96sOidOexUFuSZLT3J2eFfkgiS9S0zUM4/Ivo6j+CWSVWuxXxywQ
        vFhkaQ7Is3b0Sk+fRXqyCeO5x7eg6ZV1YZTnr3Rvl59lopZ/UJKxr8/xrHDk+ygmv/Wf3X
        Ooo2dfHy0yT4iv9q1ZkGcn3i8LhhogA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 194BAAD72;
        Wed, 10 Mar 2021 15:39:51 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:39:48 +0100
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
        linux-fsdevel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: Re: [PATCH v18 8/9] mm: hugetlb: gather discrete indexes of tail page
Message-ID: <YEjoRBKakozoscVk@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-9-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-9-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 18:28:06, Muchun Song wrote:
> For HugeTLB page, there are more metadata to save in the struct page.
> But the head struct page cannot meet our needs, so we have to abuse
> other tail struct page to store the metadata. In order to avoid
> conflicts caused by subsequent use of more tail struct pages, we can
> gather these discrete indexes of tail struct page. In this case, it
> will be easier to add a new tail page index later.
> 
> There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
> so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

OK, so this is what I have asked in an earlier patch. Good. I would
reorder and make this patch prior to the one relying on the fact though.
 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/hugetlb.h        | 24 ++++++++++++++++++++++--
>  include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
>  mm/hugetlb.c                   |  6 +++---
>  mm/hugetlb_vmemmap.c           |  8 ++++++++
>  4 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index a4d80f7263fc..c70421e26189 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -28,6 +28,26 @@ typedef struct { unsigned long pd; } hugepd_t;
>  #include <linux/shm.h>
>  #include <asm/tlbflush.h>
>  
> +/*
> + * For HugeTLB page, there are more metadata to save in the struct page. But
> + * the head struct page cannot meet our needs, so we have to abuse other tail
> + * struct page to store the metadata. In order to avoid conflicts caused by
> + * subsequent use of more tail struct pages, we gather these discrete indexes
> + * of tail struct page here.
> + */
> +enum {
> +	SUBPAGE_INDEX_SUBPOOL = 1,	/* reuse page->private */
> +#ifdef CONFIG_CGROUP_HUGETLB
> +	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
> +	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
> +	__MAX_CGROUP_SUBPAGE_INDEX = SUBPAGE_INDEX_CGROUP_RSVD,
> +#endif
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +	SUBPAGE_INDEX_HWPOISON,		/* reuse page->private */
> +#endif
> +	__NR_USED_SUBPAGE,
> +};
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> @@ -607,13 +627,13 @@ extern unsigned int default_hstate_idx;
>   */
>  static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
>  {
> -	return (struct hugepage_subpool *)(hpage+1)->private;
> +	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
>  }
>  
>  static inline void hugetlb_set_page_subpool(struct page *hpage,
>  					struct hugepage_subpool *subpool)
>  {
> -	set_page_private(hpage+1, (unsigned long)subpool);
> +	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
>  }
>  
>  static inline struct hstate *hstate_file(struct file *f)
> diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
> index 2ad6e92f124a..54ec689e3c9c 100644
> --- a/include/linux/hugetlb_cgroup.h
> +++ b/include/linux/hugetlb_cgroup.h
> @@ -21,15 +21,16 @@ struct hugetlb_cgroup;
>  struct resv_map;
>  struct file_region;
>  
> +#ifdef CONFIG_CGROUP_HUGETLB
>  /*
>   * Minimum page order trackable by hugetlb cgroup.
>   * At least 4 pages are necessary for all the tracking information.
> - * The second tail page (hpage[2]) is the fault usage cgroup.
> - * The third tail page (hpage[3]) is the reservation usage cgroup.
> + * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
> + * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
> + * is the reservation usage cgroup.
>   */
> -#define HUGETLB_CGROUP_MIN_ORDER	2
> +#define HUGETLB_CGROUP_MIN_ORDER order_base_2(__MAX_CGROUP_SUBPAGE_INDEX + 1)
>  
> -#ifdef CONFIG_CGROUP_HUGETLB
>  enum hugetlb_memory_event {
>  	HUGETLB_MAX,
>  	HUGETLB_NR_MEMORY_EVENTS,
> @@ -66,9 +67,9 @@ __hugetlb_cgroup_from_page(struct page *page, bool rsvd)
>  	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
>  		return NULL;
>  	if (rsvd)
> -		return (struct hugetlb_cgroup *)page[3].private;
> +		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
>  	else
> -		return (struct hugetlb_cgroup *)page[2].private;
> +		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
>  }
>  
>  static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
> @@ -90,9 +91,11 @@ static inline int __set_hugetlb_cgroup(struct page *page,
>  	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
>  		return -1;
>  	if (rsvd)
> -		page[3].private = (unsigned long)h_cg;
> +		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
> +				 (unsigned long)h_cg);
>  	else
> -		page[2].private = (unsigned long)h_cg;
> +		set_page_private(page + SUBPAGE_INDEX_CGROUP,
> +				 (unsigned long)h_cg);
>  	return 0;
>  }
>  
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c221b937be17..4956880a7861 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1312,7 +1312,7 @@ static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
>  	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
>  		return;
>  
> -	page = head + page_private(head + 4);
> +	page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
>  
>  	/*
>  	 * Move PageHWPoison flag from head page to the raw error page,
> @@ -1331,7 +1331,7 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
>  		return;
>  
>  	if (free_vmemmap_pages_per_hpage(h)) {
> -		set_page_private(head + 4, page - head);
> +		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
>  	} else if (page != head) {
>  		/*
>  		 * Move PageHWPoison flag from head page to the raw error page,
> @@ -1347,7 +1347,7 @@ static inline void hwpoison_subpage_clear(struct hstate *h, struct page *head)
>  	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
>  		return;
>  
> -	set_page_private(head + 4, 0);
> +	set_page_private(head + SUBPAGE_INDEX_HWPOISON, 0);
>  }
>  #else
>  static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index b65f0d5189bd..33e42678abe3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -257,6 +257,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int nr_pages = pages_per_huge_page(h);
>  	unsigned int vmemmap_pages;
>  
> +	/*
> +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> +	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
> +	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> +	 */
> +	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
> +		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> +
>  	if (!hugetlb_free_vmemmap_enabled)
>  		return;
>  
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
