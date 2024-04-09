Return-Path: <linux-fsdevel+bounces-16401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A966189D12E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBED71C21E29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5EA54F95;
	Tue,  9 Apr 2024 03:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQL3YinO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29285491D;
	Tue,  9 Apr 2024 03:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633827; cv=none; b=AuCDStoTty9WI+98apIdtrmA+MzLjPh11ydBqvUKhre/6EtJlY5NikxXNnDL19fYyr5B1FcMBdib8KCLOePM1eY11YxQHdot7YG6xE5E1SEeNLm/BMhF38jp1WAkITvYUyPKV4Z39qlZ8c1Uni3D7smAxDX6uUyTb5kueCGCqQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633827; c=relaxed/simple;
	bh=D+djOmazhtiUc00LP623M9woKaxcmIZ2G+kfGLV6pUQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qA0bVA3zp+v2uG0D7cRqa0Sk6Ygh4yFIW6PtbIidOLpQ5Bd5c69+uG099W+zhP6547JdTkxLDltiS8+EQ+/B0PvE4MYYfpJC7f8GvwyeA8agNOW0ltKt0x+o2necMVv27OWDxW86IXHSon47ygUtCuCAonUHEdVm3Of16KeeAC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQL3YinO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F5BEC433C7;
	Tue,  9 Apr 2024 03:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633827;
	bh=D+djOmazhtiUc00LP623M9woKaxcmIZ2G+kfGLV6pUQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AQL3YinOSvywtX22ww964wn+Agfn+P5+J5xvG++h2cdvaWn4LHp6NCk2RlC8HyVxN
	 ht8NtQEkPlT/5KQdL/SC71jZ1xnPtw9O9aSEd4p+AZeGBJPZDhrmq5vLWH9A0BsMJ9
	 TZCDJY58Y3dJToEXVbW/4u9SgJ0uh/9eVubyAQZPn7j7nCieG7rX0dBO0JvKhvK6q7
	 lBVSORnLw7TruYevEhVR+1a9Q2PjszjpxF4VbAaD41eh+tLjmLBp74v1pFOxkAtKJB
	 WmESAawzH6LM2GKR9NpLeNdYROj1e5Zq2D8NF+ifYiNGes2ICYxeo46/2wExofKihj
	 Zvp5vqlVwmesg==
Date: Mon, 08 Apr 2024 20:37:07 -0700
Subject: [PATCH 10/14] xfs: condense symbolic links after a mapping exchange
 operation
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348629.2978056.18360223188162051575.stgit@frogsfrogsfrogs>
In-Reply-To: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The previous commit added a new file mapping exchange flag that enables
us to perform post-exchange processing on file2 once we're done
exchanging the extent mappings.  Now add this ability for symlinks.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online symlink repair feature can
salvage the remote target in a temporary link and exchange the data fork
mappings when ready.  If one file is in extents format and the other is
inline, we will have to promote both to extents format to perform the
exchange.  After the exchange, we can try to condense the fixed symlink
down to inline format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_exchmaps.c       |   49 +++++++++++++++++++++++++++++++++++-
 fs/xfs/libxfs/xfs_symlink_remote.c |   47 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_symlink_remote.h |    1 +
 fs/xfs/xfs_symlink.c               |   49 ++++--------------------------------
 4 files changed, 102 insertions(+), 44 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index f199629adbf0a..f58240466b1c4 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -30,6 +30,7 @@
 #include "xfs_attr.h"
 #include "xfs_dir2_priv.h"
 #include "xfs_dir2.h"
+#include "xfs_symlink_remote.h"
 
 struct kmem_cache	*xfs_exchmaps_intent_cache;
 
@@ -433,6 +434,49 @@ xfs_exchmaps_dir_to_sf(
 	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
 }
 
