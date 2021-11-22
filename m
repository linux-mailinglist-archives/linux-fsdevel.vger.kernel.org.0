Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7457459597
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Nov 2021 20:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbhKVTbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 14:31:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239940AbhKVTbO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 14:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637609285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNcYibNmBUcfZkggdoK8hnFuKZchVdYBDp3qTV9U7K0=;
        b=O7jNw/GiJJI4jgktjao7yvtiezaP8Udrwx3gykMAIp/S3D23ziKgx3vLJ4//r5SSdB7Vwq
        eKyJYzvNo0oTCnXpQUW29CyxFhMpqyPXOq7asCquQnQ1zyQ1y1rBa+p6TKD9vFNlYGNiFN
        gBQ3YH6KvSlqTVINud7GUlwai/USMu8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-jiKC8G3ROBGRUblBTigwyQ-1; Mon, 22 Nov 2021 14:28:04 -0500
X-MC-Unique: jiKC8G3ROBGRUblBTigwyQ-1
Received: by mail-qt1-f200.google.com with SMTP id u14-20020a05622a198e00b002b2f35a6dcfso11370883qtc.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Nov 2021 11:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pNcYibNmBUcfZkggdoK8hnFuKZchVdYBDp3qTV9U7K0=;
        b=56YXoCIeVSmN78pgs9t80akVk39dVDNPyu86jbXQhAyiyMw0qG4HVhrJJZFRvFw6kp
         Kn0Fu3KJrh/5QP1g3wGbQmVteTqu7i6K5FKbx3YBw9CtFZX8liiA4G6QzNVfVWS4soWb
         k1WDaZbZ5QktCnp/jjcDiPcvZa7xv6PfOobzJUxX+7M/j+9X62ZsHgGPIOGz++pZPvPH
         81MLPtkr5bcsVJXKr0IfbOyNXCgzRqO5TvHrM7dgVq0YfpBW+ncuPNs7VZG56w9IhrQ6
         DfPyhpZM2JOqOxVY3noyLiEBZH+7YDVlFG/EVukVCVSJtICw/o7GsKmJ2XYGZkASEWNk
         6J2w==
X-Gm-Message-State: AOAM533zIBBHNE21Bivmev4BFpyE+nhXL8uVZis5tyf7dfdwoNbbjaoF
        YFGxpwm8DTtcPeQS4KbVfHMCjUr6siDd7RenbYh55iOenStuuCMfffBcOOFFg/OFmcjlLjeseSS
        cDYbgkQL2rMAQwId601HxxNNidQ==
X-Received: by 2002:a05:622a:130f:: with SMTP id v15mr34079080qtk.122.1637609283660;
        Mon, 22 Nov 2021 11:28:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJziFww9Z3qQSNr4r5lr8dZ4A2+nkum+t0KJu1XKbcQZWKoOE1wI52lFK5wjNGEbEp9T41tQ3w==
X-Received: by 2002:a05:622a:130f:: with SMTP id v15mr34079039qtk.122.1637609283261;
        Mon, 22 Nov 2021 11:28:03 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id x21sm4846491qkf.77.2021.11.22.11.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 11:28:02 -0800 (PST)
Date:   Mon, 22 Nov 2021 14:27:59 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <YZvvP9RFXi3/jX0q@bfoster>
References: <CAJfpegu4BwJD1JKngsrzUs7h82cYDGpxv0R1om=WGhOOb6pZ2Q@mail.gmail.com>
 <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <YZVQUSCWWgOs+cRB@bfoster>
 <20211117214852.GU449541@dread.disaster.area>
 <YZf+lRsb0lBWdYgN@bfoster>
 <20211122000851.GE449541@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122000851.GE449541@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 11:08:51AM +1100, Dave Chinner wrote:
