Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAF459869
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 00:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbhKVXbR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Nov 2021 18:31:17 -0500
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:53883 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhKVXbP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Nov 2021 18:31:15 -0500
Received: from dread.disaster.area (pa49-195-103-97.pa.nsw.optusnet.com.au [49.195.103.97])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id E109286793B;
        Tue, 23 Nov 2021 10:26:59 +1100 (AEDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mpIi9-00C3kR-HA; Tue, 23 Nov 2021 10:26:57 +1100
Date:   Tue, 23 Nov 2021 10:26:57 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>,
        xfs <linux-xfs@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: make sure link path does not go away at access
Message-ID: <20211122232657.GF449541@dread.disaster.area>
References: <20211115222417.GO449541@dread.disaster.area>
 <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <YZVQUSCWWgOs+cRB@bfoster>
 <20211117214852.GU449541@dread.disaster.area>
 <YZf+lRsb0lBWdYgN@bfoster>
 <20211122000851.GE449541@dread.disaster.area>
 <YZvvP9RFXi3/jX0q@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZvvP9RFXi3/jX0q@bfoster>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=619c2746
        a=fP9RlOTWD4uZJjPSFnn6Ew==:117 a=fP9RlOTWD4uZJjPSFnn6Ew==:17
        a=HsDoLlocmGUuF16g:21 a=kj9zAlcOel0A:10 a=vIxV3rELxO4A:10 a=7-415B0cAAAA:8
        a=8lsCNJXj5NFy3Ic0CI0A:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=hl_xKfOxWho2XEkUDbUg:22 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 22, 2021 at 02:27:59PM -0500, Brian Foster wrote:
> On Mon, Nov 22, 2021 at 11:08:51AM +1100, Dave Chinner wrote:
> > On Fri, Nov 19, 2021 at 02:44:21PM -0500, Brian Foster wrote:
> > > In
> > > any event, another experiment I ran in light of the above results that
> > > might be similar was to put the inode queueing component of
> > > destroy_inode() behind an rcu callback. This reduces the single threaded
> > > perf hit from the previous approach by about 50%. So not entirely
> > > baseline performance, but it's back closer to baseline if I double the
> > > throttle threshold (and actually faster at 4x). Perhaps my crude
> > > prototype logic could be optimized further to not rely on percpu
> > > threshold changes to match the baseline.
> > > 
> > > My overall takeaway from these couple hacky experiments is that the
> > > unconditional synchronous rcu wait is indeed probably too heavy weight,
> > > as you point out. The polling or callback (or perhaps your separate
> > > queue) approach seems to be in the ballpark of viability, however,
> > > particularly when we consider the behavior of scaled or mixed workloads
> > > (since inactive queue processing seems to be size driven vs. latency
> > > driven).
> > > 
> > > So I dunno.. if you consider the various severity and complexity
> > > tradeoffs, this certainly seems worth more consideration to me. I can
> > > think of other potentially interesting ways to experiment with
> > > optimizing the above or perhaps tweak queueing to better facilitate
> > > taking advantage of grace periods, but it's not worth going too far down
> > > that road if you're wedded to the "busy inodes" approach.
> > 
> > I'm not wedded to "busy inodes" but, as your experiments are
> > indicating, trying to handle rcu grace periods into the deferred
> > inactivation path isn't completely mitigating the impact of having
> > to wait for a grace period for recycling of inodes.
> > 
> 
> What I'm seeing so far is that the impact seems to be limited to the
> single threaded workload and largely mitigated by an increase in the
> percpu throttle limit. IOW, it's not completely free right out of the
> gate, but the impact seems isolated and potentially mitigated by
> adjustment of the pipeline.
> 
> I realize the throttle is a percpu value, so that is what has me
> wondering about some potential for gains in efficiency to try and get
> more of that single-threaded performance back in other ways, or perhaps
> enhancements that might be more broadly beneficial to deferred
> inactivations in general (i.e. some form of adaptive throttling
> thresholds to balance percpu thresholds against a global threshold).

I ran experiments on queue depth early on. Once we go over a few
tens of inodes we start to lose the "hot cache" effect and
performance starts to go backwards. By queue depths of hundreds,
we've lost all the hot cache and nothing else gets that performance
back because we can't avoid the latency of all the memory writes
from cache eviction and the followup memory loads that result.

Making the per-cpu queues longer or shorter based on global state
won't gain us anything. ALl it will do is slow down local operations
that don't otherwise need slowing down....

> > I suspect a rethink on the inode recycling mechanism is needed. THe
> > way it is currently implemented was a brute force solution - it is
> > simple and effective. However, we need more nuance in the recycling
> > logic now.  That is, if we are recycling an inode that is clean, has
> > nlink >=1 and has not been unlinked, it means the VFS evicted it too
> > soon and we are going to re-instantiate it as the identical inode
> > that was evicted from cache.
> > 
> 
> Probably. How advantageous is inode memory reuse supposed to be in the
> first place? I've more considered it a necessary side effect of broader
> architecture (i.e. deferred reclaim, etc.) as opposed to a primary
> optimization.

Yes, it's an architectural feature resulting from the filesystem
inode life cycle being different to the VFS inode life cycle. This
was inherited from Irix - it had separate inactivation vs reclaim
states and action steps for vnodes - inactivation occurred when the
vnode refcount went to zero, reclaim occurred when the vnode was to
be freed.

Architecturally, Linux doesn't have this two-step infrastructure; it
just has evict() that runs everything when the inode needs to be
reclaimed. Hence we hide the two-phase reclaim architecture of XFS
behind that, and so we always had this troublesome impedence
mismatch on Linux.

Thinking a bit about this, maybe there is a more integrated way to
handle this life cycle impedence mismatch by making the way we
interact with the linux inode cache to be more ...  Irix like. Linux
does actually give us a a callback when the last reference to an
inode goes away: .drop_inode()

i.e. Maybe we should look to triggering inactivation work from
->drop_inode instead of ->destroy_inode and hence always leaving
unreferenced, reclaimable inodes in the VFS cache on the LRU. i.e.
rather than hiding the two-phase XFS inode inactivation+reclaim
algorithm from the VFS, move it up into the VFS.  If we prevent
inodes from being reclaimed from the LRU until they have finished
inactivation and are clean (easy enough just by marking the inode as
dirty), that would allow us to immediately reclaim and free inodes
in evict() context. Integration with __wait_on_freeing_inode() would
like solve the RCU reuse/recycling issues.

There's more to it than just this, but perhaps the longer term
direction should be closer integration with the Linux inode cache
life cycle rather than trying to solve all these problems underneath
the VFS cache whilst still trying to play by it's rules...

> I still see reuse occur with deferred inactivation, we
> just end up cycling through the same set of inodes as they fall through
> the queue rather than recycling the same one over and over. I'm sort of
> wondering what the impact would be if we didn't do this at all (for the
> new allocation case at least).

