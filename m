Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E96B3231C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 21:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234108AbhBWUFL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhBWUEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:04:37 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D315C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 12:03:57 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id s3so13711133otg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 12:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDbWfjB7meY0E7XLsjIrc5m2e7z/Yrkuj6hZaVwwlGE=;
        b=uueyZEhCJsJkc1//64Eechxof/hRtg3m1Kam7rXXOkGxioSseruAEXvRT1gwPL8vci
         FduZ0uQOv8+hJwNqH9PO99dchqYCcxQiJavaJVEq/x4E+GhQSZ1/+TJqGhdyxth/c9b0
         uBrjxFkcXCrqELg63jTj2cOvhZihBwrbswwm24tvtYDcz3VfF4hdNH3wZ4J2dUZ+BkDt
         MufANT3JpO5VQjXitgDU8rg0FNLkZhigCEZj/mve/wdbPae6jymb4nI850CjV70cb/eu
         vERzojj1KOkEFfWGrh7Xvuh/pR7gscOH4+/AOHuoREQG0qNB8ht4uwrfaELflnr/vR/c
         +bjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDbWfjB7meY0E7XLsjIrc5m2e7z/Yrkuj6hZaVwwlGE=;
        b=O+QdH4P46DB4OpyQpDGPHvO9Twrga84lN28iMA+V3Cy4akgk6cXB3L+wB8mgUnyY02
         BypX8jOWG8OCMsgb65C7wH/Uqfq0jer/ewxvw9ToQfavF+YMvsqH/+0Efbq/sOAfIlwA
         Yx06Y6b16e4zSJDLP42nLq+K5M5TfAJWsb+6jk/EhoghqI/JxGRLgJ/LjkfdIAVxjSTK
         mbXlJHbUO/Z2kRz0Er6QoLQl1uXQh520Vee/67/xIbwDHWsuC96gy3XbxNLJYzAlMVDw
         jpLky8JxrRBU2v6rkDtC6hRpFGORTZO0YkjKAUjX0NXFMb+32txIZ1zV72k15+n00PV7
         cXUA==
X-Gm-Message-State: AOAM532LqJ8uK1SpMPdcirVKBkEj22JMWoxW6eBYeXwAsNz87xFFjWod
        AhmoTUxJV7MdkuywFVayZkV3cbCiUmfte/+OfwkDtw==
X-Google-Smtp-Source: ABdhPJym6kizV7WwEuRTO4LxrYB6Kngg9p2qqbI8TF8TQ17KCmxCWMoNs/hCqzqUJllLyQpwObR4PeorYP4v1txmJq8=
X-Received: by 2002:a05:6830:18e6:: with SMTP id d6mr22473227otf.251.1614110636519;
 Tue, 23 Feb 2021 12:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com>
In-Reply-To: <20210223143426.2412737-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Feb 2021 21:03:44 +0100
Message-ID: <CANpmjNPEzA0EP9zEGE-O7tz=3EhKjdhVi43jbhoTDRG5wo3C1A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Add support for synchronous signals on perf events
To:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
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

On Tue, 23 Feb 2021 at 15:34, Marco Elver <elver@google.com> wrote:
>
> The perf subsystem today unifies various tracing and monitoring
> features, from both software and hardware. One benefit of the perf
> subsystem is automatically inheriting events to child tasks, which
> enables process-wide events monitoring with low overheads. By default
> perf events are non-intrusive, not affecting behaviour of the tasks
> being monitored.
>
> For certain use-cases, however, it makes sense to leverage the
> generality of the perf events subsystem and optionally allow the tasks
> being monitored to receive signals on events they are interested in.
> This patch series adds the option to synchronously signal user space on
> events.
>
> The discussion at [1] led to the changes proposed in this series. The
> approach taken in patch 3/4 to use 'event_limit' to trigger the signal
> was kindly suggested by Peter Zijlstra in [2].
>
> [1] https://lore.kernel.org/lkml/CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com/
> [2] https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/
>
> Motivation and example uses:
>
> 1.      Our immediate motivation is low-overhead sampling-based race
>         detection for user-space [3]. By using perf_event_open() at
>         process initialization, we can create hardware
>         breakpoint/watchpoint events that are propagated automatically
>         to all threads in a process. As far as we are aware, today no
>         existing kernel facility (such as ptrace) allows us to set up
>         process-wide watchpoints with minimal overheads (that are
>         comparable to mprotect() of whole pages).
>
>         [3] https://llvm.org/devmtg/2020-09/slides/Morehouse-GWP-Tsan.pdf
>
> 2.      Other low-overhead error detectors that rely on detecting
>         accesses to certain memory locations or code, process-wide and
>         also only in a specific set of subtasks or threads.
>
> Other example use-cases we found potentially interesting:
>
> 3.      Code hot patching without full stop-the-world. Specifically, by
>         setting a code breakpoint to entry to the patched routine, then
>         send signals to threads and check that they are not in the
>         routine, but without stopping them further. If any of the
>         threads will enter the routine, it will receive SIGTRAP and
>         pause.
>
> 4.      Safepoints without mprotect(). Some Java implementations use
>         "load from a known memory location" as a safepoint. When threads
>         need to be stopped, the page containing the location is
>         mprotect()ed and threads get a signal. This can be replaced with
>         a watchpoint, which does not require a whole page nor DTLB
>         shootdowns.
>
> 5.      Tracking data flow globally.
>
> 6.      Threads receiving signals on performance events to
>         throttle/unthrottle themselves.
>
>
> Marco Elver (4):
>   perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
>   signal: Introduce TRAP_PERF si_code and si_perf to siginfo
>   perf/core: Add support for SIGTRAP on perf events
>   perf/core: Add breakpoint information to siginfo on SIGTRAP

Note that we're currently pondering fork + exec, and suggestions would
be appreciated. We think we'll need some restrictions, like Peter
proposed here: here:
https://lore.kernel.org/lkml/YBvj6eJR%2FDY2TsEB@hirez.programming.kicks-ass.net/

We think what we want is to inherit the events to children only if
cloned with CLONE_SIGHAND. If there's space for a 'inherit_mask' in
perf_event_attr, that'd be most flexible, but perhaps we do not have
the space.

Thanks,
-- Marco

>
>  arch/m68k/kernel/signal.c          |  3 ++
>  arch/x86/kernel/signal_compat.c    |  5 ++-
>  fs/signalfd.c                      |  4 +++
>  include/linux/compat.h             |  2 ++
>  include/linux/signal.h             |  1 +
>  include/uapi/asm-generic/siginfo.h |  6 +++-
>  include/uapi/linux/perf_event.h    |  3 +-
>  include/uapi/linux/signalfd.h      |  4 ++-
>  kernel/events/core.c               | 54 +++++++++++++++++++++++++++++-
>  kernel/signal.c                    | 11 ++++++
>  10 files changed, 88 insertions(+), 5 deletions(-)
>
> --
> 2.30.0.617.g56c4b15f3c-goog
>
