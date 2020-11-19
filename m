Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5646F2B9A49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Nov 2020 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgKSSAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 13:00:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:44800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgKSSAV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:00:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4904AC2D;
        Thu, 19 Nov 2020 18:00:19 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 99F9D603F9; Thu, 19 Nov 2020 19:00:19 +0100 (CET)
Message-Id: <ed4484a3dc8297296bfcd16810f7dc1976d6f7d0.1605808477.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH v2] eventfd: convert to ->write_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 Nov 2020 19:00:19 +0100 (CET)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While eventfd ->read() callback was replaced by ->read_iter() recently by
commit 12aceb89b0bc ("eventfd: convert to f_op->read_iter()"), ->write()
was not replaced.

Convert also ->write() to ->write_iter() to make the interface more
consistent and allow non-blocking writes from e.g. io_uring. Also
reorganize the code and return value handling in a similar way as it was
done in eventfd_read().

v2: different reasoning in commit message (no code change)

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 fs/eventfd.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index df466ef81ddd..35973d216847 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -261,35 +261,36 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	return sizeof(ucnt);
 }
 
-static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t count,
-			     loff_t *ppos)
+static ssize_t eventfd_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
 	struct eventfd_ctx *ctx = file->private_data;
-	ssize_t res;
 	__u64 ucnt;
 	DECLARE_WAITQUEUE(wait, current);
 
-	if (count < sizeof(ucnt))
+	if (iov_iter_count(from) < sizeof(ucnt))
 		return -EINVAL;
-	if (copy_from_user(&ucnt, buf, sizeof(ucnt)))
+	if (unlikely(!copy_from_iter_full(&ucnt, sizeof(ucnt), from)))
 		return -EFAULT;
 	if (ucnt == ULLONG_MAX)
 		return -EINVAL;
 	spin_lock_irq(&ctx->wqh.lock);
-	res = -EAGAIN;
-	if (ULLONG_MAX - ctx->count > ucnt)
-		res = sizeof(ucnt);
-	else if (!(file->f_flags & O_NONBLOCK)) {
+	if (ULLONG_MAX - ctx->count <= ucnt) {
+		if ((file->f_flags & O_NONBLOCK) ||
+		    (iocb->ki_flags & IOCB_NOWAIT)) {
+			spin_unlock_irq(&ctx->wqh.lock);
+			return -EAGAIN;
+		}
 		__add_wait_queue(&ctx->wqh, &wait);
-		for (res = 0;;) {
+		for (;;) {
 			set_current_state(TASK_INTERRUPTIBLE);
-			if (ULLONG_MAX - ctx->count > ucnt) {
-				res = sizeof(ucnt);
+			if (ULLONG_MAX - ctx->count > ucnt)
 				break;
-			}
 			if (signal_pending(current)) {
-				res = -ERESTARTSYS;
-				break;
+				__remove_wait_queue(&ctx->wqh, &wait);
+				__set_current_state(TASK_RUNNING);
+				spin_unlock_irq(&ctx->wqh.lock);
+				return -ERESTARTSYS;
 			}
 			spin_unlock_irq(&ctx->wqh.lock);
 			schedule();
@@ -298,14 +299,12 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		__remove_wait_queue(&ctx->wqh, &wait);
 		__set_current_state(TASK_RUNNING);
 	}
-	if (likely(res > 0)) {
-		ctx->count += ucnt;
-		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
-	}
+	ctx->count += ucnt;
+	if (waitqueue_active(&ctx->wqh))
+		wake_up_locked_poll(&ctx->wqh, EPOLLIN);
 	spin_unlock_irq(&ctx->wqh.lock);
 
-	return res;
+	return sizeof(ucnt);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -328,7 +327,7 @@ static const struct file_operations eventfd_fops = {
 	.release	= eventfd_release,
 	.poll		= eventfd_poll,
 	.read_iter	= eventfd_read,
-	.write		= eventfd_write,
+	.write_iter	= eventfd_write,
 	.llseek		= noop_llseek,
 };
 
-- 
2.29.2

