Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFED3347723
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 12:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbhCXLZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 07:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234762AbhCXLZV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:25:21 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8709EC0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:20 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m35so957109qtd.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DE1DVxC3WyxIHHd+lUpARd+jKa2DD/enh2sGUuOmG0E=;
        b=pwcY4wDszwwa6XnGOQjVm+SAgthbqfdpImkjYybll5zCXtp6YCnyZbPeRqkKPSaiWU
         1oYg3qfdY1GUsnnXGyz8PsJkKRSIqFohN7dnhQU7nl5fQGJPv2rwBH/DvJKuGPqvE6Z0
         NXRIwkXABkM/NWyT8ddtwu5yXxdPkpSQ3m/7ZQIwo23mjWZKyfl/InCErlhZM9tHeH7S
         TP2IJxxRezhfSvqswvqZt30kNAyu9dyRb/FmpymkA+0OMOm0SbAHL/rgW3jlxPiO1wiL
         VCHDuJrbKaTev+N+tva+Y/Gc68FhXRutOT51wmCrzTtXfuaf5C4SYcmOAC1WrpZj7Xfd
         AWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DE1DVxC3WyxIHHd+lUpARd+jKa2DD/enh2sGUuOmG0E=;
        b=oM9/zIR9DAlwWL5XyMue/JnJh2fvzAW/h+EFAVPYYvt9DBg52OYEZfto2AWX8hy8V6
         SmlsmW5WbGQQOVtDc2I/uA0ZMlaI1uTjSXmBrVQ1O+8X4hwIQcJVKeNjKM7mGTT8CsJV
         gQynTxwj5JEbyJ39wfGPdzYVTLc5r3JDUsblW3j5DPQAtX5qe/F92cst1uXXsM7yrD+J
         UnMP5cDP1mNcrqd54GlJ7fM4gNgJdkQuKvxQjz9TfWTbdad+NG0Ppx/vfqWSIkW2WfrM
         51uMjgftwt2nJQse3J28Nsptr6UKWknd+8rMfmwhWAqTO8E4taLsqu7VW0s/4W1lIQpR
         ug+g==
X-Gm-Message-State: AOAM533Z+AecmvSqDXnI2qe17JWFkgML44bAg6OjOLTjVwLOvglLIU0G
        o4BPybLDR4ko4Sv9hPn0KgpGWuTAmg==
X-Google-Smtp-Source: ABdhPJzbRH4QH9xP0GaYx6lhYF/6RNmDIOunLgx7qzsgzDFxXKoH6s0HKY4nXr7qLiOa0yLCgfCX+idqfg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6489:b3f0:4af:af0])
 (user=elver job=sendgmr) by 2002:ad4:4431:: with SMTP id e17mr2503115qvt.37.1616585119594;
 Wed, 24 Mar 2021 04:25:19 -0700 (PDT)
Date:   Wed, 24 Mar 2021 12:24:52 +0100
Message-Id: <20210324112503.623833-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 00/11] Add support for synchronous signals on perf events
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The perf subsystem today unifies various tracing and monitoring
features, from both software and hardware. One benefit of the perf
subsystem is automatically inheriting events to child tasks, which
enables process-wide events monitoring with low overheads. By default
perf events are non-intrusive, not affecting behaviour of the tasks
being monitored.

For certain use-cases, however, it makes sense to leverage the
generality of the perf events subsystem and optionally allow the tasks
being monitored to receive signals on events they are interested in.
This patch series adds the option to synchronously signal user space on
events.

To better support process-wide synchronous self-monitoring, without
events propagating to children that do not share the current process's
shared environment, two pre-requisite patches are added to optionally
restrict inheritance to CLONE_THREAD, and remove events on exec (without
affecting the parent).

Examples how to use these features can be found in the tests added at
the end of the series. In addition to the tests added, the series has
also been subjected to syzkaller fuzzing (focus on 'kernel/events/'
coverage).

Motivation and Example Uses
---------------------------

1. 	Our immediate motivation is low-overhead sampling-based race
	detection for user space [1]. By using perf_event_open() at
	process initialization, we can create hardware
	breakpoint/watchpoint events that are propagated automatically
	to all threads in a process. As far as we are aware, today no
	existing kernel facility (such as ptrace) allows us to set up
	process-wide watchpoints with minimal overheads (that are
	comparable to mprotect() of whole pages).

2.	Other low-overhead error detectors that rely on detecting
	accesses to certain memory locations or code, process-wide and
	also only in a specific set of subtasks or threads.

[1] https://llvm.org/devmtg/2020-09/slides/Morehouse-GWP-Tsan.pdf

