Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18072423AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 03:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHLBXx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 21:23:53 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33920 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbgHLBXx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:23:53 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 898DB3A9005;
        Wed, 12 Aug 2020 11:23:48 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k5fUX-0000Xy-TX; Wed, 12 Aug 2020 11:23:45 +1000
Date:   Wed, 12 Aug 2020 11:23:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH v2 15/20] fuse, dax: Take ->i_mmap_sem lock during dax
 page fault
Message-ID: <20200812012345.GG2079@dread.disaster.area>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-16-vgoyal@redhat.com>
 <20200810222238.GD2079@dread.disaster.area>
 <20200811175530.GB497326@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811175530.GB497326@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=cCKMqcOPnOhVYIV9LdMA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:55:30PM -0400, Vivek Goyal wrote:
> On Tue, Aug 11, 2020 at 08:22:38AM +1000, Dave Chinner wrote:
> > On Fri, Aug 07, 2020 at 03:55:21PM -0400, Vivek Goyal wrote:
> > > We need some kind of locking mechanism here. Normal file systems like
> > > ext4 and xfs seems to take their own semaphore to protect agains
> > > truncate while fault is going on.
> > > 
> > > We have additional requirement to protect against fuse dax memory range
> > > reclaim. When a range has been selected for reclaim, we need to make sure
> > > no other read/write/fault can try to access that memory range while
> > > reclaim is in progress. Once reclaim is complete, lock will be released
> > > and read/write/fault will trigger allocation of fresh dax range.
> > > 
> > > Taking inode_lock() is not an option in fault path as lockdep complains
> > > about circular dependencies. So define a new fuse_inode->i_mmap_sem.
> > 
> > That's precisely why filesystems like ext4 and XFS define their own
> > rwsem.
> > 
> > Note that this isn't a DAX requirement - the page fault
> > serialisation is actually a requirement of hole punching...
> 
> Hi Dave,
> 
> I noticed that fuse code currently does not seem to have a rwsem which
> can provide mutual exclusion between truncation/hole_punch path
> and page fault path. I am wondering does that mean there are issues
> with existing code or something else makes it unnecessary to provide
> this mutual exlusion.

I don't know enough about the fuse implementation to say. What I'm
saying is that nothing in the core mm/ or VFS serilises page cache
access to the data against direct filesystem manipulations of the
underlying filesystem structures.

i.e. nothing in the VFS or page fault IO path prevents this race
condition:

P0				P1
fallocate
page cache invalidation
				page fault
				read data
punch out data extents
				<data exposed to userspace is stale>
				<data exposed to userspace has no
				backing store allocated>


That's where the ext4 and XFS internal rwsem come into play:

fallocate
down_write(mmaplock)
page cache invalidation
				page fault
				down_read(mmaplock)
				<blocks>
punch out data
up_write(mmaplock)
				<unblocks>
				<sees hole>
				<allocates zeroed pages in page cache>

And there's not stale data exposure to userspace.

It's the same reason that we use the i_rwsem to prevent concurrent
IO while a truncate or hole punch is in progress. The IO could map
the extent, then block in the IO path, while the filesytsem
re-allocates and writes new data or metadata to those blocks. That's
another potential non-owner data exposure problem.

And if you don't drain AIO+DIO before truncate/hole punch, the
i_rwsem does not protect you against concurrent IO as that gets
dropped after the AIO is submitted and returns EIOCBQUEUED to the
AIO layer. Hence there's IO in flight that isn't tracked by the
i_rwsem or the MMAPLOCK, and if you punch out the blocks and
reallocate them while the IO is in flight....

> > > @@ -3849,9 +3856,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> > >  			file_update_time(file);
> > >  	}
> > >  
> > > -	if (mode & FALLOC_FL_PUNCH_HOLE)
> > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > +		down_write(&fi->i_mmap_sem);
> > >  		truncate_pagecache_range(inode, offset, offset + length - 1);
> > > -
> > > +		up_write(&fi->i_mmap_sem);
> > > +	}
> > >  	fuse_invalidate_attr(inode);
> > 
> > 
> > I'm not sure this is sufficient. You have to lock page faults out
> > for the entire time the hole punch is being performed, not just while
> > the mapping is being invalidated.
> > 
> > That is, once you've taken the inode lock and written back the dirty
> > data over the range being punched, you can then take a page fault
> > and dirty the page again. Then after you punch the hole out,
> > you have a dirty page with non-zero data in it, and that can get
> > written out before the page cache is truncated.
> 
> Just for my better udnerstanding of the issue, I am wondering what
> problem will it lead to.
> If one process is doing punch_hole and other is writing in the
> range being punched, end result could be anything. Either we will
> read zeroes from punched_hole pages or we will read the data
> written by process writing to mmaped page, depending on in what
> order it got executed. 
>
> If that's the case, then holding fi->i_mmap_sem for the whole
> duration might not matter. What am I missing?

That it is safe to invalidate the page cache after the hole has been
punched.

There is nothing stopping, say, memory reclaim from reclaiming pages
over the range while the hole is being punched, then having the
application refault them while the backing store is being freed.
While the page fault read IO is in progress, there's nothing
stopping the filesystem from freeing those blocks, nor reallocating
them and writing something else to them (e.g. metadata). So they
could read someone elses data.

Even worse: the page fault is a write fault, it lands in a hole, has
space allocated, the page cache is zeroed, page marked dirty, and
then the hole punch calls truncate_pagecache_range() which tosses
away the zeroed page and the data the userspace application wrote
to the page.

The application then refaults the page, reading stale data off
disk instead of seeing what it had already written to the page....

And unlike truncated pages, the mm/ code cannot reliably detect
invalidation races on lockless lookup of pages that are within EOF.
They rely on truncate changing the file size before page
invalidation to detect races as page->index then points beyond EOF.
Hole punching does not change inode size, so the page cache lookups
cannot tell the difference between a new page that just needs IO to
initialise the data and a page that has just been invalidated....

IOWs, there are many ways things can go wrong with hole punch, and
the only way to avoid them all is to do invalidate and lock out the
page cache before starting the fallocate operation. i.e.:

	1. lock up the entire IO path (vfs and page fault)
	2. drain the AIO+DIO path
	3. write back dirty pages
	4. invalidate the page cache

Because this is the only way we can guarantee that nothing can access
the filesystem's backing store for the range we are about to
directly manipulate the data in while we perform an "offloaded" data
transformation on that range...

This isn't just hole punch - the same problems exist with
FALLOC_FL_ZERO_RANGE and FALLOC_FL_{INSERT,COLLAPSE}_RANGE because
they change data with extent manipulations and/or hardware offloads
that provide no guarantees of specific data state or integrity until
they complete....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
