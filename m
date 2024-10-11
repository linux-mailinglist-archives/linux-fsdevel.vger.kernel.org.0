Return-Path: <linux-fsdevel+bounces-31654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5F499988F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 03:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8C02845AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 01:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742875256;
	Fri, 11 Oct 2024 01:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT+1m1uu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA610F9;
	Fri, 11 Oct 2024 01:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728608488; cv=none; b=VgS3TZsAL2VqT0GJnLbRqWIhFFWs+0EFwC8wzAw3nbjC1aQ0bjtLKPgHLhasICQOUYaLCsuyFprl8JHVGuZSpPbnQM/AAY7+ZadBzTtCAFl8ynCE6AvZ3x/cv/jIiWHzG9sThJs4KiEPZ3WqkDQod3X5wGRuznVyPexONvbjP1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728608488; c=relaxed/simple;
	bh=RGNKgm3RbyUaqNDlLb6SFgyM+c326PkPyZospDFRJ/E=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDWjRONXojz7/eA0EOpy5GPodGU0hBoJa94mnVg5DpEsLNu0cO5trZWdiUCgzimczmr4NtS3Z+L/jUClc0TrQLZg6tUdtTxYdsrhwC6nQTiEcdwP/ObygGko6ZOCWn7Fk1PMu/4CECybYqXVM0e3pUM2owp6USJyCh8XsSeNSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT+1m1uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42536C4CEC5;
	Fri, 11 Oct 2024 01:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728608485;
	bh=RGNKgm3RbyUaqNDlLb6SFgyM+c326PkPyZospDFRJ/E=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LT+1m1uu7KtV+e2gwrq0DUgDt+gJrZWIpCD7V4uelSPRu1Tqhnoa//fTIdmozp3UT
	 jWMqXe3EWwB3KeuGvhD/Xv5zXc/7zkSsvO/Lj0DESfd1j0wbDHZWublC1cf5DREiHP
	 ERfTcsLQDRalr4FX2FDAwReqMwSotm3PQZHXzVYUuu3Sk2luOH2KyaRQMl1lL69FzU
	 YN5Fo41PjK/3kqgHe+ZxD1aXr7ATwmRAmgF6VSfJ6HZ8ofwQdbdtDRgM6BRht7xmvi
	 XNOGeTXAMlpTZi0Z7MZ2y1q4Tzx6YkAOziwHUrsx9F9huT5dl7at/IrYk/sfg1Sp15
	 FZAH5Z0ZhHytg==
Date: Thu, 10 Oct 2024 18:01:24 -0700
Subject: [PATCH 1/2] xfs: fix rt device offset calculations for FITRIM
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <172860643675.4178573.6455434897985057942.stgit@frogsfrogsfrogs>
In-Reply-To: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
References: <172860643652.4178573.7450433759242549822.stgit@frogsfrogsfrogs>
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
---
 fs/xfs/xfs_discard.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)


diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 34fe6bbeb2a76f..83cc68508a7f6c 100644
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
 


