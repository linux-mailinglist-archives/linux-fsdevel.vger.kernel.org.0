Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF4A323061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhBWSOh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbhBWSOg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:14:36 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27706C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 10:13:56 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 2so8236781qvd.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64chh81MrDhbGsEgUYAQK1O320WsxsfdzdSvZe/81Lc=;
        b=FMcvcTOtJbk9S1OVOWzfwDI5hEJZtOOmWU/jx2w96FB7sbM4dTOUaL9uiX7+DbzOjh
         SckAfTThgCrNq9MZdWyLykL8A8V2tpZq2WKyEu+IEcuT9vYdy42OJfU0uY5KQmUvOc14
         IWOySySdL1dIZtnKCoAktLqbu5etA0LNHAujHL8fGQQx/khRZpqpAlO/3G9ifKZOSe7p
         U/V1t1C2ssrd12UzPv6Tc8TI1ZQmeQL4SBk29m7M3GzQuqVAIvMNKithrg9NzgJ+wPvt
         p3t+iw8zwvxfIY5nhwTyV9xO8IgyaZDSCJqvoTzizj2jdUg5IQ/zrKmsPyS0Q5cSX+pn
         /DxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64chh81MrDhbGsEgUYAQK1O320WsxsfdzdSvZe/81Lc=;
        b=WmpO2SrWue/7JkCU6nvRUNobrEodY6gRXlpdaDAUtDAHzf9eaTTV5r/PfAsiCyOFZ+
         sstzQ8SRaigk5nXG9GLEITk8kmfmBKjEvChs/A5+OD2ShWTJS2hSzwaND3jYkhqj+Asz
         C7X7z00ruoEiLU/rO5MERvVFnUQQt3B33S9ZE/mdEw+cTDv9pW3/TY0AGHaMJXP1nxyV
         dSszTVbRrNrqBhX78DcHPhLWCgi2tm5mI1CfQ35CvPQG26OBnXEmDARFL6rGCluzQkAt
         z0VEbIiBupHpTYgBf3W5wy07nI1hbQrlg+yu/y+PLd7urQ4JaZWFewE2dhMZMIvoybZn
         QUMg==
X-Gm-Message-State: AOAM531zWHWx+F8RaDsUreWNQxb6TuRSJvD9ZvmzDJo9QVrP6MNO6Nv7
        4fVhnIevGjdmgKL2OairIV0RKmeHkYjgG1o4GWtSMg==
X-Google-Smtp-Source: ABdhPJzd2W30fvJh6WbDh5Kt5luVUnWfWNcb2OCq6wulmujrbpLeuMCS+sjlsu+6F+H08XVOLW05o0n0O0xTf4LNtqY=
X-Received: by 2002:a0c:8304:: with SMTP id j4mr26498875qva.18.1614104034885;
 Tue, 23 Feb 2021 10:13:54 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-4-elver@google.com>
In-Reply-To: <20210223143426.2412737-4-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 19:13:42 +0100
Message-ID: <CACT4Y+byoqr4UjNcYO-VMRZorqVxGyZmQb==pJXiQ0WjqwXvhg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/4] perf/core: Add support for SIGTRAP on perf events
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 23, 2021 at 3:34 PM Marco Elver <elver@google.com> wrote:
>
> Adds bit perf_event_attr::sigtrap, which can be set to cause events to
> send SIGTRAP (with si_code TRAP_PERF) to the task where the event
> occurred. To distinguish perf events and allow user space to decode
> si_perf (if set), the event type is set in si_errno.
>
> The primary motivation is to support synchronous signals on perf events
> in the task where an event (such as breakpoints) triggered.
>
> Link: https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/uapi/linux/perf_event.h |  3 ++-
>  kernel/events/core.c            | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index ad15e40d7f5d..b9cc6829a40c 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -389,7 +389,8 @@ struct perf_event_attr {
>                                 cgroup         :  1, /* include cgroup events */
>                                 text_poke      :  1, /* include text poke events */
>                                 build_id       :  1, /* use build id in mmap2 events */
> -                               __reserved_1   : 29;
> +                               sigtrap        :  1, /* send synchronous SIGTRAP on event */
> +                               __reserved_1   : 28;
>
>         union {
>                 __u32           wakeup_events;    /* wakeup every n events */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 37a8297be164..8718763045fd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6288,6 +6288,17 @@ void perf_event_wakeup(struct perf_event *event)
>         }
>  }
>
> +static void perf_sigtrap(struct perf_event *event)
> +{
> +       struct kernel_siginfo info;
> +
> +       clear_siginfo(&info);
> +       info.si_signo = SIGTRAP;
> +       info.si_code = TRAP_PERF;
> +       info.si_errno = event->attr.type;
> +       force_sig_info(&info);
> +}
> +
>  static void perf_pending_event_disable(struct perf_event *event)
>  {
>         int cpu = READ_ONCE(event->pending_disable);
> @@ -6297,6 +6308,13 @@ static void perf_pending_event_disable(struct perf_event *event)
>
>         if (cpu == smp_processor_id()) {
>                 WRITE_ONCE(event->pending_disable, -1);
> +
> +               if (event->attr.sigtrap) {
> +                       atomic_inc(&event->event_limit); /* rearm event */

We send the signal to the current task. Can this fire outside of the
current task context? E.g. in interrupt/softirq/etc? And then we will
send the signal to the current task. Watchpoint can be set to
userspace address and then something asynchronous (some IO completion)
that does not belong to this task access the userspace address (is
this possible?). But watchpoints can also be set to kernel addresses,
then another context can definitely access it.
(1) can this happen? maybe perf context is somehow disabled when !in_task()?
(2) if yes, what is the desired behavior?




> +                       perf_sigtrap(event);
> +                       return;
> +               }
> +
>                 perf_event_disable_local(event);
>                 return;
>         }
> @@ -11325,6 +11343,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
>
>         event->state            = PERF_EVENT_STATE_INACTIVE;
>
> +       if (event->attr.sigtrap)
> +               atomic_set(&event->event_limit, 1);
> +
>         if (task) {
>                 event->attach_state = PERF_ATTACH_TASK;
>                 /*
> --
> 2.30.0.617.g56c4b15f3c-goog
>
