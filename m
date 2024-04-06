Return-Path: <linux-fsdevel+bounces-16256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5F389A8F1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 07:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBBB61C21070
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 05:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AD1BC46;
	Sat,  6 Apr 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GIQHNgVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F5139F
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Apr 2024 05:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712379757; cv=none; b=P0i9S0QwPi9j4aJ4X0uZyWUGWlP0QsAUm4zV86TewwygU3/z/85sxvtDmA9Uk8ERPc40pFstzoKwk4a5agx+drbBTYCsJLeN88lvoRFKlQO8cXH9Tc2VoVPnSfxV3y3qTpmU4PxYuzWrPpyF+zaVwJs+CMG8rfX9OfjxX8/qxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712379757; c=relaxed/simple;
	bh=zETyBS9MplTWs8W+F8isZHcyAzyohyE2BEaLnJHA+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVPert6UdLzBxX8MP87HyXPGrptMkvu1e91nu4Ok7fD00uI4CtOkLcaV+FdfuY/pt7b35ZHp3e7rneHYzj+Xd4jd9waTdWXW/il9Vl5xudj9Skwo2PisbRwODLPiSANj7jGaiVz+KAXi1o2JsdzTYR13RBobMCRnDYGjJYoJKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GIQHNgVP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aur0Nt4a1nkHmg+IpYrfUPf5w3lyl6emUYlH5WHvu8k=; b=GIQHNgVP+R8Xw6wkCW7cxR3RJs
	UmJvaeX1fIbLGC0X8q1D/w+C9YNfzHSPO+/N9A8TB4ys1Vvxzr2xDS8L1ErDyFyr0PHWZhustqY5W
	SL41fruCZlkbeOjrd8q/+XjQnVremGRsP+dWqntXiEeAeClZCzCT/QHWUqjyoZ/sdrXQP0Jl4IBc7
	UKuy0QB3Gf55K8oHY00QcL6EIiXBYlmgWSLge/oyRtOd67bXw3qxNqZm28hbZLNZTYnTIVE4DzZYq
	iytqZprWdSztw/zztbosJHSTazfa0bt/AsceYHUN8QUpQP7aOo/vwJrWkNEUM2rmZhlu66zCGepFT
	rAAfDNoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rsyCH-006r1P-2U;
	Sat, 06 Apr 2024 05:02:33 +0000
Date: Sat, 6 Apr 2024 06:02:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian@brauner.io>
Subject: [PATCH 6/6] remove call_{read,write}_iter() functions
Message-ID: <20240406050233.GF1632446@ZenIV>
References: <20240406045622.GY538574@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406045622.GY538574@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

From d8c77afeb9912f5eca06f53cbed7fc618c71b46b Mon Sep 17 00:00:00 2001
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Mon, 28 Aug 2023 17:13:18 +0200
Subject: [PATCH 6/6] remove call_{read,write}_iter() functions

These have no clear purpose.  This is effectively a revert of commit
bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()").

The patch was created with the help of a coccinelle script.

Fixes: bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/block/loop.c              |  4 ++--
 drivers/target/target_core_file.c |  4 ++--
 fs/aio.c                          |  4 ++--
 fs/read_write.c                   | 12 ++++++------
 fs/splice.c                       |  4 ++--
 include/linux/fs.h                | 12 ------------
 io_uring/rw.c                     |  4 ++--
 7 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fe..93780f41646b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -445,9 +445,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
-		ret = call_write_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4d447520bab8..94e6cd4e7e43 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -299,9 +299,9 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		aio_cmd->iocb.ki_flags |= IOCB_DSYNC;
 
 	if (is_write)
-		ret = call_write_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&aio_cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&aio_cmd->iocb, &iter);
 
 	if (ret != -EIOCBQUEUED)
 		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
diff --git a/fs/aio.c b/fs/aio.c
index 9cdaa2faa536..13ca81c7c744 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1605,7 +1605,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->read_iter(req, &iter));
 	kfree(iovec);
 	return ret;
 }
@@ -1636,7 +1636,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		if (S_ISREG(file_inode(file)->i_mode))
 			kiocb_start_write(req);
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->write_iter(req, &iter));
 	}
 	kfree(iovec);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..2de7f6adb33d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -392,7 +392,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_DEST, buf, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->read_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -494,7 +494,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
 
-	ret = call_write_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->write_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ret > 0 && ppos)
 		*ppos = kiocb.ki_pos;
@@ -736,9 +736,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
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
@@ -799,7 +799,7 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = file->f_op->read_iter(iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -860,7 +860,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 		return ret;
 
 	kiocb_start_write(iocb);
-	ret = call_write_iter(file, iocb, iter);
+	ret = file->f_op->write_iter(iocb, iter);
 	if (ret != -EIOCBQUEUED)
 		kiocb_end_write(iocb);
 	if (ret > 0)
diff --git a/fs/splice.c b/fs/splice.c
index 218e24b1ac40..60aed8de21f8 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -362,7 +362,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = in->f_op->read_iter(&kiocb, &to);
 
 	if (ret > 0) {
 		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
@@ -740,7 +740,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		init_sync_kiocb(&kiocb, out);
 		kiocb.ki_pos = sd.pos;
-		ret = call_write_iter(out, &kiocb, &from);
+		ret = out->f_op->write_iter(&kiocb, &from);
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 143e967a3af2..a94343f567cb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2096,18 +2096,6 @@ struct inode_operations {
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
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
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 0585ebcc9773..7d335b7e00ed 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -701,7 +701,7 @@ static inline int io_iter_do_read(struct io_rw *rw, struct iov_iter *iter)
 	struct file *file = rw->kiocb.ki_filp;
 
 	if (likely(file->f_op->read_iter))
-		return call_read_iter(file, &rw->kiocb, iter);
+		return file->f_op->read_iter(&rw->kiocb, iter);
 	else if (file->f_op->read)
 		return loop_rw_iter(READ, rw, iter);
 	else
@@ -1047,7 +1047,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
-		ret2 = call_write_iter(req->file, kiocb, &s->iter);
+		ret2 = req->file->f_op->write_iter(kiocb, &s->iter);
 	else if (req->file->f_op->write)
 		ret2 = loop_rw_iter(WRITE, rw, &s->iter);
 	else
-- 
2.39.2


