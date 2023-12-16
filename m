Return-Path: <linux-fsdevel+bounces-6265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53C48156D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E7E7281C1F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6089530347;
	Sat, 16 Dec 2023 03:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aaiz38pz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF01EB44
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ERZYSmZBhuvvvnoYNYpkA3Vl+n3Jximiv1YGZ7OitLQ=;
	b=aaiz38pzKiugC7Tlg40b87BRR7qNJ7SLJQXvUkpdJM+Lutdum8RxgQdiWqRBF8d9+kXBci
	8dAv7dkfFinK2AYiUgdDki2xwVSVyOnDuDr6pLssATxbY1vRtr0MkZvomYziXMZRlSCGfx
	xau0WAmrv1ShMUk4AXdY6FF6ZxeArLk=
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
Subject: [PATCH 21/50] locking/seqlock: Split out seqlock_types.h
Date: Fri, 15 Dec 2023 22:26:20 -0500
Message-ID: <20231216032651.3553101-11-kent.overstreet@linux.dev>
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

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/sched.h         |  2 +-
 include/linux/seqlock.h       | 79 +----------------------------
 include/linux/seqlock_types.h | 93 +++++++++++++++++++++++++++++++++++
 3 files changed, 96 insertions(+), 78 deletions(-)
 create mode 100644 include/linux/seqlock_types.h

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6d803d0904d9..436f7ce1450a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -33,7 +33,7 @@
 #include <linux/task_io_accounting.h>
 #include <linux/posix-timers_types.h>
 #include <linux/rseq.h>
-#include <linux/seqlock.h>
+#include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
 #include <linux/livepatch_sched.h>
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e92f9d5577ba..d90d8ee29d81 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -18,6 +18,7 @@
 #include <linux/lockdep.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
+#include <linux/seqlock_types.h>
 #include <linux/spinlock.h>
 
 #include <asm/processor.h>
@@ -37,37 +38,6 @@
  */
 #define KCSAN_SEQLOCK_REGION_MAX 1000
 
-/*
- * Sequence counters (seqcount_t)
- *
- * This is the raw counting mechanism, without any writer protection.
- *
- * Write side critical sections must be serialized and non-preemptible.
- *
- * If readers can be invoked from hardirq or softirq contexts,
- * interrupts or bottom halves must also be respectively disabled before
- * entering the write section.
- *
- * This mechanism can't be used if the protected data contains pointers,
- * as the writer can invalidate a pointer that a reader is following.
- *
- * If the write serialization mechanism is one of the common kernel
- * locking primitives, use a sequence counter with associated lock
- * (seqcount_LOCKNAME_t) instead.
- *
- * If it's desired to automatically handle the sequence counter writer
- * serialization and non-preemptibility requirements, use a sequential
- * lock (seqlock_t) instead.
- *
- * See Documentation/locking/seqlock.rst
- */
-typedef struct seqcount {
-	unsigned sequence;
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-	struct lockdep_map dep_map;
-#endif
-} seqcount_t;
-
 static inline void __seqcount_init(seqcount_t *s, const char *name,
 					  struct lock_class_key *key)
 {
@@ -131,28 +101,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * See Documentation/locking/seqlock.rst
  */
 
-/*
- * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
- * disable preemption. It can lead to higher latencies, and the write side
- * sections will not be able to acquire locks which become sleeping locks
- * (e.g. spinlock_t).
- *
- * To remain preemptible while avoiding a possible livelock caused by the
- * reader preempting the writer, use a different technique: let the reader
- * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
- * case, acquire then release the associated LOCKNAME writer serialization
- * lock. This will allow any possibly-preempted writer to make progress
- * until the end of its writer serialization lock critical section.
- *
- * This lock-unlock technique must be implemented for all of PREEMPT_RT
- * sleeping locks.  See Documentation/locking/locktypes.rst
- */
-#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
-#define __SEQ_LOCK(expr)	expr
-#else
-#define __SEQ_LOCK(expr)
-#endif
-
 /*
  * typedef seqcount_LOCKNAME_t - sequence counter with LOCKNAME associated
  * @seqcount:	The real sequence counter
@@ -194,11 +142,6 @@ static inline void seqcount_lockdep_reader_access(const seqcount_t *s)
  * @lockbase:		prefix for associated lock/unlock
  */
 #define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
-typedef struct seqcount_##lockname {					\
-	seqcount_t		seqcount;				\
-	__SEQ_LOCK(locktype	*lock);					\
-} seqcount_##lockname##_t;						\
-									\
 static __always_inline seqcount_t *					\
 __seqprop_##lockname##_ptr(seqcount_##lockname##_t *s)			\
 {									\
@@ -284,6 +227,7 @@ SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
 SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
 SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
 SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
+#undef SEQCOUNT_LOCKNAME
 
 /*
  * SEQCNT_LOCKNAME_ZERO - static initializer for seqcount_LOCKNAME_t
@@ -794,25 +738,6 @@ static inline void raw_write_seqcount_latch(seqcount_latch_t *s)
 	smp_wmb();      /* increment "sequence" before following stores */
 }
 
