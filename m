Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE87259DBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgIARzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgIARzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:55:45 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1D9C061245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2020 10:55:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id o5so1796005qke.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2020 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DBIFQBgTgJDITRRFjN3apQN+jUzUfVbMcOLUuYRAHwc=;
        b=okLH2fjNUvPUGzwR0n4NYZ+uNw3AppjUZRvLL0GelvaZd4TgZ8e13SLO4ZWGLpt98h
         vjBW59o9yKGRoT9VpQ53l77+9weIcUhUYTc+1gJDiksZeLwn5PYg/suL3xDjNkt0xCD1
         N5dr1VmNXOl44CeSiHb+lvJjCJ1YxJwVe2FOAcoa6jd7pxEWmW+JP+dbTIt6/31tStdp
         L7hPyZZZFs+x3GAcYWLzIWfLkKWgea+TnU1dzMXQTF+mf3hdRlJWBz3dp0JcxdRf448J
         PQb3K9TOcr+it2nOiyDi3JUQKWDmUsI+GwS1ksabuAs9YV3Jl/KkZeeUNZ0/NFVd+nR/
         CXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DBIFQBgTgJDITRRFjN3apQN+jUzUfVbMcOLUuYRAHwc=;
        b=ALREqCBq00rQOjewwY59Irg5TblfHxqrybPBEWT6CFXLEQgrk5x2ozKb4jIXRwIMnb
         xb1vn4lt4Ho7C+CTZqPpWjDn3tqDQFrbYl5PqPnvebidsNoJ65EaDd4esKoLpP/iRS6M
         IdieQl12BOuUxkTo5mNWNEC/aPmhSOe165Leh3U6d5h38kdBmII1+1S/prgwVFPOohEO
         wOeVeKBnF7aAjDFqPIjh7YG6xfRtlQMXfW9y/e063TEBMcmApNTq/Vhk7+/RNZSPkPVk
         6PGV4nzcjtu9uy/K7xBOA7x8IYmq79ldr53uM6Bw0yzVakZ6Oy0E6frwKG2xEkJTWjLl
         vvYQ==
X-Gm-Message-State: AOAM533rev2yJGPRdYqyCIrb35VPuDd3ilPdd20ca2lGs4RwpQdE3v2b
        V2g/041PwjwfIRxtnel/ADd2L0BkkxgRtjQe
X-Google-Smtp-Source: ABdhPJzi97n6kbZa1XvmnHxqY5KosfMqifclQ7UQoomxea/OqyejlcgtYKPBQdma4VqGZzm57vIBfg==
X-Received: by 2002:a37:8344:: with SMTP id f65mr3054896qkd.228.1598982942553;
        Tue, 01 Sep 2020 10:55:42 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r5sm2234880qtd.87.2020.09.01.10.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:55:41 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901174538.GA6084@magnolia>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <2cc86088-fbec-353b-540b-b5525d5a5b67@toxicpanda.com>
