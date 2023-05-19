Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394A37097D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjESM6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjESM6M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:12 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA2710E3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30959c0dfd6so340777f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501040; x=1687093040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NfCkAQ35AOMeZ0PU9XvE/RsIzU8MevcHDjanPn4djvM=;
        b=Kt7SnEglHDDop+f0D62Ta3jiJO5gtmpKpKbCbm9Owr1q3fhefbaqWhp7FtbhWM1Jz/
         HRBOrMKhX0mHNmI9ljFI4jcYGVuGZ/z+7h0OS4+Hj0NOdXV3L1En0xrfnKM39hEQ2Ly6
         cp0RTPSRVA+aawQtM0NIWvX3csYGQlY1RQ+AkxZVUfO+NWv8cJwepv8uRC+M/cmF8A8l
         AMBaT+SqQp3KC0ap9O75/SeK5NvLuEg8udnVgJxYL3mh90A6BPsQJsiWRbdEslbEsj2r
         q5EnJklrmTNM0S15xkNnmS5xVq/mUY1OSZuZHnvstg3H3ewIujmdouUP5ShnJpW1q/FY
         7FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501040; x=1687093040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfCkAQ35AOMeZ0PU9XvE/RsIzU8MevcHDjanPn4djvM=;
        b=aDjoOBafPpd01ZpUFInrNdq8KpDcBI+u3XxqChW44x9lf7syMNpCml26QIvIElFyS6
         nE1NNoOlLZpk48AxusxpiJu0o4A8Qiwa6Mdh+STfm944576iJLA/irtpxnlS5mSg2KjC
         MAHi8+R7fJz6taZ/XRsslo1WvoDy5kwNZ45UPR4IALf9/DhcdZG5Ou38drEcAyuJozSO
         NNWVFUqsXLuGQSght2yysvwyZBQ6vJKwFV4OOYByUSddwfOZnb09CntgyGLjU5t1gZTh
         BlOTdyBnhHKprwQX6ZSg3as6uoBvK/VU0NqbXTGERHmZx1gWaoUOenX9mzPOFUV3sMaD
         G7kg==
X-Gm-Message-State: AC+VfDzVX+m/TanS0JtHA98HPb85OG60+yG7lyig/iUC8O3meMt2Rq7u
        VKMy8NM7KbYFltbanQaelxg=
X-Google-Smtp-Source: ACHHUZ6HwcLi7BfaFXsa+nfH90CY/dq38WVnf1Xrvmotl/nFyNX5VUly7BO6lITSqssB8umaEdDmTQ==
X-Received: by 2002:adf:ffc8:0:b0:2ef:b123:46d9 with SMTP id x8-20020adfffc8000000b002efb12346d9mr2027993wrs.3.1684501039791;
        Fri, 19 May 2023 05:57:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:19 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 05/10] fuse: Handle asynchronous read and write in passthrough
Date:   Fri, 19 May 2023 15:57:00 +0300
Message-Id: <20230519125705.598234-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
References: <20230519125705.598234-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extend the passthrough feature by handling asynchronous IO both for read
and write operations.

When an AIO request is received, if the request targets a FUSE file with
the passthrough functionality enabled, a new identical AIO request is
created.  The new request targets the backing file and gets assigned
a special FUSE passthrough AIO completion callback.

When the backing file AIO request is completed, the FUSE
passthrough AIO completion callback is executed and propagates the
completion signal to the FUSE AIO request by triggering its completion
callback as well.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 82 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 9d81f3982c96..2ccd2d6de736 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -9,6 +9,36 @@
 #define FUSE_IOCB_MASK                                                  \
 	(IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
 
+struct fuse_aio_req {
+	struct kiocb iocb;
+	struct kiocb *iocb_fuse;
+};
+
+static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
+{
+	struct kiocb *iocb = &aio_req->iocb;
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	if (iocb->ki_flags & IOCB_WRITE) {
+		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
+				      SB_FREEZE_WRITE);
+		file_end_write(iocb->ki_filp);
+	}
+
+	iocb_fuse->ki_pos = iocb->ki_pos;
+	kfree(aio_req);
+}
+
+static void fuse_aio_rw_complete(struct kiocb *iocb, long res)
+{
+	struct fuse_aio_req *aio_req =
+		container_of(iocb, struct fuse_aio_req, iocb);
+	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+
+	fuse_aio_cleanup_handler(aio_req);
+	iocb_fuse->ki_complete(iocb_fuse, res);
+}
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 				   struct iov_iter *iter)
 {
@@ -21,8 +51,24 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 	if (!iov_iter_count(iter))
 		return 0;
 
-	rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
-	ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos, rwf);
+	if (is_sync_kiocb(iocb_fuse)) {
+		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
+		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				    rwf);
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
@@ -34,6 +80,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough->filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
 	ssize_t ret;
 	rwf_t rwf;
 
@@ -42,11 +89,32 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 
 	inode_lock(fuse_inode);
 
-	file_start_write(passthrough_filp);
-	rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
-	ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos, rwf);
-	file_end_write(passthrough_filp);
-
+	if (is_sync_kiocb(iocb_fuse)) {
+		file_start_write(passthrough_filp);
+		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
+		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				     rwf);
+		file_end_write(passthrough_filp);
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
2.34.1

