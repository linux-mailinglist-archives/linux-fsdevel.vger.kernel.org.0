Return-Path: <linux-fsdevel+bounces-10346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1291884A23B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 19:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913771F22D2C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 18:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F60D482C9;
	Mon,  5 Feb 2024 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZEYJAhpS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FB481B3
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157561; cv=none; b=WejxzykQjsNFQjO3MjuNSHgXjgvA7w1/bi6GKLq32L+YR14gdacJko+JeoSGRS/79hUZ07cqdPJn1SUU2NbC2CMMCQs501QIdHSdHw1YeuEda2nUXptccthZvg5HEKrPutcsIkPYWRAy+s+tvxGaXcrFb8RfkDS3cTp3hGF2eqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157561; c=relaxed/simple;
	bh=OhVjfgQ6ypsXAl4aTp6y2RSd+qg4DOU5DAB4K9X8HUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2FFzBQsIsbiUw2H+KysS0pPTQFhg+ciTG/ummuI9M9lzatm1lViFmoL2AbxZlDuxsnU7OYgtxDdlk+6QXwajEKh7pXvMeH3O1NYoDHLC6k/qgD0L2e57Sxjyc4T//IuTxUGAaFj8xcF/JA18SR58bZjk9k7KvUia8NmTKrJuRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZEYJAhpS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d746ce7d13so38664565ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 10:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707157559; x=1707762359; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YYhJmNwACs7xWzxaru2OLoYfAu9N74lwcPjzUDB+xg=;
        b=ZEYJAhpSf25DJNLMudbcAfzw1CZQMJLzK/SqywQ5irB9Sq2jplxCSBCbNAxBwS+Txn
         0L7nwuaesxFlBH0w6dg1Sgv904eVAU3pbZtPqeAE1fuHmxWkP4x3w9iC7mI7SgKqiL0P
         N1c+a55ibd5Orfi5+g50OkgB/c/mIxdCx5Ftg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157559; x=1707762359;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YYhJmNwACs7xWzxaru2OLoYfAu9N74lwcPjzUDB+xg=;
        b=TRZf1m+TZ5TfgyEJdIRzcNPJZW1A0DNOg4/kcSZ65Ek0EtY/JMgyLFwJc4OA1MkU3t
         vedHI9S2jdT2ByazeYVyg6Xlxvirj1Q19D3z1UHiPwTCQQ03shPKjMvTSf/Op73/cUnl
         5t9DIzt6Rnq8EB2KMgG6hsouKX8y5bbxYAqg4DeGJeWe/uV5NElKVLXIbYKrCjJkJDCo
         pyXzCQYfZt2U+SDwktanaM6F42QYQAX08UFd7gtrai2njpL8V0Bd67bcWYMiXVuCBKPe
         fM2CvTGflyPSC3t4QfXjVK3R2dkiPeNXFM826vlCFPRhQKczBkFH96eSehz5Pj3UOxGL
         y/Qw==
X-Gm-Message-State: AOJu0YxCwx/l+AJRpfZwMLdc5g9tK0terNRe1c5u4Vj0VDcAL0pRKYJC
	yl7l37ls9iP5DjMMOAlDPJu9aqGEjkuQ808PjXIO3KJ2m1cqDSEFVIlPt5PeBmM=
X-Google-Smtp-Source: AGHT+IGZSu01SCfpuVAoKxEEGhseye5jcYZ2OTQbBwLSosCOhrRB2L0bvS8C7HVgC2MzoPFWHatu+Q==
X-Received: by 2002:a17:902:6f16:b0:1d9:742b:fedd with SMTP id w22-20020a1709026f1600b001d9742bfeddmr388747plk.34.1707157558764;
        Mon, 05 Feb 2024 10:25:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbE7iGxVCPUBH4KvD0r1Rt49gMPSuQYHBQM6KluyR+1rAgHNElceTU1aObRosTlZRh1FwTv1OVSOIf5VGTjAwMhd8Xt2ohpeA+TlBhB25QhdhzTGBdE3ky5Ly2mQFPUURjnLLXpkP7V0yvChDB3MHjgqdb95/LIxNcHrt3OPWTXCSy1W8i1mP2JAETIcueqC1VCOhWPZUjKJlAfeYpMcsRgwqmeW/AIqBe2Ll/QP8ytuhKCvwSk8zJVNm2rMXjBS7v4r2WCPZw9dPf4XXIwg1wQHfPe1mozEAE1ZyTliyzm4tbIDfCZbZQZTYE/sDVy8ZcfcMOe5hCYpNtqjaK70F6w16d3Y1cQsjnGz7pwSTQS97sPVP9HJW5NbUIyIed5uExBAzifS8OSNOShYXISKThexfg5lqTXlALwMxkIgeZdFlfrI+YbM7GE3tE/EfeEvGkoKk4MIrk0dy+qxGTkwcIgG+b4mk0Qvjmwk1Ic/Ij1hLRr1BHlAs9hb4mBBJ3Gvd70gcpQehyK2WeY6yr/Veo52kvsaNLIvPGn2vG5EI=
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id iy15-20020a170903130f00b001d8f3c7fb96sm170642plb.166.2024.02.05.10.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:25:58 -0800 (PST)
Date: Mon, 5 Feb 2024 10:25:55 -0800
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: chuck.lever@oracle.com, jlayton@kernel.org, linux-api@vger.kernel.org,
	brauner@kernel.org, edumazet@google.com, davem@davemloft.net,
	alexander.duyck@gmail.com, sridhar.samudrala@intel.com,
	kuba@kernel.org, willemdebruijn.kernel@gmail.com, weiwan@google.com,
	David.Laight@ACULAB.COM, arnd@arndb.de,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/3] eventpoll: support busy poll per epoll
 instance
