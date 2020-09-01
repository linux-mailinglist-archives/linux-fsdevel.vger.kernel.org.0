Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547DC25A157
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 00:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIAWTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 18:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIAWTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:19:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4A2C061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 15:19:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u3so2572977qkd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TBrdoW89i+KAgJ5WyTFRTW2Y7YJ+13FQgyn/rXtY9s0=;
        b=Y3h0hRV+H9varxuX7CDluVNGmbOW8yrIimoOLmXTz+uY2MpU9VDOmKRmWOEwF2qu75
         a6XmK5Xxg4adshVoRwwMQbBJMjj1ldoO97O+tO33idk1NCqbI3Eo5SmCPyf7cPA78dtr
         pG0ddW+mt0wTIuzDLIvxUX/AlXdXuEAWrH8I1ekp9JoFXtREwAJXR5gSs2DBRtEr+NZm
         UAeI+buFAMA5Agu9K03DkHW4Hsk5f/IjXE1BBzJY4FeBDOxUbulPUaj4mmwXT734fYlP
         GD/Q7QfdxtCIuN7Q0qJCyqIpdWczCszflOPW2D6T9RjbzT5SuWwpctWys1XwjBlXMCTO
         alPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TBrdoW89i+KAgJ5WyTFRTW2Y7YJ+13FQgyn/rXtY9s0=;
        b=EIx9r8FfAH2iv5E/1iiN1ZKRmMM3b15iyKjb+k3xDRIW+EnC8LIINwXhLF5kjcXAag
         vwnk++bLLeezsxFFC8x2RytfW4p3qsEj43eeyw52pwdqz6HcNbF+f0TtqF4DgmV76NOU
         Brw2Vf5yYuvyp2q/d4jDMuvPnyz4oCoBf9Cg8Mq2LST9MY17L2lorcWDySBHTZaCvyqz
         G5DXMvK5opAx7o7Ms0eLZWBsPNl+WzN8ADO/22wARDEKxclsV5nzcQNgVZo/foID0m8h
         ozPDcE4QK/JU+H7pj6YOM302wVpQj1QStQVHeFhn+3VvnObiy0qJ/5fHYsZ4J4dubbf6
         aHgQ==
X-Gm-Message-State: AOAM532NrrO5/klkCvrGiIOXt23JJIh2Q8EYdMY/zQQVUevHPAyN0Suh
        JQgRv8goEVD21xRaXGFYyPGll2tZwKadRsJ+dio=