> On Fri, Nov 19, 2021 at 02:44:21PM -0500, Brian Foster wrote:
> > On Thu, Nov 18, 2021 at 08:48:52AM +1100, Dave Chinner wrote:
> > > On Wed, Nov 17, 2021 at 01:56:17PM -0500, Brian Foster wrote:
> > > > On Wed, Nov 17, 2021 at 11:22:51AM +1100, Dave Chinner wrote:
> > > > Only a single grace period is required to cover
> > > > (from the rcuwalk perspective) the entire set of inodes queued for
> > > > inactivation. That leaves at least a few fairly straightforward options:
> > > > 
> > > > 1. Use queue_rcu_work() to schedule the inactivation task. We'd probably
> > > > have to isolate the list to process first from the queueing context
> > > > rather than from workqueue context to ensure we don't process recently
> > > > added inodes that haven't sat for a grace period.
> > > 
> > > No, that takes too long. Long queues simply mean deferred
> > > inactivation is working on cold CPU caches and that means we take a
> > > 30-50% performance hit on inode eviction overhead for inodes that
> > > need inactivation (e.g. unlinked inodes) just by having to load all
> > > the inode state into CPU caches again.
> > > 
> > > Numbers I recorded at the time indicate that inactivation that
> > > doesn't block on IO or the log typically takes between 200-500us
> > > of CPU time, so the deferred batch sizes are sized to run about
> > > 10-15ms worth of deferred processing at a time. Filling a batch
> > > takes memory reclaim about 200uS to fill when running
> > > dispose_list() to evict inodes.
> > > 
> > > The problem with using RCU grace periods is that they delay the
> > > start of the work for at least 10ms, sometimes hundreds of ms.
> > > Using queue_rcu_work() means we will need to go back to unbound
> > > depth queues to avoid blocking waiting for grace period expiry to
> > > maintain perfomrance. THis means having tens of thousands of inodes
> > > queued for inactivation before the workqueue starts running. These
> > > are the sorts of numbers that caused all the problems Darrick was
> > > having with performance, and that was all cold cache loading
> > > overhead which is unavoidable with such large queue depths....
> > > 
> > 
> > Hm, Ok. I recall the large queue depth issues on the earlier versions
> > but had not caught up with the subsequent changes that limit (percpu)
> > batch size, etc. The cond sync rcu approach is easy enough to hack in
> > (i.e., sample gp on destroy, cond_sync_rcu() on inactivate) that I ran a
> > few experiments on opposing ends of the spectrum wrt to concurrency.
> > 
> > The short of it is that I do see about a 30% hit in the single threaded
> > sustained removal case with current batch sizes. If the workload scales
> > out to many (64) cpus, the impact dissipates, I suspect because we've
> > already distributed the workload across percpu wq tasks and thus drive
> > the rcu subsystem with context switches and other quiescent states that
> > progress grace periods. The single threaded perf hit mitigates at about
> > 4x the current throttling threshold.
> 
> I doubt that thread count increases are actually mitigating the perf
> hit. Performance hits hard limits on concurrent rm -rf threads due
> to CIL lock contention at 7-800,000 transactions/s
> (hence the scalability patchset) regardless of the concurrency of
> the workload. With that bottleneck removed, the system then hits
> contention limits on VFS locks during
> inode instantiation/reclaim. This typically happens at 1.1-1.2
> million transactions/s during unlink.
> 
> Essentially, if you have a slower per-thread fs modification
> workload, you can can increase the concurrency to more threads and
> CPUs but the system will eventually still hit the same throughput
> limits. Hence a per-thread performance degradataion will still reach
> the same peak throughput levels, it will just take a few more
> threads to reach that limit. IOWs, scale doesn't make the
> per-thread degradation go away, it just allows more threads to run
> at full (but degraded) performance before the scalabilty limit
> threshold is hit.
> 

All I'm testing for here is how the prospective rcu tweak behaves at
scale. It introduces a noticeable hit with a single thread and no real
noticeable change at scale. FWIW, I see a similar result with a quick
test on top of the log scalability changes. I.e., I see a noticeable
improvement in concurrent rm -rf from a baseline kernel to baseline +
log scalability, and that improvement persists with the rcu hack added
on top.

