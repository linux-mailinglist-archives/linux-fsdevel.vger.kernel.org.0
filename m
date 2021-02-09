Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67806314615
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 03:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhBICPx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 21:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhBICPw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 21:15:52 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947EEC061786
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 18:15:06 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u11so8863429plg.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 18:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NXF5mAWovbyAD4R2NQnySI3fHtBI6fQfDgdgbFNzh3s=;
        b=vEHPzOQW0z0Vj57q8EnpJC1H3Tq7Mu8FzJPV6bIWJa5XLlcOUtVY59k5E3ivawmfDj
         gVO4Vxa5yqAMcd0w4uWA/Cb66YcGqFLLCYk+NikQKTCo+ZdMF3lv1RuY+8CNY4bQ8Ybd
         reZm7lgU/SO83hahixkMv0m+HSwD0ht4lxDrlud/rfi3OBn5p78u6vhCx9p5AUeNGRU0
         1DIT8jJ9VPvSzBKKfDdOAFXN3W5F02AZ6AQxHQ0bZPTUXD8d5naNr9GZ4i0eoa9XP6Bj
         8DylUEG8fRk0Mqv2Kye6ZkyimU8cku1nzFKifBnXADkT35qEG5EpbcLLopvq2sAvWPru
         8ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NXF5mAWovbyAD4R2NQnySI3fHtBI6fQfDgdgbFNzh3s=;
        b=Grq3ZRvPb3yOhalsYIKyHNUG8PZe8zIBnqR+91ieYZBb24BctIeRsPGE/h9zIlQ5Ky
         mnnHeWkoavjeomlDTLvzR3IruUtLJK806I0omk1KPWl9Ud64l6SZDwF1P4WkY+y90rBh
         m2rO3dnGJI5ucbmwEo/NVzRE2cXujpS30nNqR1Sshv9SX5OasH1Kxc444Kq9qgtH55jP
         3m/GvHUUt43dG2koZxvfCo/ImkHj+wQvDM6P5bWRs3JNJTrLmqYN/vjySc8FgNanRze5
         4tkRI3GA/iV1YNamKKnkyub4JrAHdsIobhj6FdACK/SupO8PEQm6WEEcQ/DnnkbbSE7R
         pPvA==
X-Gm-Message-State: AOAM533Hi6CBKMYt0p6QlHfGN9ARw9tAPfriCgktCcJ+6ANCKzNxCJqx
        KZMi+FHE0YIGyY925PMMdirT1A==
X-Google-Smtp-Source: ABdhPJxnnemMqIkc+XgVs3kxrwTInx0C4AkYjo9PzvierTtrd+sRGNpqmslp1t2tOtYKjE6oDE0l7Q==
X-Received: by 2002:a17:90a:cb15:: with SMTP id z21mr1725692pjt.164.1612836905962;
        Mon, 08 Feb 2021 18:15:05 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id r5sm286894pfh.13.2021.02.08.18.15.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 18:15:05 -0800 (PST)
Subject: Re: [PATCHSET 0/3] Improve IOCB_NOWAIT O_DIRECT
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <20210208221829.17247-1-axboe@kernel.dk>
 <20210208232846.GO4626@dread.disaster.area>
 <44fec531-b2fd-f569-538a-64449a5c371b@kernel.dk>
 <20210209001445.GP4626@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb23a9ed-623e-b221-05d6-2b080f1d6066@kernel.dk>
