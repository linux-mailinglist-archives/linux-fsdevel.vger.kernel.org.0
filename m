Return-Path: <linux-fsdevel+bounces-48840-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E240FAB514F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E774189D4A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4525394C;
	Tue, 13 May 2025 10:07:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F0242D9C;
	Tue, 13 May 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130872; cv=none; b=rjjv7153wcxHhM9IevjHi+WqIoOJ7ccnxK+1Oh4f/pTMw0YZxyvKF1D8a14pnztq8Rd9YdAvH3HVlp4oBrGoIIpBazQjqqyP/WNDvtf7O17JWxgR+w60vyXSaniP5fk85oVrDZ6+3komKCCa02vDLjdsQrbEudY2UJ1euN8BS1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130872; c=relaxed/simple;
	bh=omTSwuVDldZZD4bvvYyVfYTOKAgDOm2MH8ZuGlfhiGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gwyy0ic68lq4rtwgejKSHD7CobPcdtqM90V8niX1P64gKWY+ViwHKspfFeWI4w4mKA0EXGMUTz5lIFiCkb6ZS+Xs+aJWMALXcNoGvMW4aS0jR2L2zyHSJIebBfALLGo/9gQ3iFGj05R8Lx+OUygyQgGhYf6qRoznPqfDEXCxW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-1a-682319eec4fb
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
Subject: [PATCH v15 06/43] dept: add proc knobs to show stats and dependency graph
Date: Tue, 13 May 2025 19:06:53 +0900
Message-Id: <20250513100730.12664-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTZxTHfd47lZp3lbnXilFqcAYjA4Pb+cAWs2TuiUbj7cN0WVgjb2y1
	FGwRRbKFSnEKloERiKhQwFRCi0BLMieWIEgFRUSotVydzDlRLhNtMwRxLWRfTn45/3N+58vh
	SJmLlnNqbaqo0yo1CkZCScZDyzdMLF+jipnyy8H39jQFl2ptDHRfsyKwNRgIGG37Fh77xxDM
	3H9AQnFhN4Lyp0MkNLiGETirTjLQ+2wJuH2TDHQU5jKQVVnLwMNXswQMFp0jwGrfDk8szym4
	l19BQPEoAxeLs4hAeUHAtKWaBUtmJIxUlbAw+zQWOoY9NDj718OF0kEGbjo7KHBdHyGg98Yl
	BoZtH2i452qnwJ+3AroLTDTUTFQw8MpvIcHim2Shp9lMgMu8DOqMAeGpN3M03DE1E3DqSj0B
	7r5GBE2n/yDAbvMw0OobI8BhLyTh3dU2BCN54yxkn51m4aIhD0FudhEFxsFNMPNv4PLlt7Fg
	KKujoOa9B23+EttKbQi3jk2S2Og4ht/5HjHY6TdT+G6FgH8vGWKxsamfxWb7UeyoisKVN0cJ
	XD7lo7G9+gyD7VPnWJwz7ibwRFcXuzN8vyQ+UdSo00TdZ1/9KFGVBNwp/8Qfr3wQk4kGYnIQ
	xwl8nPDMzeagkHks6Cwng8zwnwpe7/Q8h/GrBYfpOZ2DJBzJexYLjy/3oWCwlN8t1GcXEEGm
	+Eih2dHDBFnKbxIaz3eSC9JVgrWueZ5D+M+F91e7qCDLAjP5ZisVlAr8ryHCcMkv9MLCcuFW
	lZfKR1IzWlSNZGptWpJSrYmLVqVr1cejDyQn2VHguyw/zX5/HU1172lBPIcUodL20QiVjFam
	6dOTWpDAkYowqeG3QEuaqEw/IeqSE3RHNaK+Ba3gKMUn0o3+Y4ky/qAyVTwsiimi7v+U4ELk
	mSi1dl/EFbnJMuhedGfXGWu7w7i9rLZUWOucMyRHj2s/dC31DAx8fcSGD8gTEnozwi/0Pvpz
	ZW6ZO5Warmv7+yPvF1tLC+MPbYvUx+2oMZlz1/6wr0ET+Y13ccbIttjz9UVbvvv5ZVjG3s7X
	ZdaIv+LedMyErZuTM7cdQyc+lm3YzD5ZraD0KmVsFKnTK/8DwWhxgVkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0zMcRjHfb4/r+PsK40v5tf5tSFq1B6cZvNHHzY/N4zZuOk7d9Rpd6SM
	KV3JpVYmzRFX2fXrqO5sjhytVjpxReekrkPMRF12uojEHfPPs9ee97PX889bRIZW0NNFStVR
	Qa2Sx0sZMSXevCY93DttniLicQYJ/qEsCq5Wmxhov1WFwHQ7jYC+plh4OdyP4OfTNhIKC9oR
	FL/tIeF2sweBrfwMAx3vJ4LTP8iAvSCbgfTSagaefR4lwH3pAgFV5k3w2viBgta8EgIK+xi4
	UphOBMZHAkaMlSwYUxdAb7mehdG3kWD3uGhoLLLTYOtaApevuRm4b7NT0GztJaDj3lUGPKbf
	NLQ2t1AwnDsD2vNzaLjpLWHg87CRBKN/kIXn9QYCmg1ToEYbsGZ+HaPhUU49AZk3aglwvqpD
	8CDrDQFmk4uBRn8/ARZzAQk/ypoQ9OYOsJBxfoSFK2m5CLIzLlGgdUfBz++Bz0VDkZB2vYaC
	m79caF0MNl0zIdzYP0hireU4/uF/wWDbsIHCj0t4fFffw2Ltgy4WG8zHsKV8MS6930fgYp+f
	xubKcww2+y6wWDfgJLDX4WC3ztwjlsUJ8cokQb08Zr9YoQ+4E7/IkkvbIlJRd4QOhYh4biWf
	/6SYDDLDLeI7O0f+chg3h7fkfKB1SCwiOdd4/mXRKxQMJnPb+dqMfCLIFLeAr7c8Z4Is4aL4
	uotPyH/S2XxVTf1fDuGi+V9lDirIoYGbPEMVlYfEBjSuEoUpVUkJcmV81DLNYUWKSpm87MCR
	BDMKFMh4ajTfioY6YhsQJ0LSCZKWvrmKUFqepElJaEC8iJSGSdLuBFaSOHnKCUF9ZJ/6WLyg
	aUAzRJR0qmTjLmF/KHdQflQ4LAiJgvp/SohCpqeiyt2rcGv0p5MyfV7hZp310JbZh6pXdH/T
	rZ91q86L5XVL3rt8nVs8+u/zR1pVBz27PTKf/ayjvVbbwnel7vRtazoZbVUnb187tsHmdbb1
	vJPmhid2vpjj1O1KfLp3sO1RbEX16hBrjts1qXvH8WS34SH57rTZIVs64EhfGBcec11KaRTy
	yMWkWiP/Axfy9x88AwAA
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
 kernel/dependency/dept_internal.h | 53 +++++++++++++++++
 kernel/dependency/dept_proc.c     | 95 +++++++++++++++++++++++++++++++
 4 files changed, 158 insertions(+), 41 deletions(-)
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
index 24ac20b9bb16..882f29a93483 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -74,6 +74,7 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include "dept_internal.h"
 
 static int dept_stop;
 static int dept_per_cpu_ready;
