Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1501C3531
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 May 2020 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgEDJAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 May 2020 05:00:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21865 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728512AbgEDJAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 May 2020 05:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588582849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rK7fi6Y9wU92f9lQDpmj5Rq5pcDU3mpj/jsbL/pXac0=;
        b=BX7NIuW3t0alMebflTZPzJ5dx5oAJwe2ECBEo3V6T9ZDtlmh6pBjXQrwOLag9ExWj7haHZ
        yEGVrrhgl/ns7C+joMPyQ0tpd33szeydH8er7e3Ob0SVn0XhcZ6rqgteqdZjTiKBnLKV2m
        X0cyVNP10k2LYlbG91BZnvA0MF1DIr8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-kE9LgEp3NoiFYPNcxCdA_Q-1; Mon, 04 May 2020 05:00:46 -0400
X-MC-Unique: kE9LgEp3NoiFYPNcxCdA_Q-1
Received: by mail-wm1-f69.google.com with SMTP id u11so3160749wmc.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2020 02:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rK7fi6Y9wU92f9lQDpmj5Rq5pcDU3mpj/jsbL/pXac0=;
        b=V/qCxRR5H7h4ewlc0bufAU6p8f0/8oreXk5xe3mDDV7tpiEbG7jjd89fY3BFJ3//FJ
         52ATRIOoMRWuTtNBrX8iiKHX3KWKCKM1rZhNE6pTa5N/7+QFMyv1HkEgd/FAWqDOIRmr
         42TfqeW+G4+yhNuMet520Mz2KnXDf2my06ahWl0KMpJhVzVe7cTOh3i5uOfu1Yg9fKnu
         fsbRbJh7p8aZmfIJDVL+Hy28Zk3rPB6sd2ocDzN6pZI2b+Ul503wxKVYO8zkGDXiROoL
         8yrs5T+JlP/hgydV+6QclxU/HAbyvON1bSv+sojTZ3DmIxNWTi3x4yvtXm6yvj3a5eed
         ocYA==
X-Gm-Message-State: AGi0PuYE9DgxaysndOral1bib6MvlO0SJClsOF47mDn6b6Ks/daTQxXX
        QVc4s1XhUFYcDxt5x5JPhD7rUigT1cM70FyUKJPycrY61z1W6+fPOchfLVpVMtQoquSO1ImuhLI
        7MXdsn4Mnc+59EUQaNEPbN7ghiA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr1349760wrw.319.1588582845019;
        Mon, 04 May 2020 02:00:45 -0700 (PDT)
X-Google-Smtp-Source: APiQypLoNr/f4mQA7SsbgtWQOMo1QequnmZqBTgkJHb2z1VHuIOAxGvWLPnw/QDJ2+f3J7ebV07xYA==
X-Received: by 2002:a5d:6ac1:: with SMTP id u1mr1349738wrw.319.1588582844750;
        Mon, 04 May 2020 02:00:44 -0700 (PDT)
Received: from localhost.localdomain.com ([194.230.155.213])
        by smtp.gmail.com with ESMTPSA id u127sm12984720wme.8.2020.05.04.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 02:00:44 -0700 (PDT)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Subject: [PATCH v3 6/7] debugfs: switch to simplefs inode creation API
Date:   Mon,  4 May 2020 11:00:31 +0200
Message-Id: <20200504090032.10367-7-eesposit@redhat.com>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200504090032.10367-1-eesposit@redhat.com>
References: <20200504090032.10367-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The only difference, compared to the pre-existing code, is that symlink
creation now triggers fsnotify_create.  This was a bug in the debugfs
code, since for example vfs_symlink does call fsnotify_create.

Also remove debugfs_get_inode(), since it will be substituted
by new_inode_current_time() in the simplefs_create_dentry call.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 fs/debugfs/inode.c | 155 +++++----------------------------------------
 1 file changed, 15 insertions(+), 140 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 5dbb74a23e7c..76b594941840 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -61,17 +61,6 @@ static const struct inode_operations debugfs_symlink_inode_operations = {
 	.setattr	= debugfs_setattr,
 };
 
-static struct inode *debugfs_get_inode(struct super_block *sb)
-{
-	struct inode *inode = new_inode(sb);
-	if (inode) {
-		inode->i_ino = get_next_ino();
-		inode->i_atime = inode->i_mtime =
-			inode->i_ctime = current_time(inode);
-	}
-	return inode;
-}
-
 struct debugfs_mount_opts {
 	kuid_t uid;
 	kgid_t gid;
@@ -305,68 +294,6 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
 }
 EXPORT_SYMBOL_GPL(debugfs_lookup);
 
