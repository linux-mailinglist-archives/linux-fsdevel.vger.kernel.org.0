Return-Path: <linux-fsdevel+bounces-49580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120A6ABF7D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 16:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5EE3A7C20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B61A5B86;
	Wed, 21 May 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqMwCyTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07042189513
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 14:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747837508; cv=none; b=VK+1Lk505K1mDOvz2wDyNvlQq8ptvMOT56DwyGLshkFgbM/GhgnixWls/kPbLSWle3tSwnTNTqmWljjOt/+U/SDx26CV5bpmEMlkhhYSxFLnNnwqR7Ir3K02yCT+SKve3oKfwYZuimdRwgYGXSet+3ULuH89LIOKg0S30D+2SlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747837508; c=relaxed/simple;
	bh=dGwumfjerIdNUT+ZWre17rwws9aXIHeRWCUz04oVeYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SATCFz8wwaTGHB2o6DyyvWHu/dIb0sNuLFYT3yRbusw9aTDyf+vW2+L0/8tS0LmDZASpH+8R1Ximgk8YdMpEjOhoxuOySrt0TlKD4ngyzcpm2350+7aIHGFblDJFG+XL5fwet0t4RfrYkekUoWK6G2VTbOzZAz5mzJLMd1znBn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OqMwCyTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747837505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgFUH6Mk2Tk3iZDN9fsX7d3b+mQtNEFvHxIiCpWP5nk=;
	b=OqMwCyTJjkDSp9GPYkPHvXHUFhfhni4dsK1EYsaE6C5Aqjf4NFXZuAEbvHAS7oeRcKqIpc
	Iw3jCngXlM8pDVc+3IR0U8dsG/oqMzlRSJ2reShGq5NWgFz4/+yb2J8TSC5HRYE0Cuhr8e
	DoxrOe1Uq6mJ1is9/7mVur9JW1Rn6gI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-IHj6ncQmMRGgnf60jAUGyg-1; Wed, 21 May 2025 10:25:04 -0400
X-MC-Unique: IHj6ncQmMRGgnf60jAUGyg-1
X-Mimecast-MFC-AGG-ID: IHj6ncQmMRGgnf60jAUGyg_1747837503
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a360d01518so4213178f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 07:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747837503; x=1748442303;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgFUH6Mk2Tk3iZDN9fsX7d3b+mQtNEFvHxIiCpWP5nk=;
        b=R6gVGQ+K6BqzOtPMCw/Hs7Si1T3CfsAhd5vW6hJABthb6JDvkZsLJTxG3CNV9nAYyk
         YgvRV2XIiWNE9C2ANVyvGMvbKDTLHUuiE+vGww8Jx21ZYvBYaBHC+nHVON4n0rMEwKAM
         +GZP9oPRE6z/NAMMPQaoN7l+cQ6+2kd67pbT+p1U0QldS2rUVK9quMteqHcTZ7T+RvhH
         d6esUntsCfXFxCBbj/PhxqR+7yYJm07ubJ17yaPt48RRkRE9Tkxb3GXJWT5bPhkb4B2E
         B8WBuYixdNTCqK7c7sFf4wkKkY5uVnrCq/6xWQ3QiFi0fI4yjQiWn3tiA4Yql4y7qH31
         R1iw==
X-Forwarded-Encrypted: i=1; AJvYcCWIz4uJ/o/Hzr5hVgT8FzVimLT/mGAniY7g3iE/vzFkcJN9SiwFydRjTz/3MPgin7dmZrF9sbYhB8m/lo9r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+PO6vNtWk6P2FUNTYflJd1WNouOvm5J+TcseDPvUCjUq6C0E
	ylEDhhOYYRhEPao94u3UuXzCcCWLftFDJGHa0ks6n6NZncj+wHorJfKbHAvGZQI7pPCCJG9atil
	dyk540O/yOTOCSOXsn/xZscrgY3arIEbLswQ8+XjQKGagFaUjI4w3TdbLSVMRwhJwRd8=
X-Gm-Gg: ASbGnctdpDs0Cjb2J3tz+vQcw/Zr+UbyoSizuPEWuQ4kMhSXfVuovqZ7LXTHLxVY/c+
	QtqObEOaASd2bFYSR1iCAkG9pdvEWCanr5/4kbrslgVfTio0zcc67d63woOQe5sRpDsfzc65uWj
	E8oM37CgTNsE/gp74ZEi3lcV6bZRAQyD7WJin3oOZB5ZBvnlxFU8JOzeQDgO877M5FDf5MD9wJh
	AICr2+es2xI7BBbHul9BicRvjMvc+REylS/iLrOUUhS/AtPLmyM3ol1q0EPwtE/VjCUvEXQVWCJ
	QzC8FfY4ubasj/uXgZSGt2CzgCSYRSbl4sp+YHxllFKi7eZj4pN8ocyxYRmBSSxqFD0iAuSw
X-Received: by 2002:a5d:6702:0:b0:3a3:62c0:ff2 with SMTP id ffacd0b85a97d-3a362c010eemr15257837f8f.55.1747837503049;
        Wed, 21 May 2025 07:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/QB/m/PaAE/NQF15UKfuoxKAy6eEZT5rwMLl3Ovj5Sqrsob4y4T/qN2qBBMxZXcSFJxkoRA==
X-Received: by 2002:a5d:6702:0:b0:3a3:62c0:ff2 with SMTP id ffacd0b85a97d-3a362c010eemr15257810f8f.55.1747837502559;
        Wed, 21 May 2025 07:25:02 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88978sm20266010f8f.65.2025.05.21.07.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:25:01 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 John Ogness <john.ogness@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, Joe Damato
 <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe
 <axboe@kernel.dk>
