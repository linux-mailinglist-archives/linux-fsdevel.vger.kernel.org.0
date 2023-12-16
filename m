Return-Path: <linux-fsdevel+bounces-6263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 673768156CD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27A61F25A3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6A1E4A3;
	Sat, 16 Dec 2023 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWnhaoch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52C91A702
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXxCqM/e1FB55uLwmZS35mh8NG7r88Szct15Gk8BhFo=;
	b=CWnhaochAsy6lJqiTdhs4ALt36jqcdkjrNNJLlyCebEcFi77MIzyYchlT3ZKJp1qkdUw+a
	g0rIYF+ygVVf8ox5ZVu6ZtsSjccEjMWnuC+TuJrABdg1a1z78QjuI4/k+JkyWcRCwukZQH
	B+GcssvUHU4Q2y2LmE/gokgKLEfZqPU=
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
Subject: [PATCH 19/50] locking/mutex: split out mutex_types.h
Date: Fri, 15 Dec 2023 22:26:18 -0500
Message-ID: <20231216032651.3553101-9-kent.overstreet@linux.dev>
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

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/mutex.h       | 52 +--------------------------
 include/linux/mutex_types.h | 71 +++++++++++++++++++++++++++++++++++++
 include/linux/sched.h       |  2 +-
 3 files changed, 73 insertions(+), 52 deletions(-)
 create mode 100644 include/linux/mutex_types.h

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a33aa9eb9fc3..0dfba5df6524 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,7 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 #include <linux/cleanup.h>
+#include <linux/mutex_types.h>
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
@@ -33,49 +34,6 @@
 
 #ifndef CONFIG_PREEMPT_RT
 
-/*
- * Simple, straightforward mutexes with strict semantics:
- *
- * - only one task can hold the mutex at a time
- * - only the owner can unlock the mutex
- * - multiple unlocks are not permitted
- * - recursive locking is not permitted
- * - a mutex object must be initialized via the API
- * - a mutex object must not be initialized via memset or copying
- * - task may not exit with mutex held
- * - memory areas where held locks reside must not be freed
- * - held mutexes must not be reinitialized
- * - mutexes may not be used in hardware or software interrupt
- *   contexts such as tasklets and timers
- *
- * These semantics are fully enforced when DEBUG_MUTEXES is
- * enabled. Furthermore, besides enforcing the above rules, the mutex
- * debugging code also implements a number of additional features
- * that make lock debugging easier and faster:
- *
- * - uses symbolic names of mutexes, whenever they are printed in debug output
- * - point-of-acquire tracking, symbolic lookup of function names
- * - list of all locks held in the system, printout of them
- * - owner tracking
- * - detects self-recursing locks and prints out all relevant info
- * - detects multi-task circular deadlocks and prints out all affected
- *   locks and tasks (and only those tasks)
- */
-struct mutex {
-	atomic_long_t		owner;
-	raw_spinlock_t		wait_lock;
-#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
-	struct optimistic_spin_queue osq; /* Spinner MCS lock */
-#endif
-	struct list_head	wait_list;
-#ifdef CONFIG_DEBUG_MUTEXES
-	void			*magic;
-#endif
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
-
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
@@ -131,14 +89,6 @@ extern bool mutex_is_locked(struct mutex *lock);
 /*
  * Preempt-RT variant based on rtmutexes.
  */
-#include <linux/rtmutex.h>
-
-struct mutex {
-	struct rt_mutex_base	rtmutex;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map	dep_map;
-#endif
-};
 
 #define __MUTEX_INITIALIZER(mutexname)					\
 {									\
diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
new file mode 100644
index 000000000000..fdf7f515fde8
--- /dev/null
+++ b/include/linux/mutex_types.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_MUTEX_TYPES_H
+#define __LINUX_MUTEX_TYPES_H
+
+#include <linux/atomic.h>
+#include <linux/lockdep_types.h>
+#include <linux/osq_lock.h>
+#include <linux/spinlock_types.h>
+#include <linux/types.h>
+
+#ifndef CONFIG_PREEMPT_RT
+
+/*
+ * Simple, straightforward mutexes with strict semantics:
+ *
+ * - only one task can hold the mutex at a time
+ * - only the owner can unlock the mutex
+ * - multiple unlocks are not permitted
+ * - recursive locking is not permitted
+ * - a mutex object must be initialized via the API
+ * - a mutex object must not be initialized via memset or copying
+ * - task may not exit with mutex held
+ * - memory areas where held locks reside must not be freed
+ * - held mutexes must not be reinitialized
+ * - mutexes may not be used in hardware or software interrupt
+ *   contexts such as tasklets and timers
+ *
+ * These semantics are fully enforced when DEBUG_MUTEXES is
+ * enabled. Furthermore, besides enforcing the above rules, the mutex
+ * debugging code also implements a number of additional features
+ * that make lock debugging easier and faster:
+ *
+ * - uses symbolic names of mutexes, whenever they are printed in debug output
+ * - point-of-acquire tracking, symbolic lookup of function names
+ * - list of all locks held in the system, printout of them
+ * - owner tracking
+ * - detects self-recursing locks and prints out all relevant info
+ * - detects multi-task circular deadlocks and prints out all affected
+ *   locks and tasks (and only those tasks)
+ */
+struct mutex {
+	atomic_long_t		owner;
+	raw_spinlock_t		wait_lock;
+#ifdef CONFIG_MUTEX_SPIN_ON_OWNER
+	struct optimistic_spin_queue osq; /* Spinner MCS lock */
+#endif
+	struct list_head	wait_list;
+#ifdef CONFIG_DEBUG_MUTEXES
+	void			*magic;
+#endif
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#else /* !CONFIG_PREEMPT_RT */
+/*
+ * Preempt-RT variant based on rtmutexes.
+ */
+#include <linux/rtmutex.h>
+
+struct mutex {
+	struct rt_mutex_base	rtmutex;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+#endif /* CONFIG_PREEMPT_RT */
+
+#endif /* __LINUX_MUTEX_TYPES_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3762809652da..e8892789969b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -15,7 +15,7 @@
 #include <linux/sem.h>
 #include <linux/shm.h>
 #include <linux/kmsan_types.h>
-#include <linux/mutex.h>
+#include <linux/mutex_types.h>
 #include <linux/plist.h>
 #include <linux/hrtimer_types.h>
 #include <linux/irqflags.h>
-- 
2.43.0


