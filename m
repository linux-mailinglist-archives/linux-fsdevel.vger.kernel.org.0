Return-Path: <linux-fsdevel+bounces-12698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA653862927
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9911F21AA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5DF8F6A;
	Sun, 25 Feb 2024 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JA7cRX5I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0A5256
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 05:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708838311; cv=none; b=XpNMwHlEKY+4cMxuUasibaCm8fyy8tvjN2cjy2s7K0lGOxNHjX18wmEzQszJvIs3To/uhFLDPYlrETalW/tcm+Is0+XMilZVvfdk0Jglk7XbBZNd9msLi2VA1E7w67BnszVjpR0pbtD3J9bJom5DFYFOlJx8wwmNqqH/QKRscCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708838311; c=relaxed/simple;
	bh=UQyvzQT5mJT5RsaYxh80RJ7a6f0EvtNVHhpuUbIacZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAB2qYrqNkhNJxCFyPtn719z5L4VdRqH0oUod+l6A+NRuA5UNsr7Z4DeOg8mA+CVIwV3GY75XN6nRUTvm6IOrHVCPOQ/QZtitAsnqohP67eR6TOqS/HiwsmVjjlK49wnA92LmWJqeFdhIoflgDUQHEHa8ySjZEovbQAkGd1+W3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JA7cRX5I; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 00:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708838307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RMvvtI3oHlC3+eGlhXg1wyOhQeHTqMrpBTAyQcmrNl8=;
	b=JA7cRX5IMqTETECo+eZdzsrpyGWVpDI4GQsB6yJ8+/SnTuwJ86wx32xSJ0WFCx1xGWwZsO
	i5FAfW8OLJCSqIPasQAns2lOiZxlK0eZl0nB2yv0ZCayaE+nSaiwe+DQAEJ2aaHku/LYCb
	XzldhcQ3+Qh8IUE34SoAdjKxRicsGOA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Feb 24, 2024 at 09:31:44AM -0800, Linus Torvalds wrote:
> On Fri, 23 Feb 2024 at 20:12, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> > >  What are the limits to buffered IO
> > > and how do we test that? Who keeps track of it?
> >
> > TLDR: Why does the pagecache suck?
> 
> What? No.
> 
> Our page cache is so good that the question is literally "what are the
> limits of it", and "how we would measure them".
> 
> That's not a sign of suckage.
> 
> When you have to have completely unrealistic loads that nobody would
> actually care about in reality just to get a number for the limit,
> it's not a sign of problems.
> 
> Or rather, the "problem" is the person looking at a stupid load, and
> going "we need to improve this because I can write a benchmark for
> this".
> 
> Here's a clue: a hardware discussion forum I visit was arguing about
> memory latencies, and talking about how their measured overhead of
> DRAM latency was literally 85% on the CPU side, not the DRAM side.
> 
> Guess what? It's because the CPU in question had quite a bit of L3,
> and it was spread out, and the CPU doesn't even start the memory
> access before it has checked caches.
> 
> And here's a big honking clue: only a complete nincompoop and mentally
> deficient rodent would look at that and say "caches suck".
> 
> > >  ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
> > >      Vs
> > >  ~ 7,000 MiB/s with buffered IO
> >
> > Profile?  My guess is that you're bottlenecked on the xa_lock between
> > memory reclaim removing folios from the page cache and the various
> > threads adding folios to the page cache.
> 
> I doubt it's the locking.
> 
> In fact, for writeout in particular it's probably not even the page
> cache at all.
> 
> For writeout, we have a very traditional problem: we care about a
> million times more about latency than we care about throughput,
> because nobody ever actually cares all that much about performance of
> huge writes.

Before large folios, we had people very much bottlenecked by 4k page
overhead on sequential IO; my customer/sponsor was one of them.

Factor of 2 or 3, IIRC; it was _bad_. And when you looked at the
profiles and looked at the filemap.c code it wasn't hard to see why;
we'd walk a radix tree, do an atomic op (get the page), then do a 4k
usercopy... hence the work I did to break up
generic_file_buffered_read() and vectorize it, which was a huge
improvement.

It's definitely less of a factor when post large folios and when we're
talking about workloads that don't fit in cache, but I always wanted to
do a generic version of the vectorized write path that brfs and bcachefs
have.

