Return-Path: <linux-fsdevel+bounces-54605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 142B4B0188E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E06697B744E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E3823535C;
	Fri, 11 Jul 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt9U/94y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C49235355;
	Fri, 11 Jul 2025 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227075; cv=none; b=tZUv1syT8ZB6K+86KyGCWghY7Bl6paLB5O5NFcINjbpeuD7IwoN0DtG7DAVIRjXwKi1lvxvN8XXyIg7SxRetEA/lA802CoZSAq82xrpSG7K4/xQaC94bfyaMJ+H6gIdBdgTTBv6niyJB8GMesiURoYGdWJWdABrP+QDzK9BuBzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227075; c=relaxed/simple;
	bh=dDLsw2QWBJMqk3U+NXhrdQfOWLfZ0NvzXCSorxrMkWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFROXKJ/NGhH2CGQODjbbx7aZX56DHeTAehIbsWu75e+RHGbvXC6mJMTas/tbjvSUQ6jKnQqhCAE/yWhUJiXSz7EhK//5P5wK9OfIARLwOCypcCcGy2hSK372TBtFue3bKpjErwfwtIKSCxYxgGdhBRDdyjyrc05mR2sOqnUdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gt9U/94y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A3C4CEED;
	Fri, 11 Jul 2025 09:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752227074;
	bh=dDLsw2QWBJMqk3U+NXhrdQfOWLfZ0NvzXCSorxrMkWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt9U/94y3LYlQ0Eh5PRqpE7c4ypYCc94a3ARqLdePcdDycdpe9tlZJgFledWnMal4
	 kTMxOv/qTj8SDAkGa0oT9kRtbN0MO8h9yCnYuE9EpwcfDli9mgF0qYF5QPF1ayQyEn
	 otizuj4120vubhUVyZF5KgNsv8Zw49mNc4oZ2ipYz6kD5kofrlt81dMey02R+bGqGR
	 4F9XVZH69gMgIY1oXa+/qeMhnsBpUSEacfU4L8uf3ceBT8P8Vi22rs7B9jvRSN42gf
	 QPyOq6MDXYa6OAvBkwsq5miUFj5hMZLbaYxsDoL2h62EJxDJuTxEWo75CZwBzVgRq0
	 YZN7oufDGjHrA==
Date: Fri, 11 Jul 2025 11:44:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
Message-ID: <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
References: <20250701-wochen-bespannt-33e745d23ff6@brauner>
 <cda3b07998b39b7d46f10394c232b01a778d07a9.camel@xry111.site>
 <20250710034805.4FtG7AHC@linutronix.de>
 <20250710040607.GdzUE7A0@linutronix.de>
 <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de>
 <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de>
 <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250711050217.OMtx7Cz6@linutronix.de>

On Fri, Jul 11, 2025 at 07:02:17AM +0200, Nam Cao wrote:
> On Thu, Jul 10, 2025 at 05:47:57PM +0800, Xi Ruoyao wrote:
> > It didn't work :(.
> 
> Argh :(
> 
> Another possibility is that you are running into event starvation problem.
> 
> Can you give the below patch a try? It is not the real fix, the patch hurts
> performance badly. But if starvation is really your problem, it should
> ameliorate the situation:
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 895256cd2786..0dcf8e18de0d 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1764,6 +1764,8 @@ static int ep_send_events(struct eventpoll *ep,
>  		__llist_add(n, &txlist);
>  	}
>  
> +	struct llist_node *shuffle = llist_del_all(&ep->rdllist);
> +
>  	llist_for_each_entry_safe(epi, tmp, txlist.first, rdllink) {
>  		init_llist_node(&epi->rdllink);
>  
> @@ -1778,6 +1780,13 @@ static int ep_send_events(struct eventpoll *ep,
>  		}
>  	}
>  
> +	if (shuffle) {
> +		struct llist_node *last = shuffle;
> +		while (last->next)
> +			last = last->next;
> +		llist_add_batch(shuffle, last, &ep->rdllist);
> +	}
> +
>  	__pm_relax(ep->ws);
>  	mutex_unlock(&ep->mtx);
>  

I think we should revert the fix so we have time to fix it properly
during v6.17+. This patch was a bit too adventurous for a fix in the
first place tbh.

