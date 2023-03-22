Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F5E6C4E75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCVOuL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjCVOt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:49:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 04B994BEBA;
        Wed, 22 Mar 2023 07:48:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80694B3;
        Wed, 22 Mar 2023 07:49:06 -0700 (PDT)
Received: from [10.1.37.147] (C02CF1NRLVDN.cambridge.arm.com [10.1.37.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA3743F71E;
        Wed, 22 Mar 2023 07:48:21 -0700 (PDT)
Message-ID: <7d4e583e-3a6e-5d0d-7369-46724187f19c@arm.com>
Date:   Wed, 22 Mar 2023 14:48:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 3/5] mm: thp: split huge page to any lower order pages.
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230321004829.2012847-1-zi.yan@sent.com>
 <20230321004829.2012847-4-zi.yan@sent.com>
 <e8352d76-29e4-5e4a-063b-60e279e0b070@arm.com>
 <A75E3B03-C00C-45B5-8D8E-688F091B1F4D@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <A75E3B03-C00C-45B5-8D8E-688F091B1F4D@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/2023 14:27, Zi Yan wrote:
> On 22 Mar 2023, at 3:55, Ryan Roberts wrote:
> 
>> Hi,
>>
>> I'm working to enable large, variable-order folios for anonymous memory (see
>> RFC, replete with bugs at [1]). This patch set is going to be very useful to me.
>> But I have a few questions that I wonder if you can answer, below? I wonder if
>> they might relate to the bugs I'm seeing at [1].
>>
>> [1] https://lore.kernel.org/linux-mm/20230317105802.2634004-1-ryan.roberts@arm.com/
>>
>>
>>
>> On 21/03/2023 00:48, Zi Yan wrote:
>>> From: Zi Yan <ziy@nvidia.com>
>>>
>>> To split a THP to any lower order pages, we need to reform THPs on
>>> subpages at given order and add page refcount based on the new page
>>> order. Also we need to reinitialize page_deferred_list after removing
>>> the page from the split_queue, otherwise a subsequent split will see
>>> list corruption when checking the page_deferred_list again.
>>>
>>> It has many uses, like minimizing the number of pages after
>>> truncating a huge pagecache page. For anonymous THPs, we can only split
>>> them to order-0 like before until we add support for any size anonymous
>>> THPs.
>>>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> ---
>>>  include/linux/huge_mm.h |  10 ++--
>>>  mm/huge_memory.c        | 103 +++++++++++++++++++++++++++++-----------
>>>  2 files changed, 82 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>> index 20284387b841..32c91e1b59cd 100644
>>> --- a/include/linux/huge_mm.h
>>> +++ b/include/linux/huge_mm.h
>>> @@ -147,10 +147,11 @@ void prep_transhuge_page(struct page *page);
>>>  void free_transhuge_page(struct page *page);
>>>
>>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>> -int split_huge_page_to_list(struct page *page, struct list_head *list);
>>> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>> +		unsigned int new_order);
>>>  static inline int split_huge_page(struct page *page)
>>>  {
>>> -	return split_huge_page_to_list(page, NULL);
>>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>>>  }
>>>  void deferred_split_folio(struct folio *folio);
>>>
>>> @@ -297,7 +298,8 @@ can_split_folio(struct folio *folio, int *pextra_pins)
>>>  	return false;
>>>  }
>>>  static inline int
>>> -split_huge_page_to_list(struct page *page, struct list_head *list)
>>> +split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>> +		unsigned int new_order)
>>>  {
>>>  	return 0;
>>>  }
>>> @@ -397,7 +399,7 @@ static inline bool thp_migration_supported(void)
>>>  static inline int split_folio_to_list(struct folio *folio,
>>>  		struct list_head *list)
>>>  {
>>> -	return split_huge_page_to_list(&folio->page, list);
>>> +	return split_huge_page_to_list_to_order(&folio->page, list, 0);
>>>  }
>>>
>>>  static inline int split_folio(struct folio *folio)
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 710189885402..f119b9be33f2 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2359,11 +2359,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>>>
>>>  static void unmap_folio(struct folio *folio)
>>>  {
>>> -	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>>> -		TTU_SYNC;
>>> +	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC;
>>>
>>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>
>>> +	if (folio_order(folio) >= HPAGE_PMD_ORDER)
>>> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
>>> +
>>
>> Why have you changed the code so that this flag is added conditionally on the
>> folio being large enough? I've previously looked at this in the context of my
>> bug, and concluded that the consumer would ignore the flag if the folio wasn't
>> PMD mapped. Did I conclude incorrectly?
> 
> Since if folio order is not larger than PMD order, there is no way of mapping
> a PMD to the folio. Thus, TTU_SPLIT_HUGE_PMD does not make sense. Yes, the consumer
> will not split any PMD, but will still do page table locks and mmu notifier
> work, which cost unnecessary overheads.
> 
> I think I better change the if condition to folio_test_pmd_mappable().

Ahh, that makes sense - thanks.

> 
>>
>>
>>>  	/*
>>>  	 * Anon pages need migration entries to preserve them, but file
>>>  	 * pages can simply be left unmapped, then faulted back on demand.
>>> @@ -2395,7 +2397,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>  		struct lruvec *lruvec, struct list_head *list)
>>>  {
>>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>>  	lockdep_assert_held(&lruvec->lru_lock);
>>>
>>> @@ -2416,9 +2417,10 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>  }
>>>
>>
>> [...]
>>
>>> -int split_huge_page_to_list(struct page *page, struct list_head *list)
>>> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>> +				     unsigned int new_order)
>>>  {
>>>  	struct folio *folio = page_folio(page);
>>>  	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
>>> -	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>>> +	/* reset xarray order to new order after split */
>>> +	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
>>>  	struct anon_vma *anon_vma = NULL;
>>>  	struct address_space *mapping = NULL;
>>>  	int extra_pins, ret;
>>> @@ -2649,6 +2676,18 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>
>>> +	/* Cannot split THP to order-1 (no order-1 THPs) */
>>> +	if (new_order == 1) {
>>> +		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
>>> +		return -EINVAL;
>>> +	}
>>
>> Why can't you split to order-1? I vaguely understand that some data is kept in
>> the first 3 struct pages, but I would naively expect the allocator to fail to
>> allocate compound pages of order-1 if it was a problem? My large anon folios
>> patch is currently allocating order-1 in some circumstances. Perhaps its related
>> to my bug?
>>
> 
> Yes, some data is kept in first 3 struct pages, so order-1 THP is not possible.
> The page allocator does not know this restriction, but still allocate an order-1
> page. That might be related to your bug. You can have order-1 compound pages,
> but it does not mean you can use them for THPs. AFAIK, slab uses order-1 compound
> pages, but it does not store slab information on the 3rd struct page.
> 
> Basically, page allocator can allocate an order-N page, and it can be:
> 1. 2^N consecutive physical pages (not a compound page),
> 2. an order-N compound page,
> 3. an order-N THP (also an order-N compound page),
> 4. an order-N hugetlb page (also an order-N compound page).
> 
> For THP and hugetlb page, there are prep_transhuge_page() and
> prep_new_hugetlb_folio() are called respectively after the page is allocated.
> That makes them kinda subclasses of a compound page.

I've been staring at this code most of the day, and just concluded that this is
exactly my bug. split_huge_page() was trying to split my order-1 page and
scribbling over the _deferred_list in a neighboring struct page. So thanks for
posting the patch and triggering the thought! And thanks for taking the time to
explain all this.

> 
>>
>>> +
>>> +	/* Split anonymous folio to non-zero order not support */
>>> +	if (folio_test_anon(folio) && new_order) {
>>> +		VM_WARN_ONCE(1, "Split anon folio to non-0 order not support");
>>> +		return -EINVAL;
>>> +	}
>>
>> Why don't you support this? What is special about anon folios that means this
>> code doesn't work for them?
> 
> split_huge_page() code can split to non-0 order anon folios, but the rest of
> the mm code might not have proper support yet.
> That is why we need your patchset. :)
> 
>>
>>
>>> +
>>>  	is_hzp = is_huge_zero_page(&folio->page);
>>>  	VM_WARN_ON_ONCE_FOLIO(is_hzp, folio);
>>>  	if (is_hzp)
>>> @@ -2744,7 +2783,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>>  	if (folio_ref_freeze(folio, 1 + extra_pins)) {
>>>  		if (!list_empty(&folio->_deferred_list)) {
>>>  			ds_queue->split_queue_len--;
>>> -			list_del(&folio->_deferred_list);
>>> +			/*
>>> +			 * Reinitialize page_deferred_list after removing the
>>> +			 * page from the split_queue, otherwise a subsequent
>>> +			 * split will see list corruption when checking the
>>> +			 * page_deferred_list.
>>> +			 */
>>> +			list_del_init(&folio->_deferred_list);
>>>  		}
>>>  		spin_unlock(&ds_queue->split_queue_lock);
>>>  		if (mapping) {
>>> @@ -2754,14 +2799,18 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>>  			if (folio_test_swapbacked(folio)) {
>>>  				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
>>>  							-nr);
>>> -			} else {
>>> +			} else if (!new_order) {
>>> +				/*
>>> +				 * Decrease THP stats only if split to normal
>>> +				 * pages
>>> +				 */
>>>  				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
>>>  							-nr);
>>>  				filemap_nr_thps_dec(mapping);
>>>  			}
>>>  		}
>>>
>>> -		__split_huge_page(page, list, end);
>>> +		__split_huge_page(page, list, end, new_order);
>>>  		ret = 0;
>>>  	} else {
>>>  		spin_unlock(&ds_queue->split_queue_lock);
> 
> --
> Best Regards,
> Yan, Zi

