Return-Path: <linux-fsdevel+bounces-6264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245A08156CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08A1286648
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB123250E9;
	Sat, 16 Dec 2023 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WjeFrxkX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C51E491
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/AdYiLA1KltWXM4Dxc7KA8BrnvhZi0rzVoxoyzH4FI=;
	b=WjeFrxkXi1mg3nVsknIKn9D4C1XdNFTO0PyYeLNXygJ7fW9bGO8/r5DFvTSy/o7YAO3aDL
	CwryBhsCe7GWkRdm8opahT7ZQF/7VLDL592uUhZBpKntwuo8AOi4BQytpQ+Wtwy0Y1vswk
	QI4WciWS+qDGbdeKSjNd2uhUDmIkm/o=
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
Subject: [PATCH 20/50] posix-cpu-timers: Split out posix-timers_types.h
Date: Fri, 15 Dec 2023 22:26:19 -0500
Message-ID: <20231216032651.3553101-10-kent.overstreet@linux.dev>
In-Reply-To: <20231216032651.3553101-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032651.3553101-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Trimming down sched.h dependencies: we don't want to include more than
the base types.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/posix-timers.h       | 68 ++--------------------------
 include/linux/posix-timers_types.h | 72 ++++++++++++++++++++++++++++++
 include/linux/sched.h              |  2 +-
 3 files changed, 76 insertions(+), 66 deletions(-)
 create mode 100644 include/linux/posix-timers_types.h

diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index d607f51404fc..750b0647258d 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -2,40 +2,16 @@
 #ifndef _linux_POSIX_TIMERS_H
 #define _linux_POSIX_TIMERS_H
 
-#include <linux/spinlock.h>
+#include <linux/alarmtimer.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
-#include <linux/alarmtimer.h>
+#include <linux/posix-timers_types.h>
+#include <linux/spinlock.h>
 #include <linux/timerqueue.h>
 
 struct kernel_siginfo;
 struct task_struct;
 
-/*
- * Bit fields within a clockid:
- *
- * The most significant 29 bits hold either a pid or a file descriptor.
- *
- * Bit 2 indicates whether a cpu clock refers to a thread or a process.
- *
- * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
- *
- * A clockid is invalid if bits 2, 1, and 0 are all set.
- */
-#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
-#define CPUCLOCK_PERTHREAD(clock) \
-	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
-
-#define CPUCLOCK_PERTHREAD_MASK	4
-#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
-#define CPUCLOCK_CLOCK_MASK	3
-#define CPUCLOCK_PROF		0
-#define CPUCLOCK_VIRT		1
-#define CPUCLOCK_SCHED		2
-#define CPUCLOCK_MAX		3
-#define CLOCKFD			CPUCLOCK_MAX
-#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
-
 static inline clockid_t make_process_cpuclock(const unsigned int pid,
 		const clockid_t clock)
 {
@@ -109,44 +85,6 @@ static inline void cpu_timer_setexpires(struct cpu_timer *ctmr, u64 exp)
 	ctmr->node.expires = exp;
 }
 