Message-ID: <20240205182555.GA10463@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
 <20240131180811.23566-2-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131180811.23566-2-jdamato@fastly.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Jan 31, 2024 at 06:08:03PM +0000, Joe Damato wrote:
> Allow busy polling on a per-epoll context basis. The per-epoll context
> usec timeout value is preferred, but the pre-existing system wide sysctl
> value is still supported if it specified.
> 
> Note that this change uses an xor: either per epoll instance busy polling
> is enabled on the epoll instance or system wide epoll is enabled. Enabling
> both is disallowed.

I just realized that I updated the code below to use a an or (||) instead
of xor (^), but forgot to update the commit message.

I can fix this and send a v6.

> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  fs/eventpoll.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 3534d36a1474..ce75189d46df 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -227,6 +227,8 @@ struct eventpoll {
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>  	/* used to track busy poll napi_id */
>  	unsigned int napi_id;
> +	/* busy poll timeout */
> +	u64 busy_poll_usecs;
>  #endif
>  
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> @@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventpoll *ep)
>  		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
>  }
>  
> +/**
> + * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
> + * from the epoll instance ep is preferred, but if it is not set fallback to
> + * the system-wide global via busy_loop_timeout.
> + *
> + * @start_time: The start time used to compute the remaining time until timeout.
> + * @ep: Pointer to the eventpoll context.
> + *
> + * Return: true if the timeout has expired, false otherwise.
> + */
> +static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
> +{
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
> +
> +	if (bp_usec) {
> +		unsigned long end_time = start_time + bp_usec;
> +		unsigned long now = busy_loop_current_time();
> +
> +		return time_after(now, end_time);
> +	} else {
> +		return busy_loop_timeout(start_time);
> +	}
> +#endif
> +	return true;
> +}
> +
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> +static bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +	return !!ep->busy_poll_usecs || net_busy_loop_on();
> +}
> +
>  static bool ep_busy_loop_end(void *p, unsigned long start_time)
>  {
>  	struct eventpoll *ep = p;
>  
> -	return ep_events_available(ep) || busy_loop_timeout(start_time);
> +	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
>  }
>  
>  /*
> @@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
>  {
>  	unsigned int napi_id = READ_ONCE(ep->napi_id);
>  
> -	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
> +	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
>  		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
>  			       BUSY_POLL_BUDGET);
>  		if (ep_events_available(ep))
> @@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  	struct socket *sock;
>  	struct sock *sk;
>  
> -	if (!net_busy_loop_on())
> +	ep = epi->ep;
> +	if (!ep_busy_loop_on(ep))
>  		return;
>  
>  	sock = sock_from_file(epi->ffd.file);
> @@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  		return;
>  
>  	napi_id = READ_ONCE(sk->sk_napi_id);
> -	ep = epi->ep;
>  
>  	/* Non-NAPI IDs can be rejected
>  	 *	or
> @@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
>  {
>  }
>  
> +static inline bool ep_busy_loop_on(struct eventpoll *ep)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_NET_RX_BUSY_POLL */
>  
>  /*
> @@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
>  		error = PTR_ERR(file);
>  		goto out_free_fd;
>  	}
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	ep->busy_poll_usecs = 0;
> +#endif
>  	ep->file = file;
>  	fd_install(fd, file);
>  	return fd;
> -- 
> 2.25.1
> 

