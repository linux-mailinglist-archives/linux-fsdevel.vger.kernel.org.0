Return-Path: <linux-fsdevel+bounces-64410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8574BE63C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 05:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBA462177C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 03:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3112FC004;
	Fri, 17 Oct 2025 03:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L6ZRrXUs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5562F9DA4;
	Fri, 17 Oct 2025 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760672797; cv=none; b=IBcI3EULfyeQaycZKTuohbASHJPFCy+/1vF33lH6FTtRHcUnst0S9tXyieIR0Yv3T81JqEZWr8J0UBk0vl/JeGVMGj7hlD+jqZTJi6HOLSVBp6laxfXErBFWzF5RRG6at6CypTIGfrKVvbDDojbsLHytbWOVkariraF3XE4o/HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760672797; c=relaxed/simple;
	bh=zmzzUhCQMbc4fhRj8NTSf5G6gkLvbItyq/kuJi7D2Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bmvh+eneAp3Z/quULOANKMG08S8SAMGgttmTbUIXNfQYoYx/DnLeXiCLWNAFiXx2essbK2SHloXzlzqkrVMHY0DryX8LERDyRTzOxfST6vqC1pbNSutJRJFlpQ/e5yqUbkHbOfaDVx9uATcfah+jn795L9KmkxxQ1r7MBPzSLRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L6ZRrXUs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OzhIS791DbWw/BkeeiAXVxsk/8OZmh8JD9FoPLYpoC4=; b=L6ZRrXUsGgGd6cwNkJ2KANK2wb
	ls0BUyl6KmamfjFMchiK3B0qzIvIWTHtiuoK5pUlLP9AbOHrFlSCeoB4NuNHr6eAKbTV5gLRWKOgL
	lJrw0i+C30z61rABpx7J4iBsaDku9jsb6HGieq4SckKhm998/z41jlbDE8OlAaimIhz3sE9pIqA7n
	y5+94uX2OECUs0PDzwSzlx0sMqhfDV6eObfKm4imcPOETfF2FWwyuNLOznDhmK1VKYi3Gv+YoDyxO
	4AP4k/wBtb81x2AJOvIpYCe2ZBlw7rRdfD1rzm1aqp9PWpOPdTuLgnYjc9+C/EIx4v8h1TcEVCpJc
	BpRDFYOw==;
Received: from 5-226-109-134.static.ip.netia.com.pl ([5.226.109.134] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9bQI-00000006U0W-2Y9j;
	Fri, 17 Oct 2025 03:46:34 +0000
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
	linux-xfs@vger.kernel.org,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 3/3] xfs: set s_min_writeback_pages for zoned file systems
Date: Fri, 17 Oct 2025 05:45:49 +0200
Message-ID: <20251017034611.651385-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017034611.651385-1-hch@lst.de>
References: <20251017034611.651385-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_zone_alloc.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index 1147bacb2da8..c342595acc3e 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1215,6 +1215,7 @@ xfs_mount_zones(
 		.mp		= mp,
 	};
 	struct xfs_buftarg	*bt = mp->m_rtdev_targp;
+	xfs_extlen_t		zone_blocks = mp->m_groups[XG_TYPE_RTG].blocks;
 	int			error;
 
 	if (!bt) {
@@ -1245,10 +1246,33 @@ xfs_mount_zones(
 		return -ENOMEM;
 
 	xfs_info(mp, "%u zones of %u blocks (%u max open zones)",
-		 mp->m_sb.sb_rgcount, mp->m_groups[XG_TYPE_RTG].blocks,
-		 mp->m_max_open_zones);
+		 mp->m_sb.sb_rgcount, zone_blocks, mp->m_max_open_zones);
 	trace_xfs_zones_mount(mp);
 
+	/*
+	 * The writeback code switches between inodes regularly to provide
+	 * fairness.  The default lower bound is 4MiB, but for zoned file
+	 * systems we want to increase that both to reduce seeks, but also more
+	 * importantly so that workloads that writes files in a multiple of the
+	 * zone size do not get fragmented and require garbage collection when
+	 * they shouldn't.  Increase is to the zone size capped by the max
+	 * extent len.
+	 *
+	 * Note that because s_min_writeback_pages is a superblock field, this
+	 * value also get applied to non-zoned files on the data device if
+	 * there are any.  On typical zoned setup all data is on the RT device
+	 * because using the more efficient sequential write required zones
+	 * is the reason for using the zone allocator, and either the RT device
+	 * and the (meta)data device are on the same block device, or the
+	 * (meta)data device is on a fast SSD while the data on the RT device
+	 * is on a SMR HDD.  In any combination of the above cases enforcing
+	 * the higher min_writeback_pages for non-RT inodes is either a noop
+	 * or beneficial.
+	 */
+	mp->m_super->s_min_writeback_pages =
+		XFS_FSB_TO_B(mp, min(zone_blocks, XFS_MAX_BMBT_EXTLEN)) >>
+			PAGE_SHIFT;
+
 	if (bdev_is_zoned(bt->bt_bdev)) {
 		error = blkdev_report_zones(bt->bt_bdev,
 				XFS_FSB_TO_BB(mp, mp->m_sb.sb_rtstart),
-- 
2.47.3


