Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D043233B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 23:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhBWW2Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 17:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhBWW1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:27:22 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF2AC061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 14:26:42 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id s3so262519otg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 14:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fZxhrFPoVeuINwqWYDTQrRIMFcJNq/iX5+xBlXUPDIw=;
        b=Lkb/fePhnB3TeXO8nhWGUpDpvuWHlvarKeD0HrVivi0T+3SB/3s96S+TLlJRZWdu/7
         LzAu9w42VS6gqUKOAyRRnlVvojownec1/CLyOEfqurejaYCCK5tVfresc04+Dl2XW/iN
         UGuZwMWXTPugvWndL9KLxaN5dLQR0IdCP9yjKf5/5tcsEkL84nOowVAysLLEnAfcg3cS
         z28cIFKTN5FIt0IiQWX+cbneyBitwyKBKVvCyjrF08Xt9Exkv3ZXlzFYa0UB2Km3buwT
         44bJM65RqceFOuvwN2cfOXlSaBbfpqTbw3rXZXWhefF7OsdNuGkVpewdqnJ/XW/wWUWS
         blkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fZxhrFPoVeuINwqWYDTQrRIMFcJNq/iX5+xBlXUPDIw=;
        b=IN7RKRlwKPs3ZzC7KVDia+0GwedRSe+3fhniM8gWyouSuIrJMPfDRh+zFuXCwF3ZsG
         MbixBKr14Ch7fap6I207xiKEE9BgeKVpAl2OpB4AFMJQUH3WlapVuVPUc22CGrMd5i8v
         W+K+7mG+1SDO8sjDmmyBejONeOOs30knCCRghIvzNfzfJBk0WSkB9aqp4tUhDHK0lDpy
         t6dBU1hCI5gR1f0Lm4s+yTHrOW3wCnkcM3zEnWlYxJFb/mtbu113h4v78yg9a/LPv/6n
         W3gncM3kMBt3yiIhIfydKvmO5LnE/c6meSEFy8RCIOlzCCjzHodXueCttzs1jKSK0jhy
         U06Q==
X-Gm-Message-State: AOAM531b/i9HN6Y6dO/RiUIOiT7wZXWC9O4CLOwv9PQILDVpSRD5LWKw
        YpfebaKKgunwW+Irt3swIK/+PR/B1Ug/j2xQA3Y1OA==
X-Google-Smtp-Source: ABdhPJyKcJ1a+AjtPRO339TGkeeBUE+Uf/ejrr6lZnvFhmNcPW5GEY4o7F+DMHaSBgv4mLYXaBM1l4zKLP8jkuBLUWw=
X-Received: by 2002:a9d:5a05:: with SMTP id v5mr22397134oth.17.1614119201352;
 Tue, 23 Feb 2021 14:26:41 -0800 (PST)
MIME-Version: 1.0
References: <20210223143426.2412737-1-elver@google.com> <3D507285-835F-4C83-8343-2888835971B4@amacapital.net>
In-Reply-To: <3D507285-835F-4C83-8343-2888835971B4@amacapital.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Feb 2021 23:26:29 +0100
Message-ID: <CANpmjNOpq27pDnoPaNON7a_gi7Ls=7xQXBH5-BSe9jwiFE763A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] Add support for synchronous signals on perf events
To:     Andy Lutomirski <luto@amacapital.net>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Feb 2021 at 21:27, Andy Lutomirski <luto@amacapital.net> wrote:
> > On Feb 23, 2021, at 6:34 AM, Marco Elver <elver@google.com> wrote:
> >
> > =EF=BB=BFThe perf subsystem today unifies various tracing and monitorin=
g
> > features, from both software and hardware. One benefit of the perf
> > subsystem is automatically inheriting events to child tasks, which
> > enables process-wide events monitoring with low overheads. By default
> > perf events are non-intrusive, not affecting behaviour of the tasks
> > being monitored.
> >
> > For certain use-cases, however, it makes sense to leverage the
> > generality of the perf events subsystem and optionally allow the tasks
> > being monitored to receive signals on events they are interested in.
> > This patch series adds the option to synchronously signal user space on
> > events.
>
> Unless I missed some machinations, which is entirely possible, you can=E2=
=80=99t call force_sig_info() from NMI context. Not only am I not convinced=
 that the core signal code is NMI safe, but at least x86 can=E2=80=99t corr=
