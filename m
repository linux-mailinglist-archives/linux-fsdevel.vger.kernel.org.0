Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213B56D3F64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjDCIsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbjDCIsV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35891469B
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92139B815CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D3C433D2;
        Mon,  3 Apr 2023 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511697;
        bh=alCHEsMOWI9FSAhiZoQby4G8FGoC7s8cIHuq02QwOlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFJAG6Fonx5PIwq1Ibx3C895kbftdRxkSMptSdn8S+FA2nLWdUci9v/hFV5TkT2Hz
         l65cIMH3E1mE/ytiw1gDFhA7Y0YQGSgU7UmgLjRfe9kgFOlJlhgMbWmdU/Q//U42G9
         TpZ+A5GuuEPklskqk66Xf3eqcQoAiYqdoQMebegGd/0F/tbK+CxsUKvBStaiH4mJFz
         SOQdECKnOPO0IDDJuiyGYV7XFPinkxW574Jqj+U+2dRZPp6yXRl8O3FKhxYf0kaQ0O
         MhqKn5B0193uu5XZUlh208IW53QiWdE8jdwE3j8KSjRk8cSdy7ckKOln73kvmulT7O
         rC2mUK3cP2cyA==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 2/6] shmem: make shmem_get_inode() return ERR_PTR instead of NULL
Date:   Mon,  3 Apr 2023 10:47:55 +0200
Message-Id: <20230403084759.884681-3-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
References: <20230403084759.884681-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

Make shmem_get_inode() return ERR_PTR instead of NULL on error. This will be
useful later when we introduce quota support.

There should be no functional change.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 mm/shmem.c | 205 +++++++++++++++++++++++++++++------------------------
 1 file changed, 114 insertions(+), 91 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0e63ea5f6ce69..88e13930fc013 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2354,65 +2354,71 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 	struct shmem_inode_info *info;
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 	ino_t ino;
+	int err;
+
+	err = shmem_reserve_inode(sb, &ino);
+	if (err)
+		return ERR_PTR(err);
 
-	if (shmem_reserve_inode(sb, &ino))
-		return NULL;
 
 	inode = new_inode(sb);
-	if (inode) {
-		inode->i_ino = ino;
-		inode_init_owner(idmap, inode, dir, mode);
-		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-		inode->i_generation = get_random_u32();
-		info = SHMEM_I(inode);
-		memset(info, 0, (char *)inode - (char *)info);
-		spin_lock_init(&info->lock);
-		atomic_set(&info->stop_eviction, 0);
-		info->seals = F_SEAL_SEAL;
-		info->flags = flags & VM_NORESERVE;
-		info->i_crtime = inode->i_mtime;
-		info->fsflags = (dir == NULL) ? 0 :
-			SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
-		if (info->fsflags)
-			shmem_set_inode_flags(inode, info->fsflags);
-		INIT_LIST_HEAD(&info->shrinklist);
-		INIT_LIST_HEAD(&info->swaplist);
-		simple_xattrs_init(&info->xattrs);
-		cache_no_acl(inode);
-		mapping_set_large_folios(inode->i_mapping);
-
-		switch (mode & S_IFMT) {
-		default:
-			inode->i_op = &shmem_special_inode_operations;
-			init_special_inode(inode, mode, dev);
-			break;
-		case S_IFREG:
-			inode->i_mapping->a_ops = &shmem_aops;
-			inode->i_op = &shmem_inode_operations;
-			inode->i_fop = &shmem_file_operations;
-			mpol_shared_policy_init(&info->policy,
-						 shmem_get_sbmpol(sbinfo));
-			break;
-		case S_IFDIR:
-			inc_nlink(inode);
-			/* Some things misbehave if size == 0 on a directory */
-			inode->i_size = 2 * BOGO_DIRENT_SIZE;
-			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
-			break;
-		case S_IFLNK:
-			/*
-			 * Must not load anything in the rbtree,
-			 * mpol_free_shared_policy will not be called.
-			 */
-			mpol_shared_policy_init(&info->policy, NULL);
-			break;
-		}
 
-		lockdep_annotate_inode_mutex_key(inode);
-	} else
+	if (!inode) {
 		shmem_free_inode(sb);
+		return ERR_PTR(-ENOSPC);
+	}
+
+	inode->i_ino = ino;
+	inode_init_owner(idmap, inode, dir, mode);
+	inode->i_blocks = 0;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+	inode->i_generation = get_random_u32();
+	info = SHMEM_I(inode);
+	memset(info, 0, (char *)inode - (char *)info);
+	spin_lock_init(&info->lock);
+	atomic_set(&info->stop_eviction, 0);
+	info->seals = F_SEAL_SEAL;
+	info->flags = flags & VM_NORESERVE;
+	info->i_crtime = inode->i_mtime;
+	info->fsflags = (dir == NULL) ? 0 :
+		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
+	if (info->fsflags)
+		shmem_set_inode_flags(inode, info->fsflags);
+	INIT_LIST_HEAD(&info->shrinklist);
+	INIT_LIST_HEAD(&info->swaplist);
+	simple_xattrs_init(&info->xattrs);
+	cache_no_acl(inode);
+	mapping_set_large_folios(inode->i_mapping);
+
+	switch (mode & S_IFMT) {
+	default:
+		inode->i_op = &shmem_special_inode_operations;
+		init_special_inode(inode, mode, dev);
+		break;
+	case S_IFREG:
+		inode->i_mapping->a_ops = &shmem_aops;
+		inode->i_op = &shmem_inode_operations;
+		inode->i_fop = &shmem_file_operations;
+		mpol_shared_policy_init(&info->policy,
+					 shmem_get_sbmpol(sbinfo));
+		break;
+	case S_IFDIR:
+		inc_nlink(inode);
+		/* Some things misbehave if size == 0 on a directory */
+		inode->i_size = 2 * BOGO_DIRENT_SIZE;
+		inode->i_op = &shmem_dir_inode_operations;
+		inode->i_fop = &simple_dir_operations;
+		break;
+	case S_IFLNK:
+		/*
+		 * Must not load anything in the rbtree,
+		 * mpol_free_shared_policy will not be called.
+		 */
+		mpol_shared_policy_init(&info->policy, NULL);
+		break;
+	}
+
+	lockdep_annotate_inode_mutex_key(inode);
 	return inode;
 }
 
