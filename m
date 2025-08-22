Return-Path: <linux-fsdevel+bounces-58723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8DB30A28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 02:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 050A52A48CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 00:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10581F3BAB;
	Fri, 22 Aug 2025 00:11:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5AF155C97;
	Fri, 22 Aug 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755821488; cv=none; b=Fxf9ilFmM6mnWY414bDxKzcfXodyU5HuuuS3ULquYF3ju03t3QWxmfs1HTN+aBgtqm2GaIL3QSrGVnkSgd4LIJbmzoXBXhMyHumR1zCSHCNFlHBDlFj/azIWM7hlgfQI5lVgPGNZ6wgwMaCUQbR4ZjoA2MSGxHS7iKITa1wwvYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755821488; c=relaxed/simple;
	bh=UDkmKL/2p8aQSv8lXFxCvcefVp3lmKhPsUMxUO+pPAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCFz0g4cdGf1xFEl5kusO4ZpWd6dCSvYoiJSI7Z7VHcPx83YXLOQQ7oh4+2hR7zdC0LkSB/nBh5azQn9W70zmNBhwuqsfKX2aDhda6XInkIJzWfYfehEYn2nxftO2/mpmSVpzCDi4I7G0VsBB6riMDMJp6mKcoUcJ3kEhPzh7/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1upFN9-006nad-1f;
	Fri, 22 Aug 2025 00:11:12 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 03/16] Introduce wake_up_key()
Date: Fri, 22 Aug 2025 10:00:21 +1000
Message-ID: <20250822000818.1086550-4-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250822000818.1086550-1-neil@brown.name>
References: <20250822000818.1086550-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a common pattern of passing a key to __wake_up().  The key is
used to select which waiter to wake.

Callers must currently use __wake_up() directly, which requires that a
TASK state and exclusive-waiter-count also be passed.  The desired state
is almost always TASK_NORMAL and these cases do not have exclusive
waiters so the count is not relevant.

This patch introduces
   wake_up_key(wq, key)
which simplifies the call, and changes relevant callers.  An exclusive
waiter count of '1' is used for consistency with wake_up().  In all
current cases this number is irrelevant.

Most callers (all but one) of __wake_up() are converted either to
wake_up_key(), or to the existing wake_up_poll().

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/gfs2/glock.c               | 2 +-
 fs/nfs/callback_proc.c        | 2 +-
 fs/userfaultfd.c              | 4 ++--
 include/linux/wait.h          | 3 ++-
 io_uring/io_uring.h           | 2 +-
 kernel/locking/percpu-rwsem.c | 2 +-
 kernel/sched/wait.c           | 2 +-
 kernel/sched/wait_bit.c       | 2 +-
 kernel/signal.c               | 3 +--
 mm/memcontrol-v1.c            | 2 +-
 10 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b6fd1cb17de7..cbf8f264f908 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -121,7 +121,7 @@ static void wake_up_glock(struct gfs2_glock *gl)
 	wait_queue_head_t *wq = glock_waitqueue(&gl->gl_name);
 
 	if (waitqueue_active(wq))
-		__wake_up(wq, TASK_NORMAL, 1, &gl->gl_name);
+		wake_up_key(wq, &gl->gl_name);
 }
 
 static void gfs2_glock_dealloc(struct rcu_head *rcu)
diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 8397c43358bd..b1d71c43c87d 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -689,7 +689,7 @@ __be32 nfs4_callback_notify_lock(void *argp, void *resp,
 
 	/* Don't wake anybody if the string looked bogus */
 	if (args->cbnl_valid)
-		__wake_up(&cps->clp->cl_lock_waitq, TASK_NORMAL, 0, args);
+		wake_up_key(&cps->clp->cl_lock_waitq, args);
 
 	return htonl(NFS4_OK);
 }
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 54c6cc7fe9c6..0d58c53bd583 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -874,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 */
 	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL, &range);
-	__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, &range);
+	wake_up_key(&ctx->fault_wqh, &range);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	/* Flush pending events that may still wait on event_wqh */
@@ -1175,7 +1175,7 @@ static void __wake_userfault(struct userfaultfd_ctx *ctx,
 		__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL,
 				     range);
 	if (waitqueue_active(&ctx->fault_wqh))