+/* Convert inode2's remote symlink target back to shortform, if possible. */
+STATIC int
+xfs_exchmaps_link_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_exchmaps_intent	*xmi)
+{
+	struct xfs_inode		*ip = xmi->xmi_ip2;
+	struct xfs_ifork		*ifp = xfs_ifork_ptr(ip, XFS_DATA_FORK);
+	char				*buf;
+	int				error;
+
+	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
+	    ip->i_disk_size > xfs_inode_data_fork_size(ip))
+		return 0;
+
+	/* Read the current symlink target into a buffer. */
+	buf = kmalloc(ip->i_disk_size + 1,
+			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_NOFAIL);
+	if (!buf) {
+		ASSERT(0);
+		return -ENOMEM;
+	}
+
+	error = xfs_symlink_remote_read(ip, buf);
+	if (error)
+		goto free;
+
+	/* Remove the blocks. */
+	error = xfs_symlink_remote_truncate(tp, ip);
+	if (error)
+		goto free;
+
+	/* Convert fork to local format and log our changes. */
+	xfs_idestroy_fork(ifp);
+	ifp->if_bytes = 0;
+	ifp->if_format = XFS_DINODE_FMT_LOCAL;
+	xfs_init_local_fork(ip, XFS_DATA_FORK, buf, ip->i_disk_size);
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_DDATA | XFS_ILOG_CORE);
+free:
+	kfree(buf);
+	return error;
+}
+
 /* Clear the reflink flag after an exchange. */
 static inline void
 xfs_exchmaps_clear_reflink(
@@ -458,6 +502,8 @@ xfs_exchmaps_do_postop_work(
 			error = xfs_exchmaps_attr_to_sf(tp, xmi);
 		else if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
 			error = xfs_exchmaps_dir_to_sf(tp, xmi);
+		else if (S_ISLNK(VFS_I(xmi->xmi_ip2)->i_mode))
+			error = xfs_exchmaps_link_to_sf(tp, xmi);
 		xmi->xmi_flags &= ~__XFS_EXCHMAPS_INO2_SHORTFORM;
 		if (error)
 			return error;
@@ -922,7 +968,8 @@ xfs_exchmaps_init_intent(
 			xmi->xmi_flags |= XFS_EXCHMAPS_CLEAR_INO2_REFLINK;
 	}
 
-	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode))
+	if (S_ISDIR(VFS_I(xmi->xmi_ip2)->i_mode) ||
+	    S_ISLNK(VFS_I(xmi->xmi_ip2)->i_mode))
 		xmi->xmi_flags |= __XFS_EXCHMAPS_INO2_SHORTFORM;
 
 	return xmi;
diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
index ffb1317a92123..8f0d5c584f46f 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.c
+++ b/fs/xfs/libxfs/xfs_symlink_remote.c
@@ -380,3 +380,50 @@ xfs_symlink_write_target(
 	ASSERT(pathlen == 0);
 	return 0;
 }
+
+/* Remove all the blocks from a symlink and invalidate buffers. */
+int
+xfs_symlink_remote_truncate(
+	struct xfs_trans	*tp,
+	struct xfs_inode	*ip)
+{
+	struct xfs_bmbt_irec	mval[XFS_SYMLINK_MAPS];
+	struct xfs_mount	*mp = tp->t_mountp;
+	struct xfs_buf		*bp;
+	int			nmaps = XFS_SYMLINK_MAPS;
+	int			done = 0;
+	int			i;
+	int			error;
+
+	/* Read mappings and invalidate buffers. */
+	error = xfs_bmapi_read(ip, 0, XFS_MAX_FILEOFF, mval, &nmaps, 0);
+	if (error)
+		return error;
+
+	for (i = 0; i < nmaps; i++) {
+		if (!xfs_bmap_is_real_extent(&mval[i]))
+			break;
+
+		error = xfs_trans_get_buf(tp, mp->m_ddev_targp,
+				XFS_FSB_TO_DADDR(mp, mval[i].br_startblock),
+				XFS_FSB_TO_BB(mp, mval[i].br_blockcount), 0,
+				&bp);
+		if (error)
+			return error;
+
+		xfs_trans_binval(tp, bp);
+	}
+
+	/* Unmap the remote blocks. */
+	error = xfs_bunmapi(tp, ip, 0, XFS_MAX_FILEOFF, 0, nmaps, &done);
+	if (error)
+		return error;
+	if (!done) {
+		ASSERT(done);
+		xfs_inode_mark_sick(ip, XFS_SICK_INO_SYMLINK);
+		return -EFSCORRUPTED;
+	}
+
+	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
+	return 0;
+}
diff --git a/fs/xfs/libxfs/xfs_symlink_remote.h b/fs/xfs/libxfs/xfs_symlink_remote.h
index a63bd38ae4faf..ac3dac8f617ed 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.h
+++ b/fs/xfs/libxfs/xfs_symlink_remote.h
@@ -22,5 +22,6 @@ int xfs_symlink_remote_read(struct xfs_inode *ip, char *link);
 int xfs_symlink_write_target(struct xfs_trans *tp, struct xfs_inode *ip,
 		const char *target_path, int pathlen, xfs_fsblock_t fs_blocks,
 		uint resblks);
