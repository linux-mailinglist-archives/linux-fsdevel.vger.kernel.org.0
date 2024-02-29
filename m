Return-Path: <linux-fsdevel+bounces-13211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224186D380
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 20:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E1E28611D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 19:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8295D13C9EE;
	Thu, 29 Feb 2024 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN9x9sQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79B013C9D6
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235774; cv=none; b=XlYJzxcxhNWHy54IZ9v+CzZ2QUuWZ1u1llF+NOiKXoLnAdW1k4v8vpgnwW6yuhZ3ExXzM1t4QbDYWKx28nuLEiuqPTu1BHv08q/zHuD1k7UiUgJ1Qv814p/4TDtV+2ql4M99JEd7KdF6VJAILFYgKBgHf9NwV7X+1VXxXO59r0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235774; c=relaxed/simple;
	bh=uSlTKnLTLSa6TizsHMLnmP2K6THXu/42ACDR7CpLLmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1g9J0Pu+jhERZz+yarYfQ1JRUDxKsCbjScBBhtZq3fIOjt2G/0DNWYh2Y065xOEqP3J0NLMsWhFDEaVuG9JWqnyTE59A9vyLUWSbMFbmOPYW94hqfoWmYYmPCJ0L65JT2JnNPJdAZQZa0Lk8wwXTuoo0Dl9W/1K41Z669N5tIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN9x9sQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6FDC433C7;
	Thu, 29 Feb 2024 19:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709235773;
	bh=uSlTKnLTLSa6TizsHMLnmP2K6THXu/42ACDR7CpLLmU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=JN9x9sQAH1z6feYcGxRWNlftkn431UT7zVLD21dT47QyD+TfMaqpf3O8P2AjR+kPL
	 TX4RdBlVEwT2HLFt9tYCCc0u0oeqikrKu8TOBqx1Jy9e7pSYQ51bJAwo1iFlO8YlSl
	 ZQZn12rPO+UZc4865Y7lO9pPL7PzNTZYgK3pStTolpbrOZRvZEbBn+J1hs7hxa0X6W
	 WvtEkG6tDOtoauwPaTlOOkahdEGRhKb/0jjd1pSgR6ax3arkjB8lgSqOwo+lNXwZwx
	 9Hm/UriTIVM0jpFdfV5x40oTvapu5YW7UotK6p9O9glgehZ3P88qeDalx00mbyfZUa
	 ar8UKC0VNVVrg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 63371CE1382; Thu, 29 Feb 2024 11:42:53 -0800 (PST)
Date: Thu, 29 Feb 2024 11:42:53 -0800
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
Message-ID: <97a2c822-b4dd-4c53-a90e-d82c830f6bbe@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
 <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
 <Zd4FrwE8D7m31c66@casper.infradead.org>
 <1f0d0536-c35b-46f9-9dfb-c8bc29e6956a@paulmck-laptop>
 <4eibprmeehxnavkbjwvqdxecqk3b4l6lkc3hslbf3ggmxv5vxw@gprjhbny5rue>
 <e60b185a-dd54-4127-9b14-4062092afbbb@paulmck-laptop>
 <icaomghoownzdhggxpwngexhd7m62ofluzgu4vifxfucy7jarn@gcjs6skgfkhp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <icaomghoownzdhggxpwngexhd7m62ofluzgu4vifxfucy7jarn@gcjs6skgfkhp>

