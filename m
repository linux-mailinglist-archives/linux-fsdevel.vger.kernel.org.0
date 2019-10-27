Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34441E63DD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Oct 2019 16:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfJ0P5p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Oct 2019 11:57:45 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:35088 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbfJ0P5p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Oct 2019 11:57:45 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id A05BE2E14B0;
        Sun, 27 Oct 2019 18:57:37 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id jFZ2U9DQrz-valO9vDm;
        Sun, 27 Oct 2019 18:57:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572191857; bh=Rslfl7ijgIi+FGL5+iRdcB0DOAl315/Jt883QYZO0SY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=DYiuVW5ebbAfRNtlxJ2oHjbE5seAbUn105pej0Rq7+mthX/FkxsnMX/mSUR5Adjvc
         ji5Dfa/VV0Rtoo8n2z9MFxcqXGVV4q1Vqo6C8sXqDD19poeLJbfpqZcQDHmGN/K5rh
         1TL61Q53FkqWYgaLVcYHVGNk1jNdZo4x0l6ZEjmc=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7710::1:0])
        by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id 2orbSKLdUT-vaV0HXU7;
        Sun, 27 Oct 2019 18:57:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [RFC PATCH 07/10] pipe: Conditionalise wakeup in pipe_read() [ver
 #2]
To:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <fe167a90-1503-7ca2-4150-eeffd5cb1378@yandex-team.ru>
Date:   Sun, 27 Oct 2019 18:57:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <157186189069.3995.10292601951655075484.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/10/2019 23.18, David Howells wrote:
> Only do a wakeup in pipe_read() if we made space in a completely full
> buffer.  The producer shouldn't be waiting on pipe->wait otherwise.

We could go further and wakeup writer only when at least half of buffer is empty.
This gives better batching and reduces rate of context switches.

https://lore.kernel.org/lkml/157219118016.7078.16223055699799396042.stgit@buzz/T/#u

> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>   fs/pipe.c |   15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 1274305772fb..e3a8f10750c9 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -327,11 +327,13 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   				spin_lock_irq(&pipe->wait.lock);
>   				tail++;
>   				pipe_commit_read(pipe, tail);
> -				do_wakeup = 0;
> -				wake_up_interruptible_sync_poll_locked(
> -					&pipe->wait, EPOLLOUT | EPOLLWRNORM);
> +				do_wakeup = 1;
> +				if (head - (tail - 1) == pipe->max_usage)
> +					wake_up_interruptible_sync_poll_locked(
> +						&pipe->wait, EPOLLOUT | EPOLLWRNORM);
>   				spin_unlock_irq(&pipe->wait.lock);
> -				kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> +				if (head - (tail - 1) == pipe->max_usage)
> +					kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
>   			}
>   			total_len -= chars;
>   			if (!total_len)
> @@ -360,11 +362,6 @@ pipe_read(struct kiocb *iocb, struct iov_iter *to)
>   				ret = -ERESTARTSYS;
>   			break;
>   		}
> -		if (do_wakeup) {
> -			wake_up_interruptible_sync_poll(&pipe->wait, EPOLLOUT | EPOLLWRNORM);
> - 			kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> -			do_wakeup = 0;
> -		}
>   		pipe_wait(pipe);
>   	}
>   	__pipe_unlock(pipe);
> 
> 

