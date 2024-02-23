Return-Path: <linux-fsdevel+bounces-12635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F598620E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 01:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9EE11F269C1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Feb 2024 00:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4E979921;
	Sat, 24 Feb 2024 00:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ngS1pKDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FDD14A0BE
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Feb 2024 00:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732802; cv=none; b=Dv+AJBMocOdw5RCtpyCZCQZJv6CVOYPEVRKGIp0vQiXtTpkHcm26LFn3j/cM36+inKD9sbGcb8R90afX8APvp6zrquBSqJ3cxt9FkNSW8XGtOc2/AdCpUS+nQdAD3Lmnhh3O3omACO/uJ35vBS0chCuflZ3dz2/982HJJo2Lc7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732802; c=relaxed/simple;
	bh=X/coXRMgH1LidiuVbX33+DX5+4JqzHI8woGKMXUxLk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GZVfM6F8KHrgb5TlLWf3ENW0EEBUlSITdygsTVxf8xcbs4K4ipYqMiehx5+3ABBlnzBVEbGJV3AnCeX73twg8v214dlZdhbT//aO3OfHXPtElCSr6YBaIydPa858QSFh7a+Myrug1PaXX7gIGmA0/kNJNMj+tk/NcOW+bavb9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ngS1pKDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NSRNvPsVeIaZPIJCaBxXpJSPajdOJhOWKus4L4my9TQ=; b=ngS1pKDVnVh8JOBFSfTtyMwEl8
	BipkQ+wYWv6j2lEQQV9CkOGRhbysWaDFrhXEnwuJXA90hoFfzNUaAcCjqHiymjgicy5/TA71yEA1E
	S+F9O8pzMsQCP4FkqNLC/aqRm2rf/S6BA6KScMg2VIEgFUIIoRgyw4kbFScOdSVB4zBjSRHoPWFSw
	8eoJS2LkXolVetSIEJbAQLWRXbfxCeRhVU95szLeOXMPm/FsPGxnKtxlkY9GkN54Ih4gcIMfCRRcr
	JN5T0KIeOtzsK4sxm0L8gb3zQKZpgE4Zi/zyMlOvJ6HxXbP7gweOhUjhMJ3JuqGYkxDCw/j/Pofds
	ztKqYeeQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdfSQ-0000000Bcwo-2L3b;
	Fri, 23 Feb 2024 23:59:58 +0000
Date: Fri, 23 Feb 2024 15:59:58 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, mcgrof@kernel.org
Subject: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>

Part of the testing we have done with LBS was to do some performance
tests on XFS to ensure things are not regressing. Building linux is a
fine decent test and we did some random cloud instance tests on that and
presented that at Plumbers, but it doesn't really cut it if we want to
push things to the limit though. What are the limits to buffered IO
and how do we test that? Who keeps track of it?

The obvious recurring tension is that for really high performance folks
just recommend to use birect IO. But if you are stress testing changes
to a filesystem and want to push buffered IO to its limits it makes
sense to stick to buffered IO, otherwise how else do we test it?

It is good to know limits to buffered IO too because some workloads
cannot use direct IO.  For instance PostgreSQL doesn't have direct IO
support and even as late as the end of last year we learned that adding
direct IO to PostgreSQL would be difficult.  Chris Mason has noted also
that direct IO can also force writes during reads (?)... Anyway, testing
the limits of buffered IO limits to ensure you are not creating
regressions when doing some page cache surgery seems like it might be
useful and a sensible thing to do .... The good news is we have not found
regressions with LBS but all the testing seems to beg the question, of what
are the limits of buffered IO anyway, and how does it scale? Do we know, do
we care? Do we keep track of it? How does it compare to direct IO for some
workloads? How big is the delta? How do we best test that? How do we
automate all that? Do we want to automatically test this to avoid regressions?

