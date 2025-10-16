Return-Path: <linux-fsdevel+bounces-64353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA64CBE2442
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 691553533E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 09:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFB71A294;
	Thu, 16 Oct 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QzelVHyI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DC23A994
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605233; cv=none; b=nUuIoj5E3EogyrljkAv668nQ5gnHQyoblHpBXxF4OjErZ4qfO4Y29mk8RegQb9zh2BIhvg0khuKhmJRbpoAQRQHeJnPxYrPhs8icyWdLBSReZZe1vL/AJgzPcVYl0M4A7L8XUYhkQJ3mpYfr22Y7Fxeyyh9bsLn1907L5Unq5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605233; c=relaxed/simple;
	bh=/SGJhWvQ89EIvrXFZWyk4kSUE1sbUgTcfiyhpzA0m1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cd1huSlGwPXHSBu6GLWCf8Z6jvzvQ/gSstp06bKuPxXUqw5zcEbbYj4L+OjCw9mBI2ffb+FbctvJuDbGd2zgbIBSs+e4N/SRgqWFQVMv+WpJ/kOiIQ2jLV2k5JdpUZ4+JZ1xUbNJK2HGteG388COVriVEy6/I1m9ULxPP98S9yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QzelVHyI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DiNuLlQyPMrKkrBOgYK73tSxwHL6eaO2n1Ve7rjTq/k=; b=QzelVHyIPV1FTXL/PhRar8lEEa
	YxNdcmnDq9PFkMzEQVtIqGyXCPTfGWgvNc+ycLTxAMGuDLTad0kndUqWjBTqHUVF/UCRLNpE2e2ao
	pEtD0Da34g0CVt4Vm3FwcAG+bCPeo/Ubcz8ED8YV17YziGbTkN+WeEJg8UViXdlrAAqA0HEy679UP
	iqT5RSXjEIAMD6E/iPtpcjPHtURgYV8GRPtiCroaxe0YThsmAS7/qPhAbzpHlehO4BSvyHXbBB3gh
	VIeG5gZ9DTA5to1ZgFqgHRyutD2D6YC0FtNeSZtH/11vPrHcKgaCQZD1+F/QJDrwToS4ItSgduimd
	k/jkeuPA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9JqN-0000000HZrO-21gX;
	Thu, 16 Oct 2025 09:00:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B13BA30023C; Thu, 16 Oct 2025 11:00:19 +0200 (CEST)
Date: Thu, 16 Oct 2025 11:00:19 +0200
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
Message-ID: <20251016090019.GH4068168@noisy.programming.kicks-ass.net>
References: <20251014-wake-same-cpu-v2-1-68f5078845c6@ddn.com>
 <CAJnrk1brjsPoXc_dbMj-Ty4dr5ZCxtVjBn6WGOY8DkGxh87R5Q@mail.gmail.com>
 <6d16a94b-3277-4922-a628-f17f622369bc@bsbernd.com>
 <CAJnrk1b9xVqmDY9kgDjPpjs7zuXNbiNaQnMyvY0iJirJbHi1yw@mail.gmail.com>
 <20251016085813.GB3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016085813.GB3245006@noisy.programming.kicks-ass.net>

On Thu, Oct 16, 2025 at 10:58:14AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 03:19:31PM -0700, Joanne Koong wrote:
> 
> > > > Won't this lose cache locality for all the other data that is in the
> > > > client thread's cache on the previous CPU? It seems to me like on
> > > > average this would be a costlier miss overall? What are your thoughts
> > > > on this?
> > >
> > > So as in the introduction, which b4 made a '---' comment below,
> > > initially I thought this should be a conditional on queue-per-core.
> > > With queue-per-core it should be easy to explain, I think.
> > >
> > > App submits request on core-X, waits/sleeps, request gets handle on
> > > core-X by queue-X.
> > > If there are more applications running on this core, they
> > > get likely re-scheduled to another core, as the libfuse queue thread is
> > > core bound. If other applications don't get re-scheduled either the
> > > entire system is overloaded or someone sets manual application core
> > > affinity - we can't do much about that in either case. With
> > > queue-per-core there is also no debate about "previous CPU".
> > > Worse is actually scheduler behavior here, although the ring thread
> > > itself goes to sleep soon enough. Application gets still quite often
> > > re-scheduled to another core. Without wake-on-same core behavior is
> > > even worse and it jumps across all the time. Not good for CPU cache...
> > 
> > Maybe this is a lack of my understanding of scheduler internals,  but
> > I'm having a hard time seeing what the benefit of
> > wake_up_on_current_cpu() is over wake_up() for the queue-per-core
> > case.
> > 
> > As I understand it, with wake_up() the scheduler already will try to
> > wake up the thread and put it back on the same core to maintain cache
> > locality, which in this case is the same core
> > "wake_up_on_current_cpu()" is trying to put it on. If there's too much
> > load imbalance then regardless of whether you call wake_up() or
> > wake_up_on_current_cpu(), the scheduler will migrate the task to
> > whatever other core is better for it.
> > 
> > So I guess the main benefit of calling wake_up_on_current_cpu() over
> > wake_up() is that for situations where there is only some but not too
> > much load imbalance we force the application to run on the current
> > core even despite the scheduler thinking it's better for overall
> > system health to distribute the load? I don't see an issue if the
> > application thread runs very briefly but it seems more likely that the
> > application thread could be work intensive in which case it seems like
> > the thread would get migrated anyways or lead to more latency in the
> > long term with trying to compete on an overloaded core?
> 
> So the scheduler will try and wake on the previous CPU, but if that CPU
> is not idle it will look for any non-idle CPU in the same L3 and very

Typing hard: s/non-//

> aggressively move tasks around.
> 
> Notably if Task-A is waking Task-B, and Task-A is running on CPU-1 and
> Task-B was previously running on CPU-1, then the wakeup will see CPU-1
> is not idle (it is running Task-A) and it will try and find another CPU
> in the same L3.
> 
> This is fine if Task-A continues running; however in the case where
> Task-A is going to sleep right after doing the wakeup, this is perhaps
> sub-optimal, CPU-1 will end up idle.
> 
> We have the WF_SYNC (wake-flag) that tries to indicate this latter case;
> trouble is, it often gets used where it should not be, it is unreliable.
> Therefore it not a strong hint.
> 
> Then we 'recently' grew WF_CURRENT_CPU, that forces the wakeup to the
> same CPU. If you abuse, you keep pieces :-)
> 
> So it all depends a bit on the workload, machine and situation.
> 
> Some machines L3 is fine, some machines L3 has exclusive L2 and it hurts
> more to move tasks. Some workloads don't fit L2 so it doesn't matter
> anyway. TL;DR is we need this damn crystal ball instruction :-)

