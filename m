Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E920172A96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 22:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgB0V4o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 16:56:44 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:36912 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729501AbgB0V4o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:56:44 -0500
Received: from dread.disaster.area (pa49-195-202-68.pa.nsw.optusnet.com.au [49.195.202.68])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id A4DF83A32ED;
        Fri, 28 Feb 2020 08:56:35 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1j7R90-0004QR-Dr; Fri, 28 Feb 2020 08:56:34 +1100
Date:   Fri, 28 Feb 2020 08:56:34 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Christoph Hellwig <hch@infradead.org>, tytso@mit.edu,
        viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        dmonakhov@gmail.com, mbobrowski@mbobrowski.org, enwlinux@gmail.com,
        sblbir@amazon.com, khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 5/5] ext4: Add fallocate2() support
Message-ID: <20200227215634.GM10737@dread.disaster.area>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
 <158272447616.281342.14858371265376818660.stgit@localhost.localdomain>
 <20200226155521.GA24724@infradead.org>
 <06f9b82c-a519-7053-ec68-a549e02c6f6c@virtuozzo.com>
 <20200227073336.GJ10737@dread.disaster.area>
 <2e2ae13e-0757-0831-216d-b363b1727a0d@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2ae13e-0757-0831-216d-b363b1727a0d@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=mqTaRPt+QsUAtUurwE173Q==:117 a=mqTaRPt+QsUAtUurwE173Q==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=l697ptgUJYAA:10
        a=SSkiD6HNAAAA:20 a=7-415B0cAAAA:8 a=hjJOWSJPumWB5AbckyoA:9
        a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=F-BD9Ut2gcChwI3g:21
        a=9FFcs68v8UOzUGPP:21 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:12:53PM +0300, Kirill Tkhai wrote:
> On 27.02.2020 10:33, Dave Chinner wrote:
> > On Wed, Feb 26, 2020 at 11:05:23PM +0300, Kirill Tkhai wrote:
> >> On 26.02.2020 18:55, Christoph Hellwig wrote:
> >>> On Wed, Feb 26, 2020 at 04:41:16PM +0300, Kirill Tkhai wrote:
> >>>> This adds a support of physical hint for fallocate2() syscall.
> >>>> In case of @physical argument is set for ext4_fallocate(),
> >>>> we try to allocate blocks only from [@phisical, @physical + len]
> >>>> range, while other blocks are not used.
> >>>
> >>> Sorry, but this is a complete bullshit interface.  Userspace has
> >>> absolutely no business even thinking of physical placement.  If you
> >>> want to align allocations to physical block granularity boundaries
> >>> that is the file systems job, not the applications job.
> >>
> >> Why? There are two contradictory actions that filesystem can't do at the same time:
> >>
> >> 1)place files on a distance from each other to minimize number of extents
> >>   on possible future growth;
> > 
> > Speculative EOF preallocation at delayed allocation reservation time
> > provides this.
> > 
> >> 2)place small files in the same big block of block device.
> > 
> > Delayed allocation during writeback packs files smaller than the
> > stripe unit of the filesystem tightly.
> > 
> > So, yes, we do both of these things at the same time in XFS, and
> > have for the past 10 years.
> > 
> >> At initial allocation time you never know, which file will stop grow in some future,
> >> i.e. which file is suitable for compaction. This knowledge becomes available some time later.
> >> Say, if a file has not been changed for a month, it is suitable for compaction with
> >> another files like it.
> >>
> >> If at allocation time you can determine a file, which won't grow in the future, don't be afraid,
> >> and just share your algorithm here.
> >>
> >> In Virtuozzo we tried to compact ext4 with existing kernel interface:
> >>
> >> https://github.com/dmonakhov/e2fsprogs/blob/e4defrag2/misc/e4defrag2.c
> >>
> >> But it does not work well in many situations, and the main problem is blocks allocation
> >> in desired place is not possible. Block allocator can't behave excellent for everything.
> >>
> >> If this interface bad, can you suggest another interface to make block allocator to know
> >> the behavior expected from him in this specific case?
> > 
> > Write once, long term data:
> > 
> > 	fcntl(fd, F_SET_RW_HINT, RWH_WRITE_LIFE_EXTREME);
> > 
> > That will allow the the storage stack to group all data with the
> > same hint together, both in software and in hardware.
> 
> This is interesting option, but it only applicable before write is made. And it's only
> applicable on your own applications. My usecase is defragmentation of containers, where
> any applications may run. Most of applications never care whether long or short-term
> data they write.

Why is that a problem? They'll be using the default write hint (i.e.
NONE) and so a hint aware allocation policy will be separating that
data from all the other data written with specific hints...

And you've mentioned that your application has specific *never write
again* selection criteria for data it is repacking. And that
involves rewriting that data.  IOWs, you know exactly what policy
you want to apply before you rewrite the data, and so what other
applications do is completely irrelevant for your repacker...

> Maybe, we can make fallocate() care about F_SET_RW_HINT? Say, if RWH_WRITE_LIFE_EXTREME
> is set, fallocate() tries to allocate space around another inodes with the same hint.

That's exactly what I said:

> > That will allow the the storage stack to group all data with the
> > same hint together, both in software and in hardware.

What the filesystem does with the hint is up to the filesystem
and the policies that it's developers decide are appropriate. If
your filesystem doesn't do what you need, talk to the filesystem
developers about implementing the policy you require.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