The obvious issues with some workloads for buffered IO is having a
possible penality if you are not really re-using folios added to the
page cache. Jens Axboe reported a while ago issues with workloads with
random reads over a data set 10x the size of RAM and also proposed
RWF_UNCACHED as a way to help [0]. As Chinner put it, this seemed more
like direct IO with kernel pages and a memcpy(), and it requires
further serialization to be implemented that we already do for
direct IO for writes. There at least seems to be agreement that if we're
going to provide an enhancement or alternative that we should strive to not
make the same mistakes we've done with direct IO. The rationale for some
workloads to use buffered IO is it helps reduce some tail latencies, so
that's something to live up to.

On that same thread Christoph also mentioned the possibility of a direct
IO variant which can leverage the cache. Is that something we want to
move forward with?

Chris Mason also listed a few other desirables if we do:

- Allowing concurrent writes (xfs DIO does this now)
- Optionally doing zero copy if alignment is good (btrfs DIO does this now)
- Optionally tossing pages at the end (requires a separate syscall now)
- Supporting aio via io_uring

I recently ran a different type of simple test, focused on sequantial writes
to fill capacity, with write workload essentially matching your RAM, so
having parity with your RAM. Technically in the case of max size that I
tested the writes were just *slightly* over the RAM, that's a minor
technicality given I did other tests with similar sizes which showed similar
results... This test should be possible to reproduce then if you have more
than enough RAM to spare. In this case the system uses 1 TiB RAM, using
pmem to avoid drive variance / GC / and other drive shenanigans.

So pmem grub setup:

memmap=500G!4G memmap=3G!504G

As noted earlier, surely, DIO / DAX is best for pmem (and I actually get
a difference between using just DIO and DAX, but that digresses), but
when one is wishing to test buffered IO on purpose it makes sense to do
this. Yes, we can test tmpfs too... but I believe that topic will be
brought up at LSFMM separately.  The delta with DIO and buffered IO on
XFS is astronomical:

  ~86 GiB/s on pmem DIO on xfs with 64k block size, 1024 XFS agcount on x86_64
     Vs
 ~ 7,000 MiB/s with buffered IO

Let's recap, the system had 1 TiB RAM, about half was dedicated for
pmem: it used two pmem paritions one 500 GiB for XFS and another 3 GiB
for an XFS external journal. The system has DDR5 which has a cap at
35.76 GiB/s. The proprietary intel tool to test RAM crashes on me... and
leaves a kernel splat that seems to indicate the tool is doing something
we don't allow anymore. So I couldn't get an aggregate RAM baseline on
just RAM. The kernel used was 6.6.0-rc5 + our LBS changes on top.

The buffered io fio incantation:

fio -name=ten-1g-per-thread --nrfiles=10 -bs=2M -ioengine=io_uring
-direct=0
--group_reporting=1 --alloc-size=1048576 --filesize=1GiB
--readwrite=write --fallocate=none --numjobs=$(nproc) --create_on_open=1
--directory=/mnt

This dedicates 1 GiB to scale up to nproc (128) threads, it will then
use each thread to write 1 GiB of data at a time 10 times. So 10 files
of 1 GiB per thread. So this easily fills until we're out of space. Each
threads ends up writing about ~300 - 400 MiB per each of its 10 files as
we run out of space fast.

-direct=1 for direct IO and -direct=0 for buffered IO.

Perhaps this is a silly topic to bring up, I don't know, but it seemed
to me just strikinly low the max throughput wall on writes given the
amount of free memory on the system.

Reducing the data written to say just 128 GiB makes the throughput climb
to about ~ 13 GiB/s for buffered IO... but doubling that to 256 GiB we
get only 9276 MiB/s.  So even if we have twice the RAM available we hit
a throughput wall which is *still* astronomically different than direct
IO with this setup.

Should we talk about these things at LSFMM? Are folks interested?

[0] https://lwn.net/Articles/806980/
[1] https://patchwork.kernel.org/project/linux-fsdevel/cover/20191211152943.2933-1-axboe@kernel.dk/

  Luis

