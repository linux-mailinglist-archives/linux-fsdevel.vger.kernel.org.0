Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E266DAB34
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 12:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbjDGKEt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 06:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbjDGKEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 06:04:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B53D5FCF;
        Fri,  7 Apr 2023 03:04:45 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B91B6603131;
        Fri,  7 Apr 2023 11:04:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680861883;
        bh=wFFs5e3pfOXut0j6vcW6vIOzD590TwbnJcENFZLGENs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=YABez8d+ezmohaCrrAMeuJ5vhrOQlRBCRbpj0t/ZT9Nhx6Augb9Va7SJ+T2hHGLci
         Z5/RthfmMWVw8PQiUEtH6nHOsqCcWawoxuh/4rSCmj4DR2JSkb3yG+VgA35T1WuJXC
         IwZWmQY5AiHRIFRlx8am/puvZw/Pk0bVcsuoB867j97ObAXfE+pQ0fXD1nT4DIto5r
         o6QC2VKQSZd/9NkPLhvLp35+Cu5i2ZTGTAvcENt2jX2RSgIHXTjupDiQAEtq0b+6GE
         rrkII83vrqNlrkluNVttJxthsXgU5S2/dXAZGt0dzL6OnawCnp6M/P2HlUEo7WQYkY
         8okPpbvEYGu5Q==
Message-ID: <c5b9201d-141c-10ae-0475-4b230d36508b@collabora.com>
Date:   Fri, 7 Apr 2023 15:04:32 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
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
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v12 2/5] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com>
 <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com>
 <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
 <8a837998-604f-a871-729e-aa274a621481@collabora.com>
 <CABb0KFEBqAMWWpAeBfqzA4JrHo3yLyaT0rqKTUn28O0hE+szBA@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFEBqAMWWpAeBfqzA4JrHo3yLyaT0rqKTUn28O0hE+szBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/23 12:34 PM, Michał Mirosław wrote:
> On Thu, 6 Apr 2023 at 23:04, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 4/7/23 1:00 AM, Michał Mirosław wrote:
>>> On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>>>> +               cur->len += n_pages;
>>>>>> +               p->found_pages += n_pages;
>>>>>> +
>>>>>> +               if (p->max_pages && (p->found_pages == p->max_pages))
>>>>>> +                       return PM_SCAN_FOUND_MAX_PAGES;
>>>>>> +
>>>>>> +               return 0;
>>>>>> +       }
>>>>>> +
>>>>>> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {
>>>>>
>>>>> It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
>>>>> have vec_len == 0 here, then we'd not fit the entry in the userspace
>>>>> buffer anyway. Am I missing something?
>>>> No. I'd explained it with diagram last time:
>>>> https://lore.kernel.org/all/3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com
>>>>
>>>> I'll add a concise comment here.
>>>
>>> So it seems, but I think the code changed a bit and maybe could be
>>> simplified now? Since p->vec_len == 0 is currently not valid, the
>>> field could count only the entries available in p->vec[] -- IOW: not
>>> include p->cur in the count.
>> I see. But this'll not work as we need to count p->cur to don't go above
>> the maximum count, p->vec_size.
> 
> You can subtract 1 from p->vec_size before the page walk to account
> for the buffer in `cur`.
Yeah, it can be done. But I've thought about it. It would look more uglier.
I'll have to subtract 1 from vec_len in the start and then add 1 in the
end. The current algorithm seems simpler.

> 
> [...]
>>>>>> +static inline int pagemap_scan_deposit(struct pagemap_scan_private *p,
>>>>>> +                                      struct page_region __user *vec,
>>>>>> +                                      unsigned long *vec_index)
>>>>>
>>>>> ..._deposit() is used only in single place - please inline.
>>>> It is already inline.
>>>
>>> Sorry. I mean: please paste the code in place of the single call.
>> I've made it a separate function to make the code look better in the caller
>> function and logically easier to understand. This function is ugly.
>> do_pagemap_scan() is also already very long function with lots of things
>> happening. If you still insist, I'll remove this function.
> 
> Please do remove - it will make the copy to userspace code all neatly together.
Will remove it.

> 
> [...]
>>>>>> +                */
>>>>>> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
>>>>>> +                   ((end - start < HPAGE_SIZE) ||
>>>>>> +                    (p->max_pages &&
>>>>>> +                     (p->max_pages - p->found_pages) < n_pages))) {
>>>>>> +
>>>>>> +                       split_huge_pmd(vma, pmd, start);
>>>>>> +                       goto process_smaller_pages;
>>>>>> +               }
>>>>>> +
>>>>>> +               if (p->max_pages &&
>>>>>> +                   p->found_pages + n_pages > p->max_pages)
>>>>>> +                       n_pages = p->max_pages - p->found_pages;
>>>>>> +
>>>>>> +               ret = pagemap_scan_output(is_written, is_file, is_present,
>>>>>> +                                         is_swap, p, start, n_pages);
>>>>>> +               if (ret < 0)
>>>>>> +                       return ret;
>>>
>>> So let's simplify this:
>>>
>>> if (p->max_pages && n_pages > max_pages - found_pages)
>>>   n_pages = max_pages - found_pages;
>>>
>>> if (is_written && DO_WP && n_pages != HPAGE_SIZE / PAGE_SIZE) {
>>>   split_thp();
>>>   goto process_smaller_pages;
>>> }
>> Clever!! This looks very sleek.
>>
>>>
>>> BTW, THP handling could be extracted to a function that would return
>>> -EAGAIN if it has split the page or it wasn't a THP -- and that would
>>> mean `goto process_smaller_pages`.
>> Other functions in this file handle the THP in this same way. So it feels
>> like more intuitive that we follow to same pattern in this file.
> 
> I'll leave it to you. Extracting THP support would avoid a goto and
> #ifdef inside a function, though (and make the function smaller).
> 
>>>>>> +       /*
>>>>>> +        * Allocate smaller buffer to get output from inside the page walk
>>>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>>>>>> +        * we want to return output to user in compact form where no two
>>>>>> +        * consecutive regions should be continuous and have the same flags.
>>>>>> +        * So store the latest element in p.cur between different walks and
>>>>>> +        * store the p.cur at the end of the walk to the user buffer.
>>>>>> +        */
>>>>>> +       p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
>>>>>> +                             GFP_KERNEL);
>>>>>> +       if (!p.vec)
>>>>>> +               return -ENOMEM;
>>>>>> +
>>>>>> +       walk_start = walk_end = start;
>>>>>> +       while (walk_end < end && !ret) {
>>>>>
>>>>> The loop will stop if a previous iteration returned ENOSPC (and the
>>>>> error will be lost) - is it intended?
>>>> It is intentional. -ENOSPC means that the user buffer is full even though
>>>> there was more memory to walk over. We don't treat this error. So when
>>>> buffer gets full, we stop walking over further as user buffer has gotten
>>>> full and return as success.
>>>
>>> Thanks. What's the difference between -ENOSPC and
>>> PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
>>> flow).
>> -ENOSPC --> user buffer has been filled completely
>> PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer may
>>                             still have more space
> 
> What is the difference in code behaviour when those two cases are
> compared? (I'd expect none.)
There is difference:
We add data to user buffer. If it succeeds with return code 0, we engage
the WP. If it succeeds with PM_SCAN_FOUND_MAX_PAGES, we still engage the
WP. But if we get -ENOSPC, we don't perform engage as the data wasn't added
to the user buffer.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
