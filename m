Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D565BEDE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiITTgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiITTgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6697645A
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1JQip0dXGpwIQDhVuBjqxmOn9hMQr0SCOZ9gH35oNTM=;
        b=edHMzmqwuYXBqDO3MO66a0iTGNoBNgrrjVCj6GWXVu7bA21g3ZBjY2pZ1S+5zNn1sy8R3G
        TbvzvyDMT4NcUFw59JrNZunQgxiRVYzPPJVWRKNJRghV+IwcHT2qGYMfJOPqvWIdLPyb9E
        jQPrCAuj3NoZOLhNPugDWeCKi6k9ps4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-ZsKyam2qOC2IpA41u7AkQQ-1; Tue, 20 Sep 2022 15:36:43 -0400
X-MC-Unique: ZsKyam2qOC2IpA41u7AkQQ-1
Received: by mail-ed1-f71.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so2626132edd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1JQip0dXGpwIQDhVuBjqxmOn9hMQr0SCOZ9gH35oNTM=;
        b=eiDtB3saFHi9p0UUt4NxsGzh0tEfFGKQ/FLoIWn1GxO9QEHKU4A5erGJ4qeacxEicU
         4sWtRIM0Zh/aJPNqZ9+AqJTWLB2AgmQF4ESWR2GaGpVNMIbjUS40mmdty8YlEIbUov14
         NON7Uc0HAOItK0OAg9vhEs6N4KQPi8+3yr/1HOWwEtkFEfsg/Th8Z/L4AsLm4OGhd6/x
         xy+GXsANT8vBuE6G0ON/whYjmOcHkpgFv7+LQzNfJFkJmdbyWGFzj5ll1dq92RKzV2FJ
         kRe+c/h4Trvv67YqUAKo//nmxxfy+jYTO0/NOZicRgPOvZVXp4wdvZUGgB4o5icj34DF
         7x9Q==
X-Gm-Message-State: ACrzQf0dKJgegZXhIAYkWDP6500RhuVh61c6FXkjSzOhIwNCU+w9+z6F
        dBBBbN8pYK4PLBsp9iHFwWsN6ZnPqvtCcVa0Mo/rb6G3pNx5Foc0pYrP9UEnlA986Mr7IWkr4L5
        L77RuaMRizVXhJLGfuEs13zii6DpPSU08Mpc9dLkTUya1J3xjS3dE6V6094dP0sJWdDHY7/zX9S
        iZtg==
X-Received: by 2002:a17:907:2c78:b0:779:7327:c897 with SMTP id ib24-20020a1709072c7800b007797327c897mr17267428ejc.657.1663702602553;
        Tue, 20 Sep 2022 12:36:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4Owx0C5mj6YYfPadW29D9gzMrKaLqTGLBWwh4nqK1njhJFrtRBD7QC3wHxHtbH3qL6ox0iIw==
X-Received: by 2002:a17:907:2c78:b0:779:7327:c897 with SMTP id ib24-20020a1709072c7800b007797327c897mr17267411ejc.657.1663702602313;
        Tue, 20 Sep 2022 12:36:42 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:41 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 7/9] vfs: move open right after ->tmpfile()
Date:   Tue, 20 Sep 2022 21:36:30 +0200
Message-Id: <20220920193632.2215598-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920193632.2215598-1-mszeredi@redhat.com>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Create a helper finish_open_simple() that opens the file with the original
dentry.  Handle the error case here as well to simplify callers.

Call this helper right after ->tmpfile() is called.

