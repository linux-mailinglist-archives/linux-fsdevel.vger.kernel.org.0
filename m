Return-Path: <linux-fsdevel+bounces-48871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67FAB5253
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048C2188D23F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0328DF54;
	Tue, 13 May 2025 10:08:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E16528853E;
	Tue, 13 May 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130896; cv=none; b=iMYdP5okT4K8CdDYTaKSZ5jm1pigRuIB8zNXM+3dgtqa0ubnzu6wfYP6AgnPs9x6bgbCrvd25o9eSbybkgl2rvrf8d7RQXthrj1isBWh3rZBXUzz6cLLxla7qKQYiDPIn/EJMsDTON8GeHGqF+lKmp4ifvVRgR14nzgRXIVh3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130896; c=relaxed/simple;
	bh=YrWBIIAMqnF09k3CiHle1jkWmEk31GBWH5LYnj+OH1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jVf6wMpqxzyZ5kwLTYhV/8FvfNMftX6nnRsZFuxLm3P3dFvl6UTqo+eo9RLJvgPenJFesJgMPkCKNMbkJjcO7H/eMrHpkd0pmaNbfrbOM6c9ycYHbP/lxwz6ro8v/fQrtuOnw6JQNgjIJpdLwUBEYMgC/p7wLg584aBCxzeJrag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-0e-682319f279ba
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
Subject: [PATCH v15 37/43] dept: assign unique dept_key to each distinct wait_for_completion() caller
Date: Tue, 13 May 2025 19:07:24 +0900
Message-Id: <20250513100730.12664-38-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG+b/XUq2+6by8BZNpBzHTeCkBPTGKuuzy/zCTZUuWBRJnI+9s
	Y6nkRRBMNFSqMhCGOCSKuAKu3MrAoihISQWpIIooiKC0XGIaG0C00m4IMgvGLydPnvM7zzkf
	joSUt9MhEq3+sCDq1TolI6WkE4uLN3gVX2g217giwTeVQcGlGgsD3f9UIbBcMxDgafsOnvrH
	Ecw8eEhCQX43guIRJwnXHC4EtvITDPS8WAK9vkkGOvKzGEgvrWHg0dgsAYPn8wiosu6BIbOb
	gs7cEgIKPAwUFqQTgfKSgGlzJQvmtHAYLb/IwuyICjpcfTTYnq2HC5cHGWiydVDguDlKQE/j
	JQZclv9p6HS0U+DPCYXus9k0VL8qYWDMbybB7Jtk4bHdRIDDtAJqjYHAU2/naLibbSfg1JWr
	BPQO3ELQnDFMgNXSx0Crb5yAOms+Ce/K2hCM5kywcPLMNAuFhhwEWSfPU2AcjIKZ/wKbi6ZU
	YPirloLq931o1w5suWxBuHV8ksTGuiP4ne8Jg21+E4XvlfC44aKTxcbmZyw2WZNwXfk6XNrk
	IXCx10dja+XvDLZ681icOdFL4FddXewPq2Kk2+MEnTZZEDdF75Nq2p/fIhIM+hRj+j0qDf0R
	k4mCJTwXyQ+Nj7GftKHhLJrXDLeW7++fJuf1Mm41X5ftpjORVEJyfYv4p0UDC9BnnMC/vlC6
	AFFcON/sHaHmtYzbwjsDV30M/ZyvqrUvMMEB/31Z1wIj56L4XFMVNR/Kc+eC+XpbOvo4oOBv
	l/dTuUhmQkGVSK7VJ8ertbrIjZpUvTZl4/5D8VYU+C/zsdnYm8jb/VML4iRIuVjW7lmjkdPq
	5MTU+BbES0jlMpnhRsCSxalTjwrioV/FJJ2Q2IJCJZRypSzCfyROzh1QHxYOCkKCIH7qEpLg
	kDS0vP56hCPi3Oa1+1LdvUt2rt7wlU4R8nO+O7pNWbG0VQxzR9M/LvWI99/83WmY29vwTUbB
	yKpv99/BqsKyKxE3tLH2qw1dFad37al27pXO/qYPb5rKExWKoCB70daaP13bvo+ubFxjd+qH
	ooaj6uv/bfzyTSET9jpL1Xh8t4yc+foXmZJK1KhV60gxUf0BoHiyA1sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+35/T9dx9pPGr0IczWOI4uOp2Wz8MGYzbMw4+s3dXMfulGK2
	TpdRSjXV0oOruFpdyh2Th0urOZ0m0blEnWq0Wqmka3rClfnns/fen9fen/cfHxHhVUz5ihSq
	84JaJVNKaTEp3rc5NnDQZ5F8TZ7TF1xD10jILjPS0HC/BIHxoRZD98ud0DTci2DszVsCMtIa
	EOS1txLw0OpEYCm6QkPj1xlgd/XTYEtLoCG2oIyGdz3jGFrSUzGUmPbCF0MnCXXJ+RgyumnI
	yojF7tGFYcRQzIAhJgA6im4zMN4eBDang4KaHBsFlk8rIDO3hYbnFhsJ1ooODI1Ps2lwGv9Q
	UGetJWE4yQ8aUhIpKO3Lp6Fn2ECAwdXPwPsqPQarfjaU69ypV3/+puBVYhWGq3cfYLA3P0NQ
	ea0Ng8nooKHG1YvBbEojYLTwJYKOpO8MxN0YYSBLm4QgIS6dBF1LCIz9cl/OGQoC7Z1yEkon
	HGhbKG/MNSK+pref4HXmC/yo6wPNW4b1JP86n+Of3G5leF3lJ4bXmyJ4c9FyvuB5N+bzBl0U
	byq+TvOmwVSGj/9ux3xffT2zf94R8ZYwQamIFNSrQ0+I5bWfn+FzWlWULvY1GYNuHolHniKO
	Dea0T1LQpKbZJdzHjyPEpPZmF3DmxE4qHolFBOuYxjXlNE9Bs1iBG8gsmIJINoCrHGwnJ7WE
	Xc+1upv8C/XnSsqrphhPtz9RWD/FeLEhXLK+hExGYj3yKEbeClVkuEyhDFmlOSOPVimiVp06
	G25C7g8yXB5PqUBDjTurEStC0umS2u6Fci9KFqmJDq9GnIiQeku0j92WJEwWfVFQnz2ujlAK
	mmrkJyKlcyS7DwsnvNjTsvPCGUE4J6j/b7HI0zcGfcAVeV1d6dKb2TsOFgXOWbzG24YPYPbW
	wMVvyzYOfLV45I4cOzp/5aJ7Pk7HunsHvwQc2nMyoa62L9//8tz3E37W4PKUXR7z5870N0/T
	vgi19fxoptcG+B5rCA/8nJVkX+1n317Wf4nesDT11o0IeRVs8omKU9YkhBnaOMujtqbcrVJS
	I5cFLSfUGtlfXiXIoT0DAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

