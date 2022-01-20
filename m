Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF52495273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 17:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377055AbiATQeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 11:34:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377049AbiATQep (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642696484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AM0qBCzLEFCiAWlXq2pEOv2LGLsPZzb4j9Jyt3qne9Y=;
        b=Z9gfjgurLKBIki2z6gQcNMdKR+ZiQrT/rzLQEO3o332Kt1G8iKrsLwMzdVNooU2JwK6Umb
        a/xBDYpQc77Y1fccRjtjiWva6Jl3T4T+qqGe1Xxw8e8fyqEPHgWan9FAIxqIJZTsOVxlKX
        QbOzSAnLCHeggr7a3+Ye2bPhyEMj+1I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-V-8Ke5M1P0aIEHHU8Ox-XA-1; Thu, 20 Jan 2022 11:34:43 -0500
X-MC-Unique: V-8Ke5M1P0aIEHHU8Ox-XA-1
Received: by mail-qk1-f197.google.com with SMTP id o3-20020a375a03000000b0047bc1e51002so4480952qkb.19
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 08:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AM0qBCzLEFCiAWlXq2pEOv2LGLsPZzb4j9Jyt3qne9Y=;
        b=4+xN+j5qRe5w9/Gsb9C9omJ8rY7o5kqgkSnE/MQo0kPVPb3j1D0qm6XblHk5ReOqvg
         jYIKxkdzkbQZPT8KqQdJCZNeEZ7tirpdeckYY34FH8NukmmMbGlMlNawtHyYjpgoJNer
         YzC1njsJ+ZbIy8nVkNqWXZGQX+mY1gWM0GUt/hZdb8rLsMmpOOvhU/qscTn4YwkpJLIN
         D4krscf56ukoJm0u5mATpwFROFKH/Waqe2kVfKZwTlM9Y0MEmARJhBVliXcjFcR7Pz+z
         y6PEPtvmA3sPkALnRgnLNwN6GQ3HJvgxk085IQE5bZpG8LqkoIY2FUbzDJ9Mj5bULCXm
         Morg==
X-Gm-Message-State: AOAM5304BwnzS0+vphGqlYRoqx8+lLBFHBK3Bw86Ou4G0IKaECn2lJ3q
        pKBYh23zMSWKxAz++EKiLQwsbJGP6yDo/fES3DVLbvTILvd32QKJb+btis+uHpEHU1ekeSg2BaF
        3inWwkxUyisb4/SiXN5XH6YHEqA==
X-Received: by 2002:a05:620a:10b9:: with SMTP id h25mr16226331qkk.86.1642696482755;
        Thu, 20 Jan 2022 08:34:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy45hLLlEXDgJWQCyIgVrfOzyLo/XgfbESOk0FLkRWp9iKdgAICffqFgQ1ngztp251f5dHScg==
X-Received: by 2002:a05:620a:10b9:: with SMTP id h25mr16226303qkk.86.1642696482419;
        Thu, 20 Jan 2022 08:34:42 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id az13sm1698420qkb.99.2022.01.20.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 08:34:42 -0800 (PST)
Date:   Thu, 20 Jan 2022 11:34:39 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
Message-ID: <YemPH7vT+VW7xoCT@bfoster>
References: <YeV+zseKGNqnSuKR@bfoster>
 <YeWZRL88KPtLWlkI@zeniv-ca.linux.org.uk>
 <20220118030041.GB59729@dread.disaster.area>
 <YeYxOadA0HgYfBjt@zeniv-ca.linux.org.uk>
 <20220118041253.GC59729@dread.disaster.area>
 <YeZW9s7x2uCBfNJD@zeniv-ca.linux.org.uk>
 <20220118232547.GD59729@dread.disaster.area>
 <YegbVhxSNtQFlSCr@bfoster>
 <20220119220747.GF59729@dread.disaster.area>
 <YemH0LML9ZVUnrEX@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YemH0LML9ZVUnrEX@bfoster>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:03:28AM -0500, Brian Foster wrote:
> On Thu, Jan 20, 2022 at 09:07:47AM +1100, Dave Chinner wrote:
> > On Wed, Jan 19, 2022 at 09:08:22AM -0500, Brian Foster wrote:
> > > On Wed, Jan 19, 2022 at 10:25:47AM +1100, Dave Chinner wrote:
> > > > On Tue, Jan 18, 2022 at 05:58:14AM +0000, Al Viro wrote:
> > > > > On Tue, Jan 18, 2022 at 03:12:53PM +1100, Dave Chinner wrote:
> > > > Unfortunately, the simple fix of adding syncronize_rcu() to
> > > > xfs_iget_recycle() causes significant performance regressions
> > > > because we hit this path quite frequently when workloads use lots of
> > > > temporary files - the on-disk inode allocator policy tends towards
> > > > aggressive re-use of inodes for small sets of temporary files.
> > > > 
> > > > The problem XFS is trying to address is that the VFS inode lifecycle
> > > > does not cater for filesystems that need to both dirty and then
> > > > clean unlinked inodes between iput_final() and ->destroy_inode. It's
> > > > too late to be able to put the inode back on the LRU once we've
> > > > decided to drop the inode if we need to dirty it again. ANd because
> > > > evict() is part of the non-blocking memory reclaim, we aren't
> > > > supposed to block for arbitrarily long periods of time or create
> > > > unbound memory demand processing inode eviction (both of which XFS
> > > > can do in inactivation).
> > > > 
> > > > IOWs, XFS can't free the inode until it's journal releases the
> > > > internal reference on the dirty inode. ext4 doesn't track inodes in
> > > > it's journal - it only tracks inode buffers that contain the changes
> > > > made to the inode, so once the transaction is committed in
> > > > ext4_evict_inode() the inode can be immediately freed via either
> > > > ->destroy_inode or ->free_inode. That option does not exist for XFS
> > > > because we have to wait for the journal to finish with the inode
> > > > before it can be freed. Hence all the background reclaim stuff.
> > > > 
> > > > We've recently solved several of the problems we need to solve to
> > > > reduce the mismatch; avoiding blocking on inode writeback in reclaim
> > > > and background inactivation are two of the major pieces of work we
> > > > needed done before we could even consider more closely aligning XFS
> > > > to the VFS inode cache life cycle model.
> > > > 
> > > 
> > > The background inactivation work facilitates an incremental improvement
> > > by nature because destroyed inodes go directly to a queue instead of
> > > being processed synchronously. My most recent test to stamp the grace
> > > period info at inode destroy time and conditionally sync at reuse time
> > > shows pretty much no major cost because the common case is that a grace
> > > period has already expired by the time the queue populates, is processed
> > > and said inodes become reclaimable and reallocated.
> > 
> > Yup. Remember that I suggested these conditional variants in the
> > first place - I do understand what this code does...
> > 
> > > To go beyond just
> > > the performance result, if I open code the conditional sync for tracking
> > > purposes I only see something like 10-15 rcu waits out of the 36k
> > > allocation cycles. If I increase the background workload 4x, the
> > > allocation rate drops to ~33k cycles (which is still pretty much in line
> > > with baseline) and the rcu sync count increases to 70, which again is
> > > relatively nominal over tens of thousands of cycles.
> > 
> > Yup. But that doesn't mean that the calls that trigger are free from
> > impact. The cost and latency of waiting for an RCU grace period to
> > expire goes up as the CPU count goes up. e.g. it requires every CPU
> > running a task goes through a context switch before it returns.
> > Hence if we end up with situations like, say, the ioend completion
> > scheduling holdoffs, then that will prevent the RCU sync from
> > returning for seconds.
> > 
> 
> Sure... this is part of the reason the tests I've run so far have all
> tried to incorporate background rcuwalk activity, run on a higher cpu
> count box, etc. And from the XFS side of the coin, the iget code can
> invoke xfs_inodegc_queue_all() in the needs_inactive case before
> reclaimable state is a possibility, which queues a work on every cpu
> with pending inactive inodes. That is probably unlikely in the
> free/alloc case (since needs_inactive inodes are not yet free on disk),
> but the broader points are that the inactive processing work has to
> complete one way or another before reclaimable state is possible and
> that we can probably accommodate a synchronization point here if it's
> reasonably filtered. Otherwise...
> 
> > IOWs, we're effectively adding unpredictable and non-deterministic
> > latency into the recycle path that is visible to userspace
> > applications, and those latencies can be caused by subsystem
> > functionality not related to XFS. Hence we need to carefully
> > consider unexpected side-effects of adding a kernel global
> > synchronisation point into a XFS icache lookup fast path, and these
> > issues may not be immediately obvious from testing...
> > 
> 
> ... agreed. I think at this point we've also discussed various potential
> ways to shift or minimize latency/cost further, so there's probably
> still room for refinement if such unexpected things crop up before...
> 
> > > This all requires some more thorough testing, but I'm sure it won't be
> > > absolutely free for every possible workload or environment. But given
> > > that we know this infrastructure is fundamentally broken (by subtle
> > > compatibilities between XFS and the VFS that have evolved over time),
> > > will require some thought and time to fix properly in the filesystem,
> > > that users are running into problems very closely related to it, why not
> > > try to address the fundamental breakage if we can do so with an isolated
> > > change with minimal (but probably not zero) performance impact?
> > > 
> > > I agree that the unconditional synchronize_rcu() on reuse approach is
> > > just not viable, but so far tests using cond_synchronize_rcu() seem
> > > fairly reasonable. Is there some other problem or concern with such an
> > > approach?
> > 
> > Just that the impact of adding RCU sync points means that bad
> > behaviour outside XFS have a new point where they can adversely
> > impact on applications doing filesystem operations.
> > 
> > As a temporary mitigation strategy I think it will probably be fine,
> > but I'd much prefer we get rid of the need for such an RCU sync
> > point rather than try to maintain a mitigation like this in fast
> > path code forever.
> > 
> 
> ... we end up here. All in all, this is intended to be a
> practical/temporary step toward functional correctness that minimizes
> performance impact and disruption (i.e. just as easy to remove when made
> unnecessary).
> 
> Al,
> 
> The caveat to this is I think the practicality of a conditional sync in
> the iget recycle code sort of depends on the queueing/batching nature of
> inactive inode processing in XFS. If you look at xfs_fs_destroy_inode()
> for example, you'll see this is all fairly recent feature/infrastructure
> code and that historically we completed most of this transition to
> reclaimable state before ->destroy_inode() returns. Therefore, the
> concern I have is that on older/stable kernels (where users are hitting
> this NULL ->get_link() BUG) the reuse code is far more likely to stall
> and slow down here with this change alone (see my earlier numbers on the
> unconditional sync_rcu() test for prospective worst case). For that
> reason, I'm not sure this is really a backportable solution.
> 
> So getting back to your concern around Ian's patch being a
> stopgap/bandaid type solution, would you be willing to pull something
> like Ian's patch to the vfs if upstream XFS adopts this conditional rcu
> sync in the iget reuse code? I think that would ensure that no further
> bandaid fixes will be required in the vfs due to XFS inode reuse, but
> would also provide an isolated variant of the fix in the VFS that is
> more easily backported to stable kernels. Thoughts?
> 
> Brian
> 

Oh and I meant to throw up a diff of what I was testing for reference.
My test code was significantly more hacked up with debug code and such,
but if I clean it up a bit the change reduces to the diff below.

Brian

--- 8< ---

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index d019c98eb839..8a24ced4d73a 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -349,6 +349,10 @@ xfs_iget_recycle(
 	spin_unlock(&ip->i_flags_lock);
 	rcu_read_unlock();
 
+	ASSERT(ip->i_destroy_gp != 0);
+	cond_synchronize_rcu(ip->i_destroy_gp);
+	ip->i_destroy_gp = 0;
+
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	error = xfs_reinit_inode(mp, inode);
 	if (error) {
@@ -2019,6 +2023,7 @@ xfs_inodegc_queue(
 	trace_xfs_inode_set_need_inactive(ip);
 	spin_lock(&ip->i_flags_lock);
 	ip->i_flags |= XFS_NEED_INACTIVE;
+	ip->i_destroy_gp = start_poll_synchronize_rcu();
 	spin_unlock(&ip->i_flags_lock);
 
 	gc = get_cpu_ptr(mp->m_inodegc);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index c447bf04205a..a978da2332a0 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -75,6 +75,8 @@ typedef struct xfs_inode {
 	spinlock_t		i_ioend_lock;
 	struct work_struct	i_ioend_work;
 	struct list_head	i_ioend_list;
+
+	unsigned long		i_destroy_gp;
 } xfs_inode_t;
 
 /* Convert from vfs inode to xfs inode */

