Return-Path: <linux-fsdevel+bounces-49352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86876ABB8EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C05177C09
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CF9276022;
	Mon, 19 May 2025 09:18:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EA826F45D;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646334; cv=none; b=DjlMj1gjnEI3AWsTmaSndmg/KaWUQsivo5e6FGvA0/zaZGjZJ2FJ1lrPeWk0oGPy4ATB6v6g7dcnqzdVVyS40V4Z+Br8QcmKxRiZuUxBJCjtjwDEdLcPT9CkhhOmRu+dYXsA/uPzHYFgirLib+8bacFNSFHACgSEvieCegsg0Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646334; c=relaxed/simple;
	bh=ezEJxJ4N1Vjrb6q0DqS69gfOLERcwARBMwf+UHXwu2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Am52ys0HAUUeLVuCBkgySE2fFhYzU0vIChs/5kWok3pHfB7aBxBVtcamF6QNAKjFdJirvcdu2pb5QH35QpfatRM/WP1dW9rfMhpzbYg/PDBq8W6fGzpK4moem6AjDAR42UZ5HIJCfeIl+VHWbfDUssgIqM3v7aFXFBsavRQV8uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-72-682af76db36f
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
Subject: [PATCH v16 07/42] dept: distinguish each kernel context from another
Date: Mon, 19 May 2025 18:17:51 +0900
Message-Id: <20250519091826.19752-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+917d+91ubosqZsW1SgsI82oOEQvev7CjKCgKKhGXttqLplT
	M4p8rJemmWaWpU6LtdystfWwx8QcLe1ptaaJWg2JLM2wtjLtsRn9c/hwzvl+zj+HJaVOUSir
	VGsFjVquktFiStwTXDFD/T1CMfPNk8ng/XaEgnNXzDQ0XTYhMF/LIKDr/kpo9nUjGHjyjITi
	oiYEFe/aSbjm7EBgN2bS8LJzBLi8vTQ0FuXQkHX+Cg3PPw0S0HaqgACTNRbeGN5T8Ci/koDi
	LhrOFmcR/vKBgH5DFQOG9CngMZYwMPguGho73CKwt06HM2VtNNy1N1LgrPEQ8PL2ORo6zH9E
	8MjZQIEvLwyaTuSKoPpzJQ2ffAYSDN5eBl7U6Qlw6keDRecXHvr6WwQPcusIOHThKgGu13cQ
	1B55S4DV7KbB4e0mwGYtIuHnxfsIPHk9DBw81s/A2Yw8BDkHT1Gga5sDAz/8l0u/RUNGuYWC
	6l9utHgBNpeZEXZ095JYZ0vFP72vaGz36Sn8sJLHt0raGayrbWWw3pqMbcYIfP5uF4Er+rwi
	bK06SmNrXwGDs3tcBP789Cmzdtwm8fw4QaVMETRRC7eJFQ0nG1CiZ8Oex+0NVDoyLM9GLMtz
	s/kL7nnZKGgIB/JviAJMc+F8S0s/GeAQbiJvy33v74tZknMP55tLX6PAYBQXy7sKTzMBprgp
	vLncgQJOCTeHf2YO/+ecwJssdUOeIG4u35rjGIpK/SsuUxkVcPJcYRDvzCxm/gXG8veMLVQ+
	kujRsCokVapTEuRK1exIRZpauSdy++4EK/J/l2H/4OYa1Ne0rh5xLJIFSyz2aQqpSJ6SlJZQ
	j3iWlIVIqmxTFVJJnDxtr6DZvVWTrBKS6lEYS8nGSGb5UuOk3A65VtglCImC5v+UYINC01Hq
	ogk2n1a9M/56WX/nhkSNdlRJNbk+9nnCmGFR5Z59Mc13jodmhU4q7DNmZ4aJTVgTUj1pTVTP
	wqX8sr01x1eJU0K6Hmg35UQfKKiN/xIvhC/5fmNycGvn6OX5y3QbD9SZ1LVrPl7fH+n48Wvd
	pW0jtTGWm/terTYd/q0av2JL6erkcBmVpJBHR5CaJPlfuEKuxlkDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSV0xTcRTG/d9NteZaidyARlNDVIxiI5gTJYTEdWOC8cGR+EKLXm1DqaZV
	FFcYtaIMEUUUBcpIZVwEb4lx1RAqCC7QVpaAiiMSGQZpFcFRNL6c/PJ953zfy2FwRQUZyOgM
	BwSjQaNXUjJCtnlN6rL4byHaFa11c8EzlkbA1RqRgrbrVQjEumQMBho3Qod3EMHE01Yc8nLb
	EBS/7cWhrqkPgaM8hQLX+5ng9oxQ0JKbTkFqaQ0Fzz9PYtBzMQeDKikaXts+EvA4uwSDvAEK
	ruSlYr7xCYNxWyUNtqRg6C/Pp2HyrQpa+tpJcBa0kODoXgqXC3souOdoIaDpVj8GrjtXKegT
	f5PwuKmZAG9WELSdyySheriEgs9eGw42zwgNL+qtGDRZ50Ct2Zdq+fqLhIeZ9RhYym5g4O66
	i+B+2hsMJLGdAqdnEAO7lIvDj2uNCPqzhmg4mTFOw5XkLATpJy8SYO4Jh4nvvuaCMRUkF9US
	UP2zHUVF8mKhiHjn4AjOm+2H+B+elxTv8FoJ/lEJx9/O76V58/1umrdKB3l7eQhfem8A44tH
	PSQvVZ6meGk0h+bPDLkxfvjZM3rLvJ2yiN2CXpcgGEMj1TJt84VmtL9/x+Envc1EErKtP4P8
	GI4N4yayb5JTTLGLuM7OcXyK/dkFnD3zo0+XMTjbPp3rKOhCU8ZsNppzn79ETzHBBnNikdOn
	M4ycDedaxUX/MudzVbX1f3P82FVcd7rz76nCt+KuKiSykcyKplUif50hIV6j04cvN8VpEw26
	w8t37YuXkO+BbMcnz91CY66NDYhlkHKGvNaxRKsgNQmmxPgGxDG40l9eaV+sVch3axKPCMZ9
	McaDesHUgIIYQhkg37RDUCvYvZoDQpwg7BeM/12M8QtMQnvUaTEe85wnsWmSxSy3lE7m39i+
	LeOX9WxdhevEl3dhxyLI7HVBLpPo7iRnFOsbr63Ni1GOV8x6LwVPW/vgza7qC9HDq83qDu9Y
	oX9qVGi5mKFQLDVsPhWzdWWKOor5UOQOWxcaVLYh67pS9QoC1jwoUB2NK4u1dOVEBlhbF0Yo
	CZNWowrBjSbNH8v9LsA8AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Each unique kernel context, in dept's point of view, should be
