Return-Path: <linux-fsdevel+bounces-8523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94DD838A9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4890E1F24B87
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 09:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAC95D752;
	Tue, 23 Jan 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kNZ0ZDik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065C5C60C;
	Tue, 23 Jan 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003045; cv=none; b=o2qzjE28k+V1w1CbgfTu7v3csmGJ23AS4jJCmlp6tciLAZpLLIFqaec8nTexuFrJasP3f40MBmHUFXRWdjtEju4ZpQpRvwK+GL8H3QD9+hkcC9pleJGm9EfKq6fw30qKQpNLqMLPVqiFbVnWh2gWkeQwGHLKkqbjkk6FIq85QeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003045; c=relaxed/simple;
	bh=MadywNv3PPpA8atuGcDj3Vd17mnoG/ezGAm6iZoKSro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ukQEt9vacRp6sSVQYLeZVO5yYUvbhAEngbPip/Eqq5/xVLRk7/NNEatV90INg3p98X2mGsujZyvuyrhG4XsQe6gWcl6hR9z65c1QtYymy0BUxT6mKvyUW1p/prZwvozfDiCSMtkDi7QFgapu9n1BS9fFZBbBx4GNZfkBeCjMdSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kNZ0ZDik; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706003044; x=1737539044;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=MadywNv3PPpA8atuGcDj3Vd17mnoG/ezGAm6iZoKSro=;
  b=kNZ0ZDikt43HqUzEIc2BqXYd4Is/Mdn3tuANdr1sz4Uz1B4vlJ9IQ3Yk
   L9h8oHEkusbdwX6T2n9X7hma/GAwcAa49JsTeqjyxTO646hpTpOSknU1n
   4TZoc0+BZwJmFE+gXtie+B/Ndza1vgxSvgRpiVK9p5R3LaW7g9/ufFZrQ
   spxIF26JpLcs3PvS0apEoaHpNfliwUftZveTxSwNAO86dIxl5Ozb9BSNW
   EjsGiJ/TZBcfTSNYDjnt89SXo+O5L5KjZNWpAA9nSlmF3uq5On5BggWiG
   gIzWa7wEKu6PnvSXxqZX0WPhUiuDRQJmDoU6k9Sdq9L+vggoQjIN8VAwq
   A==;
X-CSE-ConnectionGUID: Y0DbYVcHRG+U+LyayKzudw==
X-CSE-MsgGUID: yfg25ablSRSBPudDxtvc0Q==
X-IronPort-AV: E=Sophos;i="6.05,214,1701100800"; 
   d="scan'208";a="7514663"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2024 17:44:02 +0800
IronPort-SDR: M/PstV4BTWaUFLg4/dvAdmu4Upifxdfk2XIvxcNz2hRh6aqCOh+ZEsD7RsiZOeqwxRyeIIr1aJ
 Qp1C13nthedQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2024 00:54:04 -0800
IronPort-SDR: 7xViEHS0YVoU8QIBSZlE2HNgQcFT3xfQ37Zri4MllgAiZa3c0o68mcJ0f96h/q8NdnY3wFm02f
 wGbJDLOULVdw==
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Jan 2024 01:43:58 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 23 Jan 2024 01:43:44 -0800
Subject: [PATCH 3/5] btrfs: zoned: call blkdev_zone_mgmt in nofs scope
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-zonefs_nofs-v1-3-cc0b0308ef25@wdc.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
In-Reply-To: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, 
 Naohiro Aota <naohiro.aota@wdc.com>, Mike Snitzer <snitzer@kernel.org>, 
 dm-devel@lists.linux.dev, Chris Mason <clm@fb.com>, 
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706003027; l=3714;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=MadywNv3PPpA8atuGcDj3Vd17mnoG/ezGAm6iZoKSro=;
 b=jPU1qJgKMZ/i7HaHjlom8VTdj+Lx2qczH6TOXRim9mYZ5nEhblVM5XvcT7furce1UQ/gp5Wif
 ATsugvKlk0ZDra9L5KrCXBHheheUpRSNG72vZtsTjnurB7EKtxGltU1
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Add a memalloc_nofs scope around all calls to blkdev_zone_mgmt(). This
allows us to further get rid of the GFP_NOFS argument for
blkdev_zone_mgmt().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/zoned.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 168af9d000d1..05640d61e435 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -824,11 +824,15 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 			reset = &zones[1];
 
 		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
