Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28174519ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiEDIyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346870AbiEDIxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:53:53 -0400
Received: from lgeamrelo11.lge.com (lgeamrelo12.lge.com [156.147.23.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA86F25E9B
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:49:28 -0700 (PDT)
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 4 May 2022 17:19:22 +0900
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
Subject: [PATCH RFC v6 19/21] dept: Differentiate onstack maps from others of different tasks in class
Date:   Wed,  4 May 2022 17:17:47 +0900
Message-Id: <1651652269-15342-20-git-send-email-byungchul.park@lge.com>
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

Dept assumes that maps might belong to the same class if the running
code is the same for possibility detection. However, maps on stack would
never belong to a common class between different tasks because each task
has its own instance on stack.

So differentiated onstack maps from others in class, to avoid false
positive alarms.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     |   3 +
 kernel/dependency/dept.c | 166 ++++++++++++++++++++++++++++++++++++++---------
 kernel/exit.c            |   8 ++-
 3 files changed, 147 insertions(+), 30 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 1a3858c..3027121 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -72,6 +72,7 @@ struct dept_class {
 	 */
 	const char			*name;
 	unsigned long			key;
+	unsigned long			key2;
 	int				sub;
 
 	/*
@@ -343,6 +344,7 @@ struct dept_key {
 struct dept_map {
 	const char			*name;
 	struct dept_key			*keys;
+	unsigned long			key2;
 	int				sub_usr;
 
 	/*
@@ -366,6 +368,7 @@ struct dept_map {
 {									\
 	.name = #n,							\
 	.keys = NULL,							\
+	.key2 = 0UL,							\
 	.sub_usr = 0,							\
 	.keys_local = { .classes = { 0 } },				\
 	.wgen = 0U,							\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 6707313..2bc6259 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -73,6 +73,7 @@
 #include <linux/hash.h>
 #include <linux/dept.h>
 #include <linux/utsname.h>
+#include <linux/sched/task_stack.h>
 #include "dept_internal.h"
 
 static int dept_stop;
@@ -523,12 +524,12 @@ static unsigned long key_dep(struct dept_dep *d)
 
 static bool cmp_class(struct dept_class *c1, struct dept_class *c2)
 {
-	return c1->key == c2->key;
+	return c1->key == c2->key && c1->key2 == c2->key2;
 }
 
 static unsigned long key_class(struct dept_class *c)
 {
-	return c->key;
+	return c->key2 ? mix(c->key, c->key2) : c->key;
 }
 
 #define HASH(id, bits)							\
@@ -571,14 +572,38 @@ static inline struct dept_dep *lookup_dep(struct dept_class *fc,
 	return hash_lookup_dep(&onetime_d);
 }
 
-static inline struct dept_class *lookup_class(unsigned long key)
+static inline struct dept_class *lookup_class(unsigned long key,
+					      unsigned long key2)
 {
-	struct dept_class onetime_c = { .key = key };
+	struct dept_class onetime_c = { .key = key, .key2 = key2 };
 
 	return hash_lookup_class(&onetime_c);
 }
 
 /*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void obtain_classes_from_hlist(struct hlist_head *to,
+			bool (*cmp)(struct dept_class *c, void *data),
+			void *data)
+{
+	struct dept_class *c;
+	struct hlist_node *n;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(table_class); i++) {
+		struct hlist_head *h = table_class + i;
+
+		hlist_for_each_entry_safe(c, n, h, hash_node) {
+			if (cmp(c, data)) {
+				hlist_del_rcu(&c->hash_node);
+				hlist_add_head_rcu(&c->hash_node, to);
+			}
+		}
+	}
+}
+
+/*
  * Report
  * =====================================================================
  * DEPT prints useful information to help debuging on detection of
@@ -1899,6 +1924,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub,
 		   const char *n)
 {
 	unsigned long flags;
+	bool onstack;
 
 	if (unlikely(READ_ONCE(dept_stop) || in_nmi()))
 		return;
@@ -1908,6 +1934,16 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub,
 		return;
 	}
 
+	onstack = object_is_on_stack(m);
+
+	/*
+	 * Require an explicit key for onstack maps.
+	 */
+	if (onstack && !k) {
+		m->nocheck = true;
+		return;
+	}
+
 	/*
 	 * Allow recursive entrance.
 	 */
@@ -1917,6 +1953,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub,
 
 	m->sub_usr = sub;
 	m->keys = k;
+	m->key2 = onstack ? (unsigned long)current : 0UL;
 	m->name = n;
 	m->wgen = 0U;
 	m->nocheck = false;
@@ -2031,7 +2068,7 @@ static inline int map_sub(struct dept_map *m, int e)
 
 static struct dept_class *check_new_class(struct dept_key *local,
 					  struct dept_key *k, int sub,
-					  const char *n)
+					  unsigned long k2, const char *n)
 {
 	struct dept_class *c = NULL;
 
@@ -2047,14 +2084,14 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	if (c)
 		return c;
 
-	c = lookup_class((unsigned long)k->subkeys + sub);
+	c = lookup_class((unsigned long)k->subkeys + sub, k2);
 	if (c)
 		goto caching;
 
 	if (unlikely(!dept_lock()))
 		return NULL;
 
-	c = lookup_class((unsigned long)k->subkeys + sub);
+	c = lookup_class((unsigned long)k->subkeys + sub, k2);
 	if (unlikely(c))
 		goto unlock;
 
@@ -2065,6 +2102,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->name = n;
 	c->sub = sub;
 	c->key = (unsigned long)(k->subkeys + sub);
+	c->key2 = k2;
 	hash_add_class(c);
 	list_add(&c->all_node, &dept_classes);
 unlock:
@@ -2099,8 +2137,8 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		struct dept_key *k;
 
 		k = m->keys ?: &m->keys_local;
-		c = check_new_class(&m->keys_local, k,
-				    map_sub(m, e), m->name);
+		c = check_new_class(&m->keys_local, k, map_sub(m, e),
+				    m->key2, m->name);
 		if (!c)
 			continue;
 
@@ -2298,7 +2336,8 @@ void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
 	DEPT_WARN_ON(1UL << e != e_f);
 
 	k = m->keys ?: &m->keys_local;
-	c = check_new_class(&m->keys_local, k, map_sub(m, e), m->name);
+	c = check_new_class(&m->keys_local, k, map_sub(m, e),
+			    m->key2, m->name);
 
 	if (c && add_ecxt((void *)m, c, ip, c_fn, e_fn, ne))
 		goto exit;
@@ -2376,7 +2415,8 @@ void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 	DEPT_WARN_ON(1UL << e != e_f);
 
 	k = m->keys ?: &m->keys_local;
-	c = check_new_class(&m->keys_local, k, map_sub(m, e), m->name);
+	c = check_new_class(&m->keys_local, k, map_sub(m, e),
+			    m->key2, m->name);
 
 	if (c && add_ecxt((void *)m, c, 0UL, NULL, e_fn, 0)) {
 		do_event((void *)m, c, READ_ONCE(m->wgen), ip);
@@ -2427,7 +2467,8 @@ void dept_ecxt_exit(struct dept_map *m, unsigned long e_f,
 	DEPT_WARN_ON(1UL << e != e_f);
 
 	k = m->keys ?: &m->keys_local;
-	c = check_new_class(&m->keys_local, k, map_sub(m, e), m->name);
+	c = check_new_class(&m->keys_local, k, map_sub(m, e),
+			    m->key2, m->name);
 
 	if (c && pop_ecxt((void *)m, c))
 		goto exit;
@@ -2504,7 +2545,7 @@ void dept_wait_split_map(struct dept_map_each *me,
 	flags = dept_enter();
 
 	k = mc->keys ?: &mc->keys_local;
-	c = check_new_class(&mc->keys_local, k, 0, mc->name);
+	c = check_new_class(&mc->keys_local, k, 0, 0UL, mc->name);
 	if (c)
 		add_wait(c, ip, w_fn, ne);
 
@@ -2568,7 +2609,7 @@ void dept_event_split_map(struct dept_map_each *me,
 	flags = dept_enter();
 
 	k = mc->keys ?: &mc->keys_local;
-	c = check_new_class(&mc->keys_local, k, 0, mc->name);
+	c = check_new_class(&mc->keys_local, k, 0, 0UL, mc->name);
 
 	if (c && add_ecxt((void *)me, c, 0UL, NULL, e_fn, 0)) {
 		do_event((void *)me, c, READ_ONCE(me->wgen), ip);
@@ -2584,12 +2625,64 @@ void dept_event_split_map(struct dept_map_each *me,
 }
 EXPORT_SYMBOL_GPL(dept_event_split_map);
 
+static bool cmp_class_key2(struct dept_class *c, void *k2)
+{
+	return c->key2 == (unsigned long)k2;
+}
+
+static void per_task_key_destroy(void)
+{
+	struct dept_class *c;
+	struct hlist_node *n;
+	HLIST_HEAD(h);
+
+	/*
+	 * per_task_key_destroy() should not fail.
+	 *
+	 * FIXME: Should be fixed if per_task_key_destroy() causes
+	 * deadlock with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	obtain_classes_from_hlist(&h, cmp_class_key2, current);
+
+	hlist_for_each_entry_safe(c, n, &h, hash_node) {
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		inval_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+
+	dept_unlock();
+}
+
 void dept_task_exit(struct task_struct *t)
 {
-	struct dept_task *dt = &t->dept_task;
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
 	int i;
 
-	raw_local_irq_disable();
+	if (unlikely(READ_ONCE(dept_stop) || in_nmi()))
+		return;
+
+	if (dt->recursive) {
+		DEPT_STOP("Entered task_exit() while Dept is working.\n");
+		return;
+	}
+
+	if (t != current) {
+		DEPT_STOP("Never expect task_exit() done by others.\n");
+		return;
+	}
+
+	flags = dept_enter();
 
 	if (dt->stack)
 		put_stack(dt->stack);
@@ -2601,9 +2694,17 @@ void dept_task_exit(struct task_struct *t)
 		if (dt->wait_hist[i].wait)
 			put_wait(dt->wait_hist[i].wait);
 
+	per_task_key_destroy();
+
 	dept_off();
+	dept_exit(flags);
 
-	raw_local_irq_enable();
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
 }
 
 void dept_task_init(struct task_struct *t)
@@ -2611,10 +2712,18 @@ void dept_task_init(struct task_struct *t)
 	memset(&t->dept_task, 0x0, sizeof(struct dept_task));
 }
 
+static bool cmp_class_key1(struct dept_class *c, void *k1)
+{
+	return c->key == (unsigned long)k1;
+}
+
 void dept_key_init(struct dept_key *k)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	struct dept_class *c;
+	struct hlist_node *n;
+	HLIST_HEAD(h);
 	int sub;
 
 	if (unlikely(READ_ONCE(dept_stop) || in_nmi()))
@@ -2636,13 +2745,11 @@ void dept_key_init(struct dept_key *k)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++) {
-		struct dept_class *c;
-
-		c = lookup_class((unsigned long)k->subkeys + sub);
-		if (!c)
-			continue;
+	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++)
+		obtain_classes_from_hlist(&h, cmp_class_key1,
+					  k->subkeys + sub);
 
+	hlist_for_each_entry_safe(c, n, &h, hash_node) {
 		DEPT_STOP("The class(%s/%d) has not been removed.\n",
 			  c->name, sub);
 		break;
@@ -2657,6 +2764,9 @@ void dept_key_destroy(struct dept_key *k)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	struct dept_class *c;
+	struct hlist_node *n;
+	HLIST_HEAD(h);
 	int sub;
 
 	if (unlikely(READ_ONCE(dept_stop) || in_nmi()))
@@ -2678,13 +2788,11 @@ void dept_key_destroy(struct dept_key *k)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++) {
-		struct dept_class *c;
-
-		c = lookup_class((unsigned long)k->subkeys + sub);
-		if (!c)
-			continue;
+	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++)
+		obtain_classes_from_hlist(&h, cmp_class_key1,
+					  k->subkeys + sub);
 
+	hlist_for_each_entry_safe(c, n, &h, hash_node) {
 		hash_del_class(c);
 		disconnect_class(c);
 		list_del(&c->all_node);
diff --git a/kernel/exit.c b/kernel/exit.c
index bac41ee..d381fd4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -738,6 +738,13 @@ void __noreturn do_exit(long code)
 	struct task_struct *tsk = current;
 	int group_dead;
 
+	/*
+	 * dept_task_exit() requires might_sleep() because it needs to
+	 * wait on the grace period after cleaning the objects that have
+	 * been coupled with the current task_struct.
+	 */
+	dept_task_exit(tsk);
+
 	WARN_ON(tsk->plug);
 
 	kcov_task_exit(tsk);
@@ -844,7 +851,6 @@ void __noreturn do_exit(long code)
 	exit_tasks_rcu_finish();
 
 	lockdep_free_task(tsk);
-	dept_task_exit(tsk);
 	do_task_dead();
 }
 
-- 
1.9.1

