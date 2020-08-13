Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8800D243388
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 07:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHMFMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 01:12:49 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:37228 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725915AbgHMFMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 01:12:48 -0400
Received: from dread.disaster.area (pa49-180-53-24.pa.nsw.optusnet.com.au [49.180.53.24])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id B14EA1A8D4F;
        Thu, 13 Aug 2020 15:12:40 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1k65Xa-0001Uw-B8; Thu, 13 Aug 2020 15:12:38 +1000
Date:   Thu, 13 Aug 2020 15:12:38 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH v2 15/20] fuse, dax: Take ->i_mmap_sem lock during dax
 page fault
Message-ID: <20200813051238.GA3339@dread.disaster.area>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-16-vgoyal@redhat.com>
 <20200810222238.GD2079@dread.disaster.area>
 <20200811175530.GB497326@redhat.com>
 <20200812012345.GG2079@dread.disaster.area>
 <20200812211012.GA540706@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812211012.GA540706@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LPwYv6e9 c=1 sm=1 tr=0
        a=moVtWZxmCkf3aAMJKIb/8g==:117 a=moVtWZxmCkf3aAMJKIb/8g==:17
        a=kj9zAlcOel0A:10 a=y4yBn9ojGxQA:10 a=7-415B0cAAAA:8
        a=dml2hL0GLVIsGKko77gA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:10:12PM -0400, Vivek Goyal wrote:
> On Wed, Aug 12, 2020 at 11:23:45AM +1000, Dave Chinner wrote:
> > On Tue, Aug 11, 2020 at 01:55:30PM -0400, Vivek Goyal wrote:
> > > On Tue, Aug 11, 2020 at 08:22:38AM +1000, Dave Chinner wrote:
> > > > On Fri, Aug 07, 2020 at 03:55:21PM -0400, Vivek Goyal wrote:
> > > > > We need some kind of locking mechanism here. Normal file systems like
> > > > > ext4 and xfs seems to take their own semaphore to protect agains
> > > > > truncate while fault is going on.
> > > > > 
> > > > > We have additional requirement to protect against fuse dax memory range
> > > > > reclaim. When a range has been selected for reclaim, we need to make sure
> > > > > no other read/write/fault can try to access that memory range while
> > > > > reclaim is in progress. Once reclaim is complete, lock will be released
> > > > > and read/write/fault will trigger allocation of fresh dax range.
> > > > > 
> > > > > Taking inode_lock() is not an option in fault path as lockdep complains
> > > > > about circular dependencies. So define a new fuse_inode->i_mmap_sem.
> > > > 
> > > > That's precisely why filesystems like ext4 and XFS define their own
> > > > rwsem.
> > > > 
> > > > Note that this isn't a DAX requirement - the page fault
> > > > serialisation is actually a requirement of hole punching...
> > > 
> > > Hi Dave,
> > > 
> > > I noticed that fuse code currently does not seem to have a rwsem which
> > > can provide mutual exclusion between truncation/hole_punch path
> > > and page fault path. I am wondering does that mean there are issues
> > > with existing code or something else makes it unnecessary to provide
> > > this mutual exlusion.
> > 
> > I don't know enough about the fuse implementation to say. What I'm
> > saying is that nothing in the core mm/ or VFS serilises page cache
> > access to the data against direct filesystem manipulations of the
> > underlying filesystem structures.
> 
> Hi Dave,
> 
> Got it. I was checking nfs and they also seem to be calling filemap_fault
> and not taking any locks to block faults. fallocate() (nfs42_fallocate)
> seems to block read/write/aio/dio but does not seem to do anything
> about blocking faults. I am wondering if remote filesystem are
> little different in this aspect. Especially fuse does not maintain
> any filesystem block/extent data. It is file server which is doing
> all that.

I suspect they have all the same problems, and worse, the behaviour
will largely be dependent on the server side behaviour that is out
of the user's control.

Essentially, nobody except us XFS folks seem to regard hole punching
corrupting data or exposing stale data as being a problem that needs
to be avoided or fixed. The only reason ext4 has the i_mmap_sem is
because ext4 wanted to support DAX, and us XFS developers said "DAX
absolutely requires that the filesystem can lock out physical access
to the storage" and so they had no choice in the matter.

Other than that, nobody really seems to understand or care about all
these nasty little mmap() corner cases that we've seen corrupt user
data or expose stale data to users over many years.....

> > i.e. nothing in the VFS or page fault IO path prevents this race
> > condition:
> > 
> > P0				P1
> > fallocate
> > page cache invalidation
> > 				page fault
> > 				read data
> > punch out data extents
> > 				<data exposed to userspace is stale>
> > 				<data exposed to userspace has no
> > 				backing store allocated>
> > 
> > 
> > That's where the ext4 and XFS internal rwsem come into play:
> > 
> > fallocate
> > down_write(mmaplock)
> > page cache invalidation
> > 				page fault
> > 				down_read(mmaplock)
> > 				<blocks>
> > punch out data
> > up_write(mmaplock)
> > 				<unblocks>
> > 				<sees hole>
> > 				<allocates zeroed pages in page cache>
> > 
> > And there's not stale data exposure to userspace.
> 
> Got it. I noticed that both fuse/nfs seem to have reversed the
> order of operation. They call server to punch out data first
> and then truncate page cache. And that should mean that even
> if mmap reader will not see stale data after fallocate(punch_hole)
> has finished.

