Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF523580B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhDHKg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 06:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhDHKg6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 06:36:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE3C061760
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Apr 2021 03:36:46 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g18so983361qki.15
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Apr 2021 03:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EzmzmhSLYOYTzia53fwYPMbr67HMT97fl1vfB43xxy0=;
        b=CE/uDe25jrKi/EcWF45IReCs/HFAUYt/zKGAJidnrsKwFNUr8ELTjdagRfyFQubgHp
         iGKU1yedoQKg9fMIiEMOCB3X5xySq6bxtlRa7gbdIy84EcFI+ZaBdYUSX0YGoN8IbF8Y
         saaPZu8y4+OBvZpN3gGUiW2h2NqH9Vs2Xvh3RRI8U9gXA6pbiZJREjQO1swkLYN40VjR
         EEB2PGx7uESg3MkI3iaXTokKj92jpxPJhoTB83ZiPUqToht77ooyoWVfhaEtMHA5zTId
         F+shhJlLS7yvXzL8u6aTmnR31XOQyP31C6qewYpqfFP9Cq1PfrEdoURacVW5ZRCY87G1
         mtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EzmzmhSLYOYTzia53fwYPMbr67HMT97fl1vfB43xxy0=;
        b=es0zD8JyJ/mPw9xSc1kAONgDrmb9SnTWHbI9kMPO5WMPeucUGBeWQOc6CWGc17E+Dm
         vgLRMaeyJV9awEffQ6tLft+6XARJwo5VDYe9D/c2raI7BuokP9gBk8/9rqHm7Btc83Mw
         l5rL+/A+hAlB3VKxChKnfrDRfwEIDme6Gc6iKfx46SujFRzUJbI9QXcOvWduBFvedADS
         5cdxku+RQER7cxPFklD3/Hk7xrj1uxdRR9pbWGGsuhTiL5o7x8pbL5i/GG73lanXA2hP
         LTTcpkXbhG+KB1iCrkyRQUNUndY9hQngBreGX4Q+Vm8VdguzBHDq5xU2fzD+Fdq5jGRf
         ayzQ==
X-Gm-Message-State: AOAM531A/DVG/qOxyo8wzQgR3chwNzepQKpD+34AM+w/GYRg/gOgWYyR
        TD14a1kfaEnXjH0l5wktIf1ccM6u9g==
X-Google-Smtp-Source: ABdhPJzB0aHqU6Vvk6OAMCFdlq8fMrwJtVqGP2BZ9KnPFLZKFqsgLtH3YCZklfy1Z87D+fhG091DtXga6A==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a0c:b348:: with SMTP id a8mr7834915qvf.7.1617878205926;
 Thu, 08 Apr 2021 03:36:45 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:35:55 +0200
Message-Id: <20210408103605.1676875-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 00/10] Add support for synchronous signals on perf events
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
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
v4:
* Fix for parent and child racing to exit in sync_child_event().
* Fix race between irq_work running and task's sighand being released by
  release_task().
* Generalize setting si_perf and si_addr independent of event type;
  introduces perf_event_attr::sig_data, which can be set by user space
  to be propagated to si_perf.
* Warning in perf_sigtrap() if ctx->task and current mismatch; we expect
  this on architectures that do not properly implement
  arch_irq_work_raise().
* Require events that want sigtrap to be associated with a task.
* Dropped "perf: Add breakpoint information to siginfo on SIGTRAP"
  in favor of more generic solution (perf_event_attr::sig_data).

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

Marco Elver (9):
  perf: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
  perf: Support only inheriting events if cloned with CLONE_THREAD
  perf: Add support for event removal on exec
  signal: Introduce TRAP_PERF si_code and si_perf to siginfo
  perf: Add support for SIGTRAP on perf events
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
 include/linux/perf_event.h                    |   9 +-
 include/linux/signal.h                        |   1 +
 include/uapi/asm-generic/siginfo.h            |   6 +-
 include/uapi/linux/perf_event.h               |  12 +-
 include/uapi/linux/signalfd.h                 |   4 +-
 kernel/events/core.c                          | 302 +++++++++++++-----
 kernel/fork.c                                 |   2 +-
 kernel/signal.c                               |  11 +
 tools/include/uapi/linux/perf_event.h         |  12 +-
 tools/perf/tests/Build                        |   1 +
 tools/perf/tests/builtin-test.c               |   5 +
 tools/perf/tests/sigtrap.c                    | 150 +++++++++
 tools/perf/tests/tests.h                      |   1 +
 .../testing/selftests/perf_events/.gitignore  |   3 +
 tools/testing/selftests/perf_events/Makefile  |   6 +
 tools/testing/selftests/perf_events/config    |   1 +
 .../selftests/perf_events/remove_on_exec.c    | 260 +++++++++++++++
 tools/testing/selftests/perf_events/settings  |   1 +
 .../selftests/perf_events/sigtrap_threads.c   | 210 ++++++++++++
 23 files changed, 924 insertions(+), 87 deletions(-)
 create mode 100644 tools/perf/tests/sigtrap.c
 create mode 100644 tools/testing/selftests/perf_events/.gitignore
 create mode 100644 tools/testing/selftests/perf_events/Makefile
 create mode 100644 tools/testing/selftests/perf_events/config
 create mode 100644 tools/testing/selftests/perf_events/remove_on_exec.c
 create mode 100644 tools/testing/selftests/perf_events/settings
 create mode 100644 tools/testing/selftests/perf_events/sigtrap_threads.c

-- 
2.31.0.208.g409f899ff0-goog

