Return-Path: <linux-fsdevel+bounces-19044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915FF8BF994
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C7E281BCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 09:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52E757FF;
	Wed,  8 May 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ7gz2c0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAF54C3D0
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715160833; cv=none; b=RWgbUfc6erAt6j32x7O1EoSRwAFMOGmgLG9Og6sSbbvnQQ748bYAo6BRUDUyC+LOyPCNzUrwqLwu/UT1avYQtqsvmRkEOTgD5dv3jd4FKx7JMOl2ZCl1iZsB6irREXiGN3DI3UMWRKIRkv4d2v2f9jRB/zVpnay0QXq4DOVrxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715160833; c=relaxed/simple;
	bh=3JTPFvTi5QNOO57XxP2Zb4zI2DcZkJpc3QoV8uwPi18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qY5KksZZVKGkB4aWdwiquLH/t2Pd7zUM9L2hcYtGqKf/QcCwn2epJHppyRFknU39GLbqT+SjCN+Ua3bwNmD2w9lesy9rvu9w6upxMJQWPpAKQU/bFbrH5A/psyF0IklS8Zyvyc0d3pmCRTweEG31Pei0zCaCaXIjkr7pdaMLhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZ7gz2c0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715160830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5BpyKhPhM0bO7gwrTFG/OBZUd+XBwM1xCgdv8wtCkPg=;
	b=eZ7gz2c0hD6VAlTUJz+FrdAHlCyIjomEvtchE58HmcJZpcQVqN3h7mN5A3gBAiBLJ0X2YV
	zP0GE5Q+jk3RHdllXX/HePb/GIAc8S2YecfoB89hZAdaDx+coUM53gIMnKgH6BDnY8k+fo
	0pz07OVfSSJ7QSjLxiN1y5Iz8kGuB7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-E-FyYoNYOruW75rTK5pIKg-1; Wed, 08 May 2024 05:33:48 -0400
X-MC-Unique: E-FyYoNYOruW75rTK5pIKg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34d99cc6c3dso2519137f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2024 02:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715160827; x=1715765627;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BpyKhPhM0bO7gwrTFG/OBZUd+XBwM1xCgdv8wtCkPg=;
        b=O1zCEa625Q9Gii8k+fMPpBlVJeMn+UXNNCCpocl+6Z27Xd1qmmZiIPJzSmDwCipVAN
         sJ+sVa98+IzcFF/YvTPnis0rBBGe3r/9sAOwcUo3a/WBxdMaviPFWm73dgtBnkjssymA
         kwWiznhTVmGqD3u4gvFhXM0eC2JjVi+dYHO+MNakpgiqITFSx3z9ZiCLCONiP8+s51lv
         xEiwxwzzXGl6bqXkezHACBwYCiVNOlRPM8x6zRqPCZcTkDwlHgG9R8n928770Acl04uE
         PSuXlYdDLv9KwYYaGNVa027HX4r43E6GBkM/4CKEYlR1CNkPBnnmLsakHqGy/s9Nnp6m
         jJTg==
X-Forwarded-Encrypted: i=1; AJvYcCXbRimCHyLKyd6gK3DYahbZzIyMdl3aEgXRMPkDJIzExAW293V25A37sYli0IpMRGOFDrjFyC1ln7MpxzE00P8Z+9gGcl18c9ApW+Z94Q==
X-Gm-Message-State: AOJu0Yx3o2VLIt6f7R8fx+x2rZEhupBbXYEIaYvEk/LdzC1exFyNuDX4
	YRLMXzjMdqhM7t+VYJSExJaS/CUn1r35idk85TNjuQ74qBnfmjcKRblFEpdP54EBfqy5DlRIsDo
	Ui2bjdqkMVmlvZ+j+ub96xXfX3uqqb2Di4l98mcQ2prKUGf5jhP4pAyCpT8Elfyk=
X-Received: by 2002:a5d:50ca:0:b0:34d:9ec4:c0fe with SMTP id ffacd0b85a97d-34fcb3abaf8mr1410568f8f.65.1715160827553;
        Wed, 08 May 2024 02:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxEE0fzmn3JfOzg/ln7C3sSzZNNoFoF33hTmyhiMcSiODcxxcUc5ROYugstyDxpKPXQCeFzA==
X-Received: by 2002:a5d:50ca:0:b0:34d:9ec4:c0fe with SMTP id ffacd0b85a97d-34fcb3abaf8mr1410550f8f.65.1715160827103;
        Wed, 08 May 2024 02:33:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c707:3100:35c3:fc4b:669f:9ff9? (p200300cbc707310035c3fc4b669f9ff9.dip0.t-ipconnect.de. [2003:cb:c707:3100:35c3:fc4b:669f:9ff9])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d588c000000b0034cfb79220asm15011924wrf.116.2024.05.08.02.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 02:33:46 -0700 (PDT)