On Wed, Feb 28, 2024 at 06:55:12PM -0500, Kent Overstreet wrote:
> On Tue, Feb 27, 2024 at 09:58:48AM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 27, 2024 at 11:34:06AM -0500, Kent Overstreet wrote:
> > > On Tue, Feb 27, 2024 at 08:21:29AM -0800, Paul E. McKenney wrote:
> > > > On Tue, Feb 27, 2024 at 03:54:23PM +0000, Matthew Wilcox wrote:
> > > > > On Tue, Feb 27, 2024 at 07:32:32AM -0800, Paul E. McKenney wrote:
> > > > > > At a ridiculously high level, reclaim is looking for memory to free.
> > > > > > Some read-only memory can often be dropped immediately on the grounds
> > > > > > that its data can be read back in if needed.  Other memory can only be
> > > > > > dropped after being written out, which involves a delay.  There are of
> > > > > > course many other complications, but this will do for a start.
> > > > > 
> > > > > Hi Paul,
> > > > > 
> > > > > I appreciate the necessity of describing what's going on at a very high
> > > > > level, but there's a wrinkle that I'm not sure you're aware of which
> > > > > may substantially change your argument.
> > > > > 
> > > > > For anonymous memory, we do indeed wait until reclaim to start writing it
> > > > > to swap.  That may or may not be the right approach given how anonymous
> > > > > memory is used (and could be the topic of an interesting discussion
> > > > > at LSFMM).
> > > > > 
> > > > > For file-backed memory, we do not write back memory in reclaim.  If it
> > > > > has got to the point of calling ->writepage in vmscan, things have gone
> > > > > horribly wrong to the point where calling ->writepage will make things
> > > > > worse.  This is why we're currently removing ->writepage from every
> > > > > filesystem (only ->writepages will remain).  Instead, the page cache
> > > > > is written back much earlier, once we get to balance_dirty_pages().
> > > > > That lets us write pages in filesystem-friendly ways instead of in MM
> > > > > LRU order.
> > > > 
> > > > Thank you for the additional details.
> > > > 
> > > > But please allow me to further summarize the point of my prior email
> > > > that seems to be getting lost:
> > > > 
> > > > 1.	RCU already does significant work prodding grace periods.
> > > > 
> > > > 2.	There is no reasonable way to provide estimates of the
> > > > 	memory sent to RCU via call_rcu(), and in many cases
> > > > 	the bulk of the waiting memory will be call_rcu() memory.
> > > > 
> > > > Therefore, if we cannot come up with a heuristic that does not need to
> > > > know the bytes of memory waiting, we are stuck anyway.
> > > 
> > > That is a completely asinine argument.
> > 
> > Huh.  Anything else you need to get off your chest?
> > 
> > On the off-chance it is unclear, I do disagree with your assessment.
> > 
> > > > So perhaps the proper heuristic for RCU speeding things up is simply
> > > > "Hey RCU, we are in reclaim!".
> > > 
> > > Because that's the wrong heuristic. There are important workloads for
> > > which  we're _always_ in reclaim, but as long as RCU grace periods are
> > > happening at some steady rate, the amount of memory stranded will be
> > > bounded and there's no reason to expedite grace periods.
> > 
> > RCU is in fact designed to handle heavy load, and contains a number of
> > mechanisms to operate more efficiently at higher load than at lower load.
> > It also contains mechanisms to expedite grace periods under heavy load.
> > Some of which I already described in earlier emails on this thread.
> 
> yeah, the synchronize_rcu_expedited() souns like exactly what we need
> here, when memory reclaim notices too much memory is stranded

I was talking about things that the normal grace periods do go speed
things up when needed, but it might well be the case that this use
case needs to use synchronize_rcu_expedited().  But this function
does have some serious side effects, including lots of IPIs and (in
preemptible kernels) priority boosting of any task that has ever
been preempted within its current RCU read-side critical section.
Plus synchronize_rcu_expedited() cannot help if the problem is overly
long readers.

But one might imagine a solution that used kfree_rcu() and
rcu_barrier() to detect any RCU slowness, which would trigger use of
synchronize_rcu_expedited().  Except that this is harder than it
might immediately appear.

So first, let's find out what the situation really requires.

> > > If we start RCU freeing all pagecache folios we're going to be cycling
> > > memory through RCU freeing at the rate of gigabytes per second, tens of
> > > gigabytes per second on high end systems.
> > 
> > The load on RCU would be measured in terms of requests (kfree_rcu() and
> > friends) per unit time per CPU, not in terms of gigabytes per unit time.
> > Of course, the amount of memory per unit time might be an issue for
> > whatever allocators you are using, and as Matthew has often pointed out,
> > the deferred reclamation incurs additional cache misses.
> 
> So what I'm saying is that in the absensce of something noticing
> excessive memory being stranded and asking for an expedited grace
> period, the only bounds on the amount of memory being stranded will be
> how often RCU grace periods expire in the absence of anyone asking for
> them - that was my question to you. I'm not at all knowledgable on RCU
> internals but I gather it varies with things like dynticks and whether
> or not userspace is calling into the kernel?

It does vary based on quite a few things.  Taking as an example your
dynticks point, a nohz_full CPU does not restart the tick upon entering
the kernel.  Which is what you want for short system calls because
enabling and disabling the tick can be expensive.  But this causes
RCU trouble if a nohz_full CPU executes a long-running system call,
so RCU will force the tick on should such a CPU refused to respond to
RCU quickly enough.

