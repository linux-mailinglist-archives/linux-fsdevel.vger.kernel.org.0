Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E06484C39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jan 2022 02:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiAEBsV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 20:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbiAEBsU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:48:20 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A33EC061761
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jan 2022 17:48:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id y130so88967368ybe.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jan 2022 17:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3MV8EDA/gvv4OPelttWmulQGEHAkpGwQXtCt5sJZFc=;
        b=IjnvSApgYqoCeUI/96H6ZFMo8jneVsZ6oT5EroZA96IcN5y4uOe8HrLGXDKJxB1yk6
         d5vLYIZFUBUTrW0gABnB1eBHPxLyuRZvLdad3hmu9KQzzZf0qcHYK0P39nBGPE6Ij2+j
         fw5mlcY27kIOS8nDgHB4bFddbXLmtNRc6H0SFu/kSlRhCWV5/T0q4ajAb1MsRdFoP8+w
         qT7KTGH5hJpmyPT/we5xRA8bzDDzTdQfQc2LINB8GkvEKhYZqxuAPIssLYGivb0tkMiZ
         ZMi/Qa5ji/dXu5AxNvUVL2hw6HGZaI9uPYjWETdQX26M7SzUOdx7v0YODSlqllan5NVf
         HH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3MV8EDA/gvv4OPelttWmulQGEHAkpGwQXtCt5sJZFc=;
        b=NO37uUDwFCZ8dgtlJRAA1KoyDjVV6/QaMShC8vwq0iGR2pPOomB45FUI+Vsa2bdK2I
         xYG1C9KykGHRiIv/noG+WjPGvZ74JRQZH3g2DfVAtdsa0zdj55RRHvhbtfKyUhpzyt1Y
         mxcTOcrDBNFtpxRP79xR9hIaWCUyzFeQdSluRsxYtWT2f+Pv/3OquSgzFxSayWnMFWQI
         lwLfGR3q5k3kJ/mbsMOxLgMXiNQ8826+3joiAtqJtkv7qMaiWf1eNNi8lFU6mj8WMK2U
         v9MjR4xIyXKokv1xkptAiS3kW+vT6rMD6Sfb+rQpOscseEP5sMjCc/MwNF/nuf/wtEIp
         YFZg==
X-Gm-Message-State: AOAM532ApBvmyVis8qhJc/u7GNEqbJ+i8mJkXo4YabtbGtAfIur6vKbC
        nFo1iXK/hy24gZA+hmSmWiPJQQJHI/bhu6EJr61k7A==
X-Google-Smtp-Source: ABdhPJzgiDx9c56h3HvklU/xl5FU9OHdfrLBiBFcrJF3XAgLqNgRZIx7IBYHVpRBrRyzXDnZFaj8MeQCOxGaEnmrLB0=
X-Received: by 2002:a25:3745:: with SMTP id e66mr21815632yba.208.1641347299207;
 Tue, 04 Jan 2022 17:48:19 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com> <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1640262603-19339-2-git-send-email-CruzZhao@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 4 Jan 2022 17:48:08 -0800
Message-ID: <CABk29NvPJ3S1xq5xm+52OoUGDyuMSxGOLJbopPa3+-QmLnVYeQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/core: Cookied forceidle accounting per cpu
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Cruz,

Could you add a bit more background to help me understand what case
this patch solves? Is your issue that you want to be able to
attribute forced idle time to the specific cpus it happens on, or do
you simply want a more convenient way of summing forced idle without
iterating your cookie'd tasks and summing the schedstat manually?

> @@ -190,6 +202,9 @@ static int show_stat(struct seq_file *p, void *v)
>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(steal));
>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest));
>                 seq_put_decimal_ull(p, " ", nsec_to_clock_t(guest_nice));
> +#ifdef CONFIG_SCHED_CORE
> +               seq_put_decimal_ull(p, " ", nsec_to_clock_t(cookied_forceidle));
> +#endif

IMO it would be better to always print this stat, otherwise it sets a
weird precedent for new stats added in the future (much more difficult
for userspace to reason about which column corresponds with which
field, since it would depend on kernel config).

Also, did you intend to put this in /proc/stat instead of
/proc/schedstat (the latter of which would be more attractive to
prevent calculation of these stats unless schestat was enabled)?

> diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
> @@ -260,6 +261,21 @@ void __sched_core_account_forceidle(struct rq *rq)
>
>         rq->core->core_forceidle_start = now;
>
> +       for_each_cpu(i, smt_mask) {
> +               rq_i = cpu_rq(i);
> +               p = rq_i->core_pick ?: rq_i->curr;
> +
> +               if (!rq->core->core_cookie)
> +                       continue;

I see this is temporary given your other patch, but just a note that
if your other patch is dropped, this check can be pulled outside the
loop.

> +               if (p == rq_i->idle && rq_i->nr_running) {
> +                       cpustat = kcpustat_cpu(i).cpustat;
> +                       cpustat[CPUTIME_COOKIED_FORCEIDLE] += delta;
> +               }
> +       }

I don't think this is right. If a cpu was simply idle while some other
SMT sibling on its core was forced idle, and then a task happens to
wake on the idle cpu, that cpu will now be charged the full delta here
as forced idle (when actually it was never forced idle, we just
haven't been through pick_next_task yet). One workaround would be to
add a boolean to struct rq to cache whether the rq was in forced idle
state.

Best,
Josh
