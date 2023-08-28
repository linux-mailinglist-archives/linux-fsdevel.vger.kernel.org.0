Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55078B428
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 17:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjH1POW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 11:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbjH1PON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68344189
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693235606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xBylffIH0dxFZUyprPvL2VE3IeE26Ai49OUFXCFXyN0=;
        b=c5bXLRMCojnuNChuTID0cN1K4JUqScO3QLn541vUeXYgzh+fKSWTKQ3qdIOcnEIhxDBGob
        Hw9NGTRwrrb+ovDGUbniJuhEm6O9OErAyVFmbHB5DdJCvQkdG3E9JMhl1jsNcNgICaPQQ8
        tbk7MLWExu7xlhpD+YX2dqxKyNLu+bo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-wIva0EJYNBWsKYtl7ucrHQ-1; Mon, 28 Aug 2023 11:13:25 -0400
X-MC-Unique: wIva0EJYNBWsKYtl7ucrHQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a5952a0b20so125366766b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 08:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693235603; x=1693840403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBylffIH0dxFZUyprPvL2VE3IeE26Ai49OUFXCFXyN0=;
        b=hie+bjoBYHhuiBW0QKE56AzJcazoFXnJWCNfeH+B3Rq7NtEKooJl6eR//tjQY7+37+
         A3xyAXWDdsFwv4JhlnhPzYwaLPcSTarbnWxhN+Xk3tzi45t4OIVa2Voe8j7+yQGAI5F4
         LbCAY4zHdOInsWiX1TS1CiSAoXv4484eR8H0cr5D3VWGKX7WDAUiz6yzb/PTRRB3mW+k
         Q8zzahKIXKIhW23gXu/ghDuBDDgXKiC1FxyBBrLlcFDQorkqhQTDCpu7rH6JVtlbXnsA
         hDpzeIc2hvHV8b5DycOGIXpOMANNXXb+1JeZHDQXT2om0H1Re3HwAD2H7S6qzoL0CKLF
         9LEQ==
X-Gm-Message-State: AOJu0YxN0cxCPnxesd7KgTuGFq0EKFZNv2J6JyKcT1pvRsaNAhOqEO8w
        rv+Fbo7tVyrKZo1PJqC8FfvhkRxj7zFWejkMkqAvs7tD3OeiUliEff8VrdLV9k5VDlk2FAXm9pG
        8uyc2fo9NmrKQrM1pHV7La/BK3HqBs2mTGXjrd/N0PKzSSEhK6xFDkn6C72iFPU+Belvo6bLqif
        EjoxuyekSRrw==
X-Received: by 2002:a17:907:271a:b0:9a1:d7cd:6028 with SMTP id w26-20020a170907271a00b009a1d7cd6028mr10855509ejk.56.1693235603207;
        Mon, 28 Aug 2023 08:13:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNra/xYYjFd3Chto1cDKEHRMOZle+rwmT5fetHEG0D3FgsnH5PCAa7BHZH/zHyo/ZqsT1+ew==
X-Received: by 2002:a17:907:271a:b0:9a1:d7cd:6028 with SMTP id w26-20020a170907271a00b009a1d7cd6028mr10855487ejk.56.1693235602788;
        Mon, 28 Aug 2023 08:13:22 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (87-97-53-100.pool.digikabel.hu. [87.97.53.100])
        by smtp.gmail.com with ESMTPSA id gy25-20020a170906f25900b00985ed2f1584sm4764737ejb.187.2023.08.28.08.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 08:13:20 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] remove call_{read,write}_iter() functions
Date:   Mon, 28 Aug 2023 17:13:18 +0200
Message-Id: <20230828151318.113478-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These have no clear purpose.  This is effectively a revert of commit
bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()").

The patch was created with the help of a coccinelle script.

Fixes: bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 drivers/block/loop.c              |  4 ++--
 drivers/target/target_core_file.c |  4 ++--
 fs/aio.c                          |  4 ++--
 fs/read_write.c                   | 12 ++++++------
 fs/splice.c                       |  2 +-
 include/linux/fs.h                | 12 ------------
 io_uring/rw.c                     |  4 ++--
 7 files changed, 15 insertions(+), 27 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 637c5bda2387..7d7d7b3e5dc2 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -449,9 +449,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
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
index 77e33619de40..862987d19e4e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1553,7 +1553,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->read_iter(req, &iter));
 	kfree(iovec);
 	return ret;
 }
@@ -1593,7 +1593,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 			__sb_writers_release(file_inode(file)->i_sb, SB_FREEZE_WRITE);
 		}
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->write_iter(req, &iter));
 	}
 	kfree(iovec);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..b2f6c4f21817 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -386,7 +386,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_DEST, buf, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->read_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -488,7 +488,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
 
-	ret = call_write_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->write_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ret > 0 && ppos)
 		*ppos = kiocb.ki_pos;
@@ -730,9 +730,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
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
@@ -821,7 +821,7 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = file->f_op->read_iter(iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -885,7 +885,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_write_iter(file, iocb, iter);
+	ret = file->f_op->write_iter(iocb, iter);
 	if (ret > 0)
 		fsnotify_modify(file);
 
diff --git a/fs/splice.c b/fs/splice.c
index 3e2a31e1ce6a..366b19aa4878 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -364,7 +364,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = in->f_op->read_iter(&kiocb, &to);
 
 	if (ret > 0) {
 		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..e8fcefc71872 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1865,18 +1865,6 @@ struct inode_operations {
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
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
index 1bce2208b65c..429e067c515d 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -642,7 +642,7 @@ static inline int io_iter_do_read(struct io_rw *rw, struct iov_iter *iter)
 	struct file *file = rw->kiocb.ki_filp;
 
 	if (likely(file->f_op->read_iter))
-		return call_read_iter(file, &rw->kiocb, iter);
+		return file->f_op->read_iter(&rw->kiocb, iter);
 	else if (file->f_op->read)
 		return loop_rw_iter(READ, rw, iter);
 	else
@@ -917,7 +917,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
-		ret2 = call_write_iter(req->file, kiocb, &s->iter);
+		ret2 = req->file->f_op->write_iter(kiocb, &s->iter);
 	else if (req->file->f_op->write)
 		ret2 = loop_rw_iter(WRITE, rw, &s->iter);
 	else
-- 
2.40.1

