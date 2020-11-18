Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A17BF2B8675
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 22:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKRVTg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 16:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRVTe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:19:34 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE75FC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:19:32 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id r9so3619030ioo.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 13:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7cztEupH473jufETanc31Y2KjYRmhC5//sy0x1houAI=;
        b=EJU5Lj1zmJvTTaFPZIeugEYl6CMpJsd81LUYtNnq0/LDuGwajGLYOB75KUCnC+aVH1
         lRG2y4BwM3OBI2Q4/6D19pvlhtkLMA2c4L98ldHRnDn8+sQ+lrSK9SxsD6FMB6Cqsh2i
         UoJV23YvMs0lvmbWZeIw8Ev6+wgCnvhGyS5X1gqE1nSZecW5D2ETTZhVVv7abM1j1iZ6
         GualiFWiDlutozQlKDo99YZP/hXzqC6d0pIDPPSUVmnTNpduM1WT5h4d/gezYQJFdIun
         9M3NSzcB5OroR+1cPMQo1wlXrNHkc4PMEKzD4mOLE54YpH9iSYFOZwGca0KZmVdpJxQc
         zLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7cztEupH473jufETanc31Y2KjYRmhC5//sy0x1houAI=;
        b=RLhDQYQ3+4tYGuxoWezwNYYm7p54ZXFZ2wdggRaFkI/u1U0zp1M3susL4klCyyPDZH
         z7zwx38KSveXPf3ey0Lvn1Oo8syA3rgf/OzKVr8k+RmNxyoeeDFpJ7mRYzMz6gN2PdB7
         9EtNKfcjbD7DAjZhsqw7tN8FYySlEvhdmVGaiHaqFoMS20e2H1X0OGpKrmW1pPVS4lwP
         stssY0BJDhbWgP6fgoaUiTvTp9HB651ICjdWav9yl9yqZeyjpLBzeooNFzQZThZDckFt
         kzGXiBxWjFRPAeVG75EGBYFozLTlk/KwdZRaFLl9alU8EcMvWPcxVosPepGq4YoOdhxU
         5k9w==
X-Gm-Message-State: AOAM5310AkLg54pHyRr+sSlzAiEYJJVpjcg3dROjlg3uK7iKRnXJgSMA
        aIhPDFvui8cHOBASTGnV1nNs3KDPcJ/l4g==
X-Google-Smtp-Source: ABdhPJzpl/zlxCLd0jQ65EqevfzYgPBU2WeHLpEnalrtxYKb9StNj+wnxc+uIYUlVE9w1GoeWmTs1g==
X-Received: by 2002:a02:ec3:: with SMTP id 186mr10336108jae.92.1605734372001;
        Wed, 18 Nov 2020 13:19:32 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y2sm13325210ioc.46.2020.11.18.13.19.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 13:19:31 -0800 (PST)
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
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83997a78-7662-42ba-1e0d-9b543d3e3194@kernel.dk>
Date:   Wed, 18 Nov 2020 14:19:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201118211506.GQ7391@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 2:15 PM, Dave Chinner wrote:
> On Wed, Nov 18, 2020 at 02:00:06PM -0700, Jens Axboe wrote:
>> On 11/18/20 1:37 PM, Dave Chinner wrote:
>>> On Wed, Nov 18, 2020 at 08:26:50AM -0700, Jens Axboe wrote:
>>>> On 11/18/20 12:19 AM, Dave Chinner wrote:
>>>>> On Tue, Nov 17, 2020 at 03:17:18PM -0700, Jens Axboe wrote:
>>>>>> If we've successfully transferred some data in __iomap_dio_rw(),
>>>>>> don't mark an error for a latter segment in the dio.
>>>>>>
>>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>>
>>>>>> ---
>>>>>>
>>>>>> Debugging an issue with io_uring, which uses IOCB_NOWAIT for the
>>>>>> IO. If we do parts of an IO, then once that completes, we still
>>>>>> return -EAGAIN if we ran into a problem later on. That seems wrong,
>>>>>> normal convention would be to return the short IO instead. For the
>>>>>> -EAGAIN case, io_uring will retry later parts without IOCB_NOWAIT
>>>>>> and complete it successfully.
>>>>>
>>>>> So you are getting a write IO that is split across an allocated
>>>>> extent and a hole, and the second mapping is returning EAGAIN
>>>>> because allocation would be required? This sort of split extent IO
>>>>> is fairly common, so I'm not sure that splitting them into two
>>>>> separate IOs may not be the best approach.
>>>>
>>>> The case I seem to be hitting is this one:
>>>>
>>>> if (iocb->ki_flags & IOCB_NOWAIT) {
>>>> 	if (filemap_range_has_page(mapping, pos, end)) {
>>>>                   ret = -EAGAIN;
>>>>                   goto out_free_dio;
>>>> 	}
>>>> 	flags |= IOMAP_NOWAIT;
>>>> }
>>>>
>>>> in __iomap_dio_rw(), which isn't something we can detect upfront like IO
>>>> over a multiple extents...
>>>
>>> This specific situation cannot result in the partial IO behaviour
>>> you described.  It is an -upfront check- that is done before any IO
>>> is mapped or issued so results in the entire IO being skipped and we
>>> don't get anywhere near the code you changed.
>>>
>>> IOWs, this doesn't explain why you saw a partial IO, or why changing
>>> partial IO return values avoids -EAGAIN from a range we apparently
>>> just did a partial IO over and -didn't have page cache pages-
>>> sitting over it.
>>
>> You are right, I double checked and recreated my debugging. What's
>> triggering is that we're hitting this in xfs_direct_write_iomap_begin()
>> after we've already done some IO:
>>
>> allocate_blocks:
>> 	error = -EAGAIN;
>> 	if (flags & IOMAP_NOWAIT)
>> 		goto out_unlock;
> 
> Ok, that's exactly the case the reproducer I wrote triggers.

OK good, then we're on the same page :-)

>>> Can you provide an actual event trace of the IOs in question that
>>> are failing in your tests (e.g. from something like `trace-cmd
>>> record -e xfs_file\* -e xfs_i\* -e xfs_\*write -e iomap\*` over the
>>> sequential that reproduces the issue) so that there's no ambiguity
>>> over how this problem is occurring in your systems?
>>
>> Let me know if you still want this!
> 
> No, it makes sense now :)

What's the next step here? Are you working on an XFS fix for this?

Was looking at other potential -EAGAIN during the loop, and seems like
we'd be able to hit this if we fail xfs_ilock_for_iomap() as well. And
not sure how that would be solvable, without accepting that IOCB_NOWAIT
reads/writes can be short.

-- 
Jens Axboe

