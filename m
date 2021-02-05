Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A723105E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 08:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhBEHbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 02:31:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12467 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBEHah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 02:30:37 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DX6Ts6KNqzjKkV;
        Fri,  5 Feb 2021 15:28:33 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 15:29:44 +0800
Subject: Re: [PATCH v14 6/8] mm: hugetlb: introduce nr_free_vmemmap_pages in
 the struct hstate
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
 <20210204035043.36609-7-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <42c8272a-f170-b27e-af5e-a7cb7777a728@huawei.com>
Date:   Fri, 5 Feb 2021 15:29:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204035043.36609-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/4 11:50, Muchun Song wrote:
> All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
> field in the hstate to indicate how many vmemmap pages associated with
> a HugeTLB page that can be freed to buddy allocator. And initialize it
> in the hugetlb_vmemmap_init(). This patch is actual enablement of the
> feature.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/hugetlb.h |  3 +++
>  mm/hugetlb.c            |  1 +
>  mm/hugetlb_vmemmap.c    | 30 ++++++++++++++++++++++++++----
>  mm/hugetlb_vmemmap.h    |  5 +++++
>  4 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ad249e56ac49..775aea53669a 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -560,6 +560,9 @@ struct hstate {
>  	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>  	unsigned int free_huge_pages_node[MAX_NUMNODES];
>  	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> +#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
> +	unsigned int nr_free_vmemmap_pages;
> +#endif
>  #ifdef CONFIG_CGROUP_HUGETLB
>  	/* cgroup control files */
>  	struct cftype cgroup_files_dfl[7];
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 5518283aa667..04dde2b71f3e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3220,6 +3220,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>  	h->next_nid_to_free = first_memory_node;
>  	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>  					huge_page_size(h)/1024);
> +	hugetlb_vmemmap_init(h);
>  
>  	parsed_hstate = h;
>  }
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 224a3cb69bf9..36ebd677e606 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -208,13 +208,10 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
>  /*
>   * How many vmemmap pages associated with a HugeTLB page that can be freed
>   * to the buddy allocator.
> - *
> - * Todo: Returns zero for now, which means the feature is disabled. We will
> - * enable it once all the infrastructure is there.
>   */
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
> -	return 0;
> +	return h->nr_free_vmemmap_pages;
>  }
>  
>  static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
> @@ -269,3 +266,28 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  	 */
>  	vmemmap_remap_free(vmemmap_addr, vmemmap_end, vmemmap_reuse);
>  }
> +
> +void __init hugetlb_vmemmap_init(struct hstate *h)
> +{
> +	unsigned int nr_pages = pages_per_huge_page(h);
> +	unsigned int vmemmap_pages;
> +
> +	if (!hugetlb_free_vmemmap_enabled)
> +		return;
> +
> +	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
> +	/*
> +	 * The head page and the first tail page are not to be freed to buddy
> +	 * allocator, the other pages will map to the first tail page, so they
> +	 * can be freed.
> +	 *
> +	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
> +	 * on some architectures (e.g. aarch64). See Documentation/arm64/
> +	 * hugetlbpage.rst for more details.
> +	 */
> +	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
> +		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;

Not a problem. Should we set h->nr_free_vmemmap_pages to 0 in 'else' case explicitly ?

Anyway, looks good to me. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> +
> +	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
> +		h->name);
> +}
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 6f89a9eed02c..02a21604ef1d 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -14,6 +14,7 @@
>  int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
>  			    gfp_t gfp_mask);
>  void free_huge_page_vmemmap(struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_init(struct hstate *h);
>  #else
>  static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
>  					  gfp_t gfp_mask)
> @@ -24,5 +25,9 @@ static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head,
>  static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
>  {
>  }
> +
> +static inline void hugetlb_vmemmap_init(struct hstate *h)
> +{
> +}
>  #endif /* CONFIG_HUGETLB_PAGE_FREE_VMEMMAP */
>  #endif /* _LINUX_HUGETLB_VMEMMAP_H */
> 

