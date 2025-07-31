Return-Path: <linux-fsdevel+bounces-56434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5224B174CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 18:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B48586D05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642362356DA;
	Thu, 31 Jul 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OfOm7dSA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE5223714
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978559; cv=none; b=tOI3cAONzD0ms0woswGdeuORYalcLP2GU8H3RYRaAQD+AyFdu3VtCqu3VFYH68v8d7gG2vbC2W4DPzCKjPOhpKbGsykfAD7PQKF2i/A/bthkyu32H4IX/rs9yUa7AvcULBXZPL4tbmqNR10K6IUX4tkFCq7D5PxSNK/enwueClg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978559; c=relaxed/simple;
	bh=NmK9mpCX/2zw5F1BJI2dwZwnnUGC/SRcSDSLx0fItOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PUNxlyFFkhvSNw6CGLDz+IrdxhFBZG1R2Ewe3B9iDaUVO0KkOvjKCB5c6Fa8tixTNM1xboHebFuMxywnW3c7vLrmKNANF8ZxV4VagSLQbnxCPHQdO6cCr6+IqFNGQUVLvIZr1XalqD9d36wy7i9Tmoyj+WayqGLjAk59W/LXKQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OfOm7dSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753978556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hCFMEvUPyBLrGC/oYDfyk4mKEAk9olU5xdsqV7nWMUs=;
	b=OfOm7dSA3e9fPSKb1XPDxekcSp6SaZUj8G+p/N9mo1ZVrKVDvrym13JbqxkG6JX64/Hgk2
	0BBITEl8qgWlwpnYwCkn/5leqRypwfF+fLJWfIsQxf/LJpt47uNYoWm/ImfiyemxgHsCp5
	VzIOshQ2yqZ1k8AH+q6oAJxwjGgQ9zY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-iwBCd937Nhy8fUsGr9bLUw-1; Thu, 31 Jul 2025 12:15:40 -0400
X-MC-Unique: iwBCd937Nhy8fUsGr9bLUw-1
X-Mimecast-MFC-AGG-ID: iwBCd937Nhy8fUsGr9bLUw_1753978539
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b7851a096fso520400f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 09:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753978539; x=1754583339;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hCFMEvUPyBLrGC/oYDfyk4mKEAk9olU5xdsqV7nWMUs=;
        b=ZqQlAz/+JYWlehhuBpA/X7MiUBTqUekw7QShRDZF2Ngq1KiX+yL2FbrRe15v8qfWXK
         4Z6diemdn9M8gjGs4QEgiJLwAzKPC0hwRAu9cIP7tljR+w1YW+1bQawqzuGqhmUtWSd4
         6XvMiLuvYnazrSXpVZYJa7MlkKY4P7HPsJAqkPOc0xfifOg4SzUspnzXDwa7Wf95M/D5
         gidjnhAyvrCJZOv8GxtfQ1BouigWu8CmQsdbgPhyTjI6kR8FM+AQR4r0EnBxjW6FF8oE
         Um8YHKTyrgjPV/7IF8MJ9UkSY4yqjEtw0acQPZABwRmRGtooHgHTR/sMJhNKubjv+8gv
         iA0w==
X-Forwarded-Encrypted: i=1; AJvYcCVFNClAZ1x7BCtkhYRrauRCEIKQ1BbZDylyHce/tJ4hmOmvq/eyXOO/CYqVU5ZkYFrrj5cO1WcLkdNfxqBS@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLqJa14bzYJ5tl7rumiCm7A0dKSgYT1gRQ4Rp2MdH6NhQHOUa
	gdWH6u86jzzSJCXAv9QOwdku1n4o8wUXhJpy4dBUmjoEHTRQsB8i5vrXAYcG9iF1ebBy9ta6MQs
	kw4GFkmIaHtabcYaJbcPPBSuRakvKko5fwHsypFoP09j4pj7GPBlYkZkW6TgkYGAs27c=
X-Gm-Gg: ASbGncvVX/fNz2pdi2mUnGg7wGDRA2xy15K28wNvR6hq8mMXQ5fc703niVht4MvY56l
	JdIbVoOCzwJ9kfTfq8XT0+rHl0kXv9pr2rnr0COzhH3Hpg7c1p7g5/bhjHSx3PlE4PS7OHbvP/R
	4F0pMS2g4n1/TM4qu9etQjEy0Vja1FdJ+ePwxTRAZ4afmO6IE/FaXQpnFqOEPJ4orjzozZIvo3Y
	AIW+mXin+OW5CJa1iuIBf746kH2itvBhnmtmn8fxWduC+vAMj//RRVDkKlfsL63wQR0IuRqp7wA
	NF1NvhyjV/Yb4wdi1T1z27yMD9EeOYLVS4N6bcCapZPLZSmH9FC3p7Z9aAiC0pq5mVjA3+QYUMB
	18MNhhG0eiZ14X1LfsolizoNMdu3jHFwCL7clx/JCtEozY4V1Y6cVoTpPVUYiy90bvjw=
