Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02C414D6B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 07:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgA3Grz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 01:47:55 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18475 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgA3Gry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:47:54 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e327c020000>; Wed, 29 Jan 2020 22:47:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 22:47:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 22:47:51 -0800
Received: from [10.2.165.69] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 06:47:50 +0000
Subject: Re: [PATCH v2 4/8] mm/gup: track FOLL_PIN pages
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-doc@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200129032417.3085670-1-jhubbard@nvidia.com>
 <20200129032417.3085670-5-jhubbard@nvidia.com>
 <20200129135153.knie7ptvsxcgube6@box>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0be743df-e9af-6da9-c593-9e25ab194acf@nvidia.com>
Date:   Wed, 29 Jan 2020 22:44:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129135153.knie7ptvsxcgube6@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580366850; bh=m5ZYa1RzG8BG4yZe/mCIbkE+2pLztusMpL2EcpkuwpM=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DfCJGZ30wx6ffwipieuAOWILh3vNbWcrGfVRxKl+9VcaTHijWuHf3Ztap0Qs/ZzSE
         jlYYXnyHUbRrV2lLIG3EvAgRcgG4m0yKsHIuovSzaJH625Q2mqn5Yb0ttzcjFmZGOk
         B/Hqoduzq/m38LlJP1Zs3BgosacIiHJ81R6jd7XdQ4OHZd/Olj5Hf4n78hKNKxaUpK
         ipWOgzBybeB3ZlF50DErDdj41bRNHEh8hvu+X39l0QBHxpTY3uT9tzRex1D4Oky8zd
         2Wfj3GnMXgsDPRofyelZncFN8qhbbhPuaiJyffDKIvdpWjhNKliClhG0xNij3oHGEy
         MrstvvpMDWuJw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/29/20 5:51 AM, Kirill A. Shutemov wrote:
> On Tue, Jan 28, 2020 at 07:24:13PM -0800, John Hubbard wrote:
>> Add tracking of pages that were pinned via FOLL_PIN. This tracking is
>> implemented via overloading of page->_refcount: pins are added by
>> adding GUP_PIN_COUNTING_BIAS (1024) to the refcount. This provides a
>> fuzzy indication of pinning, and it can have false positives (and that's
>> OK). Please see the pre-existing
>> Documentation/core-api/pin_user_pages.rst for details.
>>
>> As mentioned in pin_user_pages.rst, callers who effectively set FOLL_PIN
>> (typically via pin_user_pages*()) are required to ultimately free such
>> pages via unpin_user_page().
>>
>> Please also not the limitation, discussed in pin_user_pages.rst under
> 
> s/not/note/

Fixed, thanks!

...
>>   
>> +/**
>> + * page_dma_pinned() - report if a page is pinned for DMA.
>> + *
>> + * This function checks if a page has been pinned via a call to
>> + * pin_user_pages*().
>> + *
>> + * For non-huge pages, the return value is partially fuzzy: false is not fuzzy,
>> + * because it means "definitely not pinned for DMA", but true means "probably
>> + * pinned for DMA, but possibly a false positive due to having at least
>> + * GUP_PIN_COUNTING_BIAS worth of normal page references".
>> + *
>> + * False positives are OK, because: a) it's unlikely for a page to get that many
>> + * refcounts, and b) all the callers of this routine are expected to be able to
>> + * deal gracefully with a false positive.
> 
> I wounder if we should reverse the logic and name -- page_not_dma_pinned()
> or something -- too emphasise that we can only know for sure when the page
> is not pinned, but not necessary when it is.
> 

This is an interesting point. I agree that it's worth maybe adding information
into the function name, but I'd like to keep the bool "positive", because there
will be a number of callers that ask "if it is possibly dma-pinned, then ...".
So combining that, how about this function name:

	page_maybe_dma_pinned()

, which I could live with and I think would be acceptable?

>> + *
>> + * For more information, please see Documentation/vm/pin_user_pages.rst.
>> + *
>> + * @page:	pointer to page to be queried.
>> + * @Return:	True, if it is likely that the page has been "dma-pinned".
>> + *		False, if the page is definitely not dma-pinned.
>> + */
>> +static inline bool page_dma_pinned(struct page *page)
>> +{
>> +	/*
>> +	 * page_ref_count() is signed. If that refcount overflows, then
>> +	 * page_ref_count() returns a negative value, and callers will avoid
>> +	 * further incrementing the refcount.
>> +	 *
>> +	 * Here, for that overflow case, use the signed bit to count a little
>> +	 * bit higher via unsigned math, and thus still get an accurate result
>> +	 * from page_dma_pinned().
>> +	 */
>> +	return ((unsigned int)page_ref_count(compound_head(page))) >=
>> +		GUP_PIN_COUNTING_BIAS;
> 
> Do you expect it too be called on tail pages?


Yes, we definitely cannot rule that out.


> 
>> +}
>> +
>>   #if defined(CONFIG_SPARSEMEM) && !defined(CONFIG_SPARSEMEM_VMEMMAP)
>>   #define SECTION_IN_PAGE_FLAGS
>>   #endif
>> diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
>> index 14d14beb1f7f..b9cbe553d1e7 100644
>> --- a/include/linux/page_ref.h
>> +++ b/include/linux/page_ref.h
>> @@ -102,6 +102,16 @@ static inline void page_ref_sub(struct page *page, int nr)
>>   		__page_ref_mod(page, -nr);
>>   }
>>   
>> +static inline int page_ref_sub_return(struct page *page, int nr)
>> +{
>> +	int ret = atomic_sub_return(nr, &page->_refcount);
>> +
>> +	if (page_ref_tracepoint_active(__tracepoint_page_ref_mod))
>> +		__page_ref_mod(page, -nr);
>> +
>> +	return ret;
>> +}
>> +
> 
> I see opportunity to split the patch further.