X-Google-Smtp-Source: ABdhPJx/3uhCFPHTi4t3s9OVcMDbVLCES8T9WlSODxhQl1xYFBAGSITKAGPjnzetNEzCCN5/FbRbNg==
X-Received: by 2002:ae9:c015:: with SMTP id u21mr4370206qkk.268.1598998759689;
        Tue, 01 Sep 2020 15:19:19 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l1sm3081223qtp.96.2020.09.01.15.19.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 15:19:18 -0700 (PDT)
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
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
Date:   Tue, 1 Sep 2020 18:19:17 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901214613.GH12096@dread.disaster.area>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 5:46 PM, Dave Chinner wrote:
> On Tue, Sep 01, 2020 at 11:11:58AM -0400, Josef Bacik wrote:
>> On 9/1/20 9:06 AM, Johannes Thumshirn wrote:
>>> This happens because iomap_dio_complete() calls into generic_write_sync()
>>> if we have the data-sync flag set. But as we're still under the
>>> inode_lock() from btrfs_file_write_iter() we will deadlock once
>>> btrfs_sync_file() tries to acquire the inode_lock().
>>>
>>> Calling into generic_write_sync() is not needed as __btrfs_direct_write()
>>> already takes care of persisting the data on disk. We can temporarily drop
>>> the IOCB_DSYNC flag before calling into __btrfs_direct_write() so the
>>> iomap code won't try to call into the sync routines as well.
>>>
>>> References: https://github.com/btrfs/fstests/issues/12
>>> Fixes: da4d7c1b4c45 ("btrfs: switch to iomap for direct IO")
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>    fs/btrfs/file.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
>>> index b62679382799..c75c0f2a5f72 100644
>>> --- a/fs/btrfs/file.c
>>> +++ b/fs/btrfs/file.c
>>> @@ -2023,6 +2023,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>>>    		atomic_inc(&BTRFS_I(inode)->sync_writers);
>>>    	if (iocb->ki_flags & IOCB_DIRECT) {
>>> +		iocb->ki_flags &= ~IOCB_DSYNC;
>>>    		num_written = __btrfs_direct_write(iocb, from);
>>>    	} else {
>>>    		num_written = btrfs_buffered_write(iocb, from);
>>> @@ -2046,8 +2047,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
>>>    	if (num_written > 0)
>>>    		num_written = generic_write_sync(iocb, num_written);
>>> -	if (sync)
>>> +	if (sync) {
>>> +		iocb->ki_flags |= IOCB_DSYNC;
>>>    		atomic_dec(&BTRFS_I(inode)->sync_writers);
>>> +	}
>>>    out:
>>>    	current->backing_dev_info = NULL;
>>>    	return num_written ? num_written : err;
>>>
>>
>> Christoph, I feel like this is broken.
> 
> No, it isn't broken, it's just a -different design- to the old
> direct IO path. It was done this way done by design because the old
> way of requiring separate paths for calling generic_write_sync() for
> sync and AIO is ....  nasty, and doesn't allow for optimisation of
> IO completion functionality that may be wholly dependent on
> submission time inode state.
> 
> e.g. moving the O_DSYNC completion out of the context of the
> IOMAP_F_DIRTY submission context means we can't reliably do FUA
> writes to avoid calls to generic_write_sync() completely.
> Compromising that functionality is going to cause major performance
> regressions for high performance enterprise databases using O_DSYNC
> AIO+DIO...
> 
>> Xfs and ext4 get away with this for
>> different reasons,
> 
> No, they "don't get away with it", this is how it was designed to
> work.
> 

Didn't mean this as a slight, just saying this is why it works fine for you guys 
and doesn't work for us.  Because when we first were looking at this we couldn't 
understand how it didn't blow up for you and it did blow up for us.  I'm 
providing context, not saying you guys are broken or doing it wrong.

>> ext4 doesn't take the inode_lock() at all in fsync, and
>> xfs takes the ILOCK instead of the IOLOCK, so it's fine.  However btrfs uses
>> inode_lock() in ->fsync (not for the IO, just for the logging part).  A long
>> time ago I specifically pushed the inode locking down into ->fsync()
>> handlers to give us this sort of control.
>>
>> I'm not 100% on the iomap stuff, but the fix seems like we need to move the
>> generic_write_sync() out of iomap_dio_complete() completely, and the callers
>> do their own thing, much like the normal generic_file_write_iter() does.
> 
> That effectively breaks O_DSYNC AIO and requires us to reintroduce
> all the nasty code that the old direct IO path required both the
> infrastructure and the filesystems to handle it. That's really not
> acceptible solution to an internal btrfs locking issue...
> 
>> And then I'd like to add a WARN_ON(lockdep_is_held()) in vfs_fsync_range()
>> so we can avoid this sort of thing in the future.  What do you think?
> 
> That's not going to work, either. There are filesystems that call
> vfs_fsync_range() directly from under the inode_lock(). For example,
> the fallocate() path in gfs2. And it's called under the ext4 and XFS
> MMAPLOCK from the dax page fault path, which is the page fault
> equivalent of the inode_lock(). IOWs, if you know that you aren't
> going to take inode locks in your ->fsync() method, there's nothing
> that says you cannot call vfs_fsync_range() while holding those
> inode locks.

I converted ->fsync to not have the i_mutex taken before calling _years_ ago

02c24a82187d5a628c68edfe71ae60dc135cd178

and part of what I did was update the locking document around it.  So in my 
head, the locking rules were "No VFS locks held on entry".  Obviously that's not 
true today, but if we're going to change the assumptions around these things 
then we really ought to

1) Make sure they're true for _all_ file systems.
2) Document it when it's changed.

Ok so iomap was designed assuming it was safe to take the inode_lock() before 
calling ->fsync.  That's fine, but this is kind of a bad way to find out.  We 
really shouldn't have generic helper's that have different generic locking rules 
based on which file system uses them.  Because then we end up with situations 
like this, where suddenly we're having to come up with some weird solution 
because the generic thing only works for a subset of file systems.  Thanks,

Josef
