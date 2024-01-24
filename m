Return-Path: <linux-fsdevel+bounces-8727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE4983A8CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C70C1F2189A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74377633F1;
	Wed, 24 Jan 2024 12:00:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFAB60DE6;
	Wed, 24 Jan 2024 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097605; cv=none; b=da1xFJ/ScpQq5NvbNC9K/Cye/mwlJH6YoKSXC65lIrIoVUJcHguJU+54AJOjhdTdfrOIKSR/lM4Ruur4p/Z2ucRUxY3U10Pros3bfWAZnJXFAbnWD+8HgqB2j4NjXptNQkVpsVhFPdVnT2ixuE8BBY3bpSqhI1l/NMooPgWEctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097605; c=relaxed/simple;
	bh=37cSYW8WA/TnfUxZD66nhjfMFS+Rdxdh6OVt7EPfSog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Ceuc/+MoKjvHxTrY15a4sHiPfgSUvUHskcEl/5JNm0MzNUkD+guikEm9bREyDtLUN+X74yddiuAy+rg6kM/Dx3bidL8Lw1SmD55cQ6VxqGFtyhZ3GAuE83pCbT5qIsvRUNMTAMLewF0FkF5n3pO/0e05hSMhcEZ/r4nKiVnkbyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a5-65b0fbb529a6
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
Subject: [PATCH v11 06/26] dept: Add proc knobs to show stats and dependency graph
Date: Wed, 24 Jan 2024 20:59:17 +0900
Message-Id: <20240124115938.80132-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTYRTHe573uuXkbV18S6IYWNHVbnKKiL5ED0QURX3oPvRFR15iK8si
	07Tb1HKBLsvCS6wxl9qmpKWyjDQLzXLVsrnKtBS1lTlraRdn9OXw4/z/5/fp8JSympnBa+IP
	Sdp4dayKldPygaDCRZUj5VJ4d0cYGDLDwTd0job8MisLraUlCKwVqRh6H26AV8P9CEaan1Jg
	zGlFUPi+g4KKBg+CWvMpFtq6gsHp87LQlJPBQlpxGQvP+kYxuHMvYSixbYIn2UUYHP5PNBh7
	WbhqTMNjoweD32ThwJQSBp3mKxyMvl8KTZ6XDNS2L4C8624WamqbaGio6sTQdjefBY/1DwNP
	Gh7R0GrIYuDW5yIW+oZNFJh8Xg6eOwowlKePic58+81AY5YDw5kbtzE4X99DUHfuHQab9SUL
	D3z9GOy2HAp+3nyIoPPCAAenM/0cXE29gCDjdC4NT381MpDuXgkjP/LZdavJg34vRdLtR0jt
	cAFNHheJpPpKB0fS69o5UmA7TOzm+aS4pheTwkEfQ2yW8yyxDV7iiH7AicnnlhaOPLo8QpMu
	pxFvCd0pXxMlxWoSJe2StfvlMf43xw8+jjiaXVnPpqCShXok40Vhhdid8hHrET/O3/XBgTUr
	zBVdLj8V4CnCbNGe9ZHRIzlPCWcniuYvzWwgmCxsFXMbr9MBpoUw0dlbiQKsEFaKaXXd1D//
	LLGk3DHOMiFCvJXXPt5XjnXeWS5yAakonJWJ9uJr6N/BdPG+2UVnI0UBmmBBSk18YpxaE7ti
	cUxSvObo4siEOBsaeyjTidFdVWiwdVs9EnikClKss5RJSkadqEuKq0ciT6mmKFzTSyWlIkqd
	dEzSJuzTHo6VdPUolKdVIYplw0eilEK0+pB0QJIOStr/KeZlM1LQ5eomQ2nIxuWLVK+i28I3
	Skalh9zRaaa+qJkEzV2RQnDPedlJa0OIO395cqZM803Ys3vq0GbbnOSetZm+AyeGNNPytq+v
	+pVjmBMkT92cseOrN9lz3923d2bUh8TyuxN2Od7O7NpZtyo6+GKLKnSNYZ7rGp6o3R3R/2Lr
	bHp1tjdBReti1EvnU1qd+i/8N+rITAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/xzsuv502v/K422JCysRnsvAHfmPM+MOG0S2/1aku3VWE
	tijhVMpW0VWrcM4VnUtb9OBWlGo90C1Jtcpjczriyrk8VJt/3ntt74e/3iwh11PerEodK2rU
	ykgFLSWle4KSV1e6zaK/tVsGWWn+4PxxiYT88jIaOu+XIih7eA7DyLMd8GrcjsDd1kFAbnYn
	guKhfgIeNg4gqDWep6HrnQfYnA4amrOv0JB8s5yGF58nMfTlXMNQatkNrZklGKyujyTkjtCg
	z03GU/IJg8tgYsCQ5APDxjwGJocCoHmgm4KGgmYKantXwo3CPhpqaptJaKwaxtD1OJ+GgbK/
	FLQ2PiehMyudgnujJTR8HjcQYHA6GHhpLcJgTplaS/3+h4KmdCuG1FsPMNheVyOouzSIwVLW
	TUOD046hwpJNwK87zxAMZ3xh4EKaiwH9uQwEVy7kkNDxu4mClL5AcP/Mp7cECQ12ByGkVJwU
	aseLSKGlhBce5fUzQkpdLyMUWeKECqOvcLNmBAvFY05KsJgu04Jl7Boj6L7YsDDa3s4Iz6+7
	SeGdLRfvXXhQuumYGKmKFzVrgkOk4a43Z060rD+VWVlPJ6HSVTrEsjy3jp/QeeiQhKW55XxP
	j4uYZk9uKV+R/oHSISlLcBdn88avbfS0MY/bx+c0FZLTTHI+vG2kEk2zjAvkk+vez5R5bglf
	arbOsIRbz9+70TuTl09lBk1XmUwkLUKzTMhTpY6PUqoiA/20EeEJatUpv9DoKAuauowhcTKr
	Cv3o2lGPOBYp5si2mMpFOaWM1yZE1SOeJRSesh6v+6JcdkyZcFrURB/VxEWK2nq0gCUV82U7
	D4ghci5MGStGiOIJUfPfxazEOwktwAW7ur8t2rlbmrpxbUjQhgh9TRe5uNCr82neeEP73OFl
	XP/t/ca24xNvQwNWbg9+khgzVG6Xhp2s3jdbJzntl17tYZ/wuVt1qG/bGVHtdphXmF84YnHx
	27HDEtORsKWHvhn+xB3OTPS+e0s9qgs+G7Onv2PO3tB5MXrdo+Wbt/b6KkhtuDLAl9Bolf8A
	egzQ2y4DAAA=
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


