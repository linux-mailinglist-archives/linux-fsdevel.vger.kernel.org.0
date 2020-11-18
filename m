Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B072B7A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbgKRJTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 04:19:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:52496 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbgKRJTT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:19:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E198ABDE;
        Wed, 18 Nov 2020 09:19:18 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id E59BD603F9; Wed, 18 Nov 2020 10:19:17 +0100 (CET)
Message-Id: <8a4f07e6ec47b681a32c6df5d463857e67bfc965.1605690824.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] eventfd: convert to ->write_iter()
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
Date:   Wed, 18 Nov 2020 10:19:17 +0100 (CET)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

While eventfd ->read() callback was replaced by ->read_iter() recently,
it still provides ->write() for writes. Since commit 4d03e3cc5982 ("fs:
don't allow kernel reads and writes without iter ops"), this prevents
kernel_write() to be used for eventfd and with set_fs() removal,
->write() cannot be easily called directly with a kernel buffer.

According to eventfd(2), eventfd descriptors are supposed to be (also)
used by kernel to notify userspace applications of events which now
requires ->write_iter() op to be available (and ->write() not to be).
Therefore convert eventfd_write() to ->write_iter() semantics. This
patch also cleans up the code in a similar way as commit 12aceb89b0bc
("eventfd: convert to f_op->read_iter()") did in read_iter().

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

