Return-Path: <linux-fsdevel+bounces-13217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8BB86D58A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949E528B538
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B46D512;
	Thu, 29 Feb 2024 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rRYd8IkQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927D6D506
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 20:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239876; cv=none; b=tgN0VQYF1klG717msL8piTeecPgM5Ovos7CfRX6mCv8DD4+sya251Lvo97sY6IjNrkFMIotSpRrK36tq6MglbHxS2jfhGW4leSVL7yDb9ZC7mBAaE+TiepA6XVRTjIbD4dr+MPfFac0WcL8UaRQOObqb1cydaDK4pLOmSOPxjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239876; c=relaxed/simple;
	bh=8LJFASlsIbt3iqNzCNuflpBgA3JR+WQ3eCUdjnHb+6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1IiaAM34o/iKQQw/LO5Mh3oJJqGcFmUnBCVdCH+T8URMyrj6Zjjbhyf6MuKmal/x+1d8y3xiNahUChrrv08bP2e3s7wDORLQx9+K1nfb4s8CgBQ/7eDRqZnH0GWDsMC5Tm8vQceoneV7TrVrih13JY06HEnwMfA+2kwYg9lKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rRYd8IkQ; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 15:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709239872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHPWVw68Ykul4KEf6UP6pFsG0YHU7AFeee/d4DQsGLE=;
	b=rRYd8IkQCdWtD89oJUG25RzJuocn1glClfPgIA2KzIFmHHpcOpTjSe+u6AF3HAsBlLXZTX
	6rkD9tOmWfx7I0NWXer5PsAg7rNjDBhHMohRIkxhpswDC93FP+nSQAySdMRMktzhwpW177
	hBzxlriXuW8d4ibP7X0ixDWH1ZQAEoY=
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
Message-ID: <7k3wjdjtgjnknuf5imgr2e6dy3qe4oqqbxla6tfdifrvfemwow@afe2iusbt4l6>
References: <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
 <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
 <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
 <icaomghoownzdhggxpwngexhd7m62ofluzgu4vifxfucy7jarn@gcjs6skgfkhp>
 <97a2c822-b4dd-4c53-a90e-d82c830f6bbe@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a2c822-b4dd-4c53-a90e-d82c830f6bbe@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 29, 2024 at 11:42:53AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 28, 2024 at 06:55:12PM -0500, Kent Overstreet wrote:
> > So what I'm saying is that in the absensce of something noticing
> > excessive memory being stranded and asking for an expedited grace
> > period, the only bounds on the amount of memory being stranded will be
> > how often RCU grace periods expire in the absence of anyone asking for
> > them - that was my question to you. I'm not at all knowledgable on RCU
> > internals but I gather it varies with things like dynticks and whether
> > or not userspace is calling into the kernel?
> 
> It does vary based on quite a few things.  Taking as an example your
> dynticks point, a nohz_full CPU does not restart the tick upon entering
> the kernel.  Which is what you want for short system calls because
> enabling and disabling the tick can be expensive.  But this causes
> RCU trouble if a nohz_full CPU executes a long-running system call,
> so RCU will force the tick on should such a CPU refused to respond to
> RCU quickly enough.

Makes sense - so synchronize_rcu_expedited() has to check that and issue
an IPI?

> But the typical idle-system normal grace-period duration is a couple of
> tens of milliseconds.  Except of course that if there are one-second-long
> readers, you will see one-second-long grace periods.
> 
> > "gigabytes per second" - if userspace is doing big sequential streaming
> > reads that don't fit into cache, we'll be evicting pagecache as quickly
> > as we can read it in, so we should only be limited by your SSD
> > bandwidth.
> 
> Understood.
> 
> But why not simply replace the current freeing with kfree_rcu() or
> similar and see what really happens?  More further down...

Well, mainly because I've been doing filesystem and storage work for 15
years and these kinds of problems are my bread and butter; in filesystem
land (especially bcachefs, but really any modern journalling
filesystem), there are a _lot_ of background reclaim tasks not unlike
this.

So I'm speaking from experience here; the very first thing we're going
to want when we do this for page cache pages and start analyzing system
behaviour and performance is some basic numbers as to what's going on,
and here it's practically no trouble at all to do it right.

