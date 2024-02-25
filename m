Return-Path: <linux-fsdevel+bounces-12704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1F86293F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 07:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43CC1C20A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7461F9460;
	Sun, 25 Feb 2024 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V43mQgOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1249944C
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 06:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708841065; cv=none; b=PvZ8LdBEWMis6oHdYKgAGZywjMSbQf/YbaKzM8oFrL2NmsXZeSjdTEv1eoC5cLmx8Vek4DHe1xKwXpr357ryRRHzM6qqHE0lyKcwZhqiIhfnyGajhvCBNZOPPrdOujQIUvA3KlS4Cn7JJpJOW7u3c+lKbgX3mrXu6panqDIsyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708841065; c=relaxed/simple;
	bh=JJvyQZjrGpov012p9DTG2WtVXwJguDkoEQmwGFHIs3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPW47Ib4K5/NjDpELTkmiahLL10T7MftKIbv4XnZ7SjQ0ukeoI4mCl30dsfUOfSY/C+ffdBtG5CJMm9S8RcbtDYrOcagGZZIEwLuyKPZHVBDp4/3zh04F9g1SoLuL/SE+pZnod58lVQM+SDGkmU7ulY4GTCxnrAUNjzz4YMNrk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V43mQgOl; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 01:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708841061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EU36V1tQnx8vg/C/vT87h1j5srV/PUH7jtLIv7q7Y8c=;
	b=V43mQgOl/1kcRNScKdPzTjfI1RWxuVr3a/tvexOgqRTZWPAIhGs+V4YBcFfKrCeYf8CgWI
	bChE1KDA27Xd0vTX6/2sgk9hGj9PaSYpXAULgD4vCdEZXQop5IsyRk3ugszrPTRjb0b0On
	xDfFwzScN9ipv/ibN0O1Oq5HGGX/eEo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <vtbdx77a7kzibpi543abxmu3jjhpztuhna6epzleu4e5wmkrrf@roejpebs23cm>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 12:18:23AM -0500, Kent Overstreet wrote:
> On Sat, Feb 24, 2024 at 09:31:44AM -0800, Linus Torvalds wrote:
> Before large folios, we had people very much bottlenecked by 4k page
> overhead on sequential IO; my customer/sponsor was one of them.
> 
> Factor of 2 or 3, IIRC; it was _bad_. And when you looked at the
> profiles and looked at the filemap.c code it wasn't hard to see why;
> we'd walk a radix tree, do an atomic op (get the page), then do a 4k
> usercopy... hence the work I did to break up
> generic_file_buffered_read() and vectorize it, which was a huge
> improvement.
> 
> It's definitely less of a factor when post large folios and when we're
> talking about workloads that don't fit in cache, but I always wanted to
> do a generic version of the vectorized write path that brfs and bcachefs
> have.

to expound further, our buffered io performance really is crap vs.
direct in lots of real world scenarios, and what was going on in
generic_file_buffered_read() was just one instance of a larger theme -
walking data structures, taking locks/atomics/barriers, then doing work
on the page/folio with cacheline bounces, in a loop - lots of places
where batching/vectorizing would help a lot but it tends to be
insufficient.

i had patches that went further than the generic_file_buffered_read()
rework to vectorize add_to_page_cache_lru(), and that was another
significant improvement.

the pagecache lru operations were another hot spot... willy and I at one
point were spitballing getting rid of the linked list for a dequeue,
more for getting rid of the list_head in struct page/folio and replacing
it with a single size_t index, but it'd open up more vectorizing
possibilities

i give willy crap about the .readahead interface... the way we make the
filesystem code walk the xarray to get the folios instead of just
passing it a vector is stupid

folio_batch is stupid, it shouldn't be fixed size. there's no reason for
that to be a small fixed size array on the stack, the slub fastpath has
no atomic ops and doesn't disable preemption or interrupts - it's
_fast_. just use a darray and vectorize the whole operation

but that wouldn't be the big gains, bigger would be hunting down all the
places that aren't vectorized and should be.

i haven't reviewed the recent .writepages work christoph et all are
doing, if that's properly vectorized now that'll help

