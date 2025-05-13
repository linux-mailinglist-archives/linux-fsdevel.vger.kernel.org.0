Return-Path: <linux-fsdevel+bounces-48877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB89AB5263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 318174A51C5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BD2951BE;
	Tue, 13 May 2025 10:08:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C996028B51F;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130898; cv=none; b=uhWDtoxUM1K+k+ve8PNp1SRujShZ3XK0Nq7mOgw2gvlYa2wxIuTvXB0chQHyccwWXSJNN19WqS607SeLJg4MhbVFgA/yqWJMcVSr+0lWoHp7fVvTv0BLRWeQCKBXqsBWgfelD3fUTH/Vbv/7lqA+SmuWqbSLpHmgH7BRBWA5rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130898; c=relaxed/simple;
	bh=gEgyg/9rYxrXc1J42HwM7TQpw+QbrmZR0z4Ef2LtTSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hab17Seb66PDggGwrcMlj9oAWitUlwwmxQ/8R01cqnVbCmYTXnjug1uxKOgLle5E/Ms3WjPdeUQ9/MgiaDh4XDKPYdlHp4WH1YUovWrp7dBdXJfnfajAsii2Gmd9UFnfyz7nnHsh+lQJ8Gkx3VuS/jlh4Ei6cUX9HaicEoAWlC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-2e-682319f2e398
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
Subject: [PATCH v15 39/43] dept: introduce a new type of dependency tracking between multi event sites
Date: Tue, 13 May 2025 19:07:26 +0900
Message-Id: <20250513100730.12664-40-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUyTZxSGfd7vVmpeK5kPYKLWEBPmx9jEnKCYJcb4/NGoxD8ao814tY0F
	tMinGosgKAqiAYkI0qKptS0fa52CWoIQK+gGKKyCA1SixgpIgrQRQVzL5p+TK/d9zn3/OQKt
	bGPDBW3SEUmfpNapODkjHw0xrfwUtkzzk+0tA76J0wxU1Nk56Kq1IbDfyqbA+3AzPPePIJj6
	q5OGstIuBKbXAzTccg8icFlOctD9Zh70+MY4aC89y0HOtToOng5PU9B/6SIFNscWeGl+x8CT
	4moKyrwcXCnLoQLjPQWTZisPZkMkDFnKeZh+HQ3tgx4WXC9+hMtX+zm472pnwN0wREH33QoO
	Bu3fWHjibmPAXxQBXRcKWaj5WM3BsN9Mg9k3xsOzZiMFbuMPUJ8bCMz7NMPCo8JmCvKu/05B
	T989BE2nX1HgsHs4aPWNUOB0lNLw5cZDBENFozycOjfJw5XsIgRnT11iILc/BqY+B5orJ6Ih
	u6qegZqvHvRrHLFftSPSOjJGk1xnOvni+5sjLr+RIY+rMWksH+BJbtMLnhgdqcRpiSLX7nsp
	Yhr3scRhPcMRx/hFnhSM9lDkY0cHv23RLvn6BEmnTZP0qzfsk2veTw3zh6wJGTWdRtqAjNsL
	kEzA4hr87EMF+50bz3jpIHPictzbOznLoeIS7Cx8F9iRC7TomYufV/ahoLFA3I+nSx7PMiNG
	4k5vORdkhbgWF1hH6f9CF2NbffMsywL61xsdTJCVYgwuNtqYYCgWz8uwyznz/0EYfmDpZYqR
	wojmWJFSm5SWqNbq1qzSZCZpM1b9lpzoQIH/Mh+f3t2AxrviW5AoIFWIos27VKNk1WkpmYkt
	CAu0KlSRfScgKRLUmVmSPnmvPlUnpbSgCIFRLVT87E9PUIoH1Eekg5J0SNJ/dylBFm5AJWQZ
	zOOFFYYxW9g/x6JySv64a+j7M0c70P3IFRc2E1Pldrei9e75dzYejq1Fpk1H8bbYusj4WvL0
	lw2X9QsPhyTmrzN13MswHcgKvbljp+f22xlh8YXkExO4N31n077be15ZirM0Wxt3pVZWxcga
	CkaWLj+Z/iCfDWdDa9ROXayKSdGoo6NofYr6X8Q6CjhbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/fc8fZb2n1w0zOmocobcVnWPgDX8zjP202dPTTHdfD7ohs
	baWE6FQkeuDn2GnXlfzO5vFopThNRamkQqx1Klm6owcPV+afz177vLf3558PR3pb6BmcNvaQ
	qI9V61SMglJsWZG6eHD6XM0S+7lAcA2doqDwlpWBhrISBNY7KQQ4q9dDi7sPwejLehLychsQ
	XPvYQcKdmk4E9uLjDDR+ngpNrgEGHLlnGEi9fouBV71jBLRfzCGgRN4M783dFNRmmQjIczJQ
	kJdKeEYPAcNmCwvm5ADoKs5nYexjCDg6m2moKnLQYG8LhMtX2hl4ZHdQUHOvi4DGB4UMdFr/
	0FBb85wCt3EmNGRn0lD61cRAr9tMgtk1wMLrComAGskXytM8renff9PwLLOCgPQbtwloevsQ
	weNTHwiQrc0MVLn6CLDJuSSM3KxG0GXsZ+HE2WEWClKMCM6cuEhBWnsYjP70XC4aCoGUq+UU
	lP5qRqvDsfWKFeGqvgESp9mO4BHXGwbb3RKFX5gEfD+/g8Vpj9tYLMmHsa14Ib7+yEnga4Mu
	GsuW0wyWB3NYnNHfROCvdXXstlk7FSujRJ02QdQHh0cqND2jvWy8Jepoab1EJiNpewby4gQ+
	VLh/2kmOm+HnCa2twxP24f0FW2Y3nYEUHMk3TxZait6i8WAav18Yu/BiwhQfINQ785lxK/ml
	Qoaln/xXOlsoKa+YsJdn/+tmHTVubz5MyJJKqCykkNAkC/LRxibEqLW6sCDDQU1irPZo0L64
	GBl5PsicNJZ9Dw01rq9EPIdUU5TPnXM03rQ6wZAYU4kEjlT5KFPuelbKKHXiMVEft0d/WCca
	KtFMjlL5KTdGiJHefLT6kHhQFONF/f+U4LxmJKNPa4O2Sq6t60Z0/nhZYGOM6eke/1WmA7ME
	2BHOXvqt4CMNT3RyaNuudwte71X6zpeO8CHpET2aONv5V0nZG1pOLgr2E93pL0eSpGhNvTFn
	le/ubcihfdgz2S5vWuMz7VuApcPYVlabLE8t7LZennI2NPTH8vzjfV/uEn67z3PBKsqgUYcs
	JPUG9V/WobTYPQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It's worth reporting wait-event circular dependency even if it doesn't
