Return-Path: <linux-fsdevel+bounces-32256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 931DF9A2D24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8071F2354F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 19:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046B21C18B;
	Thu, 17 Oct 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3ROzXtC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD07219CA6;
	Thu, 17 Oct 2024 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191820; cv=none; b=qFvlaXEN4ft6+blfD3twp3/bKcDfOygLSyREdYVX21Re+4dKccGuPeZVwZgEpgdpktGnLs8IA0OJ+3kY7VXouyFGAqSZIQGMRvlS2C69FUTmGkmTIPMkWskisDM0FwqXDJ5VTTpsV8EfjpKgkwWnjnE6eBC5fzwc/AML4okq07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191820; c=relaxed/simple;
	bh=RTUzcOj1zOkR/wRkPpifiR9ZrN2kO5e4mfFr7auibZ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SwF6g/03VKAmhUAbqC/L3IpF0t3hRt4UmcEPr1eAFfQPmZOFkGRaZnE8IcuA88vYC+FOEDZ8wDUy0WinjCY24ZHdhOjNXRlLVJkWEk1Vm+e2K8gt1NCxTblz7V94w+GhioFe9QbnxHpyUD3Yns42XxFgHMLnOB/d22TtFjK6J2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3ROzXtC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C45FC4CEC3;
	Thu, 17 Oct 2024 19:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729191820;
	bh=RTUzcOj1zOkR/wRkPpifiR9ZrN2kO5e4mfFr7auibZ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=V3ROzXtCn+7fz1+JBEtt9a63is/F8uRtLig5kPJkBHnN/DWSiNxxXAHwpuJVVp1v0
	 R40DpkZqCdqaRNfO54qIawc6u3TL1i4+/k0OUtcL26LvhVFlQ8T3PeJS2tq8knkPbj
	 NjYmih0jCsUK8Eb1GLffZeFUYowgioIO8rEPHQty4R+U/+3gmDSsgFhN2spXzXlqnm
	 XkzfqDd5LtV7Lb4uIg7C9UTOUInuCQJlOo75S9uB+HVF3lhK0J9dQ5LgnS0eUrtAAk
	 flbBU7mVpOg+skMFOngPJ88PPAY5KqRVV2RaISumYQ5tBXLr7h0+yeTu1RBe3R4RLh
	 VdtKgQTORrq+g==
Date: Thu, 17 Oct 2024 12:03:39 -0700
Subject: [PATCH 1/2] xfs: fix rt device offset calculations for FITRIM
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <172919071131.3453051.3024728895345414372.stgit@frogsfrogsfrogs>
In-Reply-To: <172919071109.3453051.9492235995311336058.stgit@frogsfrogsfrogs>
References: <172919071109.3453051.9492235995311336058.stgit@frogsfrogsfrogs>
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
 


