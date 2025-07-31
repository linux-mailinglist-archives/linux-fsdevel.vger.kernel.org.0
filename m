Return-Path: <linux-fsdevel+bounces-56444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077F1B17687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 21:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2615B5404F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B082459D0;
	Thu, 31 Jul 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1/UIVNQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF50EA29;
	Thu, 31 Jul 2025 19:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753989624; cv=none; b=R5FD4kZomD/xV0axZDgzJhpg4/TNUBFf7y1SnMjSDbuhxq5wX1QWYkETYrHc/g7zbR+5zUp/HdqlcQFwxQpQbydVi4/gXUi3F8SkcFe72zI43/+BaJliieuxufKtBLpLJm57cg4DaoJhFk/PRghHu5++4fzketzI2qVzHkn2IVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753989624; c=relaxed/simple;
	bh=KYO8Jxc9JNMb08crEdLysjtpUwPE3bGbSRQ0+xUTpVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kBmzWaFGDJ36AdF7B3ClYdDGGRyMt/t9vDKH9WefsSNMidVsmXYfuHWva/lWgLXRTLCRCj9Ef9ukpV9DjomO6UKCj8d5l92Ay5MgoDzvuYBD0cxwWbjpLOLTbEAlMFQ3KRs8XzicupO155WHOLI8KJwl4C4MjnyRZhW18l873Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1/UIVNQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b78a034f17so51236f8f.2;
        Thu, 31 Jul 2025 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753989620; x=1754594420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xRLUrxlBQp402/1+RqPQa0gOaP9InJ6DfzqqzSrs2is=;
        b=a1/UIVNQ5m57BnHRSEFwJ5sfvYCmTf3s0U4lXZw3ZN3RtVLRU/WaxZbN21Hjr2a6D2
         D4cecTXChO7rwFMWOtsaTMxJ1tKc7bbs33J+dtYIWb825i+DSQFqmjLDUwQV87b/KvgR
         lyJPCYnbcW+Xc9aw1gLN7nYic9qsnBKfChDMowJ066iPBe6SNtf5149wJHkL78THiMkT
         KnRRBaFaX1w8ADPALMAX9yxq35yk7X47vFoHPCZU/ipdwwViaQ0pmYfHAOe+5dHspGqa
         7whwG4ud9X247uRiBA4BQRSNm6LUKYOY+Gmb/N2RF6tqjv1e0+iK1jp/a8ZTZe6r26iD
         d04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753989620; x=1754594420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xRLUrxlBQp402/1+RqPQa0gOaP9InJ6DfzqqzSrs2is=;
        b=YQH277ARefht3GLB2gqlWD8N/5sKsD9+ippAixIxAdhHA2ZGWSaOOtoK4aFEaTLxbC
         ChfpegP8nMU5EORMvWvdUo5e80bvskLF8PVCe5cptMk0OhPlv1Q/gsAbl9hNN5sFYUS7
         zjQ8EJcywTwtJzQ3UmzgAmwPyF4yQqrlZM0TMoBnHrcBKemBdwnWQTDryn6SQuH4M04o
         pimyH/etnA6eZKjKrOj1fW+e1ySWNxQlu2/wqOkvAjSDLb8g78ZXjzYLm75lZj2NzXdX
         /EUD0sMFDwU16eSCrB5/RBgxS/5ILcjM/c9j7VH2mnF78oc9z7RsNOt4fcDMo9vvjbfU
         tIwA==
X-Forwarded-Encrypted: i=1; AJvYcCUr0fwmOhKe2jZbYePhmHomK7ENskgIkO4YbHZUYp3dW92tQrsNfInBiIkTO6YMDQgeEbT8igaoAWyel9rSYA==@vger.kernel.org, AJvYcCV/aaUT8GxRrC+rsAgU/aLh8fEEULkyFvH68dZbkUm8Zh4uNWAIi6tiDqxCD8JfsknZoxghLHJQqwqfLS9+@vger.kernel.org, AJvYcCXpVZkdLu2eueYKUSX1yvIf5uL888/6uEacDRHUzrbaeUALDb41O0WyoV19fGy2UzfCMbY/nJW8Yuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgM85tswg8Mw9zlA4O8UF/2y1Drjn8zphFZQ0K8eUQSNXuJGv
	8NRjZeNr61ewBUb+6W9fjkdNjX5rWB0+0jeDw2dC6EU11PB0gYK6ffdr
