Return-Path: <linux-fsdevel+bounces-49343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C486CABB8AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 11:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15FED17161C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B789526F466;
	Mon, 19 May 2025 09:18:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E78C267391;
	Mon, 19 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747646330; cv=none; b=O7cn6uw873mY388ToW3ksPsMNs+/YfVDJyNBkcHJckw9SYxsoY1a2/arlFdvqrLegEaDz07NGekelESBG888Ijn2hoPZE2BwLEPrXhOcz9IJljCmeGDH7GONhYER2h5nient9rZHp8CzZYdpSgqLly/HopoZ8MfGgfkG9qO/H40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747646330; c=relaxed/simple;
	bh=XPhndR0BcCicw1+tO0GozjV4Ce2hwqOtkLVx0kL8UdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WWoBVR8FVKe0lxOH5iWxGg8Xh2bCngwsj4Igo9oChImMnqAW77mP/vAdqMC/1ko8HIPl3cv/38DLc61HNof02TsdHk1rEkz/G5kOMXAgLtX9AbJdkt8hXd4Od1u93PxCqAiBYiQqee8Pv3PKeU9PMc+4rFLmxibps9JHN03lj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-76-682af76de6e3
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
Subject: [PATCH v16 11/42] dept: add a mechanism to refill the internal memory pools on running out
Date: Mon, 19 May 2025 18:17:55 +0900
Message-Id: <20250519091826.19752-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250519091826.19752-1-byungchul@sk.com>
References: <20250519091826.19752-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxjF97739t7baslNRb0iRlNimDgRROezZH4sWeIlC3HJYqJ2yWzk
	jjbSYoqAuJjA+IgDIU4HKNDaohZoC2JLNrZR0pUVQbOuQi1ISlVijFU+ErSdKOoKm/88+eWc
	nPP8cxhCdlOUwKi1JwSdVpkrpySkZHp5yxbtPymqtOe9SRB5cYaE5us2CnydVgS27lIMYc8+
	GI1OIXj9198ENNT5EJgeThDQPRBC4Gz7noKRR3Hgj8xSMFRXTUHZlesU3Hm2gCFYfx6D1Z4F
	982PSbh9rgVDQ5iCpoYyHDtPMMybLTSYSzbCZFsjDQsP02EoFBCBc3wzXDIEKeh1DpEw0DOJ
	YeS3ZgpCtnciuD0wSEK0di34fqwRQcdMCwXPomYCzJFZGoZdRgwDxlXQVR4rrHz+VgQ3a1wY
	Kq/ewOC/9zuCvjMPMNhtAQr6I1MYHPY6Al61ehBM1k7TUHF2noam0loE1RX1JJQHd8Drl7HP
	+hfpUHq5i4SONwG0dxdvM9gQ3z81S/DljiL+VeQuxTujRpK/1cLxvzZO0Hx53zjNG+0FvKMt
	hb/SG8a8aS4i4u2WHyjePnee5qum/Zif8XrpLxMPSz7NFnLVhYJu6+4jEpXbO0ge9+49GXqg
	RyWoM6MKiRmO3c49NfYR7/nWjAcvMsUmc2Nj80t6PLuBc9Q8FlUhCUOwgWXcqP4eWjRWsEe5
	EnNHjBmGZDdyd8zUoixlP+buD9X837mes3a5llgc08er+5eiMnYH57cayMVOjr0g5obfBPB/
	gTXcH21j5DkkNaIPLEim1hZqlOrc7amqYq36ZOrRPI0dxeZlPr2g6EFzvq/ciGWQfLm0y7lJ
	JRMpC/OLNW7EMYQ8XmpxfKiSSbOVxacEXd43uoJcId+N1jKkfLV0W7QoW8bmKE8IxwThuKB7
	72JGnFCCrskvfPdJXMbnZd9m5UxWTBzK21//RP+nIjEl0/325c4DSe2Kn0dCeo83IfjFFv9o
	6rDLFGSUP+UUfRZut/a4statmDcVrLF2r1RXJuc0ZSRes2kEjaIy/qAlbXzD5neOq8eWFRzZ
	ldm6bdUlU9YvvtX7JrovDu7xJIW/TjOwYsVHGXIyX6VMTyF0+cp/ASnhV1paAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHWe/ncZvmrEzT6GE+HhY6z/fMcbMbEw59Zs7XYe7StlY
	KU/lIiRKdcJPrivnLpO41kpxpRPlJOlpmEiNukh5uJh/3nvt/d7n/f7nw5GKm/RUTqOLEfU6
	lVbJyCjZhlXJC6O/+asXlbcsB8/gCQou37Iw0FhShMBSmkRAT80aeDnUi2Ck4SkJWZmNCK50
	vSGhtLYdgaPwCANNbydCs6efAWdmGgPJV28x8OzTKAFtF84SUGRbDx3SewrqzxQQkNXDQE5W
	MuGVDwQMS2YWpMRZ0F2YzcJoVxA42900VOc6aXC0zodLeW0MPHA4Kagt6yagqfwyA+2W3zTU
	1z6mYCjdDxozjDQU9xUw8GlIIkHy9LPwvNJEQK1pMlhTvK3HBn7R8MhYScCxa7cJaH51H0HF
	iU4CbBY3A9WeXgLstkwSftyoQdCd/pmFo6eGWchJSkeQdvQCBSltwTDy3bucOxgESflWCop/
	ulFoCLbkWRCu7u0ncYr9AP7hecFgx5CJwnUFAr6X/YbFKRWtLDbZYrG90B9ffdBD4CtfPTS2
	mU8y2Pb1LItTPzcTuM/lYjdO2yZbHSlqNXGiPjBkp0xd5XpM7XOFxrd35qJEVLIkFflwAr9U
	qOurIcaY4ecILS3D5Bj78jMEu/E9nYpkHMm7xwsvc1+hsWASHyEkSsVe5jiKnyU8k5gxW84v
	EzqcRvJf53ShyFr5l328fmta9d9TBR8sNBflUWeQzITGmZGvRhcXrdJogwMMUeoEnSY+IGJv
	tA15H0g6NJpRhgab1lQhnkPKCXKrY55aQaviDAnRVUjgSKWv3Gyfq1bII1UJB0X93nB9rFY0
	VCE/jlJOka/dKu5U8LtVMWKUKO4T9f9TgvOZmojKT7OT9icfzn9tOl1/pOLSFutMV9imjlZd
	wvnAd/ULP0as8IvNqeudwS2KU67bLu26G2a+HaiYd/x36cMuXeDTxTtWXrwTUBeTUVo2efPA
	Oc3I/HHhIU2d4+O/vN1uzC7R/pI15q/aEhnv27BiwciHpVHuBuee6za/2aKkvxvqwANPrErK
	oFYF+ZN6g+oPsQjb4DwDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