X-Received: by 2002:a5d:5f90:0:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3b7950065fdmr6170018f8f.49.1753978538656;
        Thu, 31 Jul 2025 09:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGytZULQmZ/hDajIkM/Htt7MthdICmHyxaaQPthRUhPkwjUZgExKSH13cnPbk4HyFbkpq+P8Q==
X-Received: by 2002:a5d:5f90:0:b0:3a4:fbaf:749e with SMTP id ffacd0b85a97d-3b7950065fdmr6169988f8f.49.1753978538121;
        Thu, 31 Jul 2025 09:15:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f44:3700:be07:9a67:67f7:24e6? (p200300d82f443700be079a6767f724e6.dip0.t-ipconnect.de. [2003:d8:2f44:3700:be07:9a67:67f7:24e6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4a6f62sm2778077f8f.73.2025.07.31.09.15.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 09:15:37 -0700 (PDT)
Message-ID: <09acd558-19b9-4964-823b-502b9044f954@redhat.com>
Date: Thu, 31 Jul 2025 18:15:35 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, corbet@lwn.net, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org, baohua@kernel.org,
 shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-3-usamaarif642@gmail.com>
 <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.07.25 16:00, Lorenzo Stoakes wrote:
> On Thu, Jul 31, 2025 at 01:27:19PM +0100, Usama Arif wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Describing the context through a type is much clearer, and good enough
>> for our case.

Just for the other patch, I'll let Usama take it from here, just a bunch 
of comments.

> 
> This is pretty bare bones. What context, what type? Under what
> circumstances?
> 
> This also is missing detail on the key difference here - that actually it
> turns out we _don't_ need these to be flags, rather we can have _distinct_
> modes which are clearer.
> 
> I'd say something like:
> 
> 	when determining which THP orders are eligiible for a VMA mapping,
> 	we have previously specified tva_flags, however it turns out it is
> 	really not necessary to treat these as flags.
> 
> 	Rather, we distinguish between distinct modes.
> 
> 	The only case where we previously combined flags was with
> 	TVA_ENFORCE_SYSFS, but we can avoid this by observing that this is
> 	the default, except for MADV_COLLAPSE or an edge cases in
> 	collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and adding
> 	a mode specifically for this case - TVA_FORCED_COLLAPSE.
> 
> 	... stuff about the different modes...
> 
>>
>> We have:
>> * smaps handling for showing "THPeligible"
>> * Pagefault handling
>> * khugepaged handling
>> * Forced collapse handling: primarily MADV_COLLAPSE, but one other odd case
> 
> Can we actually state what this case is? I mean I guess a handwave in the
> form of 'an edge case in collapse_pte_mapped_thp()' will do also.

Yeah, something like that. I think we also call it when we previously 
checked that there is a THP and that we might be allowed to collapse. 
E.g., collapse_pte_mapped_thp() is also called from khugepaged code 
where we already checked the allowed order.

> 
> Hmm actually we do weird stuff with this so maybe just handwave.
> 
> Like uprobes calls collapse_pte_mapped_thp()... :/ I'm not sure this 'If we
> are here, we've succeeded in replacing all the native pages in the page
> cache with a single hugepage.' comment is even correct.

I think in all these cases we already have a THP and want to force that 
collapse in the page table.

[...]

>>
>> Really, we want to ignore sysfs only when we are forcing a collapse
>> through MADV_COLLAPSE, otherwise we want to enforce.
> 
> I'd say 'ignoring this edge case, ...'
> 
> I think the clearest thing might be to literally list the before/after
> like:
> 
> * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
> * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
> * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
> * 0                             -> TVA_FORCED_COLLAPSE
> 

That makes sense.

>>
>> With this change, we immediately know if we are in the forced collapse
>> case, which will be valuable next.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Usama Arif <usamaarif642@gmail.com>
>> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> 
> Overall this is a great cleanup, some various nits however.
> 
>> ---
>>   fs/proc/task_mmu.c      |  4 ++--
>>   include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>>   mm/huge_memory.c        |  8 ++++----
>>   mm/khugepaged.c         | 18 +++++++++---------
>>   mm/memory.c             | 14 ++++++--------
>>   5 files changed, 39 insertions(+), 35 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 3d6d8a9f13fc..d440df7b3d59 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
>>   	__show_smap(m, &mss, false);
>>
>>   	seq_printf(m, "THPeligible:    %8u\n",
>> -		   !!thp_vma_allowable_orders(vma, vma->vm_flags,
>> -			   TVA_SMAPS | TVA_ENFORCE_SYSFS, THP_ORDERS_ALL));
>> +		   !!thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SMAPS,
>> +					      THP_ORDERS_ALL));
> 
> This !! is so gross, wonder if we could have a bool wrapper. But not a big
> deal.
> 
> I also sort of _hate_ the smaps flag anyway, invoking this 'allowable
> orders' thing just for smaps reporting with maybe some minor delta is just
> odd.
> 
> Something like `bool vma_has_thp_allowed_orders(struct vm_area_struct
> *vma);` would be nicer.
> 
> Anyway thoughts for another time... :)