Yes, but that doesn't prevent page fault races from occuring, it
just changes the nature of them.. Such as.....

> > There is nothing stopping, say, memory reclaim from reclaiming pages
> > over the range while the hole is being punched, then having the
> > application refault them while the backing store is being freed.
> > While the page fault read IO is in progress, there's nothing
> > stopping the filesystem from freeing those blocks, nor reallocating
> > them and writing something else to them (e.g. metadata). So they
> > could read someone elses data.
> > 
> > Even worse: the page fault is a write fault, it lands in a hole, has
> > space allocated, the page cache is zeroed, page marked dirty, and
> > then the hole punch calls truncate_pagecache_range() which tosses
> > away the zeroed page and the data the userspace application wrote
> > to the page.
> 
> But isn't that supposed to happen.

Right, it isn;'t supposed to happen, but it can happen if
page_mkwrite doesn't serialise against fallocate(). i.e. without a
i_mmap_sem, nothing in the mm page fault paths serialise the page
fault against the filesystem fallocate operation in progress.

Indeed, looking at fuse_page_mkwrite(), it just locks the page,
checks the page->mapping hasn't changed (that's one of those
"doesn't work for hole punching page invalidation" checks that I
mentioned!) and then it waits for page writeback to complete. IOWs,
fuse will allow a clean page in cache to be dirtied without the
filesystem actually locking anything or doing any sort of internal
serialisation operation.

IOWs, there is nothing stopping an application on fuse from hitting
this data corruption when a concurrent hole punch is run:

 P0				P1
 <read() loop to find zeros>
 fallocate
 write back dirty data
 punch out data extents
 .....
 				<app reads data via mmap>
				  read fault, clean page in cache!
 				<app writes data via mmap>
 				  write page fault
				  page_mkwrite
				    <page is locked just fine>
				  page is dirtied.
				<app writes new data to page>
 .....
 page cache invalidation
   <app's dirty page thrown away>
				.....
				<app reads data via mmap>
				  read page fault
				    <maps punched hole, returns zeros>
				app detects data corruption

That can happen quite easily - just go put a "sparsify" script into
cron so that runs of zeroes in files are converted into holes to
free up disk space every night....

> If fallocate(hole_punch) and mmaped
> write are happening at the same time, then there is no guarantee
> in what order they will execute.

It's not "order of exceution" that is the problem here - it's
guaranteeing *atomic execution* that is the problem. See the example
above - by not locking out page faults, fallocate() does not execute
atomically w.r.t. to mmap() access to the file, and hence we end up
losing changes the to data made via mmap.

That's precisely what the i_mmap_sem fixes. It *guarantees* the
ordering of the fallocate() operation and the page fault based
access to the underlying data by ensuring that the *operations
execute atomically* with respect to each other. And, by definition,
that atomicity of execution removes all the races that can lead to
data loss, corruption and/or stale data exposure....

> App might read back data it wrote
> or might read back zeros depdening on order it was executed. (Even
> with proper locking).

That behaviour is what "proper locking" provides. If you don't
have an i_mmap_sem to guarantee serialisation of page faults against
fallocate (i.e. "unproper locking"), then you also can get stale
data, the wrong data, data loss, access-after-free, overwrite of
metadata or other people's data, etc.

> > The application then refaults the page, reading stale data off
> > disk instead of seeing what it had already written to the page....
> > 
> > And unlike truncated pages, the mm/ code cannot reliably detect
> > invalidation races on lockless lookup of pages that are within EOF.
> > They rely on truncate changing the file size before page
> > invalidation to detect races as page->index then points beyond EOF.
> > Hole punching does not change inode size, so the page cache lookups
> > cannot tell the difference between a new page that just needs IO to
> > initialise the data and a page that has just been invalidated....
> > 
> > IOWs, there are many ways things can go wrong with hole punch, and
> > the only way to avoid them all is to do invalidate and lock out the
> > page cache before starting the fallocate operation. i.e.:
> > 
> > 	1. lock up the entire IO path (vfs and page fault)
> > 	2. drain the AIO+DIO path
> > 	3. write back dirty pages
> > 	4. invalidate the page cache
> 
> I see that this is definitely safe. Stop all read/write/faults/aio/dio
> before proceeding with punching hole and invalidating page cache.
> 
> I think for my purpose, I need to take fi->i_mmap_sem in memory
> range freeing path and need to exactly do all the above to make
> sure that no I/O, fault or AIO/DIO is going on before I take
> away the memory range I have allocated for that inode offset. This
> is I think very similar to assigning blocks/extents and taking
> these away. In that code path I am already taking care of
> taking inode lock as well as i_mmap_sem. But I have not taken
> care of AIO/DIO stuff. I will introduce that too.
> 
> For the time being I will handle this fallocate/ftruncate possible
> races in a separate patch series. To me it makes sense to do what
> ext4/xfs are doing. But there might be more to it when it comes
> to remote filesystems... 

Remote filesystems introduce a whole new range of data coherency
problems that are outside the scope of mmap() vs fallocate()
serialisation. That is, page fault vs fallocate serialisation is a
local client serialisation condition, not a remote filesystem
data coherency issue...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
