Return-Path: <linux-fsdevel+bounces-47449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC98A9DABA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 14:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881F83AEA32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F33256C95;
	Sat, 26 Apr 2025 12:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ck1xjdwm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8536B256C77;
	Sat, 26 Apr 2025 12:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745670560; cv=none; b=UiQMdfTpBONQXGf4usGsLHmrSug9m+LjPTPPWNXUQMvkkE1ryhfLzDL9xu1+srimxpJcvXMtGa+Qpmb5vv0XhpJjPScPYKqiRTQUKilu1pL7b/jK805RFVUfAO/DOpgjOwXYg2JjZNb3nYsE5UUW4i/aDl2roRtvoTfJ/vBrCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745670560; c=relaxed/simple;
	bh=KR+rfuw8H//rMIq7kpzvnAJPweissT+mX1RMC6mTrso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOVoUomD2mkjHg1P3sjge40nPMN59oP/3J4zwmp0p9gcPkiuPWRF3zuFkZcTL14T6BaBS4TEVr01qeofZU+3XlvgGM81nl2Vb3FTOCgjKxaEcmEC/a0ev9mtjG5KMU6Ps+rCX5USc3sEf4ItXSwuIX/B85aPViDUdA81WFwILy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ck1xjdwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53490C4CEE2;
	Sat, 26 Apr 2025 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745670560;
	bh=KR+rfuw8H//rMIq7kpzvnAJPweissT+mX1RMC6mTrso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck1xjdwm3NiB03q7WeQHdfrtGxmlWGUvUDhPpClLGoWvsPkWnI+c60xzDYNjff7P2
	 1nSLwGgomrcjjJBbNXpRLQwYmr6gxazNdqu18NYlCGdxvE3ww+aNgvHHrIrhtTz5b4
	 IQumcCn+Ssr0KHBGOaawgUyPpCWjLIauLJv9IlR4LEvHoFRUIyOg/7Awd0MiqZyIF5
	 lt4AmGEJ5uwIGV3puw8kDQeFpj1RvVLP+2vuA3ytvN5BK3SbJEbrRUlpNc/sLPzgxI
	 SF1vpeCbJGjBrOUPb1vglz8AgiC4Auwm93cVu7pWnXsa+Ww03aHWk7rBdJGE4QXH/9
	 +/BM3fGBmF3Hw==
Date: Sat, 26 Apr 2025 14:29:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Alexander Duyck <alexander.h.duyck@intel.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <20250426-haben-redeverbot-0b58878ac722@brauner>
References: <20250416185826.26375-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416185826.26375-1-jdamato@fastly.com>

On Wed, Apr 16, 2025 at 06:58:25PM +0000, Joe Damato wrote:
> Avoid an edge case where epoll_wait arms a timer and calls schedule()
> even if the timer will expire immediately.
> 
> For example: if the user has specified an epoll busy poll usecs which is
> equal or larger than the epoll_wait/epoll_pwait2 timeout, it is
> unnecessary to call schedule_hrtimeout_range; the busy poll usecs have
> consumed the entire timeout duration so it is unnecessary to induce
> scheduling latency by calling schedule() (via schedule_hrtimeout_range).
> 
> This can be measured using a simple bpftrace script:
> 
> tracepoint:sched:sched_switch
> / args->prev_pid == $1 /
> {
>   print(kstack());
>   print(ustack());
> }
> 
> Before this patch is applied:
> 
>   Testing an epoll_wait app with busy poll usecs set to 1000, and
>   epoll_wait timeout set to 1ms using the script above shows:
> 
>      __traceiter_sched_switch+69
>      __schedule+1495
>      schedule+32
>      schedule_hrtimeout_range+159
>      do_epoll_wait+1424
>      __x64_sys_epoll_wait+97
>      do_syscall_64+95
>      entry_SYSCALL_64_after_hwframe+118
> 
>      epoll_wait+82
> 
>   Which is unexpected; the busy poll usecs should have consumed the
>   entire timeout and there should be no reason to arm a timer.
> 
> After this patch is applied: the same test scenario does not generate a
> call to schedule() in the above edge case. If the busy poll usecs are
> reduced (for example usecs: 100, epoll_wait timeout 1ms) the timer is
> armed as expected.
> 
> Fixes: bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket fds.")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
>  v2: 
>    - No longer an RFC and rebased on vfs/vfs.fixes
>    - Added Jan's Reviewed-by
>    - Added Fixes tag
>    - No functional changes from the RFC
> 
>  rfcv1: https://lore.kernel.org/linux-fsdevel/20250415184346.39229-1-jdamato@fastly.com/
> 
>  fs/eventpoll.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 100376863a44..4bc264b854c4 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1996,6 +1996,14 @@ static int ep_try_send_events(struct eventpoll *ep,
>  	return res;
>  }
>  
> +static int ep_schedule_timeout(ktime_t *to)
> +{
> +	if (to)
> +		return ktime_after(*to, ktime_get());
> +	else
> +		return 1;
> +}
> +
>  /**
>   * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
>   *           event buffer.
> @@ -2103,7 +2111,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  
>  		write_unlock_irq(&ep->lock);
>  
> -		if (!eavail)
> +		if (!eavail && ep_schedule_timeout(to))
>  			timed_out = !schedule_hrtimeout_range(to, slack,
>  							      HRTIMER_MODE_ABS);

Isn't this buggy? If @to is non-NULL and ep_schedule_timeout() returns
false you want to set timed_out to 1 to break the wait. Otherwise you
hang, no?

