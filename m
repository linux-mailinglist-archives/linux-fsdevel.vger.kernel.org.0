Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4CB7458CD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjGCJts (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjGCJtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:46 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 647B712C;
        Mon,  3 Jul 2023 02:49:40 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-26-64a299b2da09
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 rebased on v6.4 05/25] dept: Tie to Lockdep and IRQ tracing
Date:   Mon,  3 Jul 2023 18:47:32 +0900
Message-Id: <20230703094752.79269-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfd9zznsOlZpDNeEgWdQmXqbRgVHzZDHoJ3eMMermh8XLXGNP
        pI6LawUFo3Kpggj1FqwIzlK0VuhQTzUiF4MQUMBLHZ1DAlUICAxKBS2x4zIB45cnv+T///8+
        PRylqmTmcrq4g5I+ThOjJgpa4Q22LpfzrNoIuTcCzmVHgP9jJg0FtxwEXKUlCBx3UzH01f0A
        /4wMIBh99oICc64LQWFHOwV36z0IquxpBJq7ZoHb7yPQkHuaQHrRLQIv+8cwtF08j6FE3gxN
        Z60YqgM9NJj7COSb0/Hk6cUQsBWzYEtZCJ32yyyMdURCg+cVA1WtyyDvjzYClVUNNNSXdWJo
        Li8g4HH8z0BT/RMaXOdyGPhz0Eqgf8RGgc3vY+GvaguG28ZJ0ckPEww8zqnGcPLaHQzu1xUI
        Hma+xSA7XhGo9Q9gcMq5FPx3ow5Bp8nLwonsAAv5qSYEp09cpOHF+GMGjG2rYfRTAVn/vVg7
        4KNEo/OQWDViocVGqyA+uNzOisaHraxokRNEp32pWFTZh8XCYT8jysWniCgPn2fFLK8bi4PP
        n7Pik0ujtNjlNuOt4TsUa7VSjC5R0n8X9asi2jTezRx4nYYO15eOUynItS8LBXECv0oYLGpE
        XzmtoB9PMeEXCy0tAWqK5/DzBWfOOyYLKTiKz5gp2N8/I1PBbH6LkHG/d3pA8wuFl+YH0yIl
        v1qoyKjFX6TzhJLb1dOiIH6N0P3JNN1RTXba8jxkSirwZ4KEct8b5ssgTHhkb6HPIqUFzShG
        Kl1cYqxGF7NqRXRSnO7wir3xsTKa/Cnb0bGdZWjY9VMN4jmkDla2HCnUqhhNoiEptgYJHKWe
        o0zvuKpVKbWapGRJH79HnxAjGWpQOEerQ5UrRw5pVfw+zUHpN0k6IOm/ppgLmpuCFlnUi4xr
        n265+eOmM0ONzcasxkt6U6inU5e8f+W6iaPK7XnHF+x1DoUs2VgX4k1NWXOvp2e+o/bf8HSm
        6yobOhAw7VZ7oxJ2/c0N/bzhmz2zfaVh7fkXKjpUblczad32Ljis8lhI+VtPctixivB43bdP
        EyZ+v15muBKZnfnLve4mX5SaNkRrIpdSeoPmM54e2dFPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hUWxiGW2vvvfY4NbGZ49DuRjUVB+zUqcj4yoqgqEXQlaIQDsfB2ScH
        r8yoZRGYjk2ZigY6WlZeYhQ10z2CetIwxVGzbLxUFjqkXWW8RDmSeUuN/nw88L7v8+tTMOo7
        3DKFISxSMobpQrREySqP+MVvlLPy9JvvFmggLWkzeEavspD9oISAs7QYQUnFZQwDjQfh1dgg
        golnzxmwpjsR5Pb1MlDhcCGoLYwj0Pl+MXR5Rgi0pF8nEJ//gEC7exJDT8YNDMXyYWhNzcNQ
        N/6JBesAgVvWeDx7PmMYtxXxYItdD/2FN3mY7NsCLa6XHDTcbuGg9s0GyLrTQ6CmtoUFR1U/
        hs7/swm4SmY4aHU0s+BMS+bg/nAeAfeYjQGbZ4SHjrocDGXmWduVb9McNCXXYbhyrxxD1+uH
        CB5dfYtBLnlJoMEziMEupzPwo6ARQX/KEA8JSeM83LqcguB6QgYLz6eaODD3+MLE92yy1482
        DI4w1Gw/R2vHclj6JE+k1Td7eWp+9IanOXIUtRf60PyaAUxzv3o4KhddI1T+eoOniUNdmA63
        tfG0OXOCpe+7rPjYCn/lLr0UYoiWjH/vCVAGpUx94CJex6HzjtIpJhY5zyYiL4UobBPjst14
        jonwp9jdPc7MsbewWrQnf+QSkVLBCJaFYuGXZ2Qu+EM4KloqP88PWGG92G6tRnOsEnzFh5YG
        /Eu6Siwuq5sXeQnbxQ/fU+Y76tlOT5aLpCJlDlpQhLwNYdGhOkOI7yZTcFBMmOH8psDwUBnN
        fo3t0mRaFRrtPFiPBAXSLlJ1X8zVqzldtCkmtB6JCkbrrYrvu6tXq/S6mAuSMfxfY1SIZKpH
        yxWsdonq0GkpQC2c1UVKwZIUIRl/p1jhtSwWVZ6UtueXSzMFTg1Z2lFdsKaj1e/Jl9whTVCk
        KrDScnxHTcU+98oZc+BOzY7MrY0vVp9ICsjyujC81z+qMjryTDtNDc84cDg84XRMksY1Pap+
        XHYquOifddNTk0vNK/13lja7/6rKt/Q27f6PkzNLHW0vqu2GExtCI/YvUdd7v1v7VMuagnRb
        fBijSfcTi55bujEDAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Yes. How to place Dept in here looks so ugly. But it's inevitable as