ectly deliver signals on NMI return. You probably need an IPI-to-self.

force_sig_info() is called from an irq_work only: perf_pending_event
-> perf_pending_event_disable -> perf_sigtrap -> force_sig_info. What
did I miss?

> > The discussion at [1] led to the changes proposed in this series. The
> > approach taken in patch 3/4 to use 'event_limit' to trigger the signal
> > was kindly suggested by Peter Zijlstra in [2].
> >
> > [1] https://lore.kernel.org/lkml/CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpoc=
X2jwVAbZD=3D-XQ@mail.gmail.com/
> > [2] https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kic=
ks-ass.net/
> >
> > Motivation and example uses:
> >
> > 1.    Our immediate motivation is low-overhead sampling-based race
> >    detection for user-space [3]. By using perf_event_open() at
> >    process initialization, we can create hardware
> >    breakpoint/watchpoint events that are propagated automatically
> >    to all threads in a process. As far as we are aware, today no
> >    existing kernel facility (such as ptrace) allows us to set up
> >    process-wide watchpoints with minimal overheads (that are
> >    comparable to mprotect() of whole pages).
>
> This would be doable much more simply with an API to set a breakpoint.  A=
ll the machinery exists except the actual user API.

Isn't perf_event_open() that API?

A new user API implementation will either be a thin wrapper around
perf events or reinvent half of perf events to deal with managing
watchpoints across a set of tasks (process-wide or some subset).

It's not just breakpoints though.

> >    [3] https://llvm.org/devmtg/2020-09/slides/Morehouse-GWP-Tsan.pdf
> >
> > 2.    Other low-overhead error detectors that rely on detecting
> >    accesses to certain memory locations or code, process-wide and
> >    also only in a specific set of subtasks or threads.
> >
> > Other example use-cases we found potentially interesting:
> >
> > 3.    Code hot patching without full stop-the-world. Specifically, by
> >    setting a code breakpoint to entry to the patched routine, then
> >    send signals to threads and check that they are not in the
> >    routine, but without stopping them further. If any of the
> >    threads will enter the routine, it will receive SIGTRAP and
> >    pause.
>
> Cute.
>
> >
> > 4.    Safepoints without mprotect(). Some Java implementations use
> >    "load from a known memory location" as a safepoint. When threads
> >    need to be stopped, the page containing the location is
> >    mprotect()ed and threads get a signal. This can be replaced with
> >    a watchpoint, which does not require a whole page nor DTLB
> >    shootdowns.
>
> I=E2=80=99m skeptical. Propagating a hardware breakpoint to all threads i=
nvolves IPIs and horribly slow writes to DR1 (or 2, 3, or 4) and DR7.  A TL=
B flush can be accelerated using paravirt or hypothetical future hardware. =
Or real live hardware on ARM64.
>
> (The hypothetical future hardware is almost present on Zen 3.  A bit of w=
ork is needed on the hardware end to make it useful.)

Fair enough. Although watchpoints can be much more fine-grained than
an mprotect() which then also has downsides (checking if the accessed
memory was actually the bytes we're interested in). Maybe we should
also ask CPU vendors to give us better watchpoints (perhaps start with
more of them, and easier to set in batch)? We still need a user space
API...

Thanks,
-- Marco



> >
> > 5.    Tracking data flow globally.
> >
> > 6.    Threads receiving signals on performance events to
> >    throttle/unthrottle themselves.
