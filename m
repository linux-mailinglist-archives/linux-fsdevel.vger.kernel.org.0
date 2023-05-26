Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A40711C44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjEZBPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjEZBPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:15:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93963198;
        Thu, 25 May 2023 18:15:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EC0A64C28;
        Fri, 26 May 2023 01:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D91C433D2;
        Fri, 26 May 2023 01:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685063715;
        bh=1MTTC0Q8gPwH/yfHT1/eDbn5c4QwXN7byAdtKsepBQE=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=A8zDaC4De3Z4PBtUQv7Z7LWgEG6b8HIzRzjQuJaslHN9a2+QHU5pAhluvmTbXjUxI
         R8fTUPMGHD2vkzqXxIF3iUKrlXYSuONMx8iLA+RTuTbPexroc3la3T6lRQsNcYLQZX
         BUgAsISF98CcKG7D3auwGWI/5VQ/cD7lkX/blyve8zSKXkNqY53KhFx0d5pNwxh8uK
         ub5uDzLSqeyiQtBWIV2mICQdT/0uX9fIn3yy980O4mzotWbwM57SAGsZSCeCNY+5kZ
         FO3iaRGWdc/T+GEGHLTySaejGBvht67Rx8Nejwbw9HJ9bzpJWoOz7JjaJjMIrXuhJR
         ocX4gWwB7k/tg==
Date:   Thu, 25 May 2023 18:15:15 -0700
Subject: [PATCH 03/25] xfs: move inode lease breaking functions to xfs_inode.c
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065022.3734442.7019671792166233875.stgit@frogsfrogsfrogs>
In-Reply-To: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
References: <168506064947.3734442.7654653738998941813.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

The lease breaking functions operate at the scope of the entire VFS
inode, not subranges of a file.  Move them to xfs_inode.c since they're
already declared in xfs_inode.h.  This cleanup moves us closer to
having xfs_FOO.h declare only the symbols in xfs_FOO.c.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_file.c  |   61 ---------------------------------------------------
 fs/xfs/xfs_inode.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h |    1 -
 3 files changed, 62 insertions(+), 62 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 2380067aa154..5ecbac510056 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -802,67 +802,6 @@ xfs_file_write_iter(
 	return xfs_file_buffered_write(iocb, from);
 }
 
-static void
-xfs_wait_dax_page(
-	struct inode		*inode)
-{
-	struct xfs_inode        *ip = XFS_I(inode);
-
-	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
-	schedule();
-	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
-}
-
-int
-xfs_break_dax_layouts(
-	struct inode		*inode,
-	bool			*retry)
-{
-	struct page		*page;
-
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
-
-	page = dax_layout_busy_page(inode->i_mapping);
-	if (!page)
-		return 0;
-
-	*retry = true;
-	return ___wait_var_event(&page->_refcount,
-			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
-			0, 0, xfs_wait_dax_page(inode));
-}
-
-int
-xfs_break_layouts(
-	struct inode		*inode,
-	uint			*iolock,
-	enum layout_break_reason reason)
-{
-	bool			retry;
-	int			error;
-
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
-
-	do {
-		retry = false;
-		switch (reason) {
-		case BREAK_UNMAP:
-			error = xfs_break_dax_layouts(inode, &retry);
-			if (error || retry)
-				break;
-			fallthrough;
-		case BREAK_WRITE:
-			error = xfs_break_leased_layouts(inode, iolock, &retry);
-			break;
-		default:
-			WARN_ON_ONCE(1);
-			error = -EINVAL;
-		}
-	} while (error == 0 && retry);
-
-	return error;
-}
-
 /* Does this file, inode, or mount want synchronous writes? */
 static inline bool xfs_file_sync_writes(struct file *filp)
 {
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 167d10c614ec..f63d0d20098c 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -38,6 +38,7 @@
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
+#include "xfs_pnfs.h"
 
 struct kmem_cache *xfs_inode_cache;
 
@@ -3699,3 +3700,64 @@ xfs_inode_count_blocks(
 	xfs_bmap_count_leaves(ifp, rblocks);
 	*dblocks = ip->i_nblocks - *rblocks;
 }
+
+static void
+xfs_wait_dax_page(
+	struct inode		*inode)
+{
+	struct xfs_inode        *ip = XFS_I(inode);
+
+	xfs_iunlock(ip, XFS_MMAPLOCK_EXCL);
+	schedule();
+	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
+}
+
+int
+xfs_break_dax_layouts(
+	struct inode		*inode,
+	bool			*retry)
+{
+	struct page		*page;
+
+	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
+
+	page = dax_layout_busy_page(inode->i_mapping);
+	if (!page)
+		return 0;
+
+	*retry = true;
+	return ___wait_var_event(&page->_refcount,
+			atomic_read(&page->_refcount) == 1, TASK_INTERRUPTIBLE,
+			0, 0, xfs_wait_dax_page(inode));
+}
+
+int
+xfs_break_layouts(
+	struct inode		*inode,
+	uint			*iolock,
+	enum layout_break_reason reason)
+{
+	bool			retry;
+	int			error;
+
+	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
+
+	do {
+		retry = false;
+		switch (reason) {
+		case BREAK_UNMAP:
+			error = xfs_break_dax_layouts(inode, &retry);
+			if (error || retry)
+				break;
+			fallthrough;
+		case BREAK_WRITE:
+			error = xfs_break_leased_layouts(inode, iolock, &retry);
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			error = -EINVAL;
+		}
+	} while (error == 0 && retry);
+
+	return error;
+}
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index f80f4761892a..de77bc053681 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -536,7 +536,6 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-/* from xfs_file.c */
 int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);

