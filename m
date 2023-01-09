Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59808661D86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 05:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbjAIEFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 23:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbjAIEES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 23:04:18 -0500
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98F0611C03
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 20:03:53 -0800 (PST)
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.51 with ESMTP; 9 Jan 2023 12:33:52 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.244.38)
        by 156.147.1.121 with ESMTP; 9 Jan 2023 12:33:52 +0900
X-Original-SENDERIP: 10.177.244.38
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, damien.lemoal@opensource.wdc.com,
        linux-ide@vger.kernel.org, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        will@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        joel@joelfernandes.org, sashal@kernel.org, daniel.vetter@ffwll.ch,
        duyuyang@gmail.com, johannes.berg@intel.com, tj@kernel.org,
        tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org,
        kernel-team@lge.com, linux-mm@kvack.org, akpm@linux-foundation.org,
        mhocko@kernel.org, minchan@kernel.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, sj@kernel.org, jglisse@redhat.com,
        dennis@kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, vbabka@suse.cz, ngupta@vflare.org,
        linux-block@vger.kernel.org, paolo.valente@linaro.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com
Subject: [PATCH RFC v7 07/23] dept: Apply sdt_might_sleep_strong() to wait_for_completion()/complete()
Date:   Mon,  9 Jan 2023 12:33:35 +0900
Message-Id: <1673235231-30302-8-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
References: <1673235231-30302-1-git-send-email-byungchul.park@lge.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Makes Dept able to track dependencies by
wait_for_completion()/complete().

In order to obtain the meaningful caller points, replace all the
wait_for_completion*() declarations with macros in the header.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/completion.h | 89 +++++++++++++++++++++++++++++++++++++++++-----
 kernel/sched/completion.c  | 60 +++++++++++++++----------------
 2 files changed, 110 insertions(+), 39 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 62b32b1..0408f6d 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -99,19 +100,89 @@ static inline void reinit_completion(struct completion *x)
 	x->done = 0;
 }
 
