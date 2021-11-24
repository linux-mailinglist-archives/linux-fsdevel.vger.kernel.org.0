Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEC45CE83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 21:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245209AbhKXU7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 15:59:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59211 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244902AbhKXU7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 15:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637787367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yH2tEOPG3Ul9vdPrtND/5A4t8ZhOw75oQyfcGIZR9Q=;
        b=THQcACqz5hiu4liV3SkjsKaWjc8UhHp3OdT4KotLLC9XpoP/Dnv1BgH5nlsfMwx/t6DRuF
        IgqEAKRnpev5DA/NpeYUZHEMJGUgfHzRBjXYNvPbE+rEqtdmZUEg0pDydKjPQNcFF4N83V
        IUrUBQYl7P0Bxr5QUdeVKKsTTPImPzs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-yCAmblvROJSiG84yZqyuzA-1; Wed, 24 Nov 2021 15:56:05 -0500
X-MC-Unique: yCAmblvROJSiG84yZqyuzA-1
Received: by mail-qv1-f69.google.com with SMTP id o3-20020a0562140e4300b0039a8ccca8efso3242207qvc.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Nov 2021 12:56:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/yH2tEOPG3Ul9vdPrtND/5A4t8ZhOw75oQyfcGIZR9Q=;
        b=Kd0jgz33134UKMY17oxRVZGCG6XG6AobX6WdENpFzLz/Le1GOysWBh1BWIkVSUu5Zz
         nNVY98V6ly5ZA6Ozz1+eiAysBqGsurbfh/fndIPAuUfrKZnkLG8pSmI1ERxPNowLCpYM
         apxCz4FgoiNjmo7PO8lPqxaEjXijTt5u7nCkJtuLcVImi7OFokbRqONRuqSklvNHpX4g
         NXtWw0wh5izKIlJjsIyyy150QWUrnR21nfYH89bF27hXYQvBIuOoT9gh8CY0dYWqxISk
         dD0lHKbWD2/JhgN6cJ6bO4Q5jQwkPQv/L6SD2eeZR72gZd9pAblPn+PbOeRmYiBY9AKK
         68bA==
X-Gm-Message-State: AOAM531+EkNiU2WWDx0jIMgu++jNPn5ps0UPRlUHWuGdS9KMTi2MhNNc
        PmJBzwt5tjo3x4dm4o7+5HMI87SyDbZfU+ih/k4wJDSjz+7J3iYYdcEVx5BuabWyiNus1WTk2R3
        /PU3DPqnXVms+ZcLjNd0L0mPEAQ==
X-Received: by 2002:a05:6214:240e:: with SMTP id fv14mr2707967qvb.56.1637787364921;
        Wed, 24 Nov 2021 12:56:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwo5Z4keP+dp+ooaDojGXV11tfUi4BuECjORc43yL/8zU6RuXZIws3zHvJvOevJINWkmw+R6A==
X-Received: by 2002:a05:6214:240e:: with SMTP id fv14mr2707924qvb.56.1637787364528;
        Wed, 24 Nov 2021 12:56:04 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id e17sm504781qtw.18.2021.11.24.12.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 12:56:03 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:56:01 -0500
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
Message-ID: <YZ6m4ZyUDt5SaICI@bfoster>
References: <f8425d1270fe011897e7e14eaa6ba8a77c1ed077.camel@themaw.net>
 <20211116030120.GQ449541@dread.disaster.area>
 <YZPVSTDIWroHNvFS@bfoster>
 <20211117002251.GR449541@dread.disaster.area>
 <YZVQUSCWWgOs+cRB@bfoster>
 <20211117214852.GU449541@dread.disaster.area>
 <YZf+lRsb0lBWdYgN@bfoster>
 <20211122000851.GE449541@dread.disaster.area>
 <YZvvP9RFXi3/jX0q@bfoster>
 <20211122232657.GF449541@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122232657.GF449541@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 23, 2021 at 10:26:57AM +1100, Dave Chinner wrote:
