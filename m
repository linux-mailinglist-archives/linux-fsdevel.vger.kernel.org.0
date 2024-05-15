Return-Path: <linux-fsdevel+bounces-19499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AC8C62EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F8BB281DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 08:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE684F1E2;
	Wed, 15 May 2024 08:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n+m36Pp6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8B22772A;
	Wed, 15 May 2024 08:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761972; cv=none; b=Ws22vvb/F8VzgdrBhWblXSL2wBKtycZ//YFOQJp3H94judmpHUjJU/LqgCrBIlhkorrmbl+ibbijR0oeMpMDT836o3hzPQeEbuNMLB6c5nd8FOsR4Due/IVHa9BERQuCgDMpmUBmdkNle81MDpYQP/v1nH5p/RFoGOOdcRUp8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761972; c=relaxed/simple;
	bh=UqgOYwdEvMOrn7Hx47ilkz/xoSWwwVwXT1kxEU/Szgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6rNW6hdFBMgA/pS6/o7dBnjSOMOsr4llP2Be49lWTwn39QkocKhWbKh0G9CRMg0YauHS6okwGR0uDR0d4ZBEFYH5kJVOxVFmLHyUFkTfPo4ZuH5ZFo13daUV5imWsHYtzYeVmzU0kJbhotwfXcx9UnKlXXCF3X+fK7Zs1s6bnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n+m36Pp6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QA0Z86REep+wCdmCQX+v/+bp3VyxCri5N4TpcnLcSGo=; b=n+m36Pp6kDfDmvRiAl/tSccNoX
	9Cvz89UOpGuItPpAgrSs+t73IUNKLAfPMAyNwTImb2yOI6BpOgzHKoaq0ckUYG0kZbNOZJRTmaLta
	fY6Vu+x/4qre2xlDxCzeZtVBHzfWxifGgUrDl4nAEkFYbdTtyoGgtNUfAQaek79N+9TuZl+4YQ861
	IcAQSoCCeiMwT3VsS8XuSB7JGrSTzZsf3LoFdNmqR/2vC1UYmvaA64LGywy83Xkxcs+vGzabh0il0
	T92WagyiD6Ugu/sc5YTuj5rIVaJtqB0hJCWe63k7ptUJfELMepm80C0OsWyPJRwgrhGXco02lgtfA
	1x5w5+DA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7A3y-0000000A7MR-2Lht;
	Wed, 15 May 2024 08:32:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29FBF30068B; Wed, 15 May 2024 10:32:38 +0200 (CEST)
Date: Wed, 15 May 2024 10:32:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Phil Auld <pauld@redhat.com>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] sched/rt: Clean up usage of rt_task()
Message-ID: <20240515083238.GA40213@noisy.programming.kicks-ass.net>
References: <20240514234112.792989-1-qyousef@layalina.io>
 <20240514235851.GA6845@lorien.usersys.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514235851.GA6845@lorien.usersys.redhat.com>

On Tue, May 14, 2024 at 07:58:51PM -0400, Phil Auld wrote:
> 
> Hi Qais,
> 
> On Wed, May 15, 2024 at 12:41:12AM +0100 Qais Yousef wrote:
> > rt_task() checks if a task has RT priority. But depends on your
> > dictionary, this could mean it belongs to RT class, or is a 'realtime'
> > task, which includes RT and DL classes.
> > 
> > Since this has caused some confusion already on discussion [1], it
> > seemed a clean up is due.
> > 
> > I define the usage of rt_task() to be tasks that belong to RT class.
> > Make sure that it returns true only for RT class and audit the users and
> > replace them with the new realtime_task() which returns true for RT and
> > DL classes - the old behavior. Introduce similar realtime_prio() to
> > create similar distinction to rt_prio() and update the users.
> 
> I think making the difference clear is good. However, I think rt_task() is
> a better name. We have dl_task() still.  And rt tasks are things managed
> by rt.c, basically. Not realtime.c :)  I know that doesn't work for deadline.c
> and dl_ but this change would be the reverse of that pattern.

It's going to be a mess either way around, but I think rt_task() and
dl_task() being distinct is more sensible than the current overlap.

> > Move MAX_DL_PRIO to prio.h so it can be used in the new definitions.
> > 
> > Document the functions to make it more obvious what is the difference
> > between them. PI-boosted tasks is a factor that must be taken into
> > account when choosing which function to use.
> > 
> > Rename task_is_realtime() to task_has_realtime_policy() as the old name
> > is confusing against the new realtime_task().

realtime_task_policy() perhaps?


