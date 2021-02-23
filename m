Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEA2322CFA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 15:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhBWO6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 09:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbhBWO6C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:58:02 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6624C06178C
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:57:18 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 204so11403705qke.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmrazInE9lkHVfTVT/c9ri5uOiLTKO8Po9aKcmrNBAY=;
        b=lPGcs8+XN3ZhWjVfUavOT+6rAWT08aaeXOP+i0kowIIBYo9WhUzverN7jPlsTiao8N
         Dsh0tpbLvYdVtf3jpRizZ1sub2i15T6IvYNm6KOy79b2VfnDv01x/1WP/06N5TEXCPvK
         ks31czjm8XJoxoKwMTPR61Wpm52jhrg/b5h0lhp1zsIFoxgM/XTerBw6sRWLdQL+/q4B
         R3IBD3hWUe+/7M45KI932Aoi2d/fOuhsL9ZuoTPMMGhuIzFgitBPsh4dDGzQtpn4jvCg
         3v7HHGk73/z4DgE6CrT1ht0NL9IWXRrD9YLxTDwKy9t7WXvPvb81TuXjDk2KSlm0SyIL
         jAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmrazInE9lkHVfTVT/c9ri5uOiLTKO8Po9aKcmrNBAY=;
        b=YY11HGnhybQluQMaH/3EISnRWhelvbGrCinbeZ+4w9uooo2KkPuFnAsAaLITNz/LC5
         mjnsn2oxhvCNUXsl/9sQQ5J5hAz6t8lNc43iyfXDOnvC6J90i6I2a9xeeefMou/yw0tN
         TtDGXFxEHo5XaXXhR5ZnZewO9gQurm5HreBVo2J93VGIzyOet2m13KQhhAFTatE5bUZJ
         TS4Le69HWKHZ7Bj9nCmuoDd3tTg2zYLji/4cjsYpPxRcqLxEaDFEOCLlBBa/TbJLfKYC
         i+XVp0KVtdJhSoWoxIALETBZGMaJXuxNgryi3HLssMAXAVh45+JSqZtH/JxKrkO3foAa
         KFLw==
X-Gm-Message-State: AOAM530CZXiz6dLCpCYbVdkd9J9c02sIX3fFE0L5+FyjOD+EO3Mcnk2i
        JufenbHF5Zxfxj3PaY9cb0PGgl2KbYSWelVS6fwlLQ==
X-Google-Smtp-Source: ABdhPJxskRNcDrPojVCsfatXoteGeJRu+C8kFTCNr9W1n27qH/CtTomH+2quLi9leH/3XygPSui+HOsTQSf1jHotd2I=
X-Received: by 2002:a37:a757:: with SMTP id q84mr25540114qke.501.1614092237384;
 Tue, 23 Feb 2021 06:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <20210223143426.2412737-4-elver@google.com>
In-Reply-To: <20210223143426.2412737-4-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Feb 2021 15:57:06 +0100
Message-ID: <CACT4Y+aEZ5_KFf8Uj-J6uLCdZcB_r5+tSpw8KhGg0PoBn_eMFQ@mail.gmail.com>
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

Can/should this be atomic_set(&event->event_limit, 1)? It should only
go between 1 and 0, right?
Otherwise:

Acked-by: Dmitry Vyukov <dvyukov@google.com>


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
