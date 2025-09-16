Return-Path: <linux-fsdevel+bounces-61541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED0BB589B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2472005E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD3C1A0711;
	Tue, 16 Sep 2025 00:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koXgUGGy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1328BD528;
	Tue, 16 Sep 2025 00:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983011; cv=none; b=e/yJkn4w61PzGEZFNguk4EGaL7v27/K0vZYkT3cmq2e9AERrzGmb6DzKk5A1qhNJz+0GOJwe3MjMQ6gp2PUVB9RRonC2bJUMx+otcvmd6nof+28NAYAaSUS9Z6qSmZNeOoP2e3FDuQaKzmhwhXDLji84jop6EDGvo6tM4O6BCY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983011; c=relaxed/simple;
	bh=F9Fu8nL/toCoi50j7kJ3H3ss4cfwP/JzDO/QZxN+PLo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8vtz6a3IAoZCFl87dE5hrMjeCoLPS60TcJjqG8DDMwny6gLt4SHYdlpNh0/V5FLc+oosqjphYfC5dbzv0Jj0qUrRv6AKMkLWzyDO+Coq1FGQunPPKcbbLA6lxXGXAM0E7aiLkbl0I9Y7U6fj1Ilt0ezsi1TAmRxV3c/Lrq0BQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koXgUGGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98398C4CEF1;
	Tue, 16 Sep 2025 00:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983010;
	bh=F9Fu8nL/toCoi50j7kJ3H3ss4cfwP/JzDO/QZxN+PLo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=koXgUGGy2X0prcH4gGv0tkesM2wOnyfv/CdkR4pd4/XBuyujpQpQKDrOqqbKGB8xV
	 IUjQWfrlNRjb+qwNY4AQ+ejBKw9bbuxo5Hiue9o4nifkIp4/A/3EiY2wkIhaQ1WY5I
	 +Q6rdDl2QOo3nOtxS615BcDRvyYD9GcP/4g80/ySpsx2yuka+0F9faEDcT1DowjaMZ
	 We8CU4lR6Job74etKUWVf/B+HR0pwqSr9XogDfecFQYLgU/9QHqIipdnWmSR4EQhzT
	 +OWgOgOMYNdySbnQCIGvsYbH73w8byKztlcBw42dLIz4E66hPDVN1V0DNH6KepNqZR
	 rPlxaovt8TBnQ==
Date: Mon, 15 Sep 2025 17:36:50 -0700
Subject: [PATCH 3/9] fuse: allow local filesystems to set some VFS iflags
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152503.383971.14388622058355442298.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
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
 fs/fuse/ioctl.c           |   53 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index fb60686fb9c61a..ae03a898d3aa7d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1629,6 +1629,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 472605d7ff6a2f..94ec220beb5f79 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -242,6 +242,8 @@
  *  - add FUSE_IOMAP_CONFIG so the fuse server can configure more fs geometry
  *  - add FUSE_NOTIFY_IOMAP_DEV_INVAL to invalidate iomap bdev ranges
  *  - add FUSE_ATTR_ATOMIC for single-fsblock atomic write support
+ *  - add FUSE_ATTR_{SYNC,IMMUTABLE,APPEND} for VFS enforcement of file
+ *    attributes
  */
 
 #ifndef _LINUX_FUSE_H
@@ -597,11 +599,17 @@ struct fuse_file_lock {
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
index 380559950c3444..30c914ba4bb23f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1254,6 +1254,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = fc->blkbits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b63e4e1d8f45ce..f845864bf50dee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -521,6 +521,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
+		fuse_fileattr_init(inode, attr);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index f5f7d806262cdf..fc0c9bac7a5939 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -502,6 +502,56 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
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
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int old_iflags = inode->i_flags;
+
+	if (!fc->local_fs)
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
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	if (!fc->local_fs)
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
@@ -574,7 +624,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);


