Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3A1715CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 12:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbgB0LNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 06:13:19 -0500
Received: from relay.sw.ru ([185.231.240.75]:58372 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgB0LNT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:13:19 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7H66-0005H7-As; Thu, 27 Feb 2020 14:12:54 +0300
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <20200227073336.GJ10737@dread.disaster.area>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2e2ae13e-0757-0831-216d-b363b1727a0d@virtuozzo.com>
Date:   Thu, 27 Feb 2020 14:12:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227073336.GJ10737@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.02.2020 10:33, Dave Chinner wrote:
> On Wed, Feb 26, 2020 at 11:05:23PM +0300, Kirill Tkhai wrote:
>> On 26.02.2020 18:55, Christoph Hellwig wrote:
>>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>>> This adds a support of physical hint for fallocate2() syscall.
>>>> In case of @physical argument is set for ext4_fallocate(),
>>>> we try to allocate blocks only from [@phisical, @physical + len]
>>>> range, while other blocks are not used.
>>>
>>> Sorry, but this is a complete bullshit interface.  Userspace has
>>> absolutely no business even thinking of physical placement.  If you
>>> want to align allocations to physical block granularity boundaries
>>> that is the file systems job, not the applications job.
>>
>> Why? There are two contradictory actions that filesystem can't do at the same time:
>>
>> 1)place files on a distance from each other to minimize number of extents
>>   on possible future growth;
> 
> Speculative EOF preallocation at delayed allocation reservation time
> provides this.
> 
>> 2)place small files in the same big block of block device.
> 
> Delayed allocation during writeback packs files smaller than the
> stripe unit of the filesystem tightly.
> 
> So, yes, we do both of these things at the same time in XFS, and
> have for the past 10 years.
> 
>> At initial allocation time you never know, which file will stop grow in some future,
>> i.e. which file is suitable for compaction. This knowledge becomes available some time later.
>> Say, if a file has not been changed for a month, it is suitable for compaction with
>> another files like it.
>>
>> If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
>> and just share your algorithm here.
>>
>> In Virtuozzo we tried to compact ext4 with existing kernel interface:
>>
>> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>>
>> But it does not work well in many situations, and the main problem is blocks allocation
>> in desired place is not possible. Block allocator can't behave excellent for everything.
>>
>> If this interface bad, can you suggest another interface to make block allocator to know
>> the behavior expected from him in this specific case?
> 
> Write once, long term data:
> 
> 	fcntl(fd, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);
> 
> That will allow the the storage stack to group all data with the
> same hint together, both in software and in hardware.

This is interesting option, but it only applicable before write is made. And it's only
applicable on your own applications. My usecase is defragmentation of containers, where
any applications may run. Most of applications never care whether long or short-term
data they write.

Maybe, we can make fallocate() care about F_SET_RW_HINT? Say, if RWH_WRITE_LIFE_EXTREME
is set, fallocate() tries to allocate space around another inodes with the same hint.

E.g., we have 1Mb discard granuality on block device and two files in different block
device clusters: one is 4Kb of length, another's size is 1Mb-4Kb. The biggest file is
situated on the start of block device cluster:

[      1Mb cluster0       ][      1Mb cluster1     ]
[****BIG_FILE****|free 4Kb][small_file|free 1Mb-4Kb]

defrag util wants to move small file into free space in cluster0. To do that it opens
BIG_FILE and sets F_SET_RW_HINT for its inode. Then it opens tmp file, sets the hint
and calls fallocate():

fd1 = open("BIG_FILE", O_RDONLY);
ioctl(fd1, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);

fd2 = open("donor", O_WRONLY|O_TMPFILE|O_CREAT);
ioctl(fd2, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);

fallocate(fd2, 0, 0, 4Kb); // firstly seeks a space around files with RWH_WRITE_LIFE_EXTREME hint

How about this?

Kirill
