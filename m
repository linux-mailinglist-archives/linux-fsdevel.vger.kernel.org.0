Return-Path: <linux-fsdevel+bounces-64206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51FFBDCBAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C051921975
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 06:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036130FC1A;
	Wed, 15 Oct 2025 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhXywWnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6D30FF00;
	Wed, 15 Oct 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509670; cv=none; b=exjZNr/J2ksnR8P7kDOG+OUkWNr8Cx3jgh6bcNEGSntoTSaZOdKuf85/rFBywcvQgK6jzHMra5vCcEzybw8H6jw8ZMmTwA6ZpBx1Ys9eRzjG2CMHSCN4czIoTZzAdg4xRJRPNSA39tt3AXEwK1fldCkHxP5y1PaEYFQu/1tLbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509670; c=relaxed/simple;
	bh=NmcytVf+oWV0CX09tfvNS19w3ctSosk2IiTPf1EvbZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joXljllj/+YkO3L4mhqMtFKK68jXqpuVQGi8yoBFVRyfZ1dFSDXtVptQRBfMhISKvqSDZ8olci7+RnV9Rpfvtzgs7v/xn76d/dIXRsKJDpzN7D7V2Ak7M7uEx7mT6TastoUi2OegQ1y2tHEu9Ai2M8x0Er6gyXTNNs8D/uJIkOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YhXywWnl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2S6yrGSJzKiMajpaUI8vM4I6Sy7cVl721scCL8BqWLo=; b=YhXywWnlybvD+Q4MLlpCLaT2LP
	/4L8CGInDcz5hr848E1WMd9H5DoE5e4cJpQrERMBQbwMgatFu9AUs8KZ0jl1uAK/sY7vzZnReOlgQ
	NpEeLSEu4gUUOqmQfv/n6Otc7zAlh89rp8SZK0cdKAR5ZsC/8N6m80FjwQzXbR0TWv6S6BQsL/Dhw
	abVa4UcKzedtqqvuERs+eK1dSpWNcltYWGgaJsofQdtLFgyqL19+Iv8zb1kXeHGiYzXBT3DvTz/ep
	zeP7mdQBBN7l6P3PjCjrCw+DHgI2kVyD4cu8jkVI73Rs14Yuvq9cg19lSeJhlYcvoAyZvF75EltCL
	ce1xgY1w==;
Received: from [38.87.93.141] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8uzC-00000000bFA-2wTR;
	Wed, 15 Oct 2025 06:27:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	willy@infradead.org,
	dlemoal@kernel.org,
	hans.holmberg@wdc.com,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 3/3] xfs: set s_min_writeback_pages for zoned file systems
Date: Wed, 15 Oct 2025 15:27:16 +0900
Message-ID: <20251015062728.60104-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251015062728.60104-1-hch@lst.de>
References: <20251015062728.60104-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Set s_min_writeback_pages to the zone size, so that writeback always
writes up to a full zone.  This ensures that writeback does not add
spurious file fragmentation when writing back a large number of
files that are larger than the zone size.

Fixes: 4e4d52075577 ("xfs: add the zoned space allocator")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_zone_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 1147bacb2da8..0f4e460fd3ea 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1215,6 +1215,7 @@ xfs_mount_zones(
 		.mp		= mp,
 	};
 	struct xfs_buftarg	*bt = mp->m_rtdev_targp;
+	xfs_extlen_t		zone_blocks = mp->m_groups[XG_TYPE_RTG].blocks;
 	int			error;
 
 	if (!bt) {
@@ -1245,10 +1246,12 @@ xfs_mount_zones(
 		return -ENOMEM;
 
 	xfs_info(mp, "%u zones of %u blocks (%u max open zones)",
-		 mp->m_sb.sb_rgcount, mp->m_groups[XG_TYPE_RTG].blocks,
-		 mp->m_max_open_zones);
+		 mp->m_sb.sb_rgcount, zone_blocks, mp->m_max_open_zones);
 	trace_xfs_zones_mount(mp);
 
+	mp->m_super->s_min_writeback_pages =
+		XFS_FSB_TO_B(mp, zone_blocks) >> PAGE_SHIFT;
+
 	if (bdev_is_zoned(bt->bt_bdev)) {
 		error = blkdev_report_zones(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
-- 
2.47.3


