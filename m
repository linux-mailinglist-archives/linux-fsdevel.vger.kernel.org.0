Return-Path: <linux-fsdevel+bounces-16402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CCF89D130
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 05:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56E9B1F21D34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5F554F92;
	Tue,  9 Apr 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuCjW9y2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADF54743;
	Tue,  9 Apr 2024 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633843; cv=none; b=NSpJRuM8ShXWrx/ioqcl5geYtdiTg10lQRA95zqyfwQz1rwyn+2mtFiPNhfc87PLqPX7bwz8CeEGkbglweFG2mEXQaKHR6FaHksM5x7+2iDvXAYMN3M/OjYbJiyrAnn0p2dd+td03CMB9I4UJ8mUt63z9tPE5aQ/Sla0UJeTww0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633843; c=relaxed/simple;
	bh=MGQZlzBc2ocQN2TLxRrhxBwsdyZ58BpZ2zf7LOepDRs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bme5O46uLG90CsvDWpyYcG/6v0JUYG7H9QRkKLDc98C6SvGhyXOV4HloZtcxc+0xfxxHc9ZAy5pFSmWpB1Xt2S09YeqUQSO/ztxg9DVr3vKIFmRH4/Su4GMFuOJ0xAiuxTej+hKU1RM73ghK9GaNUYwi/J6ULeIeSEMCe48gWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuCjW9y2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC4DC433C7;
	Tue,  9 Apr 2024 03:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712633843;
	bh=MGQZlzBc2ocQN2TLxRrhxBwsdyZ58BpZ2zf7LOepDRs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=TuCjW9y24zgzEbhmV6ictCe30ww5+4vXOC0T+0KYjkWZzQ7r6wwDS5KdJTxwid/P9
	 CQ8QItiV+8Ud/N6F0URqQKMJRoGr0XtRCUYZ2UnVIjeyTPZv7gKkZWd0d2V1pBuhCS
	 JLZXdmqOuPTnoR7UzYkc871yyT5CrdIK4OyLuneMI3vAdDc5wvM5aLIBZ6yfjK/hmi
	 b7uTute+HVQBg9FuIpxQpWVrPZYFDz02WqAoyEFJs4oDBvYGm7ax+JXBfxZ4mrNP5B
	 9adA5pMA2sk1y96uHkalT9sVuWfkGozTnu0Yb197LySxJQz2fUqy8zrNCLY1p3Ptya
	 +yPc3SekqyahQ==
Date: Mon, 08 Apr 2024 20:37:22 -0700
Subject: [PATCH 11/14] xfs: make file range exchange support realtime files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, hch@lst.de, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
Message-ID: <171263348646.2978056.10426556562007277356.stgit@frogsfrogsfrogs>
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

Now that bmap items support the realtime device, we can add the
necessary pieces to the file range exchange code to support exchanging
mappings.  All we really need to do here is adjust the blockcount
upwards to the end of the rt extent and remove the inode checks.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/libxfs/xfs_exchmaps.c |   70 ++++++++++++++++++++++++++++++++++++------
 fs/xfs/xfs_exchrange.c       |    9 +++++
 2 files changed, 69 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index f58240466b1c4..4ffb17adc7a27 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -152,12 +152,7 @@ xfs_exchmaps_check_forks(
 	    ifp2->if_format == XFS_DINODE_FMT_LOCAL)
 		return -EINVAL;
 
-	/* We don't support realtime data forks yet. */
-	if (!XFS_IS_REALTIME_INODE(req->ip1))
-		return 0;
-	if (whichfork == XFS_ATTR_FORK)
-		return 0;
-	return -EINVAL;
+	return 0;
 }
 
 #ifdef CONFIG_XFS_QUOTA