@@ -264,46 +265,13 @@ static bool valid_key(struct dept_key *k)
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
@@ -333,7 +301,7 @@ static void *from_pool(enum object_t t)
 	if (DEPT_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	p = &pool[t];
+	p = &dept_pool[t];
 
 	/*
 	 * Try local pool first.
@@ -368,7 +336,7 @@ static void *from_pool(enum object_t t)
 
 static void to_pool(void *o, enum object_t t)
 {
-	struct dept_pool *p = &pool[t];
+	struct dept_pool *p = &dept_pool[t];
 	struct llist_head *h;
 
 	preempt_disable();
@@ -2109,7 +2077,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(classes);
+LIST_HEAD(dept_classes);
 
 static bool within(const void *addr, void *start, unsigned long size)
 {
@@ -2141,7 +2109,7 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	list_for_each_entry_safe(c, n, &classes, all_node) {
+	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
 			continue;
@@ -2217,7 +2185,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->sub_id = sub_id;
 	c->key = (unsigned long)(k->base + sub_id);
 	hash_add_class(c);
-	list_add(&c->all_node, &classes);
+	list_add(&c->all_node, &dept_classes);
 unlock:
 	dept_unlock();
 caching:
@@ -2951,8 +2919,8 @@ static void migrate_per_cpu_pool(void)
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
index 000000000000..187a9b21f744
--- /dev/null
+++ b/kernel/dependency/dept_internal.h
@@ -0,0 +1,53 @@
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


