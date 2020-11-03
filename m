Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803002A46EA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 14:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbgKCNwP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 08:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbgKCNv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:51:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF19C0613D1;
        Tue,  3 Nov 2020 05:51:29 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604411485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=IS0H0PmYwF+g21mCG5Xo/19/WQ/0DRdzMedmtdA3coA=;
        b=HrIvto5PjENGZ2sJaNLHD5fU5x7ktTkUsQiiDyfOlfNVG6i2QfDeoLNWiuBZ8UuMqdNhX2
        fB4hQZYW9XLjZyQzXu32J97iL+4BOXERJUUmfYUCqJbELJ/WBmwK+DuqZ6BSQGoZXks/KC
        aDoQ57uSGJVq4g4B3MLZakzs1shvqXk/dnG4UwyHY3B13uTe41oYG3HvCVER6K38Ja+gJt
        7Usp+noPsRZGIC1+DKDd7s1qqy+Nv55wtBL5RImMxzkF+RjknCJjAvMn0ydLpnI8IyVMmU
        hhwOYGNoGIQLOU3q/1OXFTFUdc4C4oO5CKnfyMrPpfB98PwG0AkBsHS1Z2hGyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604411485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=IS0H0PmYwF+g21mCG5Xo/19/WQ/0DRdzMedmtdA3coA=;
        b=66P0BI0kspaCcqHZR5ZhOyEE21HuNZfhFXd12L2xM9Ri7Lmpu3Br/scECIFCm7xMgiFzUo
        sskAL7tUf7GfYKDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: [patch V4 24/37] sched: highmem: Store local kmaps in task struct
In-Reply-To: <20201103095859.038791330@linutronix.de>
Date:   Tue, 03 Nov 2020 14:51:24 +0100
Message-ID: <877dr235wj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of storing the map per CPU provide and use per task storage. That
prepares for local kmaps which are preemptible.

The context switch code is preparatory and not yet in use because
kmap_atomic() runs with preemption disabled. Will be made usable in the
next step.

The context switch logic is safe even when an interrupt happens after
clearing or before restoring the kmaps. The kmap index in task struct is
not modified so any nesting kmap in an interrupt will use unused indices
and on return the counter is the same as before.

Also add an assert into the return to user space code. Going back to user
space with an active kmap local is a nono.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: Use the version which actually compiles and works
V3: Handle the debug case correctly
---
 include/linux/highmem-internal.h |   10 +++
 include/linux/sched.h            |    9 +++
 kernel/entry/common.c            |    2 
 kernel/fork.c                    |    1 
 kernel/sched/core.c              |   18 +++++++
 mm/highmem.c                     |   99 +++++++++++++++++++++++++++++++++++----
 6 files changed, 129 insertions(+), 10 deletions(-)

--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -9,6 +9,16 @@
 void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot);
 void *__kmap_local_page_prot(struct page *page, pgprot_t prot);
 void kunmap_local_indexed(void *vaddr);
+void kmap_local_fork(struct task_struct *tsk);
+void __kmap_local_sched_out(void);
+void __kmap_local_sched_in(void);
+static inline void kmap_assert_nomap(void)
+{
+	DEBUG_LOCKS_WARN_ON(current->kmap_ctrl.idx);
+}
+#else
+static inline void kmap_local_fork(struct task_struct *tsk) { }
+static inline void kmap_assert_nomap(void) { }
 #endif
 
 #ifdef CONFIG_HIGHMEM
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <asm/kmap_size.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -629,6 +630,13 @@ struct wake_q_node {
 	struct wake_q_node *next;
 };
 
