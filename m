Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15D711C95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 03:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbjEZB2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 21:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEZB2T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 21:28:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B8125;
        Thu, 25 May 2023 18:28:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDE861553;
        Fri, 26 May 2023 01:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23542C433D2;
        Fri, 26 May 2023 01:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685064497;
        bh=Nwwwk83Gnw1pSjojmhdYHXGXJcv6qXcgTJYNi+AjRq0=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=P7uxPIRbMYG3241mQmGZPab86LPcfKNPJnHBh/Y1Cc+5CfWgo3+tVL2nwgVREUsfm
         yLtg36dmiDslpqMkq7CRXP2LZkutB9CfTUUU6H2aQFVoKeEManfjrwKJiugB3ByJrA
         hg8XjpCB0IXty8ucbIFUo9Q3DWQF02uWXnDYuydcwpvgC3guTLSg51qL/KrhpqGmqU
         oltlhxnbE6/y47ciCnZ4bkVTFa0EcRr9txOSFMTfP6XYyPLOMAfEa4QnM8LAba4+Fa
         gbDT12sFqZDb+LG+GP1vbHU2qGrKnoZi23aQr9FEyFgE87jvdBUuxHmXYR5n/x4tWZ
         gnMNBl3ULRRNQ==
Date:   Thu, 25 May 2023 18:28:16 -0700
Subject: [PATCH 24/25] xfs: support non-power-of-two rtextsize with
 exchange-range
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Message-ID: <168506065328.3734442.8337276024483785147.stgit@frogsfrogsfrogs>
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

The VFS exchange-range alignment checks use (fast) bitmasks to perform
block alignment checks on the exchange parameters.  Unfortunately,
bitmasks require that the alignment size be a power of two.  This isn't
true for realtime devices, so we have to copy-pasta the VFS checks using
long division for this to work properly.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_xchgrange.c |  102 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 91 insertions(+), 11 deletions(-)


diff --git a/fs/xfs/xfs_xchgrange.c b/fs/xfs/xfs_xchgrange.c
index 1c26290b992d..9595aeb599ef 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -816,6 +816,86 @@ xfs_xchg_range_need_rt_conversion(
 	return xfs_inode_has_bigrtextents(ip);
 }
 
+/*
+ * Check the alignment of an exchange request when the allocation unit size
+ * isn't a power of two.  The VFS helpers use (fast) bitmask-based alignment
+ * checks, but here we have to use slow long division.
+ */
+static int
+xfs_xchg_range_check_rtalign(
+	struct xfs_inode		*ip1,
+	struct xfs_inode		*ip2,
+	const struct xfs_exch_range	*fxr)
+{
+	struct xfs_mount		*mp = ip1->i_mount;
+	uint32_t			rextbytes;
+	uint64_t			length = fxr->length;
+	uint64_t			blen;
+	loff_t				size1, size2;
+
+	rextbytes = XFS_FSB_TO_B(mp, mp->m_sb.sb_rextsize);
+	size1 = i_size_read(VFS_I(ip1));
+	size2 = i_size_read(VFS_I(ip2));
+
+	/* The start of both ranges must be aligned to a rt extent. */
+	if (!isaligned_64(fxr->file1_offset, rextbytes) ||
+	    !isaligned_64(fxr->file2_offset, rextbytes))
+		return -EINVAL;
+
+	/*
+	 * If the caller asked for full files, check that the offset/length
+	 * values cover all of both files.
+	 */
+	if ((fxr->flags & XFS_EXCH_RANGE_FULL_FILES) &&
+	    (fxr->file1_offset != 0 || fxr->file2_offset != 0 ||
+	     fxr->length != size1 || fxr->length != size2))
+		return -EDOM;
+
+	if (fxr->flags & XFS_EXCH_RANGE_TO_EOF)
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
+		blen = roundup_64(size1, rextbytes) - fxr->file1_offset;
+	else if (fxr->file2_offset + length == size2)
+		blen = roundup_64(size2, rextbytes) - fxr->file2_offset;
+	else if (!isaligned_64(length, rextbytes))
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
+	if (isaligned_64(length, rextbytes))
+		return 0;
+
+	blen = length;
+	if (fxr->file2_offset + length < size2)
+		blen = rounddown_64(blen, rextbytes);
+
+	if (fxr->file1_offset + blen < size1)
+		blen = rounddown_64(blen, rextbytes);
+
+	return blen == length ? 0 : -EINVAL;
+}
+
 /* Prepare two files to have their data exchanged. */
 int
 xfs_xchg_range_prep(
@@ -826,6 +906,7 @@ xfs_xchg_range_prep(
 {
 	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
 	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip2);
 	int			error;
 
 	trace_xfs_xchg_range_prep(ip1, fxr, ip2, 0);
@@ -834,18 +915,17 @@ xfs_xchg_range_prep(
 	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
 		return -EINVAL;
 
-	/*
-	 * The alignment checks in the VFS helpers cannot deal with allocation
-	 * units that are not powers of 2.  This can happen with the realtime
-	 * volume if the extent size is set.  Note that alignment checks are
-	 * skipped if FULL_FILES is set.
-	 */
-	if (!(fxr->flags & XFS_EXCH_RANGE_FULL_FILES) &&
-	    !is_power_of_2(xfs_inode_alloc_unitsize(ip2)))
-		return -EOPNOTSUPP;
+	/* Check non-power of two alignment issues, if necessary. */
+	if (XFS_IS_REALTIME_INODE(ip2) && !is_power_of_2(alloc_unit)) {
+		error = xfs_xchg_range_check_rtalign(ip1, ip2, fxr);
+		if (error)
+			return error;
 
-	error = xfs_exch_range_prep(file1, file2, fxr,
-			xfs_inode_alloc_unitsize(ip2));
+		/* Do the VFS checks with the regular block alignment. */
+		alloc_unit = ip1->i_mount->m_sb.sb_blocksize;
+	}
+
+	error = xfs_exch_range_prep(file1, file2, fxr, alloc_unit);
 	if (error || fxr->length == 0)
 		return error;
 

