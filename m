Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E42F25A23B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 02:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgIBAWQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 20:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBAWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:22:14 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A62C061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 17:22:13 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so2402927qtv.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 17:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tjHatJ2t+8EOHnqaelvJhyQI7vgBQp/WwFXKm3c2+Bs=;
        b=O3nWA22IhmjYx4KXBkeQs/SCBoGRkUha7/Eb6Yj1hSu/AeRfVk1ylZO6kmGV4YrJl4
         JxcXW5Nuw1zbyuPFQwFz56MT+OVLdW8K+42Tc7d9vwsU4HOiwtS42TZWRxxHasn79otu
         C8kLDf0nRk568VO6XVcAOGczXp9IxzIAujulpHqXZxMTlP1hNhQL5uAmlyO0touq4Jgh
         c1YaTNSHd/lEfa/47Zf9PHyUbFSX85Y9Vkz5YcvpDipVhK62UsDgbfAFbQGtZt5/Nu3Y
         kTRXAQh6FHM/dIbNPid3g7soqdG4D8Vx5/GZnvHfS13ZUg3o+P94RFWKMbEqV/EhBr5A
         Mrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tjHatJ2t+8EOHnqaelvJhyQI7vgBQp/WwFXKm3c2+Bs=;
        b=gHOQAyZ1Um3sA3nR/1Gd0OsGqrAMupsYknffLJ5KOeJ+l5KwUrZuuVP5qVy/ZlNLD3
         BJxHWPYFH22cqjS7ng5v0eKsGyuPrk7mYhEtD+SEriWtZmG4gQbVTkkF5OX7hTiOF1Kh
         dstLqP2DaKy/qkLRygKzjnc0UzuwhRGvze/G+cMj5VwebcZLwR4MKCcsDgqAy++K54hI
         a9WyUc3fYxs7F9O8mzgO+L5H2MmBKI8XAE+cj9Dh24o8XWohTVpwvmAdo8ZUjGDsDJpp
         wKBRsfkPPVDRUBsVhGtEbaEtjomEN4N0YdOKDEdPNKx+KYGX55G72XN65d++2Ca+d7b7
         cpGw==
X-Gm-Message-State: AOAM533bARGW+uy1j2uXCZ4f6WCp5eD4JURdiOJ2GFvHOXZTu9alkIxt
        dntQ9TsU8JdfkF12LOzGnbqG1afHlOKoa9ioKys=
X-Google-Smtp-Source: ABdhPJxJFodklFhG/WMpQfOATSTfxl49l9vQqmyBeKdBToqyZRWELdEGXaT/ZbpBLiKFNHWdnLBI/w==
X-Received: by 2002:ac8:8eb:: with SMTP id y40mr382691qth.1.1599006132202;
        Tue, 01 Sep 2020 17:22:12 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g15sm3257979qtx.57.2020.09.01.17.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 17:22:11 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     Dave Chinner <david@fromorbit.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d2ba3cc5-5648-2e4b-6ae4-2515b1365ce2@toxicpanda.com>
