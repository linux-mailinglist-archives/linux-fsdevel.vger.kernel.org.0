Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B001A310771
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 10:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhBEJNP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 04:13:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:36122 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229760AbhBEJKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:10:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 039F7AFD7;
        Fri,  5 Feb 2021 09:09:34 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:09:28 +0100
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
Subject: Re: [PATCH v14 8/8] mm: hugetlb: optimize the code with the help of
 the compiler
Message-ID: <20210205090924.GA14537@linux>
References: <20210204035043.36609-1-songmuchun@bytedance.com>
 <20210204035043.36609-9-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204035043.36609-9-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 11:50:43AM +0800, Muchun Song wrote:
> We cannot optimize if a "struct page" crosses page boundaries. If
> it is true, we can optimize the code with the help of a compiler.
> When free_vmemmap_pages_per_hpage() returns zero, most functions are
> optimized by the compiler.

"When the "struct page size" crosses page boundaries we cannot
 make use of this feature.
 Let free_vmemmap_pages_per_hpage() return zero if that is the case,
 most of the functions can be optimized away."

I think the above is more clear, but just a suggestion.
 

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

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
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE L3
