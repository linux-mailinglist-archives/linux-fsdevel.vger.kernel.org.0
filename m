Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22AD683127
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjAaPRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjAaPRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:17:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5788577C8
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:15:28 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id cl23-20020a17090af69700b0022c745bfdc3so8163487pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1w32OYqa8AZjxkoAPXiI7k6LH9j1UoDsQfFmvAUs9x4=;
        b=1cN/c75Xi0LLBEuX6EG+YXQvmNDy3Bm7HgOWIH8++aM7x03E6dTremoVkZyolsZNyO
         HGZIC1He/x3ETvMatn4ZtNrWNspuNWu7JiHzJiHRV7MkO0RFrUU02UwlT9YlJt/hH5Rn
         WGw2OJDVHINHX2zApofndPxfg8QRniiOqZollMeOGk0101t0vy/YTl6MChu9EJ5bBGxZ
         dSkbQIfUlwJOIcj6yfLmrgSDBofEN08deOk7FBUeGywcPZC7ksC6aO2rWwmlaQbToSpX
         LSzlcdCFUjEpBHG+3RvgPljYKUqyMA5HTMeyzdXSlRnrkEh66A8ZkzccUEpFLjbH4NAC
         +pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1w32OYqa8AZjxkoAPXiI7k6LH9j1UoDsQfFmvAUs9x4=;
        b=0mKK6MsM6NX1rNheN6x9ZsrXhKLLqYtzTGHn4na93L1xD0g40ax0fJc6JxGxSnb54e
         sJsRfHp6o01nwYvb45NN1/J9RHv2+WPioJRh289wV5q0x/KVphzo+wnuaB4CHeq98q71
         Nv/p23hLtbSuVb7j7hMG1XK3uXFCr33OQAFGNJ/WnG2lSMYbPG/jAaIrlFQFlodorN+n
         hEEYVsx9vkOENnnNTFbuY5DqlJeS15kaWG8wxyjO/R1eYoQlNy4mtnXZSg4dbjgMc6go
         p3EMScrosh4zKljbybMzuza/ZZSLNq3mbv+Nv1+CDLyMN9mT/9cU0FnXa8gFL6Fc1Uqa
         PDMA==
X-Gm-Message-State: AO0yUKW7iG2sXfYKePTrqAd+/+2x8GGIJcSFMY1ag73uI076CApfM5YP
        +I8l+RPwjFfl9S4B+K+A4oXs7Q==
X-Google-Smtp-Source: AK7set8YhzHwf4Ig2OUa7hLPVGrMJTenjYezS08HPIsGxOiSJhw6apseNc4nVjZEZIThFeq8j7lW+w==
X-Received: by 2002:a05:6a20:c1a7:b0:bc:6c4f:308a with SMTP id bg39-20020a056a20c1a700b000bc6c4f308amr7046633pzb.0.1675178126950;
        Tue, 31 Jan 2023 07:15:26 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t13-20020a6564cd000000b004db2b310f95sm8556368pgv.16.2023.01.31.07.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:15:26 -0800 (PST)
Message-ID: <34f0dd4c-9d6a-bc66-f37d-329fb1620212@kernel.dk>
Date:   Tue, 31 Jan 2023 08:15:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [GIT PULL] iov_iter: Improve page extraction (pin or just list)
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        David Howells <dhowells@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jeff Layton <jlayton@kernel.org>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <040ed7a7-3f4d-dab7-5a49-1cd9933c5445@redhat.com>
 <e68c5cab-c3a6-1872-98fa-9f909f23be79@nvidia.com>
 <3351099.1675077249@warthog.procyon.org.uk>
 <fd0003a0-a133-3daf-891c-ba7deafad768@kernel.dk>
 <f57ee72f-38e9-6afa-182f-2794638eadcb@kernel.dk>
 <e8480b18-08af-d101-a721-50d213893492@kernel.dk>
 <3520518.1675116740@warthog.procyon.org.uk>
 <f392399b-a4c4-2251-e12b-e89fff351c4d@kernel.dk>
 <3791872.1675172490@warthog.procyon.org.uk>
 <88d50843-9aa6-7930-433d-9b488857dc14@redhat.com>
 <f2fb6cc5-ff95-ca51-b377-5e4bd239d5e8@kernel.dk>
 <7f8f2d0f-4bf2-71aa-c356-c78c6b7fd071@redhat.com>
 <028c959d-e52a-5d08-6ac6-004ecdb3e549@kernel.dk>
 <0361aae6-59b2-1bbc-5530-a5be587b8a59@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0361aae6-59b2-1bbc-5530-a5be587b8a59@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/23 8:10 AM, David Hildenbrand wrote:
