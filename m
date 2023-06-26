Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87EC73DFD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFZMu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjFZMt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:49:58 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D37930E5;
        Mon, 26 Jun 2023 05:48:41 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-7c-64997d6c014a
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
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 14/25] dept: Add a mechanism to refill the internal memory pools on running out
Date:   Mon, 26 Jun 2023 20:56:49 +0900
Message-Id: <20230626115700.13873-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQH8D3PfWsrXW7q21UWdU2YiUZERXOcBl1MtueLidNP6sxW7VWq
        ULRVFBMnCqgDETDBKjYOCqu1VMGCEYTWWpC3KqIQxKYQwGWIUjFoka6drkD8cvLLOf/8Px0J
        pbjPzJdotIdFnVaVpGRltMwfZVqWfOKKOi4QmgEF5+Mg8OEcDcYKGwsdt8oR2KpPYRh++BM8
        Hx9BEHr8hAJDYQeCkoFeCqqb+hA4LKdZ6Pz7a+gKjLLQWpjDQkZpBQtP34Qx+C5dxFBu3wye
        fBMGV3CIBsMwC1cNGTgyXmEImq0cmNNjYNBSxEF4YAW09nUz4PAuhSvXfCzUO1ppaKoZxNB5
        z8hCn+0zA56mFho6CnIZuPnWxMKbcTMF5sAoB89cxRgqMyNFr8MODGfef2KgOdcVUdltDF0v
        6hA4z/VjsNu6WWgIjGCoshdS8O/1hwgGL/g5yDof5ODqqQsIcrIu0fDkv2YGMn2rITRhZDeu
        Iw0joxTJrDpKHOPFNGkzCaS2qJcjmU4vR4rtR0iVZQkprR/GpGQswBC79Q+W2McuciTb34WJ
        r7ueJW/b2znScjlEb/lmh2y9WkzSpIq65Qm/yRKNWW34oHXjsZcvXEw6ylmVjaQSgY8X2mtb
        6S/Ot93lJs3yi4WeniA16Vn8IqEq9x8mG8kkFF86QxhqaZwKzeT3CL32Xjxpmo8Rnn9smLKc
        XyMM97/C06ULhfJK11SRNLKve2RCk1bwq4XTPjc7nTFIhcKM9dOeJzyw9ND5SF6MvrIihUab
        mqzSJMXHJqZpNcdi96Qk21Hkrcwnwjtr0FjHNjfiJUgZJY9bcFmtYFSp+rRkNxIklHKWfM6E
        Qa2Qq1Vpx0Vdyq+6I0mi3o2iJbRyrnzl+FG1gt+nOiweEMWDou7LFUuk89ORNQHtPaT17/au
        ++u98/fa0Lse/mTusyZj27abH248EO+M1cHE4kbpz04N2ZC3ryKv0fOL/tvZmwa+9/RzW0/+
        6Xdfi00z7Y+vH8qLGSpI6fRGnSlQbN9xVxEOlKjSQ82p0cq6suCP3nyPZdfa7dTZou9uVVfe
        qfkhYcBZJiijV+5W0vpE1YollE6v+h+VRP1PUgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSXUxTZxgHcN/3fJVqzUkheoJxM03IMpyIH+hjJIoXi0cS3bIb3S6Qak9o
        tVTT8iFGErRgFETBBAtaXWlJZVD5aP2WYtNCoSqIQkCwoIIREYSFWaSC04Lx5skvz//J/+oR
        EVIzFSlSadIErUaultFiUrxrs36VOrtMEetri4HiM7EQ+HCKBGOtjYaOmmoEtuvHMYw0b4ee
        qTEEM22PCTCUdCAof9VPwHXvAAJn5QkaOl8vhq7ABA2+kgIa9JZaGp6MzmLwXziPodq+Ex4W
        mTG4gsMkGEZouGTQ49B4iyForWLAmhMFg5UXGZh9tQZ8A90UeC77KHD2rYSyK34aGpw+Ery3
        BzF03jXSMGD7QsFDbysJHcWFFFwbN9MwOmUlwBqYYOCpy4ShLjfU9m7WieHkf/9T0FLoCqmi
        HkNX7z0EjadeYrDbumnwBMYwOOwlBHy62oxg8Ox7BvLOBBm4dPwsgoK8CyQ8/txCQa4/Dmam
        jXRCPO8ZmyD4XEcm75wykfwDM8ffudjP8LmNfQxvsqfzjspo3tIwgvnyyQDF26tO07x98jzD
        57/vwry/u4Hmx9vbGb61dIb8fflf4niFoFZlCNrVW5LFSmPeA3y4KuHIUK+LykEF6/JRmIhj
        13NFtlvMnGn2J+7ZsyAx5wh2BecofEPlI7GIYC0LueHWpvmjcHY/12/vx3Mm2Siu56Nn3hJ2
        Azfy8i3+VvojV13nmi8KC+3vPTKjOUvZOO6E300XIbEJLahCESpNRqpcpY6L0R1UZmlUR2L2
        H0q1o9DnWLNni2+jD53b3YgVIdkiSewPpQopJc/QZaW6ESciZBGSJdMGhVSikGcdFbSH9mrT
        1YLOjZaJSNlSSeJuIVnKpsjThIOCcFjQfk+xKCwyB6WNL+oxJkUW6701u8mhmysPNP8m0e9N
        yWz8d8+2P5LSw34Obiq1elPiF/yidKA2963JxuqGk7s8G/Yl1r5IUjVFHLOWy86tDf+7/vnw
        1ukdNRtLmyau1TZFd1Us1iYl6LW/bjT0aTK3Wobybd2f6yyZUS29d8KVrm2b7rff+OfPpwMm
        GalTytdEE1qd/CvFSdDjNQMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dept engine works in a constrained environment. For example, Dept cannot
