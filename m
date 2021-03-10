Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB63341C2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 16:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhCJPlx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 10:41:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:53824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229851AbhCJPlZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 10:41:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615390884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bO+sT2tMSpXMY6TPV+kBsEIA4iGXD+t9OpjWOBtCQhk=;
        b=NdaImVBGCpcQaixkjGkqa30awoCeRc5HPhvyiPOFSsXDe5FT1dtZY3jaWiAKULzYWtRtUU
        egRRbumGbOuq0D0jaRlgRPA0h6cuDgCqTonOYsrcHWiX/UJsxhie+fR0sg/NJdP90cFo00
        Vf1OI0Q3URcsV5e68gr9S93NtXTZGEY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D45B5ABD7;
        Wed, 10 Mar 2021 15:41:23 +0000 (UTC)
Date:   Wed, 10 Mar 2021 16:41:23 +0100
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
Subject: Re: [PATCH v18 9/9] mm: hugetlb: optimize the code with the help of
 the compiler
Message-ID: <YEjoozshsvKeMAAu@dhcp22.suse.cz>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-10-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308102807.59745-10-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 08-03-21 18:28:07, Muchun Song wrote:
> When the "struct page size" crosses page boundaries we cannot
> make use of this feature. Let free_vmemmap_pages_per_hpage()
> return zero if that is the case, most of the functions can be
> optimized away.

I am confused. Don't you check for this in early_hugetlb_free_vmemmap_param already?
Why do we need any runtime checks?

> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> ---
>  include/linux/hugetlb.h | 3 ++-
>  mm/hugetlb_vmemmap.c    | 7 +++++++
>  mm/hugetlb_vmemmap.h    | 6 ++++++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index c70421e26189..333dd0479fc2 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -880,7 +880,8 @@ extern bool hugetlb_free_vmemmap_enabled;
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
> index 33e42678abe3..1ba1ef45c48c 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -265,6 +265,13 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
>  	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
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
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index cb2bef8f9e73..29aaaf7b741e 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -21,6 +21,12 @@ void hugetlb_vmemmap_init(struct hstate *h);
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
>  #else
> -- 
> 2.11.0
> 

-- 
Michal Hocko
SUSE Labs
