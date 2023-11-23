Return-Path: <linux-fsdevel+bounces-3555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B500B7F65A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 18:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E60411C20EA3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C99405F7;
	Thu, 23 Nov 2023 17:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRshLENg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D8C3FB2B
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Nov 2023 17:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14110C433D9;
	Thu, 23 Nov 2023 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700761205;
	bh=O9W6/GX6YEbHEjBdyX568Y7GKhj2VDUTeGTyhBOEuiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRshLENg0OhwIa7EuXgjOFUR0TLSauxJDN9FdI0dxz6H5uCFTe3w9jcLveyMMgExg
	 BtWWR7DS2t0/I3aXymNEtaicJSrhb8k8iu+641Aa0BekwbxHUH0JIhLexX2Cgpu9LB
	 8xqnuhr/7EYk8itKbKj1pLxqjin678xhUfBz8rNwhHIAA+fYDMyIGGc2dcs+Q4YJBp
	 a1+uksx/lK8ziBIzLOSkXDzeOvVql6Tvpsg+Sy+FKHnDxeZthw2LTG8EhIjvIA5NLe
	 M0TA1IPIhHp6wF3DGDWVybjwzJYOzjai3dZVKxkX7lsTd3vLfGQK3rrs/JjOCNa4e+
	 e07Q5WXa7OnWA==
Date: Thu, 23 Nov 2023 18:40:01 +0100
From: Christian Brauner <brauner@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-aio@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: obey min_nr when doing wakeups
Message-ID: <20231123-jazzfest-gesund-3105db71afca@brauner>
References: <20231122234257.179390-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231122234257.179390-1-kent.overstreet@linux.dev>

On Wed, Nov 22, 2023 at 06:42:53PM -0500, Kent Overstreet wrote:
> Unclear who's maintaining fs/aio.c these days - who wants to take this?
> -- >8 --
> 
> I've been observing workloads where IPIs due to wakeups in
> aio_complete() are ~15% of total CPU time in the profile. Most of those
> wakeups are unnecessary when completion batching is in use in
> io_getevents().
> 
> This plumbs min_nr through via the wait eventry, so that aio_complete()
> can avoid doing unnecessary wakeups.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Benjamin LaHaise <bcrl@kvack.org
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: linux-aio@kvack.org
> Cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/aio.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 56 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index f8589caef9c1..c69e7caacd1b 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1106,6 +1106,11 @@ static inline void iocb_destroy(struct aio_kiocb *iocb)
>  	kmem_cache_free(kiocb_cachep, iocb);
>  }
>  
> +struct aio_waiter {
> +	struct wait_queue_entry	w;
> +	size_t			min_nr;
> +};
> +
>  /* aio_complete
>   *	Called when the io request on the given iocb is complete.
>   */
> @@ -1114,7 +1119,7 @@ static void aio_complete(struct aio_kiocb *iocb)
>  	struct kioctx	*ctx = iocb->ki_ctx;
>  	struct aio_ring	*ring;
>  	struct io_event	*ev_page, *event;
> -	unsigned tail, pos, head;
> +	unsigned tail, pos, head, avail;
>  	unsigned long	flags;
>  
>  	/*
> @@ -1156,6 +1161,10 @@ static void aio_complete(struct aio_kiocb *iocb)
>  	ctx->completed_events++;
>  	if (ctx->completed_events > 1)
>  		refill_reqs_available(ctx, head, tail);
> +
> +	avail = tail > head
> +		? tail - head
> +		: tail + ctx->nr_events - head;
>  	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>  
>  	pr_debug("added to ring %p at [%u]\n", iocb, tail);
> @@ -1176,8 +1185,18 @@ static void aio_complete(struct aio_kiocb *iocb)
>  	 */
>  	smp_mb();
>  
> -	if (waitqueue_active(&ctx->wait))
> -		wake_up(&ctx->wait);
> +	if (waitqueue_active(&ctx->wait)) {
> +		struct aio_waiter *curr, *next;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&ctx->wait.lock, flags);
> +		list_for_each_entry_safe(curr, next, &ctx->wait.head, w.entry)
> +			if (avail >= curr->min_nr) {
> +				list_del_init_careful(&curr->w.entry);
> +				wake_up_process(curr->w.private);
> +			}
> +		spin_unlock_irqrestore(&ctx->wait.lock, flags);
> +	}
>  }
>  
>  static inline void iocb_put(struct aio_kiocb *iocb)
> @@ -1290,7 +1309,9 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  			struct io_event __user *event,
>  			ktime_t until)
>  {
> -	long ret = 0;
> +	struct hrtimer_sleeper	t;
> +	struct aio_waiter	w;
> +	long ret = 0, ret2 = 0;
>  
>  	/*
>  	 * Note that aio_read_events() is being called as the conditional - i.e.
> @@ -1306,12 +1327,37 @@ static long read_events(struct kioctx *ctx, long min_nr, long nr,
>  	 * the ringbuffer empty. So in practice we should be ok, but it's
>  	 * something to be aware of when touching this code.
>  	 */
> -	if (until == 0)
> -		aio_read_events(ctx, min_nr, nr, event, &ret);
> -	else
> -		wait_event_interruptible_hrtimeout(ctx->wait,
> -				aio_read_events(ctx, min_nr, nr, event, &ret),
> -				until);
> +	aio_read_events(ctx, min_nr, nr, event, &ret);
> +	if (until == 0 || ret < 0 || ret >= min_nr)
> +		return ret;
> +
> +	hrtimer_init_sleeper_on_stack(&t, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	if (until != KTIME_MAX) {
> +		hrtimer_set_expires_range_ns(&t.timer, until, current->timer_slack_ns);
> +		hrtimer_sleeper_start_expires(&t, HRTIMER_MODE_REL);
> +	}
> +
> +	init_wait(&w.w);
> +
> +	while (1) {
> +		unsigned long nr_got = ret;
> +
> +		w.min_nr = min_nr - ret;

Hm, can this underflow?

> +
> +		ret2 = prepare_to_wait_event(&ctx->wait, &w.w, TASK_INTERRUPTIBLE) ?:
> +			!t.task ? -ETIME : 0;

I'd like to avoid the nested ?: as that's rather hard to read.
I _think_ this is equivalent to:

if (!ret2 && !t.task)
	ret = -ETIME;

I can just fix this in-tree though. Did I parse that correctly?

> +
> +		if (aio_read_events(ctx, min_nr, nr, event, &ret) || ret2)
> +			break;
> +
> +		if (nr_got == ret)
> +			schedule();
> +	}
> +
> +	finish_wait(&ctx->wait, &w.w);
> +	hrtimer_cancel(&t.timer);
> +	destroy_hrtimer_on_stack(&t.timer);
> +
>  	return ret;
>  }
>  
> -- 
> 2.42.0
> 

