Return-Path: <linux-fsdevel+bounces-16996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475418A5EA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04797285004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C101598E7;
	Mon, 15 Apr 2024 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqDCb3Y/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1D156974;
	Mon, 15 Apr 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713224637; cv=none; b=kgbgiFp3swi7LB3U1XqPq0P/Wgt+rGCKChTdcvmnpAWZ+0lUe4X43p+hEfaPi72H2jHHSlWTG2BP1slUrUwZsDxhHhJpgdW/Xq+WJYUnuagnQ7JDFV1YapdtYLHndm9605fqSMkNzd5Mpe6NX10J+i87aNyq9ohNduWER+NtqTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713224637; c=relaxed/simple;
	bh=I1OroHR2iUihbZ6Q1Ddoxzz8UtHzYd2KwBUbDMzUnQU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NO1ixWE1lCnCjaYdQDEyIqc6m1EDnWjZvkqBGvx/NYkmIcwvYhCrxiyFH+ejZZrPs+D5MeemVf16JBwo+32hz5Q4fRhV1uIEHP+8OMmCyZcLDgKktrvmqxu/2fWrwOE6Rfs+p4Bz83c0BJFfUiYGDxO1ZTAK5T2kjK7SK/Fvle0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqDCb3Y/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 687A8C113CC;
	Mon, 15 Apr 2024 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713224636;
	bh=I1OroHR2iUihbZ6Q1Ddoxzz8UtHzYd2KwBUbDMzUnQU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=BqDCb3Y/MT57ztK2HuMz24qTRNciJzqoGiO+6DbU47Y2gqrCvpR7bLRPCdih7Qo5w
	 Y94wgvBZ/rXPY1mg6pFd98UKYB3e9bEnTU9Q0uy/DbuEno5XxJ/VUDzrtN5pQO40Gb
	 DEOau6GwqV4yvjRBXxTZ+5qrlB9sts/3/P/nQprbfAZgR3M1BP9NV7ha37+NFnjBkk
	 x5yWx6NqcxXPdL6epdJrdqNAa2YArQ/zFe+2WTznUvoWTa+89FrdzvI20S500cTu9C
	 jOivlfMtZA1+G5nAhe9smQxyuYP5kebhtU11BRv1XBGOOwX9iNU+zilS5RLpPf6rjC
	 kKtN+Td7WZt+A==
Date: Mon, 15 Apr 2024 16:43:55 -0700
Subject: [PATCH 12/15] xfs: support non-power-of-two rtextsize with
 exchange-range
From: "Darrick J. Wong" <djwong@kernel.org>
To: chandanbabu@kernel.org, djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171322381424.87355.16122396919554607590.stgit@frogsfrogsfrogs>
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

The generic exchange-range alignment checks use (fast) bitmasking
operations to perform block alignment checks on the exchange parameters.
Unfortunately, bitmasks require that the alignment size be a power of
two.  This isn't true for realtime devices with a non-power-of-two
extent size, so we have to copy-pasta the generic checks using long
division for this to work properly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_exchrange.c |   89 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 82 insertions(+), 7 deletions(-)


diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 90baf12bd97f..c8a655c92c92 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -504,6 +504,75 @@ xfs_exchange_range_finish(
 	return file_remove_privs(fxr->file2);
 }
 
+/*
+ * Check the alignment of an exchange request when the allocation unit size
+ * isn't a power of two.  The generic file-level helpers use (fast)
+ * bitmask-based alignment checks, but here we have to use slow long division.
+ */
+static int
+xfs_exchrange_check_rtalign(
+	const struct xfs_exchrange	*fxr,
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	unsigned int			alloc_unit)
+{
+	uint64_t			length = fxr->length;
+	uint64_t			blen;
+	loff_t				size1, size2;
+
+	size1 = i_size_read(VFS_I(ip1));
+	size2 = i_size_read(VFS_I(ip2));
+
+	/* The start of both ranges must be aligned to a rt extent. */
+	if (!isaligned_64(fxr->file1_offset, alloc_unit) ||
+	    !isaligned_64(fxr->file2_offset, alloc_unit))
+		return -EINVAL;
+
+	if (fxr->flags & XFS_EXCHANGE_RANGE_TO_EOF)
+		length = max_t(int64_t, size1 - fxr->file1_offset,
+					size2 - fxr->file2_offset);
+
+	/*
+	 * If the user wanted us to exchange up to the infile's EOF, round up
+	 * to the next rt extent boundary for this check.  Do the same for the
+	 * outfile.
+	 *
+	 * Otherwise, reject the range length if it's not rt extent aligned.
+	 * We already confirmed the starting offsets' rt extent block
+	 * alignment.
+	 */
+	if (fxr->file1_offset + length == size1)
+		blen = roundup_64(size1, alloc_unit) - fxr->file1_offset;
+	else if (fxr->file2_offset + length == size2)
+		blen = roundup_64(size2, alloc_unit) - fxr->file2_offset;
+	else if (!isaligned_64(length, alloc_unit))
+		return -EINVAL;
+	else
+		blen = length;
+
+	/* Don't allow overlapped exchanges within the same file. */
+	if (ip1 == ip2 &&
+	    fxr->file2_offset + blen > fxr->file1_offset &&
+	    fxr->file1_offset + blen > fxr->file2_offset)
+		return -EINVAL;
+
+	/*
+	 * Ensure that we don't exchange a partial EOF rt extent into the
+	 * middle of another file.
+	 */
+	if (isaligned_64(length, alloc_unit))
+		return 0;
+
+	blen = length;
+	if (fxr->file2_offset + length < size2)
+		blen = rounddown_64(blen, alloc_unit);
+
+	if (fxr->file1_offset + blen < size1)
+		blen = rounddown_64(blen, alloc_unit);
+
+	return blen == length ? 0 : -EINVAL;
+}
+
 /* Prepare two files to have their data exchanged. */
 STATIC int
 xfs_exchrange_prep(
@@ -511,6 +580,7 @@ xfs_exchrange_prep(
 	struct xfs_inode	*ip1,
 	struct xfs_inode	*ip2)
 {
+	struct xfs_mount	*mp = ip2->i_mount;
 	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip2);
 	int			error;
 
@@ -520,13 +590,18 @@ xfs_exchrange_prep(
 	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
 		return -EINVAL;
 
-	/*
-	 * The alignment checks in the generic helpers cannot deal with
-	 * allocation units that are not powers of 2.  This can happen with the
-	 * realtime volume if the extent size is set.
-	 */
-	if (!is_power_of_2(alloc_unit))
-		return -EOPNOTSUPP;
+	/* Check non-power of two alignment issues, if necessary. */
+	if (!is_power_of_2(alloc_unit)) {
+		error = xfs_exchrange_check_rtalign(fxr, ip1, ip2, alloc_unit);
+		if (error)
+			return error;
+
+		/*
+		 * Do the generic file-level checks with the regular block
+		 * alignment.
+		 */
+		alloc_unit = mp->m_sb.sb_blocksize;
+	}
 
 	error = xfs_exchange_range_prep(fxr, alloc_unit);
 	if (error || fxr->length == 0)