Cc: Nam Cao <namcao@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH] eventpoll: Fix priority inversion problem
In-Reply-To: <20250519074016.3337326-1-namcao@linutronix.de>
References: <20250519074016.3337326-1-namcao@linutronix.de>
Date: Wed, 21 May 2025 16:25:00 +0200
Message-ID: <xhsmh8qmq9h37.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/05/25 09:40, Nam Cao wrote:
> @@ -136,14 +136,28 @@ struct epitem {
>               struct rcu_head rcu;
>       };
>
> -	/* List header used to link this structure to the eventpoll ready list */
> -	struct list_head rdllink;
> +	/*
> +	 * Whether this item can be added to the eventpoll ready list. Adding to the list can be
> +	 * blocked for two reasons:
> +	 *
> +	 *  1. This item is already on the list.
> +	 *  2. A waiter is consuming the ready list and has consumed this item. The waiter therefore
> +	 *     is blocking this item from being added again, preventing seeing the same item twice.
> +	 *     If adding is blocked due to this reason, the waiter will add this item to the list
> +	 *     once consuming is done.
> +	 */
> +	bool link_locked;

Nit: IIUC it's not just the readylist, it's anytime the link is used
(e.g. to punt it on a txlist), so how about:

        /*
         * Whether epitem.rdllink is currently used in a list. When used, it
         * cannot be detached or inserted elsewhere.
         *
         * It may be in use for two reasons:
         *
         * 1. This item is on the eventpoll ready list
         * 2. This item is being consumed by a waiter and stashed on a temporary
         *    list. If adding is blocked due to this reason, the waiter will add
         *    this item to the list once consuming is done.
         */
         bool link_used;

>
>       /*
> -	 * Works together "struct eventpoll"->ovflist in keeping the
> -	 * single linked chain of items.
> +	 * Indicate whether this item is ready for consumption. All items on the ready list has this
> +	 * flag set. Item that should be on the ready list, but cannot be added because of
> +	 * link_locked (in other words, a waiter is consuming the ready list), also has this flag
> +	 * set. When a waiter is done consuming, the waiter will add ready items to the ready list.
>        */
> -	struct epitem *next;
> +	bool ready;
> +
> +	/* List header used to link this structure to the eventpoll ready list */
> +	struct llist_node rdllink;
>
>       /* The file descriptor information this item refers to */
>       struct epoll_filefd ffd;

> @@ -361,10 +368,27 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
>               (p1->file < p2->file ? -1 : p1->fd - p2->fd));
>  }
>
> -/* Tells us if the item is currently linked */
> -static inline int ep_is_linked(struct epitem *epi)
> +static void epitem_ready(struct epitem *epi)
>  {
> -	return !list_empty(&epi->rdllink);
> +	/*
> +	 * Mark it ready, just in case a waiter is blocking this item from going into the ready
> +	 * list. This will tell the waiter to add this item to the ready list, after the waiter is
> +	 * finished.
> +	 */
> +	xchg(&epi->ready, true);

Perhaps a stupid question, why use an xchg() for .ready and .link_locked
(excepted for that epitem_ready() cmpxchg()) writes when the return value
is always discarded? Wouldn't e.g. smp_store_release() suffice, considering
the reads are smp_load_acquire()?

> +
> +	/*
> +	 * If this item is not blocked, add it to the ready list. This item could be blocked for two
> +	 * reasons:
> +	 *
> +	 * 1. It is already on the ready list. Then nothing further is required.
> +	 * 2. A waiter is consuming the ready list, and has consumed this item. The waiter is now
> +	 *    blocking this item, so that this item won't be seen twice. In this case, the waiter
> +	 *    will add this item to the ready list after the waiter is finished.
> +	 */
> +	if (!cmpxchg(&epi->link_locked, false, true))
> +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> +
>  }
>
>  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)

> @@ -1924,19 +1874,39 @@ static int ep_send_events(struct eventpoll *ep,
>                        * Trigger mode, we need to insert back inside
>                        * the ready list, so that the next call to
>                        * epoll_wait() will check again the events
> -			 * availability. At this point, no one can insert
> -			 * into ep->rdllist besides us. The epoll_ctl()
> -			 * callers are locked out by
> -			 * ep_send_events() holding "mtx" and the
> -			 * poll callback will queue them in ep->ovflist.
> +			 * availability.
>                        */
> -			list_add_tail(&epi->rdllink, &ep->rdllist);
> +			xchg(&epi->ready, true);
> +		}
> +	}
> +
> +	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
> +		/*
> +		 * We are done iterating. Allow the items we took to be added back to the ready
> +		 * list.
> +		 */
> +		xchg(&epi->link_locked, false);
> +
> +		/*
> +		 * In the loop above, we may mark some items ready, and they should be added back.
> +		 *
> +		 * Additionally, someone else may also attempt to add the item to the ready list,
> +		 * but got blocked by us. Add those blocked items now.
> +		 */
> +		if (smp_load_acquire(&epi->ready)) {
>                       ep_pm_stay_awake(epi);
> +			epitem_ready(epi);
>               }

Isn't this missing a:

                list_del_init(&epi->rdllink);

AFAICT we're always going to overwrite that link when next marking the item
as ready, but I'd say it's best to exit this with a clean state. That would
have to be before the clearing of link_locked so it doesn't race with a
concurrent epitem_ready() call.

>       }
> -	ep_done_scan(ep, &txlist);
> +
> +	__pm_relax(ep->ws);
>       mutex_unlock(&ep->mtx);
>
> +	if (!llist_empty(&ep->rdllist)) {
> +		if (waitqueue_active(&ep->wq))
> +			wake_up(&ep->wq);
> +	}
> +
>       return res;
>  }
>