> > > And rcutorture really does do forward-progress testing on vanilla RCU
> > > that features tight in-kernel loops doing call_rcu() without bounds on
> > > memory in flight, and RCU routinely survives this in a VM that is given
> > > only 512MB of memory.  In fact, any failure to survive this is considered
> > > a bug to be fixed.
> > 
> > Are you saying there's already feedback between memory reclaim and RCU?
> 
> For the callback flooding in the torture test, yes.  There is a
> register_oom_notifier() function, and if that function is called during
> the callback flooding, that is a test failure.

Based on number of outstanding callbacks?

> There used to be a shrinker in the RCU implementation itself, but this
> proved unhelpful and was therefore removed.  As in RCU worked fine without
> it given the workloads of that time.  Who knows?  Maybe it needs to be
> added back in.

Why was it unhelpful? Were you having problems with the approach, or
just didn't seem to be useful?

> The key point is that no one knows enough about this problem to dive at
> all deeply into solution space.  From what you have described thus far,
> the solution might involve one or more of the following options:
> 
> o	We do nothing, because RCU just handles it.  (Hey, I can dream,
> 	can't I?)
> 
> o	We do a few modifications to RCU's force-quiescent state code.
> 	This needs to be revisited for lazy preemption anyway, so this
> 	is a good time to take a look.
> 
> o	We do a few modifications to RCU's force-quiescent state code,
> 	but with the addition of communication of some sort from reclaim.
> 	This appears to be your current focus.

Not exactly (but I'd like to hear what you have in mind); I'm
envisioning this driven by reclaim itself.

> o	It might be that reclaim needs to use SRCU instead of RCU.
> 	This would insulate reclaim from other subsystems' overly long
> 	readers, but at the expense of smp_mb() overhead when entering
> 	and exiting a reader.  Also, unlike RCU, SRCU has no reasonable
> 	way of encouraging delayed readers (for example, delayed due
> 	to preemption).

Yeah, I don't think SRCU is quite what we want here.

> o	It might be that reclaim needs its own specialized flavor of RCU,
> 	as did tracing (Tasks RCU) and BPF (Tasks Trace RCU).  Plus there
> 	is Steve Rostedt's additional flavor for tracing, which is now
> 	Tasks RCU Rude.  I doubt that any of these three are what you
> 	want, but let's get some hard data so that we can find out.
> 
> o	It might be that reclaim needs some synchronization mechanism
> 	other than RCU.
> 
> We really need some hard data on how this thing affects RCU.  Again,
> could we do the kfree()->kfree_rcu() change (and similar change,
> depending on what memory allocator is used) and the run some tests to
> see how RCU reacts?

Well, like I mentioned previously - the "hard data" you say we need is
exactly what I was saying we need to collect as a first order of
business - we need to know the amount of memory stranded by RCU, and we
need to be able to watch that number as we run through different
buffered IO workloads.

Sure, we could do this as a special case for just pagecache page
freeing; but it looks like zero extra work to just do it right and do it
for kfree_rcu() in general; and I've already talked about how minimal
the perforance cost is.

And more broadly, we have real gaps when it comes to OOM debugging and
being able to report on who's responsible for what memory and how much,
and that's something I want to close. I've got a shrinker debugging
patch that I really need to get back to and shove in, and really in that
area I need to go further and add byte counters to shrinker reporting.

IOW, this isn't just an RCU topic, this is a memory reclaim topic, and
lots of us filesystem developers have... things to say on the subject of
memory reclaim. Being able to get proper information so that we can
debug stuff has been a major point of contention; I hope you can
try to appreciate where we're coming from.

> If RCU does not react all that well, then we will also need information on
> what the RCU readers look like, for example, must they block, must they
> be preemptible, and about how long do they run for?  Best if they never
> block, need not be preemptible, and run for very short periods of time,
> but they are what they are.  Perhaps Matthew Wilcox has some thoughts
> on this.

We'll be using this in filemap_read() (and I've worked on that code more
than most); we're already using rcu_read_lock() there for the xarray
lookup, which is partly why RCU (the regular sort) is a natural fit for
protecting the data itself.

This will move the copy_to_user_nofault() under rcu_read_lock(), so
we're not blocking or faulting or preempting or anything like that. Just
doing a (potentially big) copy to userspace.

