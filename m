Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F73333A4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 11:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhCJKmW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 05:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhCJKlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:41:51 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE35C061760
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:51 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id bt20so3448428qvb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Mar 2021 02:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CXDGXPLv4zBuXju/CY+pJKsC5gho63hQizGsKGKZIlo=;
        b=s8QQMW2LW/UVYVavbb8dseqF5ki4rCkHLP26JLijl8mjtrb2/K9xsn1pRuxTKkCI4A
         WGyH7yeNfeUXgTkHZRLKKruj4dvA8zqeAw8g9DEKxuPrIaGljnESUIgjFlOM+bCXz4tn
         c9bFCJzuS2ISr9LWzCXLNx+Wcm+zwSSUKC22+8M7ayZ+u40rra70SNM/qZC8LntQ8M+x
         LfbEJhGnYNOCsOoYIBKkY22AYCekDUpQLyniHJOCTXmbR2NjqIWEI/Q7LXtMgkQdT9PA
         pBMfOEGap4OIRTFxX57bGhAxB9ytAltLxLxoTVs8/M5KXEc0dKDW6iG4+bhnhlJ2Cq5H
         n5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CXDGXPLv4zBuXju/CY+pJKsC5gho63hQizGsKGKZIlo=;
        b=U8PQ7qCKXRM/oQLZ+/Hz/xStdbS6yfOhDwoFmlKjVAjrd4d/592lSOj3bTCdmt0Qjt
         S/X1Epp6+WQzEG21u7BgAZ1p6tAM7JCBL70MbVybgw2ZGIeZfJ2O7dfKmZqfYFY12Ld/
         7sezNpN6RuNDAZ9C+v7HMipgGIE8tGfdmpsK8pHW9147uw8P0s2BDJlh5hDWU/xuD3M7
         95K6e8+DnRE4m6Dhy4NBPz63k9e2Yb5LqBqTrFpsH21NksYbd0BgHPeiIwvv2i4Q4at4
         F50xnaIVJVncxhE8WW1VC7virS/rTNb6uUV8jcyMw3bdflDt+jInnPEQQOurIsqbIeI+
         qoWg==
X-Gm-Message-State: AOAM530o3SaDGYPc97Q12+J3zi65/tzpx9X1ALi4HaHHlJ2DvXYfx/2j
        DvDvjpmdDhLhmhSOvguQ9RgMuvW40A==
X-Google-Smtp-Source: ABdhPJyUi3y7lpUQnvLHzVb9XkNgXOybwzuc9DsNWma/PHqm9SowojQnqTCgLARpnGj2C/XeILIJohc7NA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e995:ac0b:b57c:49a4])
 (user=elver job=sendgmr) by 2002:a05:6214:2262:: with SMTP id
 gs2mr2155838qvb.32.1615372910698; Wed, 10 Mar 2021 02:41:50 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:41:31 +0100
Message-Id: <20210310104139.679618-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH RFC v2 0/8] Add support for synchronous signals on perf events
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

Examples how to use these features can be found in the two kselftests at
the end of the series. The kselftests verify and stress test the basic
functionality.

The discussion at [1] led to the changes proposed in this series. The
approach taken in patch "Add support for SIGTRAP on perf events" to use
'event_limit' to trigger the signal was kindly suggested by Peter
Zijlstra in [2].

[1] https://lore.kernel.org/lkml/CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/ 

Motivation and example uses:

1. 	Our immediate motivation is low-overhead sampling-based race
	detection for user space [3]. By using perf_event_open() at
	process initialization, we can create hardware
	breakpoint/watchpoint events that are propagated automatically
	to all threads in a process. As far as we are aware, today no
	existing kernel facility (such as ptrace) allows us to set up
	process-wide watchpoints with minimal overheads (that are
	comparable to mprotect() of whole pages).

	[3] https://llvm.org/devmtg/2020-09/slides/Morehouse-GWP-Tsan.pdf 

2.	Other low-overhead error detectors that rely on detecting
	accesses to certain memory locations or code, process-wide and
	also only in a specific set of subtasks or threads.

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

---
v2:
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

v1: https://lkml.kernel.org/r/20210223143426.2412737-1-elver@google.com

Marco Elver (8):
  perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
  perf/core: Support only inheriting events if cloned with CLONE_THREAD
  perf/core: Add support for event removal on exec
  signal: Introduce TRAP_PERF si_code and si_perf to siginfo
  perf/core: Add support for SIGTRAP on perf events
  perf/core: Add breakpoint information to siginfo on SIGTRAP
  selftests/perf: Add kselftest for process-wide sigtrap handling
  selftests/perf: Add kselftest for remove_on_exec

 arch/m68k/kernel/signal.c                     |   3 +
 arch/x86/kernel/signal_compat.c               |   5 +-
 fs/signalfd.c                                 |   4 +
 include/linux/compat.h                        |   2 +
 include/linux/perf_event.h                    |   5 +-
 include/linux/signal.h                        |   1 +
 include/uapi/asm-generic/siginfo.h            |   6 +-
 include/uapi/linux/perf_event.h               |   5 +-
 include/uapi/linux/signalfd.h                 |   4 +-
 kernel/events/core.c                          | 130 ++++++++-
 kernel/fork.c                                 |   2 +-
 kernel/signal.c                               |  11 +
 .../testing/selftests/perf_events/.gitignore  |   3 +
 tools/testing/selftests/perf_events/Makefile  |   6 +
 tools/testing/selftests/perf_events/config    |   1 +
 .../selftests/perf_events/remove_on_exec.c    | 256 ++++++++++++++++++
 tools/testing/selftests/perf_events/settings  |   1 +
 .../selftests/perf_events/sigtrap_threads.c   | 202 ++++++++++++++
 18 files changed, 632 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/perf_events/.gitignore
 create mode 100644 tools/testing/selftests/perf_events/Makefile
 create mode 100644 tools/testing/selftests/perf_events/config
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c
 create mode 100644 tools/testing/selftests/perf_events/settings
 create mode 100644 tools/testing/selftests/perf_events/sigtrap_threads.c

-- 
2.30.1.766.gb4fecdf3b7-goog

