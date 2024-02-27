Return-Path: <linux-fsdevel+bounces-12962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1272D869A71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AC28F215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B88145350;
	Tue, 27 Feb 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0pHnAJA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AE14264A
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047953; cv=none; b=mRERslYdrf08th0OhF9hGyNN0Nz5aKlGDaFFaPRhiEkBZqx/FC9ZXqRv2mhmtlDRR2HR2PfgDVcuAvOcSdN0ZYkqpeOnSsTkEgR/u3xfYqKZBX2d1J6vsPVrQSyZznN2B/jvWPngjwlTT7JHgcnbf6xFsA6k0VpDkZvURCAQVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047953; c=relaxed/simple;
	bh=FA7ZtZfv5sV94KpinvJfx2SRQfk/VJW3SQxQPoBgN50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkmGaWMG4MGp78kc2WQuVxs9cLdGEAtl7SlC351CJHtkwJBlk+GffCc5cRyKRTP7MRqtXDzMBpRMLdsg45rlI6r/S9vFFbGQII9CCsAt3/Nw5yWRjFooUq4yiA2hq0hw/tRK5M8ycuOQcNeVoOFyNPI4kr5GEnyWJrIfX+RM1so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0pHnAJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6179C433C7;
	Tue, 27 Feb 2024 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709047952;
	bh=FA7ZtZfv5sV94KpinvJfx2SRQfk/VJW3SQxQPoBgN50=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=B0pHnAJAuoKAOY2I+Wzr6JIeZQFHX5Ly8AOHVqFVrkOtF/Y5vJVILr+NJCnC0btPK
	 D9rGchZBRYDddoLwua7LGOEqEL+yxlT8IUV4VfkXxYLsc/UarMTz9DJikBVpyqBI/b
	 g6TKidxpL4NjPBx1VqGhUEi/kqC0hJu5SU5LexROr3Ps/ldiIWfWQKK2hLt6ulDdPJ
	 pteUgoI8DzLbnmngubPRHRF0quoCn5+Zx3kOVtdu5842Msv/BoXwTGl7TdJMHefOIj
	 uJ3mmkvDvvflOO1zwtUnEMjTAvsrT/UYqWkuLFaaNZzDvCEh5K6lcyUIMefl3dgWC9
	 /D6kXeSaYWsqw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F414CE0F12; Tue, 27 Feb 2024 07:32:32 -0800 (PST)
Date: Tue, 27 Feb 2024 07:32:32 -0800
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
Message-ID: <ff8c0f56-6778-47e4-b365-d9c1ef75bbae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
 <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
 <49354148-4dea-4c89-b591-76b21ed4a5d1@paulmck-laptop>
 <ldpltrnfmf4a3xs43hfjnhrfidrbd7t5k6i5i3ysuzken2zeql@wm2ivk45hitj>
 <df68c44e-1ab3-485d-a0d6-0c37a06ab4ff@paulmck-laptop>
 <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6xpyltamnbd7q7nesntqspyfjfq3jexkmfyj2fekrk2mrhktcr@73vij67d5vne>

