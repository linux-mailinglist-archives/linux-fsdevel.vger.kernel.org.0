Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5221617153B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgB0Kmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 05:42:35 -0500
Received: from relay.sw.ru ([185.231.240.75]:57428 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgB0Kmf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:42:35 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7GcL-00055Y-C5; Thu, 27 Feb 2020 13:42:09 +0300
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Christoph Hellwig <hch@infradead.org>
Cc:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <19bddb89-c3c4-0f38-dca3-70164dc81a57@yandex-team.ru>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <ef3f2efc-88b9-401e-7b01-5e40a2412f5b@virtuozzo.com>
Date:   Thu, 27 Feb 2020 13:42:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <19bddb89-c3c4-0f38-dca3-70164dc81a57@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27.02.2020 09:59, Konstantin Khlebnikov wrote:
> On 26/02/2020 23.05, Kirill Tkhai wrote:
>> On 26.02.2020 18:55, Christoph Hellwig wrote:
>>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
>>>> This adds a support of physical hint for fallocate2() syscall.
>>>> In case of @physical argument is set for ext4_fallocate(),
>>>> we try to allocate blocks only from [@phisical, @physical + len]
>>>> range, while other blocks are not used.
>>>
>>> Sorry, but this is a complete bullshit interface.  Userspace has
>>> absolutely no business even thinking of physical placement.  If you
>>> want to align allocations to physical block granularity boundaries
>>> that is the file systems job, not the applications job.
>>
>> Why? There are two contradictory actions that filesystem can't do at the same time:
>>
>> 1)place files on a distance from each other to minimize number of extents
>>    on possible future growth;
>> 2)place small files in the same big block of block device.
>>
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
> Controlling exact place is odd. I suppose main reason for this that defragmentation
> process wants to control fragmentation during allocating new space.
> 
> Maybe flag FALLOC_FL_DONT_FRAGMENT (allocate exactly one extent or fail) could solve that problem?
>
> Defragmentator could try allocate different sizes and automatically balance fragmentation factor
> without controlling exact disk offsets. Also it could reserve space for expected file growth.

I don't think this will helps. The problem is not in allocation a single extent (fallocate() already
tries to allocate as small number of extents as possible), but in that it's impossible to allocate it
in desired bounds. Say, you have 1Mb discard granuality on block device and two files in different
block device clusters: one is 4Kb of length, another's size is 1Mb-4Kb. The biggest file is situated
on the start of block device cluster:

[      1Mb cluster0       ][      1Mb cluster1     ]
[****BIG_FILE****|free 4Kb][small_file|free 1Mb-4Kb]

The best defragmentation will be to move small_file into free 4Kb of cluster0. Allocation of single
extent does not help here: you have to allocate very big bunch of such extents in cycle before
allocator returns you desired block, and then it's need to return the rest of extents back. This
has very bad performance.
