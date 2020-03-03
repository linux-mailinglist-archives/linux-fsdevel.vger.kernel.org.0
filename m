Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33599177337
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 10:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgCCJ5u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 04:57:50 -0500
Received: from relay.sw.ru ([185.231.240.75]:57328 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgCCJ5u (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:57:50 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j94Id-0003K4-IT; Tue, 03 Mar 2020 12:57:15 +0300
Subject: Re: [PATCH RFC 0/5] fs, ext4: Physical blocks placement hint for
 fallocate(0): fallocate2(). TP defrag.
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca
Cc:     viro@zeniv.linux.org.uk, snitzer@redhat.com, jack@suse.cz,
        ebiggers@google.com, riteshh@linux.ibm.com, krisman@collabora.com,
        surajjs@amazon.com, dmonakhov@gmail.com, mbobrowski@mbobrowski.org,
        enwlinux@gmail.com, sblbir@amazon.com, khazhy@google.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <20200302165637.GA6826@mit.edu>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2b2bb85f-8062-648a-1b6e-7d655bf43c96@virtuozzo.com>
Date:   Tue, 3 Mar 2020 12:57:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200302165637.GA6826@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, Ted,

On 02.03.2020 19:56, Theodore Y. Ts'o wrote:
> Kirill,
> 
> In a couple of your comments on this patch series, you mentioned
> "defragmentation".  Is that because you're trying to use this as part
> of e4defrag, or at least, using EXT4_IOC_MOVE_EXT?
> 
> If that's the case, you should note that input parameter for that
> ioctl is:
> 
> struct move_extent {
> 	__u32 reserved;		/* should be zero */
> 	__u32 donor_fd;		/* donor file descriptor */
> 	__u64 orig_start;	/* logical start offset in block for orig */
> 	__u64 donor_start;	/* logical start offset in block for donor */
> 	__u64 len;		/* block length to be moved */
> 	__u64 moved_len;	/* moved block length */
> };
> 
> Note that the donor_start is separate from the start of the file that
> is being defragged.  So you could have the userspace application
> fallocate a large chunk of space for that donor file, and then use
> that donor file to defrag multiple files if you want to close pack
> them.

The practice shows it's not so. Your suggestion was the first thing we tried,
but it works bad and just doubles/triples IO.

Let we have two files of 512Kb, and they are placed in separate 1Mb clusters:

[[512Kb file][512Kb free]][[512Kb file][512Kb free]]

We want to pack both of files in the same 1Mb cluster. Packed together on block device,
they will be in the same server of underlining distributed storage file system.
This gives a big performance improvement, and this is the price I aimed.

In case of I fallocate a large hunk for both of them, I have to move them
both to this new hunk. So, instead of moving 512Kb of data, we will have to move
1Mb of data, i.e. double size, which is counterproductive.

Imaging another situation, when we have 
[[1020Kb file]][4Kb free]][[4Kb file][1020Kb free]]

Here we may just move [4Kb file] into [4Kb free]. But your suggestion again forces
us to move 1Mb instead of 4Kb, which makes IO 256 times worse! This is terrible!
And this is the thing I try prevent with finding a suitable new interface.

> Many years ago, back when LSF/MM colocated with a larger
> storage-focused conference so we could manage to origanize an ext4
> developer's workshop, we had talked about ways we create kernel
> support for a more powerful userspace defragger, which could also
> defragment the free space, so that future block allocations were more
> likely to be successful.
> 
> The discussions surrounded interfaces where userspace could block (or
> at least strongly dissuade unless the only other alternative was
> returning ENOSPC) the kernel from allocating out of a certain number
> of block groups.  And then also to have an interface where for a
> particular process (namely, the defragger), to make the kernel
> strongly prefer that allocations come out of an ordered list of block
> groups.
> 
> (Of course these days, now that the cool kids are all embracing eBPF,
> one could imagine a privileged interface where the defragger could
> install some kind of eBPF program which provided enhanced policy to
> ext4's block allocator.)
> 
> No one ever really followed through with this, in part because the
> details of allowing userspace (and it would have to be privileged
> userspace) to dictate policy to the block allocator has all sorts of
> potential pitfalls, and in part because no company was really
> interested in funding the engineering work.  In addition, I'll note
> that the windows world, the need and interest for defragging has gone
> done significantly with the advent more sophisticated file systems
> like NTFSv5, which doesn't need defragging nearly as often as say, the
> FAT file system.  And I think if anything, the interst in doing work
> with e4defrag has decreased even more over the years.
> 
> That being said, there has been some interest in making changes to
> both the block allocator and some kind of on-line defrag which is
> optimized for low-end flash (such as the kind found in android
> handsets).  There, the need to be careful that we don't end up
> increasing the write wearout becomes even more critical, although the
> GC work which f2fs does involve extra moving around of data blocks,
> and phones have seemed to do fine.  Of course, the typical phone only
> has to last 2-3 years before the battery dies, the screen gets
> cracked, and/or the owner decides they want the latest cool toy from
> the phone manufacturers.  :-)
> 
> In any case, if your goal is really some interface to support on-line
> defragmentation for ext4, you want to consider whether the
> EXT4_IOC_MOVE_EXTENT interface is sufficiently powerful such that you
> don't really need to mess around with new block allocation hints.

It's powerful, but it does not allow to create an effective defragmentation
tool for my usecase. See the examples above. I do not want to replace
EXT4_IOC_MOVE_EXTENT I just want an interface to be able to allocate
a space close to some existing file and reduce IO at defragmentation time.
This is just only thing I need in this patchset.

I can't climb into maintainers heads and find a thing, which will be suitable
for you. I did my try and suggested the interface. In case of it's not OK
for you, could you, please, suggest another one, which will work for my usecase?
The thesis "EXT4_IOC_MOVE_EXTENT is enough for everything" does not work for me :(
Are you OK with interface suggested by Andreas?

Thanks,
Kirill






