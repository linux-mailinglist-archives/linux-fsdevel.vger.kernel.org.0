Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADA243065
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 23:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHLVKe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 17:10:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54077 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgHLVKd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597266631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lajmu4EexvaCOeWvbC8/EUC4iJVRcqbVaB2CSLh8m28=;
        b=UNkru5zVQ/vqnSH2vnzGQ7f+3nJmo/uAON7leIy91E63Os+HV9Uq3jUZ9jmyv8EX07N7c0
        bv9YcyLKgUtfpsVVl2ci8ehaBK19EmJrLQVXBVuyblWAv4fP8ektBrA10Pbxsn2cz+s0TD
        Flm6IJvH95hhGG22zPIfOJpPtUKbBmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-bZk2_DJxO-mIxuPXAOKWKg-1; Wed, 12 Aug 2020 17:10:21 -0400
X-MC-Unique: bZk2_DJxO-mIxuPXAOKWKg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA0A57;
        Wed, 12 Aug 2020 21:10:20 +0000 (UTC)
Received: from horse.redhat.com (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37A7719D7D;
        Wed, 12 Aug 2020 21:10:13 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BCBCC220264; Wed, 12 Aug 2020 17:10:12 -0400 (EDT)
Date:   Wed, 12 Aug 2020 17:10:12 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: Re: [PATCH v2 15/20] fuse, dax: Take ->i_mmap_sem lock during dax
 page fault
Message-ID: <20200812211012.GA540706@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
 <20200807195526.426056-16-vgoyal@redhat.com>
 <20200810222238.GD2079@dread.disaster.area>
 <20200811175530.GB497326@redhat.com>
 <20200812012345.GG2079@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812012345.GG2079@dread.disaster.area>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 12, 2020 at 11:23:45AM +1000, Dave Chinner wrote:
> On Tue, Aug 11, 2020 at 01:55:30PM -0400, Vivek Goyal wrote:
> > On Tue, Aug 11, 2020 at 08:22:38AM +1000, Dave Chinner wrote:
> > > On Fri, Aug 07, 2020 at 03:55:21PM -0400, Vivek Goyal wrote:
> > > > We need some kind of locking mechanism here. Normal file systems like
> > > > ext4 and xfs seems to take their own semaphore to protect agains
> > > > truncate while fault is going on.
> > > > 
> > > > We have additional requirement to protect against fuse dax memory range
> > > > reclaim. When a range has been selected for reclaim, we need to make sure
> > > > no other read/write/fault can try to access that memory range while
> > > > reclaim is in progress. Once reclaim is complete, lock will be released
> > > > and read/write/fault will trigger allocation of fresh dax range.
> > > > 
> > > > Taking inode_lock() is not an option in fault path as lockdep complains
> > > > about circular dependencies. So define a new fuse_inode->i_mmap_sem.
> > > 
> > > That's precisely why filesystems like ext4 and XFS define their own
> > > rwsem.
> > > 
> > > Note that this isn't a DAX requirement - the page fault
> > > serialisation is actually a requirement of hole punching...
> > 
> > Hi Dave,
> > 
> > I noticed that fuse code currently does not seem to have a rwsem which
> > can provide mutual exclusion between truncation/hole_punch path
> > and page fault path. I am wondering does that mean there are issues
> > with existing code or something else makes it unnecessary to provide
> > this mutual exlusion.
> 
> I don't know enough about the fuse implementation to say. What I'm
> saying is that nothing in the core mm/ or VFS serilises page cache
> access to the data against direct filesystem manipulations of the
> underlying filesystem structures.

Hi Dave,

Got it. I was checking nfs and they also seem to be calling filemap_fault
and not taking any locks to block faults. fallocate() (nfs42_fallocate)
seems to block read/write/aio/dio but does not seem to do anything
about blocking faults. I am wondering if remote filesystem are
little different in this aspect. Especially fuse does not maintain
any filesystem block/extent data. It is file server which is doing
all that.

> 
> i.e. nothing in the VFS or page fault IO path prevents this race
> condition:
> 
> P0				P1
> fallocate
> page cache invalidation
> 				page fault
> 				read data
> punch out data extents
> 				<data exposed to userspace is stale>
> 				<data exposed to userspace has no
> 				backing store allocated>
> 
> 
> That's where the ext4 and XFS internal rwsem come into play:
> 
> fallocate
> down_write(mmaplock)
> page cache invalidation
> 				page fault
> 				down_read(mmaplock)
> 				<blocks>
> punch out data
> up_write(mmaplock)
> 				<unblocks>
> 				<sees hole>
> 				<allocates zeroed pages in page cache>
> 
> And there's not stale data exposure to userspace.

Got it. I noticed that both fuse/nfs seem to have reversed the
order of operation. They call server to punch out data first
and then truncate page cache. And that should mean that even
if mmap reader will not see stale data after fallocate(punch_hole)
has finished.

> 
> It's the same reason that we use the i_rwsem to prevent concurrent
> IO while a truncate or hole punch is in progress. The IO could map
> the extent, then block in the IO path, while the filesytsem
> re-allocates and writes new data or metadata to those blocks. That's
> another potential non-owner data exposure problem.
> 
> And if you don't drain AIO+DIO before truncate/hole punch, the
> i_rwsem does not protect you against concurrent IO as that gets
> dropped after the AIO is submitted and returns EIOCBQUEUED to the
> AIO layer. Hence there's IO in flight that isn't tracked by the
> i_rwsem or the MMAPLOCK, and if you punch out the blocks and
> reallocate them while the IO is in flight....
> 
> > > > @@ -3849,9 +3856,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
> > > >  			file_update_time(file);
> > > >  	}
> > > >  
> > > > -	if (mode & FALLOC_FL_PUNCH_HOLE)
> > > > +	if (mode & FALLOC_FL_PUNCH_HOLE) {
> > > > +		down_write(&fi->i_mmap_sem);
> > > >  		truncate_pagecache_range(inode, offset, offset + length - 1);
> > > > -
> > > > +		up_write(&fi->i_mmap_sem);
> > > > +	}
> > > >  	fuse_invalidate_attr(inode);
> > > 
> > > 
> > > I'm not sure this is sufficient. You have to lock page faults out
> > > for the entire time the hole punch is being performed, not just while
> > > the mapping is being invalidated.
> > > 
> > > That is, once you've taken the inode lock and written back the dirty
> > > data over the range being punched, you can then take a page fault
> > > and dirty the page again. Then after you punch the hole out,
> > > you have a dirty page with non-zero data in it, and that can get
> > > written out before the page cache is truncated.
> > 
> > Just for my better udnerstanding of the issue, I am wondering what
> > problem will it lead to.
> > If one process is doing punch_hole and other is writing in the
> > range being punched, end result could be anything. Either we will
> > read zeroes from punched_hole pages or we will read the data
> > written by process writing to mmaped page, depending on in what
> > order it got executed. 
> >
> > If that's the case, then holding fi->i_mmap_sem for the whole
> > duration might not matter. What am I missing?
> 
> That it is safe to invalidate the page cache after the hole has been
> punched.

