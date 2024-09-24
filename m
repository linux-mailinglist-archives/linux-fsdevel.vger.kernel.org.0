Return-Path: <linux-fsdevel+bounces-29945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EC3983F83
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9D5FB212E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 07:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF6614F9E7;
	Tue, 24 Sep 2024 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dmqsvfRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470F14830C;
	Tue, 24 Sep 2024 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163710; cv=none; b=dDB9Oj+rubfCXAr+6ALqOtd0t2NtMPZUYRrqar69EzdesbshIbDm8X8Apjre7rBVuLDs+p46iTQd2eIoAQumF2+SAKyBVyYl6/f9MqYU+mYLbQZ/Cj96s3gAHFEwGJADtMmwVr/RMCRcM0fNoNFHGvJhinr5svOPkjSEZ/O1wW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163710; c=relaxed/simple;
	bh=dO7DPx9lr+A6EiTToDNsMt0eMLyFbcysQqhoPY9lCwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dbk1CWwJRIhmeIut5g2TxQjOhDlNw5t1cva5lVp1zeM7fnnU4KR+tfefdfRbpShE8GeiA5bdeRpNTk7l//dvtIymc7p1S2BFE0s0kzwC5KoTodcdV0uumLWpRc7SofO7D6pzxYLt2Ivpb0Trcqj+TO9aVkQjfjficknxfOJyz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dmqsvfRt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=YNRHAj4pG2z8wKAOo6HVGGA4NzRephlTf1ufR3qBIbg=; b=dmqsvfRt0vUo+ergFN7BL23uCq
	TqH+MaSkqHgHwfUt/MwCC/hzZfvwRhPTEWBLuCUU7Mc4Cuu2mcjzGnxDW2sgwZ/ioGGzvWIMDCUkR
	qB3L6HajqVyXu5n6sPU7hAvVIToML/7gMUjTw+FEBIgrbf3jXbB9FadaDeAGRvV890j9LpJnPFMTV
	sSDWMqIBVsEYY1NSo32BKs8ZntAy+4v+hB+O7rdZbL+aafnqZXEbgk8sDi4RwfWZssj0H58YRFl7k
	thqvARS+S5x0d5YlpzSv1u/ze/z7iwHAlz8XVnns5h24QIvPhvFVKW+GvyHMKiiUy5ADRZwFF44zt
	QcujZaZA==;
Received: from 2a02-8389-2341-5b80-b62d-f525-8e84-d569.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b62d:f525:8e84:d569] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1st0BA-00000001SPf-1lhp;
	Tue, 24 Sep 2024 07:41:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/10] xfs: punch delalloc extents from the COW fork for COW writes
Date: Tue, 24 Sep 2024 09:40:52 +0200
Message-ID: <20240924074115.1797231-11-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de>
References: <20240924074115.1797231-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iomap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cc768f0139d365..8a4e5f14ec0c77 100644
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
2.45.2


