Return-Path: <linux-fsdevel+bounces-10536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548D584C0F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E4A1C21715
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1D51CF95;
	Tue,  6 Feb 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqohHpns"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74B1CD2D;
	Tue,  6 Feb 2024 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262439; cv=none; b=Wp+kPyXC9/ocS+26FExWNj6hsFCo2JZtMTevWwMxR73sQEcI6MtN6wGkLScNia0/DH17Oi7VP3vQpzURiZx3Pu2G9EyPlq7MAxT6EqJC8hfU4PsyAY5LFjJRa7gEs/ASg4AbWNoDARHtTTHoqplBECMZRj4qusGYzbjTs9uXm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262439; c=relaxed/simple;
	bh=2ujnuBthhHC/WoSoD6QQnKnumAsVCVROyse7z/cd2Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF8ijqeXeJWedsx4I4J9xdTzauUxkCSodJkBjin6O0WLbAFEROlnfRqwgQIJ64I1Yq5WgD49UWN1fiTgvA+++S5LQw3X0NIvARc3LVQqG5nafN0mE6osI14GjRBXoataVSMxXLDbbwAc0i+bGvvnVUVHjCNvF41Jv3TSKP5/hZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DqohHpns; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8/qSJOR+zkPPH2i9c8ryKssFXsF/wlJRBdyNQ7Hk1aE=; b=DqohHpnsHhxigSOb2sDDtK0Fhc
	fyh+uGH2Fco/NlpE7qCu1h0/QL08p7YxPsuyrr82HitYHg6Wl50QXE2uT6iPlhiH8TG+3oGbvJTlN
	Q2tM0egXmVzf8Cq2CKFxaPIwHE6GHtD6rc9vs5lJ34/ALMtAKvYB0XomAiNX97VaykYZH+PilsDL4
	g/g3eMmOauaS3wMA5ZNZ9wQqGJhIFxATgaihdzr1DPe9v6ITphy1NzysdvfqhkZDvsE3sYE7Ohn9k
	ZvQ2EzS7RqqmpLIyHYMtgJpHtE3wtyaMSjmMmuVZAa+NQ/6dEylc3uMbVwOcdBnsfaNinNliG2KP0
	9QDf7r/w==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXUwo-0000000DaA9-1Twe;
	Tue, 06 Feb 2024 23:33:50 +0000
Date: Tue, 6 Feb 2024 23:33:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: JonasZhou-oc <JonasZhou-oc@zhaoxin.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, CobeChen@zhaoxin.com,
	LouisQi@zhaoxin.com, JonasZhou@zhaoxin.com
Subject: Re: [PATCH] fs/address_space: move i_mmap_rwsem to mitigate a false
 sharing with i_mmap.
Message-ID: <ZcLB3pCSFRXRodzN@casper.infradead.org>
References: <20240202093407.12536-1-JonasZhou-oc@zhaoxin.com>
 <Zb0EV8rTpfJVNAJA@casper.infradead.org>
 <Zb1DVNGaorZCDS7R@casper.infradead.org>
 <ZcBUat4yjByQC7zg@dread.disaster.area>
 <ZcFvHfYGH7EwGBRK@casper.infradead.org>
 <ZcKmP3zVdBwJVxGd@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcKmP3zVdBwJVxGd@dread.disaster.area>

On Wed, Feb 07, 2024 at 08:35:59AM +1100, Dave Chinner wrote:
> > The solution to this problem is to change the interval tree data structure
> > from an Red-Black tree to a B-tree, or something similar where we use
> > an array of pointers instead of a single pointer.
> 
> .... B-trees are not immune to pointer chasing problems, either.
> Most use binary searches within the nodes, and so we have the
> problem of unpredictable cacheline misses within the nodes as well
> as being unable to do depth based prefetch similar to rbtrees.
> 
> Perhaps we should be looking at something like this:
> 
> https://lore.kernel.org/linux-fsdevel/20240126220655.395093-2-kent.overstreet@linux.dev/

I need more data (and maybe Kent has it!)

Without any data, I believe that Eytzinger layout is an idea that was
a really good one in the 1990s/2000s and has now passed its expiration
date because of the changed nature of hardware.

In the mid-90s, we could do O(10) instructions in the time it took to
service a LLC miss.  Today, it's more like O(2500).  That means it is
far more important to be predictable than it is to execute the minimum
number of instructions.  If your B-tree nodes are 256kB in size (I believe
that's what bacachefs is using?), then Eytzinger layout may make some
sense, but if you're using smaller nodes (which I further believe is
appropriate for an in-memory B-tree), then a straight 'load each index
and compare it' may outperform a search that jumps around inside a node.

I'm pontificating and will happily yield to someone who has data.
I've tried to mark my assumptions clearly above.


Something else I'm not aware of (and filesystem B-trees will not have
any experience of) is what research exists on efficiently adding new
entries to a balanced tree so as to minimise rebalances.  Filesystems
are like the Maple Tree in that for every logical offset inside a file,
there is precisely one answer to "what physical block does this map to".

For the i_mmap tree, we want instead to answer the question "Which VMAs
have an intersection with this range of the file", and for the benchmark
in question, we will have a large number of entries that compare equal to
each other (they have the same start, and same end, but different values).
So they could be inserted at many different points in the tree.  We'd like
to choose the point which causes the least amount of rebalancing.

