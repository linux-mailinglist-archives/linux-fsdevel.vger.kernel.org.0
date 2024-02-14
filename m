Return-Path: <linux-fsdevel+bounces-11583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F4E854F27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2F6B2F062
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 16:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7AE604AC;
	Wed, 14 Feb 2024 16:41:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AFF5FB8A;
	Wed, 14 Feb 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928889; cv=none; b=HCJiUz5bRhc9ro08zmQzwFlGqDUb15UcFBDGY4zl1RicQOtlMKAZZXyByV/KEf0fQjz9ON8+cvhiq5fU6r+vV1YfvgGT+NKu30VK019nSKZgn7CeDYCgfGj1J+JB3KHuD7K1diMDJx2YPoHGnRoX/WX8a37Y8bDbVrs5kXeCqLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928889; c=relaxed/simple;
	bh=mlzRfG3S1iCz1kh8DMN9QJKlAi7b/aj4A2+AzxWYo9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dc3DWUt/Vb2xRPSZAOwqu7FRYY8tp/bEe6rgwx4a3+IzsxjgFPcqF7DphTKENLWgEvsgnwZbEZMyNdNH39Jkncj5X4wFXs7T89w0eHZY/W+fbEvjkFZcWXNs7Q4BvIHGwGA1qN8p4r2+JCVN1w1oDhKVETNYxmyeKy4dg0JxXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7031FB;
	Wed, 14 Feb 2024 08:42:07 -0800 (PST)
Received: from [10.57.64.120] (unknown [10.57.64.120])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C380B3F762;
	Wed, 14 Feb 2024 08:41:23 -0800 (PST)
Message-ID: <78095f74-dc1c-4425-b390-fb6307a6e429@arm.com>
Date: Wed, 14 Feb 2024 16:41:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] mm: thp: split huge page to any lower order pages
 (except order-1).
Content-Language: en-GB
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, linux-mm@kvack.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, Yang Shi <shy828301@gmail.com>,
 Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Zach O'Keefe
 <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-6-zi.yan@sent.com>
 <de66b9fb-ee84-473f-a69a-2ac8554f6000@arm.com>
 <6859C8DA-5B7F-458E-895C-763BA782F4B9@nvidia.com>
 <6c986b83-e00d-46fe-8c88-374f8e6bd0fa@arm.com>
 <5D3CF5B4-FB16-4CE7-9D8E-CBFFA7A1FA43@nvidia.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <5D3CF5B4-FB16-4CE7-9D8E-CBFFA7A1FA43@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 16:28, Zi Yan wrote:
> On 14 Feb 2024, at 11:22, Ryan Roberts wrote:
> 
>> On 14/02/2024 16:11, Zi Yan wrote:
>>> On 14 Feb 2024, at 5:38, Ryan Roberts wrote:
>>>
>>>> On 13/02/2024 21:55, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> To split a THP to any lower order (except order-1) pages, we need to
>>>>> reform THPs on subpages at given order and add page refcount based on the
>>>>> new page order. Also we need to reinitialize page_deferred_list after
>>>>> removing the page from the split_queue, otherwise a subsequent split will
>>>>> see list corruption when checking the page_deferred_list again.
>>>>>
>>>>> It has many uses, like minimizing the number of pages after
>>>>> truncating a huge pagecache page. For anonymous THPs, we can only split
>>>>> them to order-0 like before until we add support for any size anonymous
>>>>> THPs.
>>>>
>>>> multi-size THP is now upstream. Not sure if this comment still makes sense.
>>> Will change it to reflect the fact that multi-size THP is already upstream.
>>>
>>>> Still its not completely clear to me how you would integrate this new machinery
>>>> and decide what non-zero order to split anon THP to?
>>>
>>> Originally, it was developed along with my 1GB THP support. So it was intended
>>> to split order-18 to order-9. But for now, like you and David said in the cover
>>> letter email thread, we might not want to use it for anonymous large folios
>>> until we find a necessary use case.
>>>
>>>>>
>>>>> Order-1 folio is not supported because _deferred_list, which is used by
>>>>> partially mapped folios, is stored in subpage 2 and an order-1 folio only
>>>>> has subpage 0 and 1.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  include/linux/huge_mm.h |  21 +++++---
>>>>>  mm/huge_memory.c        | 114 +++++++++++++++++++++++++++++++---------
>>>>>  2 files changed, 101 insertions(+), 34 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>> index 5adb86af35fc..de0c89105076 100644
>>>>> --- a/include/linux/huge_mm.h
>>>>> +++ b/include/linux/huge_mm.h
>>>>> @@ -265,10 +265,11 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>>>>>
>>>>>  void folio_prep_large_rmappable(struct folio *folio);
>>>>>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>>>>> -int split_huge_page_to_list(struct page *page, struct list_head *list);
>>>>> +int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>> +		unsigned int new_order);
>>>>>  static inline int split_huge_page(struct page *page)
>>>>>  {
>>>>> -	return split_huge_page_to_list(page, NULL);
>>>>> +	return split_huge_page_to_list_to_order(page, NULL, 0);
>>>>>  }
>>>>>  void deferred_split_folio(struct folio *folio);
>>>>>
>>>>> @@ -422,7 +423,8 @@ can_split_folio(struct folio *folio, int *pextra_pins)
>>>>>  	return false;
>>>>>  }
>>>>>  static inline int
>>>>> -split_huge_page_to_list(struct page *page, struct list_head *list)
>>>>> +split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>> +		unsigned int new_order)
>>>>>  {
>>>>>  	return 0;
>>>>>  }
>>>>> @@ -519,17 +521,20 @@ static inline bool thp_migration_supported(void)
>>>>>  }
>>>>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>>>>
>>>>> -static inline int split_folio_to_list(struct folio *folio,
>>>>> -		struct list_head *list)
>>>>> +static inline int split_folio_to_list_to_order(struct folio *folio,
>>>>> +		struct list_head *list, int new_order)
>>>>>  {
>>>>> -	return split_huge_page_to_list(&folio->page, list);
>>>>> +	return split_huge_page_to_list_to_order(&folio->page, list, new_order);
>>>>>  }
>>>>>
>>>>> -static inline int split_folio(struct folio *folio)
>>>>> +static inline int split_folio_to_order(struct folio *folio, int new_order)
>>>>>  {
>>>>> -	return split_folio_to_list(folio, NULL);
>>>>> +	return split_folio_to_list_to_order(folio, NULL, new_order);
>>>>>  }
>>>>>
>>>>> +#define split_folio_to_list(f, l) split_folio_to_list_to_order(f, l, 0)
>>>>> +#define split_folio(f) split_folio_to_order(f, 0)
>>>>> +
>>>>>  /*
>>>>>   * archs that select ARCH_WANTS_THP_SWAP but don't support THP_SWP due to
>>>>>   * limitations in the implementation like arm64 MTE can override this to
>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>> index ad7133c97428..d0e555a8ea98 100644
>>>>> --- a/mm/huge_memory.c
>>>>> +++ b/mm/huge_memory.c
>>>>> @@ -2718,11 +2718,14 @@ void vma_adjust_trans_huge(struct vm_area_struct *vma,
>>>>>
>>>>>  static void unmap_folio(struct folio *folio)
>>>>>  {
>>>>> -	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
>>>>> -		TTU_SYNC | TTU_BATCH_FLUSH;
>>>>> +	enum ttu_flags ttu_flags = TTU_RMAP_LOCKED | TTU_SYNC |
>>>>> +		TTU_BATCH_FLUSH;
>>>>>
>>>>>  	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>>>>>
>>>>> +	if (folio_test_pmd_mappable(folio))
>>>>> +		ttu_flags |= TTU_SPLIT_HUGE_PMD;
>>>>
>>>> Should we split this change out? I think it makes sense independent of this series?
>>>>
>>>
>>> Sure. Since multi-size THP is upstream, this avoid unnecessary code path if
>>> the THP is not PMD-mapped.
>>>
>>>>> +
>>>>>  	/*
>>>>>  	 * Anon pages need migration entries to preserve them, but file
>>>>>  	 * pages can simply be left unmapped, then faulted back on demand.
>>>>> @@ -2756,7 +2759,6 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>>>  		struct lruvec *lruvec, struct list_head *list)
>>>>>  {
>>>>>  	VM_BUG_ON_PAGE(!PageHead(head), head);
>>>>> -	VM_BUG_ON_PAGE(PageCompound(tail), head);
>>>>>  	VM_BUG_ON_PAGE(PageLRU(tail), head);
>>>>>  	lockdep_assert_held(&lruvec->lru_lock);
>>>>>
>>>>> @@ -2777,7 +2779,8 @@ static void lru_add_page_tail(struct page *head, struct page *tail,
>>>>>  }
>>>>>
>>>>>  static void __split_huge_page_tail(struct folio *folio, int tail,
>>>>> -		struct lruvec *lruvec, struct list_head *list)
>>>>> +		struct lruvec *lruvec, struct list_head *list,
>>>>> +		unsigned int new_order)
>>>>>  {
>>>>>  	struct page *head = &folio->page;
>>>>>  	struct page *page_tail = head + tail;
>>>>> @@ -2847,10 +2850,15 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>>>>>  	 * which needs correct compound_head().
>>>>>  	 */
>>>>>  	clear_compound_head(page_tail);
>>>>> +	if (new_order) {
>>>>> +		prep_compound_page(page_tail, new_order);
>>>>> +		folio_prep_large_rmappable(page_folio(page_tail));
>>>>> +	}
>>>>>
>>>>>  	/* Finally unfreeze refcount. Additional reference from page cache. */
>>>>> -	page_ref_unfreeze(page_tail, 1 + (!folio_test_anon(folio) ||
>>>>> -					  folio_test_swapcache(folio)));
>>>>> +	page_ref_unfreeze(page_tail,
>>>>> +		1 + ((!folio_test_anon(folio) || folio_test_swapcache(folio)) ?
>>>>> +			     folio_nr_pages(page_folio(page_tail)) : 0));
>>>>>
>>>>>  	if (folio_test_young(folio))
>>>>>  		folio_set_young(new_folio);
>>>>> @@ -2868,7 +2876,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
>>>>>  }
>>>>>
>>>>>  static void __split_huge_page(struct page *page, struct list_head *list,
>>>>> -		pgoff_t end)
>>>>> +		pgoff_t end, unsigned int new_order)
>>>>>  {
>>>>>  	struct folio *folio = page_folio(page);
>>>>>  	struct page *head = &folio->page;
>>>>> @@ -2877,10 +2885,11 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>>>  	unsigned long offset = 0;
>>>>>  	unsigned int nr = thp_nr_pages(head);
>>>>>  	int i, nr_dropped = 0;
>>>>> +	unsigned int new_nr = 1 << new_order;
>>>>>  	int order = folio_order(folio);
>>>>>
>>>>>  	/* complete memcg works before add pages to LRU */
>>>>> -	split_page_memcg(head, order, 0);
>>>>> +	split_page_memcg(head, order, new_order);
>>>>>
>>>>>  	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
>>>>>  		offset = swp_offset(folio->swap);
>>>>> @@ -2893,8 +2902,8 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>>>
>>>>>  	ClearPageHasHWPoisoned(head);
>>>>>
>>>>> -	for (i = nr - 1; i >= 1; i--) {
>>>>> -		__split_huge_page_tail(folio, i, lruvec, list);
>>>>> +	for (i = nr - new_nr; i >= new_nr; i -= new_nr) {
>>>>> +		__split_huge_page_tail(folio, i, lruvec, list, new_order);
>>>>>  		/* Some pages can be beyond EOF: drop them from page cache */
>>>>>  		if (head[i].index >= end) {
>>>>>  			struct folio *tail = page_folio(head + i);
>>>>> @@ -2910,29 +2919,41 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>>>>>  			__xa_store(&head->mapping->i_pages, head[i].index,
>>>>>  					head + i, 0);
>>>>>  		} else if (swap_cache) {
>>>>> +			/*
>>>>> +			 * split anonymous THPs (including swapped out ones) to
>>>>> +			 * non-zero order not supported
>>>>> +			 */
>>>>> +			VM_WARN_ONCE(new_order,
>>>>> +				"Split swap-cached anon folio to non-0 order not supported");
>>>>
>>>> Why isn't it supported? Even if it's not supported, is this level the right
>>>> place to enforce these kinds of policy decisions? I wonder if we should be
>>>> leaving that to the higher level to decide?
>>>
>>> Is the swap-out small-size THP without splitting merged? This needs that patchset.
>>
>> No not yet. I have to respin it. Its on my todo list.
>>
>> I'm not sure I understand the dependency though?
> 
> IIUC, swap cache only supports one cluster size, HPAGE_PMD_NR, so splitting
> a PMD-size swapcached folio will need to split a cluster to smaller ones, which
> needs your patchset support. Let me know if I get it wrong.

Ahh yeah, sorry, obvious now that you've spelled it out - thanks!

> 
>>
>>> You are right that a warning here is not appropriate. I will fail the splitting
>>> if the folio is swapcached and going to be split into >0 order.
>>>
>>>>>  			__xa_store(&swap_cache->i_pages, offset + i,
>>>>>  					head + i, 0);
>>>>>  		}
>>>>>  	}
>>>>>
>>>
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
> 
> 
> --
> Best Regards,
> Yan, Zi