We end up with a larger pool of free inodes in the finobt. This is
basically what my "busy inode check" proposal is based on - inodes
that we can't allocate without recycling just remain on the finobt
for longer before they can be used. This would be awful if we didn't
have the finobt to efficiently locate free inodes - the finobt
record iteration makes it pretty low overhead to scan inodes here.

> > So how much re-initialisation do we actually need for that inode?
> > Almost everything in the inode is still valid; the problems come
> > from inode_init_always() resetting the entire internal inode state
> > and XFS then having to set them up again.  The internal state is
> > already largely correct when we start recycling, and the identity of
> > the recycled inode does not change when nlink >= 1. Hence eliding
> > inode_init_always() would also go a long way to avoiding the need
> > for a RCU grace period to pass before we can make the inode visible
> > to the VFS again.
> > 
> > If we can do that, then the only indoes that need a grace period
> > before they can be recycled are unlinked inodes as they change
> > identity when being recycled. That identity change absolutely
> > requires a grace period to expire before the new instantiation can
> > be made visible.  Given the arbitrary delay that this can introduce
> > for an inode allocation operation, it seems much better suited to
> > detecting busy inodes than waiting for a global OS state change to
> > occur...
> > 
> 
> Maybe..? The experiments I've been doing are aimed at simplicity and
> reducing the scope of the changes. Part of the reason for this is tbh
> I'm not totally convinced we really need to do anything more complex
> than preserve the inline symlink buffer one way or another (for example,
> see the rfc patch below for an alternative to the inline symlink rcuwalk
> disable patch). Maybe we should consider something like this anyways.
> 
> With busy inodes, we need to alter inode allocation to some degree to
> accommodate. We can have (tens of?) thousands of inodes under the grace
> period at any time based on current batching behavior, so it's not
> totally evident to me that we won't end up with some of the same
> fundamental issues to deal with here, just needing to be accommodated in
> the inode allocation algorithm rather than the teardown sequence.

