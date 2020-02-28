Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA5A17375D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 13:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgB1Mm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 07:42:27 -0500
Received: from relay.sw.ru ([185.231.240.75]:51102 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1Mm0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:42:26 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7exk-0004yl-CC; Fri, 28 Feb 2020 15:41:52 +0300
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
 <2e2ae13e-0757-0831-216d-b363b1727a0d@virtuozzo.com>
 <20200227215634.GM10737@dread.disaster.area>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e4835807-52d2-cce4-ed11-cc58448d3140@virtuozzo.com>
Date:   Fri, 28 Feb 2020 15:41:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227215634.GM10737@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28.02.2020 00:56, Dave Chinner wrote:
> On Thu, Feb 27, 2020 at 02:12:53PM +0300, Kirill Tkhai wrote:
>> On 27.02.2020 10:33, Dave Chinner wrote:
>>> On Wed, Feb 26, 2020 at 11:05:23PM +0300, Kirill Tkhai wrote:
>>>> On 26.02.2020 18:55, Christoph Hellwig wrote:
>>>>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>>>>> This adds a support of physical hint for fallocate2() syscall.
>>>>>> In case of @physical argument is set for ext4_fallocate(),
>>>>>> we try to allocate blocks only from [@phisical, @physical + len]
>>>>>> range, while other blocks are not used.
>>>>>
>>>>> Sorry, but this is a complete bullshit interface.  Userspace has
>>>>> absolutely no business even thinking of physical placement.  If you
>>>>> want to align allocations to physical block granularity boundaries
>>>>> that is the file systems job, not the applications job.
>>>>
>>>> Why? There are two contradictory actions that filesystem can't do at the same time:
>>>>
>>>> 1)place files on a distance from each other to minimize number of extents
>>>>   on possible future growth;
>>>
>>> Speculative EOF preallocation at delayed allocation reservation time
>>> provides this.
>>>
>>>> 2)place small files in the same big block of block device.
>>>
>>> Delayed allocation during writeback packs files smaller than the
>>> stripe unit of the filesystem tightly.
>>>
>>> So, yes, we do both of these things at the same time in XFS, and
>>> have for the past 10 years.
>>>
>>>> At initial allocation time you never know, which file will stop grow in some future,
>>>> i.e. which file is suitable for compaction. This knowledge becomes available some time later.
>>>> Say, if a file has not been changed for a month, it is suitable for compaction with
>>>> another files like it.
>>>>
>>>> If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
>>>> and just share your algorithm here.
>>>>
>>>> In Virtuozzo we tried to compact ext4 with existing kernel interface:
>>>>
>>>> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>>>>
>>>> But it does not work well in many situations, and the main problem is blocks allocation
>>>> in desired place is not possible. Block allocator can't behave excellent for everything.
>>>>
>>>> If this interface bad, can you suggest another interface to make block allocator to know
>>>> the behavior expected from him in this specific case?
>>>
>>> Write once, long term data:
>>>
>>> 	fcntl(fd, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);
>>>
>>> That will allow the the storage stack to group all data with the
>>> same hint together, both in software and in hardware.
>>
>> This is interesting option, but it only applicable before write is made. And it's only
>> applicable on your own applications. My usecase is defragmentation of containers, where
>> any applications may run. Most of applications never care whether long or short-term
>> data they write.
> 
> Why is that a problem? They'll be using the default write hint (i.e.
> NONE) and so a hint aware allocation policy will be separating that
> data from all the other data written with specific hints...
> 
> And you've mentioned that your application has specific *never write
> again* selection criteria for data it is repacking. And that
> involves rewriting that data.  IOWs, you know exactly what policy
> you want to apply before you rewrite the data, and so what other
> applications do is completely irrelevant for your repacker...

It is not a rewriting data, there is moving data to new place with EXT4_IOC_MOVE_EXT.
This time extent is already allocated and its place is known. But if

>> Maybe, we can make fallocate() care about F_SET_RW_HINT? Say, if RWH_WRITE_LIFE_EXTREME
>> is set, fallocate() tries to allocate space around another inodes with the same hint.
> 
> That's exactly what I said:
>
>>> That will allow the the storage stack to group all data with the
>>> same hint together, both in software and in hardware.

... and fallocate() cares about the hint, this should work.
 
> What the filesystem does with the hint is up to the filesystem
> and the policies that it's developers decide are appropriate. If
> your filesystem doesn't do what you need, talk to the filesystem
> developers about implementing the policy you require.

Do XFS kernel defrag interfaces allow to pack some randomly chosen
small files in 1Mb blocks? Do they allow to pack small 4Kb file into
free space after a big file like in example:

before:
       BIG file                         Small file
[single 16 Mb extent - 4Kb][unused 4Kb][4Kb extent]

after:
       BIG file             Small file     
[single 16 Mb extent - 4Kb][4Kb extent][unused 4Kb]

?

Kirill