wait_for_completion() can be used at various points in the code and it's
very hard to distinguish wait_for_completion()s between different usages.
Using a single dept_key for all the wait_for_completion()s could trigger
false positive reports.

Assign unique dept_key to each distinct wait_for_completion() caller to
avoid false positive reports.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
 kernel/sched/completion.c  |  60 +++++++++++-----------
 2 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 3200b741de28..4d8fb1d95c0a 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -27,12 +27,10 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
-	struct dept_map dmap;
 };
 
 #define init_completion(x)				\
 do {							\
-	sdt_map_init(&(x)->dmap);			\
 	__init_completion(x);				\
 } while (0)
 
@@ -43,17 +41,14 @@ do {							\
 
 static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
 {
-	sdt_might_sleep_end();
 }
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
-	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -119,18 +114,18 @@ static inline void reinit_completion(struct completion *x)
 	x->done = 0;
 }
 
-extern void wait_for_completion(struct completion *);
-extern void wait_for_completion_io(struct completion *);
-extern int wait_for_completion_interruptible(struct completion *x);
-extern int wait_for_completion_killable(struct completion *x);
-extern int wait_for_completion_state(struct completion *x, unsigned int state);
-extern unsigned long wait_for_completion_timeout(struct completion *x,
+extern void __wait_for_completion(struct completion *);
+extern void __wait_for_completion_io(struct completion *);
+extern int __wait_for_completion_interruptible(struct completion *x);
+extern int __wait_for_completion_killable(struct completion *x);
+extern int __wait_for_completion_state(struct completion *x, unsigned int state);
+extern unsigned long __wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
-extern unsigned long wait_for_completion_io_timeout(struct completion *x,
+extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
 						    unsigned long timeout);
-extern long wait_for_completion_interruptible_timeout(
+extern long __wait_for_completion_interruptible_timeout(
 	struct completion *x, unsigned long timeout);
-extern long wait_for_completion_killable_timeout(
+extern long __wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
@@ -139,4 +134,79 @@ extern void complete(struct completion *);
 extern void complete_on_current_cpu(struct completion *x);
 extern void complete_all(struct completion *);
 
+#define wait_for_completion(x)						\
+({									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__wait_for_completion(x);					\
+	sdt_might_sleep_end();						\
+})
+#define wait_for_completion_io(x)					\
+({									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__wait_for_completion_io(x);					\
+	sdt_might_sleep_end();						\
+})
+#define wait_for_completion_interruptible(x)				\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_interruptible(x);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_killable(x)					\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_killable(x);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_state(x, s)					\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_state(x, s);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_timeout(x, t)				\
+({									\
+	unsigned long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_timeout(x, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_io_timeout(x, t)				\
+({									\
+	unsigned long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_io_timeout(x, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_interruptible_timeout(x, t)			\
+({									\
+	long __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_interruptible_timeout(x, t);	\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_killable_timeout(x, t)			\
+({									\
+	long __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_killable_timeout(x, t);		\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
 #endif
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 499b1fee9dc1..247169b26d81 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -4,7 +4,7 @@
  * Generic wait-for-completion handler;
  *
  * It differs from semaphores in that their default case is the opposite,
- * wait_for_completion default blocks whereas semaphore default non-block. The
+ * __wait_for_completion default blocks whereas semaphore default non-block. The
  * interface also makes it easy to 'complete' multiple waiting threads,
  * something which isn't entirely natural for semaphores.
  *
@@ -37,7 +37,7 @@ void complete_on_current_cpu(struct completion *x)
  * This will wake up a single thread waiting on this completion. Threads will be
  * awakened in the same order in which they were queued.
  *
- * See also complete_all(), wait_for_completion() and related routines.
+ * See also complete_all(), __wait_for_completion() and related routines.
  *
  * If this function wakes up a task, it executes a full memory barrier before
  * accessing the task state.
@@ -134,23 +134,23 @@ wait_for_common_io(struct completion *x, long timeout, int state)
 }
 
 /**
- * wait_for_completion: - waits for completion of a task
+ * __wait_for_completion: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout.
  *
- * See also similar routines (i.e. wait_for_completion_timeout()) with timeout
+ * See also similar routines (i.e. __wait_for_completion_timeout()) with timeout
  * and interrupt capability. Also see complete().
  */
-void __sched wait_for_completion(struct completion *x)
+void __sched __wait_for_completion(struct completion *x)
 {
 	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(__wait_for_completion);
 
 /**
- * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
+ * __wait_for_completion_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -162,28 +162,28 @@ EXPORT_SYMBOL(wait_for_completion);
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_timeout(struct completion *x, unsigned long timeout)
+__wait_for_completion_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_timeout);
+EXPORT_SYMBOL(__wait_for_completion_timeout);
 
 /**
- * wait_for_completion_io: - waits for completion of a task
+ * __wait_for_completion_io: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout. The caller is accounted as waiting
  * for IO (which traditionally means blkio only).
  */
-void __sched wait_for_completion_io(struct completion *x)
+void __sched __wait_for_completion_io(struct completion *x)
 {
 	wait_for_common_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io);
+EXPORT_SYMBOL(__wait_for_completion_io);
 
 /**
- * wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
+ * __wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -196,14 +196,14 @@ EXPORT_SYMBOL(wait_for_completion_io);
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
+__wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common_io(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io_timeout);
+EXPORT_SYMBOL(__wait_for_completion_io_timeout);
 
 /**
- * wait_for_completion_interruptible: - waits for completion of a task (w/intr)
+ * __wait_for_completion_interruptible: - waits for completion of a task (w/intr)
  * @x:  holds the state of this particular completion
  *
  * This waits for completion of a specific task to be signaled. It is
@@ -211,7 +211,7 @@ EXPORT_SYMBOL(wait_for_completion_io_timeout);
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_interruptible(struct completion *x)
+int __sched __wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
 
@@ -219,10 +219,10 @@ int __sched wait_for_completion_interruptible(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible);
+EXPORT_SYMBOL(__wait_for_completion_interruptible);
 
 /**
- * wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
+ * __wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -233,15 +233,15 @@ EXPORT_SYMBOL(wait_for_completion_interruptible);
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_interruptible_timeout(struct completion *x,
+__wait_for_completion_interruptible_timeout(struct completion *x,
 					  unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_INTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
+EXPORT_SYMBOL(__wait_for_completion_interruptible_timeout);
 
 /**
- * wait_for_completion_killable: - waits for completion of a task (killable)
+ * __wait_for_completion_killable: - waits for completion of a task (killable)
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It can be
@@ -249,7 +249,7 @@ EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_killable(struct completion *x)
+int __sched __wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
 
@@ -257,9 +257,9 @@ int __sched wait_for_completion_killable(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_killable);
+EXPORT_SYMBOL(__wait_for_completion_killable);
 
-int __sched wait_for_completion_state(struct completion *x, unsigned int state)
+int __sched __wait_for_completion_state(struct completion *x, unsigned int state)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
 
@@ -267,10 +267,10 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_state);
+EXPORT_SYMBOL(__wait_for_completion_state);
 
 /**
- * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
+ * __wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -282,12 +282,12 @@ EXPORT_SYMBOL(wait_for_completion_state);
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_killable_timeout(struct completion *x,
+__wait_for_completion_killable_timeout(struct completion *x,
 				     unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_KILLABLE);
 }
-EXPORT_SYMBOL(wait_for_completion_killable_timeout);
+EXPORT_SYMBOL(__wait_for_completion_killable_timeout);
 
 /**
  *	try_wait_for_completion - try to decrement a completion without blocking
@@ -329,7 +329,7 @@ EXPORT_SYMBOL(try_wait_for_completion);
  *	completion_done - Test to see if a completion has any waiters
  *	@x:	completion structure
  *
- *	Return: 0 if there are waiters (wait_for_completion() in progress)
+ *	Return: 0 if there are waiters (__wait_for_completion() in progress)
  *		 1 if there are no waiters.
  *
  *	Note, this will always return true if complete_all() was called on @X.
-- 
2.17.1


