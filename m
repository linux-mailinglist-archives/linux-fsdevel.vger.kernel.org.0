Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 990CE57D85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 09:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfF0Hzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 03:55:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfF0Hzo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 03:55:44 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C4E20828;
        Thu, 27 Jun 2019 07:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561622143;
        bh=Rfx3QvLxxmERfr1nfPQEGnlDjMwAzu8Gqm3kSJPs1Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGy4dZjPdaaMYHcZN52wEdtsRUL3Q2x6njs9FHunjdLo6zZUbEAsHH/oQOHzPODk5
         nOnioWkFfM74gBYx3WphthiXLfSld4O2v9vdc5DxmMLDzSeit9l7PvsBVDQsVkYddR
         31F2G+rMInUGL6o6vLtAoLtGVi8025+N75KgEJJ4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH] userfaultfd: disable irqs for fault_pending and event locks
Date:   Thu, 27 Jun 2019 00:50:04 -0700
Message-Id: <20190627075004.21259-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612194825.GH18795@gmail.com>
References: <20190612194825.GH18795@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When IOCB_CMD_POLL is used on a userfaultfd, aio_poll() disables IRQs
and takes kioctx::ctx_lock, then userfaultfd_ctx::fd_wqh.lock.  This may
have to wait for userfaultfd_ctx::fd_wqh.lock to be released by
userfaultfd_ctx_read(), which can be waiting for
userfaultfd_ctx::fault_pending_wqh.lock or
userfaultfd_ctx::event_wqh.lock.  But elsewhere the fault_pending_wqh
and event_wqh locks are taken with IRQs enabled.  Since the IRQ handler
may take kioctx::ctx_lock, lockdep reports that a deadlock is possible.

Fix it by always disabling IRQs when taking the fault_pending_wqh and
event_wqh locks.

