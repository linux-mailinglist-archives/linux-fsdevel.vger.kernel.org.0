Return-Path: <linux-fsdevel+bounces-49351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71270ABB8E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678AE1897DDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AA6275846;
	Mon, 19 May 2025 09:18:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45226E14C;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646334; cv=none; b=dWunZ+vr8Y4zyKR6VR/kZUhS5UGbNUOrYAxE2+z2Anw4AUM8lOaeRtTc//eULu4IvpyEMFM2i+6xfWBmw/FtJS3ilZER9vCFLsbUnXwqKDfn5K5ejkWz7lOkVzqZiJdsS0CdWx8eLjose06LMzrGryx+Lr8gJCPTRGvw7whBYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646334; c=relaxed/simple;
	bh=sdBf+jdap8ZYMWI+dmhqrnpwWrwLomAGjaFbuF2ajZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ABSznEzO1SM8qGLKl/mQexHfPZ6OyxSBZ3Ez0E5IkgceFiXdqU3sp3KKxm6kuQ5gBS9x4dzcvhGkVvat5AfU2+pE/2h0hhRX/fjvbAMZupIixkz0zNF2zRj1WVYz9VNfE2qwnfpKJXBNNbj8KuRFkiOHktThJ2dVuXjwgnpHl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-83-682af76e49b0
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v16 05/42] dept: tie to lockdep and IRQ tracing
Date: Mon, 19 May 2025 18:17:49 +0900
Message-Id: <20250519091826.19752-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99yX516KJTedzjs121LndBid+DKPy3B80ueLxsSYvZhF67ja
	Cq1aFMRJArQQlZX4MiRDxFK0w7ZIbdnGnKUVAg7IpEJFRERkhthYQCrtRNhmwfjl5Jec//93
	vhyeVtxk5/Ea3UFJr1OlK7GMkQ3Pqlym+ydRveJGw0KIjB9joLzWgcF/xY7AUZdHQbB5I9yN
	hhBM/tVBQ2mJH0Hlowc01LX0I/BU52PoepwAgcgohtaSIgyGqloMt59OUdB39jQFdtcmeGgd
	YqD9pIWC0iCGc6UGKjaeUDBhtXFgzV0Eg9VlHEw9SoLW/m4WPL1L4aeKPgzXPa0MtNQPUtB1
	rRxDv+N/Ftpb/mQgWjwf/KdMLNSMWDA8jVppsEZGOej0mSloMb8DTmNMWPj8PxZumnwUFF68
	SkHg3h8IGo4NUOBydGNoioQocLtKaHj5czOCweJhDgp+mODgXF4xgqKCswwY+9bA5IvY5fPj
	SZB3wclAzb/dKCWZOCociDSFRmlidGeRl5E7mHiiZoa0WUTye9kDjhgbejlidh0i7upEUnU9
	SJHKcIQlLttxTFzh0xw5MRygyMitW9yWBd/IPk+V0jWZkv6T9Ttl6tpTRry/8/vDzoEFuejy
	rhMojheF1eLItTr2DV8uN6FpxsJisadngp7m2cIHots0FMvIeFrojhfvnr83E3pb+EL8xRea
	KTPCIjE4NoCnWS6sEZvywsxr6fui3embEcUJn4q9RU0zXUUsE7BXMNNSUTgTJ0YNXu514V3x
	RnUPcxLJzegtG1JodJlalSZ99XJ1tk5zePl3+7QuFHsva87U9noU9m9tRAKPlLPkTs/HagWr
	yszI1jYikaeVs+U29xK1Qp6qyj4i6fft0B9KlzIa0XyeUc6Vr4xmpSqEPaqDUpok7Zf0b7YU
	HzcvF6XYs75aN75Zd/UzQ4cvfn3pAe2QEP9b38qa/HxTecrRXduLatstL+w5hT92blj1XoK0
	t8qwra3Xz2q9W8b+TmPjlxVc+vBxx5fYIk8IpfWT8YFiPlDYkRxuG6v35nu/Xrvx6P07XlvK
	cFd455xvV3yU0zyZfGTI++ue3RWbnpWNBZ8omQy1KimR1meoXgE99uKMWgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe97rXC3eptVrF4pBVJMsIeNAZVFED1IRBEZ9yZUvbuXMtjJX
	BJpTSpu0wOyitlSWbrOtrYu3iTlaLakszUpsmUmlriRzlmbWNPpy+MH5n9/58heR0ip6nkiV
	elTQpCpSZIyYEu9Ym71C/UOuXNU7IIbg8BkKiu02BlpvWhHYbmcR0PdgK7waCSD49eQZCUWF
	rQiuv39Lwm2vH4G78jQDbb0zoT04yICvMJ+B7HI7A88HxgnouniBAKtzO7wzf6Sg5XwZAUV9
	DFwtyiZC4zMBo2YLC+bMJdBTeYWF8fcx4PN30OAp8dHg7oyCy6VdDDS4fRR4a3oIaKsrZsBv
	+0NDi/cRBSMF86HVaKCh+msZAwMjZhLMwUEWXjSZCPCa5oBDH7Lmfp+g4aGhiYDcilsEtL+p
	R9B4ppsAp62DAU8wQIDLWUjC2I0HCHoKvrCQc26UhatZBQjycy5SoO+KhV8/Q59LhmMg65qD
	gurfHWhjHLaV2hD2BAZJrHcdx2PBlwx2j5go/LiMx7VX3rJY39jJYpPzGHZVynF5Qx+Brw8F
	aey0nGWwc+gCi/O+tBP469On7M6Fe8XrkoQUVbqgWRmXKFbajXom7cXJDEf3gkxUtT8PhYl4
	bjVfVWxAk8xwS/nXr0fJSY7gFvMuw0c6D4lFJNcxnX9V8mYqFM5t4O80BehJprglfN+3bmaS
	JVws78kaov5JF/FWR9OUKIxbw3fme6ZupaFMu7WUOo/EJjTNgiJUqelqhSolNlp7SKlLVWVE
	HzisdqJQgcynxo01aLhtazPiREg2Q+JwL1dKaUW6VqduRryIlEVILK5lSqkkSaE7IWgO79Mc
	SxG0zWi+iJLNlcTvFhKlXLLiqHBIENIEzf8tIQqbl4n29XPv/KVr1yfMvlRhiKzafOSg0fwn
	7sa5wKyYnLsvySj3Hfp+MEmuG0vwfVh0urp1qTpuD7Etvj9iS1StxRupS65ITOv+NLO+ruWg
	wmwb6/c1sJvisTGHlifU197rtO6PDPc/nnimXP2odyAsY/nvaPs0tc4+kZzbz+4yqQuKZJRW
	qYiRkxqt4i9Scb27PAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

