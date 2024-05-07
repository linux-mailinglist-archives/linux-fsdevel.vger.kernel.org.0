Return-Path: <linux-fsdevel+bounces-18898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 371658BE335
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D281C23240
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C46015E217;
	Tue,  7 May 2024 13:12:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925F15E1EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087546; cv=none; b=B8rM6jRapoZ89RqiZWuPKGFzlyHdQYOGbLbJ4IyLc4HTG+Q5mXXW6wEwyHum27jgt10kwhWcSV8w1vzbo62aDjPixFeZaqnfTa2UeTxY3I1vgfzIPC89y0SEJUnK3dA1HCWfU8p4FgXAYbioT0IMqwrMuVTpGaCda6jiXpdJ1Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087546; c=relaxed/simple;
	bh=90pmd+lD3TWl3wYzLDx/DvLGHftBKcomYQWa8N72yKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eovXlgyT0Cvu70vV5JG7+hT26OAiltqi6KZZcJp980P8HRgrs+2jozPEMRYSPvmTnnMszrvj2h50ipBRSvxgfn+wzhazTorgmgi44ZT/cOg2AycjsQNmECRrhEDlS/LiK/TSZ/GxfVtp3DOINqvAQMm2xxNG13h/2oJJR1fMiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VYdrl0bt7ztSrk;
	Tue,  7 May 2024 21:08:55 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 343C31403D2;
	Tue,  7 May 2024 21:12:20 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 21:12:19 +0800