lead to an actual deadlock, because it's a good information about a
circular dependency anyway.  However, it should be suppressed once
turning out it doesn't lead an actual deadlock, for instance, there are
other wake-up(or event) paths.

The report needs to be suppressed by annotating that an event can be
recovered by other sites triggering the desired wake-up, using a newly
introduced API, dept_recover_event() specifying an event site and its
recover site.

By the introduction, need of a new type of dependency tracking arises
since a loop of recover dependency could trigger another type of
deadlock.  So implement a logic to track the new type of dependency
between multi event sites for a single wait.

Lastly, to make sure that recover sites must be used in code, introduce
a section '.dept.event_sites' to mark it as 'used' only if used in code,
and warn it if dept_recover_event()s are annotated with recover sites,
not used in code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/asm-generic/vmlinux.lds.h |  13 +-
 include/linux/dept.h              |  91 ++++++++++++++
 kernel/dependency/dept.c          | 197 ++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 58a635a6d5bd..fd24b35fb379 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -699,6 +699,16 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define KERNEL_CTORS()
 #endif
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVNET_SITES_USED()						\
+	. = ALIGN(8);							\
+	__dept_event_sites_start = .;					\
+	KEEP(*(.dept.event_sites))					\
+	__dept_event_sites_end = .;
+#else
+#define DEPT_EVNET_SITES_USED()
+#endif
+
 /* init and exit section handling */
 #define INIT_DATA							\
 	KEEP(*(SORT(___kentry+*)))					\
@@ -723,7 +733,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	DEPT_EVNET_SITES_USED()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/dept.h b/include/linux/dept.h
index a6ff9db9bcf9..b933f9d98c69 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -395,6 +395,82 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+struct dept_event_site {
+	/*
+	 * event site name
+	 */
+	const char			*name;
+
+	/*
+	 * function name where the event is triggered in
+	 */
+	const char			*func_name;
+
+	/*
+	 * for associating its recover dependencies
+	 */
+	struct list_head		dep_head;
+	struct list_head		dep_rev_head;
+
+	/*
+	 * for BFS
+	 */
+	unsigned int			bfs_gen;
+	struct dept_event_site		*bfs_parent;
+	struct list_head		bfs_node;
+
+	/*
+	 * flag indicating the event is not only declared but also
+	 * actually used in code
+	 */
+	bool				used;
+};
+
+struct dept_event_site_dep {
+	struct dept_event_site		*evt_site;
+	struct dept_event_site		*recover_site;
+
+	/*
+	 * for linking to dept_event objects
+	 */
+	struct list_head		dep_node;
+	struct list_head		dep_rev_node;
+};
+
+#define DEPT_EVENT_SITE_INITIALIZER(es)					\
+{									\
+	.name = #es,							\
+	.func_name = NULL,						\
+	.dep_head = LIST_HEAD_INIT((es).dep_head),			\
+	.dep_rev_head = LIST_HEAD_INIT((es).dep_rev_head),		\
+	.bfs_gen = 0,							\
+	.bfs_parent = NULL,						\
+	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.used = false,							\
+}
+
+#define DEPT_EVENT_SITE_DEP_INITIALIZER(esd)				\
+{									\
+	.evt_site = NULL,						\
+	.recover_site = NULL,						\
+	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
+	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+}
+
+struct dept_event_site_init {
+	struct dept_event_site *evt_site;
+	const char *func_name;
+};
+
+#define dept_event_site_used(es)					\
+do {									\
+	static struct dept_event_site_init _evtinit __initdata =	\
+		{ .evt_site = (es), .func_name = __func__ };		\
+	static struct dept_event_site_init *_evtinitp __used		\
+		__attribute__((__section__(".dept.event_sites"))) =	\
+		&_evtinit;						\
+} while (0)
+
 extern void dept_stop_emerg(void);
 extern void dept_on(void);
 extern void dept_off(void);
