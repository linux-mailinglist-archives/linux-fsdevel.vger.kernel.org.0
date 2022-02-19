Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88004BC816
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242228AbiBSK7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:59:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiBSK7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:59:11 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3705169CEA
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:58:44 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 19 Feb 2022 19:58:43 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:58:43 +0900
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
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH v2 10/18] dept: Apply Dept to rwsem
Date:   Sat, 19 Feb 2022 19:58:23 +0900
Message-Id: <1645268311-24222-11-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
References: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by rwsem.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h      | 24 ++++++++++++++++++++----
 include/linux/percpu-rwsem.h | 10 +++++++++-
 include/linux/rwsem.h        | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b93a707..37af50c 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -646,10 +646,26 @@ static inline void print_irqtrace_events(struct task_struct *curr)
 	dept_mutex_unlock(&(l)->dmap, i);				\
 } while (0)
 
-#define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define rwsem_acquire_read(l, s, t, i)		lock_acquire_shared(l, s, t, NULL, i)
-#define rwsem_release(l, i)			lock_release(l, i)
+#define rwsem_acquire(l, s, t, i)					\
+do {									\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+	dept_rwsem_lock(&(l)->dmap, s, t, NULL, "up_write", i);		\
+} while (0)
+#define rwsem_acquire_nest(l, s, t, n, i)				\
+do {									\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+	dept_rwsem_lock(&(l)->dmap, s, t, (n) ? &(n)->dmap : NULL, "up_write", i);\
+} while (0)
+#define rwsem_acquire_read(l, s, t, i)					\
+do {									\
+	lock_acquire_shared(l, s, t, NULL, i);				\
+	dept_rwsem_lock(&(l)->dmap, s, t, NULL, "up_read", i);		\
+} while (0)
+#define rwsem_release(l, i)						\
+do {									\
+	lock_release(l, i);						\
+	dept_rwsem_unlock(&(l)->dmap, i);				\
+} while (0)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_read(l)		lock_acquire_shared_recursive(l, 0, 0, NULL, _THIS_IP_)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 5fda40f..ac2b1a5 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -20,8 +20,16 @@ struct percpu_rw_semaphore {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define __PERCPU_RWSEM_DMAP_INIT(lockname) .dmap = { .name = #lockname, .skip_cnt = ATOMIC_INIT(0) }
+#else
+#define __PERCPU_RWSEM_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = {	\
+	.name = #lockname,					\
+	__PERCPU_RWSEM_DMAP_INIT(lockname) },
 #else
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f934876..dc7977a 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -16,11 +16,18 @@
 #include <linux/atomic.h>
 #include <linux/err.h>
 
+#ifdef CONFIG_DEPT
+# define RWSEM_DMAP_INIT(lockname)	.dmap = { .name = #lockname, .skip_cnt = ATOMIC_INIT(0) },
+#else
+# define RWSEM_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 # define __RWSEM_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		RWSEM_DMAP_INIT(lockname)		\
 	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
@@ -32,6 +39,32 @@
 #include <linux/osq_lock.h>
 #endif
 
+#ifdef CONFIG_DEPT
+#define dept_rwsem_lock(m, ne, t, n, e_fn, ip)				\
+do {									\
+	if (t) {							\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_ask_event(m);					\
+	} else if (n) {							\
+		dept_skip(m);						\
+	} else {							\
+		dept_wait(m, 1UL, ip, __func__, ne);			\
+		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, ne);	\
+		dept_ask_event(m);					\
+	}								\
+} while (0)
+#define dept_rwsem_unlock(m, ip)					\
+do {									\
+	if (!dept_unskip_if_skipped(m)) {				\
+		dept_event(m, 1UL, ip, __func__);			\
+		dept_ecxt_exit(m, ip);					\
+	}								\
+} while (0)
+#else
+#define dept_rwsem_lock(m, ne, t, n, e_fn, ip)	do { } while (0)
+#define dept_rwsem_unlock(m, ip)		do { } while (0)
+#endif
+
 /*
  * For an uncontended rwsem, count and owner are the only fields a task
  * needs to touch when acquiring the rwsem. So they are put next to each
-- 
1.9.1

