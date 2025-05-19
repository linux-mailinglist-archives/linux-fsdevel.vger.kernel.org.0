Return-Path: <linux-fsdevel+bounces-49353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50F6ABB8EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B31189AF7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF89E277009;
	Mon, 19 May 2025 09:18:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8126FA7D;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646335; cv=none; b=KvjR3a92K6mh6b+Mb+y+CY9bPvc9KkscPV1VUaAwUjDZ3WcTFVCEqa7S3kvb6jlkhO/5ukbJgbb5aD2k7LfXe1H1snaJRNeOzUOr1rHPXnxBJhU11779RUv9fANwSALWwHzNbecybUGUf6i7HzxfqYRsh2L8ewjC4yiI1lsUpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646335; c=relaxed/simple;
	bh=7Twj65zRSkQ/WMNSTWEyxzgXy8V9jjNnIrH+Kg2KsWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ON9JHjC83PvtNb1OT/ohoMfAaOikwDo82AehnN/xYE4PyL8+ErXFIimZZmvpunHJaJCdABpIuy1zrA/E8sT0ak7Gty0UkmRmuLZWslZk1EiShDiz2Pl2f0u1m80o/vq9QjwA5fYhq5VsMfLwHYQtfOPVyBB41ttyqEAJOqTWb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-71-682af76ded55
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
Subject: [PATCH v16 06/42] dept: add proc knobs to show stats and dependency graph
Date: Mon, 19 May 2025 18:17:50 +0900
Message-Id: <20250519091826.19752-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRSG/b6ZzgzFmkk1OoJR0mhQjJcaNeeHom7MOjGaGI0mYsxuXWZt
	tRTSIorJJtxEF4QoWlBALNVUaKvUTrNhd63ctIoXREXuoFSDS7gZpKVcdLfg+ufkSc77PufP
	YQj5Y0kYo9ElCnqdSqugpKR0cLZ5lW4sSr3W2rAUfKPnSCiusFPQeMeGwO5KxdD3cAe0+AcQ
	TD5/QUCBsRFBaU8XAS5PNwJ3WRoFrz/MgSbfMAX1xmwK0m9UUPCyfwpDZ34eBptzN7y19JLw
	9IIZQ0EfBUUF6Tg4/sEwbrHSYElZBt6yQhqmepRQ390sAXf7Srha0knBPXc9CZ5KL4bXfxVT
	0G3/VwJPPY9J8OeGQ+PFHAncHjJT0O+3EGDxDdPwqtqEwWOaD46MoDDz81cJPMqpxpB58y6G
	pra/Edw/9w6D095MQZ1vAIPoNBIwceshAm/uIA1nzo/TUJSaiyD7TD4JGZ0bYDIQvHxtVAmp
	1x0k3P7SjLZu5u0ldsTXDQwTfIZ4kp/wvaF4t99E8k/MHP9nYRfNZ9xvp3mT8wQvlkXxN+71
	Yb50xCfhndbfKd45kkfzWYNNmB9qaKD3LIqRbooVtJokQb8m+mepuuvyJZzQvfnU25xRMgWJ
	yiwUwnDses5vnpB857PvrNQ0U2wk19o6TkzzPDaCE3N6gxkpQ7DNoVzLtTY0vZjL7uXKJwMz
	BZJdxtnbxBmWsRs4e7WR/CZdwtkc1TOiEHYj155dN9OVBzNNthJyWsqxl0K4qkLx/8JCrqas
	lbyAZCY0y4rkGl1SnEqjXb9anazTnFr9S3ycEwX/y/Lb1KFKNNK4rxaxDFLMljncK9RyiSrJ
	kBxXiziGUMyTWcXlarksVpV8WtDH/6Q/oRUMtSicIRULZOv8J2Pl7FFVonBcEBIE/fctZkLC
	UlDms72r0hxFLluoJX6b3J2gjc4/XjN2ZQdV6X0fqPgq7t9VU/zj6DEcf7gva8Lj+mNx4Mum
	58bYu/lVYWurajs2WiIi03e2TOUt+PWDN/HKwZiIB4aDWxb90PLIEdfzhDYmhXUc6CjoVaZ1
	3XF9DHhXLE0bOvKprZw5cHXPx+2RR8YcCtKgVimjCL1B9R/1BxbOWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRiH+5/rXC1Py+pglDGKytASsl4qLYj0FBaRH4S+5KhDG7opm7Ps
	IppmpmnXKVna1Ji2HWvuCGk5WQ41i9LSLGVaWUSWFyi38tJlGn15eeD3/p73yyvB5RYyUKLW
	pvA6rTJRQUkJ6b6tWSGaH8GqDUXWheAZzyXg5j2Bgs67VgRCXSYGQy3R8No7jGDqWQcOxcZO
	BOXv+3Goax1A4Kg+Q0HXx/nQ7RmjoN2YT0FW5T0KXnydxsBddAUDq30vvDV/IuDppQoMioco
	uFGchfnGZwwmzBYazBmrYLC6hIbp92HQPtBDgqu0nQRH3zq4XuamoNHRTkBr/SAGXQ9uUjAg
	/CHhaetjAryFS6HzcgEJNaMVFHz1mnEwe8ZoeOk0YdBqWgy2bJ815/tvEtoKnBjk3K7FoLv3
	IYKm3HcY2IUeClyeYQxEuxGHyaoWBIOFIzScvTBBw43MQgT5Z4sIyHaHw9RP3+XS8TDIvGUj
	oOZXD9oRyQllAuJcw2M4ly0e4yY9ryjO4TUR3JMKlmso6ae57KY+mjPZDZxYHcxVNg5hXPk3
	D8nZLecpzv7tCs3ljXRj3Ojz5/T+ZQel247wiepUXrc+Ml6q6r92FUseiDj+tmCcyEBiWB7y
	k7DMRvbcOws1wxSzmn3zZgKf4QBmBSsWfCLzkFSCMz1z2delvWgmWMgcYO9M/ZwtEMwqVugV
	Z1nGhLOC00j8kwaxVptzVuTHbGL78l2zXblvp9taRlxCUhOaY0EBam2qRqlODA/VJ6jStOrj
	oYeTNHbk+yDz6enL9Wi8K7oZMRKkmCezOdaq5KQyVZ+maUasBFcEyCziGpVcdkSZdoLXJR3S
	GRJ5fTNaKiEUS2R74vh4OXNUmcIn8Hwyr/ufYhK/wAykW8nb0h2VCXG3gpIexU7lXFjv5k+X
	HFywPKYxPajsTLh3ZLXx86iqTjRHzTVs2HY9F0/piHCbNevu676EvEyIE3ee2r65CtL9vbW7
	IopWNvjHxBoqnPVaoU09SG8JlI1sDBrdHWk6OY3HaauzPkT1t100nCunJ6uOxSs1NYtcCkKv
	UoYF4zq98i+FbAMvPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It'd be useful to show dept internal stats and dependency graph on
