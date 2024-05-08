Return-Path: <linux-fsdevel+bounces-19064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A222B8BFA74
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153F0B24D41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E0785959;
	Wed,  8 May 2024 10:03:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1527E0F2;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162585; cv=none; b=kbg0LjMj4sBEq0AKiHHKbqKN3Y96DUErXSkJG5YOH49kjBDoPxnF3MP9gnNI3AEBhLpB7Rif30rWBEvBZaPuk1XZgAzfhP1ZslA1ry8hphB2+g+hxnStGzYurCSVx8+tZvrrj4v/SmHfLdTyvok/RHIO0+ighcR5v03lNq1P/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162585; c=relaxed/simple;
	bh=37cSYW8WA/TnfUxZD66nhjfMFS+Rdxdh6OVt7EPfSog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nH1tQt1EaVBNEQ1xPP2N1PnUGdtNI6eRqQt1oL1gumn5ay2PcK74zntMuh6BT4qaxA4O+4CLcZe84j41vQIL+39DKNMYHTsWQXok5RuJZrTLb4J967BVI5TV7FwO1dGA4naVUgSYKxCDySohTUeMqV0IweixU2rHq2TvwCRSTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-75-663b4a39b220
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v14 06/28] dept: Add proc knobs to show stats and dependency graph
Date: Wed,  8 May 2024 18:47:03 +0900
Message-Id: <20240508094726.35754-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xTZxgHcN73nPOeQ0PJsRg54octZY0J3kARH5wxfNITll0ylxhv0UYO
	0sjFFEHrMgWpCCgOXJAN2FYKVlLwVjBeaLWWgCKhltEwlItAiI5R6IIWrZBhq+HLk1/y/J//
	p4ejFC1MFKfJPCppM9XpSiKjZVNhtWsSk79MjS3+Vwnl52PB96aIhprrTQRc1xoRNLXkY5ho
	3w5/z3oQzHU/paCywoWgdnSIgpaOYQS2htMEesfDwe3zEuisOEegoO46gZ7JeQyDly5iaLR8
	DV1lRgx2/ysaKicIVFcW4MD4B4PfZGbBlKeCsYYqFuZH46BzuI8B2/NV8NsfgwSstk4aOu6M
	Yei9V0NguGmBga6OxzS4yksZuDptJDA5a6LA5POy8JfdgOGGPlBU+Pp/Bh6V2jEU1t/E4H7W
	iuB+0QgGS1MfgTafB0OzpYKC91faEYxdmGLhzHk/C9X5FxCcO3OJBv3gRph7V0OSEsU2j5cS
	9c3HRNusgRafGAXxbtUQK+rvP2dFgyVHbG6IEeusE1isnfExosVcTETLzEVWLJlyY3Ha6WTF
	x7/O0eK4uxJ/F7VbtiVFStfkStp1Ww/I0vwDPx55knC87JaD5KHG1SUolBP4eOGX+kK8aOvU
	GBs04VcK/f1+Kuil/OdCc+lLJmiK98iEeue2oCP474W6NvfHPM2rhBejDhK0nN8oFD/9k3zq
	/ExovGH/2BPKJwjPXk2joBWBTGtBVeBWFsgscIL1bQvz6WC58LChny5DcgMKMSOFJjM3Q61J
	j1+bpsvUHF97MCvDggK/ZPppfs8dNOPa4UA8h5Rhcnvk5lQFo87N1mU4kMBRyqXy9rObUhXy
	FLXuhKTN2q/NSZeyHWgFRysj5etnj6Uo+EPqo9JhSToiaRe3mAuNykO6H8xUX45x28hJg77K
	1p2YfHnD7wOt+5nqEfuBvBLNkgjN1giQ5hJ2qHb9h5OGQNV18oFVlfoy2pxMxXlu9+T3O791
	FTlNu8K/8oYY0+gkv6BZ1iZf4LxhRLf3C09xb+S+dQMTrrOxTofimxgcnTz58ylF0kzhzuj8
	R9zecSWdnaaOi6G02eoPVffRMUcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0hTYRgG8L7vnPOduZqcltGpoGLQBSvLSnvLiC6Qh6ILUQRB5KijDqfZ
	piuLwNq66kwjXekqL7VEV9YssHIxtmbaxSxHZelSM8u8RTlpaRdX9M/LD56H569XQsnzmEkS
	VVKKqElSqhVESks3ROnnLlkbFTu/4+1oyMmcD76BEzSYK6wEGq6XI7DeOoyhyx0NrwZ7EAw9
	fUaBKbcBQVFbCwW3arwI7KVHCDR2BIPH10+gLjeDgL6kgsDz7mEMzXlnMJTb1sPj7GIMDv9H
	GkxdBApMejxyPmHwW8pYsKRPh/bSfBaG28KhzvuSAdeFOgbsb2bD+YvNBKrtdTTUVLVjaLxr
	JuC1/mbgcU0tDQ05Rgau9RUT6B60UGDx9bPwwlGI4YZhZO3Yt18MPDQ6MBy7fBODp+kegvsn
	WjHYrC8JuHw9GCptuRT8uOpG0J7Vy8LRTD8LBYezEGQczaPB0BwBQ9/NZMVSwdXTTwmGyn2C
	fbCQFh4V88Kd/BZWMNx/wwqFtlShsjRUKKnuwkLRVx8j2MpOEsH29QwrnOr1YKGvvp4Vas8N
	0UKHx4Q3Td4uXbZbVKt0ombe8hhpvP/tweRHkfuzbztJOiqfcwoFSXhuEV/d284GTLiZ/OvX
	firgEG4aX2nsZAKmuB4pf7l+TcDjuM18icvzt09z0/l3bU4SsIyL4E8+u0T+bU7ly284/u4E
	cZF808c+FLB8pHNPn89mI2khGlWGQlRJukSlSh0Rpk2IT0tS7Q/btSfRhka+xXJoOKcKDTRG
	OxEnQYoxsgYSFStnlDptWqIT8RJKESJzH18cK5ftVqYdEDV7dmpS1aLWiSZLaMUE2dptYoyc
	i1OmiAmimCxq/qdYEjQpHU2dN2Hi6i/2vTtOB3+mQ1Otxic5cbLg/MHxC97rPYYw9aaMzI6K
	J+6FxHVzVqQiuTTBWrXQ/GBit/fpla0Hb/98kN6amYpiUjq7xzO9adE4xqLQ6fTjjLVV9Ss7
	m36FD7hn8U1ZX1ZsMRd4W1e1xNEte2c4pqwb03V246KxlnWmDwpaG68MD6U0WuUfFEE9rykD
	AAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It'd be useful to show Dept internal stats and dependency graph on
