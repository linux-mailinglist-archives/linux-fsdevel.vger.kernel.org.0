Return-Path: <linux-fsdevel+bounces-16647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF92A8A0701
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 06:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B58DB24020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 04:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6259F13BC1C;
	Thu, 11 Apr 2024 04:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IspGiYnJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48413BC01;
	Thu, 11 Apr 2024 04:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712808882; cv=none; b=Q/o69N4AEcPoPGmZaived704UL78aLop7MzaJaW4YP6ADMOP4O7q28b04XF90gceftx2HH4k1n2KQ6O8D12U9Z6uw5Wxf/SyZU5Y7z2+r4dHu/uFE+NSZQ5i++lFwn/BEQbnvngA04xYlPZ5thppD5dKp6kEBrOL0R3AbKFYfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712808882; c=relaxed/simple;
	bh=U4SKgYUbeO7H/gKAzOS8h5MHwNwiwoKkW0kw4ddURSw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhhM/pWF74Zv0sE6OsucJSe7ZfyyIcF8MeyH7GElNSRyBtwquYjK0aDmq025rcpn4Iq8ydhqv4RKKQ7ZsXQKdajiAr/+KI3jVXvNkVjw/bl5ucw+5mMc0dcIMuMaYjO94R6kFmNQbfG7VLg8knKWlgG+X0/JQDLgGGbSRFahrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IspGiYnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466ACC43390;
	Thu, 11 Apr 2024 04:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712808882;
	bh=U4SKgYUbeO7H/gKAzOS8h5MHwNwiwoKkW0kw4ddURSw=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=IspGiYnJCeDK5Y0r0nyPXxTvscY/gCaEFY5Uazvtpvo9rY5awEfC5Mp/B2E3mjnlx
	 3jVFPrWv0LOqP8WWTZEa8nxor9zxFpd8Ivr1J3reVXxfGSyoc5am3XWWwiCb/SP+HM
	 xXaN6YskyLerVcY0ooI6dNMlf1R8WNhsjVIqeghO9QMF/lJvbcNE2iZtpB0mubXfgz
	 mkRM5+/dVp9vx1cLegkZ/o96BRtiwGEBuShmyDtdSasd9x8OGlIsPvjvUsbLP6bn9U
	 PiAnD4+zXpodZp7zSOEWidjYJR2787UpQhogm7Vm0Xwd/Ff2L4JXpuL7RfQcuGzt6f
	 npFS6/rH4eLRg==
Date: Wed, 10 Apr 2024 21:14:41 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: [PATCH v30.2.1 15/14] xfs: capture inode generation numbers in the
 ondisk exchmaps log item
Message-ID: <20240411041441.GS6390@frogsfrogsfrogs>
References: <171263348423.2978056.309570547736145336.stgit@frogsfrogsfrogs>
 <20240410000528.GR6390@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410000528.GR6390@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Per some very late review comments, capture the generation numbers of
both inodes involved in a file content exchange operation so that we
don't accidentally target files with have been reallocated.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
v30.2.1: make a generic helper for later use, and add more comments
about why we're doing this in the first place
---
 fs/xfs/libxfs/xfs_log_format.h  |    2 ++
 fs/xfs/libxfs/xfs_log_recover.h |    2 ++
 fs/xfs/xfs_exchmaps_item.c      |   25 ++++++++++++++++++++-----
 fs/xfs/xfs_log_recover.c        |   31 +++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_log_format.h b/fs/xfs/libxfs/xfs_log_format.h
index 8dbe1f997dfd5..accba2acd623d 100644
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
index 47b758b49cb35..521d327e4c89e 100644
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
index a40216f33214c..264a121c5e16d 100644
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
index 1e5ba95adf2c7..b445e8ce4a7d2 100644
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

