Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3707097D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbjESM6d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjESM6P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:15 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE66F1A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:29 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f427118644so31291755e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501045; x=1687093045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u9VxBMZPGYf+c2R53dKXDbbBJGM0bbTYdDzTM1sa4M=;
        b=FtrjhRn6MiN7yDeFBxXPCNK+k8KYUktRCZeRs/qI27KI97XnVdTKPXECO2Un1wrzVW
         WfeSBYThL0nHBT/1oehJaeOUDe6H/fFgpRMPLKoVyh6W5X31kyAfmxGP/YBq0hjUdBHe
         dt/pyMEXze880IZt7ocWi3RqH0OrZ77mFpkMQl/kfuk7i8bAw9KaKtjc1kLGF/e3pijb
         wEvuNn2vKx03THmFWHqCs5gGgsvJ35+4/IS/7GcYOJmwW2pFVe5as1QoTd2CWcdtizNn
         hmDZ8QualPfvH+KkgycpuwZ6dSrMDtuYESdmdpPT2Mkinn+eV7w67dj1HsB508kR6872
         VFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501045; x=1687093045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u9VxBMZPGYf+c2R53dKXDbbBJGM0bbTYdDzTM1sa4M=;
        b=X6TETjoyNqVLe7IRQY12WFujFBvTd0vVmArXnO5jsHDawXsI7l3Hoeo3UFm9a/e/0Q
         4Y+ImAFwEnSglbf4qnGBR2pB92AkxAl3mY2J9w4EOufkx6vAFYFm+x3dZ/d+kT+ajtVU
         sMhk+8Z73YPwTuX6PzAO2r2mHcASGhC04qHvD0wMJVjPh1ZAJFdvuuwtS6F4ZZS3SAYs
         0iUENQMjdGJIhebKcT49pAmvj3k8m2rkK5YitDNJjcW5D4kP+3PKZj8OPN136urlFrmT
         W4QkdeL8BM160BCgn+HUyklM+4iDpjjIUXGXFzZFvZoLu6I8K3qGpo5q/dWTbs4AtvY+
         uWWg==
X-Gm-Message-State: AC+VfDynPVFkrquTJgtq0/hZ3U/K3OKxO4ZEyU3JCQ7UaQ9m73a8lGTT
        qVlNkvarD8Fv1b/qxd3yODY=
X-Google-Smtp-Source: ACHHUZ5MMKPQv5/tH/tKyuJDrJqL4kNUKEjKiE+N2t9rYHgsCqPaBt2Mqp8R4+BU9TCtIumZ5ARW+Q==
X-Received: by 2002:a7b:cd01:0:b0:3f1:72ec:4009 with SMTP id f1-20020a7bcd01000000b003f172ec4009mr1228039wmj.9.1684501045117;
        Fri, 19 May 2023 05:57:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:24 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 09/10] fuse: invalidate atime after passthrough read/mmap
Date:   Fri, 19 May 2023 15:57:04 +0300
Message-Id: <20230519125705.598234-10-amir73il@gmail.com>
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

Similar to invalidate atime in fuse_readpages_end().

To minimize requests to server, invalidate atime only if the backing
inode atime has changed during the operation.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/passthrough.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 8352d6b91e0e..2b745b6b2364 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -12,6 +12,7 @@
 struct fuse_aio_req {
 	struct kiocb iocb;
 	struct kiocb *iocb_fuse;
+	struct timespec64 pre_atime;
 };
 
 static void fuse_file_start_write(struct file *fuse_file,
@@ -40,6 +41,21 @@ static void fuse_file_end_write(struct file *fuse_file,
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 }
 
+static void fuse_file_start_read(struct file *backing_file,
+				 struct timespec64 *pre_atime)
+{
+	*pre_atime = file_inode(backing_file)->i_atime;
+}
+
+static void fuse_file_end_read(struct file *fuse_file,
+			       struct file *backing_file,
+			       struct timespec64 *pre_atime)
+{
+	/* Mimic atime update policy of passthrough inode, not the value */
+	if (!timespec64_equal(&file_inode(backing_file)->i_atime, pre_atime))
+		fuse_invalidate_atime(file_inode(fuse_file));
+}
+
 static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req, long res)
 {
 	struct kiocb *iocb = &aio_req->iocb;
@@ -50,6 +66,8 @@ static void fuse_aio_cleanup_handler(struct fuse_aio_req *aio_req, long res)
 	if (iocb->ki_flags & IOCB_WRITE) {
 		__sb_writers_acquired(file_inode(filp)->i_sb, SB_FREEZE_WRITE);
 		fuse_file_end_write(fuse_filp, filp, iocb->ki_pos, res);
+	} else {
+		fuse_file_end_read(fuse_filp, filp, &aio_req->pre_atime);
 	}
 
 	iocb_fuse->ki_pos = iocb->ki_pos;
@@ -81,9 +99,13 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 
 	old_cred = override_creds(ff->passthrough->cred);
 	if (is_sync_kiocb(iocb_fuse)) {
+		struct timespec64 pre_atime;
+
 		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
+		fuse_file_start_read(passthrough_filp, &pre_atime);
 		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
 				    rwf);
+		fuse_file_end_read(fuse_filp, passthrough_filp, &pre_atime);
 	} else {
 		struct fuse_aio_req *aio_req;
 
@@ -94,6 +116,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		}
 
 		aio_req->iocb_fuse = iocb_fuse;
+		fuse_file_start_read(passthrough_filp, &aio_req->pre_atime);
 		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
 		aio_req->iocb.ki_complete = fuse_aio_rw_complete;
 		ret = call_read_iter(passthrough_filp, &aio_req->iocb, iter);
@@ -166,6 +189,7 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	const struct cred *old_cred;
 	struct fuse_file *ff = file->private_data;
 	struct file *passthrough_filp = ff->passthrough->filp;
+	struct timespec64 pre_atime;
 
 	if (!passthrough_filp->f_op->mmap)
 		return -ENODEV;
@@ -176,7 +200,9 @@ ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
 	vma->vm_file = get_file(passthrough_filp);
 
 	old_cred = override_creds(ff->passthrough->cred);
+	fuse_file_start_read(passthrough_filp, &pre_atime);
 	ret = call_mmap(vma->vm_file, vma);
+	fuse_file_end_read(file, passthrough_filp, &pre_atime);
 	revert_creds(old_cred);
 
 	if (ret)
-- 
2.34.1

