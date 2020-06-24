Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE96207963
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391250AbgFXQoY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391226AbgFXQoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:44:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA8FC061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 09:44:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so1674458pgn.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MTRMKEW0KCXWy44lqufzCQhDf6gXTTb7ZrXSYsufaq0=;
        b=jmm3QQI0tdZrsdA6jPwTBhaVfQro9QpvXw4CCufatWzxrrgq9DmDpRXOnkQxCLjZRI
         KAwuijMeZvHEvckvDPNC1uBeztqdngpExlw5CTsvhreUCUUIosB3n+1TvnMGSOiAL9Vu
         zh21gzSV1Bo0zgLNCJFfjnQjbUkk3E+ftiwQmtYAa/rt0zBszkpsyUAEfa/SMRaPWdeL
         xArvs8TAnO9nlXUY+zU08Ojl9HicCdCmX6yzHDSEu5iICzDatAS4gkEY5syYt73jtDNW
         8t2Wxki7DSAhO9tl7lzWh4jmne6faPgnCDcY4AArMyrrwLXxgcIX/XvZAys54B0mQwaz
         XiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MTRMKEW0KCXWy44lqufzCQhDf6gXTTb7ZrXSYsufaq0=;
        b=meZie0DpIABridTE3Uhq67tksehTyvrHk4WcPbvhN30/vSuXG8ikOuGN6O4u7CuC3d
         pUCe5k9cAjXj7s11lE03IRhCLRbVbFu0FmQ98oCL+32grCiMGL4Evu4CqpKi/OHD4yNI
         mHyfCEDw/PQ9EVTZvo+1OX20dBFTopNwLyNUdqfo3607aSfWavmMZ9jrxLDT03Ra16e3
         thSgluzrcrgutHJAfcr3xUgzO518W45yxIPgrs8Zu39lU4SO40UN/wD0q/tgB9SdVvIR
         ceV5SfCGAt4+Li9OIGZf1hnyy5VIW+ECmLf8cpDMOoo7vUl0d5/Q1bGRI1RPAx1X4fWP
         ab4A==
X-Gm-Message-State: AOAM532SrkdT5EuRkJl/XmQTiwlN4uhe0xkVTrXTA+70nwrrTNEzT73p
        SaNexx1HpK4YGcDaiETe3RHurQ==
X-Google-Smtp-Source: ABdhPJwv+HSOZKZl9Rs6O63Aq5U3yEsp+jpZYYb2Jui24C7D3n7Wz4JIcXL5PtCUVlLAAO5CJkLv8A==
X-Received: by 2002:a62:19c4:: with SMTP id 187mr7097299pfz.312.1593017063628;
        Wed, 24 Jun 2020 09:44:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j10sm12026479pgh.28.2020.06.24.09.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 09:44:23 -0700 (PDT)
Subject: Re: [PATCH 05/15] mm: allow read-ahead with IOCB_NOWAIT set
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20200618144355.17324-1-axboe@kernel.dk>
 <20200618144355.17324-6-axboe@kernel.dk>
 <20200624010253.GB5369@dread.disaster.area>
 <20200624014645.GJ21350@casper.infradead.org>
 <bad52be9-ae44-171b-8dbf-0d98eedcadc0@kernel.dk>
 <70b0427c-7303-8f45-48bd-caa0562a2951@kernel.dk>
 <20200624164127.GP21350@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8835b6f2-b3c5-c9a0-2119-1fb161cf87dd@kernel.dk>
Date:   Wed, 24 Jun 2020 10:44:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624164127.GP21350@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/24/20 10:41 AM, Matthew Wilcox wrote:
> On Wed, Jun 24, 2020 at 09:35:19AM -0600, Jens Axboe wrote:
>> On 6/24/20 9:00 AM, Jens Axboe wrote:
>>> On 6/23/20 7:46 PM, Matthew Wilcox wrote:
>>>> I'd be quite happy to add a gfp_t to struct readahead_control.
>>>> The other thing I've been looking into for other reasons is adding
>>>> a memalloc_nowait_{save,restore}, which would avoid passing down
>>>> the gfp_t.
>>>
>>> That was my first thought, having the memalloc_foo_save/restore for
>>> this. I don't think adding a gfp_t to readahead_control is going
>>> to be super useful, seems like the kind of thing that should be
>>> non-blocking by default.
>>
>> We're already doing memalloc_nofs_save/restore in
>> page_cache_readahead_unbounded(), so I think all we need is to just do a
>> noio dance in generic_file_buffered_read() and that should be enough.
> 
> I think we can still sleep though, right?  I was thinking more
> like this:
> 
> http://git.infradead.org/users/willy/linux.git/shortlog/refs/heads/memalloc

Yeah, that's probably better. How do we want to handle this? I've already
got the other bits queued up. I can either add them to the series, or
pull a branch that'll go into Linus as well.

-- 
Jens Axboe