On Tue, Feb 27, 2024 at 01:21:05AM -0500, Kent Overstreet wrote:
> On Mon, Feb 26, 2024 at 09:17:41PM -0800, Paul E. McKenney wrote:
> > On Mon, Feb 26, 2024 at 08:08:17PM -0500, Kent Overstreet wrote:
> > > On Mon, Feb 26, 2024 at 04:55:29PM -0800, Paul E. McKenney wrote:
> > > > On Mon, Feb 26, 2024 at 07:29:04PM -0500, Kent Overstreet wrote:
> > > > > On Mon, Feb 26, 2024 at 04:05:37PM -0800, Paul E. McKenney wrote:
> > > > > > On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> > > > > > > Well, we won't want it getting hammered on continuously - we should be
> > > > > > > able to tune reclaim so that doesn't happen.
> > > > > > > 
> > > > > > > I think getting numbers on the amount of memory stranded waiting for RCU
> > > > > > > is probably first order of business - minor tweak to kfree_rcu() et all
> > > > > > > for that; there's APIs they can query to maintain that counter.
> > > > > > 
> > > > > > We can easily tell you the number of blocks of memory waiting to be freed.
> > > > > > But RCU does not know their size.  Yes, we could ferret this on each
> > > > > > call to kmem_free_rcu(), but that might not be great for performance.
> > > > > > We could traverse the lists at runtime, but such traversal must be done
> > > > > > with interrupts disabled, which is also not great.
> > > > > > 
> > > > > > > then, we can add a heuristic threshhold somewhere, something like 
> > > > > > > 
> > > > > > > if (rcu_stranded * multiplier > reclaimable_memory)
> > > > > > > 	kick_rcu()
> > > > > > 
> > > > > > If it is a heuristic anyway, it sounds best to base the heuristic on
> > > > > > the number of objects rather than their aggregate size.
> > > > > 
> > > > > I don't think that'll really work given that object size can very from <
> > > > > 100 bytes all the way up to 2MB hugepages. The shrinker API works that
> > > > > way and I positively hate it; it's really helpful for introspection and
> > > > > debugability later to give good human understandable units to this
> > > > > stuff.
> > > > 
> > > > You might well be right, but let's please try it before adding overhead to
> > > > kfree_rcu() and friends.  I bet it will prove to be good and sufficient.
> > > > 
> > > > > And __ksize() is pretty cheap, and I think there might be room in struct
> > > > > slab to stick the object size there instead of getting it from the slab
> > > > > cache - and folio_size() is cheaper still.
> > > > 
> > > > On __ksize():
> > > > 
> > > >  * This should only be used internally to query the true size of allocations.
> > > >  * It is not meant to be a way to discover the usable size of an allocation
> > > >  * after the fact. Instead, use kmalloc_size_roundup().
> > > > 
> > > > Except that kmalloc_size_roundup() doesn't look like it is meant for
> > > > this use case.  On __ksize() being used only internally, I would not be
> > > > at all averse to kfree_rcu() and friends moving to mm.
> > > 
> > > __ksize() is the right helper to use for this; ksize() is "how much
> > > usable memory", __ksize() is "how much does this occupy".
> > > 
> > > > The idea is for kfree_rcu() to invoke __ksize() when given slab memory
> > > > and folio_size() when given vmalloc() memory?
> > > 
> > > __ksize() for slab memory, but folio_size() would be for page
> > > allocations - actually, I think compound_order() is more appropriate
> > > here, but that's willy's area. IOW, for free_pages_rcu(), which AFAIK we
> > > don't have yet but it looks like we're going to need.
> > > 
> > > I'm scanning through vmalloc.c and I don't think we have a helper yet to
> > > query the allocation size - I can write one tomorrow, giving my brain a
> > > rest today :)
> > 
> > Again, let's give the straight count of blocks a try first.  I do see
> > that you feel that the added overhead is negligible, but zero added
> > overhead is even better.
> 
> How are you going to write a heuristic that works correctly both when
> the system is cycling through nothing but 2M hugepages, and nothing but
> 128 byte whatevers?

I could simply use the same general approach that I use within RCU
itself, which currently has absolutely no idea how much memory (if any)
that each callback will free.  Especially given that some callbacks
free groups of memory blocks, while other free nothing.  ;-)

Alternatively, we could gather statistics on the amount of memory freed
by each callback and use that as an estimate.

But we should instead step back and ask exactly what we are trying to
accomplish here, which just might be what Dave Chinner was getting at.

At a ridiculously high level, reclaim is looking for memory to free.
Some read-only memory can often be dropped immediately on the grounds
that its data can be read back in if needed.  Other memory can only be
dropped after being written out, which involves a delay.  There are of
course many other complications, but this will do for a start.

So, where does RCU fit in?

RCU fits in between the two.  With memory awaiting RCU, there is no need
to write anything out, but there is a delay.  As such, memory waiting
for an RCU grace period is similar to memory that is to be reclaimed
after its I/O completes.

