Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2373C7097D1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 14:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjESM6N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 08:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjESM6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 08:58:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87161723
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-309438004a6so1991741f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 05:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684501037; x=1687093037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dx0DzRRIuT1dU2c89gbu/C+cWU/zLuZoc/A/+hPTtYA=;
        b=JKKtf9TbcrZAT0l3SYEZxGVIbjHvyNsLD7Ux5yBdhJiZOGKq0HNA6Ux0PBM0EAJkMi
         eF4XKgze5xRgIMtFVAI89+v0WJVqcpeo7coKQkn1wi/Ho2PpeRuKBHW0FE9WiHBulcbr
         q9QE6k2hvo3d6VY75VigvQMsAt2kLrtg9imDg5J/QrBSDDGcYLQziOPC0FT9DJHZu5xj
         95TjC+eaYEw/0MmI/A5kMS7w0nK4TOA+wCQBuL7MTria3Jeiz77FS72zjQlXSFleZ2/s
         9Ib5gaHeVSGQSFwwwyLRnZ4JGOGAdAclV3XfuU517FxUtjJf+xQkhOCNysCC+FBRQXtV
         lQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684501037; x=1687093037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dx0DzRRIuT1dU2c89gbu/C+cWU/zLuZoc/A/+hPTtYA=;
        b=cmvFvn8X7TSxMezpmmqjT149H+WG5IP0ugrmjMAglm5vUWP6eHsLoJRHCSFOFU+/Ra
         seRyCT61kRkDFM6EHTLOCu04wXI36icJ1gCfLKjDLiegUI7eqzfhJPdFYZZ3PPNTaF7T
         apdR/Jts5ATAdj5mE3ZsunMXHoYudjeJSq5MK2PBo90cnVishEt3TcpxJZrq1xrSxeCr
         TNGSTq+HkjllSuztBoe5+SATd7xFCD0+gRr9XIvw2ubHi+deHV9wbnd66SCvNFDCxJJU
         U1utuzMqaOF3GF5DrfJJd+LLH2UjfGQvc6SPcEiQY7SFyGO+JRgBg9lYXJ5hWkh9cbhE
         AwVw==
X-Gm-Message-State: AC+VfDyZJje8EiLNkKD1ZVLreZ0+f5RqzMAR+NjN00kZrPn5WxFUXoX2
        /Rr1PJXHiEscHx7zXGnTgo0=
X-Google-Smtp-Source: ACHHUZ5j0CaiL1cNbaoVrL6iTjBwwe2V3qnJwsJtF3P2XYAZBeEXO16CoHDvYD5O3YRexMeJGUzsRw==
X-Received: by 2002:a5d:4ace:0:b0:2f5:3fa1:6226 with SMTP id y14-20020a5d4ace000000b002f53fa16226mr2141049wrs.14.1684501037088;
        Fri, 19 May 2023 05:57:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b0030630120e56sm5250937wrd.57.2023.05.19.05.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:57:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 03/10] fuse: Passthrough initialization and release
Date:   Fri, 19 May 2023 15:56:58 +0300
Message-Id: <20230519125705.598234-4-amir73il@gmail.com>
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

Implement the FUSE passthrough ioctl that associates a backing
(passthrough) file with the fuse_file.

The file descriptor passed to the ioctl by the FUSE daemon is used to
access the relative file pointer, that will be copied to the fuse_file
data structure to consolidate the link between the FUSE and the backing
file.

To enable the passthrough mode, FUSE daemon calls the
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl and, if the call succeeds, receives
back an identifier that will be used at open/create response time in the
fuse_open_out field to associate the FUSE file to the backing file.

The value returned by the ioctl to user space can be:
  > 0: success, the value can be used as part of an open/create reply.
 <= 0: an error occurred.
 == 0: represents an error to preserve backward compatibility - the
fuse_open_out field that is used to pass the backing_id back to the
kernel uses the same bits that were previously as struct padding, and is
commonly zero-initialized (e.g., in the libfuse implementation).

Removing 0 from the correct values fixes the ambiguity between the case
in which 0 corresponds to a real backing_id, a missing implementation
of FUSE passthrough or a request for a normal FUSE file, simplifying the
user space implementation.

For the passthrough mode to be successfully activated, the backing file
filesystem must implement both read_iter and write_iter file operations.
This extra check avoids special pseudo files to be used for passhrough.
Passthrough comes with another limitation: no further filesystem stacking
is allowed for those FUSE filesystems using passthrough.

The FUSE daemon must call FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl to drop
the reference on the backing file.  This can be done immediattely after
responding to open or at a later time.

