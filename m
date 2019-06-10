Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387DD3BCB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2019 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389170AbfFJTOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 15:14:33 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:36351 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389152AbfFJTOc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 15:14:32 -0400
Received: by mail-ua1-f65.google.com with SMTP id 94so3529970uam.3;
        Mon, 10 Jun 2019 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hXrfDEoF/55M53i73uGkMDRlja8di0X+2AypmqfVHNw=;
        b=HG+V5/zvYTs/OcY+6lCJro/4MjxQLE9fc2bGIAYrMOchwrcdpbBzc/ylWiMde+HDP0
         Q7sdcOtN+mnS6ElF+MOaqEuoRwSMRGbt/wLFstfD3RrzI8Q2Fw9ls4mq4afMTqdIchaX
         ClFFJvzX1ARGpbyZ7YiqelIpLiVAqssZMBUjxviLbdD+rCPejPk47GmInwTOchKEEL2I
         XQq/aaOpL6qP9z1UYPigB0H9hL5iSx42aDHvtmWdcXqBEGYgIb3MfWY8lzPUyngY5R7T
         TroIShd6QuCN0lixcf3Rd1OMwLyvq7ETZ8aEIERmir9hiw7D37yVjxTTrpA29WCG0sm2
         SRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hXrfDEoF/55M53i73uGkMDRlja8di0X+2AypmqfVHNw=;
        b=bz+ogdBKq3eRvYBS+XApWOn4XC3MyH1iPH2LxP8BLPe+pfkbqVuybNR2oHOJY0vG21
         uDl+BIUqJK0YyA5evsOkwkq5paXn9MAgqvddxxA9Q2EZiL3pxa/U/3EB+srVgwzlCYlm
         jsB7W6Pji+3WBNbbTcFHewpBP1k3GuvtnXQGg0D2+kdTXATf4XK1+b4s9UUtBAqA2rdF
         QBwBFseZ9khtn6h4RbqlNRsx2v0Mb1LSN2XuEsJoMGe1b+BlFeblZx6JbmIsAa41Ahf8
         EFI/LKwNXd12e9+g8JMx9FzVYhXJxPfDvrMYDFffSKwrXqQqNI65Zlnpg2rZXf7F3bxt
         CXLw==
X-Gm-Message-State: APjAAAUA2gX59+nI7RdGYXwAeA+T5SfOLYCLSohRJufgb67JIoEEMzdE
        smAFDkGGpiWT94hooRUtA/jXODB2GA==
X-Google-Smtp-Source: APXvYqzgyrJme4y6dhoTeDlnTufFruTAUoP3Z3oZN38ufhtPFAUIr1r4mX1SDnHq92DBZtThmtGFyA==
X-Received: by 2002:a9f:25e9:: with SMTP id 96mr22056402uaf.95.1560194070090;
        Mon, 10 Jun 2019 12:14:30 -0700 (PDT)
Received: from kmo-pixel.hsd1.vt.comcast.net (c-71-234-172-214.hsd1.vt.comcast.net. [71.234.172.214])
        by smtp.gmail.com with ESMTPSA id t20sm4834014vkd.53.2019.06.10.12.14.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 12:14:29 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 02/12] locking: SIX locks (shared/intent/exclusive)
Date:   Mon, 10 Jun 2019 15:14:10 -0400
Message-Id: <20190610191420.27007-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610191420.27007-1-kent.overstreet@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

New lock for bcachefs, like read/write locks but with a third state,
intent.

Intent locks conflict with each other, but not with read locks; taking a
write lock requires first holding an intent lock.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/six.h     | 192 +++++++++++++++
 kernel/Kconfig.locks    |   3 +
 kernel/locking/Makefile |   1 +
 kernel/locking/six.c    | 512 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 708 insertions(+)
 create mode 100644 include/linux/six.h
 create mode 100644 kernel/locking/six.c

