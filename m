Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD47BF2EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfIZM0f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 08:26:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42580 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfIZM0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:26:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so2229331wrw.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 05:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p32y5pL62PU7Yf9iy/plIVHUc6YiHXgm7LNnsJBfWag=;
        b=QOUNhFqApk0JZioGtQSmqcw6DrLAybbq5zyIfy4vZUVbIk0srAk//b2mD0SDPpM8uJ
         891LzBY3eRJHYK4y5wWOZeWbZqRs20mepTSFNoIae3EMzwh4/3LdP/SEcrGfU6sAQb/8
         0L5o4W5RCKH/MeSm2qXQXeKbS6FjhFCheOaLlXJkI3KPTYzsagKWNhqO0Y/9VnQDIGOu
         8X+NXogpXrd2GPzJWHPCdqHKrug9a73PnieO6i8eo/Z66MaWiwCwvxuj0bZQq2R1J0Ag
         8OJF4cvEQGNIbJyh06yT4xAWUQMM/rej6F3HP8azXufHyMzuY7mbvOGC3E+3IP/FKxkb
         QoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p32y5pL62PU7Yf9iy/plIVHUc6YiHXgm7LNnsJBfWag=;
        b=jXJW5R3m+JeFeUZK1hHRlqppD7R97tgqZ4jFNl2gbnNvfH+d4LGUB8A+cRRd6qoXbI
         97tDI+CEKc5b+MP4h+xLjpilaPOxywYfrHbL9jWLHl4+BMvueE7PPemdDMGto5T+hQxB
         +uw580ut6Skhc26L4iyMxjT53wtNCKFmr0qrPJpmrvHFMbzFJ3w02UvIdIc1m3lmQexC
         XzexfgpX8xKW0AAVffwg4RYgoZXijC7jedqpgVuuN0MdxdRcnwWrp69yCk0SSKiHAO+H
         MIlCTuSCptaf2nXDaES0eigqfMaJEUD5C+IKx4kLH6qtKOCHLQEP+x0CC6hXPvho2b+u
         bcvw==
X-Gm-Message-State: APjAAAVbw1uuTil1iDWqh+ZE0Yd+Lrb3yuQN0d3gm+z3E2scLNFn4521
        0Sp8Gu6WE+RxKmvk/kwImXxI+Q==
X-Google-Smtp-Source: APXvYqzBATD7joVjL92vZMpqjqZNavOQPERuLrMeZb/ll/M9FujdM09hbbVOjMLwThqwb9vquE5C1g==
X-Received: by 2002:a05:6000:108c:: with SMTP id y12mr1628248wrw.238.1569500792496;
        Thu, 26 Sep 2019 05:26:32 -0700 (PDT)
Received: from [192.168.1.145] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id e17sm1932014wma.15.2019.09.26.05.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 05:26:31 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190926095012.31826-1-colin.king@canonical.com>
 <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
 <20190926113329.GE27389@kadam>
 <04262621-68fd-a4bb-ab0c-83954c03fbb0@kernel.dk>
 <2de0eb45-3abc-3ccd-f3d3-346d899ba50d@rasmusvillemoes.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9754557-38a5-052b-f42d-6ba9d7acfed2@kernel.dk>
Date:   Thu, 26 Sep 2019 14:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2de0eb45-3abc-3ccd-f3d3-346d899ba50d@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/19 2:14 PM, Rasmus Villemoes wrote:
> On 26/09/2019 13.42, Jens Axboe wrote:
>> On 9/26/19 1:33 PM, Dan Carpenter wrote:
>>> On Thu, Sep 26, 2019 at 11:56:30AM +0200, Jens Axboe wrote:
>>>> On 9/26/19 11:50 AM, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> In the case where sig is NULL the error variable ret is not initialized
>>>>> and may contain a garbage value on the final checks to see if ret is
>>>>> -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
>>>>> ensure the ret does not accidentially contain -ERESTARTSYS before the
>>>>> loop.
>>>>
>>>> Oops, weird it didn't complain. I've folded in this fix, as that commit
>>>> isn't upstream yet. Thanks!
>>>
>>> There is a bug in GCC where at certain optimization levels, instead of
>>> complaining, it initializes it to zero.
>>
>> That's awfully nice of it ;-)
>>
>> Tried with -O0 and still didn't complain for me.
>>
>> $ gcc --version
>> gcc (Ubuntu 9.1.0-2ubuntu2~18.04) 9.1.0
>>
>> Tried gcc 5/6/7/8 as well. Might have to go look at what code it's
>> generating.
>>
> 
> I think it's essentially the same as
> https://lore.kernel.org/lkml/CAHk-=whP-9yPAWuJDwA6+rQ-9owuYZgmrMA9AqO3EGJVefe8vg@mail.gmail.com/
> (thread "tmpfs: fix uninitialized return value in shmem_link").

I think you're right, it's the same pattern. If I kill the:

if (ret)
	return ret;

inside the if (sig) branch, then gcc does show the warning as it should.

-- 
Jens Axboe