In any case, the backing file will be kept open by the FUSE driver until
the last fuse_file that was setup to passthrough to that backing file is
closed AND the FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl was called.

Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/inode.c       |  1 +
 fs/fuse/passthrough.c | 89 +++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f52604534ff6..9ad1cc37a5c4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -181,6 +181,7 @@ struct fuse_passthrough {
 
 	/** refcount */
 	refcount_t count;
+	struct rcu_head rcu;
 };
 
 /** FUSE specific file data */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 271586fac008..4200fb13883e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1301,6 +1301,7 @@ static int fuse_passthrough_id_free(int id, void *p, void *data)
 
 	WARN_ON_ONCE(refcount_read(&passthrough->count) != 1);
 	fuse_passthrough_free(passthrough);
+
 	return 0;
 }
 
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index fc723e004de9..8d090ae252f2 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -3,6 +3,7 @@
 #include "fuse_i.h"
 
 #include <linux/file.h>
+#include <linux/idr.h>
 
 /*
  * Returns passthrough_fh id that can be passed with FOPEN_PASSTHROUGH
@@ -10,18 +11,98 @@
  */
 int fuse_passthrough_open(struct fuse_conn *fc, int backing_fd)
 {
-	return -EINVAL;
+	struct file *passthrough_filp;
+	struct inode *passthrough_inode;
+	struct super_block *passthrough_sb;
+	struct fuse_passthrough *passthrough;
+	int res;
+
+	if (!fc->passthrough)
+		return -EPERM;
+
+	passthrough_filp = fget(backing_fd);
+	if (!passthrough_filp)
+		return -EBADF;
+
+	res = -EOPNOTSUPP;
+	if (!passthrough_filp->f_op->read_iter ||
+	    !passthrough_filp->f_op->write_iter)
+		goto out_fput;
+
+	passthrough_inode = file_inode(passthrough_filp);
+	passthrough_sb = passthrough_inode->i_sb;
+	res = -ELOOP;
+	if (passthrough_sb->s_stack_depth >= FILESYSTEM_MAX_STACK_DEPTH)
+		goto out_fput;
+
+	passthrough = kmalloc(sizeof(struct fuse_passthrough), GFP_KERNEL);
+	res = -ENOMEM;
+	if (!passthrough)
+		goto out_fput;
+
+	passthrough->filp = passthrough_filp;
+	refcount_set(&passthrough->count, 1);
+
+	idr_preload(GFP_KERNEL);
+	spin_lock(&fc->lock);
+	res = idr_alloc_cyclic(&fc->passthrough_files_map, passthrough, 1, 0,
+			       GFP_ATOMIC);
+	spin_unlock(&fc->lock);
+	idr_preload_end();
+
+	if (res < 0)
+		fuse_passthrough_free(passthrough);
+
+	return res;
+
+out_fput:
+	fput(passthrough_filp);
+
+	return res;
 }
 
 int fuse_passthrough_close(struct fuse_conn *fc, int passthrough_fh)
 {
-	return -EINVAL;
+	struct fuse_passthrough *passthrough;
+
+	if (!fc->passthrough)
+		return -EPERM;
+
+	if (passthrough_fh <= 0)
+		return -EINVAL;
+
+	spin_lock(&fc->lock);
+	passthrough = idr_remove(&fc->passthrough_files_map, passthrough_fh);
+	spin_unlock(&fc->lock);
+
+	if (!passthrough)
+		return -ENOENT;
+
+	fuse_passthrough_put(passthrough);
+
+	return 0;
 }
 
 int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 			   struct fuse_open_out *openarg)
 {
-	return -EINVAL;
+	int passthrough_fh = openarg->passthrough_fh;
+	struct fuse_passthrough *passthrough;
+
+	if (passthrough_fh <= 0)
+		return -EINVAL;
+
+	rcu_read_lock();
+	passthrough = idr_find(&fc->passthrough_files_map, passthrough_fh);
+	if (passthrough && !refcount_inc_not_zero(&passthrough->count))
+		passthrough = NULL;
+	rcu_read_unlock();
+	if (!passthrough)
+		return -ENOENT;
+
+	ff->passthrough = passthrough;
+
+	return 0;
 }
 
 void fuse_passthrough_put(struct fuse_passthrough *passthrough)
@@ -36,5 +117,5 @@ void fuse_passthrough_free(struct fuse_passthrough *passthrough)
 		fput(passthrough->filp);
 		passthrough->filp = NULL;
 	}
-	kfree(passthrough);
+	kfree_rcu(passthrough, rcu);
 }
-- 
2.34.1

