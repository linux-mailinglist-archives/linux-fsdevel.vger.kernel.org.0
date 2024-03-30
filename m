Return-Path: <linux-fsdevel+bounces-15758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B6189289E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 02:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2F941C20BBC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55078467;
	Sat, 30 Mar 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOHMy+Jq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2BB79D8;
	Sat, 30 Mar 2024 01:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760404; cv=none; b=DTFJ9PPzZnReSDrIjBdF/fqjfxfhi1TdrKh7lrtiwj9faWkZXG40N04XNA10Igpb7ndXbNZiSuIjix0D4A+F5pFoy3lJS+S1X/sNOITzBnDkBZ0rkkuTz6RSkwawflP6aEg2f42T8TK0q8YXk6RNFvxJ+Q3atkNuZ+RQTqwm5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760404; c=relaxed/simple;
	bh=2ah3qhjIaiFztUm/NWJ+1imWmWuxFYh5tm2QDgJlzf0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUqa+PLAqxon83J/pdIyQwCUouJAekCuNh0RgflLEM68T6NWAp/jKe2YHZC3UfyGmxoOpWbIp4Gwm9NEwdT8udtjx8Szi7kmu/87qUsN4wLN8iMUisAbg/TUyIsBrrh1tEoNypYjHv5jJUtO781tjwUCQ/h5jtRI6hTvm37XnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOHMy+Jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235F6C433F1;
	Sat, 30 Mar 2024 01:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760404;
	bh=2ah3qhjIaiFztUm/NWJ+1imWmWuxFYh5tm2QDgJlzf0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cOHMy+Jq4gYyjsclZacUnv6647hmo8+fcKQsz60yHp1/CVMC/WLoJV50ZMUx4IhXY
	 4jvWn2mLYjRgZHQZZSV80E/SADj6jfrNfrrZ3V1Y3qKQB+nVDOzkhTlFGgnUqjlgRf
	 Db+99yxfccK6t5IFvcjWfaKLhaTYpIBGsZQCxKMJqJWkw5wRCVgief7uCSVepj1p8C
	 fS81g7hgMWj3vZtDVEEv+yCB216awFqClXl6Hofx4czWj8WhN4p8pdP+5NdNH/IXX1
	 XhJEk1oXKhm1uIZkVUQlLNVvl3KPc9nCaUIXLUc3otkLxfKbyIbfNyAwc+SOyi1uve
	 yrkmeXzlE6/mA==
Date: Fri, 29 Mar 2024 18:00:03 -0700
Subject: [PATCH 12/14] xfs: support non-power-of-two rtextsize with
 exchange-range
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171176018875.2014991.5435978759086688250.stgit@frogsfrogsfrogs>
In-Reply-To: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
References: <171176018639.2014991.12163554496963657299.stgit@frogsfrogsfrogs>
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
index 23e668a192e0d..2d33c7de04f4c 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -563,6 +563,75 @@ xfs_exchange_range_finish(
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
@@ -570,6 +639,7 @@ xfs_exchrange_prep(
 	struct xfs_inode	*ip1,
 	struct xfs_inode	*ip2)
 {
+	struct xfs_mount	*mp = ip2->i_mount;
 	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip2);
 	int			error;
 
@@ -579,13 +649,18 @@ xfs_exchrange_prep(
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