runtime via proc for better information. Introduced the knobs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/Makefile        |  1 +
 kernel/dependency/dept.c          | 24 +++-----
 kernel/dependency/dept_internal.h | 26 +++++++++
 kernel/dependency/dept_proc.c     | 95 +++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 15 deletions(-)
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
index 7e12e46dc4b7..19406093103e 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -74,6 +74,7 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include "dept_internal.h"
 
 static int dept_stop;
 static int dept_per_cpu_ready;
@@ -260,20 +261,13 @@ static bool valid_key(struct dept_key *k)
  *       have been freed will be placed.
  */
 
-enum object_t {
-#define OBJECT(id, nr) OBJECT_##id,
-	#include "dept_object.h"
-#undef  OBJECT
-	OBJECT_NR,
-};
-
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef  OBJECT
 
-static struct dept_pool pool[OBJECT_NR] = {
+struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
@@ -303,7 +297,7 @@ static void *from_pool(enum object_t t)
 	if (DEPT_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	p = &pool[t];
+	p = &dept_pool[t];
 
 	/*
 	 * Try local pool first.
@@ -338,7 +332,7 @@ static void *from_pool(enum object_t t)
 
 static void to_pool(void *o, enum object_t t)
 {
-	struct dept_pool *p = &pool[t];
+	struct dept_pool *p = &dept_pool[t];
 	struct llist_head *h;
 
 	preempt_disable();
@@ -2092,7 +2086,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(classes);
+LIST_HEAD(dept_classes);
 
 static bool within(const void *addr, void *start, unsigned long size)
 {
@@ -2124,7 +2118,7 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	list_for_each_entry_safe(c, n, &classes, all_node) {
+	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
 			continue;
@@ -2200,7 +2194,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->sub_id = sub_id;
 	c->key = (unsigned long)(k->base + sub_id);
 	hash_add_class(c);
-	list_add(&c->all_node, &classes);
+	list_add(&c->all_node, &dept_classes);
 unlock:
 	dept_unlock();
 caching:
@@ -2915,8 +2909,8 @@ static void migrate_per_cpu_pool(void)
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
index 000000000000..007c1eec6bab
--- /dev/null
+++ b/kernel/dependency/dept_internal.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dept(DEPendency Tracker) - runtime dependency tracker internal header
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __DEPT_INTERNAL_H
+#define __DEPT_INTERNAL_H
+
+#ifdef CONFIG_DEPT
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef  OBJECT
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
index 000000000000..7d61dfbc5865
--- /dev/null
+++ b/kernel/dependency/dept_proc.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Procfs knobs for Dept(DEPendency Tracker)
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (C) 2021 LG Electronics, Inc. , Byungchul Park
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


