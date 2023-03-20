Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE26C0A5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 07:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCTGJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 02:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCTGJh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:09:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE7AD29;
        Sun, 19 Mar 2023 23:09:29 -0700 (PDT)
Received: from [192.168.210.158] (unknown [118.107.141.245])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 04A8E6602E34;
        Mon, 20 Mar 2023 06:09:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679292568;
        bh=1zcmPZhKecmBcE5a7YFM9eq943nRARSRB6OckgtIk6o=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=IHpA0Z5IWLMLUt8jUMCQsE+iJCgx+zOpkDFIePN1rXiqmS5b+4eaveSzI8hd0yX7T
         MMz0saOe0bQPXcdUCkkhqDKQkwDu8YK3wCMkf9V9+1JxZWxItrTPVg4OGcRpTG4Sb8
         7uQqIewYTBNN/B8FDnsU16qaSKF9+2TrI9EdBS/VEuSlo4RUsguFRTPKaRk0OeL3cq
         sJHIUMVNMYwLcY2keTUt0MFApDcuwNZxQdKQZYcQksOFgLFlO0nXnvFcMpwJq0pAsh
         lVnkePkuSMQIeGrJZX1bbOTa+GEz3qOwnPCWQFgJ9HoOaPLMAmmO3pOdp6blOedCyQ
         gS/Z2bTUFLiAg==
Message-ID: <6a452f0b-968e-11fa-530c-64eed955eb1f@collabora.com>
Date:   Mon, 20 Mar 2023 11:08:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH v11 4/7] fs/proc/task_mmu: Implement IOCTL to get and
 optionally clear info about PTEs
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
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
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-5-usama.anjum@collabora.com>
 <CABb0KFGU-jn4pCgmTK2zw0J-1-AVert4JsWF2CxgZ7LxckmWCA@mail.gmail.com>
 <3c8d9ea0-1382-be0c-8dd2-d490eedd3b55@collabora.com>
 <CABb0KFGru9xFCxyVHBcE+dkXe58=5wiCbvZGSWhuTfr4gn=MRQ@mail.gmail.com>
 <44d3f94e-fb9f-49df-7460-75dcee61802f@collabora.com>
 <CABb0KFH+Ho+grc5DXT7iWjnQH7T_o4y3BQj8ri5-wxcOvu12Bg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABb0KFH+Ho+grc5DXT7iWjnQH7T_o4y3BQj8ri5-wxcOvu12Bg@mail.gmail.com>
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

On 3/17/23 7:15 PM, Michał Mirosław wrote:
> On Fri, 17 Mar 2023 at 13:44, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 3/17/23 2:28 AM, Michał Mirosław wrote:
>>> On Thu, 16 Mar 2023 at 18:53, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 3/13/23 9:02 PM, Michał Mirosław wrote:
>>>>> On Thu, 9 Mar 2023 at 14:58, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
>>> [...]
>>>>>> --- a/fs/proc/task_mmu.c
>>>>>> +++ b/fs/proc/task_mmu.c
>>> [...]
>>>>>> +static int pagemap_scan_output(bool wt, bool file, bool pres, bool swap,
>>> [...]
>>>>> The `cur->len` test seems redundant: is it possible to have
>>>>> `cur->start == addr` in that case (I guess it would have to get
>>>>> `n_pages == 0` in an earlier invocation)?
>>>> No, both wouldn't work. cur->len == 0 means that it has only garbage. It is
>>>> essential to check the validity from cur->len before performing other
>>>> checks. Also cur->start can never be equal to addr as we are walking over
>>>> page addressing in serial manner. We want to see here if the current
>>>> address matches the previous data by finding the ending address of last
>>>> stored data (cur->start + cur->len * PAGE_SIZE).
>>>
>>> If cur->len == 0, then it doesn't matter if it gets merged or not - it
>>> can be filtered out during the flush (see below).
>>> [...]
>>>>>> +               } else if ((!p->vec_index) ||
>>>>>> +                          ((p->vec_index + 1) < p->vec_len)) {
>>>>>
>>>>> Can you explain this test? Why not just `p->vec_index < p->vec_len`? Or better:
>>>>>
>>>>> if (vec_index >= p->vec_len)
>>>>>     return -ENOSPC;
>>>>
>>>> No, it'll not work. Lets leave it as it is. :)
>>>>
>>>> It has gotten somewhat complex, but I don't have any other way to make it
>>>> simpler which works. First note the following points:
>>>> 1) We walk over 512 page or 1 thp at a time to not over allocate memory in
>>>> kernel (p->vec).
>>>> 2) We also want to merge the consecutive pages with the same flags into one
>>>> struct page_region. p->vec of current walk may merge with next walk. So we
>>>> cannot write to user memory until we find the results of the next walk.
>>>>
>>>> So most recent data is put into p->cur. When non-intersecting or mergeable
>>>> data is found, we move p->cur to p->vec[p->index] inside the page walk.
>>>> After the page walk, p->vec[0 to p->index] is moved to arg->vec. After all
>>>> the walks are over. We move the p->cur to arg->vec. It completes the data
>>>> transfer to user buffer.
>>> [...]
>>>> I'm so sorry that it has gotten this much complex. It was way simpler when
>>>> we were walking over all the memory in one go. But then we needed an
>>>> unbounded memory from the kernel which we don't want.
>>> [...]
>>>
>>> I've gone through and hopefully understood the code. I'm not sure this
>>> needs to be so complicated: when traversing a single PMD you can
>>> always copy p->cur to p->vec[p->vec_index++] because you can have at
>>> most pages_per_PMD non-merges (in the worst case the last page always
>>> is left in p->cur and whole p->vec is used). After each PMD p->vec
>>> needs a flush if p->vec_index > 0, skipping the dummy entry at front
>>> (len == 0; if present). (This is mostly how it is implemented now, but
>>> I propose to remove the "overflow" check and do the starting guard
>>> removal only every PMD.)
>> Sorry, unable to understand where to remove the guard?
> 
> Instead of checking for it in pagemap_scan_output() for each page you
> can skip it in do_pagemap_cmd() when doing the flush.
No, this cannot be done because in do_pagemap_cmd() we don't know that we
have space for new pages in the output buffer or not because the next page
may be aggregated to already present data.