> On Mon, Nov 22, 2021 at 02:27:59PM -0500, Brian Foster wrote:
> > On Mon, Nov 22, 2021 at 11:08:51AM +1100, Dave Chinner wrote:
> > > On Fri, Nov 19, 2021 at 02:44:21PM -0500, Brian Foster wrote:
> > > > In
> > > > any event, another experiment I ran in light of the above results that
> > > > might be similar was to put the inode queueing component of
> > > > destroy_inode() behind an rcu callback. This reduces the single threaded
> > > > perf hit from the previous approach by about 50%. So not entirely
> > > > baseline performance, but it's back closer to baseline if I double the
> > > > throttle threshold (and actually faster at 4x). Perhaps my crude
> > > > prototype logic could be optimized further to not rely on percpu
> > > > threshold changes to match the baseline.
> > > > 
> > > > My overall takeaway from these couple hacky experiments is that the
> > > > unconditional synchronous rcu wait is indeed probably too heavy weight,
> > > > as you point out. The polling or callback (or perhaps your separate
> > > > queue) approach seems to be in the ballpark of viability, however,
> > > > particularly when we consider the behavior of scaled or mixed workloads
> > > > (since inactive queue processing seems to be size driven vs. latency
> > > > driven).
> > > > 
> > > > So I dunno.. if you consider the various severity and complexity
> > > > tradeoffs, this certainly seems worth more consideration to me. I can
> > > > think of other potentially interesting ways to experiment with
> > > > optimizing the above or perhaps tweak queueing to better facilitate
> > > > taking advantage of grace periods, but it's not worth going too far down
> > > > that road if you're wedded to the "busy inodes" approach.
> > > 
> > > I'm not wedded to "busy inodes" but, as your experiments are
> > > indicating, trying to handle rcu grace periods into the deferred
> > > inactivation path isn't completely mitigating the impact of having
> > > to wait for a grace period for recycling of inodes.
> > > 
> > 
> > What I'm seeing so far is that the impact seems to be limited to the
> > single threaded workload and largely mitigated by an increase in the
> > percpu throttle limit. IOW, it's not completely free right out of the
> > gate, but the impact seems isolated and potentially mitigated by
> > adjustment of the pipeline.
> > 
> > I realize the throttle is a percpu value, so that is what has me
> > wondering about some potential for gains in efficiency to try and get
> > more of that single-threaded performance back in other ways, or perhaps
> > enhancements that might be more broadly beneficial to deferred
> > inactivations in general (i.e. some form of adaptive throttling
> > thresholds to balance percpu thresholds against a global threshold).
> 
> I ran experiments on queue depth early on. Once we go over a few
> tens of inodes we start to lose the "hot cache" effect and
> performance starts to go backwards. By queue depths of hundreds,
> we've lost all the hot cache and nothing else gets that performance
> back because we can't avoid the latency of all the memory writes
> from cache eviction and the followup memory loads that result.
> 

Admittedly my testing is simple/crude as I'm just exploring the
potential viability of a concept, not fine tuning a workload, etc. That
said, I'm curious to know what your tests for this look like because I
suspect I'm running into different conditions. My tests frequently hit
the percpu throttle threshold (256 inodes), which is beyond your ideal
tens of inodes range (and probably more throttle limited than cpu cache
limited).

> Making the per-cpu queues longer or shorter based on global state
> won't gain us anything. ALl it will do is slow down local operations
> that don't otherwise need slowing down....
> 

This leaves out context. The increase in throttle threshold mitigates
the delays I've introduced via the rcu callback. That happens to produce
observable results comparable to my baseline test, but it's more of a
measure of the impact of the delay than a direct proposal. If there's a
more fine grained test worth running here (re: above), please describe
it.

> > > I suspect a rethink on the inode recycling mechanism is needed. THe
> > > way it is currently implemented was a brute force solution - it is
> > > simple and effective. However, we need more nuance in the recycling
> > > logic now.  That is, if we are recycling an inode that is clean, has
> > > nlink >=1 and has not been unlinked, it means the VFS evicted it too
> > > soon and we are going to re-instantiate it as the identical inode
> > > that was evicted from cache.
> > > 
> > 
> > Probably. How advantageous is inode memory reuse supposed to be in the
> > first place? I've more considered it a necessary side effect of broader
> > architecture (i.e. deferred reclaim, etc.) as opposed to a primary
> > optimization.
> 
> Yes, it's an architectural feature resulting from the filesystem
> inode life cycle being different to the VFS inode life cycle. This
> was inherited from Irix - it had separate inactivation vs reclaim
> states and action steps for vnodes - inactivation occurred when the
> vnode refcount went to zero, reclaim occurred when the vnode was to
> be freed.
> 
> Architecturally, Linux doesn't have this two-step infrastructure; it
> just has evict() that runs everything when the inode needs to be
> reclaimed. Hence we hide the two-phase reclaim architecture of XFS
> behind that, and so we always had this troublesome impedence
> mismatch on Linux.
> 

