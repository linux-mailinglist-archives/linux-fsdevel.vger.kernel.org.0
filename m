Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC77519A72
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbiEDIxS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346642AbiEDIxD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:03 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88C0124F1A
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:21 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 4 May 2022 17:19:19 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.125 with ESMTP; 4 May 2022 17:19:19 +0900
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
Subject: [PATCH RFC v6 04/21] dept: Apply Dept to mutex families
Date:   Wed,  4 May 2022 17:17:32 +0900
Message-Id: <1651652269-15342-5-git-send-email-byungchul.park@lge.com>
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

Makes Dept able to track dependencies by mutex families.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h | 18 +++++++++++++++---
 include/linux/mutex.h   | 22 ++++++++++++++++++++++
 include/linux/rtmutex.h |  1 +
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 4fa91d5..99569acb 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -603,9 +603,21 @@ static inline void print_irqtrace_events(struct task_struct *curr)
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
index 8f226d4..b699cf41 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -25,6 +25,7 @@
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			.dmap = DEPT_MAP_INITIALIZER(lockname)	\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
@@ -75,6 +76,27 @@ struct mutex {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define dept_mutex_lock(m, ne, t, n, e_fn, ip)				\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+	} else if (n) {							\
+		dept_ecxt_enter_nokeep(m);				\
+	} else {							\
+		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+	}								\
+} while (0)
+#define dept_mutex_unlock(m, ip)					\
+do {									\
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
index 7d04988..416064d 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -81,6 +81,7 @@ static inline void rt_mutex_debug_task_free(struct task_struct *tsk) { }
 	.dep_map = {					\
 		.name = #mutexname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(mutexname)	\
 	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
-- 
1.9.1

