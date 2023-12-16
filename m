Return-Path: <linux-fsdevel+bounces-6244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F400D815675
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4953E1F2549B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252BA1C32;
	Sat, 16 Dec 2023 02:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AG54kKMy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD91841;
	Sat, 16 Dec 2023 02:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702694922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pQCAhoEImgBg9eAn9p/zgb0DuNZMF2oFAp8brsnsG30=;
	b=AG54kKMye/qE90KrJ5rpolVHuXkgTtjqCucD5+A52XcR/kspSjNJ8LY+bHs4VH5y6aPOv1
	xst6Kr5GNYzmhKRNWkOrjPv4izdjI0aBSSjqVQfxeaMlcWTAWTUrAABY43dpyUX5uEwUmn
	bYYfMNwSU8TCkUtaSpOuwzof/USiMZs=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 00/50] big header dependency cleanup targeting sched.h
Date: Fri, 15 Dec 2023 21:47:41 -0500
Message-ID: <20231216024834.3510073-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

the issue being targeted here is that sched.h is entirely too much of an
everything header, and a nexus of recursive header dependencies.

the main strategy is to try to only pull type definitions into sched.h,
by splitting out *_types.h versions of sched.h dependencies, and
secondarily moving code out of sched.h into more appropriate locations.

this patchset does not go quite as far as I would have liked;
arch/x86/include/asm/processor.h also pulls in way too much, and I would
like to also split out a _types.h version for that, but that would
entail changing every arch's version of that header and I'm not going to
tackle that yet.

if we do get that done, the number of headers pulled in by sched.h will
be cut approximately in half (from well over 300 to 170-180) on an
allyesconfig.

build tested on x86, still needs build testing on other archs

https://evilpiepirate.org/git/bcachefs.git/log/?h=header_cleanup

Kent Overstreet (49):
  drivers/gpu/drm/i915/i915_memcpy.c: fix missing includes
  x86/kernel/fpu/bugs.c: fix missing include
  x86/lib/cache-smp.c: fix missing include
  x86/include/asm/debugreg.h: fix missing include
  x86/include/asm/paravirt_types.h: fix missing include
  task_stack.h: add missing include
  nsproxy.h: add missing include
  kernel/fork.c: add missing include
  kmsan: add missing types.h dependency
  time_namespace.h: fix missing include
  nodemask: Split out include/linux/nodemask_types.h
  prandom: Remove unused include
  timekeeping: Kill percpu.h dependency
  arm64: Fix circular header dependency
  kernel/numa.c: Move logging out of numa.h
  sched.h: Move (spin|rwlock)_needbreak() to spinlock.h
  ktime.h: move ktime_t to types.h
  hrtimers: Split out hrtimer_types.h
  locking/mutex: split out mutex_types.h
  posix-cpu-timers: Split out posix-timers_types.h
  locking/seqlock: Split out seqlock_types.h
  pid: Split out pid_types.h
  sched.h: move pid helpers to pid.h
  plist: Split out plist_types.h
  rslib: kill bogus dependency on list.h
  timerqueue: Split out timerqueue_types.h
  signal: Kill bogus dependency on list.h
  timers: Split out timer_types.h
  workqueue: Split out workqueue_types.h
  shm: Slim down dependencies
  ipc: Kill bogus dependency on spinlock.h
  Split out irqflags_types.h
  mm_types_task.h: Trim dependencies
  cpumask: Split out cpumask_types.h
  syscall_user_dispatch.h: split out *_types.h
  x86/signal: kill dependency on time.h
  uapi/linux/resource.h: fix include
  refcount: Split out refcount_types.h
  seccomp: Split out seccomp_types.h
  uidgid: Split out uidgid_types.h
  sem: Split out sem_types.h
  lockdep: move held_lock to lockdep_types.h
  restart_block: Trim includes
  rseq: Split out rseq.h from sched.h
  preempt.h: Kill dependency on list.h
  thread_info, uaccess.h: Move HARDENED_USERCOPY to better location
  Kill unnecessary kernel.h include
  kill unnecessary thread_info.h include
  Kill sched.h dependency on rcupdate.h