Date:   Tue, 1 Sep 2020 20:22:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901235830.GI12096@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 7:58 PM, Dave Chinner wrote:
> On Tue, Sep 01, 2020 at 06:19:17PM -0400, Josef Bacik wrote:
>> On 9/1/20 5:46 PM, Dave Chinner wrote:
>>> On Tue, Sep 01, 2020 at 11:11:58AM -0400, Josef Bacik wrote:
>>>> On 9/1/20 9:06 AM, Johannes Thumshirn wrote:
>>>>> This happens because iomap_dio_complete() calls into generic_write_sync()
>>>>> if we have the data-sync flag set. But as we're still under the
>>>>> inode_lock() from btrfs_file_write_iter() we will deadlock once
>>>>> btrfs_sync_file() tries to acquire the inode_lock().
>>>>>
>>>>> Calling into generic_write_sync() is not needed as __btrfs_direct_write()
>>>>> already takes care of persisting the data on disk. We can temporarily drop
>>>>> the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the
>>>>> iomap code won't try to call into the sync routines as well.
>>>>>
>>>>> References: https://github.com/btrfs/fstests/issues/12
>>>>> Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")
>>>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>>> ---
>>>>>     fs/btrfs/file.c | 5 ++++-
>>>>>     1 file changed, 4 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>>>> index b62679382799..c75c0f2a5f72 100644
>>>>> --- a/fs/btrfs/file.c
>>>>> +++ b/fs/btrfs/file.c
>>>>> @@ -2023,6 +2023,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>>>>>     		atomic_inc(&BTRFS_I(inode)->sync_writers);
>>>>>     	if (iocb->ki_flags & IOCB_DIRECT) {
>>>>> +		iocb->ki_flags &= ~IOCB_DSYNC;
>>>>>     		num_written = __btrfs_direct_write(iocb, from);
>>>>>     	} else {
>>>>>     		num_written = btrfs_buffered_write(iocb, from);
>>>>> @@ -2046,8 +2047,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>>>>>     	if (num_written > 0)
>>>>>     		num_written = generic_write_sync(iocb, num_written);
>>>>> -	if (sync)
>>>>> +	if (sync) {
>>>>> +		iocb->ki_flags |= IOCB_DSYNC;
>>>>>     		atomic_dec(&BTRFS_I(inode)->sync_writers);
>>>>> +	}
>>>>>     out:
>>>>>     	current->backing_dev_info = NULL;
>>>>>     	return num_written ? num_written : err;
>>>>>
>>>>
>>>> Christoph, I feel like this is broken.
>>>
>>> No, it isn't broken, it's just a -different design- to the old
>>> direct IO path. It was done this way done by design because the old
>>> way of requiring separate paths for calling generic_write_sync() for
>>> sync and AIO is ....  nasty, and doesn't allow for optimisation of
>>> IO completion functionality that may be wholly dependent on
>>> submission time inode state.
>>>
>>> e.g. moving the O_DSYNC completion out of the context of the
>>> IOMAP_F_DIRTY submission context means we can't reliably do FUA
>>> writes to avoid calls to generic_write_sync() completely.
>>> Compromising that functionality is going to cause major performance
>>> regressions for high performance enterprise databases using O_DSYNC
>>> AIO+DIO...
>>>
>>>> Xfs and ext4 get away with this for
>>>> different reasons,
>>>
>>> No, they "don't get away with it", this is how it was designed to
>>> work.
>>>
>>
>> Didn't mean this as a slight, just saying this is why it works fine for you
>> guys and doesn't work for us.  Because when we first were looking at this we
>> couldn't understand how it didn't blow up for you and it did blow up for us.
>> I'm providing context, not saying you guys are broken or doing it wrong.
>>
>>>> ext4 doesn't take the inode_lock() at all in fsync, and
>>>> xfs takes the ILOCK instead of the IOLOCK, so it's fine.  However btrfs uses
>>>> inode_lock() in ->fsync (not for the IO, just for the logging part).  A long
>>>> time ago I specifically pushed the inode locking down into ->fsync()
>>>> handlers to give us this sort of control.
>>>>
>>>> I'm not 100% on the iomap stuff, but the fix seems like we need to move the
>>>> generic_write_sync() out of iomap_dio_complete() completely, and the callers
>>>> do their own thing, much like the normal generic_file_write_iter() does.
>>>
>>> That effectively breaks O_DSYNC AIO and requires us to reintroduce
>>> all the nasty code that the old direct IO path required both the
>>> infrastructure and the filesystems to handle it. That's really not
>>> acceptible solution to an internal btrfs locking issue...
>>>
>>>> And then I'd like to add a WARN_ON(lockdep_is_held()) in vfs_fsync_range()
>>>> so we can avoid this sort of thing in the future.  What do you think?
>>>
>>> That's not going to work, either. There are filesystems that call
>>> vfs_fsync_range() directly from under the inode_lock(). For example,
>>> the fallocate() path in gfs2. And it's called under the ext4 and XFS
>>> MMAPLOCK from the dax page fault path, which is the page fault
>>> equivalent of the inode_lock(). IOWs, if you know that you aren't
>>> going to take inode locks in your ->fsync() method, there's nothing
>>> that says you cannot call vfs_fsync_range() while holding those
>>> inode locks.
>>
>> I converted ->fsync to not have the i_mutex taken before calling _years_ ago
>>
>> 02c24a82187d5a628c68edfe71ae60dc135cd178
>>
>> and part of what I did was update the locking document around it.  So in my
>> head, the locking rules were "No VFS locks held on entry".  Obviously that's
>> not true today, but if we're going to change the assumptions around these
>> things then we really ought to
>>
>> 1) Make sure they're true for _all_ file systems.
>> 2) Document it when it's changed.
>>
>> Ok so iomap was designed assuming it was safe to take the inode_lock()
>> before calling ->fsync.
> 
> No, I did not say that. Stop trying to put your words in my mouth,
> Josef.
> 

