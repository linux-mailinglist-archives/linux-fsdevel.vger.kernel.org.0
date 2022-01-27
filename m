Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09B049D745
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 02:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiA0BLf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 20:11:35 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:46106 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234411AbiA0BLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:11:23 -0500
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 27 Jan 2022 10:11:19 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 27 Jan 2022 10:11:19 +0900
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
Subject: [PATCH on v5.17-rc1 11/14] dept: Introduce split map concept and new APIs for them
Date:   Thu, 27 Jan 2022 10:11:09 +0900
Message-Id: <1643245873-15542-11-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
References: <1643245733-14513-1-git-send-email-byungchul.park@lge.com>
 <1643245873-15542-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a case where all maps used for a type of wait/event is so large
in size. For instance, struct page can be a type for (un)lock_page().
The additional memory size for the maps would be 'the # of pages *
sizeof(struct dept_map)' if each struct page keeps its map all the way,
which might be too big to accept in some system.

It'd better to have splitted map, one is for each instance and the other
is for the type which is commonly used, and new APIs using them. So
introduced split map and new APIs for them.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     |  36 ++++++++++++++
 kernel/dependency/dept.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 8665629..5a726bf 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -441,6 +441,30 @@ struct dept_map {
 	bool nocheck;
 };
 
+struct dept_map_each {
+	/*
+	 * wait timestamp associated to this map
+	 */
+	unsigned int wgen;
+};
+
+struct dept_map_common {
+	const char *name;
+	struct dept_key *keys;
+	int sub_usr;
+
+	/*
+	 * It's local copy for fast acces to the associated classes. And
+	 * Also used for dept_key instance for statically defined map.
+	 */
+	struct dept_key keys_local;
+
+	/*
+	 * whether this map should be going to be checked or not
+	 */
+	bool nocheck;
+};
+
 #define DEPT_TASK_INITIALIZER(t)					\
 	.dept_task.wait_hist = { { .wait = NULL, } },			\
 	.dept_task.ecxt_held_pos = 0,					\
@@ -469,6 +493,11 @@ struct dept_map {
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long ip);
 extern struct dept_map *dept_top_map(void);
 extern void dept_warn_on(bool cond);
+extern void dept_split_map_each_init(struct dept_map_each *me);
+extern void dept_split_map_common_init(struct dept_map_common *mc, struct dept_key *k, const char *n);
+extern void dept_wait_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *w_fn, int ne);
+extern void dept_event_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *e_fn);
+extern void dept_asked_event_split_map(struct dept_map_each *me, struct dept_map_common *mc);
 
 /*
  * for users who want to manage external keys
@@ -505,6 +534,8 @@ struct dept_map {
 struct dept_task { };
 struct dept_key  { };
 struct dept_map  { };
+struct dept_map_each    { };
+struct dept_map_commmon { };
 
 #define DEPT_TASK_INITIALIZER(t)
 
@@ -525,6 +556,11 @@ struct dept_map {
 #define dept_ecxt_exit(m, ip)				do { } while (0)
 #define dept_top_map()					NULL
 #define dept_warn_on(c)					do { } while (0)
+#define dept_split_map_each_init(me)			do { } while (0)
+#define dept_split_map_common_init(mc, k, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_wait_split_map(me, mc, ip, w_fn, ne)	do { } while (0)
+#define dept_event_split_map(me, mc, ip, e_fn)		do { } while (0)
+#define dept_asked_event_split_map(me, mc)		do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
 
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index b682bf9..bc764cc 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2233,6 +2233,128 @@ void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 }
 EXPORT_SYMBOL_GPL(dept_event);
 
+void dept_split_map_each_init(struct dept_map_each *me)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	me->wgen = 0U;
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_split_map_each_init);
+
+void dept_split_map_common_init(struct dept_map_common *mc,
+				struct dept_key *k, const char *n)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	if (mc->keys != k)
+		mc->keys = k;
+	clean_classes_cache(&mc->keys_local);
+
+	/*
+	 * sub_usr is not used with split map.
+	 */
+	mc->sub_usr = 0;
+	mc->name = n;
+	mc->nocheck = false;
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_split_map_common_init);
+
+void dept_wait_split_map(struct dept_map_each *me,
+			 struct dept_map_common *mc,
+			 unsigned long ip, const char *w_fn, int ne)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_class *c;
+	struct dept_key *k;
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (mc->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	k = mc->keys ?: &mc->keys_local;
+	c = check_new_class(&mc->keys_local, k, 0, mc->name);
+	if (c)
+		add_wait(c, ip, w_fn, ne);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_wait_split_map);
+
+void dept_asked_event_split_map(struct dept_map_each *me,
+				struct dept_map_common *mc)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	unsigned int wg;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (mc->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * Avoid zero wgen.
+	 */
+	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+	WRITE_ONCE(me->wgen, wg);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_asked_event_split_map);
+
+void dept_event_split_map(struct dept_map_each *me,
+			  struct dept_map_common *mc,
+			  unsigned long ip, const char *e_fn)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_class *c;
+	struct dept_key *k;
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (mc->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	k = mc->keys ?: &mc->keys_local;
+	c = check_new_class(&mc->keys_local, k, 0, mc->name);
+	if (c) {
+		add_ecxt((void *)me, c, 0UL, NULL, e_fn, 0);
+		do_event((void *)me, c, READ_ONCE(me->wgen), ip);
+		pop_ecxt((void *)me);
+	}
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_event_split_map);
+
 void dept_ecxt_exit(struct dept_map *m, unsigned long ip)
 {
 	struct dept_task *dt = dept_task();
-- 
1.9.1

