Return-Path: <linux-fsdevel+bounces-38438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7AA028EC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60F83A4FB9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28741547D8;
	Mon,  6 Jan 2025 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FJOJMbeb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708014BF92;
	Mon,  6 Jan 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176589; cv=none; b=SrILy4rbGiFZJAVwsmkmBWihHUOj50CDDsqyAhCsb9DOM+Lrp2/P3b+j5YglapPRtBYHuZxztiYwLWJkDix5f92B4xRuu79UClXpgXUQOwE9P/+Mu2+bpTLcghIEHOy9CS65+p4VA29ynsxupr4OxU7yWTp+QH8pI9kjLN/FyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176589; c=relaxed/simple;
	bh=jq9YGzSycLQVNe9wZfHAMmY+r9VjqCthZQOXjcOtiG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryB/uHmTCX4NnCW/2KAGj1M1zx9WB8xit9RUjueS5K0aLnl3jPRpaGUGv6ZIsEuJEGngLmxqZC4Npzyv991+NFSeGfrK/yL7hM717FA5jjoqAXCZV8GJ4vTzNqmJ63EgHMT+idOa1UP3P12+lJ5qyEGTdKvLjGadN5JP8ljbkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FJOJMbeb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=zmEx+czQp3oQRA3OoEuruo97hs99J4mpPt85r/hCFQ4=; b=FJOJMbebHMT8FhlmQHab4bItBh
	A1ZM41Yi/fXBGjvFykC9lqHOCzG5NAsJqB4zWoxGaGrvCssTsdWhUjG7lqeBh7oHaGYe4+BxAf0R+
	KJ/P4sdLJ9qf/1/nyfX5MuVLpu/mU+48hHCmQfOKwJy8G3YONPfSHvqCETiK+SwKc+CztEb8qN7k9
	uhvrPV/ESw5cDHjdn8dGDOQNE2+0I4U39+4bqbUT/VBtGASCo2AbCu/NqqFuY/yNu8apJ8n+ZusX8
	Te0Vp5KBb7CyCYbVyui7XNdDd2YtmJDggT/1umezJb5wZVpohKSicwA/Id0QmQa4Keh8tmDDJkV9T
	Ri7RMaXQ==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoq3-00000001it9-0ceV;
	Mon, 06 Jan 2025 15:16:19 +0000
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
Subject: [PATCH 3/4] xfs: cleanup xfs_vn_getattr
Date: Mon,  6 Jan 2025 16:15:56 +0100
Message-ID: <20250106151607.954940-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106151607.954940-1-hch@lst.de>
References: <20250106151607.954940-1-hch@lst.de>
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