X-Gm-Gg: ASbGncuwEkj0/+thDkaW3067IFO8tHRERUYRePU58SyJJdTxaENYkpo0FA9H9EXjced
	ylxASv/p1mnr7lBqeUjvi45TIEvkPnGJ3KOL0XmbIAtaB4B3S2EGQ7Mdfz6DFUO8N8GrhNLN5+Q
	oJ9wiUGljZ+3zxBZi1sbRh4xb0CEb6AHu9eQ6KdWzLPZcAcmBmR0xu217soog3bxpXpN6oQCdCt
	MCJ+idMApPTklVx/lkHETocx+rNOKhb2Yu4Kpyx7PHKsjbivHLD4Nsvf5gxuFsE4cm4KFJx9vvd
	bEZjSZ/5uzh51NCGXczW6PTMlQDGk0dNb3Sy0zD1EyZbYHzNFqQYyma2HBnLi40O4f4IiYFrDI3
	4pzZ+97ZwO61npBUALv36ecTMmhZwe2+y2+S7dCtMoH6DlL2wM/R3U71v0GaquO4oxHhj8eE+Di
	hx7R9iKNLkwA==
X-Google-Smtp-Source: AGHT+IEx20gxDUvHP+1hO/8jGFnF9jdKE+U4NP7atpCHfRFhwcjxuJhbA9fC6HlRmlt/4jCJ9Rz40Q==
X-Received: by 2002:a05:6000:25c8:b0:3b7:9c35:bb7 with SMTP id ffacd0b85a97d-3b79c351143mr3125976f8f.46.1753989619761;
        Thu, 31 Jul 2025 12:20:19 -0700 (PDT)
