Return-Path: <linux-fsdevel+bounces-64352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 151EBBE240C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBD6F4E3F9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8213230C62A;
	Thu, 16 Oct 2025 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NG18yCEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67F2214A79
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605121; cv=none; b=GegibJSiDLuc3urlV+p+pqC5JrnPkWGYfjGbuuFOakoty1KW+L76MEBzREx4T6AELvx11DQcyRKnC/1l49Qjpphcxm6+Srsl3yd1K5v/Ib7yg/V2vRcXTaq/GiBMdp0vZuv3+ZvIOFG1cJy4QAeg1hMH6YQVo77ILC/YaeqB9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605121; c=relaxed/simple;
	bh=5XxEMgMKKBeR6w3C7yGfqs36k1abLQJdz2tac+8Y8bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ib9FP81wd6gE6b2/QDG0jyoQMXz4eZKFRblLR+dFuNWH6xBaGsuZHmE867Thb4++mVjLTsIQQTy8UxaNczPwBoybas4ol5qBnSHqSNgXBGUSJHTbX0OpQoRoa9jVducfZaF5JqwEKY6jmQHR5P4t8MAANyXmoVmi1d0eRCwRVgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NG18yCEn; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTTl+vfC9r7NGy5s41MPpGg0tTIF32sqGIRWLUqMf/0=; b=NG18yCEnPfnk4vRaTgEXNlC+X/
	vaSh2u2cH1N+X6rftTDG/8Gp8EbACLxs2fC2s0v1IFfaLnWybRCh2coTJX1Tm6Tl4gw5Fb5Y5+ZvA
	PiGv4sLTuGyYVDNJfht/UTfGo5kDVhAlhNLVqjzGkbE7EAVLL5OFK41iFapwXl4eO5NgLjqwd0w8W
	7ic+DHzDiJLdpWFYLhCfYrvq6gZO0AM/EOn2bGHApX9wQrOhnjtvvwpcH8cx/QvGBWzVAuUB5KRZU
	FHNqlhRNbbO4LAgV3n/GPbPYnscL3ssifCpBVVvaTvBtqlMstVR8znISlroh+qf6YxM7gdTHHQQ0R
	M7B9A0wg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JoN-00000006cCg-0bWB;
	Thu, 16 Oct 2025 08:58:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 01D7A30023C; Thu, 16 Oct 2025 10:58:13 +0200 (CEST)
Date: Thu, 16 Oct 2025 10:58:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Luis Henriques <luis@igalia.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: Wake requests on the same cpu
Message-ID: <20251016085813.GB3245006@noisy.programming.kicks-ass.net>
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
 <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>

On Wed, Oct 15, 2025 at 03:19:31PM -0700, Joanne Koong wrote:

> > > Won't this lose cache locality for all the other data that is in the
> > > client thread's cache on the previous CPU? It seems to me like on
> > > average this would be a costlier miss overall? What are your thoughts
> > > on this?
> >
> > So as in the introduction, which b4 made a '---' comment below,
> > initially I thought this should be a conditional on queue-per-core.
> > With queue-per-core it should be easy to explain, I think.
> >
> > App submits request on core-X, waits/sleeps, request gets handle on
> > core-X by queue-X.
> > If there are more applications running on this core, they
> > get likely re-scheduled to another core, as the libfuse queue thread is
> > core bound. If other applications don't get re-scheduled either the
> > entire system is overloaded or someone sets manual application core
> > affinity - we can't do much about that in either case. With
> > queue-per-core there is also no debate about "previous CPU".
> > Worse is actually scheduler behavior here, although the ring thread
> > itself goes to sleep soon enough. Application gets still quite often
> > re-scheduled to another core. Without wake-on-same core behavior is
> > even worse and it jumps across all the time. Not good for CPU cache...
> 
> Maybe this is a lack of my understanding of scheduler internals,  but
> I'm having a hard time seeing what the benefit of
> wake_up_on_current_cpu() is over wake_up() for the queue-per-core
> case.
> 
> As I understand it, with wake_up() the scheduler already will try to
> wake up the thread and put it back on the same core to maintain cache
> locality, which in this case is the same core
> "wake_up_on_current_cpu()" is trying to put it on. If there's too much
> load imbalance then regardless of whether you call wake_up() or
> wake_up_on_current_cpu(), the scheduler will migrate the task to
> whatever other core is better for it.
> 
> So I guess the main benefit of calling wake_up_on_current_cpu() over
> wake_up() is that for situations where there is only some but not too
> much load imbalance we force the application to run on the current
> core even despite the scheduler thinking it's better for overall
> system health to distribute the load? I don't see an issue if the
> application thread runs very briefly but it seems more likely that the
> application thread could be work intensive in which case it seems like
> the thread would get migrated anyways or lead to more latency in the
> long term with trying to compete on an overloaded core?

So the scheduler will try and wake on the previous CPU, but if that CPU
is not idle it will look for any non-idle CPU in the same L3 and very
aggressively move tasks around.

Notably if Task-A is waking Task-B, and Task-A is running on CPU-1 and
Task-B was previously running on CPU-1, then the wakeup will see CPU-1
is not idle (it is running Task-A) and it will try and find another CPU
in the same L3.

This is fine if Task-A continues running; however in the case where
Task-A is going to sleep right after doing the wakeup, this is perhaps
sub-optimal, CPU-1 will end up idle.

We have the WF_SYNC (wake-flag) that tries to indicate this latter case;
trouble is, it often gets used where it should not be, it is unreliable.
Therefore it not a strong hint.

Then we 'recently' grew WF_CURRENT_CPU, that forces the wakeup to the
same CPU. If you abuse, you keep pieces :-)

So it all depends a bit on the workload, machine and situation.

Some machines L3 is fine, some machines L3 has exclusive L2 and it hurts
more to move tasks. Some workloads don't fit L2 so it doesn't matter
anyway. TL;DR is we need this damn crystal ball instruction :-)

