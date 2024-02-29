Return-Path: <linux-fsdevel+bounces-13193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC9486CCD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 16:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A600FB20EAB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 15:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE0313F016;
	Thu, 29 Feb 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aqJwvh8W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A62413EFFB
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220267; cv=none; b=UtHmVp9e6WX+nmkTBfeorxC8EGkDo/kMKBHrPbGCOuOR1+xYPusccXWvsbSPiUASUF+SrteDrUYWJcMzRRSl2vrP6ax1/OH/RZc5dEGNwrUt80Fq8or3LM4JFN/Is5gdYIFhcF4AtOVFfIp44SCEWr3uRz1FUPPHny3/DetyQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220267; c=relaxed/simple;
	bh=9i8HeEsXq2d06Gz/jQudMgcUj6vDZVdN5Mw7zWlg8s0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fOkipfGBRNtvKAKrAC332vI1VQjD7mYcXYDIU8HVMxeM0YfjOdkKGNsjqHxy0EX+KoTIcGNhLkuXXlDXi8S71PfJWFVLjn0cfAmnBp3pItPldFLCXvxXidzBMG9M2Vu1pTMrrFhimVqDmrM+LtLWpqKAujM3Cn/uSuxIdeJS7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aqJwvh8W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709220264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AxmBeNt1M6ySpa8ysrWdbvthE9c/VEZKD+FVbjOLoMc=;
	b=aqJwvh8WvcgEEdwBwDHQTirm6ZqQFgqI6FOsl25d2EipZ8Q9t6vjo6y46oguQCKG5Zmd4J
	U7C+gQuOLvxViy0WjrxJvx6FadkLKsBi51aJ6HyOesfdvpXjTI9E/uWUNsAJMvFvxq/Tng
	clAPk10Kz9H1flDhgqj6XLH9Bn73cw8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-6fgxHGHfP2Cy_IXmSV4TJw-1; Thu,
 29 Feb 2024 10:24:20 -0500
X-MC-Unique: 6fgxHGHfP2Cy_IXmSV4TJw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F3193C11A14;
	Thu, 29 Feb 2024 15:24:20 +0000 (UTC)
Received: from carbon.redhat.com (unknown [10.39.193.65])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2DF4B492BE2;
	Thu, 29 Feb 2024 15:24:19 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: muchun.song@linux.dev,
	brauner@kernel.org,
	rodrigo@sdfg.com.ar
Subject: [PATCH] hugetlbfs: support idmapped mounts
Date: Thu, 29 Feb 2024 16:24:05 +0100
Message-ID: <20240229152405.105031-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

pass down the idmapped mount information to the different helper
functions.

Differently, hugetlb_file_setup() will continue to not have any
mapping since it is only used from contexts where idmapped mounts are
not used.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/hugetlbfs/inode.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d746866ae3b6..6502c7e776d1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -933,7 +933,7 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 	unsigned int ia_valid = attr->ia_valid;
 	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
-	error = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	error = setattr_prepare(idmap, dentry, attr);
 	if (error)
 		return error;
 
@@ -950,7 +950,7 @@ static int hugetlbfs_setattr(struct mnt_idmap *idmap,
 		hugetlb_vmtruncate(inode, newsize);
 	}
 
-	setattr_copy(&nop_mnt_idmap, inode, attr);
+	setattr_copy(idmap, inode, attr);
 	mark_inode_dirty(inode);
 	return 0;
 }
@@ -985,6 +985,7 @@ static struct inode *hugetlbfs_get_root(struct super_block *sb,
 static struct lock_class_key hugetlbfs_i_mmap_rwsem_key;
 
 static struct inode *hugetlbfs_get_inode(struct super_block *sb,
+					struct mnt_idmap *idmap,
 					struct inode *dir,
 					umode_t mode, dev_t dev)
 {
@@ -1006,7 +1007,7 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
 
 		inode->i_ino = get_next_ino();
-		inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
+		inode_init_owner(idmap, inode, dir, mode);
 		lockdep_set_class(&inode->i_mapping->i_mmap_rwsem,
 				&hugetlbfs_i_mmap_rwsem_key);
 		inode->i_mapping->a_ops = &hugetlbfs_aops;
@@ -1050,7 +1051,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 {
 	struct inode *inode;
 
-	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
+	inode = hugetlbfs_get_inode(dir->i_sb, idmap, dir, mode, dev);
 	if (!inode)
 		return -ENOSPC;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -1062,7 +1063,7 @@ static int hugetlbfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 static int hugetlbfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			   struct dentry *dentry, umode_t mode)
 {
-	int retval = hugetlbfs_mknod(&nop_mnt_idmap, dir, dentry,
+	int retval = hugetlbfs_mknod(idmap, dir, dentry,
 				     mode | S_IFDIR, 0);
 	if (!retval)
 		inc_nlink(dir);
@@ -1073,7 +1074,7 @@ static int hugetlbfs_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
 			    umode_t mode, bool excl)
 {
-	return hugetlbfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
+	return hugetlbfs_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }
 
 static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
@@ -1082,7 +1083,7 @@ static int hugetlbfs_tmpfile(struct mnt_idmap *idmap,
 {
 	struct inode *inode;
 
-	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
+	inode = hugetlbfs_get_inode(dir->i_sb, idmap, dir, mode | S_IFREG, 0);
 	if (!inode)
 		return -ENOSPC;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
@@ -1094,10 +1095,11 @@ static int hugetlbfs_symlink(struct mnt_idmap *idmap,
 			     struct inode *dir, struct dentry *dentry,
 			     const char *symname)
 {
+	const umode_t mode = S_IFLNK|S_IRWXUGO;
 	struct inode *inode;
 	int error = -ENOSPC;
 
-	inode = hugetlbfs_get_inode(dir->i_sb, dir, S_IFLNK|S_IRWXUGO, 0);
+	inode = hugetlbfs_get_inode(dir->i_sb, idmap, dir, mode, 0);
 	if (inode) {
 		int l = strlen(symname)+1;
 		error = page_symlink(inode, symname, l);
@@ -1566,6 +1568,7 @@ static struct file_system_type hugetlbfs_fs_type = {
 	.init_fs_context	= hugetlbfs_init_fs_context,
 	.parameters		= hugetlb_fs_parameters,
 	.kill_sb		= kill_litter_super,
+	.fs_flags               = FS_ALLOW_IDMAP,
 };
 
 static struct vfsmount *hugetlbfs_vfsmount[HUGE_MAX_HSTATE];
@@ -1619,7 +1622,9 @@ struct file *hugetlb_file_setup(const char *name, size_t size,
 	}
 
 	file = ERR_PTR(-ENOSPC);
-	inode = hugetlbfs_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0);
+	/* hugetlbfs_vfsmount[] mounts do not use idmapped mounts.  */
+	inode = hugetlbfs_get_inode(mnt->mnt_sb, &nop_mnt_idmap, NULL,
+				    S_IFREG | S_IRWXUGO, 0);
 	if (!inode)
 		goto out;
 	if (creat_flags == HUGETLB_SHMFS_INODE)
-- 
2.44.0


