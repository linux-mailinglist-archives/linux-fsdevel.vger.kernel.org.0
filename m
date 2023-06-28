Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B201B7414E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjF1PZb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjF1PZ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:25:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3547E268F
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD7361365
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E6BC433C0;
        Wed, 28 Jun 2023 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687965924;
        bh=ZMnvUqzeadwEtrY+PraNrm34AEWiOd4yOx+5Vnlx2ig=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eRsGE8sow61Jtmo9m1fmSdyyOPmgSQMrcRjqKc0muqWxg1u7+6Fj8L+xgURNdQ/pO
         +Ix3A5CvAA6TfBuKqIs/JHBu60Xh4ptvkPZcTrUZsuC6HeKwPMtnQrzriek9O1ZTlA
         M1hoB1LZaxyCGqx1bnhp6/kBYfJiBSUpUeREoKlr8X52aj2ogK1XMj50Qe9jPQhQuX
         5dJxdwZmp88VV5qBbLlT2ekDYX0QLDejwVj9sB0ljcwEzxAAkW7iVWGh5B4wF3Bub/
         4yoapVGZhQBh4Xo95xjUluRsXp4qRY/s/m4ohVp5PQTiwmSnwLVRaX8yOPV6iczvP/
         aqGdhWuTBaNNw==
Subject: [PATCH v6 3/3] shmem: stable directory offsets
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 28 Jun 2023 11:25:22 -0400
Message-ID: <168796592256.157221.15420161253379368867.stgit@manet.1015granger.net>
In-Reply-To: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
References: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The current cursor-based directory offset mechanism doesn't work
when a tmpfs filesystem is exported via NFS. This is because NFS
clients do not open directories. Each server-side READDIR operation
has to open the directory, read it, then close it. The cursor state
for that directory, being associated strictly with the opened
struct file, is thus discarded after each NFS READDIR operation.

Directory offsets are cached not only by NFS clients, but also by
user space libraries on those clients. Essentially there is no way
to invalidate those caches when directory offsets have changed on
an NFS server after the offset-to-dentry mapping changes. Thus the
whole application stack depends on unchanging directory offsets.

The solution we've come up with is to make the directory offset for
each file in a tmpfs filesystem stable for the life of the directory
entry it represents.

shmem_readdir() and shmem_dir_llseek() now use an xarray to map each
directory offset (an loff_t integer) to the memory address of a
struct dentry.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/shmem_fs.h |    1 +
 mm/shmem.c               |   47 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9029abd29b1c..a5454a80ab30 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -27,6 +27,7 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+	struct offset_ctx	dir_offsets;	/* stable entry offsets */
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 721f9fd064aa..318a6e70b6b1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2355,6 +2355,11 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
 #define shmem_initxattrs NULL
 #endif
 
+static struct offset_ctx *shmem_get_offset_ctx(struct inode *inode)
+{
+	return &SHMEM_I(inode)->dir_offsets;
+}
+
 static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
 				     struct inode *dir, umode_t mode, dev_t dev,
 				     unsigned long flags)
@@ -2410,7 +2415,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			/* Some things misbehave if size == 0 on a directory */
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
-			inode->i_fop = &simple_dir_operations;
+			inode->i_fop = &simple_offset_dir_operations;
+			simple_offset_init(shmem_get_offset_ctx(inode));
 			break;
 		case S_IFLNK:
 			/*
@@ -2950,7 +2956,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
-		error = 0;
+		error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+		if (error)
+			goto out_iput;
+
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		inode_inc_iversion(dir);
@@ -3027,6 +3036,13 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	ret = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+	if (ret) {
+		if (inode->i_nlink)
+			shmem_free_inode(inode->i_sb);
+		goto out;
+	}
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3045,6 +3061,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
+	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
+
 	dir->i_size -= BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
@@ -3103,24 +3121,29 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(old_dentry);
 	int they_are_dirs = S_ISDIR(inode->i_mode);
+	int error;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
 
 	if (flags & RENAME_EXCHANGE)
-		return simple_rename_exchange(old_dir, old_dentry, new_dir, new_dentry);
+		return simple_offset_rename_exchange(old_dir, old_dentry,
+						     new_dir, new_dentry);
 
 	if (!simple_empty(new_dentry))
 		return -ENOTEMPTY;
 
 	if (flags & RENAME_WHITEOUT) {
-		int error;
-
 		error = shmem_whiteout(idmap, old_dir, old_dentry);
 		if (error)
 			return error;
 	}
 
+	simple_offset_remove(shmem_get_offset_ctx(old_dir), old_dentry);
+	error = simple_offset_add(shmem_get_offset_ctx(new_dir), old_dentry);
+	if (error)
+		return error;
+
 	if (d_really_is_positive(new_dentry)) {
 		(void) shmem_unlink(new_dir, new_dentry);
 		if (they_are_dirs) {
@@ -3164,19 +3187,23 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	if (error && error != -EOPNOTSUPP)
 		goto out_iput;
 
+	error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
+	if (error)
+		goto out_iput;
+
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
 		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
 		if (!inode->i_link) {
 			error = -ENOMEM;
-			goto out_iput;
+			goto out_remove_offset;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
 		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
 		if (error)
-			goto out_iput;
+			goto out_remove_offset;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
@@ -3191,6 +3218,9 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
+
+out_remove_offset:
+	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
 out_iput:
 	iput(inode);
 	return error;
@@ -3920,6 +3950,8 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if (S_ISDIR(inode->i_mode))
+		simple_offset_destroy(shmem_get_offset_ctx(inode));
 }
 
 static void shmem_init_inode(void *foo)
@@ -4000,6 +4032,7 @@ static const struct inode_operations shmem_dir_inode_operations = {
 	.mknod		= shmem_mknod,
 	.rename		= shmem_rename2,
 	.tmpfile	= shmem_tmpfile,
+	.get_offset_ctx	= shmem_get_offset_ctx,
 #endif
 #ifdef CONFIG_TMPFS_XATTR
 	.listxattr	= shmem_listxattr,


