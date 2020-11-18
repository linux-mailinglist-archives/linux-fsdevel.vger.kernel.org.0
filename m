Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16072B86D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgKRVgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgKRVgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:36:51 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030DCC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:36:49 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d17so3694127ion.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EL4banRxpfbAZZyLO7kGiH3ePKLWz2gQHf+YpXUwIzs=;
        b=Lp049pMmFGk4A3VKVnAOqBsiwa5uWth+fi0idqz391rlFbJUeoF14oye4mTX+/vKXn
         N4r9NCayCqQj9+ERJNJHV4KfGZyhbrgfKROHRT5RrgnW2AC2IjW8Sk8SjbtwHZ/xeQUJ
         O7Pnyub+yTh/TALUMkNq2i2YL2mJSPHZzTnQresUC3VNh+nLK+wZLy1yXTFTwPdv6FgJ
         dGYHbBm5xZ+SvX74bz3qFAFOl85J5xnm6Hv9RC7t72ffuh0sbuqaE+W68eOSUKJlE25R
         04rEbiwA5pgOEHKINXTNfHW12twtCZHB0O7aFBrisaytKZmWuvgzHVIh+GwH74c51t11
         KRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EL4banRxpfbAZZyLO7kGiH3ePKLWz2gQHf+YpXUwIzs=;
        b=e7hwcI4SITrTyQTIJ3Amhdo99dWa/WkdG3ivhjYhcEHv3PEuoQgV45mqOwikygCVU8
         SAORBlU5PpWG7iBUDi5z4cjsYH75GvZeMRY/j8obOIjKiEb2MbaSBUoqw10L1pA8gYuQ
         xJ6SK7qJrIV7YF9KEpMbblgSAbu3mx5+b8RxsHuY8qWl8E8MU88G7Vyy8KuH08lLQbYL
         DDCQZcIIWLtk/LcH0jeATNMAfVvptjoJEWOyrSD57gzOZj6skUOo4W8+NQLF2aTerUMG
         w5+tTlL0Nj2H8b++fG8j+ooufbOlVsQSxgfuJhGXZ24cx3dYaCy2awBCQaYN9yWVdy2+
         IVZA==
X-Gm-Message-State: AOAM532yq2Dn2JhzESXRD7PBo8XQjAk0CjxvsTGlq++hCYTHcDf2H6EX
        GboUu3w5RFoZI/y9tDp6MogHDz0bcp+wEQ==
X-Google-Smtp-Source: ABdhPJw1kCavCSYOPBKpDnVsGcsaIwvcv3+8NEcYpvxnuuLcFyUgAXEKxle3+7renx9atyG8tAICyg==
X-Received: by 2002:a02:cbb5:: with SMTP id v21mr10939898jap.80.1605735408793;
        Wed, 18 Nov 2020 13:36:48 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y2sm13343051ioc.46.2020.11.18.13.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:36:48 -0800 (PST)
Subject: Re: [PATCH RFC] iomap: only return IO error if no data has been
 transferred
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <2a56ae95-b64e-f20f-8875-62a2f2e8e00f@kernel.dk>
 <20201118071941.GN7391@dread.disaster.area>
 <9ef0f890-f115-41f3-15fc-28f21810379f@kernel.dk>
 <20201118203723.GP7391@dread.disaster.area>
 <95d51836-9dc0-24c3-9aad-678d68613907@kernel.dk>
 <20201118211506.GQ7391@dread.disaster.area>
 <83997a78-7662-42ba-1e0d-9b543d3e3194@kernel.dk>
 <20201118213341.GR7391@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83c8c94e-0d70-bd9a-d5b2-0621c1d977ac@kernel.dk>
