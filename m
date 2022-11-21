Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1660E632767
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiKUPK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 10:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiKUPJw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:09:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715B2D2F78;
        Mon, 21 Nov 2022 07:00:47 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.241.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7C72966029A5;
        Mon, 21 Nov 2022 15:00:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669042845;
        bh=M3Swul50R+VFzoP/f23mK9UtV+LTG0RgsqO+dggNkSQ=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=SVo6rWoKLhGqK/3yW6FwCRbq8ukHC9MYFCfi4LnciyABINq/fPBgOtwhni7jrmyM3
         jdaB6k0MblEL+tf8xTkEi5QnaLjltCWUjQFAC0gkuWWsD/Va5Vl2Bx4qVrO9Su4uAm
         r5+4cGFzZj8QnQl711qeIVBRHF9EeV5KAq9Gqwn+CEi+flLuWnb8poVbW5iI8WTNfM
         /Hnz9Hs+8EUauSedzSfarCQbh4OBkqH1GyxE/1G9SOEnqHkQN0ugM32Q+9mPJgvSgM
         ZfVpKaqqcQVmDUzImfIoAqSd9sYm47H27BoBNJEX230JJKn29bA7xH+bU6gwDgvbtK
         QQKeO6/p4XZOA==
Message-ID: <254130e7-7fb1-6cf1-e8fa-5bc2d4450431@collabora.com>
Date:   Mon, 21 Nov 2022 20:00:36 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
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
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
 <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
 <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a90ee936-67a9-340d-bf2c-2f331617b0da@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

Thank you for replying.

On 11/14/22 8:46 PM, David Hildenbrand wrote:
>> The soft-dirtiness is stored in the PTE. VMA is marked dirty to store the
>> dirtiness for reused regions. Clearing the soft-dirty status of whole
>> process is straight forward. When we want to clear/monitor the
>> soft-dirtiness of a part of the virtual memory, there is a lot of internal
>> noise. We don't want the non-dirty pages to become dirty because of how the
>> soft-dirty feature has been working. Soft-dirty feature wasn't being used
>> the way we want to use now. While monitoring a part of memory, it is not
>> acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
>> when the two VMAs are merged without considering if they both are dirty or
>> not (34228d473efe). To monitor changes over the memory, sometimes VMAs are
>> split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
>> decide to merge them backup. It is so waste of resources.
> 
> Maybe you'd want a per-process option to not merge if the VM_SOFTDIRTY
> property differs. But that might be just one alternative for handling this
> case.
> 
>>
>> To keep things consistent, the default behavior of the IOCTL is to output
>> even the extra non-dirty pages as dirty from the kernel noise. A optional
>> PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
>> tolerant of extra non-dirty pages. This flag can be considered as something
>> which is by-passing the already present buggy implementation in the kernel.
>> It is not buggy per say as the issue can be solved if we don't allow the
>> two VMA which have different soft-dirty bits to get merged. But we are
>> allowing that so that the total number of VMAs doesn't increase. This was
>> acceptable at the time, but now with the use case of monitoring a part of
>> memory for soft-dirty doesn't want this merging. So either we need to
>> revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be needed
>> or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to ignore
>> the extra dirty pages which aren't dirty in reality.
>>
>> When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are checked to
>> find if the pages are dirty. So re-used regions cannot be detected. This
>> has the only side-effect of not checking the VMAs. So this is limitation of
>> using this flag which should be acceptable in the current state of code.
>> This limitation is okay for the users as they can clear the soft-dirty bit
>> of the VMA before starting to monitor a range of memory for soft-dirtiness.
>>
>>
>>> Please separate that part out from the other changes; I am still not
>>> convinced that we want this and what the semantical implications are.
>>>
>>> Let's take a look at an example: can_change_pte_writable()
>>>
>>>      /* Do we need write faults for softdirty tracking? */
>>>      if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>>>          return false;
>>>
>>> We care about PTE softdirty tracking, if it is enabled for the VMA.
>>> Tracking is enabled if: vma_soft_dirty_enabled()
>>>
>>>      /*
>>>       * Soft-dirty is kind of special: its tracking is enabled when
>>>       * the vma flags not set.
>>>       */
>>>      return !(vma->vm_flags & VM_SOFTDIRTY);
>>>
>>> Consequently, if VM_SOFTDIRTY is set, we are not considering the soft_dirty
>>> PTE bits accordingly.
>> Sorry, I'm unable to completely grasp the meaning of the example. We have
>> followed clear_refs_write() to write the soft-dirty bit clearing code in
>> the current patch. Dirtiness of the VMA and the PTE may be set
>> independently. Newer allocated memory has dirty bit set in the VMA. When
>> something is written the memory, the soft dirty bit is set in the PTEs as
>> well regardless if the soft dirty bit is set in the VMA or not.
>>
> 
> Let me try to find a simple explanation:
> 
> After clearing a SOFTDIRTY PTE flag inside an area with VM_SOFTDIRTY set,
> there are ways that PTE could get written to and it could become dirty,
> without the PTE becoming softdirty.
> 
> Essentially, inside a VMA with VM_SOFTDIRTY set, the PTE softdirty values
> might be stale: there might be entries that are softdirty even though the
> PTE is *not* marked softdirty.
Can someone please share the example to reproduce this? In all of my
testing, even if I ignore VM_SOFTDIRTY and only base my decision of
soft-dirtiness on individual pages, it always passes.

> 
> These are, AFAIU, the current semantics, and I am not sure if we want user
> space to explicitly work around that.
> 
>>>
>>>
>>> I'd suggest moving forward without this controversial
>>> PAGEMAP_NO_REUSED_REGIONS functionality for now, and preparing it as a
>>> clear add-on we can discuss separately.Like I've described above, I've
>>> only added this flag to not get the
>> non-dirty pages as dirty. Can there be some alternative to adding this
>> flag? Please suggest.
> 
> Please split it out into a separate patch for now. We can discuss further
> what the semantics are and if there are better alternatives for that. In
> the meantime, you could move forward without PAGEMAP_NO_REUSED_REGIONS
> while we are discussing them further.
> 

-- 
BR,
Muhammad Usama Anjum
