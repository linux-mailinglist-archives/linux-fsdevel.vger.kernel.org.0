Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBE16DA457
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 23:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDFVEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Apr 2023 17:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDFVEI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Apr 2023 17:04:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0675FE1;
        Thu,  6 Apr 2023 14:04:05 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9C02B66031CB;
        Thu,  6 Apr 2023 22:03:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680815044;
        bh=wB6zD51lex7I7n9LEZMIeAEbkO6YUuKChM00tqiWyD0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=aOUblwfSB5LQghHObMRJ3lYoqiolYUjWxeWI89Cbq4zsdKgOZxD7o9AGS3dkKAThH
         FRvGtate+50/NsHnedFqHFFi4HvTxdOvvKCZmnUuuyOBOAUZG0yfY4Vw+6SXiOnCNf
         lojdcWTKJc5eNGjHQZE8ufGG0WtmDx439J+aliaenPhCeTlajns0vgRZA/55suta0X
         A7PraK5ZDlnj1py3MbY/2ibmtolkQafCTswKNTrIFG4AeYDUJ7XLQVRHZLZtQoFaNT
         sYDnWusIgiho7tMR/7HnlPB+GChDnas5iZo+WHdEv5hVDgiVINYpAk9/4me44GbH9q
         9A+Mb1cC6E9mA==
Message-ID: <8a837998-604f-a871-729e-aa274a621481@collabora.com>
Date:   Fri, 7 Apr 2023 02:03:53 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Mike Rapoport <rppt@kernel.org>
References: <20230406074005.1784728-1-usama.anjum@collabora.com>
 <20230406074005.1784728-3-usama.anjum@collabora.com>
 <CABb0KFHZpYVML2e+Xg9+kwjyhqQkikPBhymO=EXoQnO2xjfG4g@mail.gmail.com>
 <0351b563-5193-6431-aa9c-c5bf5741b791@collabora.com>
 <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFE4ruptVXDpCk5MB6nkh9WeKTcKfROnx0ecoy-k1eCKCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/7/23 1:00 AM, Michał Mirosław wrote:
> On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> Hello,
>>
>> Thank you so much for the review. Do you have any thoughts on the build
>> error on arc architecture?
>> https://lore.kernel.org/all/e3c82373-256a-6297-bcb4-5e1179a2cbe2@collabora.com
> 
> Maybe copy HPAGE_* defines from x86 and key on CONFIG_PGTABLE_LEVELS >
> 2? I don't know much about arc arch, though.
> 
>> On 4/6/23 8:52 PM, Michał Mirosław wrote:
>>> On Thu, 6 Apr 2023 at 09:40, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:>
> [...]
>>>> +#define PM_SCAN_BITMAP(wt, file, present, swap)        \
>>>> +       (wt | file << 1 | present << 2 | swap << 3)
>>> Please parenthesize macro arguments ("(wt)", "(file)", etc.) to not
>>> have to worry about operator precedence when passed a complex
>>> expression.
>> Like this?
>> #define PM_SCAN_BITMAP(wt, file, present, swap) \
>>         ((wt) | (file << 1) | (present << 2) | (swap << 3))
> 
> The value would be:
>  ( (wt) | ((file) << 1) | ... )
> IOW, each parameter should have parentheses around its name.
Will do.

