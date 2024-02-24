Return-Path: <linux-fsdevel+bounces-12670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22A186269E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 19:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600661F21373
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA12487AE;
	Sat, 24 Feb 2024 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwO9NV2A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04E17C74
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 18:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708798406; cv=none; b=eTftnwDtkaU0UQEWQxLPD4lJ0ba9u0ddKLPDMUq6BSXjO5cieyDKia6dWeyXEsbe7KIfEceFTPRn2mESGqSanm2wRozG5sB8pYTvV2oxKRmmV5MmTbbpm7xt9KiuEekY0sOdiopXnYhQrJpPZPjY44FCkBrtDroX7Dq/s5hIcE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708798406; c=relaxed/simple;
	bh=7snYNqxS2G2Ac16wnrqSZsfuz7RnLnUdhVLTm3D2WJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOm6ojBTsv491ef0jNE2Sj4orjWRKMB5BVU8ZvvoFjLSaaSq9CHCnVYb20Ren8VQ7u1Ma5c3IX8EJ7qWOIKYlC9Fqfp6IdRDaWd7VqO/oB96MK6xeCAiAl1K4Xe1ZQ0b5Mn+NJ2sogOCe41L2VoB8w6h52LeWOp0E/Z79ZAmAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwO9NV2A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Gqu6DXrP8Slk+IazA2w1RT9aS9FzXuXHguOaEpxhDk=; b=qwO9NV2Al8a5D03bhsEZ5im3XA
	Pg6tFxq7tJsY0VJiHZGJ/lxFZEuZmipPI4TF5AgsNoy7ZEcNDYZ+tqJm90YfYKW1CwUkLJIS5XATn
	fQY9NTdAkgHBGFoSV1wz+zUCsO2OylBDHSU8ZbDV3zVBDZiowZqvkNio70/ZzQe2gCTutWbR4WeyW
	B6SfwdAsiFhNJhJ7niLX+wjAiwIxwZ7QiZc3iCTX2pB3FZB7+IPiYscdW1X1GaaQvhywyJbWyd/3r
	FDaUZ73i51jNpq3lCh0iIDhmdHkCrY0q3U6GagaPUxk/uPpB/4pn9zLXbjg1oj2dsYDd9MOmrjGVS
	AxTuu7uQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdwWO-0000000BUrR-2wmF;
	Sat, 24 Feb 2024 18:13:12 +0000
Date: Sat, 24 Feb 2024 18:13:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ZdoxuNx0Tt0E-Lzy@casper.infradead.org>
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

For a lot of things our pagecache is amazing.  And in other ways it
absolutely sucks.  The trick will be fixing those less-used glass jaws
without damaging the common cases.

> When you have to have completely unrealistic loads that nobody would
> actually care about in reality just to get a number for the limit,
> it's not a sign of problems.

No, but sometimes the unrealistic loads are, alas, a good proxy for
problems that customers hit.  For example, I have one where the customer
does an overnight backup with a shitty backup program that doesn't use
O_DIRECT and ends up evicting the actual working set from the page
cache.  They start work the next morning with terrible performance
because everything they care about has been swapped out.  The "fix"
is to limit the pagecache to one NUMA node.  I suspect if this customer
could be persuaded to run a more recent kernel that this problem has
been solved, so I'm not sure there's a call to action from this
particular case.

Anyway, if there's a way to fix an unrealistic load that doesn't affect
realistic loads, sometimes we fix a customer problem too.

> Guess what? It's because the CPU in question had quite a bit of L3,
> and it was spread out, and the CPU doesn't even start the memory
> access before it has checked caches.
> 
> And here's a big honking clue: only a complete nincompoop and mentally
> deficient rodent would look at that and say "caches suck".

although the problem might be that the CPU has a terrible cross-chiplet
interconnect ;-)

> > >  ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
> > >      Vs
> > >  ~ 7,000 MiB/s with buffered IO
> >
> > Profile?  My guess is that you're bottlenecked on the xa_lock between
> > memory reclaim removing folios from the page cache and the various
> > threads adding folios to the page cache.
> 
> I doubt it's the locking.

It might not be!  But there are read-only workloads that do bottleneck
on the xa_lock.

> For writeout, we have a very traditional problem: we care about a
> million times more about latency than we care about throughput,
> because nobody ever actually cares all that much about performance of
> huge writes.
> 
> Ask yourself when you have last *really* sat there waiting for writes,
> unless it's some dog-slow USB device that writes at 100kB/s?

You picked a bad day to send this email ;-)

$ sudo dd if=Downloads/debian-testing-amd64-netinst.iso of=/dev/sda
[sudo] password for willy:
1366016+0 records in
1366016+0 records out
699400192 bytes (699 MB, 667 MiB) copied, 296.219 s, 2.4 MB/s

ok, that was a cheap-arse USB stick, but then I had to wait for the
installer to write 800GB of random data to /dev/nvme0n1p3 as it set up
the crypto drive.  The Debian installer didn't time that for me, but it
was enough time to vacuum the couch.

> Now, the benchmark that Luis highlighted is a completely different
> class of historical problems that has been around forever, namely the
> "fill up lots of memory with dirty data".
> 
> And there - because the problem is easy to trigger but nobody tends to
> care deeply about throughput because they care much much *MUCH* more
> about latency, we have a rather stupid big hammer approach.
> 
> It's called "vm_dirty_bytes".
> 
> Well, that's the knob (not the only one). The actual logic around it
> is then quite the moreass of turning that into the
> dirty_throttle_control, and the per-bdi dirty limits that try to take
> the throughput of the backing device into account etc etc.
> 
> And then all those heuristics are used to actually LITERALLY PAUSE the
> writer. We literally have this code:
> 
>                 __set_current_state(TASK_KILLABLE);
>                 bdi->last_bdp_sleep = jiffies;
>                 io_schedule_timeout(pause);
> 
> in balance_dirty_pages(), which is all about saying "I'm putting you
> to sleep, because I judge you to have dirtied so much memory that
> you're making things worse for others".
> 
> And a lot of *that* is then because we haven't wanted everybody to
> rush in and start their own synchronous writeback, but instead watn
> all writeback to be done by somebody else. So now we move from
> mm/page-writeback.c to fs/fs-writeback.c, and all the work-queues to
> do dirty writeout.
> 
> Notice how the io_schedule_timeout() above doesn't even get woken up
> by IO completing. Nope. The "you have written too much" logic
> literally pauses the writer, and doesn't even want to wake it up when
> there is no more dirty data.
> 
> So the "you went over the dirty limits It's a penalty box, and all of
> this comes from "you are doing something that is abnormal and that
> disturbs other people, so you get an unconditional penalty". Yes, the
> timeout is then obviously tied to how much of a problem the dirtying
> is (based on that whole "how fast is the device") but it's purely a
> heuristic.
> 
> And (one) important part here is "nobody sane does that".  So
> benchmarking this is a bit crazy. The code is literally meant for bad
> actors, and what you are benchmarking is the kernel telling you "don't
> do that then".

This was a really good writeup, thanks.  I think this might need some
tuning (if it is what's going on).  When the underlying device can do
86GB/s and we're only getting 7GB/s, we could afford to let this writer
do a bit more.