Ok, that was generally how I viewed it.

> Thinking a bit about this, maybe there is a more integrated way to
> handle this life cycle impedence mismatch by making the way we
> interact with the linux inode cache to be more ...  Irix like. Linux
> does actually give us a a callback when the last reference to an
> inode goes away: .drop_inode()
> 
> i.e. Maybe we should look to triggering inactivation work from
> ->drop_inode instead of ->destroy_inode and hence always leaving
> unreferenced, reclaimable inodes in the VFS cache on the LRU. i.e.
> rather than hiding the two-phase XFS inode inactivation+reclaim
> algorithm from the VFS, move it up into the VFS.  If we prevent
> inodes from being reclaimed from the LRU until they have finished
> inactivation and are clean (easy enough just by marking the inode as
> dirty), that would allow us to immediately reclaim and free inodes
> in evict() context. Integration with __wait_on_freeing_inode() would
> like solve the RCU reuse/recycling issues.
> 

Hmm.. this is the point where we decide whether the inode remains
cached, which is currently basically whether the inode has a link count
or not. That makes me curious what (can) happens with an
unlinked/inactivated inode on the lru. I'm not sure any other fs' do
anything like that currently..?

> There's more to it than just this, but perhaps the longer term
> direction should be closer integration with the Linux inode cache
> life cycle rather than trying to solve all these problems underneath
> the VFS cache whilst still trying to play by it's rules...
> 

Yeah. Caching logic details aside, I think that makes sense.

> > I still see reuse occur with deferred inactivation, we
> > just end up cycling through the same set of inodes as they fall through
> > the queue rather than recycling the same one over and over. I'm sort of
> > wondering what the impact would be if we didn't do this at all (for the
> > new allocation case at least).
> 
> We end up with a larger pool of free inodes in the finobt. This is
> basically what my "busy inode check" proposal is based on - inodes
> that we can't allocate without recycling just remain on the finobt
> for longer before they can be used. This would be awful if we didn't
> have the finobt to efficiently locate free inodes - the finobt
> record iteration makes it pretty low overhead to scan inodes here.
> 

