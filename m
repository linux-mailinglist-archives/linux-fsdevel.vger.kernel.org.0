Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AA469F28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Feb 2023 11:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBVKLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Feb 2023 05:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjBVKLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:11:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB38311C1;
        Wed, 22 Feb 2023 02:11:38 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A5DDC660215E;
        Wed, 22 Feb 2023 10:11:13 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677060696;
        bh=NXcADlIg87ZcIH/rmsyo4aL3MQ7pMgv/uza3wicJzPE=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=THO6C2nljd7jwF7SJMnlnE7I332qeIT0Y2k8E29LrPGIExRXzjvMgw2wW1j8gtrfj
         7HIfAe/s+pErJgN8cPqOVUFTraUY0QBLiW7zuNwVh2QSz2yv7BI1HRD+MVET5GEVvO
         Pba592XrXyPsLQHCWUkk9rL1Yxodfefnz9GqUDJdle0ki/yLi2TxYibwN5M3e1gdtZ
         k0vOAPGfooR81D9X2QnPI1IMAAYSMNkDI9vH0iyVrxnIiuqQZj5sUtAjLUbMB2IgPK
         szoZfOQEwiY4wu8Loq7NoTH+jIoW8Rq4kmmH+GrhvSjYbbDo7d2Gb3r7OX+BlQxBWv
         NxJtjfUNiZ0Ow==
Message-ID: <6d2b40c6-bed9-69a6-e198-537b50953acd@collabora.com>
Date:   Wed, 22 Feb 2023 15:11:06 +0500
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
 <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
 <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFGWi0dtgXZ-AeUuHb55EgnwTu3JfJ9cW3ftCqezKi8dAQ@mail.gmail.com>
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

On 2/21/23 5:42 PM, Michał Mirosław wrote:
> On Tue, 21 Feb 2023 at 11:28, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> Hi Michał,
>>
>> Thank you so much for comment!
>>
>> On 2/17/23 8:18 PM, Michał Mirosław wrote:
> [...]
>>> For the page-selection mechanism, currently required_mask and
>>> excluded_mask have conflicting
>> They are opposite of each other:
>> All the set bits in required_mask must be set for the page to be selected.
>> All the set bits in excluded_mask must _not_ be set for the page to be
>> selected.
>>
>>> responsibilities. I suggest to rework that to:
>>> 1. negated_flags: page flags which are to be negated before applying
>>> the page selection using following masks;
>> Sorry I'm unable to understand the negation (which is XOR?). Lets look at
>> the truth table:
>> Page Flag       negated_flags
>> 0               0                       0
>> 0               1                       1
>> 1               0                       1
>> 1               1                       0
>>
>> If a page flag is 0 and negated_flag is 1, the result would be 1 which has
>> changed the page flag. It isn't making sense to me. Why the page flag bit
>> is being fliped?
>>
>> When Anrdei had proposed these masks, they seemed like a fancy way of
>> filtering inside kernel and it was straight forward to understand. These
>> masks would help his use cases for CRIU. So I'd included it. Please can you
>> elaborate what is the purpose of negation?
> 
> The XOR is a way to invert the tested value of a flag (from positive
> to negative and the other way) without having the API with invalid
> values (with required_flags and excluded_flags you need to define a
> rule about what happens if a flag is present in both of the masks -
> either prioritise one mask over the other or reject the call).
At minimum, one mask (required, any or excluded) must be specified. For a
page to get selected, the page flags must fulfill the criterion of all the
specified masks.

If a flag is present in both required_mask and excluded_mask, the
required_mask would select a page. But exculded_mask would drop the page.
So page page would be dropped. It is responsibility of the user to
correctly specify the flags.

matched = true;
if (p->required_mask)
	matched = ((p->required_mask & bitmap) == p->required_mask);
if (matched && p->anyof_mask)
	matched = (p->anyof_mask & bitmap);
if (matched && p->excluded_mask)
	matched = !(p->excluded_mask & bitmap);

if (matched && bitmap) {
	// page selected
}

Do you accept/like this behavior of masks after explaintation?

> (Note: the XOR is applied only to the value of the flags for the
> purpose of testing page-selection criteria.)
> 
> So:
> 1. if a flag is not set in negated_flags, but set in required_flags,
> then it means "this flag must be one" - equivalent to it being set in
> required_flag (in your current version of the API).
> 2. if a flag is set in negated_flags and also in required_flags, then
> it means "this flag must be zero" - equivalent to it being set in
> excluded_flags.
Lets translate words into table:
pageflags	required_flags	negated_flags	matched
1		1		0		yes
0		1		1		yes

> 
> The same thing goes for anyof_flags: if a flag is set in anyof_flags,
> then for it to be considered matched:
> 1. it must have a value of 1 if it is not set in negated_flags
> 2. it must have a value of 0 if it is set in negated_flags

pageflags	anyof_flags	negated_flags	matched
1		1		0		yes
0		1		1		yes

> 
> BTW, I think I assumed that both conditions (all flags in
> required_flags and at least one in anyof_flags is present) need to be
> true for the page to be selected - is this your intention? 
All the masks are optional. If all or any of the 3 masks are specified, the
page flags must pass these masks to get selected.

> The example
> code has a bug though, in that if anyof_flags is zero it will never
> match. Let me fix the selection part:
> 
> // calc. a mask of flags that have expected ("active") values
> tested_flags = page_flags ^ negated_flags;
> // are all required flags in "active" state? [== all zero when negated]
> if (~tested_flags & required_mask)
>   skip page;
> // is any extra flag "active"?
> if (anyof_flags && !(tested_flags & anyof_flags))
>   skip page;
> 
After taking a while to understand this and compare with already present
flag system, `negated flags` is comparatively difficult to understand while
already present flags seem easier.

> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
