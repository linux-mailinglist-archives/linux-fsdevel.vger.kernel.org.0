Return-Path: <linux-fsdevel+bounces-49777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA54AC250D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76214A7480
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2342951BA;
	Fri, 23 May 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ihlR58X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lcyVzjQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F32DCC0C;
	Fri, 23 May 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010698; cv=none; b=Y5BJ1cGDgpMsCb02K0TNtnG3UR8y+Jk7G3l/NQvIJKso21X/9ELu1IEgmYRer/+OBRzOx62cZNm4cLIZOXetiF1blkri8+JT3R6FPcQVWKlkR3qzSoQKlTGqeVQjsfISjvsayfRGJG594zmKBYS+Oelw1VEIG/uBmpDMyuYszMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010698; c=relaxed/simple;
	bh=F8AHXtmwckzlSUmmoc0BGi2VV71no0d0RwZD7r2sahA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o194Wc0rvbpzd1CwWnUzI5NhYKaFNzxbwzOC9iqFw/wxRspij30SFBTFi0d2fdO8+ffSt5uHCSoyMpB7kvBtCoM5UpaUMDYyQrMZlZ1Sog5/kWzmOOjp0TNnmMZx8/Lqk+XvjJgrhzUkc52V9U5/78TrIHlyysEwAomTShsr6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ihlR58X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lcyVzjQk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 23 May 2025 16:31:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748010694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEZ6N6/GF0ZchnaYLlsA8GRq22FznhGXk6veRassrhY=;
	b=4ihlR58X7u+FIL4yEadB/WP2vETM0c9pnq1Hl1akE8KY7Y/PXnw3AXEASUOQbcnaEupLN6
	IwkZLCQtdyJHa4q/r4qW6t2zHvn3LvF000Nuv0KbmrbhKN640VHTZ3+B9qVojyz7jbQbIl
	4guWTmqiT/t/gF4cxUozTGgPS54KHybNGABCzQTIEtbCF278035U3afRKFxYXClfwncV2v
	eTCDB/UipuUgVhrQkuYnoDBtPmMhEHSw7tMuAuD3852Owmi7xlByE7W2oVZ3PNxMOK+x10
	BRgVN+ahvnJmYy4SZnTg3UMsRjy1kqZAIfOeV+yjAdZjsPqHgBEcMVI6uavahg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748010694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEZ6N6/GF0ZchnaYLlsA8GRq22FznhGXk6veRassrhY=;
	b=lcyVzjQklrUcJISkGY4WIZyKTwWqR2KcBF0PqUERD7JZg0Lc/A/0e54TsHZahAoya9o/nI
	IB/9TxBVhUXaV8AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	John Ogness <john.ogness@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jens Axboe <axboe@kernel.dk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v2] eventpoll: Fix priority inversion problem
Message-ID: <20250523143132.i_YkS3R3@linutronix.de>
References: <20250523061104.3490066-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523061104.3490066-1-namcao@linutronix.de>

On 2025-05-23 08:11:04 [+0200], Nam Cao wrote:
> @@ -867,10 +837,25 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
>  
>  	rb_erase_cached(&epi->rbn, &ep->rbr);
>  
> -	write_lock_irq(&ep->lock);
> -	if (ep_is_linked(epi))
> -		list_del_init(&epi->rdllink);
> -	write_unlock_irq(&ep->lock);
> +	/*
> +	 * ep->mtx is held, which means no waiter is touching the ready list. This item is also no
> +	 * longer being added. Therefore, the ready flag can only mean one thing: this item is on
> +	 * the ready list.
> +	 */
> +	if (smp_load_acquire(&epi->ready)) {
> +		put_back_last = NULL;
> +		while (true) {
> +			struct llist_node *n = llist_del_first(&ep->rdllist);
> +
> +			if (&epi->rdllink == n || WARN_ON(!n))
> +				break;
> +			if (!put_back_last)
> +				put_back_last = n;
> +			llist_add(n, &put_back);

put_back is local, you cam use __llist_add()

You could llist_del_all() and then you could use the non-atomic
operations for the replacement. But you need to walk the whole list to
know the first and last for the batch.
the "wait" perf bench throws in "16320" items. Avoiding
llist_del_first() makes hardly a different to, worse, to slight
improvement. Since it is all random it depends when the atomic operation
outweighs  

The ctl case gets worse with this approach. On average it has to iterate
over 45% items to find the right item and it adds less than 200 items.
So the atomic does not outweigh the while iteration.

> +		}
> +		if (put_back_last)
> +			llist_add_batch(put_back.first, put_back_last, &ep->rdllist);
> +	}
>  
>  	wakeup_source_unregister(ep_wakeup_source(epi));
>  	/*
> @@ -1867,19 +1767,20 @@ static int ep_send_events(struct eventpoll *ep,
>  	init_poll_funcptr(&pt, NULL);
>  
>  	mutex_lock(&ep->mtx);
> -	ep_start_scan(ep, &txlist);
>  
> -	/*
> -	 * We can loop without lock because we are passed a task private list.
> -	 * Items cannot vanish during the loop we are holding ep->mtx.
> -	 */
> -	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
> +	while (res < maxevents) {
>  		struct wakeup_source *ws;
> +		struct llist_node *n;
>  		__poll_t revents;
>  
> -		if (res >= maxevents)
> +		n = llist_del_first(&ep->rdllist);
> +		if (!n)
>  			break;
>  
> +		epi = llist_entry(n, struct epitem, rdllink);
> +		llist_add(n, &txlist);

txlist is local, you can use __list_add()

> +		smp_store_release(&epi->ready, false);
> +
>  		/*
>  		 * Activate ep->ws before deactivating epi->ws to prevent
>  		 * triggering auto-suspend here (in case we reactive epi->ws

Sebastian

