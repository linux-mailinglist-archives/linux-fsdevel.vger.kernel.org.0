Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BA22DE042
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Dec 2020 10:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388811AbgLRJHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Dec 2020 04:07:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:35508 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbgLRJHT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:07:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5572DABC6;
        Fri, 18 Dec 2020 09:06:37 +0000 (UTC)
Date:   Fri, 18 Dec 2020 10:06:31 +0100
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
Subject: Re: [PATCH v10 10/11] mm/hugetlb: Gather discrete indexes of tail
 page
Message-ID: <20201218090631.GA3623@localhost.localdomain>
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-11-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121303.13386-11-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 17, 2020 at 08:13:02PM +0800, Muchun Song wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c02f49959fd..78dd88dda857 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1360,7 +1360,7 @@ static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
>  	if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
>  		return;
>  
> -	page = head + page_private(head + 4);
> +	page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
>  
>  	/*
>  	 * Move PageHWPoison flag from head page to the raw error page,
> @@ -1379,7 +1379,7 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
>  		return;
>  
>  	if (free_vmemmap_pages_per_hpage(h)) {
> -		set_page_private(head + 4, page - head);
> +		set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);

Ok, I was too eager here.

If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is not set for whatever reason
(e.g: CONFIG_MEMORY_HOTREMOVE is disabled), when you convert "+4"
to its index (SUBPAGE_INDEX_HWPOISON), this will no longer build
since we only define SUBPAGE_INDEX_HWPOISON when the config
option CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set.

Different things can be done to fix this:

e.g:

 - Define a two different hwpoison_subpage_{deliver,set}
   and have them under
   #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
   ...
   #else
   ...
   #endif

 - Work it around as is with IS_ENABLED(CONFIG_HUGETLB_...
 - Have a common entry and decide depending on whether
   the config is enabled.

I guess option #1 might be cleaner.

-- 
Oscar Salvador
SUSE L3
