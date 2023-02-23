Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB26A04B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 10:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjBWJXz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 04:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjBWJXy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:23:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E4B4BE8E;
        Thu, 23 Feb 2023 01:23:52 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1235766021F3;
        Thu, 23 Feb 2023 09:23:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677144231;
        bh=K7SA27+Ff2KyyarUCbIlmovzuWLPMLER+gG6ygY9D+o=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=aavO812FnW4vHyEI8XVOZCZ7gJozrDNxdWzeMUbTN+zGMHliYYB1uwMwscVNOHgWa
         MlyUR5tHS//kKhlCRa27J9T9hh7WS1/8AvMUwTH4RGzjkVb0zzjWaKCwx6oMLKz01j
         a2A+Ah9+ejBjlQmxegSyOqSGbPmo9571NBmPB7eNe7MKP7vX/o+gOSADPdhu6FjrFU
         wusYyLVOqdwuA+HsG4Jny7xwjQ1GLuZHVxUSzsUkaddCvgZvKKrsa6CVSXp5XOW9mN
         tj+6HRC9rVj8BVz38cTr09MaTYQ3FfvyU6+wzyCA/4gji77KfGHVT41SGRdcW6sDK/
         omgelyYFiDUeQ==
Message-ID: <324564ba-2cdc-258e-1f57-d0a1d27e9da5@collabora.com>
Date:   Thu, 23 Feb 2023 14:23:41 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
 <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com>
 <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
 <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com>
 <CABb0KFEBpJTNF7V0XfuvbtaHUiN0Zpx6FqD+BRyXf2gjxiVgTA@mail.gmail.com>
 <473b32fd-24f9-88fd-602f-3ba11d725472@collabora.com>
 <CABb0KFFSUeu76O9K_Q7PTQVEXJaauyOc0yF-T1uubWsYAq8cOg@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFSUeu76O9K_Q7PTQVEXJaauyOc0yF-T1uubWsYAq8cOg@mail.gmail.com>
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

On 2/23/23 1:41 PM, Michał Mirosław wrote:
> On Thu, 23 Feb 2023 at 07:44, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 2/22/23 4:48 PM, Michał Mirosław wrote:
>>> On Wed, 22 Feb 2023 at 12:06, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>>>>> BTW, I think I assumed that both conditions (all flags in
>>>>>>> required_flags and at least one in anyof_flags is present) need to be
>>>>>>> true for the page to be selected - is this your intention?
>>>>>> All the masks are optional. If all or any of the 3 masks are specified, the
>>>>>> page flags must pass these masks to get selected.
>>>>>
>>>>> This explanation contradicts in part the introductory paragraph, but
>>>>> this version seems more useful as you can pass all masks zero to have
>>>>> all pages selected.
>>>> Sorry, I wrote it wrongly. (All the masks are not optional.) Let me
>>>> rephrase. All or at least any 1 of the 3 masks (required, any, exclude)
>>>> must be specified. The return_mask must always be specified. Error is
>>>> returned if all 3 masks (required, anyof, exclude) are zero or return_mask
>>>> is zero.
>>>
>>> Why do you need those restrictions? I'd guess it is valid to request a
>>> list of all pages with zero return_mask - this will return a compact
>>> list of used ranges of the virtual address space.
>> At the time, we are supporting 4 flags (PAGE_IS_WRITTEN, PAGE_IS_FILE,
>> PAGE_IS_PRESENT and PAGE_IS_SWAPPED). The idea is that user mention his
>> flags of interest in the return_mask. If he wants only 1 flag, he'll
>> specify it. Definitely if user wants only 1 flag, initially it doesn't make
>> any sense to mention in the return mask. But we want uniformity. If user
>> want, 2 or more flags in returned, return_mask becomes compulsory. So to
>> keep things simple and generic for any number of flags of interest
>> returned, the return_mask must be specified even if the flag of interest is
>> only 1.
> 
> I'm not sure why do we want uniformity in the case of 1 flag? If a
> user specifies a single required flag, I'd expect he doesn't need to
> look at the flags returned as those will duplicate the information
> from mere presence of a page. A user might also require a single flag,
> but want all of them returned. Both requests - return 1 flag and
> return 0 flags would give meaningful output, so why force one way or
> the other? Allowing two will also enable users to express the intent:
> they need either just a list of pages, or they need a list with
> per-page flags - the need would follow from the code structure or
> other factors.
We can add as much flexibility as much people ask by keeping code simple.
But it is going to be dirty to add error check which detects if return_mask
= 0 and if there is only 1 flag of interest mentioned by the user. The
following mentioned error check is essential to return deterministic
output. Do you think this case is worth it to support and we don't want to
go with the generality for both 1 or more flag cases?

