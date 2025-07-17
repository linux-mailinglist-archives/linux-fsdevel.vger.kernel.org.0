Return-Path: <linux-fsdevel+bounces-55340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08FB09821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 01:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630FDA62788
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 23:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4129B24110F;
	Thu, 17 Jul 2025 23:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDCtv0Cw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A272E21A928
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 23:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752795187; cv=none; b=N/yl4uPzhG+uEwFI7NcTo6U+vy1fpc7/7+8wNXVqaie6+m1lfj4qHKwal3oL+jY/DAdZglNZSyhcQiRtIJIevuIH+wp62ToTWkMJK0LpHYnGLsDlKmlPooeHhHQWVkiMkGfcKNzPgjEf0hN9nuvwhWf/DtksIW65LjIuO1VpC+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752795187; c=relaxed/simple;
	bh=7UK7lQe9w7VF9nklkTll/83ml/FrCCTnHFqsk6TW5ow=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DlE4/4Lh3026LqN2Pv8Fzc6sWplUOrZQ6B2zPWfe7AjkexgBIZcYHUtUQseg9NoCv1uGHH0i/HIi7xuNBUR6nDFDHBzeR7uHGoa7plgb9Mu+uYFWFW5vp0Kzq2aheaNFx8EZXvEAV2kSv7VTYiZLhGVW0GLfDLNKSP7SLx6tb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDCtv0Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C26FC4CEF0;
	Thu, 17 Jul 2025 23:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752795187;
	bh=7UK7lQe9w7VF9nklkTll/83ml/FrCCTnHFqsk6TW5ow=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LDCtv0CwptNJFNq+t7/PR4+ix243Jkk9UWKciljA0VcBgK/m/0lk8bArnM80Ln4t/
	 pbdgZL+Y+x8/xtiyFpQCv/1IDewhiaEOtvJS3WGvTl84WWHsCs7gCBFXSeXinXf0rR
	 YGWroVJbij07fBOvPJtNieUD8qw3iYiFbuMaSy7h3DKagPLfW8zTp0Ek28vId95FIg
	 Y12Ce4cNTB2dANBAT+ZP1sQNbD6pHrmCyc9snQhwdpC+9yZryTP4EV49n1Y8lrvRGv
	 pHPYdGq4+/vEIi3MFu2JkaVcFqGgtJCSeSfErlrEng+yiErd+jDxom+3gyE3BsByE0
	 raAHr2Xqraizw==
Date: Thu, 17 Jul 2025 16:33:06 -0700
Subject: [PATCH 2/7] fuse: synchronize inode->i_flags after fileattr_[gs]et
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net,
 miklos@szeredi.hu, bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175279450827.713693.18393351763830445477.stgit@frogsfrogsfrogs>
In-Reply-To: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
References: <175279450745.713693.16690872492281672288.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_trace.h |   31 +++++++++++++++++
 fs/fuse/dir.c        |    1 +
 fs/fuse/inode.c      |    1 +
 fs/fuse/ioctl.c      |   89 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 123 insertions(+)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e7da75d8a5741d..3058d02cd65cc7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1579,6 +1579,7 @@ long fuse_file_compat_ioctl(struct file *file, unsigned int cmd,
 int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 int fuse_fileattr_set(struct mnt_idmap *idmap,
 		      struct dentry *dentry, struct fileattr *fa);
+void fuse_fileattr_init(struct inode *inode, const struct fuse_attr *attr);
 
 /* iomode.c */
 int fuse_file_cached_io_open(struct inode *inode, struct fuse_file *ff);
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index cc22635790b68c..e5a41be1bfd6cf 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -128,6 +128,37 @@ TRACE_EVENT(fuse_request_end,
 		  __entry->unique, __entry->len, __entry->error)
 );
 
+TRACE_EVENT(fuse_fileattr_update_inode,
+	TP_PROTO(const struct inode *inode, unsigned int old_iflags),
+
+	TP_ARGS(inode, old_iflags),
+
+	TP_STRUCT__entry(
+		__field(dev_t,		connection)
+		__field(uint64_t,	ino)
+		__field(uint64_t,	nodeid)
+		__field(loff_t,		isize)
+		__field(unsigned int,	old_iflags)
+		__field(unsigned int,	new_iflags)
+	),
+
+	TP_fast_assign(
+		const struct fuse_inode *fi = get_fuse_inode_c(inode);
+		const struct fuse_mount *fm = get_fuse_mount_c(inode);
+
+		__entry->connection	=	fm->fc->dev;
+		__entry->ino		=	fi->orig_ino;
+		__entry->nodeid		=	fi->nodeid;
+		__entry->isize		=	i_size_read(inode);
+		__entry->old_iflags	=	old_iflags;
+		__entry->new_iflags	=	inode->i_flags;
+	),
+
+	TP_printk("connection %u ino %llu nodeid %llu isize 0x%llx old_iflags 0x%x iflags 0x%x",
+		  __entry->connection, __entry->ino, __entry->nodeid,
+		  __entry->isize, __entry->old_iflags, __entry->new_iflags)
+);
+
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 struct fuse_iext_cursor;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1e9d5bf1811c6a..56ef73dd58e3b6 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1213,6 +1213,7 @@ static void fuse_fillattr(struct mnt_idmap *idmap, struct inode *inode,
 		blkbits = inode->i_sb->s_blocksize_bits;
 
 	stat->blksize = 1 << blkbits;
+	generic_fill_statx_attr(inode, stat);
 }
 
 static void fuse_statx_to_attr(struct fuse_statx *sx, struct fuse_attr *attr)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d67cc635612cff..84f68dc37db64f 100644
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
index 5be73609dfe979..2c5002fc3ee9e0 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -4,6 +4,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/uio.h>
 #include <linux/compat.h>
@@ -502,6 +503,91 @@ static void fuse_priv_ioctl_cleanup(struct inode *inode, struct fuse_file *ff)
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
+				       const struct fileattr *fa)
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
+	struct fileattr fa;
+	struct fsxattr xfa = { };
+	struct fuse_file *ff;
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
+	if (attr->ino == FUSE_ROOT_ID && attr->blksize == 0)
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
 int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
@@ -572,7 +658,10 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 
 		err = fuse_priv_ioctl(inode, ff, FS_IOC_FSSETXATTR,
 				      &xfa, sizeof(xfa));
+		if (err)
+			goto cleanup;
 	}
+	fuse_fileattr_update_inode(inode, fa);
 
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);


