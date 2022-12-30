Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF8659EFA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiL3XzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbiL3XzW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:55:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862311E3CE;
        Fri, 30 Dec 2022 15:55:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25A0161BCD;
        Fri, 30 Dec 2022 23:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBB4C433D2;
        Fri, 30 Dec 2022 23:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672444520;
        bh=d6rZADnnl5NJT9em+5xNA+xpoVTObaMoEUZNgr89LGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OyeO3MbXs7HqmRNt64bgvPOCHTTl9cWxM4RDDFHnhM7JBEnwMtLZOjOVr65jR+sq2
         FqBfjAgdtQhRWiffjdtRAMpx7Wipyaxq5SqN+gxvDPjWm6rinQwNZ42SWOhLY8Vuxb
         cySLaqYR2waqYbJAL+98HBJzvvDTSBlLsvl7433PXCin8iNjhmEiDthCtEXp//LBJJ
         HAimJzjaR9jCzg32gjM1/XGILNe02EpzPcY/f7bKBK9mPSxFh4qWsWfZR/BRHWvrGZ
         4vSbHXvHwTHjBdK7E2RiO5yQvao2x1G1HI+YwVebEMUnDVmq6PXsbT0oDzQ3MZTVDe
         Q/pDf275PfCEA==
Subject: [PATCH 20/21] xfs: support non-power-of-two rtextsize with
 exchange-range
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:13:58 -0800
Message-ID: <167243843816.699466.13150984573684791764.stgit@magnolia>
In-Reply-To: <167243843494.699466.5163281976943635014.stgit@magnolia>
References: <167243843494.699466.5163281976943635014.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 6a66d09099b0..ae030a6f607e 100644
--- a/fs/xfs/xfs_xchgrange.c
+++ b/fs/xfs/xfs_xchgrange.c
@@ -416,6 +416,86 @@ xfs_xchg_range_need_rt_conversion(
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
+	const struct file_xchg_range	*fxr)
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
+	if ((fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
+	    (fxr->file1_offset != 0 || fxr->file2_offset != 0 ||
+	     fxr->length != size1 || fxr->length != size2))
+		return -EDOM;
+
+	if (fxr->flags & FILE_XCHG_RANGE_TO_EOF)
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
@@ -426,6 +506,7 @@ xfs_xchg_range_prep(
 {
 	struct xfs_inode	*ip1 = XFS_I(file_inode(file1));
 	struct xfs_inode	*ip2 = XFS_I(file_inode(file2));
+	unsigned int		alloc_unit = xfs_inode_alloc_unitsize(ip2);
 	int			error;
 
 	trace_xfs_xchg_range_prep(ip1, fxr, ip2, 0);
@@ -434,18 +515,17 @@ xfs_xchg_range_prep(
 	if (XFS_IS_REALTIME_INODE(ip1) != XFS_IS_REALTIME_INODE(ip2))
 		return -EINVAL;
 
-	/*
-	 * The alignment checks in the VFS helpers cannot deal with allocation
-	 * units that are not powers of 2.  This can happen with the realtime
-	 * volume if the extent size is set.  Note that alignment checks are
-	 * skipped if FULL_FILES is set.
-	 */
-	if (!(fxr->flags & FILE_XCHG_RANGE_FULL_FILES) &&
-	    !is_power_of_2(xfs_inode_alloc_unitsize(ip2)))
-		return -EOPNOTSUPP;
+	/* Check non-power of two alignment issues, if necessary. */
+	if (XFS_IS_REALTIME_INODE(ip2) && !is_power_of_2(alloc_unit)) {
+		error = xfs_xchg_range_check_rtalign(ip1, ip2, fxr);
+		if (error)
+			return error;
 
-	error = generic_xchg_file_range_prep(file1, file2, fxr,
-			xfs_inode_alloc_unitsize(ip2));
+		/* Do the VFS checks with the regular block alignment. */
+		alloc_unit = ip1->i_mount->m_sb.sb_blocksize;
+	}
+
+	error = generic_xchg_file_range_prep(file1, file2, fxr, alloc_unit);
 	if (error || fxr->length == 0)
 		return error;
 

