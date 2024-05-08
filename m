Return-Path: <linux-fsdevel+bounces-19057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C2C8BFA51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 12:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC5401C211A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 10:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC9C84A23;
	Wed,  8 May 2024 10:03:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0807E0E8;
	Wed,  8 May 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162584; cv=none; b=X4/T4COmbHx8QNsRSyctGnFS8x94yPNLycSngTT49aROBt9zeFLuz7ScF7lBbpdFocAs046WN7WY1MT3Wtyd+LMf04FqDlu7ZisBRLfqv1dgPhlIzNm3AQFGOtbNi64jk+bGW+oAznXKR6RcPcVvP1AmV4ea8iZC2grSUKJNDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162584; c=relaxed/simple;
	bh=FoAZA+0jlnYhnPe3f+IjJ7FMJD3ZMq2wQkEX2mpeEjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=leEQAc+qyWQ4nvGUIWYtGYembmkYAxPMIupJzAUxfijsFRhdRh/K1PeKG+u6kvnyh33IHBjlUs1fLQujsdbEQf1UdNVSNN7qjVb4UElY7ZIGZWnGL069kINbpHx/1RcYvnTm6a5f/I5SP7A7EvDVrULKPiDJbqgPY5hXeQ6qVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-d85ff70000001748-a5-663b4a393331
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
Subject: [PATCH v14 09/28] dept: Add a mechanism to refill the internal memory pools on running out
Date: Wed,  8 May 2024 18:47:06 +0900
Message-Id: <20240508094726.35754-10-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240508094726.35754-1-byungchul@sk.com>
References: <20240508094726.35754-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0yTZxSH977flWrJZ0fks2Zquhmjy5go6kEXJ4nRd0tImMbE6JLRwMdo
	Viq2grJkBqUicosQsVtpDKAWAlWwNAsMSgoEJiNi1c6BlIudDhsLJGgbEdS1Xv45efI75zzn
	n8NTCgej5DW6Y5Jep9aqWBktm15a+0XitzsyNjr9O6CidCMEnxfRYGm2seC+3oTA5jiFwd+3
	F/4JBRAs3LpNganKjaD24RgFjv5xBM6G0yzcexQNnuAsCwNVJSwUXG5m4c7TRQzei5UYmuzJ
	MHi+DoNrfooGk5+FalMBDpcnGOatjRxY89eCr8HMweLDeBgYv8+A88Hn8NslLwudzgEa+tt8
	GO79YWFh3PaGgcH+mzS4K8oYuDZTx8LTkJUCa3CWg7uuGgwtxrCo8NlrBv4sc2EovHIDg2ek
	A0FX0SQGu+0+C73BAIZWexUFL+v7EPjKpzk4UzrPQfWpcgQlZy7SYPRugYUXFnZXIukNzFLE
	2HqcOEM1NPmrTiTt5jGOGLsecKTGnkNaGzaQy51+TGrnggyxN55jiX2ukiPF0x5MZoaGOHLz
	1wWaPPKYcIrykOyrdEmryZX0X+5MlWX+PVjNZbu/PvG4JUTno/ZNxSiKF4UE8d9RO/eBr/qn
	cIRZYZ04PDxPRThGWCO2lv3HRJgSAjLxytCeCH8spInV5zyoGPE8LawVOyf2RWK5sFWc6Jii
	3ylXi00trreaqHA+MjWDIqwQtogdBebwWVl45g0vml91v19YIXY3DNPnkbwGfdSIFBpdbpZa
	o02Iy8zTaU7EpR3JsqPwL1l/WTzchubc+3uQwCPVUrkrdnuGglHnGvKyepDIU6oYed/ZbRkK
	ebo672dJf+QHfY5WMvSglTytipVvCh1PVwg/qo9JP0lStqT/0MV8lDIf4d9Tv1cnrEozlpuW
	V2Y4krLBl0ZWrK+Pe/Jq18mRA1VFFsekVmk8yWsOmiuMsaVJbLRysiRU2NSsKk3Jiem+tVw/
	eGlsp/4b6/qk6MQkQ2xwyWeL61RDbUfhzqcF9Tc2X1AOr/HaticHStp3fzLtfdyrs8SXf9fN
	cPHZvb7RZSrakKmO30DpDer/Acsh+9JHAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRzGfd9zznuOo8VpCZ0USkYX6Kqh9S+7faneiu5EEUENPepwmmxm
	GiSaS9MystCV05iXlqmVTT9Uapji0ixbueymlmKZaArWLHNdXNGXhx/PA79Pj8CocjlfQRsT
	J+tjNDo1UbCK7SGpi1duCQkP+NU2B7LPBoDr62kW8m9VEHDcLEdQUZ2CYaBpE7wcG0Iw8eQp
	A6YcB4LCni4Gqu3dCOpKTxJo75sKTtcIgZacMwRSi28ReDboxtCZewFDuW0btJ4vwlA/3s+C
	aYCA2ZSKJ+MThnFrGQ/W5LnQW5rHg7snEFq6OzhoLGjhoO7NQrh8pZNAbV0LC/Y7vRja7+UT
	6K74zUGrvZkFR3YWBzeGiwgMjlkZsLpGeHheb8FQaZy0pX35xcHDrHoMaSW3MThf1yC4f/o9
	BltFB4FG1xCGKlsOAz+uNSHoPfeZh1Nnx3kwp5xDcOZULgvGzmCY+J5P1q+ijUMjDDVWHaN1
	YxaWPiqS6N28Lp4a77/hqcV2lFaVLqDFtQOYFo66OGoryyDUNnqBp5mfnZgOt7XxtPnSBEv7
	nCa80++AYnWYrNPGy/qlaw8rIl+0mvlYx7qED5VjbDK6uywTeQuSGCRdHejHHibifOnVq3HG
	wz6iv1SV9ZHzMCMOKaSSto0eni6GSuYMJ8pEgsCKc6Xad7s9tVJcLr2r6Wf/KWdL5ZX1fzXe
	k/3r/mHkYZUYLNWk5vHnkcKCvMqQjzYmPlqj1QUvMURFJsZoE5aEHom2ocm3WE+4s++gr+2b
	GpAoIPUUpYOEhKs4TbwhMboBSQKj9lE2pa8IVynDNInHZf2RQ/qjOtnQgPwEVj1DuWWffFgl
	Rmji5ChZjpX1/1csePsmo+SC3bHmn/rnK5KiUiKsuiRzZVI7Rd2xcenF1+d1fd/F3ItfGnAx
	Y1Fm6GXi1g3O++jnr6v2nbmnp0Dbkb7GuN4rb+P+k82PN/tvb9j74JlzWkkCdfe5RPtB9ahp
	6yzLJ2GUHHzw89sOL7tVhdNeBgWGmS7tfJsePNtiNTQdKNqgZg2RmsAFjN6g+QNJu8zoKQMA
	AA==
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