Other ideas for use-cases we found interesting, but should only
illustrate the range of potential to further motivate the utility (we're
sure there are more):

3.	Code hot patching without full stop-the-world. Specifically, by
	setting a code breakpoint to entry to the patched routine, then
	send signals to threads and check that they are not in the
	routine, but without stopping them further. If any of the
	threads will enter the routine, it will receive SIGTRAP and
	pause.

4.	Safepoints without mprotect(). Some Java implementations use
	"load from a known memory location" as a safepoint. When threads
	need to be stopped, the page containing the location is
	mprotect()ed and threads get a signal. This could be replaced with
	a watchpoint, which does not require a whole page nor DTLB
	shootdowns.

5.	Threads receiving signals on performance events to
	throttle/unthrottle themselves.

6.	Tracking data flow globally.

Changelog
---------

v3:
* Add patch "perf: Rework perf_event_exit_event()" to beginning of
  series, courtesy of Peter Zijlstra.
* Rework "perf: Add support for event removal on exec" based on
  the added "perf: Rework perf_event_exit_event()".
* Fix kselftests to work with more recent libc, due to the way it forces
  using the kernel's own siginfo_t.
* Add basic perf-tool built-in test.

v2/RFC: https://lkml.kernel.org/r/20210310104139.679618-1-elver@google.com
* Patch "Support only inheriting events if cloned with CLONE_THREAD"
  added to series.
* Patch "Add support for event removal on exec" added to series.
* Patch "Add kselftest for process-wide sigtrap handling" added to
  series.
* Patch "Add kselftest for remove_on_exec" added to series.
* Implicitly restrict inheriting events if sigtrap, but the child was
  cloned with CLONE_CLEAR_SIGHAND, because it is not generally safe if
  the child cleared all signal handlers to continue sending SIGTRAP.
* Various minor fixes (see details in patches).

v1/RFC: https://lkml.kernel.org/r/20210223143426.2412737-1-elver@google.com

Pre-series: The discussion at [2] led to the changes in this series. The
approach taken in "Add support for SIGTRAP on perf events" to trigger
the signal was suggested by Peter Zijlstra in [3].

[2] https://lore.kernel.org/lkml/CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com/

[3] https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/


Marco Elver (10):
  perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
  perf: Support only inheriting events if cloned with CLONE_THREAD
  perf: Add support for event removal on exec
  signal: Introduce TRAP_PERF si_code and si_perf to siginfo
  perf: Add support for SIGTRAP on perf events
  perf: Add breakpoint information to siginfo on SIGTRAP
  selftests/perf_events: Add kselftest for process-wide sigtrap handling
  selftests/perf_events: Add kselftest for remove_on_exec
  tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
  perf test: Add basic stress test for sigtrap handling

Peter Zijlstra (1):
  perf: Rework perf_event_exit_event()

 arch/m68k/kernel/signal.c                     |   3 +
 arch/x86/kernel/signal_compat.c               |   5 +-
 fs/signalfd.c                                 |   4 +
 include/linux/compat.h                        |   2 +
 include/linux/perf_event.h                    |   6 +-
 include/linux/signal.h                        |   1 +
 include/uapi/asm-generic/siginfo.h            |   6 +-
 include/uapi/linux/perf_event.h               |   5 +-
 include/uapi/linux/signalfd.h                 |   4 +-
 kernel/events/core.c                          | 297 +++++++++++++-----
 kernel/fork.c                                 |   2 +-
 kernel/signal.c                               |  11 +
 tools/include/uapi/linux/perf_event.h         |   5 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |   5 +
 tools/perf/tests/sigtrap.c                    | 148 +++++++++
 tools/perf/tests/tests.h                      |   1 +
 .../testing/selftests/perf_events/.gitignore  |   3 +
 tools/testing/selftests/perf_events/Makefile  |   6 +
 tools/testing/selftests/perf_events/config    |   1 +
 .../selftests/perf_events/remove_on_exec.c    | 260 +++++++++++++++
 tools/testing/selftests/perf_events/settings  |   1 +
 .../selftests/perf_events/sigtrap_threads.c   | 206 ++++++++++++
 23 files changed, 896 insertions(+), 87 deletions(-)
 create mode 100644 tools/perf/tests/sigtrap.c
 create mode 100644 tools/testing/selftests/perf_events/.gitignore
 create mode 100644 tools/testing/selftests/perf_events/Makefile
 create mode 100644 tools/testing/selftests/perf_events/config
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c
 create mode 100644 tools/testing/selftests/perf_events/settings
 create mode 100644 tools/testing/selftests/perf_events/sigtrap_threads.c

-- 
2.31.0.291.g576ba9dcdaf-goog