How to place dept this way looks so ugly.  However, it's inevitable for
now.  The way should be enhanced gradually.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/irqflags.h            |   7 +-
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
 kernel/dependency/dept.c            |   8 +--
 kernel/locking/lockdep.c            |  22 ++++++
 14 files changed, 127 insertions(+), 29 deletions(-)

diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 57b074e0cfbb..d8b9cf093f83 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -15,6 +15,7 @@
 #include <linux/irqflags_types.h>
 #include <linux/typecheck.h>
 #include <linux/cleanup.h>
+#include <linux/dept.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -55,8 +56,10 @@ extern void trace_hardirqs_off(void);
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
@@ -131,6 +134,8 @@ do {						\
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
+	if (current->softirq_context == 1)	\
+		dept_softirq_enter();		\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index 8d5ac16a9b17..ec3ff5931aa6 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -27,6 +27,7 @@ typedef struct {
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
 		.lock_type = LD_LOCK_PERCPU,		\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},						\
 	.owner = NULL,
 
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 67964dc4db95..ef03d8808c10 100644
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
@@ -428,7 +431,8 @@ enum xhlock_context_t {
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	  .dmap = DEPT_MAP_INITIALIZER(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
@@ -510,33 +514,89 @@ extern bool read_lock_is_recursive(void);
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
index 9f361d3ab9d9..6ef4dc67efb3 100644
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
@@ -195,6 +197,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2143d05116be..f3ae3b11e7af 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -29,6 +29,7 @@ struct device;
 		, .dep_map = {					\
 			.name = #lockname,			\
 			.wait_type_inner = LD_WAIT_SLEEP,	\
+			.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 		}
 #else
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index af7d75ede619..857b0d46f6f1 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -22,7 +22,7 @@ struct percpu_rw_semaphore {
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
index c8b543d428b0..2540b18e3489 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -22,6 +22,7 @@
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SLEEP,	\
+		.dmap = DEPT_MAP_INITIALIZER(lockname, NULL),\
 	},
 #else
 # define __RWSEM_DEP_MAP_INIT(lockname)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 5ce48eab7a2a..5f3447449fe0 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -51,7 +51,7 @@ static inline void __seqcount_init(seqcount_t *s, const char *name,
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
index 900b0d5c05f5..f2903bdc8179 100644
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
index a6671b13891f..6cdda00411bc 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -249,10 +249,10 @@ static bool dept_working(void)
  * Even k == NULL is considered as a valid key because it would use
  * &->map_key as the key in that case.
  */
-struct dept_key __dept_no_validate__;
+extern struct lock_class_key __lockdep_no_validate__;
 static bool valid_key(struct dept_key *k)
 {
-	return &__dept_no_validate__ != k;
+	return &__lockdep_no_validate__.dkey != k;
 }
 
 /*
@@ -1946,7 +1946,7 @@ void dept_softirqs_off(void)
 	dept_task()->softirqs_enabled = false;
 }
 
-void dept_hardirqs_off(void)
+void noinstr dept_hardirqs_off(void)
 {
 	/*
 	 * Assumes that it's called with IRQ disabled so that accessing
@@ -1968,7 +1968,7 @@ void dept_softirq_enter(void)
 /*
  * Ensure it's the outmost hardirq context.
  */
-void dept_hardirq_enter(void)
+void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 58d78a33ac65..6c984a55d5ed 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1226,6 +1226,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	struct lock_class_key *k;
 	unsigned long flags;
 
+	dept_key_init(&key->dkey);
+
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 	hash_head = keyhashentry(key);
@@ -4362,6 +4364,8 @@ static void __trace_hardirqs_on_caller(void)
  */
 void lockdep_hardirqs_on_prepare(void)
 {
+	dept_hardirqs_on();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4482,6 +4486,8 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
  */
 void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
+	dept_hardirqs_off();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4526,6 +4532,8 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
+	dept_softirqs_on_ip(ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4564,6 +4572,8 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
+	dept_softirqs_off();
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4941,6 +4951,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 {
 	int i;
 
+	ldt_init(&lock->dmap, &key->dkey, subclass, name);
+
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		lock->class_cache[i] = NULL;
 
@@ -5734,6 +5746,12 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
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
 
@@ -5751,6 +5769,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	ldt_downgrade(&lock->dmap, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -6586,6 +6606,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	bool found = false;
 	bool need_callback = false;
 
+	dept_key_destroy(&key->dkey);
+
 	might_sleep();
 
 	if (WARN_ON_ONCE(static_obj(key)))
-- 
2.17.1