Sure, but the purpose of the allocation selection
policy is to select the best inode to allocate for the current
context.  The cost of not being able to use an inode immediately
needs to be factored into that allocation policy. i.e. if the
selected inode has an associated delay with it before it can be
reused and other free inodes don't, then we should not be selecting
the inode with a delay associcated with it.

This is exactly the reasoning and logic we use for busy extents.  We
only take the blocking penalty for resolving busy extent state if we
run out of free extents to search before we've found an allocation
candidate. I think it makes sense for inode allocation, too.

> --- 8< ---
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 64b9bf334806..058e3fc69ff7 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -2644,7 +2644,7 @@ xfs_ifree(
>  	 * already been freed by xfs_attr_inactive.
>  	 */
>  	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> -		kmem_free(ip->i_df.if_u1.if_data);
> +		kfree_rcu(ip->i_df.if_u1.if_data);
>  		ip->i_df.if_u1.if_data = NULL;

That would need to be rcu_assign_pointer(ip->i_df.if_u1.if_data,
NULL) to put the correct memory barriers in place, right? Also, I
think ip->i_df.if_u1.if_data needs to be set to NULL before calling
kfree_rcu() so racing lookups will always see NULL before
the object is freed.

But again, as I asked up front, why do we even need to free this
memory buffer here? It will be freed in xfs_inode_free_callback()
after the current RCU grace period expires, so what do we gain by
freeing it separately here?

>  		ip->i_df.if_bytes = 0;
>  	}
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a607d6aca5c4..e98d7f10ba7d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -511,27 +511,6 @@ xfs_vn_get_link(
>  	return ERR_PTR(error);
>  }
>  
> -STATIC const char *
> -xfs_vn_get_link_inline(
> -	struct dentry		*dentry,
> -	struct inode		*inode,
> -	struct delayed_call	*done)
> -{
> -	struct xfs_inode	*ip = XFS_I(inode);
> -	char			*link;
> -
> -	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
> -
> -	/*
> -	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
> -	 * if_data is junk.
> -	 */
> -	link = ip->i_df.if_u1.if_data;
> -	if (XFS_IS_CORRUPT(ip->i_mount, !link))
> -		return ERR_PTR(-EFSCORRUPTED);
> -	return link;
> -}
> -
>  static uint32_t
>  xfs_stat_blksize(
>  	struct xfs_inode	*ip)
> @@ -1250,14 +1229,6 @@ static const struct inode_operations xfs_symlink_inode_operations = {
>  	.update_time		= xfs_vn_update_time,
>  };
>  
> -static const struct inode_operations xfs_inline_symlink_inode_operations = {
> -	.get_link		= xfs_vn_get_link_inline,
> -	.getattr		= xfs_vn_getattr,
> -	.setattr		= xfs_vn_setattr,
> -	.listxattr		= xfs_vn_listxattr,
> -	.update_time		= xfs_vn_update_time,
> -};
> -
>  /* Figure out if this file actually supports DAX. */
>  static bool
>  xfs_inode_supports_dax(
> @@ -1409,9 +1380,8 @@ xfs_setup_iops(
>  		break;
>  	case S_IFLNK:
>  		if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL)
> -			inode->i_op = &xfs_inline_symlink_inode_operations;
> -		else
> -			inode->i_op = &xfs_symlink_inode_operations;
> +			inode->i_link = ip->i_df.if_u1.if_data;
> +		inode->i_op = &xfs_symlink_inode_operations;

This still needs corruption checks - ip->i_df.if_u1.if_data can be
null if there's some kind of inode corruption detected.

>  		break;
>  	default:
>  		inode->i_op = &xfs_inode_operations;
> diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
> index fc2c6a404647..20ec2f450c56 100644
> --- a/fs/xfs/xfs_symlink.c
> +++ b/fs/xfs/xfs_symlink.c
> @@ -497,6 +497,7 @@ xfs_inactive_symlink(
>  	 * do here in that case.
>  	 */
>  	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> +		WRITE_ONCE(VFS_I(ip)->i_link, NULL);

Again, rcu_assign_pointer(), yes?

>  		xfs_iunlock(ip, XFS_ILOCK_EXCL);
>  		return 0;
>  	}
> 
> 

-- 
Dave Chinner
david@fromorbit.com