I get the idea. That last bit is what I'm skeptical about. The finobt is
based on the premise that free inode lookup becomes a predictable tree
lookup instead of the old searching algorithm on the inobt, which we
still support and can be awful in its own right under worst case
conditions. I agree that this would be bad on the inobt (which raises
the question on how we'd provide these recycling correctness guarantees
on !finobt fs'). What I'm more concerned about is whether this could
make finobt enabled fs' (transiently) just as poor as the old algo under
certain workloads/conditions.

I think there needs to be at least some high level description of the
search algorithm before we can sufficiently reason about it's behavior..

> > > So how much re-initialisation do we actually need for that inode?
> > > Almost everything in the inode is still valid; the problems come
> > > from inode_init_always() resetting the entire internal inode state
> > > and XFS then having to set them up again.  The internal state is
> > > already largely correct when we start recycling, and the identity of
> > > the recycled inode does not change when nlink >= 1. Hence eliding
> > > inode_init_always() would also go a long way to avoiding the need
> > > for a RCU grace period to pass before we can make the inode visible
> > > to the VFS again.
> > > 
> > > If we can do that, then the only indoes that need a grace period
> > > before they can be recycled are unlinked inodes as they change
> > > identity when being recycled. That identity change absolutely
> > > requires a grace period to expire before the new instantiation can
> > > be made visible.  Given the arbitrary delay that this can introduce
> > > for an inode allocation operation, it seems much better suited to
> > > detecting busy inodes than waiting for a global OS state change to
> > > occur...
> > > 
> > 
> > Maybe..? The experiments I've been doing are aimed at simplicity and
> > reducing the scope of the changes. Part of the reason for this is tbh
> > I'm not totally convinced we really need to do anything more complex
> > than preserve the inline symlink buffer one way or another (for example,
> > see the rfc patch below for an alternative to the inline symlink rcuwalk
> > disable patch). Maybe we should consider something like this anyways.
> > 
> > With busy inodes, we need to alter inode allocation to some degree to
> > accommodate. We can have (tens of?) thousands of inodes under the grace
> > period at any time based on current batching behavior, so it's not
> > totally evident to me that we won't end up with some of the same
> > fundamental issues to deal with here, just needing to be accommodated in
> > the inode allocation algorithm rather than the teardown sequence.
> 
> Sure, but the purpose of the allocation selection
> policy is to select the best inode to allocate for the current
> context.  The cost of not being able to use an inode immediately
> needs to be factored into that allocation policy. i.e. if the
> selected inode has an associated delay with it before it can be
> reused and other free inodes don't, then we should not be selecting
> the inode with a delay associcated with it.
> 

We still have to find those "no delay" inodes. AFAICT the worst case
conditions on the system I've been playing with can have something like
20k free && busy inodes. That could cover all or most of the finobt at
the time of an inode allocation. What happens from there depends on the
search algorithm.

> This is exactly the reasoning and logic we use for busy extents.  We
> only take the blocking penalty for resolving busy extent state if we
> run out of free extents to search before we've found an allocation
> candidate. I think it makes sense for inode allocation, too.
> 

Sure, the idea makes sense and it's worth looking into. But there are
enough contextual differences that I wouldn't just assume the same logic
translates over to the finobt without potential for performance impact.
For example, extent allocation has some advantages with things like
delalloc (physical block allocation occurs async from buffered write
syscall time) and the fact that metadata allocs can reuse busy blocks.
The finobt only tracks existing chunks with free inodes, so it's easily
possible to have conditions where the finobt is 100% (or majority)
populated with busy inodes (whether it be one inode or several
thousand).

This raises questions like at what point does search cost become a
factor? At what point and with what frequency do we suffer the blocking
penalty? Do we opt to allocate new chunks based on gp state? Something
else? We don't need to answer these questions here (this thread is long
enough :P). I'm just trying to say that it's one thing to consider the
approach a viable option, but it isn't automatically preferable just
because we use it for extents. Further details beyond "detect busy
inodes" would be nice to objectively reason about.

> > --- 8< ---
> > 
> > diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> > index 64b9bf334806..058e3fc69ff7 100644
> > --- a/fs/xfs/xfs_inode.c
> > +++ b/fs/xfs/xfs_inode.c
> > @@ -2644,7 +2644,7 @@ xfs_ifree(
> >  	 * already been freed by xfs_attr_inactive.
> >  	 */
> >  	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> > -		kmem_free(ip->i_df.if_u1.if_data);
> > +		kfree_rcu(ip->i_df.if_u1.if_data);
> >  		ip->i_df.if_u1.if_data = NULL;
> 
> That would need to be rcu_assign_pointer(ip->i_df.if_u1.if_data,
> NULL) to put the correct memory barriers in place, right? Also, I
> think ip->i_df.if_u1.if_data needs to be set to NULL before calling
> kfree_rcu() so racing lookups will always see NULL before
> the object is freed.
> 

I think rcu_assign_pointer() is intended to be paired with the
associated rcu deref and for scenarios like making sure an object isn't
made available until it's completely initialized (i.e. such as for rcu
protected list traversals, etc.).

With regard to ordering, we no longer access if_data in rcuwalk mode
with this change. Thus I think all we need here is the
WRITE_ONCE(i_link, NULL) that pairs with the READ_ONCE() in the vfs, and
that happens earlier in xfs_inactive_symlink() before we rcu free the
memory here. With that, ISTM a racing lookup should either see an rcu
protected i_link or NULL, the latter of which calls into ->get_link()
and triggers refwalk mode. Hm?