Matthew Wilcox (Oracle) (1):
  wait: Remove uapi header file from main header file

 arch/arm64/include/asm/spectre.h            |   4 +-
 arch/x86/include/asm/current.h              |   1 +
 arch/x86/include/asm/debugreg.h             |   1 +
 arch/x86/include/asm/fpu/types.h            |   2 +
 arch/x86/include/asm/paravirt_types.h       |   2 +
 arch/x86/include/asm/percpu.h               |   2 +-
 arch/x86/include/asm/preempt.h              |   1 -
 arch/x86/include/asm/tlbbatch.h             |   2 +-
 arch/x86/include/uapi/asm/signal.h          |   1 -
 arch/x86/kernel/fpu/bugs.c                  |   1 +
 arch/x86/kernel/signal.c                    |   1 +
 arch/x86/lib/cache-smp.c                    |   1 +
 drivers/gpu/drm/i915/i915_memcpy.c          |   2 +
 drivers/target/target_core_xcopy.c          |   1 +
 fs/exec.c                                   |   1 +
 include/linux/audit.h                       |   1 +
 include/linux/cpumask.h                     |   4 +-
 include/linux/cpumask_types.h               |  12 +
 include/linux/dma-fence.h                   |   1 +
 include/linux/hrtimer.h                     |  46 +--
 include/linux/hrtimer_types.h               |  50 +++
 include/linux/ipc.h                         |   2 +-
 include/linux/irqflags.h                    |  14 +-
 include/linux/irqflags_types.h              |  22 ++
 include/linux/kmsan_types.h                 |   2 +
 include/linux/ktime.h                       |   8 +-
 include/linux/lockdep.h                     |  57 ----
 include/linux/lockdep_types.h               |  57 ++++
 include/linux/mm_types_task.h               |   7 +-
 include/linux/mutex.h                       |  52 +---
 include/linux/mutex_types.h                 |  71 +++++
 include/linux/nodemask.h                    |   2 +-
 include/linux/nodemask_types.h              |  10 +
 include/linux/nsproxy.h                     |   1 +
 include/linux/numa.h                        |  18 +-
 include/linux/pid.h                         | 140 ++++++++-
 include/linux/pid_types.h                   |  16 +
 include/linux/plist.h                       |  12 +-
 include/linux/plist_types.h                 |  17 ++
 include/linux/posix-timers.h                |  68 +----
 include/linux/posix-timers_types.h          |  72 +++++
 include/linux/prandom.h                     |   1 -
 include/linux/preempt.h                     |   6 +-
 include/linux/rcupdate.h                    |  11 +
 include/linux/refcount.h                    |  13 +-
 include/linux/refcount_types.h              |  19 ++
 include/linux/restart_block.h               |   2 +-
 include/linux/resume_user_mode.h            |   1 +
 include/linux/rhashtable-types.h            |   2 +-
 include/linux/rseq.h                        | 131 ++++++++
 include/linux/rslib.h                       |   1 -
 include/linux/sched.h                       | 320 ++------------------
 include/linux/sched/signal.h                |   1 +
 include/linux/sched/task_stack.h            |   1 +
 include/linux/seccomp.h                     |  22 +-
 include/linux/seccomp_types.h               |  26 ++
 include/linux/sem.h                         |  10 +-
 include/linux/sem_types.h                   |  13 +
 include/linux/seqlock.h                     |  79 +----
 include/linux/seqlock_types.h               |  93 ++++++
 include/linux/shm.h                         |   4 +-
 include/linux/signal.h                      |   1 +
 include/linux/signal_types.h                |   2 +-
 include/linux/spinlock.h                    |  31 ++
 include/linux/syscall_user_dispatch.h       |   9 +-
 include/linux/syscall_user_dispatch_types.h |  22 ++
 include/linux/thread_info.h                 |  49 ---
 include/linux/time_namespace.h              |   3 +
 include/linux/timekeeping.h                 |   1 +
 include/linux/timer.h                       |  16 +-
 include/linux/timer_types.h                 |  23 ++
 include/linux/timerqueue.h                  |  13 +-
 include/linux/timerqueue_types.h            |  17 ++
 include/linux/types.h                       |   3 +
 include/linux/uaccess.h                     |  49 +++
 include/linux/uidgid.h                      |  11 +-
 include/linux/uidgid_types.h                |  15 +
 include/linux/uio.h                         |   2 +-
 include/linux/wait.h                        |   1 -
 include/linux/workqueue.h                   |  16 +-
 include/linux/workqueue_types.h             |  25 ++
 include/uapi/linux/resource.h               |   2 +-
 init/init_task.c                            |   1 +
 ipc/shm.c                                   |   1 +
 kernel/Makefile                             |   1 +
 kernel/exit.c                               |   4 +-
 kernel/fork.c                               |   2 +
 kernel/futex/core.c                         |   1 +
 kernel/futex/requeue.c                      |   1 +
 kernel/futex/waitwake.c                     |   1 +
 kernel/numa.c                               |  24 ++
 kernel/pid_namespace.c                      |   1 +
 kernel/sched/core.c                         |   1 +
 mm/swapfile.c                               |   1 +
 security/selinux/hooks.c                    |   1 +
 security/smack/smack_lsm.c                  |   1 +
 96 files changed, 1068 insertions(+), 825 deletions(-)
 create mode 100644 include/linux/cpumask_types.h
 create mode 100644 include/linux/hrtimer_types.h
 create mode 100644 include/linux/irqflags_types.h
 create mode 100644 include/linux/mutex_types.h
 create mode 100644 include/linux/nodemask_types.h
 create mode 100644 include/linux/pid_types.h
 create mode 100644 include/linux/plist_types.h
 create mode 100644 include/linux/posix-timers_types.h
 create mode 100644 include/linux/refcount_types.h
 create mode 100644 include/linux/rseq.h
 create mode 100644 include/linux/seccomp_types.h
 create mode 100644 include/linux/sem_types.h
 create mode 100644 include/linux/seqlock_types.h
 create mode 100644 include/linux/syscall_user_dispatch_types.h
 create mode 100644 include/linux/timer_types.h
 create mode 100644 include/linux/timerqueue_types.h
 create mode 100644 include/linux/uidgid_types.h
 create mode 100644 include/linux/workqueue_types.h
 create mode 100644 kernel/numa.c

-- 
2.43.0


