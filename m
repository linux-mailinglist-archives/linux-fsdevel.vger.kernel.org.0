Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2719B4BC7D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiBSK7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:59:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbiBSK7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:59:04 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo13.lge.com [156.147.23.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97B469280
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:58:41 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 19 Feb 2022 19:58:41 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:58:41 +0900
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
Subject: [PATCH v2 03/18] dept: Embed Dept data in Lockdep
Date:   Sat, 19 Feb 2022 19:58:16 +0900
Message-Id: <1645268311-24222-4-git-send-email-byungchul.park@lge.com>
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

Dept should work independently from Lockdep. However, there's no choise
but to rely on Lockdep code and its instances for now.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/lockdep.h       | 71 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/lockdep_types.h |  3 ++
 kernel/locking/lockdep.c      | 12 ++++----
 3 files changed, 76 insertions(+), 10 deletions(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b942..c56f6b6 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -20,6 +20,33 @@
 extern int prove_locking;
 extern int lock_stat;
 
+#ifdef CONFIG_DEPT
+static inline void dept_after_copy_map(struct dept_map *to,
+				       struct dept_map *from)
+{
+	int i;
+
+	if (from->keys == &from->keys_local)
+		to->keys = &to->keys_local;
+
+	if (!to->keys)
+		return;
+
+	/*
+	 * Since the class cache can be modified concurrently we could observe
+	 * half pointers (64bit arch using 32bit copy insns). Therefore clear
+	 * the caches and take the performance hit.
+	 *
+	 * XXX it doesn't work well with lockdep_set_class_and_subclass(), since
+	 *     that relies on cache abuse.
+	 */
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++)
+		to->keys->classes[i] = NULL;
+}
+#else
+#define dept_after_copy_map(t, f)	do { } while (0)
+#endif
+
 #ifdef CONFIG_LOCKDEP
 
 #include <linux/linkage.h>
@@ -43,6 +70,8 @@ static inline void lockdep_copy_map(struct lockdep_map *to,
 	 */
 	for (i = 0; i < NR_LOCKDEP_CACHING_CLASSES; i++)
 		to->class_cache[i] = NULL;
+
+	dept_after_copy_map(&to->dmap, &from->dmap);
 }
 
 /*
@@ -176,8 +205,19 @@ struct held_lock {
 	current->lockdep_recursion -= LOCKDEP_OFF;	\
 } while (0)
 
-extern void lockdep_register_key(struct lock_class_key *key);
-extern void lockdep_unregister_key(struct lock_class_key *key);
+extern void __lockdep_register_key(struct lock_class_key *key);
+extern void __lockdep_unregister_key(struct lock_class_key *key);
+
+#define lockdep_register_key(k)				\
+do {							\
+	__lockdep_register_key(k);			\
+	dept_key_init(&(k)->dkey);			\
+} while (0)
+#define lockdep_unregister_key(k)			\
+do {							\
+	__lockdep_unregister_key(k);			\
+	dept_key_destroy(&(k)->dkey);			\
+} while (0)
 
 /*
  * These methods are used by specific locking variants (spinlocks,
@@ -185,9 +225,18 @@ struct held_lock {
  * to lockdep:
  */
 
-extern void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+extern void __lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 	struct lock_class_key *key, int subclass, u8 inner, u8 outer, u8 lock_type);
 
+#define lockdep_init_map_type(l, n, k, s, i, o, t)		\
+do {								\
+	__lockdep_init_map_type(l, n, k, s, i, o, t);		\
+	if ((k) == &__lockdep_no_validate__)			\
+		dept_map_nocheck(&(l)->dmap);			\
+	else							\
+		dept_map_init(&(l)->dmap, &(k)->dkey, s, n);	\
+} while (0)
+
 static inline void
 lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
 		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
@@ -431,13 +480,27 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
+#ifdef CONFIG_DEPT
+/*
+ * TODO: I found the case to use an address of other than a real key as
+ * _key, for instance, in workqueue. So for now, we cannot use the
+ * assignment like '.dmap.keys = &(_key)->dkey' unless it's fixed.
+ */
+#define STATIC_DEPT_MAP_INIT(_name, _key) .dmap = {		\
+	.name = (_name),					\
+	.keys = NULL },
+#else
+#define STATIC_DEPT_MAP_INIT(_name, _key)
+#endif
+
 #define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
  */
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
-	{ .name = (_name), .key = (void *)(_key), }
+	{ .name = (_name), .key = (void *)(_key), \
+	STATIC_DEPT_MAP_INIT(_name, _key) }
 
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index d224308..50c8879 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -11,6 +11,7 @@
 #define __LINUX_LOCKDEP_TYPES_H
 
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #define MAX_LOCKDEP_SUBCLASSES		8UL
 
@@ -76,6 +77,7 @@ struct lock_class_key {
 		struct hlist_node		hash_entry;
 		struct lockdep_subclass_key	subkeys[MAX_LOCKDEP_SUBCLASSES];
 	};
+	struct dept_key				dkey;
 };
 
 extern struct lock_class_key __lockdep_no_validate__;
@@ -185,6 +187,7 @@ struct lockdep_map {
 	int				cpu;
 	unsigned long			ip;
 #endif
+	struct dept_map			dmap;
 };
 
 struct pin_cookie { unsigned int val; };
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4a882f8..a85468d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1184,7 +1184,7 @@ static inline struct hlist_head *keyhashentry(const struct lock_class_key *key)
 }
 
 /* Register a dynamically allocated key. */
-void lockdep_register_key(struct lock_class_key *key)
+void __lockdep_register_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head;
 	struct lock_class_key *k;
@@ -1207,7 +1207,7 @@ void lockdep_register_key(struct lock_class_key *key)
 restore_irqs:
 	raw_local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(lockdep_register_key);
+EXPORT_SYMBOL_GPL(__lockdep_register_key);
 
 /* Check whether a key has been registered as a dynamic key. */
 static bool is_dynamic_key(const struct lock_class_key *key)
@@ -4771,7 +4771,7 @@ static inline int check_wait_context(struct task_struct *curr,
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+void __lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 			    struct lock_class_key *key, int subclass,
 			    u8 inner, u8 outer, u8 lock_type)
 {
@@ -4831,7 +4831,7 @@ void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 		raw_local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(lockdep_init_map_type);
+EXPORT_SYMBOL_GPL(__lockdep_init_map_type);
 
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);
@@ -6291,7 +6291,7 @@ void lockdep_reset_lock(struct lockdep_map *lock)
 }
 
 /* Unregister a dynamically allocated key. */
-void lockdep_unregister_key(struct lock_class_key *key)
+void __lockdep_unregister_key(struct lock_class_key *key)
 {
 	struct hlist_head *hash_head = keyhashentry(key);
 	struct lock_class_key *k;
@@ -6326,7 +6326,7 @@ void lockdep_unregister_key(struct lock_class_key *key)
 	/* Wait until is_dynamic_key() has finished accessing k->hash_entry. */
 	synchronize_rcu();
 }
-EXPORT_SYMBOL_GPL(lockdep_unregister_key);
+EXPORT_SYMBOL_GPL(__lockdep_unregister_key);
 
 void __init lockdep_init(void)
 {
-- 
1.9.1

