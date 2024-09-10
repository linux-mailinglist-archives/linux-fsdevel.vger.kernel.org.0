Return-Path: <linux-fsdevel+bounces-28994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B502E97287D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD8B1F24DA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF6314C581;
	Tue, 10 Sep 2024 04:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AzzhH91W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4821F16DECC;
	Tue, 10 Sep 2024 04:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943240; cv=none; b=ujfLs6rh8cBeN4ySnzVwFYxSVK7xPCCr3Qu7L6E5CPQ7jHk09W0msLU0zjKt7C6txPl54utPkwAkSLNa58o9orrP3j5yeCgp59heYVripNJ6uLqHimvX+zyP3cVeZzC4mmtKLhGGPgPDgNY+VGlP1X7jBpV8wTXSgdEmGJu7vp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943240; c=relaxed/simple;
	bh=FlIO9JPzS5Fa5iDG39QnEPq8Vb68yVlCBNjXVgWOm5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HT2JCShSwUhtdGxjuzdvDkAd030AXsyfWYzY0nAiJu5g2r5GJh2sSl9DZYC0AyuhApXQl9x4Y/cwo7lRhPhRq0aKtM6ximalyijUMfk+4eJ6bVoi9AAEvk0WOumTueouINkL29oxOO7gQ2R7ziDfOyZaVZFwjhLPOKNc4J7eopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AzzhH91W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OmWVswPXVzrF4tNUvkQ9RrIJnqQVwd2UULxZUmIHGK8=; b=AzzhH91WysbUAH+WAdXysUayiK
	6dZEMsXVd9eRfRSnm2nxx7jW4PMUJJKZ2VZf6l0/heQclqJ3/DlvTEeAn0qNu3Eepb4Zm+ByI6fiT
	ddhSaIah9mOYSdkbDzU/N8/+ciKdUNuC4byot5ZHD58UGhiu3RDE393mnrQiyIQoL/DQO1f3vVt/I
	cg8uP6ROn2i9EFxKiOwo8K0MgmOzrn0FUJK6qoOJG1k2LGUOtkiWqOAJdl58bxcR71BeEKAQ8TuDK
	mNeHxdxSBOWEyYLUVcp0iPt9C61iMBhGLCstTQOpv15t6OlCTRiEv1HoY91Uaj5YfYoYVtVBByHfN
	0tOHuVLA==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsgA-00000004EzY-0SKt;
	Tue, 10 Sep 2024 04:40:38 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/12] xfs: support the COW fork in xfs_bmap_punch_delalloc_range
Date: Tue, 10 Sep 2024 07:39:11 +0300
Message-ID: <20240910043949.3481298-10-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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
index 087867be0cf92d..c5165aed0e5102 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -442,11 +442,12 @@ xfs_getbmap(
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
@@ -474,11 +475,14 @@ xfs_bmap_punch_delalloc_range(
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
@@ -580,7 +584,7 @@ xfs_free_eofblocks(
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
index 3c98d82c0ad0dc..1d068cac69b4cc 100644
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
2.45.2


