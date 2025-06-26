Return-Path: <linux-fsdevel+bounces-53101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD2AEA295
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6DF1C61175
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 15:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56F72ED142;
	Thu, 26 Jun 2025 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eB4J+ntw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UqTz9nTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C69C2ECD12;
	Thu, 26 Jun 2025 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750951430; cv=none; b=O/g/i14jG3aXcgxI/04CX5+wRjhblqMqFJDSWEo92leiJJDyG5YETnnlfuQCZXXiuFsMbeq4gPFHAFeWdMzP2vIWl9MXQJvbgFswp/3ARCQLb5xMgbovgBjXhn/jQY+vTvw7Bd6l2qa36mbT7mSRDVZhUUOjUxe1X8WiAYOe5v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750951430; c=relaxed/simple;
	bh=VuhrQSogIfvNgLMSmClndkgcp/4HyaoB1qcUbwITc8g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WAR4BqicYfS79/Vh1ESjQ7g81AaiEtL7Gj+hur+EUU2NzK0qxUp0+STZlQ0mkdKBKpnubUsG4/UcftqwPFs8DvGuxaNk+kA8yqFJ2h03QFx85CWIWMuR06/AF/xjatcs9QXVwoPBSGKysu45ORNcvmDW4icjeNyxsgCg1UciIxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eB4J+ntw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UqTz9nTB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750951426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jL0tCZ3toSzGmOxjcnKOB+BJwR+ZZmNB0KXfY4YqPu4=;
	b=eB4J+ntwsXtlYXTGA/BDefnyOFp8VM5NHUL2QQz4uWrHRJGHSzjkjL/vKMRk2ljn5EbrWo
	RAql3jJxO8TdJ6z9+9Tv/jkGm90d/u8gXbovVKZ56Qgqy8dE73jCcH7G9v3OVOx1WJMf51
	ZYFTvlUP0lAtcfz01cno/SxDnFepEdQKlnNTo2GyccS8qczR9eTUX7eC1k0ioObmPv6rB7
	RyAgwp0SiqObuDKjH6IxlCteb9UaOHvp0Yh8ieijWiBmtFQym0fXI7gX6sZMnuXv+k0s0K
	fqjsix/N5CkFxhE4MpKIbpQab8NgabVGBZGnIPTvP3AW3E89MZt02g6YiSflYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750951426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jL0tCZ3toSzGmOxjcnKOB+BJwR+ZZmNB0KXfY4YqPu4=;
	b=UqTz9nTBsQRoHH9zENmAM29A6/H6Gsy8qqeEnflQxaSBLwKpMzbBfHYb1noTxk08TTTJ2L
	lmpbRx9G1CxVZKDA==
To: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan
 Kara <jack@suse.cz>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, Martin
 Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Cc: Nam Cao <namcao@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
In-Reply-To: <20250527090836.1290532-1-namcao@linutronix.de>
References: <20250527090836.1290532-1-namcao@linutronix.de>
Date: Thu, 26 Jun 2025 17:29:46 +0206
Message-ID: <841pr6msql.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-05-27, Nam Cao <namcao@linutronix.de> wrote:
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index d4dbffdedd08e..a97a771a459c9 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -137,13 +137,7 @@ struct epitem {
>  	};
>  
>  	/* List header used to link this structure to the eventpoll ready list */
> -	struct list_head rdllink;
> -
> -	/*
> -	 * Works together "struct eventpoll"->ovflist in keeping the
> -	 * single linked chain of items.
> -	 */
> -	struct epitem *next;
> +	struct llist_node rdllink;
>  
>  	/* The file descriptor information this item refers to */
>  	struct epoll_filefd ffd;
> @@ -191,22 +185,15 @@ struct eventpoll {
>  	/* Wait queue used by file->poll() */
>  	wait_queue_head_t poll_wait;
>  
> -	/* List of ready file descriptors */
> -	struct list_head rdllist;
> -
> -	/* Lock which protects rdllist and ovflist */
> -	rwlock_t lock;
> +	/*
> +	 * List of ready file descriptors. Adding to this list is lockless. Items can be removed
> +	 * only with eventpoll::mtx
> +	 */
> +	struct llist_head rdllist;
>  
>  	/* RB tree root used to store monitored fd structs */
>  	struct rb_root_cached rbr;
>  
> -	/*
> -	 * This is a single linked list that chains all the "struct epitem" that
> -	 * happened while transferring ready events to userspace w/out
> -	 * holding ->lock.
> -	 */
> -	struct epitem *ovflist;
> -
>  	/* wakeup_source used when ep_send_events or __ep_eventpoll_poll is running */
>  	struct wakeup_source *ws;
>  
> @@ -361,10 +348,14 @@ static inline int ep_cmp_ffd(struct epoll_filefd *p1,
>  	        (p1->file < p2->file ? -1 : p1->fd - p2->fd));
>  }
>  
> -/* Tells us if the item is currently linked */
> -static inline int ep_is_linked(struct epitem *epi)
> +/*
> + * Add the item to its container eventpoll's rdllist; do nothing if the item is already on rdllist.
> + */
> +static void epitem_ready(struct epitem *epi)
>  {
> -	return !list_empty(&epi->rdllink);
> +	if (&epi->rdllink == cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))

Perhaps:

	if (try_cmpxchg(&epi->rdllink.next, &epi->rdllink, NULL))

> +		llist_add(&epi->rdllink, &epi->ep->rdllist);
> +
>  }
>  
>  static inline struct eppoll_entry *ep_pwq_from_wait(wait_queue_entry_t *p)

John Ogness