-		__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, range);
+		wake_up_key(&ctx->fault_wqh, range);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 }
 
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..86d751893c9f 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -224,6 +224,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define wake_up_locked(x)		__wake_up_locked((x), TASK_NORMAL, 1)
 #define wake_up_all_locked(x)		__wake_up_locked((x), TASK_NORMAL, 0)
 #define wake_up_sync(x)			__wake_up_sync(x, TASK_NORMAL)
+#define wake_up_key(x,k)		__wake_up(x, TASK_NORMAL, 1, k);
 
 #define wake_up_interruptible(x)	__wake_up(x, TASK_INTERRUPTIBLE, 1, NULL)
 #define wake_up_interruptible_nr(x, nr)	__wake_up(x, TASK_INTERRUPTIBLE, nr, NULL)
@@ -236,7 +237,7 @@ void __wake_up_pollfree(struct wait_queue_head *wq_head);
 #define poll_to_key(m) ((void *)(__force uintptr_t)(__poll_t)(m))
 #define key_to_poll(m) ((__force __poll_t)(uintptr_t)(void *)(m))
 #define wake_up_poll(x, m)							\
-	__wake_up(x, TASK_NORMAL, 1, poll_to_key(m))
+	wake_up_key(x, poll_to_key(m))
 #define wake_up_poll_on_current_cpu(x, m)					\
 	__wake_up_on_current_cpu(x, TASK_NORMAL, poll_to_key(m))
 #define wake_up_locked_poll(x, m)						\
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index abc6de227f74..11d8b656ad64 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -304,7 +304,7 @@ static inline void __io_wq_wake(struct wait_queue_head *wq)
 	 * epoll and should terminate multishot poll at that point.
 	 */
 	if (wq_has_sleeper(wq))
-		__wake_up(wq, TASK_NORMAL, 0, poll_to_key(EPOLL_URING_WAKE | EPOLLIN));
+		wake_up_poll(wq, EPOLL_URING_WAKE | EPOLLIN);
 }
 
 static inline void io_poll_wq_wake(struct io_ring_ctx *ctx)
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index ef234469baac..1d3e5f03e0f1 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -278,7 +278,7 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	/*
 	 * Prod any pending reader/writer to make progress.
 	 */
-	__wake_up(&sem->waiters, TASK_NORMAL, 1, sem);
+	wake_up_key(&sem->waiters, sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 20f27e2cf7ae..201d9827580f 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -227,7 +227,7 @@ EXPORT_SYMBOL_GPL(__wake_up_sync);	/* For internal use only */
 
 void __wake_up_pollfree(struct wait_queue_head *wq_head)
 {
-	__wake_up(wq_head, TASK_NORMAL, 0, poll_to_key(EPOLLHUP | POLLFREE));
+	wake_up_poll(wq_head, EPOLLHUP | POLLFREE);
 	/* POLLFREE must have cleared the queue. */
 	WARN_ON_ONCE(waitqueue_active(wq_head));
 }
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 1088d3b7012c..87f9d1428e62 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -126,7 +126,7 @@ void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
 
 	if (waitqueue_active(wq_head))
-		__wake_up(wq_head, TASK_NORMAL, 1, &key);
+		wake_up_key(wq_head, &key);
 }
 EXPORT_SYMBOL(__wake_up_bit);
 
diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..e4adffab3a8d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2154,8 +2154,7 @@ void do_notify_pidfd(struct task_struct *task)
 
 	WARN_ON(task->exit_state == 0);
 
-	__wake_up(&pid->wait_pidfd, TASK_NORMAL, 0,
-			poll_to_key(EPOLLIN | EPOLLRDNORM));
+	wake_up_poll(&pid->wait_pidfd, EPOLLIN | EPOLLRDNORM);
 }
 
 /*
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 4b94731305b9..8cb251aa2dcc 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1328,7 +1328,7 @@ void memcg1_oom_recover(struct mem_cgroup *memcg)
 	 * triggering notification.
 	 */
 	if (memcg && memcg->under_oom)
-		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
+		wake_up_key(&memcg_oom_waitq, memcg);
 }
 
 /**
-- 
2.50.0.107.gf914562f5916.dirty


