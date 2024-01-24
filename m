Return-Path: <linux-fsdevel+bounces-8732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80983A8F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 13:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3FA1F24CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D008F65BBE;
	Wed, 24 Jan 2024 12:00:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5D362A06;
	Wed, 24 Jan 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097609; cv=none; b=NcktwhyhdESAPQfMaWtK7GLkY3WEM9K3e/VzMOUkxIDTG+I0krKz0qVOgA+kPy/NgtLvelwmBNFwwtLPpNUVvOjwxmcPPHFjIUefmYObvgnAa4SbSkBrgD3iTGaNa1aB6O6nzOqui8mQiFt18zWRh2ai3l1p8O3hbu1M3XVI1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097609; c=relaxed/simple;
	bh=nifTUInVysx7YljtcW2Qa4mywSC4rocnbBoHNOK15ls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cuGKyyVF5yCHo1Tu8qF7zEcF6YooSKTIgKYDCABuBMH0/oVjpul+kGtfJ1trmQFhZ1CQGOQ8Zxawl6cgYWaGVQDKvnoUWRF3tKspEYhSI3gWOjwY6nuoe/lmytknRQgILE2wv+HslGJhXWJEcL5vZYe/mnbz/CY5OioApx9g/Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f5-65b0fbb6d165
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
Subject: [PATCH v11 11/26] dept: Distinguish each syscall context from another
Date: Wed, 24 Jan 2024 20:59:22 +0900
Message-Id: <20240124115938.80132-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240124115938.80132-1-byungchul@sk.com>
References: <20240124115938.80132-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHe8/lPXN14rAKjwkZiwqMtIvFQ0QEfeh0M6lv9SEPecqhzpil
	GRSWc5XlTGvZxWRemGvOXDNM08Wy8tJyTR26RKVMSkkzrEk2s7zQl4cfz//3/D89MlJRRy+X
	qdSnJY1aTFRiOSUfXVS8viZgkzaUfgqBvOsbwP/zCgWFVVYMnkcVCKxPLhIw/Ho3dE+MIAi0
	vSOhwOBBUPyxj4QnTf0IHOZLGDoHF4PXP4ah1XANQ2ZpFYb2r1ME9N7OJ6DCfgBcN0oIcE5+
	oaBgGMP9gkxiZgwRMGmyMGDKWA0D5nsMTH3cCK39XTQ4etbB3aJeDA2OVgqaagcI6HxWiKHf
	+pcGV1MLBZ68HBoqv5Vg+DphIsHkH2Ogw2kkwKadKdL9mKahOcdJgK7sMQHe9/UInl/5QIDd
	2oXhpX+EgGq7gYTf5a8RDOhHGci6PsnA/Yt6BNeyblPw7k8zDdreLRD4VYh3bhNejoyRgrY6
	TXBMGCnhTQkv1N3rYwTt8x5GMNrPCNXmcKG0YZgQisf9tGC3XMWCfTyfEbJHvYTwze1mhJY7
	AUoY9BYQMaFH5NvjpERVqqSJ3BErj2/PaMCnWmPPtg+KGah+fzYKkvFcFP+i/A36z823blGz
	jLm1vM83Sc7yUm4lX53zmc5GchnJXV7Im7+34dlgCRfNu75Pzx1Q3Gpe7/tCzzLLbeVthnmH
	58L4CptzrihoZl95t2fOV3Bb+A+WXGbeyQziL2etmecQ/oXZR91ArBEtsCCFSp2aJKoSoyLi
	09WqsxHHk5PsaOahTOenjtaicc/hRsTJkHIRu9NSJSloMTUlPakR8TJSuZT1hTySFGycmH5O
	0iQf05xJlFIaUaiMUgazmybS4hTcSfG0lCBJpyTN/5SQBS3PQGGdkktvS2ivD1N1oRND3YGW
	zml51DL9ZvculJf7vix2KsZy7NND3U3/CP00vKXIZesKWVF56O2D5FfBHWyfJ9hji9lXnNxh
	cuh+BQwX1Ak1xu17Ni+M1lkZRQeOrs8fGmKX7BXLVml74kadbb2su7Iocm2udxt3MDQyzMEo
	qZR4cWM4qUkR/wEobJniTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz46zx8k8YmM3tGXiNvGJZv3nmak1DPNj9YxnOiq5U2Sz
	RT/kKLLqUKzCOdfpxx0buqPV+nGaupScVNIatS6HuptUqMw/7732fr8/778+LKEoogJYdcIp
	SZMgxilpGSmL3JK29slEpbR+0LkZcq+sB+9YFglFFWYanOVlCMyPz2MYqt8G73xuBBOvWwnQ
	5zsRlHzqIeBxQy8Cu/ECDe0D86HD66HBkX+ZhrS7FTS0DU9i6C64jqHMEgHN10ox1Ix/IUE/
	REOhPg1PyyCGcYOJAUPqKug33mJg8pMKHL2dFNTddlBg71oDN+9002CzO0hoeNqPof15EQ29
	5j8UNDc0keDMzabg0ddSGoZ9BgIMXg8Db2qKMVSmT69ljv6moDG7BkPmvSoMHe+rEbzI6sNg
	MXfSUOd1Y7Ba8gn49aAeQX/OCAMZV8YZKDyfg+ByRgEJrVONFKR3h8DEzyI6fItQ5/YQQrr1
	tGD3FZPCq1JeeHarhxHSX3QxQrElSbAag4S7tiEslPzwUoLFdIkWLD+uM4JupAMLX1taGKHp
	xgQpDHTocdSy/bKwI1KcOlnSrNsaI4ttS7XRiY6YM20DYiqq3qFDfizPbeAb8/LIGaa5QN7l
	Gidm2J9bwVuzP1M6JGMJ7uJc3vjtNT0TLOQi+eZvv2cPSG4Vn+P6Qs2wnNvIV+b/6/Dccr6s
	smZ2yG/af3Sza7av4EL4PtNV5hqSFaM5JuSvTkiOF9VxIcHa47EpCeozwYdPxFvQ9M8Yzk3m
	PkVj7dtqEcci5Tx5uKlCUlBisjYlvhbxLKH0l7uWlEsK+REx5aykORGtSYqTtLVoKUsqF8u3
	75ViFNxR8ZR0XJISJc3/FLN+AanogP9aeZjaFvDxT6DzYHR14eDUDXHjy+go/eix+026lZkt
	56ZUdqdRZTXNP2QejvCwMebI3SNhoxrdwQ+20OClJ1efbPiwKEzedMyhDlz3RpdUXh+61Wkr
	dzmy9u0qacU8Hz4Y4n64W4ryFd5bsOl7blWeTxW6Ry96Qt92Js7ZqSS1saIqiNBoxb+mShGM
	LwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It enters kernel mode on each syscall and each syscall handling should