+int xfs_symlink_remote_truncate(struct xfs_trans *tp, struct xfs_inode *ip);
 
 #endif /* __XFS_SYMLINK_REMOTE_H */
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 3e376d24c7c16..3daeebff4bb47 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -250,19 +250,12 @@ xfs_symlink(
  */
 STATIC int
 xfs_inactive_symlink_rmt(
-	struct xfs_inode *ip)
+	struct xfs_inode	*ip)
 {
-	struct xfs_buf	*bp;
-	int		done;
-	int		error;
-	int		i;
-	xfs_mount_t	*mp;
-	xfs_bmbt_irec_t	mval[XFS_SYMLINK_MAPS];
-	int		nmaps;
-	int		size;
-	xfs_trans_t	*tp;
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	int			error;
 
-	mp = ip->i_mount;
 	ASSERT(!xfs_need_iread_extents(&ip->i_df));
 	/*
 	 * We're freeing a symlink that has some
@@ -286,44 +279,14 @@ xfs_inactive_symlink_rmt(
 	 * locked for the second transaction.  In the error paths we need it
 	 * held so the cancel won't rele it, see below.
 	 */
-	size = (int)ip->i_disk_size;
 	ip->i_disk_size = 0;
 	VFS_I(ip)->i_mode = (VFS_I(ip)->i_mode & ~S_IFMT) | S_IFREG;
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
-	/*
-	 * Find the block(s) so we can inval and unmap them.
-	 */
-	done = 0;
-	nmaps = ARRAY_SIZE(mval);
-	error = xfs_bmapi_read(ip, 0, xfs_symlink_blocks(mp, size),
-				mval, &nmaps, 0);
-	if (error)
-		goto error_trans_cancel;
-	/*
-	 * Invalidate the block(s). No validation is done.
-	 */
-	for (i = 0; i < nmaps; i++) {
-		error = xfs_trans_get_buf(tp, mp->m_ddev_targp,
-				XFS_FSB_TO_DADDR(mp, mval[i].br_startblock),
-				XFS_FSB_TO_BB(mp, mval[i].br_blockcount), 0,
-				&bp);
-		if (error)
-			goto error_trans_cancel;
-		xfs_trans_binval(tp, bp);
-	}
-	/*
-	 * Unmap the dead block(s) to the dfops.
-	 */
-	error = xfs_bunmapi(tp, ip, 0, size, 0, nmaps, &done);
+
+	error = xfs_symlink_remote_truncate(tp, ip);
 	if (error)
 		goto error_trans_cancel;
-	ASSERT(done);
 
-	/*
-	 * Commit the transaction. This first logs the EFI and the inode, then
-	 * rolls and commits the transaction that frees the extents.
-	 */
-	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 	error = xfs_trans_commit(tp);
 	if (error) {
 		ASSERT(xfs_is_shutdown(mp));


