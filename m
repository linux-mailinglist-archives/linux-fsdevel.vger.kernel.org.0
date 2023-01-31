Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1897368272F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 09:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAaIpV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 03:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjAaIpF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:45:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21A4A1F2;
        Tue, 31 Jan 2023 00:40:50 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.165.226])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 40F036602EB0;
        Tue, 31 Jan 2023 08:40:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675154430;
        bh=rgu7DTIg2yh3vlm4bDLiBc5n/dNTUucjeoIq3IaxRes=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=kYq80rrVyqb14gdPV8m4rokazQdVee0TJewpQ8ndOjQdIMMManRCPZ7I/rUAomJBl
         TnK2kcah33Z5+ydN/qa4Hsp8NXXPioNzIVJX/fakke/hnDmU4ufKrvCs6qI+f4aflg
         gMZrOdIX5CNWn3vzsmej9/GMR1jbvWU0/tabs9+mvDHRLBwWJzl3X69O0SdNeqpjNp
         pmkqBP0aog2sNtThK0cxrzrt04ytFbNDQdU/V6mkkBHaxCcQICYKAxUD5DPnwuxSgs
         s2bFeAkin24Lh440R2h8vxadA/PSQiXDmc4OEI+DBat6xxExN/+yC5kTiM3B4C39zm
         75qbyyMFQESqg==
Message-ID: <a85f5857-8a96-c55f-00f8-dc498f7be334@collabora.com>
Date:   Tue, 31 Jan 2023 13:40:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v8 1/4] userfaultfd: Add UFFD WP Async support
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20230124084323.1363825-1-usama.anjum@collabora.com>
 <20230124084323.1363825-2-usama.anjum@collabora.com> <Y9MHM+RVzvigcTTk@x1n>
 <1968dff9-f48a-3290-a15b-a8b739f31ed2@collabora.com> <Y9PtHUONh2ImQyKF@x1n>
 <d8c30ea7-05a1-d53b-1391-472ff5b2a7fd@collabora.com> <Y9g2MAwycCJ3N2tf@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y9g2MAwycCJ3N2tf@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/23 2:27 AM, Peter Xu wrote:
> On Mon, Jan 30, 2023 at 01:38:16PM +0500, Muhammad Usama Anjum wrote:
>> On 1/27/23 8:32 PM, Peter Xu wrote:
>>> On Fri, Jan 27, 2023 at 11:47:14AM +0500, Muhammad Usama Anjum wrote:
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index 4000e9f017e0..8c03b133d483 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -3351,6 +3351,18 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>>>>  
>>>>>>  	if (likely(!unshare)) {
>>>>>>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>>>>>> +			if (userfaultfd_wp_async(vma)) {
>>>>>> +				/*
>>>>>> +				 * Nothing needed (cache flush, TLB invalidations,
>>>>>> +				 * etc.) because we're only removing the uffd-wp bit,
>>>>>> +				 * which is completely invisible to the user. This
>>>>>> +				 * falls through to possible CoW.
>>>>>
>>>>> Here it says it falls through to CoW, but..
>>>>>
>>>>>> +				 */
>>>>>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
>>>>>> +					   pte_clear_uffd_wp(*vmf->pte));
>>>>>> +				return 0;
>>>>>
>>>>> ... it's not doing so.  The original lines should do:
>>>>>
>>>>> https://lore.kernel.org/all/Y8qq0dKIJBshua+X@x1n/
>>>
>>> [1]
>>>
>>>>>
>>>>> Side note: you cannot modify pgtable after releasing the pgtable lock.
>>>>> It's racy.
>>>> If I don't unlock and return after removing the UFFD_WP flag in case of
>>>> async wp, the target just gets stuck. Maybe the pte lock is not unlocked in
>>>> some path.
>>>>
>>>> If I unlock and don't return, the crash happens.
>>>>
>>>> So I'd put unlock and return from here. Please comment on the below patch
>>>> and what do you think should be done. I've missed something.
>>>
>>> Have you tried to just use exactly what I suggested in [1]?  I'll paste
>>> again:
>>>
>>> ---8<---
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 4000e9f017e0..09aab434654c 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3351,8 +3351,20 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>>
>>>         if (likely(!unshare)) {
>>>                 if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>>> -                       pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> -                       return handle_userfault(vmf, VM_UFFD_WP);
>>> +                       if (userfaultfd_uffd_wp_async(vma)) {
>>> +                               /*
>>> +                                * Nothing needed (cache flush, TLB
>>> +                                * invalidations, etc.) because we're only
>>> +                                * removing the uffd-wp bit, which is
>>> +                                * completely invisible to the user.
>>> +                                * This falls through to possible CoW.
>>> +                                */
>>> +                               set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
>>> +                                          pte_clear_uffd_wp(*vmf->pte));
>>> +                       } else {
>>> +                               pte_unmap_unlock(vmf->pte, vmf->ptl);
>>> +                               return handle_userfault(vmf, VM_UFFD_WP);
>>> +                       }
>>>                 }
>>> ---8<---
>>>
>>> Note that there's no "return", neither the unlock.  The lock is used in the
>>> follow up write fault resolution and it's released later.
>> I've tried out the exact patch above. This doesn't work. The pages keep
>> their WP flag even after being resolved in do_wp_page() while is written on
>> the page.
>>
>> So I'd added pte_unmap_unlock() and return 0 from here. This makes the
>> patch to work. Maybe you can try this on your end to see what I'm seeing here?
> 
> Oh maybe it's because it didn't update orig_pte.  If you want, you can try
> again with doing so by changing:
> 
>   set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
>              pte_clear_uffd_wp(*vmf->pte));
> 
> into:
> 
>   pte_t pte = pte_clear_uffd_wp(*vmf->pte);
>   set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>   /* Update this to be prepared for following up CoW handling */
>   vmf->orig_pte = pte;
> 
It works.

