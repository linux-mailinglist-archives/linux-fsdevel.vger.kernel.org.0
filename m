Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0414942CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jan 2022 23:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbiASWHy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jan 2022 17:07:54 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:56233 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236813AbiASWHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jan 2022 17:07:53 -0500
Received: from dread.disaster.area (pa49-179-45-11.pa.nsw.optusnet.com.au [49.179.45.11])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id CA2DB62B732;
        Thu, 20 Jan 2022 09:07:49 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nAJ7L-001pwk-Vj; Thu, 20 Jan 2022 09:07:48 +1100
Date:   Thu, 20 Jan 2022 09:07:47 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <20220119220747.GF59729@dread.disaster.area>
References: <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
 <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
 <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
 <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
 <20220118232547.GD59729@dread.disaster.area>
 <YegbVhxSNtQFlSCr@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YegbVhxSNtQFlSCr@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=61e88bb8
        a=Eslsx4mF8WGvnV49LKizaA==:117 a=Eslsx4mF8WGvnV49LKizaA==:17
        a=kj9zAlcOel0A:10 a=DghFqjY3_ZEA:10 a=7-415B0cAAAA:8
        a=ajwNnfqt_jgpfc7MgyAA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:08:22AM -0500, Brian Foster wrote:
> On Wed, Jan 19, 2022 at 10:25:47AM +1100, Dave Chinner wrote:
> > On Tue, Jan 18, 2022 at 05:58:14AM +0000, Al Viro wrote:
> > > On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:
> > Unfortunately, the simple fix of adding syncronize_rcu() to
> > xfs_iget_recycle() causes significant performance regressions
> > because we hit this path quite frequently when workloads use lots of
> > temporary files - the on-disk inode allocator policy tends towards
> > aggressive re-use of inodes for small sets of temporary files.
> > 
> > The problem XFS is trying to address is that the VFS inode lifecycle
> > does not cater for filesystems that need to both dirty and then
> > clean unlinked inodes between iput_final() and ->destroy_inode. It's
> > too late to be able to put the inode back on the LRU once we've
> > decided to drop the inode if we need to dirty it again. ANd because
> > evict() is part of the non-blocking memory reclaim, we aren't
> > supposed to block for arbitrarily long periods of time or create
> > unbound memory demand processing inode eviction (both of which XFS
> > can do in inactivation).
> > 
> > IOWs, XFS can't free the inode until it's journal releases the
> > internal reference on the dirty inode. ext4 doesn't track inodes in
> > it's journal - it only tracks inode buffers that contain the changes
> > made to the inode, so once the transaction is committed in
> > ext4_evict_inode() the inode can be immediately freed via either
> > ->destroy_inode or ->free_inode. That option does not exist for XFS
> > because we have to wait for the journal to finish with the inode
> > before it can be freed. Hence all the background reclaim stuff.
> > 
> > We've recently solved several of the problems we need to solve to
> > reduce the mismatch; avoiding blocking on inode writeback in reclaim
> > and background inactivation are two of the major pieces of work we
> > needed done before we could even consider more closely aligning XFS
> > to the VFS inode cache life cycle model.
> > 
> 
> The background inactivation work facilitates an incremental improvement
> by nature because destroyed inodes go directly to a queue instead of
> being processed synchronously. My most recent test to stamp the grace
> period info at inode destroy time and conditionally sync at reuse time
> shows pretty much no major cost because the common case is that a grace
> period has already expired by the time the queue populates, is processed
> and said inodes become reclaimable and reallocated.

Yup. Remember that I suggested these conditional variants in the
first place - I do understand what this code does...

> To go beyond just
> the performance result, if I open code the conditional sync for tracking
> purposes I only see something like 10-15 rcu waits out of the 36k
> allocation cycles. If I increase the background workload 4x, the
> allocation rate drops to ~33k cycles (which is still pretty much in line
> with baseline) and the rcu sync count increases to 70, which again is
> relatively nominal over tens of thousands of cycles.

Yup. But that doesn't mean that the calls that trigger are free from
impact. The cost and latency of waiting for an RCU grace period to
expire goes up as the CPU count goes up. e.g. it requires every CPU
running a task goes through a context switch before it returns.
Hence if we end up with situations like, say, the ioend completion
scheduling holdoffs, then that will prevent the RCU sync from
returning for seconds.

IOWs, we're effectively adding unpredictable and non-deterministic
latency into the recycle path that is visible to userspace
applications, and those latencies can be caused by subsystem
functionality not related to XFS. Hence we need to carefully
consider unexpected side-effects of adding a kernel global
synchronisation point into a XFS icache lookup fast path, and these
issues may not be immediately obvious from testing...

> This all requires some more thorough testing, but I'm sure it won't be
> absolutely free for every possible workload or environment. But given
> that we know this infrastructure is fundamentally broken (by subtle
> compatibilities between XFS and the VFS that have evolved over time),
> will require some thought and time to fix properly in the filesystem,
> that users are running into problems very closely related to it, why not
> try to address the fundamental breakage if we can do so with an isolated
> change with minimal (but probably not zero) performance impact?
> 
> I agree that the unconditional synchronize_rcu() on reuse approach is
> just not viable, but so far tests using cond_synchronize_rcu() seem
> fairly reasonable. Is there some other problem or concern with such an
> approach?

Just that the impact of adding RCU sync points means that bad
behaviour outside XFS have a new point where they can adversely
impact on applications doing filesystem operations.

As a temporary mitigation strategy I think it will probably be fine,
but I'd much prefer we get rid of the need for such an RCU sync
point rather than try to maintain a mitigation like this in fast
path code forever.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
