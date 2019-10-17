Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8480DDA6D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 09:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405191AbfJQH5c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 03:57:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732594AbfJQH5c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:57:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5788F4E93D;
        Thu, 17 Oct 2019 07:57:31 +0000 (UTC)
Received: from bfoster (dhcp-41-2.bos.redhat.com [10.18.41.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B957C5D9D5;
        Thu, 17 Oct 2019 07:57:30 +0000 (UTC)
Date:   Thu, 17 Oct 2019 03:57:29 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 25/26] xfs: rework unreferenced inode lookups
Message-ID: <20191017075729.GA19442@bfoster>
References: <20191009032124.10541-1-david@fromorbit.com>
 <20191009032124.10541-26-david@fromorbit.com>
 <20191014130719.GE12380@bfoster>
 <20191017012438.GK16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017012438.GK16973@dread.disaster.area>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 17 Oct 2019 07:57:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:24:38PM +1100, Dave Chinner wrote:
> On Mon, Oct 14, 2019 at 09:07:19AM -0400, Brian Foster wrote:
> > On Wed, Oct 09, 2019 at 02:21:23PM +1100, Dave Chinner wrote:
> > > From: Dave Chinner <dchinner@redhat.com>
> > > 
> > > Looking up an unreferenced inode in the inode cache is a bit hairy.
> > > We do this for inode invalidation and writeback clustering purposes,
> > > which is all invisible to the VFS. Hence we can't take reference
> > > counts to the inode and so must be very careful how we do it.
> > > 
> > > There are several different places that all do the lookups and
> > > checks slightly differently. Fundamentally, though, they are all
> > > racy and inode reclaim has to block waiting for the inode lock if it
> > > loses the race. This is not very optimal given all the work we;ve
> > > already done to make reclaim non-blocking.
> > > 
> > > We can make the reclaim process nonblocking with a couple of simple
> > > changes. If we define the unreferenced lookup process in a way that
> > > will either always grab an inode in a way that reclaim will notice
> > > and skip, or will notice a reclaim has grabbed the inode so it can
> > > skip the inode, then there is no need for reclaim to need to cycle
> > > the inode ILOCK at all.
> > > 
> > > Selecting an inode for reclaim is already non-blocking, so if the
> > > ILOCK is held the inode will be skipped. If we ensure that reclaim
> > > holds the ILOCK until the inode is freed, then we can do the same
> > > thing in the unreferenced lookup to avoid inodes in reclaim. We can
> > > do this simply by holding the ILOCK until the RCU grace period
> > > expires and the inode freeing callback is run. As all unreferenced
> > > lookups have to hold the rcu_read_lock(), we are guaranteed that
> > > a reclaimed inode will be noticed as the trylock will fail.
> > > 
> > > 
> > > Additional research notes on final reclaim locking before free
> > > --------------------------------------------------------------
> > > 
> > > 2016: 1f2dcfe89eda ("xfs: xfs_inode_free() isn't RCU safe")
> > > 
> > > Fixes situation where the inode is found during RCU lookup within
> > > the freeing grace period, but critical structures have already been
> > > freed. lookup code that has this problem is stuff like
> > > xfs_iflush_cluster.
> > > 
> > > 
> > > 2008: 455486b9ccdd ("[XFS] avoid all reclaimable inodes in xfs_sync_inodes_ag")
> > > 
> > > Prior to this commit, the flushing of inodes required serialisation
> > > with xfs_ireclaim(), which did this lock/unlock thingy to ensure
> > > that it waited for flushing in xfs_sync_inodes_ag() to complete
> > > before freeing the inode:
> > > 
> > >                 /*
> > > -                * If we can't get a reference on the VFS_I, the inode must be
> > > -                * in reclaim. If we can get the inode lock without blocking,
> > > -                * it is safe to flush the inode because we hold the tree lock
> > > -                * and xfs_iextract will block right now. Hence if we lock the
> > > -                * inode while holding the tree lock, xfs_ireclaim() is
> > > -                * guaranteed to block on the inode lock we now hold and hence
> > > -                * it is safe to reference the inode until we drop the inode
> > > -                * locks completely.
> > > +                * If we can't get a reference on the inode, it must be
> > > +                * in reclaim. Leave it for the reclaim code to flush.
> > >                  */
> > > 
> > > This case is completely gone from the modern code.
> > > 
> > > lock/unlock exists at start of git era. Switching to archive tree.
> > > 
> > > This xfs_sync() functionality goes back to 1994 when inode
> > > writeback was first introduced by:
> > > 
> > > 47ac6d60 ("Add support to xfs_ireclaim() needed for xfs_sync().")
> > > 
> > > So it has been there forever -  lets see if we can get rid of it.
> > > State of existing codeL
> > > 
> > > - xfs_iflush_cluster() does not check for XFS_IRECLAIM inode flag
> > >   while holding rcu_read_lock()/i_flags_lock, so doesn't avoid
> > >   reclaimable or inodes that are in the process of being reclaimed.
> > >   Inodes at this point of reclaim are clean, so if xfs_iflush_cluster
> > >   wins the race to the ILOCK, then inode reclaim has to wait
> > >   for the lock to be dropped by xfs_iflush_cluster() once it detects
> > >   the inode is clean.
> > > 
> > 
> > Ok, so the iflush/ifree clustering functionality doesn't account for
> > inodes under reclaim, thus has the potential to contend with reclaim in
> > progress via ilock. The new isolate function trylocks the ilock and
> > iflock to check dirty state and whatnot before it sets XFS_IRECLAIM and
> > continues scanning, so we aren't blocking through that code. Both of
> > those locks are held until the dispose, where ->i_ino is zeroed and
> > ilock released.
> 
> Not quite. The XFS_IRECLAIM flag indicates the inode has been
> isolated but may not yet have been disposed. There can be a
> substantial delay between isolation and disposal, and the ip->i_ino
> is not cleared until disposal is run. IOWs, it handles this case:
> 
> reclaim:				iflush/ifree
> 
> isolate
>   spin_trylock(ip->i_flags_lock)
>   xfs_ilock_nowait(ip, ILOCK_EXCL)
>   xfs_iflock(ip)
>   ip->i_flags |= XFS_IRECLAIM
>   spin_unlock(ip->i_flags_lock);
> <loops isolating more inodes>
> 					rcu_read_lock()
> 					ip = radix_tree_lookup()
> 					spin_lock(ip->i_flags_lock)
> 					ip->i_ino still set
> 					if XFS_IRECLAIM set
> 					  <skip inode>
> 
> So when the inode has been isolated, we see the XFS_IRECLAIM just
> fine because of the i_flags_lock.
> 
> The reason why the ILOCK is taken under the i_flags_lock in
> iflush/ifree is that we can have this happen if we drop the spin
> lock first:
> 
> 					ip = radix_tree_lookup()
> 					spin_lock(ip->i_flags_lock)
> 					ip->i_ino still set
> 					if XFS_IRECLAIM set
> 					  skip inode
> 					spin_unlock(ip->i_flags_lock)
> 					rcu_read_unlock()
> 					<preempted>
> isolate
>   spin_trylock(ip->i_flags_lock)
>   xfs_ilock_nowait(ip, ILOCK_EXCL)
>   xfs_iflock(ip)
>   ip->i_flags |= XFS_IRECLAIM
>   spin_unlock(ip->i_flags_lock);
> dispose inode
>   rcu_free
> <...>
> rcu_callbacks
>   xfs_iunlock(ip, ILOCK_EXCL)
>   kmem_cache_free(ip)
> 					<scheduled again>
> 					xfs_ilock_nowait(ip, ILOCK_EXCL)
> 					accesses freed inode
> 
> IOWs, it's the combination of using the same locking heirarchy in
> the isolation routine and the iflush/ifree that provide the
> serialisation. We have to serialise the taking of the ILOCK under
> the i_flags_lock, because it's the i_flags_lock that actually
> provides the RCU lookup object validity serialisation. Hence we have
> to ensure that the inode cannot be reclaimed via RCU callbacks while
> under the rcu_read_lock context. That means we have to:
> 
> a) hold off RCU freeing of inodes (rcu_read_lock)
> b) hold the object spinlock to ensure the object is not yet 
> queued for RCU freeing (!ip->i_ino checks)
> c) Hold the object spin lock to ensure the object has not been
> locked for reclaim and is about to be disposed (XFS_IRECLAIM checks)
> d) Hold the object spinlock while we grab the lock(s) that will hold
> off reclaim once we drop the object spin lock until we are finished
> with the object (ILOCK -> iflock)
> 
> So XFS_IRECLAIM plays a part in this dance, but it's only one step
> in the process...
> 

