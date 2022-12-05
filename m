Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA98B642BD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 16:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbiLEPbq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 10:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiLEPbE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:31:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C3C769;
        Mon,  5 Dec 2022 07:29:58 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.130.220])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 99CBF66015BC;
        Mon,  5 Dec 2022 15:29:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670254197;
        bh=2bjuDBl8NE/9ZgIEVWteEyFSeWYDZRciTha5fd+y5wY=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=k6xb+UmHTlOKRkeDCOYetikN0rr/+hksIIDwI1nLRHt6WrNV9wN+iyQWeA4uJ+Q43
         uifq/zzWWAPwjipt3UkaG8590BeI6ZIE113j30xqySPmU8Jgc/UohiQB6SMB8K7Iel
         ACINYXxpSA1v7GwpLIMRRG2TsyvRN3j8TlBNz4J141lsUgsZfoFdAzPuUzwALqEsIu
         Q6NCxQ3lwYn8N9HcmVxBZnqt4yFO9TOFiZ7cdmxpO41p0mDmsgVHcv8RpHKXLQmsws
         I2ZJMfB0ygYQTN37uV/EcBtfm+HuqB2mfqBxrTaoIurJwsjnpHnS40gpaZRNbhh4Sr
         zfoTceFf9eXag==
Message-ID: <31fe345b-06ac-8c2c-1540-76dd09eca3ee@collabora.com>
Date:   Mon, 5 Dec 2022 20:29:43 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Zach O'Keefe <zokeefe@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        "open list : KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list : PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
 <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
 <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
 <254130e7-7fb1-6cf1-e8fa-5bc2d4450431@collabora.com>
 <bfcae708-db21-04b4-0bbe-712badd03071@redhat.com>
 <3d069746-d440-f1a6-1b64-5ee196c2fc21@collabora.com>
 <d7f7b120-b62d-dc2e-ad7a-f7957d3456e3@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <d7f7b120-b62d-dc2e-ad7a-f7957d3456e3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/30/22 5:10 PM, David Hildenbrand wrote:
