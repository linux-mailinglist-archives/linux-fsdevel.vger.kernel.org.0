Return-Path: <linux-fsdevel+bounces-14167-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97909878A57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 22:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF681281D5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 21:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BF758119;
	Mon, 11 Mar 2024 21:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PjeEEZZZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20265788F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710194289; cv=none; b=St+A8wHrwOgpv1gwKh7d4G91eZ4WKXRmJzez5A9KslmhR0nXeIDVILajYL4CIRVC5wMJ1uSRQmezItWaAtVMq5ZY/b2l9I8jvphKi6/gGoC++NTrKjo8s5GMJJAYelnsamvOqE1K1KZgH2hD7RuFp9jTnKHnJ6KBubxvGtQCP/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710194289; c=relaxed/simple;
	bh=w7sDwMTOerzm5Xuh65hVklRXhpKp6FBoNlhDuRwSpbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giUeyjXzNTGsKlZv9aphx91nLyXu7bnqGn2xRGS/TxOnXOwbvxdOjgnDqOOJdQXGZjRPuGARSYDaZaasMOphtc7zd4t5cs755Bu5uSqYk6UTvqw5tP3PE8QrfEMZR3xSWOHFuAf4a/ZHqS5sHJS8gWhjkp4idz7qHCgOBSj60Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PjeEEZZZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 11 Mar 2024 17:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710194285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeeH/7m++KX2oHbcaD4O3D3wB1bE8G5L6OD8vROvCMs=;
	b=PjeEEZZZ8xmURmO9iA+N4D6/z6N2s2JEysfHvtYzfhhVzJcuiDzmZgzARQ6jBTtGh53QFN
	uN7Aq8DOahWDNmhBKh+NxcPoqZZWvN/VDZ01eGFZZo39SVBUk0FVY9Jxc5/+PGAja1WqeU
	DWBglQvjHU5r5+JQ3QJPoFVBOG0Rvzw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: On the optimum size of a batch
Message-ID: <3rn4qk754v7esfz3gtcjwoxoguidu5o6bv4mumwmfmzaq27bir@5td5wd4xdjoj>
References: <Zeoble0xJQYEAriE@casper.infradead.org>
 <Ze5onaXsI+LT1+Be@dread.disaster.area>
 <Ze59byUR80z42m8R@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze59byUR80z42m8R@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 11, 2024 at 03:41:35AM +0000, Matthew Wilcox wrote:
> On Mon, Mar 11, 2024 at 01:12:45PM +1100, Dave Chinner wrote:
> > > Batch size      Cost of allocating 100          thousand        million
> > > 1               500 (5 * 100)                   5000            5M
> > > 2               300 (6 * 50)                    3000            3M
> > > 4               200 (8 * 25)                    2000            2M
> > > 8               156 (12 * 13)                   1500            1.5M
> > > 16              140 (20 * 7)                    1260            1.25M
> > > 32              144 (36 * 4)                    1152            1.13M
> > > 64              136 (68 * 2)                    1088            1.06M
> > > 128             132 (132 * 1)                   1056            1.03M
> > 
> > Isn't this just repeating the fundamental observation that SLUB is
> > based on?  i.e. it can use high-order pages so that it can
> > pre-allocate optimally sized batches of objects regardless of their
> > size? i.e.  it tries to size the backing page order to allocate in
> > chunks of 30-40 objects at a time?
> 
> What SLUB is currently doing is inefficient.  One of the conversations
> I had (off-list) about appropriate batch size is in relation to SLUB-ng
> where one of the participants claimed that the batch size of 32 was
> obviously too small (it wasn't; the performance problem was due to a
> bug).
> 
> What you're thinking about is the cost of allocating from the page
> allocator (which is now much cheaper than it used to be, but should
> be cheaper than it currently is).  But there is another inefficiency
> to consider, which is that the slab allocator has a per-slab lock,
> and while you can efficiently remove and add a number of objects to
> a single slab, you might only have one or two free objects per slab.
> To work around this some of the more performance sensitive parts of the
> kernel have implemented their own allocator in front of slab.  This is
> clearly a bad thing for all of us, and hence Vlastimil has been working
> on a better approach.
> 
> https://lore.kernel.org/linux-mm/20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz/
> 
> > Except for SLUB we're actually allocating in the hundreds of
> > millions to billions of objects on machines with TBs of RAM. IOWs we
> > really want to be much further down the curve than 8 - batches of at
> > least 32-64 have significantly lower cost and that matters when
> > scaling to (and beyond) hundreds of millions of objects....
> 
> But that doesn't necessarily mean that you want a larger batch size.
> Because you're not just allocating, you're also freeing and over a
> large enough timescale the number of objects allocated and freed is
> approximately equal.  In the SLUB case, your batch size needs to be
> large enough to absorb most of the allcation-vs-free bias jitter; that
> is if you know they always alternate AFAFAFAFAF a batch size of 2 would
> be fine.  If you know you get four allocations followed by four frees,
> having a batch size of 5 woud be fine.  We'd never go to the parent
> allocator if we got a AFAAFFAAAFFFAAAAFFFFAAFFAFAAFAAFFF pattern.

taking a step back - you're talking about one particular use case for
fbatch, but fbatch is used for lots of different things (there are lots
of places we want to vectorize and batch!).

There's also lots of different cache effects to consider. It's not just
data cache that's an issue; if we only consider data cache a smaller
fbatch might be preferable, so that our working set stays entirely in
L1.

But - icache usage always wants a larger batch size; "do this one thing
with all the pages", then jump to unrelated code and do the next thing -
larger batch size means fewer icache misses. And icache is branchier and
harder to prefetch than access to fbatch - it's just a vector - but
you're going to be seeing that a lot less in microbenchmarks than in
real world code.

Real world, you want to just hand off the _whole_ dataset you're working
on from one codepath to the next whereever practical.

this is why I've been harping on the readahead path - the way it makes
the fs repeatedly do xarray lookups to get the next folio when the core
mm/readahead.c code _already did that_ instead of just passing it a
vector is totally stupid...

and, if fbatch had been a proper dynamically sized vector instead of a
small fixed size array, this never would've happened in the first
place...

