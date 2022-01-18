Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5A8491E6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 05:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiAREM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 23:12:58 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:59182 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230055AbiAREM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 23:12:57 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 23DA562C1BB;
        Tue, 18 Jan 2022 15:12:54 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1n9frZ-001999-LL; Tue, 18 Jan 2022 15:12:53 +1100
Date:   Tue, 18 Jan 2022 15:12:53 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220118041253.GC59729@dread.disaster.area>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
 <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61e63e48
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=2CF9Hwn2lFnZscYVSWIA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 03:17:13AM +0000, Al Viro wrote:
> On Tue, Jan 18, 2022 at 02:00:41PM +1100, Dave Chinner wrote:
> > > IOW, how far is xfs_inode_mark_reclaimable() from being callable in RCU
> > > callback context?
> > 
> > AIUI, not very close at all,
> > 
> > I'm pretty sure we can't put it under RCU callback context at all
> > because xfs_fs_destroy_inode() can take sleeping locks, perform
> > transactions, do IO, run rcu_read_lock() critical sections, etc.
> > This means that needs to run an a full task context and so can't run
> > from RCU callback context at all.
> 
> Umm...  AFAICS, this
> 	pag = xfs_perag_get(mp, XFS_INO_TO_AGNO(mp, ip->i_ino));
> 	spin_lock(&pag->pag_ici_lock);
> 	spin_lock(&ip->i_flags_lock);
> 
> 	trace_xfs_inode_set_reclaimable(ip);
> 	ip->i_flags &= ~(XFS_NEED_INACTIVE | XFS_INACTIVATING);
> 	ip->i_flags |= XFS_IRECLAIMABLE;
> 	xfs_perag_set_inode_tag(pag, XFS_INO_TO_AGINO(mp, ip->i_ino),
> 	XFS_ICI_RECLAIM_TAG);
> 
> 	spin_unlock(&ip->i_flags_lock);
> 	spin_unlock(&pag->pag_ici_lock);
> 	xfs_perag_put(pag);
>
> in the end of xfs_inodegc_set_reclaimable() could go into ->free_inode()
> just fine.

No, that just creates a black hole where the VFS inode has been
destroyed but the XFS inode cache doesn't know it's been trashed.
Hence setting XFS_IRECLAIMABLE needs to remain in the during
->destroy_inode, otherwise the ->lookup side of the cache will think
that are currently still in use by the VFS and hand them straight
back out without going through the inode recycling code.

i.e. XFS_IRECLAIMABLE is the flag that tells xfs_iget() that the VFS
part of the inode has been torn down, and that it must go back
through VFS re-initialisation before it can be re-instantiated as a
VFS inode.

It would also mean that the inode will need to go through two RCU
grace periods before it gets reclaimed, because XFS uses RCU
protected inode cache lookups internally (e.g. for clustering dirty
inode writeback) and so freeing the inode from the internal
XFS inode cache requires RCU freeing...

> It's xfs_inodegc_queue() I'm not sure about - the part
> about flush_work() in there...

That's the bit that prevents unbound queuing of inodes that require
inactivation because of the problems that causes memory reclaim and
performance. It blocks waiting for xfs_inactive()
calls to complete via xfs_inodegc_worker(), and it's the
xfs_inactive() calls that do all the IO, transactions, locking, etc.

So if we block waiting for them to complete in RCU callback context,
we're effectively inverting the current locking order for entire
filesystem w.r.t. RCU...

Also worth considering: if we are processing the unlink of an inode
with tens or hundreds of millions of extents in xfs_inactive(), that
flush_work() call could block for *minutes* waiting on inactivation
to run the millions of transactions needed to free that inode.
Regardless of lock ordering, we don't want to block RCU grace period
callback work for that long....

> I'm not familiar with that code; could you point me towards some
> docs/old postings/braindump/whatnot?

Commit ab23a7768739 ("xfs: per-cpu deferred inode inactivation
queues") explains the per-cpu queuing mechanism that is being used
in this code.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
