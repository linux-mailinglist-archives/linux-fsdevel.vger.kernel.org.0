Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F300E6A0334
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 08:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjBWHKy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 02:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBWHKx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:10:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991304A1D2;
        Wed, 22 Feb 2023 23:10:52 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A5D366021EE;
        Thu, 23 Feb 2023 07:10:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677136250;
        bh=l/p5o6Wgs9SQqz6XM6V90URqUHPwWct0pb1tZfq2qT8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jXxbccMkuSbQ+H0cNGv5LnGxMywISsVIclNBnzIYcGl/abV5K/IO87gZ9YKhN9rKS
         Ld/QTGNc6sMW8SwKqk+sQAFtffKPP53Yp+tQZCvgePK8Oa4gI6FPlge1jetOe+0Bt8
         rxidSPecRM2vLvm8Khloj5UfIEd0mFSPieVa1VzFUNGXmrMAsBdEezU3I+sL9o9sTW
         z6Qmee2QXBwWbVfxr6n4KnbkKpO4A9heQ7n9fD0BeGu7nsUFvTIoo51fcyaHl9fY2O
         vqv4Ed4Iv0fwynrOvQVtaEuzUKKkrvMqX5s4kHvFydWBJeqgRw/ZOrn9qcBDdF52Wc
         QcvwF/s72GgyA==
Message-ID: <c15446c5-eedd-690f-9dae-2bc12ee9eb78@collabora.com>
Date:   Thu, 23 Feb 2023 12:10:40 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Cyrill Gorcunov <gorcunov@gmail.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     Nadav Amit <namit@vmware.com>, Mike Rapoport <rppt@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <cf36b6ea-6268-deff-d9ed-6782de2bd0a7@gmail.com>
 <2fe790e5-89e0-d660-79cb-15160dffd907@collabora.com>
 <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <751CCD6C-BFD1-42BD-A651-AE8E9568568C@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nadav, Mike, Michał,

Can you please share your thoughts at [A] below?

On 2/23/23 12:10 AM, Nadav Amit wrote:
> 
> 
>> On Feb 20, 2023, at 5:24 AM, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>
>>>> +static inline int pagemap_scan_pmd_entry(pmd_t *pmd, unsigned long start,
>>>> +                     unsigned long end, struct mm_walk *walk)
>>>> +{
>>>> +    struct pagemap_scan_private *p = walk->private;
>>>> +    struct vm_area_struct *vma = walk->vma;
>>>> +    unsigned long addr = end;
>>>> +    spinlock_t *ptl;
>>>> +    int ret = 0;
>>>> +    pte_t *pte;
>>>> +
>>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>> +    ptl = pmd_trans_huge_lock(pmd, vma);
>>>> +    if (ptl) {
>>>> +        bool pmd_wt;
>>>> +
>>>> +        pmd_wt = !is_pmd_uffd_wp(*pmd);
>>>> +        /*
>>>> +         * Break huge page into small pages if operation needs to be
>>>> performed is
>>>> +         * on a portion of the huge page.
>>>> +         */
>>>> +        if (pmd_wt && IS_WP_ENGAGE_OP(p) && (end - start < HPAGE_SIZE)) {
>>>> +            spin_unlock(ptl);
>>>> +            split_huge_pmd(vma, pmd, start);
>>>> +            goto process_smaller_pages;
>>> I think that such goto's are really confusing and should be avoided. And
>>> using 'else' (could have easily prevented the need for goto). It is not the
>>> best solution though, since I think it would have been better to invert the
>>> conditions.
>> Yeah, else can be used here. But then we'll have to add a tab to all the
>> code after adding else. We have already so many tabs and very less space to
>> right code. Not sure which is better.
> 
> goto’s are usually not the right solution. You can extract things into a different
> function if you have to.
> 
> I’m not sure why IS_GET_OP(p) might be false and what’s the meaning of taking the
> lock and dropping it in such a case. I think that the code can be simplified and
> additional condition nesting can be avoided.
Lock is taken and we check if pmd has UFFD_WP set or not. In the next
version, the GET check has been removed as we have dropped WP_ENGAGE + !GET
operation. So get is always specified and condition isn't needed.

Please comment on next version if you want anything more optimized.

> 
>>>> --- a/include/uapi/linux/fs.h
>>>> +++ b/include/uapi/linux/fs.h
>>>> @@ -305,4 +305,54 @@ typedef int __bitwise __kernel_rwf_t;
>>>>  #define RWF_SUPPORTED    (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
>>>>               RWF_APPEND)
>>>>  +/* Pagemap ioctl */
>>>> +#define PAGEMAP_SCAN    _IOWR('f', 16, struct pagemap_scan_arg)
>>>> +
>>>> +/* Bits are set in the bitmap of the page_region and masks in
>>>> pagemap_scan_args */
>>>> +#define PAGE_IS_WRITTEN        (1 << 0)
>>>> +#define PAGE_IS_FILE        (1 << 1)
>>>> +#define PAGE_IS_PRESENT        (1 << 2)
>>>> +#define PAGE_IS_SWAPPED        (1 << 3)
>>>
>>> These names are way too generic and are likely to be misused for the wrong
>>> purpose. The "_IS_" part seems confusing as well. So I think the naming
>>> needs to be fixed and some new type (using typedef) or enum should be
>>> introduced to hold these flags. I understand it is part of uapi and it is
>>> less common there, but it is not unheard of and does make things clearer.
>> Do you think PM_SCAN_PAGE_IS_* work here?
> 
> Can we lose the IS somehow?
[A] Do you think these names would work better: PM_SCAN_WRITTEN_PAGE,
PM_SCAN_FILE_PAGE, PM_SCAN_SWAP_PAGE, PM_SCAN_PRESENT_PAGE?

> 
>>
>>>
>>>
>>>> +
>>>> +/*
>>>> + * struct page_region - Page region with bitmap flags
>>>> + * @start:    Start of the region
>>>> + * @len:    Length of the region
>>>> + * bitmap:    Bits sets for the region
>>>> + */
>>>> +struct page_region {
>>>> +    __u64 start;
>>>> +    __u64 len;
>>>
>>> I presume in bytes. Would be useful to mention.
>> Length of region in pages.
> 
> Very unintuitive to me I must say. If the start is an address, I would expect
> the len to be in bytes.
The PAGEMAP_SCAN ioctl is working on page granularity level. We tell the
user if a page has certain flags are not. Keeping length in bytes doesn't
makes sense.

> 

-- 
BR,
Muhammad Usama Anjum
