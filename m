Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130F519AA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347312AbiEDIyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346880AbiEDIxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:53 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C816425E89
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:28 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.53 with ESMTP; 4 May 2022 17:19:22 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 May 2022 17:19:22 +0900
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
        hamohammed.sa@gmail.com, 42.hyeyoo@gmail.com
Subject: [PATCH RFC v6 20/21] dept: Do not add dependencies between events within scheduler and sleeps
Date:   Wed,  4 May 2022 17:17:48 +0900
Message-Id: <1651652269-15342-21-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
References: <1651652269-15342-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A sleep is not a wait that prevents the events within __schedule(). It
rather goes through __schedule() so all the events are going to be
triggered while sleeping. So they don't have any dependencies with each
other.

So distinguished sleep type of wait from the other type e.i. spinning
and made it skip building dependencies between sleep type of waits and
the events within __schedule().

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h   |  2 +-
 include/linux/dept.h         | 28 ++++++++++++++++++++----
 include/linux/dept_page.h    |  4 ++--
 include/linux/dept_sdt.h     |  9 +++++++-
 include/linux/lockdep.h      | 52 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/mutex.h        |  2 +-
 include/linux/rwlock.h       | 12 +++++-----
 include/linux/rwsem.h        |  2 +-
 include/linux/seqlock.h      |  2 +-
 include/linux/spinlock.h     |  8 +++----
 kernel/dependency/dept.c     | 37 ++++++++++++++++++++++++-------
 kernel/locking/spinlock_rt.c | 24 ++++++++++----------
 kernel/sched/core.c          |  2 ++
 13 files changed, 138 insertions(+), 46 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 358c656..2dade27 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -36,7 +36,7 @@ struct completion {
 #define dept_wfc_wait(m, ip)						\
 do {									\
 	dept_ask_event(m);						\
-	dept_wait(m, 1UL, ip, __func__, 0);				\
+	dept_wait(m, 1UL, ip, __func__, 0, true);			\
 } while (0)
 #define dept_wfc_complete(m, ip)		dept_event(m, 1UL, ip, __func__)
 #define dept_wfc_enter(m, ip)			dept_ecxt_enter(m, 1UL, ip, "completion_context_enter", "complete", 0)
diff --git a/include/linux/dept.h b/include/linux/dept.h
index 3027121..28db897 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -170,6 +170,11 @@ struct dept_ecxt {
 	 */
 	unsigned long			event_ip;
 	struct dept_stack		*event_stack;
+
+	/*
+	 * whether the event is triggered within __schedule()
+	 */
+	bool				in_sched;
 };
 
 struct dept_wait {
@@ -208,6 +213,11 @@ struct dept_wait {
 	 */
 	unsigned long			wait_ip;
 	struct dept_stack		*wait_stack;
+
+	/*
+	 * spin or sleep
+	 */
+	bool				sleep;
 };
 
 struct dept_dep {
@@ -460,6 +470,11 @@ struct dept_task {
 	 */
 	bool				hardirqs_enabled;
 	bool				softirqs_enabled;
+
+	/*
+	 * whether the current task is in __schedule()
+	 */
+	bool				in_sched;
 };
 
 #define DEPT_TASK_INITIALIZER(t)				\
@@ -480,6 +495,7 @@ struct dept_task {
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
 	.softirqs_enabled = false,				\
+	.in_sched = false,					\
 }
 
 extern void dept_on(void);
@@ -492,7 +508,7 @@ struct dept_task {
 extern void dept_map_reinit(struct dept_map *m);
 extern void dept_map_nocheck(struct dept_map *m);
 
-extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int ne);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int ne, bool sleep);
 extern void dept_stage_wait(struct dept_map *m, unsigned long w_f, const char *w_fn, int ne);
 extern void dept_ask_event_wait_commit(unsigned long ip);
 extern void dept_clean_stage(void);
@@ -502,11 +518,13 @@ struct dept_task {
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_split_map_each_init(struct dept_map_each *me);
 extern void dept_split_map_common_init(struct dept_map_common *mc, struct dept_key *k, const char *n);
-extern void dept_wait_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *w_fn, int ne);
+extern void dept_wait_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *w_fn, int ne, bool sleep);
 extern void dept_event_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *e_fn);
 extern void dept_ask_event_split_map(struct dept_map_each *me, struct dept_map_common *mc);
 extern void dept_kernel_enter(void);
 extern void dept_work_enter(void);
