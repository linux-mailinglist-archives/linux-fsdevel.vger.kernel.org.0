Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55D683161
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 16:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjAaPWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 10:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjAaPWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:22:17 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F7A46B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:20:16 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id t24-20020a4a8258000000b005170b789faaso1141841oog.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uB3Z6qnpneL7fBnCtQQbgmmvnsrVox9LWLijWqPdBg=;
        b=eu0W+8Bqo5Bcoxbv6tDsvAwivF6vSrDXoaGc/lpNfwiItYZRFNSC+lo5UQR6BbtBLh
         siZtCrgKLJmaD0HGkrmedkm6U4HGIJdmlc+ySQdutigNcA9ihkjE+Hd0hPuuJE+776KX
         WgpbxpAgKCpPqT/4tlICCaiclR6v9xbm98pEgWUP2Vmokh0UK9dTNL+ej4xrX/0JPmS4
         enME4Y59XTqMGdVC22INOaZUHj6YoFE/xpDHNIvw2qxOPmmg78OxbcxJ8VulCpabagBd
         MEfYiw7tCt0JILIAKZc2qvUzUGWSblg1vjFtim6FnJKb6iObapLgUFqA7jGNEdwOswUB
         J9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uB3Z6qnpneL7fBnCtQQbgmmvnsrVox9LWLijWqPdBg=;
        b=ywc0qCC60KbKsUqhn3pyIVVQZ352oqXNbUOs2o2sZhGpSXWx1AFihwt4uS7/2fnU+Z
         +XyuMe1vFnuenuxfYAOiaKqOku1xg0yEVRwCYUh/dg5wCLaEvkQQ8F4A2gvv2zafMxKJ
         mWYFxBTttzWYgeucoYS6+u2xTH8e5wNMvkp0zwRU+NDGeP2SS2+F9X8Fl79bxfC1WYDG
         Y0VOfBgLMwd5NHUoefIQV+OfKnY56N1/TaBntZNZZ6n3UBy9RICLJIUFGSVLzs7wfJDp
         I2iwHcLSfh0UhO3FBcPE1j9iIRJwsnDyYxuWHDkhRNBUfkNTTGMZtzFMgc3VHJnY05Sg
         K4aQ==
X-Gm-Message-State: AO0yUKVPMhM90K5Wr5lWE++r3PrFneTkd6UG/oiy2kM0U7FHFrnSSqzH
        VYV70dbjQXYoBNMaWrOJ3lAcj35THivq/xSG
X-Google-Smtp-Source: AK7set/Ze64lq3+f11Klcyol4ZjsNqkXL5s6RRKkDwsNA2gzWH3GDKWTh18fHiCZTlJOXcECR4zIhA==
X-Received: by 2002:a17:902:db05:b0:198:a5d9:f2fd with SMTP id m5-20020a170902db0500b00198a5d9f2fdmr512965plx.6.1675177447799;
        Tue, 31 Jan 2023 07:04:07 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902758500b0019686d286e2sm3901802pll.13.2023.01.31.07.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:04:07 -0800 (PST)
Message-ID: <028c959d-e52a-5d08-6ac6-004ecdb3e549@kernel.dk>
Date:   Tue, 31 Jan 2023 08:04:06 -0700
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
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <7f8f2d0f-4bf2-71aa-c356-c78c6b7fd071@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/31/23 8:02?AM, David Hildenbrand wrote:
> On 31.01.23 15:50, Jens Axboe wrote:
>> On 1/31/23 6:48?AM, David Hildenbrand wrote:
>>> On 31.01.23 14:41, David Howells wrote:
>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>>>>> percpu counters maybe - add them up at the point of viewing?
>>>>>> They are percpu, see my last email. But for every 108 changes (on
>>>>>> my system), they will do two atomic_long_adds(). So not very
>>>>>> useful for anything but low frequency modifications.
>>>>>>
>>>>>
>>>>> Can we just treat the whole acquired/released accounting as a debug mechanism
>>>>> to detect missing releases and do it only for debug kernels?
>>>>>
>>>>>
>>>>> The pcpu counter is an s8, so we have to flush on a regular basis and cannot
>>>>> really defer it any longer ... but I'm curious if it would be of any help to
>>>>> only have a single PINNED counter that goes into both directions (inc/dec on
>>>>> pin/release), to reduce the flushing.
>>>>>
>>>>> Of course, once we pin/release more than ~108 pages in one go or we switch
>>>>> CPUs frequently it won't be that much of a help ...
>>>>
>>>> What are the stats actually used for?  Is it just debugging, or do we actually
>>>> have users for them (control groups spring to mind)?
>>>
>>> As it's really just "how many pinning events" vs. "how many unpinning
>>> events", I assume it's only for debugging.
>>>
>>> For example, if you pin the same page twice it would not get accounted
>>> as "a single page is pinned".
>>
>> How about something like the below then? I can send it out as a real
>> patch, will run a sanity check on it first but would be surprised if
>> this doesn't fix it.
>>
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index f45a3a5be53a..41abb16286ec 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -168,7 +168,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>            */
>>           smp_mb__after_atomic();
>>   +#ifdef CONFIG_DEBUG_VM
>>           node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, refs);
>> +#endif
>>             return folio;
>>       }
>> @@ -180,7 +182,9 @@ struct folio *try_grab_folio(struct page *page, int refs, unsigned int flags)
>>   static void gup_put_folio(struct folio *folio, int refs, unsigned int flags)
>>   {
>>       if (flags & FOLL_PIN) {
>> +#ifdef CONFIG_DEBUG_VM
>>           node_stat_mod_folio(folio, NR_FOLL_PIN_RELEASED, refs);
>> +#endif
>>           if (folio_test_large(folio))
>>               atomic_sub(refs, folio_pincount_ptr(folio));
>>           else
>> @@ -236,8 +240,9 @@ int __must_check try_grab_page(struct page *page, unsigned int flags)
>>           } else {
>>               folio_ref_add(folio, GUP_PIN_COUNTING_BIAS);
>>           }
>> -
>> +#ifdef CONFIG_DEBUG_VM
>>           node_stat_mod_folio(folio, NR_FOLL_PIN_ACQUIRED, 1);
>> +#endif
>>       }
>>         return 0;
>>
> 
> We might want to hide the counters completely by defining them only
> with CONFIG_DEBUG_VM.

Are all of them debug aids only? If so, yes we should just have
node_stat_* under CONFIG_DEBUG_VM.

-- 
Jens Axboe

