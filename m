Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB6677C36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjAWNPY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 08:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAWNPX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:15:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFA413DFC;
        Mon, 23 Jan 2023 05:15:22 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.186.163])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CACAE66029A5;
        Mon, 23 Jan 2023 13:15:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674479720;
        bh=eZUiVTNJd98+gtT/nMH4QDYraaSsAMNKpFlsv+UCbg8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=j3gTk8oDtmYafOYZGKoyCrDpDCujE9melTSWyjfS9iFaunWaHVPhVh70RN3pSH/uq
         W9Pi/tpMVFBy2oNRDbebNXvPn1/2Voeqf+dIR6i5qiVqpuDz+xppbeK+OO8SZONXxI
         XowHQIQqYjM2tYb3UW34ZPC/zDudGOTS9mKQQ5o/HUxKXbGMeRkTtPZrOCr8NOPnaL
         2TSCQc3Jn21b0/n5FlbOd7SHwHPSUqvo4GBQHh/d4OEgoqXWYFtkKvGZNF1X3JZu16
         WoDRWlugm1tN/UsoYje24rujYkiLTYN1kW2/gEBdJQfKDgWZySqTGO3oB84r0tEbk0
         eGD9cQYgDYfkA==
Message-ID: <0eb79bb3-7384-11c6-a380-c027f09305f2@collabora.com>
Date:   Mon, 23 Jan 2023 18:15:00 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WC?= =?UTF-8?Q?aw?= 
        <emmir@google.com>, Paul Gofman <pgofman@codeweavers.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v7 0/4] Implement IOCTL to get and/or the clear info about
 PTEs
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>
References: <20230109064519.3555250-1-usama.anjum@collabora.com>
 <Y8hutCGec6je5toG@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y8hutCGec6je5toG@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/19/23 3:12 AM, Peter Xu wrote:
> On Mon, Jan 09, 2023 at 11:45:15AM +0500, Muhammad Usama Anjum wrote:
>> *Changes in v7:*
>> - Add uffd wp async
>> - Update the IOCTL to use uffd under the hood instead of soft-dirty
>>   flags
>>
>> Stop using the soft-dirty flags for finding which pages have been
>> written to. It is too delicate and wrong as it shows more soft-dirty
>> pages than the actual soft-dirty pages. There is no interest in
>> correcting it [A][B] as this is how the feature was written years ago.
>> It shouldn't be updated to changed behaviour. Peter Xu has suggested
>> using the async version of the UFFD WP [C] as it is based inherently
>> on the PTEs.
>>
>> So in this patch series, I've added a new mode to the UFFD which is
>> asynchronous version of the write protect. When this variant of the
>> UFFD WP is used, the page faults are resolved automatically by the
>> kernel. The pages which have been written-to can be found by reading
>> pagemap file (!PM_UFFD_WP). This feature can be used successfully to
>> find which pages have been written to from the time the pages were
>> write protected. This works just like the soft-dirty flag without
>> showing any extra pages which aren't soft-dirty in reality.
>>
>> [A] https://lore.kernel.org/all/20221220162606.1595355-1-usama.anjum@collabora.com
>> [B] https://lore.kernel.org/all/20221122115007.2787017-1-usama.anjum@collabora.com
>> [C] https://lore.kernel.org/all/Y6Hc2d+7eTKs7AiH@x1n
>>
>> *Changes in v6:*
>> - Updated the interface and made cosmetic changes
>>
>> *Cover Letter in v5:*
>> Hello,
> 
> Please consider either drop the cover letter below this point or rephrase,
> otherwise many of them are not true anymore and it can confuse the
> reviewers.
I'll remove.

> 
> I have a few high level comments/questions here, please bare with me if any
> of them are already discussed by others in the old versions; I'd be happy
> to read them when there's a pointer to the relevant answers.
> 
> Firstly, doc update is more than welcomed to explain the new interface
> first (before throwing the code..).  That can be done in pagemap.rst on
> pagemap changes, or userfaultfd.rst on userfaultfd.
Okay. I'll add the documentation in next version or after the series has
been accepted. Initially I'd added the documentation. But the code kept on
changing so much that I had to spend considerable time on updating the
documentation. I know it is better to add documentation with the patches.
I'll try to add it.

> 
> Besides, can you provide more justification on the new pagemap-side
> interface design?
> 
> It seems it came from the Windows API GetWriteWatch(), but it's definitely
> not exactly that.  Let me spell some points out..
Initially, we just wanted a way to emulate Windows API GetWriteWatch(). So
we had added `max_pages` in the IOCTL arguments which is optional and can
be used to specify how many pages we want to find of our interest. There
was only one set of flags to be matched with the pages.

> 
> There're four kinds of masks (required/anyof/excluded/return).  Are they
> all needed?  Why this is a good interface design?
Then, CRIU developers Andrea [1] and Danylo [2], asked to include all these
different kinds of masks. I'd thought of these masks as fancy filter inside
the kernel. But there wasn't anyone else to review. So I'd included them to
move forward. Please let me know your thoughts after reading emails from [1].

> 
> I saw you used page_region structure to keep the information.  I think you
> wanted to have a densed output, especially if counting in the "return mask"
> above it starts to make more sense. If with a very limited return mask it
> means many of the (continuous) page information can be merged into a single
> page_region struct when the kernel is scanning.
Correct.

> 
> However, at the meantime the other three masks (required/anyof/excluded)
> made me quite confused - it means you wanted to somehow filter the pages
> and only some of them will get collected.  The thing is for a continuous
> page range if any of the page got skipped due to the masks (e.g. not in
> "required" or in "excluded") it also means it can never be merged into
> previous page_region either.  That seems to be against the principle of
> having densed output.
The filtering is being done. But the output can still be condensed
regardless. There isn't that randomness in the page flags of the
consecutive pages.

> 
> I hope you can help clarify what's the major use case here.
> 
> There's also the new interface to do atomic "fetch + update" on wrprotected
> pages.  Is that just for efficiency or is the accuracy required in some of
> the applications?
"Atomic fetch and update/clear" or "Atomic fetch Written-to status and
clear it" is needed to support GetWriteWatch() and there is no already
present way to perform this operation atomically. We want efficiency and
accuracy both to get good performance/speed. So this IOCTL is needed to
achieve:
1) New functionality which isn't already present
2) Most efficient and accurate method to perform the operation (it isn't
possible through soft-dirty feature)

> 
> Thanks,
> 

[1] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com
[2] https://lore.kernel.org/all/20221014134802.1361436-1-mdanylo@google.com

-- 
BR,
Muhammad Usama Anjum
