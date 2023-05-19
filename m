Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7407097D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbjESM6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjESM6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEEA10E6
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:24 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3078cc99232so3085890f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501041; x=1687093041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPqmrL0mnZ7qe/E9Rpc117PrA+EFnmfyd2e2nb1dpUM=;
        b=DKJ72ZXrzu9F18Fr8S8S66IHw6Ksy5y1KvTkjPtc2gv7ohnBCq9xIqJftAWhJ/Kefm
         UkhiS/fieWeSYi9hVBLHXKWvZVlZGInH/n38y/07lL/2ABdlcyr8FT6jbpbjYjlFsg7w
         XMSpqC0fjZNFHV4uK/OIyYFEx5F7cucfIOEAcdODqNngYS2zb3ooAJh93DzXtdhx4gxE
         hhhW4kWHqyuJy3itARLtL3Fpk+3ciouDMzejozbBL3BZyHq7XmVQfl/v4m/3BSb3Cx2T
         7S1G7MNIXKJOdesRnVn94cA/pM8Yo2IeRbRVsD2in2VpYtux5ONQToisNxyogOIrc1pQ
         mHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501041; x=1687093041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPqmrL0mnZ7qe/E9Rpc117PrA+EFnmfyd2e2nb1dpUM=;
        b=UKCH6X7wWqLtrxFo3/yKb17JzXvgqIUMhvcnlhp5IJKRxeYifexkWv1ZuFQNGaQFs1
         D8VpfQWtNHG1zZ5kTM8UgLtjojEEWejbUbHu3/FEZ/jfgKVH+pTojqYQnyNDuK5QmLtT
         6l0t6u72yQJpbbARLWSeeJUM5Y77oDZ0zNQvp+VKaDRie1zO5j0XpneBn9TArniQOCxq
         qOJT6fOG4nusTZrIqjbSjMwiJC3JjZ330+lGW/bSeGOcJM/RHPpyM99N92w2Fwz1ekL5
         D4FsgI6rIEEHqjxCOKKPdr92zv/fEh0vRcuSB+CnB875u/lwu5UhyxsHAg3dMPjyBDWQ
         qN+g==
X-Gm-Message-State: AC+VfDxZAFDz+nCXfWMWI8WG+6NIVma7mQDLoe5U9ijkwFFyowJTGIsp
        rPZdGkIXLabLq3oAngitHoLTlhhP9Qc=
X-Google-Smtp-Source: ACHHUZ7yoSwmqeZ6TkKbOiKYzToC7Dt1pBzPgDvo6OUMj5jJwGbq7uVtMdvXxiMpjqE08cadeO14Bw==
X-Received: by 2002:adf:ea4b:0:b0:307:c1cb:425b with SMTP id j11-20020adfea4b000000b00307c1cb425bmr1644997wrn.70.1684501041262;
        Fri, 19 May 2023 05:57:21 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:20 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 06/10] fuse: Use daemon creds in passthrough mode
Date:   Fri, 19 May 2023 15:57:01 +0300
Message-Id: <20230519125705.598234-7-amir73il@gmail.com>
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

When using FUSE passthrough, read/write operations are directly
forwarded to the backing file through VFS, but there is no guarantee
that the process that is triggering the request has the right
permissions to access the backing file.  This would cause the
read/write access to fail.

In a passthrough FUSE filesystems, where the FUSE daemon is responsible
for the enforcement of the backing file access policies, often happens
that the process dealing with the FUSE filesystem doesn't have access
to the backing file.

Being the FUSE daemon in charge of implementing the FUSE file operations,
that in the case of read/write operations usually simply results in the
copy of memory buffers from/to the backing filesystem respectively,
these operations are executed with the FUSE daemon privileges.

This patch adds a reference to the FUSE daemon credentials, referenced
at FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() time so that they can be used
to temporarily override the user credentials when accessing backing file
in passthrough operations.

The process accessing the FUSE file with passthrough enabled temporarily
receives the privileges of the FUSE daemon while performing read/write
operations. Similar behavior is implemented in overlayfs.

These privileges will be reverted as soon as the IO operation completes.
This feature does not provide any higher security privileges to those
processes accessing the FUSE filesystem with passthrough enabled.  This
is because it is still the FUSE daemon responsible for enabling or not
the passthrough feature at file open time, and should enable the feature
only after appropriate access policy checks.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/fuse_i.h      |  4 +++-
 fs/fuse/passthrough.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ff09fcd840df..61a3968cfc8f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -174,10 +174,12 @@ struct fuse_mount;
 struct fuse_release_args;
 
 /**
- * Reference to backing file for read/write operations in passthrough mode.
+ * Reference to backing file for read/write operations in passthrough mode
+ * and the credentials to be used for passthrough operations.
  */
 struct fuse_passthrough {
 	struct file *filp;
+	struct cred *cred;
 
 	/** refcount */
 	refcount_t count;
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 2ccd2d6de736..06c6926aa85a 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -45,12 +45,14 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 	struct file *fuse_filp = iocb_fuse->ki_filp;
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct file *passthrough_filp = ff->passthrough->filp;
+	const struct cred *old_cred;
 	ssize_t ret;
 	rwf_t rwf;
 
 	if (!iov_iter_count(iter))
 		return 0;
 
+	old_cred = override_creds(ff->passthrough->cred);
 	if (is_sync_kiocb(iocb_fuse)) {
 		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
 		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
@@ -59,8 +61,10 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		struct fuse_aio_req *aio_req;
 
 		aio_req = kmalloc(sizeof(struct fuse_aio_req), GFP_KERNEL);
-		if (!aio_req)
-			return -ENOMEM;
+		if (!aio_req) {
+			ret = -ENOMEM;
+			goto out;
+		}
 
 		aio_req->iocb_fuse = iocb_fuse;
 		kiocb_clone(&aio_req->iocb, iocb_fuse, passthrough_filp);
@@ -69,6 +73,8 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		if (ret != -EIOCBQUEUED)
 			fuse_aio_cleanup_handler(aio_req);
 	}
+out:
+	revert_creds(old_cred);
 
 	return ret;
 }
@@ -81,6 +87,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	struct inode *fuse_inode = file_inode(fuse_filp);
 	struct file *passthrough_filp = ff->passthrough->filp;
 	struct inode *passthrough_inode = file_inode(passthrough_filp);
+	const struct cred *old_cred;
 	ssize_t ret;
 	rwf_t rwf;
 
@@ -89,6 +96,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 
 	inode_lock(fuse_inode);
 
+	old_cred = override_creds(ff->passthrough->cred);
 	if (is_sync_kiocb(iocb_fuse)) {
 		file_start_write(passthrough_filp);
 		rwf = iocb_to_rw_flags(iocb_fuse->ki_flags, FUSE_IOCB_MASK);
@@ -115,6 +123,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 			fuse_aio_cleanup_handler(aio_req);
 	}
 out:
+	revert_creds(old_cred);
 	inode_unlock(fuse_inode);
 
 	return ret;
@@ -156,6 +165,7 @@ int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd)
 		goto out_fput;
 
 	passthrough->filp = passthrough_filp;
+	passthrough->cred = prepare_creds();
 	refcount_set(&passthrough->count, 1);
 
 	idr_preload(GFP_KERNEL);
@@ -232,5 +242,9 @@ void fuse_passthrough_free(struct fuse_passthrough *passthrough)
 		fput(passthrough->filp);
 		passthrough->filp = NULL;
 	}
+	if (passthrough->cred) {
+		put_cred(passthrough->cred);
+		passthrough->cred = NULL;
+	}
 	kfree_rcu(passthrough, rcu);
 }
-- 
2.34.1