Yeah, that's not the only nasty bit here ... :)

> 
>>
>>   	if (arch_pkeys_enabled())
>>   		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 71db243a002e..b0ff54eee81c 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>>   #define THP_ORDERS_ALL	\
>>   	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
>>
>> -#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
> 
> Dumb question, but what does 'TVA' stand for? :P

Whoever came up with that probably used the function name where this is 
passed in

thp_vma_allowable_orders()

> 
>> -#define TVA_IN_PF		(1 << 1)	/* Page fault handler */
>> -#define TVA_ENFORCE_SYSFS	(1 << 2)	/* Obey sysfs configuration */
>> +enum tva_type {
>> +	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
> 
> How I hate this flag (just an observation...)
> 
>> +	TVA_PAGEFAULT,		/* Serving a page fault. */
>> +	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
> 
> This is equivalent to the TVA_ENFORCE_SYSFS case before, sort of a default
> I guess, but actually quite nice to add the context that it's sourced from
> khugepaged - I assume this will always be the case when specified?
> 
>> +	TVA_FORCED_COLLAPSE,	/* Forced collapse (i.e., MADV_COLLAPSE). */
> 
> Would put 'e.g.' here, then that allows 'space' for the edge case...

Makes sense.

> 
>> +};
>>
>> -#define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
>> -	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
>> +#define thp_vma_allowable_order(vma, vm_flags, type, order) \
>> +	(!!thp_vma_allowable_orders(vma, vm_flags, type, BIT(order)))
> 
> Nit, but maybe worth keeping tva_ prefix - tva_type - here just so it's
> clear what type it refers to.
> 
> But not end of the world.
> 
> Same comment goes for param names below etc.

No strong opinion, but I prefer to drop the prefix when it can be 
deduced from the type and we are inside of the very function that 
essentially defines these types (tva prefix is implicit, no other type 
applies).

These should probably just be inline functions at some point with proper 
types and doc (separate patch uin the future, of course).

[...]

>> +++ b/mm/khugepaged.c
>> @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>>   {
>>   	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>>   	    hugepage_pmd_enabled()) {
>> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
>> -					    PMD_ORDER))
>> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>>   			__khugepaged_enter(vma->vm_mm);
>>   	}
>>   }
>> @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>   				   struct collapse_control *cc)
>>   {
>>   	struct vm_area_struct *vma;
>> -	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>> +	enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
>> +				 TVA_FORCED_COLLAPSE;
> 
> This is great, this is so much clearer.
> 
> A nit though, I mean I come back to my 'type' vs 'tva_type' nit above, this
> is inconsistent, so we should choose one approach and stick with it.

This is outside of the function, so I would prefer to keep it here, but 
no stong opinion.

> 
>>
>>   	if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
>>   		return SCAN_ANY_PROCESS;
>> @@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>
>>   	if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
>>   		return SCAN_ADDRESS_RANGE;
>> -	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_flags, PMD_ORDER))
>> +	if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_type, PMD_ORDER))
>>   		return SCAN_VMA_CHECK;
>>   	/*
>>   	 * Anon VMA expected, the address may be unmapped then
>> @@ -1532,9 +1532,10 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>>   	 * in the page cache with a single hugepage. If a mm were to fault-in
>>   	 * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
>>   	 * and map it by a PMD, regardless of sysfs THP settings. As such, let's
>> -	 * analogously elide sysfs THP settings here.
>> +	 * analogously elide sysfs THP settings here and pretend we are
>> +	 * collapsing.
> 
> I think saying pretending here is potentially confusing, maybe worth saying
> 'force collapse'?

Makes sense.

-- 
Cheers,

David / dhildenb