@@ -2927,27 +2933,30 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	    struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
-	int error = -ENOSPC;
+	int error;
 
 	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, dev, VM_NORESERVE);
-	if (inode) {
-		error = simple_acl_create(dir, inode);
-		if (error)
-			goto out_iput;
-		error = security_inode_init_security(inode, dir,
-						     &dentry->d_name,
-						     shmem_initxattrs, NULL);
-		if (error && error != -EOPNOTSUPP)
-			goto out_iput;
 
-		error = 0;
-		dir->i_size += BOGO_DIRENT_SIZE;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
-		inode_inc_iversion(dir);
-		d_instantiate(dentry, inode);
-		dget(dentry); /* Extra count - pin the dentry in core */
-	}
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	error = simple_acl_create(dir, inode);
+	if (error)
+		goto out_iput;
+	error = security_inode_init_security(inode, dir,
+					     &dentry->d_name,
+					     shmem_initxattrs, NULL);
+	if (error && error != -EOPNOTSUPP)
+		goto out_iput;
+
+	error = 0;
+	dir->i_size += BOGO_DIRENT_SIZE;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	inode_inc_iversion(dir);
+	d_instantiate(dentry, inode);
+	dget(dentry); /* Extra count - pin the dentry in core */
 	return error;
+
 out_iput:
 	iput(inode);
 	return error;
@@ -2958,21 +2967,24 @@ shmem_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
 	      struct file *file, umode_t mode)
 {
 	struct inode *inode;
-	int error = -ENOSPC;
+	int error;
 
 	inode = shmem_get_inode(idmap, dir->i_sb, dir, mode, 0, VM_NORESERVE);
-	if (inode) {
-		error = security_inode_init_security(inode, dir,
-						     NULL,
-						     shmem_initxattrs, NULL);
-		if (error && error != -EOPNOTSUPP)
-			goto out_iput;
-		error = simple_acl_create(dir, inode);
-		if (error)
-			goto out_iput;
-		d_tmpfile(file, inode);
-	}
+
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
+
+	error = security_inode_init_security(inode, dir,
+					     NULL,
+					     shmem_initxattrs, NULL);
+	if (error && error != -EOPNOTSUPP)
+		goto out_iput;
+	error = simple_acl_create(dir, inode);
+	if (error)
+		goto out_iput;
+	d_tmpfile(file, inode);
 	return finish_open_simple(file, error);
+
 out_iput:
 	iput(inode);
 	return error;
@@ -3146,8 +3158,9 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	inode = shmem_get_inode(idmap, dir->i_sb, dir, S_IFLNK | 0777, 0,
 				VM_NORESERVE);
-	if (!inode)
-		return -ENOSPC;
+
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	error = security_inode_init_security(inode, dir, &dentry->d_name,
 					     shmem_initxattrs, NULL);
@@ -3762,12 +3775,13 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct shmem_options *ctx = fc->fs_private;
 	struct inode *inode;
 	struct shmem_sb_info *sbinfo;
+	int error = -ENOMEM;
 
 	/* Round up to L1_CACHE_BYTES to resist false sharing */
 	sbinfo = kzalloc(max((int)sizeof(struct shmem_sb_info),
 				L1_CACHE_BYTES), GFP_KERNEL);
 	if (!sbinfo)
-		return -ENOMEM;
+		return error;
 
 	sb->s_fs_info = sbinfo;
 
@@ -3829,8 +3843,10 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	inode = shmem_get_inode(&nop_mnt_idmap, sb, NULL, S_IFDIR | sbinfo->mode, 0,
 				VM_NORESERVE);
-	if (!inode)
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
 		goto failed;
+	}
 	inode->i_uid = sbinfo->uid;
 	inode->i_gid = sbinfo->gid;
 	sb->s_root = d_make_root(inode);
@@ -3840,7 +3856,7 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 failed:
 	shmem_put_super(sb);
-	return -ENOMEM;
+	return error;
 }
 
 static int shmem_get_tree(struct fs_context *fc)
@@ -4209,10 +4225,16 @@ EXPORT_SYMBOL_GPL(shmem_truncate_range);
 #define shmem_vm_ops				generic_file_vm_ops
 #define shmem_anon_vm_ops			generic_file_vm_ops
 #define shmem_file_operations			ramfs_file_operations
-#define shmem_get_inode(idmap, sb, dir, mode, dev, flags) ramfs_get_inode(sb, dir, mode, dev)
 #define shmem_acct_size(flags, size)		0
 #define shmem_unacct_size(flags, size)		do {} while (0)
 
+static inline struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
+					    umode_t mode, dev_t dev, unsigned long flags)
+{
+	struct inode *inode = ramfs_get_inode(sb, dir, mode, dev);
+	return inode ? inode : ERR_PTR(-ENOSPC);
+}
+
 #endif /* CONFIG_SHMEM */
 
 /* common code */
@@ -4237,9 +4259,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
 				S_IFREG | S_IRWXUGO, 0, flags);
-	if (unlikely(!inode)) {
+
+	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
-		return ERR_PTR(-ENOSPC);
+		return ERR_CAST(inode);
 	}
 	inode->i_flags |= i_flags;
 	inode->i_size = size;
-- 
2.30.2

