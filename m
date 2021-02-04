Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA0430EC8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 07:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhBDGeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 01:34:37 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12123 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhBDGeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 01:34:36 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWTHk4Fwjz1638H;
        Thu,  4 Feb 2021 14:32:34 +0800 (CST)
Received: from [10.174.179.241] (10.174.179.241) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:33:43 +0800
Subject: Re: [PATCH v14 8/8] mm: hugetlb: optimize the code with the help of
 the compiler
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
 <20210204035043.36609-9-songmuchun@bytedance.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <657ef0d7-8c68-a0f2-de16-d524f0eb4cc7@huawei.com>
Date:   Thu, 4 Feb 2021 14:33:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210204035043.36609-9-songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/2/4 11:50, Muchun Song wrote:
> We cannot optimize if a "struct page" crosses page boundaries. If
> it is true, we can optimize the code with the help of a compiler.
> When free_vmemmap_pages_per_hpage() returns zero, most functions are
> optimized by the compiler.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

I like it. Thanks.
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  include/linux/hugetlb.h |  3 ++-
>  mm/hugetlb_vmemmap.c    | 13 +++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 822ab2f5542a..7bfb06e16298 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -878,7 +878,8 @@ extern bool hugetlb_free_vmemmap_enabled;
>  
>  static inline bool is_hugetlb_free_vmemmap_enabled(void)
>  {
> -	return hugetlb_free_vmemmap_enabled;
> +	return hugetlb_free_vmemmap_enabled &&
> +	       is_power_of_2(sizeof(struct page));
>  }
>  #else
>  static inline bool is_hugetlb_free_vmemmap_enabled(void)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 8efad9978821..068d0e0cebc8 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -211,6 +211,12 @@ early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
>   */
>  static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
>  {
> +	/*
> +	 * This check aims to let the compiler help us optimize the code as
> +	 * much as possible.
> +	 */
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return 0;
>  	return h->nr_free_vmemmap_pages;
>  }
>  
> @@ -280,6 +286,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	BUILD_BUG_ON(NR_USED_SUBPAGE >=
>  		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
>  
> +	/*
> +	 * The compiler can help us to optimize this function to null
> +	 * when the size of the struct page is not power of 2.
> +	 */
> +	if (!is_power_of_2(sizeof(struct page)))
> +		return;
> +
>  	if (!hugetlb_free_vmemmap_enabled)
>  		return;
>  
> 