Date:   Mon, 8 Feb 2021 19:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209001445.GP4626@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 5:14 PM, Dave Chinner wrote:
> On Mon, Feb 08, 2021 at 04:37:26PM -0700, Jens Axboe wrote:
>> On 2/8/21 4:28 PM, Dave Chinner wrote:
>>> On Mon, Feb 08, 2021 at 03:18:26PM -0700, Jens Axboe wrote:
>>>> Hi,
>>>>
>>>> Ran into an issue with IOCB_NOWAIT and O_DIRECT, which causes a rather
>>>> serious performance issue. If IOCB_NOWAIT is set, the generic/iomap
>>>> iterators check for page cache presence in the given range, and return
>>>> -EAGAIN if any is there. This is rather simplistic and looks like
>>>> something that was never really finished. For !IOCB_NOWAIT, we simply
>>>> call filemap_write_and_wait_range() to issue (if any) and wait on the
>>>> range. The fact that we have page cache entries for this range does
>>>> not mean that we cannot safely do O_DIRECT IO to/from it.
>>>>
>>>> This series adds filemap_range_needs_writeback(), which checks if
>>>> we have pages in the range that do require us to call
>>>> filemap_write_and_wait_range(). If we don't, then we can proceed just
>>>> fine with IOCB_NOWAIT.
>>>
>>> Not exactly. If it is a write we are doing, we _must_ invalidate
>>> the page cache pages over the range of the DIO write to maintain
>>> some level of cache coherency between the DIO write and the page
>>> cache contents. i.e. the DIO write makes the page cache contents
>>> stale, so the page cache has to be invalidated before the DIO write
>>> is started, and again when it completes to toss away racing updates
>>> (mmap) while the DIO write was in flight...
>>>
>>> Page invalidation can block (page locks, waits on writeback, taking
>>> the mmap_sem to zap page tables, etc), and it can also fail because
>>> pages are dirty (e.g. writeback+invalidation racing with mmap).
>>>
>>> And if it fails because dirty pages then we fall back to buffered
>>> IO, which serialises readers and writes and will block.
>>
>> Right, not disagreeing with any of that.
>>
>>>> The problem manifested itself in a production environment, where someone
>>>> is doing O_DIRECT on a raw block device. Due to other circumstances,
>>>> blkid was triggered on this device periodically, and blkid very helpfully
>>>> does a number of page cache reads on the device. Now the mapping has
>>>> page cache entries, and performance falls to pieces because we can no
>>>> longer reliably do IOCB_NOWAIT O_DIRECT.
>>>
>>> If it was a DIO write, then the pages would have been invalidated
>>> on the first write and the second write would issued with NOWAIT
>>> just fine.
>>>
>>> So the problem sounds to me like DIO reads from the block device are
>>> not invalidating the page cache over the read range, so they persist
>>> and prevent IOCB_NOWAIT IO from being submitted.
>>
>> That is exactly the case I ran into indeed.
>>
>>> Historically speaking, this is why XFS always used to invalidate the
>>> page cache for DIO - it didn't want to leave cached clean pages that
>>> would prevent future DIOs from being issued concurrently because
>>> coherency with the page cache caused performance issues. We
>>> optimised away this invalidation because the data in the page cache
>>> is still valid after a flush+DIO read, but it sounds to me like
>>> there are still corner cases where "always invalidate cached pages"
>>> is the right thing for DIO to be doing....
>>>
>>> Not sure what the best way to go here it - the patch isn't correct
>>> for NOWAIT DIO writes, but it looks necessary for reads. And I'm not
>>> sure that we want to go back to "invalidate everything all the time"
>>> either....
>>
>> We still do the invalidation for writes with the patch for writes,
>> nothing has changed there. We just skip the
>> filemap_write_and_wait_range() if there's nothing to write. And if
>> there's nothing to write, _hopefully_ the invalidation should go
>> smoothly unless someone dirtied/locked/put-under-writeback the page
>> since we did the check. But that's always going to be racy, and there's
>> not a whole lot we can do about that.
> 
> Sure, but if someone has actually mapped the range and is accessing
> it, then PTEs will need zapping and mmap_sem needs to be taken in
> write mode. If there's continual racing access, you've now got the
> mmap_sem regularly being taken exclusively in the IOCB_NOWAIT path
> and that means it will get serialised against other threads in the
> task doing page faults and other mm context operations.  The "needs
> writeback" check you've added does nothing to alleviate this
> potential blocking point for the write path.
> 
> That's my point - you're exposing obvious new blocking points for
> IOCB_NOWAIT DIO writes, not removing them. It may not happen very
> often, but the whack-a-mole game you are playing with IOCB_NOWAIT is
> "we found an even rarer blocking condition that it is critical to
> our application". While this patch whacks this specific mole in the
> read path, it also exposes the write path to another rare blocking
> condition that will eventually end up being the mole that needs to
> be whacked...
> 
> Perhaps the needs-writeback optimisation should only be applied to
> the DIO read path?

Sure, we can do that as a first version, and then tackle the remainder
of the write side as a separate thing as we need to handle invalidate
inode pages separately too.

I'll send out a v2 with just the read side.

-- 
Jens Axboe