One complication, and a complication that we are considering exploiting,
is that, unlike reclaimable memory waiting for I/O, we could often
(but not always) have some control over how quickly RCU's grace periods
complete.  And we already do this programmatically by using the choice
between sychronize_rcu() and synchronize_rcu_expedited().  The question
is whether we should expedite normal RCU grace periods during reclaim,
and if so, under what conditions.

You identified one potential condition, namely the amount of memory
waiting to be reclaimed.  One complication with this approach is that RCU
has no idea how much memory each callback represents, and for call_rcu(),
there is no way for it to find out.  For kfree_rcu(), there are ways,
but as you know, I am questioning whether those ways are reasonable from
a performance perspective.  But even if they are, we would be accepting
more error from the memory waiting via call_rcu() than we would be
accepting if we just counted blocks instead of bytes for kfree_rcu().

Let me reiterate that:  The estimation error that you are objecting to
for kfree_rcu() is completely and utterly unavoidable for call_rcu().
RCU callback functions do whatever their authors want, and we won't be
analyzing their code to estimate bytes freed without some serious advances
in code-analysis technology.  Hence my perhaps otherwise inexplicable
insistence on starting with block counts rather than byte counts.

Another complication surrounding estimating memory to be freed is that
this memory can be in any of the following states:

1.	Not yet associated with a specific grace period.  Its CPU (or
	its rcuog kthread, as the case may be) must interact with the
	RCU core and assign a grace period.  There are a few costly
	RCU_STRICT_GRACE_PERIOD tricks that can help here, usually
	involving IPIing a bunch of CPUs or awakening a bunch of rcuog
	kthreads.

2.	Associated with a grace period that has not yet started.
	This grace period must of course be started, which usually
	cannot happen until the previous grace period completes.
	Which leads us to...

3.	Associated with the current grace period.  This is where
	the rcutorture forcing of quiescent states comes in.

4.	Waiting to be invoked.	This happens from either RCU_SOFTIRQ
	context or from rcuoc kthread context, and is of course impeded
	by any of the aforementioned measures to speed things up.
	Perhaps we could crank up the priority of the relevant ksoftirq
	or rcuog/rcuoc kthreads, though this likely has some serious
	side effects.  Besides, as far as I know, we don't mess with
	other process priorities for the benefit of reclaim, so why
	would we start with RCU?

Of these, #3 and #4 are normally the slowest, with #3 often being the
slowest under light call_rcu()/kfree_rcu() load (or in the presence of
slow RCU readers) and #4 often being the slowest under callback-flooding
conditions.  Now reclaim might cause callback flooding, but I don't
recall seeing this.  At least not to the extent as userspace-induced
callback flooding, for example, during "rm -rf" of a big filesystem tree
with lots of small files on a fast device.  So we likely focus on #3.

So we can speed RCU up, and we could use some statistics on quantity
of whatever waiting for RCU.  But is that the right approach?

Keep in mind that reclaim via writeback involves I/O delays.  Now these
delays are often much shorter than the used to be, courtesy of SSDs.
But queueing is still a thing, as are limitations on write bandwidth,
so those delays are still consequential.  My experience is that reclaim
spans seconds rather than milliseconds, let alone microseconds, and RCU
grace periods are in the tens to hundreds of milliseconds.  Or am I yet
again showing my age?

So perhaps we should instead make RCU take "ongoing reclaim" into account
when prodding reluctant grace periods.  For example, RCU normally scans
for idle CPUs every 3 milliseconds.  Maybe it should speed that up to
once per millisecond when reclaim is ongoing.  And likelwise for RCU's
other grace-period-prodding heuristics.

In addition, RCU uses the number of callbacks queued on a particular
CPU to instigate grace-period prodding.  Maybe these heuristics should
also depend on whether or not a reclaim is in progress.

Is there an easy, fast, and reliable way for RCU to determine whether or
not a reclaim is ongoing?  It might be both easier and more effective
for RCU to simply unconditionally react to the existence of a relaim
than for the reclaim process to try to figure out when to prod RCU.

							Thanx, Paul