long as relying on Lockdep. The way should be enhanced gradually.

   1. Basically relies on Lockdep to track typical locks and IRQ things.

   2. Dept fails to recognize IRQ situation so it generates false alarms
      when raw_local_irq_*() APIs are used. So made it track those too.

   3. Lockdep doesn't track the outmost {hard,soft}irq entracnes but
      Dept makes use of it. So made it track those too.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h            |  22 +++++-
 include/linux/local_lock_internal.h |   1 +
 include/linux/lockdep.h             | 102 ++++++++++++++++++++++------
 include/linux/lockdep_types.h       |   3 +
 include/linux/mutex.h               |   1 +
 include/linux/percpu-rwsem.h        |   2 +-
 include/linux/rtmutex.h             |   1 +
 include/linux/rwlock_types.h        |   1 +
 include/linux/rwsem.h               |   1 +
 include/linux/seqlock.h             |   2 +-
 include/linux/spinlock_types_raw.h  |   3 +
 include/linux/srcu.h                |   2 +-
 kernel/dependency/dept.c            |   4 +-
 kernel/locking/lockdep.c            |  23 +++++++
 14 files changed, 139 insertions(+), 29 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5ec0fa71399e..0ebc5ec2dbd4 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -13,6 +13,7 @@
 #define _LINUX_TRACE_IRQFLAGS_H
 
 #include <linux/typecheck.h>