> On 30.11.22 12:42, Muhammad Usama Anjum wrote:
>> On 11/21/22 8:55 PM, David Hildenbrand wrote:
>>> On 21.11.22 16:00, Muhammad Usama Anjum wrote:
>>>> Hello,
>>>>
>>>> Thank you for replying.
>>>>
>>>> On 11/14/22 8:46 PM, David Hildenbrand wrote:
>>>>>> The soft-dirtiness is stored in the PTE. VMA is marked dirty to store
>>>>>> the
>>>>>> dirtiness for reused regions. Clearing the soft-dirty status of whole
>>>>>> process is straight forward. When we want to clear/monitor the
>>>>>> soft-dirtiness of a part of the virtual memory, there is a lot of
>>>>>> internal
>>>>>> noise. We don't want the non-dirty pages to become dirty because of how
>>>>>> the
>>>>>> soft-dirty feature has been working. Soft-dirty feature wasn't being
>>>>>> used
>>>>>> the way we want to use now. While monitoring a part of memory, it is not
>>>>>> acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
>>>>>> when the two VMAs are merged without considering if they both are
>>>>>> dirty or
>>>>>> not (34228d473efe). To monitor changes over the memory, sometimes
>>>>>> VMAs are
>>>>>> split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
>>>>>> decide to merge them backup. It is so waste of resources.
>>>>>
>>>>> Maybe you'd want a per-process option to not merge if the VM_SOFTDIRTY
>>>>> property differs. But that might be just one alternative for handling
>>>>> this
>>>>> case.
>>>>>
>>>>>>
>>>>>> To keep things consistent, the default behavior of the IOCTL is to
>>>>>> output
>>>>>> even the extra non-dirty pages as dirty from the kernel noise. A
>>>>>> optional
>>>>>> PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
>>>>>> tolerant of extra non-dirty pages. This flag can be considered as
>>>>>> something
>>>>>> which is by-passing the already present buggy implementation in the
>>>>>> kernel.
>>>>>> It is not buggy per say as the issue can be solved if we don't allow the
>>>>>> two VMA which have different soft-dirty bits to get merged. But we are
>>>>>> allowing that so that the total number of VMAs doesn't increase. This
>>>>>> was
>>>>>> acceptable at the time, but now with the use case of monitoring a
>>>>>> part of
>>>>>> memory for soft-dirty doesn't want this merging. So either we need to
>>>>>> revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be
>>>>>> needed
>>>>>> or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to
>>>>>> ignore
>>>>>> the extra dirty pages which aren't dirty in reality.
>>>>>>
>>>>>> When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are
>>>>>> checked to
>>>>>> find if the pages are dirty. So re-used regions cannot be detected. This
>>>>>> has the only side-effect of not checking the VMAs. So this is
>>>>>> limitation of
>>>>>> using this flag which should be acceptable in the current state of code.
>>>>>> This limitation is okay for the users as they can clear the
>>>>>> soft-dirty bit
>>>>>> of the VMA before starting to monitor a range of memory for
>>>>>> soft-dirtiness.
>>>>>>
>>>>>>
>>>>>>> Please separate that part out from the other changes; I am still not
>>>>>>> convinced that we want this and what the semantical implications are.
>>>>>>>
>>>>>>> Let's take a look at an example: can_change_pte_writable()
>>>>>>>
>>>>>>>        /* Do we need write faults for softdirty tracking? */
>>>>>>>        if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>>>>>>>            return false;
>>>>>>>
>>>>>>> We care about PTE softdirty tracking, if it is enabled for the VMA.
>>>>>>> Tracking is enabled if: vma_soft_dirty_enabled()
>>>>>>>
>>>>>>>        /*
>>>>>>>         * Soft-dirty is kind of special: its tracking is enabled when
>>>>>>>         * the vma flags not set.
>>>>>>>         */
>>>>>>>        return !(vma->vm_flags & VM_SOFTDIRTY);
>>>>>>>
>>>>>>> Consequently, if VM_SOFTDIRTY is set, we are not considering the
>>>>>>> soft_dirty
>>>>>>> PTE bits accordingly.
>>>>>> Sorry, I'm unable to completely grasp the meaning of the example. We
>>>>>> have
>>>>>> followed clear_refs_write() to write the soft-dirty bit clearing code in
>>>>>> the current patch. Dirtiness of the VMA and the PTE may be set
>>>>>> independently. Newer allocated memory has dirty bit set in the VMA. When
>>>>>> something is written the memory, the soft dirty bit is set in the
>>>>>> PTEs as
>>>>>> well regardless if the soft dirty bit is set in the VMA or not.
>>>>>>
>>>>>
>>>>> Let me try to find a simple explanation:
>>>>>
>>>>> After clearing a SOFTDIRTY PTE flag inside an area with VM_SOFTDIRTY set,
>>>>> there are ways that PTE could get written to and it could become dirty,
>>>>> without the PTE becoming softdirty.
>>>>>
>>>>> Essentially, inside a VMA with VM_SOFTDIRTY set, the PTE softdirty values
>>>>> might be stale: there might be entries that are softdirty even though the
>>>>> PTE is *not* marked softdirty.
>>>> Can someone please share the example to reproduce this? In all of my
>>>> testing, even if I ignore VM_SOFTDIRTY and only base my decision of
>>>> soft-dirtiness on individual pages, it always passes.
>>>
>>> Quick reproducer (the first and easiest one that triggered :) )
>>> attached.
>>>
>>> With no kernel changes, it works as expected.
>>>
>>> # ./softdirty_mprotect
>>>
>>>
>>> With the following kernel change to simulate what you propose it fails:
>>>
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index d22687d2e81e..f2c682bf7f64 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1457,8 +1457,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct
>>> pagemapread *pm,
>>>                  flags |= PM_FILE;
>>>          if (page && !migration && page_mapcount(page) == 1)
>>>                  flags |= PM_MMAP_EXCLUSIVE;
>>> -       if (vma->vm_flags & VM_SOFTDIRTY)
>>> -               flags |= PM_SOFT_DIRTY;
>>> +       //if (vma->vm_flags & VM_SOFTDIRTY)
>>> +       //      flags |= PM_SOFT_DIRTY;
>>>            return make_pme(frame, flags);
>>>   }
>>>
>>>
>>> # ./softdirty_mprotect
>>> Page #1 should be softdirty
>>>
>> Thank you so much for sharing the issue and reproducer.
>>
>> After remapping the second part of the memory and m-protecting +
>> m-unprotecting the whole memory, the PTE of the first half of the memory
>> doesn't get marked as soft dirty even after writing multiple times to it.
>> Even if soft-dirtiness is cleared on the whole process, the PTE of the
>> first half memory doesn't get dirty. This seems like more of a bug in
>> mprotect. The mprotect should not mess up with the soft-dirty flag in the
>> PTEs.
>>
>> I'm debugging this. I hope to find the issue soon. Soft-dirty tracking in
>> PTEs should be working correctly irrespective of the VM_SOFTDIRTY is set or
>> not on the VMA.
> 
> No, it's not a bug and these are not the VM_SOFTDIRTY semantics -- just
> because you think they should be like this. As people explained,
> VM_SOFTDIRTY implies *until now* that any PTE is consideres softdirty. And
> there are other scenarios that can similarly trigger something like that,
> besides mprotect().
> 
> Sorry if I sound annoyed, but please
> 
> 1) factor out that from your patch set for now
> 2) find a way to handle this cleanly, for example, not merging VMAs that
>    differ in VM_SOFTDIRTY
> 

I'm extremely sorry for the annoyance. I absolutely understand your point.
The problem is that the half of this IOCTL wouldn't be useful without
solving the extra soft-dirty pages issue. We don't want to upstream
something which we wouldn't be using until 2 is solved. This is why we are
trying to solve the point 2 before upstreaming the 1. I'm working on ideas
on how this can be resolved or redesigned entirely. Maybe Cyril will share
the ideas soon once he has some time. He was involved in the soft-dirty
feature development.

-- 
BR,
Muhammad Usama Anjum