runtime via proc for better information.  Introduce the knobs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/Makefile        |  1 +
 kernel/dependency/dept.c          | 50 +++-------------
 kernel/dependency/dept_internal.h | 54 +++++++++++++++++
 kernel/dependency/dept_proc.c     | 96 +++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 41 deletions(-)
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_proc.c

diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
index b5cfb8a03c0c..92f165400187 100644
--- a/kernel/dependency/Makefile
+++ b/kernel/dependency/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DEPT) += dept.o
+obj-$(CONFIG_DEPT) += dept_proc.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 6cdda00411bc..9650d6d0c4d0 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -75,6 +75,7 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include "dept_internal.h"
 
 static int dept_stop;
 static int dept_per_cpu_ready;
@@ -265,46 +266,13 @@ static bool valid_key(struct dept_key *k)
  *       have been freed will be placed.
  */
 
-enum object_t {
-#define OBJECT(id, nr) OBJECT_##id,
-	#include "dept_object.h"
-#undef OBJECT
-	OBJECT_NR,
-};
-
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef OBJECT
 
-struct dept_pool {
-	const char			*name;
-
-	/*
-	 * object size
-	 */
-	size_t				obj_sz;
-
-	/*
-	 * the number of the static array
-	 */
-	atomic_t			obj_nr;
-
-	/*
-	 * offset of ->pool_node
-	 */
-	size_t				node_off;
-
-	/*
-	 * pointer to the pool
-	 */
-	void				*spool;
-	struct llist_head		boot_pool;
-	struct llist_head __percpu	*lpool;
-};
-
-static struct dept_pool pool[OBJECT_NR] = {
+struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
@@ -334,7 +302,7 @@ static void *from_pool(enum object_t t)
 	if (DEPT_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	p = &pool[t];
+	p = &dept_pool[t];
 
 	/*
 	 * Try local pool first.
@@ -369,7 +337,7 @@ static void *from_pool(enum object_t t)
 
 static void to_pool(void *o, enum object_t t)
 {
-	struct dept_pool *p = &pool[t];
+	struct dept_pool *p = &dept_pool[t];
 	struct llist_head *h;
 
 	preempt_disable();
@@ -2108,7 +2076,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(classes);
+LIST_HEAD(dept_classes);
 
 static bool within(const void *addr, void *start, unsigned long size)
 {
@@ -2140,7 +2108,7 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	list_for_each_entry_safe(c, n, &classes, all_node) {
+	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
 			continue;
@@ -2216,7 +2184,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->sub_id = sub_id;
 	c->key = (unsigned long)(k->base + sub_id);
 	hash_add_class(c);
-	list_add(&c->all_node, &classes);
+	list_add(&c->all_node, &dept_classes);
 unlock:
 	dept_unlock();
 caching:
@@ -2950,8 +2918,8 @@ static void migrate_per_cpu_pool(void)
 		struct llist_head *from;
 		struct llist_head *to;
 
-		from = &pool[i].boot_pool;
-		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
+		from = &dept_pool[i].boot_pool;
+		to = per_cpu_ptr(dept_pool[i].lpool, boot_cpu);
 		move_llist(to, from);
 	}
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
new file mode 100644
index 000000000000..6b39e5a2a830
--- /dev/null
+++ b/kernel/dependency/dept_internal.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dept(DEPendency Tracker) - runtime dependency tracker internal header
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __DEPT_INTERNAL_H
+#define __DEPT_INTERNAL_H
+
+#ifdef CONFIG_DEPT
+#include <linux/percpu.h>
+
+struct dept_pool {
+	const char			*name;
+
+	/*
+	 * object size
+	 */
+	size_t				obj_sz;
+
+	/*
+	 * the number of the static array
+	 */
+	atomic_t			obj_nr;
+
+	/*
+	 * offset of ->pool_node
+	 */
+	size_t				node_off;
+
+	/*
+	 * pointer to the pool
+	 */
+	void				*spool;
+	struct llist_head		boot_pool;
+	struct llist_head __percpu	*lpool;
+};
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef OBJECT
+	OBJECT_NR,
+};
+
+extern struct list_head dept_classes;
+extern struct dept_pool dept_pool[];
+
+#endif
+#endif /* __DEPT_INTERNAL_H */
diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
new file mode 100644
index 000000000000..97beaf397715
--- /dev/null
+++ b/kernel/dependency/dept_proc.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Procfs knobs for Dept(DEPendency Tracker)
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (C) 2021 LG Electronics, Inc. , Byungchul Park
+ *  Copyright (C) 2024 SK hynix, Inc. , Byungchul Park
+ */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/dept.h>
+#include "dept_internal.h"
+
+static void *l_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	return seq_list_next(v, &dept_classes, pos);
+}
+
+static void *l_start(struct seq_file *m, loff_t *pos)
+{
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	return seq_list_start_head(&dept_classes, *pos);
+}
+
+static void l_stop(struct seq_file *m, void *v)
+{
+}
+
+static int l_show(struct seq_file *m, void *v)
+{
+	struct dept_class *fc = list_entry(v, struct dept_class, all_node);
+	struct dept_dep *d;
+	const char *prefix;
+
+	if (v == &dept_classes) {
+		seq_puts(m, "All classes:\n\n");
+		return 0;
+	}
+
+	prefix = fc->sched_map ? "<sched> " : "";
+	seq_printf(m, "[%p] %s%s\n", (void *)fc->key, prefix, fc->name);
+
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	list_for_each_entry(d, &fc->dep_head, dep_node) {
+		struct dept_class *tc = d->wait->class;
+
+		prefix = tc->sched_map ? "<sched> " : "";
+		seq_printf(m, " -> [%p] %s%s\n", (void *)tc->key, prefix, tc->name);
+	}
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations dept_deps_ops = {
+	.start	= l_start,
+	.next	= l_next,
+	.stop	= l_stop,
+	.show	= l_show,
+};
+
+static int dept_stats_show(struct seq_file *m, void *v)
+{
+	int r;
+
+	seq_puts(m, "Availability in the static pools:\n\n");
+#define OBJECT(id, nr)							\
+	r = atomic_read(&dept_pool[OBJECT_##id].obj_nr);		\
+	if (r < 0)							\
+		r = 0;							\
+	seq_printf(m, "%s\t%d/%d(%d%%)\n", #id, r, nr, (r * 100) / (nr));
+	#include "dept_object.h"
+#undef  OBJECT
+
+	return 0;
+}
+
+static int __init dept_proc_init(void)
+{
+	proc_create_seq("dept_deps", S_IRUSR, NULL, &dept_deps_ops);
+	proc_create_single("dept_stats", S_IRUSR, NULL, dept_stats_show);
+	return 0;
+}
+
+__initcall(dept_proc_init);
-- 
2.17.1