Date:   Tue, 1 Sep 2020 13:55:40 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901174538.GA6084@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/1/20 1:45 PM, Darrick J. Wong wrote:
> On Tue, Sep 01, 2020 at 11:11:58AM -0400, Josef Bacik wrote:
>> On 9/1/20 9:06 AM, Johannes Thumshirn wrote:
>>> Fstests generic/113 exposes a deadlock introduced by the switch to iomap
>>> for direct I/O.
>>>
>>> [ 18.291293]
>>> [ 18.291532] ============================================
>>> [ 18.292115] WARNING: possible recursive locking detected
>>> [ 18.292723] 5.9.0-rc2+ #746 Not tainted
>>> [ 18.293145] --------------------------------------------
>>> [ 18.293718] aio-stress/922 is trying to acquire lock:
>>> [ 18.294274] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_sync_file+0xf7/0x560 [btrfs]
>>> [ 18.295450]
>>> [ 18.295450] but task is already holding lock:
>>> [ 18.296086] ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
>>> [ 18.297249]
>>> [ 18.297249] other info that might help us debug this:
>>> [ 18.297960] Possible unsafe locking scenario:
>>> [ 18.297960]
>>> [ 18.298605] CPU0
>>> [ 18.298880] ----
>>> [ 18.299151] lock(&sb->s_type->i_mutex_key#11);
>>> [ 18.299653] lock(&sb->s_type->i_mutex_key#11);
>>> [ 18.300156]
>>> [ 18.300156] *** DEADLOCK ***
>>> [ 18.300156]
>>> [ 18.300802] May be due to missing lock nesting notation
>>> [ 18.300802]
>>> [ 18.301542] 2 locks held by aio-stress/922:
>>> [ 18.302000] #0: ffff888217412010 (&sb->s_type->i_mutex_key#11){++++}-{3:3}, at: btrfs_file_write_iter+0x6e/0x630 [btrfs]
>>> [ 18.303194] #1: ffff888217411ea0 (&ei->dio_sem){++++}-{3:3}, at: btrfs_direct_IO+0x113/0x160 [btrfs]
>>> [ 18.304223]
>>> [ 18.304223] stack backtrace:
>>> [ 18.304695] CPU: 0 PID: 922 Comm: aio-stress Not tainted 5.9.0-rc2+ #746
>>> [ 18.305383] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
>>> [ 18.306532] Call Trace:
>>> [ 18.306796] dump_stack+0x78/0xa0
>>> [ 18.307145] __lock_acquire.cold+0x121/0x29f
>>> [ 18.307613] ? btrfs_dio_iomap_end+0x65/0x130 [btrfs]
>>> [ 18.308140] lock_acquire+0x93/0x3b0
>>> [ 18.308544] ? btrfs_sync_file+0xf7/0x560 [btrfs]
>>> [ 18.309036] down_write+0x33/0x70
>>> [ 18.309402] ? btrfs_sync_file+0xf7/0x560 [btrfs]
>>> [ 18.309912] btrfs_sync_file+0xf7/0x560 [btrfs]
>>> [ 18.310384] iomap_dio_complete+0x10d/0x120
>>> [ 18.310824] iomap_dio_rw+0x3c8/0x520
>>> [ 18.311225] btrfs_direct_IO+0xd3/0x160 [btrfs]
>>> [ 18.311727] btrfs_file_write_iter+0x1fe/0x630 [btrfs]
>>> [ 18.312264] ? find_held_lock+0x2b/0x80
>>> [ 18.312662] aio_write+0xcd/0x180
>>> [ 18.313011] ? __might_fault+0x31/0x80
>>> [ 18.313408] ? find_held_lock+0x2b/0x80
>>> [ 18.313817] ? __might_fault+0x31/0x80
>>> [ 18.314217] io_submit_one+0x4e1/0xb30
>>> [ 18.314606] ? find_held_lock+0x2b/0x80
>>> [ 18.315010] __x64_sys_io_submit+0x71/0x220
>>> [ 18.315449] do_syscall_64+0x33/0x40
>>> [ 18.315829] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>> [ 18.316363] RIP: 0033:0x7f5940881f79
>>> [ 18.316740] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e7 4e 0c 00 f7 d8 64 89 01 48
>>> [ 18.318651] RSP: 002b:00007f5934f51d88 EFLAGS: 00000246 ORIG_RAX: 00000000000000d1
>>> [ 18.319428] RAX: ffffffffffffffda RBX: 00007f5934f52680 RCX: 00007f5940881f79
>>> [ 18.320168] RDX: 0000000000b56030 RSI: 0000000000000008 RDI: 00007f593171f000
>>> [ 18.320895] RBP: 00007f593171f000 R08: 0000000000000000 R09: 0000000000b56030
>>> [ 18.321630] R10: 00007fffd599e080 R11: 0000000000000246 R12: 0000000000000008
>>> [ 18.322369] R13: 0000000000000000 R14: 0000000000b56030 R15: 0000000000b56070
>>>
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
>> Christoph, I feel like this is broken.  Xfs and ext4 get away with this for
>> different reasons, ext4 doesn't take the inode_lock() at all in fsync, and
>> xfs takes the ILOCK instead of the IOLOCK, so it's fine.  However btrfs uses
>> inode_lock() in ->fsync (not for the IO, just for the logging part).  A long
>> time ago I specifically pushed the inode locking down into ->fsync()
>> handlers to give us this sort of control.
>>
>> I'm not 100% on the iomap stuff, but the fix seems like we need to move the
>> generic_write_sync() out of iomap_dio_complete() completely, and the callers
>> do their own thing, much like the normal generic_file_write_iter() does.
>> And then I'd like to add a WARN_ON(lockdep_is_held()) in vfs_fsync_range()
>> so we can avoid this sort of thing in the future.  What do you think?
> 
> Hmm, I was under the impression that the direct write completion in
> either path (iomap or classic) could call generic_write_sync?  How did
> this work in btrfs before the iomap conversion?

Looking at the code, we have this

		if (iocb->ki_flags & IOCB_DSYNC)
			retval = dio_set_defer_completion(dio);

it only happens on async, and then the generic_write_sync() happens outside of 
the context of the submitting task, and since we're async we wouldn't be waiting 
on the IO inside of the area where we're holding the inode_lock().  Thanks,

Josef

