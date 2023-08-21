Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FDF78225C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjHUEIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjHUEIL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:08:11 -0400
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32EA4194
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Aug 2023 21:07:28 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-ab-64e2ded5845e
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [RESEND PATCH v10 12/25] dept: Distinguish each syscall context from another
Date:   Mon, 21 Aug 2023 12:46:24 +0900
Message-Id: <20230821034637.34630-13-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfb+/x44fv53GT9noNmxMD1b2YZ42w8/TMGPDHzruN91cZXdE
        zUOo0IMeyCmhYufUUf0uo644WXEeElpiae7kIT1RLlKhq/nnvdfe78/7/deHJZRllA+rjdgr
        6SPUOhWtIBUdY/JmNzS7NIE9sQpITw4E94+TJOQUWWiou1mIwFJ6FENr9Qp43duOoP/ZcwKM
        mXUI8pzvCCitaUZQaT5Gw6uWsVDv7qLBkZlEw/ErRTS8aBvA0HQuA0OhvBaepOVjsPd9JsHY
        SsMF43E8JF8w9JkKGDDFTgOXOZuBAWcQOJobKKh8OwuyLjXRUFHpIKHmjgvDq/IcGpotfyl4
        UvOIhLr0FApudObT0NZrIsDk7mLgpT0XQ3Hc0FBCzx8KHqbYMSRcLcFQ/8aG4O7J9xhkSwMN
        D9ztGKxyJgG/r1UjcJ3uYCA+uY+BC0dPI0iKP0fC88GHFMQ1hUD/rxx6yXzxQXsXIcZZ94uV
        vbmk+DhfEMuy3zFi3N23jJgr7xOt5pnilYpWLOZ1uylRLjhFi3J3BiMmdtRjsbO2lhEfne8n
        xZZ6I17vu1WxQCPptFGSPmBRqCKsx9ZP7DkbeuBjRhKORefXJCIvVuCDhVtlt+lExA5zfGqw
        x6b5GUJjYx/hYW9+qmBN+UQlIgVL8CdGC+Zvz2hPMJ7fJFS/KCE9TPLThLNnLg4XOH6u8DX1
        MjGyP0UoLLYPs9eQL9vKkYeVfIjw3fmBHLlJ8hIuZkwc4UnCfXMjmYa4XDSqACm1EVHhaq0u
        2D8sOkJ7wH9nZLiMhh7KdGhg2x3UXbexCvEsUo3hQie7NEpKHWWIDq9CAkuovDnfn06NktOo
        o2MkfeR2/T6dZKhCviypmsjN6d2vUfK71Hul3ZK0R9L/TzHr5ROLDj8taVsZPT3mREiQdjBN
        Xuv/9f71pnvFFVHWl4MWtGDd5fY3G7iDumX52vL5nfjpbG8jl/Xj42IfO2cZXFe7I6AocGHw
        kS/Ghgmrt24ecG7zW85YlyxdVZrVMYn6Pq5lyxxbijr9T2HCzXK/nzMcyTkBK0tshnmpxY6Y
        Y/f8AidHVqtIQ5g6aCahN6j/AaVrYtRMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/v7/GO4+fc5rcYdtayDDWyzzBjsX4zzMOwmc3d3I87enKX
        lA3RFa4npVwUpTitB+muP+KUU4rEiZKn3Oo89qA8dHHKQ7X557PXPu+9P399WEKeS/mwuvAo
        UR+uDlXSUlK6fmn8vGcutyagKmcepCcHgGfgJAm55aU0NF8rQVBaeQxDV30IPB/sRTD06DEB
        5qxmBJc63xBQ2eBCUF10nIaWdxOh1dNPQ2NWEg3xheU0POkZxtB+NgNDiXUdNJ0uwODwfiTB
        3EVDjjkej4xPGLyWYgYscb7gLjrPwHBnIDS62iiou9BIQfWruXDuYjsNt6obSWiocmNouZlL
        g6v0LwVNDfdJaE5PoaCsr4CGnkELARZPPwNPHfkYrhtHriV+/0PBvRQHhsTLFRhaX9oR1Jzs
        wGAtbaOhztOLwWbNIuDX1XoE7tTPDCQkexnIOZaKICnhLAmPf9+jwNgeBEM/c+kVS4W63n5C
        MNoOCtWD+aTwoIAXbpx/wwjGmleMkG89INiK/IXCW11YuPTNQwnW4lO0YP2WwQimz61Y6HM6
        GeF+9hApvGs14w3Tt0uXacRQXbSoX7BcJdV+tw8RkZmqmPcZSTgOZa81IZbluUV8QtoiE5Kw
        NOfHv3jhJUat4GbxtpQPlAlJWYI7MZ4v+vKIHg2mcFv4+icV5KhJzpfPPHNhrCDjFvPdaXlj
        5rmZfMl1x5glI3ur/SYatZwL4r92viVPI2k+GleMFLrw6DC1LjRovmGfNjZcFzN/V0SYFY38
        jOXwcHoVGmgJqUUci5QTZKrpbo2cUkcbYsNqEc8SSoVs2o9OjVymUcceEvURO/UHQkVDLZrG
        ksqpsjXbRJWc26OOEveJYqSo/59iVuITh6ruFH6c3TEgY5Xre2uOTFJ27BjMW7JMu83nYcj7
        JqfTtss540b2koWJFRJ7Ro5vahlB2YN7/DdJYq5e8dt88PDrvg7nHL37w3EqOWT2yruRlaa8
        /Xu7P/Unbr1t/hX8NdOocBWnKfwCNjq8US7t5rbu1buP+qxSTb5oCG7rCYxwNSlJg1Yd6E/o
        Dep/YqCJCy8DAAA=
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/kernel/syscall.c |  2 ++
 arch/x86/entry/common.c     |  4 +++
 include/linux/dept.h        | 39 ++++++++++++---------
 kernel/dependency/dept.c    | 67 +++++++++++++++++++------------------
 4 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index da84cf855c44..d5a43e721173 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/ptrace.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
