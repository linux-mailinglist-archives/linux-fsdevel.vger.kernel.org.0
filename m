Return-Path: <linux-fsdevel+bounces-19079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B088BFBA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547F328417D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C5081ABB;
	Wed,  8 May 2024 11:15:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573887D07F
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715166950; cv=none; b=U2GUulL8btQplhJF0nQWcwHdrWpvruX140rzAzY+MiS6fjfCS92OdLvHGMaJF2VF5dB77RK9mClOFiGRXD+nasqiWHsDTZv9CF3alEQ71NoGXp21C0cZS/hBN9IUbIjUfQGWwZJUV4kZQgHvy1Tg74oD+gYK11zoG454pYHhUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715166950; c=relaxed/simple;
	bh=iw2ELT+liLm2ttqRCmRgZZ7pnxFhRcKSH8O/n7WD6RE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l2BPu0Fi7IcaR5c/Hbb1SZyVK7Q0oE3QmlzZLEk0jTz4h0uHdQssosigRwkJ0FTL0AhlrUBrFq0SIdtxAnFazpMaS62XFtB0fOOw7ta7rqo+adqc5NLmiAIAnErWdtk3Q1oNXh7jlsuFppn9xomES+Ss10xcBhBwgCLS68GCC1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VZCC62DWSzYnXn;
	Wed,  8 May 2024 19:11:46 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 122831800C9;
	Wed,  8 May 2024 19:15:37 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 8 May 2024 19:15:36 +0800
Message-ID: <609abbe8-cf88-4145-b1d0-397c980aff28@huawei.com>
Date: Wed, 8 May 2024 19:15:36 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 3/4] mm: filemap: move __lruvec_stat_mod_folio() out
 of filemap_set_pte_range()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-4-wangkefeng.wang@huawei.com>
 <0bf097d2-6d2a-498b-a266-303f168b6221@redhat.com>
 <e1b19d37-82ea-447b-b9da-0a714df2c632@huawei.com>
 <d9190747-953f-4c2a-9729-23d86044fb4d@redhat.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <d9190747-953f-4c2a-9729-23d86044fb4d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/8 17:33, David Hildenbrand wrote:
