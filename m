Return-Path: <linux-fsdevel+bounces-30829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9098E866
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 04:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E000C1C21EE7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 02:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492EE1946B;
	Thu,  3 Oct 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xUF1gLmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D217C77
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727922284; cv=none; b=tT2llFiQj+pTMxpLnMsGzPhewjhaz+mLhCqxAMABEmdaf6axtuuN942TzRa95OeG0cRVW8dcTZyCvbKgM1lP+KiDUdJ+IbkYjWnDJwx+zgA/L12o0pdgkD0Z/EH+73klz4woKw488GUZGCVmkOS7BsM05bjpyw/q++1dn131d+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727922284; c=relaxed/simple;
	bh=aMdCdcUDTuSlnqEPqMPjtWK4238cpRCuYDIgnOLzFk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZjbbpdL0o5qXmhSRAsvLTib/2rPw9G7h+2Op/x8eAgxXA7oLrxDVFSXIVzGBh7RXo9emwR6uox7K/3Cx0O78v2f2EQ3HcxCgGCAzxIZZO0pXsrkt4+mcIvGuBj9LFbHHdcxHj1gAybznhkMlVTL/RAZGKMs7f78Ens39QtqpGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xUF1gLmV; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Oct 2024 22:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727922280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iJELL/3yw9EiFQl9OU3g6qvpp+miNml7rNur4oHDt3U=;
	b=xUF1gLmVNThXjGKdz6+YnXMKj5PffvrGXolKtYgAyq261ejmR9qVCqexaTdqqTu7XAGOyP
	aPOxYd2mcvdJDOalcE/upTRzZAsBguxP3QOYOfwpA/Veu7klyKY5gU9/365QbN50WCC3m7
	EQMEE0ZTpsg3nsumQOHDnNk9NXjakC4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Dave Chinner <david@fromorbit.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [RFC PATCH 0/7] vfs: improving inode cache iteration scalability
Message-ID: <m6y4vkrwcwk56qvt2rljvalqqwhfnot62lnas4sohledbumlah@mtv6i4xl5hn6>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002-lethargisch-hypnose-fd06ae7a0977@brauner>
 <Zv098heGHOtGfw1R@dread.disaster.area>
 <3lukwhxkfyqz5xsp4r7byjejrgvccm76azw37pmudohvxcxqld@kiwf5f5vjshk>
 <Zv3H8BxJX2GwNW2Y@dread.disaster.area>
 <lngs2n3kfwermwuadhrfq2loff3k4psydbjullhecuutthpqz3@4w6cybx7boxw>
 <Zv32Vow1YdYgB8KC@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv32Vow1YdYgB8KC@dread.disaster.area>
X-Migadu-Flow: FLOW_OUT

On Thu, Oct 03, 2024 at 11:41:42AM GMT, Dave Chinner wrote:
> > A couple things that help - we've already determined that the inode LRU
> > can go away for most filesystems,
> 
> We haven't determined that yet. I *think* it is possible, but there
> is a really nasty inode LRU dependencies that has been driven deep
> down into the mm page cache writeback code.  We have to fix that
> awful layering violation before we can get rid of the inode LRU.
> 
> I *think* we can do it by requiring dirty inodes to hold an explicit
> inode reference, thereby keeping the inode pinned in memory whilst
> it is being tracked for writeback. That would also get rid of the
> nasty hacks needed in evict() to wait on writeback to complete on
> unreferenced inodes.
> 
> However, this isn't simple to do, and so getting rid of the inode
> LRU is not going to happen in the near term.

Ok.

> > and we can preallocate slots without
> > actually adding objects. Iteration will see NULLs that they skip over,
> > so we can't simply preallocate a slot for everything if nr_live_objects
> > / nr_lru_objects is too big. But, we can certainly preallocate slots on
> > a given code path and then release them back to the percpu buffer if
> > they're not used.
> 
> I'm not really that interested in spending time trying to optimise
> away list_lru contention at this point in time.

Fair, and I'm not trying to derail this one - whether dlock-list, or
fast-list, or super_iter_inodes(), we should do one of them. On current
mainline, I see lock contention bad enough to trigger bcachefs's 10
second "srcu lock held too long" warning, any of these solves the
biggest problem.

But...

> It's not a performance limiting factor because inode and
> dentry LRU scalability is controllable by NUMA configuration. i.e.
> if you have severe list_lru lock contention on inode and dentry
> caches, then either turn on Sub-NUMA Clustering in your bios,
> configure your VM with more discrete nodes, or use the fake-numa=N
> boot parameter to increase the number of nodes the kernel sets up.
> This will increase the number of list_lru instances for NUMA aware
> shrinkers and the contention will go away.

I don't buy this, asking users to change their bios (and even to know
that's a thing they should consider) is a big ask. Linked lists _suck_,
both w.r.t. locking and cache behaviour, and we need to be exploring
better options.

> > > - LRU lists are -ordered- (it's right there in the name!) and this
> > >   appears to be an unordered list construct.
> > 
> > Yes, it is. But in actual practice cache replacement policy tends not to
> > matter nearly as much as people think; there's many papers showing real
> > world hit ratio of common algorithms is only a fudge factor from random
> > replacement - the main thing you want is an accessed bit (or counter, if
> > you want the analagous version of n-lru for n > 2), and we'll still have
> > that.
> 
> Sure.  But I can cherry-pick many papers showing exactly the opposite.
> i.e. that LRU and LFU algorithms are far superior at maintaining a
> working set compared to random cache shootdown, especially when
> there is significant latency for cache replacement.

But as mentioned we won't be comparing against pure random, it'll be vs.
pure random with at least an accessed bit, preserving the multiple
generations which are the most important feature of LRU/LFU as we use
them.

> What matters is whether there are any behavioural regressions as a
> result of changing the current algorithm. We've used quasi-LRU
> working set management for so long that this is the behaviour that
> people have tuned their systems and applications to work well with.
> Fundamental changes to working set maintenance behaviour is not
> something I'm considering doing, nor something I *want* to do.

Yup, it's not going to be the easiest thing to tackle.