be considered independently from the point of view of Dept. Otherwise,
Dept may wrongly track dependencies across different syscalls.

That might be a real dependency from user mode. However, now that Dept
just started to work, conservatively let Dept not track dependencies
across different syscalls.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 arch/arm64/kernel/syscall.c |  3 ++
 arch/x86/entry/common.c     |  4 +++
 include/linux/dept.h        | 39 ++++++++++++---------
 kernel/dependency/dept.c    | 67 +++++++++++++++++++------------------
 4 files changed, 64 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 9a70d9746b66..96c18ad1dbf7 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -7,6 +7,7 @@
 #include <linux/ptrace.h>
 #include <linux/randomize_kstack.h>
 #include <linux/syscalls.h>
+#include <linux/dept.h>
 
 #include <asm/debug-monitors.h>
 #include <asm/exception.h>
@@ -100,6 +101,8 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 * (Similarly for HVC and SMC elsewhere.)
 	 */
 
+	dept_kernel_enter();
+
 	if (flags & _TIF_MTE_ASYNC_FAULT) {
 		/*
 		 * Process the asynchronous tag check fault before the actual
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 6356060caaf3..445e70937b38 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -20,6 +20,7 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/init.h>
+#include <linux/dept.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -75,6 +76,7 @@ static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
 /* Returns true to return using SYSRET, or false to use IRET */
 __visible noinstr bool do_syscall_64(struct pt_regs *regs, int nr)
 {
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
@@ -262,6 +264,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
 	int nr = syscall_32_enter(regs);
 
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	/*
 	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
@@ -283,6 +286,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 	int nr = syscall_32_enter(regs);
 	int res;
 
+	dept_kernel_enter();
 	add_random_kstack_offset();
 	/*
 	 * This cannot use syscall_enter_from_user_mode() as it has to
diff --git a/include/linux/dept.h b/include/linux/dept.h
index c6e2291dd843..4e359f76ac3c 100644
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
 	 * for reserving a current stack instance at each operation
@@ -465,7 +470,7 @@ struct dept_task {
 	.wait_hist = { { .wait = NULL, } },			\
 	.ecxt_held_pos = 0,					\
 	.wait_hist_pos = 0,					\
-	.irq_id = { 0U },					\
+	.cxt_id = { 0U },					\
 	.wgen_enirq = { 0U },					\
 	.enirq_ip = { 0UL },					\
 	.stack = NULL,						\
@@ -503,6 +508,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_kernel_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -552,6 +558,7 @@ struct dept_task { };
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
+#define dept_kernel_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 19406093103e..9aba9eb22760 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -220,9 +220,9 @@ static struct dept_class *dep_tc(struct dept_dep *d)
 
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
@@ -406,7 +406,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -431,7 +431,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -447,7 +447,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -486,7 +486,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -502,7 +502,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -651,7 +651,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -684,7 +684,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -910,7 +910,7 @@ static void bfs(struct dept_class *c, bfs_f *cb, void *in, void **out)
  */
 
 static unsigned long cur_enirqf(void);
-static int cur_irq(void);
+static int cur_cxt(void);
 static unsigned int cur_ctxt_id(void);
 
 static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1458,7 +1458,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1494,7 +1494,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg = 0U;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1510,9 +1510,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
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
@@ -1593,7 +1593,7 @@ static bool add_ecxt(struct dept_map *m, struct dept_class *c,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1745,7 +1745,7 @@ static void do_event(struct dept_map *m, struct dept_class *c,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1787,7 +1787,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1812,27 +1812,21 @@ static unsigned long cur_enirqf(void)
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
@@ -1893,7 +1887,7 @@ static void dept_enirq(unsigned long ip)
 
 	flags = dept_enter();
 
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		dt->enirq_ip[irq] = ip;
 		enirq_transition(irq);
 	}
@@ -1939,6 +1933,13 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+void noinstr dept_kernel_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1946,7 +1947,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -1956,7 +1957,7 @@ void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
-- 
2.17.1


