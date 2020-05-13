Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DAC1D092D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 08:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgEMG5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730258AbgEMG5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 02:57:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B7C061A0C;
        Tue, 12 May 2020 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DRip+MGYeXnAm9ZgzN+DsTqmAXn6wgI0HX1AmvNIpA4=; b=dL6Gnd5H37HpOIBcYju2mxlVGw
        V17ie2vxjCEp7WAqanl4wpn7dkMw6/bDvpA8BYqOXr5riBIdn2X5KSSYRV5+Kxp6NDezCcBE+ULtQ
        idN121qEQGQ1FZVA0iOLGq0IOJThz4jm7shygeNyqHmATOkC3Wz3D08pWZa+6HkDgNZrd04SBv6Pb
        HEyFmHs41e27Ip+Cxx1oN2/87sE/aZCRRPDdZeke+S6jY7ShA8scWzhNYszhlDj3jYiI1Qi0ezsvV
        wbHE8XySZlJnS46cSw08Ll//aN9k/MBtZ5X//QRfWX0qLn8bOtLdzr9gsYQgyIuVBt77gAn7LAGl+
        zhHoCmAw==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYlKM-0003XR-99; Wed, 13 May 2020 06:57:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH 06/14] fs: remove the call_{read,write}_iter functions
Date:   Wed, 13 May 2020 08:56:48 +0200
Message-Id: <20200513065656.2110441-7-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513065656.2110441-1-hch@lst.de>
References: <20200513065656.2110441-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just open coding the methods calls is a lot easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c              |  4 ++--
 drivers/target/target_core_file.c |  4 ++--
 fs/aio.c                          |  4 ++--
 fs/io_uring.c                     |  4 ++--
 fs/read_write.c                   | 12 ++++++------
 fs/splice.c                       |  2 +-
 include/linux/fs.h                | 12 ------------
 7 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e5..ad167050a4ec4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -572,9 +572,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 		kthread_associate_blkcg(cmd->css);
 
 	if (rw == WRITE)
-		ret = call_write_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
 	kthread_associate_blkcg(NULL);
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 7143d03f0e027..79f0707877917 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -303,9 +303,9 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		aio_cmd->iocb.ki_flags |= IOCB_DSYNC;
 
 	if (is_write)
-		ret = call_write_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&aio_cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&aio_cmd->iocb, &iter);
 
 	kfree(bvec);
 
diff --git a/fs/aio.c b/fs/aio.c
index 5f3d3d8149287..1ccc0efdc357d 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1540,7 +1540,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->read_iter(req, &iter));
 	kfree(iovec);
 	return ret;
 }
@@ -1580,7 +1580,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->write_iter(req, &iter));
 	}
 	kfree(iovec);
 	return ret;
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 979d9f977409a..59514051383e4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2582,7 +2582,7 @@ static int io_read(struct io_kiocb *req, bool force_nonblock)
 		ssize_t ret2;
 
 		if (req->file->f_op->read_iter)
-			ret2 = call_read_iter(req->file, kiocb, &iter);
+			ret2 = req->file->f_op->read_iter(kiocb, &iter);
 		else
 			ret2 = loop_rw_iter(READ, req->file, kiocb, &iter);
 
@@ -2697,7 +2697,7 @@ static int io_write(struct io_kiocb *req, bool force_nonblock)
 			current->signal->rlim[RLIMIT_FSIZE].rlim_cur = req->fsize;
 
 		if (req->file->f_op->write_iter)
-			ret2 = call_write_iter(req->file, kiocb, &iter);
+			ret2 = req->file->f_op->write_iter(kiocb, &iter);
 		else
 			ret2 = loop_rw_iter(WRITE, req->file, kiocb, &iter);
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 76be155ad9824..f0768313ea010 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -412,7 +412,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_init(&iter, READ, &iov, 1, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->read_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -481,7 +481,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_init(&iter, WRITE, &iov, 1, len);
 
-	ret = call_write_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->write_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ret > 0 && ppos)
 		*ppos = kiocb.ki_pos;
@@ -690,9 +690,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 
 	if (type == READ)
-		ret = call_read_iter(filp, &kiocb, iter);
+		ret = filp->f_op->read_iter(&kiocb, iter);
 	else
-		ret = call_write_iter(filp, &kiocb, iter);
+		ret = filp->f_op->write_iter(&kiocb, iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -961,7 +961,7 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = file->f_op->read_iter(iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -1025,7 +1025,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_write_iter(file, iocb, iter);
+	ret = file->f_op->write_iter(iocb, iter);
 	if (ret > 0)
 		fsnotify_modify(file);
 
diff --git a/fs/splice.c b/fs/splice.c
index fd0a1e7e5959a..a59d4fadf27fe 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -310,7 +310,7 @@ ssize_t generic_file_splice_read(struct file *in, loff_t *ppos,
 	i_head = to.head;
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = in->f_op->read_iter(&kiocb, &to);
 	if (ret > 0) {
 		*ppos = kiocb.ki_pos;
 		file_accessed(in);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 45cc10cdf6ddd..21f126957c2cf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1895,18 +1895,6 @@ struct inode_operations {
 	int (*set_acl)(struct inode *, struct posix_acl *, int);
 } ____cacheline_aligned;
 
-static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-				     struct iov_iter *iter)
-{
-	return file->f_op->read_iter(kio, iter);
-}
-
-static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
-				      struct iov_iter *iter)
-{
-	return file->f_op->write_iter(kio, iter);
-}
-
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	return file->f_op->mmap(file, vma);
-- 
2.26.2

