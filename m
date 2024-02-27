Return-Path: <linux-fsdevel+bounces-12957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF8B86962F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A9D1F2D139
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 14:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0813DBBC;
	Tue, 27 Feb 2024 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="40opcWTL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B713A26F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042941; cv=none; b=XinIJXKqRW+qLU0GqMSfb3YUcOW4Ecmw9UdLjFL0Nx+Hn6EImD7Lsg16t4S75jjjs3ELuLEn5qM92IRHfre5qWt3MnCL3GtQwhB1BEiJS8ZTBLPy71oD0PyEnZ2XTfus7ZoDi0H/lZfbRrOVMPqqCM268ZXU4lLOYrKHdu3un2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042941; c=relaxed/simple;
	bh=TreBfZry1ty8WfWUBLXFWH22SGT7WU2oPgKGNMFBgBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl1CuRsfIC0Zz7Ewhv78HqMjl30Yc8WUqlBcDy7deRRfuRfmmP9xMbmufBNnTZ5ujgowjzYIkJN5YrBlTydIsq5oOgYnaXCHx/up5bYvcXcZHG9fRfRKTCKjVG3/xESul43N92snF2jQNDRHiQ+7kUsF59MZihxIhnqHGA/cMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=40opcWTL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mfwl7kv+G9+gYG+E2kVWVOA4HLmODjdhMkg6/H53NvM=; b=40opcWTLbsEkDk0LDDQHajs/g6
	PmtHOAyWLGCVNOUQWt13SZywI268U2rGO6OGtGNPVQ0K7fPd0q6rgqOcWkIeJPqRaNokkkAqC00L6
	ItRaoBmUz/2A41L9ybu93OdKClrhyKLgqipUpGTa5jEWLLn6zou44/kSAcTyNmpet4qw15Jp4gN0K
	jMYXi5T8I+pPkQyQPjZLAzZrJSn51Nsm3NJ6wF8SqEETOBe8fvY8Nq9VLTqWe4wOeaTW8bMHZqoTb
	dYzki+XKreOaXdTZCa4qfrxDn4YBJTZUObImB4LoYaDNWZAWb/vv1aUvXjmnqJwXuRN9Iz7GH6B5T
	kCPxZi3w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rey8f-00000005WSH-3lEd;
	Tue, 27 Feb 2024 14:08:57 +0000
Date: Tue, 27 Feb 2024 06:08:57 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd3s-SPx_EnDXJzs@bombadil.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Feb 27, 2024 at 05:07:30AM -0500, Kent Overstreet wrote:
> On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> > Part of the testing we have done with LBS was to do some performance
> > tests on XFS to ensure things are not regressing. Building linux is a
> > fine decent test and we did some random cloud instance tests on that and
> > presented that at Plumbers, but it doesn't really cut it if we want to
> > push things to the limit though. What are the limits to buffered IO
> > and how do we test that? Who keeps track of it?
> > 
> > The obvious recurring tension is that for really high performance folks
> > just recommend to use birect IO. But if you are stress testing changes
> > to a filesystem and want to push buffered IO to its limits it makes
> > sense to stick to buffered IO, otherwise how else do we test it?
> > 
> > It is good to know limits to buffered IO too because some workloads
> > cannot use direct IO.  For instance PostgreSQL doesn't have direct IO
> > support and even as late as the end of last year we learned that adding
> > direct IO to PostgreSQL would be difficult.  Chris Mason has noted also
> > that direct IO can also force writes during reads (?)... Anyway, testing
> > the limits of buffered IO limits to ensure you are not creating
> > regressions when doing some page cache surgery seems like it might be
> > useful and a sensible thing to do .... The good news is we have not found
> > regressions with LBS but all the testing seems to beg the question, of what
> > are the limits of buffered IO anyway, and how does it scale? Do we know, do
> > we care? Do we keep track of it? How does it compare to direct IO for some
> > workloads? How big is the delta? How do we best test that? How do we
> > automate all that? Do we want to automatically test this to avoid regressions?
> > 
> > The obvious issues with some workloads for buffered IO is having a
> > possible penality if you are not really re-using folios added to the
> > page cache. Jens Axboe reported a while ago issues with workloads with
> > random reads over a data set 10x the size of RAM and also proposed
> > RWF_UNCACHED as a way to help [0]. As Chinner put it, this seemed more
> > like direct IO with kernel pages and a memcpy(), and it requires
> > further serialization to be implemented that we already do for
> > direct IO for writes. There at least seems to be agreement that if we're
> > going to provide an enhancement or alternative that we should strive to not
> > make the same mistakes we've done with direct IO. The rationale for some
> > workloads to use buffered IO is it helps reduce some tail latencies, so
> > that's something to live up to.
> > 
> > On that same thread Christoph also mentioned the possibility of a direct
> > IO variant which can leverage the cache. Is that something we want to
> > move forward with?
> > 
> > Chris Mason also listed a few other desirables if we do:
> > 
> > - Allowing concurrent writes (xfs DIO does this now)
> 
> AFAIK every filesystem allows concurrent direct writes, not just xfs,
> it's _buffered_ writes that we care about here.

The context above was a possible direct IO variant, that's why direct IO
was mentioned and that XFS at least had support.

> I just pushed a patch to my CI for buffered writes without taking the
> inode lock - for bcachefs. It'll be straightforward, but a decent amount
> of work, to lift this to the VFS, if people are interested in
> collaborating.
> 
> https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-buffered-write-locking

Neat, this is sort of what I wanted to get a sense for, if this sort of
topic was worth discussing at LSFMM.

> The approach is: for non extending, non appending writes, see if we can
> pin the entire range of the pagecache we're writing to; fall back to
> taking the inode lock if we can't.

Perhaps a silly thought... but initial reaction is, would it make sense
for the page cache to make this easier for us, so we have this be
easier? It is not clear to me but my first reaction to seeing some of
these deltas was what if we had something like the space split up, as we
do with XFS agcounts, and so each group deals with its own ranges. I
considered this before profiling, and as with Matthew I figured it might
be lock contenton.  It very likely is not for my test case, and as Linus
and Dave has clarified we are both penalized and also have a
singlthreaded writeback.  If we had a group split we'd have locks per
group and perhaps a writeback a dedicated thread per group.

  Luis