Yeah, I grok the reclaim isolation stuff (for the most part). My comment
above was trying to reason through where/how this process actually
blocks reclaim, which is the problem described in the commit log
description.

> > I'd think at this point a racing iflush/ifree would see the ->i_ino
> > update. If I'm following this correctly, blocking in reclaim would
> > require a race where iflush gets ->i_flags_lock and sees a valid
> > ->i_ino, a reclaim in progress is waiting on ->i_flags_lock to reset
> > ->i_ino, iflush releases ->i_flags_lock in time for reclaim to acquire
> > it, reset ->i_ino and then release ilock before the iflush ilock_nowait
> > fails (since reclaim still has it) or reclaim itself reacquires it. At
> > that point, reclaim blocks on ilock and ends up waiting on iflush to
> > identify that ->i_ino is zero and drop the lock. Am I following that
> > correctly?
> > 
> > If so, then to avoid that race condition (this sounds more like a lock
> > contention inefficiency than a blocking problem),
> 
> It's not a contention issue - there's real bugs if we don't order
> the locking correctly here.
> 

Is this patch fixing real bugs in the existing code or reducing
contention/blocking in the reclaim codepath? My understanding was the
latter, so thus I'm trying to make sure I follow how this blocking can
actually happen that this patch purports to address. The reasoning in my
comment above is basically how I followed the existing code as it
pertains to blocking in reclaim, and that is the scenario I was asking
about...

Brian

> Cheers,
> 
> Dave.
> 
> -- 
> Dave Chinner
> david@fromorbit.com
