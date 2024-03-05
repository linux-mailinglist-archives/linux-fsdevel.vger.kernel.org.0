Return-Path: <linux-fsdevel+bounces-13573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 128DD87137F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 03:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363FD1C225F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85111803A;
	Tue,  5 Mar 2024 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gba/Mo3y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F5818030
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605142; cv=none; b=CaQqIvOY+pjqn2iQUxsf+uoEog5L2QFIg6OkYA0jawumwoQc3r94p0mdzO6i5ZZxCxTB7FFXxO2eIJ/XWj0TRnmpg72Tlu1V/QzWxtT6BT1We5OOP25F5AD2CKuinbT2L/CIFHu2WQTk1H8/GtnsQSkHISAezqYMjtVQZotO9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605142; c=relaxed/simple;
	bh=5VG1TjIC9pb0MvJzEssQmsZGAAMjBb2hnqKGJLRJHus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UuxTRIRI6BU4oVwQuU1eQZpRztnSvo4YEY0+MtCxiygUc0nuLHv8TGmRibWUXtpnM9NbiZG/N6YBk2lXz6nMWt9xePJn7O/W8q6mHkttTEdUj4ZlOi4g1cLX+DnV29z67mqz/QeASMGTreJJIINcSnukOkrckPpVcx3lx58Zleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gba/Mo3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC82EC433F1;
	Tue,  5 Mar 2024 02:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709605141;
	bh=5VG1TjIC9pb0MvJzEssQmsZGAAMjBb2hnqKGJLRJHus=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gba/Mo3ymQ5xZSNmu98f5/7MOEsA5tJTtvofDRfrvT7VkuzTWl5AzF7H+4D9Qs/rJ
	 OrtwOMmj1Th4GzTODFcQEtDA1O4YRLb3OIeJlNRhNcy7RybO+YIJL5u5cUiAUeQFpc
	 y46Mq8E7olsshlaC9NPdAE0wN9GV84KHSpUjCZcH9ZSBpgHTWPlW+f6y/aUhqqZ/qr
	 bVPWxoqPdbPblOII2he8Zkk+R3zGITYzWoBKyAIGMnSWKNO3xj8z9f2+0ocp+3exfa
	 tYz/iOovBB2NeFKGzjQD04e120encE1tQulMXIygLZoLuCa1sA1zKx76Ll24ftsdtK
	 +4mrgaAhnss2g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48A8FCE04AE; Mon,  4 Mar 2024 18:19:01 -0800 (PST)
Date: Mon, 4 Mar 2024 18:19:01 -0800
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
Message-ID: <b0988051-75e9-45d1-bdad-a628f0c6a494@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
 <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
 <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
 <icaomghoownzdhggxpwngexhd7m62ofluzgu4vifxfucy7jarn@gcjs6skgfkhp>
 <97a2c822-b4dd-4c53-a90e-d82c830f6bbe@paulmck-laptop>
 <7k3wjdjtgjnknuf5imgr2e6dy3qe4oqqbxla6tfdifrvfemwow@afe2iusbt4l6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7k3wjdjtgjnknuf5imgr2e6dy3qe4oqqbxla6tfdifrvfemwow@afe2iusbt4l6>

On Thu, Feb 29, 2024 at 03:51:08PM -0500, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 11:42:53AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 28, 2024 at 06:55:12PM -0500, Kent Overstreet wrote:
> > > So what I'm saying is that in the absensce of something noticing
> > > excessive memory being stranded and asking for an expedited grace
> > > period, the only bounds on the amount of memory being stranded will be
> > > how often RCU grace periods expire in the absence of anyone asking for
> > > them - that was my question to you. I'm not at all knowledgable on RCU
> > > internals but I gather it varies with things like dynticks and whether
> > > or not userspace is calling into the kernel?
> > 
> > It does vary based on quite a few things.  Taking as an example your
> > dynticks point, a nohz_full CPU does not restart the tick upon entering
> > the kernel.  Which is what you want for short system calls because
> > enabling and disabling the tick can be expensive.  But this causes
> > RCU trouble if a nohz_full CPU executes a long-running system call,
> > so RCU will force the tick on should such a CPU refused to respond to
> > RCU quickly enough.
> 
> Makes sense - so synchronize_rcu_expedited() has to check that and issue
> an IPI?

No and yes, in that synchronize_rcu_expedited() sends an IPI to every
CPU that is not either deep in the idle loop, in nohz_full userspace,
or offline.  A nohz_full CPU that is in a long system call will thus
get an IPI, which means that synchronize_rcu_expedited() need not rely
on the scheduling-clock interrupt.

