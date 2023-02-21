Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A810569DDE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 11:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjBUK3E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 05:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjBUK3D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:29:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D28AD2D;
        Tue, 21 Feb 2023 02:29:01 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.217.110])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8FAB66021CA;
        Tue, 21 Feb 2023 10:28:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676975338;
        bh=fxVmTBekLEao3S5bXJ02H7r4cVQUYDNCck3NzQOmT6Y=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=ZWkarKD+DUtaUi/POrJUturQZo0lgaUlOmMYr4PykO1GcCPQAJp7VVfql9GSK3sEs
         1tw9rDjfq7uN8Dn4gacFid7lQzpRtR3MfQprnDJ1e0r3WT9LSdQ3fpHHUB72VS53zO
         UYu0c46+iuprdeZh5O4b1OHcN8NL+1nwKFwXFLoJfcOAduwM7NZrxAgPOXwI0DnIMI
         ZJX32mQekwmA1GV08U+D1V+C9H3vTsocHJesWWFhOoMXurRGZMVNB1bzITHONbU2VX
         oLYUn3Hpft+uiO5rfFb9riWjedupvOHr6IQy8gnNlIj0q8iyIBGQ6dgDAhRmZKOZjo
         QYTOpzL4QEnwA==
Message-ID: <36ddfd75-5c58-197b-16c9-9f819099ea6d@collabora.com>
Date:   Tue, 21 Feb 2023 15:28:46 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
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
        Nadav Amit <namit@vmware.com>,
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
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>
References: <20230202112915.867409-1-usama.anjum@collabora.com>
 <20230202112915.867409-4-usama.anjum@collabora.com>
 <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CABb0KFEgsk+YidSXBYQ9mM8nVV6PuEOQf=bbNn7hsoG1hUeLZg@mail.gmail.com>
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

Hi Michał,

Thank you so much for comment!

On 2/17/23 8:18 PM, Michał Mirosław wrote:
> On Thu, 2 Feb 2023 at 12:30, Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
> [...]
>> - The masks are specified in required_mask, anyof_mask, excluded_ mask
>>   and return_mask.
> [...]

The interface was suggested by Andrei back on the review of v3 [1]:
> I mean we should be able to specify for what pages we need to get info
> for. An ioctl argument can have these four fields:
> * required bits (rmask & mask == mask) - all bits from this mask have to
be set.
> * any of these bits (amask & mask != 0) - any of these bits is set.
> * exclude masks (emask & mask == 0) = none of these bits are set.
> * return mask - bits that have to be reported to user.

> 
> May I suggest a slightly modified interface for the flags?
I've added everyone who may be interested in making interface better.

> 
> As I understand, the return_mask is what is applied to page flags to
> aggregate the list.
> This is a separate thing, and I think it doesn't need changes except
> maybe an improvement
> in the documentation and visual distinction.
> 
> For the page-selection mechanism, currently required_mask and
> excluded_mask have conflicting
They are opposite of each other:
All the set bits in required_mask must be set for the page to be selected.
All the set bits in excluded_mask must _not_ be set for the page to be
selected.

> responsibilities. I suggest to rework that to:
> 1. negated_flags: page flags which are to be negated before applying
> the page selection using following masks;
Sorry I'm unable to understand the negation (which is XOR?). Lets look at
the truth table:
Page Flag	negated_flags		
0		0			0
0		1			1
1		0			1
1		1			0

If a page flag is 0 and negated_flag is 1, the result would be 1 which has
changed the page flag. It isn't making sense to me. Why the page flag bit
is being fliped?

When Anrdei had proposed these masks, they seemed like a fancy way of
filtering inside kernel and it was straight forward to understand. These
masks would help his use cases for CRIU. So I'd included it. Please can you
elaborate what is the purpose of negation?

> 2. required_flags: flags which all have to be set in the
> (negation-applied) page flags;
> 3. anyof_flags: flags of which at least one has to be set in the
> (negation-applied) page flags;
> 
> IOW, the resulting algorithm would be:
> 
> tested_flags = page_flags ^ negated_flags;
> if (~tested_flags & required_flags)
>   skip page;
> if (!(tested_flags & anyof_flags))
>   skip_page;
> 
> aggregate_on(page_flags & return_flags);
> 
> Best Regards
> Michał Mirosław

[1] https://lore.kernel.org/all/YyiDg79flhWoMDZB@gmail.com

-- 
BR,
Muhammad Usama Anjum
