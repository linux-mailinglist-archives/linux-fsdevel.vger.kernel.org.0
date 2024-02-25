Return-Path: <linux-fsdevel+bounces-12699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3136862929
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67D50B214B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662F09445;
	Sun, 25 Feb 2024 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ejansM5C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41198BF8
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 05:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708838706; cv=none; b=XZ4fD5ZRdUMSQuExAGeJiKFjI8P+RTal3/2pQtLlzvARD4HtfucKD6YfdhRl/aPOBNyItyk4RAM1jb5xCrkWvgxctgHFudPTdaP14msZsKZ59qYFqY3aRMMmvBNMkFqbIpMStGBli6WkihHffY0SCq7KqE11Uk8SeuUmABReEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708838706; c=relaxed/simple;
	bh=1CfEfrwe3C4OLirVXFdsJ8Sv4gD8Rv8Scya8onHEn+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unpm/OnknJ7lT4p6u+dJkiTGXSMEIT756mJ8t8yCz2HDgzw4L+iESsEAjgVtIQigwzSV2zcfbRh+bqCLFWyiGOjbH/8oA6/D2uE5GVeQDfudYncBeMxerdgE7gfsaQhqY5K6ZwWn1UsoM3yZH4ahSahILXvXqZVozV+JQnuLzd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ejansM5C; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 00:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708838703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjXC2JkYyp2zA7zOsHpwHQbHa4Lbe1SXOUcO5kMx/pc=;
	b=ejansM5CJH7RY0h0m/Dt6l70X+H72EK7MR9ktJAeBz4EG3DHFzGR9wrbYerDQQA8BVXto5
	BMhZIzr4GMEj31KUUECR+yPJyU1J5POUifBTI8EnWY5tZoA576sHeCewG0blpaT3EcZT2t
	kCTcDl0mVeEjyxhTgVBGAxqyAsDhm2k=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <45odvhgymm7fxsgwpewoiiggaokxjcr7ootsamm4rwsdw26j62@5lohhv2kvofo>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 23, 2024 at 03:59:58PM -0800, Luis Chamberlain wrote:
> Part of the testing we have done with LBS was to do some performance
> tests on XFS to ensure things are not regressing. Building linux is a
> fine decent test and we did some random cloud instance tests on that and
> presented that at Plumbers, but it doesn't really cut it if we want to
> push things to the limit though. What are the limits to buffered IO
> and how do we test that? Who keeps track of it?
> 
> The obvious recurring tension is that for really high performance folks
> just recommend to use birect IO. But if you are stress testing changes
> to a filesystem and want to push buffered IO to its limits it makes
> sense to stick to buffered IO, otherwise how else do we test it?
> 
> It is good to know limits to buffered IO too because some workloads
> cannot use direct IO.  For instance PostgreSQL doesn't have direct IO
> support and even as late as the end of last year we learned that adding
> direct IO to PostgreSQL would be difficult.  Chris Mason has noted also
> that direct IO can also force writes during reads (?)... Anyway, testing
> the limits of buffered IO limits to ensure you are not creating
> regressions when doing some page cache surgery seems like it might be
> useful and a sensible thing to do .... The good news is we have not found
> regressions with LBS but all the testing seems to beg the question, of what
> are the limits of buffered IO anyway, and how does it scale? Do we know, do
> we care? Do we keep track of it? How does it compare to direct IO for some
> workloads? How big is the delta? How do we best test that? How do we
> automate all that? Do we want to automatically test this to avoid regressions?
> 
> The obvious issues with some workloads for buffered IO is having a
> possible penality if you are not really re-using folios added to the
> page cache. Jens Axboe reported a while ago issues with workloads with
> random reads over a data set 10x the size of RAM and also proposed
> RWF_UNCACHED as a way to help [0]. As Chinner put it, this seemed more
> like direct IO with kernel pages and a memcpy(), and it requires
> further serialization to be implemented that we already do for
> direct IO for writes. There at least seems to be agreement that if we're
> going to provide an enhancement or alternative that we should strive to not
> make the same mistakes we've done with direct IO. The rationale for some
> workloads to use buffered IO is it helps reduce some tail latencies, so
> that's something to live up to.
> 
> On that same thread Christoph also mentioned the possibility of a direct
> IO variant which can leverage the cache. Is that something we want to
> move forward with?

The thing to consider here would be an improved O_SYNC. There's a fair
amount of tree walking and thread to thread cacheline bouncing that
would be avoided by just calling .write_folios() and kicking bios off
from .write_iter().

OTOH - the way it's done now is probably the best possible way of
splitting up the work between multiple threads, so I'd expect this
approach to get less throughput than current O_SYNC.

Luis, are you profiling these workloads? I haven't looked at high
throughput profiles of the buffered IO path in years, and that's a good
place to start.

