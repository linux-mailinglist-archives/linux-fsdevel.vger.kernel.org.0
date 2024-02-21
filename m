Return-Path: <linux-fsdevel+bounces-12228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B8A85D46D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5081E1F281D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0D33F9C0;
	Wed, 21 Feb 2024 09:49:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94C3D541;
	Wed, 21 Feb 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508996; cv=none; b=X+JjW3s787rkFZhC5kW7GP/iySSwSo0JW1hKbsDbQYEzyTXLoImK5l39wkh8EUqrs56Bd7ZZVmyBn6cAM832hRl8RGiCDgbQb+H9hgalafgnuoO7TV+PYmTZdPYV8KsDSk7SogYYIndDLOCaqsS603ViknFvjOPvDPSvc5kQ7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508996; c=relaxed/simple;
	bh=QWHRCvl6WHVJCxC3TSQ+F2P9dkdR+c40EtoDliptNOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=arczJjH1o7/DiDQjc2JnwSMwUu0F5AN9MIryRh4VPJGntLe1+xJ2WrI5U22zr2DcvAy1l3A/4IlcTgJEnlanDdWQLyshyvLd1O5nN67B8Mv8fXPJbugN2KswkknQdTRunpRBl2+Ebim+AX6xMtQl/ObR+kqeycSOrdtdkW5O9M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-d6-65d5c738f4e1
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
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v12 05/27] dept: Tie to Lockdep and IRQ tracing
Date: Wed, 21 Feb 2024 18:49:11 +0900
Message-Id: <20240221094933.36348-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSaUxTaRSG/b67UqneFBOvYOLYBHGJa9ScMe7JZK7JTDLRH0aN0SpX2kir
	abGAxoTVQRSjZhCUzljA1FJQoBX3EigpiAZspSoiVEWigxSr1OJUQGwZ/XPy5LxvnpwfhyVk
	d6hYVqVJEbUaRbKclpCSwejShT+3PBaX2JwknDm5BIKf8kgwVFfR4LpaiaDqWiaGfuev8HTY
	h2Ck7SEBRYUuBKWvegi41uxFYDdn0dDRNwU8QT8NrYUnaMgur6bBPTCKofvcWQyV1t/hweky
	DA2htyQU9dNQUpSNw+NfDCGThQFTRjz0mi8wMPpqKbR6n1Bg71oA5//ppuGuvZWE5pu9GDpu
	G2jwVo1T8KD5HgmuMwUUXHlfRsPAsIkAU9DPwKMGI4aanLDoWOArBS0FDRiOXarF4Hl2B0F9
	3ksM1qonNDQFfRhs1kICvlx2Iug9NchA7skQAyWZpxCcyD1HwsOxFgpyulfAyH8Gev0qocnn
	J4QcW6pgHzaSwv0yXrh1oYcRcuq7GMFoPSTYzPOF8rv9WCgdClKC1XKcFqxDZxkhf9CDhfft
	7Yxwr3iEFPo8RfiPuO2S1Yliskovahev3S1RVoyVkgf/OpL2zBpgMtBHRT6KYnluOe/tGcM/
	+PrVWibCNJfAd3aGiAhP437ibQVvqHwkYQnuz8m8+UMbHQliuHV80OKgIkxy8fztrvEJkZRb
	wRuMdeT/0ll8ZU3DhCiKW8lXlPgm+rJw57G7johIeS47in9e0ff9ihl8o7mTPI2kRjTJgmQq
	jV6tUCUvX6RM16jSFu09oLai8EuZjo7uuImGXFsciGORPFqqvOERZZRCr0tXOxDPEvJpUjI1
	vJImKtIPi9oDu7SHkkWdA8WxpHy6dNlwaqKMS1KkiPtF8aCo/ZFiNio2A1Efire6swbn6vy7
	Ay/ebsysIZxbZ6Y1TorV73R1xri34TkJ87JeEhfX+ELuo3qtZaU9yI6Lf/+2eApV1+TP3BAs
	3uSI3paUmxAb+GVAPfvremPb1PK8Ofrjn2bH7XsnrTXw7emvP8fPYn2b1Xucfl91/PbCL7kp
	HepaZaDHofHKSZ1SsXQ+odUpvgGIL+v+TgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2xLYRjHve+5dYfKMcNBhTVkLnFLlMclLp+8IUSCiFtoONHaBS1jRLLa
	BWNiYzq70HZStZXNGXPbpNlYzdjKamaZYZnL2AVbF7MNLfHlyS///z+/T4+CCs5mRin0UXsl
	Q5Q2Qs3yNL9yftxUcL+QZvTJkyDl5AzwdR2jISvfyYLnWh4C5w0ThpaHS+FldyuC3qfVFJjT
	PAis715TcKO8EUGJ4wgLNc2DwevrYKEi7QQLcTn5LDz70oeh4Vwqhjx5BVSetmFw9XykwdzC
	QqY5DvvPJww99lwO7LEToMmRwUHfu5lQ0VjLQFl2BQMl9VPg/IUGFopLKmgov92EoeZuFguN
	zt8MVJY/osGTkszA1XYbC1+67RTYfR0cPHdZMBTE+22Jnb8YcCe7MCReuo7B++oegvvH3mKQ
	nbUslPlaMRTKaRT8vPwQQdOpNg4STvZwkGk6heBEwjkaqvvdDMQ3aKD3Rxa7eD4pa+2gSHzh
	flLSbaHJY5tI7mS85kj8/XqOWOR9pNAxmeQUt2Bi/e5jiJx7nCXy91SOJLV5MWmvquLIo/Re
	mjR7zXiVagO/YLsUoY+WDNMXbuV1V/qt9O6zhw68kju5WPRNm4SCFKIwSyy6dp0LMCuEiXV1
	PVSAQ4RxYmHyByYJ8QpKODpQdHx9ygaKocIi0ZdbygSYFiaId+t/4wArBY2YZblJ/5OOFfMK
	XH9FQcJs8Upm6999sH/z4tlN6jTiLWhALgrRR0VHavURmmnGcF1MlP7AtG27ImXkfxr74b6U
	26irZmkpEhRIPUipu+WVghlttDEmshSJCkodoqT3+yPldm3MQcmwa4thX4RkLEWjFbR6hHLZ
	OmlrsLBDu1cKl6TdkuF/ixVBo2KR52pze7Zbl+cqGv4+lf+VE7t8j+YbWiMusmU0bwpb/UDV
	Xj9sc3FVWLr7fcyQfJdGlb7OkKOaKJn7z98TC8KLavl5lRfveBK6HGT8k7FnjqzuDJlTZ12+
	0Rbaxn50JralVNtMzqQCk2rMzsQtob0jl5heelas9X1+88H6Zv1c3qqmjTrtzMmUwaj9A76H
	vmkwAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