Message-ID: <d9190747-953f-4c2a-9729-23d86044fb4d@redhat.com>
Date: Wed, 8 May 2024 11:33:45 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc 3/4] mm: filemap: move __lruvec_stat_mod_folio() out
 of filemap_set_pte_range()
To: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
 <20240429072417.2146732-4-wangkefeng.wang@huawei.com>
 <0bf097d2-6d2a-498b-a266-303f168b6221@redhat.com>
 <e1b19d37-82ea-447b-b9da-0a714df2c632@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <e1b19d37-82ea-447b-b9da-0a714df2c632@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.05.24 15:12, Kefeng Wang wrote:
> 
> 
> On 2024/5/7 19:11, David Hildenbrand wrote:
>> On 29.04.24 09:24, Kefeng Wang wrote:
>>> Adding __folio_add_file_rmap_ptes() which don't update lruvec stat, it
>>> is used in filemap_set_pte_range(), with it, lruvec stat updating is
>>> moved into the caller, no functional changes.
>>>
>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> ---
>>>    include/linux/rmap.h |  2 ++
>>>    mm/filemap.c         | 27 ++++++++++++++++++---------
>>>    mm/rmap.c            | 16 ++++++++++++++++
>>>    3 files changed, 36 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index 7229b9baf20d..43014ddd06f9 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -242,6 +242,8 @@ void folio_add_anon_rmap_pmd(struct folio *,
>>> struct page *,
>>>            struct vm_area_struct *, unsigned long address, rmap_t flags);
>>>    void folio_add_new_anon_rmap(struct folio *, struct vm_area_struct *,
>>>            unsigned long address);
>>> +int __folio_add_file_rmap_ptes(struct folio *, struct page *, int
>>> nr_pages,
>>> +        struct vm_area_struct *);
>>>    void folio_add_file_rmap_ptes(struct folio *, struct page *, int
>>> nr_pages,
>>>            struct vm_area_struct *);
>>>    #define folio_add_file_rmap_pte(folio, page, vma) \
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index 7019692daddd..3966b6616d02 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -3501,14 +3501,15 @@ static struct folio
>>> *next_uptodate_folio(struct xa_state *xas,
>>>    static void filemap_set_pte_range(struct vm_fault *vmf, struct folio
>>> *folio,
>>>                struct page *page, unsigned int nr, unsigned long addr,
>>> -            unsigned long *rss)
>>> +            unsigned long *rss, int *nr_mapped)
>>>    {
>>>        struct vm_area_struct *vma = vmf->vma;
>>>        pte_t entry;
>>>        entry = prepare_range_pte_entry(vmf, false, folio, page, nr, addr);
>>> -    folio_add_file_rmap_ptes(folio, page, nr, vma);
>>> +    *nr_mapped += __folio_add_file_rmap_ptes(folio, page, nr, vma);
>>> +
>>>        set_ptes(vma->vm_mm, addr, vmf->pte, entry, nr);
>>>        /* no need to invalidate: a not-present page won't be cached */
>>> @@ -3525,7 +3526,8 @@ static void filemap_set_pte_range(struct
>>> vm_fault *vmf, struct folio *folio,
>>>    static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>>>                struct folio *folio, unsigned long start,
>>>                unsigned long addr, unsigned int nr_pages,
>>> -            unsigned long *rss, unsigned int *mmap_miss)
>>> +            unsigned long *rss, int *nr_mapped,
>>> +            unsigned int *mmap_miss)
>>>    {
>>>        vm_fault_t ret = 0;
>>>        struct page *page = folio_page(folio, start);
>>> @@ -3558,7 +3560,8 @@ static vm_fault_t filemap_map_folio_range(struct
>>> vm_fault *vmf,
>>>            continue;
>>>    skip:
>>>            if (count) {
>>> -            filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>>> +            filemap_set_pte_range(vmf, folio, page, count, addr,
>>> +                          rss, nr_mapped);
>>>                if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>>                    ret = VM_FAULT_NOPAGE;
>>>            }
>>> @@ -3571,7 +3574,8 @@ static vm_fault_t filemap_map_folio_range(struct
>>> vm_fault *vmf,
>>>        } while (--nr_pages > 0);
>>>        if (count) {
>>> -        filemap_set_pte_range(vmf, folio, page, count, addr, rss);
>>> +        filemap_set_pte_range(vmf, folio, page, count, addr, rss,
>>> +                      nr_mapped);
>>>            if (in_range(vmf->address, addr, count * PAGE_SIZE))
>>>                ret = VM_FAULT_NOPAGE;
>>>        }
>>> @@ -3583,7 +3587,7 @@ static vm_fault_t filemap_map_folio_range(struct
>>> vm_fault *vmf,
>>>    static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>>>            struct folio *folio, unsigned long addr,
>>> -        unsigned long *rss, unsigned int *mmap_miss)
>>> +        unsigned long *rss, int *nr_mapped, unsigned int *mmap_miss)
>>>    {
>>>        vm_fault_t ret = 0;
>>>        struct page *page = &folio->page;
>>> @@ -3606,7 +3610,7 @@ static vm_fault_t
>>> filemap_map_order0_folio(struct vm_fault *vmf,
>>>        if (vmf->address == addr)
>>>            ret = VM_FAULT_NOPAGE;
>>> -    filemap_set_pte_range(vmf, folio, page, 1, addr, rss);
>>> +    filemap_set_pte_range(vmf, folio, page, 1, addr, rss, nr_mapped);
>>>        return ret;
>>>    }
>>> @@ -3646,6 +3650,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>>>        folio_type = mm_counter_file(folio);
>>>        do {
>>>            unsigned long end;
>>> +        int nr_mapped = 0;
>>>            addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>>>            vmf->pte += xas.xa_index - last_pgoff;
>>> @@ -3655,11 +3660,15 @@ vm_fault_t filemap_map_pages(struct vm_fault
>>> *vmf,
>>>            if (!folio_test_large(folio))
>>>                ret |= filemap_map_order0_folio(vmf,
>>> -                    folio, addr, &rss, &mmap_miss);
>>> +                    folio, addr, &rss, &nr_mapped,
>>> +                    &mmap_miss);
>>>            else
>>>                ret |= filemap_map_folio_range(vmf, folio,
>>>                        xas.xa_index - folio->index, addr,
>>> -                    nr_pages, &rss, &mmap_miss);
>>> +                    nr_pages, &rss, &nr_mapped,
>>> +                    &mmap_miss);
>>> +
>>> +        __lruvec_stat_mod_folio(folio, NR_FILE_MAPPED, nr_mapped);
>>>            folio_unlock(folio);
>>>            folio_put(folio);
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 2608c40dffad..55face4024f2 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1452,6 +1452,22 @@ static __always_inline void
>>> __folio_add_file_rmap(struct folio *folio,
>>>            mlock_vma_folio(folio, vma);
>>>    }
>>> +int __folio_add_file_rmap_ptes(struct folio *folio, struct page *page,
>>> +        int nr_pages, struct vm_area_struct *vma)
>>> +{
>>> +    int nr, nr_pmdmapped = 0;
>>> +
>>> +    VM_WARN_ON_FOLIO(folio_test_anon(folio), folio);
>>> +
>>> +    nr = __folio_add_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE,
>>> +                  &nr_pmdmapped);
>>> +
>>> +    /* See comments in folio_add_anon_rmap_*() */
>>> +    if (!folio_test_large(folio))
>>> +        mlock_vma_folio(folio, vma);
>>> +
>>> +    return nr;
>>> +}
>>
>> I'm not really a fan :/ It does make the code more complicated, and it
>> will be harder to extend if we decide to ever account differently (e.g.,
>> NR_SHMEM_MAPPED, additional tracking for mTHP etc).
> 
> If more different accounts, this may lead to bad scalability.

We already do it for PMD mappings.

>>
>> With large folios we'll be naturally batching already here, and I do
> 
> Yes, it is batched with large folios，but our fs is ext4/tmpfs, there
> are not support large folio or still upstreaming.

Okay, so that will be sorted out sooner or later.

> 
>> wonder, if this is really worth for performance, or if we could find
>> another way of batching (let the caller activate batching and drain
>> afterwards) without exposing these details to the caller.
> 
> It does reduce latency when batch lruvec stat updating without large
> folio, but I can't find better way, or let's wait for the large folio
> support on ext4/tmpfs, I also Cced memcg maintainers in patch4 to see if
> there are any other ideas.

I'm not convinced this benefit here is worth making the code more 
complicated.

Maybe we can find another way to optimize this batching in rmap code 
without having to leak these details to the callers.

For example, we could pass an optional batching structure to all rmap 
add/rel functions that would collect these stat updates. Then we could 
have one function to flush it and update the counters combined.

Such batching could be beneficial also for page unmapping/zapping where 
we might unmap various different folios in one go.

-- 
Cheers,

David / dhildenb