+extern void dept_sched_enter(void);
+extern void dept_sched_exit(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -546,7 +564,7 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_map_reinit(m)				do { } while (0)
 #define dept_map_nocheck(m)				do { } while (0)
 
-#define dept_wait(m, w_f, ip, w_fn, ne)			do { (void)(w_fn); } while (0)
+#define dept_wait(m, w_f, ip, w_fn, ne, s)		do { (void)(w_fn); } while (0)
 #define dept_stage_wait(m, w_f, w_fn, ne)		do { (void)(w_fn); } while (0)
 #define dept_ask_event_wait_commit(ip)			do { } while (0)
 #define dept_clean_stage()				do { } while (0)
@@ -556,11 +574,13 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_split_map_each_init(me)			do { } while (0)
 #define dept_split_map_common_init(mc, k, n)		do { (void)(n); (void)(k); } while (0)
-#define dept_wait_split_map(me, mc, ip, w_fn, ne)	do { } while (0)
+#define dept_wait_split_map(me, mc, ip, w_fn, ne, s)	do { } while (0)
 #define dept_event_split_map(me, mc, ip, e_fn)		do { } while (0)
 #define dept_ask_event_split_map(me, mc)		do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
 #define dept_work_enter()				do { } while (0)
+#define dept_sched_enter()				do { } while (0)
+#define dept_sched_exit()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/include/linux/dept_page.h b/include/linux/dept_page.h
index d2d093d..4af3b2d 100644
--- a/include/linux/dept_page.h
+++ b/include/linux/dept_page.h
@@ -20,7 +20,7 @@
 								\
 	if (likely(me))						\
 		dept_wait_split_map(me, &pglocked_mc, _RET_IP_, \
-				    __func__, 0);		\
+				    __func__, 0, true);		\
 } while (0)
 
 #define dept_pglocked_set_bit(f)				\