-extern void wait_for_completion(struct completion *);
-extern void wait_for_completion_io(struct completion *);
-extern int wait_for_completion_interruptible(struct completion *x);
-extern int wait_for_completion_killable(struct completion *x);
-extern int wait_for_completion_state(struct completion *x, unsigned int state);
-extern unsigned long wait_for_completion_timeout(struct completion *x,
+extern void raw_wait_for_completion(struct completion *);
+extern void raw_wait_for_completion_io(struct completion *);
+extern int raw_wait_for_completion_interruptible(struct completion *x);
+extern int raw_wait_for_completion_killable(struct completion *x);
+extern int raw_wait_for_completion_state(struct completion *x, unsigned int state);
+extern unsigned long raw_wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
-extern unsigned long wait_for_completion_io_timeout(struct completion *x,
+extern unsigned long raw_wait_for_completion_io_timeout(struct completion *x,
 						    unsigned long timeout);
-extern long wait_for_completion_interruptible_timeout(
+extern long raw_wait_for_completion_interruptible_timeout(
 	struct completion *x, unsigned long timeout);
-extern long wait_for_completion_killable_timeout(
+extern long raw_wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
+
+#define wait_for_completion(x)					\
+({								\
+	sdt_might_sleep_strong(NULL);				\
+	raw_wait_for_completion(x);				\
+	sdt_might_sleep_finish();				\
+})
+#define wait_for_completion_io(x)				\
+({								\
+	sdt_might_sleep_strong(NULL);				\
+	raw_wait_for_completion_io(x);				\
+	sdt_might_sleep_finish();				\
+})
+#define wait_for_completion_interruptible(x)			\
+({								\
+	int __ret;						\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_interruptible(x);	\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_killable(x)				\
+({								\
+	int __ret;						\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_killable(x);		\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_state(x, s)				\
+({								\
+	int __ret;						\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_state(x, s);		\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_timeout(x, t)			\
+({								\
+	unsigned long __ret;					\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_timeout(x, t);		\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_io_timeout(x, t)			\
+({								\
+	unsigned long __ret;					\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_io_timeout(x, t);	\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_interruptible_timeout(x, t)		\
+({								\
+	long __ret;						\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_interruptible_timeout(x, t);\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+#define wait_for_completion_killable_timeout(x, t)		\
+({								\
+	long __ret;						\
+	sdt_might_sleep_strong(NULL);				\
+	__ret = raw_wait_for_completion_killable_timeout(x, t);	\
+	sdt_might_sleep_finish();				\
+	__ret;							\
+})
+
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index d57a5c1..8fcf5ee 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -4,7 +4,7 @@
  * Generic wait-for-completion handler;
  *
  * It differs from semaphores in that their default case is the opposite,
- * wait_for_completion default blocks whereas semaphore default non-block. The
+ * raw_wait_for_completion default blocks whereas semaphore default non-block. The
  * interface also makes it easy to 'complete' multiple waiting threads,
  * something which isn't entirely natural for semaphores.
  *
@@ -20,7 +20,7 @@
  * This will wake up a single thread waiting on this completion. Threads will be
  * awakened in the same order in which they were queued.
  *
- * See also complete_all(), wait_for_completion() and related routines.
+ * See also complete_all(), raw_wait_for_completion() and related routines.
  *
  * If this function wakes up a task, it executes a full memory barrier before
  * accessing the task state.
@@ -124,23 +124,23 @@ void complete_all(struct completion *x)
 }
 
 /**
- * wait_for_completion: - waits for completion of a task
+ * raw_wait_for_completion: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout.
  *
- * See also similar routines (i.e. wait_for_completion_timeout()) with timeout
+ * See also similar routines (i.e. raw_wait_for_completion_timeout()) with timeout
  * and interrupt capability. Also see complete().
  */
-void __sched wait_for_completion(struct completion *x)
+void __sched raw_wait_for_completion(struct completion *x)
 {
 	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(raw_wait_for_completion);
 
 /**
- * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
+ * raw_wait_for_completion_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -152,28 +152,28 @@ void __sched wait_for_completion(struct completion *x)
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_timeout(struct completion *x, unsigned long timeout)
+raw_wait_for_completion_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_timeout);
+EXPORT_SYMBOL(raw_wait_for_completion_timeout);
 
 /**
- * wait_for_completion_io: - waits for completion of a task
+ * raw_wait_for_completion_io: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout. The caller is accounted as waiting
  * for IO (which traditionally means blkio only).
  */
-void __sched wait_for_completion_io(struct completion *x)
+void __sched raw_wait_for_completion_io(struct completion *x)
 {
 	wait_for_common_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io);
+EXPORT_SYMBOL(raw_wait_for_completion_io);
 
 /**
- * wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
+ * raw_wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -186,14 +186,14 @@ void __sched wait_for_completion_io(struct completion *x)
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
+raw_wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common_io(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io_timeout);
+EXPORT_SYMBOL(raw_wait_for_completion_io_timeout);
 
 /**
- * wait_for_completion_interruptible: - waits for completion of a task (w/intr)
+ * raw_wait_for_completion_interruptible: - waits for completion of a task (w/intr)
  * @x:  holds the state of this particular completion
  *
  * This waits for completion of a specific task to be signaled. It is
@@ -201,7 +201,7 @@ void __sched wait_for_completion_io(struct completion *x)
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_interruptible(struct completion *x)
+int __sched raw_wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
 
@@ -209,10 +209,10 @@ int __sched wait_for_completion_interruptible(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible);
+EXPORT_SYMBOL(raw_wait_for_completion_interruptible);
 
 /**
- * wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
+ * raw_wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -223,15 +223,15 @@ int __sched wait_for_completion_interruptible(struct completion *x)
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_interruptible_timeout(struct completion *x,
+raw_wait_for_completion_interruptible_timeout(struct completion *x,
 					  unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_INTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
+EXPORT_SYMBOL(raw_wait_for_completion_interruptible_timeout);
 
 /**
- * wait_for_completion_killable: - waits for completion of a task (killable)
+ * raw_wait_for_completion_killable: - waits for completion of a task (killable)
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It can be
@@ -239,7 +239,7 @@ int __sched wait_for_completion_interruptible(struct completion *x)
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_killable(struct completion *x)
+int __sched raw_wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
 
@@ -247,9 +247,9 @@ int __sched wait_for_completion_killable(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_killable);
+EXPORT_SYMBOL(raw_wait_for_completion_killable);
 
-int __sched wait_for_completion_state(struct completion *x, unsigned int state)
+int __sched raw_wait_for_completion_state(struct completion *x, unsigned int state)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
 
@@ -257,10 +257,10 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_state);
+EXPORT_SYMBOL(raw_wait_for_completion_state);
 
 /**
- * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
+ * raw_wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -272,12 +272,12 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_killable_timeout(struct completion *x,
+raw_wait_for_completion_killable_timeout(struct completion *x,
 				     unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_KILLABLE);
 }
-EXPORT_SYMBOL(wait_for_completion_killable_timeout);
+EXPORT_SYMBOL(raw_wait_for_completion_killable_timeout);
 
 /**
  *	try_wait_for_completion - try to decrement a completion without blocking
@@ -319,7 +319,7 @@ bool try_wait_for_completion(struct completion *x)
  *	completion_done - Test to see if a completion has any waiters
  *	@x:	completion structure
  *
- *	Return: 0 if there are waiters (wait_for_completion() in progress)
+ *	Return: 0 if there are waiters (raw_wait_for_completion() in progress)
  *		 1 if there are no waiters.
  *
  *	Note, this will always return true if complete_all() was called on @X.
-- 
1.9.1

