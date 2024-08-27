Return-Path: <linux-fsdevel+bounces-27297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BB29600E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00232B23130
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05271147C86;
	Tue, 27 Aug 2024 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2krRZ9wS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDB314659A;
	Tue, 27 Aug 2024 05:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735449; cv=none; b=nKSmLPvhbb6Z18brePDvMO891Bv5WC7x73d/tIXtOLOoz02Ge9mqcO/wwF1WWiIyo8Q2ihS2pd0dMOgpr3ymUS0UizxHljy8bKXt4MfaifDfOIIae5ZvkyoC8nZ092RKo95ld+S4T7myQbnssi7eh6YShnu8doEnH2u6E2Dsc9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735449; c=relaxed/simple;
	bh=QUFtyJH3dcMcZebFwUvcCKMArk5V+gX/0xD0GNmJT14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKDFYmT9RAIjQZWPp06t1pGzs6zZ8oW5SWcoEYDIZppLbjGSXNCXlouR7MtWyfDt8jdldMRGveDV06Q7gJTIOvVExs7o+nQAJ5uCRZZ7CYQAoxdRdipZvAaI3yCL8tcG7Bcb3AdNs0FFmACeKkr4jSLw5PjoVJw4+7rJQEJSHg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2krRZ9wS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xjHxjPn3HQ8KFImChtzQQNIb0yJo4Nv6I9RvSN32pMw=; b=2krRZ9wSx/EE7Gt4dmjDSDTI7S
	L3667pa7/rNQ15S01o4fTH/ROMbqkao8a1C1K6aBrtvSHsgwv9+fb+MPjLl/g87PpBYQ1ib4dDGK3
	31AaLHizBHPDeQNXGwfWzgehVdO7gfryZhFJoGHhymB4V47SHBsE9cSAHy1esUVs+xUt+YnVcZGj2
	G2geFhQGJrF2GLIso0/+OIuMuLxHHfrjLMtzdGKmd3Fdt3u4ApCL56PNEfVC5y5z6Fc+BVrO7HZ9j
	utC4MB7H3C+p76V0F/7672cy2T6bF71RQOeCH7F5uNLRqxf4OV9yeQjSdEH0UaRa2tnREuYMPBceq
	XjffnTOA==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTf-00000009ovt-14Tq;
	Tue, 27 Aug 2024 05:10:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/10] xfs: support the COW fork in xfs_bmap_punch_delalloc_range
Date: Tue, 27 Aug 2024 07:09:54 +0200
Message-ID: <20240827051028.1751933-8-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240827051028.1751933-1-hch@lst.de>
References: <20240827051028.1751933-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

xfs_buffered_write_iomap_begin can also create delallocate reservations
that need cleaning up, prepare for that by adding support for the COW
fork in xfs_bmap_punch_delalloc_range.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.c      |  4 ++--
 fs/xfs/xfs_bmap_util.c | 10 +++++++---
 fs/xfs/xfs_bmap_util.h |  2 +-
 fs/xfs/xfs_iomap.c     |  3 ++-
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6dead20338e24c..559a3a57709748 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -116,7 +116,7 @@ xfs_end_ioend(
 	if (unlikely(error)) {
 		if (ioend->io_flags & IOMAP_F_SHARED) {
 			xfs_reflink_cancel_cow_range(ip, offset, size, true);
-			xfs_bmap_punch_delalloc_range(ip, offset,
+			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, offset,
 					offset + size);
 		}
 		goto done;
@@ -456,7 +456,7 @@ xfs_discard_folio(
 	 * byte of the next folio. Hence the end offset is only dependent on the
 	 * folio itself and not the start offset that is passed in.
 	 */
-	xfs_bmap_punch_delalloc_range(ip, pos,
+	xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK, pos,
 				folio_pos(folio) + folio_size(folio));
 }
 
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fe2e2c93097550..15c8f90f19a934 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -443,11 +443,12 @@ xfs_getbmap(
 void
 xfs_bmap_punch_delalloc_range(
 	struct xfs_inode	*ip,
+	int			whichfork,
 	xfs_off_t		start_byte,
 	xfs_off_t		end_byte)
 {
 	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_ifork	*ifp = &ip->i_df;
+	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, whichfork);
 	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, start_byte);
 	xfs_fileoff_t		end_fsb = XFS_B_TO_FSB(mp, end_byte);
 	struct xfs_bmbt_irec	got, del;
@@ -475,11 +476,14 @@ xfs_bmap_punch_delalloc_range(
 			continue;
 		}
 
-		xfs_bmap_del_extent_delay(ip, XFS_DATA_FORK, &icur, &got, &del);
+		xfs_bmap_del_extent_delay(ip, whichfork, &icur, &got, &del);
 		if (!xfs_iext_get_extent(ifp, &icur, &got))
 			break;
 	}
 
+	if (whichfork == XFS_COW_FORK && !ifp->if_bytes)
+		xfs_inode_clear_cowblocks_tag(ip);
+
 out_unlock:
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 }
@@ -590,7 +594,7 @@ xfs_free_eofblocks(
 	 */
 	if (ip->i_diflags & (XFS_DIFLAG_PREALLOC | XFS_DIFLAG_APPEND)) {
 		if (ip->i_delayed_blks) {
-			xfs_bmap_punch_delalloc_range(ip,
+			xfs_bmap_punch_delalloc_range(ip, XFS_DATA_FORK,
 				round_up(XFS_ISIZE(ip), mp->m_sb.sb_blocksize),
 				LLONG_MAX);
 		}
diff --git a/fs/xfs/xfs_bmap_util.h b/fs/xfs/xfs_bmap_util.h
index eb0895bfb9dae4..b29760d36e1ab1 100644
--- a/fs/xfs/xfs_bmap_util.h
+++ b/fs/xfs/xfs_bmap_util.h
@@ -30,7 +30,7 @@ xfs_bmap_rtalloc(struct xfs_bmalloca *ap)
 }
 #endif /* CONFIG_XFS_RT */
 
-void	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip,
+void	xfs_bmap_punch_delalloc_range(struct xfs_inode *ip, int whichfork,
 		xfs_off_t start_byte, xfs_off_t end_byte);
 
 struct kgetbmap {
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 1e11f48814c0d0..24d69c8c168aeb 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1215,7 +1215,8 @@ xfs_buffered_write_delalloc_punch(
 	loff_t			length,
 	struct iomap		*iomap)
 {
-	xfs_bmap_punch_delalloc_range(XFS_I(inode), offset, offset + length);
+	xfs_bmap_punch_delalloc_range(XFS_I(inode), XFS_DATA_FORK, offset,
+			offset + length);
 }
 
 static int
-- 
2.43.0


