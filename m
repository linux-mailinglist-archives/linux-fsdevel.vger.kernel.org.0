Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C373EAC0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238126AbhHLUnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 16:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbhHLUnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:43:01 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04208C06124C
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o126so6181485ybo.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SocJctGaI1z5Y2V/7vECrCscsCsQ4+Z36X400HrEw90=;
        b=MCNby1XiS34HtYanu4HEMdBBHb3yopMV+ncDfXZPodXtOcrBLr22b4Ls/BfzbM0orx
         TqWQKlFF8n3hldLltBeAiIuRiSueXGuR/x6wcKtQeIgY/OG+ScEbKhwPxWoI0qGWrurb
         kiGMVfasnwjaeCnwtMBVGUFibsTbivcP5DJBWTQD6rwAe5AGcxzA6Mnkl/CvWSac4XRb
         YiwMTW85eHqLcg+YmYX0CvbbhkOF6naVhEq8CtV16QYgDMxcjI4jZ08tesEszudmUeNC
         1yFv4FlBVwzeYuw+XFWEQjr8VdpUhfofcBPc7LX8p0I64vx950IJ6NgchwjIyMzAg1fE
         3Hxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SocJctGaI1z5Y2V/7vECrCscsCsQ4+Z36X400HrEw90=;
        b=YgCJkEd9OIv7m72jrsZB9fdDluxey78QyAhuveecaIEI8hzSDgHTs+bZGRuoxNVvax
         ZXv4ZHJ1SLeyBsGtlEAczp8y4SLrXhImGy50i9srtNfDvFTzAI3SVwMAf5+Jg2L1cUub
         y6S/THZBvo7pd19CKqkEwCL/pYDav1IzIrLrS6cyL3PCdfsznXJuqON6+QHA+TCN0A+U
         dazr0qnKVhZ5Mapbf6WORTqY36aeXWBUtux2O+lVFfAtfRUn02mnWB7d9idqJHzeQ0qC
         x/7LCLIY5fia153k1u60X8USGltVI1O19gZ/sQMYjY0CVnHBW1evXcJitw7rVrlWWinr
         Y2sA==
X-Gm-Message-State: AOAM5308i0WqQiw35xG4zhQXkA7AR9Dpjq64gdnx1HY61LH6rW1cdBFL
        vAX7zH70R8bWaMRmW2skVEPX9OXAgS3NjJy2Psc4OQ==
X-Google-Smtp-Source: ABdhPJzIgj0CrwWUnOBFfrhyb8EUrtawZ0J3NKD3b1jYgEH5AUQqaCmnuiuSctcAx1ohrVe08vfPNjodqk7WcRj2tmg=
X-Received: by 2002:a25:bec2:: with SMTP id k2mr7239053ybm.234.1628800954923;
 Thu, 12 Aug 2021 13:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210812203137.2880834-1-joshdon@google.com>
In-Reply-To: <20210812203137.2880834-1-joshdon@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 12 Aug 2021 22:42:23 +0200
Message-ID: <CANn89iJK-PzFrN2S_jojN2rvZBfBJY4cLTg6q+uzF-vcrfrAeQ@mail.gmail.com>
Subject: Re: [PATCH] fs/proc/uptime.c: fix idle time reporting in /proc/uptime
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 12, 2021 at 10:31 PM Josh Don <joshdon@google.com> wrote:
>
> /proc/uptime reports idle time by reading the CPUTIME_IDLE field from
> the per-cpu kcpustats. However, on NO_HZ systems, idle time is not
> continually updated on idle cpus, leading this value to appear
> incorrectly small.
>
> /proc/stat performs an accounting update when reading idle time; we can
> use the same approach for uptime.
>
> With this patch, /proc/stat and /proc/uptime now agree on idle time.
> Additionally, the following shows idle time tick up consistently on an
> idle machine:
> (while true; do cat /proc/uptime; sleep 1; done) | awk '{print $2-prev; prev=$2}'
>
> Reported-by: Luigi Rizzo <lrizzo@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> ---
>  fs/proc/stat.c              | 26 --------------------------
>  fs/proc/uptime.c            | 13 ++++++++-----
>  include/linux/kernel_stat.h |  1 +
>  kernel/sched/cputime.c      | 28 ++++++++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 31 deletions(-)
>
> diff --git a/fs/proc/stat.c b/fs/proc/stat.c
> index 6561a06ef905..99796a8a5223 100644
> --- a/fs/proc/stat.c
> +++ b/fs/proc/stat.c
> @@ -24,16 +24,6 @@
>
>  #ifdef arch_idle_time
>
> -static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
> -{
> -       u64 idle;
> -
> -       idle = kcs->cpustat[CPUTIME_IDLE];
> -       if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
> -               idle += arch_idle_time(cpu);
> -       return idle;
> -}
> -
>  static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  {
>         u64 iowait;
> @@ -46,22 +36,6 @@ static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>
>  #else
>
> -static u64 get_idle_time(struct kernel_cpustat *kcs, int cpu)
> -{
> -       u64 idle, idle_usecs = -1ULL;
> -
> -       if (cpu_online(cpu))
> -               idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> -
> -       if (idle_usecs == -1ULL)
> -               /* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> -               idle = kcs->cpustat[CPUTIME_IDLE];
> -       else
> -               idle = idle_usecs * NSEC_PER_USEC;
> -
> -       return idle;
> -}
> -
>  static u64 get_iowait_time(struct kernel_cpustat *kcs, int cpu)
>  {
>         u64 iowait, iowait_usecs = -1ULL;

...

> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 872e481d5098..9d7629e21164 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -227,6 +227,34 @@ void account_idle_time(u64 cputime)
>                 cpustat[CPUTIME_IDLE] += cputime;
>  }
>
> +/*
> + * Returns the total idle time for the given cpu.
> + * @kcs: The kernel_cpustat for the desired cpu.
> + * @cpu: The desired cpu.
> + */
> +u64 get_idle_time(const struct kernel_cpustat *kcs, int cpu)
> +{
> +       u64 idle;
> +       u64 __maybe_unused idle_usecs = -1ULL;
> +
> +#ifdef arch_idle_time
> +       idle = kcs->cpustat[CPUTIME_IDLE];
> +       if (cpu_online(cpu) && !nr_iowait_cpu(cpu))
> +               idle += arch_idle_time(cpu);
> +#else
> +       if (cpu_online(cpu))
> +               idle_usecs = get_cpu_idle_time_us(cpu, NULL);
> +
> +       if (idle_usecs == -1ULL)
> +               /* !NO_HZ or cpu offline so we can rely on cpustat.idle */
> +               idle = kcs->cpustat[CPUTIME_IDLE];
> +       else
> +               idle = idle_usecs * NSEC_PER_USEC;
> +#endif
> +
> +       return idle;
> +}
> +
>

Not sure why you moved get_idle_time() in kernel/sched/cputime.c

For builds where CONFIG_PROC_FS is not set, this function is not used/needed.
