Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9CB43C88A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhGNQdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:33:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhGNQdB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626280209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/KGvldDrB0eAalL1DiPGX7W1Lee3FENtfoeiX8YJwg=;
        b=YTV5+7NMaGPIT9viLflUBMlzmKYXOoFeXjpdD1SCRy0pg49SZKhtGoxTjTZBOLNQWA/EpN
        zqI+SsQrrEECCkF6IGmbGflFvtlKF7Evih52dfLZqfOrb73vGCitKvtpun97ih2mQpkbVG
        effn9K6IeL1z1ddn8yFK3MnJWPB8M4w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-DBbij-f8Nlu4zNo7CXP4ow-1; Wed, 14 Jul 2021 12:30:08 -0400
X-MC-Unique: DBbij-f8Nlu4zNo7CXP4ow-1
Received: by mail-wr1-f72.google.com with SMTP id m9-20020a5d4a090000b029013e2b4a9d1eso1789126wrq.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 09:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=B/KGvldDrB0eAalL1DiPGX7W1Lee3FENtfoeiX8YJwg=;
        b=iVhcW6aQ4g/KK7xaEXEYBrCOPjhkMWt/ALzxqeWOVjI1opnwXtECawlBr8FVAKZArJ
         5cFpF0nTtVxswPYs5s3Fyr02PrC6JLq5nZ97YThaIdEHYReMuQqpIb1rd9lNFP/6/2t2
         iGBsoaXgfxZ5wprE5iUEzmmvAakM5zDkDhLvZnu4x9hxmur17Z0zu16/FDWE42M6ywBv
         8/yp2DWrMG1bn83aYdGsKvmVo4dsTI4althDZyi5NWIwN0UF1yMY3yUORiMHzLqJ/Cyc
         HPvmLpBBLa8zlUPLJ4Oxrj54Y76gZts7sO+TjQkzT1RKmWopOnzVa/Hb41eh6ov/gdH2
         FcVg==
X-Gm-Message-State: AOAM530VhwIWPv3tFgMjfh/oeXZZVk0v+8NRISq0vvWpAVbOSYumt0iD
        zJJENEIZf34rkZdOYWQ+me5LEtAFqEJQVyMw2rZE3XsSqQnJUM1NL8YQ1TP22X2CGNOJ7F6Qyd+
        wj2JHUZ/wb9cteoPa0OSJltnssA==
X-Received: by 2002:a5d:4561:: with SMTP id a1mr13810743wrc.259.1626280207062;
        Wed, 14 Jul 2021 09:30:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOkWzlAEBVFt3MFLPq/RmRRAGntsLVLFQJ7RrjHjEb1hpdXy9atz6myPzK6KyqD9P4vJwl4Q==
X-Received: by 2002:a5d:4561:: with SMTP id a1mr13810709wrc.259.1626280206860;
        Wed, 14 Jul 2021 09:30:06 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c60d5.dip0.t-ipconnect.de. [91.12.96.213])
        by smtp.gmail.com with ESMTPSA id n7sm5466790wmq.37.2021.07.14.09.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 09:30:06 -0700 (PDT)
Subject: Re: [RFC PATCH 1/1] pagemap: report swap location for shared pages
From:   David Hildenbrand <david@redhat.com>
To:     Peter Xu <peterx@redhat.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        peterz@infradead.org, chinwen.chang@mediatek.com,
        linmiaohe@huawei.com, jannh@google.com, apopple@nvidia.com,
        christian.brauner@ubuntu.com, ebiederm@xmission.com,
        adobriyan@gmail.com, songmuchun@bytedance.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, ivan.teterevkov@nutanix.com,
        florian.schmidt@nutanix.com, carl.waldspurger@nutanix.com,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20210714152426.216217-1-tiberiu.georgescu@nutanix.com>
 <20210714152426.216217-2-tiberiu.georgescu@nutanix.com>
 <YO8L5PTdAs+vPeIx@t490s> <0e38ef52-0ac7-c15b-114b-3316973fc7dc@redhat.com>