Commit ae62c16e105a ("userfaultfd: disable irqs when taking the
waitqueue lock") didn't fix this because it only accounted for the
fd_wqh lock, not the other locks nested inside it.

Reported-by: syzbot+fab6de82892b6b9c6191@syzkaller.appspotmail.com
Reported-by: syzbot+53c0b767f7ca0dc0c451@syzkaller.appspotmail.com
Reported-by: syzbot+a3accb352f9c22041cfa@syzkaller.appspotmail.com
Fixes: bfe4037e722e ("aio: implement IOCB_CMD_POLL")
Cc: <stable@vger.kernel.org> # v4.19+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/userfaultfd.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index ae0b8b5f69e6..ccbdbd62f0d8 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -40,6 +40,16 @@ enum userfaultfd_state {
 /*
  * Start with fault_pending_wqh and fault_wqh so they're more likely
  * to be in the same cacheline.
+ *
+ * Locking order:
+ *	fd_wqh.lock
+ *		fault_pending_wqh.lock
+ *			fault_wqh.lock
+ *		event_wqh.lock
+ *
+ * To avoid deadlocks, IRQs must be disabled when taking any of the above locks,
+ * since fd_wqh.lock is taken by aio_poll() while it's holding a lock that's
+ * also taken in IRQ context.
  */
 struct userfaultfd_ctx {
 	/* waitqueue head for the pending (i.e. not read) userfaults */
@@ -458,7 +468,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
 			 TASK_KILLABLE;
 
-	spin_lock(&ctx->fault_pending_wqh.lock);
+	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/*
 	 * After the __add_wait_queue the uwq is visible to userland
 	 * through poll/read().
@@ -470,7 +480,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * __add_wait_queue.
 	 */
 	set_current_state(blocking_state);
-	spin_unlock(&ctx->fault_pending_wqh.lock);
+	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	if (!is_vm_hugetlb_page(vmf->vma))
 		must_wait = userfaultfd_must_wait(ctx, vmf->address, vmf->flags,
@@ -552,13 +562,13 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * kernel stack can be released after the list_del_init.
 	 */
 	if (!list_empty_careful(&uwq.wq.entry)) {
-		spin_lock(&ctx->fault_pending_wqh.lock);
+		spin_lock_irq(&ctx->fault_pending_wqh.lock);
 		/*
 		 * No need of list_del_init(), the uwq on the stack
 		 * will be freed shortly anyway.
 		 */
 		list_del(&uwq.wq.entry);
-		spin_unlock(&ctx->fault_pending_wqh.lock);
+		spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 	}
 
 	/*
@@ -583,7 +593,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	init_waitqueue_entry(&ewq->wq, current);
 	release_new_ctx = NULL;
 
-	spin_lock(&ctx->event_wqh.lock);
+	spin_lock_irq(&ctx->event_wqh.lock);
 	/*
 	 * After the __add_wait_queue the uwq is visible to userland
 	 * through poll/read().
@@ -613,15 +623,15 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 			break;
 		}
 
-		spin_unlock(&ctx->event_wqh.lock);
+		spin_unlock_irq(&ctx->event_wqh.lock);
 
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
 		schedule();
 
-		spin_lock(&ctx->event_wqh.lock);
+		spin_lock_irq(&ctx->event_wqh.lock);
 	}
 	__set_current_state(TASK_RUNNING);
-	spin_unlock(&ctx->event_wqh.lock);
+	spin_unlock_irq(&ctx->event_wqh.lock);
 
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
@@ -918,10 +928,10 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 	 * the last page faults that may have been already waiting on
 	 * the fault_*wqh.
 	 */
-	spin_lock(&ctx->fault_pending_wqh.lock);
+	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL, &range);
 	__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, &range);
-	spin_unlock(&ctx->fault_pending_wqh.lock);
+	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	/* Flush pending events that may still wait on event_wqh */
 	wake_up_all(&ctx->event_wqh);
@@ -1134,7 +1144,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 
 	if (!ret && msg->event == UFFD_EVENT_FORK) {
 		ret = resolve_userfault_fork(ctx, fork_nctx, msg);
-		spin_lock(&ctx->event_wqh.lock);
+		spin_lock_irq(&ctx->event_wqh.lock);
 		if (!list_empty(&fork_event)) {
 			/*
 			 * The fork thread didn't abort, so we can
@@ -1180,7 +1190,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			if (ret)
 				userfaultfd_ctx_put(fork_nctx);
 		}
-		spin_unlock(&ctx->event_wqh.lock);
+		spin_unlock_irq(&ctx->event_wqh.lock);
 	}
 
 	return ret;
@@ -1219,14 +1229,14 @@ static ssize_t userfaultfd_read(struct file *file, char __user *buf,
 static void __wake_userfault(struct userfaultfd_ctx *ctx,
 			     struct userfaultfd_wake_range *range)
 {
-	spin_lock(&ctx->fault_pending_wqh.lock);
+	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	/* wake all in the range and autoremove */
 	if (waitqueue_active(&ctx->fault_pending_wqh))
 		__wake_up_locked_key(&ctx->fault_pending_wqh, TASK_NORMAL,
 				     range);
 	if (waitqueue_active(&ctx->fault_wqh))
 		__wake_up(&ctx->fault_wqh, TASK_NORMAL, 1, range);
-	spin_unlock(&ctx->fault_pending_wqh.lock);
+	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 }
 
 static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
@@ -1881,7 +1891,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 	wait_queue_entry_t *wq;
 	unsigned long pending = 0, total = 0;
 
-	spin_lock(&ctx->fault_pending_wqh.lock);
+	spin_lock_irq(&ctx->fault_pending_wqh.lock);
 	list_for_each_entry(wq, &ctx->fault_pending_wqh.head, entry) {
 		pending++;
 		total++;
@@ -1889,7 +1899,7 @@ static void userfaultfd_show_fdinfo(struct seq_file *m, struct file *f)
 	list_for_each_entry(wq, &ctx->fault_wqh.head, entry) {
 		total++;
 	}
-	spin_unlock(&ctx->fault_pending_wqh.lock);
+	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	/*
 	 * If more protocols will be added, there will be all shown
-- 
2.22.0