In contrast, synchronize_rcu() (non-expedited) might well need to
re-enable the tick on this CPU in this case.

> > But the typical idle-system normal grace-period duration is a couple of
> > tens of milliseconds.  Except of course that if there are one-second-long
> > readers, you will see one-second-long grace periods.
> > 
> > > "gigabytes per second" - if userspace is doing big sequential streaming
> > > reads that don't fit into cache, we'll be evicting pagecache as quickly
> > > as we can read it in, so we should only be limited by your SSD
> > > bandwidth.
> > 
> > Understood.
> > 
> > But why not simply replace the current freeing with kfree_rcu() or
> > similar and see what really happens?  More further down...
> 
> Well, mainly because I've been doing filesystem and storage work for 15
> years and these kinds of problems are my bread and butter; in filesystem
> land (especially bcachefs, but really any modern journalling
> filesystem), there are a _lot_ of background reclaim tasks not unlike
> this.
> 
> So I'm speaking from experience here; the very first thing we're going
> to want when we do this for page cache pages and start analyzing system
> behaviour and performance is some basic numbers as to what's going on,
> and here it's practically no trouble at all to do it right.

I am not questioning the depth of your filesystem and storage experience.

However, the definition of "right" can vary widely.  In this case, "right"
might mean that we absolutely must do yet another special-purpose RCU.
I hope not, but if this is in fact the case, I need to learn that before
spending huge amounts of time attempting to tweak vanilla RCU into doing
something that it is incapable of doing.

> > > > And rcutorture really does do forward-progress testing on vanilla RCU
> > > > that features tight in-kernel loops doing call_rcu() without bounds on
> > > > memory in flight, and RCU routinely survives this in a VM that is given
> > > > only 512MB of memory.  In fact, any failure to survive this is considered
> > > > a bug to be fixed.
> > > 
> > > Are you saying there's already feedback between memory reclaim and RCU?
> > 
> > For the callback flooding in the torture test, yes.  There is a
> > register_oom_notifier() function, and if that function is called during
> > the callback flooding, that is a test failure.
> 
> Based on number of outstanding callbacks?

I am not sure what you are asking.  The OOM killer doesn't care about the
number of callbacks.  The callback flooding for vanilla RCU's torture
testing does not limit the number of callbacks.  Instead, it continues
allocating memory and passing it to call_rcu() until either the OOM
notification arrives (which is a bug in RCU) or until a reasonable number
of callbacks have completed their grace periods.

It does cheat in that the RCU callback function hands the memory directly
to rcutorture instead of taking a trip through the memory allocator.
It does this to focus the torturing on RCU instead of letting RCU hide
behind the memory allocator.

> > There used to be a shrinker in the RCU implementation itself, but this
> > proved unhelpful and was therefore removed.  As in RCU worked fine without
> > it given the workloads of that time.  Who knows?  Maybe it needs to be
> > added back in.
> 
> Why was it unhelpful? Were you having problems with the approach, or
> just didn't seem to be useful?

If I recall correctly, the RCU shrinker was counterproductive because
the grace periods completed quickly enough on their own, so there was
no point in burning the additional CPU.

But times change, so maybe it is time to put a shrinker back in.

