Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BE2171719
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 13:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgB0MZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 07:25:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:60820 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729062AbgB0MZd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:25:33 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7IDs-0005hu-OA; Thu, 27 Feb 2020 15:25:00 +0300
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mike Snitzer <snitzer@redhat.com>, Jan Kara <jack@suse.cz>,
        Eric Biggers <ebiggers@google.com>, riteshh@linux.ibm.com,
        krisman@collabora.com, surajjs@amazon.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, Eric Whitney <enwlinux@gmail.com>,
        sblbir@amazon.com, Khazhismel Kumykov <khazhy@google.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <eda406cc-8ce3-e67a-37be-3e525b58d5a1@virtuozzo.com>
Date:   Thu, 27 Feb 2020 15:24:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <A57E33D1-3D54-405A-8300-13F117DC4633@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.02.2020 00:51, Andreas Dilger wrote:
> On Feb 26, 2020, at 1:05 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>
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
>>  on possible future growth;
>> 2)place small files in the same big block of block device.
>>
>> At initial allocation time you never know, which file will stop grow in some
>> future, i.e. which file is suitable for compaction. This knowledge becomes
>> available some time later.  Say, if a file has not been changed for a month,
>> it is suitable for compaction with another files like it.
>>
>> If at allocation time you can determine a file, which won't grow in the future,
>> don't be afraid, and just share your algorithm here.
> 
> Very few files grow after they are initially written/closed.  Those that
> do are almost always opened with O_APPEND (e.g. log files).  It would be
> reasonable to have O_APPEND cause the filesystem to reserve blocks (in
> memory at least, maybe some small amount on disk like 1/4 of the current
> file size) for the file to grow after it is closed.  We might use the
> same heuristic for directories that grow long after initial creation.

1)Lets see on a real example. I created a new ext4 and started the test below:
https://gist.github.com/tkhai/afd8458c0a3cc082a1230370c7d89c99

Here are two files written. One file is 4Kb. One file is 1Mb-4Kb.

$filefrag -e test1.tmp test2.tmp 
Filesystem type is: ef53
File size of test1.tmp is 4096 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:      33793..     33793:      1:             last,eof
test1.tmp: 1 extent found
File size of test2.tmp is 1044480 (255 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     254:      33536..     33790:    255:             last,eof
test2.tmp: 1 extent found

$debugfs:  testb 33791
Block 33791 not in use

test2.tmp started from 131Mb. In case of discard granuality is 1Mb, test1.tmp
placement prevents us from discarding next 1Mb block.

2)Another example. Let write two files: 1Mb-4Kb and 1Mb+4Kb:

# filefrag -e test3.tmp test4.tmp 
Filesystem type is: ef53
File size of test3.tmp is 1052672 (257 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     256:      35840..     36096:    257:             last,eof
test3.tmp: 1 extent found
File size of test4.tmp is 1044480 (255 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..     254:      35072..     35326:    255:             last,eof
test4.tmp: 1 extent found

They don't go sequentially, and here is fragmentation starts.

After both the tests:
$df -h
/dev/loop0      2.0G   11M  1.8G   1% /root/mnt

Filesystem is free, all last block groups are free. E.g.,

Group 15: (Blocks 491520-524287) csum 0x3ef5 [INODE_UNINIT, ITABLE_ZEROED]
  Block bitmap at 272 (bg #0 + 272), csum 0xd52c1f66
  Inode bitmap at 288 (bg #0 + 288), csum 0x00000000
  Inode table at 7969-8480 (bg #0 + 7969)
  32768 free blocks, 8192 free inodes, 0 directories, 8192 unused inodes
  Free blocks: 491520-524287
  Free inodes: 122881-131072

but two files are not packed together.

So, ext4 block allocator does not work good for my workload. It even does not
know anything about discard granuality of underlining block device. Does it?
I assume no fs knows. Should I tell it?

> The main exception there is VM images, because they are not really "files"
> in the normal sense, but containers aggregating a lot of different files,
> each created with patterns that are not visible to the VM host.  In that
> case, it would be better to have the VM host tell the filesystem that the
> IO pattern is "random" and not try to optimize until the VM is cold.
> 
>> In Virtuozzo we tried to compact ext4 with existing kernel interface:
>>
>> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>>
>> But it does not work well in many situations, and the main problem is blocks allocation in desired place is not possible. Block allocator can't behave
>> excellent for everything.
>>
>> If this interface bad, can you suggest another interface to make block
>> allocator to know the behavior expected from him in this specific case?
> 
> In ext4 there is already the "group" allocator, which combines multiple
> small files together into a single preallocation group, so that the IO
> to disk is large/contiguous.  The theory is that files written at the
> same time will have similar lifespans, but that isn't always true.
> 
> If the files are large and still being written, the allocator will reserve
> additional blocks (default 8MB I think) on the expectation that it will
> continue to write until it is closed.
> 
> I think (correct me if I'm wrong) that your issue is with defragmenting
> small files to free up contiguous space in the filesystem?  I think once
> the free space is freed of small files that defragmenting large files is
> easily done.  Anything with more than 8-16MB extents will max out most
> storage anyway (seek rate * IO size).

My issue is mostly with files < 1Mb, because underlining device discard
granuality is 1Mb. The result of fragmentation is that size of occupied
1Mb blocks of device is 1.5 times bigger, than size of really written
data (say, df -h). And this is the problem.

> In that case, an interesting userspace interface would be an array of
> inode numbers (64-bit please) that should be packed together densely in
> the order they are provided (maybe a flag for that).  That allows the
> filesystem the freedom to find the physical blocks for the allocation,
> while userspace can tell which files are related to each other.

So, this interface is 3-in-1:

1)finds a placement for inodes extents;
2)assigns this space to some temporary donor inode;
3)calls ext4_move_extents() for each of them.

Do I understand you right?

If so, then IMO it's good to start from two inodes, because here may code
a very difficult algorithm of placement of many inodes, which may require
much memory. Is this OK?

Can we introduce a flag, that some of inode is unmovable?

Can this interface use a knowledge about underlining device discard granuality?

In the answer to Dave, I wrote a proposition to make fallocate() care about
i_write_hint. Could you please comment what you think about that too?

Thanks,
Kirill
