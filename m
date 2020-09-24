Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF1F2771F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgIXNNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgIXNN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:13:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6415C0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a17so3772224wrn.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SnFurKpeBkbwLq0KOJ5lvNPVyL4t0UDoYrGfHs7nv0A=;
        b=c49kIoCNMCWuGzzxSiHgueczTg5CkgrwLkGuWWq0FAGajSgKan0mFscWOzZVZ+m05d
         RbXYXA5FxFJCeXX7mCyh/aiJnyvqxapJeon+80154c1bUNnQb82F4gdw7Ej5UktyMO7k
         rdobOrqsNJFec7D8/br7wA47DdV9NURPNYsPThcpOki9m0thIqLiLbuRY4FgjXMsR04N
         SgpRRL5PtFgFAYE/gC7RVtUpmBRrctaosbCu9mkSBwDACxmcy70fQW+z6IZaqNo6orLr
         KL9ZHtgqVaorBff9YMt60zaVL854011zyCBngVeDEpHIO6pUMJdPr0mg9vOQxDHTy24j
         Fobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnFurKpeBkbwLq0KOJ5lvNPVyL4t0UDoYrGfHs7nv0A=;
        b=tFkpah3VYbg2rpwS2rYwxFR80aCT9zMpYBGPQJ/SdFX+B60N7yBV73cY/x38cBOmuB
         hs5L88Sr/oCeYs8zXg5nIA4e5742Z/4hIIgnarf5QcxHqJgjsn4XgfV6PO3lDV49x+GD
         +eTOnYUBnTWGrTFUDTNBPG8cnS13qllDokh49znAnb6qz43DdSNHkcOfdVatAfvNSImz
         +72T8IQT9ME++OcoYwXCDj3WvP7N2As/y2azdadkCvZMcMzyD8Y0Q41t6ZuvQZvIt4nf
         fDvBjSjPRcc2Y5qTxZAqxd4xi8pqUzEAyB6G1qFt2YHJgJ8jQdZx2u+FqWH43nyPAGiQ
         WtgA==
X-Gm-Message-State: AOAM531ZbIn0ln4uotQHmHlITqx6WHgyCLILGzmaIsBPbg/lI0jXhs26
        QlD6RjDyQarHJNnE6q5a63vXCA==
X-Google-Smtp-Source: ABdhPJwK71YGbcO6RW1+2r9ehrDaUmk/rj/VmGPTl16ohLV3Ibabs4NOTPjOmXGkw+O1V+VCBcxg2g==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr5608662wrm.0.1600953206542;
        Thu, 24 Sep 2020 06:13:26 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k22sm3805044wrd.29.2020.09.24.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
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
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 4/4] fuse: Handle asynchronous read and write in passthrough
Date:   Thu, 24 Sep 2020 14:13:18 +0100
Message-Id: <20200924131318.2654747-5-balsini@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
References: <20200924131318.2654747-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the passthrough feature by handling asynchronous IO both for read
and write operations.

When an AIO request is received, if the request targets a FUSE file with
the passthrough functionality enabled, a new identical AIO request is
created. The new request targets the lower file system file, and gets
assigned a special FUSE passthrough AIO completion callback.
When the lower file system AIO request is completed, the FUSE passthrough
AIO completion callback is executed and propagates the completion signal to
the FUSE AIO request by triggering its completion callback as well.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/passthrough.c | 64 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index f70c0ef6945b..b7d1a5517ffd 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -4,6 +4,11 @@
 
 #include <linux/uio.h>
 
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
 static void fuse_copyattr(struct file *dst_file, struct file *src_file)
 {
 	struct inode *dst = file_inode(dst_file);
@@ -39,6 +44,32 @@ fuse_passthrough_override_creds(const struct file *fuse_filp)
 	return override_creds(fc->creator_cred);
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
@@ -56,7 +87,18 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
 				    iocbflags_to_rwf(iocb_fuse->ki_flags));
 	} else {
-		ret = -EIO;
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
 	}
 	revert_creds(old_cred);
 
@@ -72,6 +114,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough_filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
 
 	if (!iov_iter_count(iter))
 		return 0;
@@ -87,8 +130,25 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 		if (ret > 0)
 			fuse_copyattr(fuse_filp, passthrough_filp);
 	} else {
-		ret = -EIO;
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
 	}
+out:
 	revert_creds(old_cred);
 	inode_unlock(fuse_inode);
 
-- 
2.28.0.681.g6f77f65b4e-goog

