Return-Path: <linux-fsdevel+bounces-38720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5650A07010
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 09:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F091887578
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 08:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE02921518B;
	Thu,  9 Jan 2025 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9RK3+GW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA81E21504D;
	Thu,  9 Jan 2025 08:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411487; cv=none; b=AoD2gvNhk5zwzmYBNlj7XcD/6S5HUB/4doLN1rsQtDHaoFlCyr6KtLu0BEp5x4HL745nIJc59/uZnmesaRfd90gruTsE5uwQExRm8+llAv1AMAP6/Vic3Jsv3Yeez8G2pBPpstXTz53UNc3RRqBrMr0JSvG7MQe6lr6Kh3Gk2n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411487; c=relaxed/simple;
	bh=PLI1iug43MUXqNNQ82z7bxdQD4bPaH0qBo6qY8dXECI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdgqKP98JjsenKlTa4ZttpSZo42wAft2djy/wLnOzKsxTHvSOrP3i9uNEh9xH6146zO3v9WQXMH0f16F6+BAzLrlTbCk+Q5vpIoZaSOqbPN7KvjXQEHa5RkKVGj3YIMq4yitE6mxb1UkmH0FjnXlaN/6S+yMLhj+F9cZFcoiNT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R9RK3+GW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dft7MIy23CyEG2PquDs0+TgqwlRHRiq4fSjhQ9dPiIc=; b=R9RK3+GWZEvjWiI0lgarhU45lq
	C3l3i2Tx6OehydCLS6cF4eZySVLNshlHGkWVva111wrnmRS7h1Dp5lwPAnesY5Gn7chpqopVWKu4h
	UkT1Ef0iKYU8RnT25JnG6MJiHmgWhwXsilFQHGP9+4zPRoLG2CQO/FAIbY1yfaIAkqT4nU2s/gsRj
	BOcAScUX5uclNNqUp1ZprupUP6N6fCoveoGwAaZ06D+JvibQyOWW4c1uPu1/8AFzA0rLsKFPEY20g
	fp+7Z3VegDbJJxyoj5e4ggJOHZx6a78o1oOK3VYzIKyCtTyELGNehjHIFB6EVOgZ+dOYadKsLD7kC
	V0EglbuA==;
Received: from 2a02-8389-2341-5b80-ddeb-cdec-70b9-e2f0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ddeb:cdec:70b9:e2f0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnwp-0000000BBeM-2KLh;
	Thu, 09 Jan 2025 08:31:24 +0000
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
Subject: [PATCH 3/5] xfs: cleanup xfs_vn_getattr
Date: Thu,  9 Jan 2025 09:31:03 +0100
Message-ID: <20250109083109.1441561-4-hch@lst.de>
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

Split the two bits of optional statx reporting into their own helpers
so that they are self-contained instead of deeply indented in the main
getattr handler.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 207e0dadffc3..6b0228a21617 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -573,17 +573,28 @@ xfs_stat_blksize(
 }
 
 static void
-xfs_get_atomic_write_attr(
+xfs_report_dioalign(
 	struct xfs_inode	*ip,
-	unsigned int		*unit_min,
-	unsigned int		*unit_max)
+	struct kstat		*stat)
 {
-	if (!xfs_inode_can_atomicwrite(ip)) {
-		*unit_min = *unit_max = 0;
-		return;
-	}
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	stat->result_mask |= STATX_DIOALIGN;
+	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+	stat->dio_offset_align = bdev_logical_block_size(bdev);
+}
+
+static void
+xfs_report_atomic_write(
+	struct xfs_inode	*ip,
+	struct kstat		*stat)
+{
+	unsigned int		unit_min = 0, unit_max = 0;
+
+	if (xfs_inode_can_atomicwrite(ip))
+		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
 }
 
 STATIC int
@@ -647,22 +658,10 @@ xfs_vn_getattr(
 		stat->rdev = inode->i_rdev;
 		break;
 	case S_IFREG:
-		if (request_mask & STATX_DIOALIGN) {
-			struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-			struct block_device	*bdev = target->bt_bdev;
-
-			stat->result_mask |= STATX_DIOALIGN;
-			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-			stat->dio_offset_align = bdev_logical_block_size(bdev);
-		}
-		if (request_mask & STATX_WRITE_ATOMIC) {
-			unsigned int	unit_min, unit_max;
-
-			xfs_get_atomic_write_attr(ip, &unit_min,
-					&unit_max);
-			generic_fill_statx_atomic_writes(stat,
-					unit_min, unit_max);
-		}
+		if (request_mask & STATX_DIOALIGN)
+			xfs_report_dioalign(ip, stat);
+		if (request_mask & STATX_WRITE_ATOMIC)
+			xfs_report_atomic_write(ip, stat);
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.45.2


