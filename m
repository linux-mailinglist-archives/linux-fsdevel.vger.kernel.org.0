Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE4136B581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 17:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233963AbhDZPMx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhDZPMx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:12:53 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A39C061756
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 08:12:11 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id p15so11146329iln.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=swd2ytxCTbLtBkqxY4O+lU4BzwGRhipWxkgb2JYbQEw=;
        b=Lw76PaXLz7pySCFqUgmvUQmLWlrEJ2bC2MpTbYOs7d24zAXTVdSgZY9/LFZDs8n6yZ
         3/fgV/nIm8dpjPnqIrnULy7L5fsKDARfk1p1RvvTWhhhz8eP/8VshbORBTNHOOm6CSNW
         jg8y+R8dfQhbABFiSCz69An7f+G7DO6cQXKJKPowG15E4yQrKmBlxgU4/YdZnST9J1wc
         TBtbuqgOTF7VojGRcpFRO7c+Saze9FLao0C6lMJ6xrkwUjUADnmm0Xm0OzwjAGxt14Pw
         3XxBwUc9Ut4srDcn8ESgU0ixETEcHgse30u/Xf1GVviCIFccwVy5Uo4gZmA/cSuf9JCw
         0Enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=swd2ytxCTbLtBkqxY4O+lU4BzwGRhipWxkgb2JYbQEw=;
        b=blDxmhswouxb5WbF34nLynUPHnp8lNudqsAc88A3mn7QrFz/mreE+mXEZFluircfCz
         +lka9OFsKPec6iEkhmJmYr1wzB7gySoGUIvCjwuEMfzUOkc9NjldLuB5gFcJbKxsvece
         D4fQvLJuT+Qof7TY0wq0xUDgQ08NZkVq7GZPwtWGa1Ji/ufaC97O8SehdxkaXQYbb195
         8X1qwBXmsK6LtvYObuae3SqbFzC/V810HTjdfsHZgrqG8y1LjnkiNz+XrWFrfLgvNjTb
         JTu3xfVxGihQG/WBrxp2E7M2d/xKtZw3YbvrN3jvJvi1j48G357dDgmEf1hq4R5ezwCj
         JOvQ==
X-Gm-Message-State: AOAM530vJp4af4fcP8gduMb9PfZ12fekkWSCz/CzF8/s00ruMiP0UXO/
        FJZyPP3fMXujlCl0cLj3LQTOo/xxGgfOFw==
X-Google-Smtp-Source: ABdhPJxj7xl/uWhQqF7nbW7Df2KHSJ6/UD7qMkHtZkW298KohHJ7Xyk3rKhIyJ0rbnNvCGJzFknKOQ==
X-Received: by 2002:a92:d58a:: with SMTP id a10mr13936856iln.170.1619449930352;
        Mon, 26 Apr 2021 08:12:10 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h8sm83963ils.35.2021.04.26.08.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 08:12:09 -0700 (PDT)
Subject: Re: switch block layer polling to a bio based model
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20210426134821.2191160-1-hch@lst.de>
 <2d229167-f56d-583b-569c-166c97ce2e71@kernel.dk>
 <20210426150638.GA24618@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b7e3ba0-aa09-b86d-8ea1-dc2e78c7529e@kernel.dk>
Date:   Mon, 26 Apr 2021 09:12:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210426150638.GA24618@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/21 9:06 AM, Christoph Hellwig wrote:
> On Mon, Apr 26, 2021 at 08:57:31AM -0600, Jens Axboe wrote:
>> I was separately curious about this as I have a (as of yet unposted)
>> patchset that recycles bio allocations, as we spend quite a bit of time
>> doing that for high rate polled IO. It's good for taking the above 2.97M
>> IOPS to 3.2-3.3M IOPS, and it'd obviously be a bit more problematic with
>> required RCU freeing of bio's. Even without the alloc cache, using RCU
>> will ruin any potential cache locality on back-to-back bio free + bio
>> alloc.
> 
> That sucks indeed.  How do you recycle the bios?  If we make sure the

Here's the series. It's not super clean (yet), but basically allows
users like io_uring to setup a bio cache, and pass that in through
iocb->ki_bi_cache. With that, we can recycle them instead of going
through free+alloc continually. If you look at profiles for high iops,
we're spending more time than desired doing just that.

https://git.kernel.dk/cgit/linux-block/log/?h=io_uring-bio-cache

> bio is only ever recycled as a bio and bi_bdev remaings valid long
> enough we might not need the rcu free.  Even without your recycling
> we could probably do something nasty using SLAB_TYPESAFE_BY_RCU.

It would not be hard to restrict to same bdev for the cache, just one
more check to do for recycling.

Note that the caching series _only_ supports polled IO for now, as
non-polled would require IRQ juggling for free+alloc and that will
definitely take some of the win away and maybe even render it moot.
Have yet to test that part out. Not a huge deal with the RCU free, as
you end up doing that purely for polled IO and hence wouldn't impact the
IRQ side of things negatively.

-- 
Jens Axboe