How to place Dept this way looks so ugly. But it's inevitable for now.
The way should be enhanced gradually.

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
index 2b665c32f5fe..672dac1c3059 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -14,6 +14,7 @@
 
 #include <linux/typecheck.h>
 #include <linux/cleanup.h>
+#include <linux/dept.h>
 #include <asm/irqflags.h>
 #include <asm/percpu.h>
 
@@ -61,8 +62,10 @@ extern void trace_hardirqs_off(void);
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
@@ -137,6 +140,8 @@ do {						\
 # define lockdep_softirq_enter()		\
 do {						\
 	current->softirq_context++;		\
+	if (current->softirq_context == 1)	\
+		dept_softirq_enter();		\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
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
index dc2844b071c2..8825f535d36d 100644
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
@@ -466,7 +469,8 @@ enum xhlock_context_t {
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	  .dmap = DEPT_MAP_INITIALIZER(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
@@ -548,33 +552,89 @@ extern bool read_lock_is_recursive(void);
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
index 2ebc323d345a..aecd65836b2c 100644
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
@@ -194,6 +196,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index a33aa9eb9fc3..04c41faace85 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -26,6 +26,7 @@
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
index 1dd530ce8b45..1fa391e7770a 100644
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
index e92f9d5577ba..dee83ab183e4 100644
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
index 127ef3b2e607..f6b8266a4bfd 100644
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
index a3e774479f94..7e12e46dc4b7 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -244,10 +244,10 @@ static bool dept_working(void)
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
@@ -1936,7 +1936,7 @@ void dept_softirqs_off(void)
 	dept_task()->softirqs_enabled = false;
 }
 
-void dept_hardirqs_off(void)
+void noinstr dept_hardirqs_off(void)
 {
 	/*
 	 * Assumes that it's called with IRQ disabled so that accessing
@@ -1958,7 +1958,7 @@ void dept_softirq_enter(void)
 /*
  * Ensure it's the outmost hardirq context.
  */
-void dept_hardirq_enter(void)
+void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 151bd3de5936..e27cf9d17163 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1215,6 +1215,8 @@ void lockdep_register_key(struct lock_class_key *key)
 	struct lock_class_key *k;
 	unsigned long flags;
 
+	dept_key_init(&key->dkey);
+
 	if (WARN_ON_ONCE(static_obj(key)))
 		return;
 	hash_head = keyhashentry(key);
@@ -4310,6 +4312,8 @@ static void __trace_hardirqs_on_caller(void)
  */
 void lockdep_hardirqs_on_prepare(void)
 {
+	dept_hardirqs_on();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4430,6 +4434,8 @@ EXPORT_SYMBOL_GPL(lockdep_hardirqs_on);
  */
 void noinstr lockdep_hardirqs_off(unsigned long ip)
 {
+	dept_hardirqs_off();
+
 	if (unlikely(!debug_locks))
 		return;
 
@@ -4474,6 +4480,8 @@ void lockdep_softirqs_on(unsigned long ip)
 {
 	struct irqtrace_events *trace = &current->irqtrace;
 
+	dept_softirqs_on_ip(ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4512,6 +4520,8 @@ void lockdep_softirqs_on(unsigned long ip)
  */
 void lockdep_softirqs_off(unsigned long ip)
 {
+	dept_softirqs_off();
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -4859,6 +4869,8 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 {
 	int i;
 
+	ldt_init(&lock->dmap, &key->dkey, subclass, name);
+
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		lock->class_cache[i] = NULL;
 
@@ -5630,6 +5642,12 @@ void lock_set_class(struct lockdep_map *lock, const char *name,
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
 
@@ -5647,6 +5665,8 @@ void lock_downgrade(struct lockdep_map *lock, unsigned long ip)
 {
 	unsigned long flags;
 
+	ldt_downgrade(&lock->dmap, ip);
+
 	if (unlikely(!lockdep_enabled()))
 		return;
 
@@ -6447,6 +6467,8 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	unsigned long flags;
 	bool found = false;
 
+	dept_key_destroy(&key->dkey);
+
 	might_sleep();
 
 	if (WARN_ON_ONCE(static_obj(key)))
-- 
2.17.1