> > > We could, potentially, use a separate lockless queue for unlinked
> > > inodes and defer that to after a grace period, but then rm -rf
> > > workloads will go much, much slower.
> > > 
> > 
> > I don't quite follow what you mean by a separate lockless queue..?
> 
> I was thinking separating unlinked symlinks into their own queue
> that can be processed after a grace period....
> 

Ok. I had a similar idea in mind, but rather than handle inode types
specially just split the single queue into multiple queues that can
pipeline and potentially mitigate rcu delays. This essentially takes the
previous optimization (that mitigated the hit by about 50%) a bit
further, but I'm not totally sure it's a win without testing it.

> > In
> > any event, another experiment I ran in light of the above results that
> > might be similar was to put the inode queueing component of
> > destroy_inode() behind an rcu callback. This reduces the single threaded
> > perf hit from the previous approach by about 50%. So not entirely
> > baseline performance, but it's back closer to baseline if I double the
> > throttle threshold (and actually faster at 4x). Perhaps my crude
> > prototype logic could be optimized further to not rely on percpu
> > threshold changes to match the baseline.
> > 
> > My overall takeaway from these couple hacky experiments is that the
> > unconditional synchronous rcu wait is indeed probably too heavy weight,
> > as you point out. The polling or callback (or perhaps your separate
> > queue) approach seems to be in the ballpark of viability, however,
> > particularly when we consider the behavior of scaled or mixed workloads
> > (since inactive queue processing seems to be size driven vs. latency
> > driven).
> > 
> > So I dunno.. if you consider the various severity and complexity
> > tradeoffs, this certainly seems worth more consideration to me. I can
> > think of other potentially interesting ways to experiment with
> > optimizing the above or perhaps tweak queueing to better facilitate
> > taking advantage of grace periods, but it's not worth going too far down
> > that road if you're wedded to the "busy inodes" approach.
> 
> I'm not wedded to "busy inodes" but, as your experiments are
> indicating, trying to handle rcu grace periods into the deferred
> inactivation path isn't completely mitigating the impact of having
> to wait for a grace period for recycling of inodes.
> 

What I'm seeing so far is that the impact seems to be limited to the
single threaded workload and largely mitigated by an increase in the
percpu throttle limit. IOW, it's not completely free right out of the
gate, but the impact seems isolated and potentially mitigated by
adjustment of the pipeline.

I realize the throttle is a percpu value, so that is what has me
wondering about some potential for gains in efficiency to try and get
more of that single-threaded performance back in other ways, or perhaps
enhancements that might be more broadly beneficial to deferred
inactivations in general (i.e. some form of adaptive throttling
thresholds to balance percpu thresholds against a global threshold).

> I suspect a rethink on the inode recycling mechanism is needed. THe
> way it is currently implemented was a brute force solution - it is
> simple and effective. However, we need more nuance in the recycling
> logic now.  That is, if we are recycling an inode that is clean, has
> nlink >=1 and has not been unlinked, it means the VFS evicted it too
> soon and we are going to re-instantiate it as the identical inode
> that was evicted from cache.
> 

Probably. How advantageous is inode memory reuse supposed to be in the
first place? I've more considered it a necessary side effect of broader
architecture (i.e. deferred reclaim, etc.) as opposed to a primary
optimization. I still see reuse occur with deferred inactivation, we
just end up cycling through the same set of inodes as they fall through
the queue rather than recycling the same one over and over. I'm sort of
wondering what the impact would be if we didn't do this at all (for the
new allocation case at least).

