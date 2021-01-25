Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB93049B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 21:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729885AbhAZFZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbhAYPmM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:12 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0D0C061D73
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:14 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b5so13042497wrr.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvDUp1MzEWxghIK3ZwzGMuRqEDjs1vp2utVl4yg2BMY=;
        b=ihuQBXJQqcV0KHYVyowgmAWkU5i4M+n8a4Y1xZOwAfNPR/1e34pwStDLhjX0b523ZF
         B/lpBXGwUbl5fHkkN0+vJo5UzKxluVzrzRl0jB3ffYN8ZkCfj/1OESuBltpZDHvwlpLZ
         E9uc5mxAC0c/f+V5OlBJCix/DggmtXel5yKDJ5XmKzr3EyaGmBdbSyoPdmk9zoqiJQgr
         2uEnt0rP0YnGET8Dg7DJycrVhTN177w0YFu3fHVIymAsckAassNlniCOY9cXbnR47mrH
         t/hUlTAeaKJLTdPINMFbfBXdczTGtfpO8RzXRRv6h+8oIKOFlu7XBpF/AtGdsogxPmod
         ovuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvDUp1MzEWxghIK3ZwzGMuRqEDjs1vp2utVl4yg2BMY=;
        b=OLvDRbkHNEQsYMsybDlR+JzzLqXk/By+6oMuBSpdGe0jxGtHp/BsmgFXLT+N98cDFf
         ArkbAj75u8zERaEOinaYT+mI6iAFUViEfGRKb4b1BHRrLHTw4kJFMTFSXmeNoBwbptGl
         +93Ar6cb2x2UxxHVAVhMi+ZUvX8vzSJkfRlePtUqyjlRbr1m3+rC42BCkkY2cOmNxgpG
         JUR28RyFmw2CfbyGv72PKpUEleNz4UgFTOOidLzNB9sVIlHQbEbt/z1qWir1sIzxXT84
         HN95ctp1y5dFbe3ASvHc7FNdJo27gr0l2DsDB3MHJin50NL8dg1Tqd+tI6TNWW0cbczi
         eHWA==
X-Gm-Message-State: AOAM5316Q39k30xz/R94lE6+oGCIRDuRe46rYb7dY2H0eJojlu0wHfyR
        iz70xF4qGH/s2dGJJYP+ypLk9A==
X-Google-Smtp-Source: ABdhPJzswhyj4Q4ni8SAtO/j8cwjUv2fd1EtXxmMgTyaCO4FiNq4r9s3wF3VYMq6kEMvuP16YtYfig==
X-Received: by 2002:a5d:47a2:: with SMTP id 2mr1559520wrb.393.1611588673053;
        Mon, 25 Jan 2021 07:31:13 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:12 -0800 (PST)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V12 6/8] fuse: Handle asynchronous read and write in passthrough
Date:   Mon, 25 Jan 2021 15:30:55 +0000
Message-Id: <20210125153057.3623715-7-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the passthrough feature by handling asynchronous IO both for read
and write operations.

When an AIO request is received, if the request targets a FUSE file with
the passthrough functionality enabled, a new identical AIO request is
created. The new request targets the lower file system file and gets
assigned a special FUSE passthrough AIO completion callback.
When the lower file system AIO request is completed, the FUSE
passthrough AIO completion callback is executed and propagates the
completion signal to the FUSE AIO request by triggering its completion
callback as well.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/passthrough.c | 89 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index d949ca07a83b..c7fa1eeb7639 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -9,6 +9,11 @@
 #define PASSTHROUGH_IOCB_MASK                                                  \
 	(IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
 
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
 static void fuse_copyattr(struct file *dst_file, struct file *src_file)
 {
 	struct inode *dst = file_inode(dst_file);
@@ -17,6 +22,32 @@ static void fuse_copyattr(struct file *dst_file, struct file *src_file)
 	i_size_write(dst, i_size_read(src));
 }
 
+static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		file_end_write(iocb->ki_filp);
+		fuse_copyattr(iocb_fuse->ki_filp, iocb->ki_filp);
+	}
+
+	iocb_fuse->ki_pos = iocb->ki_pos;
+	kfree(aio_req);
+}
+
+static void fuse_aio_rw_complete(struct kiocb *iocb, long res, long res2)
+{
+	struct fuse_aio_req *aio_req =
+		container_of(iocb, struct fuse_aio_req, iocb);
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	fuse_aio_cleanup_handler(aio_req);
+	iocb_fuse->ki_complete(iocb_fuse, res, res2);
+}
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 				   struct iov_iter *iter)
 {
@@ -28,9 +59,24 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
-			    iocb_to_rw_flags(iocb_fuse->ki_flags,
-					     PASSTHROUGH_IOCB_MASK));
+	if (is_sync_kiocb(iocb_fuse)) {
+		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				    iocb_to_rw_flags(iocb_fuse->ki_flags,
+						     PASSTHROUGH_IOCB_MASK));
+	} else {
+		struct fuse_aio_req *aio_req;
+
+		aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
+		if (!aio_req)
+			return -ENOMEM;
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = call_read_iter(passthrough_filp, &aio_req->iocb, iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
+	}
 
 	return ret;
 }
@@ -43,20 +89,41 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough.filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
 
 	if (!iov_iter_count(iter))
 		return 0;
 
 	inode_lock(fuse_inode);
 
-	file_start_write(passthrough_filp);
-	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
-			     iocb_to_rw_flags(iocb_fuse->ki_flags,
-					      PASSTHROUGH_IOCB_MASK));
-	file_end_write(passthrough_filp);
-	if (ret > 0)
-		fuse_copyattr(fuse_filp, passthrough_filp);
-
+	if (is_sync_kiocb(iocb_fuse)) {
+		file_start_write(passthrough_filp);
+		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				     iocb_to_rw_flags(iocb_fuse->ki_flags,
+						      PASSTHROUGH_IOCB_MASK));
+		file_end_write(passthrough_filp);
+		if (ret > 0)
+			fuse_copyattr(fuse_filp, passthrough_filp);
+	} else {
+		struct fuse_aio_req *aio_req;
+
+		aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
+		if (!aio_req) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		file_start_write(passthrough_filp);
+		__sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
+
+		aio_req->iocb_fuse = iocb_fuse;
+		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
+		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
+		ret = call_write_iter(passthrough_filp, &aio_req->iocb, iter);
+		if (ret != -EIOCBQUEUED)
+			fuse_aio_cleanup_handler(aio_req);
+	}
+out:
 	inode_unlock(fuse_inode);
 
 	return ret;
-- 
2.30.0.280.ga3ce27912f-goog

