Return-Path: <linux-fsdevel+bounces-15757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FEE89289C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 02:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7B931C20B44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7820B5CAC;
	Sat, 30 Mar 2024 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inQwtO3s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4314C99;
	Sat, 30 Mar 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711760388; cv=none; b=Tl+YfvQXJ0Iw3XFMBnRM3ei9uJbPhyDG1RwazsYpB8vmyyN+QujuZ9lZO7mNQCJVDADew/aOYR5n6E44wADX9zuvLsyYPkzFpLloczTC4aUL0dzD1NpQNSVavzVXv/Kwl9SRU+91SfNWmk+pr4pVh2RYeH0dmtJ2CetHQ9P7zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711760388; c=relaxed/simple;
	bh=o9iIaWSYhQ3MC2Zqg/VKe33lM2bmHrfsINac+R7dP+4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dy43rhtjr3Ex3gZU9vDoapSEHoPvSNJqTGvLex3s2zOiZtBkOVHQDngNSSFutE9HwE2WcgffE8pKCkAhdVFgkflN9lR7J68282+JTZcpaHkZKUQOKpdHLzqlJj7Q/lhWKQCsnk0JCGnl5MCFCkk9jH9+ff1+NgjQA2rFnZDCOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inQwtO3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A884C4166A;
	Sat, 30 Mar 2024 00:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711760388;
	bh=o9iIaWSYhQ3MC2Zqg/VKe33lM2bmHrfsINac+R7dP+4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=inQwtO3sST/AGB1oalP0po3VotWaQxCEYmMMeQTC8wmUZM2R12iur8FXjPPTNcN6o
	 VauYM92tNqXpYMBUDC9V2rnoh3WRcf6yJ0iIXYZxWas/WvUEN0fgz7y3akp282fOv6
	 UDE8+8UBh/0VOZVv7cLggSEkDMOh+QBD3ccjpp8okXOyC2OtGxs95s7ToKs4PtHNLr
	 pwIgb/fDyxh41GkKJKphwXv7yeDF6Kgg2+GDryRa/oEZrsB5b7Az5VfKT18k0Ygdaa
	 UYK8pF6zqrqas98/5Q/7hb5a/3twjnISPUyS6FEIewQ4LDhH9qtekn5o8lvT1yAupU
	 ZhEZ0RLQm73SA==
Date: Fri, 29 Mar 2024 17:59:47 -0700
Subject: [PATCH 11/14] xfs: make file range exchange support realtime files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, hch@lst.de,
 linux-xfs@vger.kernel.org
Message-ID: <171176018859.2014991.5490004087203613834.stgit@frogsfrogsfrogs>
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
index 7b7b8b1d8a2b5..0ac52a73152f2 100644
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
index 1642ea1bd7b30..23e668a192e0d 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -21,6 +21,7 @@
 #include "xfs_sb.h"
 #include "xfs_icache.h"
 #include "xfs_log.h"
+#include "xfs_rtbitmap.h"
 #include <linux/fsnotify.h>
 
 /*
@@ -241,6 +242,14 @@ xfs_exchrange_mappings(
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


