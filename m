Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20304DA814
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 03:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353073AbiCPC2b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 22:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351210AbiCPC21 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 22:28:27 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF8C55E17D
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Mar 2022 19:27:10 -0700 (PDT)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.52 with ESMTP; 16 Mar 2022 11:27:09 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 16 Mar 2022 11:27:09 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
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
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH RFC v5 05/21] dept: Apply Dept to mutex families
Date:   Wed, 16 Mar 2022 11:26:17 +0900
Message-Id: <1647397593-16747-6-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
References: <1647397593-16747-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by mutex families.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h | 18 +++++++++++++++---
 include/linux/mutex.h   | 32 ++++++++++++++++++++++++++++++++
 include/linux/rtmutex.h |  7 +++++++
 3 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 01e7427..42237fc 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -614,9 +614,21 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
 #define seqcount_release(l, i)			lock_release(l, i)
 
-#define mutex_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define mutex_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define mutex_release(l, i)			lock_release(l, i)
+#define mutex_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_mutex_lock(&(l)->dmap, s, t, NULL, "mutex_unlock", i);	\
+} while (0)
+#define mutex_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_mutex_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "mutex_unlock", i);\
+} while (0)
+#define mutex_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_mutex_unlock(&(l)->dmap, i);				\
+} while (0)
 
 #define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d4..c321911 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,11 +20,18 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+#ifdef CONFIG_DEPT
+# define DMAP_MUTEX_INIT(lockname)	.dmap = { .name = #lockname },
+#else
+# define DMAP_MUTEX_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)			\
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			DMAP_MUTEX_INIT(lockname)		\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
@@ -75,6 +82,31 @@ struct mutex {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define dept_mutex_lock(m, ne, t, n, e_fn, ip)				\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_ask_event(m);					\
+	} else if (n) {							\
+		dept_ecxt_enter_nokeep(m);				\
+		dept_ask_event(m);					\
+	} else {							\
+		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_ask_event(m);					\
+	}								\
+} while (0)
+#define dept_mutex_unlock(m, ip)					\
+do {									\
+	dept_event(m, 1UL, ip, __func__);				\
+	dept_ecxt_exit(m, 1UL, ip);					\
+} while (0)
+#else
+#define dept_mutex_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_mutex_unlock(m, ip)		do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_MUTEXES
 
 #define __DEBUG_MUTEX_INITIALIZER(lockname)				\
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d04988..60cebb0 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -76,11 +76,18 @@ static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 	__rt_mutex_init(mutex, __func__, &__key); \
 } while (0)
 
+#ifdef CONFIG_DEPT
+#define DMAP_RT_MUTEX_INIT(mutexname)	.dmap = { .name = #mutexname },
+#else
+#define DMAP_RT_MUTEX_INIT(mutexname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)	\
 	.dep_map = {					\
 		.name = #mutexname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		DMAP_RT_MUTEX_INIT(mutexname)		\
 	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
-- 
1.9.1

