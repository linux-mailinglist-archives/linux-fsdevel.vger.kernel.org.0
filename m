Return-Path: <linux-fsdevel+bounces-27524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BB8961E08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D4A9284BD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBDA14B942;
	Wed, 28 Aug 2024 05:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y5hcTLou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D514AD02;
	Wed, 28 Aug 2024 05:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821932; cv=none; b=YtxzvykIVqevK6TGUJuE/saAf9Vdhcy9LTOZ4lESbwfr+LkOgocqiI9uo82q7RRLgJxiD3rDUdxudJc6vunujgpxhdaM9jpCyCCdPIejqXwmkWu28PkVEFeW6mhI8KMS/1n/+Fx4ZRuK52G2TDPu3JvkO1fPMDTJMe9a5tlhnQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821932; c=relaxed/simple;
	bh=Dq9ZMtvcwmpybYTzxLknCdSp9cbIjU0DMI6dO9xpBPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2QDAEm/BhF1w9sTLwgmWwsxqPfR/OAA7jHnyJq7TFfxIqj0tSwmDpqWEuF0HXDoj0QrAsSL4292VoBmdQ6wsra5OBZddrHduF2sAPErg/jmuXxnEI3L58MWTGW725X+YJ38cCdvj0clkNAuMLTmm40GnUlJ1kSX0lHOBpYQnvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y5hcTLou; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qMWulCc75ggbPFFFOIwGcFhC7CEy0JsG+s0/Mq8Ahjk=; b=Y5hcTLouWeIWBIK1g3JnieoAQf
	0vMebHya0bdrxRkwInKg5Es8P1IiqvnOeIVjMwsGQnNIoF1fBzt2vhk9M7wPaZtqODy6M26j0BIw1
	bvnmPs0yGwst2mHXOHLdsOVtnC4fQY3dW1CYaA5o5P4D5KHLyJNqExHwP6HcYjVCcZjBjwooEVQ6Z
	y+mEeD/tPqYLjG9hXjIBPJTJkuRuxJXTi/edrMY2LQ6t7TL3r8bpKtvfQ6GdrS0+OiNFhDToqm2dK
	4kaERhedFPXdgCyceQijWZWuO+ain02wZboHdet6PFWq8kKaNQZbvNYFy0sIgCyUyiel31oMK2Fk7
	cInMSnVA==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAyW-0000000DsIM-3rcu;
	Wed, 28 Aug 2024 05:12:09 +0000
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
Subject: [PATCH 3/3] xfs: report the correct read/write dio alignment for reflinked inodes
Date: Wed, 28 Aug 2024 08:11:03 +0300
Message-ID: <20240828051149.1897291-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240828051149.1897291-1-hch@lst.de>
References: <20240828051149.1897291-1-hch@lst.de>
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
---
 fs/xfs/xfs_iops.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1cdc8034f54d93..de2fc12688dc23 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -570,6 +570,33 @@ xfs_stat_blksize(
 	return PAGE_SIZE;
 }
 
+static void
+xfs_report_dioalign(
+	struct xfs_inode	*ip,
+	struct kstat		*stat)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+
+	stat->result_mask |= STATX_DIOALIGN | STATX_DIO_READ_ALIGN;
+	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+	stat->dio_read_offset_align = bdev_logical_block_size(bdev);
+
+	/*
+	 * On COW inodes we are forced to always rewrite an entire file system
+	 * block.
+	 *
+	 * Because applications assume they can do sector sized direct writes
+	 * on XFS we provide an emulation by doing a read-modify-write cycle
+	 * through the cache, but that is highly inefficient.  Thus report the
+	 * natively supported size here.
+	 */
+	if (xfs_is_cow_inode(ip))
+		stat->dio_offset_align = ip->i_mount->m_sb.sb_blocksize;
+	else
+		stat->dio_offset_align = stat->dio_read_offset_align;
+}
+
 STATIC int
 xfs_vn_getattr(
 	struct mnt_idmap	*idmap,
@@ -635,14 +662,8 @@ xfs_vn_getattr(
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
+		if (request_mask & (STATX_DIOALIGN | STATX_DIO_READ_ALIGN))
+			xfs_report_dioalign(ip, stat);
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
-- 
2.43.0


