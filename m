Return-Path: <linux-fsdevel+bounces-30826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F4498E820
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 03:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250CCB20BAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4C413FFC;
	Thu,  3 Oct 2024 01:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UqbItuX1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C183ADF49;
	Thu,  3 Oct 2024 01:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727918567; cv=none; b=Hsiuj7KiqefhiYVT80/L1GgoRD/SZreNVwzk7Q8R7Jbvm/y0aoY4PBnABe+CbLhljQkVwOCy1+A79QZrW8NDl7doVOqb67K14tDYJBtnnpXIO410/YewKOeksejIubZr4qv4DzgB9lOEMDsVyTy91SeSsfavjAfuP0xDv4B0xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727918567; c=relaxed/simple;
	bh=9zUFeRa6gi6DComkOdyu8r1UMejneNZRWAhrY5ZlzbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLH68fHPIosZsgRcjXBIGqdg683krgoRsWBU3fUlVCLIPEiZ0TfjXrYd1taD8EEylgU/FdirubtvPPEMmpPdK3Ay5hqqyras64O914kNsMUIFotO7GDFIQbJJs0jTzbkNCfzpRtdxZQhbtFPUQ2y01Z7cjQ7cC3oj1xbZPtNvf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UqbItuX1; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 21:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727918562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9c6ETAqBKTFhmAR4ihMpQ6sQqK4ImBV9hgurAcSZDu8=;
	b=UqbItuX1OF0RutrcWGcUU4DO4mGcmdsTmvW94LHrt0Aj9lAoe1ImMEuB/Tk5iMqmzZZVB1
	Jnm+oViEZDveKyIMSEqTCx5420jDOiQfhR7WLUOXyLN260DjshXB/+7PZeKnDsEjLUNASj
	eFIFRtqhRoXpM1DvDAtBu+alm3Jt7+E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <dhv3pbtrwyt6myltrhvgxobsvrejpsguo4xn6p572j3t3t3axl@d6x455tgwi2s>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
 <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>
 <Zv3UdBPLutZkBeNg@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv3UdBPLutZkBeNg@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 09:17:08AM GMT, Dave Chinner wrote:
> On Wed, Oct 02, 2024 at 04:28:35PM -0400, Kent Overstreet wrote:
> > On Wed, Oct 02, 2024 at 12:49:13PM GMT, Linus Torvalds wrote:
> > > On Wed, 2 Oct 2024 at 05:35, Dave Chinner <david@fromorbit.com> wrote:
> > > >
> > > > On Wed, Oct 02, 2024 at 12:00:01PM +0200, Christian Brauner wrote:
> > > >
> > > > > I don't have big conceptual issues with the series otherwise. The only
> > > > > thing that makes me a bit uneasy is that we are now providing an api
> > > > > that may encourage filesystems to do their own inode caching even if
> > > > > they don't really have a need for it just because it's there.  So really
> > > > > a way that would've solved this issue generically would have been my
> > > > > preference.
> > > >
> > > > Well, that's the problem, isn't it? :/
> > > >
> > > > There really isn't a good generic solution for global list access
> > > > and management.  The dlist stuff kinda works, but it still has
> > > > significant overhead and doesn't get rid of spinlock contention
> > > > completely because of the lack of locality between list add and
> > > > remove operations.
> > > 
> > > I much prefer the approach taken in your patch series, to let the
> > > filesystem own the inode list and keeping the old model as the
> > > "default list".
> > > 
> > > In many ways, that is how *most* of the VFS layer works - it exposes
> > > helper functions that the filesystems can use (and most do), but
> > > doesn't force them.
> > > 
> > > Yes, the VFS layer does force some things - you can't avoid using
> > > dentries, for example, because that's literally how the VFS layer
> > > deals with filenames (and things like mounting etc). And honestly, the
> > > VFS layer does a better job of filename caching than any filesystem
> > > really can do, and with the whole UNIX mount model, filenames
> > > fundamentally cross filesystem boundaries anyway.
> > > 
> > > But clearly the VFS layer inode list handling isn't the best it can
> > > be, and unless we can fix that in some fundamental way (and I don't
> > > love the "let's use crazy lists instead of a simple one" models) I do
> > > think that just letting filesystems do their own thing if they have
> > > something better is a good model.
> > 
> > Well, I don't love adding more indirection and callbacks.
> 
> It's way better than open coding inode cache traversals everywhere.

