Return-Path: <linux-fsdevel+bounces-66009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCFEC179F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52D314F689C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297702D320E;
	Wed, 29 Oct 2025 00:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOvfUcBR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813CE1DF97F;
	Wed, 29 Oct 2025 00:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698807; cv=none; b=IuH2PWTurLD6z5V8Lvb06J2INY87jShdAuzVHGDAH3TMUQgw9JDspqT2LMmqScH+CHpM2/h96PNife9D7JXAuEwY9rPvdU+Sqsxw7hL2b/eY5T2HJS7QqG/Hmp1dOIxX6F4MTjFZx2/sTtcE2vcp7AXFBaZUrNqVsgTj3D2SOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698807; c=relaxed/simple;
	bh=2LmwfvKdPH4UfqgRzQ5g3TsySXd3HELJcrBIonfmsMc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nberRiyfNg7gqS/+sYBPVvR7EFFtU1GKJaYp+ArupnFUP/SBOZFkhDEGYtYqDLhBmF4cDayiX1LOAaucNuwXdZZrD0SGPECesimbDiTet+MQiQfY6dwo27lLAo2Mvi/1KyTdWZzJGpycqzzJxh6rgUw9G1mips2IxCjlw8MnUPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOvfUcBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BEEBC4CEFD;
	Wed, 29 Oct 2025 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698807;
	bh=2LmwfvKdPH4UfqgRzQ5g3TsySXd3HELJcrBIonfmsMc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=QOvfUcBR0myq3/7BB0Y8piMuRkG9qg8KoImWy5TZKLTkOEyLqNVssmIwxKXj3uwwi
	 JY5AqgFkbr1MYv3V95n1tBcqucQ3xUy63zi80C1g062Mo9YoSOhoniPXSB2dBweS12
	 IXQfD2f+veqn+ZeHu3GtpkE7Dd5VvT/asvR5oKwan1Oc7NnSHY3bCL5Fux7O4cHCGk
	 Shq0Dmk8jrre1En+IaujWit72llUP8v2JcC3dk2DPEk+sk7nRsXxeGEYDUID4kgT7k
	 WmxtBt1OFGuDAlUuQoDizErOINHe0wKDA3JFo1kFOR7vVenHMNjLa76nG94lh60L96
	 LhELK55za+X1A==
Date: Tue, 28 Oct 2025 17:46:46 -0700
Subject: [PATCH 07/31] fuse: create a per-inode flag for toggling iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810502.1424854.13869957103489591272.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a per-inode flag to control whether or not this inode actually
uses iomap.  This is required for non-regular files because iomap
doesn't apply there; and enables fuse filesystems to provide some
non-iomap files if desired.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   17 ++++++++++++++++
 include/uapi/linux/fuse.h |    3 +++
 fs/fuse/file.c            |    1 +
 fs/fuse/file_iomap.c      |   49 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |   26 ++++++++++++++++++------
 5 files changed, 90 insertions(+), 6 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 839d4f2ada4656..c7aeb324fe599e 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -257,6 +257,8 @@ enum {
 	 * or the fuse server has an exclusive "lease" on distributed fs
 	 */
 	FUSE_I_EXCLUSIVE,
+	/* Use iomap for this inode */
+	FUSE_I_IOMAP,
 };
 
 struct fuse_conn;
@@ -1717,11 +1719,26 @@ extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 
 void fuse_iomap_mount(struct fuse_mount *fm);
 void fuse_iomap_unmount(struct fuse_mount *fm);
+
+void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags);
+void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags);
+void fuse_iomap_evict_inode(struct inode *inode);
+
+static inline bool fuse_inode_has_iomap(const struct inode *inode)
+{
+	const struct fuse_inode *fi = get_fuse_inode(inode);
+
+	return test_bit(FUSE_I_IOMAP, &fi->state);
+}
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
 # define fuse_iomap_mount(...)			((void)0)
 # define fuse_iomap_unmount(...)		((void)0)
