Return-Path: <linux-fsdevel+bounces-30830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF9C98E87E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 04:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B641C21FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888511B59A;
	Thu,  3 Oct 2024 02:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KKtgXLvx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAD17C98
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 02:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727923367; cv=none; b=sShqV3TGPoQ0At6ngeRKnO7iF5PK317SUSh56C0Icy5EKOCChdMGZC3eF6ohHsyieLb4lMrJKnX3q9C+nH/koBRxoLAZweNqCBLbfIEtBl+C5HMBf29eBH7qXNeDhkvi1MtqckFb+tFkLA0fF+EEOijbB5IrcoA3i4C5lLOg3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727923367; c=relaxed/simple;
	bh=EstBgqcCx9wF+j1CJtDJFD6Mz//CxVTndewL8R6/bww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYOctJW+hGegP4YEl4hMofdkCl5eQqNHcvNs7iaeMKNJO/m+WRSob1nP2RjC5KYvGzoTfDcRPMGtxsm4koWX8efkkD0hYjn656l5HglQVJUeSFS1L2a/oEvxG+ItMlFwA74NQXUfYNrgX0v0BpSrV+h7FL1bJcUbJGg1vj0gDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KKtgXLvx; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 22:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727923363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LchHZOpX/HshgZN2Su0Emej4j0jOoeX5Sse4gQbVQSQ=;
	b=KKtgXLvxTgHCrPSAbUP9oQ+UcIQ7u5NJgM/m9+JTd8+PDC1QGC74WPT73wZTRdFr3+heG1
	C4B4zvtzfD3K/LmfOV1GsH3DvMNS1G6lgzvjUZjP9MIDUDQGDrp8c40QbZDQRk7Z2TCuCQ
	AHTQD7ivWin9HFu7h5ZnHabMug6Z1xE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <rd7boyrdyurefoko73sfgemzu2lhwkfoletcaqfyrs6sdnjukr@do4ogpf2ykg7>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <CAHk-=wgBqi+1YjH=-AiSDqx8p0uA6yGZ=HmMKtkGC3Ey=OhXhw@mail.gmail.com>
 <kz36dz2tzysa7ih7qf6iuhvzrfvwytzcpcv46hzedtpdebazam@2op5ojw3xvse>
 <Zv3UdBPLutZkBeNg@dread.disaster.area>
 <dhv3pbtrwyt6myltrhvgxobsvrejpsguo4xn6p572j3t3t3axl@d6x455tgwi2s>
 <Zv3/hQs+Rz/dcQnP@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv3/hQs+Rz/dcQnP@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 12:20:53PM GMT, Dave Chinner wrote:
> On Wed, Oct 02, 2024 at 09:22:38PM -0400, Kent Overstreet wrote:
> > On Thu, Oct 03, 2024 at 09:17:08AM GMT, Dave Chinner wrote:
> Which was painful to work with because
> it maintains the existing spin lock based traversal pattern. This
> was necessary because the iterator held a spinlock internally. I
> really didn't like that aspect of it because it perpeutated the need
> to open code the iget/iput game to allow the spinlock to be dropped
> across the inode operation that needed to be performed.
> 
> i.e. adding an dlist iterator didn't clean up any of the other mess
> that sb->s_inodes iteration required...

yeah, true.

that's actually something that does get cleaner with fast-list; because
we're iterating over a radix tree and our iterator is a radix tree
index, the crab-walk thing naturally goes away.

> > My concern is that we've been trying to get away from callbacks for
> > iteration - post spectre they're quite a bit more expensive than
> > external iterators, and we've generally been successful with that. 
> 
> So everyone keeps saying, but the old adage applies here: Penny
> wise, pound foolish.
> 
> Optimising away the callbacks might bring us a few percent
> performance improvement for each operation (e.g. via the dlist
> iterator mechanisms) in a traversal, but that iteration is still
> only single threaded. Hence the maximum processing rate is
> determined by the performance of a single CPU core.
> 
> However, if we change the API to allow for parallelism at the cost
> of a few percent per object operation, then a single CPU core will
> not process quite as many objects as before. However, the moment we
> allow multiple CPU cores to process in parallel, we acheive
> processing rate improvements measured in integer multiples.
> 
> Modern CPUs have concurrency to burn.  Optimising APIs for minimum
> per-operation overhead rather than for concurrent processing
> implementations is the wrong direction to be taking....

OTOH - this is all academic because none of the uses of s_inodes are
_remotely_ fastpaths. Aside from nr_blockdev_pages() it's more or less
all filesystem teardown, or similar frequency.

> > Radix tree doesn't work for us, since our keys are { inum, subvol } - 96
> > bits -
> 
> Sure it does - you just need two layers of radix trees. i.e have a
> radix tree per subvol to index inodes by inum, and a per-sb radix
> tree to index the subvols. With some code to propagate radix tree
> bits from the inode radix tree to the subvol radix tree they then
> largely work in conjunction for filtered searches.

It'd have to be the reverse - index by inum, then subvol, and then we'd
need to do bit stuffing so that a radix tree with a single element is
just a pointer to the element. But - yeah, if the current approach (not
considering the subvol when calculating the hash) becomes an issue, that
might be the way to go.

> This is -exactly- the internal inode cache structure that XFS has.
> We have a per-sb radix tree indexing the allocation groups, and a
> radix tree per allocation group indexing inodes by inode number.
> Hence an inode lookup involves splitting the inum into agno/agino
> pairs, then doing a perag lookup with the agno, and doing a perag
> inode cache lookup with the agino. All of these radix tree
> lookups are lockless...

Speaking of, I'd like to pick your brain on AGIs at some point. We've
been sketching out future scalability work in bcachefs, and I think
that's going to be one of the things we'll end up needing.

Right now the scalability limit is backpointers fsck, but that looks
fairly trivial to solve: there's no reason to run the backpointers ->
extents pass except for debug testing, we can check and repair those
references at runtime, and we can sum up backpointers in a bucket and
check them against the bucket sector counts and skip extents ->
backpointers if they match.

After that, the next scalability limitation should be the main
check_alloc_info pass, and we'll need something analagous to AGIs to
shard that and run it efficiently when the main allocation info doesn't
fit in memory - and it sounds like you have other optimizations that
leverage AGIs as well.

