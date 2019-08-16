Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 366918FEA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 11:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfHPJFl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 05:05:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41759 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfHPJFl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 05:05:41 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyYAz-0005kn-OB; Fri, 16 Aug 2019 11:05:37 +0200
Date:   Fri, 16 Aug 2019 11:05:36 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     ARUL JENISTON MC <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: [Trimmed unreadable long subject line ]
In-Reply-To: <20190816083246.169312-1-arul.jeniston@gmail.com>
Message-ID: <alpine.DEB.2.21.1908161055310.1908@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arul,

On Fri, 16 Aug 2019, arul.jeniston@gmail.com wrote:

Please write the subject as a short precise sentence which fits into 70
characters and put the long explanation into the body, i.e. here.

See Documentation/process/submitting-patches.rst

> From: ARUL JENISTON MC <arul.jeniston@gmail.com>

This lacks a Signed-off-by

> ---
>  fs/timerfd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index 6a6fc8aa1de7..f5094e070e9a 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
>  					&ctx->t.alarm, ctx->tintv) - 1;
>  				alarm_restart(&ctx->t.alarm);
>  			} else {
> -				ticks += hrtimer_forward_now(&ctx->t.tmr,
> -							     ctx->tintv) - 1;
> +				u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
> +								 ctx->tintv);
> +				/*
> +				 * ticks shouldn't become zero at this point.
> +				 * Ignore if hrtimer_forward_now returns 0
> +				 * due to larger backward time drift.
> +				 */

What? Backward time drift? Can you please explain how this would happen?

> +				if (likely(nooftimeo)) {
> +					ticks += nooftimeo - 1;
> +				}

Pointless brackets.

Thanks,

	tglx
