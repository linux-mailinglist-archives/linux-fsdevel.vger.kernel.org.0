Return-Path: <linux-fsdevel+bounces-49381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EB2ABB985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4926B1619AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEE028935E;
	Mon, 19 May 2025 09:19:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5B283149;
	Mon, 19 May 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646349; cv=none; b=WLBJLRS8q1vp6mEOt2O4qB/GE2WGmq8HF/zEzyP/aZ3TEQG1tFmLaKVoso7W19cDLu1vjtjsD459UYzC+BKC6rZ+pJyUJpVbjFQ9Q89UfozR/am5D2RpLU+WLELzYw1nWYsEfYb+Fp2gPbSHuo9mGeylj+U2nnEwQi+NtSJTiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646349; c=relaxed/simple;
	bh=s4zHN9XeEk53MhJYeNB0v+KxCbg7we9x407GQpxdMJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Km0EBEwaq8YTu+VBfVBeMfmO90twvcPSAl2CdZQze0iT3jvk+VowospfgsF9McvD+vblNjWYJttyx4O3CkFc5NIlXz+u+lwAm8Yjdgs7RRCH0Nxnt2kJMXhuD3EJwTBmrm1/162f5XMl/BuCLni9UjSbwCNuxTQKOBYLI7A431M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-35-682af77122e1
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
Subject: [PATCH v16 39/42] dept: add module support for struct dept_event_site and dept_event_site_dep
Date: Mon, 19 May 2025 18:18:23 +0900
Message-Id: <20250519091826.19752-40-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+/6eu5z9HPLzsOisIYoM+8ww/MHvn9TmLw9bjn7cTV25S8rY
	imqndKrtavR0XZx2d+ncMUnXUiudhqOTnoRG03qauCMid5l/Pnvt89779fnnw+CSDnIZo1Cm
	CCqlLEFKiQjR+DxDxJnv4fJN2voQ8HzTEFBWZ6HAdceMwHIvE4ORtv3wxjuG4NezFziU6FwI
	qj68xeFe+yACR80lCro+zge3Z5ICpy6PgsvVdRS8HJ3BYKC4CAOzLRreGYcJ6CwwYFAyQkFp
	yWXMNz5jMG000WDMCIOhmhs0zHyIAudgNwmOvvVwvWKAgkaHk4D2+iEMuhrKKBi0zJLQ2d5B
	gFe7HFyF+STUThgoGPUacTB6Jml41azHoF0fDNYsnzDn6x8SnuQ3Y5Bz8y4G7t5HCJo07zGw
	WbopaPWMYWC36XD4ebsNwZB2nIbsq9M0lGZqEeRlFxOQNbAVfv3wXS7/FgWZlVYCan93o907
	eUuFBfGtY5M4n2U/x//0vKZ4h1dP8E8NHP/wxluaz2rqo3m97SxvrwnnqxtHML5qykPyNtMV
	irdNFdF87rgb4yeeP6djVxwW7YgXEhSpgmrjrmMieXFBJp08ui8tzzpOZqCb23NRIMOxW7gH
	Hiv9n29V5swxxa7henqmcT8vYldx9vxhMheJGJztDuLelPcif7CQPckV9/aQfibYMM5cbqT8
	LGa3cROFXeQ/6UrObG2eEwX69n15rXNdCbuVc5srCL+UY0sCuY7+BvxfYSn3uKaHKEBiPQow
	IYlCmZooUyRsiZSnKxVpkSeSEm3I91/GizNH6tGU62ALYhkknSe2OtbJJaQsVZ2e2II4Bpcu
	Epvsa+UScbws/bygSopTnU0Q1C1oOUNIl4g3e8/FS9hTshThtCAkC6r/KcYELstAbOr54L17
	I5T9ufdnzQFfNJp+531JuDc6SBsLzUMLTbTbXXGpLlscs+tCCHnEHU1uNywIenqSK310aH/Y
	J9uea8dD4wqN0wePPxTdrRxbExK9+XuoLqmUVrZdPzq8mgqb3aA+UVSoU3zRMCtdp4KdVWnV
	tzs+dc4sbjiQsiOSjJESarksKhxXqWV/AVdh1idbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH/d3nXC1uU+qi9GBkDytL0jhUVBTUrdCif4IicuTNjXTalqZC
	4HJZaYpWzrKc02rJNmtu/tFrZk6ttTJLMydqKmLJdEI5y7LHVvTP4cP5cj7n/HEEuNhIhgnk
	ipO8UiFNllBCQhi/MXf1ia+RsrU1Qxj4Js8TcOOemYL2uyYE5no1BqMtO+H91BiCH69e41BW
	2o6garAPh/rWfgT2mjMUdAzPgU7fBAXO0gIKcm/eo+CNZwaDXu0lDEzWOPhgGCHAVVyNQdko
	BdfLcjF/+YTBtMFIgyEnAoZqymmYGYwGZ38XCY4KJwn2npVwTddLwWO7k4DW+/7rOh7eoKDf
	/JsEV+tzAqaKwqG9pJCEWm81BZ4pAw4G3wQNbxv1GLTq54FF47fmfflFwrPCRgzybtVh0Ol+
	hKDh/AAGVnMXBQ7fGAY2aykO3++0IBgqGqfh7MVpGq6rixAUnNUSoOmNhR/f/JsrJqNBXWkh
	oPZnF9q6mTPrzIhzjE3gnMZ2ivvue0dx9ik9wb2oZrkH5X00p2nooTm9NZ2z1URyNx+PYlzV
	Zx/JWY0XKM76+RLN5Y93Ypy3rY3et+CgcFMinyzP4JVrNicIZdpiNZ3m2ZFZYBknc9CtDfko
	WMAyMeztyjw6wBSzjO3unsYDHMosZm2FI2Q+EgpwpmsW+77CjQJBCHOM1bq7yQATTARrqjBQ
	ARYx61lvSQf5T7qINVka/4qC/f2eAsffWTETy3aadEQxEupRkBGFyhUZKVJ5cmyU6rgsSyHP
	jDqammJF/g8ynJ4puY8mO3Y2IUaAJLNFFvsKmZiUZqiyUpoQK8AloSKjbblMLEqUZmXzytQj
	yvRkXtWEwgWEZL5o9wE+QcwkSU/yx3k+jVf+TzFBcFgOGmhhqlzuoDh3+tJz0iVpo0vcQoc3
	cwCXzLwMcxw6nKTJIbbtbZ5OvFKcHT53ck6VuztkVo8raW555NiWp6Euj9oL5+Qb18Y8KVlW
	u0pxeSBiXZDz68LElXd046kn4vtG2i7v9a5r3s8GPcjNsGq9CR+VB66ermvf7ojdM6zbleKR
	ECqZNDoSV6qkfwC8Kk4PPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