+			unsigned int nofs_flags;
+
 			ASSERT(sb_zone_is_full(reset));
 
+			nofs_flags = memalloc_nofs_save();
 			ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
 					       reset->start, reset->len,
-					       GFP_NOFS);
+					       GFP_KERNEL);
+			memalloc_nofs_restore(nofs_flags);
 			if (ret)
 				return ret;
 
@@ -974,11 +978,14 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 			 * explicit ZONE_FINISH is not necessary.
 			 */
 			if (zone->wp != zone->start + zone->capacity) {
+				unsigned int nofs_flags;
 				int ret;
 
+				nofs_flags = memalloc_nofs_save();
 				ret = blkdev_zone_mgmt(device->bdev,
 						REQ_OP_ZONE_FINISH, zone->start,
-						zone->len, GFP_NOFS);
+						zone->len, GFP_KERNEL);
+				memalloc_nofs_restore(nofs_flags);
 				if (ret)
 					return ret;
 			}
@@ -996,11 +1003,13 @@ int btrfs_advance_sb_log(struct btrfs_device *device, int mirror)
 
 int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 {
+	unsigned int nofs_flags;
 	sector_t zone_sectors;
 	sector_t nr_sectors;
 	u8 zone_sectors_shift;
 	u32 sb_zone;
 	u32 nr_zones;
+	int ret;
 
 	zone_sectors = bdev_zone_sectors(bdev);
 	zone_sectors_shift = ilog2(zone_sectors);
@@ -1011,9 +1020,13 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-	return blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
-				zone_start_sector(sb_zone, bdev),
-				zone_sectors * BTRFS_NR_SB_LOG_ZONES, GFP_NOFS);
+	nofs_flags = memalloc_nofs_save();
+	ret = blkdev_zone_mgmt(bdev, REQ_OP_ZONE_RESET,
+			       zone_start_sector(sb_zone, bdev),
+			       zone_sectors * BTRFS_NR_SB_LOG_ZONES,
+			       GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flags);
+	return ret;
 }
 
 /*
@@ -1124,12 +1137,15 @@ static void btrfs_dev_clear_active_zone(struct btrfs_device *device, u64 pos)
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes)
 {
+	unsigned int nofs_flags;
 	int ret;
 
 	*bytes = 0;
+	nofs_flags = memalloc_nofs_save();
 	ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET,
 			       physical >> SECTOR_SHIFT, length >> SECTOR_SHIFT,
-			       GFP_NOFS);
+			       GFP_KERNEL);
+	memalloc_nofs_restore(nofs_flags);
 	if (ret)
 		return ret;
 
@@ -2234,14 +2250,17 @@ static int do_zone_finish(struct btrfs_block_group *block_group, bool fully_writ
 		struct btrfs_device *device = map->stripes[i].dev;
 		const u64 physical = map->stripes[i].physical;
 		struct btrfs_zoned_device_info *zinfo = device->zone_info;
+		unsigned int nofs_flags;
 
 		if (zinfo->max_active_zones == 0)
 			continue;
 
+		nofs_flags = memalloc_nofs_save();
 		ret = blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_FINISH,
 				       physical >> SECTOR_SHIFT,
 				       zinfo->zone_size >> SECTOR_SHIFT,
-				       GFP_NOFS);
+				       GFP_KERNEL);
+		memalloc_nofs_restore(nofs_flags);
 
 		if (ret)
 			return ret;

-- 
2.43.0


