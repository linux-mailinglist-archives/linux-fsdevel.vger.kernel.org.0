Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE92298D2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775621AbgJZMvw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:51:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45368 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775615AbgJZMvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:51:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id e17so12349362wru.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2020 05:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eIClT5rENq9kBsjIFF+DaoCpFvJQstMih7FfG4bpQI=;
        b=JDXJgSQJ80djfaAPRIOkY7qkWmZDRbS9SFL476HVIgjsAc6wSRP1/i/v1IV8BMMYkp
         B0EXwBBKYxl9+AGFZ4g/QiSgQ2Qjwh8a1W9uCMGhSrkaoV9bhAc8vQKI0pMz4TpbVugL
         l9LBQsJCbYz7EZZ3ceGl/XYGw6QQ69Pz/gzHcm3PBAtl2mbGYSdGHgRqvLdZ6SALcNBG
         50tu3ZWj0GYObEaxLQ9JTZMCL1rHqgAMqIR4CCbY8sNXhD2dsInDHE5FmQQG9PozEd5f
         tT1UeQYxanLapsSaHir/m/ta4wr1rRd6ZAPhzMXeNtNrey4ICU9KsVoXmPtM9rHi8zlt
         JCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eIClT5rENq9kBsjIFF+DaoCpFvJQstMih7FfG4bpQI=;
        b=G6w7hU438lzrKyYF3K7Qetj/+Vk3DS1d9qaXVSkS7e9UlLaFXqyVcSx3Cb+BxVr8jx
         9RloRldfd3fcDAWcabXM6alEk469u1OMXKIIHogXV/ujZOC12TkWEFBl6Yvka8vlDdlZ
         ZViB6Qas8QITdkFOwg9QU2y9TvOFZRx60mHTwKDcYVqnBAl0uJEwlUH2cM9cTY3DcNd9
         Z6VKR8Tc5VCbCQqmSvcx2e30c7WIyrcFl33EQiHuqlBba1XeeqwNg6LGUHFwD6Oec2Hz
         dadiD96NWdjRcn2JhCXcsLwhe8y9DzQYXXRUBqBQRpBHneeUbXIfMDJdcn/pfBttPYVT
         F8Aw==
X-Gm-Message-State: AOAM5322UPowTon5pr9+o22umjOSgfy18FWEz5bWF6wYgqZSz/A0+F25
        KIp1G6fwW7TYCyfeAZpS5+/tQg==
X-Google-Smtp-Source: ABdhPJxnjjlEsdDTWZ5ovaMmfaaPyRK980t1YQWpq0a/B0eAQqt2YNlOhDcO6C7LQR2UDpxp+/8bJw==
X-Received: by 2002:a5d:410a:: with SMTP id l10mr17506394wrp.274.1603716709164;
        Mon, 26 Oct 2020 05:51:49 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id r1sm24423262wro.18.2020.10.26.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 05:51:48 -0700 (PDT)
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
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 4/5] fuse: Handle asynchronous read and write in passthrough
Date:   Mon, 26 Oct 2020 12:50:15 +0000
Message-Id: <20201026125016.1905945-5-balsini@android.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201026125016.1905945-1-balsini@android.com>
References: <20201026125016.1905945-1-balsini@android.com>
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
 fs/fuse/passthrough.c | 85 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 76 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 5a78cb336db4..10b6872cdaa7 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -6,6 +6,11 @@
 #include <linux/idr.h>
 #include <linux/uio.h>
 
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
 static void fuse_copyattr(struct file *dst_file, struct file *src_file)
 {
 	struct inode *dst = file_inode(dst_file);
@@ -32,6 +37,32 @@ static inline rwf_t iocb_to_rw_flags(int ifl)
 	return flags;
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
@@ -43,8 +74,23 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 	if (!iov_iter_count(iter))
 		return 0;
 
-	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
-			    iocb_to_rw_flags(iocb_fuse->ki_flags));
+	if (is_sync_kiocb(iocb_fuse)) {
+		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				    iocb_to_rw_flags(iocb_fuse->ki_flags));
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
@@ -57,19 +103,40 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough.filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
 
 	if (!iov_iter_count(iter))
 		return 0;
 
 	inode_lock(fuse_inode);
 
-	file_start_write(passthrough_filp);
-	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
-			     iocb_to_rw_flags(iocb_fuse->ki_flags));
-	file_end_write(passthrough_filp);
-	if (ret > 0)
-		fuse_copyattr(fuse_filp, passthrough_filp);
-
+	if (is_sync_kiocb(iocb_fuse)) {
+		file_start_write(passthrough_filp);
+		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				     iocb_to_rw_flags(iocb_fuse->ki_flags));
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
2.29.0.rc1.297.gfa9743e501-goog

