Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83693419DEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbhI0SR7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:17:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235847AbhI0SR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632766580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jS5GOWeYO/PMnGFwElUXmol7i16a0IRUl5OnPrJSSw8=;
        b=Drufaud5rL3Zwihag5YgZoxHT7+EYRnG1JYSvMKx+RZPinMtfRTI9iUCHedv/VgFyG4Wq5
        0kE7ksMGNSCdHgYs1XnyC3mg+GLU3rrjU4SiriD/6WZuAjLhjUfXmTiY8R2yMQG7vAH6k7
        zLAwE2yDhL7aH6MSc/Q8qn/5pWyHFRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-dqhl7ga8Ns29zz0VWJ93eQ-1; Mon, 27 Sep 2021 14:16:18 -0400
X-MC-Unique: dqhl7ga8Ns29zz0VWJ93eQ-1
Received: by mail-wm1-f72.google.com with SMTP id 75-20020a1c004e000000b00307b9b32cc9so255142wma.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:16:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jS5GOWeYO/PMnGFwElUXmol7i16a0IRUl5OnPrJSSw8=;
        b=n4NJj9YyhywC6tjlT46Kk5CY0pdHGkC4hoAGSA0ZwxLvf37DW02q8pXOl0Q2ULSAOV
         4F0dC7w/yg9iLA3hycFX1ZtKUhWdmlfG0XCxzcjayvKpYBcjm0YNxsEDlwWJezeYSJwP
         slKmieCCuPWTxGTVaMU24cc5zFXUachOd3F15NdnXSvXH8FZbD5elSanpHHaHVpKu9OF
         gtdI/zfAsx2z6tHrnX1TkaRj+/RGEo+T0Fn19QQGFixWVF1vj9CM4pSN/nJtwm/77ya6
         EkU/wqbWvMwiUHNqV/Lm6KTuMq7a4KyxP+BvWQQ697LVaYb2venMvuCqKOPX62OWr4Ch
         gcuQ==
X-Gm-Message-State: AOAM531VmWrnVSW5aSeRfyCfGSzuHp8qkvS+M6dkmiC0X0Id8/w4NzHq
        UUc9SKbf5X2F2lhQT2fKidNaaa574i8vNRIjUAbiP9+lWDz6gFHFGB+3uymlF0VpLJM6H96Wa5S
        /E/+FRm+XPcBo4+Hr/EQl/rrpJg==
X-Received: by 2002:a05:6000:1103:: with SMTP id z3mr1529645wrw.312.1632766577623;
        Mon, 27 Sep 2021 11:16:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxde2berEnif/kOAuNLM3Hq9ossbeVALJbBhinBf8mTyIIPx9GSxH9wvRZbz1S2MpTYzK7rA==
X-Received: by 2002:a05:6000:1103:: with SMTP id z3mr1529627wrw.312.1632766577439;
        Mon, 27 Sep 2021 11:16:17 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c654d.dip0.t-ipconnect.de. [91.12.101.77])
        by smtp.gmail.com with ESMTPSA id n15sm17686984wrg.58.2021.09.27.11.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:16:16 -0700 (PDT)
Subject: Re: Struct page proposal
To:     Matthew Wilcox <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
References: <YUvWm6G16+ib+Wnb@moria.home.lan>
 <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIH5j5xkPafvNds@casper.infradead.org> <YVII7eM7P42riwoI@moria.home.lan>
 <YVIJg+kNqqbrBZFW@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <b57911a4-3963-aa65-1f8e-46578b3c0623@redhat.com>
Date:   Mon, 27 Sep 2021 20:16:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVIJg+kNqqbrBZFW@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.09.21 20:12, Matthew Wilcox wrote:
> On Mon, Sep 27, 2021 at 02:09:49PM -0400, Kent Overstreet wrote:
>> On Mon, Sep 27, 2021 at 07:05:26PM +0100, Matthew Wilcox wrote:
>>> On Mon, Sep 27, 2021 at 07:48:15PM +0200, Vlastimil Babka wrote:
>>>> On 9/23/21 03:21, Kent Overstreet wrote:
>>>>> So if we have this:
>>>>>
>>>>> struct page {
>>>>> 	unsigned long	allocator;
>>>>> 	unsigned long	allocatee;
>>>>> };
>>>>>
>>>>> The allocator field would be used for either a pointer to slab/slub's state, if
>>>>> it's a slab page, or if it's a buddy allocator page it'd encode the order of the
>>>>> allocation - like compound order today, and probably whether or not the
>>>>> (compound group of) pages is free.
>>>>
>>>> The "free page in buddy allocator" case will be interesting to implement.
>>>> What the buddy allocator uses today is:
>>>>
>>>> - PageBuddy - determine if page is free; a page_type (part of mapcount
>>>> field) today, could be a bit in "allocator" field that would have to be 0 in
>>>> all other "page is allocated" contexts.
>>>> - nid/zid - to prevent merging accross node/zone boundaries, now part of
>>>> page flags
>>>> - buddy order
>>>> - a list_head (reusing the "lru") to hold the struct page on the appropriate
>>>> free list, which has to be double-linked so page can be taken from the
>>>> middle of the list instantly
>>>>
>>>> Won't be easy to cram all that into two unsigned long's, or even a single
>>>> one. We should avoid storing anything in the free page itself. Allocating
>>>> some external structures to track free pages is going to have funny
>>>> bootstrap problems. Probably a major redesign would be needed...
>>>
>>> Wait, why do we want to avoid using the memory that we're allocating?
>>
>> The issue is where to stick the state for free pages. If that doesn't fit in two
>> ulongs, then we'd need a separate allocation, which means slab needs to be up
>> and running before free pages are initialized.
> 
> But the thing we're allocating is at least PAGE_SIZE bytes in size.
> Why is "We should avoid storing anything in the free page itself" true?
> 

Immediately comes to mind:
* Free page reporting via virtio-balloon
* CMA on s390x (see arch_free_page())
* Free page poisoning
* init_on_free

-- 
Thanks,

David / dhildenb

