Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99D932F5AF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 07:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbhANGtV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 01:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbhANGtU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 01:49:20 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72605C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 22:48:40 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id y23so3677655wmi.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Jan 2021 22:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=rEByY9VwYO/ilF16a6/hn85Ky4LITGY/WfKgegfD5ho=;
        b=mN9jnHc8tUpRqXrUDJc0JxMGzXaGqq4riLHE0OaQcOKz40MOnCBzwuJavypl9SPtgl
         29BFRuKL5m7sLlMgFiVseBvw8HIyTz11jGZ2DELghCcvEaeH5Ii9HsAvHrv9+P0VCuDz
         lHwbGyzFLKzquJ38sVEytN/higd0/lG2rV7iSQ2PhQ6jzjxgGnmEliR3uyO/UbBQab2E
         4hJZ7f3zycYrfg2nBIqLEv6Kt9M25rmVNqdbea+lHKB9QcZINxBGu4ROdtcR/yp4gLn9
         WpTkVk1tmlMy40+7AbXJifdKVXsU6eVFZ9Ho3NHnVM9DThzmGy5Aki8+XTYGZYqmLLbW
         PXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=rEByY9VwYO/ilF16a6/hn85Ky4LITGY/WfKgegfD5ho=;
        b=V+r2oRWNVXaHbUirzHMH7lCTAG6YsZuSp3DyGEETRooACi5wWhinZJZtCl9hLDWUk6
         ZPnt16ATnAfJ5YOFh5by+m9cmRzyGfEFcM76hbzfNOJ4y0kB1w1O3h8vEmAkHqM293zQ
         c93m5x9oquI25JEGBZ6AsBl7pu7GfZmmKh6EODg9bOlaBD+CxftO+Bo6KeYlJXT7xZbd
         MJz3QX3Ex2LGY9957wRP1Dnd4Q4nh4sKcYRvK1z7ijkknAYrWLoCeg4hmpvKj/SO/hNc
         B4D1Ea5olrHF8XOt8PWIDY+3RAT5CEPjFcIDRCnDtGXdg1b1mKHFf+8lRVCLA6X79Wkk
         mJVw==
X-Gm-Message-State: AOAM530VIAeygDMM++MhzI3bED/M6LbiEnqdGny91UIf4JY7B73X79I7
        7AIERR9SW5tlaZfeaTaLuVE+Gg==
X-Google-Smtp-Source: ABdhPJzpECKyW4ZabeXsvmWWwG6DkSOugAgOdBizZb0+5sBQkqNqqRrIXmZaoDxsfry1lJbglM2+2Q==
X-Received: by 2002:a05:600c:2117:: with SMTP id u23mr2337658wml.153.1610606918861;
        Wed, 13 Jan 2021 22:48:38 -0800 (PST)
Received: from tmp.scylladb.com (bzq-79-182-3-66.red.bezeqint.net. [79.182.3.66])
        by smtp.googlemail.com with ESMTPSA id v20sm8141086wra.19.2021.01.13.22.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 22:48:37 -0800 (PST)
Subject: Re: [RFC] xfs: reduce sub-block DIO serialisation
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        andres@anarazel.de
References: <20210112010746.1154363-1-david@fromorbit.com>
 <32f99253-fe56-9198-e47c-7eb0e24fdf73@scylladb.com>
 <20210112221324.GU331610@dread.disaster.area>
 <0f0706f9-92ab-6b38-f3ab-b91aaf4343d1@scylladb.com>
 <20210113203809.GF331610@dread.disaster.area>
From:   Avi Kivity <avi@scylladb.com>
Message-ID: <50362fc8-3d5e-cd93-4e55-f3ecddc21780@scylladb.com>
Date:   Thu, 14 Jan 2021 08:48:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113203809.GF331610@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/21 10:38 PM, Dave Chinner wrote:
> On Wed, Jan 13, 2021 at 10:00:37AM +0200, Avi Kivity wrote:
>> On 1/13/21 12:13 AM, Dave Chinner wrote:
>>> On Tue, Jan 12, 2021 at 10:01:35AM +0200, Avi Kivity wrote:
>>>> On 1/12/21 3:07 AM, Dave Chinner wrote:
>>>>> Hi folks,
>>>>>
>>>>> This is the XFS implementation on the sub-block DIO optimisations
>>>>> for written extents that I've mentioned on #xfs and a couple of
>>>>> times now on the XFS mailing list.
>>>>>
>>>>> It takes the approach of using the IOMAP_NOWAIT non-blocking
>>>>> IO submission infrastructure to optimistically dispatch sub-block
>>>>> DIO without exclusive locking. If the extent mapping callback
>>>>> decides that it can't do the unaligned IO without extent
>>>>> manipulation, sub-block zeroing, blocking or splitting the IO into
>>>>> multiple parts, it aborts the IO with -EAGAIN. This allows the high
>>>>> level filesystem code to then take exclusive locks and resubmit the
>>>>> IO once it has guaranteed no other IO is in progress on the inode
>>>>> (the current implementation).
>>>> Can you expand on the no-splitting requirement? Does it involve only
>>>> splitting by XFS (IO spans >1 extents) or lower layers (RAID)?
>>> XFS only.
>>
>> Ok, that is somewhat under control as I can provide an extent hint, and wish
>> really hard that the filesystem isn't fragmented.
>>
>>
>>>> The reason I'm concerned is that it's the constraint that the application
>>>> has least control over. I guess I could use RWF_NOWAIT to avoid blocking my
>>>> main thread (but last time I tried I'd get occasional EIOs that frightened
>>>> me off that).
>>> Spurious EIO from RWF_NOWAIT is a bug that needs to be fixed. DO you
>>> have any details?
>>>
>> I reported it in [1]. It's long since gone since I disabled RWF_NOWAIT. It
>> was relatively rare, sometimes happening in continuous integration runs that
>> take hours, and sometimes not.
>>
>>
>> I expect it's fixed by now since io_uring relies on it. Maybe I should turn
>> it on for kernels > some_random_version.
>>
>>
>> [1] https://lore.kernel.org/lkml/9bab0f40-5748-f147-efeb-5aac4fd44533@scylladb.com/t/#u
> Yeah, as I thought. Usage of REQ_NOWAIT with filesystem based IO is
> simply broken - it causes spurious IO failures to be reported to IO
> completion callbacks and so are very difficult to track and/or
> retry. iomap does not use REQ_NOWAIT at all, so you should not ever
> see this from XFS or ext4 DIO anymore...


What kernel version would be good?


Searching the log I found


commit 4503b7676a2e0abe69c2f2c0d8b03aec53f2f048
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Jun 1 10:00:27 2020 -0600

     io_uring: catch -EIO from buffered issue request failure

     -EIO bubbles up like -EAGAIN if we fail to allocate a request at the
     lower level. Play it safe and treat it like -EAGAIN in terms of sync
     retry, to avoid passing back an errant -EIO.

     Catch some of these early for block based file, as non-mq devices
     generally do not support NOWAIT. That saves us some overhead by
     not first trying, then retrying from async context. We can go straight
     to async punt instead.

     Signed-off-by: Jens Axboe <axboe@kernel.dk>

but this looks to be io_uring specific fix (somewhat frightening too), 
not removal of REQ_NOWAIT.