@@ -432,6 +508,14 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 extern void dept_key_init(struct dept_key *k);
 extern void dept_key_destroy(struct dept_key *k);
 extern void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f, struct dept_key *new_k, unsigned long new_e_f, unsigned long new_ip, const char *new_c_fn, const char *new_e_fn, int new_sub_l);
+extern void __dept_recover_event(struct dept_event_site_dep *esd, struct dept_event_site *es, struct dept_event_site *rs);
+
+#define dept_recover_event(es, rs)					\
+do {									\
+	static struct dept_event_site_dep _esd = DEPT_EVENT_SITE_DEP_INITIALIZER(_esd);\
+									\
+	__dept_recover_event(&_esd, es, rs);				\
+} while (0)
 
 extern void dept_softirq_enter(void);
 extern void dept_hardirq_enter(void);
@@ -445,8 +529,10 @@ extern void dept_hardirqs_off(void);
 struct dept_key { };
 struct dept_map { };
 struct dept_ext_wgen { };
+struct dept_event_site { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
+#define DEPT_EVENT_SITE_INITIALIZER(es) { }
 
 #define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
@@ -477,6 +563,7 @@ struct dept_ext_wgen { };
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
 #define dept_map_ecxt_modify(m, e_f, n_k, n_e_f, n_ip, n_c_fn, n_e_fn, n_sl) do { (void)(n_k); (void)(n_c_fn); (void)(n_e_fn); } while (0)
+#define dept_recover_event(es, rs)			do { } while (0)
 
 #define dept_softirq_enter()				do { } while (0)
 #define dept_hardirq_enter()				do { } while (0)
@@ -487,4 +574,8 @@ struct dept_ext_wgen { };
 
 #define dept_set_lockdep_map(m, lockdep_m)		do { } while (0)
 #endif
+
+#define DECLARE_DEPT_EVENT_SITE(es) extern struct dept_event_site (es)
+#define DEFINE_DEPT_EVENT_SITE(es) struct dept_event_site (es) = DEPT_EVENT_SITE_INITIALIZER(es)
+
 #endif /* __LINUX_DEPT_H */
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 3313ac4df3a6..b7167ce4f647 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -979,6 +979,118 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
 	}
 }
 