diff --git a/include/linux/six.h b/include/linux/six.h
new file mode 100644
index 0000000000..0fb1b2f493
--- /dev/null
+++ b/include/linux/six.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_SIX_H
+#define _LINUX_SIX_H
+
+/*
+ * Shared/intent/exclusive locks: sleepable read/write locks, much like rw
+ * semaphores, except with a third intermediate state, intent. Basic operations
+ * are:
+ *
+ * six_lock_read(&foo->lock);
+ * six_unlock_read(&foo->lock);
+ *
+ * six_lock_intent(&foo->lock);
+ * six_unlock_intent(&foo->lock);
+ *
+ * six_lock_write(&foo->lock);
+ * six_unlock_write(&foo->lock);
+ *
+ * Intent locks block other intent locks, but do not block read locks, and you
+ * must have an intent lock held before taking a write lock, like so:
+ *
+ * six_lock_intent(&foo->lock);
+ * six_lock_write(&foo->lock);
+ * six_unlock_write(&foo->lock);
+ * six_unlock_intent(&foo->lock);
+ *
+ * Other operations:
+ *
+ *   six_trylock_read()
+ *   six_trylock_intent()
+ *   six_trylock_write()
+ *
+ *   six_lock_downgrade():	convert from intent to read
+ *   six_lock_tryupgrade():	attempt to convert from read to intent
+ *
+ * Locks also embed a sequence number, which is incremented when the lock is
+ * locked or unlocked for write. The current sequence number can be grabbed
+ * while a lock is held from lock->state.seq; then, if you drop the lock you can
+ * use six_relock_(read|intent_write)(lock, seq) to attempt to retake the lock
+ * iff it hasn't been locked for write in the meantime.
+ *
+ * There are also operations that take the lock type as a parameter, where the
+ * type is one of SIX_LOCK_read, SIX_LOCK_intent, or SIX_LOCK_write:
+ *
+ *   six_lock_type(lock, type)
+ *   six_unlock_type(lock, type)
+ *   six_relock(lock, type, seq)
+ *   six_trylock_type(lock, type)
+ *   six_trylock_convert(lock, from, to)
+ *
+ * A lock may be held multiple types by the same thread (for read or intent,
+ * not write). However, the six locks code does _not_ implement the actual
+ * recursive checks itself though - rather, if your code (e.g. btree iterator
+ * code) knows that the current thread already has a lock held, and for the
+ * correct type, six_lock_increment() may be used to bump up the counter for
+ * that type - the only effect is that one more call to unlock will be required
+ * before the lock is unlocked.
+ */
+
+#include <linux/lockdep.h>
+#include <linux/osq_lock.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+#define SIX_LOCK_SEPARATE_LOCKFNS
+
+union six_lock_state {
+	struct {
+		atomic64_t	counter;
+	};
+
+	struct {
+		u64		v;
+	};
+
+	struct {
+		/* for waitlist_bitnr() */
+		unsigned long	l;
+	};
+
+	struct {
+		unsigned	read_lock:28;
+		unsigned	intent_lock:1;
+		unsigned	waiters:3;
+		/*
+		 * seq works much like in seqlocks: it's incremented every time
+		 * we lock and unlock for write.
+		 *
+		 * If it's odd write lock is held, even unlocked.
+		 *
+		 * Thus readers can unlock, and then lock again later iff it
+		 * hasn't been modified in the meantime.
+		 */
+		u32		seq;
+	};
+};
+
+enum six_lock_type {
+	SIX_LOCK_read,
+	SIX_LOCK_intent,
+	SIX_LOCK_write,
+};
+
+struct six_lock {
+	union six_lock_state	state;
+	unsigned		intent_lock_recurse;
+	struct task_struct	*owner;
+	struct optimistic_spin_queue osq;
+
+	raw_spinlock_t		wait_lock;
+	struct list_head	wait_list[2];
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
+};
+
+static __always_inline void __six_lock_init(struct six_lock *lock,
+					    const char *name,
+					    struct lock_class_key *key)
+{
+	atomic64_set(&lock->state.counter, 0);
+	raw_spin_lock_init(&lock->wait_lock);
+	INIT_LIST_HEAD(&lock->wait_list[SIX_LOCK_read]);
+	INIT_LIST_HEAD(&lock->wait_list[SIX_LOCK_intent]);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *) lock, sizeof(*lock));
+	lockdep_init_map(&lock->dep_map, name, key, 0);
+#endif
+}
+
+#define six_lock_init(lock)						\
+do {									\
+	static struct lock_class_key __key;				\
+									\
+	__six_lock_init((lock), #lock, &__key);				\
+} while (0)
+
+#define __SIX_VAL(field, _v)	(((union six_lock_state) { .field = _v }).v)
+
+#define __SIX_LOCK(type)						\
+bool six_trylock_##type(struct six_lock *);				\
+bool six_relock_##type(struct six_lock *, u32);				\
+void six_lock_##type(struct six_lock *);				\
+void six_unlock_##type(struct six_lock *);
+
+__SIX_LOCK(read)
+__SIX_LOCK(intent)
+__SIX_LOCK(write)
+#undef __SIX_LOCK
+
+#define SIX_LOCK_DISPATCH(type, fn, ...)			\
+	switch (type) {						\
+	case SIX_LOCK_read:					\
+		return fn##_read(__VA_ARGS__);			\
+	case SIX_LOCK_intent:					\
+		return fn##_intent(__VA_ARGS__);		\
+	case SIX_LOCK_write:					\
+		return fn##_write(__VA_ARGS__);			\
+	default:						\
+		BUG();						\
+	}
+
+static inline bool six_trylock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	SIX_LOCK_DISPATCH(type, six_trylock, lock);
+}
+
+static inline bool six_relock_type(struct six_lock *lock, enum six_lock_type type,
+		     unsigned seq)
+{
+	SIX_LOCK_DISPATCH(type, six_relock, lock, seq);
+}
+
+static inline void six_lock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	SIX_LOCK_DISPATCH(type, six_lock, lock);
+}
+
+static inline void six_unlock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	SIX_LOCK_DISPATCH(type, six_unlock, lock);
+}
+
+void six_lock_downgrade(struct six_lock *);
+bool six_lock_tryupgrade(struct six_lock *);
+bool six_trylock_convert(struct six_lock *, enum six_lock_type,
+			 enum six_lock_type);
+
+void six_lock_increment(struct six_lock *, enum six_lock_type);
+
+#endif /* _LINUX_SIX_H */
diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index fbba478ae5..ff3e6121ae 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -251,3 +251,6 @@ config ARCH_USE_QUEUED_RWLOCKS
 config QUEUED_RWLOCKS
 	def_bool y if ARCH_USE_QUEUED_RWLOCKS
 	depends on SMP
