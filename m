Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C291765272
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jul 2023 13:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjG0LcG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 07:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjG0LcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:32:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5D92D73;
        Thu, 27 Jul 2023 04:31:36 -0700 (PDT)
Received: from [192.168.100.7] (unknown [59.103.218.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95FF26607057;
        Thu, 27 Jul 2023 12:31:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1690457490;
        bh=QwGbrEQGGJI024TRKlZTazP2ydOrrqpiaW+jd0PA/0w=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=Kgu7lcFf3EpvlQmYW1IE3cyUf7qJnscHff1xjQoubuXKbU4ExNtRkW8Z8IHZDJqOs
         IXxru92rni9lSRWKvjObLgbWHUKMItwvi0xD5QSeHZPszFamTsoC4CNTYwU2mpx0B/
         v28NqlvfD9ExtM+xDMnT0dbhwn29t/VQiujMYC2MI6BM6rifPilvU0HAiW2YKQJBUE
         22SLiSUpW7dW0hwiw1a+niUbHy2W7Wlvx7k9HzaJY+q9S0ORwYH1U1AIxHV8KdCKiR
         BAxmXvTC/3WUHaYejcNER4w+b0xXgBo2BYfgOKoaqYubsKWC6kw4R49gcbkdHe7QYZ
         RI96tQJYcvr2w==
Message-ID: <df71c1ca-0f3f-fffb-a5d8-14ea99577387@collabora.com>
Date:   Thu, 27 Jul 2023 16:31:18 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [v3] fs/proc/task_mmu: Implement IOCTL for efficient page table
 scanning
Content-Language: en-US
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>
References: <20230713101415.108875-6-usama.anjum@collabora.com>
 <7eedf953-7cf6-c342-8fa8-b7626d69ab63@collabora.com>
 <ZLpqzcyo2ZMXwtm4@qmqm.qmqm.pl>
 <382f4435-2088-08ce-20e9-bc1a15050861@collabora.com>
 <ZLshsAj5PbsEAHhP@qmqm.qmqm.pl>
 <b1071d62-5c8e-1b03-d919-b3a9db520e51@collabora.com>
 <CABb0KFF6M2_94Ect72zMtaRLBpOoHjHYJA-Ube3oQAh4cXSg5w@mail.gmail.com>
 <44eddc7d-fd68-1595-7e4f-e196abe37311@collabora.com>
 <CABb0KFHJVeEkh4f6WWK6FThCbA+NE8iYUZE68nV1YAxaHwiwog@mail.gmail.com>
 <e1ead2e8-046a-31d9-8df9-27cdd7b7ff83@collabora.com>
 <1afedab8-5929-61e5-b0da-9c70dc01c254@collabora.com>
 <eac29a4d-aa3f-4df5-97e6-4aa3a358f2b1@collabora.com>
 <CABb0KFHuNpG+NJQ4sQdp1n_Kf4sO8aC5DBEppFc1zz=zAeDfQw@mail.gmail.com>
 <f949f74f-bb65-e3f2-e70d-7198446a9981@collabora.com>
 <CABb0KFGQ_HbD+MNwKCcE+6D50XhJxpx0M0dRiC-EVwEXPv+4XA@mail.gmail.com>
 <89c09085-19ab-462b-e3be-b4e492a85899@collabora.com>
 <CABb0KFFnWVy5k+8DhoS6jJzqeDDMkt3u=Rj6KS2HQSz1BY1+bw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFFnWVy5k+8DhoS6jJzqeDDMkt3u=Rj6KS2HQSz1BY1+bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/23 4:26 PM, Michał Mirosław wrote:
> On Thu, 27 Jul 2023 at 10:03, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>> On 7/27/23 2:10 AM, Michał Mirosław wrote:
>>> On Wed, 26 Jul 2023 at 10:34, Muhammad Usama Anjum
>>> <usama.anjum@collabora.com> wrote:
>>>> On 7/25/23 11:05 PM, Michał Mirosław wrote:
>>>>> On Tue, 25 Jul 2023 at 11:11, Muhammad Usama Anjum
>>>>> <usama.anjum@collabora.com> wrote:
> [...]
>>>>> 2. For the address tagging part I'd prefer someone who knows how this
>>>>> is used take a look. We're ignoring the tag (but clear it on return in
>>>>> ->start) - so it doesn't matter for the ioctl() itself.
>>>> I've added Kirill if he can give his thoughts about tagged memory.
>>>>
>>>> Right now we are removing the tags from all 3 pointers (start, end, vec)
>>>> before using the pointers on kernel side. But we are overwriting and
>>>> writing the walk ending address in start which user can read/use.
>>>>
>>>> I think we shouldn't over-write the start (and its tag) and instead return
>>>> the ending walk address in new variable, walk_end.
>>>
>>> The overwrite of `start` is making the ioctl restart (continuation)
>>> easier to handle. I prefer the current way, but it's not a strong
>>> opinion.
>> We shouldn't overwrite the start if we aren't gonna put the correct tag. So
>> I've resorted to adding another variable `walk_end` to return the walk
>> ending address.
> 
> Yes. We have two options:
> 
> 1. add new field and have the userspace check it and update start
> itself to continue the scan,
I've selected this option and sent v26 already:
https://lore.kernel.org/all/20230727093637.1262110-1-usama.anjum@collabora.com

>  or:
> 2. reconstruct the tag from either orignal `start` or `end` and have
> the userspace re-set `start` if it wants to restart the scan instead
> of continuing.
In some case, compiler can put integrity checking metadata in the pointer's
upper byte. So copying start or end's meta data would be wrong.

> 
> (the second one, using `end`'s tag, might be the easiest for
> userspace, as it can check `start` == `end` when deciding to continue
> or restart).
> 
> Best Regards
> Michał Mirosław

-- 
BR,
Muhammad Usama Anjum
