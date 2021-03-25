Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD63C349BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 22:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCYVvQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 17:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbhCYVux (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:50:53 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8798FC061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 14:50:44 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id q26so3383608qkm.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 14:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPDX5Uvos2ib1btitjeT/DSWvnYPpsVpIIBrEV7n3/w=;
        b=PzOKsYkvSBTrup8k68oKcP/7M5mr/IMYCggyr9Hm87+hGOn4uL95lVBiZBBTMOkXHT
         HvoPF6CNNcatwoKgem1fPZrwSAsRyOsgln2qBQzGjFFMdIt3pHGOP2OsBg/6EfWlN6Ja
         d9OUfAkVRzSkl7ABsAtFHIoonu2udIrkVOYeBO2zijSc5TjfkJLYcjoMuOv82TG7UVia
         CKdnKHs46LcMt2keeeFQeqvWcgvbk8nQhFOgqHAXMOV31h5j5LBjzvfNALECOOwnl8PF
         jk9myShHlWo3z4p3nwHUXt3yPfILtuSDw20e4sW3DtGoHOp12hw50vVRugbvXCdvU3kb
         VN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPDX5Uvos2ib1btitjeT/DSWvnYPpsVpIIBrEV7n3/w=;
        b=kLklJyLJfeWRLDDcnKsovHi467bHdkPGjJ/TnhFwQDOJ9m6D6PylQuE8uSzRPy/5dN
         lBiXx32Sx6d5oXRaRJO29uCSZVthOCJFKhV9k6TgPVK5R22ChfH+5GjQGtmTMMLqUBsS
         8b7olPaSXtoGtLONzSZ/K3lEctFo2eyDwrvvu9vCJJ4y7rz4LwDaUtGYlmas/c5BnpE9
         wt/KrOTxjH7XES4s0kjRKoX4gJVYFEHvu6eLlRV37NW3t98NUNRDn3hib1WtP9LCy7C6
         VEWu3QF/6v2c2amn2j+Q0t7spc5SMFtlqUzAPsuRHwlDX1upDdMl0+12amb5gEcSEToO
         AdMg==
X-Gm-Message-State: AOAM532+2OeoY1lcroQZH4j8W/+TQLOfZ4Q4sIAGbZAw50+V/eB19ob8
        wUpWwCXYHUzSUBY6ZGanCsFmsc7r0gO+eBdq7ktlKw==
X-Google-Smtp-Source: ABdhPJxEiUL0lGnCquAGKAV2sAwzIEC9u8umV+RueZW7xY12lFzwzA1Izpo96Rl35iofOmhm0lCrpflesYZL3xmoEEo=
X-Received: by 2002:a37:a643:: with SMTP id p64mr9830973qke.276.1616709043374;
 Thu, 25 Mar 2021 14:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210323035706.572953-1-joshdon@google.com> <20210324112739.GO15768@suse.de>
In-Reply-To: <20210324112739.GO15768@suse.de>
From:   Josh Don <joshdon@google.com>
Date:   Thu, 25 Mar 2021 14:50:32 -0700
Message-ID: <CABk29Nv7qwWcn4nUe_cxH-pJnppUVjHan+f-iHc8hEyPJ37jxA@mail.gmail.com>
Subject: Re: [PATCH v2] sched: Warn on long periods of pending need_resched
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 4:27 AM Mel Gorman <mgorman@suse.de> wrote:
>
> I'm not a fan of the name. I know other sysctls have _enabled in the
> name but it's redundant. If you say the name out loud, it sounds weird.
> I would suggest an alternative but see below.

Now using the version rebased by Peter; this control has gone away and
we have simply a scheduling feature "LATENCY WARN"

> I suggest semantics and naming similar to hung_task_warnings
> because it's sortof similar. resched_latency_warnings would combine
> resched_latency_warn_enabled and resched_latency_warn_once. 0 would mean
> "never warn", -1 would mean always warn and any positive value means
> "warn X number of times".

See above. I'm happy with the enabled bit being toggled separately by
a sched feature; the warn_once behavior is not overloaded with the
enabling/disabling. Also, I don't see value in "warn X number of
times", given the warning is rate limited anyway.

> > +int sysctl_resched_latency_warn_ms = 100;
> > +int sysctl_resched_latency_warn_once = 1;
>
> Use __read_mostly

Good point, done.

> > +#ifdef CONFIG_SCHED_DEBUG
> > +static u64 resched_latency_check(struct rq *rq)
> > +{
> > +     int latency_warn_ms = READ_ONCE(sysctl_resched_latency_warn_ms);
> > +     u64 need_resched_latency, now = rq_clock(rq);
> > +     static bool warned_once;
> > +
> > +     if (sysctl_resched_latency_warn_once && warned_once)
> > +             return 0;
> > +
>
> That is a global variable that can be modified in parallel and I do not
> think it's properly locked (scheduler_tick is holding rq lock which does
> not protect this).
>
> Consider making resched_latency_warnings atomic and use
> atomic_dec_if_positive. If it drops to zero in this path, disable the
> static branch.
>
> That said, it may be overkill. hung_task_warnings does not appear to have
> special protection that prevents it going to -1 or lower values by accident
> either. Maybe it can afford to be a bit more relaxed because a system that
> is spamming hung task warnings is probably dead or might as well be dead.

There's no real issue if we race over modification to that sysctl.
This is intentionally not more strongly synchronized for that reason.

> > +     if (!need_resched() || WARN_ON_ONCE(latency_warn_ms < 2))
> > +             return 0;
> > +
>
> Why is 1ms special? Regardless of the answer, if the sysctl should not
> be 1 then the user should not be able to set it to 1.

Yea let me change that to !latency_warn_ms so it isn't HZ specific.

>
> > +     /* Disable this warning for the first few mins after boot */
> > +     if (now < resched_boot_quiet_sec * NSEC_PER_SEC)
> > +             return 0;
> > +
>
> Check system_state == SYSTEM_BOOTING instead?

Yea, that might be better; let me test that.

> > +     if (!rq->last_seen_need_resched_ns) {
> > +             rq->last_seen_need_resched_ns = now;
> > +             rq->ticks_without_resched = 0;
> > +             return 0;
> > +     }
> > +
> > +     rq->ticks_without_resched++;
> > +     need_resched_latency = now - rq->last_seen_need_resched_ns;
> > +     if (need_resched_latency <= latency_warn_ms * NSEC_PER_MSEC)
> > +             return 0;
> > +
>
> The naming need_resched_latency implies it's a boolean but it's not.
> Maybe just resched_latency?
>
> Similarly, resched_latency_check implies it returns a boolean but it
> returns an excessive latency value. At this point I've been reading the
> patch for a long time so I've ran out of naming suggestions :)

The "need_" part does confuse it a bit; I reworded these to hopefully
make it more clear.

> > +     warned_once = true;
> > +
> > +     return need_resched_latency;
> > +}
> > +
>
> I note that you split when a warning is needed and printing the warning
> but it's not clear why. Sure you are under the RQ lock but there are other
> places that warn under the RQ lock. I suppose for consistency it could
> use SCHED_WARN_ON even though all this code is under SCHED_DEBUG already.

We had seen a circular lock dependency warning (console_sem, pi lock,
rq lock), since printing might need to wake a waiter. However, I do
see plenty of warns under rq->lock, so maybe I missed a patch to
address this?
