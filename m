Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A5B49D732
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbiA0BL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:11:27 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:38078 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234345AbiA0BLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:11:20 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 27 Jan 2022 10:11:17 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 27 Jan 2022 10:11:17 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH on v5.17-rc1 04/14] dept: Apply Dept to spinlock
Date:   Thu, 27 Jan 2022 10:11:02 +0900
Message-Id: <1643245873-15542-4-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
References: <1643245733-14513-1-git-send-email-byungchul.park@lge.com>
 <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by spinlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h            | 18 +++++++++++++++---
 include/linux/spinlock.h           | 24 ++++++++++++++++++++++++
 include/linux/spinlock_types_raw.h | 13 +++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index c56f6b6..1da8b95 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -582,9 +582,21 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define lock_acquire_shared(l, s, t, n, i)		lock_acquire(l, s, t, 1, 1, n, i)
 #define lock_acquire_shared_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 2, 1, n, i)
 
-#define spin_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define spin_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define spin_release(l, i)			lock_release(l, i)
+#define spin_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_spin_lock(&(l)->dmap, s, t, NULL, "spin_unlock", i);	\
+} while (0)
+#define spin_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_spin_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "spin_unlock", i); \
+} while (0)
+#define spin_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_spin_unlock(&(l)->dmap, i);				\
+} while (0)
 
 #define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define rwlock_acquire_read(l, s, t, i)					\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 5c0c517..4d1f5e4 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -95,6 +95,30 @@
 # include <linux/spinlock_up.h>
 #endif
 
+#ifdef CONFIG_DEPT
+#define dept_spin_lock(m, ne, t, n, e_fn, ip)				\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_asked_event(m);					\
+	} else if (n) {							\
+		dept_warn_on(dept_top_map() != (n));			\
+	} else {							\
+		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_asked_event(m);					\
+	}								\
+} while (0)
+#define dept_spin_unlock(m, ip)						\
+do {									\
+	dept_event(m, 1UL, ip, __func__);				\
+	dept_ecxt_exit(m, ip);						\
+} while (0)
+#else
+#define dept_spin_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_spin_unlock(m, ip)			do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 				   struct lock_class_key *key, short inner);
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b..5a9b25d 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -26,16 +26,28 @@
 
 #define SPINLOCK_OWNER_INIT	((void *)-1L)
 
+#ifdef CONFIG_DEPT
+# define RAW_SPIN_DMAP_INIT(lockname)	.dmap = { .name = #lockname },
+# define SPIN_DMAP_INIT(lockname)	.dmap = { .name = #lockname },
+# define LOCAL_SPIN_DMAP_INIT(lockname)	.dmap = { .name = #lockname },
+#else
+# define RAW_SPIN_DMAP_INIT(lockname)
+# define SPIN_DMAP_INIT(lockname)
+# define LOCAL_SPIN_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define RAW_SPIN_DEP_MAP_INIT(lockname)		\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SPIN,	\
+		RAW_SPIN_DMAP_INIT(lockname)		\
 	}
 # define SPIN_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
+		SPIN_DMAP_INIT(lockname)		\
 	}
 
 # define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
@@ -43,6 +55,7 @@
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		LOCAL_SPIN_DMAP_INIT(lockname)		\
 	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
-- 
1.9.1