+#include <linux/dept.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -60,8 +61,10 @@ extern void trace_hardirqs_off(void);
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
 # define lockdep_hardirq_enter()			\
 do {							\
-	if (__this_cpu_inc_return(hardirq_context) == 1)\
+	if (__this_cpu_inc_return(hardirq_context) == 1) { \
 		current->hardirq_threaded = 0;		\
+		dept_hardirq_enter();			\
+	}						\
 } while (0)
 # define lockdep_hardirq_threaded()		\
 do {						\
@@ -136,6 +139,8 @@ do {						\
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
+	if (current->softirq_context == 1)	\
+		dept_softirq_enter();		\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
@@ -170,17 +175,28 @@ extern void warn_bogus_irq_restore(void);
 /*
  * Wrap the arch provided IRQ routines to provide appropriate checks.
  */
-#define raw_local_irq_disable()		arch_local_irq_disable()
-#define raw_local_irq_enable()		arch_local_irq_enable()
+#define raw_local_irq_disable()				\
+	do {						\
+		arch_local_irq_disable();		\
+		dept_hardirqs_off();			\
+	} while (0)
+#define raw_local_irq_enable()				\
+	do {						\
+		dept_hardirqs_on();			\
+		arch_local_irq_enable();		\
+	} while (0)
 #define raw_local_irq_save(flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
 		flags = arch_local_irq_save();		\
+		dept_hardirqs_off();			\
 	} while (0)
 #define raw_local_irq_restore(flags)			\
 	do {						\
 		typecheck(unsigned long, flags);	\
 		raw_check_bogus_irq_restore();		\
+		if (!arch_irqs_disabled_flags(flags))	\
+			dept_hardirqs_on();		\
 		arch_local_irq_restore(flags);		\
 	} while (0)
 #define raw_local_save_flags(flags)			\
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 975e33b793a7..39f67788fd95 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -21,6 +21,7 @@ typedef struct {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},						\
 	.owner = NULL,
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 74bd269a80a2..f6bf7567b8df 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -12,6 +12,7 @@
 
 #include <linux/lockdep_types.h>
 #include <linux/smp.h>
+#include <linux/dept_ldt.h>
 #include <asm/percpu.h>
 
 struct task_struct;
@@ -39,6 +40,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 	 */
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		to->class_cache[i] = NULL;
+
+	dept_map_copy(&to->dmap, &from->dmap);
 }
 
 /*
@@ -458,7 +461,8 @@ enum xhlock_context_t {
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	  .dmap = DEPT_MAP_INITIALIZER(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
@@ -540,33 +544,89 @@ extern bool read_lock_is_recursive(void);
 #define lock_acquire_shared(l, s, t, n, i)		lock_acquire(l, s, t, 1, 1, n, i)
 #define lock_acquire_shared_recursive(l, s, t, n, i)	lock_acquire(l, s, t, 2, 1, n, i)
 
-#define spin_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define spin_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define spin_release(l, i)			lock_release(l, i)
-
-#define rwlock_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
+#define spin_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define spin_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define spin_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define rwlock_acquire(l, s, t, i)					\
+do {									\
+	ldt_wlock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
 #define rwlock_acquire_read(l, s, t, i)					\
 do {									\
+	ldt_rlock(&(l)->dmap, s, t, NULL, i, !read_lock_is_recursive());\
 	if (read_lock_is_recursive())					\
 		lock_acquire_shared_recursive(l, s, t, NULL, i);	\
 	else								\
 		lock_acquire_shared(l, s, t, NULL, i);			\
 } while (0)
-
-#define rwlock_release(l, i)			lock_release(l, i)
-
-#define seqcount_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define seqcount_acquire_read(l, s, t, i)	lock_acquire_shared_recursive(l, s, t, NULL, i)
-#define seqcount_release(l, i)			lock_release(l, i)
-
-#define mutex_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define mutex_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define mutex_release(l, i)			lock_release(l, i)
-
-#define rwsem_acquire(l, s, t, i)		lock_acquire_exclusive(l, s, t, NULL, i)
-#define rwsem_acquire_nest(l, s, t, n, i)	lock_acquire_exclusive(l, s, t, n, i)
-#define rwsem_acquire_read(l, s, t, i)		lock_acquire_shared(l, s, t, NULL, i)
-#define rwsem_release(l, i)			lock_release(l, i)
+#define rwlock_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define seqcount_acquire(l, s, t, i)					\
+do {									\
+	ldt_wlock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define seqcount_acquire_read(l, s, t, i)				\
+do {									\
+	ldt_rlock(&(l)->dmap, s, t, NULL, i, false);			\
+	lock_acquire_shared_recursive(l, s, t, NULL, i);		\
+} while (0)
+#define seqcount_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define mutex_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define mutex_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define mutex_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
+#define rwsem_acquire(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_exclusive(l, s, t, NULL, i);			\
+} while (0)
+#define rwsem_acquire_nest(l, s, t, n, i)				\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, n, i);				\
+	lock_acquire_exclusive(l, s, t, n, i);				\
+} while (0)
+#define rwsem_acquire_read(l, s, t, i)					\
+do {									\
+	ldt_lock(&(l)->dmap, s, t, NULL, i);				\
+	lock_acquire_shared(l, s, t, NULL, i);				\
+} while (0)
+#define rwsem_release(l, i)						\
+do {									\
+	ldt_unlock(&(l)->dmap, i);					\
+	lock_release(l, i);						\
+} while (0)
 
 #define lock_map_acquire(l)			lock_acquire_exclusive(l, 0, 0, NULL, _THIS_IP_)
 #define lock_map_acquire_try(l)			lock_acquire_exclusive(l, 0, 1, NULL, _THIS_IP_)
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 59f4fb1626ea..fc3e0c136b86 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_TYPES_H
 
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
@@ -77,6 +78,7 @@ struct lock_class_key {
 		struct hlist_node		hash_entry;
 		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 	};
+	struct dept_key				dkey;
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
@@ -186,6 +188,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8f226d460f51..58bf314eddeb 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -25,6 +25,7 @@
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index 36b942b67b7d..e871aca04645 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -21,7 +21,7 @@ struct percpu_rw_semaphore {
 };
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname, .dmap = DEPT_MAP_INITIALIZER(lockname, NULL) },
 #else
 #define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
 #endif
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 7d049883a08a..35889ac5eeae 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -81,6 +81,7 @@ do { \
 	.dep_map = {					\
 		.name = #mutexname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(mutexname, NULL),\
 	}
 #else
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 1948442e7750..6e58dfc84997 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -10,6 +10,7 @@
 	.dep_map = {							\
 		.name = #lockname,					\
 		.wait_type_inner = LD_WAIT_CONFIG,			\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),		\
 	}
 #else
 # define RW_DEP_MAP_INIT(lockname)
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index efa5c324369a..4f856e745dce 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -21,6 +21,7 @@
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 3926e9027947..6ba00bcbc11a 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -81,7 +81,7 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 # define SEQCOUNT_DEP_MAP_INIT(lockname)				\
-		.dep_map = { .name = #lockname }
+		.dep_map = { .name = #lockname, .dmap = DEPT_MAP_INITIALIZER(lockname, NULL) }
 
 /**
  * seqcount_init() - runtime initializer for seqcount_t
diff --git a/include/linux/spinlock_types_raw.h b/include/linux/spinlock_types_raw.h
index 91cb36b65a17..3dcc551ded25 100644
--- a/include/linux/spinlock_types_raw.h
+++ b/include/linux/spinlock_types_raw.h
@@ -31,11 +31,13 @@ typedef struct raw_spinlock {
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SPIN,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 # define SPIN_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 
 # define LOCAL_SPIN_DEP_MAP_INIT(lockname)		\
@@ -43,6 +45,7 @@ typedef struct raw_spinlock {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	}
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 41c4b26fb1c1..49efe1f427fa 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -35,7 +35,7 @@ int __init_srcu_struct(struct srcu_struct *ssp, const char *name,
 	__init_srcu_struct((ssp), #ssp, &__srcu_key); \
 })
 
-#define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name },
+#define __SRCU_DEP_MAP_INIT(srcu_name)	.dep_map = { .name = #srcu_name, .dmap = DEPT_MAP_INITIALIZER(srcu_name, NULL) },
 #else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 
 int init_srcu_struct(struct srcu_struct *ssp);
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 8ec638254e5f..d3b6d2f4cd7b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -245,10 +245,10 @@ static inline bool dept_working(void)
  * Even k == NULL is considered as a valid key because it would use
  * &->map_key as the key in that case.
  */
