Return-Path: <linux-fsdevel+bounces-14094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B90D877A28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 04:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1475A28195C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 03:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E0C23A0;
	Mon, 11 Mar 2024 03:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MwlOgmeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C1115B3;
	Mon, 11 Mar 2024 03:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710128508; cv=none; b=ddC9Wl62bGG6kJfMYEtyevfhIEVnUyZd5YAbtUvgISvfLJJEEvVEnJ5jkZt+8AqjBg0LybcApNmwWe21fNdJXE8uvXasidp86Aj5ntKXRqGP9q+nm/IJG02TfA7YJLoUcyRQMJVJGqufHQkPsnNT7NYEQJPCieXcvVAZiBaAUEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710128508; c=relaxed/simple;
	bh=IkVWhXDcD+dqXR0sg2CSh+0xLf+knakijimU2ebVXAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNajBsrNYwQo2gO3/BdwS6kiLrgQJnSBqMY1jfS2wLMqznfsZJB3hEr53ttUyO2i4n2GiIK+pgK6OjAqMJOgNOV/V3GhuIcWLIEiOwwwBqlWJFIqeY66WDDftvgYbwc3YM04/QkkFRZrqD/ioL6bg7F5sLt4yRgZ/tu7QW5ne48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MwlOgmeM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0IhkeUfnkckGUpoB8ltx//YeJvd8V+1fi/yffsV3/DE=; b=MwlOgmeMRShI7BYlx0kHstVhwm
	hgt4enB2uKdIIl4DUlbLzZAgYM+QIr0KyS8j52ssOJiKK7PECYrI8ur2Yg5lhXRWltKMEAENneSrE
	GHF2O/16j7srHcEfH1vx8OVCLBeawcyjEPMfWR5ILjY3IwDhtYunJROk/J/tl8BnjxKVlEZWsxgjS
	/Dcp6AB0D3HSZ35TjxPeb3I+2/djM5Cb2ToUPaPhPiBtf+sa1MAWGDDGrh9ASCl4fblf2yqAt41AG
	oKTvkpanedvcrvAYsgMMKbeDl8FCEstEYqcbWMyZohgNKPC1eaDyPE2cqGu+fFt4kOPYA90L6LhUm
	Ta8tWEPg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjWXf-0000000HKj2-0ofC;
	Mon, 11 Mar 2024 03:41:35 +0000
Date: Mon, 11 Mar 2024 03:41:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: On the optimum size of a batch
Message-ID: <Ze59byUR80z42m8R@casper.infradead.org>
References: <Zeoble0xJQYEAriE@casper.infradead.org>
 <Ze5onaXsI+LT1+Be@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze5onaXsI+LT1+Be@dread.disaster.area>

On Mon, Mar 11, 2024 at 01:12:45PM +1100, Dave Chinner wrote:
> > Batch size      Cost of allocating 100          thousand        million
> > 1               500 (5 * 100)                   5000            5M
> > 2               300 (6 * 50)                    3000            3M
> > 4               200 (8 * 25)                    2000            2M
> > 8               156 (12 * 13)                   1500            1.5M
> > 16              140 (20 * 7)                    1260            1.25M
> > 32              144 (36 * 4)                    1152            1.13M
> > 64              136 (68 * 2)                    1088            1.06M
> > 128             132 (132 * 1)                   1056            1.03M
> 
> Isn't this just repeating the fundamental observation that SLUB is
> based on?  i.e. it can use high-order pages so that it can
> pre-allocate optimally sized batches of objects regardless of their
> size? i.e.  it tries to size the backing page order to allocate in
> chunks of 30-40 objects at a time?

What SLUB is currently doing is inefficient.  One of the conversations
I had (off-list) about appropriate batch size is in relation to SLUB-ng
where one of the participants claimed that the batch size of 32 was
obviously too small (it wasn't; the performance problem was due to a
bug).

What you're thinking about is the cost of allocating from the page
allocator (which is now much cheaper than it used to be, but should
be cheaper than it currently is).  But there is another inefficiency
to consider, which is that the slab allocator has a per-slab lock,
and while you can efficiently remove and add a number of objects to
a single slab, you might only have one or two free objects per slab.
To work around this some of the more performance sensitive parts of the
kernel have implemented their own allocator in front of slab.  This is
clearly a bad thing for all of us, and hence Vlastimil has been working
on a better approach.

https://lore.kernel.org/linux-mm/20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz/

> Except for SLUB we're actually allocating in the hundreds of
> millions to billions of objects on machines with TBs of RAM. IOWs we
> really want to be much further down the curve than 8 - batches of at
> least 32-64 have significantly lower cost and that matters when
> scaling to (and beyond) hundreds of millions of objects....

But that doesn't necessarily mean that you want a larger batch size.
Because you're not just allocating, you're also freeing and over a
large enough timescale the number of objects allocated and freed is
approximately equal.  In the SLUB case, your batch size needs to be
large enough to absorb most of the allcation-vs-free bias jitter; that
is if you know they always alternate AFAFAFAFAF a batch size of 2 would
be fine.  If you know you get four allocations followed by four frees,
having a batch size of 5 woud be fine.  We'd never go to the parent
allocator if we got a AFAAFFAAAFFFAAAAFFFFAAFFAFAAFAAFFF pattern.

> > This is a simple model for only one situation.  If we have a locking
> > contention breakdown, the overhead cost might be much higher than 4 units,
> > and that would lead us to a larger batch size.
> > 
> > Another consideration is how much of each object we have to touch.
> > put_pages_list() is frequently called with batches of 500 pages.  In order
> > to free a folio, we have to manipulate its contents, so touching at least
> > one cacheline per object.
> 
> Right, that's simply the cost of the batch cache footprint issue
> rather than a "fixed cost mitigation" described for allocation.

No, it's not, it's an illustration that too large a batch size can
actively harm you.

> So I'm not sure what you're trying to say here? We've known about
> these batch optimisation considerations for a long, long time and
> that batch size optimisation is always algorithm and access pattern
> dependent, so.... ???

People forget these "things we've always known".  I went looking and
couldn't find a good writeup of this, so did my own.  In addition to the
percpu slub batch size, various people have opined that the folio_batch
size (15 objects) is too small for doing things like writeback and
readahead.  They're going to have to bring data to convince me.

> > And we make multiple passes over the batch,
> > first decrementing the refcount, removing it from the lru list; second
> > uncharging the folios from the memcg (writes to folio->memcg_data);
> > third calling free_pages_prepare which, eg, sets ->mapping to NULL;
> > fourth putting the folio on the pcp list (writing to the list_head).
> 
> Sounds like "batch cache footprint" would be reduced by inverting
> that algorithm and doing all the work on a single object in a single
> pass, rahter than doing it in multiple passes.  That way the cache
> footprint of the batch is determined entirely by the size of the
> data structures accessed to process each object in the batch.

Well, now you're just opining without having studied the problem, and
I have, so I can say confidently that you're wrong.  You could read
the code if you like.