>>
>>>
>>> Meanwhile please fully digest how pgtable lock is used in this path before
>>> moving forward on any of such changes.
>>>
>>>>
>>>>>
>>>>>> +			}
>>>>>>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>>>>>  			return handle_userfault(vmf, VM_UFFD_WP);
>>>>>>  		}
>>>>>> @@ -4812,8 +4824,21 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>>>>>  
>>>>>>  	if (vma_is_anonymous(vmf->vma)) {
>>>>>>  		if (likely(!unshare) &&
>>>>>> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>>>>>> -			return handle_userfault(vmf, VM_UFFD_WP);
>>>>>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
>>>>>> +			if (userfaultfd_wp_async(vmf->vma)) {
>>>>>> +				/*
>>>>>> +				 * Nothing needed (cache flush, TLB invalidations,
>>>>>> +				 * etc.) because we're only removing the uffd-wp bit,
>>>>>> +				 * which is completely invisible to the user. This
>>>>>> +				 * falls through to possible CoW.
>>>>>> +				 */
>>>>>> +				set_pmd_at(vmf->vma->vm_mm, vmf->address, vmf->pmd,
>>>>>> +					   pmd_clear_uffd_wp(*vmf->pmd));
>>>>>
>>>>> This is for THP, not hugetlb.
>>>>>
>>>>> Clearing uffd-wp bit here for the whole pmd is wrong to me, because we
>>>>> track writes in small page sizes only.  We should just split.
>>>> By detecting if the fault is async wp, just splitting the PMD doesn't work.
>>>> The below given snippit is working right now. But definately, the fault of
>>>> the whole PMD is being resolved which if we can bypass by correctly
>>>> splitting would be highly desirable. Can you please take a look on UFFD
>>>> side and suggest the changes? It would be much appreciated. I'm attaching
>>>> WIP v9 patches for you to apply on next(next-20230105) and pagemap_ioctl
>>>> selftest can be ran to test things after making changes.
>>>
>>> Can you elaborate why thp split didn't work?  Or if you want, I can look
>>> into this and provide the patch to enable uffd async mode.
>> Sorry, I was doing the wrong way. Splitting the page does work. What do you
>> think about the following:
>>
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3351,6 +3351,17 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>>
>>  	if (likely(!unshare)) {
>>  		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
>> +			if (userfaultfd_wp_async(vma)) {
>> +				/*
>> +				 * Nothing needed (cache flush, TLB invalidations,
>> +				 * etc.) because we're only removing the uffd-wp bit,
>> +				 * which is completely invisible to the user.
>> +				 */
>> +				set_pte_at(vma->vm_mm, vmf->address, vmf->pte,
>> +					   pte_clear_uffd_wp(*vmf->pte));
>> +				pte_unmap_unlock(vmf->pte, vmf->ptl);
>> +				return 0;
> 
> Please give it a shot with above to see whether we can avoid the "return 0"
> here.
> 
>> +			}
>>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
>>  			return handle_userfault(vmf, VM_UFFD_WP);
>>  		}
>> @@ -4812,8 +4823,13 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault
>> *vmf)
>>
>>  	if (vma_is_anonymous(vmf->vma)) {
>>  		if (likely(!unshare) &&
>> -		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd)) {
>> +			if (userfaultfd_wp_async(vmf->vma)) {
>> +				__split_huge_pmd(vmf->vma, vmf->pmd, vmf->address, false, NULL);
>> +				return 0;
> 
> Same here, I hope it'll work for you if you just goto __split_huge_pmd()
> right below and return with VM_FAULT_FALLBACK.  It avoids one more round of
> fault just like the pte case above.
> 
It works as well.

>> +			}
>>  			return handle_userfault(vmf, VM_UFFD_WP);
>> +		}
>>  		return do_huge_pmd_wp_page(vmf);
>>  	}
> 

-- 
BR,
Muhammad Usama Anjum
