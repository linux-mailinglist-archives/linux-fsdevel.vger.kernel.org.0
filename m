Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9C3105E5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 08:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhBEHbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 02:31:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11682 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhBEHbU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:31:20 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX6V65LCfzlH7G;
        Fri,  5 Feb 2021 15:28:46 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 15:30:18 +0800
Subject: Re: [PATCH v14 7/8] mm: hugetlb: gather discrete indexes of tail page
To:     Muchun Song <songmuchun@bytedance.com>
CC:     <duanxiongchun@bytedance.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <corbet@lwn.net>,
        <mike.kravetz@oracle.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <viro@zeniv.linux.org.uk>,
        <akpm@linux-foundation.org>, <paulmck@kernel.org>,
        <mchehab+huawei@kernel.org>, <pawan.kumar.gupta@linux.intel.com>,
        <rdunlap@infradead.org>, <oneukum@suse.com>,
        <anshuman.khandual@arm.com>, <jroedel@suse.de>,
        <almasrymina@google.com>, <rientjes@google.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <mhocko@suse.com>,
        <song.bao.hua@hisilicon.com>, <david@redhat.com>,
        <naoya.horiguchi@nec.com>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-8-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1312358b-f065-4525-bbdf-25d011c72395@huawei.com>
Date:   Fri, 5 Feb 2021 15:30:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204035043.36609-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/4 11:50, Muchun Song wrote:
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
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  include/linux/hugetlb.h        | 20 ++++++++++++++++++--
>  include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
>  mm/hugetlb_vmemmap.c           |  8 ++++++++
>  3 files changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 775aea53669a..822ab2f5542a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -28,6 +28,22 @@ typedef struct { unsigned long pd; } hugepd_t;
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
> +#endif
> +	NR_USED_SUBPAGE,
> +};
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> @@ -607,13 +623,13 @@ extern unsigned int default_hstate_idx;
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
> index 2ad6e92f124a..c0cae6a704f2 100644
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
> +#define HUGETLB_CGROUP_MIN_ORDER	order_base_2(NR_USED_SUBPAGE)
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
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 36ebd677e606..8efad9978821 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -272,6 +272,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int nr_pages = pages_per_huge_page(h);
>  	unsigned int vmemmap_pages;
>  
> +	/*
> +	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
> +	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
> +	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
> +	 */
> +	BUILD_BUG_ON(NR_USED_SUBPAGE >=
> +		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
> +
>  	if (!hugetlb_free_vmemmap_enabled)
>  		return;
>  
> 