> So how much re-initialisation do we actually need for that inode?
> Almost everything in the inode is still valid; the problems come
> from inode_init_always() resetting the entire internal inode state
> and XFS then having to set them up again.  The internal state is
> already largely correct when we start recycling, and the identity of
> the recycled inode does not change when nlink >= 1. Hence eliding
> inode_init_always() would also go a long way to avoiding the need
> for a RCU grace period to pass before we can make the inode visible
> to the VFS again.
> 
> If we can do that, then the only indoes that need a grace period
> before they can be recycled are unlinked inodes as they change
> identity when being recycled. That identity change absolutely
> requires a grace period to expire before the new instantiation can
> be made visible.  Given the arbitrary delay that this can introduce
> for an inode allocation operation, it seems much better suited to
> detecting busy inodes than waiting for a global OS state change to
> occur...
> 

Maybe..? The experiments I've been doing are aimed at simplicity and
reducing the scope of the changes. Part of the reason for this is tbh
I'm not totally convinced we really need to do anything more complex
than preserve the inline symlink buffer one way or another (for example,
see the rfc patch below for an alternative to the inline symlink rcuwalk
disable patch). Maybe we should consider something like this anyways.

With busy inodes, we need to alter inode allocation to some degree to
accommodate. We can have (tens of?) thousands of inodes under the grace
period at any time based on current batching behavior, so it's not
totally evident to me that we won't end up with some of the same
fundamental issues to deal with here, just needing to be accommodated in
the inode allocation algorithm rather than the teardown sequence.

Brian

--- 8< ---

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 64b9bf334806..058e3fc69ff7 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -2644,7 +2644,7 @@ xfs_ifree(
 	 * already been freed by xfs_attr_inactive.
 	 */
 	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
-		kmem_free(ip->i_df.if_u1.if_data);
+		kfree_rcu(ip->i_df.if_u1.if_data);
 		ip->i_df.if_u1.if_data = NULL;
 		ip->i_df.if_bytes = 0;
 	}
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index a607d6aca5c4..e98d7f10ba7d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -511,27 +511,6 @@ xfs_vn_get_link(
 	return ERR_PTR(error);
 }
 
-STATIC const char *
-xfs_vn_get_link_inline(
-	struct dentry		*dentry,
-	struct inode		*inode,
-	struct delayed_call	*done)
-{
-	struct xfs_inode	*ip = XFS_I(inode);
-	char			*link;
-
-	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
-
-	/*
-	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
-	 * if_data is junk.
-	 */
-	link = ip->i_df.if_u1.if_data;
-	if (XFS_IS_CORRUPT(ip->i_mount, !link))
-		return ERR_PTR(-EFSCORRUPTED);
-	return link;
-}
-
 static uint32_t
 xfs_stat_blksize(
 	struct xfs_inode	*ip)
@@ -1250,14 +1229,6 @@ static const struct inode_operations xfs_symlink_inode_operations = {
 	.update_time		= xfs_vn_update_time,
 };
 
-static const struct inode_operations xfs_inline_symlink_inode_operations = {
-	.get_link		= xfs_vn_get_link_inline,
-	.getattr		= xfs_vn_getattr,
-	.setattr		= xfs_vn_setattr,
-	.listxattr		= xfs_vn_listxattr,
-	.update_time		= xfs_vn_update_time,
-};
-
 /* Figure out if this file actually supports DAX. */
 static bool
 xfs_inode_supports_dax(
@@ -1409,9 +1380,8 @@ xfs_setup_iops(
 		break;
 	case S_IFLNK:
 		if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL)
-			inode->i_op = &xfs_inline_symlink_inode_operations;
-		else
-			inode->i_op = &xfs_symlink_inode_operations;
+			inode->i_link = ip->i_df.if_u1.if_data;
+		inode->i_op = &xfs_symlink_inode_operations;
 		break;
 	default:
 		inode->i_op = &xfs_inode_operations;
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index fc2c6a404647..20ec2f450c56 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -497,6 +497,7 @@ xfs_inactive_symlink(
 	 * do here in that case.
 	 */
 	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
+		WRITE_ONCE(VFS_I(ip)->i_link, NULL);
 		xfs_iunlock(ip, XFS_ILOCK_EXCL);
 		return 0;
 	}