@@ -46,7 +46,7 @@
 								\
 	if (likely(me))						\
 		dept_wait_split_map(me, &pgwriteback_mc, _RET_IP_,\
-				    __func__, 0);		\
+				    __func__, 0, true);		\
 } while (0)
 
 #define dept_pgwriteback_set_bit(f)				\
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 49763cd..14a1720 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -29,7 +29,13 @@
 #define sdt_wait(m)							\
 	do {								\
 		dept_ask_event(m);					\
-		dept_wait(m, 1UL, _THIS_IP_, "wait", 0);		\
+		dept_wait(m, 1UL, _THIS_IP_, "wait", 0, true);		\
+	} while (0)
+
+#define sdt_wait_spin(m)						\
+	do {								\
+		dept_ask_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, "wait", 0, false);		\
 	} while (0)
 /*
  * This will be committed in __schedule() when it actually gets to
@@ -47,6 +53,7 @@
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
 #define sdt_wait(m)			do { } while (0)
+#define sdt_wait_spin(m)		do { } while (0)
 #define sdt_wait_prepare(m)		do { } while (0)
 #define sdt_wait_finish()		do { } while (0)
 #define sdt_ecxt_enter(m)		do { } while (0)
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b0e097f..b2119f4 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -575,12 +575,12 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define spin_acquire(l, s, t, i)					\
 do {									\
 	lock_acquire_exclusive(l, s, t, NULL, i);			\
-	dept_spin_lock(&(l)->dmap, s, t, NULL, "spin_unlock", i);	\
+	dept_spin_lock(&(l)->dmap, s, t, NULL, "spin_unlock", i, false);\
 } while (0)
 #define spin_acquire_nest(l, s, t, n, i)				\
 do {									\
 	lock_acquire_exclusive(l, s, t, n, i);				\
-	dept_spin_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "spin_unlock", i); \
+	dept_spin_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "spin_unlock", i, false); \
 } while (0)
 #define spin_release(l, i)						\
 do {									\
@@ -591,16 +591,16 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 #define rwlock_acquire(l, s, t, i)					\
 do {									\
 	lock_acquire_exclusive(l, s, t, NULL, i);			\
-	dept_rwlock_wlock(&(l)->dmap, s, t, NULL, "write_unlock", i);	\
+	dept_rwlock_wlock(&(l)->dmap, s, t, NULL, "write_unlock", i, false);\
 } while (0)
 #define rwlock_acquire_read(l, s, t, i)					\
 do {									\
 	if (read_lock_is_recursive()) {				\
 		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
-		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 0);\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 0, false);\
 	} else {							\
 		lock_acquire_shared(l, s, t, NULL, i);			\
-		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 1);\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 1, false);\
 	}								\
 } while (0)
 #define rwlock_release(l, i)						\
@@ -614,6 +614,48 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 	dept_rwlock_runlock(&(l)->dmap, i);				\
 } while (0)
 
+#define rt_spin_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_spin_lock(&(l)->dmap, s, t, NULL, "spin_unlock", i, true);	\
+} while (0)
+#define rt_spin_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_spin_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "spin_unlock", i, true);\
+} while (0)
+#define rt_spin_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_spin_unlock(&(l)->dmap, i);				\
+} while (0)
+
+#define rt_rwlock_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_rwlock_wlock(&(l)->dmap, s, t, NULL, "write_unlock", i, true);\
+} while (0)
+#define rt_rwlock_acquire_read(l, s, t, i)					\
+do {									\
+	if (read_lock_is_recursive()) {				\
+		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 0, true);\
+	} else {							\
+		lock_acquire_shared(l, s, t, NULL, i);			\
+		dept_rwlock_rlock(&(l)->dmap, s, t, NULL, "read_unlock", i, 1, true);\
+	}								\
+} while (0)
+#define rt_rwlock_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_rwlock_wunlock(&(l)->dmap, i);				\
+} while (0)
+#define rt_rwlock_release_read(l, i)					\
+do {									\
+	lock_release(l, i);						\
+	dept_rwlock_runlock(&(l)->dmap, i);				\
+} while (0)
+
 #define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
 #define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
 #define seqcount_release(l, i)			lock_release(l, i)
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index b699cf41..e98a912 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -84,7 +84,7 @@ struct mutex {
 	} else if (n) {							\
 		dept_ecxt_enter_nokeep(m);				\
 	} else {							\
-		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_wait(m, 1UL, ip, __func__, ne, true);		\
 		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
 	}								\
 } while (0)
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index bbab144..68a083d 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -33,25 +33,25 @@
 #define DEPT_EVT_RWLOCK_W		(1UL << 1)
 #define DEPT_EVT_RWLOCK_RW		(DEPT_EVT_RWLOCK_R | DEPT_EVT_RWLOCK_W)
 
-#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip)			\
+#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip, s)			\
 do {									\
 	if (t) {							\
 		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_W, ip, __func__, e_fn, ne);\
 	} else if (n) {							\
 		dept_ecxt_enter_nokeep(m);				\
 	} else {							\
-		dept_wait(m, DEPT_EVT_RWLOCK_RW, ip, __func__, ne);	\
+		dept_wait(m, DEPT_EVT_RWLOCK_RW, ip, __func__, ne, s);	\
 		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_W, ip, __func__, e_fn, ne);\
 	}								\
 } while (0)
-#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q)			\
+#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q, s)			\
 do {									\
 	if (t) {							\
 		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_R, ip, __func__, e_fn, ne);\
 	} else if (n) {							\
 		dept_ecxt_enter_nokeep(m);				\
 	} else {							\
-		dept_wait(m, (q) ? DEPT_EVT_RWLOCK_RW : DEPT_EVT_RWLOCK_W, ip, __func__, ne);\
+		dept_wait(m, (q) ? DEPT_EVT_RWLOCK_RW : DEPT_EVT_RWLOCK_W, ip, __func__, ne, s);\
 		dept_ecxt_enter(m, DEPT_EVT_RWLOCK_R, ip, __func__, e_fn, ne);\
 	}								\
 } while (0)
@@ -64,8 +64,8 @@
 	dept_ecxt_exit(m, DEPT_EVT_RWLOCK_R, ip);			\
 } while (0)
 #else
-#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip)	do { } while (0)
-#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q)	do { } while (0)
+#define dept_rwlock_wlock(m, ne, t, n, e_fn, ip, s)	do { } while (0)
+#define dept_rwlock_rlock(m, ne, t, n, e_fn, ip, q, s)	do { } while (0)
 #define dept_rwlock_wunlock(m, ip)			do { } while (0)
 #define dept_rwlock_runlock(m, ip)			do { } while (0)
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index ed4c34e..fd86dfd5 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -41,7 +41,7 @@
 	} else if (n) {							\
 		dept_ecxt_enter_nokeep(m);				\
 	} else {							\
-		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_wait(m, 1UL, ip, __func__, ne, true);		\
 		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
 	}								\
 } while (0)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 47c3379..ac2ac40 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -25,7 +25,7 @@
 
 #ifdef CONFIG_DEPT
 #define DEPT_EVT_ALL		((1UL << DEPT_MAX_SUBCLASSES_EVT) - 1)
-#define dept_seq_wait(m, ip)	dept_wait(m, DEPT_EVT_ALL, ip, __func__, 0)
+#define dept_seq_wait(m, ip)	dept_wait(m, DEPT_EVT_ALL, ip, __func__, 0, false)
 #define dept_seq_writebegin(m, ip)				\
 do {								\
 	dept_ecxt_enter(m, 1UL, ip, __func__, "write_seqcount_end", 0);\
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 191fb99..a78aaa3 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -96,14 +96,14 @@
 #endif
 
 #ifdef CONFIG_DEPT
-#define dept_spin_lock(m, ne, t, n, e_fn, ip)				\
+#define dept_spin_lock(m, ne, t, n, e_fn, ip, s)			\
 do {									\
 	if (t) {							\
 		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
 	} else if (n) {							\
 		dept_ecxt_enter_nokeep(m);				\
 	} else {							\
-		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_wait(m, 1UL, ip, __func__, ne, s);			\
 		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
 	}								\
 } while (0)
@@ -112,8 +112,8 @@
 	dept_ecxt_exit(m, 1UL, ip);					\
 } while (0)
 #else
-#define dept_spin_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
-#define dept_spin_unlock(m, ip)			do { } while (0)
+#define dept_spin_lock(m, ne, t, n, e_fn, ip, s)	do { } while (0)
+#define dept_spin_unlock(m, ip)				do { } while (0)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 2bc6259..14dc33b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1425,6 +1425,13 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	struct dept_dep *d;
 	int i;
 
+	/*
+	 * It's meaningless to track dependencies between sleeps and
+	 * events triggered within __schedule().
+	 */
+	if (e->in_sched && w->sleep)
+		return;
+
 	if (lookup_dep(fc, tc))
 		return;
 
