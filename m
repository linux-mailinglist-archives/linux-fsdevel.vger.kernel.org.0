Return-Path: <linux-fsdevel+bounces-13702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3169287319E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97051B2A8EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 08:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B66A60B98;
	Wed,  6 Mar 2024 08:55:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499595DF30;
	Wed,  6 Mar 2024 08:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715340; cv=none; b=txFn6d4vAn1L0xhWwCWjRBUMHG5UX3XNSPAYQ/WG6N0bAD24C3OxtCZdX+2WqXMArnCqBKW9HSa7QN+bHYGds2rEr9zJHoD1ftlRLonYRJicoxosbd4UcMa4ISiuhK22Iqv66MlkuKI7kr70h4lBJj8DDdDCds1V/RjwtmYyhE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715340; c=relaxed/simple;
	bh=37cSYW8WA/TnfUxZD66nhjfMFS+Rdxdh6OVt7EPfSog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TJO9YkS5KYOQkkILPADFV7J13tMlOPrgIhOSn2bj0pOhASPXrA2xKR6FFn/JEkRdWSYUIZ+ctn50yrsq4nKSpJwRkBn+9QDI1iPu8djmgq9eglcO/XTPnZKvUZjbQD3TiLAcu5SSVP+lKXXLBtShElf0wL9rLik1CPaazGtJ/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-89-65e82f7df8d6
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
Subject: [PATCH v13 06/27] dept: Add proc knobs to show stats and dependency graph
Date: Wed,  6 Mar 2024 17:54:52 +0900
Message-Id: <20240306085513.41482-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRiA+75z9p2z0eKwgk4mVCMJ7GqUvdEF+1GdiC52+VNCjTzlSC12
	U7NC06ysmQXLTKnNZA23so4FWs1spaWRrRq2ykSHpdJUsDZaSuWF/rw8vO/D8+tlKZUki2K1
	6QZRl65JVRMFreifbFt4YnGvuORGSxRcurAEQj/P0lBe7SLgveNE4Lqfi6GvcSN8CAcRDL9+
	Q0GJxYvA1vWFgvtNHQjcjlME3ndPAV9okECz5TyBvJvVBN5+H8HQfuUyBqe0BV4VV2BoiPTQ
	UNJHoKwkD4+OXgwRexUD9pwYCDiuMTDSFQfNHW0ycH+aD6XX2wk8djfT0FQbwPD+YTmBDtdf
	GbxqekmD95JZBrcHKgh8D9spsIcGGXjXYMVwN380VPDjjwxemBswFFTew+D7+AhB/dlODJKr
	jcCzUBBDjWSh4PetRgSBon4GTl+IMFCWW4Tg/OkrNOS3L4fhX+UkYaXwLDhICfk1GYI7bKWF
	lgpeqLv2hRHy6z8xglUyCjWOWOHm4z4s2IZCMkGqOkcEaegyIxT2+7Aw0NrKCC+vDtNCt68E
	b4/ao1idLKZqTaJu8dr9ipTI5+yjLfGZxQ88JAc5FxQiOctzy3ipt0D2n0tLz6AxJtw83u+P
	UGM8jZvN15i/jTsUF1Twla0bxngqt4N31jnG9zQXw/daaplCxLJKbjn/INc4kZzFO+82jGfk
	XDx/ceAiGWPVqPI6z0YmnDNyvq1+wwTP4J86/HQxUlrRpCqk0qab0jTa1GWLUrLStZmLDhxJ
	k9DoJ9lPjOytRUPenR7EsUg9WZkg7xFVMo1Jn5XmQTxLqacpj//uFlXKZE3WMVF3ZJ/OmCrq
	PWgmS6unK5eGM5JV3CGNQTwsikdF3f8rZuVROQjvyvprmlMZDNgyY3VvEr3RtUH/wa9YwtlF
	rLWz2mweNpYFpBWeypg4V7G7c6smo2jTxiZf4bZZFj1dEP+oYo1irvH4w1gP+Ry9uys76UnS
	1cR5/rrDiT2rqjZvTnr+9Z3hW7RJfWrtc8P+hF0n16+a0lgXyghvXWfY8at/NSSpaX2KJi6W
	0uk1/wBT0fQRRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiGfc/He06bFU8qcSfgMlJjzMChOCFP1DiyTHnVaIxGTfZnnMyT
	UYVKWkFQNCBFGR8ViAVBIAVJB7QMLbpQBdKViKCCKIiAQICgQqiQqCUrkDnqsj9Prtz3nevX
	w9NqMxvEa3VnZL1OitdgJaM8uCPz2wubp+UtwzUICvO2gPdjNgPljXYMvX/YENjvZFAw8yAG
	Xi54ECx1P6WhxNyLoGpilIY7HWMIWmsvYeibCoB+7zyGLnMuhsybjRiezS5TMFJcRIHNcQAe
	F1RT4PK9ZaBkBsONkkxq5UxT4LPWc2BN3wCTtWUcLE9EQNfYAAvtFV0stA6HQWnlCIaW1i4G
	OponKei7V45hzP6JhccdnQz0Fuaz0DBXjWF2wUqD1TvPwXOXhYJbxhXb5Q//sPAw30XB5Zrb
	FPQP3UfQlj1OgcM+gKHd66GgyWGmYfH3BwgmTe84yMrzcXAjw4QgN6uYAeNIJCz9XY6jt5N2
	zzxNjE1nSeuChSGPqkXiLBvliLFtmCMWRxJpqg0lN1tmKFL13ssSR/1vmDjeF3Ek510/ReZ6
	ejjSeX2JIVP9JdSh4J+UO0/I8dpkWb95V6wyzvfqfOKjqJSCu26cjmybcpCCF4VtYmnpFeRn
	LGwUBwd9tJ8DhRCxKf8N62da8CjFmp49fl4jHBZtztrPOSNsEKfNzVwO4nmVECnezUj6T/m1
	aLvl+qxRCFHi1bmr2M/qlUl3ZhUuQEoLWlWPArW65ARJGx8ZbjgVl6rTpoT/cjrBgVaexXph
	ubAZfeyLcSOBR5ovVNGKt7KalZINqQluJPK0JlCVtjglq1UnpNRzsv70z/qkeNngRsE8o/lS
	te+4HKsWfpXOyKdkOVHW/99SvCIoHb1eLaXuaYtwbf0U4AkxVYS5Dq/5zjnuDqibGDh+3ynO
	rV23vjv4m2v3rmSvq9v3l6M4dOL7I1l8i31UImPWtbFm/qRp/VelF3N9i9cUx5yNYlmd6emL
	TYkxlr3XG3TuH3uKhso6U3YPvIysDFVm/TlsPNq2f1e0diaq8nZi5w/haU80jCFOigil9Qbp
	X+s2LokoAwAA
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