if (return_mask == 0 && hweight_long(required_mask | any_mask) != 1)
	return error;

> 
>>>>>> After taking a while to understand this and compare with already present
>>>>>> flag system, `negated flags` is comparatively difficult to understand while
>>>>>> already present flags seem easier.
>>>>>
>>>>> Maybe replacing negated_flags in the API with matched_values =
>>>>> ~negated_flags would make this better?
>>>>>
>>>>> We compare having to understand XOR vs having to understand ordering
>>>>> of required_flags and excluded_flags.
>>>> There is no ordering in current masks scheme. No mask is preferable. For a
>>>> page to get selected, all the definitions of the masks must be fulfilled.
>>>> You have come up with good example that what if required_mask =
>>>> exclude_mask. In this case, no page will fulfill the criterion and hence no
>>>> page would be selected. It is user's fault that he isn't understanding the
>>>> definitions of these masks correctly.
>>>>
>>>> Now thinking about it, I can add a error check which would return error if
>>>> a bit in required and excluded masks matches. Would you like it? Lets put
>>>> this check in place.
>>>> (Previously I'd left it for user's wisdom not to do this. If he'll specify
>>>> same masks in them, he'll get no addresses out of the syscall.)
>>>
>>> This error case is (one of) the problems I propose avoiding. You also
>>> need much more text to describe the requred/excluded flags
>>> interactions and edge cases than saying that a flag must have a value
>>> equal to corresponding bit in ~negated_flags to be matched by
>>> requried/anyof masks.
>> I've found excluded_mask very intuitive as compared to negated_mask which
>> is so difficult to understand that I don't know how to use it correctly.
>> Lets take an example, I want pages which are PAGE_IS_WRITTEN and are not
>> PAGE_IS_FILE. In addition, the pages must be PAGE_IS_PRESENT or
>> PAGE_IS_SWAPPED. This can be specified as:
>>
>> required_mask = PAGE_IS_WRITTEN
>> excluded_mask = PAGE_IS_FILE
>> anyof_mask = PAGE_IS_PRESETNT | PAGE_IS_SWAP
>>
>> (a) assume page_flags = 0b1111
>> skip page as 0b1111 & 0b0010 = true
>>
>> (b) assume page_flags = 0b1001
>> select page as 0b1001 & 0b0010 = false
>>
>> It seemed intuitive. Right? How would you achieve same thing with negated_mask?
>>
>> required_mask = PAGE_IS_WRITTEN
>> negated_mask = PAGE_IS_FILE
>> anyof_mask = PAGE_IS_PRESETNT | PAGE_IS_SWAP
>>
>> (1) assume page_flags = 0b1111
>> tested_flags = 0b1111 ^ 0b0010 = 0b1101
>>
>> (2) assume page_flags = 0b1001
>> tested_flags = 0b1001 ^ 0b0010 = 0b1011
>>
>> In (1), we wanted to skip pages which have PAGE_IS_FILE set. But
>> negated_mask has just masked it and page is still getting tested if it
>> should be selected and it would get selected. It is wrong.
>>
>> In (2), the PAGE_IS_FILE bit of page_flags was 0 and got updated to 1 or
>> PAGE_IS_FILE in tested_flags.
> 
> I require flags PAGE_IS_WRITTEN=1, PAGE_IS_FILE=0, so:
> 
> required_mask = PAGE_IS_WRITTEN | PAGE_IS_FILE;
> negated_flags = PAGE_IS_FILE; // flags I want zero
You want PAGE_IS_FILE to be zero and at the same time you are requiring the
PAGE_IS_FILE. It is confusing. Lets go with excluded mask and excluded_mask
must never have any bit matching with required_mask. Lets stay with this as
it is intuitive and would be easy to use from the user's perspective.
Andrei and Danylo had suggested these mask scheme and have use cases for
this. Andrei and Danylo can please comment as well.

> 
> I also require one of PAGE_IS_PRESENT=1 or PAGE_IS_SWAP=1, so:
> 
> anyof_mask = PAGE_IS_PRESENT | PAGE_IS_SWAP;
> 
> Another case: I want to analyse a process' working set:
> 
> required_mask = 0;
> negated_flags = PAGE_IS_FILE;
> anyof_mask = PAGE_IS_FILE | PAGE_IS_WRITTEN;
> 
> -> gathering pages modified [WRITTEN=1] or not backed by a file [FILE=0].
> 
> To clarify a bit: negated_flags doesn't mask anything: the field
> inverts values of the flags (marks some "active low", if you consider
> electronic signal analogy).
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
