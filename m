Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40820625446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 08:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiKKHIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 02:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbiKKHIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 02:08:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763BB7E;
        Thu, 10 Nov 2022 23:08:31 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.244.84])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C770D6602A3B;
        Fri, 11 Nov 2022 07:08:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668150509;
        bh=pvIdnfnFRLkb9a2WsNljwiMXvnygDQauyNsDYqh/4sw=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=a5IeFXQ/Otx+hHDjdjJ57JXvMLxKAVXVj3N3JerNDwTqsU8T5dTLmrXNotJ2xfYZO
         wKftbfi4MhZip2xZRQyPyB/IjFeCCUK8JKkD7GwA+MLxPbGmkuTKGfgR7mzaa0XXyQ
         RsmrcnRebwcCYC9PGWzJss5rvF//jf/aGUkCN7z+4wBD+yv3JDCf32pdK9G6FyhtxU
         fihhvb29PlidnvksyvOwaI30yPipxkiu3WQ4mOZzkKSnD4XDRAdjZ4UTE4qhlDLkd4
         0Zpny0U+8ymMvxAjOys5whOlry/roGm+PK5fyIX4Fm/cf4QDz/xCf1Q4coA45s9P2C
         uDKeDZvuhNI/A==
Message-ID: <6fdce544-8d4f-8b3c-9208-735769a9e624@collabora.com>
Date:   Fri, 11 Nov 2022 12:08:18 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v6 0/3] Implement IOCTL to get and/or the clear info about
 PTEs
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
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
References: <20221109102303.851281-1-usama.anjum@collabora.com>
 <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
Content-Language: en-US
In-Reply-To: <9c167d01-ef09-ec4e-b4a1-2fff62bf01fe@redhat.com>
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

On 11/9/22 3:34 PM, David Hildenbrand wrote:
> On 09.11.22 11:23, Muhammad Usama Anjum wrote:
[...]
>> Some non-dirty pages get marked as dirty because of the kernel's
>> internal activity (such as VMA merging as soft-dirty bit difference isn't
>> considered while deciding to merge VMAs). The dirty bit of the pages is
>> stored in the VMA flags and in the per page flags. If any of these two bits
>> are set, the page is considered to be soft dirty. Suppose you have cleared
>> the soft dirty bit of half of VMA which will be done by splitting the VMA
>> and clearing soft dirty bit flag in the half VMA and the pages in it. Now
>> kernel may decide to merge the VMAs again. So the half VMA becomes dirty
>> again. This splitting/merging costs performance. The application receives
>> a lot of pages which aren't dirty in reality but marked as dirty.
>> Performance is lost again here. Also sometimes user doesn't want the newly
>> allocated memory to be marked as dirty. PAGEMAP_NO_REUSED_REGIONS flag
>> solves both the problems. It is used to not depend on the soft dirty flag
>> in the VMA flags. So VMA splitting and merging doesn't happen. It only
>> depends on the soft dirty bit of the individual pages. Thus by using this
>> flag, there may be a scenerio such that the new memory regions which are
>> just created, doesn't look dirty when seen with the IOCTL, but look dirty
>> when seen from procfs. This seems okay as the user of this flag know the
>> implication of using it.
The soft-dirtiness is stored in the PTE. VMA is marked dirty to store the
dirtiness for reused regions. Clearing the soft-dirty status of whole
process is straight forward. When we want to clear/monitor the
soft-dirtiness of a part of the virtual memory, there is a lot of internal
noise. We don't want the non-dirty pages to become dirty because of how the
soft-dirty feature has been working. Soft-dirty feature wasn't being used
the way we want to use now. While monitoring a part of memory, it is not
acceptable to get non-dirty pages as dirty. Non-dirty pages become dirty
when the two VMAs are merged without considering if they both are dirty or
not (34228d473efe). To monitor changes over the memory, sometimes VMAs are
split to clear the soft-dirty bit in the VMA flags. But sometimes kernel
decide to merge them backup. It is so waste of resources.

To keep things consistent, the default behavior of the IOCTL is to output
even the extra non-dirty pages as dirty from the kernel noise. A optional
PAGEMAP_NO_REUSED_REGIONS flag is added for those use cases which aren't
tolerant of extra non-dirty pages. This flag can be considered as something
which is by-passing the already present buggy implementation in the kernel.
It is not buggy per say as the issue can be solved if we don't allow the
two VMA which have different soft-dirty bits to get merged. But we are
allowing that so that the total number of VMAs doesn't increase. This was
acceptable at the time, but now with the use case of monitoring a part of
memory for soft-dirty doesn't want this merging. So either we need to
revert 34228d473efe and PAGEMAP_NO_REUSED_REGIONS flag will not be needed
or we should allow PAGEMAP_NO_REUSED_REGIONS or similar mechanism to ignore
the extra dirty pages which aren't dirty in reality.

When PAGEMAP_NO_REUSED_REGIONS flag is used, only the PTEs are checked to
find if the pages are dirty. So re-used regions cannot be detected. This
has the only side-effect of not checking the VMAs. So this is limitation of
using this flag which should be acceptable in the current state of code.
This limitation is okay for the users as they can clear the soft-dirty bit
of the VMA before starting to monitor a range of memory for soft-dirtiness.


> Please separate that part out from the other changes; I am still not
> convinced that we want this and what the semantical implications are.
> 
> Let's take a look at an example: can_change_pte_writable()
> 
>     /* Do we need write faults for softdirty tracking? */
>     if (vma_soft_dirty_enabled(vma) && !pte_soft_dirty(pte))
>         return false;
> 
> We care about PTE softdirty tracking, if it is enabled for the VMA.
> Tracking is enabled if: vma_soft_dirty_enabled()
> 
>     /*
>      * Soft-dirty is kind of special: its tracking is enabled when
>      * the vma flags not set.
>      */
>     return !(vma->vm_flags & VM_SOFTDIRTY);
> 
> Consequently, if VM_SOFTDIRTY is set, we are not considering the soft_dirty
> PTE bits accordingly.
Sorry, I'm unable to completely grasp the meaning of the example. We have
followed clear_refs_write() to write the soft-dirty bit clearing code in
the current patch. Dirtiness of the VMA and the PTE may be set
independently. Newer allocated memory has dirty bit set in the VMA. When
something is written the memory, the soft dirty bit is set in the PTEs as
well regardless if the soft dirty bit is set in the VMA or not.

> 
> 
> I'd suggest moving forward without this controversial
> PAGEMAP_NO_REUSED_REGIONS functionality for now, and preparing it as a
> clear add-on we can discuss separately.Like I've described above, I've only added this flag to not get the
non-dirty pages as dirty. Can there be some alternative to adding this
flag? Please suggest.


--
BR,
Muhammad Usama Anjum
