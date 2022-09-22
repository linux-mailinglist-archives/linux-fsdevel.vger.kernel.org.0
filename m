Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C235E5DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiIVIp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbiIVIpA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCC1AB4E1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q2MdUQ+cskiOFqdTJdIqCbmLrGfJwLVlFJJJyVKZST0=;
        b=hZpOg9vEhhkbF+Ha0X6v40b2VMAvHNhCNPtQkK7jUqzT+JhqnqmZCsY4/y8Sjb3OtwI4mr
        E7neGS2ehBfjCHwCfOEQ6GuJtxlSSnzxU3A2wfH8jR20U+NyUEBjOFGoI8oqRp3VgjvHOG
        XkFfDMMxe0JmRFmGroTJRfb5+2VBO1k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-260-e52gERjiP4muMjHPc2yPAQ-1; Thu, 22 Sep 2022 04:44:55 -0400
X-MC-Unique: e52gERjiP4muMjHPc2yPAQ-1
Received: by mail-ed1-f72.google.com with SMTP id y1-20020a056402358100b00451b144e23eso6139633edc.18
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=q2MdUQ+cskiOFqdTJdIqCbmLrGfJwLVlFJJJyVKZST0=;
        b=MNBzO8E/yf9Vb1pM4KDiZrwbMRWyvBaUb6YCFr+kGh2U+/jsvggxO35VrOVQ0irq2f
         obOzjd8Atv3+obMnadU+9Vi0lSuEICoNe7SBeo+BgBOBfBng4LsVeDQTDaHJT3bl3niv
         SrGRDYSJzo97/p0CndzjCX+RSlszyOXxoPN1QCtS/IFfUwm1oimoYTPERpfcrGzSG415
         IO6fBSWC+w5I0GezDR0gGAvJDwQ7Bibvj9dMmBSYTeacFpYKYf33NS+qJD/qTRoJPlgs
         7R/2L5apkjV0MUMoRjqnfBnHPWHhejTWugwhlugh2j1Vk3CyEmWLo9A6QE93P7lgD0GQ
         FdKA==
X-Gm-Message-State: ACrzQf154peDksInun0la7E7RqJNhdeAv7D/8/vmwxEY5XqxBAHlqB+C
        TCH5VSNuE12HJUsSfVYyBZ8MXZatr5fMfhRs1SKCfzAtL1zoHKc/KpSxsvc18VarddlWrLQcnWc
        cATb/WOIWEGY2QYXxYP/J8h+xGF8xx38UEjfK+Nu+Y1TbQj5ZOPLLOfSNZKvftuPHWxx2x60f7W
        nqbA==
X-Received: by 2002:a17:907:a40c:b0:781:53dd:27fd with SMTP id sg12-20020a170907a40c00b0078153dd27fdmr1846871ejc.261.1663836293810;
        Thu, 22 Sep 2022 01:44:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EOsg89DoiZJRR0cGBkgX2BhdVx/pNpXNSIrV8Tyan5OQ91mNaU83SqMVwLrjojl/fTzkeWw==
X-Received: by 2002:a17:907:a40c:b0:781:53dd:27fd with SMTP id sg12-20020a170907a40c00b0078153dd27fdmr1846854ejc.261.1663836293564;
        Thu, 22 Sep 2022 01:44:53 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:52 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 08/10] vfs: move open right after ->tmpfile()
Date:   Thu, 22 Sep 2022 10:44:40 +0200
Message-Id: <20220922084442.2401223-9-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
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
 fs/namei.c         | 83 ++++++++++++++++++----------------------------
 include/linux/fs.h |  9 +++++
 2 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 03ad4e55fb26..fea56fe9f306 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,44 +3583,44 @@ static int do_open(struct nameidata *nd,
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
-	inode = child->d_inode;
-	if (unlikely(!inode))
-		goto out_err;
-	if (!(open_flag & O_EXCL)) {
+		return error;
+	/* Don't check for other permissions, the inode was just created */
+	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
+	if (error)
+		return error;
+	inode = file_inode(file);
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
@@ -3641,25 +3641,15 @@ struct file *vfs_tmpfile_open(struct user_namespace *mnt_userns,
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
 EXPORT_SYMBOL(vfs_tmpfile_open);
@@ -3669,26 +3659,19 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
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
-	/* Don't check for other permissions, the inode was just created */
-	error = may_open(mnt_userns, &path, 0, op->open_flag);
-	if (!error)
-		error = vfs_open(&path, file);
+	audit_inode(nd->name, file->f_path.dentry, 0);
 out2:
 	mnt_drop_write(path.mnt);
 out:
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 02646542f6bb..a3c50869e79b 100644
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

