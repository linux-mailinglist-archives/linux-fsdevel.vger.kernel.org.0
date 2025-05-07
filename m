Return-Path: <linux-fsdevel+bounces-48376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B345AADE99
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D0F9A7ED6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE5A26A1DD;
	Wed,  7 May 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gG63bfpR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7126A0A8;
	Wed,  7 May 2025 12:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619552; cv=none; b=YBbV+uJhg1sHT5H02gMVaFjzGumNgJhv0AScm51M5I0hjw8MI/T1D/3Sfjayg8Vw8SyulH3lXrvf/KwgCNomf1PdGfWSWDQ6/Ce4LxhnKcMpNi+0YdtHflJb0c1/yT9E53eVnT9XLli5ECASaMKSCCMjNXooVInxk398v7Kf6QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619552; c=relaxed/simple;
	bh=P4j2T0N6c9aCXPqANFu176CcUsl0xifFeDVuIde8mPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oVNdEp2CkeRS6Efy+EIoIpz6Pl97Dybl/GooN9c3dvH4W+I6fp1JWRM60XdpGfream6/3prGSmwfPTWQfuxiZgOs9TXtORH1warDmW0rjMv6xeAgg2k3NDXXgVYFq7cqj9upzQCuVXtoIkq+0B3RDotxtdbpMVSBWcqLUtYGCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gG63bfpR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kNJsjpAR9uVLVTSuO6gd7JTwF0JplTQLOXncYPB/ETg=; b=gG63bfpR/nX6yLGNjYjUfzP3p0
	haJ1WA4AAjUvhUoDRa5ybQdtG3yIAaZW0vUt/qx6ok8K2wCsd5OFNjE2DL3v2+q1bZ0QnlFebgLNd
	4t1CzvcmvMEmLmgSbV+skA3IFXKu1SOdj2bWYpfRL6y26KQdIDU7RR5VRkaxaRl/9SNX7k99F291m
	sGWhDFx9Qt6JqL9w2fRAq2rPduFe+OiYJjo1bTND0bpiNNJ4NReyskBAk8TnlpQKzn2FIU1ZCmE4D
	1uhpJP7heocdCieLazEpT0KGNp8oLKEqX4/99QMYQYMQ4nT0lr3N9bi+yiFliKk23Q1LR/bZd3kwP
	fMuaJ+pQ==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdX4-0000000FJKh-0IHZ;
	Wed, 07 May 2025 12:05:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Coly Li <colyli@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Carlos Maiolino <cem@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <jth@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH 18/19] btrfs: use bdev_rw_virt in scrub_one_super
Date: Wed,  7 May 2025 14:04:42 +0200
Message-ID: <20250507120451.4000627-19-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507120451.4000627-1-hch@lst.de>
References: <20250507120451.4000627-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Replace the code building a bio from a kernel direct map address and
submitting it synchronously with the bdev_rw_virt helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 2c5edcee9450..7bdb2bc0a212 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2770,17 +2770,11 @@ static int scrub_one_super(struct scrub_ctx *sctx, struct btrfs_device *dev,
 			   struct page *page, u64 physical, u64 generation)
 {
 	struct btrfs_fs_info *fs_info = sctx->fs_info;
-	struct bio_vec bvec;
-	struct bio bio;
 	struct btrfs_super_block *sb = page_address(page);
 	int ret;
 
-	bio_init(&bio, dev->bdev, &bvec, 1, REQ_OP_READ);
-	bio.bi_iter.bi_sector = physical >> SECTOR_SHIFT;
-	__bio_add_page(&bio, page, BTRFS_SUPER_INFO_SIZE, 0);
-	ret = submit_bio_wait(&bio);
-	bio_uninit(&bio);
-
+	ret = bdev_rw_virt(dev->bdev, physical >> SECTOR_SHIFT, sb,
+			BTRFS_SUPER_INFO_SIZE, REQ_OP_READ);
 	if (ret < 0)
 		return ret;
 	ret = btrfs_check_super_csum(fs_info, sb);
-- 
2.47.2


