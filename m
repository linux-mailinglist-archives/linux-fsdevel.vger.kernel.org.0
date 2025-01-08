Return-Path: <linux-fsdevel+bounces-38641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E87A055E9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 09:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD49918883E6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 08:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B241F1936;
	Wed,  8 Jan 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B75GCB7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47B91E9B2B;
	Wed,  8 Jan 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736326570; cv=none; b=hizPt3YfG9PliDLxeoSYkWG7Oa9hpBw0Mk2rRP2wACvBD/tbH6nbt9mucY5DIoUCGLO/gETGoNpmqpPwNwdDwmPFwmR8eDalhq3ag0AJE1/Q0IURI+GFnZsWA4agDcWCzolwYe4Ud80kQkKIJrEFJ3SLepQsPvvZLslNj4zDhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736326570; c=relaxed/simple;
	bh=PLI1iug43MUXqNNQ82z7bxdQD4bPaH0qBo6qY8dXECI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3eoMDDp1FzK2YKMmrjx/QSbJHsynV2CTnNisbGfQ5okHhGCTKFCD2bZZk/dYjPC80SVLgMjNScrwko6A9Ce0t1zytotstOvQsvxsBYy1jwrWxI40JMox/NYQuWnhrc3AGkLsGIT9bReDh3E1XRPa92Q9IIvwR7mKKHRpOab2Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B75GCB7h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Dft7MIy23CyEG2PquDs0+TgqwlRHRiq4fSjhQ9dPiIc=; b=B75GCB7hajsN3D8TKOdQQ5zboR
	LbZXLZPZW2ao+V/XfZ91eWaYPqsb40Idfjlr3uAG4aW3wAYylJ1iENT/bhUI2gkwRirehaSc3/hID
	OT1uFyvuS7ApTxV0Eeu02/u8whC0lWyG4Z3VJ2P+HuZR0SX0cpk8WHyjLhens5YDaRIg6oxGO/9I7
	ngc/I1Qq8tc6QGRCCZKGhla4Z62RSt5So1E+g1HUFvZNtYbkvKVxnR5WyUUtGjdW/fQ7yqQmBR+LA
	MbqaNSC2rf4wRjY2Hk4QLdVMy1g7D1QIKBZvUrBLoEK6zWPA9m7w/440yFnA1QSpNKySBvLbu3Nxt
	Z7yVduEA==;
Received: from 2a02-8389-2341-5b80-e44b-b36a-6403-8f06.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e44b:b36a:6403:8f06] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tVRrC-00000007dqM-12yc;
	Wed, 08 Jan 2025 08:56:07 +0000
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
Date: Wed,  8 Jan 2025 09:55:31 +0100
Message-ID: <20250108085549.1296733-4-hch@lst.de>
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


