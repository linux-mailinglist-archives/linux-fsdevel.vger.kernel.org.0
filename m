Return-Path: <linux-fsdevel+bounces-17872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19E8B32D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 10:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47F9DB23E75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CA0146000;
	Fri, 26 Apr 2024 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8CR7bZd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA813E88C;
	Fri, 26 Apr 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714120284; cv=none; b=KvNFbWUtSImbwrAoZepKTryktb+Qtsv/MbkWsqABpJv5Mhb8bP6TJJXYWGbeK+/L95gP5WNlgi/8ZkQfy5+ec91DweEH8Z1L9sLnnvEFqIFmHLPJIsOpakJffNPEpScnoJu4fGPsIIF1RRsQRX1FbSft5q+tjPYvd/gKyGU67Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714120284; c=relaxed/simple;
	bh=RI6cTVQZZaTD23ckzea2ec0ulvYhFYsFCanXHhrpQ6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLvHQmoq7m8YoG+eT+ursuompvqgMQcbTisQTll8yGTGmbjPZAfKl2/ADNYNlnbSoj518JO0VaWpAiDJ6xbEkk10ILFg4F3mtQsGb/ez55ZCdqCgyVq6DWS+mWbrL4jAzIBGJ/QWjGNXUEQifXI2KNEg4HYZr01T95e+Hl3wozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8CR7bZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ABE8C4AF07;
	Fri, 26 Apr 2024 08:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714120283;
	bh=RI6cTVQZZaTD23ckzea2ec0ulvYhFYsFCanXHhrpQ6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8CR7bZdJONHfSN7GeLAQAOhlyDe4ak2UkDvkzV12KoTgOqXvAJx3+r21VMjz0v4s
	 NNeh4X3554/dTePTNYI03x9i4YcrsiLf8j3CA1Ekvus0z6QQLwBzCGOZmDFrQU4DUC
	 Rzi8bZpCATAIxM9BuVgIjT34U98lwO7tR1ybdu6SZYXfD4loLxPPkW+TXi5d+lbQfM
	 Yh4+DD3HIwzHNUsh6qTID9OtbUncHXr9RwW4hiMWTprAdAi++LLA4J+zJG6tcbQd7Y
	 yTYtxddNkoS0UnmEwyOB9tjHLGx3MK94U9jWfamWZNRrl51YlbciOQFOT+yoD4XTiO
	 tBf9ozXPt2Wbw==
Date: Fri, 26 Apr 2024 10:31:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: viro@zeniv.linux.org.uk, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, jack@suse.cz, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	bristot@redhat.com, vschneid@redhat.com, cmllamas@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	jing.xia@unisoc.com, xuewen.yan94@gmail.com, Xuewen Yan <xuewen.yan@unisoc.com>
Subject: Re: [RFC PATCH] epoll: Add synchronous wakeup support for
 ep_poll_callback
Message-ID: <20240426-zupfen-jahrzehnt-5be786bcdf04@brauner>
References: <20240426080548.8203-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426080548.8203-1-xuewen.yan@unisoc.com>

adding Eric

On Fri, Apr 26, 2024 at 04:05:48PM +0800, Xuewen Yan wrote:
> Now, the epoll only use wake_up() interface to wake up task.
> However, sometimes, there are epoll users which want to use
> the synchronous wakeup flag to hint the scheduler, such as
> Android binder driver.
> So add a wake_up_sync() define, and use the wake_up_sync()
> when the sync is true in ep_poll_callback().
> 
> Co-developed-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  fs/eventpoll.c       | 5 ++++-
>  include/linux/wait.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 882b89edc52a..9b815e0a1ac5 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -1336,7 +1336,10 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
>  				break;
>  			}
>  		}
> -		wake_up(&ep->wq);
> +		if (sync)
> +			wake_up_sync(&ep->wq);
> +		else
> +			wake_up(&ep->wq);
>  	}
>  	if (waitqueue_active(&ep->poll_wait))
>  		pwake++;
> diff --git a/include/linux/wait.h b/include/linux/wait.h
> index 8aa3372f21a0..2b322a9b88a2 100644
> --- a/include/linux/wait.h
> +++ b/include/linux/wait.h
> @@ -221,6 +221,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
>  #define wake_up_all(x)			__wake_up(x, TASK_NORMAL, 0, NULL)
>  #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
>  #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
> +#define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
>  
>  #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
>  #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
> -- 
> 2.25.1
> 

