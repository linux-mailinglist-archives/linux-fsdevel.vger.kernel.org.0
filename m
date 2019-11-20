Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EFB1036F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKTJph (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 04:45:37 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47682 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfKTJph (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:45:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=jiufei.xue@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TidUqF1_1574243134;
Received: from localhost(mailfrom:jiufei.xue@linux.alibaba.com fp:SMTPD_---0TidUqF1_1574243134)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Nov 2019 17:45:34 +0800
From:   Jiufei Xue <jiufei.xue@linux.alibaba.com>
To:     miklos@szeredi.hu, amir73il@gmail.com
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ovl: implement async IO routines
Date:   Wed, 20 Nov 2019 17:45:26 +0800
Message-Id: <1574243126-59283-3-git-send-email-jiufei.xue@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
References: <1574243126-59283-1-git-send-email-jiufei.xue@linux.alibaba.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A performance regression is observed since linux v4.19 when we do aio
test using fio with iodepth 128 on overlayfs. And we found that queue
depth of the device is always 1 which is unexpected.

After investigation, it is found that commit 16914e6fc7e1
("ovl: add ovl_read_iter()") and commit 2a92e07edc5e
("ovl: add ovl_write_iter()") use do_iter_readv_writev() to submit
requests to real filesystem. Async IOs are converted to sync IOs here
and cause performance regression.

So implement async IO for stacked reading and writing.

Changes since v1:
  - add a cleanup helper for completion/error handling
  - handle the case when aio_req allocation failed

Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 fs/overlayfs/file.c      | 116 +++++++++++++++++++++++++++++++++++++++++------
 fs/overlayfs/overlayfs.h |   2 +
 fs/overlayfs/super.c     |  12 ++++-
 3 files changed, 114 insertions(+), 16 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e235a63..8ba000f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -11,6 +11,14 @@
 #include <linux/uaccess.h>
 #include "overlayfs.h"
 
+struct ovl_aio_req {
+	struct kiocb iocb;
+	struct kiocb *orig_iocb;
+	struct fd fd;
+};
+
+static struct kmem_cache *ovl_aio_request_cachep;
+
 static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 {
 	if (realinode != ovl_inode_upper(inode))
@@ -225,6 +233,33 @@ static rwf_t ovl_iocb_to_rwf(struct kiocb *iocb)
 	return flags;
 }
 
+static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *orig_iocb = aio_req->orig_iocb;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		struct inode *inode = file_inode(orig_iocb->ki_filp);
+
+		file_end_write(iocb->ki_filp);
+		ovl_copyattr(ovl_inode_real(inode), inode);
+	}
+
+	orig_iocb->ki_pos = iocb->ki_pos;
+	fdput(aio_req->fd);
+	kmem_cache_free(ovl_aio_request_cachep, aio_req);
+}
+
+static void ovl_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+{
+	struct ovl_aio_req *aio_req = container_of(iocb,
+						   struct ovl_aio_req, iocb);
+	struct kiocb *orig_iocb = aio_req->orig_iocb;
+
+	ovl_aio_cleanup_handler(aio_req);
+	orig_iocb->ki_complete(orig_iocb, res, res2);
+}
+
 static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 {
 	struct file *file = iocb->ki_filp;
@@ -240,14 +275,32 @@ static ssize_t ovl_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		return ret;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
-			    ovl_iocb_to_rwf(iocb));
+	if (is_sync_kiocb(iocb)) {
+		ret = vfs_iter_read(real.file, iter, &iocb->ki_pos,
+				    ovl_iocb_to_rwf(iocb));
+		ovl_file_accessed(file);
+		fdput(real);
+	} else {
+		struct ovl_aio_req *aio_req = kmem_cache_alloc(ovl_aio_request_cachep,
+							       GFP_NOFS);
+		if (!aio_req) {
+			ret = -ENOMEM;
+			fdput(real);
+			goto out_revert;
+		}
+
+		aio_req->fd = real;
+		aio_req->orig_iocb = iocb;
+		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
+		ret = vfs_iocb_iter_read(real.file, &aio_req->iocb, iter);
+		ovl_file_accessed(file);
+		if (ret != -EIOCBQUEUED)
+			ovl_aio_cleanup_handler(aio_req);
+	}
+out_revert:
 	revert_creds(old_cred);
 
-	ovl_file_accessed(file);
-
-	fdput(real);
-
 	return ret;
 }
 
@@ -275,15 +328,34 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	file_start_write(real.file);
-	ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
-			     ovl_iocb_to_rwf(iocb));
-	file_end_write(real.file);
-	revert_creds(old_cred);
-
-	/* Update size */
-	ovl_copyattr(ovl_inode_real(inode), inode);
+	if (is_sync_kiocb(iocb)) {
+		ret = vfs_iter_write(real.file, iter, &iocb->ki_pos,
+				     ovl_iocb_to_rwf(iocb));
+		file_end_write(real.file);
+		/* Update size */
+		ovl_copyattr(ovl_inode_real(inode), inode);
+		fdput(real);
+	} else {
+		struct ovl_aio_req *aio_req = kmem_cache_alloc(ovl_aio_request_cachep,
+							       GFP_NOFS);
+		if (!aio_req) {
+			ret = -ENOMEM;
+			file_end_write(real.file);
+			fdput(real);
+			goto out_revert;
+		}
+
+		aio_req->fd = real;
+		aio_req->orig_iocb = iocb;
+		kiocb_clone(&aio_req->iocb, iocb, real.file);
+		aio_req->iocb.ki_complete = ovl_aio_rw_complete;
+		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
+		if (ret != -EIOCBQUEUED)
+			ovl_aio_cleanup_handler(aio_req);
+	}
 
-	fdput(real);
+out_revert:
+	revert_creds(old_cred);
 
 out_unlock:
 	inode_unlock(inode);
@@ -651,3 +723,19 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 };
+
+int __init ovl_init_aio_request_cache(void)
+{
+	ovl_aio_request_cachep = kmem_cache_create("ovl_aio_req",
+						   sizeof(struct ovl_aio_req),
+						   0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!ovl_aio_request_cachep)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void ovl_exit_aio_request_cache(void)
+{
+	kmem_cache_destroy(ovl_aio_request_cachep);
+}
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index 6934bcf..afd1631 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -416,6 +416,8 @@ struct dentry *ovl_create_real(struct inode *dir, struct dentry *newdentry,
 
 /* file.c */
 extern const struct file_operations ovl_file_operations;
+int __init ovl_init_aio_request_cache(void);
+void ovl_exit_aio_request_cache(void);
 
 /* copy_up.c */
 int ovl_copy_up(struct dentry *dentry);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index afbcb11..83cef1f 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1739,9 +1739,17 @@ static int __init ovl_init(void)
 	if (ovl_inode_cachep == NULL)
 		return -ENOMEM;
 
+	err = ovl_init_aio_request_cache();
+	if (err) {
+		kmem_cache_destroy(ovl_inode_cachep);
+		return -ENOMEM;
+	}
+
 	err = register_filesystem(&ovl_fs_type);
-	if (err)
+	if (err) {
 		kmem_cache_destroy(ovl_inode_cachep);
+		ovl_exit_aio_request_cache();
+	}
 
 	return err;
 }
@@ -1756,7 +1764,7 @@ static void __exit ovl_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(ovl_inode_cachep);
-
+	ovl_exit_aio_request_cache();
 }
 
 module_init(ovl_init);
-- 
1.8.3.1