make use of dynamic allocation e.g. kmalloc(). So Dept has been using
static pools to keep memory chunks Dept uses.

However, Dept would barely work once any of the pools gets run out. So
implemented a mechanism for the refill on the lack by any chance, using
irq work and workqueue that fits on the contrained environment.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h            |  19 ++++--
 kernel/dependency/dept.c        | 104 +++++++++++++++++++++++++++-----
 kernel/dependency/dept_object.h |  10 +--
 kernel/dependency/dept_proc.c   |   8 +--
 4 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index d9ca9dd50219..583e8fe2dd7b 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -336,9 +336,19 @@ struct dept_pool {
 	size_t				obj_sz;
 
 	/*
-	 * the number of the static array
+	 * the remaining number of the object in spool
 	 */
-	atomic_t			obj_nr;
+	int				obj_nr;
+
+	/*
+	 * the number of the object in spool
+	 */
+	int				tot_nr;
+
+	/*
+	 * accumulated amount of memory used by the object in byte
+	 */
+	atomic_t			acc_sz;
 
 	/*
 	 * offset of ->pool_node
@@ -348,9 +358,10 @@ struct dept_pool {
 	/*
 	 * pointer to the pool
 	 */
-	void				*spool;
+	void				*spool; /* static pool */
+	void				*rpool; /* reserved pool */
 	struct llist_head		boot_pool;
-	struct llist_head __percpu	*lpool;
+	struct llist_head __percpu	*lpool; /* local pool */
 };
 
 struct dept_ecxt_held {
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 6cf17f206b78..8454f0a14d67 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -74,6 +74,9 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/irq_work.h>
+#include <linux/vmalloc.h>
 #include "dept_internal.h"
 
 static int dept_stop;
@@ -122,10 +125,12 @@ static int dept_per_cpu_ready;
 			WARN(1, "DEPT_STOP: " s);			\
 	})
 
-#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO_ONCE(s...)	pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 static arch_spinlock_t stage_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
  * DEPT internal engine should be careful in using outside functions