struct dept_event_site and struct dept_event_site_dep have been
introduced to track dependencies between multi event sites for a single
wait, that will be loaded to data segment.  Plus, a custom section,
'.dept.event_sites', also has been introduced to keep pointers to the
objects to make sure all the event sites defined exist in code.

dept should work with the section and segment of module.  Add the
support to handle the section and segment properly whenever modules are
loaded and unloaded.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 14 +++++++
 include/linux/module.h   |  5 +++
 kernel/dependency/dept.c | 79 +++++++++++++++++++++++++++++++++++-----
 kernel/module/main.c     | 15 ++++++++
 4 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 988aceee36ad..25fdd324614a 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -414,6 +414,11 @@ struct dept_event_site {
 	struct dept_event_site		*bfs_parent;
 	struct list_head		bfs_node;
 
+	/*
+	 * for linking all dept_event_site's
+	 */
+	struct list_head		all_node;
+
 	/*
 	 * flag indicating the event is not only declared but also
 	 * actually used in code
@@ -430,6 +435,11 @@ struct dept_event_site_dep {
 	 */
 	struct list_head		dep_node;
 	struct list_head		dep_rev_node;
+
+	/*
+	 * for linking all dept_event_site_dep's
+	 */
+	struct list_head		all_node;
 };
 
 #define DEPT_EVENT_SITE_INITIALIZER(es)					\
@@ -441,6 +451,7 @@ struct dept_event_site_dep {
 	.bfs_gen = 0,							\
 	.bfs_parent = NULL,						\
 	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.all_node = LIST_HEAD_INIT((es).all_node),			\
 	.used = false,							\
 }
 