+/*
+ * Recover dependency between event sites
+ * =====================================================================
+ * Even though an event is in a chain of wait-event circular dependency,
+ * the corresponding wait might be woken up by another site triggering
+ * the desired event.  To reflect that, dept allows to annotate the
+ * recover relationship between event sites using __dept_recover_event().
+ * However, that requires to track a new type of dependency between the
+ * event sites.
+ */
+
+/*
+ * Print all events in the circle.
+ */
+static void print_recover_circle(struct dept_event_site *es)
+{
+	struct dept_event_site *from = es->bfs_parent;
+	struct dept_event_site *to = es;
+
+	dept_outworld_enter();
+
+	pr_warn("===================================================\n");
+	pr_warn("DEPT: Circular recover dependency has been detected.\n");
+	pr_warn("%s %.*s %s\n", init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version,
+		print_tainted());
+	pr_warn("---------------------------------------------------\n");
+
+	do {
+		print_spc(1, "event site(%s@%s)\n", from->name, from->func_name);
+		print_spc(1, "-> event site(%s@%s)\n", to->name, to->func_name);
+		to = from;
+		from = from->bfs_parent;
+
+		if (to != es)
+			pr_warn("\n");
+	} while (to != es);
+
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("information that might be helpful\n");
+	pr_warn("---------------------------------------------------\n");
+	dump_stack();
+
+	dept_outworld_exit();
+}
+
+static void bfs_init_recover(void *node, void *in, void **out)
+{
+	struct dept_event_site *root = (struct dept_event_site *)node;
+	struct dept_event_site_dep *new = (struct dept_event_site_dep *)in;
+
+	root->bfs_gen = bfs_gen;
+	new->recover_site->bfs_parent = new->evt_site;
+}
+
+static void bfs_extend_recover(struct list_head *h, void *node)
+{
+	struct dept_event_site *cur = (struct dept_event_site *)node;
+	struct dept_event_site_dep *esd;
+
+	list_for_each_entry(esd, &cur->dep_head, dep_node) {
+		struct dept_event_site *next = esd->recover_site;
+
+		if (bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_parent = cur;
+		next->bfs_gen = bfs_gen;
+		list_add_tail(&next->bfs_node, h);
+	}
+}
+
+static void *bfs_dequeue_recover(struct list_head *h)
+{
+	struct dept_event_site *es;
+
+	DEPT_WARN_ON(list_empty(h));
+
+	es = list_first_entry(h, struct dept_event_site, bfs_node);
+	list_del(&es->bfs_node);
+	return es;
+}
+
+static enum bfs_ret cb_check_recover_dl(void *node, void *in, void **out)
+{
+	struct dept_event_site *cur = (struct dept_event_site *)node;
+	struct dept_event_site_dep *new = (struct dept_event_site_dep *)in;
+
+	if (cur == new->evt_site) {
+		print_recover_circle(new->recover_site);
+		dept_stop_emerg();
+		return BFS_DONE;
+	}
+
+	return BFS_CONTINUE;
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void check_recover_dl_bfs(struct dept_event_site_dep *esd)
+{
+	struct bfs_ops ops = {
+		.bfs_init = bfs_init_recover,
+		.extend = bfs_extend_recover,
+		.dequeue = bfs_dequeue_recover,
+		.callback = cb_check_recover_dl,
+	};
+
+	bfs((void *)esd->recover_site, &ops, (void *)esd, NULL);
+}
+
 /*
  * Main operations
  * =====================================================================
@@ -3176,8 +3288,78 @@ static void migrate_per_cpu_pool(void)
 	}
 }
 
+static bool dept_recover_ready;
+
+void __dept_recover_event(struct dept_event_site_dep *esd,
+		struct dept_event_site *es, struct dept_event_site *rs)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	if (!esd || !es || !rs) {
+		DEPT_WARN_ONCE("All the parameters should be !NULL.\n");
+		return;
+	}
+
+	/*
+	 * Check locklessly if another already has done it for us.
+	 */
+	if (READ_ONCE(esd->evt_site))
+		return;
+
+	if (!dept_recover_ready) {
+		DEPT_WARN("Should be called once dept_recover_ready.\n");
+		return;
+	}
+
+	flags = dept_enter();
+	if (unlikely(!dept_lock()))
+		goto exit;
+
+	/*
+	 * Check if another already has done it for us with lock held.
+	 */
+	if (esd->evt_site)
+		goto unlock;
+
+	/*
+	 * Can be used as an indicator of whether this
+	 * __dept_recover_event() has been processed or not as well as
+	 * for storing its associated events.
+	 */
+	WRITE_ONCE(esd->evt_site, es);
+	esd->recover_site = rs;
+
+	if (!es->used || !rs->used) {
+		if (!es->used)
+			DEPT_INFO("dept_event_site %s has never been used.\n", es->name);
+		if (!rs->used)
+			DEPT_INFO("dept_event_site %s has never been used.\n", rs->name);
+
+		DEPT_WARN("Cannot track recover dependency with events that never used.\n");
+		goto unlock;
+	}
+
+	list_add(&esd->dep_node, &es->dep_head);
+	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
+	check_recover_dl_bfs(esd);
+unlock:
+	dept_unlock();
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(__dept_recover_event);
+
 #define B2KB(B) ((B) / 1024)
 
+extern char __dept_event_sites_start[], __dept_event_sites_end[];
+
 /*
  * Should be called after setup_per_cpu_areas() and before no non-boot
  * CPUs have been on.
@@ -3185,6 +3367,21 @@ static void migrate_per_cpu_pool(void)
 void __init dept_init(void)
 {
 	size_t mem_total = 0;
+	struct dept_event_site_init **evtinitpp;
+
+	/*
+	 * dept recover dependency tracking works from now on.
+	 */
+	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
+	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
+	     evtinitpp++) {
+		(*evtinitpp)->evt_site->used = true;
+		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
+		pr_info("dept_event %s@%s is initialized.\n",
+				(*evtinitpp)->evt_site->name,
+				(*evtinitpp)->evt_site->func_name);
+	}
+	dept_recover_ready = true;
 
 	local_irq_disable();
 	dept_per_cpu_ready = 1;
-- 
2.17.1


