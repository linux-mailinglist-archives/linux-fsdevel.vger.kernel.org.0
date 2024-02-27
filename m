Return-Path: <linux-fsdevel+bounces-12996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B219869E8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C55B2B341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22044F213;
	Tue, 27 Feb 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBnDlcea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417A947A7D
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056729; cv=none; b=CEqJeeiLrFBn/gqesU4vIqwsD7FG6+U9Hgx8Fx4xafn/nDRFgDqBFC6int/qPJU0ZCXBRppQhyYPiPDn7XkkkIvqBxlGSJESFEpMPi+tePmOg8UaIS6LP1ITPdQ8JJGrQTHNnZ4HbuC6PXFVfMuGFbW1ZedCT4vlmlCcBtklkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056729; c=relaxed/simple;
	bh=J1Fc7aIEWZtmGnIlgmF4C05pnfHyng0VuK5dCNFJhJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjHUPLuMLgMzPenpdZ9zRj7Whf1xhlsT3KwRb11S7CTfVgzTrKjlBSz4X8ddXSgsHI/1nJMNTFX/HMDtibSjkeeLgmEnFP/TK2K+BJ0/1MyBwGUFJn1OnIXHIpa6uazbhQCno6oMBUlE8R1QN7LnXwjnTJEPdTb7kovocW1PItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBnDlcea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DCC433F1;
	Tue, 27 Feb 2024 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709056728;
	bh=J1Fc7aIEWZtmGnIlgmF4C05pnfHyng0VuK5dCNFJhJk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dBnDlceajoYWRyE60YqKattmdHukCJLDXoH4f4HroNcpLHdrJ2KfK17K17ADGRyZz
	 9iRvUfsTdIBOy/0cdTfukEMuhCC6khBjM5XX4z+rlw5MG+PfB2n8O8oUJoNtOhInox
	 iPr+nyJWniErhMSqaIuhJXSwX1UxHSiPO4ZycipP+vCq51a+JaSESXeQ3QYZXUXwK5
	 ejGbHHtxLp9leV3mFDUHlc9xtDr1Nh6+lrKEFAh71Bj+eg/is5cWiWZhuKEjfT6+y4
	 qUx+1NWMLABA350iddBP3LF1cKkJnWXbqt94t75IsHzOTNvx77Cj1AjWOZR9YylEBj
	 sNnwIrwVWJvvQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59D81CE0D68; Tue, 27 Feb 2024 09:58:48 -0800 (PST)
Date: Tue, 27 Feb 2024 09:58:48 -0800
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
Message-ID: <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
 <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>

On Tue, Feb 27, 2024 at 11:34:06AM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 08:21:29AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 27, 2024 at 03:54:23PM +0000, Matthew Wilcox wrote:
> > > On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > > > At a ridiculously high level, reclaim is looking for memory to free.
> > > > Some read-only memory can often be dropped immediately on the grounds
> > > > that its data can be read back in if needed.  Other memory can only be
> > > > dropped after being written out, which involves a delay.  There are of
> > > > course many other complications, but this will do for a start.
> > > 
> > > Hi Paul,
> > > 
> > > I appreciate the necessity of describing what's going on at a very high
> > > level, but there's a wrinkle that I'm not sure you're aware of which
> > > may substantially change your argument.
> > > 
> > > For anonymous memory, we do indeed wait until reclaim to start writing it
> > > to swap.  That may or may not be the right approach given how anonymous
> > > memory is used (and could be the topic of an interesting discussion
> > > at LSFMM).
> > > 
> > > For file-backed memory, we do not write back memory in reclaim.  If it
> > > has got to the point of calling ->writepage in vmscan, things have gone
> > > horribly wrong to the point where calling ->writepage will make things
> > > worse.  This is why we're currently removing ->writepage from every
> > > filesystem (only ->writepages will remain).  Instead, the page cache
> > > is written back much earlier, once we get to balance_dirty_pages().
> > > That lets us write pages in filesystem-friendly ways instead of in MM
> > > LRU order.
> > 
> > Thank you for the additional details.
> > 
> > But please allow me to further summarize the point of my prior email
> > that seems to be getting lost:
> > 
> > 1.	RCU already does significant work prodding grace periods.
> > 
> > 2.	There is no reasonable way to provide estimates of the
> > 	memory sent to RCU via call_rcu(), and in many cases
> > 	the bulk of the waiting memory will be call_rcu() memory.
> > 
> > Therefore, if we cannot come up with a heuristic that does not need to
> > know the bytes of memory waiting, we are stuck anyway.
> 
> That is a completely asinine argument.

Huh.  Anything else you need to get off your chest?

On the off-chance it is unclear, I do disagree with your assessment.

> > So perhaps the proper heuristic for RCU speeding things up is simply
> > "Hey RCU, we are in reclaim!".
> 
> Because that's the wrong heuristic. There are important workloads for
> which  we're _always_ in reclaim, but as long as RCU grace periods are
> happening at some steady rate, the amount of memory stranded will be
> bounded and there's no reason to expedite grace periods.

RCU is in fact designed to handle heavy load, and contains a number of
mechanisms to operate more efficiently at higher load than at lower load.
It also contains mechanisms to expedite grace periods under heavy load.
Some of which I already described in earlier emails on this thread.

> If we start RCU freeing all pagecache folios we're going to be cycling
> memory through RCU freeing at the rate of gigabytes per second, tens of
> gigabytes per second on high end systems.

The load on RCU would be measured in terms of requests (kfree_rcu() and
friends) per unit time per CPU, not in terms of gigabytes per unit time.
Of course, the amount of memory per unit time might be an issue for
whatever allocators you are using, and as Matthew has often pointed out,
the deferred reclamation incurs additional cache misses.

And rcutorture really does do forward-progress testing on vanilla RCU
that features tight in-kernel loops doing call_rcu() without bounds on
memory in flight, and RCU routinely survives this in a VM that is given
only 512MB of memory.  In fact, any failure to survive this is considered
a bug to be fixed.

So I suspect RCU is quite capable of handling this load.  But how many
additional kfree_rcu() calls are you anticipating per unit time per CPU?
For example, could we simply measure the rate at which pagecache folios
are currently being freed under heavy load?  Given that information,
we could just try it out.

> Do you put hard limits on how long we can go before an RCU grace period
> that will limit the amount of memory stranded to something acceptable?
> Yes or no?

C'mon, Kent, you can do better than this.

Given what you have described, I believe that RCU would have no problem
with it.  However, additional information would be welcome.  As always,
I could well be missing something.

And yes, kernel developers can break RCU (with infinite loops in RCU
readers being a popular approach) and systems administrators can break
RCU, for example, by confining processing of offloading callbacks to a
single CPU on a 128-CPU system.  Don't do that.

							Thanx, Paul