Next patch will change the tmpfile API and move this call into tmpfile
instances.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/namei.c         | 79 ++++++++++++++++++----------------------------
 include/linux/fs.h |  9 ++++++
 2 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 652d09ae66fb..4faf7e743664 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,44 +3583,43 @@ static int do_open(struct nameidata *nd,
  * On non-idmapped mounts or if permission checking is to be performed on the
  * raw inode simply passs init_user_ns.
  */
-static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
-			   struct dentry *dentry, umode_t mode, int open_flag)
+static int vfs_tmpfile(struct user_namespace *mnt_userns,
+		       const struct path *parentpath,
+		       struct file *file, umode_t mode)
 {
-	struct dentry *child = NULL;
-	struct inode *dir = dentry->d_inode;
+	struct dentry *child;
+	struct inode *dir = d_inode(parentpath->dentry);
 	struct inode *inode;
 	int error;
 
 	/* we want directory to be writable */
 	error = inode_permission(mnt_userns, dir, MAY_WRITE | MAY_EXEC);
 	if (error)
-		goto out_err;
-	error = -EOPNOTSUPP;
+		return error;
 	if (!dir->i_op->tmpfile)
-		goto out_err;
-	error = -ENOMEM;
-	child = d_alloc(dentry, &slash_name);
+		return -EOPNOTSUPP;
+	child = d_alloc(parentpath->dentry, &slash_name);
 	if (unlikely(!child))
-		goto out_err;
+		return -ENOMEM;
+	file->f_path.mnt = parentpath->mnt;
+	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
+	error = finish_open_simple(file, error);
+	dput(child);
 	if (error)
-		goto out_err;
-	error = -ENOENT;
+		return error;
+	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
+	if (error)
+		return error;
 	inode = child->d_inode;
-	if (unlikely(!inode))
-		goto out_err;
-	if (!(open_flag & O_EXCL)) {
+	if (!(file->f_flags & O_EXCL)) {
 		spin_lock(&inode->i_lock);
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
 	ima_post_create_tmpfile(mnt_userns, inode);
-	return child;
-
-out_err:
-	dput(child);
-	return ERR_PTR(error);
+	return 0;
 }
 
 /**
@@ -3641,25 +3640,15 @@ struct file *tmpfile_open(struct user_namespace *mnt_userns,
 {
 	struct file *file;
 	int error;
-	struct path path = { .mnt = parentpath->mnt };
-
-	path.dentry = vfs_tmpfile(mnt_userns, parentpath->dentry, mode, open_flag);
-	if (IS_ERR(path.dentry))
-		return ERR_CAST(path.dentry);
-
-	error = may_open(mnt_userns, &path, 0, open_flag);
-	file = ERR_PTR(error);
-	if (error)
-		goto out_dput;
-
-	/*
-	 * This relies on the "noaccount" property of fake open, otherwise
-	 * equivalent to dentry_open().
-	 */
-	file = open_with_fake_path(&path, open_flag, d_inode(path.dentry), cred);
-out_dput:
-	dput(path.dentry);
 
+	file = alloc_empty_file_noaccount(open_flag, cred);
+	if (!IS_ERR(file)) {
+		error = vfs_tmpfile(mnt_userns, parentpath, file, mode);
+		if (error) {
+			fput(file);
+			file = ERR_PTR(error);
+		}
+	}
 	return file;
 }
 EXPORT_SYMBOL(tmpfile_open);
@@ -3669,26 +3658,20 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
 		struct file *file)
 {
 	struct user_namespace *mnt_userns;
-	struct dentry *child;
 	struct path path;
 	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
+
 	if (unlikely(error))
 		return error;
 	error = mnt_want_write(path.mnt);
 	if (unlikely(error))
 		goto out;
 	mnt_userns = mnt_user_ns(path.mnt);
-	child = vfs_tmpfile(mnt_userns, path.dentry, op->mode, op->open_flag);
-	error = PTR_ERR(child);
-	if (IS_ERR(child))
+	error = vfs_tmpfile(mnt_userns, &path, file, op->mode);
+	if (error)
 		goto out2;
-	dput(path.dentry);
-	path.dentry = child;
-	audit_inode(nd->name, child, 0);
+	audit_inode(nd->name, file->f_path.dentry, 0);
 	/* Don't check for other permissions, the inode was just created */
-	error = may_open(mnt_userns, &path, 0, op->open_flag);
-	if (!error)
-		error = vfs_open(&path, file);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a445da4842e0..f0d17eefb966 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2780,6 +2780,15 @@ extern int finish_open(struct file *file, struct dentry *dentry,
 			int (*open)(struct inode *, struct file *));
 extern int finish_no_open(struct file *file, struct dentry *dentry);
 
+/* Helper for the simple case when original dentry is used */
+static inline int finish_open_simple(struct file *file, int error)
+{
+	if (error)
+		return error;
+
+	return finish_open(file, file->f_path.dentry, NULL);
+}
+
 /* fs/dcache.c */
 extern void __init vfs_caches_init_early(void);
 extern void __init vfs_caches_init(void);
-- 
2.37.3

