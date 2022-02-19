Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A41E4BC7EB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Feb 2022 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiBSK71 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Feb 2022 05:59:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242159AbiBSK7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Feb 2022 05:59:12 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE986674F0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Feb 2022 02:58:46 -0800 (PST)
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 19 Feb 2022 19:58:45 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.151 with ESMTP; 19 Feb 2022 19:58:45 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org
Cc:     damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, chris@chris-wilson.co.uk,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, bfields@fieldses.org,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jack@suse.com, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
        hamohammed.sa@gmail.com
Subject: [PATCH v2 17/18] dept: Distinguish each syscall context from another
Date:   Sat, 19 Feb 2022 19:58:30 +0900
Message-Id: <1645268311-24222-18-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
References: <1645268311-24222-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It enters kernel mode on each syscall and each syscall handling should
be considered independently from the point of view of Dept. Otherwise,
Dept may wrongly track dependencies across different syscalls.

That might be a real dependency from user mode. However, now that Dept
just started to work, conservatively let Dept not track dependencies
across different syscalls.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h     | 39 ++++++++++++++++------------
 kernel/dependency/dept.c | 67 ++++++++++++++++++++++++------------------------
 kernel/entry/common.c    |  3 +++
 3 files changed, 60 insertions(+), 49 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index e2d4aea..1a1c307 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -25,11 +25,16 @@
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
-	struct dept_iecxt		iecxt[DEPT_IRQS_NR];
-	struct dept_iwait		iwait[DEPT_IRQS_NR];
+	struct dept_iecxt		iecxt[DEPT_CXT_IRQS_NR];
+	struct dept_iwait		iwait[DEPT_CXT_IRQS_NR];
 };
 
 struct dept_stack {
@@ -150,8 +155,8 @@ struct dept_ecxt {
 	/*
 	 * where the IRQ-enabled happened
 	 */
-	unsigned long			enirq_ip[DEPT_IRQS_NR];
-	struct dept_stack		*enirq_stack[DEPT_IRQS_NR];
+	unsigned long			enirq_ip[DEPT_CXT_IRQS_NR];
+	struct dept_stack		*enirq_stack[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * where the event context started
@@ -194,8 +199,8 @@ struct dept_wait {
 	/*
 	 * where the IRQ wait happened
 	 */
-	unsigned long			irq_ip[DEPT_IRQS_NR];
-	struct dept_stack		*irq_stack[DEPT_IRQS_NR];
+	unsigned long			irq_ip[DEPT_CXT_IRQS_NR];
+	struct dept_stack		*irq_stack[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * where the wait happened
@@ -400,19 +405,19 @@ struct dept_task {
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
 	 * current effective IRQ-enabled flag
@@ -448,7 +453,7 @@ struct dept_task {
 	.dept_task.wait_hist = { { .wait = NULL, } },			\
 	.dept_task.ecxt_held_pos = 0,					\
 	.dept_task.wait_hist_pos = 0,					\
-	.dept_task.irq_id = { 0 },					\
+	.dept_task.cxt_id = { 0 },					\
 	.dept_task.wgen_enirq = { 0 },					\
 	.dept_task.enirq_ip = { 0 },					\
 	.dept_task.recursive = 0,					\
@@ -480,6 +485,7 @@ struct dept_task {
 extern void dept_wait_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *w_fn, int ne);
 extern void dept_event_split_map(struct dept_map_each *me, struct dept_map_common *mc, unsigned long ip, const char *e_fn);
 extern void dept_ask_event_split_map(struct dept_map_each *me, struct dept_map_common *mc);
+extern void dept_kernel_enter(void);
 
 /*
  * for users who want to manage external keys
@@ -520,6 +526,7 @@ struct dept_task {
 #define dept_wait_split_map(me, mc, ip, w_fn, ne)	do { } while (0)
 #define dept_event_split_map(me, mc, ip, e_fn)		do { } while (0)
 #define dept_ask_event_split_map(me, mc)		do { } while (0)
+#define dept_kernel_enter()				do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
 #endif
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 84409759..c369a8e 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -212,9 +212,9 @@ static inline struct dept_class *dep_tc(struct dept_dep *d)
 
 static inline const char *irq_str(int irq)
 {
-	if (irq == DEPT_SIRQ)
+	if (irq == DEPT_CXT_SIRQ)
 		return "softirq";
-	if (irq == DEPT_HIRQ)
+	if (irq == DEPT_CXT_HIRQ)
 		return "hardirq";
 	return "(unknown)";
 }
@@ -374,7 +374,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -399,7 +399,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -414,7 +414,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -453,7 +453,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -469,7 +469,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -614,7 +614,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *c_fn = e->ecxt_fn ?: "(unknown)";
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -645,7 +645,7 @@ static void print_dep(struct dept_dep *d)
 	const char *c_fn = e->ecxt_fn ?: "(unknown)";
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -871,7 +871,7 @@ static void bfs(struct dept_class *c, bfs_f *cb, void *in, void **out)
  */
 
 static inline unsigned long cur_enirqf(void);
-static inline int cur_irq(void);
+static inline int cur_cxt(void);
 static inline unsigned int cur_ctxt_id(void);
 
 static inline struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1397,7 +1397,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1433,7 +1433,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg = 0U;
-	int irq;
+	int cxt;
 	int i;
 
 	w = new_wait();
@@ -1445,9 +1445,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 
-	irq = cur_irq();
-	if (irq < DEPT_IRQS_NR)
-		add_iwait(c, irq, w);
+	cxt = cur_cxt();
+	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
+		add_iwait(c, cxt, w);
 
 	/*
 	 * Avoid adding dependency between user aware nested ecxt and
@@ -1512,7 +1512,7 @@ static void add_ecxt(void *obj, struct dept_class *c, unsigned long ip,
 	eh->nest = ne;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1639,7 +1639,7 @@ static void do_event(void *obj, struct dept_class *c, unsigned int wg,
 			break;
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1681,7 +1681,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1706,27 +1706,21 @@ static inline unsigned long cur_enirqf(void)
 	return 0UL;
 }
 
-static inline int cur_irq(void)
+static inline int cur_cxt(void)
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
 
 static inline unsigned int cur_ctxt_id(void)
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
@@ -1776,7 +1770,7 @@ static void enirq_update(unsigned long ip)
 	/*
 	 * Do enirq_transition() only on an OFF -> ON transition.
 	 */
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (prev & (1UL << irq))
 			continue;
 
@@ -1879,6 +1873,13 @@ void dept_disable_hardirq(unsigned long ip)
 	dept_exit(flags);
 }
 
+void dept_kernel_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += (1UL << DEPT_CXTS_NR);
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1886,7 +1887,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += (1UL << DEPT_IRQS_NR);
+	dt->cxt_id[DEPT_CXT_SIRQ] += (1UL << DEPT_CXTS_NR);
 }
 
 /*
@@ -1896,7 +1897,7 @@ void dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += (1UL << DEPT_IRQS_NR);
+	dt->cxt_id[DEPT_CXT_HIRQ] += (1UL << DEPT_CXTS_NR);
 }
 
 /*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad7136..1826508 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,7 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 #include <linux/tick.h>
+#include <linux/dept.h>
 
 #include "common.h"
 
@@ -102,6 +103,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 	long ret;
 
 	__enter_from_user_mode(regs);
+	dept_kernel_enter();
 
 	instrumentation_begin();
 	local_irq_enable();
@@ -114,6 +116,7 @@ noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)
 noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 {
 	__enter_from_user_mode(regs);
+	dept_kernel_enter();
 	instrumentation_begin();
 	local_irq_enable();
 	instrumentation_end();
-- 
1.9.1