> But again, as I asked up front, why do we even need to free this
> memory buffer here? It will be freed in xfs_inode_free_callback()
> after the current RCU grace period expires, so what do we gain by
> freeing it separately here?
> 

One prevented memory leak? ;)

It won't be freed in xfs_inode_free_callback() because we change the
data fork format type (and clear i_mode) in this path. Perhaps that
could use an audit, but that's a separate issue.

> >  		ip->i_df.if_bytes = 0;
> >  	}
> > diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> > index a607d6aca5c4..e98d7f10ba7d 100644
> > --- a/fs/xfs/xfs_iops.c
> > +++ b/fs/xfs/xfs_iops.c
> > @@ -511,27 +511,6 @@ xfs_vn_get_link(
> >  	return ERR_PTR(error);
> >  }
> >  
> > -STATIC const char *
> > -xfs_vn_get_link_inline(
> > -	struct dentry		*dentry,
> > -	struct inode		*inode,
> > -	struct delayed_call	*done)
> > -{
> > -	struct xfs_inode	*ip = XFS_I(inode);
> > -	char			*link;
> > -
> > -	ASSERT(ip->i_df.if_format == XFS_DINODE_FMT_LOCAL);
> > -
> > -	/*
> > -	 * The VFS crashes on a NULL pointer, so return -EFSCORRUPTED if
> > -	 * if_data is junk.
> > -	 */
> > -	link = ip->i_df.if_u1.if_data;
> > -	if (XFS_IS_CORRUPT(ip->i_mount, !link))
> > -		return ERR_PTR(-EFSCORRUPTED);
> > -	return link;
> > -}
> > -
> >  static uint32_t
> >  xfs_stat_blksize(
> >  	struct xfs_inode	*ip)
> > @@ -1250,14 +1229,6 @@ static const struct inode_operations xfs_symlink_inode_operations = {
> >  	.update_time		= xfs_vn_update_time,
> >  };
> >  
> > -static const struct inode_operations xfs_inline_symlink_inode_operations = {
> > -	.get_link		= xfs_vn_get_link_inline,
> > -	.getattr		= xfs_vn_getattr,
> > -	.setattr		= xfs_vn_setattr,
> > -	.listxattr		= xfs_vn_listxattr,
> > -	.update_time		= xfs_vn_update_time,
> > -};
> > -
> >  /* Figure out if this file actually supports DAX. */
> >  static bool
> >  xfs_inode_supports_dax(
> > @@ -1409,9 +1380,8 @@ xfs_setup_iops(
> >  		break;
> >  	case S_IFLNK:
> >  		if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL)
> > -			inode->i_op = &xfs_inline_symlink_inode_operations;
> > -		else
> > -			inode->i_op = &xfs_symlink_inode_operations;
> > +			inode->i_link = ip->i_df.if_u1.if_data;
> > +		inode->i_op = &xfs_symlink_inode_operations;
> 
> This still needs corruption checks - ip->i_df.if_u1.if_data can be
> null if there's some kind of inode corruption detected.
> 

It's fine for i_link to be NULL. We'd just fall into the get_link() call
and have to handle it there like the current callback does.

However, this does need to restore some of the code removed from
xfs_vn_get_link() in commit 30ee052e12b9 ("xfs: optimize inline
symlinks") to handle the local format case. If if_data can be NULL we'll
obviously need to handle it there anyways.

If there's no fundamental objection I'll address these issues, give it
some proper testing and send a real patch..

Brian

> >  		break;
> >  	default:
> >  		inode->i_op = &xfs_inode_operations;
> > diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
> > index fc2c6a404647..20ec2f450c56 100644
> > --- a/fs/xfs/xfs_symlink.c
> > +++ b/fs/xfs/xfs_symlink.c
> > @@ -497,6 +497,7 @@ xfs_inactive_symlink(
> >  	 * do here in that case.
> >  	 */
> >  	if (ip->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
> > +		WRITE_ONCE(VFS_I(ip)->i_link, NULL);
> 
> Again, rcu_assign_pointer(), yes?
> 
> >  		xfs_iunlock(ip, XFS_ILOCK_EXCL);
> >  		return 0;
> >  	}
> > 
> > 
> 
> -- 
> Dave Chinner
> david@fromorbit.com
> 