> 
>>> BTW#2, I think the ENOSPC return in pagemap_scan_output() should
>>> happen later - only if the pages would match and that caused the count
>>> to exceed the limit. For THP n_pages should be truncated to the limit
>>> (and ENOSPC returned right away) only after the pages were verified to
>>> match.
>> We have 2 counters here:
>> * the p->max_pages optionally can be set to find out only N pages of
>> interest. So p->found_pages is counting this. We need to return early if
>> the page limit is complete.
>> * the p->vec_index keeps track of output buffer array size
> 
> I think I get how the limits are supposed to work, but I also think
> the implementation is not optimal. An example (assuming max_pages = 1
> and vec_len = 1):
>  - a matching page has been found
>  - a second - non-matching - is tried but results in immediate -ENOSPC.
> -> In this case I'd expect the early return to happen just after the
> first page is found so that non
> A similar problem occurs for hugepage: when the limit is hit (we found
>> = max_pages, n_pages is possibly truncated), but the scan continues
> until next page / PMD.
I'll try to check if I can optimize it. It seems like I should be able to
update this pretty easily by returning a negative status/error which
signifies that we have found the max_pages. Now just abort in sane way.

> 
> [...]
>>>>>> +       if (!arg->required_mask && !arg->anyof_mask &&
>>>>>> +           !arg->excluded_mask)
>>>>>> +               return false;
>>>>>
>>>>> Is there an assumption in the code that those checks are needed? I'd
>>>>> expect that no selection criteria makes a valid page set?
>>>> In my view, selection criterion must be specified for the ioctl to work. If
>>>> there is no criterio, user should go and read pagemap file directly. So the
>>>> assumption is that at least one selection criterion must be specified.
>>>
>>> Yes. I'm not sure we need to prevent multiple ways of doing the same
>>> thing. But doesn't pagemap reading lack the range aggregation feature?
>> Yeah, correct. But note that we are supporting only selective 4 flags in
>> this ioctl, not all pagemap flags. So it is useful for only those users who
>> depend only on these 4 flags. Out pagemap_ioctl interface is not so much
>> generic that we can cater anyone. Its interface is specific and we are
>> adding only those cases which are of our interest. So if someone wants
>> range aggregation from pagemap_ioctl, he'll need to add that flag in the
>> IOCTL first. When IOCTL support is added, he can specify the selection
>> criterion etc.
> 
> The available flag set is not a problem. An example usecase: dumping
> the memory state for debugging: ioctl(return_mask=ALL) returns a
> conveniently compact vector of ranges of pages that are actually used
> by the process (not only having reserved the virtual space). This is
> actually something that helps dumping processes with using tools like
> AddressSanitizer that create huge sparse mappings.
I don't know, we are adding more and more use cases as people are noticing
it. I've not thought about this use case. So I need more understanding
about it:
How should I identify "which pages are used"? Does use mean present and
swapped both? We we want to find present or swapped pages in other words
!pte_none pages and return in compact form, it can already be done by
ioctl(anyod_mask=PRESET | SWAPPED, return_mask=ALL).

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
