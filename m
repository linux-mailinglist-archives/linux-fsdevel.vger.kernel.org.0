Return-Path: <linux-fsdevel+bounces-16403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2989D132
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DDD81F224F2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A9454F92;
	Tue,  9 Apr 2024 03:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCk0fbd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7854743;
	Tue,  9 Apr 2024 03:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633859; cv=none; b=JqPjPUBOUg1l0qyG3ARggpKNYMDYzxYq1mTHEzzKbvQDwYuFcew4/CAn+0LmlQ8cvU6ojOczLM0TPNoBP5yO6gDaiP6/gFI0+JsZKagWmDmrPxAD0Gp/75OvK+e7YAxwVb3JJHJYkYJZgbc9E6j+03+009rzR6IqvkuqkcCjP1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633859; c=relaxed/simple;
	bh=nrfkAZ5EaS8pVlPhlXP5IwYxyR9s96s/mYTFazVBO/4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JnSu/5ICaYC2PbGOdjY114csaBdUkbh1J5HI9B17iaL2YKl+EjI5719lzIx/OzQQBi0Q+3UgSkYdZSgsG51CwdsW0ztys3U0alpweXSEHbRs6E1kBQaRMWW8aan86LEUmVQvRqX8S8ZtNaFNrdLf8lL3SdAHXJC2hSniKfaR7Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCk0fbd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE742C433F1;
	Tue,  9 Apr 2024 03:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633858;
	bh=nrfkAZ5EaS8pVlPhlXP5IwYxyR9s96s/mYTFazVBO/4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hCk0fbd/M/y4UTmvT6U0ep7krLdY6555uLfDPoNplXd4klK0iJDc5pusQu3mwOXH3
	 oFdE5hWB1cHwZ9nB/7SrZVAd0p5lZ35VdVeJ7OVw91t7EEI8wg2ES+ECjaYwu8NPLR
	 u+vCJmXWI0Nxqm0PWizEJDpzlC3RKlgClHAv+wuo0uurTQpRue8dBf5dPcijJ1WnK8
	 5+KebbVz10L2r09JsSXZOoYaXtJO3NcBETqsZl+bHbGH6QrpD9KWZgTgJNyHjgiYio
	 1SuVvn7oq7tpcfTC95NQfgF9HXrDVtwJWbO50bUVaP3dP1vYm40gXGF+CeAYcbkL0q
	 PONIobyisTOyw==
Date: Mon, 08 Apr 2024 20:37:38 -0700
Subject: [PATCH 12/14] xfs: support non-power-of-two rtextsize with
 exchange-range
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348662.2978056.419865545460726402.stgit@frogsfrogsfrogs>
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
index fc2ef7da6cd43..aa837ca9fa4ea 100644
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