+struct kmap_ctrl {
+#ifdef CONFIG_KMAP_LOCAL
+	int				idx;
+	pte_t				pteval[KM_MAX_IDX];
+#endif
+};
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1294,6 +1302,7 @@ struct task_struct {
 	unsigned int			sequential_io;
 	unsigned int			sequential_io_avg;
 #endif
+	struct kmap_ctrl		kmap_ctrl;
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 	unsigned long			task_state_change;
 #endif
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -2,6 +2,7 @@
 
 #include <linux/context_tracking.h>
 #include <linux/entry-common.h>
+#include <linux/highmem.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
@@ -194,6 +195,7 @@ static void exit_to_user_mode_prepare(st
 
 	/* Ensure that the address limit is intact and no locks are held */
 	addr_limit_user_check();
+	kmap_assert_nomap();
 	lockdep_assert_irqs_disabled();
 	lockdep_sys_exit();
 }
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -930,6 +930,7 @@ static struct task_struct *dup_task_stru
 	account_kernel_stack(tsk, 1);
 
 	kcov_task_init(tsk);
+	kmap_local_fork(tsk);
 
 #ifdef CONFIG_FAULT_INJECTION
 	tsk->fail_nth = 0;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4053,6 +4053,22 @@ static inline void finish_lock_switch(st
 # define finish_arch_post_lock_switch()	do { } while (0)
 #endif
 
+static inline void kmap_local_sched_out(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_out();
+#endif
+}
+
+static inline void kmap_local_sched_in(void)
+{
+#ifdef CONFIG_KMAP_LOCAL
+	if (unlikely(current->kmap_ctrl.idx))
+		__kmap_local_sched_in();
+#endif
+}
+
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -4075,6 +4091,7 @@ prepare_task_switch(struct rq *rq, struc
 	perf_event_task_sched_out(prev, next);
 	rseq_preempt(prev);
 	fire_sched_out_preempt_notifiers(prev, next);
+	kmap_local_sched_out();
 	prepare_task(next);
 	prepare_arch_switch(next);
 }
@@ -4141,6 +4158,7 @@ static struct rq *finish_task_switch(str
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
 	kcov_finish_switch(current);
+	kmap_local_sched_in();
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -365,8 +365,6 @@ EXPORT_SYMBOL(kunmap_high);
 
 #include <asm/kmap_size.h>
 
-static DEFINE_PER_CPU(int, __kmap_local_idx);
-
 /*
  * With DEBUG_HIGHMEM the stack depth is doubled and every second
  * slot is unused which acts as a guard page
@@ -379,23 +377,21 @@ static DEFINE_PER_CPU(int, __kmap_local_
 
 static inline int kmap_local_idx_push(void)
 {
-	int idx = __this_cpu_add_return(__kmap_local_idx, KM_INCR) - 1;
-
 	WARN_ON_ONCE(in_irq() && !irqs_disabled());
-	BUG_ON(idx >= KM_MAX_IDX);
-	return idx;
+	current->kmap_ctrl.idx += KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx >= KM_MAX_IDX);
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline int kmap_local_idx(void)
 {
-	return __this_cpu_read(__kmap_local_idx) - 1;
+	return current->kmap_ctrl.idx - 1;
 }
 
 static inline void kmap_local_idx_pop(void)
 {
-	int idx = __this_cpu_sub_return(__kmap_local_idx, KM_INCR);
-
-	BUG_ON(idx < 0);
+	current->kmap_ctrl.idx -= KM_INCR;
+	BUG_ON(current->kmap_ctrl.idx < 0);
 }
 
 #ifndef arch_kmap_local_post_map
@@ -461,6 +457,7 @@ void *__kmap_local_pfn_prot(unsigned lon
 	pteval = pfn_pte(pfn, prot);
 	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
 	arch_kmap_local_post_map(vaddr, pteval);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = pteval;
 	preempt_enable();
 
 	return (void *)vaddr;
@@ -505,10 +502,92 @@ void kunmap_local_indexed(void *vaddr)
 	arch_kmap_local_pre_unmap(addr);
 	pte_clear(&init_mm, addr, kmap_pte - idx);
 	arch_kmap_local_post_unmap(addr);
+	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
 	kmap_local_idx_pop();
 	preempt_enable();
 }
 EXPORT_SYMBOL(kunmap_local_indexed);
+
+/*
+ * Invoked before switch_to(). This is safe even when during or after
+ * clearing the maps an interrupt which needs a kmap_local happens because
+ * the task::kmap_ctrl.idx is not modified by the unmapping code so a
+ * nested kmap_local will use the next unused index and restore the index
+ * on unmap. The already cleared kmaps of the outgoing task are irrelevant
+ * because the interrupt context does not know about them. The same applies
+ * when scheduling back in for an interrupt which happens before the
+ * restore is complete.
+ */
+void __kmap_local_sched_out(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Clear kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/*
+		 * This is a horrible hack for XTENSA to calculate the
+		 * coloured PTE index. Uses the PFN encoded into the pteval
+		 * and the map index calculation because the actual mapped
+		 * virtual address is not stored in task::kmap_ctrl.
+		 * For any sane architecture this is optimized out.
+		 */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		arch_kmap_local_pre_unmap(addr);
+		pte_clear(&init_mm, addr, kmap_pte - idx);
+		arch_kmap_local_post_unmap(addr);
+	}
+}
+
+void __kmap_local_sched_in(void)
+{
+	struct task_struct *tsk = current;
+	pte_t *kmap_pte = kmap_get_pte();
+	int i;
+
+	/* Restore kmaps */
+	for (i = 0; i < tsk->kmap_ctrl.idx; i++) {
+		pte_t pteval = tsk->kmap_ctrl.pteval[i];
+		unsigned long addr;
+		int idx;
+
+		/* With debug all even slots are unmapped and act as guard */
+		if (IS_ENABLED(CONFIG_DEBUG_HIGHMEM) && !(i & 0x01)) {
+			WARN_ON_ONCE(!pte_none(pteval));
+			continue;
+		}
+		if (WARN_ON_ONCE(pte_none(pteval)))
+			continue;
+
+		/* See comment in __kmap_local_sched_out() */
+		idx = arch_kmap_local_map_idx(i, pte_pfn(pteval));
+		addr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
+		set_pte_at(&init_mm, addr, kmap_pte - idx, pteval);
+		arch_kmap_local_post_map(addr, pteval);
+	}
+}
+
+void kmap_local_fork(struct task_struct *tsk)
+{
+	if (WARN_ON_ONCE(tsk->kmap_ctrl.idx))
+		memset(&tsk->kmap_ctrl, 0, sizeof(tsk->kmap_ctrl));
+}
+
 #endif
 
 #if defined(HASHED_PAGE_VIRTUAL)
