Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548F2177D9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 18:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgCCRgs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 12:36:48 -0500
Received: from relay.sw.ru ([185.231.240.75]:47752 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728291AbgCCRgs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:36:48 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j9BSz-0007Ah-L0; Tue, 03 Mar 2020 20:36:26 +0300
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
 <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
 <20200303165505.GA61444@mit.edu>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a438aa32-5d14-814a-a003-8ea52026f8b5@virtuozzo.com>
Date:   Tue, 3 Mar 2020 20:36:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303165505.GA61444@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03.03.2020 19:55, Theodore Y. Ts'o wrote:
> On Tue, Mar 03, 2020 at 12:57:15PM +0300, Kirill Tkhai wrote:
>> The practice shows it's not so. Your suggestion was the first thing we tried,
>> but it works bad and just doubles/triples IO.
>>
>> Let we have two files of 512Kb, and they are placed in separate 1Mb clusters:
>>
>> [[512Kb file][512Kb free]][[512Kb file][512Kb free]]
>>
>> We want to pack both of files in the same 1Mb cluster. Packed together on block device,
>> they will be in the same server of underlining distributed storage file system.
>> This gives a big performance improvement, and this is the price I aimed.
>>
>> In case of I fallocate a large hunk for both of them, I have to move them
>> both to this new hunk. So, instead of moving 512Kb of data, we will have to move
>> 1Mb of data, i.e. double size, which is counterproductive.
>>
>> Imaging another situation, when we have 
>> [[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]
>>
>> Here we may just move [4Kb file] into [4Kb free]. But your suggestion again forces
>> us to move 1Mb instead of 4Kb, which makes IO 256 times worse! This is terrible!
>> And this is the thing I try prevent with finding a suitable new interface.
> 
> OK, so you aren't trying to *defragment*.  You want to have files
> placed "properly" ab initio.
> 
> It sounds like what you *think* is the best way to go is to simply
> have files backed tightly together.  So effectively what you want as a
> block allocation strategy is something which just finds the next free
> space big enough for the requested fallocate space, and just plop it
> down right there.
> 
> OK, so what happens once you've allocated all of the free space, and
> the pattern of deletes leaves the file system with a lot of holes?

We defrag not all files, but a specific subset of files. Say, webserver
may have a lot of static content, a lot of small files, which are never
changed. So, we found files, which were not modified for months or years,
and pack them together. Also we pack RO files, and the most cases they
never changed in the future.

So, it's not for all files, it's for specific files, which are chosen
by defragger algorithm.

> I could imagine trying to implement this as a mount option which uses
> an alternate block allocation strategy, but it's not clear what your
> end game is after all of the "easy" spaces have been taken.  It's much
> like proposals I've seen for a log-structured file system, where the
> garbage collector is left as a "we'll get to it later" TODO item.  (If
> I had a dollar each time I've read a paper proposing a log structured
> file system which leaves out the garbage collector as an
> implementation detail....)

Mount option acts at runtime. I'm OK with block placement at runtime. We
defrag files with old modification time, when we know they are unmodifiable,
some time later. So, I'm not sure this will help.
If I understood you wrong, please, explain, whether you mean something else.

>> It's powerful, but it does not allow to create an effective defragmentation
>> tool for my usecase. See the examples above. I do not want to replace
>> EXT4_IOC_MOVE_EXTENT I just want an interface to be able to allocate
>> a space close to some existing file and reduce IO at defragmentation time.
>> This is just only thing I need in this patchset.
> 
> "At defragmentation time"?   So you do want to run a defragger?
> 
> It might be helpful to see the full design of what you have in mind,
> and not just a request for interfaces....

Yes, I run defragger. And it detects, which files may be packed together,
and then it tries to pack them.
>> I can't climb into maintainers heads and find a thing, which will be suitable
>> for you. I did my try and suggested the interface. In case of it's not OK
>> for you, could you, please, suggest another one, which will work for my usecase?
>> The thesis "EXT4_IOC_MOVE_EXTENT is enough for everything" does not work for me :(
>> Are you OK with interface suggested by Andreas?
> 
> Like you, I can't climb into your head and figure out exactly how your
> entire system design is going to work.  And I'd really rather not
> proposal or bless an interface until I do, since it may be that it's
> better to make some minor changes to your system design, instead of
> trying to twist ext4 for your particular use case....

Let I try to give a description:

1)defragger scans whole filesystem and it divides fs in 1Mb cluster.
There is populated a statistics of every scanned cluster: filling percent,
percent of long-time-unmodifiable blocks, percent of RO blocks etc.

Also relation of some directories to block groups are cached.

2)then it marks clusters suitable for compaction and for relocation.

3)then some data becomes compacted or relocated. For compaction we try
to allocate blocks nearly existing RO data to decrease IO (as I wrote
in previous email). The only way we can do it is to use ext4 block
allocation option: usually it tries to allocate blocks for a new inode
in the same block group, where directory is placed. Here we use information
about relationship between directories and block groups. We use specific
directory to create donor file. In case of success, fallocate(donor)
returns blocks from correct 1Mb cluster. Otherwise, cluster is fully
relocated (1Mb block is allocated and we write everything there).

3.1)We have:

[     Cluster 1      ][      Cluster 2    ][    Cluster 3       ]
[1020Kb file][4K hole][4Kfile][1020Kb hole][1020Kb file][4K hole]

3.2)Create a donor file in the directory, which is related to the same
block group, where cluster 1 is placed.

3.3)Several calls of fallocate(donor, 4K)-> are we in Cluster 1 (or 3, or similar)?
                                                /              \
                                             (OK)move 4K file   (Fail)fallocate(1M) and move both 1020Kb file and 4K file.


The practice shows that probability of successful fallocate() results in the specific cluster
is small. So, it the most case we have to move both 1020Kb and 4K files.

My experience is "less full filesystem is, less probability to receive suitable extent from fallocate()".
For me it looks like ext4 tries to spread all files over the disk, so this helps to build files
with less number of extents. This is very nice at allocation time, and it really works good.
But I need some opposite at defragmentation time...

What do you think about all of this?

Thanks,
Kirill
