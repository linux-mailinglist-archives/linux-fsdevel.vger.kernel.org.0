Return-Path: <linux-fsdevel+bounces-12731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4A862D2A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A56071C20FBF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 21:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2D21B957;
	Sun, 25 Feb 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KMjxZ8hU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0C1B94F
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708896608; cv=none; b=bZ0Z0VVXHSxAVRFhBDmF9wWrcYCB77KUpqZS3mEk7KPpCx3ylz+nxWWT3D/DDubzt8LL+VUIqFUquUbi2GptmsuemGzSsA+yl/iSOGtgabT2pyKds18S/dQ7yfM2c44+duQg4lD0GLUqy7s8nvdQdbOo/4geP3Ubk9AO5Im/2CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708896608; c=relaxed/simple;
	bh=7bsr5pxdWVuqW1VVxfuYKi1z9ODAPW9nPBslIebCyzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBSH8VvZaBMp21mT+p9EG7lzaDAreA3rHlO4BL0O7pBZujtqb0OsuzaUiDQZv1Q7zsFv3ENFETyWcRWBK11NyM64OEL1i8Fed3jjw56qiaLEsmyc10xYkL0iWqbkjrm1jW2iduwwxX+JlHCjcDBfmPFgAl662MduKHqv1ejvg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KMjxZ8hU; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 25 Feb 2024 16:29:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708896603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr+h+YWNXTfxtzgW+IRBSnnfKh3QOXetAtC7/5S634U=;
	b=KMjxZ8hUjNx6kSOE8qtcX3FNj53c8KcaxELrOMeh9GiV196ozFrD0knqBznPkDg41qvEcS
	3DrX+QWWr3FDEaVYXML5F1lY57PXPDDDQv1/f5StYP1hVDoCWDEfh5U7eeGFBt2Cfayv4u
	/pAQsSB25g/cdTcqCloVni+2nINAMbE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ufp6jyfxvdeftlr2tqu4ythrdilxrwg6uuev7ghc6zlwjjtp3r@sklx42xdiepw>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Feb 25, 2024 at 09:03:32AM -0800, Linus Torvalds wrote:
> On Sun, 25 Feb 2024 at 05:10, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > There's also the small random 64 byte read case that we haven't optimised
> > for yet.  That also bottlenecks on the page refcount atomic op.
> >
> > The proposed solution to that was double-copy; look up the page without
> > bumping its refcount, copy to a buffer, look up the page again to be
> > sure it's still there, copy from the buffer to userspace.
> 
> Please stop the cray-cray.
> 
> Yes, cache dirtying is expensive. But you don't actually have
> cacheline ping-pong, because you don't have lots of different CPU's
> hammering the same page cache page in any normal circumstances. So the
> really expensive stuff just doesn't exist.

Not ping pong, you're just blowing the cachelines you want out of l1
with the big usercopy, hardware caches not being fully associative.

> I think you've been staring at profiles too much. In instruction-level
> profiles, the atomic ops stand out a lot. But that's at least partly
> artificial - they are a serialization point on x86, so things get
> accounted to them. So they tend to be the collection point for
> everything around them in an OoO CPU.

Yes, which leads to a fun game of whack a mole when you eliminate one
atomic op and then everything just ends up piling up behind a different
atomic op - but for the buffered read path, the folio get/put are the
only atomic ops.

> Fior example, the fact that Kent complains about the page cache and
> talks about large folios is completely ludicrous. I've seen the
> benchmarks of real loads. Kent - you're not close to any limits, you
> are often a factor of two to five off other filesystems. We're not
> talking "a few percent", and we're not talking "the atomics are
> hurting".

Yes, there's a bunch of places where bcachefs is still slow; it'll get
there :)

If you've got those benchmarks handyy and they're ones I haven't seen,
I'd love to take look; the one that always jumps out at people is small
O_DIRECT reads, and that hasn't been a priority because O_DIRECT doesn't
matter to most people nearly as much as they think it does.

There's a bunch of stuff still to work through; another that comes to
mind is that we need a free inodes btree to eliminate scanning in inode
create, and that was half a day of work - except it also needs sharding
(i.e. leaf nodes can't span certain boundaries), and for that I need
variable sized btree nodes so we aren't burning stupid amounts of
memory - and that's something we need anyways, number of btrees growing
like it is.

Another fun one that I just discovered while I was hanging out at
Darrick's - journal was stalling on high iodepth workloads; device write
buffer fills up, write latency goes up, suddenly the journal can't write
quickly enough when it's only submitting one write at a time. So there's
a fix for 6.9 queued up that lets the journal keep multiple writes in
flight.

That one was worth mentioning because another fix would've been to add a
way to signal backpressure to /above/ the filesystem, so that we don't
hit such big queuing delays within the filesystem; right now user writes
don't hit backpressure until submit_bio() blocks because the request
queue is full. I've been seeing other performance corner cases where it
looks like such a mechanism would be helpful.

I except I've got a solid year or two ahead of me of mastly just working
through performance bugs - standing up a lot of automated perf testing
adn whatnot. But, one thing at a time...