-/**
- * posix_cputimer_base - Container per posix CPU clock
- * @nextevt:		Earliest-expiration cache
- * @tqhead:		timerqueue head for cpu_timers
- */
-struct posix_cputimer_base {
-	u64			nextevt;
-	struct timerqueue_head	tqhead;
-};
-
-/**
- * posix_cputimers - Container for posix CPU timer related data
- * @bases:		Base container for posix CPU clocks
- * @timers_active:	Timers are queued.
- * @expiry_active:	Timer expiry is active. Used for
- *			process wide timers to avoid multiple
- *			task trying to handle expiry concurrently
- *
- * Used in task_struct and signal_struct
- */
-struct posix_cputimers {
-	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
-	unsigned int			timers_active;
-	unsigned int			expiry_active;
-};
-
-/**
- * posix_cputimers_work - Container for task work based posix CPU timer expiry
- * @work:	The task work to be scheduled
- * @mutex:	Mutex held around expiry in context of this task work
- * @scheduled:  @work has been scheduled already, no further processing
- */
-struct posix_cputimers_work {
-	struct callback_head	work;
-	struct mutex		mutex;
-	unsigned int		scheduled;
-};
-
 static inline void posix_cputimers_init(struct posix_cputimers *pct)
 {
 	memset(pct, 0, sizeof(*pct));
diff --git a/include/linux/posix-timers_types.h b/include/linux/posix-timers_types.h
new file mode 100644
index 000000000000..57fec639a9bb
--- /dev/null
+++ b/include/linux/posix-timers_types.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _linux_POSIX_TIMERS_TYPES_H
+#define _linux_POSIX_TIMERS_TYPES_H
+
+#include <linux/mutex_types.h>
+#include <linux/timerqueue.h>
+#include <linux/types.h>
+
+/*
+ * Bit fields within a clockid:
+ *
+ * The most significant 29 bits hold either a pid or a file descriptor.
+ *
+ * Bit 2 indicates whether a cpu clock refers to a thread or a process.
+ *
+ * Bits 1 and 0 give the type: PROF=0, VIRT=1, SCHED=2, or FD=3.
+ *
+ * A clockid is invalid if bits 2, 1, and 0 are all set.
+ */
+#define CPUCLOCK_PID(clock)		((pid_t) ~((clock) >> 3))
+#define CPUCLOCK_PERTHREAD(clock) \
+	(((clock) & (clockid_t) CPUCLOCK_PERTHREAD_MASK) != 0)
+
+#define CPUCLOCK_PERTHREAD_MASK	4
+#define CPUCLOCK_WHICH(clock)	((clock) & (clockid_t) CPUCLOCK_CLOCK_MASK)
+#define CPUCLOCK_CLOCK_MASK	3
+#define CPUCLOCK_PROF		0
+#define CPUCLOCK_VIRT		1
+#define CPUCLOCK_SCHED		2
+#define CPUCLOCK_MAX		3
+#define CLOCKFD			CPUCLOCK_MAX
+#define CLOCKFD_MASK		(CPUCLOCK_PERTHREAD_MASK|CPUCLOCK_CLOCK_MASK)
+
+/**
+ * posix_cputimer_base - Container per posix CPU clock
+ * @nextevt:		Earliest-expiration cache
+ * @tqhead:		timerqueue head for cpu_timers
+ */
+struct posix_cputimer_base {
+	u64			nextevt;
+	struct timerqueue_head	tqhead;
+};
+
+/**
+ * posix_cputimers - Container for posix CPU timer related data
+ * @bases:		Base container for posix CPU clocks
+ * @timers_active:	Timers are queued.
+ * @expiry_active:	Timer expiry is active. Used for
+ *			process wide timers to avoid multiple
+ *			task trying to handle expiry concurrently
+ *
+ * Used in task_struct and signal_struct
+ */
+struct posix_cputimers {
+	struct posix_cputimer_base	bases[CPUCLOCK_MAX];
+	unsigned int			timers_active;
+	unsigned int			expiry_active;
+};
+
+/**
+ * posix_cputimers_work - Container for task work based posix CPU timer expiry
+ * @work:	The task work to be scheduled
+ * @mutex:	Mutex held around expiry in context of this task work
+ * @scheduled:  @work has been scheduled already, no further processing
+ */
+struct posix_cputimers_work {
+	struct callback_head	work;
+	struct mutex		mutex;
+	unsigned int		scheduled;
+};
+
+#endif /* _linux_POSIX_TIMERS_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e8892789969b..6d803d0904d9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -31,7 +31,7 @@
 #include <linux/syscall_user_dispatch.h>
 #include <linux/mm_types_task.h>
 #include <linux/task_io_accounting.h>
-#include <linux/posix-timers.h>
+#include <linux/posix-timers_types.h>
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
-- 
2.43.0


