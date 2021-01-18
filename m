Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5262FAA83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437163AbhARTrx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437158AbhART3x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:29:53 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F5C061798
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so14704602wmh.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKB9lEn/LGchi0nKMk+V258K5toceSfY+t698Ueu4z0=;
        b=T5+u1mt0y6k6Isp16kGrpGqeV2EXtm82ppcOPxUDINZaE8bADOe/+j5oXkTeUPK7Ut
         NPvQnoU5pCdLkJUBw4zCxouiZ6LFW1HCXK9qKXuwIRH+VMvDSd7oWWLPEB56pO9ZDQWZ
         VYoaHP2SOlzIAP9ZkcK58QBXD3F3YJRKtvRqw9GXu80jDXX4ZBH3CVTj2ak/8PhqS59O
         /w5RehdRlne49H9NEATW8e39Ac5J4tJ2IKxYWTQx/odJLbyhjsyh2KYLXT8I3Oztjmkc
         k33n6y9UULrZFybJ9IzvIYWW4QP9dXN4OWhiiyzSgGcT00UQigExMLDXS0V0Qjr6bNI6
         nurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKB9lEn/LGchi0nKMk+V258K5toceSfY+t698Ueu4z0=;
        b=ilu7T60xRXiZRqfp2PyE1yBWo3v0oBb5AD5/xYfYdh7n0j7K7AYz6cNaQ6k3hYiLUx
         syWDgrXYSgdayB/l9pae8CfKUwWxxNtqtlFxXIWENbi9QSY7T2Br+GCEDwaOmeoMzQEE
         meU0v42X7+qZN+r9qMoMtHj/fxVHh5w/514cX62dFgf9ziMFCbu7OaGtvRJx+tnBoMOz
         +/5B1oT2BPy2CQ5qUsHTtjgpIxagrVaczBu93O36WkyXDOKBaNBGsRoQr9CS/jIMFHwj
         A+XoaSmGvxqRii6oTfWGCPXjqUJ7xzvU1nQ0e+WIRyCn589ssDzTeidveKn0Sxmoeg5b
         Dosg==
X-Gm-Message-State: AOAM5307rXDjbjFapY9o/2zUActaAshFumHMYsKkP0x3uJ0mOCGteno1
        eBLa2Jd6+i8kBoYFbC49/ruZSA==
X-Google-Smtp-Source: ABdhPJwQcXOU5kEucjd61L6MBal54u+GztUhYgmLeRB+UCDGBbBh4Hj6I74e2a6TNSRIkcYq9MozGQ==
X-Received: by 2002:a1c:e4c5:: with SMTP id b188mr842882wmh.78.1610998145235;
        Mon, 18 Jan 2021 11:29:05 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:29:04 -0800 (PST)
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
Subject: [PATCH RESEND V11 6/7] fuse: Handle asynchronous read and write in passthrough
Date:   Mon, 18 Jan 2021 19:27:47 +0000
Message-Id: <20210118192748.584213-7-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
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
When the lower file system AIO request is completed, the FUSE passthrough
AIO completion callback is executed and propagates the completion signal to
the FUSE AIO request by triggering its completion callback as well.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/passthrough.c | 89 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 8f6882a31a0b..da71a74014d7 100644
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
2.30.0.284.gd98b1dd5eaa7-goog