Organization: Red Hat
Message-ID: <f39be587-31f4-72c0-7d39-dad02a0f5777@redhat.com>
Date:   Wed, 14 Jul 2021 18:30:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0e38ef52-0ac7-c15b-114b-3316973fc7dc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 14.07.21 18:24, David Hildenbrand wrote:
> On 14.07.21 18:08, Peter Xu wrote:
>> On Wed, Jul 14, 2021 at 03:24:26PM +0000, Tiberiu Georgescu wrote:
>>> When a page allocated using the MAP_SHARED flag is swapped out, its pagemap
>>> entry is cleared. In many cases, there is no difference between swapped-out
>>> shared pages and newly allocated, non-dirty pages in the pagemap interface.
>>>
>>> This patch addresses the behaviour and modifies pte_to_pagemap_entry() to
>>> make use of the XArray associated with the virtual memory area struct
>>> passed as an argument. The XArray contains the location of virtual pages
>>> in the page cache, swap cache or on disk. If they are on either of the
>>> caches, then the original implementation still works. If not, then the
>>> missing information will be retrieved from the XArray.
>>>
>>> Co-developed-by: Florian Schmidt <florian.schmidt@nutanix.com>
>>> Signed-off-by: Florian Schmidt <florian.schmidt@nutanix.com>
>>> Co-developed-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
>>> Signed-off-by: Carl Waldspurger <carl.waldspurger@nutanix.com>
>>> Co-developed-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
>>> Signed-off-by: Ivan Teterevkov <ivan.teterevkov@nutanix.com>
>>> Signed-off-by: Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
>>> ---
>>>    fs/proc/task_mmu.c | 37 +++++++++++++++++++++++++++++--------
>>>    1 file changed, 29 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index eb97468dfe4c..b17c8aedd32e 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1359,12 +1359,25 @@ static int pagemap_pte_hole(unsigned long start, unsigned long end,
>>>    	return err;
>>>    }
>>>    
>>> +static void *get_xa_entry_at_vma_addr(struct vm_area_struct *vma,
>>> +		unsigned long addr)
>>> +{
>>> +	struct inode *inode = file_inode(vma->vm_file);
>>> +	struct address_space *mapping = inode->i_mapping;
>>> +	pgoff_t offset = linear_page_index(vma, addr);
>>> +
>>> +	return xa_load(&mapping->i_pages, offset);
>>> +}
>>> +
>>>    static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>>    		struct vm_area_struct *vma, unsigned long addr, pte_t pte)
>>>    {
>>>    	u64 frame = 0, flags = 0;
>>>    	struct page *page = NULL;
>>>    
>>> +	if (vma->vm_flags & VM_SOFTDIRTY)
>>> +		flags |= PM_SOFT_DIRTY;
>>> +
>>>    	if (pte_present(pte)) {
>>>    		if (pm->show_pfn)
>>>    			frame = pte_pfn(pte);
>>> @@ -1374,13 +1387,22 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>>    			flags |= PM_SOFT_DIRTY;
>>>    		if (pte_uffd_wp(pte))
>>>    			flags |= PM_UFFD_WP;
>>> -	} else if (is_swap_pte(pte)) {
>>> +	} else if (is_swap_pte(pte) || shmem_file(vma->vm_file)) {
>>>    		swp_entry_t entry;
>>> -		if (pte_swp_soft_dirty(pte))
>>> -			flags |= PM_SOFT_DIRTY;
>>> -		if (pte_swp_uffd_wp(pte))
>>> -			flags |= PM_UFFD_WP;
>>> -		entry = pte_to_swp_entry(pte);
>>> +		if (is_swap_pte(pte)) {
>>> +			entry = pte_to_swp_entry(pte);
>>> +			if (pte_swp_soft_dirty(pte))
>>> +				flags |= PM_SOFT_DIRTY;
>>> +			if (pte_swp_uffd_wp(pte))
>>> +				flags |= PM_UFFD_WP;
>>> +		} else {
>>> +			void *xa_entry = get_xa_entry_at_vma_addr(vma, addr);
>>> +
>>> +			if (xa_is_value(xa_entry))
>>> +				entry = radix_to_swp_entry(xa_entry);
>>> +			else
>>> +				goto out;
>>> +		}
>>>    		if (pm->show_pfn)
>>>    			frame = swp_type(entry) |
>>>    				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
>>> @@ -1393,9 +1415,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
>>>    		flags |= PM_FILE;
>>>    	if (page && page_mapcount(page) == 1)
>>>    		flags |= PM_MMAP_EXCLUSIVE;
>>> -	if (vma->vm_flags & VM_SOFTDIRTY)
>>> -		flags |= PM_SOFT_DIRTY;
>>
>> IMHO moving this to the entry will only work for the initial iteration, however
>> it won't really help anything, as soft-dirty should always be used in pair with
>> clear_refs written with value "4" first otherwise all pages will be marked
>> soft-dirty then the pagemap data is meaningless.
>>
>> After the "write 4" op VM_SOFTDIRTY will be cleared and I expect the test case
>> to see all zeros again even with the patch.
>>
>> I think one way to fix this is to do something similar to uffd-wp: we leave a
>> marker in pte showing that this is soft-dirtied pte even if swapped out.
> 
> How exactly does such a pte look like? Simply pte_none() with another
> bit set?
> 
>> However we don't have a mechanism for that yet in current linux, and the
>> uffd-wp series is the first one trying to introduce something like that.
> 
> Can you give me a pointer? I'm very interested in learning how to
> identify this case.
> 

I assume it's 
https://lore.kernel.org/lkml/20210527202117.30689-1-peterx@redhat.com/

-- 
Thanks,

David / dhildenb