> > The key point is that no one knows enough about this problem to dive at
> > all deeply into solution space.  From what you have described thus far,
> > the solution might involve one or more of the following options:
> > 
> > o	We do nothing, because RCU just handles it.  (Hey, I can dream,
> > 	can't I?)
> > 
> > o	We do a few modifications to RCU's force-quiescent state code.
> > 	This needs to be revisited for lazy preemption anyway, so this
> > 	is a good time to take a look.
> > 
> > o	We do a few modifications to RCU's force-quiescent state code,
> > 	but with the addition of communication of some sort from reclaim.
> > 	This appears to be your current focus.
> 
> Not exactly (but I'd like to hear what you have in mind); I'm
> envisioning this driven by reclaim itself.

I am wide open.  So much so that I consider your thought of driving RCU
from reclaim as a special case of communication of some sort from reclaim.

Again, I would like to see actual data.  This is not the simple part
of RCU.  In contrast, some years back when I immediately agreed to add
polling interfaces to SRCU, it was a simple addition to RCU that I had
long known would eventually be needed.

> > o	It might be that reclaim needs to use SRCU instead of RCU.
> > 	This would insulate reclaim from other subsystems' overly long
> > 	readers, but at the expense of smp_mb() overhead when entering
> > 	and exiting a reader.  Also, unlike RCU, SRCU has no reasonable
> > 	way of encouraging delayed readers (for example, delayed due
> > 	to preemption).
> 
> Yeah, I don't think SRCU is quite what we want here.

Given that you have actually used SRCU, I trust your judgment more than
I would trust most other people's.  But long and painful experience has
caused me to trust the judgment of real hardware running real software
quite a bit more than I trust that of any person, my own judgment
included.

> > o	It might be that reclaim needs its own specialized flavor of RCU,
> > 	as did tracing (Tasks RCU) and BPF (Tasks Trace RCU).  Plus there
> > 	is Steve Rostedt's additional flavor for tracing, which is now
> > 	Tasks RCU Rude.  I doubt that any of these three are what you
> > 	want, but let's get some hard data so that we can find out.
> > 
> > o	It might be that reclaim needs some synchronization mechanism
> > 	other than RCU.

You are free to ignore these last two for the time being, but they might
well prove necessary.  So I cannot ignore them.

> > We really need some hard data on how this thing affects RCU.  Again,
> > could we do the kfree()->kfree_rcu() change (and similar change,
> > depending on what memory allocator is used) and the run some tests to
> > see how RCU reacts?
> 
> Well, like I mentioned previously - the "hard data" you say we need is
> exactly what I was saying we need to collect as a first order of
> business - we need to know the amount of memory stranded by RCU, and we
> need to be able to watch that number as we run through different
> buffered IO workloads.

Good!  Please do it!  Change those kfree() calls to kfree_rcu() and
let's see whether or not the system OOMs.

> Sure, we could do this as a special case for just pagecache page
> freeing; but it looks like zero extra work to just do it right and do it
> for kfree_rcu() in general; and I've already talked about how minimal
> the perforance cost is.

Kent, kfree_rcu() is itself a special case.

There is call_rcu(), synchronize_rcu(), synchronize_rcu_expedited(), as
well as all of the polling interfaces, none of which have any reasonable
way to know the corresponding size of data.  And a lot of the RCU traffic
typically goes through call_rcu() and synchronize_rcu().

> And more broadly, we have real gaps when it comes to OOM debugging and
> being able to report on who's responsible for what memory and how much,
> and that's something I want to close. I've got a shrinker debugging
> patch that I really need to get back to and shove in, and really in that
> area I need to go further and add byte counters to shrinker reporting.
> 
> IOW, this isn't just an RCU topic, this is a memory reclaim topic, and
> lots of us filesystem developers have... things to say on the subject of
> memory reclaim. Being able to get proper information so that we can
> debug stuff has been a major point of contention; I hope you can
> try to appreciate where we're coming from.

I am trying, Kent.  I really am.  I am absolutely not succeeding.

Without the kfree()->kfree_rcu() testing, how do you even know that
vanilla RCU is in fact the right solution?  The answer is that you
absolutely do not know one way or the other.

Please keep in mind that we have had several cases where vanilla RCU
was not the right answer, which is why SRCU, Tasks RCU, Tasks Trace RCU,
and Tasks Rude RCU exist.  Plus there has been code that uses workqueues
as a type of RCU.  And if you are going to do something like free half
of memory in one shot and be unable to re-use that memory until after a
normal RCU grace period elapses, we probably need something quite special.
Maybe things never get that extreme, but you have been emphasizing tens
of gigabytes, and that would likely require something special on even a
64GB system.  Or maybe you would only do tens of gigabytes on a system
with terabytes of memory, in which case I am not quite so worried.

Which brings us to how do you even know that RCU needs to change at all?
Again, the answer is that you absolutely do not know one way or the other.

> > If RCU does not react all that well, then we will also need information on
> > what the RCU readers look like, for example, must they block, must they
> > be preemptible, and about how long do they run for?  Best if they never
> > block, need not be preemptible, and run for very short periods of time,
> > but they are what they are.  Perhaps Matthew Wilcox has some thoughts
> > on this.
> 
> We'll be using this in filemap_read() (and I've worked on that code more
> than most); we're already using rcu_read_lock() there for the xarray
> lookup, which is partly why RCU (the regular sort) is a natural fit for
> protecting the data itself.
> 
> This will move the copy_to_user_nofault() under rcu_read_lock(), so
> we're not blocking or faulting or preempting or anything like that. Just
> doing a (potentially big) copy to userspace.

Thank you for the heads up.  Are these also things that you believe
that RCU cannot handle without modifications?  If so, it would be good
to test these as well.

							Thanx, Paul