-struct dept_key __dept_no_validate__;
+extern struct lock_class_key __lockdep_no_validate__;
 static inline bool valid_key(struct dept_key *k)
 {
-	return &__dept_no_validate__ != k;
+	return &__lockdep_no_validate__.dkey != k;
 }
 
 /*
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4dfd2f3e09b2..97eaf13cddd8 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1221,6 +1221,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	struct lock_class_key *k;
 	unsigned long flags;
 
+	dept_key_init(&key->dkey);
+
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 	hash_head = keyhashentry(key);
@@ -4343,6 +4345,8 @@ void noinstr lockdep_hardirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
+	dept_hardirqs_on_ip(ip);
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4408,6 +4412,8 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
  */
 void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
+	dept_hardirqs_off_ip(ip);
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4452,6 +4458,8 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
+	dept_softirqs_on_ip(ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4490,6 +4498,9 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
+
+	dept_softirqs_off_ip(ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4837,6 +4848,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 {
 	int i;
 
+	ldt_init(&lock->dmap, &key->dkey, subclass, name);
+
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		lock->class_cache[i] = NULL;
 
@@ -5581,6 +5594,12 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
 {
 	unsigned long flags;
 
+	/*
+	 * dept_map_(re)init() might be called twice redundantly. But
+	 * there's no choice as long as Dept relies on Lockdep.
+	 */
+	ldt_set_class(&lock->dmap, name, &key->dkey, subclass, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -5598,6 +5617,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	ldt_downgrade(&lock->dmap, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -6398,6 +6419,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	unsigned long flags;
 	bool found = false;
 
+	dept_key_destroy(&key->dkey);
+
 	might_sleep();
 
 	if (WARN_ON_ONCE(static_obj(key)))
-- 
2.17.1