> On 07.05.24 15:12, Kefeng Wang wrote:
>>
>>
>> On 2024/5/7 19:11, David Hildenbrand wrote:
>>> On 29.04.24 09:24, Kefeng Wang wrote:
>>>> Adding __folio_add_file_rmap_ptes() which don't update lruvec stat, it
>>>> is used in filemap_set_pte_range(), with it, lruvec stat updating is
>>>> moved into the caller, no functional changes.
>>>>
>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>> ---
>>>>    include/linux/rmap.h |  2 ++
>>>>    mm/filemap.c         | 27 ++++++++++++++++++---------
>>>>    mm/rmap.c            | 16 ++++++++++++++++
>>>>    3 files changed, 36 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>>> index 7229b9baf20d..43014ddd06f9 100644
>>>> --- a/include/linux/rmap.h
>>>> +++ b/include/linux/rmap.h
>>>> @@ -242,6 +242,8 @@ void folio_add_anon_rmap_pmd(struct folio *,
>>>> struct page *,
>>>>            struct vm_area_struct *, unsigned long address, rmap_t 
>>>> flags);
>>>>    void folio_add_new_anon_rmap(struct folio *, struct 
>>>> vm_area_struct *,
>>>>            unsigned long address);
>>>> +int __folio_add_file_rmap_ptes(struct folio *, struct page *, int
>>>> nr_pages,
>>>> +        struct vm_area_struct *);
>>>>    void folio_add_file_rmap_ptes(struct folio *, struct page *, int
>>>> nr_pages,
>>>>            struct vm_area_struct *);
>>>>    #define folio_add_file_rmap_pte(folio, page, vma) \
>>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>>> index 7019692daddd..3966b6616d02 100644
>>>> --- a/mm/filemap.c
>>>> +++ b/mm/filemap.c
>>>> @@ -3501,14 +3501,15 @@ static struct folio
>>>> *next_uptodate_folio(struct xa_state *xas,
>>>>    static void filemap_set_pte_range(struct vm_fault *vmf, struct folio
>>>> *folio,
>>>>                struct page *page, unsigned int nr, unsigned long addr,
>>>> -            unsigned long *rss)
>>>> +            unsigned long *rss, int *nr_mapped)
>>>>    {
>>>>        struct vm_area_struct *vma = vmf->vma;
>>>>        pte_t entry;
>>>>        entry = prepare_range_pte_entry(vmf, false, folio, page, nr, 
>>>> addr);
>>>> -    folio_add_file_rmap_ptes(folio, page, nr, vma);
>>>> +    *nr_mapped += __folio_add_file_rmap_ptes(folio, page, nr, vma);
>>>> +
>>>>        set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>>>>        /* no need to invalidate: a not-present page won't be cached */
>>>> @@ -3525,7 +3526,8 @@ static void filemap_set_pte_range(struct
>>>> vm_fault *vmf, struct folio *folio,
>>>>    static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>>>                struct folio *folio, unsigned long start,
>>>>                unsigned long addr, unsigned int nr_pages,
>>>> -            unsigned long *rss, unsigned int *mmap_miss)
>>>> +            unsigned long *rss, int *nr_mapped,
>>>> +            unsigned int *mmap_miss)
>>>>    {
>>>>        vm_fault_t ret = 0;
>>>>        struct page *page = folio_page(folio, start);
>>>> @@ -3558,7 +3560,8 @@ static vm_fault_t filemap_map_folio_range(struct
>>>> vm_fault *vmf,
>>>>            continue;
>>>>    skip:
>>>>            if (count) {
>>>> -            filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>>>> +            filemap_set_pte_range(vmf, folio, page, count, addr,
>>>> +                          rss, nr_mapped);
>>>>                if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>>>                    ret = VM_FAULT_NOPAGE;
>>>>            }
>>>> @@ -3571,7 +3574,8 @@ static vm_fault_t filemap_map_folio_range(struct
>>>> vm_fault *vmf,
>>>>        } while (--nr_pages > 0);
>>>>        if (count) {
>>>> -        filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>>>> +        filemap_set_pte_range(vmf, folio, page, count, addr, rss,
>>>> +                      nr_mapped);
>>>>            if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>>>                ret = VM_FAULT_NOPAGE;
>>>>        }
>>>> @@ -3583,7 +3587,7 @@ static vm_fault_t filemap_map_folio_range(struct
>>>> vm_fault *vmf,
>>>>    static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>>>>            struct folio *folio, unsigned long addr,
>>>> -        unsigned long *rss, unsigned int *mmap_miss)
>>>> +        unsigned long *rss, int *nr_mapped, unsigned int *mmap_miss)
>>>>    {
>>>>        vm_fault_t ret = 0;
>>>>        struct page *page = &folio->page;
>>>> @@ -3606,7 +3610,7 @@ static vm_fault_t
>>>> filemap_map_order0_folio(struct vm_fault *vmf,
>>>>        if (vmf->address == addr)
>>>>            ret = VM_FAULT_NOPAGE;
>>>> -    filemap_set_pte_range(vmf, folio, page, 1, addr, rss);
>>>> +    filemap_set_pte_range(vmf, folio, page, 1, addr, rss, nr_mapped);
>>>>        return ret;
>>>>    }
>>>> @@ -3646,6 +3650,7 @@ vm_fault_t filemap_map_pages(struct vm_fault 
>>>> *vmf,
>>>>        folio_type = mm_counter_file(folio);
>>>>        do {
>>>>            unsigned long end;
>>>> +        int nr_mapped = 0;
>>>>            addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>>>>            vmf->pte += xas.xa_index - last_pgoff;
>>>> @@ -3655,11 +3660,15 @@ vm_fault_t filemap_map_pages(struct vm_fault
>>>> *vmf,
>>>>            if (!folio_test_large(folio))
>>>>                ret |= filemap_map_order0_folio(vmf,
>>>> -                    folio, addr, &rss, &mmap_miss);
>>>> +                    folio, addr, &rss, &nr_mapped,
>>>> +                    &mmap_miss);
>>>>            else
>>>>                ret |= filemap_map_folio_range(vmf, folio,
>>>>                        xas.xa_index - folio->index, addr,
>>>> -                    nr_pages, &rss, &mmap_miss);
>>>> +                    nr_pages, &rss, &nr_mapped,
>>>> +                    &mmap_miss);
>>>> +
>>>> +        __lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
>>>>            folio_unlock(folio);
>>>>            folio_put(folio);
>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>> index 2608c40dffad..55face4024f2 100644
>>>> --- a/mm/rmap.c
>>>> +++ b/mm/rmap.c
>>>> @@ -1452,6 +1452,22 @@ static __always_inline void
>>>> __folio_add_file_rmap(struct folio *folio,
>>>>            mlock_vma_folio(folio, vma);
>>>>    }
>>>> +int __folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
>>>> +        int nr_pages, struct vm_area_struct *vma)
>>>> +{
>>>> +    int nr, nr_pmdmapped = 0;
>>>> +
>>>> +    VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>>>> +
>>>> +    nr = __folio_add_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE,
>>>> +                  &nr_pmdmapped);
>>>> +
>>>> +    /* See comments in folio_add_anon_rmap_*() */
>>>> +    if (!folio_test_large(folio))
>>>> +        mlock_vma_folio(folio, vma);
>>>> +
>>>> +    return nr;
>>>> +}
>>>
>>> I'm not really a fan :/ It does make the code more complicated, and it
>>> will be harder to extend if we decide to ever account differently (e.g.,
>>> NR_SHMEM_MAPPED, additional tracking for mTHP etc).
>>
>> If more different accounts, this may lead to bad scalability.
> 
> We already do it for PMD mappings.
> 
>>>
>>> With large folios we'll be naturally batching already here, and I do
>>
>> Yes, it is batched with large folios，but our fs is ext4/tmpfs, there
>> are not support large folio or still upstreaming.
> 
> Okay, so that will be sorted out sooner or later.
> 
>>
>>> wonder, if this is really worth for performance, or if we could find
>>> another way of batching (let the caller activate batching and drain
>>> afterwards) without exposing these details to the caller.
>>
>> It does reduce latency when batch lruvec stat updating without large
>> folio, but I can't find better way, or let's wait for the large folio
>> support on ext4/tmpfs, I also Cced memcg maintainers in patch4 to see if
>> there are any other ideas.
> 
> I'm not convinced this benefit here is worth making the code more 
> complicated.
> 
> Maybe we can find another way to optimize this batching in rmap code 
> without having to leak these details to the callers.
> 
> For example, we could pass an optional batching structure to all rmap 
> add/rel functions that would collect these stat updates. Then we could 
> have one function to flush it and update the counters combined.
> 
> Such batching could be beneficial also for page unmapping/zapping where 
> we might unmap various different folios in one go.

It sounds better and clearer, I will try it and see the results, thanks 
for your advise!

> 