Eh? You had a nice iterator for dlock-list :)

> The callback model is simply "call this function on every object",
> and it allows implementations the freedom to decide how they are
> going to run those callbacks.
> 
> For example, this abstraction allows XFS to parallelise the
> traversal. We currently run the traversal across all inodes in a
> single thread, but now that XFS is walking the inode cache we can
> push each shard off to a workqueue and run each shard concurrently.
> IOWs, we can actually make the traversal of large caches much, much
> faster without changing the semantics of the operation the traversal
> is trying to acheive.
> 
> We simply cannot do things like that without a new iteration model.
> Abstraction is necessary to facilitate a new iteration model, and a
> model that provides independent object callbacks allows scope for
> concurrent processing of individual objects.

Parallelized iteration is a slick possibility.

My concern is that we've been trying to get away from callbacks for
iteration - post spectre they're quite a bit more expensive than
external iterators, and we've generally been successful with that. 

> 
> > The underlying approach in this patchset of "just use the inode hash
> > table if that's available" - that I _do_ like, but this seems like
> > the wrong way to go about it, we're significantly adding to the amount
> > of special purpose "things" filesystems have to do if they want to
> > perform well.
> 
> I've already addressed this in my response to Christian. This is a
> mechanism that allows filesystems to be moved one-by-one to a new
> generic cache and iteration implementation without impacting
> existing code. Once we have that, scalability of the inode cache and
> traversals should not be a reason for filesystems "doing their own
> thing" because the generic infrastructure will be sufficient for
> most filesystem implementations.

Well, I'm not really seeing the need; based on my performance testing
both dlock-list and fast-list completely shift the bottleneck to the
lru_list locking - and in my testing both patchsets were about equal, to
within the margin of error.

Which is a touch surprising, given that dlock-list works similarly to
lru_list - possibly it's because you only have siblings sharing lists
vs. numa nodes for lru lists, or lru scanning is doing more cross
cpu/node accesses.

> > Converting the standard inode hash table to an rhashtable (or more
> > likely, creating a new standard implementation and converting
> > filesystems one at a time) still needs to happen, and then the "use the
> > hash table for iteration" approach could use that without every
> > filesystem having to specialize.
> 
> Yes, but this still doesn't help filesystems like XFS where the
> structure of the inode cache is highly optimised for the specific
> on-disk and in-memory locality of inodes. We aren't going to be
> converting XFS to a rhashtable based inode cache anytime soon
> because it simply doesn't provide the functionality we require.
> e.g. efficient lockless sequential inode number ordered traversal in
> -every- inode cluster writeback operation.

I was going to ask what your requirements are - I may take on the
general purpose inode rhashtable code, although since I'm still pretty
buried we'll see.

Coincidentally, just today I'm working on an issue in bcachefs where
we'd also prefer an ordered data structure to a hash table for the inode
cache - in online fsck, we need to be able to check if an inode is still
open, but checking for an inode in an interior snapshot node means we
have to do a scan and check if any of the open inodes are in a
descendent subvolume.

Radix tree doesn't work for us, since our keys are { inum, subvol } - 96
bits - but it has me considering looking at maple trees (or something
like the lockless RCU btree you were working on awhile back) - those
modern approaches should be approaching hash table performance, if
enough needs for ordered access come up.

> > Failing that, or even regardless, I think we do need either dlock-list
> > or fast-list. "I need some sort of generic list, but fast" is something
> > I've seen come up way too many times.
> 
> There's nothing stopping you from using the dlist patchset for your
> own purposes. It's public code - just make sure you retain the
> correct attributions. :)

If this patchset goes in that might be just what I do, if I don't get
around to finishing fast-list :)

