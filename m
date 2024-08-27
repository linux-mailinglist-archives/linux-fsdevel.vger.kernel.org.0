Return-Path: <linux-fsdevel+bounces-27300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6159600EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B9A2836CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EBB149013;
	Tue, 27 Aug 2024 05:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="twUHlQK+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A3148FF6;
	Tue, 27 Aug 2024 05:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724735457; cv=none; b=rFB0+b0pWtKoLNyBThq/clbHT+ANDS3qqzq1jtD6co1zJ2Iai9m14z8DN1vA0dcJdp/WyvfdtayQ8JzdZJ2LiU7NBq8Kc8jSgHs/OuSGXECUm4VyITlAhFMtOayuXPiA32d1MiMy7t2DASOT8V486Tm/M37K6tha8wkmpGM6Z8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724735457; c=relaxed/simple;
	bh=jvY3TJ5Xo4Arf5fXcydVNHlVPWIMm7Gh4ZAjOFyFjrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGTXPCalJLJvO2U52PVXvcqTZVY7mbrYl88+pp84A6yua1IRVhW7n3LUlmgEQfNU67SwECRiFY38YGaAVyBDtMyvhwPeOhwRln60cUImn21kl1IAvFFiPsoeF1//9rdnqA8//RlA8VwB00Jj684fDf9/rDaHuuooxGVI4TMALgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=twUHlQK+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2BJ7wEgRytdez6wX5d5tK1D5vLK+1FX1/tMbbReuJ1c=; b=twUHlQK+ocmv0Z6lwk+8AVaiYC
	1ssI4bvq7ACIAypgoDHSt8o7HMz1Jt6aKFJqLrH9xlRg++7JtFhqXkSm8Nx2eDTe3aNpmn/hn7Lzi
	ZEiAPiuUh0GrwDAtj15qZ7NKG67NwhFb5FD/h85XrkYDmeLtPxLUUjq7HRmN9AYtcbTnJNjeJl6zO
	hJ+jAMc79eXMeoxNJWtA3kDts8Tms0O36OpqYt2re/I+PWs1ePHf6GuspBVII06IW8LlpNmMDhRES
	LZilqBnyLT3wLZXCHdKGHeNxvcm4f2cEgEw5me3h9dOFcSB9Fvw24oAHEtoUPN9U+Ca2uhrduGLn7
	IhSLTCHg==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sioTm-00000009oxo-2xd3;
	Tue, 27 Aug 2024 05:10:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] xfs: punch delalloc extents from the COW fork for COW writes
Date: Tue, 27 Aug 2024 07:09:57 +0200
Message-ID: <20240827051028.1751933-11-hch@lst.de>
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

When ->iomap_end is called on a short write to the COW fork it needs to
punch stale delalloc data from the COW fork and not the data fork.

Ensure that IOMAP_F_NEW is set for new COW fork allocations in
xfs_buffered_write_iomap_begin, and then use the IOMAP_F_SHARED flag
in xfs_buffered_write_delalloc_punch to decide which fork to punch.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 22e9613a995f12..4113e09cb836a8 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1195,7 +1195,7 @@ xfs_buffered_write_iomap_begin(
 		xfs_trim_extent(&cmap, offset_fsb, imap.br_startoff - offset_fsb);
 	}
 
-	iomap_flags = IOMAP_F_SHARED;
+	iomap_flags |= IOMAP_F_SHARED;
 	seq = xfs_iomap_inode_sequence(ip, iomap_flags);
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, iomap_flags, seq);
@@ -1212,8 +1212,10 @@ xfs_buffered_write_delalloc_punch(
 	loff_t			length,
 	struct iomap		*iomap)
 {
-	xfs_bmap_punch_delalloc_range(XFS_I(inode), XFS_DATA_FORK, offset,
-			offset + length);
+	xfs_bmap_punch_delalloc_range(XFS_I(inode),
+			(iomap->flags & IOMAP_F_SHARED) ?
+				XFS_COW_FORK : XFS_DATA_FORK,
+			offset, offset + length);
 }
 
 static int
-- 
2.43.0