> 
> [...]
>>>> +               cur->len += n_pages;
>>>> +               p->found_pages += n_pages;
>>>> +
>>>> +               if (p->max_pages && (p->found_pages == p->max_pages))
>>>> +                       return PM_SCAN_FOUND_MAX_PAGES;
>>>> +
>>>> +               return 0;
>>>> +       }
>>>> +
>>>> +       if (!p->vec_index || ((p->vec_index + 1) < p->vec_len)) {
>>>
>>> It looks that `if (p->vec_index < p->vec_len)` is enough here - if we
>>> have vec_len == 0 here, then we'd not fit the entry in the userspace
>>> buffer anyway. Am I missing something?
>> No. I'd explained it with diagram last time:
>> https://lore.kernel.org/all/3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com
>>
>> I'll add a concise comment here.
> 
> So it seems, but I think the code changed a bit and maybe could be
> simplified now? Since p->vec_len == 0 is currently not valid, the
> field could count only the entries available in p->vec[] -- IOW: not
> include p->cur in the count.
I see. But this'll not work as we need to count p->cur to don't go above
the maximum count, p->vec_size.

> 
> BTW, `if (no space) return -ENOSPC` will avoid additional indentation
> for the non-merging case.
I'll update.

> 
> [...]
>>>> +static inline int pagemap_scan_deposit(struct pagemap_scan_private *p,
>>>> +                                      struct page_region __user *vec,
>>>> +                                      unsigned long *vec_index)
>>>
>>> ..._deposit() is used only in single place - please inline.
>> It is already inline.
> 
> Sorry. I mean: please paste the code in place of the single call.
I've made it a separate function to make the code look better in the caller
function and logically easier to understand. This function is ugly.
do_pagemap_scan() is also already very long function with lots of things
happening. If you still insist, I'll remove this function.

> 
> [...]
>>>> +               /*
>>>> +                * Break huge page into small pages if the WP operation need to
>>>> +                * be performed is on a portion of the huge page or if max_pages
>>>> +                * pages limit would exceed.
>>>
>>> BTW, could the `max_pages` limit be relaxed a bit (in that it would be
>>> possible to return more pages if they all merge into the last vector
>>> entry) so that it would not need to split otherwise-matching huge
>>> page? It would remove the need for this special handling in the kernel
>>> and splitting the page by this read-only-appearing ioctl?
>> No, this cannot be done. Otherwise we'll not be able to emulate Windows
>> syscall GetWriteWatch() which specifies the exact number of pages. Usually
>> in most of cases, either user will not use THP or not perform the operation
>> on partial huge page. So this part is only there to keep things correct for
>> those users who do use THP and partial pagemap_scan operations.
> 
> I see that `GetWriteWatch` returns a list of pages not ranges of
> pages. That makes sense (more or less). (BTW, It could be emulated in
> userspace by caching the last not-fully-consumed range.)
First of all, caching is avoided as then state maintained is needed. This
is probably not accepted in Wine upstream later. Secondly, even if we have
cache, Get + WP operation would not be accurate when we ask only N pages,
but it gets N + X pages where X pages will not be consumed by the
application at this time.

> 
>>>> +                */
>>>> +               if (is_written && PM_SCAN_OP_IS_WP(p) &&
>>>> +                   ((end - start < HPAGE_SIZE) ||
>>>> +                    (p->max_pages &&
>>>> +                     (p->max_pages - p->found_pages) < n_pages))) {
>>>> +
>>>> +                       split_huge_pmd(vma, pmd, start);
>>>> +                       goto process_smaller_pages;
>>>> +               }
>>>> +
>>>> +               if (p->max_pages &&
>>>> +                   p->found_pages + n_pages > p->max_pages)
>>>> +                       n_pages = p->max_pages - p->found_pages;
>>>> +
>>>> +               ret = pagemap_scan_output(is_written, is_file, is_present,
>>>> +                                         is_swap, p, start, n_pages);
>>>> +               if (ret < 0)
>>>> +                       return ret;
> 
> So let's simplify this:
> 
> if (p->max_pages && n_pages > max_pages - found_pages)
>   n_pages = max_pages - found_pages;
> 
> if (is_written && DO_WP && n_pages != HPAGE_SIZE / PAGE_SIZE) {
>   split_thp();
>   goto process_smaller_pages;
> }
Clever!! This looks very sleek.

> 
> BTW, THP handling could be extracted to a function that would return
> -EAGAIN if it has split the page or it wasn't a THP -- and that would
> mean `goto process_smaller_pages`.
Other functions in this file handle the THP in this same way. So it feels
like more intuitive that we follow to same pattern in this file.

> 
>>> Why not propagate the error from uffd_wp_range()?
>> uffd_wp_range() returns status in long variable. We cannot return long in
>> this function. So intead of type casting long to int and then return I've
>> used -EINVAL. Would following be more suitable?
>>
>> long ret2 = uffd_wp_range(vma, start, HPAGE_SIZE, true);
>> if (ret2 < 0)
>>         return (int)ret2;
> 
> I think it's ok, since negative values are expected to be error codes.
> And since you can't overflow int with HPAGE_SIZE pages, then I
> wouldn't use `ret2` but cast the return and add a comment why it's
> safe.
I'll update.

> 
> [...]
>>>> +       start = (unsigned long)untagged_addr(arg.start);
>>>> +       vec = (struct page_region *)(unsigned long)untagged_addr(arg.vec);
>>>
>>> Is the inner cast needed?
>> arg.vec remains 64-bit on 32-bit systems. So casting 64bit value directly
>> to struct page_region pointer errors out. So I've added specific casting to
>> unsigned long first before casting to pointers.
> 
> I see. So to convey the intention, the `arg.start` and `arg.vec`
> should be casted to unsigned long, not the `untagged_addr()` return
> values.
I'll update.

> 
>>>> +       ret = pagemap_scan_args_valid(&arg, start, vec);
>>>> +       if (ret)
>>>> +               return ret;
>>>> +
>>>> +       end = start + arg.len;
>>>> +       p.max_pages = arg.max_pages;
>>>> +       p.found_pages = 0;
>>>> +       p.flags = arg.flags;
>>>> +       p.required_mask = arg.required_mask;
>>>> +       p.anyof_mask = arg.anyof_mask;
>>>> +       p.excluded_mask = arg.excluded_mask;
>>>> +       p.return_mask = arg.return_mask;
>>>> +       p.cur.len = 0;
>>>> +       p.cur.start = 0;
>>>> +       p.vec = NULL;
>>>> +       p.vec_len = (PAGEMAP_WALK_SIZE >> PAGE_SHIFT);
>>>
>>> Nit: parentheses are not needed here, please remove.
>> Will do.
>>
>>>
>>>> +
>>>> +       /*
>>>> +        * Allocate smaller buffer to get output from inside the page walk
>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>>>> +        * we want to return output to user in compact form where no two
>>>> +        * consecutive regions should be continuous and have the same flags.
>>>> +        * So store the latest element in p.cur between different walks and
>>>> +        * store the p.cur at the end of the walk to the user buffer.
>>>> +        */
>>>> +       p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
>>>> +                             GFP_KERNEL);
>>>> +       if (!p.vec)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       walk_start = walk_end = start;
>>>> +       while (walk_end < end && !ret) {
>>>
>>> The loop will stop if a previous iteration returned ENOSPC (and the
>>> error will be lost) - is it intended?
>> It is intentional. -ENOSPC means that the user buffer is full even though
>> there was more memory to walk over. We don't treat this error. So when
>> buffer gets full, we stop walking over further as user buffer has gotten
>> full and return as success.
> 
> Thanks. What's the difference between -ENOSPC and
> PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
> flow).
-ENOSPC --> user buffer has been filled completely
PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer may
			    still have more space

