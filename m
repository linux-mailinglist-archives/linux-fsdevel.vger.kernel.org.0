Return-Path: <linux-fsdevel+bounces-12934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9B6868CF0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 11:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18E091F2520C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 10:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360E137C39;
	Tue, 27 Feb 2024 10:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LMtICWEa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F554BF6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709028460; cv=none; b=iotZTsji/MokMOBYtGc5ognhC2OMt+StoHlUJ/zvMKH8Re2Or/ztV9/w0uM6ePQwGZmBwPyNYo9+sK0iNYW7RmTlz8fW/kmfrmbfbgC6WLcFWkPo8K6kYbI0zSNPjs8ylywPVyWvPwJwDUaoNXYQUkG8TTWCfcUJq8s5dY1zje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709028460; c=relaxed/simple;
	bh=lFqmCvNuSnrtDXfwZPvqi4GOjPQf4rE+nzgp71ZpOZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gza0zRboaQkNdPrkU0JqBIY44dJ6sT7Nwl5RRkPd+JdC9jj9xthwO3LJF+clhVe89j5R6YZS5+SZHM5o8UaYDSpO1VCM7Gpo+bfYAHPdJfjbHYQjs/tQ3Fh/Xq+LiqSqroFLamPfFpi1ffICBstRSd49yYHHp4pbW5N9WeHgSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LMtICWEa; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 05:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709028455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZC5i4ceQpeqp2EF6ln2H0aYPVsQ9lMsdpe13g+8CkTk=;
	b=LMtICWEaJAvln4EHFOHqfvW0WdwRkhPAFA4RAmLEPC0UlQKynmTwOFxR3BXH9HEPHwtIwE
	kLJOiG1WBli06FqIkK/WbcExtHcUvtnbQ7gOkvmzg6qNiN7Sn32d7xcMPYce7qNPG77F/q
	nr4SNYXzHWel1xTrv/UCgq3+oia+WVA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
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
> 
> Chris Mason also listed a few other desirables if we do:
> 
> - Allowing concurrent writes (xfs DIO does this now)

AFAIK every filesystem allows concurrent direct writes, not just xfs,
it's _buffered_ writes that we care about here.

I just pushed a patch to my CI for buffered writes without taking the
inode lock - for bcachefs. It'll be straightforward, but a decent amount
of work, to lift this to the VFS, if people are interested in
collaborating.

https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-buffered-write-locking

The approach is: for non extending, non appending writes, see if we can
pin the entire range of the pagecache we're writing to; fall back to
taking the inode lock if we can't.

If we do a short write because of a page fault (despite previously
faulting in the userspace buffer), there is no way to completely prevent
torn writes an atomicity breakage; we could at least try a trylock on
the inode lock, I didn't do that here.

For lifting this to the VFS, this needs
 - My darray code, which I'll be moving to include/linux/ in the 6.9
   merge window
 - My pagecache add lock - we need this for sychronization with hole
   punching and truncate when we don't have the inode lock.
 - My vectorized buffered write path lifted to filemap.c, which means we
   need some sort of vectorized replacement for .write_begin and
   .write_end

