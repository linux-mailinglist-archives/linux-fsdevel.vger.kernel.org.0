Return-Path: <linux-fsdevel+bounces-12232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A314A85D481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3C5288672
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566123D3BB;
	Wed, 21 Feb 2024 09:50:00 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37823D995;
	Wed, 21 Feb 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508999; cv=none; b=Uh8XSmriq7soxYdo7G1OMWHuPijLQ7fHb64lDN7uxr+Lw+50BMUcZds/dHpd1NvSbgCytFaXulp5Njq61aNXejdDAtiJ6KECUjuq2mETcFcn/0e8Lx4l0zU+v6pCNzGYTaY73CWWv5dsYgGHZp09a+nyvSdp+CkbHVP1sIQqVCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508999; c=relaxed/simple;
	bh=37cSYW8WA/TnfUxZD66nhjfMFS+Rdxdh6OVt7EPfSog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=R8fihbSictf5QDUdWNnMAE92FoLQBWKs4JMHYvRh5F706FVO8Q19XgKtCNJl4sW8BPoecQYjdPetmPycm0OqPFgbN4HfvAigMBVcJjgRRT8qTRbEgvEbT8UjX3c1KuEwx86ui+fTP1c+bHMTTAcfyhmTVZajpgsDaz4tdW5FYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-e6-65d5c738595f
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
Subject: [PATCH v12 06/27] dept: Add proc knobs to show stats and dependency graph
Date: Wed, 21 Feb 2024 18:49:12 +0900
Message-Id: <20240221094933.36348-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ8f3+fpeHh2Mo+ylRsz8iPR7cP8GjaPP2zG/IrhVs90U+Gi
	xGwdh4qSH4lqVmnn+kFcKHTJtX6JunKlqNRN0VyydHGK3DH/fPba5/N+v/76sKT8Me3FqiOO
	SJoIVZgCyyhZ/4Ss+UurmyX/qy85uHTBHxxDcRRkFBZgsNzNR1DwQEtAX+V6eDNsRzDyqoGE
	1BQLgqzuDhIeVHUiMBlOYXj9YSJYHQMYalPOYzh9qxBD4+dRAtqvXSYg37gR6pKzCSh3fqQg
	tQ9DeuppwjU+EeDU5zGgj50FNkMaA6Pdi6C2s4UG01s/uHGzHUOpqZaCqhIbAa+fZGDoLBij
	oa6qhgLLpUQa7nzJxvB5WE+C3jHAQFN5JgH3dC7R2W+/aahOLCfgbM59AqxtTxGUxXURYCxo
	wVDhsBNQZEwh4eftSgS2pH4GzlxwMpCuTUJw/sw1Chp+VdOgaw+EkR8ZePUyscI+QIq6omjR
	NJxJiS+yBfFxWgcj6sreMmKm8ahYZJgr3irtI8SsQQctGvPisWgcvMyICf1WQvxSX8+INddH
	KPGDNZXY5B0kWx4ihamjJM3Clftkoc53Jw69UB5LfmjGsSh/XgLyYAV+iaDtacP/+Y0hnnQz
	5mcLra3Ov+zJ+wpFib10ApKxJH9uvGD4+spVYNnJ/GZB+32fO0Pxs4Rih5ZxM8cHCuaOQuaf
	00fIv1f+1+PBK4XcdDvtZrkr09z4kHQ7BX6MFSw/ktC/wjThuaGVSkZcJhqXh+TqiKhwlTps
	yYLQmAj1sQXBB8ONyPVQ+pOju0rQoGWLGfEsUkzgQoutkpxWRUXGhJuRwJIKT46Kdq24EFXM
	cUlzcK/maJgUaUbeLKWYygUMR4fI+f2qI9IBSTokaf5fCdbDKxZRW+/yXYttqkd7pGe+sis+
	Y7u9t3XtXLdyXI6N/MocfpTYn9dr1/txAclDa7cX68J/KhdzQ/EtQXHWmT4Nc9L2lMQyvc07
	eqZgafaz3LFlXoJyg1JbEjRpzf0t6Q71ivE9HjMu+jU2OaTpdWXbclLeW4NX+bUez/U0+W7m
	ajfWtymoyFDVormkJlL1BzqHsJpMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfZ/fHadn1eYZbbit2UJYso+h8VfftTGzmQ1TNz10dRV3RKzt
	UlJXcTUVFTtl5+qiXLX86Op26epSiTsk1dQMESldnPLjyvzz2Wvv93uvvz4c6VdKL+UUiSdE
	VaJcKWMklGTXlvS10P5cXN87EQr5uevBPZVFQVlNNQO9d0wIquvTCBhti4CX02MIZrqfkFBc
	2IvgxvAgCfX2IQQW4zkGnG8Xg8s9zoCjMIeB9IoaBp5+miVgoKiAAJN5JzzWlRNg9bynoHiU
	gdLidMJ7PhDgMVSxYNAEwYixhIXZ4Q3gGHpBQ+s1Bw2W/tVw9foAA00WBwX2eyMEOB+UMTBU
	/YeGx/YOCnrz82i4/aWcgU/TBhIM7nEWnln1BNRmeG2Z337T0J5nJSDz5l0CXK8eImjOekOA
	ufoFA63uMQLqzIUk/LzVhmDk4mcWzud6WChNu4gg53wRBU9+tdOQMRAGMz/KmO1bcOvYOIkz
	6k5hy7Sewp3lAr5fMsjijOZ+FuvNJ3GdMRhXNI0S+Makm8bmqmwGmycLWKz97CLwl54eFndc
	maHwW1cxsTtwv2RrjKhUJIuqdeHRkljP67PHOjed1jXYGA0yrdEiH07gNwovjdnkHDP8KqGv
	zzPPAfwKoS7vHa1FEo7kLywUjF+7GS3iOH9+j5D2PXpuQ/FBQqM7jZ1jKR8m2AZr2H/O5YKp
	1jrv8eE3CZWlY/Qc+3k3z582kDok0aMFVShAkZicIFcow0LU8bEpiYrTIYeTEszI+zKG1Nn8
	e2jKGWFDPIdki6SxjS7Rj5Ynq1MSbEjgSFmAlDrljaQx8pQzoiopSnVSKaptaBlHyZZII/eJ
	0X78UfkJMV4Uj4mq/y3B+SzVoHhnoPTg9Q++m/lgS9NBqigk8JHVdsUzFN6VrbNptlfGNeT2
	dPWXw9aJ2cFIHx0XetkZlbouvM/31Yrwqcn9b3hj1nCLVmk6FJqJj/8u8M9Pjbt0Lqjl18rQ
	MFaun/CPhAmRcxyw636+s2s+hsQNV2QfUe29sO0b/NkRdfnHlIxSx8o3BJMqtfwvB7e1ny4D
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