> 
> [...]
>>>> --- a/include/linux/userfaultfd_k.h
>>>> +++ b/include/linux/userfaultfd_k.h
>>>> @@ -210,6 +210,14 @@ extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
>>>>
>>>>  #else /* CONFIG_USERFAULTFD */
>>>>
>>>> +static inline long uffd_wp_range(struct mm_struct *dst_mm,
>>>> +                                struct vm_area_struct *vma,
>>>> +                                unsigned long start, unsigned long len,
>>>> +                                bool enable_wp)
>>>> +{
>>>> +       return 0;
>>>> +}
> [...]
>>> Shouldn't this part be in the patch introducing uffd_wp_range()?
>> We have not added uffd_wp_range() in previous patches. We just need this
>> stub for this patch for the case when CONFIG_USERFAULTFD isn't enabled.
>>
>> I'd this as separate patch before this patch. Mike asked me to merge it
>> with this patch in order not to break bisectability.
>> [1] https://lore.kernel.org/all/ZBK+86eMMazwfhdx@kernel.org
> 
> I would understand the reply [1] to mean that the uffd_wp_range() stub
> should go in the same patch where uffd_wp_range() is implemented. But
> uffd_wp_range() is already in (since f369b07c86140) so I don't see how
> having the stub in a separate commit sequenced before this one could
> break bisect?
Sorry, I mis-interpreted it. I'll make it a separate patch.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