+
+config SIXLOCKS
+	bool
diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 392c7f23af..9a73c8564e 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem-xadd.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
 obj-$(CONFIG_WW_MUTEX_SELFTEST) += test-ww_mutex.o
+obj-$(CONFIG_SIXLOCKS) += six.o
diff --git a/kernel/locking/six.c b/kernel/locking/six.c
new file mode 100644
index 0000000000..9fa58b6fad
--- /dev/null
+++ b/kernel/locking/six.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <linux/log2.h>
+#include <linux/preempt.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/sched/rt.h>
+#include <linux/six.h>
+
+#ifdef DEBUG
+#define EBUG_ON(cond)		BUG_ON(cond)
+#else
+#define EBUG_ON(cond)		do {} while (0)
+#endif
+
+#define six_acquire(l, t)	lock_acquire(l, 0, t, 0, 0, NULL, _RET_IP_)
+#define six_release(l)		lock_release(l, 0, _RET_IP_)
+
+struct six_lock_vals {
+	/* Value we add to the lock in order to take the lock: */
+	u64			lock_val;
+
+	/* If the lock has this value (used as a mask), taking the lock fails: */
+	u64			lock_fail;
+
+	/* Value we add to the lock in order to release the lock: */
+	u64			unlock_val;
+
+	/* Mask that indicates lock is held for this type: */
+	u64			held_mask;
+
+	/* Waitlist we wakeup when releasing the lock: */
+	enum six_lock_type	unlock_wakeup;
+};
+
+#define __SIX_LOCK_HELD_read	__SIX_VAL(read_lock, ~0)
+#define __SIX_LOCK_HELD_intent	__SIX_VAL(intent_lock, ~0)
+#define __SIX_LOCK_HELD_write	__SIX_VAL(seq, 1)
+
+#define LOCK_VALS {							\
+	[SIX_LOCK_read] = {						\
+		.lock_val	= __SIX_VAL(read_lock, 1),		\
+		.lock_fail	= __SIX_LOCK_HELD_write,		\
+		.unlock_val	= -__SIX_VAL(read_lock, 1),		\
+		.held_mask	= __SIX_LOCK_HELD_read,			\
+		.unlock_wakeup	= SIX_LOCK_write,			\
+	},								\
+	[SIX_LOCK_intent] = {						\
+		.lock_val	= __SIX_VAL(intent_lock, 1),		\
+		.lock_fail	= __SIX_LOCK_HELD_intent,		\
+		.unlock_val	= -__SIX_VAL(intent_lock, 1),		\
+		.held_mask	= __SIX_LOCK_HELD_intent,		\
+		.unlock_wakeup	= SIX_LOCK_intent,			\
+	},								\
+	[SIX_LOCK_write] = {						\
+		.lock_val	= __SIX_VAL(seq, 1),			\
+		.lock_fail	= __SIX_LOCK_HELD_read,			\
+		.unlock_val	= __SIX_VAL(seq, 1),			\
+		.held_mask	= __SIX_LOCK_HELD_write,		\
+		.unlock_wakeup	= SIX_LOCK_read,			\
+	},								\
+}
+
+static inline void six_set_owner(struct six_lock *lock, enum six_lock_type type,
+				 union six_lock_state old)
+{
+	if (type != SIX_LOCK_intent)
+		return;
+
+	if (!old.intent_lock) {
+		EBUG_ON(lock->owner);
+		lock->owner = current;
+	} else {
+		EBUG_ON(lock->owner != current);
+	}
+}
+
+static __always_inline bool do_six_trylock_type(struct six_lock *lock,
+						enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	union six_lock_state old;
+	u64 v = READ_ONCE(lock->state.v);
+
+	EBUG_ON(type == SIX_LOCK_write && lock->owner != current);
+
+	do {
+		old.v = v;
+
+		EBUG_ON(type == SIX_LOCK_write &&
+			((old.v & __SIX_LOCK_HELD_write) ||
+			 !(old.v & __SIX_LOCK_HELD_intent)));
+
+		if (old.v & l[type].lock_fail)
+			return false;
+	} while ((v = atomic64_cmpxchg_acquire(&lock->state.counter,
+				old.v,
+				old.v + l[type].lock_val)) != old.v);
+
+	six_set_owner(lock, type, old);
+	return true;
+}
+
+__always_inline __flatten
+static bool __six_trylock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	if (!do_six_trylock_type(lock, type))
+		return false;
+
+	six_acquire(&lock->dep_map, 1);
+	return true;
+}
+
+__always_inline __flatten
+static bool __six_relock_type(struct six_lock *lock, enum six_lock_type type,
+			      unsigned seq)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	union six_lock_state old;
+	u64 v = READ_ONCE(lock->state.v);
+
+	do {
+		old.v = v;
+
+		if (old.seq != seq || old.v & l[type].lock_fail)
+			return false;
+	} while ((v = atomic64_cmpxchg_acquire(&lock->state.counter,
+				old.v,
+				old.v + l[type].lock_val)) != old.v);
+
+	six_set_owner(lock, type, old);
+	six_acquire(&lock->dep_map, 1);
+	return true;
+}
+
+struct six_lock_waiter {
+	struct list_head	list;
+	struct task_struct	*task;
+};
+
+/* This is probably up there with the more evil things I've done */
+#define waitlist_bitnr(id) ilog2((((union six_lock_state) { .waiters = 1 << (id) }).l))
+
+#ifdef CONFIG_LOCK_SPIN_ON_OWNER
+
+static inline int six_can_spin_on_owner(struct six_lock *lock)
+{
+	struct task_struct *owner;
+	int retval = 1;
+
+	if (need_resched())
+		return 0;
+
+	rcu_read_lock();
+	owner = READ_ONCE(lock->owner);
+	if (owner)
+		retval = owner->on_cpu;
+	rcu_read_unlock();
+	/*
+	 * if lock->owner is not set, the mutex owner may have just acquired
+	 * it and not set the owner yet or the mutex has been released.
+	 */
+	return retval;
+}
+
+static inline bool six_spin_on_owner(struct six_lock *lock,
+				     struct task_struct *owner)
+{
+	bool ret = true;
+
+	rcu_read_lock();
+	while (lock->owner == owner) {
+		/*
+		 * Ensure we emit the owner->on_cpu, dereference _after_
+		 * checking lock->owner still matches owner. If that fails,
+		 * owner might point to freed memory. If it still matches,
+		 * the rcu_read_lock() ensures the memory stays valid.
+		 */
+		barrier();
+
+		if (!owner->on_cpu || need_resched()) {
+			ret = false;
+			break;
+		}
+
+		cpu_relax();
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+{
+	struct task_struct *task = current;
+
+	if (type == SIX_LOCK_write)
+		return false;
+
+	preempt_disable();
+	if (!six_can_spin_on_owner(lock))
+		goto fail;
+
+	if (!osq_lock(&lock->osq))
+		goto fail;
+
+	while (1) {
+		struct task_struct *owner;
+
+		/*
+		 * If there's an owner, wait for it to either
+		 * release the lock or go to sleep.
+		 */
+		owner = READ_ONCE(lock->owner);
+		if (owner && !six_spin_on_owner(lock, owner))
+			break;
+
+		if (do_six_trylock_type(lock, type)) {
+			osq_unlock(&lock->osq);
+			preempt_enable();
+			return true;
+		}
+
+		/*
+		 * When there's no owner, we might have preempted between the
+		 * owner acquiring the lock and setting the owner field. If
+		 * we're an RT task that will live-lock because we won't let
+		 * the owner complete.
+		 */
+		if (!owner && (need_resched() || rt_task(task)))
+			break;
+
+		/*
+		 * The cpu_relax() call is a compiler barrier which forces
+		 * everything in this loop to be re-loaded. We don't need
+		 * memory barriers as we'll eventually observe the right
+		 * values at the cost of a few extra spins.
+		 */
+		cpu_relax();
+	}
+
+	osq_unlock(&lock->osq);
+fail:
+	preempt_enable();
+
+	/*
+	 * If we fell out of the spin path because of need_resched(),
+	 * reschedule now, before we try-lock again. This avoids getting
+	 * scheduled out right after we obtained the lock.
+	 */
+	if (need_resched())
+		schedule();
+
+	return false;
+}
+
+#else /* CONFIG_LOCK_SPIN_ON_OWNER */
+
+static inline bool six_optimistic_spin(struct six_lock *lock, enum six_lock_type type)
+{
+	return false;
+}
+
+#endif
+
+noinline
+static void __six_lock_type_slowpath(struct six_lock *lock, enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	union six_lock_state old, new;
+	struct six_lock_waiter wait;
+	u64 v;
+
+	if (six_optimistic_spin(lock, type))
+		return;
+
+	lock_contended(&lock->dep_map, _RET_IP_);
+
+	INIT_LIST_HEAD(&wait.list);
+	wait.task = current;
+
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (type == SIX_LOCK_write)
+			EBUG_ON(lock->owner != current);
+		else if (list_empty_careful(&wait.list)) {
+			raw_spin_lock(&lock->wait_lock);
+			list_add_tail(&wait.list, &lock->wait_list[type]);
+			raw_spin_unlock(&lock->wait_lock);
+		}
+
+		v = READ_ONCE(lock->state.v);
+		do {
+			new.v = old.v = v;
+
+			if (!(old.v & l[type].lock_fail))
+				new.v += l[type].lock_val;
+			else if (!(new.waiters & (1 << type)))
+				new.waiters |= 1 << type;
+			else
+				break; /* waiting bit already set */
+		} while ((v = atomic64_cmpxchg_acquire(&lock->state.counter,
+					old.v, new.v)) != old.v);
+
+		if (!(old.v & l[type].lock_fail))
+			break;
+
+		schedule();
+	}
+
+	six_set_owner(lock, type, old);
+
+	__set_current_state(TASK_RUNNING);
+
+	if (!list_empty_careful(&wait.list)) {
+		raw_spin_lock(&lock->wait_lock);
+		list_del_init(&wait.list);
+		raw_spin_unlock(&lock->wait_lock);
+	}
+}
+
+__always_inline
+static void __six_lock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	six_acquire(&lock->dep_map, 0);
+
+	if (!do_six_trylock_type(lock, type))
+		__six_lock_type_slowpath(lock, type);
+
+	lock_acquired(&lock->dep_map, _RET_IP_);
+}
+
+static inline void six_lock_wakeup(struct six_lock *lock,
+				   union six_lock_state state,
+				   unsigned waitlist_id)
+{
+	struct list_head *wait_list = &lock->wait_list[waitlist_id];
+	struct six_lock_waiter *w, *next;
+
+	if (waitlist_id == SIX_LOCK_write && state.read_lock)
+		return;
+
+	if (!(state.waiters & (1 << waitlist_id)))
+		return;
+
+	clear_bit(waitlist_bitnr(waitlist_id),
+		  (unsigned long *) &lock->state.v);
+
+	if (waitlist_id == SIX_LOCK_write) {
+		struct task_struct *p = READ_ONCE(lock->owner);
+
+		if (p)
+			wake_up_process(p);
+		return;
+	}
+
+	raw_spin_lock(&lock->wait_lock);
+
+	list_for_each_entry_safe(w, next, wait_list, list) {
+		list_del_init(&w->list);
+
+		if (wake_up_process(w->task) &&
+		    waitlist_id != SIX_LOCK_read) {
+			if (!list_empty(wait_list))
+				set_bit(waitlist_bitnr(waitlist_id),
+					(unsigned long *) &lock->state.v);
+			break;
+		}
+	}
+
+	raw_spin_unlock(&lock->wait_lock);
+}
+
+__always_inline __flatten
+static void __six_unlock_type(struct six_lock *lock, enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	union six_lock_state state;
+
+	EBUG_ON(!(lock->state.v & l[type].held_mask));
+	EBUG_ON(type == SIX_LOCK_write &&
+		!(lock->state.v & __SIX_LOCK_HELD_intent));
+
+	six_release(&lock->dep_map);
+
+	if (type == SIX_LOCK_intent) {
+		EBUG_ON(lock->owner != current);
+
+		if (lock->intent_lock_recurse) {
+			--lock->intent_lock_recurse;
+			return;
+		}
+
+		lock->owner = NULL;
+	}
+
+	state.v = atomic64_add_return_release(l[type].unlock_val,
+					      &lock->state.counter);
+	six_lock_wakeup(lock, state, l[type].unlock_wakeup);
+}
+
+#define __SIX_LOCK(type)						\
+bool six_trylock_##type(struct six_lock *lock)				\
+{									\
+	return __six_trylock_type(lock, SIX_LOCK_##type);		\
+}									\
+EXPORT_SYMBOL_GPL(six_trylock_##type);					\
+									\
+bool six_relock_##type(struct six_lock *lock, u32 seq)			\
+{									\
+	return __six_relock_type(lock, SIX_LOCK_##type, seq);		\
+}									\
+EXPORT_SYMBOL_GPL(six_relock_##type);					\
+									\
+void six_lock_##type(struct six_lock *lock)				\
+{									\
+	__six_lock_type(lock, SIX_LOCK_##type);				\
+}									\
+EXPORT_SYMBOL_GPL(six_lock_##type);					\
+									\
+void six_unlock_##type(struct six_lock *lock)				\
+{									\
+	__six_unlock_type(lock, SIX_LOCK_##type);			\
+}									\
+EXPORT_SYMBOL_GPL(six_unlock_##type);
+
+__SIX_LOCK(read)
+__SIX_LOCK(intent)
+__SIX_LOCK(write)
+
+#undef __SIX_LOCK
+
+/* Convert from intent to read: */
+void six_lock_downgrade(struct six_lock *lock)
+{
+	six_lock_increment(lock, SIX_LOCK_read);
+	six_unlock_intent(lock);
+}
+EXPORT_SYMBOL_GPL(six_lock_downgrade);
+
+bool six_lock_tryupgrade(struct six_lock *lock)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+	union six_lock_state old, new;
+	u64 v = READ_ONCE(lock->state.v);
+
+	do {
+		new.v = old.v = v;
+
+		EBUG_ON(!(old.v & l[SIX_LOCK_read].held_mask));
+
+		new.v += l[SIX_LOCK_read].unlock_val;
+
+		if (new.v & l[SIX_LOCK_intent].lock_fail)
+			return false;
+
+		new.v += l[SIX_LOCK_intent].lock_val;
+	} while ((v = atomic64_cmpxchg_acquire(&lock->state.counter,
+				old.v, new.v)) != old.v);
+
+	six_set_owner(lock, SIX_LOCK_intent, old);
+	six_lock_wakeup(lock, new, l[SIX_LOCK_read].unlock_wakeup);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(six_lock_tryupgrade);
+
+bool six_trylock_convert(struct six_lock *lock,
+			 enum six_lock_type from,
+			 enum six_lock_type to)
+{
+	EBUG_ON(to == SIX_LOCK_write || from == SIX_LOCK_write);
+
+	if (to == from)
+		return true;
+
+	if (to == SIX_LOCK_read) {
+		six_lock_downgrade(lock);
+		return true;
+	} else {
+		return six_lock_tryupgrade(lock);
+	}
+}
+EXPORT_SYMBOL_GPL(six_trylock_convert);
+
+/*
+ * Increment read/intent lock count, assuming we already have it read or intent
+ * locked:
+ */
+void six_lock_increment(struct six_lock *lock, enum six_lock_type type)
+{
+	const struct six_lock_vals l[] = LOCK_VALS;
+
+	EBUG_ON(type == SIX_LOCK_write);
+	six_acquire(&lock->dep_map, 0);
+
+	/* XXX: assert already locked, and that we don't overflow: */
+
+	switch (type) {
+	case SIX_LOCK_read:
+		atomic64_add(l[type].lock_val, &lock->state.counter);
+		break;
+	case SIX_LOCK_intent:
+		lock->intent_lock_recurse++;
+		break;
+	case SIX_LOCK_write:
+		BUG();
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(six_lock_increment);
-- 
2.20.1

