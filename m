Return-Path: <linux-fsdevel+bounces-6294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A47815710
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07CBB238BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B618A18E0F;
	Sat, 16 Dec 2023 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XEtPsaHY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771F14AAD
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9mNDldpW72dzzPm2XiWKIN1gnNsmgtyhmZKpYp8TNSQ=;
	b=XEtPsaHY4Dmh0NEcxeo6xv7f2ym7o2IfV8/+qvppIKvuW8rL7syDOpqeXnCtLUbRWy3ay9
	XUTcKSfr0H9Um73s8jIzA0dpG5SyaSVsv//HPpv6j5K8XxsJxUYi8LxxcHXGVIFo2kSSKH
	BrTDi66xvwaoqvzUoGgtuCKz5WtWL5I=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 50/50] Kill sched.h dependency on rcupdate.h
Date: Fri, 15 Dec 2023 22:35:51 -0500
Message-ID: <20231216033552.3553579-7-kent.overstreet@linux.dev>
In-Reply-To: <20231216033552.3553579-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216033552.3553579-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

by moving cond_resched_rcu() to rcupdate.h, we can kill another big
sched.h dependency.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/rcupdate.h | 11 +++++++++++
 include/linux/sched.h    | 13 +++----------
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f7206b2623c9..8ebfa57e0164 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1058,4 +1058,15 @@ extern int rcu_normal;
 
 DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 
+#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
+#define cond_resched_rcu()		\
+do {					\
+	rcu_read_unlock();		\
+	cond_resched();			\
+	rcu_read_lock();		\
+} while (0)
+#else
+#define cond_resched_rcu()
+#endif
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d528057c99e4..b781ac7e0a02 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -10,8 +10,11 @@
 #include <uapi/linux/sched.h>
 
 #include <asm/current.h>
+#include <linux/thread_info.h>
+#include <linux/preempt.h>
 
 #include <linux/irqflags_types.h>
+#include <linux/smp_types.h>
 #include <linux/pid_types.h>
 #include <linux/sem_types.h>
 #include <linux/shm.h>
@@ -22,7 +25,6 @@
 #include <linux/timer_types.h>
 #include <linux/seccomp_types.h>
 #include <linux/nodemask_types.h>
-#include <linux/rcupdate.h>
 #include <linux/refcount_types.h>
 #include <linux/resource.h>
 #include <linux/latencytop.h>
@@ -2058,15 +2060,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-static inline void cond_resched_rcu(void)
-{
-#if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
-	rcu_read_unlock();
-	cond_resched();
-	rcu_read_lock();
-#endif
-}
-
 #ifdef CONFIG_PREEMPT_DYNAMIC
 
 extern bool preempt_model_none(void);
-- 
2.43.0


