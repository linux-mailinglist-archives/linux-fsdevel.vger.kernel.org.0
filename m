Return-Path: <linux-fsdevel+bounces-16997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3168A5EAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65854285022
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04B159206;
	Mon, 15 Apr 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThlyF6c6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE301DA21;
	Mon, 15 Apr 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224652; cv=none; b=aOfXa7nYbS5pmfzePBNartQw1c+RW7HqyV0HSlV9ewUU7xTIYZ65zFLXB8n+C8p95hspFsZ4phFeAbMesB44gOTS/NobumCOuHZjRGs1rVIn+dl/6bJ6kKFP9iE5rnbQ+4l4swyVl+bnrg63i1nfK55WQfHbsGlSldPt1vuF+dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224652; c=relaxed/simple;
	bh=31/dOC20N1uJAGlaHA/vRg03Sa20UmnxA8pmCW1tYds=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcr8OjZwFybsuP7uiXCwplG1rhwmwiisiwxdM2oNSye0ACkJfd5Axe/u9YduYUWqsFcxYwyJMy8Qf4f7dqChCayBYJt440I79GoTyRrg9DwqDPPBEk23O3eKwwN8aKd3Phxi297m/RwFC4SGSeESV7AfaiwnKepF4AOZIObNS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThlyF6c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152E4C113CC;
	Mon, 15 Apr 2024 23:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224652;
	bh=31/dOC20N1uJAGlaHA/vRg03Sa20UmnxA8pmCW1tYds=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ThlyF6c6WLYzqEsKz5jKn4QDFggUHj8AZr8VEikrAP++G7JI3tiFHYTsI1lhWpL+Q
	 rIxum/66ZXtLnBQk+G06qeEVZYQtwK5IwVL/RIEnifpW6dTSYIlXaF0xbGgPLdmCPB
	 UkXb6holiPUdSa937hGcYnd7sXvP2+TkYdSTJiBHtIAudfG57dF2NSFp+1chccW83j
	 g7/UVPVXlgF+RnUkFZ9HlXuy12vWbWAjiw3uX5xE5jSAMbgi2hoiyCZh4V1mMS46tZ
	 bg3EZ5ughu9BGPQjevjFlKbxHwfC/bJKWkHdsubg7rmYw66U4H5FJw90uVnJZ+0NwV
	 DuUay4yXiK4Dw==
Date: Mon, 15 Apr 2024 16:44:11 -0700
Subject: [PATCH 13/15] xfs: capture inode generation numbers in the ondisk
 exchmaps log item
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381440.87355.12149121920420626034.stgit@frogsfrogsfrogs>
In-Reply-To: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
References: <171322381182.87355.15534989930482135103.stgit@frogsfrogsfrogs>
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

Per some very late review comments, capture the generation numbers of
both inodes involved in a file content exchange operation so that we
don't accidentally target files with have been reallocated.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_log_format.h  |    2 ++
 fs/xfs/libxfs/xfs_log_recover.h |    2 ++
 fs/xfs/xfs_exchmaps_item.c      |   25 ++++++++++++++++++++-----
 fs/xfs/xfs_log_recover.c        |   31 +++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 8dbe1f997dfd..accba2acd623 100644
