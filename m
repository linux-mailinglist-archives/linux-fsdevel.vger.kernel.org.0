Return-Path: <linux-fsdevel+bounces-12972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA735869B93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA221C216F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513B9146915;
	Tue, 27 Feb 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoARtJF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BBB145FF8
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050013; cv=none; b=ddAj3o9Gaap4jqIcE7Yd0KnIq+J/nThRYDik01696t7bF16WiKgfNb0wtaaR8lTdrnZ/vFsn33b3wWDLGisQDXCZxGZrvS1Wh2284YBm+IxrL7JVMs53b1eR2j0eVNenfx5+ciFdWpaLNnmBaml9RCklJDE0OEtjE78oe4QsOjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050013; c=relaxed/simple;
	bh=CGtGmL1FfoSdaXDRarwBLqvpH7xazho5uBvNzP5U/Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDQjEhNcqdlNZdCsROtnHHbvmHNDCuUprxRqWFr101bNlXNt/I7Y13KfkmrU9f4ivRztJpZrKhGUTzaKNn2JTqzOJALpzBiSZXTPix8w7FU8gns3byiKHRmDUIQCjQXkqC37xp5m73r46gex9gyOHHa35ANmUCrvBQqjDuUtgt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoARtJF5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37972C433F1;
	Tue, 27 Feb 2024 16:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050013;
	bh=CGtGmL1FfoSdaXDRarwBLqvpH7xazho5uBvNzP5U/Rc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=uoARtJF5eNoTHuTfd77RG6I4DKny53qG2RL8fBxGYNb5r9QqHUD8rVA0VeqDFDWTy
	 tbVpdy5G/9FKxj2vMIlWDfExk0tW1cnQV1Po/0BSRXyyOlY5QXeyo85UhLwYcaLNtd
	 E5ReQsYRz5PnYAmDXDxLcu7uLFA/DELh2sUvevZ2FTZEnAAwGySd+XpmH4j5dX0c6C
	 UsDsPqKcBKvxCBv1MpiataibW/CxC1IS7LRNzm0pCK6IeQ4RyjmmbitEJRpAGLUW7F
	 G1H46qqcZGYsOs4E8H52uThu2nQGPWt/XUhcXHyjem9L09PUVvPNeDmEi9FZ93J5zp
	 lE7Uhgo96aEOA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C5FFACE0F12; Tue, 27 Feb 2024 08:06:52 -0800 (PST)
Date: Tue, 27 Feb 2024 08:06:52 -0800
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
Message-ID: <3c16052d-8e4c-4af7-ae82-f47ee058a884@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <qclzh7gjlnuagsjiqemwvfnkxca2345zxansc7x463bguhsmm2@zl2cwv5fh5sv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qclzh7gjlnuagsjiqemwvfnkxca2345zxansc7x463bguhsmm2@zl2cwv5fh5sv>

On Tue, Feb 27, 2024 at 10:52:51AM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > I could simply use the same general approach that I use within RCU
> > itself, which currently has absolutely no idea how much memory (if any)
> > that each callback will free.  Especially given that some callbacks
> > free groups of memory blocks, while other free nothing.  ;-)
> > 
> > Alternatively, we could gather statistics on the amount of memory freed
> > by each callback and use that as an estimate.
> > 
> > But we should instead step back and ask exactly what we are trying to
> > accomplish here, which just might be what Dave Chinner was getting at.
> > 
> > At a ridiculously high level, reclaim is looking for memory to free.
> > Some read-only memory can often be dropped immediately on the grounds
> > that its data can be read back in if needed.  Other memory can only be
> > dropped after being written out, which involves a delay.  There are of
> > course many other complications, but this will do for a start.
> > 
> > So, where does RCU fit in?
> > 
> > RCU fits in between the two.  With memory awaiting RCU, there is no need
> > to write anything out, but there is a delay.  As such, memory waiting
> > for an RCU grace period is similar to memory that is to be reclaimed
> > after its I/O completes.
> > 
> > One complication, and a complication that we are considering exploiting,
> > is that, unlike reclaimable memory waiting for I/O, we could often
> > (but not always) have some control over how quickly RCU's grace periods
> > complete.  And we already do this programmatically by using the choice
> > between sychronize_rcu() and synchronize_rcu_expedited().  The question
> > is whether we should expedite normal RCU grace periods during reclaim,
> > and if so, under what conditions.
> > 
> > You identified one potential condition, namely the amount of memory
> > waiting to be reclaimed.  One complication with this approach is that RCU
> > has no idea how much memory each callback represents, and for call_rcu(),
> > there is no way for it to find out.  For kfree_rcu(), there are ways,
> > but as you know, I am questioning whether those ways are reasonable from
> > a performance perspective.  But even if they are, we would be accepting
> > more error from the memory waiting via call_rcu() than we would be
> > accepting if we just counted blocks instead of bytes for kfree_rcu().
> 
> You're _way_ overcomplicating this.

Sorry, but no.

Please read the remainder of my prior email carefully.

							Thanx, Paul

> The relevant thing to consider is the relative cost of __ksize() and
> kfree_rcu(). __ksize() is already pretty cheap, and with slab gone and
> space available in struct slab we can get it down to a single load.
> 
> > Let me reiterate that:  The estimation error that you are objecting to
> > for kfree_rcu() is completely and utterly unavoidable for call_rcu().
> 
> hardly, callsites manually freeing memory manually after an RCU grace
> period can do the accounting manually - if they're hot enough to matter,
> most aren.t
> 
> and with memory allocation profiling coming, which also tracks # of
> allocations, we'll also have an easy way to spot those.

