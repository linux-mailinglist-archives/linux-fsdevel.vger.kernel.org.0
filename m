Return-Path: <linux-fsdevel+bounces-48845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5719AAB519B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D2D3A4B19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AEF25E478;
	Tue, 13 May 2025 10:07:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C92512E0;
	Tue, 13 May 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130876; cv=none; b=DKeE9Upt9bigr9DGlt+XwaBJdVvTTzDjkcDFhQ0vt+Zfa0ZyWkblQpNE5tRkFpcLA4faT94E6QkAK2SjlYxkZ1ETqz7EbqCZj03TZdolehvMUlZeoN4cSv/qWjCmfyVRT23bX9aJEXQgOXDwhKu5MjxX41Cwh2POagiEgYZglRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130876; c=relaxed/simple;
	bh=4A9mulUq0DyLsLDdCQ4U5LwuKs+mN67d32ljZcRTlfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AdcUkDUt5EKHUA0S3W/IYgZiW3As06cAloaV/cL90WbLMwDxlB9b2wqe0ve0gsyIzxiRWQJw8yQoDnVLeyEDmcg6TYpRqZIehKmvI79TR8aKRXVtrGcBE6XDLtmTwCjlr+do1CM/rzjkoskbrmTeXvYKXbSA536ukfS7uE9hJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-6c-682319eefd7d
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
Subject: [PATCH v15 11/43] dept: add a mechanism to refill the internal memory pools on running out
Date: Tue, 13 May 2025 19:06:58 +0900
Message-Id: <20250513100730.12664-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2xLYRjHve85PaetdTmpmYOJrQyZuMxleQi2+eJ8EYKEkKCxM21snbTb
	mERsdDJsNWIaw3Ql3bJ2Np3EtdQ2tblMWe3CNoyx2qWyaWOso3X58uSX/z/5Pc+HR0hIGwRT
	hEpVOq9WyVNklJgUD4QY53kmz1AsdOhDwfstj4QLVRYKnFfNCCzXczC4H66BVl8/gp/PnhOg
	L3IiKH3fScB1RxcCW/lhCpo/hoLL66GgsegEBUcuV1Hwom8UQ8fZ0xjM1rXw1vSJhCeFRgx6
	NwXn9UdwYPRiGDFV0GDKjobu8mIaRt/HQmNXiwBsr+fCuZIOCu7aGklw3OzG0Hz7AgVdll8C
	eOJoIMGnmwrOUwUCqBw0UtDnMxFg8npoeGk3YHAYwqFaGxAeHR4TwKMCO4ajV65hcLXfQXAv
	7x0Gq6WFgjpvP4YaaxEBP8oeIujWDdCQmz9Cw/kcHYITuWdJ0HYshZ/fA5svfouFnEvVJFT6
	W1DCSs5SYkFcXb+H4LQ1+7gf3lcUZ/MZSO6xkeVuFXfSnPbea5ozWDO4mvIY7vJdN+ZKh7wC
	zlpxjOKsQ6dp7viAC3ODTU30+oit4hVJfIoyk1cvWLVTrGh/PoD3vkjYX/VFi7NR5eLjSCRk
	mSWss8kg+M+mc6Y/TDGz2ba2ESLIYUwkW1PwKZCLhQTTMp5tvdiOgsUEZhebXVBMB5lkotmv
	H404yBImjh08NUz/lU5nzdX2PyJRIPeXNZFBljJL2UKDmQxKWeakiO3zm/9dMZl9UN5GFiKJ
	AY2rQFKlKjNVrkxZMl+RpVLun78rLdWKAv9lOji67SYacm6sRYwQyUIkDe4ohVQgz9RkpdYi
	VkjIwiQ5NwKRJEmedYBXp+1QZ6Twmlo0VUjKJkkW+fYlSZnd8nR+D8/v5dX/WywUTclGOrWn
	zJbvdz2a1uzsQZvotC3inolZ450feutz8+zpnsfudRH5syJvf8ZjCcmhvOtNcufM6J772+f0
	RrzZvnn508T4sZHwacsSb+i7vDs3x8WrQuo0G+KHv8qGEp1kZnHGXOme8Kv2wtb60isl0rgv
	q39ZxkVFRYp6/GcW5B3SzYmSkRqFPDaGUGvkvwHIBvbIWwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzH+36fX3fH5XEaD2Y4a4yJQ3zM75n1nY3xD+YfPfJwl37YHZGN
	3bnL/KhWJpHSiV3tupS7RiFrteK0Uqojq1MxRF1GF6Vwx/zz2Wuv9/Z+//ORUSo7M0OmSzgq
	6RPEODWroBXb15gX+6bP0y5tH18G/qFzNOSWOlhovlOMwFFuwtBXFwUvh/sR/Gx8TkF2VjOC
	mz1dFJTXexFUFZ1hofVdKLT5B1lwZ11kwXyrlIWWz2MYOq9cwlDs3AZvbO9paMgowJDdx8L1
	bDMOnI8YRmx2DmzGcOgtyuFgrEcDbq+Hgdo8NwNVrxfBtRudLDyqctNQX9GLofVBLgtex28G
	Guqf0jCcPhOaM9MYKPEVsPB52EaBzT/IwYtqK4Z661QoswRaz377xcCTtGoMZ2/fxdDW8RDB
	43PdGJwODwu1/n4MLmcWBaOFdQh60wc4SEkd4eC6KR3BxZQrNFg6I+Hnj8By3pAGTPllNJSM
	e9DG9cRxw4FIbf8gRSyu42TU386SqmErTZ4VCKQyp4sjlsevOWJ1HiOuooXk1qM+TG5+9TPE
	aT/PEufXSxy5MNCGia+pidsxa69i7QEpTpck6Zesj1ZoO54P4CMtG0+UfrJgIypZfgHJZQK/
	QrBdszFBZvn5wqtXI1SQw/g5givtfcArZBTvmSC8zOtAwWAKHyMY03K4INN8uPDlXQEOspJf
	Kfgyv3H/SmcLxWXVf4vkAT9e2EQHWcVHChnWYjoDKawoxI7CdAlJ8aIuLjLCcFibnKA7ERGT
	GO9EgQ+ynRrLrEBDrVE1iJch9UTl0765WhUjJhmS42uQIKPUYUrT/YBSHhCTT0r6xH36Y3GS
	oQbNlNHqacqtu6VoFX9IPCodlqQjkv5/imXyGUZ0ryLGlyyqyvPS6yrxh8mX2yRXDlEYjB89
	saMKS7Ry2sGyVfLUrh/duT3fo9amxu73hsu9YxGVhRacb859u82Vstrd1L6OD72KY0/pTY12
	a/7Ojilyc8jmzE2NhV8iN+zfo5m0q7Gz+0xq6O0dKa0Np30LQloSt+gqH2iUS8RlatqgFTUL
	Kb1B/AN/tU/BPQMAAA==
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
index a936a8d831c5..fc1d9e8b28f9 100644
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
@@ -142,9 +145,11 @@ static inline struct dept_task *dept_task(void)
 		}							\
 	})
 
-#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO_ONCE(s...)	pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
  * DEPT internal engine should be careful in using outside functions
@@ -267,6 +272,7 @@ static bool valid_key(struct dept_key *k)
 
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
+static struct dept_##id rpool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef  OBJECT
@@ -275,14 +281,74 @@ struct dept_pool dept_pool[OBJECT_NR] = {
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
@@ -318,19 +384,31 @@ static void *from_pool(enum object_t t)
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
 
@@ -2957,8 +3035,8 @@ void __init dept_init(void)
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
@@ -2966,6 +3044,6 @@ void __init dept_init(void)
 	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
 	#include "dept_hash.h"
 #undef  HASH
-	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... total memory initially used by objects and hashs: %zu KB\n", B2KB(mem_total));
 	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index 187a9b21f744..80a7b90df37b 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -22,9 +22,19 @@ struct dept_pool {
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
@@ -34,9 +44,10 @@ struct dept_pool {
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