> On 31.01.23 16:04, Jens Axboe wrote:
>> On 1/31/23 8:02?AM, David Hildenbrand wrote:
>>> On 31.01.23 15:50, Jens Axboe wrote:
>>>> On 1/31/23 6:48?AM, David Hildenbrand wrote:
>>>>> On 31.01.23 14:41, David Howells wrote:
>>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>>>>> percpu counters maybe - add them up at the point of viewing?
>>>>>>>> They are percpu, see my last email. But for every 108 changes (on
>>>>>>>> my system), they will do two atomic_long_adds(). So not very
>>>>>>>> useful for anything but low frequency modifications.
>>>>>>>>
>>>>>>>
>>>>>>> Can we just treat the whole acquired/released accounting as a debug mechanism
>>>>>>> to detect missing releases and do it only for debug kernels?
>>>>>>>
>>>>>>>
>>>>>>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>>>>>>> really defer it any longer ... but I'm curious if it would be of any help to
>>>>>>> only have a single PINNED counter that goes into both directions (inc/dec on
>>>>>>> pin/release), to reduce the flushing.
>>>>>>>
>>>>>>> Of course, once we pin/release more than ~108 pages in one go or we switch
>>>>>>> CPUs frequently it won't be that much of a help ...
>>>>>>
>>>>>> What are the stats actually used for?  Is it just debugging, or do we actually
>>>>>> have users for them (control groups spring to mind)?
>>>>>
>>>>> As it's really just "how many pinning events" vs. "how many unpinning
>>>>> events", I assume it's only for debugging.
>>>>>
>>>>> For example, if you pin the same page twice it would not get accounted
>>>>> as "a single page is pinned".
>>>>
>>>> How about something like the below then? I can send it out as a real
>>>> patch, will run a sanity check on it first but would be surprised if
>>>> this doesn't fix it.
>>>>
>>>>
>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>> index f45a3a5be53a..41abb16286ec 100644
>>>> --- a/mm/gup.c
>>>> +++ b/mm/gup.c
>>>> @@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>>             */
>>>>            smp_mb__after_atomic();
>>>>    +#ifdef CONFIG_DEBUG_VM
>>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>>>> +#endif
>>>>              return folio;
>>>>        }
>>>> @@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>>>    static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>>>>    {
>>>>        if (flags & FOLL_PIN) {
>>>> +#ifdef CONFIG_DEBUG_VM
>>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>>>> +#endif
>>>>            if (folio_test_large(folio))
>>>>                atomic_sub(refs, folio_pincount_ptr(folio));
>>>>            else
>>>> @@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>>>>            } else {
>>>>                folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>>>>            }
>>>> -
>>>> +#ifdef CONFIG_DEBUG_VM
>>>>            node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>>>> +#endif
>>>>        }
>>>>          return 0;
>>>>
>>>
>>> We might want to hide the counters completely by defining them only
>>> with CONFIG_DEBUG_VM.
>>
>> Are all of them debug aids only? If so, yes we should just have
>> node_stat_* under CONFIG_DEBUG_VM.
>>
> 
> Rather only these 2. Smth like:

Ah gotcha, that makes more sense to me. Will update the patch and
send it out.

-- 
Jens Axboe