+# define fuse_iomap_init_reg_inode(...)		((void)0)
+# define fuse_iomap_init_nonreg_inode(...)	((void)0)
+# define fuse_iomap_evict_inode(...)		((void)0)
+# define fuse_inode_has_iomap(...)		(false)
 #endif
 
 #endif /* _FS_FUSE_I_H */
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e571f8ceecbfad..e949bfe022c3b0 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -243,6 +243,7 @@
  *
  *  7.99
  *  - add FUSE_IOMAP and iomap_{begin,end,ioend} for regular file operations
+ *  - add FUSE_ATTR_IOMAP to enable iomap for specific inodes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -583,9 +584,11 @@ struct fuse_file_lock {
  *
  * FUSE_ATTR_SUBMOUNT: Object is a submount root
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
+ * FUSE_ATTR_IOMAP: Use iomap for this inode
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
+#define FUSE_ATTR_IOMAP		(1 << 2)
 
 /**
  * Open flags
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05bb..42c85c19f3b13b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3135,6 +3135,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	init_waitqueue_head(&fi->page_waitq);
 	init_waitqueue_head(&fi->direct_io_waitq);
 
+	fuse_iomap_init_reg_inode(inode, flags);
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_inode_init(inode, flags);
 }
diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 1b9e1bf2f799a3..fc0d5f135bacf9 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -635,3 +635,52 @@ void fuse_iomap_unmount(struct fuse_mount *fm)
 	fuse_flush_requests_and_wait(fc);
 	fuse_send_destroy(fm);
 }
+
+static inline void fuse_inode_set_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	set_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+static inline void fuse_inode_clear_iomap(struct inode *inode)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	clear_bit(FUSE_I_IOMAP, &fi->state);
+}
+
+void fuse_iomap_init_nonreg_inode(struct inode *inode, unsigned attr_flags)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(!S_ISREG(inode->i_mode));
+
+	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP))
+		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
+
+void fuse_iomap_init_reg_inode(struct inode *inode, unsigned attr_flags)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	ASSERT(S_ISREG(inode->i_mode));
+
+	if (conn->iomap && (attr_flags & FUSE_ATTR_IOMAP)) {
+		set_bit(FUSE_I_EXCLUSIVE, &fi->state);
+		fuse_inode_set_iomap(inode);
+	}
+}
+
+void fuse_iomap_evict_inode(struct inode *inode)
+{
+	struct fuse_conn *conn = get_fuse_conn(inode);
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	if (fuse_inode_has_iomap(inode))
+		fuse_inode_clear_iomap(inode);
+	if (conn->iomap && fuse_inode_is_exclusive(inode))
+		clear_bit(FUSE_I_EXCLUSIVE, &fi->state);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 271356fa3be3ea..9b9e7b2dd0d928 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -196,6 +196,8 @@ static void fuse_evict_inode(struct inode *inode)
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
+
+	fuse_iomap_evict_inode(inode);
 }
 
 static int fuse_reconfigure(struct fs_context *fsc)
@@ -428,20 +430,32 @@ static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 	inode->i_size = attr->size;
 	inode_set_mtime(inode, attr->mtime, attr->mtimensec);
 	inode_set_ctime(inode, attr->ctime, attr->ctimensec);
-	if (S_ISREG(inode->i_mode)) {
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
 		fuse_init_common(inode);
 		fuse_init_file_inode(inode, attr->flags);
-	} else if (S_ISDIR(inode->i_mode))
+		break;
+	case S_IFDIR:
 		fuse_init_dir(inode);
-	else if (S_ISLNK(inode->i_mode))
+		fuse_iomap_init_nonreg_inode(inode, attr->flags);
+		break;
+	case S_IFLNK:
 		fuse_init_symlink(inode);
-	else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
-		 S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
+		fuse_iomap_init_nonreg_inode(inode, attr->flags);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
 		fuse_init_common(inode);
 		init_special_inode(inode, inode->i_mode,
 				   new_decode_dev(attr->rdev));
-	} else
+		fuse_iomap_init_nonreg_inode(inode, attr->flags);
+		break;
+	default:
 		BUG();
+		break;
+	}
 	/*
 	 * Ensure that we don't cache acls for daemons without FUSE_POSIX_ACL
 	 * so they see the exact same behavior as before.


