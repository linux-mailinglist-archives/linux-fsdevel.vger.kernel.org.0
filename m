Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EB7675169
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 10:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjATJpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 04:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjATJpI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:45:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1007AF0B
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 01:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674207865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m292PQ83GoaOas7duljZc/n5N3aCG8DPEh4PPdCEr3U=;
        b=OYhrCZOXuZP5OeZr+bt1kE5ofGRmti2MnBYHvu06G30OdjpnzIMIQwcFcjlMBueC3SpVT7
        Ri8VooKXmkShJjkMygZgi/1Jh7yp+4heJvjuFVpIzxJPduQKH+GSs5nL3V9CtN7y4oOZ8r
        FHeukrSwOofkjET8IHWVrGuulBeZb3w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-9LdOn1LDPK676ZSp_vQ2iQ-1; Fri, 20 Jan 2023 04:44:21 -0500
X-MC-Unique: 9LdOn1LDPK676ZSp_vQ2iQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4964A3806644;
        Fri, 20 Jan 2023 09:44:21 +0000 (UTC)
Received: from lithium.redhat.com (unknown [10.39.194.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD2BC40C2064;
        Fri, 20 Jan 2023 09:44:19 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     brauner@kernel.org, linux-fsdevel@vger.kernel.org
Cc:     hughd@google.com, sforshee@kernel.org, hch@lst.de,
        gscrivan@redhat.com, rodrigoca@microsoft.com
Subject: [PATCH] shmem: support idmapped mounts for tmpfs
Date:   Fri, 20 Jan 2023 10:43:46 +0100
Message-Id: <20230120094346.3182328-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch enables idmapped mounts for tmpfs when CONFIG_SHMEM is defined.
Since all dedicated helpers for this functionality exist, in this
patch we just pass down the idmap argument from the VFS methods to the
relevant helpers.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 mm/shmem.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 028675cd97d4..2fdd76ab337f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1068,7 +1068,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 
 	if (shmem_is_huge(NULL, inode, 0, false))
 		stat->blksize = HPAGE_PMD_SIZE;
@@ -1091,7 +1091,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	bool update_mtime = false;
 	bool update_ctime = true;
 
-	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	error = setattr_prepare(idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -1129,9 +1129,9 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 		}
 	}
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	if (attr->ia_valid & ATTR_MODE)
-		error = posix_acl_chmod(&nop_mnt_idmap, dentry, inode->i_mode);
+		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
 		inode->i_ctime = current_time(inode);
 		if (update_mtime)
@@ -2329,8 +2329,9 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
-static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
-				     umode_t mode, dev_t dev, unsigned long flags)
+static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
+				     struct inode *dir, umode_t mode, dev_t dev,
+				     unsigned long flags)
 {
 	struct inode *inode;
 	struct shmem_inode_info *info;
@@ -2343,7 +2344,7 @@ static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
 	inode = new_inode(sb);
 	if (inode) {
 		inode->i_ino = ino;
-		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
 		inode->i_generation = get_random_u32();
@@ -2921,7 +2922,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
 	if (inode) {
 		error = simple_acl_create(dir, inode);
 		if (error)
@@ -2952,7 +2953,7 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = shmem_get_inode(dir->i_sb, dir, mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
 	if (inode) {
 		error = security_inode_init_security(inode, dir,
 						     NULL,
@@ -2975,8 +2976,8 @@ static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 {
 	int error;
 
-	if ((error = shmem_mknod(&nop_mnt_idmap, dir, dentry,
-				 mode | S_IFDIR, 0)))
+	error = shmem_mknod(idmap, dir, dentry, mode | S_IFDIR, 0);
+	if (error)
 		return error;
 	inc_nlink(dir);
 	return 0;
@@ -2985,7 +2986,7 @@ static int shmem_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode, bool excl)
 {
-	return shmem_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
+	return shmem_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
 /*
@@ -3055,7 +3056,7 @@ static int shmem_whiteout(struct mnt_idmap *idmap,
 	if (!whiteout)
 		return -ENOMEM;
 
-	error = shmem_mknod(&nop_mnt_idmap, old_dir, whiteout,
+	error = shmem_mknod(idmap, old_dir, whiteout,
 			    S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
 	dput(whiteout);
 	if (error)
@@ -3098,7 +3099,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	if (flags & RENAME_WHITEOUT) {
 		int error;
 
-		error = shmem_whiteout(&nop_mnt_idmap, old_dir, old_dentry);
+		error = shmem_whiteout(idmap, old_dir, old_dentry);
 		if (error)
 			return error;
 	}
@@ -3136,7 +3137,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (len > PAGE_SIZE)
 		return -ENAMETOOLONG;
 
-	inode = shmem_get_inode(dir->i_sb, dir, S_IFLNK | 0777, 0,
+	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
 				VM_NORESERVE);
 	if (!inode)
 		return -ENOSPC;
@@ -3819,7 +3820,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 #endif
 	uuid_gen(&sb->s_uuid);
 
-	inode = shmem_get_inode(sb, NULL, S_IFDIR | sbinfo->mode, 0, VM_NORESERVE);
+	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL, S_IFDIR | sbinfo->mode, 0,
+				VM_NORESERVE);
 	if (!inode)
 		goto failed;
 	inode->i_uid = sbinfo->uid;
@@ -4044,7 +4046,11 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
+#ifdef CONFIG_SHMEM
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP,
+#else
 	.fs_flags	= FS_USERNS_MOUNT,
+#endif
 };
 
 void __init shmem_init(void)
@@ -4196,7 +4202,7 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
 #define shmem_vm_ops				generic_file_vm_ops
 #define shmem_anon_vm_ops			generic_file_vm_ops
 #define shmem_file_operations			ramfs_file_operations
-#define shmem_get_inode(sb, dir, mode, dev, flags)	ramfs_get_inode(sb, dir, mode, dev)
+#define shmem_get_inode(idmap, sb, dir, mode, dev, flags) ramfs_get_inode(sb, dir, mode, dev)
 #define shmem_acct_size(flags, size)		0
 #define shmem_unacct_size(flags, size)		do {} while (0)
 
@@ -4219,8 +4225,11 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 	if (shmem_acct_size(flags, size))
 		return ERR_PTR(-ENOMEM);
 
-	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
-				flags);
+	if (is_idmapped_mnt(mnt))
+		return ERR_PTR(-EINVAL);
+
+	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
+				S_IFREG | S_IRWXUGO, 0, flags);
 	if (unlikely(!inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_PTR(-ENOSPC);
-- 
2.38.1