@@ -1469,7 +1476,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 static atomic_t wgen = ATOMIC_INIT(1);
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int ne)
+		     const char *w_fn, int ne, bool sleep)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1485,6 +1492,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_ip = ip;
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
+	w->sleep = sleep;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -1538,6 +1546,7 @@ static bool add_ecxt(void *obj, struct dept_class *c, unsigned long ip,
 	e->ecxt_stack = ip && rich_stack ? get_current_stack() : NULL;
 	e->event_fn = e_fn;
 	e->ecxt_fn = c_fn;
+	e->in_sched = dt->in_sched;
 
 	eh = dt->ecxt_held + (dt->ecxt_held_pos++);
 	eh->ecxt = get_ecxt(e);
@@ -1906,6 +1915,16 @@ void dept_hardirq_enter(void)
 	dt->cxt_id[DEPT_CXT_HIRQ] += (1UL << DEPT_CXTS_NR);
 }
 
+void dept_sched_enter(void)
+{
+	dept_task()->in_sched = true;
+}
+
+void dept_sched_exit(void)
+{
+	dept_task()->in_sched = false;
+}
+
 /*
  * DEPT API
  * =====================================================================
@@ -2119,7 +2138,8 @@ static struct dept_class *check_new_class(struct dept_key *local,
 }
 
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
-			unsigned long ip, const char *w_fn, int ne)
+			unsigned long ip, const char *w_fn, int ne,
+			bool sleep)
 {
 	int e;
 
@@ -2142,12 +2162,12 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, ne);
+		add_wait(c, ip, w_fn, ne, sleep);
 	}
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
-	       const char *w_fn, int ne)
+	       const char *w_fn, int ne, bool sleep)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
@@ -2163,7 +2183,7 @@ void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
 
 	flags = dept_enter();
 
-	__dept_wait(m, w_f, ip, w_fn, ne);
+	__dept_wait(m, w_f, ip, w_fn, ne, sleep);
 
 	dept_exit(flags);
 }
@@ -2296,7 +2316,7 @@ void dept_ask_event_wait_commit(unsigned long ip)
 	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 	WRITE_ONCE(m->wgen, wg);
 
-	__dept_wait(m, w_f, ip, w_fn, ne);
+	__dept_wait(m, w_f, ip, w_fn, ne, true);
 exit:
 	dept_exit(flags);
 }
@@ -2526,7 +2546,8 @@ void dept_split_map_common_init(struct dept_map_common *mc,
 
 void dept_wait_split_map(struct dept_map_each *me,
 			 struct dept_map_common *mc,
-			 unsigned long ip, const char *w_fn, int ne)
+			 unsigned long ip, const char *w_fn, int ne,
+			 bool sleep)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_class *c;
@@ -2547,7 +2568,7 @@ void dept_wait_split_map(struct dept_map_each *me,
 	k = mc->keys ?: &mc->keys_local;
 	c = check_new_class(&mc->keys_local, k, 0, 0UL, mc->name);
 	if (c)
-		add_wait(c, ip, w_fn, ne);
+		add_wait(c, ip, w_fn, ne, sleep);
 
 	dept_exit(flags);
 }
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed..2e1d0e5 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -51,7 +51,7 @@ static __always_inline void __rt_spin_lock(spinlock_t *lock)
 
 void __sched rt_spin_lock(spinlock_t *lock)
 {
-	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	rt_spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	__rt_spin_lock(lock);
 }
 EXPORT_SYMBOL(rt_spin_lock);
@@ -59,7 +59,7 @@ void __sched rt_spin_lock(spinlock_t *lock)
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
 {
-	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	rt_spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
 	__rt_spin_lock(lock);
 }
 EXPORT_SYMBOL(rt_spin_lock_nested);
@@ -67,7 +67,7 @@ void __sched rt_spin_lock_nested(spinlock_t *lock, int subclass)
 void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 				    struct lockdep_map *nest_lock)
 {
-	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
+	rt_spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
 	__rt_spin_lock(lock);
 }
 EXPORT_SYMBOL(rt_spin_lock_nest_lock);
@@ -75,7 +75,7 @@ void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 
 void __sched rt_spin_unlock(spinlock_t *lock)
 {
-	spin_release(&lock->dep_map, _RET_IP_);
+	rt_spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
 	rcu_read_unlock();
 
@@ -104,7 +104,7 @@ static __always_inline int __rt_spin_trylock(spinlock_t *lock)
 		ret = rt_mutex_slowtrylock(&lock->lock);
 
 	if (ret) {
-		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		rt_spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
 		migrate_disable();
 	}
@@ -197,7 +197,7 @@ int __sched rt_read_trylock(rwlock_t *rwlock)
 
 	ret = rwbase_read_trylock(&rwlock->rwbase);
 	if (ret) {
-		rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rt_rwlock_acquire_read(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
 		migrate_disable();
 	}
@@ -211,7 +211,7 @@ int __sched rt_write_trylock(rwlock_t *rwlock)
 
 	ret = rwbase_write_trylock(&rwlock->rwbase);
 	if (ret) {
-		rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
+		rt_rwlock_acquire(&rwlock->dep_map, 0, 1, _RET_IP_);
 		rcu_read_lock();
 		migrate_disable();
 	}
@@ -222,7 +222,7 @@ int __sched rt_write_trylock(rwlock_t *rwlock)
 void __sched rt_read_lock(rwlock_t *rwlock)
 {
 	rtlock_might_resched();
-	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rt_rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_read_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
 	migrate_disable();
@@ -232,7 +232,7 @@ void __sched rt_read_lock(rwlock_t *rwlock)
 void __sched rt_write_lock(rwlock_t *rwlock)
 {
 	rtlock_might_resched();
-	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
+	rt_rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
 	migrate_disable();
@@ -243,7 +243,7 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 {
 	rtlock_might_resched();
-	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
+	rt_rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
 	rwbase_write_lock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
 	rcu_read_lock();
 	migrate_disable();
@@ -253,7 +253,7 @@ void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
 
 void __sched rt_read_unlock(rwlock_t *rwlock)
 {
-	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	rt_rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
 	rcu_read_unlock();
 	rwbase_read_unlock(&rwlock->rwbase, TASK_RTLOCK_WAIT);
@@ -262,7 +262,7 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
 
 void __sched rt_write_unlock(rwlock_t *rwlock)
 {
-	rwlock_release(&rwlock->dep_map, _RET_IP_);
+	rt_rwlock_release(&rwlock->dep_map, _RET_IP_);
 	rcu_read_unlock();
 	migrate_enable();
 	rwbase_write_unlock(&rwlock->rwbase);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5784b07..cb42f52 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6272,6 +6272,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 	struct rq *rq;
 	int cpu;
 
+	dept_sched_enter();
 	cpu = smp_processor_id();
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
@@ -6401,6 +6402,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 		__balance_callbacks(rq);
 		raw_spin_rq_unlock_irq(rq);
 	}
+	dept_sched_exit();
 }
 
 void __noreturn do_task_dead(void)
-- 
1.9.1