@@ -264,6 +269,7 @@ static inline bool valid_key(struct dept_key *k)
 
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
+static struct dept_##id rpool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef  OBJECT
@@ -272,14 +278,70 @@ struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
-	.obj_nr = ATOMIC_INIT(nr),					\
+	.obj_nr = nr,							\
+	.tot_nr = nr,							\
+	.acc_sz = ATOMIC_INIT(sizeof(spool_##id) + sizeof(rpool_##id)), \
 	.node_off = offsetof(struct dept_##id, pool_node),		\
 	.spool = spool_##id,						\
+	.rpool = rpool_##id,						\
 	.lpool = &lpool_##id, },
 	#include "dept_object.h"
 #undef  OBJECT
 };
 
+static void dept_wq_work_fn(struct work_struct *work)
+{
+	int i;
+
+	for (i = 0; i < OBJECT_NR; i++) {
+		struct dept_pool *p = dept_pool + i;
+		int sz = p->tot_nr * p->obj_sz;
+		void *rpool;
+		bool need;
+
+		arch_spin_lock(&dept_pool_spin);
+		need = !p->rpool;
+		arch_spin_unlock(&dept_pool_spin);
+
+		if (!need)
+			continue;
+
+		rpool = vmalloc(sz);
+
+		if (!rpool) {
+			DEPT_STOP("Failed to extend internal resources.\n");
+			break;
+		}
+
+		arch_spin_lock(&dept_pool_spin);
+		if (!p->rpool) {
+			p->rpool = rpool;
+			rpool = NULL;
+			atomic_add(sz, &p->acc_sz);
+		}
+		arch_spin_unlock(&dept_pool_spin);
+
+		if (rpool)
+			vfree(rpool);
+		else
+			DEPT_INFO("Dept object(%s) just got refilled successfully.\n", p->name);
+	}
+}
+
+static DECLARE_WORK(dept_wq_work, dept_wq_work_fn);
+
+static void dept_irq_work_fn(struct irq_work *w)
+{
+	schedule_work(&dept_wq_work);
+}
+
+static DEFINE_IRQ_WORK(dept_irq_work, dept_irq_work_fn);
+
+static void request_rpool_refill(void)
+{
+	irq_work_queue(&dept_irq_work);
+}
+
 /*
  * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
  * enabled or not because NMI and other contexts in the same CPU never
@@ -315,19 +377,31 @@ static void *from_pool(enum object_t t)
 	/*
 	 * Try static pool.
 	 */
-	if (atomic_read(&p->obj_nr) > 0) {
-		int idx = atomic_dec_return(&p->obj_nr);
+	arch_spin_lock(&dept_pool_spin);
+
+	if (!p->obj_nr) {
+		p->spool = p->rpool;
+		p->obj_nr = p->rpool ? p->tot_nr : 0;
+		p->rpool = NULL;
+		request_rpool_refill();
+	}
+
+	if (p->obj_nr) {
+		void *ret;
+
+		p->obj_nr--;
+		ret = p->spool + (p->obj_nr * p->obj_sz);
+		arch_spin_unlock(&dept_pool_spin);
 
-		if (idx >= 0)
-			return p->spool + (idx * p->obj_sz);
+		return ret;
 	}
+	arch_spin_unlock(&dept_pool_spin);
 
-	DEPT_INFO_ONCE("---------------------------------------------\n"
-		"  Some of Dept internal resources are run out.\n"
-		"  Dept might still work if the resources get freed.\n"
-		"  However, the chances are Dept will suffer from\n"
-		"  the lack from now. Needs to extend the internal\n"
-		"  resource pools. Ask max.byungchul.park@gmail.com\n");
+	DEPT_INFO("------------------------------------------\n"
+		"  Dept object(%s) is run out.\n"
+		"  Dept is trying to refill the object.\n"
+		"  Nevertheless, if it fails, Dept will stop.\n",
+		p->name);
 	return NULL;
 }
 
@@ -3000,8 +3074,8 @@ void __init dept_init(void)
 	pr_info("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD);
 	pr_info("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES);
 #define OBJECT(id, nr)							\
-	pr_info("... memory used by %s: %zu KB\n",			\
-	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	pr_info("... memory initially used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(spool_##id) + sizeof(rpool_##id)));
 	#include "dept_object.h"
 #undef  OBJECT
 #define HASH(id, bits)							\
@@ -3009,6 +3083,6 @@ void __init dept_init(void)
 	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
 	#include "dept_hash.h"
 #undef  HASH
-	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... total memory initially used by objects and hashs: %zu KB\n", B2KB(mem_total));
 	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
 }
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
index 0b7eb16fe9fb..4f936adfa8ee 100644
--- a/kernel/dependency/dept_object.h
+++ b/kernel/dependency/dept_object.h
@@ -6,8 +6,8 @@
  * nr: # of the object that should be kept in the pool.
  */
 
-OBJECT(dep, 1024 * 8)
-OBJECT(class, 1024 * 8)
-OBJECT(stack, 1024 * 32)
-OBJECT(ecxt, 1024 * 16)
-OBJECT(wait, 1024 * 32)
+OBJECT(dep, 1024 * 4 * 2)
+OBJECT(class, 1024 * 4)
+OBJECT(stack, 1024 * 4 * 8)
+OBJECT(ecxt, 1024 * 4 * 2)
+OBJECT(wait, 1024 * 4 * 4)
diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
index 7d61dfbc5865..f07a512b203f 100644
--- a/kernel/dependency/dept_proc.c
+++ b/kernel/dependency/dept_proc.c
@@ -73,12 +73,10 @@ static int dept_stats_show(struct seq_file *m, void *v)
 {
 	int r;
 
-	seq_puts(m, "Availability in the static pools:\n\n");
+	seq_puts(m, "Accumulated amount of memory used by pools:\n\n");
 #define OBJECT(id, nr)							\
-	r = atomic_read(&dept_pool[OBJECT_##id].obj_nr);		\
-	if (r < 0)							\
-		r = 0;							\
-	seq_printf(m, "%s\t%d/%d(%d%%)\n", #id, r, nr, (r * 100) / (nr));
+	r = atomic_read(&dept_pool[OBJECT_##id].acc_sz);		\
+	seq_printf(m, "%s\t%d KB\n", #id, r / 1024);
 	#include "dept_object.h"
 #undef  OBJECT
 
-- 
2.17.1

