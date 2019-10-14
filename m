Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170C6D6A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbfJNUJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 16:09:51 -0400
Received: from sandeen.net ([63.231.237.45]:53090 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731587AbfJNUJu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:09:50 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 1C6EE7907;
        Mon, 14 Oct 2019 15:09:14 -0500 (CDT)
Subject: Re: [PATCH] xfs: introduce "metasync" api to sync metadata to fsblock
To:     Jan Kara <jack@suse.cz>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>, Jan Kara <jack@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
References: <1570977420-3944-1-git-send-email-kernelfans@gmail.com>
 <20191013163417.GQ13108@magnolia> <20191014083315.GA10091@mypc>
 <20191014094311.GD5939@quack2.suse.cz>
 <d3ffa114-8b73-90dc-8ba6-3f44f47135d7@sandeen.net>
 <20191014200303.GF5939@quack2.suse.cz>
From:   Eric Sandeen <sandeen@sandeen.net>
Message-ID: <5796090e-6206-1bd7-174e-58798c9af052@sandeen.net>
Date:   Mon, 14 Oct 2019 15:09:48 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191014200303.GF5939@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 10/14/19 3:03 PM, Jan Kara wrote:
> On Mon 14-10-19 08:23:39, Eric Sandeen wrote:
>> On 10/14/19 4:43 AM, Jan Kara wrote:
>>> On Mon 14-10-19 16:33:15, Pingfan Liu wrote:
>>>> On Sun, Oct 13, 2019 at 09:34:17AM -0700, Darrick J. Wong wrote:
>>>>> On Sun, Oct 13, 2019 at 10:37:00PM +0800, Pingfan Liu wrote:
>>>>>> When using fadump (fireware assist dump) mode on powerpc, a mismatch
>>>>>> between grub xfs driver and kernel xfs driver has been obsevered.  Note:
>>>>>> fadump boots up in the following sequence: fireware -> grub reads kernel
>>>>>> and initramfs -> kernel boots.
>>>>>>
>>>>>> The process to reproduce this mismatch:
>>>>>>     - On powerpc, boot kernel with fadump=on and edit /etc/kdump.conf.
>>>>>>     - Replacing "path /var/crash" with "path /var/crashnew", then, "kdumpctl
>>>>>>       restart" to rebuild the initramfs. Detail about the rebuilding looks
>>>>>>       like: mkdumprd /boot/initramfs-`uname -r`.img.tmp;
>>>>>>             mv /boot/initramfs-`uname -r`.img.tmp /boot/initramfs-`uname -r`.img
>>>>>>             sync
>>>>>>     - "echo c >/proc/sysrq-trigger".
>>>>>>
>>>>>> The result:
>>>>>> The dump image will not be saved under /var/crashnew/* as expected, but
>>>>>> still saved under /var/crash.
>>>>>>
>>>>>> The root cause:
>>>>>> As Eric pointed out that on xfs, 'sync' ensures the consistency by writing
>>>>>> back metadata to xlog, but not necessary to fsblock. This raises issue if
>>>>>> grub can not replay the xlog before accessing the xfs files. Since the
>>>>>> above dir entry of initramfs should be saved as inline data with xfs_inode,
>>>>>> so xfs_fs_sync_fs() does not guarantee it written to fsblock.
>>>>>>
>>>>>> umount can be used to write metadata fsblock, but the filesystem can not be
>>>>>> umounted if still in use.
>>>>>>
>>>>>> There are two ways to fix this mismatch, either grub or xfs. It may be
>>>>>> easier to do this in xfs side by introducing an interface to flush metadata
>>>>>> to fsblock explicitly.
>>>>>>
>>>>>> With this patch, metadata can be written to fsblock by:
>>>>>>     # update AIL
>>>>>>     sync
>>>>>>     # new introduced interface to flush metadata to fsblock
>>>>>>     mount -o remount,metasync mountpoint
>>>>>
>>>>> I think this ought to be an ioctl or some sort of generic call since the
>>>>> jbd2 filesystems (ext3, ext4, ocfs2) suffer from the same "$BOOTLOADER
>>>>> is too dumb to recover logs but still wants to write to the fs"
>>>>> checkpointing problem.
>>>> Yes, a syscall sounds more reasonable.
>>>>>
>>>>> (Or maybe we should just put all that stuff in a vfat filesystem, I
>>>>> don't know...)
>>>> I think it is unavoidable to involve in each fs' implementation. What
>>>> about introducing an interface sync_to_fsblock(struct super_block *sb) in
>>>> the struct super_operations, then let each fs manage its own case?
>>>
>>> Well, we already have a way to achieve what you need: fsfreeze.
>>> Traditionally, that is guaranteed to put fs into a "clean" state very much
>>> equivalent to the fs being unmounted and that seems to be what the
>>> bootloader wants so that it can access the filesystem without worrying
>>> about some recovery details. So do you see any problem with replacing
>>> 'sync' in your example above with 'fsfreeze /boot && fsfreeze -u /boot'?
>>>
>>> 								Honza
>>
>> The problem with fsfreeze is that if the device you want to quiesce is, say,
>> the root fs, freeze isn't really a good option.
> 
> I agree you need to be really careful not to deadlock against yourself in
> that case. But this particular use actually has a chance to work.
> 
>> But the other thing I want to highlight about this approach is that it does not
>> solve the root problem: something is trying to read the block device without
>> first replaying the log.
>>
>> A call such as the proposal here is only going to leave consistent metadata at
>> the time the call returns; at any time after that, all guarantees are off again,
>> so the problem hasn't been solved.
> 
> Oh, absolutely agreed. I was also thinking about this before sending my
> reply. Once you unfreeze, the log can start filling with changes and
> there's no guarantee that e.g. inode does not move as part of these
> changes. But to be fair, replaying the log isn't easy either, even more so
> from a bootloader. You cannot write the changes from the log back into the
> filesystem as e.g. in case of suspend-to-disk the resumed kernel gets
> surprised and corrupts the fs under its hands (been there, tried that). So
> you must keep changes only in memory and that's not really easy in the
> constrained bootloader environment.
> 
> So I guess we are left with hacks that kind of mostly work and fsfreeze is
> one of those. If you don't mess with the files after fsfreeze, you're
> likely to find what you need even without replaying the log.

We're in agreement here.  ;)  I only worry about implementing things like this
which sound like guarantees, but aren't, and end up encouraging bad behavior
or promoting misconceptions.

More and more, I think we should reconsider Darrick's "bootfs" (ext2 by another
name, but with extra-sync-iness) proposal...

-Eric

> 								Honza
> 