Message-ID: <e1b19d37-82ea-447b-b9da-0a714df2c632@huawei.com>
Date: Tue, 7 May 2024 21:12:19 +0800
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
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <0bf097d2-6d2a-498b-a266-303f168b6221@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/5/7 19:11, David Hildenbrand wrote:
> On 29.04.24 09:24, Kefeng Wang wrote:
>> Adding __folio_add_file_rmap_ptes() which don't update lruvec stat, it
>> is used in filemap_set_pte_range(), with it, lruvec stat updating is
>> moved into the caller, no functional changes.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
>>   include/linux/rmap.h |  2 ++
>>   mm/filemap.c         | 27 ++++++++++++++++++---------
>>   mm/rmap.c            | 16 ++++++++++++++++
>>   3 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 7229b9baf20d..43014ddd06f9 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -242,6 +242,8 @@ void folio_add_anon_rmap_pmd(struct folio *, 
>> struct page *,
>>           struct vm_area_struct *, unsigned long address, rmap_t flags);
>>   void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>           unsigned long address);
>> +int __folio_add_file_rmap_ptes(struct folio *, struct page *, int 
>> nr_pages,
>> +        struct vm_area_struct *);
>>   void folio_add_file_rmap_ptes(struct folio *, struct page *, int 
>> nr_pages,
>>           struct vm_area_struct *);
>>   #define folio_add_file_rmap_pte(folio, page, vma) \
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 7019692daddd..3966b6616d02 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -3501,14 +3501,15 @@ static struct folio 
>> *next_uptodate_folio(struct xa_state *xas,
>>   static void filemap_set_pte_range(struct vm_fault *vmf, struct folio 
>> *folio,
>>               struct page *page, unsigned int nr, unsigned long addr,
>> -            unsigned long *rss)
>> +            unsigned long *rss, int *nr_mapped)
>>   {
>>       struct vm_area_struct *vma = vmf->vma;
>>       pte_t entry;
>>       entry = prepare_range_pte_entry(vmf, false, folio, page, nr, addr);
>> -    folio_add_file_rmap_ptes(folio, page, nr, vma);
>> +    *nr_mapped += __folio_add_file_rmap_ptes(folio, page, nr, vma);
>> +
>>       set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>>       /* no need to invalidate: a not-present page won't be cached */
>> @@ -3525,7 +3526,8 @@ static void filemap_set_pte_range(struct 
>> vm_fault *vmf, struct folio *folio,
>>   static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>               struct folio *folio, unsigned long start,
>>               unsigned long addr, unsigned int nr_pages,
>> -            unsigned long *rss, unsigned int *mmap_miss)
>> +            unsigned long *rss, int *nr_mapped,
>> +            unsigned int *mmap_miss)
>>   {
>>       vm_fault_t ret = 0;
>>       struct page *page = folio_page(folio, start);
>> @@ -3558,7 +3560,8 @@ static vm_fault_t filemap_map_folio_range(struct 
>> vm_fault *vmf,
>>           continue;
>>   skip:
>>           if (count) {
>> -            filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>> +            filemap_set_pte_range(vmf, folio, page, count, addr,
>> +                          rss, nr_mapped);
>>               if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>                   ret = VM_FAULT_NOPAGE;
>>           }
>> @@ -3571,7 +3574,8 @@ static vm_fault_t filemap_map_folio_range(struct 
>> vm_fault *vmf,
>>       } while (--nr_pages > 0);
>>       if (count) {
>> -        filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>> +        filemap_set_pte_range(vmf, folio, page, count, addr, rss,
>> +                      nr_mapped);
>>           if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>               ret = VM_FAULT_NOPAGE;
>>       }
>> @@ -3583,7 +3587,7 @@ static vm_fault_t filemap_map_folio_range(struct 
>> vm_fault *vmf,
>>   static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>>           struct folio *folio, unsigned long addr,
>> -        unsigned long *rss, unsigned int *mmap_miss)
>> +        unsigned long *rss, int *nr_mapped, unsigned int *mmap_miss)
>>   {
>>       vm_fault_t ret = 0;
>>       struct page *page = &folio->page;
>> @@ -3606,7 +3610,7 @@ static vm_fault_t 
>> filemap_map_order0_folio(struct vm_fault *vmf,
>>       if (vmf->address == addr)
>>           ret = VM_FAULT_NOPAGE;
>> -    filemap_set_pte_range(vmf, folio, page, 1, addr, rss);
>> +    filemap_set_pte_range(vmf, folio, page, 1, addr, rss, nr_mapped);
>>       return ret;
>>   }
>> @@ -3646,6 +3650,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>       folio_type = mm_counter_file(folio);
>>       do {
>>           unsigned long end;
>> +        int nr_mapped = 0;
>>           addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>>           vmf->pte += xas.xa_index - last_pgoff;
>> @@ -3655,11 +3660,15 @@ vm_fault_t filemap_map_pages(struct vm_fault 
>> *vmf,
>>           if (!folio_test_large(folio))
>>               ret |= filemap_map_order0_folio(vmf,
>> -                    folio, addr, &rss, &mmap_miss);
>> +                    folio, addr, &rss, &nr_mapped,
>> +                    &mmap_miss);
>>           else
>>               ret |= filemap_map_folio_range(vmf, folio,
>>                       xas.xa_index - folio->index, addr,
>> -                    nr_pages, &rss, &mmap_miss);
>> +                    nr_pages, &rss, &nr_mapped,
>> +                    &mmap_miss);
>> +
>> +        __lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
>>           folio_unlock(folio);
>>           folio_put(folio);
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 2608c40dffad..55face4024f2 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1452,6 +1452,22 @@ static __always_inline void 
>> __folio_add_file_rmap(struct folio *folio,
>>           mlock_vma_folio(folio, vma);
>>   }
>> +int __folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
>> +        int nr_pages, struct vm_area_struct *vma)
>> +{
>> +    int nr, nr_pmdmapped = 0;
>> +
>> +    VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>> +
>> +    nr = __folio_add_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE,
>> +                  &nr_pmdmapped);
>> +
>> +    /* See comments in folio_add_anon_rmap_*() */
>> +    if (!folio_test_large(folio))
>> +        mlock_vma_folio(folio, vma);
>> +
>> +    return nr;
>> +}
> 
> I'm not really a fan :/ It does make the code more complicated, and it 
> will be harder to extend if we decide to ever account differently (e.g., 
> NR_SHMEM_MAPPED, additional tracking for mTHP etc).

If more different accounts, this may lead to bad scalability.
> 
> With large folios we'll be naturally batching already here, and I do 

Yes, it is batched with large folios，but our fs is ext4/tmpfs, there
are not support large folio or still upstreaming.

> wonder, if this is really worth for performance, or if we could find 
> another way of batching (let the caller activate batching and drain 
> afterwards) without exposing these details to the caller.

It does reduce latency when batch lruvec stat updating without large
folio, but I can't find better way, or let's wait for the large folio
support on ext4/tmpfs, I also Cced memcg maintainers in patch4 to see if
there are any other ideas.


> 
> Note that there is another cleanup happening [1].

The patch is related RMAP_LEVEL_PMD level, it should be not involved in 
filemap_map_pages().

> 
> [1] 
> https://lore.kernel.org/all/20240506192924.271999-1-yosryahmed@google.com/T/#u
>  

