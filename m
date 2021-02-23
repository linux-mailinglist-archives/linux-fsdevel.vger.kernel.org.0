Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D703C322C72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 15:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbhBWOf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 09:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbhBWOf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 09:35:26 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2867C061786
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:45 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id k28so10083794qtu.17
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 06:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Q8hQJDMeUJlqSjrNYnPafLaJX5CJRNsJS+XYHF26pcU=;
        b=PJnNVGeDqB/jzzRFb43n6pABAUatJLV3VpoQVilcEqdrryJp08zjPufvVz5cFPnSEY
         t/li1aI0RjRwp7z2bUQbnWYCBL0UM2aSKop0ae9s2DpamNAajkWv+hxDEW2W9qIUp36d
         PAkr+ieLWes8nDdQ/+SEvLNzI2fhbLggfEVRl9YrCoom2ez47kSRP4/0+WUFn/kOA6Dt
         tTkwHtzevwds9t+smuh8yccupDpw+dh//SW88nsBdvQXbwTAsE8g1S7IxFZI03HwubvC
         rBVvVUVzattE0GWgZFrJETMXyA15a2rVhKdtnp2DazMEJEX4XDqEecySE72Fjn1RZ8Z0
         L2rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Q8hQJDMeUJlqSjrNYnPafLaJX5CJRNsJS+XYHF26pcU=;
        b=VJwry7poyQZlfi4gkLjXIjA1/jtUECJ6opaqCsPkSgFlEJoRBPgTTs82IDw5iyYBVN
         OczqX4s8tsjNJv5gjbdb0gtrpmktT6//qpJNPVkMeHOU5+ZVT+LDHXQMxIfa9uyF3yTu
         ksaRljxsveT0ahd+tRU0Rq6QgWx0+3AHK1GwTOISRB4xz8iifaoA3sojaz82FZYZQDpn
         IA9zgMoMFrs+od5/v4ERjsxZjw1M35VMIFHat12OMm3A/Jb79JihozAQbjEkal2nQh2A
         yVrv2QT3Hu9vN1elKhBlCe6dKwLOXu9C6HLlz7lB+DWRo8q0JGVQBtu0pzETRv/13Eqv
         sZSQ==
X-Gm-Message-State: AOAM532VWxKb6BUdU0S458aJL8rXiE6GZRD9IHaEejTOI+fY0eNu9C34
        ZC6U2xvbufROLemzrU8TIrycCDh+jA==
X-Google-Smtp-Source: ABdhPJwIekUA4sFfcyjccindFCcQp2ep8MthgqSzW3N3MtGLmm1PZlc40koEqgpP+XoOBcmnN/Qv1jzPlw==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:855b:f924:6e71:3d5d])
 (user=elver job=sendgmr) by 2002:a0c:a8cf:: with SMTP id h15mr25576657qvc.20.1614090884790;
 Tue, 23 Feb 2021 06:34:44 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:34:22 +0100
Message-Id: <20210223143426.2412737-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH RFC 0/4] Add support for synchronous signals on perf events
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
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org
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

The discussion at [1] led to the changes proposed in this series. The
approach taken in patch 3/4 to use 'event_limit' to trigger the signal
was kindly suggested by Peter Zijlstra in [2].

[1] https://lore.kernel.org/lkml/CACT4Y+YPrXGw+AtESxAgPyZ84TYkNZdP0xpocX2jwVAbZD=-XQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/ 

Motivation and example uses:

1. 	Our immediate motivation is low-overhead sampling-based race
	detection for user-space [3]. By using perf_event_open() at
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

Other example use-cases we found potentially interesting:

3.	Code hot patching without full stop-the-world. Specifically, by
	setting a code breakpoint to entry to the patched routine, then
	send signals to threads and check that they are not in the
	routine, but without stopping them further. If any of the
	threads will enter the routine, it will receive SIGTRAP and
	pause.

4. 	Safepoints without mprotect(). Some Java implementations use
	"load from a known memory location" as a safepoint. When threads
	need to be stopped, the page containing the location is
	mprotect()ed and threads get a signal. This can be replaced with
	a watchpoint, which does not require a whole page nor DTLB
	shootdowns.

5.	Tracking data flow globally.

6.	Threads receiving signals on performance events to
	throttle/unthrottle themselves.


Marco Elver (4):
  perf/core: Apply PERF_EVENT_IOC_MODIFY_ATTRIBUTES to children
  signal: Introduce TRAP_PERF si_code and si_perf to siginfo
  perf/core: Add support for SIGTRAP on perf events
  perf/core: Add breakpoint information to siginfo on SIGTRAP

 arch/m68k/kernel/signal.c          |  3 ++
 arch/x86/kernel/signal_compat.c    |  5 ++-
 fs/signalfd.c                      |  4 +++
 include/linux/compat.h             |  2 ++
 include/linux/signal.h             |  1 +
 include/uapi/asm-generic/siginfo.h |  6 +++-
 include/uapi/linux/perf_event.h    |  3 +-
 include/uapi/linux/signalfd.h      |  4 ++-
 kernel/events/core.c               | 54 +++++++++++++++++++++++++++++-
 kernel/signal.c                    | 11 ++++++
 10 files changed, 88 insertions(+), 5 deletions(-)

-- 
2.30.0.617.g56c4b15f3c-goog