Received: from ?IPV6:2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4? ([2a02:6b6f:e759:7e00:8b4:7c1f:c64:2a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm3394382f8f.24.2025.07.31.12.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 12:20:19 -0700 (PDT)
Message-ID: <6143b8ea-24c0-4446-a0cd-821837f6e74d@gmail.com>
Date: Thu, 31 Jul 2025 20:20:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm/huge_memory: convert "tva_flags" to "enum
 tva_type" for thp_vma_allowable_order*()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, hannes@cmpxchg.org,
 baohua@kernel.org, shakeel.butt@linux.dev, riel@surriel.com, ziy@nvidia.com,
 laoar.shao@gmail.com, dev.jain@arm.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com,
 vbabka@suse.cz, jannh@google.com, Arnd Bergmann <arnd@arndb.de>,
 sj@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 kernel-team@meta.com
References: <20250731122825.2102184-1-usamaarif642@gmail.com>
 <20250731122825.2102184-3-usamaarif642@gmail.com>
 <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <c44cb864-3b36-4aa2-8040-60c97bfdc28e@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 31/07/2025 15:00, Lorenzo Stoakes wrote:
> On Thu, Jul 31, 2025 at 01:27:19PM +0100, Usama Arif wrote:
>> From: David Hildenbrand <david@redhat.com>
>>
>> Describing the context through a type is much clearer, and good enough
>> for our case.
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
> 
> Hmm actually we do weird stuff with this so maybe just handwave.
> 
> Like uprobes calls collapse_pte_mapped_thp()... :/ I'm not sure this 'If we
> are here, we've succeeded in replacing all the native pages in the page
> cache with a single hugepage.' comment is even correct.
> 
> Anyway yeah, hand wave I guess...
> 
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

Thanks for the feedback Lorenzo!

I have modified the commit message to be:

    mm/huge_memory: convert "tva_flags" to "enum tva_type"
    
    When determining which THP orders are eligible for a VMA mapping,
    we have previously specified tva_flags, however it turns out it is
    really not necessary to treat these as flags.
    
    Rather, we distinguish between distinct modes.
    
    The only case where we previously combined flags was with
    TVA_ENFORCE_SYSFS, but we can avoid this by observing that this
    is the default, except for MADV_COLLAPSE or an edge cases in
    collapse_pte_mapped_thp() and hugepage_vma_revalidate(), and
    adding a mode specifically for this case - TVA_FORCED_COLLAPSE.
    
    We have:
    * smaps handling for showing "THPeligible"
    * Pagefault handling
    * khugepaged handling
    * Forced collapse handling: primarily MADV_COLLAPSE, but also for
      an edge case in collapse_pte_mapped_thp()
    
    Ignoring the collapse_pte_mapped_thp edgecase, we only want to
    ignore sysfs only when we are forcing a collapse through
    MADV_COLLAPSE, otherwise we want to enforce it, hence this patch
    does the following flag to enum conversions:
    
    * TVA_SMAPS | TVA_ENFORCE_SYSFS -> TVA_SMAPS
    * TVA_IN_PF | TVA_ENFORCE_SYSFS -> TVA_PAGEFAULT
    * TVA_ENFORCE_SYSFS             -> TVA_KHUGEPAGED
    * 0                             -> TVA_FORCED_COLLAPSE
    
    With this change, we immediately know if we are in the forced collapse
    case, which will be valuable next.

>> ---
>>  fs/proc/task_mmu.c      |  4 ++--
>>  include/linux/huge_mm.h | 30 ++++++++++++++++++------------
>>  mm/huge_memory.c        |  8 ++++----
>>  mm/khugepaged.c         | 18 +++++++++---------
>>  mm/memory.c             | 14 ++++++--------
>>  5 files changed, 39 insertions(+), 35 deletions(-)
>>
>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>> index 3d6d8a9f13fc..d440df7b3d59 100644
>> --- a/fs/proc/task_mmu.c
>> +++ b/fs/proc/task_mmu.c
>> @@ -1293,8 +1293,8 @@ static int show_smap(struct seq_file *m, void *v)
>>  	__show_smap(m, &mss, false);
>>
>>  	seq_printf(m, "THPeligible:    %8u\n",
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
> 
>>
>>  	if (arch_pkeys_enabled())
>>  		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>> index 71db243a002e..b0ff54eee81c 100644
>> --- a/include/linux/huge_mm.h
>> +++ b/include/linux/huge_mm.h
>> @@ -94,12 +94,15 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>>  #define THP_ORDERS_ALL	\
>>  	(THP_ORDERS_ALL_ANON | THP_ORDERS_ALL_SPECIAL | THP_ORDERS_ALL_FILE_DEFAULT)
>>
>> -#define TVA_SMAPS		(1 << 0)	/* Will be used for procfs */
> 
> Dumb question, but what does 'TVA' stand for? :P
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
> 
>>
>>  #define split_folio(f) split_folio_to_list(f, NULL)
>>
>> @@ -264,14 +267,14 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>>
>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  					 vm_flags_t vm_flags,
>> -					 unsigned long tva_flags,
>> +					 enum tva_type type,
>>  					 unsigned long orders);
>>
>>  /**
>>   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>>   * @vma:  the vm area to check
>>   * @vm_flags: use these vm_flags instead of vma->vm_flags
>> - * @tva_flags: Which TVA flags to honour
>> + * @type: TVA type
>>   * @orders: bitfield of all orders to consider
>>   *
>>   * Calculates the intersection of the requested hugepage orders and the allowed
>> @@ -285,11 +288,14 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  static inline
>>  unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  				       vm_flags_t vm_flags,
>> -				       unsigned long tva_flags,
>> +				       enum tva_type type,
>>  				       unsigned long orders)
>>  {
>> -	/* Optimization to check if required orders are enabled early. */
>> -	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
>> +	/*
>> +	 * Optimization to check if required orders are enabled early. Only
>> +	 * forced collapse ignores sysfs configs.
>> +	 */
>> +	if (type != TVA_FORCED_COLLAPSE && vma_is_anonymous(vma)) {
>>  		unsigned long mask = READ_ONCE(huge_anon_orders_always);
>>
>>  		if (vm_flags & VM_HUGEPAGE)
>> @@ -303,7 +309,7 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  			return 0;
>>  	}
>>
>> -	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
>> +	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
>>  }
>>
>>  struct thpsize {
>> @@ -536,7 +542,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
>>
>>  static inline unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  					vm_flags_t vm_flags,
>> -					unsigned long tva_flags,
>> +					enum tva_type type,
>>  					unsigned long orders)
>>  {
>>  	return 0;
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 2b4ea5a2ce7d..85252b468f80 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -99,12 +99,12 @@ static inline bool file_thp_enabled(struct vm_area_struct *vma)
>>
>>  unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>  					 vm_flags_t vm_flags,
>> -					 unsigned long tva_flags,
>> +					 enum tva_type type,
>>  					 unsigned long orders)
>>  {
>> -	bool smaps = tva_flags & TVA_SMAPS;
>> -	bool in_pf = tva_flags & TVA_IN_PF;
>> -	bool enforce_sysfs = tva_flags & TVA_ENFORCE_SYSFS;
>> +	const bool smaps = type == TVA_SMAPS;
>> +	const bool in_pf = type == TVA_PAGEFAULT;
>> +	const bool enforce_sysfs = type != TVA_FORCED_COLLAPSE;
> 
> Some cheeky const-ifying, I like it :)
> 
>>  	unsigned long supported_orders;
>>
>>  	/* Check the intersection of requested and supported orders. */
>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>> index 2c9008246785..7a54b6f2a346 100644
>> --- a/mm/khugepaged.c
>> +++ b/mm/khugepaged.c
>> @@ -474,8 +474,7 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>>  {
>>  	if (!test_bit(MMF_VM_HUGEPAGE, &vma->vm_mm->flags) &&
>>  	    hugepage_pmd_enabled()) {
>> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_ENFORCE_SYSFS,
>> -					    PMD_ORDER))
>> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>>  			__khugepaged_enter(vma->vm_mm);
>>  	}
>>  }
>> @@ -921,7 +920,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>>  				   struct collapse_control *cc)
>>  {
>>  	struct vm_area_struct *vma;
>> -	unsigned long tva_flags = cc->is_khugepaged ? TVA_ENFORCE_SYSFS : 0;
>> +	enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
>> +				 TVA_FORCED_COLLAPSE;
> 
> This is great, this is so much clearer.
> 
> A nit though, I mean I come back to my 'type' vs 'tva_type' nit above, this
> is inconsistent, so we should choose one approach and stick with it.
> 

I dont exactly like the name "tva" (It has nothing to do with the fact it took
me more time than I would like to figure out that it meant THP VMA allowable :)),
so what I will do is use "type" everywhere if that is ok?
But no strong opinion and can change the variable/macro args to tva_type if that
is preferred.