dept engine works in a constrained environment.  For example, dept
cannot make use of dynamic allocation e.g. kmalloc().  So dept has been
using static pools to keep memory chunks dept uses.

However, dept would barely work once any of the pools gets run out.  So
implemented a mechanism for the refill on the lack, using irq work and
workqueue that fits on the contrained environment.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c          | 108 +++++++++++++++++++++++++-----
 kernel/dependency/dept_internal.h |  19 ++++--
 kernel/dependency/dept_object.h   |  10 +--
 kernel/dependency/dept_proc.c     |   8 +--
 4 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index b4a39c81bbc1..ad443e063fdc 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -75,6 +75,9 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/irq_work.h>
+#include <linux/vmalloc.h>
 #include "dept_internal.h"
 
 static int dept_stop;
@@ -143,9 +146,11 @@ static inline struct dept_task *dept_task(void)
 		}							\
 	})
 
-#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO_ONCE(s...)	pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
  * DEPT internal engine should be cautious in using outside functions
@@ -268,6 +273,7 @@ static bool valid_key(struct dept_key *k)
 
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
+static struct dept_##id rpool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef OBJECT
@@ -276,14 +282,74 @@ struct dept_pool dept_pool[OBJECT_NR] = {
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
 #undef OBJECT
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
+		local_irq_disable();
+		arch_spin_lock(&dept_pool_spin);
+		need = !p->rpool;
+		arch_spin_unlock(&dept_pool_spin);
+		local_irq_enable();
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
+		local_irq_disable();
+		arch_spin_lock(&dept_pool_spin);
+		if (!p->rpool) {
+			p->rpool = rpool;
+			rpool = NULL;
+			atomic_add(sz, &p->acc_sz);
+		}
+		arch_spin_unlock(&dept_pool_spin);
+		local_irq_enable();
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
@@ -319,19 +385,31 @@ static void *from_pool(enum object_t t)
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
 
@@ -2956,8 +3034,8 @@ void __init dept_init(void)
 	pr_info("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD);
 	pr_info("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES);
 #define OBJECT(id, nr)							\
-	pr_info("... memory used by %s: %zu KB\n",			\
-	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	pr_info("... memory initially used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(spool_##id) + sizeof(rpool_##id)));
 	#include "dept_object.h"
 #undef OBJECT
 #define HASH(id, bits)							\
@@ -2965,6 +3043,6 @@ void __init dept_init(void)
 	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
 	#include "dept_hash.h"
 #undef HASH
-	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... total memory initially used by objects and hashs: %zu KB\n", B2KB(mem_total));
 	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index 6b39e5a2a830..b2a44632ee4d 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -23,9 +23,19 @@ struct dept_pool {
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
@@ -35,9 +45,10 @@ struct dept_pool {
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
 
 enum object_t {
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
index 97beaf397715..f28992834588 100644
--- a/kernel/dependency/dept_proc.c
+++ b/kernel/dependency/dept_proc.c
@@ -74,12 +74,10 @@ static int dept_stats_show(struct seq_file *m, void *v)
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