Why are you being combative?  I'm simply trying to work towards a 
reasonable solution and figure out how we keep this class of problems 
from happening again.  I literally do not care at all about the design 
decisions for iomap, you are an intelligent person and I assume good 
intent, I assume you did it for good reasons.  I'm simply trying to work 
out holes in my understanding, and work towards a solution we're all 
happy with.  I'm not trying to argue with you or throw mud, I'm simply 
trying to understand.

> The iomap design simply assumes that ->fsync can run without needing
> to hold the same locks as IO submission requires. iomap
> requires a ->fsync implementation that doesn't take the inode_lock()
> if the inode_lock() is used to serialise IO submission. i.e. iomap
> separates IO exclusion from -internal inode state serialisation-.
> 

This is only slightly different from what I was saying, and in reality 
is the same thing because we all currently use the inode_lock() for the 
submission side.  So while the assumption may be slightly different, the 
outcome is the same.

> This design assumption means DIO submission can safely -flush dirty
> data-, invalidate the page cache, sync the inode/journal to stable
> storage, etc all while holding the IO exclusion lock to ensure
> submission won't race with other metadata modification operations
> like truncate, holepunch, etc.
> 
> IOWs, iomap expects the inode_lock() to work as an -IO submission
> exclusion lock-, not as an inode _state protection_ lock. Yes, this
> means iomap has a different IO locking model to the original direct
> and bufferhead based buffered IO paths. However, these architectural
> changes are required to replace bufferhead based locking, implement
> the physical storage exclusion DAX requires, close mmap vs hole
> punch races, etc.
> 
> In practice, this means all the inode state in XFS (and ext4) are
> protected by internal inode locks rather than the inode_lock(). As
> such, they they do not require the inode_lock() to be able to write
> back dirty data or modify inode state or flush inode state to stable
> storage.
> 
> Put simply: converting a filesystem to use iomap is not a "change
> the filesystem interfacing code and it will work" modification.  We
> ask that filesystems are modified to conform to the iomap IO
> exclusion model; adding special cases for every potential
> locking and mapping quirk every different filesystem has is part of
> what turned the old direct IO code into an unmaintainable nightmare.
> 
>> That's fine, but this is kind of a bad way to find
>> out.  We really shouldn't have generic helper's that have different generic
>> locking rules based on which file system uses them.
> 
> We certainly can change the rules for new infrastructure. Indeed, we
> had to change the rules to support DAX.  The whole point of the
> iomap infrastructure was that it enabled us to use code that already
> worked for DAX (the XFS code) in multiple filesystems. And as people
> have realised that the DIO via iomap is much faster than the old DIO
> code and is a much more efficient way of doing large buffered IO,
> other filesystems have started to use it.
> 
> However....
> 
>> Because then we end up
>> with situations like this, where suddenly we're having to come up with some
>> weird solution because the generic thing only works for a subset of file
>> systems.  Thanks,
> 
> .... we've always said "you need to change the filesystem code to
> use iomap". This is simply a reflection on the fact that iomap has
> different rules and constraints to the old code and so it's not a
> direct plug in replacement. There are no short cuts here...
> 

That's fine, again I'm not saying you did anything wrong with the 
implementation.  I'm saying these requirements were not clear, and with 
no warning or annotations or documentation we simply find out by random 
chance while Johannes is running with a non-standard xfstests setup. 
Perhaps that's what the system working looks like, but honestly I would 
have rather found out at the point that I applied, built, and reviewed 
the code so we could have addressed it then.  Instead now we have to rip 
it out until we figure out what to do about it.  Thanks,

Josef
