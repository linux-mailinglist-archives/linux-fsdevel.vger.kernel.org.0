Return-Path: <linux-fsdevel+bounces-16978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC89A8A5E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 813BF1F214F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE761159208;
	Mon, 15 Apr 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZDZTWHB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C1E1DA21;
	Mon, 15 Apr 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224355; cv=none; b=VgxYnqdavGgef+pH0XHIfXUGc6qqIVuEc0Z6rxWU0Hve6oHLnGLgPoGsl9BBoOBS7NSvoQhMzwGt9g0Ptm2VaSKlHPiNbKAKisHjU9L/Z2wYblUAoZ13bLqwnHy9lr1jWkw1xDROYS0xMs+ErerYB9oc7StJnaqFjMerbZyblcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224355; c=relaxed/simple;
	bh=BIAj79a6xW7Qur5Uav4bzKyvXSxdBthYED2HE78nZFo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCqRs07lGZDPENdcHFup39H2SM6L6mOyU0t/HjQLwC3ALh/tDdhMb23XOp5twl90OpHHdUzFTu/43phGVtM1eIry5kIIMYLc/+f0XD64EPLmTmx51XLzmEFvEcd/9imezSB0einphdLcXArRKGEQVPx7PxNGtIPrvB0DkCQycQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZDZTWHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3BDC113CC;
	Mon, 15 Apr 2024 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224355;
	bh=BIAj79a6xW7Qur5Uav4bzKyvXSxdBthYED2HE78nZFo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MZDZTWHBuamQag1ZIVBftaeqYXPIJoTOnAA2OsvkoOtbNfPhRFBWazz3tfRsXeNDV
	 r3Ou3g8fSP1eUAINY6FNOfmaA4J20shCbUd7wH7IfndhipjqFgYW+/pirpqcrjpDNi
	 DQmFg0rKgiqRXw6FHQMsKmZJrkcbTBKTG5AHQFS3xsIb8swPEua+cPX+zql+nfT0t7
	 VM3ZlAyE+vMCpWNg5VIiroJjv4faQddXmj7hd7x3nBxXgENpErdaJNSdZpRCJnpNQr
	 PFGtzYfyOa34BmxXD1tl7bXlJuGxgFcGkxh8hTNCInA3z6jiwu4KqrziiN+U9hjhbC
	 kkpm7OpNKpEBA==
Date: Mon, 15 Apr 2024 16:39:14 -0700
Subject: [PATCH 1/7] xfs: move inode lease breaking functions to xfs_inode.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322380744.87068.6708439075828080621.stgit@frogsfrogsfrogs>
In-Reply-To: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
References: <171322380710.87068.4499164955656161226.stgit@frogsfrogsfrogs>
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

The lease breaking functions operate at the scope of the entire VFS
inode, not subranges of a file.  Move them to xfs_inode.c since they're
already declared in xfs_inode.h.  This cleanup moves us closer to
having xfs_FOO.h declare only the symbols in xfs_FOO.c.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_file.c  |   61 ---------------------------------------------------
 fs/xfs/xfs_inode.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_inode.h |    1 -
 3 files changed, 62 insertions(+), 62 deletions(-)


diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 632653e00906..40b778415f5f 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -861,67 +861,6 @@ xfs_file_write_iter(
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
-	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
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
-	xfs_assert_ilocked(XFS_I(inode), XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
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
index 3e667a19b80b..39e6f88e9691 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -38,6 +38,7 @@
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
 #include "xfs_health.h"
+#include "xfs_pnfs.h"
 
 struct kmem_cache *xfs_inode_cache;
 
@@ -3946,3 +3947,64 @@ xfs_inode_count_blocks(
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
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
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
+	xfs_assert_ilocked(XFS_I(inode), XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
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
index ab46ffb3ac19..5164c5d3e549 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -565,7 +565,6 @@ xfs_itruncate_extents(
 	return xfs_itruncate_extents_flags(tpp, ip, whichfork, new_size, 0);
 }
 
-/* from xfs_file.c */
 int	xfs_break_dax_layouts(struct inode *inode, bool *retry);
 int	xfs_break_layouts(struct inode *inode, uint *iolock,
 		enum layout_break_reason reason);


