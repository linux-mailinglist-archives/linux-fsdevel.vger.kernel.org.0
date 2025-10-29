Return-Path: <linux-fsdevel+bounces-66039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD4C17AB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0001897DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928862D6E51;
	Wed, 29 Oct 2025 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C24G8rZB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE147258ED8;
	Wed, 29 Oct 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699277; cv=none; b=SMzlk3oLRDBWtSwwV7tIFj0fmZXwTPDINUfdurv/2KSNy0HWKjLAf4tzUnH1MHt1vsTD/Aa1UlsZH3y0SCQqu9YUk15NR+Um7hEO+31yDaicmchx+2OkQ77ba2XjeqMwzX3+vySZNW5bbP5zTvzM56t/l7+WTwKalwyymMtvEUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699277; c=relaxed/simple;
	bh=TvcxE52D2ZNmLY2oC+gwYq4MrjWLExTstveV0eEfmzY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOeLRLiLsww1fGEYDbGBAnWZFIq/MbaThCrFGHqEBhkKUmeTJ29yUiZ1H5rLKp4yodZ8aTa4I1uMh6H3x5/EFvOzV/xRJlTNHoVly4wify4SahCcSG2QjZLWoPzIcEmjmDErRuC7lT1xz6GQCLFy2E42sTRVtwHY7FAWbEqNWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C24G8rZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6615AC4CEE7;
	Wed, 29 Oct 2025 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699276;
	bh=TvcxE52D2ZNmLY2oC+gwYq4MrjWLExTstveV0eEfmzY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C24G8rZBCYFto0YhDFi3cgvQ8Yzma9jLN2lO5VvbBtUQ6DVhB4DUvEUUAdkMXq9Ta
	 UAwzYZTxi3eAjoQtA/SLMWSv/tjmDgS18jhM9XhazG46lHKlsmfFlF+DGj9rCs0WWv
	 LUtX+Ru1BEXkmWnPSMBZl8Vvqd0cbhVnta0+wOKVe6tk9JeLWh8cu4lxJ0gScPyB6L
	 X6aavdeHQD8YY6/IPX90pToskySGD6rhEsbeiS2+6EvA8ZWNxf6jNfKu1EyR/Hz/vk
	 j6NBv4JT7KQo6ERLaBhnLOQ9WpUn4QEqVqpXcR++kdHfXoOgsZpBITevdXtyh1+CnD
	 vuzdOa4kX4NOg==
Date: Tue, 28 Oct 2025 17:54:35 -0700
Subject: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169811656.1426244.11474449087922753694.stgit@frogsfrogsfrogs>
In-Reply-To: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
References: <176169811533.1426244.7175103913810588669.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

There are three inode flags (immutable, append, sync) that are enforced
by the VFS.  Whenever we go around setting iflags, let's update the VFS
state so that they actually work.  Make it so that the fuse server can
set these three inode flags at load time and have the kernel advertise
and enforce them.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    1 +
 include/uapi/linux/fuse.h |    8 +++++++
 fs/fuse/dir.c             |    1 +
 fs/fuse/inode.c           |    1 +
 fs/fuse/ioctl.c           |   50 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b599e467146d33..b4c62e51dec9ea 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1633,6 +1633,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5d10e471f2df7f..6061238f08f210 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -247,6 +247,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -602,11 +604,17 @@ struct fuse_file_lock {
  * FUSE_ATTR_DAX: Enable DAX for this file in per inode DAX mode
  * FUSE_ATTR_IOMAP: Use iomap for this inode
  * FUSE_ATTR_ATOMIC: Enable untorn writes
+ * FUSE_ATTR_SYNC: File writes are synchronous
+ * FUSE_ATTR_IMMUTABLE: File is immutable
+ * FUSE_ATTR_APPEND: File is append-only
  */
 #define FUSE_ATTR_SUBMOUNT      (1 << 0)
 #define FUSE_ATTR_DAX		(1 << 1)
 #define FUSE_ATTR_IOMAP		(1 << 2)
 #define FUSE_ATTR_ATOMIC	(1 << 3)
+#define FUSE_ATTR_SYNC		(1 << 4)
+#define FUSE_ATTR_IMMUTABLE	(1 << 5)
+#define FUSE_ATTR_APPEND	(1 << 6)
 
 /**
  * Open flags
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4bfc8fe52532a6..492222862ed2b0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1247,6 +1247,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = fc->blkbits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 2fc75719969a89..707bd3718be681 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -531,6 +531,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
+		fuse_fileattr_init(inode, attr);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 07529db21fb781..bd2caf191ce2e0 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -502,6 +502,53 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
 	fuse_file_release(inode, ff, O_RDONLY, NULL, S_ISDIR(inode->i_mode));
 }
 
+static inline void update_iflag(struct inode *inode, unsigned int iflag,
+				bool set)
+{
+	if (set)
+		inode->i_flags |= iflag;
+	else
+		inode->i_flags &= ~iflag;
+}
+
+static void fuse_fileattr_update_inode(struct inode *inode,
+				       const struct file_kattr *fa)
+{
+	unsigned int old_iflags = inode->i_flags;
+
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (fa->flags_valid) {
+		update_iflag(inode, S_SYNC, fa->flags & FS_SYNC_FL);
+		update_iflag(inode, S_IMMUTABLE, fa->flags & FS_IMMUTABLE_FL);
+		update_iflag(inode, S_APPEND, fa->flags & FS_APPEND_FL);
+	} else if (fa->fsx_valid) {
+		update_iflag(inode, S_SYNC, fa->fsx_xflags & FS_XFLAG_SYNC);
+		update_iflag(inode, S_IMMUTABLE,
+					fa->fsx_xflags & FS_XFLAG_IMMUTABLE);
+		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
+	}
+
+	if (old_iflags != inode->i_flags)
+		fuse_invalidate_attr(inode);
+}
+
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
+{
+	if (!fuse_inode_is_exclusive(inode))
+		return;
+
+	if (attr->flags & FUSE_ATTR_SYNC)
+		inode->i_flags |= S_SYNC;
+
+	if (attr->flags & FUSE_ATTR_IMMUTABLE)
+		inode->i_flags |= S_IMMUTABLE;
+
+	if (attr->flags & FUSE_ATTR_APPEND)
+		inode->i_flags |= S_APPEND;
+}
+
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -572,7 +619,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);


