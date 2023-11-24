Return-Path: <linux-fsdevel+bounces-3573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB277F69C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 01:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C63DB20CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 00:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E671B39E;
	Fri, 24 Nov 2023 00:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hgAuAymp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBA0D6C
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 16:24:33 -0800 (PST)
Date: Thu, 23 Nov 2023 19:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700785471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WSQSWkENNHXrr1vd8S2sz7OZma/XY3Oo3PCMS6hFtjI=;
	b=hgAuAympFxgPQIOYNaXA816El6fQZMXGPmkb9Bx/GN/ahhKbChQYxYRl0NEJSiDbOzzMAD
	RftSbRnrfXSn84zFcb2EPqycUCaDPfSBngQBGWFbcU4OxEeQKcUN2ck7wMLC7Ga8vA2T/H
	0yYOLy//hayS0QlP6jbnZ2ffHExApvw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
Message-ID: <20231124002428.iqwnjtrpgsi6iv6m@moria.home.lan>
References: <20231122234257.179390-1-kent.overstreet@linux.dev>
 <20231123-jazzfest-gesund-3105db71afca@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-jazzfest-gesund-3105db71afca@brauner>
X-Migadu-Flow: FLOW_OUT

On Thu, Nov 23, 2023 at 06:40:01PM +0100, Christian Brauner wrote:
> On Wed, Nov 22, 2023 at 06:42:53PM -0500, Kent Overstreet wrote:
> > Unclear who's maintaining fs/aio.c these days - who wants to take this?
> > -- >8 --
> > 
> > I've been observing workloads where IPIs due to wakeups in
> > aio_complete() are ~15% of total CPU time in the profile. Most of those
> > wakeups are unnecessary when completion batching is in use in
> > io_getevents().
> > 
> > This plumbs min_nr through via the wait eventry, so that aio_complete()
> > can avoid doing unnecessary wakeups.
> > 
> > Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> > Cc: Benjamin LaHaise <bcrl@kvack.org
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: linux-aio@kvack.org
> > Cc: linux-fsdevel@vger.kernel.org
> > ---
> >  fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---------
> >  1 file changed, 56 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/aio.c b/fs/aio.c
> > index f8589caef9c1..c69e7caacd1b 100644
> > --- a/fs/aio.c
> > +++ b/fs/aio.c
> > @@ -1106,6 +1106,11 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
> >  	kmem_cache_free(kiocb_cachep, iocb);
> >  }
> >  
> > +struct aio_waiter {
> > +	struct wait_queue_entry	w;
> > +	size_t			min_nr;
> > +};
> > +
> >  /* aio_complete
> >   *	Called when the io request on the given iocb is complete.
> >   */
> > @@ -1114,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *iocb)
> >  	struct kioctx	*ctx = iocb->ki_ctx;
> >  	struct aio_ring	*ring;
> >  	struct io_event	*ev_page, *event;
> > -	unsigned tail, pos, head;
> > +	unsigned tail, pos, head, avail;
> >  	unsigned long	flags;
> >  
> >  	/*
> > @@ -1156,6 +1161,10 @@ static void aio_complete(struct aio_kiocb *iocb)
> >  	ctx->completed_events++;
> >  	if (ctx->completed_events > 1)
> >  		refill_reqs_available(ctx, head, tail);
> > +
> > +	avail = tail > head
> > +		? tail - head
> > +		: tail + ctx->nr_events - head;
> >  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
> >  
> >  	pr_debug("added to ring %p at [%u]\n", iocb, tail);
> > @@ -1176,8 +1185,18 @@ static void aio_complete(struct aio_kiocb *iocb)
> >  	 */
> >  	smp_mb();
> >  
> > -	if (waitqueue_active(&ctx->wait))
> > -		wake_up(&ctx->wait);
> > +	if (waitqueue_active(&ctx->wait)) {
> > +		struct aio_waiter *curr, *next;
> > +		unsigned long flags;
> > +
> > +		spin_lock_irqsave(&ctx->wait.lock, flags);
> > +		list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
> > +			if (avail >= curr->min_nr) {
> > +				list_del_init_careful(&curr->w.entry);
> > +				wake_up_process(curr->w.private);
> > +			}
> > +		spin_unlock_irqrestore(&ctx->wait.lock, flags);
> > +	}
> >  }
> >  
> >  static inline void iocb_put(struct aio_kiocb *iocb)
> > @@ -1290,7 +1309,9 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
> >  			struct io_event __user *event,
> >  			ktime_t until)
> >  {
> > -	long ret = 0;
> > +	struct hrtimer_sleeper	t;
> > +	struct aio_waiter	w;
> > +	long ret = 0, ret2 = 0;
> >  
> >  	/*
> >  	 * Note that aio_read_events() is being called as the conditional - i.e.
> > @@ -1306,12 +1327,37 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
> >  	 * the ringbuffer empty. So in practice we should be ok, but it's
> >  	 * something to be aware of when touching this code.
> >  	 */
> > -	if (until == 0)
> > -		aio_read_events(ctx, min_nr, nr, event, &ret);
> > -	else
> > -		wait_event_interruptible_hrtimeout(ctx->wait,
> > -				aio_read_events(ctx, min_nr, nr, event, &ret),
> > -				until);
> > +	aio_read_events(ctx, min_nr, nr, event, &ret);
> > +	if (until == 0 || ret < 0 || ret >= min_nr)
> > +		return ret;
> > +
> > +	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > +	if (until != KTIME_MAX) {
> > +		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
> > +		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
> > +	}
> > +
> > +	init_wait(&w.w);
> > +
> > +	while (1) {
> > +		unsigned long nr_got = ret;
> > +
> > +		w.min_nr = min_nr - ret;
> 
> Hm, can this underflow?

No, because if ret >= min_nr aio_read_events() returned true, and we're
done.

> > +
> > +		ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE) ?:
> > +			!t.task ? -ETIME : 0;
> 
> I'd like to avoid the nested ?: as that's rather hard to read.
> I _think_ this is equivalent to:
> 
> if (!ret2 && !t.task)
> 	ret = -ETIME;
> 
> I can just fix this in-tree though. Did I parse that correctly?

You did, except it needs to be ret2 = -ETIME - we don't return that to
userspace.