@@ -198,6 +193,8 @@ xfs_exchmaps_can_skip_mapping(
 	struct xfs_exchmaps_intent	*xmi,
 	struct xfs_bmbt_irec		*irec)
 {
+	struct xfs_mount		*mp = xmi->xmi_ip1->i_mount;
+
 	/* Do not skip this mapping if the caller did not tell us to. */
 	if (!(xmi->xmi_flags & XFS_EXCHMAPS_INO1_WRITTEN))
 		return false;
@@ -209,11 +206,64 @@ xfs_exchmaps_can_skip_mapping(
 	/*
 	 * The mapping is unwritten or a hole.  It cannot be a delalloc
 	 * reservation because we already excluded those.  It cannot be an
-	 * unwritten mapping with dirty page cache because we flushed the page
-	 * cache.  We don't support realtime files yet, so we needn't (yet)
-	 * deal with them.
+	 * unwritten extent with dirty page cache because we flushed the page
+	 * cache.  For files where the allocation unit is 1FSB (files on the
+	 * data dev, rt files if the extent size is 1FSB), we can safely
+	 * skip this mapping.
 	 */
-	return true;
+	if (!xfs_inode_has_bigallocunit(xmi->xmi_ip1))
+		return true;
+
+	/*
+	 * For a realtime file with a multi-fsb allocation unit, the decision
+	 * is trickier because we can only swap full allocation units.
+	 * Unwritten mappings can appear in the middle of an rtx if the rtx is
+	 * partially written, but they can also appear for preallocations.
+	 *
+	 * If the mapping is a hole, skip it entirely.  Holes should align with
+	 * rtx boundaries.
+	 */
+	if (!xfs_bmap_is_real_extent(irec))
+		return true;
+
+	/*
+	 * All mappings below this point are unwritten.
+	 *
+	 * - If the beginning is not aligned to an rtx, trim the end of the
+	 *   mapping so that it does not cross an rtx boundary, and swap it.
+	 *
+	 * - If both ends are aligned to an rtx, skip the entire mapping.
+	 */
+	if (!isaligned_64(irec->br_startoff, mp->m_sb.sb_rextsize)) {
+		xfs_fileoff_t	new_end;
+
+		new_end = roundup_64(irec->br_startoff, mp->m_sb.sb_rextsize);
+		irec->br_blockcount = min(irec->br_blockcount,
+					  new_end - irec->br_startoff);
+		return false;
+	}
+	if (isaligned_64(irec->br_blockcount, mp->m_sb.sb_rextsize))
+		return true;
+
+	/*
+	 * All mappings below this point are unwritten, start on an rtx
+	 * boundary, and do not end on an rtx boundary.
+	 *
+	 * - If the mapping is longer than one rtx, trim the end of the mapping
+	 *   down to an rtx boundary and skip it.
+	 *
+	 * - The mapping is shorter than one rtx.  Swap it.
+	 */
+	if (irec->br_blockcount > mp->m_sb.sb_rextsize) {
+		xfs_fileoff_t	new_end;
+
+		new_end = rounddown_64(irec->br_startoff + irec->br_blockcount,
+				mp->m_sb.sb_rextsize);
+		irec->br_blockcount = new_end - irec->br_startoff;
+		return true;
+	}
+
+	return false;
 }
 
 /*
diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index 6ecbd9d4c9363..fc2ef7da6cd43 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -21,6 +21,7 @@
 #include "xfs_sb.h"
 #include "xfs_icache.h"
 #include "xfs_log.h"
+#include "xfs_rtbitmap.h"
 #include <linux/fsnotify.h>
 
 /* Lock (and optionally join) two inodes for a file range exchange. */
@@ -182,6 +183,14 @@ xfs_exchrange_mappings(
 	if (fxr->flags & XFS_EXCHANGE_RANGE_FILE1_WRITTEN)
 		req.flags |= XFS_EXCHMAPS_INO1_WRITTEN;
 
+	/*
+	 * Round the request length up to the nearest file allocation unit.
+	 * The prep function already checked that the request offsets and
+	 * length in @fxr are safe to round up.
+	 */
+	if (xfs_inode_has_bigallocunit(ip2))
+		req.blockcount = xfs_rtb_roundup_rtx(mp, req.blockcount);
+
 	error = xfs_exchrange_estimate(&req);
 	if (error)
 		return error;