+#include <linux/dept.h>
 
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
@@ -105,6 +106,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 */
 
 	local_daif_restore(DAIF_PROCCTX);
+	dept_kernel_enter();
 
 	if (flags & _TIF_MTE_ASYNC_FAULT) {
 		/*
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6c2826417b33..7cdd27abe529 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/dept.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -72,6 +73,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 
 __visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 {
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
@@ -120,6 +122,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	int nr = syscall_32_enter(regs);
 
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
@@ -140,6 +143,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	int nr = syscall_32_enter(regs);
 	int res;
 
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	/*
 	 * This cannot use syscall_enter_from_user_mode() as it has to
diff --git a/include/linux/dept.h b/include/linux/dept.h
index b6d45b4b1fd6..f62c7b6f42c6 100644
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
@@ -406,19 +411,19 @@ struct dept_task {
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
@@ -470,7 +475,7 @@ struct dept_task {
 	.wait_hist = { { .wait = NULL, } },			\
 	.ecxt_held_pos = 0,					\
 	.wait_hist_pos = 0,					\
-	.irq_id = { 0U },					\
+	.cxt_id = { 0U },					\
 	.wgen_enirq = { 0U },					\
 	.enirq_ip = { 0UL },					\
 	.eff_enirqf = 0UL,					\
@@ -509,6 +514,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_kernel_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -560,6 +566,7 @@ struct dept_task { };
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
+#define dept_kernel_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index c5e23e9184b8..4165cacf4ebb 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -221,9 +221,9 @@ static inline struct dept_class *dep_tc(struct dept_dep *d)
 
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
@@ -407,7 +407,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -432,7 +432,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -448,7 +448,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -487,7 +487,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -503,7 +503,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -652,7 +652,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -685,7 +685,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -911,7 +911,7 @@ static void bfs(struct dept_class *c, bfs_f *cb, void *in, void **out)
  */
 
 static inline unsigned long cur_enirqf(void);
-static inline int cur_irq(void);
+static inline int cur_cxt(void);
 static inline unsigned int cur_ctxt_id(void);
 
 static inline struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1459,7 +1459,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1495,7 +1495,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg = 0U;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1511,9 +1511,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
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
@@ -1594,7 +1594,7 @@ static bool add_ecxt(struct dept_map *m, struct dept_class *c,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1746,7 +1746,7 @@ static void do_event(struct dept_map *m, struct dept_class *c,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1788,7 +1788,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1813,27 +1813,21 @@ static inline unsigned long cur_enirqf(void)
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
@@ -1884,7 +1878,7 @@ static void enirq_update(unsigned long ip)
 	/*
 	 * Do enirq_transition() only on an OFF -> ON transition.
 	 */
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (prev & (1UL << irq))
 			continue;
 
@@ -1983,6 +1977,13 @@ void dept_hardirqs_off_ip(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_hardirqs_off_ip);
 
+void dept_kernel_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1990,7 +1991,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -2000,7 +2001,7 @@ void dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
-- 
2.17.1

