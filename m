Return-Path: <linux-fsdevel+bounces-12905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AED0868542
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB691C21832
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC4A4431;
	Tue, 27 Feb 2024 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9+xpM4a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8FD1FA6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708995330; cv=none; b=TW8ZipcL51AIFJEO2tugoMv7320uV1HdHA1c5PuBuxrP6Tj+5gK/A8nct5M01ZDrBlLhOo372YGqf3S/v+gxd040HMlG/PmlP4lRk6LLwnquHr0uefpTjboC+AktKraYBfeOCTXszCWgzgvMF4o5HOcnOdZZni/QKnp0AqNDMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708995330; c=relaxed/simple;
	bh=u4jebG4Kb1YXhFjNl6sDu0rFGKvBtxVeWgU5fnkhOmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzU26zzCBr/9ViDXPbKO2UJvqkGgEkoYoKthjej8eRe5XR5Q3FGrzgRC1is3I22/AdpEqZ1/hBkQQT1+m6w2kOP2Po8dlWR1hcw8Xj8T7G97WhRGnp5ByfnQT0Fu29I7EoGuCmPN+7Y7LKM+AQVnmhpONGHXKOLjOoEY0AueJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9+xpM4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC80C433F1;
	Tue, 27 Feb 2024 00:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708995329;
	bh=u4jebG4Kb1YXhFjNl6sDu0rFGKvBtxVeWgU5fnkhOmA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=P9+xpM4aSwMQka9mbjhR0iQY69bxxNzcGq1cR9uyJl85W+66620o/eBdHFErwZ0ZX
	 AuZ8e9WngWOWTq4Yxd/sUh0cvPQ6GylklTok+54Jtzl7meLwxfQnAhx5O2Np8N/Kn/
	 lB+xa5Abw/AhUQV4p6jt/aaTLf5+xauhh0wnGo+8JqDWbwTygKPusOTuyaewIaPrDh
	 Efo2PujaoRdx6RU/lnu2vuAg2p57e0A7JYfSA5QeUFvNC5HPME7wIqZeO+tROrwKpG
	 L0aaiTKFu9vRr5NxyqmLFlZo6KHAqsHLMVIVyvl/lOJfgnr6Y7ewNmJ53KHVeoYZvH
	 Voi34F+meqDWA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 693B2CE1147; Mon, 26 Feb 2024 16:55:29 -0800 (PST)
Date: Mon, 26 Feb 2024 16:55:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>

On Mon, Feb 26, 2024 at 07:29:04PM -0500, Kent Overstreet wrote:
> On Mon, Feb 26, 2024 at 04:05:37PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> > > Well, we won't want it getting hammered on continuously - we should be
> > > able to tune reclaim so that doesn't happen.
> > > 
> > > I think getting numbers on the amount of memory stranded waiting for RCU
> > > is probably first order of business - minor tweak to kfree_rcu() et all
> > > for that; there's APIs they can query to maintain that counter.
> > 
> > We can easily tell you the number of blocks of memory waiting to be freed.
> > But RCU does not know their size.  Yes, we could ferret this on each
> > call to kmem_free_rcu(), but that might not be great for performance.
> > We could traverse the lists at runtime, but such traversal must be done
> > with interrupts disabled, which is also not great.
> > 
> > > then, we can add a heuristic threshhold somewhere, something like 
> > > 
> > > if (rcu_stranded * multiplier > reclaimable_memory)
> > > 	kick_rcu()
> > 
> > If it is a heuristic anyway, it sounds best to base the heuristic on
> > the number of objects rather than their aggregate size.
> 
> I don't think that'll really work given that object size can very from <
> 100 bytes all the way up to 2MB hugepages. The shrinker API works that
> way and I positively hate it; it's really helpful for introspection and
> debugability later to give good human understandable units to this
> stuff.

You might well be right, but let's please try it before adding overhead to
kfree_rcu() and friends.  I bet it will prove to be good and sufficient.

> And __ksize() is pretty cheap, and I think there might be room in struct
> slab to stick the object size there instead of getting it from the slab
> cache - and folio_size() is cheaper still.

On __ksize():

 * This should only be used internally to query the true size of allocations.
 * It is not meant to be a way to discover the usable size of an allocation
 * after the fact. Instead, use kmalloc_size_roundup().

Except that kmalloc_size_roundup() doesn't look like it is meant for
this use case.  On __ksize() being used only internally, I would not be
at all averse to kfree_rcu() and friends moving to mm.

The idea is for kfree_rcu() to invoke __ksize() when given slab memory
and folio_size() when given vmalloc() memory?

							Thanx, Paul

