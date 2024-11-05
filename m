Return-Path: <linux-fsdevel+bounces-33701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246EF9BD8AF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 23:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE641283BCD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 22:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019521643F;
	Tue,  5 Nov 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMHQZOTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63E433B5;
	Tue,  5 Nov 2024 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845779; cv=none; b=FkMXRHJKNjW1xznov+UuJhiXzXZLPhMiqeEJduCvWSD58GlWgQdWnqxT0HnbbNnkX6PbaYrPQnmeslojw2n96HNagB4qzSFCehpmZOGNKFEPn1cKo75Ug1mdTl4F9HC50QshI8DWTgHSOoLT8GPMWYVZjajY0YkimOvOG9BHbTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845779; c=relaxed/simple;
	bh=RTUzcOj1zOkR/wRkPpifiR9ZrN2kO5e4mfFr7auibZ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KE0ntknMDyZadp0wTGwXEV5W0Lmy5apD1dFcKPCIoSM58eWmQct5dYfqspZwZpFUTRNypMH/C74Z2gO19ERaHFoS84FcEoX7GuyaCwg1xnZHAF2Rc4gndE0fdBhsXRHBdx99Wi1m0yWFDD4/66imrmL43BWlU00x+drXzpgnhoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMHQZOTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EC2C4CECF;
	Tue,  5 Nov 2024 22:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730845779;
	bh=RTUzcOj1zOkR/wRkPpifiR9ZrN2kO5e4mfFr7auibZ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XMHQZOTEBq11MeSTb/bv47sdBrSzR6RcmwYBNhfc2DhOwQQo19IO5HUdKRTjW/7R2
	 Mr5PF+f74n7lY+wl7fO3FEvM2j7BQOAPGage2z+o40G3iIYe3ZQfDudyZ+aCLEAAIG
	 1j7fHUSj5WWTZ5vC+EwCuU9DWvNiMCPBBb0kYIt6GinrarQdEZoHzdfI6fFqdF5O3v
	 y5IAx9h5N0YmFLfY0IIozyFbNVGYRYbDW4H8BtxDBdqJdwULevjlVUzJi0JwlbFt50
	 3zgE9aHjtHU+i5q145tdwzfKojyMziSE6XEvKEJsJlFWG3wjC2G199pSrjnR3x0V6i
	 JChuxb9UKzv+Q==
Date: Tue, 05 Nov 2024 14:29:38 -0800
Subject: [PATCH 1/2] xfs: fix rt device offset calculations for FITRIM
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <173084397664.1871760.3393564037807268704.stgit@frogsfrogsfrogs>
In-Reply-To: <173084397642.1871760.15713612607469138511.stgit@frogsfrogsfrogs>
References: <173084397642.1871760.15713612607469138511.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

FITRIM on xfs has this bizarro uapi where we flatten all the physically
addressable storage across two block devices into a linear address
space.  In this address space, the realtime device comes immediately
after the data device.  Therefore, the xfs_trim_rtdev_extents has to
convert its input parameters from the linear address space to actual
rtdev block addresses on the realtime volume.

Right now the address space conversion is done in units of rtblocks.
However, a future patchset will convert xfs_rtblock_t to be a segmented
address space (group:blkno) like the data device.  Change the conversion
code to be done in units of daddrs since those will never be segmented.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_discard.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)


diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 4f3e4736f13ea6..42b8b5e0e931b7 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -480,7 +480,7 @@ xfs_discard_rtdev_extents(
 		trace_xfs_discard_rtextent(mp, busyp->bno, busyp->length);
 
 		error = __blkdev_issue_discard(bdev,
-				XFS_FSB_TO_BB(mp, busyp->bno),
+				xfs_rtb_to_daddr(mp, busyp->bno),
 				XFS_FSB_TO_BB(mp, busyp->length),
 				GFP_NOFS, &bio);
 		if (error)
@@ -612,22 +612,25 @@ xfs_trim_rtdev_extents(
 	xfs_rtblock_t		start_rtbno, end_rtbno;
 	xfs_rtxnum_t		start_rtx, end_rtx;
 	xfs_rgnumber_t		start_rgno, end_rgno;
+	xfs_daddr_t		daddr_offset;
 	int			last_error = 0, error;
 	struct xfs_rtgroup	*rtg = NULL;
 
 	/* Shift the start and end downwards to match the rt device. */
+	daddr_offset = XFS_FSB_TO_BB(mp, mp->m_sb.sb_dblocks);
+	if (start > daddr_offset)
+		start -= daddr_offset;
+	else
+		start = 0;
 	start_rtbno = xfs_daddr_to_rtb(mp, start);
-	if (start_rtbno > mp->m_sb.sb_dblocks)
-		start_rtbno -= mp->m_sb.sb_dblocks;
-	else
-		start_rtbno = 0;
 	start_rtx = xfs_rtb_to_rtx(mp, start_rtbno);
 	start_rgno = xfs_rtb_to_rgno(mp, start_rtbno);
 
+	if (end <= daddr_offset)
+		return 0;
+	else
+		end -= daddr_offset;
 	end_rtbno = xfs_daddr_to_rtb(mp, end);
-	if (end_rtbno <= mp->m_sb.sb_dblocks)
-		return 0;
-	end_rtbno -= mp->m_sb.sb_dblocks;
 	end_rtx = xfs_rtb_to_rtx(mp, end_rtbno + mp->m_sb.sb_rextsize - 1);
 	end_rgno = xfs_rtb_to_rgno(mp, end_rtbno);
 