The diff over v2 after taking the review comments into account looks quite trivial:

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index b0ff54eee81c..bd4f9e6327e0 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -98,7 +98,7 @@ enum tva_type {
        TVA_SMAPS,              /* Exposing "THPeligible:" in smaps. */
        TVA_PAGEFAULT,          /* Serving a page fault. */
        TVA_KHUGEPAGED,         /* Khugepaged collapse. */
-       TVA_FORCED_COLLAPSE,    /* Forced collapse (i.e., MADV_COLLAPSE). */
+       TVA_FORCED_COLLAPSE,    /* Forced collapse (e.g. MADV_COLLAPSE). */
 };
 
 #define thp_vma_allowable_order(vma, vm_flags, type, order) \
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7a54b6f2a346..88cb6339e910 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -920,7 +920,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
                                   struct collapse_control *cc)
 {
        struct vm_area_struct *vma;
-       enum tva_type tva_type = cc->is_khugepaged ? TVA_KHUGEPAGED :
+       enum tva_type type = cc->is_khugepaged ? TVA_KHUGEPAGED :
                                 TVA_FORCED_COLLAPSE;
 
        if (unlikely(hpage_collapse_test_exit_or_disable(mm)))
@@ -932,7 +932,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 
        if (!thp_vma_suitable_order(vma, address, PMD_ORDER))
                return SCAN_ADDRESS_RANGE;
-       if (!thp_vma_allowable_order(vma, vma->vm_flags, tva_type, PMD_ORDER))
+       if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
                return SCAN_VMA_CHECK;
        /*
         * Anon VMA expected, the address may be unmapped then
@@ -1532,8 +1532,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
         * in the page cache with a single hugepage. If a mm were to fault-in
         * this memory (mapped by a suitably aligned VMA), we'd get the hugepage
         * and map it by a PMD, regardless of sysfs THP settings. As such, let's
-        * analogously elide sysfs THP settings here and pretend we are
-        * collapsing.
+        * analogously elide sysfs THP settings here and force collapse.
         */
        if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
                return SCAN_VMA_CHECK;