--- a/fs/xfs/libxfs/xfs_log_format.h
+++ b/fs/xfs/libxfs/xfs_log_format.h
@@ -896,6 +896,8 @@ struct xfs_xmi_log_format {
 
 	uint64_t		xmi_inode1;	/* inumber of first file */
 	uint64_t		xmi_inode2;	/* inumber of second file */
+	uint32_t		xmi_igen1;	/* generation of first file */
+	uint32_t		xmi_igen2;	/* generation of second file */
 	uint64_t		xmi_startoff1;	/* block offset into file1 */
 	uint64_t		xmi_startoff2;	/* block offset into file2 */
 	uint64_t		xmi_blockcount;	/* number of blocks */
diff --git a/fs/xfs/libxfs/xfs_log_recover.h b/fs/xfs/libxfs/xfs_log_recover.h
index 47b758b49cb3..521d327e4c89 100644
--- a/fs/xfs/libxfs/xfs_log_recover.h
+++ b/fs/xfs/libxfs/xfs_log_recover.h
@@ -123,6 +123,8 @@ bool xlog_is_buffer_cancelled(struct xlog *log, xfs_daddr_t blkno, uint len);
 
 int xlog_recover_iget(struct xfs_mount *mp, xfs_ino_t ino,
 		struct xfs_inode **ipp);
+int xlog_recover_iget_handle(struct xfs_mount *mp, xfs_ino_t ino, uint32_t gen,
+		struct xfs_inode **ipp);
 void xlog_recover_release_intent(struct xlog *log, unsigned short intent_type,
 		uint64_t intent_id);
 int xlog_alloc_buf_cancel_table(struct xlog *log);
diff --git a/fs/xfs/xfs_exchmaps_item.c b/fs/xfs/xfs_exchmaps_item.c
index a40216f33214..264a121c5e16 100644
--- a/fs/xfs/xfs_exchmaps_item.c
+++ b/fs/xfs/xfs_exchmaps_item.c
@@ -231,7 +231,9 @@ xfs_exchmaps_create_intent(
 	xlf = &xmi_lip->xmi_format;
 
 	xlf->xmi_inode1 = xmi->xmi_ip1->i_ino;
+	xlf->xmi_igen1 = VFS_I(xmi->xmi_ip1)->i_generation;
 	xlf->xmi_inode2 = xmi->xmi_ip2->i_ino;
+	xlf->xmi_igen2 = VFS_I(xmi->xmi_ip2)->i_generation;
 	xlf->xmi_startoff1 = xmi->xmi_startoff1;
 	xlf->xmi_startoff2 = xmi->xmi_startoff2;
 	xlf->xmi_blockcount = xmi->xmi_blockcount;
@@ -368,14 +370,25 @@ xfs_xmi_item_recover_intent(
 	/*
 	 * Grab both inodes and set IRECOVERY to prevent trimming of post-eof
 	 * mappings and freeing of unlinked inodes until we're totally done
-	 * processing files.
+	 * processing files.  The ondisk format of this new log item contains
+	 * file handle information, which is why recovery for other items do
+	 * not check the inode generation number.
 	 */
-	error = xlog_recover_iget(mp, xlf->xmi_inode1, &ip1);
-	if (error)
+	error = xlog_recover_iget_handle(mp, xlf->xmi_inode1, xlf->xmi_igen1,
+			&ip1);
+	if (error) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, xlf,
+				sizeof(*xlf));
 		return ERR_PTR(error);
-	error = xlog_recover_iget(mp, xlf->xmi_inode2, &ip2);
-	if (error)
+	}
+
+	error = xlog_recover_iget_handle(mp, xlf->xmi_inode2, xlf->xmi_igen2,
+			&ip2);
+	if (error) {
+		XFS_CORRUPTION_ERROR(__func__, XFS_ERRLEVEL_LOW, mp, xlf,
+				sizeof(*xlf));
 		goto err_rele1;
+	}
 
 	req->ip1 = ip1;
 	req->ip2 = ip2;
@@ -485,6 +498,8 @@ xfs_exchmaps_relog_intent(
 
 	new_xlf->xmi_inode1	= old_xlf->xmi_inode1;
 	new_xlf->xmi_inode2	= old_xlf->xmi_inode2;
+	new_xlf->xmi_igen1	= old_xlf->xmi_igen1;
+	new_xlf->xmi_igen2	= old_xlf->xmi_igen2;
 	new_xlf->xmi_startoff1	= old_xlf->xmi_startoff1;
 	new_xlf->xmi_startoff2	= old_xlf->xmi_startoff2;
 	new_xlf->xmi_blockcount	= old_xlf->xmi_blockcount;
diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index 1e5ba95adf2c..b445e8ce4a7d 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -1767,6 +1767,37 @@ xlog_recover_iget(
 	return 0;
 }
 
+/*
+ * Get an inode so that we can recover a log operation.
+ *
+ * Log intent items that target inodes effectively contain a file handle.
+ * Check that the generation number matches the intent item like we do for
+ * other file handles.  Log intent items defined after this validation weakness
+ * was identified must use this function.
+ */
+int
+xlog_recover_iget_handle(
+	struct xfs_mount	*mp,
+	xfs_ino_t		ino,
+	uint32_t		gen,
+	struct xfs_inode	**ipp)
+{
+	struct xfs_inode	*ip;
+	int			error;
+
+	error = xlog_recover_iget(mp, ino, &ip);
+	if (error)
+		return error;
+
+	if (VFS_I(ip)->i_generation != gen) {
+		xfs_irele(ip);
+		return -EFSCORRUPTED;
+	}
+
+	*ipp = ip;
+	return 0;
+}
+
 /******************************************************************************
  *
  *		Log recover routines