But the typical idle-system normal grace-period duration is a couple of
tens of milliseconds.  Except of course that if there are one-second-long
readers, you will see one-second-long grace periods.

> "gigabytes per second" - if userspace is doing big sequential streaming
> reads that don't fit into cache, we'll be evicting pagecache as quickly
> as we can read it in, so we should only be limited by your SSD
> bandwidth.

Understood.

But why not simply replace the current freeing with kfree_rcu() or
similar and see what really happens?  More further down...

> > And rcutorture really does do forward-progress testing on vanilla RCU
> > that features tight in-kernel loops doing call_rcu() without bounds on
> > memory in flight, and RCU routinely survives this in a VM that is given
> > only 512MB of memory.  In fact, any failure to survive this is considered
> > a bug to be fixed.
> 
> Are you saying there's already feedback between memory reclaim and RCU?

For the callback flooding in the torture test, yes.  There is a
register_oom_notifier() function, and if that function is called during
the callback flooding, that is a test failure.

There used to be a shrinker in the RCU implementation itself, but this
proved unhelpful and was therefore removed.  As in RCU worked fine without
it given the workloads of that time.  Who knows?  Maybe it needs to be
added back in.

> > So I suspect RCU is quite capable of handling this load.  But how many
> > additional kfree_rcu() calls are you anticipating per unit time per CPU?
> > For example, could we simply measure the rate at which pagecache folios
> > are currently being freed under heavy load?  Given that information,
> > we could just try it out.
> 
> It's not the load I'm concerned about, or the number of call_rcu()
> calls, I have no doubt that RCU will cope with that just fine.
> 
> But I do think that we need an additional feedback mechanism here. When
> we're doing big streaming sequential buffered IO, and lots of memory is
> cycled in and out of the pagecache, we have a couple things we want to
> avoid:
> 
> The main thing is that we don't want the amount of memory stranded
> waiting for RCU to grow unbounded and shove everything out of the
> caches; if you're currently just concerned about _deadlock_ that is
> likely insufficient here, we're also concerned about maintaining good
> steady performance under load
> 
> We don't want memory reclaim to be trying harder and harder when the
> correct thing to do is a synchronize_rcu_expedited().
> 
> We _also_ don't want to be hammering on RCU asking for expedited grace
> periods unnecessarily when the number of pending callbacks is high, but
> they're all for unrelated stuff - expedited RCU grace periods aren't
> free either!.
> 
> Does that help clarify things?

Yes, but...

The key point is that no one knows enough about this problem to dive at
all deeply into solution space.  From what you have described thus far,
the solution might involve one or more of the following options:

o	We do nothing, because RCU just handles it.  (Hey, I can dream,
	can't I?)

o	We do a few modifications to RCU's force-quiescent state code.
	This needs to be revisited for lazy preemption anyway, so this
	is a good time to take a look.

o	We do a few modifications to RCU's force-quiescent state code,
	but with the addition of communication of some sort from reclaim.
	This appears to be your current focus.

o	It might be that reclaim needs to use SRCU instead of RCU.
	This would insulate reclaim from other subsystems' overly long
	readers, but at the expense of smp_mb() overhead when entering
	and exiting a reader.  Also, unlike RCU, SRCU has no reasonable
	way of encouraging delayed readers (for example, delayed due
	to preemption).

o	It might be that reclaim needs its own specialized flavor of RCU,
	as did tracing (Tasks RCU) and BPF (Tasks Trace RCU).  Plus there
	is Steve Rostedt's additional flavor for tracing, which is now
	Tasks RCU Rude.  I doubt that any of these three are what you
	want, but let's get some hard data so that we can find out.

o	It might be that reclaim needs some synchronization mechanism
	other than RCU.

We really need some hard data on how this thing affects RCU.  Again,
could we do the kfree()->kfree_rcu() change (and similar change,
depending on what memory allocator is used) and the run some tests to
see how RCU reacts?

If RCU does not react all that well, then we will also need information on
what the RCU readers look like, for example, must they block, must they
be preemptible, and about how long do they run for?  Best if they never
block, need not be preemptible, and run for very short periods of time,
but they are what they are.  Perhaps Matthew Wilcox has some thoughts
on this.

Given that information, we can make at least a semi-informed decision
as to which (if any) of the six possibilities listed above is most
appropriate.

Does that help to communicate my position on this topic?

							Thanx, Paul

