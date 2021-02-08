Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7993143FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 00:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbhBHXiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 18:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhBHXiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 18:38:10 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB714C061794
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 15:37:29 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id u143so4509099pfc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 15:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OKPzETQJHrkkCZIrhT+XO3fklkwfhO78S/i/FCCQB9k=;
        b=HSjdob+Gi/C+IbjVK2Qoprw+JoTGEy0r7kubIu4xA0/VE8RAcdvWfzwyKrBJCMaz+0
         zifqLQLGDXYuCqz2zNYS3zVxizlerRXLHBEFIvv/eFbPZIpzSipZPLO+J1uZRN2BmKRa
         k6An0R4DU6BitqCPczmhidPVzi6jzVHCe+nff0S9FSbFo0EganepFJ9WpyWRpnDQKKeg
         4CpfbtYGZSL577R39Sx+T8b1BFs/YgB/E3hYNwKJdwx98GSx4d5aMkTvPD0wrv4FW4v5
         SIyn4xgU2GnmLJ5zxBszukUdtnXvk0RApxesa4wXUkzGiqXAz31OsM0wmSpzA2Eheri+
         So5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OKPzETQJHrkkCZIrhT+XO3fklkwfhO78S/i/FCCQB9k=;
        b=q6XC0jWJJ9MIV+NQeLglLT2YrK7QcQp8KuU5cDke6U7F3nsIEjXfPbj3TBQNjVBNoT
         xDEz0j4ldSw07TmkaEnG++ChdI2TkCRnVkSzJ33ouq5AgSEnwNKz+3Ggg8R3t8mlQ4Sx
         aFd43H5U3b1KYkSZ7bNPUImqwFsC7tbfOXQ8tVDOlp1lnMYatmwxVnkaWCKPerO97yDX
         1EgtV/ekorOoplMoJvyRn6HKcgjfj45MappbysCARq0Ug5Hv4sW7DG29doI8GAwnjTcM
         R9kRwsi+w4/RDaDtZLaLKHXqpRWPPyN09YcIKlm6iyb2vio9nhVomcPWNunQcaXR/ec+
         3t8A==
X-Gm-Message-State: AOAM533dJMHVjIc2oCWi1r4C7/PiScuKZOmvMF/2VBxs6Igk9i9Rp8Y7
        3fmc5yM6MFVZb+1Y8g8CQqBMTw==
X-Google-Smtp-Source: ABdhPJzoP3Duav1RWK3YV2IG0V8Ut2qW58dDCOEa0IRcKy/NjicHaTUR8eXZo6GH4v1YjxdFzy4XdA==
X-Received: by 2002:a62:64c9:0:b029:1b9:6b48:7901 with SMTP id y192-20020a6264c90000b02901b96b487901mr20548105pfb.0.1612827448994;
        Mon, 08 Feb 2021 15:37:28 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v19sm353370pjg.50.2021.02.08.15.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Feb 2021 15:37:28 -0800 (PST)
Subject: Re: [PATCHSET 0/3] Improve IOCB_NOWAIT O_DIRECT
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hch@infradead.org, akpm@linux-foundation.org
References: <20210208221829.17247-1-axboe@kernel.dk>
 <20210208232846.GO4626@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <44fec531-b2fd-f569-538a-64449a5c371b@kernel.dk>
Date:   Mon, 8 Feb 2021 16:37:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208232846.GO4626@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/8/21 4:28 PM, Dave Chinner wrote:
> On Mon, Feb 08, 2021 at 03:18:26PM -0700, Jens Axboe wrote:
>> Hi,
>>
>> Ran into an issue with IOCB_NOWAIT and O_DIRECT, which causes a rather
>> serious performance issue. If IOCB_NOWAIT is set, the generic/iomap
>> iterators check for page cache presence in the given range, and return
>> -EAGAIN if any is there. This is rather simplistic and looks like
>> something that was never really finished. For !IOCB_NOWAIT, we simply
>> call filemap_write_and_wait_range() to issue (if any) and wait on the
>> range. The fact that we have page cache entries for this range does
>> not mean that we cannot safely do O_DIRECT IO to/from it.
>>
>> This series adds filemap_range_needs_writeback(), which checks if
>> we have pages in the range that do require us to call
>> filemap_write_and_wait_range(). If we don't, then we can proceed just
>> fine with IOCB_NOWAIT.
> 
> Not exactly. If it is a write we are doing, we _must_ invalidate
> the page cache pages over the range of the DIO write to maintain
> some level of cache coherency between the DIO write and the page
> cache contents. i.e. the DIO write makes the page cache contents
> stale, so the page cache has to be invalidated before the DIO write
> is started, and again when it completes to toss away racing updates
> (mmap) while the DIO write was in flight...
> 
> Page invalidation can block (page locks, waits on writeback, taking
> the mmap_sem to zap page tables, etc), and it can also fail because
> pages are dirty (e.g. writeback+invalidation racing with mmap).
> 
> And if it fails because dirty pages then we fall back to buffered
> IO, which serialises readers and writes and will block.

Right, not disagreeing with any of that.

>> The problem manifested itself in a production environment, where someone
>> is doing O_DIRECT on a raw block device. Due to other circumstances,
>> blkid was triggered on this device periodically, and blkid very helpfully
>> does a number of page cache reads on the device. Now the mapping has
>> page cache entries, and performance falls to pieces because we can no
>> longer reliably do IOCB_NOWAIT O_DIRECT.
> 
> If it was a DIO write, then the pages would have been invalidated
> on the first write and the second write would issued with NOWAIT
> just fine.
> 
> So the problem sounds to me like DIO reads from the block device are
> not invalidating the page cache over the read range, so they persist
> and prevent IOCB_NOWAIT IO from being submitted.

That is exactly the case I ran into indeed.

> Historically speaking, this is why XFS always used to invalidate the
> page cache for DIO - it didn't want to leave cached clean pages that
> would prevent future DIOs from being issued concurrently because
> coherency with the page cache caused performance issues. We
> optimised away this invalidation because the data in the page cache
> is still valid after a flush+DIO read, but it sounds to me like
> there are still corner cases where "always invalidate cached pages"
> is the right thing for DIO to be doing....
> 
> Not sure what the best way to go here it - the patch isn't correct
> for NOWAIT DIO writes, but it looks necessary for reads. And I'm not
> sure that we want to go back to "invalidate everything all the time"
> either....

We still do the invalidation for writes with the patch for writes,
nothing has changed there. We just skip the
filemap_write_and_wait_range() if there's nothing to write. And if
there's nothing to write, _hopefully_ the invalidation should go
smoothly unless someone dirtied/locked/put-under-writeback the page
since we did the check. But that's always going to be racy, and there's
not a whole lot we can do about that.

-- 
Jens Axboe

