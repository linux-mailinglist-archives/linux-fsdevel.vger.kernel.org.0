Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF995BCE19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiISOKz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiISOKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B046131DFD
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663596645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/WZypUOARqjqxBYzDb24XhV4Ramykp+1sRUd+3h/a8=;
        b=e9J5xCaZby7PUm5YGHU8hv/shIbln7xmss+MTuS3smtZoT+T4PfmFsKWC8PKwqHFaW6y4Y
        1T5eWBfYaL1xAr5rri3J/RZckCP9d42ZXkR0zaj4R6Guvk+bq8c9uS1qYelHNaAQkhtC9I
        RU61wPFoePw0B0ag0LABb/Nk76FhF6E=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-379-FAAyA4FQOVGP7JEOK5wWjg-1; Mon, 19 Sep 2022 10:10:44 -0400
X-MC-Unique: FAAyA4FQOVGP7JEOK5wWjg-1
Received: by mail-ed1-f71.google.com with SMTP id i17-20020a05640242d100b0044f18a5379aso20707811edc.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Sep 2022 07:10:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=A/WZypUOARqjqxBYzDb24XhV4Ramykp+1sRUd+3h/a8=;
        b=qD1jGIW5ngTigKJTUycCQ4zLt5AQTAodo3Rs9pXP3M1t+oqVwgPrRMsG7O/g/tBRSt
         ERYYnniZ6fRsyO4i1j2b868iznOSXZ6IYzX38aMrdJXWfYkezx1QusSPs+2iiNQkH83D
         uA+9D2eWip+2UTnNa2pNollnCaCv2vTl1tzWHGTaiPsqKK3KwUAGY/pL1X74nHzWP3ZQ
         +xGEqzwvBN9lUuz1p8czKcuE5360XCEzYiJbGuyl7DbeJ27D82mwyzU7riVPUEJVK7C4
         w9JqPnsl/ARph47VElEiLG/L/OUlX0X5WSc2Z1NIofhSxXLnTjfCg6P0fTztIi2A210P
         0brQ==
X-Gm-Message-State: ACrzQf0j6Y4G+5NDCx4Amg1R7zvfEoQ3bEtaQtq1LY5ZIU/pZGNCABly
        EcktnfIhTVd38CCsIhtL7SkhYY5O1CyrCyctzCk8uxhOcZFwd6KXhmvdZCJ6uvLA2qr0bm2pcb7
        V3IMfXpX5cGLHXf3A/fECrhdjqHEdoOw/919r4DC/Jeg/Nb4STOmG/GIpc4jfQTzxz+kWz0I81T
        QJ+g==
X-Received: by 2002:a05:6402:274c:b0:44f:334e:1e11 with SMTP id z12-20020a056402274c00b0044f334e1e11mr15772254edd.304.1663596643403;
        Mon, 19 Sep 2022 07:10:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6MpYd68eGk+Y26U6ElFI/IPzwDwqglhFB7YvkhK7G7zqyNgopO7oCdCQgpfWCfhBBq6JGrWQ==
X-Received: by 2002:a05:6402:274c:b0:44f:334e:1e11 with SMTP id z12-20020a056402274c00b0044f334e1e11mr15772236edd.304.1663596643155;
        Mon, 19 Sep 2022 07:10:43 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id lb22-20020a170907785600b0073bdf71995dsm9849951ejc.139.2022.09.19.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:10:42 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v2 6/8] vfs: move open right after ->tmpfile()
Date:   Mon, 19 Sep 2022 16:10:29 +0200
Message-Id: <20220919141031.1834447-7-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220919141031.1834447-1-mszeredi@redhat.com>
References: <20220919141031.1834447-1-mszeredi@redhat.com>
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
 fs/namei.c         | 65 ++++++++++++++++++++--------------------------
 include/linux/fs.h |  9 +++++++
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 652d09ae66fb..eb1e1956450f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3583,11 +3583,12 @@ static int do_open(struct nameidata *nd,
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
 
@@ -3599,28 +3600,34 @@ static struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	if (!dir->i_op->tmpfile)
 		goto out_err;
 	error = -ENOMEM;
-	child = d_alloc(dentry, &slash_name);
+	child = d_alloc(parentpath->dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
+	file->f_path.mnt = parentpath->mnt;
+	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
+	error = finish_open_simple(file, error);
+	dput(child);
+	if (error)
+		goto out_err;
+	error = may_open(mnt_userns, &file->f_path, 0, file->f_flags);
 	if (error)
 		goto out_err;
 	error = -ENOENT;
 	inode = child->d_inode;
 	if (unlikely(!inode))
 		goto out_err;
-	if (!(open_flag & O_EXCL)) {
+	if (!(file->f_flags & O_EXCL)) {
 		spin_lock(&inode->i_lock);
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
 	ima_post_create_tmpfile(mnt_userns, inode);
-	return child;
+	return 0;
 
 out_err:
-	dput(child);
-	return ERR_PTR(error);
+	return error;
 }
 
 /**
@@ -3641,25 +3648,15 @@ struct file *tmpfile_open(struct user_namespace *mnt_userns,
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
@@ -3669,26 +3666,20 @@ static int do_tmpfile(struct nameidata *nd, unsigned flags,
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

