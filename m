Return-Path: <linux-fsdevel+bounces-38721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B378BA07014
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B0B3A5935
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DDF21506E;
	Thu,  9 Jan 2025 08:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8a5dqUv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DE521504D;
	Thu,  9 Jan 2025 08:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411489; cv=none; b=SvVeDgGPejt/fIzOWoKc2dLfiqnhF+QtTkgLpB4S9aaBeRaPe751qZm1L+tFBt9edUMl6mNPVQDcr8CFudwu7ZexHK6x5Y1fmxRNcpeUua12KWtEKUU7WrLDdJ2BWiP/qYP+U/CWvj9e5hmkJufLzwPZWWeRjLWpeXrwb3uycb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411489; c=relaxed/simple;
	bh=p/OuIHiOJFvwABOtCOFrqH0lSwbKYtW7f7d3Cqohf3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myEMdkPG7N+WwQlvcsz45WwldE4eZvVzm5eBhhN1Klt/jFNHzG6U0job3oeNN+YdmXtcCZJI023DUygpGy/pzIR5xsJX6c8+h0sn36D2o1LKecwi1okJa6FXLYPIlOdUGn0zwX1wm3iuFW8YVz45WjwD5V1Fm6laQ9nLRArhOqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E8a5dqUv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FtAYZYXOsBivy1P3gIjTR2JsStPM4FIOELODfaQzrmE=; b=E8a5dqUvVxGSB7tlzQAVa9KPb8
	PYEFGDFf2EjlWyamFrYMQgw2hD/YWjIKuhft7pxASo+DOR07fU1LZ02ZFR3qxJOq1J0tdQYgvPimT
	yPAxi0Q6OSKdszruftIkUsRvtXlOaMvjd1VuxFU/9gAjE6RHUZXzovzuZlHiOmQy7dzS4mEH71SN9
	GIqAowL1rMxydOtDxkTFirppcYh586iREx31gAHyBVipYbLc4XSJWTbPRccHrChuNZ3M9UM5ZXTfS
	PIp/2v7sG+IYk2kYHnhZ7zJ5hsycnAB1f1lku+YClGMuhQ8sgXUHRN/9Bj/NF8qUhzGnBGTIbBq93
	M2H3uvgg==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnws-0000000BBf6-0AWY;
	Thu, 09 Jan 2025 08:31:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH 4/5] xfs: report the correct read/write dio alignment for reflinked inodes
Date: Thu,  9 Jan 2025 09:31:04 +0100
Message-ID: <20250109083109.1441561-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250109083109.1441561-1-hch@lst.de>
References: <20250109083109.1441561-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

For I/O to reflinked blocks we always need to write an entire new
file system block, and the code enforces the file system block alignment
for the entire file if it has any reflinked blocks.

Use the new STATX_DIO_READ_ALIGN flag to report the asymmetric read
vs write alignments for reflinked files.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6b0228a21617..40289fe6f5b2 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -580,9 +580,24 @@ xfs_report_dioalign(
 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
 	struct block_device	*bdev = target->bt_bdev;
 
-	stat->result_mask |= STATX_DIOALIGN;
+	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
 	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
+
+	/*
+	 * For COW inodes, we can only perform out of place writes of entire
+	 * allocation units (blocks or RT extents).
+	 * For writes smaller than the allocation unit, we must fall back to
+	 * buffered I/O to perform read-modify-write cycles.  At best this is
+	 * highly inefficient; at worst it leads to page cache invalidation
+	 * races.  Tell applications to avoid this by reporting the larger write
+	 * alignment in dio_offset_align, and the smaller read alignment in
+	 * dio_read_offset_align.
+	 */
+	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
+	if (xfs_is_cow_inode(ip))
+		stat->dio_offset_align = xfs_inode_alloc_unitsize(ip);
+	else
+		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
 static void
@@ -658,7 +673,7 @@ xfs_vn_getattr(
 		stat->rdev = inode->i_rdev;
 		break;
 	case S_IFREG:
-		if (request_mask & STATX_DIOALIGN)
+		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
 			xfs_report_dioalign(ip, stat);
 		if (request_mask & STATX_WRITE_ATOMIC)
 			xfs_report_atomic_write(ip, stat);
-- 
2.45.2