Date:   Wed, 18 Nov 2020 14:36:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118213341.GR7391@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 2:33 PM, Dave Chinner wrote:
> On Wed, Nov 18, 2020 at 02:19:30PM -0700, Jens Axboe wrote:
>> On 11/18/20 2:15 PM, Dave Chinner wrote:
>>> On Wed, Nov 18, 2020 at 02:00:06PM -0700, Jens Axboe wrote:
>>>> On 11/18/20 1:37 PM, Dave Chinner wrote:
>>>>> On Wed, Nov 18, 2020 at 08:26:50AM -0700, Jens Axboe wrote:
>>>>>> On 11/18/20 12:19 AM, Dave Chinner wrote:
>>>>>>> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
>>>>>>>> If we've successfully transferred some data in __iomap_dio_rw(),
>>>>>>>> don't mark an error for a latter segment in the dio.
>>>>>>>>
>>>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>>>
>>>>>>>> ---
>>>>>>>>
>>>>>>>> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
>>>>>>>> IO. If we do parts of an IO, then once that completes, we still
>>>>>>>> return -EAGAIN if we ran into a problem later on. That seems wrong,
>>>>>>>> normal convention would be to return the short IO instead. For the
>>>>>>>> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
>>>>>>>> and complete it successfully.
>>>>>>>
>>>>>>> So you are getting a write IO that is split across an allocated
>>>>>>> extent and a hole, and the second mapping is returning EAGAIN
>>>>>>> because allocation would be required? This sort of split extent IO
>>>>>>> is fairly common, so I'm not sure that splitting them into two
>>>>>>> separate IOs may not be the best approach.
>>>>>>
>>>>>> The case I seem to be hitting is this one:
>>>>>>
>>>>>> if (iocb->ki_flags & IOCB_NOWAIT) {
>>>>>> 	if (filemap_range_has_page(mapping, pos, end)) {
>>>>>>                   ret = -EAGAIN;
>>>>>>                   goto out_free_dio;
>>>>>> 	}
>>>>>> 	flags |= IOMAP_NOWAIT;
>>>>>> }
>>>>>>
>>>>>> in __iomap_dio_rw(), which isn't something we can detect upfront like IO
>>>>>> over a multiple extents...
>>>>>
>>>>> This specific situation cannot result in the partial IO behaviour
>>>>> you described.  It is an -upfront check- that is done before any IO
>>>>> is mapped or issued so results in the entire IO being skipped and we
>>>>> don't get anywhere near the code you changed.
>>>>>
>>>>> IOWs, this doesn't explain why you saw a partial IO, or why changing
>>>>> partial IO return values avoids -EAGAIN from a range we apparently
>>>>> just did a partial IO over and -didn't have page cache pages-
>>>>> sitting over it.
>>>>
>>>> You are right, I double checked and recreated my debugging. What's
>>>> triggering is that we're hitting this in xfs_direct_write_iomap_begin()
>>>> after we've already done some IO:
>>>>
>>>> allocate_blocks:
>>>> 	error = -EAGAIN;
>>>> 	if (flags & IOMAP_NOWAIT)
>>>> 		goto out_unlock;
>>>
>>> Ok, that's exactly the case the reproducer I wrote triggers.
>>
>> OK good, then we're on the same page :-)
>>
>>>>> Can you provide an actual event trace of the IOs in question that
>>>>> are failing in your tests (e.g. from something like `trace-cmd
>>>>> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
>>>>> sequential that reproduces the issue) so that there's no ambiguity
>>>>> over how this problem is occurring in your systems?
>>>>
>>>> Let me know if you still want this!
>>>
>>> No, it makes sense now :)
>>
>> What's the next step here? Are you working on an XFS fix for this?
> 
> I'm just building the patch now for testing.

Nice, you're fast...

>> Was looking at other potential -EAGAIN during the loop, and seems like
>> we'd be able to hit this if we fail xfs_ilock_for_iomap() as well. And
>> not sure how that would be solvable, without accepting that IOCB_NOWAIT
>> reads/writes can be short.
> 
> The change I'm making should solves that, too. i.e. NOWAIT IO must
> map entirely within a single extent, so there is no scope for a
> short IO and re-entering the mapping code under NOWAIT conditions
> that could then fail.

Perfect, thanks Dave!

-- 
Jens Axboe

