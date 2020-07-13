Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274C1219040
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 21:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgGHTOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHTOr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:14:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F634C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 12:14:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id a11so31813378ilk.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rFsgcBrLfHYz/K6KxtoQL9iwQ95h3ppfoE4ItS1iQH4=;
        b=KFy9EDJQ15yHM7RpBGVq7CDaBD8wf5jWOuDE+t5q1FllhyvSnw7J0j75VprQoaTsmp
         2UYdXzlGVND/oHyANGmmndAWgKF9U2gq6KZJyX6Spr/fim1dByo1TiXMRgmOLB4mFEQc
         dqnSNDt7UwoAv8b0fwJ2sjblOC/Wq9S9oC6B47Ju4+HL04cvEzQsaG8vJyBHVBRAPJ89
         gj5fWTgl+qHz0Pe8ar4rL6X/zWUGK2b6hlFRqs4KNlNj4/pGAjt6zrofMOgxc5p39kgU
         B4niIuCT6RT78Zqgyzi45eX3eT/3jX1/Ayy3Ergp/rXM5XvHxFV6TewHwPecoK57rBf/
         m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rFsgcBrLfHYz/K6KxtoQL9iwQ95h3ppfoE4ItS1iQH4=;
        b=mhfTHejUEDwS9BMbHJlhsuP9LFxICyGw6qmlhl2+sl7y0BKWM8LSuhV2AIMQ4V/9w4
         YMNRFrfZl2cmigyRynazbtTs0W8RtDTu+sw5wOgLGKPJbJQKD4207UhVYxarJXq6Vx/Q
         7QGqihHurBhGxxkEgPEv6PjGB+uOkb6vWGkVKYyXOS0s14FaUrzsyThcul3ufffu3pbB
         T/yr8v9liHmnBRJJAdJ2ZPGaquudjD0t0EVkk2kFriNOwKiJjM/kxgCxLL0/wZu8Hpfn
         Oe0ppxek930OroxvxUsnlGFXiujyxdjPkCa5oEhmai3UFzlInIyPiieA/vc9oUumsztG
         AbVQ==
X-Gm-Message-State: AOAM530pXI4ld1fYqMcaG5BhkcUuvJ2E6j4t1qVowUVpSFTZaCbB+F3c
        6tBJN4iNUE4/gbyyezexl5Ep0T9pYD7bYQ==
X-Google-Smtp-Source: ABdhPJwHwAEhOI/pp2Kagui9FzEmSG7QfUJ9DIOdxqjh4TslZE34q6zNm8rd3XtA9NA6A6kDaYAVRQ==
X-Received: by 2002:a05:6e02:128d:: with SMTP id y13mr42270618ilq.305.1594235686111;
        Wed, 08 Jul 2020 12:14:46 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a1sm374149ilq.50.2020.07.08.12.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 12:14:45 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix a use after free in io_async_task_func()
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200708184711.GA31157@mwanda>
 <4ea3c931-1738-14e2-aac6-55ef9b3dedeb@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8d70f6ba-4f9f-24da-1dc2-83af554316b8@kernel.dk>
Date:   Wed, 8 Jul 2020 13:14:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4ea3c931-1738-14e2-aac6-55ef9b3dedeb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/8/20 1:01 PM, Pavel Begunkov wrote:
> On 08/07/2020 21:47, Dan Carpenter wrote:
>> The "apoll" variable is freed and then used on the next line.  We need
>> to move the free down a few lines.
> 
> My bad, thanks for spotting that!
> A comment below
> 
>>
>> Fixes: 0be0b0e33b0b ("io_uring: simplify io_async_task_func()")
>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  fs/io_uring.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 70828e2470e2..f2993070a9e8 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -4652,12 +4652,13 @@ static void io_async_task_func(struct callback_head *cb)
>>  	/* restore ->work in case we need to retry again */
>>  	if (req->flags & REQ_F_WORK_INITIALIZED)
>>  		memcpy(&req->work, &apoll->work, sizeof(req->work));
>> -	kfree(apoll);
> 
> __io_req_task_submit() can take some time, e.g. waiting for a mutex, so
> I'd rather free it before, but save req->poll.canceled in a local var.

It's 64 bytes of data, really doesn't matter. Let's just keep it simple.

-- 
Jens Axboe

