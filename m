Return-Path: <linux-fsdevel+bounces-13143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2938A86BC5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 00:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639C1B21708
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A77293F;
	Wed, 28 Feb 2024 23:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dpagGL2/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF4F72935
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164524; cv=none; b=HHQ5ggzFEtW6DvhmVx3j82FSskDEIgXjmjz259SUD+ApX755TKF8VGw62zo1ZXl/Dcxz1sa+ueezndc6q9WqBN8+qalFHZ3h5BQGkP4FmAiHRaRsAdD9ipycZoQwJcZtHL3hlOg85mINA3kJ+XeEZdGYRYFlSZejoVmG0cbKWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164524; c=relaxed/simple;
	bh=cE+NnbUHu4YTvKrsjiI0H1N9h5PRIF6nROyvxtX7PHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urRNa0GWOFg5KwgB2fYiUN/iQLWc04J4a0meEHa7Be6ImVoazpRzrsATZjLtzdP/8hfbn+r04QDkml8ibE+w1JEyoeNUwSLHG5BAQ0z+mJVF6RsxKFwBp7xOHZHXsh4bHkaexV3ai/YJ7kuEuzH2+4o3+MLDwEhZCF0UhAKr8cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dpagGL2/; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 18:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709164519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8eKTRF+yktDF00oz41sjjxR0LlpZbbwO6aSEwAdNRU=;
	b=dpagGL2/8e/jF6z1U/4Cb6KPHOxSY8gK+bL/i29BU7ZCY7VEsbjBPQqmKmfLh7/+lTTpAj
	fJTGMlnFRa8v6jm0p9D6oPC7ZC1+ZdrLya2sitWgHf8AY5eYiaUC5XtBw9c1hFH6RJXB/M
	U+Q+XD6tdfpD+Jq8q7o/CI7vsAUZ7pI=
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
Message-ID: <icaomghoownzdhggxpwngexhd7m62ofluzgu4vifxfucy7jarn@gcjs6skgfkhp>
References: <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
 <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
 <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 09:58:48AM -0800, Paul E. McKenney wrote:
> On Tue, Feb 27, 2024 at 11:34:06AM -0500, Kent Overstreet wrote:
> > On Tue, Feb 27, 2024 at 08:21:29AM -0800, Paul E. McKenney wrote:
> > > On Tue, Feb 27, 2024 at 03:54:23PM +0000, Matthew Wilcox wrote:
> > > > On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > > > > At a ridiculously high level, reclaim is looking for memory to free.
> > > > > Some read-only memory can often be dropped immediately on the grounds
> > > > > that its data can be read back in if needed.  Other memory can only be
> > > > > dropped after being written out, which involves a delay.  There are of
> > > > > course many other complications, but this will do for a start.
> > > > 
> > > > Hi Paul,
> > > > 
> > > > I appreciate the necessity of describing what's going on at a very high
> > > > level, but there's a wrinkle that I'm not sure you're aware of which
> > > > may substantially change your argument.
> > > > 
> > > > For anonymous memory, we do indeed wait until reclaim to start writing it
> > > > to swap.  That may or may not be the right approach given how anonymous
> > > > memory is used (and could be the topic of an interesting discussion
> > > > at LSFMM).
> > > > 
> > > > For file-backed memory, we do not write back memory in reclaim.  If it
> > > > has got to the point of calling ->writepage in vmscan, things have gone
> > > > horribly wrong to the point where calling ->writepage will make things
> > > > worse.  This is why we're currently removing ->writepage from every
> > > > filesystem (only ->writepages will remain).  Instead, the page cache
> > > > is written back much earlier, once we get to balance_dirty_pages().
> > > > That lets us write pages in filesystem-friendly ways instead of in MM
> > > > LRU order.
> > > 
> > > Thank you for the additional details.
> > > 
> > > But please allow me to further summarize the point of my prior email
> > > that seems to be getting lost:
> > > 
> > > 1.	RCU already does significant work prodding grace periods.
> > > 
> > > 2.	There is no reasonable way to provide estimates of the
> > > 	memory sent to RCU via call_rcu(), and in many cases
> > > 	the bulk of the waiting memory will be call_rcu() memory.
> > > 
> > > Therefore, if we cannot come up with a heuristic that does not need to
> > > know the bytes of memory waiting, we are stuck anyway.
> > 
> > That is a completely asinine argument.
> 
> Huh.  Anything else you need to get off your chest?
> 
> On the off-chance it is unclear, I do disagree with your assessment.
> 
> > > So perhaps the proper heuristic for RCU speeding things up is simply
> > > "Hey RCU, we are in reclaim!".
> > 
> > Because that's the wrong heuristic. There are important workloads for
> > which  we're _always_ in reclaim, but as long as RCU grace periods are
> > happening at some steady rate, the amount of memory stranded will be
> > bounded and there's no reason to expedite grace periods.
> 
> RCU is in fact designed to handle heavy load, and contains a number of
> mechanisms to operate more efficiently at higher load than at lower load.
> It also contains mechanisms to expedite grace periods under heavy load.
> Some of which I already described in earlier emails on this thread.

