Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307D86DAC1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Apr 2023 13:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDGLLI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Apr 2023 07:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjDGLLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Apr 2023 07:11:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5547ECB;
        Fri,  7 Apr 2023 04:11:05 -0700 (PDT)
Received: from [192.168.10.39] (unknown [119.155.57.40])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F33E66031A4;
        Fri,  7 Apr 2023 12:10:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680865863;
        bh=B0IW8AxLLQ/M9fKJHJt4ViUXFpwbhTGWKP+3cfqzxFg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Xn0pM5CwwZf3DBlCqByzYb2srNvK6Qsouf17RM6648RFVLhn+gQGdMjOePDCDjphn
         JcSpxS7uKiK7UvQds03zKV0j9nPHJ/q2OwifkwvL0drbd7AWYKRVODQi5j6WxHH9NT
         qKANjVs8LTaIHfjbdqqzBN0NAw0yznOUMW7id71VTMOrNTAzYfjjt3w9UNIbi24ECl
         D1AVay9dwuc9ZO2xLnW8+1AnHVwIaP2ZVB4tJY2L28ImkpMh1/IL0cq1c/jtgCgREi
         ixdBN9y45uRzNgCEoD8KCBkoqLnb8CX++e4Mhi5im273IpjyPXNNQ7D4+HkW+/0BR4
         NUsIPoRTYp/bw==
Message-ID: <05e14540-7092-5dd2-d503-473b673af716@collabora.com>
Date:   Fri, 7 Apr 2023 16:10:51 +0500
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
 <c5b9201d-141c-10ae-0475-4b230d36508b@collabora.com>
 <CABb0KFH3mj5qt22qDLHRKjh-wB7Jrn6Pz8h-QARaf9oR65U0Qg@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFH3mj5qt22qDLHRKjh-wB7Jrn6Pz8h-QARaf9oR65U0Qg@mail.gmail.com>
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

On 4/7/23 3:14 PM, Michał Mirosław wrote:
> On Fri, 7 Apr 2023 at 12:04, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 4/7/23 12:34 PM, Michał Mirosław wrote:
>>> On Thu, 6 Apr 2023 at 23:04, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 4/7/23 1:00 AM, Michał Mirosław wrote:
>>>>> On Thu, 6 Apr 2023 at 19:58, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>>>>>> +       /*
>>>>>>>> +        * Allocate smaller buffer to get output from inside the page walk
>>>>>>>> +        * functions and walk page range in PAGEMAP_WALK_SIZE size chunks. As
>>>>>>>> +        * we want to return output to user in compact form where no two
>>>>>>>> +        * consecutive regions should be continuous and have the same flags.
>>>>>>>> +        * So store the latest element in p.cur between different walks and
>>>>>>>> +        * store the p.cur at the end of the walk to the user buffer.
>>>>>>>> +        */
>>>>>>>> +       p.vec = kmalloc_array(p.vec_len, sizeof(struct page_region),
>>>>>>>> +                             GFP_KERNEL);
>>>>>>>> +       if (!p.vec)
>>>>>>>> +               return -ENOMEM;
>>>>>>>> +
>>>>>>>> +       walk_start = walk_end = start;
>>>>>>>> +       while (walk_end < end && !ret) {
>>>>>>>
>>>>>>> The loop will stop if a previous iteration returned ENOSPC (and the
>>>>>>> error will be lost) - is it intended?
>>>>>> It is intentional. -ENOSPC means that the user buffer is full even though
>>>>>> there was more memory to walk over. We don't treat this error. So when
>>>>>> buffer gets full, we stop walking over further as user buffer has gotten
>>>>>> full and return as success.
>>>>>
>>>>> Thanks. What's the difference between -ENOSPC and
>>>>> PM_SCAN_FOUND_MAX_PAGES? They seem to result in the same effect (code
>>>>> flow).
>>>> -ENOSPC --> user buffer has been filled completely
>>>> PM_SCAN_FOUND_MAX_PAGES --> max_pages have been found, user buffer may
>>>>                             still have more space
>>>
>>> What is the difference in code behaviour when those two cases are
>>> compared? (I'd expect none.)
>> There is difference:
>> We add data to user buffer. If it succeeds with return code 0, we engage
>> the WP. If it succeeds with PM_SCAN_FOUND_MAX_PAGES, we still engage the
>> WP. But if we get -ENOSPC, we don't perform engage as the data wasn't added
>> to the user buffer.
> 
> Thanks! I see it now. I see a few more corner cases here:
> 1. If we did engage WP but fail to copy the vector we return -EFAULT
> but the WP is already engaged. I'm not sure this is something worth
> guarding against, but documenting that would be helpful I think.
Sure.

> 2. If uffd_wp_range() fails, but we have already processed pages
> earlier, we should treat the error like ENOSPC and back out the failed
> range (the earier changes would be lost otherwise).
Backing out is easier to do for hugepages. But for normal pages, we'll have
to write some code to find where the current data was added (in cur or in
vec) and back out from that. I'll have to write some more code to avoid the
side-effects as well.

But aren't we going over-engineering here? Error occurred and we are trying
to keep the previously generated correct data and returning successfully
still to the user? I don't think we should do this. An error is error. We
should return the error simply even if the memory flags would get lost. We
don't know what caused the error in uffd_wp_range(). Under normal
situation, we there shouldn't have had error.


> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
