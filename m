Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C3A101126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 03:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKSCOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Nov 2019 21:14:09 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:49866 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726952AbfKSCOJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Nov 2019 21:14:09 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TiW9RlV_1574129645;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TiW9RlV_1574129645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 19 Nov 2019 10:14:05 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] vfs: add vfs_iocb_iter_[read|write] helper functions
Date:   Tue, 19 Nov 2019 10:14:02 +0800
Message-Id: <1574129643-14664-2-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
References: <1574129643-14664-1-git-send-email-jiufei.xue@linux.alibaba.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This isn't cause any behavior changes and will be used by overlay
async IO implementation.

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 fs/read_write.c    | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h | 16 +++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587..3dfbcec 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -984,6 +984,64 @@ ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 }
 EXPORT_SYMBOL(vfs_iter_write);
 
+ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
+			   struct iov_iter *iter)
+{
+	ssize_t ret = 0;
+	ssize_t tot_len;
+
+	if (!file->f_op->read_iter)
+		return -EINVAL;
+	if (!(file->f_mode & FMODE_READ))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_READ))
+		return -EINVAL;
+
+	tot_len = iov_iter_count(iter);
+	if (!tot_len)
+		return 0;
+
+	ret = rw_verify_area(READ, file, &iocb->ki_pos, tot_len);
+	if (ret < 0)
+		return ret;
+
+	ret = call_read_iter(file, iocb, iter);
+	if (ret >= 0)
+		fsnotify_access(file);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_iocb_iter_read);
+
+ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
+			    struct iov_iter *iter)
+{
+	ssize_t ret = 0;
+	ssize_t tot_len;
+
+	if (!file->f_op->write_iter)
+		return -EINVAL;
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EBADF;
+	if (!(file->f_mode & FMODE_CAN_WRITE))
+		return -EINVAL;
+
+	tot_len = iov_iter_count(iter);
+	if (!tot_len)
+		return 0;
+
+	ret = rw_verify_area(WRITE, file, &iocb->ki_pos, tot_len);
+	if (ret < 0)
+		return ret;
+
+	ret = call_write_iter(file, iocb, iter);
+	if (ret >= 0)
+		fsnotify_modify(file);
+
+	return ret;
+}
+EXPORT_SYMBOL(vfs_iocb_iter_write);
+
 ssize_t vfs_readv(struct file *file, const struct iovec __user *vec,
 		  unsigned long vlen, loff_t *pos, rwf_t flags)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e0d909d..c885279 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2071,6 +2071,18 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 	};
 }
 
+static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
+			       struct file *filp)
+{
+        *kiocb = (struct kiocb) {
+                .ki_filp = filp,
+                .ki_flags = kiocb_src->ki_flags,
+                .ki_hint = ki_hint_validate(file_write_hint(filp)),
+                .ki_ioprio = kiocb_src->ki_ioprio,
+                .ki_pos = kiocb_src->ki_pos,
+        };
+}
+
 /*
  * Inode state bits.  Protected by inode->i_lock
  *
@@ -3105,6 +3117,10 @@ ssize_t vfs_iter_read(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
 ssize_t vfs_iter_write(struct file *file, struct iov_iter *iter, loff_t *ppos,
 		rwf_t flags);
+ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
+			   struct iov_iter *iter);
+ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
+			    struct iov_iter *iter);
 
 /* fs/block_dev.c */
 extern ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to);
-- 
1.8.3.1

