Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B1B2B4A6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 17:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731195AbgKPQNJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 11:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729729AbgKPQNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:13:08 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D46C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 08:13:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so19247605wrr.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7fv7431mx4G8bgXu0nUWe59gIwPWLtxJAF3ECMn9vM=;
        b=B8uEI064pFhgy4k0JohyrKBE4+OKGmXPNoeo2NsZt8GEvIP/lQINbjDxAEp91NaVHF
         UFmCURWe9C9CnSsHbXKdVvMMQDwYso7nx9ruelsa6yX0iNJKP6wtDRWR8uaZjTok/1Qm
         nNTXyhhFPRWt7MIuFxvFEg9QXqDCw1MGHO+eG4hmeyY168sE1IP0mFdgUVgVfTI5G++m
         hymFjncWRtTEGTGY5RWjskIAk14OGXACxlbdm8xgYzee71guQRHiCXJ1CnnqodPPmFte
         vwziT6MaKRHI0QcwOaU8CFQHqSpv347uABC5eRweWRXMR59F65m28evwohRriL+CJc/E
         mFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7fv7431mx4G8bgXu0nUWe59gIwPWLtxJAF3ECMn9vM=;
        b=Z4qlmbIAhGS5NA9k/y6MGzXDgoP4gcZvpRWNY23JjQUV1rmb6Rc6HR53BtFjsH2gF8
         e/n3pXC5ae9DiBzj8LI1Cf/HzCKLYahUeDiLRLQFGpMnNMfKQiWd4KO5RLmLgahnjCk7
         WpLhv6d4dgc/ytznOQaE8OwA6RGbdv1e4OE87tSFGmcWGGaDmm+7b/vSXMdo1u+b79Xe
         OiKMlKvEE2IRSxyzcPjaFtWRPizhnKF1W6p29lYKX2MPMzVzE+iqdvSMVPCQhtdaZ0Km
         QqAlMVrbfgtoPkK8YOXfDWHMt6VsEzXMKZf7NJGZ03LJ7pAVlV4LicHF5z90cDnJn2Ay
         XTfQ==
X-Gm-Message-State: AOAM5301lvEK7TuGefL7BKg1mrMTlopwNSFyM/pqtrw29k/HDa8nw8yO
        ZPwX1q51KQBswrIJzreWBw6kwJieDC6NGO5sdHYqMjcSNNFH3fec
X-Google-Smtp-Source: ABdhPJxwE3V20xjgqHXPRr/htKj+YCO+jAEvXBQE1liRveeBGRcq6/E/9vl43ozSZjflkbUdpTGWDySqvS6ubLWnHZ4=
X-Received: by 2002:adf:e44f:: with SMTP id t15mr18829622wrm.380.1605543186866;
 Mon, 16 Nov 2020 08:13:06 -0800 (PST)
MIME-Version: 1.0
References: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20201116161001.1606608-1-willemdebruijn.kernel@gmail.com>
From:   Soheil Hassas Yeganeh <soheil@google.com>
Date:   Mon, 16 Nov 2020 11:12:30 -0500
Message-ID: <CACSApva7eyfYn=JXxMecB+X6PJ3=iTOWVxH3tQC-23HjhYHM-Q@mail.gmail.com>
Subject: Re: [PATCH v2] epoll: add nsec timeout support
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:10 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Add epoll_create1 flag EPOLL_NSTIMEO. When passed, this changes the
> interpretation of argument timeout in epoll_wait from msec to nsec.
>
> Use cases such as datacenter networking operate on timescales well
> below milliseconds. Shorter timeouts bounds their tail latency.
> The underlying hrtimer is already programmed with nsec resolution.
>
> Changes (v2):
>   - cast to s64: avoid overflow on 32-bit platforms (Shuo Chen)
>   - minor commit message rewording
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Acked-by: Soheil Hassas Yeganeh <soheil@google.com>

> ---
>
> Applies cleanly both to 5.10-rc4 and next-20201116.
> In next, nstimeout no longer fills padding with new field refs.
>
> Selftest for now at github. Can follow-up for kselftests.
> https://github.com/wdebruij/kerneltools/blob/master/tests/epoll_nstimeo.c
> ---
>  fs/eventpoll.c                 | 26 +++++++++++++++++++-------
>  include/uapi/linux/eventpoll.h |  1 +
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 4df61129566d..817d9cc5b8b8 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -225,6 +225,9 @@ struct eventpoll {
>         unsigned int napi_id;
>  #endif
>
> +       /* Accept timeout in ns resolution (EPOLL_NSTIMEO) */
> +       unsigned int nstimeout:1;
> +
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         /* tracks wakeup nests for lockdep validation */
>         u8 nests;
> @@ -1787,17 +1790,20 @@ static int ep_send_events(struct eventpoll *ep,
>         return esed.res;
>  }
>
> -static inline struct timespec64 ep_set_mstimeout(long ms)
> +static inline struct timespec64 ep_set_nstimeout(s64 ns)
>  {
> -       struct timespec64 now, ts = {
> -               .tv_sec = ms / MSEC_PER_SEC,
> -               .tv_nsec = NSEC_PER_MSEC * (ms % MSEC_PER_SEC),
> -       };
> +       struct timespec64 now, ts;
>
> +       ts = ns_to_timespec64(ns);
>         ktime_get_ts64(&now);
>         return timespec64_add_safe(now, ts);
>  }
>
> +static inline struct timespec64 ep_set_mstimeout(long ms)
> +{
> +       return ep_set_nstimeout(ms * (s64)NSEC_PER_MSEC);
> +}
> +
>  /**
>   * ep_poll - Retrieves ready events, and delivers them to the caller supplied
>   *           event buffer.
> @@ -1826,7 +1832,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>         lockdep_assert_irqs_enabled();
>
>         if (timeout > 0) {
> -               struct timespec64 end_time = ep_set_mstimeout(timeout);
> +               struct timespec64 end_time;
> +
> +               end_time = ep->nstimeout ? ep_set_nstimeout(timeout) :
> +                                          ep_set_mstimeout(timeout);
>
>                 slack = select_estimate_accuracy(&end_time);
>                 to = &expires;
> @@ -2046,7 +2055,7 @@ static int do_epoll_create(int flags)
>         /* Check the EPOLL_* constant for consistency.  */
>         BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
>
> -       if (flags & ~EPOLL_CLOEXEC)
> +       if (flags & ~(EPOLL_CLOEXEC | EPOLL_NSTIMEO))
>                 return -EINVAL;
>         /*
>          * Create the internal data structure ("struct eventpoll").
> @@ -2054,6 +2063,9 @@ static int do_epoll_create(int flags)
>         error = ep_alloc(&ep);
>         if (error < 0)
>                 return error;
> +
> +       ep->nstimeout = !!(flags & EPOLL_NSTIMEO);
> +
>         /*
>          * Creates all the items needed to setup an eventpoll file. That is,
>          * a file structure and a free file descriptor.
> diff --git a/include/uapi/linux/eventpoll.h b/include/uapi/linux/eventpoll.h
> index 8a3432d0f0dc..f6ef9c9f8ac2 100644
> --- a/include/uapi/linux/eventpoll.h
> +++ b/include/uapi/linux/eventpoll.h
> @@ -21,6 +21,7 @@
>
>  /* Flags for epoll_create1.  */
>  #define EPOLL_CLOEXEC O_CLOEXEC
> +#define EPOLL_NSTIMEO 0x1
>
>  /* Valid opcodes to issue to sys_epoll_ctl() */
>  #define EPOLL_CTL_ADD 1
> --
> 2.29.2.299.gdc1121823c-goog
>
