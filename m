Return-Path: <linux-fsdevel+bounces-13710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A808731BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6DB1C243E0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 09:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3184D63114;
	Wed,  6 Mar 2024 08:55:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498D605D9;
	Wed,  6 Mar 2024 08:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715344; cv=none; b=WiKJPpNTgfXL4kDNhQ6UEgdkTQzt2/UmUsVnQmtY6mF9Av34cIp6fAKYJdivGY2XEU35l33PncOTyzxG4J60oiy35LSoLdZq5klLnb3F7n3X3AYi4xFOCHkrTrde4T6rhUH8Rq1w8aaQ95wjEwUkhhjWAQPFLN4AeW9DZ5cdrcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715344; c=relaxed/simple;
	bh=FoAZA+0jlnYhnPe3f+IjJ7FMJD3ZMq2wQkEX2mpeEjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dGOjVnEpI4lWWZNrZyZDU716e0tk6HntelMTZk1d4CXuf11OHuHottlIvocKF46jUtbdFcKV3y1/rS5IlvnOkOM7zj7GmdQpK1MGA68iQQa4TlIeI1keehhSIJWA7Ywy7qIp6g58MtNTxe+wowPDEBPXBGMbUy+X/pGo6+Xkel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-f8-65e82f7e0839
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
	42.hyeyoo@gmail.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	hdanton@sina.com,
	her0gyugyu@gmail.com
Subject: [PATCH v13 13/27] dept: Add a mechanism to refill the internal memory pools on running out
Date: Wed,  6 Mar 2024 17:54:59 +0900
Message-Id: <20240306085513.41482-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306085513.41482-1-byungchul@sk.com>
References: <20240306085513.41482-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUzMcRwHcN/fczdnv53STwydYZiePOxjy+M8/Gy0jH8w08391E0PXC5C
	7VLpQSlZRcW6ykmlh+v+EJUTUlo5VE5LS040V+nhbk7NuTL/fPba5+H914fBJXrSg1GEnxOU
	4bJQKSUiRMNzi9bFen8XfL784uBGmg9YJ5MJKKiqoMBYWY6gQh+HwdDLvfDBZkEw1f4Gh9xs
	IwLN50846Jv7EDSUXqHgvXkedFpHKWjNvkZBfHEVBW9/TGPQm5OFQbnuALRlFmFgsH8jIHeI
	gvzceMxZvmNg15bRoFWvgIHSPBqmP/tCa183CQ09a+H23V4K6htaCWh+NIDB+8cFFPRVOEho
	a24hwHgjnYSHI0UU/LBpcdBaR2l4ZyjEoDrBGXR14g8Jr9INGFwtqcGg8+MTBI3J/RjoKrop
	eG61YFCry8bh9/2XCAauD9OQmGanIT/uOoJriTkEJPRuhKlfBdT2zfxzyyjOJ9Se5xtshQT/
	uojj6/I+0XxCYw/NF+pUfG3pGr64fgjjNeNWkteVpVC8bjyL5lOHOzF+pKOD5ltuTRG8uTMX
	C/Q4KvKXC6GKKEHpvTVIFNLVlk+fMW678LXaRqhRnV8qcmE4dgM32GPG/7tP3Tpril3FmUz2
	Wbuyy7ja9EFyxjhrEXElHXtmPJ89yY1eKZ/tE+wK7sFUP52KGEbMbuIK7vj/i1zKlVcbZmNc
	nO2MkQxqxhJ2I9cer3Fa5NyZZDhzkgP9O1jIPSs1EZlIXIjmlCGJIjwqTKYI3eAVEh2uuOB1
	MiJMh5y/pI2ZPvYIjRsPNSGWQdK54u0u3wQJKYuKjA5rQhyDS13Fl3+bBYlYLou+KCgjTihV
	oUJkE1rEEFJ3sZ/tvFzCBsvOCacF4Yyg/D/FGBcPNdpWfy/ZXfXCNbNmccTPLzuTzh7ZHWBv
	vOwW1xidovYclA4mXarzk//xC2pJWVk8sU4asBPl68f2v0vz/mnqfhrsiF1tPX6wxBGjD3P1
	7zDW3MwinmhYedCSwOUryX3Blosaz8TpLYagLtXRHf2m9Yczxra6TfTsOqaqXIu61KccC6RE
	ZIjMdw2ujJT9BTcn9k9HAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRyG+5+7o8VhGZ20MCYiKJmayi+LlKB2kIo+ZQWhQw860mmbl8wK
	c1rmNSu10mRempdZ2uxDN000L2toy1smKilmrpaStZFpFzX68vLwvvB8ehlcUkw6MQplgqBS
	ymOklIgQHdmj2XFx56zgfdOCoDDXG2zfswgoa2ygwPxAj6Dh0SUMLJ0yeGu3IljqfY1DSZEZ
	QcXkOA6PuiYQtNSmUzAwvQEGbfMUGItyKNBUNVLw5vMyBmPF1zHQGw6D6VolBm2LHwkosVBQ
	WqLBVmIWg0VdPQ26NDeYqr1Dw/KkDxgnhknouGskoWXUE26Xj1HwvMVIQNfjKQwGnpZRMNHw
	hwRTVw8B5sI8Eu7PVVLw2a7DQWebp6G/TYtBU8aK7fK33yR057VhcLn6IQaD754haM16j4Gh
	YZiCDpsVg2ZDEQ4/azoRTOV/oSEzd5GG0kv5CHIyiwnIGPOHpR9lVHAg32Gdx/mM5mS+xa4l
	+FeVHP/kzjjNZ7SO0rzWkMg313rwVc8tGF+xYCN5Q/1VijcsXKf57C+DGD/X10fzPbeWCH56
	sAQ76nxStDdSiFEkCaqd+8JF0UOmUjreHHT2Q5OdSENPfLORA8OxftxEmhFfZYp150ZGFtfY
	kd3ONefNkKuMs1YRV913cJU3shHcfLp+rSdYN65u6T2djRhGzAZwZXf3/lO6cPqmtjWNw0pd
	MFdArbKE9ed6NRXUNSTSonX1yFGhTIqVK2L8vdSno1OUirNeEXGxBrTyFt2F5cLH6PuArB2x
	DJKuFwc7fBQkpDxJnRLbjjgGlzqKz/+cFiTiSHnKOUEVF6ZKjBHU7ciZIaSbxSGhQriEjZIn
	CKcFIV5Q/V8xxsEpDV2cqh3Ktx6YHmnStG4zheo6UjdZAriQ4KPF8cfNnppjlq81yeujZnbT
	n5R1sq0vEvb7HiuXfXU/tfXdFY6o6EuV2INQvueZsRPDbl7OUVW3F4bwwl1RCTmwpdf1QqDe
	6HpjtupezyHaL/1H/69u3OOlyVs2PqwNS4z1S3LxnSGkhDpa7uOBq9Tyv2POYkEpAwAA
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