@@ -450,6 +461,7 @@ struct dept_event_site_dep {
 	.recover_site = NULL,						\
 	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
 	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+	.all_node = LIST_HEAD_INIT((esd).all_node),			\
 }
 
 struct dept_event_site_init {
@@ -473,6 +485,7 @@ extern void dept_init(void);
 extern void dept_task_init(struct task_struct *t);
 extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_mark_event_site_used(void *start, void *end);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
@@ -536,6 +549,7 @@ struct dept_event_site { };
 #define dept_task_init(t)				do { } while (0)
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
+#define dept_mark_event_site_used(s, e)			do { } while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/module.h b/include/linux/module.h
index b3329110d668..3da466a2c705 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -28,6 +28,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/dept.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -599,6 +600,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_DEPT
+	struct dept_event_site **dept_event_sites;
+	unsigned int num_dept_event_sites;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index e14c17b8e197..baa60bd0fb93 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -984,6 +984,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  * event sites.
  */
 
+static LIST_HEAD(dept_event_sites);
+static LIST_HEAD(dept_event_site_deps);
+
 /*
  * Print all events in the circle.
  */
@@ -2043,6 +2046,33 @@ static void del_dep_rcu(struct rcu_head *rh)
 	preempt_enable();
 }
 
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
+{
+	list_del_rcu(&esd->dep_node);
+	list_del_rcu(&esd->dep_rev_node);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site(struct dept_event_site *es)
+{
+	struct dept_event_site_dep *esd, *next_esd;
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+}
+
 /*
  * NOTE: Must be called with dept_lock held.
  */
@@ -2384,6 +2414,8 @@ void dept_free_range(void *start, unsigned int sz)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_class *c, *n;
+	struct dept_event_site_dep *esd, *next_esd;
+	struct dept_event_site *es, *next_es;
 	unsigned long flags;
 
 	if (unlikely(!dept_working()))
@@ -2405,6 +2437,24 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
+	list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
+		if (!within((void *)esd, start, sz))
+			continue;
+
+		disconnect_event_site_dep(esd);
+		list_del(&esd->all_node);
+	}
+
+	list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
+		if (!within((void *)es, start, sz) &&
+		    !within(es->name, start, sz) &&
+		    !within(es->func_name, start, sz))
+			continue;
+
+		disconnect_event_site(es);
+		list_del(&es->all_node);
+	}
+
 	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
@@ -3336,6 +3386,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
 
 	list_add(&esd->dep_node, &es->dep_head);
 	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
+	list_add(&esd->all_node, &dept_event_site_deps);
 	check_recover_dl_bfs(esd);
 unlock:
 	dept_unlock();
@@ -3346,6 +3397,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
 
 #define B2KB(B) ((B) / 1024)
 
+void dept_mark_event_site_used(void *start, void *end)
+{
+	struct dept_event_site_init **evtinitpp;
+
+	for (evtinitpp = (struct dept_event_site_init **)start;
+	     evtinitpp < (struct dept_event_site_init **)end;
+	     evtinitpp++) {
+		(*evtinitpp)->evt_site->used = true;
+		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
+		list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
+
+		pr_info("dept_event_site %s@%s is initialized.\n",
+				(*evtinitpp)->evt_site->name,
+				(*evtinitpp)->evt_site->func_name);
+	}
+}
+
 extern char __dept_event_sites_start[], __dept_event_sites_end[];
 
 /*
@@ -3355,20 +3423,11 @@ extern char __dept_event_sites_start[], __dept_event_sites_end[];
 void __init dept_init(void)
 {
 	size_t mem_total = 0;
-	struct dept_event_site_init **evtinitpp;
 
 	/*
 	 * dept recover dependency tracking works from now on.
 	 */
-	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
-	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
-	     evtinitpp++) {
-		(*evtinitpp)->evt_site->used = true;
-		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
-		pr_info("dept_event %s@%s is initialized.\n",
-				(*evtinitpp)->evt_site->name,
-				(*evtinitpp)->evt_site->func_name);
-	}
+	dept_mark_event_site_used(__dept_event_sites_start, __dept_event_sites_end);
 	dept_recover_ready = true;
 
 	local_irq_disable();
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7e569e1b4db5..1c439ed8c9ed 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2611,6 +2611,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						&mod->dyndbg_info.num_classes);
 #endif
 
+#ifdef CONFIG_DEPT
+	mod->dept_event_sites = section_objs(info, ".dept.event_sites",
+					sizeof(*mod->dept_event_sites),
+					&mod->num_dept_event_sites);
+#endif
 	return 0;
 }
 
@@ -3249,6 +3254,14 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+static void dept_mark_event_site_used_module(struct module *mod)
+{
+#ifdef CONFIG_DEPT
+	dept_mark_event_site_used(mod->dept_event_sites,
+			     mod->dept_event_sites + mod->num_dept_event_sites);
+#endif
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3408,6 +3421,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Done! */
 	trace_module_load(mod);
 
+	dept_mark_event_site_used_module(mod);
+
 	return do_init_module(mod);
 
  sysfs_cleanup:
-- 
2.17.1