-/*
- * Sequential locks (seqlock_t)
- *
- * Sequence counters with an embedded spinlock for writer serialization
- * and non-preemptibility.
- *
- * For more info, see:
- *    - Comments on top of seqcount_t
- *    - Documentation/locking/seqlock.rst
- */
-typedef struct {
-	/*
-	 * Make sure that readers don't starve writers on PREEMPT_RT: use
-	 * seqcount_spinlock_t instead of seqcount_t. Check __SEQ_LOCK().
-	 */
-	seqcount_spinlock_t seqcount;
-	spinlock_t lock;
-} seqlock_t;
-
 #define __SEQLOCK_UNLOCKED(lockname)					\
 	{								\
 		.seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
diff --git a/include/linux/seqlock_types.h b/include/linux/seqlock_types.h
new file mode 100644
index 000000000000..dfdf43e3fa3d
--- /dev/null
+++ b/include/linux/seqlock_types.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SEQLOCK_TYPES_H
+#define __LINUX_SEQLOCK_TYPES_H
+
+#include <linux/lockdep_types.h>
+#include <linux/mutex_types.h>
+#include <linux/spinlock_types.h>
+
+/*
+ * Sequence counters (seqcount_t)
+ *
+ * This is the raw counting mechanism, without any writer protection.
+ *
+ * Write side critical sections must be serialized and non-preemptible.
+ *
+ * If readers can be invoked from hardirq or softirq contexts,
+ * interrupts or bottom halves must also be respectively disabled before
+ * entering the write section.
+ *
+ * This mechanism can't be used if the protected data contains pointers,
+ * as the writer can invalidate a pointer that a reader is following.
+ *
+ * If the write serialization mechanism is one of the common kernel
+ * locking primitives, use a sequence counter with associated lock
+ * (seqcount_LOCKNAME_t) instead.
+ *
+ * If it's desired to automatically handle the sequence counter writer
+ * serialization and non-preemptibility requirements, use a sequential
+ * lock (seqlock_t) instead.
+ *
+ * See Documentation/locking/seqlock.rst
+ */
+typedef struct seqcount {
+	unsigned sequence;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map dep_map;
+#endif
+} seqcount_t;
+
+/*
+ * For PREEMPT_RT, seqcount_LOCKNAME_t write side critical sections cannot
+ * disable preemption. It can lead to higher latencies, and the write side
+ * sections will not be able to acquire locks which become sleeping locks
+ * (e.g. spinlock_t).
+ *
+ * To remain preemptible while avoiding a possible livelock caused by the
+ * reader preempting the writer, use a different technique: let the reader
+ * detect if a seqcount_LOCKNAME_t writer is in progress. If that is the
+ * case, acquire then release the associated LOCKNAME writer serialization
+ * lock. This will allow any possibly-preempted writer to make progress
+ * until the end of its writer serialization lock critical section.
+ *
+ * This lock-unlock technique must be implemented for all of PREEMPT_RT
+ * sleeping locks.  See Documentation/locking/locktypes.rst
+ */
+#if defined(CONFIG_LOCKDEP) || defined(CONFIG_PREEMPT_RT)
+#define __SEQ_LOCK(expr)	expr
+#else
+#define __SEQ_LOCK(expr)
+#endif
+
+#define SEQCOUNT_LOCKNAME(lockname, locktype, preemptible, lockbase)	\
+typedef struct seqcount_##lockname {					\
+	seqcount_t		seqcount;				\
+	__SEQ_LOCK(locktype	*lock);					\
+} seqcount_##lockname##_t;
+
+SEQCOUNT_LOCKNAME(raw_spinlock, raw_spinlock_t,  false,    raw_spin)
+SEQCOUNT_LOCKNAME(spinlock,     spinlock_t,      __SEQ_RT, spin)
+SEQCOUNT_LOCKNAME(rwlock,       rwlock_t,        __SEQ_RT, read)
+SEQCOUNT_LOCKNAME(mutex,        struct mutex,    true,     mutex)
+#undef SEQCOUNT_LOCKNAME
+
+/*
+ * Sequential locks (seqlock_t)
+ *
+ * Sequence counters with an embedded spinlock for writer serialization
+ * and non-preemptibility.
+ *
+ * For more info, see:
+ *    - Comments on top of seqcount_t
+ *    - Documentation/locking/seqlock.rst
+ */
+typedef struct {
+	/*
+	 * Make sure that readers don't starve writers on PREEMPT_RT: use
+	 * seqcount_spinlock_t instead of seqcount_t. Check __SEQ_LOCK().
+	 */
+	seqcount_spinlock_t seqcount;
+	spinlock_t lock;
+} seqlock_t;
+
+#endif /* __LINUX_SEQLOCK_TYPES_H */
-- 
2.43.0


