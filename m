Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810992BA486
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 09:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKTIWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 03:22:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:38614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgKTIWP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 03:22:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605860534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUWjaY/+C4/6mXNmnlJHLKENTydPJvcWDaqoKy/+AxE=;
        b=p2XZg5MGbqcIH9+gJr/UY0TtqQN1xa16G6tXYzAYrZ2AA7tuiXFa31IuvEppxtLLOF5kPR
        5IgmuM1D3vxPsWQ9LUUS+e8bDEGBS4w53qh9+3VuibKpd4lt9nfLbFaeZ8kAUbSeEAeZ/j
        tK5AzmtT01vq/WDbRwSFRHv85NzQzuU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1C3ADACB0;
        Fri, 20 Nov 2020 08:22:14 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:22:12 +0100
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
        osalvador@suse.de, song.bao.hua@hisilicon.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] mm/hugetlb: Add a kernel parameter
 hugetlb_free_vmemmap
Message-ID: <20201120082212.GG3200@dhcp22.suse.cz>
References: <20201120064325.34492-1-songmuchun@bytedance.com>
 <20201120064325.34492-18-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120064325.34492-18-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 20-11-20 14:43:21, Muchun Song wrote:
> Add a kernel parameter hugetlb_free_vmemmap to disable the feature of
> freeing unused vmemmap pages associated with each hugetlb page on boot.

As replied to the config patch. This is fine but I would argue that the
default should be flipped. Saving memory is nice but it comes with
overhead and therefore should be an opt-in. The config option should
only guard compile time dependencies not a user choice.

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
>  Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
>  mm/hugetlb_vmemmap.c                            | 21 +++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 5debfe238027..ccf07293cb63 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1551,6 +1551,15 @@
>  			Documentation/admin-guide/mm/hugetlbpage.rst.
>  			Format: size[KMG]
>  
> +	hugetlb_free_vmemmap=
> +			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
> +			this controls freeing unused vmemmap pages associated
> +			with each HugeTLB page.
> +			Format: { on (default) | off }
> +
> +			on:  enable the feature
> +			off: disable the feature
> +
>  	hung_task_panic=
>  			[KNL] Should the hung task detector generate panics.
>  			Format: 0 | 1
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index f7b1c7462991..7d6129ee97dd 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -145,6 +145,9 @@ default_hugepagesz
>  
>  	will all result in 256 2M huge pages being allocated.  Valid default
>  	huge page size is architecture dependent.
> +hugetlb_free_vmemmap
> +	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this disables freeing
> +	unused vmemmap pages associated each HugeTLB page.
>  
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 3629165d8158..c958699d1393 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -144,6 +144,22 @@ static inline bool vmemmap_pmd_huge(pmd_t *pmd)
>  }
>  #endif
>  
> +static bool hugetlb_free_vmemmap_disabled __initdata;
> +
> +static int __init early_hugetlb_free_vmemmap_param(char *buf)
> +{
> +	if (!buf)
> +		return -EINVAL;
> +
> +	if (!strcmp(buf, "off"))
> +		hugetlb_free_vmemmap_disabled = true;
> +	else if (strcmp(buf, "on"))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
> +
>  static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
>  {
>  	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
> @@ -541,6 +557,11 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	unsigned int order = huge_page_order(h);
>  	unsigned int vmemmap_pages;
>  
> +	if (hugetlb_free_vmemmap_disabled) {
> +		pr_info("disable free vmemmap pages for %s\n", h->name);
> +		return;
> +	}
> +
>  	vmemmap_pages = ((1 << order) * sizeof(struct page)) >> PAGE_SHIFT;
>  	/*
>  	 * The head page and the first tail page are not to be freed to buddy
> -- 
> 2.11.0

-- 
Michal Hocko
SUSE Labs