ah, OK. I wasn't sure how far to go before I get tagged for "excessive
patch splitting"! haha. Anyway, are you suggesting to put the
page_ref_sub_return() routine into it's own patch?

Another thing to split out would be adding the flags to the remaining
functions, such as undo_dev_pagemap(). That burns quite a few lines of
diff. Anything else to split out?

> 
>>   static inline void page_ref_inc(struct page *page)
>>   {
>>   	atomic_inc(&page->_refcount);
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 9e117998274c..7a96490dcc54 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -44,6 +44,136 @@ static inline struct page *try_get_compound_head(struct page *page, int refs)
>>   	return head;
>>   }
>>   
>> +/*
>> + * try_grab_compound_head() - attempt to elevate a page's refcount, by a
>> + * flags-dependent amount.
>> + *
>> + * "grab" names in this file mean, "look at flags to decide whether to use
>> + * FOLL_PIN or FOLL_GET behavior, when incrementing the page's refcount.
>> + *
>> + * Either FOLL_PIN or FOLL_GET (or neither) must be set, but not both at the
>> + * same time. (That's true throughout the get_user_pages*() and
>> + * pin_user_pages*() APIs.) Cases:
>> + *
>> + *    FOLL_GET: page's refcount will be incremented by 1.
>> + *    FOLL_PIN: page's refcount will be incremented by GUP_PIN_COUNTING_BIAS.
>> + *
>> + * Return: head page (with refcount appropriately incremented) for success, or
>> + * NULL upon failure. If neither FOLL_GET nor FOLL_PIN was set, that's
>> + * considered failure, and furthermore, a likely bug in the caller, so a warning
>> + * is also emitted.
>> + */
>> +static __maybe_unused struct page *try_grab_compound_head(struct page *page,
>> +							  int refs,
>> +							  unsigned int flags)
>> +{
>> +	if (flags & FOLL_GET)
>> +		return try_get_compound_head(page, refs);
>> +	else if (flags & FOLL_PIN) {
>> +		refs *= GUP_PIN_COUNTING_BIAS;
>> +		return try_get_compound_head(page, refs);
> 
> Maybe overflow detection? At least under VM_BUG_ON()?


OK, yes I see now that there is no check to see if we're about to overflow
the refs, in this path. I'll add one.


...
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 0a55dec68925..b1079aaa6f24 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -958,6 +958,11 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   	 */
>>   	WARN_ONCE(flags & FOLL_COW, "mm: In follow_devmap_pmd with FOLL_COW set");
>>   
>> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
>> +			 (FOLL_PIN | FOLL_GET)))
> 
> Too many parentheses.


OK, I'll remove at least one. :)


> 
>> +		return NULL;
>> +
>>   	if (flags & FOLL_WRITE && !pmd_write(*pmd))
>>   		return NULL;
>>   
>> @@ -973,7 +978,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   	 * device mapped pages can only be returned if the
>>   	 * caller will manage the page reference count.
>>   	 */
>> -	if (!(flags & FOLL_GET))
>> +	if (!(flags & (FOLL_GET | FOLL_PIN)))
>>   		return ERR_PTR(-EEXIST);
>>   
>>   	pfn += (addr & ~PMD_MASK) >> PAGE_SHIFT;
>> @@ -981,7 +986,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   	if (!*pgmap)
>>   		return ERR_PTR(-EFAULT);
>>   	page = pfn_to_page(pfn);
>> -	get_page(page);
>> +	if (!try_grab_page(page, flags))
>> +		page = ERR_PTR(-ENOMEM);
>>   
>>   	return page;
>>   }
>> @@ -1101,6 +1107,11 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
>>   	if (flags & FOLL_WRITE && !pud_write(*pud))
>>   		return NULL;
>>   
>> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
>> +			 (FOLL_PIN | FOLL_GET)))
>> +		return NULL;
>> +
> 
> Ditto.


ACK.

...
>> @@ -4965,6 +4958,12 @@ follow_huge_pmd(struct mm_struct *mm, unsigned long address,
>>   	struct page *page = NULL;
>>   	spinlock_t *ptl;
>>   	pte_t pte;
>> +
>> +	/* FOLL_GET and FOLL_PIN are mutually exclusive. */
>> +	if (WARN_ON_ONCE((flags & (FOLL_PIN | FOLL_GET)) ==
>> +			 (FOLL_PIN | FOLL_GET)))
>> +		return NULL;
>> +
> 
> Ditto.

ACK.




thanks,
-- 
John Hubbard
NVIDIA
