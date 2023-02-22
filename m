Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EBA69F328
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 12:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjBVLHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 06:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjBVLHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:07:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B58238E8C;
        Wed, 22 Feb 2023 03:06:58 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A26CA66021B8;
        Wed, 22 Feb 2023 11:06:31 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677064016;
        bh=QKwfpx7EO+MS89l0UxB2amnGrD9VJwiJcP8lwDdKibk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=bRbbuUWQNiaNT2Iio02cIY6oaCZbyT3Xql2roHy2yFgEgvSuPJb49iwJXdVPFXdUu
         bvDTL+1/0nf8MXyjiKMOu3RMGkl+92ZR/O22bDXD81B6NHXVC528E492jaOLZOpy4s
         nrlI/OCKLdLEIxZ0tha2jHO+2LVa6uDPGAz/2y5vXyrdflfMLdL5ts9HmafR/2l8R1
         KYX4xdwm/pYncLYPgA5SiDh8XvtQzSr1lM3YifBzYvEJAhQlk++SiQ8SEmThWC+yxn
         Glmyt8RyMRwMyHyYDxZvndQ2nrLvBd2V2bihYgO/eE6Y4l8h83GSvnnx/q/t/Fo+2R
         FF7uNovgEvfEQ==
Message-ID: <a212c91e-b22a-c080-40ac-d2e909bb51c2@collabora.com>
Date:   Wed, 22 Feb 2023 16:06:25 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Andrei Vagin <avagin@gmail.com>,
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
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com,
        Danylo Mocherniuk <mdanylo@google.com>
Subject: Re: [PATCH v10 3/6] fs/proc/task_mmu: Implement IOCTL to get and/or
 the clear info about PTEs
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
 <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
 <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com>
 <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFF+AEKijaXMjDpQLKyAdueJ93kf9QLfOouKHaPPwvfw_w@mail.gmail.com>
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

On 2/22/23 3:44 PM, Michał Mirosław wrote:
> On Wed, 22 Feb 2023 at 11:11, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 2/21/23 5:42 PM, Michał Mirosław wrote:
>>> On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>>
>>>> Hi Michał,
>>>>
>>>> Thank you so much for comment!
>>>>
>>>> On 2/17/23 8:18 PM, Michał Mirosław wrote:
>>> [...]
>>>>> For the page-selection mechanism, currently required_mask and
>>>>> excluded_mask have conflicting
>>>> They are opposite of each other:
>>>> All the set bits in required_mask must be set for the page to be selected.
>>>> All the set bits in excluded_mask must _not_ be set for the page to be
>>>> selected.
>>>>
>>>>> responsibilities. I suggest to rework that to:
>>>>> 1. negated_flags: page flags which are to be negated before applying
>>>>> the page selection using following masks;
>>>> Sorry I'm unable to understand the negation (which is XOR?). Lets look at
>>>> the truth table:
>>>> Page Flag       negated_flags
>>>> 0               0                       0
>>>> 0               1                       1
>>>> 1               0                       1
>>>> 1               1                       0
>>>>
>>>> If a page flag is 0 and negated_flag is 1, the result would be 1 which has
>>>> changed the page flag. It isn't making sense to me. Why the page flag bit
>>>> is being fliped?
>>>>
>>>> When Anrdei had proposed these masks, they seemed like a fancy way of
>>>> filtering inside kernel and it was straight forward to understand. These
>>>> masks would help his use cases for CRIU. So I'd included it. Please can you
>>>> elaborate what is the purpose of negation?
>>>
>>> The XOR is a way to invert the tested value of a flag (from positive
>>> to negative and the other way) without having the API with invalid
>>> values (with required_flags and excluded_flags you need to define a
>>> rule about what happens if a flag is present in both of the masks -
>>> either prioritise one mask over the other or reject the call).
>> At minimum, one mask (required, any or excluded) must be specified. For a
>> page to get selected, the page flags must fulfill the criterion of all the
>> specified masks.
> 
> [Please see the comment below.]
> 
> [...]
>> Lets translate words into table:
> [Yes, those tables captured the intent correctly.]
> 
>>> BTW, I think I assumed that both conditions (all flags in
>>> required_flags and at least one in anyof_flags is present) need to be
>>> true for the page to be selected - is this your intention?
>> All the masks are optional. If all or any of the 3 masks are specified, the
>> page flags must pass these masks to get selected.
> 
> This explanation contradicts in part the introductory paragraph, but
> this version seems more useful as you can pass all masks zero to have
> all pages selected.
Sorry, I wrote it wrongly. (All the masks are not optional.) Let me
rephrase. All or at least any 1 of the 3 masks (required, any, exclude)
must be specified. The return_mask must always be specified. Error is
returned if all 3 masks (required, anyof, exclude) are zero or return_mask
is zero.

> 
>>> The example
>>> code has a bug though, in that if anyof_flags is zero it will never
>>> match. Let me fix the selection part:
>>>
>>> // calc. a mask of flags that have expected ("active") values
>>> tested_flags = page_flags ^ negated_flags;
>>> // are all required flags in "active" state? [== all zero when negated]
>>> if (~tested_flags & required_mask)
>>>   skip page;
>>> // is any extra flag "active"?
>>> if (anyof_flags && !(tested_flags & anyof_flags))
>>>   skip page;
>>>
>> After taking a while to understand this and compare with already present
>> flag system, `negated flags` is comparatively difficult to understand while
>> already present flags seem easier.
> 
> Maybe replacing negated_flags in the API with matched_values =
> ~negated_flags would make this better?
> 
> We compare having to understand XOR vs having to understand ordering
> of required_flags and excluded_flags.
There is no ordering in current masks scheme. No mask is preferable. For a
page to get selected, all the definitions of the masks must be fulfilled.
You have come up with good example that what if required_mask =
exclude_mask. In this case, no page will fulfill the criterion and hence no
page would be selected. It is user's fault that he isn't understanding the
definitions of these masks correctly.

Now thinking about it, I can add a error check which would return error if
a bit in required and excluded masks matches. Would you like it? Lets put
this check in place.
(Previously I'd left it for user's wisdom not to do this. If he'll specify
same masks in them, he'll get no addresses out of the syscall.)

> IOW my proposal is to replace branches in the masks interpretation (if
> in one set then matches but if in another set then doesn't; if flags
> match ... ) with plain calculation (flag is matching when equals
> ~negated_flags; if flags match the masks ...).
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
