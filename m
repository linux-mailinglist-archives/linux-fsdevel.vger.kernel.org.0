Return-Path: <linux-fsdevel+bounces-48843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7444AB517F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC1861F32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D933253F03;
	Tue, 13 May 2025 10:07:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77A3244691;
	Tue, 13 May 2025 10:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130873; cv=none; b=CkixV3aKVKPSAc11S5ybn//vFsz9w6/7nUoGqk2T1YVRhqaB3EF+G4HcZdpHPCBkJTyZgFuZzXlzjzeMngcESFdBveyCwgxhSPU4W2rYeLLdB8X9JtA0vP2yMBg1e9dH3Bde3/F2MVKxpeAHZ3gI31NS5vWN5f2bOeYP6CMxik0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130873; c=relaxed/simple;
	bh=gP8tQf8HzUzkOl0/4uKU2DTMSmlUgz+LzrjzVdAxmXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jRtOymb4CyW8agWG1QLJW6fNFJ2744YkRb+odvZNIWzB1FdcGyNewghVJKVbPcij7SVioThM8IDy8IYlBTduc7FhkzSWmKZxkXW/NVodQ2S0YESzYyeOSMAIFUjJmNVihuG9Qt6P5gLjavLDB8YtQmH34t3YHJN3I0PPfy+Pk4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-2a-682319ee2b9f
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
Subject: [PATCH v15 07/43] dept: distinguish each kernel context from another
Date: Tue, 13 May 2025 19:06:54 +0900
Message-Id: <20250513100730.12664-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRSG+b6Z+WZarZnU24hGsWowGi81ao6Ju9FE13GjidEYjfzQRia2
	EYppFcVbqCBhixAWUnC9VpBSoSgWoyhWK2gRjIiIXAxUQaMQbsraIhfRUuOfkyfve973/Dkc
	paxkQjmd/qBk0GuiVEROy3vG5yzqnTZHuzStYj74vibTcOGGg0Dt9UIEjlsmDJ1PNkCjvxvB
	8PMXFGRbahFcaWul4JbHi8BlP0Xg1YcJUO/rI1BlSSGQkHuDwMuuEQwtWRkYCp2b4a3tIw3P
	0nMwZHcSOJ+dgAOjA8OgrYAFW/w8aLefY2GkTQ1V3gYGXG8Wwn+XWgjcd1XR4Cltx/Dq3gUC
	XscPBp55ntLgT5sOtf+mMlDUm0Ogy2+jwObrY6HObcXgsU6B4sRAYdL/owxUproxJF29iaG+
	uQzBg+R3GJyOBgIVvm4MJU4LBUP5TxC0p/WwcPrMIAvnTWkIUk5n0ZDYsgKGvwUuX/yqBtPl
	YhqKvjegNX+IjksOJFZ091FiYslhccj3moguv5UWq3ME8e65VlZMfPCGFa3OQ2KJfYGYe78T
	i1f6fYzoLPiHiM7+DFY099Rjsbemht0yY5d8daQUpYuVDEv+3CPX5rpH8YG6HUcyBxJwPDq7
	3ow4TuCXC64iMCNZEFvf2+kxJny40NQ0SI3xJD5MKEn9yJiRnKP4hnFC48VmNGZM5DcLeW3V
	wQDNzxPMmT1BVvArBNe1LPpX6SyhsNgdLJLxK4Xv+TVBXRnYSbcW0mOlAp8tE5yVzeRXYJrw
	yN5EpyOFFYUUIKVOHxut0UUtX6yN0+uOLN4bE+1EgfeynRiJKEX9tdvKEc8h1XjF087ZWiWj
	iTXGRZcjgaNUkxSmOwFJEamJOyoZYnYbDkVJxnI0naNVUxXL/Icjlfw+zUFpvyQdkAy/XczJ
	QuPR1dIImXpto3a9ZebGnV9e5x872V5VOjkjb1zYptH6mKQ8t+PshpQIj8Vr6BraWgcDZRtn
	7T/e+35X9aBXpp27qvzx2vCHA4tuI9W2b2vK4oyf1cN/7Qwpq57LTNyecDOXPN+yqmN7zBJ/
	yN+Z4Z51c2aE1bX6R1qSyaZPHaEWOklvUtFGrUa9gDIYNT8BgHO97loDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG/b5zzne22eJkVicrs0VUdpUyXiiioPBUFhVBEJIOPbXhNNnM
	NAi0LS1L0UTtojUvTdNZcwpZOREl80JmadZCLe1CIy9Um2XNahr98/Ljed73ef55JZRPBeMn
	UcfGi9pYpUZBZLRs32b9mtH5S1Xrc9Nmgst5noaCu2YCXXcqEZhrUzA4HoXAy/FhBL+ePKUg
	P7cLQdFgPwW1LQMIbOVnCXS/nwk9rjECbbkXCehL7hJ49tmNoS/vMoZK6154Y/pIQ0dWMYZ8
	B4Hr+XrsGZ8wTJgqWDAlL4Oh8mssuAeDoG2gl4HmwjYGbK9XwdUbfQTqbW00tNQNYeh+UEBg
	wPyHgY6WVhrGMxdAV3YGA1WjxQQ+j5soMLnGWHjeaMTQYpwLFoMnNfXbbwYeZzRiSC2txtBj
	f4ig4fxbDFZzL4Fm1zCGGmsuBT/LHiEYyhxh4dylCRaup2QiuHgujwZDXzD8+uFpLnQGQcpN
	Cw1Vk71o21bBfMOMhObhMUow1JwSfrpeEME2bqSF9mJeuH+tnxUMDa9ZwWg9KdSUBwol9Q4s
	FH11MYK14gIRrF8vs0L6SA8WRjs72f2Ljsi2RIkadYKoXbc1QqYqafyN454fTsz5rsfJ6MrO
	dCSV8NxGvv9dOT3FhFvOv3o1QU2xLxfA12R8ZNKRTEJxvd78y0I7mjJmc3v5W4Pt0wc0t4xP
	zxmZZjkXzNtu59H/QhfzlZbG6SApt4mfLOuc1n08O1nGSjoLyYzIqwL5qmMTYpRqTfBaXbQq
	KVaduDbyRIwVeT7IdMadXYec3SFNiJMgxQx5q2OJyodRJuiSYpoQL6EUvvKUex5JHqVMOi1q
	T4RrT2pEXRNaIKEV8+S7D4sRPtxxZbwYLYpxova/iyVSv2R0XDrLf56yqkPXcTXCKzvA5jzg
	VZS65dscVbX4peGYY2Noon2yKZQsz97z5cPSBLt9x5FVOW7TSuf67er4FeFPH8d17ltoCdtz
	+2D4iNNgSUrTju4ivrXuwrAZUmqDpq756OpWx6JoQ9rO+OH6dv0T73t+3m5y4VBgqUYaWTIW
	56+gdSplUCCl1Sn/AoqGLeo9AwAA
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
index dc50fa9d388b..138106869494 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -25,11 +25,16 @@ struct task_struct;
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
@@ -94,8 +99,8 @@ struct dept_class {
 			/*
 			 * for tracking IRQ dependencies
 			 */
-			struct dept_iecxt iecxt[DEPT_IRQS_NR];
-			struct dept_iwait iwait[DEPT_IRQS_NR];
+			struct dept_iecxt iecxt[DEPT_CXT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * classified by a map embedded in task_struct,
@@ -207,8 +212,8 @@ struct dept_ecxt {
 			/*
 			 * where the IRQ-enabled happened
 			 */
-			unsigned long	enirq_ip[DEPT_IRQS_NR];
-			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+			unsigned long	enirq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the event context started
@@ -252,8 +257,8 @@ struct dept_wait {
 			/*
 			 * where the IRQ wait happened
 			 */
-			unsigned long	irq_ip[DEPT_IRQS_NR];
-			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+			unsigned long	irq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the wait happened
@@ -383,6 +388,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_update_cxt(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -430,6 +436,7 @@ struct dept_map { };
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
index 882f29a93483..a936a8d831c5 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -229,9 +229,9 @@ static struct dept_class *dep_tc(struct dept_dep *d)
 
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
@@ -409,7 +409,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -435,7 +435,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -451,7 +451,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -490,7 +490,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -506,7 +506,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -664,7 +664,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -697,7 +697,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -865,7 +865,7 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  */
 
 static unsigned long cur_enirqf(void);
-static int cur_irq(void);
+static int cur_cxt(void);
 static unsigned int cur_ctxt_id(void);
 
 static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1442,7 +1442,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1486,7 +1486,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1502,9 +1502,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
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
@@ -1578,7 +1578,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1727,7 +1727,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1774,7 +1774,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1799,27 +1799,21 @@ static unsigned long cur_enirqf(void)
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
@@ -1876,7 +1870,7 @@ static void dept_enirq(unsigned long ip)
 
 	flags = dept_enter();
 
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		dt->enirq_ip[irq] = ip;
 		enirq_transition(irq);
 	}
@@ -1922,6 +1916,13 @@ void noinstr dept_hardirqs_off(void)
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
@@ -1929,7 +1930,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -1939,7 +1940,7 @@ void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index d1aeb206b19a..a626631f6bec 100644
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
 	select DEBUG_MUTEXES
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-- 
2.17.1


