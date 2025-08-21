Return-Path: <linux-fsdevel+bounces-58470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F35B2E9E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D8E3AA4BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A0A1F4C8E;
	Thu, 21 Aug 2025 01:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2d/kajv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7C1A9FBC
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738004; cv=none; b=pDt+D2weO1T8j0Xdd5xBrRIksHS9mxRBY2eUxBrix0NyUmpc/wUzzRHuTePaG2b9iU/Gbmir8l99bWB4MAgr5xX5Gy7EXhXhYVJQNNShE7uvqd3pDPGWPmRUFQQf1ejq5LK1xAoJcTUx2qRCqOhPbSEn7pP8CwKyTYA56PA46CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738004; c=relaxed/simple;
	bh=F/JDrfcA5rJccWCSORn22XuZKEdlePw3fBPuwRIcIBI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnuvJrFT5bM04yYXUK8O7bMCUnXQQk/xfNYEgRih6w1iK8YUzFcxj6zOem7BNBhYV5D29H/l8NlAULvAT71dhhEf98nwQ2A9pPBz0pcv6gna3Kq4ZPkzqGCJ2+nHAqGO5PJ1UMHpNmU9CtVliXwS6zRoVXxwd0JY9wrVb3KuyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2d/kajv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478CAC4CEE7;
	Thu, 21 Aug 2025 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738004;
	bh=F/JDrfcA5rJccWCSORn22XuZKEdlePw3fBPuwRIcIBI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=d2d/kajvmYgGVjQ8tIG4Z1bxeEBwP4F9oYCDZurm+ODXZahuwuE058jSH/s9qx+fJ
	 1ZWi1r48nQiJVatWZlVAMXXuvQxHUZFIA7iMCjoG22vk0w9wbD3QYWm6IsXiEj1JKU
	 3WYtuQPaHSiJ8YOesbtZu8QBg6Ug8cb+J+G+JoMTK/dD5f1nm0W2r14TGRtcFOUwb0
	 zyOodF6ZH7FBJ3GGhqStfIVodr2W+HBHmzTRyVIKVIz4bEv84sypdpKcI4xkoQeUb3
	 vGbhZvttqYLiDsr1RsrTJLRDvJOYLVpO4UgOegci5KRZ6/fQrnVPE4SNP/vG4ymruw
	 Z+n1uFIJDGrOg==
Date: Wed, 20 Aug 2025 18:00:03 -0700
Subject: [PATCH 2/6] fuse: synchronize inode->i_flags after fileattr_[gs]et
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710225.18622.5729581662089321433.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
References: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
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
state so that they actually work.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h     |    1 +
 fs/fuse/fuse_trace.h |   23 +++++++++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/inode.c      |    1 +
 fs/fuse/ioctl.c      |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 116 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a710c56b205e30..f7a7d8ad641d5b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1588,6 +1588,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct file_kattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 80af541a54c5bd..aea9ea0835d497 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -176,6 +176,29 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+TRACE_EVENT(fuse_fileattr_update_inode,
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags),
+
+	TP_ARGS(inode, old_iflags),
+
+	TP_STRUCT__entry(
+		FUSE_INODE_FIELDS
+		__field(unsigned int,		old_iflags)
+		__field(unsigned int,		new_iflags)
+	),
+
+	TP_fast_assign(
+		FUSE_INODE_ASSIGN(inode, fi, fm);
+		__entry->old_iflags	=	old_iflags;
+		__entry->new_iflags	=	inode->i_flags;
+	),
+
+	TP_printk(FUSE_INODE_FMT " old_iflags 0x%x iflags 0x%x",
+		  FUSE_INODE_PRINTK_ARGS,
+		  __entry->old_iflags,
+		  __entry->new_iflags)
+);
+
 #ifdef CONFIG_FUSE_BACKING
 #define FUSE_BACKING_PASSTHROUGH	(1U << 0)
 #define FUSE_BACKING_IOMAP		(1U << 1)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 05cb79beb8e426..d2f9bcccd776f0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1254,6 +1254,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 18dc9492d19174..b1793df3cbbd1a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -524,6 +524,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr, fc);
+		fuse_fileattr_init(inode, attr);
 		unlock_new_inode(inode);
 	} else if (fuse_stale_inode(inode, generation, attr)) {
 		/* nodeid was reused, any I/O on the old inode should fail */
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index f5f7d806262cdf..c320ea80cb3db8 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -502,6 +503,92 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
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
+	/*
+	 * Prior to iomap, the fuse driver sent all file IO operations to the
+	 * fuse server, which was wholly responsible for enforcing the
+	 * immutable and append bits.  With iomap, we let more of the kernel IO
+	 * path stay within the kernel, so we actually have to set the VFS
+	 * flags now so that the enforcement can take place inside the kernel.
+	 */
+	if (!fuse_has_iomap(inode))
+		return;
+
+	/*
+	 * Configure VFS enforcement of the three inode flags that we support.
+	 * XXX: still need to figure out what's going on wrt NOATIME in fuse.
+	 */
+	if (fa->flags_valid) {
+		update_iflag(inode, S_SYNC, fa->flags & FS_SYNC_FL);
+		update_iflag(inode, S_IMMUTABLE, fa->flags & FS_IMMUTABLE_FL);
+		update_iflag(inode, S_APPEND, fa->flags & FS_APPEND_FL);
+	} else if (fa->fsx_xflags) {
+		update_iflag(inode, S_SYNC, fa->fsx_xflags & FS_XFLAG_SYNC);
+		update_iflag(inode, S_IMMUTABLE,
+					fa->fsx_xflags & FS_XFLAG_IMMUTABLE);
+		update_iflag(inode, S_APPEND, fa->fsx_xflags & FS_XFLAG_APPEND);
+	}
+
+	trace_fuse_fileattr_update_inode(inode, old_iflags);
+
+	if (old_iflags != inode->i_flags)
+		fuse_invalidate_attr(inode);
+}
+
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr)
+{
+	struct file_kattr fa;
+	struct fsxattr xfa = { };
+	struct fuse_file *ff;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+	unsigned int flags = 0;
+	int err;
+
+	if (!fuse_has_iomap(inode))
+		return;
+
+	/*
+	 * Don't do this when we're setting up the root inode because the
+	 * connection workers haven't been set up yet.
+	 */
+	if (attr->ino == fc->root_nodeid && attr->blksize == 0)
+		return;
+
+	ff = fuse_priv_ioctl_prepare(inode);
+	if (IS_ERR(ff))
+		return;
+
+	err = fuse_priv_ioctl(inode, ff, FS_IOC_FSGETXATTR, &xfa, sizeof(xfa));
+	if (!err) {
+		fileattr_fill_xflags(&fa, xfa.fsx_xflags);
+		fuse_fileattr_update_inode(inode, &fa);
+		goto cleanup;
+	}
+
+	err = fuse_priv_ioctl(inode, ff, FS_IOC_GETFLAGS, &flags, sizeof(flags));
+	if (!err) {
+		fileattr_fill_flags(&fa, flags);
+		fuse_fileattr_update_inode(inode, &fa);
+		goto cleanup;
+	}
+
+cleanup:
+	fuse_priv_ioctl_cleanup(inode, ff);
+}
+
 int fuse_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -574,7 +661,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);