-static struct dentry *start_creating(const char *name, struct dentry *parent)
-{
-	struct dentry *dentry;
-	int error;
-
-	pr_debug("creating file '%s'\n", name);
-
-	if (IS_ERR(parent))
-		return parent;
-
-	error = simple_pin_fs(&debugfs, &debug_fs_type);
-	if (error) {
-		pr_err("Unable to pin filesystem for file '%s'\n", name);
-		return ERR_PTR(error);
-	}
-
-	/* If the parent is not specified, we create it in the root.
-	 * We need the root dentry to do this, which is in the super
-	 * block. A pointer to that is in the struct vfsmount that we
-	 * have around.
-	 */
-	if (!parent)
-		parent = debugfs.mount->mnt_root;
-
-	inode_lock(d_inode(parent));
-	if (unlikely(IS_DEADDIR(d_inode(parent))))
-		dentry = ERR_PTR(-ENOENT);
-	else
-		dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry) && d_really_is_positive(dentry)) {
-		if (d_is_dir(dentry))
-			pr_err("Directory '%s' with parent '%s' already present!\n",
-			       name, parent->d_name.name);
-		else
-			pr_err("File '%s' in directory '%s' already present!\n",
-			       name, parent->d_name.name);
-		dput(dentry);
-		dentry = ERR_PTR(-EEXIST);
-	}
-
-	if (IS_ERR(dentry)) {
-		inode_unlock(d_inode(parent));
-		simple_release_fs(&debugfs);
-	}
-
-	return dentry;
-}
-
-static struct dentry *failed_creating(struct dentry *dentry)
-{
-	inode_unlock(d_inode(dentry->d_parent));
-	dput(dentry);
-	simple_release_fs(&debugfs);
-	return ERR_PTR(-ENOMEM);
-}
-
-static struct dentry *end_creating(struct dentry *dentry)
-{
-	inode_unlock(d_inode(dentry->d_parent));
-	return dentry;
-}
-
 static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 				struct dentry *parent, void *data,
 				const struct file_operations *proxy_fops,
@@ -375,32 +302,17 @@ static struct dentry *__debugfs_create_file(const char *name, umode_t mode,
 	struct dentry *dentry;
 	struct inode *inode;
 
-	if (!(mode & S_IFMT))
-		mode |= S_IFREG;
-	BUG_ON(!S_ISREG(mode));
-	dentry = start_creating(name, parent);
-
+	dentry = simplefs_create_file(&debugfs, &debug_fs_type,
+				      name, mode, parent, data, &inode);
 	if (IS_ERR(dentry))
 		return dentry;
 
-	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode)) {
-		pr_err("out of free dentries, can not create file '%s'\n",
-		       name);
-		return failed_creating(dentry);
-	}
-
-	inode->i_mode = mode;
-	inode->i_private = data;
-
 	inode->i_op = &debugfs_file_inode_operations;
 	inode->i_fop = proxy_fops;
 	dentry->d_fsdata = (void *)((unsigned long)real_fops |
 				DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
 
-	d_instantiate(dentry, inode);
-	fsnotify_create(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 
 /**
@@ -533,29 +445,16 @@ EXPORT_SYMBOL_GPL(debugfs_create_file_size);
  */
 struct dentry *debugfs_create_dir(const char *name, struct dentry *parent)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry;
 	struct inode *inode;
 
+	dentry = simplefs_create_dir(&debugfs, &debug_fs_type,
+				     name, 0755, parent, &inode);
 	if (IS_ERR(dentry))
 		return dentry;
 
-	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode)) {
-		pr_err("out of free dentries, can not create directory '%s'\n",
-		       name);
-		return failed_creating(dentry);
-	}
-
-	inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
 	inode->i_op = &debugfs_dir_inode_operations;
-	inode->i_fop = &simple_dir_operations;
-
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_dir);
 
@@ -575,29 +474,19 @@ struct dentry *debugfs_create_automount(const char *name,
 					debugfs_automount_t f,
 					void *data)
 {
-	struct dentry *dentry = start_creating(name, parent);
+	struct dentry *dentry;
 	struct inode *inode;
 
+	dentry = simplefs_create_dentry(&debugfs, &debug_fs_type, name, parent,
+					&inode);
 	if (IS_ERR(dentry))
 		return dentry;
 
-	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode)) {
-		pr_err("out of free dentries, can not create automount '%s'\n",
-		       name);
-		return failed_creating(dentry);
-	}
-
 	make_empty_dir_inode(inode);
 	inode->i_flags |= S_AUTOMOUNT;
 	inode->i_private = data;
 	dentry->d_fsdata = (void *)f;
-	/* directory inodes start off with i_nlink == 2 (for "." entry) */
-	inc_nlink(inode);
-	d_instantiate(dentry, inode);
-	inc_nlink(d_inode(dentry->d_parent));
-	fsnotify_mkdir(d_inode(dentry->d_parent), dentry);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 EXPORT_SYMBOL(debugfs_create_automount);
 
@@ -629,28 +518,14 @@ struct dentry *debugfs_create_symlink(const char *name, struct dentry *parent,
 {
 	struct dentry *dentry;
 	struct inode *inode;
-	char *link = kstrdup(target, GFP_KERNEL);
-	if (!link)
-		return ERR_PTR(-ENOMEM);
 
-	dentry = start_creating(name, parent);
-	if (IS_ERR(dentry)) {
-		kfree(link);
+	dentry = simplefs_create_symlink(&debugfs, &debug_fs_type,
+					 name, parent, target, &inode);
+	if (IS_ERR(dentry))
 		return dentry;
-	}
 
-	inode = debugfs_get_inode(dentry->d_sb);
-	if (unlikely(!inode)) {
-		pr_err("out of free dentries, can not create symlink '%s'\n",
-		       name);
-		kfree(link);
-		return failed_creating(dentry);
-	}
-	inode->i_mode = S_IFLNK | S_IRWXUGO;
 	inode->i_op = &debugfs_symlink_inode_operations;
-	inode->i_link = link;
-	d_instantiate(dentry, inode);
-	return end_creating(dentry);
+	return simplefs_finish_dentry(dentry, inode);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_symlink);
 
-- 
2.25.2

