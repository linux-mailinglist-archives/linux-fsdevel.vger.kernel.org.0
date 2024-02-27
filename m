Return-Path: <linux-fsdevel+bounces-12918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8559F8688EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 07:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98061C21DD8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 06:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F9753375;
	Tue, 27 Feb 2024 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q+wpQAr/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB992D04E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709014883; cv=none; b=cM74i14UBkrAaZ5A8wnQ36Hi7Siq2dPkuF5q1lHvz5XNRjB0Kju4AUmvC2nL1l5p+4Tn+dCiGNkE6k7r9b4t0NlMD6RYrJWpvLnUakCuSbgRpFDeygVtt8QNkaoxWR7rdbe0Zy2ji98CCkbfhfpMm1dsSfVGFe3rAzyL3vb2UjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709014883; c=relaxed/simple;
	bh=14M0PDFCLSg8r/XD6jtzzk2wPJN52iBiTeF026/wRic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsqfJ/EoANKDQOAMuB1S/lqri83naLqsrE5gZHLz7GXWGxZ5xDKXcnQifm90OqzmXb5hEL9elk4YdCu33JKLM/QJc9r8of/pXhmLA0EOCmZ4Er0uXWjv6r9oLnutQPTWQ1ZY1t9n9rat0v965KJxTggnlvXgu2QmjroexZtOdEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q+wpQAr/; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 01:21:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709014874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GSq7+i8kqkYZe31UVWQlh2crqMmMhxEGm5D2e74FWM=;
	b=q+wpQAr/wKRDCeFvxG8VegbD/UXQkLTkXiSjdML7AT/xs8//hjv+wvp3q1fXFI+hTRKoC3
	2MwNw8AU477SlGNCO/v8H5+Xd1VzsTzso7sqwTbWgmX26oMvCVgE6lhv26Mlkisb02ACFK
	7KKqYDATvEmgtCfeVdX9KEDJ0sJ3Ako=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
References: <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 09:17:41PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 26, 2024 at 08:08:17PM -0500, Kent Overstreet wrote:
> > On Mon, Feb 26, 2024 at 04:55:29PM -0800, Paul E. McKenney wrote:
> > > On Mon, Feb 26, 2024 at 07:29:04PM -0500, Kent Overstreet wrote:
> > > > On Mon, Feb 26, 2024 at 04:05:37PM -0800, Paul E. McKenney wrote:
> > > > > On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> > > > > > Well, we won't want it getting hammered on continuously - we should be
> > > > > > able to tune reclaim so that doesn't happen.
> > > > > > 
> > > > > > I think getting numbers on the amount of memory stranded waiting for RCU
> > > > > > is probably first order of business - minor tweak to kfree_rcu() et all
> > > > > > for that; there's APIs they can query to maintain that counter.
> > > > > 
> > > > > We can easily tell you the number of blocks of memory waiting to be freed.
> > > > > But RCU does not know their size.  Yes, we could ferret this on each
> > > > > call to kmem_free_rcu(), but that might not be great for performance.
> > > > > We could traverse the lists at runtime, but such traversal must be done
> > > > > with interrupts disabled, which is also not great.
> > > > > 
> > > > > > then, we can add a heuristic threshhold somewhere, something like 
> > > > > > 
> > > > > > if (rcu_stranded * multiplier > reclaimable_memory)
> > > > > > 	kick_rcu()
> > > > > 
> > > > > If it is a heuristic anyway, it sounds best to base the heuristic on
> > > > > the number of objects rather than their aggregate size.
> > > > 
> > > > I don't think that'll really work given that object size can very from <
> > > > 100 bytes all the way up to 2MB hugepages. The shrinker API works that
> > > > way and I positively hate it; it's really helpful for introspection and
> > > > debugability later to give good human understandable units to this
> > > > stuff.
> > > 
> > > You might well be right, but let's please try it before adding overhead to
> > > kfree_rcu() and friends.  I bet it will prove to be good and sufficient.
> > > 
> > > > And __ksize() is pretty cheap, and I think there might be room in struct
> > > > slab to stick the object size there instead of getting it from the slab
> > > > cache - and folio_size() is cheaper still.
> > > 
> > > On __ksize():
> > > 
> > >  * This should only be used internally to query the true size of allocations.
> > >  * It is not meant to be a way to discover the usable size of an allocation
> > >  * after the fact. Instead, use kmalloc_size_roundup().
> > > 
> > > Except that kmalloc_size_roundup() doesn't look like it is meant for
> > > this use case.  On __ksize() being used only internally, I would not be
> > > at all averse to kfree_rcu() and friends moving to mm.
> > 
> > __ksize() is the right helper to use for this; ksize() is "how much
> > usable memory", __ksize() is "how much does this occupy".
> > 
> > > The idea is for kfree_rcu() to invoke __ksize() when given slab memory
> > > and folio_size() when given vmalloc() memory?
> > 
> > __ksize() for slab memory, but folio_size() would be for page
> > allocations - actually, I think compound_order() is more appropriate
> > here, but that's willy's area. IOW, for free_pages_rcu(), which AFAIK we
> > don't have yet but it looks like we're going to need.
> > 
> > I'm scanning through vmalloc.c and I don't think we have a helper yet to
> > query the allocation size - I can write one tomorrow, giving my brain a
> > rest today :)
> 
> Again, let's give the straight count of blocks a try first.  I do see
> that you feel that the added overhead is negligible, but zero added
> overhead is even better.

How are you going to write a heuristic that works correctly both when
the system is cycling through nothing but 2M hugepages, and nothing but
128 byte whatevers?

