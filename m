Return-Path: <linux-fsdevel+bounces-38642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD1DA055EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D80871637F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415381F12E8;
	Wed,  8 Jan 2025 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WgEzzKnL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516FC1A76DA;
	Wed,  8 Jan 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326574; cv=none; b=XTb7mdolGR1E8eqjjo+WcKhQq4AfIW1hC9P8mVet8QYXowF1CHWKUqk6ca/4zZ0DyKeadhv2w8sJXoW6cOp4NlrrC3IXZrU5F0jFxJT09yocpQoC+p6BFs7UFDHmiFA6U1a7B6z7yqkETE7dmyzBoNzLhBPa8SbS2InPjKKCkUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326574; c=relaxed/simple;
	bh=fZaTLFIGGcVPCWB+hdH7Xix8RiGo+dy3J9FIj6hos1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRnG0kyJc5C553kIVeEplE7LYWpyC1byliXKTlcg+xAoLa5tkgWFy6lOajSitmd2BuyP8e6bja48AogUbrHVbgBFNtYm9Vz62aic5Wp+MjHTBweZBW03OjxlU8qawNNBwKv/QFrky+MpvFSFLAtW8cjy4GK0+jS7lNcf4QBeNHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WgEzzKnL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UGXxXoMHvy/IKlTO6pduyxAtO9jC3f0XHea4TioCGEw=; b=WgEzzKnLHRi1O3wstIE0ioGw22
	PVxEVRs4MGhMzE8Z8v999u0/dCwPfLp0a+HefEsuZx/gpUCIrqPVTUv6TAOjYZ2Bh8GU+MOtHlLLe
	Tp9yLnxzHy9SB5YYS81cMub7pYo9O1ch3JBTEase2nR0PI2HGBJCODILRvXPy283cOYF4d6zZqsk8
	zjkQm/Kn1+R44vXX18KN95ikoKDmuxty4QRolBArsHsOhHIYFGn3eQbnk3yqOv2lXHPLgV0CNc8ej
	htaIBf3rVN3mlBDjtV3gS7ci+KgWVyEfNoc0qA3Hwk/CeXxbm7IwTZ2GoLhNJv0DwjpPvIJecDh5f
	AP6aZDKQ==;
Received: from 2a02-8389-2341-5b80-e44b-b36a-6403-8f06.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e44b:b36a:6403:8f06] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRrG-00000007drJ-2k2A;
	Wed, 08 Jan 2025 08:56:11 +0000
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
	linux-xfs@vger.kernel.org
Subject: [PATCH 4/5] xfs: report the correct read/write dio alignment for reflinked inodes
Date: Wed,  8 Jan 2025 09:55:32 +0100
Message-ID: <20250108085549.1296733-5-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250108085549.1296733-1-hch@lst.de>
References: <20250108085549.1296733-1-hch@lst.de>
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


