Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D45B175825
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2020 11:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCBKS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 05:18:26 -0500
Received: from relay.sw.ru ([185.231.240.75]:36310 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgCBKS0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:18:26 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j8i91-00038m-Od; Mon, 02 Mar 2020 13:17:51 +0300
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
 <e4835807-52d2-cce4-ed11-cc58448d3140@virtuozzo.com>
 <20200229224124.GR10737@dread.disaster.area>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <8e729e06-9251-5df4-5ef8-67da61b3cfea@virtuozzo.com>
Date:   Mon, 2 Mar 2020 13:17:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200229224124.GR10737@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01.03.2020 01:41, Dave Chinner wrote:
> On Fri, Feb 28, 2020 at 03:41:51PM +0300, Kirill Tkhai wrote:
>> On 28.02.2020 00:56, Dave Chinner wrote:
>>> On Thu, Feb 27, 2020 at 02:12:53PM +0300, Kirill Tkhai wrote:
>>>> On 27.02.2020 10:33, Dave Chinner wrote:
>>>>> On Wed, Feb 26, 2020 at 11:05:23PM +0300, Kirill Tkhai wrote:
>>>>>> On 26.02.2020 18:55, Christoph Hellwig wrote:
>>>>>>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>>>>>>> This adds a support of physical hint for fallocate2() syscall.
>>>>>>>> In case of @physical argument is set for ext4_fallocate(),
>>>>>>>> we try to allocate blocks only from [@phisical, @physical + len]
>>>>>>>> range, while other blocks are not used.
>>>>>>>
>>>>>>> Sorry, but this is a complete bullshit interface.  Userspace has
>>>>>>> absolutely no business even thinking of physical placement.  If you
>>>>>>> want to align allocations to physical block granularity boundaries
>>>>>>> that is the file systems job, not the applications job.
>>>>>>
>>>>>> Why? There are two contradictory actions that filesystem can't do at the same time:
>>>>>>
>>>>>> 1)place files on a distance from each other to minimize number of extents
>>>>>>   on possible future growth;
>>>>>
>>>>> Speculative EOF preallocation at delayed allocation reservation time
>>>>> provides this.
>>>>>
>>>>>> 2)place small files in the same big block of block device.
>>>>>
>>>>> Delayed allocation during writeback packs files smaller than the
>>>>> stripe unit of the filesystem tightly.
>>>>>
>>>>> So, yes, we do both of these things at the same time in XFS, and
>>>>> have for the past 10 years.
>>>>>
>>>>>> At initial allocation time you never know, which file will stop grow in some future,
>>>>>> i.e. which file is suitable for compaction. This knowledge becomes available some time later.
>>>>>> Say, if a file has not been changed for a month, it is suitable for compaction with
>>>>>> another files like it.
>>>>>>
>>>>>> If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
>>>>>> and just share your algorithm here.
>>>>>>
>>>>>> In Virtuozzo we tried to compact ext4 with existing kernel interface:
>>>>>>
>>>>>> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
>>>>>>
>>>>>> But it does not work well in many situations, and the main problem is blocks allocation
>>>>>> in desired place is not possible. Block allocator can't behave excellent for everything.
>>>>>>
>>>>>> If this interface bad, can you suggest another interface to make block allocator to know
>>>>>> the behavior expected from him in this specific case?
>>>>>
>>>>> Write once, long term data:
>>>>>
>>>>> 	fcntl(fd, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);
>>>>>
>>>>> That will allow the the storage stack to group all data with the
>>>>> same hint together, both in software and in hardware.
>>>>
>>>> This is interesting option, but it only applicable before write is made. And it's only
>>>> applicable on your own applications. My usecase is defragmentation of containers, where
>>>> any applications may run. Most of applications never care whether long or short-term
>>>> data they write.
>>>
>>> Why is that a problem? They'll be using the default write hint (i.e.
>>> NONE) and so a hint aware allocation policy will be separating that
>>> data from all the other data written with specific hints...
>>>
>>> And you've mentioned that your application has specific *never write
>>> again* selection criteria for data it is repacking. And that
>>> involves rewriting that data.  IOWs, you know exactly what policy
>>> you want to apply before you rewrite the data, and so what other
>>> applications do is completely irrelevant for your repacker...
>>
>> It is not a rewriting data, there is moving data to new place with EXT4_IOC_MOVE_EXT.
> 
> "rewriting" is a technical term for reading data at rest and writing
> it again, whether it be to the same location or to some other
> location. Changing physical location of data, by definition,
> requires rewriting data.
> 
> EXT4_IOC_MOVE_EXT = data rewrite + extent swap to update the
> metadata in the original file to point at the new data. Hence it
> appears to "move" from userspace perspective (hence the name) but
> under the covers it is rewriting data and fiddling pointers...

Yeah, I understand this. I mean that file remains accessible for external
users, and external reads/writes are handled properly, and state of file
remains consistent.

>>> What the filesystem does with the hint is up to the filesystem
>>> and the policies that it's developers decide are appropriate. If
>>> your filesystem doesn't do what you need, talk to the filesystem
>>> developers about implementing the policy you require.
>>
>> Do XFS kernel defrag interfaces allow to pack some randomly chosen
>> small files in 1Mb blocks? Do they allow to pack small 4Kb file into
>> free space after a big file like in example:
> 
> No. Randomly selecting small holes for small file writes is a
> terrible idea from a performance perspective. Hence filling tiny
> holes (not randomly!) is often only done for metadata allocation
> (e.g. extent map blocks, which are largely random access anyway) or
> if there is no other choice for data (e.g. at ENOSPC).

I'm speaking more about the possibility. "Random" is from block allocator
view. But from user view they are not random, these are unmodifiable files.
Say, static content of website never changes, and these files may be packed
together to decrease number of occupied 1Mb disc blocks.

To pack all files on a disc together is terrible idea, I'm 100% agree with you.

Kirill
