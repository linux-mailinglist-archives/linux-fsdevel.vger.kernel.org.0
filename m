Return-Path: <linux-fsdevel+bounces-12237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED6F85D49B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 10:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4C11C230AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 09:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4054D11B;
	Wed, 21 Feb 2024 09:50:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044BB41235;
	Wed, 21 Feb 2024 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509003; cv=none; b=Pn/jxIPfpM03D9ws4hu0uP2un9oZK3fmmZ+IbCF3XH2w1An7FvVWrSYeA6lxX5ffLA52B7sgoLvRaJf42Gh/pcIdvws4bR2J5q/du9h5Z5VlIxyksN9rwan5W2nFWUwXLS2X3/n7MAq6qiryQkubwktgftN7rNuRdMaenxHjAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509003; c=relaxed/simple;
	bh=FoAZA+0jlnYhnPe3f+IjJ7FMJD3ZMq2wQkEX2mpeEjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Y6ayxPL3UwwG8lNwwqI+Mx8HL48oSNr5HE7Ljf3duC2M/OWTuZw2riVrhzAFs7i+Z1aFv9DD2fawZ4kWM0OmRI8lXEl21WE+fDztay/O1zCLU7XbMiM6KpwuSQ1DDVdS39MPhhaH8QjJbTPZuKse3Jpx5a5jPPFWARUJnlrcaNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-58-65d5c73972c1
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
Subject: [PATCH v12 13/27] dept: Add a mechanism to refill the internal memory pools on running out
Date: Wed, 21 Feb 2024 18:49:19 +0900
Message-Id: <20240221094933.36348-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240221094933.36348-1-byungchul@sk.com>
References: <20240221094933.36348-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xTZxgHcN/3XKnWnHQuHjVB0kRJ0DkgXp4Qon7zLI4wY4gJZpfGnkil
	gLbIRWMCUm/lEiGBqgVTy1Iq1ImtOHAWGUSQEbDMg0NDieAFkUIN0MYKG2tx+/Lkl///yfPp
	YQlFG7We1WTnirpslVZJy0jZ9CrrV0k9Q2L8hVE5VJbFQ2D+Igm1tx00eH5pQuC4W4xh8tE+
	+CvoQ7DQ/4QAU7UHwY0xLwF3u0cRuO1naXj6ejVIAT8NvdWlNJTU36ZhcGoRw0hNFYYmZwr0
	XbZi6AhNkGCapMFsKsHh8Q5DyNbIgK1oE4zbrzGwOJYAvaPPKHC/2AJXr4/Q8MDdS0J36ziG
	p/draRh1LFHQ1/2YBE9lOQW3Zqw0TAVtBNgCfgb+7LBgaDaED52f+4eCnvIODOd/voNBev4b
	gvaLLzE4Hc9o6Ar4MLic1QR8aniEYLximoFzZSEGzMUVCErP1ZDw5O8eCgwjO2DhYy29N0no
	8vkJweDKF9xBCyn8YeWFtmteRjC0v2AEi/Ok4LLHCfUPJrFwYzZACc7GS7TgnK1iBOO0hIWZ
	gQFGeHxlgRReSyb83YZ0WbJa1GryRN3Xu3+SZQz1mZnjnj0Fb5qDZBFqSzSiKJbntvMf/BJh
	ROyyP1YmRGKai+WHh0NExGu4GN5V/pYyIhlLcBdW8vYP/XSk+II7wocGp1DEJLeJdyx5yYjl
	3E6+3FxCfL6/kW9q7lh2VDi/afZRESu4HfzQYMt/O6VRvN9Ff/Y6/nf7MHkZyS1oRSNSaLLz
	slQa7fZtGYXZmoJtR3KynCj8ULYzi4db0aznYCfiWKRcJc/4VRIVlCpPX5jViXiWUK6Rk/nh
	SK5WFZ4SdTk/6k5qRX0n2sCSyrXyxGC+WsEdVeWKmaJ4XNT932I2an0ROnDYUHNl5+z+51K0
	1HJqf/Tc1pSl1Lq56jTjfMOxMWPu2fkTL732tFt1V5di29WOCsnnv/SpJn6GN325Z74yOUm/
	b/D7uBO9qepvGjZbXumtmdEPvQ3vi6d2pXe1HazH32YWGmNT16omrIk/pMnStadjlIrkiZv3
	CuoS+ze6DzFlSlKfoUqII3R61b9orYCFTAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwH8L6/546z39LmJ4+7IaIS4mMsZqPfzOMaNg/jpt90qy7u0tNm
	SiGXrCLRXZzYSR2Xi1USqfVwtVK6EqskeWiVku50deTO5p/PXnu/9/n89WFwNw3pwcjkkYJC
	Lg2TUCJCtGtDovf62jZhpT1nFaRfXgmWsWQCNAY9Bc2PChDonyRg0F8dCG+tgwgmG1/jkJXZ
	jODOxy4cntR0IyjPO0dBa98MMFuGKTBlplCQeNdAQcuAHYPO6xkYFBh3QkNaLgYVtq8EZPVT
	oM5KxBzjGwY2XT4NuvjF0JuXTYP9ox+YuttJqMoxkVD+fjncvNVJwfNyEwE1Jb0YtD7TUNCt
	nyKhoaaOgOb0VBIefs+lYMCqw0FnGabhTYUWg8Ikx7ULP/+QUJtagcGFe48xML8rQ/AiuQcD
	o76dgirLIAZFxkwcJu5XI+i9MkTD+cs2GtQJVxCknL9OwOvftSQkdfrD5LiG2ryBrxocxvmk
	omi+3Kol+Ppcji/N7qL5pBfvaV5rPM0X5Xnxd5/3Y/ydUQvJG/MvUbxxNIPmVUNmjP/e1ETz
	dTcmCb7PnIXtmXtQtDFYCJNFCQrfgGOikLYGNX2yeVPM50IrEY9KV6kQw3DsGm483U+FXBmK
	9eQ6Omy40+7sQq4o9QupQiIGZy9O4/JGGilnMZM9ztlaBpDTBLuY0091EU6L2bVcqjrx3zLH
	LuAKCiv+2dWRP1APkk67sf5cW8tTPA2JtMglH7nL5FHhUlmYv48yNCRWLovxOR4RbkSOn9Gd
	saeXoLHWwErEMkgyXRxSbBbcSGmUMja8EnEMLnEXE9GOSBwsjY0TFBFHFafDBGUlmsMQklni
	7QeEY27sCWmkECoIJwXF/xZjXD3iUcCRdcmjTRGLEs7Ux7m8M6Tl90RqdowcySj2ORj46cfs
	jl19U0MBLxuCXVQJkwGr5e2fPcMn0N7dHfbeoMdRrd5ltUE9W/FXV21eZ0v3R89beMpjRc1S
	zbJ61Hh43/QllW99t22bn2JijIfmX9oyenvBToU223ot50PuLZl3mcHwS58tIZQhUj8vXKGU
	/gXrGl4dLwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

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
index 319a5b43df89..ca1a34be4127 100644
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
index a8e693fd590f..8ca46ad98e10 100644
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
@@ -122,9 +125,11 @@ static int dept_per_cpu_ready;
 			WARN(1, "DEPT_STOP: " s);			\
 	})
 
-#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO_ONCE(s...)	pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
  * DEPT internal engine should be careful in using outside functions
@@ -263,6 +268,7 @@ static bool valid_key(struct dept_key *k)
 
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
+static struct dept_##id rpool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef  OBJECT
@@ -271,14 +277,70 @@ struct dept_pool dept_pool[OBJECT_NR] = {
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
@@ -314,19 +376,31 @@ static void *from_pool(enum object_t t)
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
 
@@ -2957,8 +3031,8 @@ void __init dept_init(void)
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
@@ -2966,6 +3040,6 @@ void __init dept_init(void)
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