identified on every entrance to kernel mode e.g. system call or user
oriented fault.  Otherwise, dept may track meaningless dependencies
across different kernel context.

Plus, in order to update kernel context id at the very beginning of each
entrance, arch code support is required, that could be configured by
CONFIG_ARCH_HAS_DEPT_SUPPORT.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 29 ++++++++++-------
 include/linux/sched.h    | 10 +++---
 kernel/dependency/dept.c | 67 ++++++++++++++++++++--------------------
 lib/Kconfig.debug        |  5 ++-
 4 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 5f0d2d8c8cbe..cb1b1beea077 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -26,11 +26,16 @@ struct task_struct;
 #define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
 #define DEPT_MAX_SUBCLASSES_CACHE	2
 
-#define DEPT_SIRQ			0
-#define DEPT_HIRQ			1
-#define DEPT_IRQS_NR			2
-#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
-#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+enum {
+	DEPT_CXT_SIRQ = 0,
+	DEPT_CXT_HIRQ,
+	DEPT_CXT_IRQS_NR,
+	DEPT_CXT_PROCESS = DEPT_CXT_IRQS_NR,
+	DEPT_CXTS_NR
+};
+
+#define DEPT_SIRQF			(1UL << DEPT_CXT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_CXT_HIRQ)
 
 struct dept_ecxt;
 struct dept_iecxt {
@@ -95,8 +100,8 @@ struct dept_class {
 			/*
 			 * for tracking IRQ dependencies
 			 */
-			struct dept_iecxt iecxt[DEPT_IRQS_NR];
-			struct dept_iwait iwait[DEPT_IRQS_NR];
+			struct dept_iecxt iecxt[DEPT_CXT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * classified by a map embedded in task_struct,
@@ -208,8 +213,8 @@ struct dept_ecxt {
 			/*
 			 * where the IRQ-enabled happened
 			 */
-			unsigned long	enirq_ip[DEPT_IRQS_NR];
-			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+			unsigned long	enirq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the event context started
@@ -253,8 +258,8 @@ struct dept_wait {
 			/*
 			 * where the IRQ wait happened
 			 */
-			unsigned long	irq_ip[DEPT_IRQS_NR];
-			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+			unsigned long	irq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the wait happened
@@ -384,6 +389,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_update_cxt(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -431,6 +437,7 @@ struct dept_map { };
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
+#define dept_update_cxt()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a1924b40feb5..802fca4d99b3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -827,19 +827,19 @@ struct dept_task {
 	int				wait_hist_pos;
 
 	/*
-	 * sequential id to identify each IRQ context
+	 * sequential id to identify each context
 	 */
-	unsigned int			irq_id[DEPT_IRQS_NR];
+	unsigned int			cxt_id[DEPT_CXTS_NR];
 
 	/*
 	 * for tracking IRQ-enabled points with cross-event
 	 */
-	unsigned int			wgen_enirq[DEPT_IRQS_NR];
+	unsigned int			wgen_enirq[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for keeping up-to-date IRQ-enabled points
 	 */
-	unsigned long			enirq_ip[DEPT_IRQS_NR];
+	unsigned long			enirq_ip[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for reserving a current stack instance at each operation
@@ -893,7 +893,7 @@ struct dept_task {
 	.wait_hist = { { .wait = NULL, } },			\
 	.ecxt_held_pos = 0,					\
 	.wait_hist_pos = 0,					\
-	.irq_id = { 0U },					\
+	.cxt_id = { 0U },					\
 	.wgen_enirq = { 0U },					\
 	.enirq_ip = { 0UL },					\
 	.stack = NULL,						\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 9650d6d0c4d0..b4a39c81bbc1 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -230,9 +230,9 @@ static struct dept_class *dep_tc(struct dept_dep *d)
 
 static const char *irq_str(int irq)
 {
-	if (irq == DEPT_SIRQ)
+	if (irq == DEPT_CXT_SIRQ)
 		return "softirq";
-	if (irq == DEPT_HIRQ)
+	if (irq == DEPT_CXT_HIRQ)
 		return "hardirq";
 	return "(unknown)";
 }
@@ -410,7 +410,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -436,7 +436,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -452,7 +452,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -491,7 +491,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -507,7 +507,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -665,7 +665,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -698,7 +698,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -866,7 +866,7 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  */
 
 static unsigned long cur_enirqf(void);
-static int cur_irq(void);
+static int cur_cxt(void);
 static unsigned int cur_ctxt_id(void);
 
 static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1443,7 +1443,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1487,7 +1487,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1503,9 +1503,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
 
-	irq = cur_irq();
-	if (irq < DEPT_IRQS_NR)
-		add_iwait(c, irq, w);
+	cxt = cur_cxt();
+	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
+		add_iwait(c, cxt, w);
 
 	/*
 	 * Avoid adding dependency between user aware nested ecxt and
@@ -1579,7 +1579,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1728,7 +1728,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1775,7 +1775,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1800,27 +1800,21 @@ static unsigned long cur_enirqf(void)
 	return 0UL;
 }
 
-static int cur_irq(void)
+static int cur_cxt(void)
 {
 	if (lockdep_softirq_context(current))
-		return DEPT_SIRQ;
+		return DEPT_CXT_SIRQ;
 	if (lockdep_hardirq_context())
-		return DEPT_HIRQ;
-	return DEPT_IRQS_NR;
+		return DEPT_CXT_HIRQ;
+	return DEPT_CXT_PROCESS;
 }
 
 static unsigned int cur_ctxt_id(void)
 {
 	struct dept_task *dt = dept_task();
-	int irq = cur_irq();
+	int cxt = cur_cxt();
 
-	/*
-	 * Normal process context
-	 */
-	if (irq == DEPT_IRQS_NR)
-		return 0U;
-
-	return dt->irq_id[irq] | (1UL << irq);
+	return dt->cxt_id[cxt] | (1UL << cxt);
 }
 
 static void enirq_transition(int irq)
@@ -1877,7 +1871,7 @@ static void dept_enirq(unsigned long ip)
 
 	flags = dept_enter();
 
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		dt->enirq_ip[irq] = ip;
 		enirq_transition(irq);
 	}
@@ -1923,6 +1917,13 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+void noinstr dept_update_cxt(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1930,7 +1931,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -1940,7 +1941,7 @@ void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 54b03db59a12..195c11b92bcf 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1365,9 +1365,12 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config ARCH_HAS_DEPT_SUPPORT
+	bool
+
 config DEPT
 	bool "Dependency tracking (EXPERIMENTAL)"
-	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && ARCH_HAS_DEPT_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-- 
2.17.1