yeah, the synchronize_rcu_expedited() souns like exactly what we need
here, when memory reclaim notices too much memory is stranded

> > If we start RCU freeing all pagecache folios we're going to be cycling
> > memory through RCU freeing at the rate of gigabytes per second, tens of
> > gigabytes per second on high end systems.
> 
> The load on RCU would be measured in terms of requests (kfree_rcu() and
> friends) per unit time per CPU, not in terms of gigabytes per unit time.
> Of course, the amount of memory per unit time might be an issue for
> whatever allocators you are using, and as Matthew has often pointed out,
> the deferred reclamation incurs additional cache misses.

So what I'm saying is that in the absensce of something noticing
excessive memory being stranded and asking for an expedited grace
period, the only bounds on the amount of memory being stranded will be
how often RCU grace periods expire in the absence of anyone asking for
them - that was my question to you. I'm not at all knowledgable on RCU
internals but I gather it varies with things like dynticks and whether
or not userspace is calling into the kernel?

"gigabytes per second" - if userspace is doing big sequential streaming
reads that don't fit into cache, we'll be evicting pagecache as quickly
as we can read it in, so we should only be limited by your SSD
bandwidth.

> And rcutorture really does do forward-progress testing on vanilla RCU
> that features tight in-kernel loops doing call_rcu() without bounds on
> memory in flight, and RCU routinely survives this in a VM that is given
> only 512MB of memory.  In fact, any failure to survive this is considered
> a bug to be fixed.

Are you saying there's already feedback between memory reclaim and RCU?

> So I suspect RCU is quite capable of handling this load.  But how many
> additional kfree_rcu() calls are you anticipating per unit time per CPU?
> For example, could we simply measure the rate at which pagecache folios
> are currently being freed under heavy load?  Given that information,
> we could just try it out.

It's not the load I'm concerned about, or the number of call_rcu()
calls, I have no doubt that RCU will cope with that just fine.

But I do think that we need an additional feedback mechanism here. When
we're doing big streaming sequential buffered IO, and lots of memory is
cycled in and out of the pagecache, we have a couple things we want to
avoid:

The main thing is that we don't want the amount of memory stranded
waiting for RCU to grow unbounded and shove everything out of the
caches; if you're currently just concerned about _deadlock_ that is
likely insufficient here, we're also concerned about maintaining good
steady performance under load

We don't want memory reclaim to be trying harder and harder when the
correct thing to do is a synchronize_rcu_expedited().

We _also_ don't want to be hammering on RCU asking for expedited grace
periods unnecessarily when the number of pending callbacks is high, but
they're all for unrelated stuff - expedited RCU grace periods aren't
free either!.

Does that help clarify things?

