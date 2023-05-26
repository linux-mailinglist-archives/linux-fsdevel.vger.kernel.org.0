Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E9C711C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjEZB1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZB1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51BB194;
        Thu, 25 May 2023 18:27:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC5464C2E;
        Fri, 26 May 2023 01:27:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4EEC433D2;
        Fri, 26 May 2023 01:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064465;
        bh=kDJXM8uNO3EHKFL3aAvFIKqtScZSsO9kUJzjLCfh5OE=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=CQeJnB1pOBIxBaQ3GGPPwen3YD3sdZ7dB7FZruM2LxsJKi740aAlU/ynCScGRwEEK
         C8sEfgY3AmFmXwGZ4wf1hkTFKQEYYBy6dXNV7Lz+XQZymDRza0auHh1uisRP5YBvc3
         4I0XgCO0UWEB1DKb5qnihS7bCPJ0VYtAnWjTSC7bSte3inwzN5PsIaLmgHIVkIBlTS
         zOKLKTIIaF8v32whM7x8EDJBRu5oali+dbwACGE2mXkydCeBvou7wKA/IIMv7FwbYr
         VOUiKqhkCu1WGJsIC29nIT65KdMK1QjEZ7Ut7/WEZ1NvwD+o482D00uFykB95+GFvf
         y0hPB02/xDR+g==
Date:   Thu, 25 May 2023 18:27:45 -0700
Subject: [PATCH 22/25] xfs: condense symbolic links after an atomic swap
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065298.3734442.10785719892096786181.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
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

From: Darrick J. Wong <djwong@kernel.org>

The previous commit added a new swapext flag that enables us to perform
post-swap processing on file2 once we're done swapping the extent maps.
Now add this ability for symlinks.

This isn't used anywhere right now, but we need to have the basic ondisk
flags in place so that a future online symlink repair feature can
salvage the remote target in a temporary link and swap the data forks
when ready.  If one file is in extents format and the other is inline,
we will have to promote both to extents format to perform the swap.
After the swap, we can try to condense the fixed symlink down to inline
format if possible.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_swapext.c        |   48 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_symlink_remote.c |   47 +++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_symlink_remote.h |    1 +
 fs/xfs/xfs_symlink.c               |   49 ++++--------------------------------
 4 files changed, 101 insertions(+), 44 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_swapext.c b/fs/xfs/libxfs/xfs_swapext.c
index dcd356d10947..b72d9c6ae6e2 100644
--- a/fs/xfs/libxfs/xfs_swapext.c
+++ b/fs/xfs/libxfs/xfs_swapext.c
@@ -29,6 +29,7 @@
 #include "xfs_attr.h"
 #include "xfs_dir2_priv.h"
 #include "xfs_dir2.h"
+#include "xfs_symlink_remote.h"
 
 struct kmem_cache	*xfs_swapext_intent_cache;
 
@@ -442,6 +443,48 @@ xfs_swapext_dir_to_sf(
 	return xfs_dir2_block_to_sf(&args, bp, size, &sfh);
 }
 
+/* Convert inode2's remote symlink target back to shortform, if possible. */
+STATIC int
+xfs_swapext_link_to_sf(
+	struct xfs_trans		*tp,
+	struct xfs_swapext_intent	*sxi)
+{
+	struct xfs_inode		*ip = sxi->sxi_ip2;
+	struct xfs_ifork		*ifp = xfs_ifork_ptr(ip, XFS_DATA_FORK);
+	char				*buf;
+	int				error;
+
+	if (ifp->if_format == XFS_DINODE_FMT_LOCAL ||
+	    ip->i_disk_size > xfs_inode_data_fork_size(ip))
+		return 0;
+
+	/* Read the current symlink target into a buffer. */
+	buf = kmem_alloc(ip->i_disk_size + 1, KM_NOFS);
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
+	kmem_free(buf);
+	return error;
+}
+
 static inline void
 xfs_swapext_clear_reflink(
 	struct xfs_trans	*tp,
@@ -466,6 +509,8 @@ xfs_swapext_do_postop_work(
 			error = xfs_swapext_attr_to_sf(tp, sxi);
 		else if (S_ISDIR(VFS_I(sxi->sxi_ip2)->i_mode))
 			error = xfs_swapext_dir_to_sf(tp, sxi);
+		else if (S_ISLNK(VFS_I(sxi->sxi_ip2)->i_mode))
+			error = xfs_swapext_link_to_sf(tp, sxi);
 		sxi->sxi_flags &= ~XFS_SWAP_EXT_CVT_INO2_SF;
 		if (error)
 			return error;
@@ -1122,7 +1167,8 @@ xfs_swapext(
 	if (req->req_flags & XFS_SWAP_REQ_CVT_INO2_SF)
 		ASSERT(req->whichfork == XFS_ATTR_FORK ||
 		       (req->whichfork == XFS_DATA_FORK &&
-			S_ISDIR(VFS_I(req->ip2)->i_mode)));
+			(S_ISDIR(VFS_I(req->ip2)->i_mode) ||
+			 S_ISLNK(VFS_I(req->ip2)->i_mode))));
 
 	if (req->blockcount == 0)
 		return;
diff --git a/fs/xfs/libxfs/xfs_symlink_remote.c b/fs/xfs/libxfs/xfs_symlink_remote.c
index 5261f15ea2ed..b48dcb893a2a 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.c
+++ b/fs/xfs/libxfs/xfs_symlink_remote.c
@@ -391,3 +391,50 @@ xfs_symlink_write_target(
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
index d81461c06b6b..05eb9c3937d9 100644
--- a/fs/xfs/libxfs/xfs_symlink_remote.h
+++ b/fs/xfs/libxfs/xfs_symlink_remote.h
@@ -23,5 +23,6 @@ int xfs_symlink_remote_read(struct xfs_inode *ip, char *link);
 int xfs_symlink_write_target(struct xfs_trans *tp, struct xfs_inode *ip,
 		const char *target_path, int pathlen, xfs_fsblock_t fs_blocks,
 		uint resblks);
+int xfs_symlink_remote_truncate(struct xfs_trans *tp, struct xfs_inode *ip);
 
 #endif /* __XFS_SYMLINK_REMOTE_H */
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 2ecaebbdb00e..49029b3fa0f8 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -249,19 +249,12 @@ xfs_symlink(
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
@@ -285,44 +278,14 @@ xfs_inactive_symlink_rmt(
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

