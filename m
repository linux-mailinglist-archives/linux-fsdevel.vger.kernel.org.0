Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4EED90034
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfHPKpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 06:45:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41996 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfHPKpt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:45:49 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyZjs-0007t3-3s; Fri, 16 Aug 2019 12:45:44 +0200
Date:   Fri, 16 Aug 2019 12:45:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arul Jeniston <arul.jeniston@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read
 function.
In-Reply-To: <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
References: <20190816083246.169312-1-arul.jeniston@gmail.com> <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Arul,

On Fri, 16 Aug 2019, Arul Jeniston wrote:

> Subject: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.

The prefix is not 'FS: timerfd:'

1) The usual prefix for fs/* is: 'fs:' but...

2) git log fs/timerfd.c gives you a pretty good hint for the proper
   prefix. Look at the commits which actually do functional changes to that
   file, not at those which do (sub)system wide cleanups/adjustments.

Also 'timerfd_read function' can be written as 'timerfd_read()' which
spares the redundant function and clearly marks it as function via the
brackets.

> 'hrtimer_forward_now()' returns zero due to bigger backward time drift.
> This causes timerfd_read to return 0. As per man page, read on timerfd
>  is not expected to return 0.
> This problem is well explained in https://lkml.org/lkml/2019/7/31/442

1) The explanation needs to be in the changelog itself. Links can point to
   discussions, bug-reports which have supplementary information.

2) Please do not use lkml.org links.

Again: Please read and follow Documentation/process/submitting-patches.rst 

> . This patch fixes this problem.
> Signed-off-by: Arul Jeniston <arul.jeniston@gmail.com>

Missing empty line before Signed-off-by. Please use git-log to see how
changelogs are properly formatted.

Also: 'This patch fixes this problem' is not helpful at all. Again see the
document I already pointed you to.

> ---
>  fs/timerfd.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/timerfd.c b/fs/timerfd.c
> index 6a6fc8aa1de7..f5094e070e9a 100644
> --- a/fs/timerfd.c
> +++ b/fs/timerfd.c
> @@ -284,8 +284,16 @@ static ssize_t timerfd_read(struct file *file,
> char __user *buf, size_t count,
>                                         &ctx->t.alarm, ctx->tintv) - 1;
>                                 alarm_restart(&ctx->t.alarm);
>                         } else {
> -                               ticks += hrtimer_forward_now(&ctx->t.tmr,
> -                                                            ctx->tintv) - 1;
> +                               u64 nooftimeo = hrtimer_forward_now(&ctx->t.tmr,
> +                                                                ctx->tintv);

nooftimeo is pretty non-intuitive. The function documentation of
hrtimer_forward_now() says:

      Returns the number of overruns.

So the obvious variable name is overruns, right?

> +                               /*
> +                                * ticks shouldn't become zero at this point.
> +                                * Ignore if hrtimer_forward_now returns 0
> +                                * due to larger backward time drift.

Again. This explanation does not make any sense at all.

Time does not go backwards, except if it is CLOCK_REALTIME which can be set
backwards via clock_settime() or settimeofday().

> +                                */
> +                               if (likely(nooftimeo)) {
> +                                       ticks += nooftimeo - 1;
> +                               }

Again: Pointless brackets.

If you disagree with my review comment, then tell me in a reply. If not,
then fix it. If you decide to ignore my comments, then don't wonder if I
ignore your patches.

Thanks,

	tglx
