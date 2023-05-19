Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D157097D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjESM6c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjESM6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:15 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F488187
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:29 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f41dceb9c9so22043975e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501044; x=1687093044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUs5OQwSuWFzIRmLv8qNMZ7hMdIuOAG4ihDCj/t7DwQ=;
        b=eiMOlwwKtdACcwQvpnmcyY9i6EraSSH4XrgPie99Dz2t3FIHbsqvu6cU+pF3Znefo5
         HacDikXLJOCTx0ohlWcHCQg7jj1RC8scdYN+b1MxAguJaVIllPAyFrsobSNYkaf2h7Ld
         JssHUnvaBbYC81PcS5ZjSt1SIhW58qQn39V17V0bRZFltD3UprRWPlqIRQTu1dq5BPp+
         1c8hpmo+Nemsbl1H/onvfhVE2Mo2HyMlpPvEs+z2ohPNOyAzANdyv3Yp9wkoqxzzaMG1
         wHvgo+5jiVHgBFiUfVre+rfyheD/IVh54M2ybGO35ezZRgwkBFYjEXUa4ZyyW78VuadP
         djIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501044; x=1687093044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUs5OQwSuWFzIRmLv8qNMZ7hMdIuOAG4ihDCj/t7DwQ=;
        b=EXXyUt45rGYgcPkG25C+YpTBj/bptZn3tp0JsupxOTZj/m9Db5HhOwzausacS1/P4i
         c3bOMNLTCcfbaE3yiQdzdnO+LVaVG4WTEIR04vNTplSTgyA41f3OK+k5aXd8NvItYtYg
         2D7XHTBZ9769JSM+dvkLpCuUt2O2GCin5PgFdk97hjesG1duazAprtrxhXCR87hbjE8l
         naRQewLblBYXzoSx9dNWLOfQKc7OubAmKLEWWG1JGKQaRu3YzfdtXlBURhwqe1c2X98Y
         rBweRRQPBULIuvqBGbBwCe4dc60WS60oOrvd2irCROJ8wVG0TAYtHSAmXYWASXQnlnun
         hk6g==
X-Gm-Message-State: AC+VfDytc1uHuXXh3oPl0gK8qhnYpU//CwrVPe03ZPY0/3a81ffp8kHp
        EdOsyNTw9zlLje3/YUJw7Kws/D9WPEI=
X-Google-Smtp-Source: ACHHUZ4gAY1IkhBMjsm+nZfruqgYmTsR2YXmXy19lba8ODn/8Ii1GVcSudr2owLsp4FY6fIAdUYREw==
X-Received: by 2002:a1c:4c10:0:b0:3f4:5058:a033 with SMTP id z16-20020a1c4c10000000b003f45058a033mr1291102wmf.24.1684501043845;
        Fri, 19 May 2023 05:57:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 08/10] fuse: update inode size/mtime after passthrough write
Date:   Fri, 19 May 2023 15:57:03 +0300
Message-Id: <20230519125705.598234-9-amir73il@gmail.com>
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

Similar to update size/mtime at the end of fuse_perform_write(),
we need to bump the attr version when we update the inode size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 53 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 10b370bcc423..8352d6b91e0e 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -14,15 +14,42 @@ struct fuse_aio_req {
 	struct kiocb *iocb_fuse;
 };
 
-static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req)
+static void fuse_file_start_write(struct file *fuse_file,
+				  struct file *backing_file,
+				  loff_t pos, size_t count)
+{
+	struct inode *inode = file_inode(fuse_file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (inode->i_size < pos + count)
+		set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+
+	file_start_write(backing_file);
+}
+
+static void fuse_file_end_write(struct file *fuse_file,
+				struct file *backing_file,
+				loff_t pos, ssize_t res)
+{
+	struct inode *inode = file_inode(fuse_file);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	file_end_write(backing_file);
+
+	fuse_write_update_attr(inode, pos, res);
+	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
+}
+
+static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req, long res)
 {
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
+	struct file *filp = iocb->ki_filp;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
 
 	if (iocb->ki_flags & IOCB_WRITE) {
-		__sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
-				      SB_FREEZE_WRITE);
-		file_end_write(iocb->ki_filp);
+		__sb_writers_acquired(file_inode(filp)->i_sb, SB_FREEZE_WRITE);
+		fuse_file_end_write(fuse_filp, filp, iocb->ki_pos, res);
 	}
 
 	iocb_fuse->ki_pos = iocb->ki_pos;
@@ -35,7 +62,7 @@ static void fuse_aio_rw_complete(struct kiocb *iocb, long res)
 		container_of(iocb, struct fuse_aio_req, iocb);
 	struct kiocb *iocb_fuse = aio_req->iocb_fuse;
 
-	fuse_aio_cleanup_handler(aio_req);
+	fuse_aio_cleanup_handler(aio_req, res);
 	iocb_fuse->ki_complete(iocb_fuse, res);
 }
 
@@ -71,7 +98,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
 		ret = call_read_iter(passthrough_filp, &aio_req->iocb, iter);
 		if (ret != -EIOCBQUEUED)
-			fuse_aio_cleanup_handler(aio_req);
+			fuse_aio_cleanup_handler(aio_req, ret);
 	}
 out:
 	revert_creds(old_cred);
@@ -87,22 +114,25 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough->filp;
 	struct inode *passthrough_inode = file_inode(passthrough_filp);
+	size_t count = iov_iter_count(iter);
 	const struct cred *old_cred;
 	ssize_t ret;
 	rwf_t rwf;
 
-	if (!iov_iter_count(iter))
+	if (!count)
 		return 0;
 
 	inode_lock(fuse_inode);
 
 	old_cred = override_creds(ff->passthrough->cred);
 	if (is_sync_kiocb(iocb_fuse)) {
-		file_start_write(passthrough_filp);
+		fuse_file_start_write(fuse_filp, passthrough_filp,
+				      iocb_fuse->ki_pos, count);
 		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
 		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
 				     rwf);
-		file_end_write(passthrough_filp);
+		fuse_file_end_write(fuse_filp, passthrough_filp,
+				    iocb_fuse->ki_pos, ret);
 	} else {
 		struct fuse_aio_req *aio_req;
 
@@ -112,7 +142,8 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 			goto out;
 		}
 
-		file_start_write(passthrough_filp);
+		fuse_file_start_write(fuse_filp, passthrough_filp,
+				      iocb_fuse->ki_pos, count);
 		__sb_writers_release(passthrough_inode->i_sb, SB_FREEZE_WRITE);
 
 		aio_req->iocb_fuse = iocb_fuse;
@@ -120,7 +151,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
 		ret = call_write_iter(passthrough_filp, &aio_req->iocb, iter);
 		if (ret != -EIOCBQUEUED)
-			fuse_aio_cleanup_handler(aio_req);
+			fuse_aio_cleanup_handler(aio_req, ret);
 	}
 out:
 	revert_creds(old_cred);
-- 
2.34.1