That's precisely both fuse and nfs seem to be doing. truncate page
cache after server has hole punched the file. (nfs42_proc_deallocate()
and fuse_file_fallocate()). I don't understand the nfs code, but
that seems to be the case from a quick look.

> 
> There is nothing stopping, say, memory reclaim from reclaiming pages
> over the range while the hole is being punched, then having the
> application refault them while the backing store is being freed.
> While the page fault read IO is in progress, there's nothing
> stopping the filesystem from freeing those blocks, nor reallocating
> them and writing something else to them (e.g. metadata). So they
> could read someone elses data.
> 
> Even worse: the page fault is a write fault, it lands in a hole, has
> space allocated, the page cache is zeroed, page marked dirty, and
> then the hole punch calls truncate_pagecache_range() which tosses
> away the zeroed page and the data the userspace application wrote
> to the page.

But isn't that supposed to happen. If fallocate(hole_punch) and mmaped
write are happening at the same time, then there is no guarantee
in what order they will execute. App might read back data it wrote
or might read back zeros depdening on order it was executed. (Even
with proper locking).

> 
> The application then refaults the page, reading stale data off
> disk instead of seeing what it had already written to the page....
> 
> And unlike truncated pages, the mm/ code cannot reliably detect
> invalidation races on lockless lookup of pages that are within EOF.
> They rely on truncate changing the file size before page
> invalidation to detect races as page->index then points beyond EOF.
> Hole punching does not change inode size, so the page cache lookups
> cannot tell the difference between a new page that just needs IO to
> initialise the data and a page that has just been invalidated....
> 
> IOWs, there are many ways things can go wrong with hole punch, and
> the only way to avoid them all is to do invalidate and lock out the
> page cache before starting the fallocate operation. i.e.:
> 
> 	1. lock up the entire IO path (vfs and page fault)
> 	2. drain the AIO+DIO path
> 	3. write back dirty pages
> 	4. invalidate the page cache

I see that this is definitely safe. Stop all read/write/faults/aio/dio
before proceeding with punching hole and invalidating page cache.

I think for my purpose, I need to take fi->i_mmap_sem in memory
range freeing path and need to exactly do all the above to make
sure that no I/O, fault or AIO/DIO is going on before I take
away the memory range I have allocated for that inode offset. This
is I think very similar to assigning blocks/extents and taking
these away. In that code path I am already taking care of
taking inode lock as well as i_mmap_sem. But I have not taken
care of AIO/DIO stuff. I will introduce that too.

For the time being I will handle this fallocate/ftruncate possible
races in a separate patch series. To me it makes sense to do what
ext4/xfs are doing. But there might be more to it when it comes
to remote filesystems... 

Miklos, WDYT. Shall I modify fuse fallocate/ftruncate code to 
block all faults/AIO/DIO as well before we get down to the
task of writing back pages, truncating page cache and punching
hole.

> 
> Because this is the only way we can guarantee that nothing can access
> the filesystem's backing store for the range we are about to
> directly manipulate the data in while we perform an "offloaded" data
> transformation on that range...
> 
> This isn't just hole punch - the same problems exist with
> FALLOC_FL_ZERO_RANGE and FALLOC_FL_{INSERT,COLLAPSE}_RANGE because
> they change data with extent manipulations and/or hardware offloads
> that provide no guarantees of specific data state or integrity until
> they complete....

Ok. As of now fuse seems to have blocked all extra fallocate operations
like ZERO_RANGE, INSERT, COLLAPSE.

Thanks
Vivek

