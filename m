Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FA6512098
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiD0QHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbiD0QHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:07:06 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E8F3D280E
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:15 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160309euoutp02670cb1d5f9bcc42e670f6da26cdc7e6c~pzFGSWH2L1441914419euoutp026
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220427160309euoutp02670cb1d5f9bcc42e670f6da26cdc7e6c~pzFGSWH2L1441914419euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075389;
        bh=6KheWDMJayGgUZm5cX5ypXhrxLVS/z/lNlxWvV+S3gU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oKOOQqTnkgA+xeL9Ueo04TncfX7Jj0pgrtxJ+dsDvidU5zp4F1u/lfQok9JQZ4C0y
         F3vWHpa9oZGTkPzDl6FVIFs/Sg3By261hHNiSR/LR+HrH/0/EwNPPNC2hfsAIab3FK
         7RD4s6RpeXAoeTV1XdTvWOWV7lMsFZVdKsnrb+Dk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160307eucas1p20ea3feb33adf91cfc3dd4f8fbf324a82~pzFE2r7sG0614706147eucas1p2s;
        Wed, 27 Apr 2022 16:03:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FD.D7.10009.B3969626; Wed, 27
        Apr 2022 17:03:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427160306eucas1p10514a8597007ed9d5e269d659df58d35~pzFENQHEv2685626856eucas1p1q;
        Wed, 27 Apr 2022 16:03:06 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427160306eusmtrp1bd41f0ccc94ff2757a2c5d1040c9a38c~pzFEMD4Fz2142221422eusmtrp1C;
        Wed, 27 Apr 2022 16:03:06 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-85-6269693b25f4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C8.81.09522.A3969626; Wed, 27
        Apr 2022 17:03:06 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160306eusmtip12de3b05594fbd8d62abc7abc3a75390e~pzFDyTcRQ0836008360eusmtip1j;
        Wed, 27 Apr 2022 16:03:06 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     jaegeuk@kernel.org, axboe@kernel.dk, snitzer@kernel.org,
        hch@lst.de, mcgrof@kernel.org, naohiro.aota@wdc.com,
        sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 10/16] btrfs: zoned: use btrfs zone helpers to support non
 po2 zoned devices
Date:   Wed, 27 Apr 2022 18:02:49 +0200
Message-Id: <20220427160255.300418-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGc+69vb10KVwKCQctYXRbomyDdZvzZGzKFpbdDYwz6TZjtknF
        y8eEIq0w2TIpUMns+GhBNykyO4QNaUORVl35smIQELvWFhwQkaHAAk5wxUUJSEa9mPnf8z7n
        95znvMmhcJGZXEdlKA6wSoU8U0IKiHOXF10vx2Vk7Hll7O9wZLlyGUemsQoS/XBvEUcDx5wY
        qqw4zkdLTheOOudqeMj9sBBDIw47hk6bejA0aTHgqNRxj0CPtDdXPc0EjpYnpKiy+zpAU0MG
        DHWOvog8txv5yFP3Puro7CeQt+0EiU7+MsVHupJ/cTSsmwJI32vloYUGDR8135knUN/o+vgI
        xjuYyKz0mUlGXzzHZ1w3zxCM15nLtDYdIZmf1cdwxlpfwLQbFzCmfURNMmXFcyRjPzzOY+a7
        hkim3NYEGIttiGB01jO8j0S7BG/tZTMz8lhl7JZkQbqmrou337Hv4NFRM6YGSzu1IICC9Ouw
        vv0CrgUCSkQ3Ajimm+Nxw30A3aaHBDcsAKjxtmBPIo67NTy/FtG/AtjqYzk9A6Cz6G0toCiS
        joaFR/j+bCg9DKC+xZ8VUDg9i0O37Y/HF4XQX8Cp2iHCHyDoF6D7SpDfFtJx0H5rmcd1RcJq
        zwO+HwlY9XW+nRwSDPurJwm/xleR4rM1jzeA9GkB9NV6eX4e0glwcV7GXRMCZ3ttfE6L4UBV
        KcHpb+DU8NJaVgNghd1Cctk4WH410y9xeiO0tMVy+DvwztUSgiMC4fDdYO4FgbDy3I84Zwvh
        dyUijpZA++LkWimE3qITa6UMvDFRxdeBKMNTuxie2sXwf68R4E0gjM1VZaWxKqmC/SpGJc9S
        5SrSYlKys1rB6oceWOn1/QZqZ/+J6QYYBboBpHBJqPB+e/oekXCvPP9rVpm9W5mbyaq6wXqK
        kIQJUzJa5CI6TX6A3cey+1nlk1OMClinxqKStun6O/KWtCPTn17T3ZIddCUX6DYE7vDNfPIZ
        Yxyc1UfsDn0jPxw8c+H3ZxNU5pqezawx0jt9ciU+Yvjac9FnO0PsxuaQnq43xZtKq8Vlyc8n
        /bTJZTF0NzY88F2SRZWOx3/7rql5a9LhLy8O2vTuqsICa2qB4fwhTckgXlteIzWXlbEt4x1t
        /LjvZcGbNwQEwdRQlHOqZzq1frkh8IPivkeKyonEBMPFSHFsuIfAbod9KN3aJnx1u1l2vc8T
        afvz/C5z73uz1pTsvJxTwTJ70cZ8U1DWjqM5h1SURf3aPJhviP/YFil13Ej8q+rzlxwp6qIt
        zuPiS4r0mcnoOmephFCly6XRuFIl/w89yuAdPwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xu7pWmZlJBo2ftS3WnzrGbLH6bj+b
        xbQPP5ktTk89y2QxqX8Gu8Xvs+eZLfa+m81qceFHI5PFzQM7mSxWrj7KZPFk/Sxmi54DH1gs
        /nbdA4q1PGS2+PPQ0GLSoWuMFk+vzmKy2HtL2+LS4xXsFpcWuVvs2XuSxeLyrjlsFvOXPWW3
        mND2ldnixoSnjBYTj29mtfi8tIXdYt3r9ywWJ25JO8h6XL7i7fHvxBo2j4nN79g9zt/byOJx
        +Wypx6ZVnWweCxumMntsXlLvsXvBZyaP3Tcb2Dx6m9+xeexsvc/q8X7fVTaPvi2rGD3Wb7nK
        4jFh80bWAKEoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQi
        fbsEvYyWRftYCw5kV0y5tYapgfF3RBcjJ4eEgInEgbezWbsYuTiEBJYyShyd85QZIiEhcXth
        EyOELSzx51oXG4gtJPCcUWJdo1IXIwcHm4CWRGMnO0iviMATRon7Px+zgDjMAg0sErcm7mIC
        aRAWiJF4u3wqM0gDi4CqxIVT/CBhXgFriZ2P/rBCzJeXmHnpOztICSdQfMKnCIhVVhLdi26x
        QpQLSpyc+YQFxGYGKm/eOpt5AqPALCSpWUhSCxiZVjGKpJYW56bnFhvqFSfmFpfmpesl5+du
        YgSmk23Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeL/szkgS4k1JrKxKLcqPLyrNSS0+xGgKdPVE
        ZinR5HxgQssriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamCSTFe/
        LV+s919hMk8H83Jz2Q/PlHkM82U9Dt5YKrCg6/ZvF7vLswzF7uy6Vvq/rHGh5kbmZYpvvvtb
        9CvontrGnCUhc+Ny5OtZbfNVW4rKODsnij2SN3fbU/Ev1/3+9L+iPRMerVhz8vYrpuvxSm6r
        Jru8eHTXiyl8xeeW46vKqi358haJ2gaW7/k4x0pDJXx2tmDaK/Xrs+XSJCMCdmkv69lScfoX
        f9arWge1vd7fKvY9PpL/ScPG+9Jie5YNB49eVmaytz0eJvr50J/T0ntlOf5OOPPhBcNS85yd
        W0LjitZeXH92pt88D9NF3dEPmrlPNTktuxZa4tdXJvnMkVVkbtyllCtH/aW5pU8xfO5WYinO
        SDTUYi4qTgQAfrbHbrADAAA=
X-CMS-MailID: 20220427160306eucas1p10514a8597007ed9d5e269d659df58d35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160306eucas1p10514a8597007ed9d5e269d659df58d35
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160306eucas1p10514a8597007ed9d5e269d659df58d35
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160306eucas1p10514a8597007ed9d5e269d659df58d35@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the generic btrfs zone helpers to calculate zone index, check zone
alignment, round up and round down operations.

The zone_size_shift field is not needed anymore as generic helpers are
used for calculation.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/volumes.c | 24 +++++++++-------
 fs/btrfs/zoned.c   | 72 ++++++++++++++++++++++------------------------
 fs/btrfs/zoned.h   | 12 ++++----
 3 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a8cc736731fd..0c6d1600d8b3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1421,7 +1421,7 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * allocator, because we anyway use/reserve the first two zones
 		 * for superblock logging.
 		 */
-		return ALIGN(start, device->zone_info->zone_size);
+		return btrfs_zoned_roundup(start, device->zone_info->zone_size);
 	default:
 		BUG();
 	}
@@ -1436,7 +1436,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	int ret;
 	bool changed = false;
 
-	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+	ASSERT(btrfs_zoned_is_aligned(*hole_start, zone_size));
 
 	while (*hole_size > 0) {
 		pos = btrfs_find_allocatable_zones(device, *hole_start,
@@ -1573,7 +1573,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	search_start = dev_extent_search_start(device, search_start);
 
 	WARN_ON(device->zone_info &&
-		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+		!btrfs_zoned_is_aligned(num_bytes, device->zone_info->zone_size));
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5131,8 +5131,8 @@ static void init_alloc_chunk_ctl_policy_zoned(
 
 	ctl->max_stripe_size = zone_size;
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
-						 zone_size);
+		ctl->max_chunk_size = btrfs_zoned_rounddown(
+			BTRFS_MAX_DATA_CHUNK_SIZE, zone_size);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		ctl->max_chunk_size = ctl->max_stripe_size;
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -5144,9 +5144,10 @@ static void init_alloc_chunk_ctl_policy_zoned(
 	}
 
 	/* We don't want a chunk larger than 10% of writable space */
-	limit = max(round_down(div_factor(fs_devices->total_rw_bytes, 1),
-			       zone_size),
-		    min_chunk_size);
+	limit = max(
+		btrfs_zoned_rounddown(div_factor(fs_devices->total_rw_bytes, 1),
+				      zone_size),
+		min_chunk_size);
 	ctl->max_chunk_size = min(limit, ctl->max_chunk_size);
 	ctl->dev_extent_min = zone_size * ctl->dev_stripes;
 }
@@ -6725,7 +6726,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc, struct bio *bio,
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical, fs_info->zone_size);
+			u64 zone_start = btrfs_zoned_rounddown(physical,
+							fs_info->zone_size);
 
 			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 		} else {
@@ -8119,8 +8121,8 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 	if (dev->zone_info) {
 		u64 zone_size = dev->zone_info->zone_size;
 
-		if (!IS_ALIGNED(physical_offset, zone_size) ||
-		    !IS_ALIGNED(physical_len, zone_size)) {
+		if (!btrfs_zoned_is_aligned(physical_offset, zone_size) ||
+		    !btrfs_zoned_is_aligned(physical_len, zone_size)) {
 			btrfs_err(fs_info,
 "zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
 				  devid, physical_offset, physical_len);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 8f574a474420..8f3f542e174c 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -177,13 +177,13 @@ static inline u32 sb_zone_number(struct block_device *bdev, int mirror)
 static inline sector_t zone_start_sector(u32 zone_number,
 					 struct block_device *bdev)
 {
-	return (sector_t)zone_number << ilog2(bdev_zone_sectors(bdev));
+	return zone_number * bdev_zone_sectors(bdev);
 }
 
 static inline u64 zone_start_physical(u32 zone_number,
 				      struct btrfs_zoned_device_info *zone_info)
 {
-	return (u64)zone_number << zone_info->zone_size_shift;
+	return zone_number * zone_info->zone_size;
 }
 
 /*
@@ -236,8 +236,8 @@ static int btrfs_get_dev_zones(struct btrfs_device *device, u64 pos,
 	if (zinfo->zone_cache) {
 		unsigned int i;
 
-		ASSERT(IS_ALIGNED(pos, zinfo->zone_size));
-		zno = pos >> zinfo->zone_size_shift;
+		ASSERT(btrfs_zoned_is_aligned(pos, zinfo->zone_size));
+		zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 		/*
 		 * We cannot report zones beyond the zone end. So, it is OK to
 		 * cap *nr_zones to at the end.
@@ -410,9 +410,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 	nr_sectors = bdev_nr_sectors(bdev);
-	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
-	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
-	if (!IS_ALIGNED(nr_sectors, zone_sectors))
+	zone_info->nr_zones = bdev_zone_no(bdev, nr_sectors);
+	if (!btrfs_zoned_is_aligned(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
 	max_active_zones = queue_max_active_zones(queue);
@@ -824,10 +823,8 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret)
 {
 	struct blk_zone zones[BTRFS_NR_SB_LOG_ZONES];
-	sector_t zone_sectors;
 	u32 sb_zone;
 	int ret;
-	u8 zone_sectors_shift;
 	sector_t nr_sectors;
 	u32 nr_zones;
 
@@ -838,12 +835,10 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
 	ASSERT(rw == READ || rw == WRITE);
 
-	zone_sectors = bdev_zone_sectors(bdev);
-	if (!is_power_of_2(zone_sectors))
+	if (!is_power_of_2(bdev_zone_sectors(bdev)))
 		return -EINVAL;
-	zone_sectors_shift = ilog2(zone_sectors);
 	nr_sectors = bdev_nr_sectors(bdev);
-	nr_zones = nr_sectors >> zone_sectors_shift;
+	nr_zones = bdev_zone_no(bdev, nr_sectors);
 
 	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
@@ -960,14 +955,12 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 {
 	sector_t zone_sectors;
 	sector_t nr_sectors;
-	u8 zone_sectors_shift;
 	u32 sb_zone;
 	u32 nr_zones;
 
 	zone_sectors = bdev_zone_sectors(bdev);
-	zone_sectors_shift = ilog2(zone_sectors);
 	nr_sectors = bdev_nr_sectors(bdev);
-	nr_zones = nr_sectors >> zone_sectors_shift;
+	nr_zones = bdev_zone_no(bdev, nr_sectors);
 
 	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
@@ -993,18 +986,17 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 				 u64 hole_end, u64 num_bytes)
 {
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
-	const u8 shift = zinfo->zone_size_shift;
-	u64 nzones = num_bytes >> shift;
+	u64 nzones = bdev_zone_no(device->bdev, num_bytes >> SECTOR_SHIFT);
 	u64 pos = hole_start;
 	u64 begin, end;
 	bool have_sb;
 	int i;
 
-	ASSERT(IS_ALIGNED(hole_start, zinfo->zone_size));
-	ASSERT(IS_ALIGNED(num_bytes, zinfo->zone_size));
+	ASSERT(btrfs_zoned_is_aligned(hole_start, zinfo->zone_size));
+	ASSERT(btrfs_zoned_is_aligned(num_bytes, zinfo->zone_size));
 
 	while (pos < hole_end) {
-		begin = pos >> shift;
+		begin = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 		end = begin + nzones;
 
 		if (end > zinfo->nr_zones)
@@ -1036,8 +1028,9 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 			if (!(pos + num_bytes <= sb_pos ||
 			      sb_pos + BTRFS_SUPER_INFO_SIZE <= pos)) {
 				have_sb = true;
-				pos = ALIGN(sb_pos + BTRFS_SUPER_INFO_SIZE,
-					    zinfo->zone_size);
+				pos = btrfs_zoned_roundup(
+					sb_pos + BTRFS_SUPER_INFO_SIZE,
+					zinfo->zone_size);
 				break;
 			}
 		}
@@ -1051,7 +1044,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 static bool btrfs_dev_set_active_zone(struct btrfs_device *device, u64 pos)
 {
 	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-	unsigned int zno = (pos >> zone_info->zone_size_shift);
+	unsigned int zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 
 	/* We can use any number of zones */
 	if (zone_info->max_active_zones == 0)
@@ -1073,7 +1066,7 @@ static bool btrfs_dev_set_active_zone(struct btrfs_device *device, u64 pos)
 static void btrfs_dev_clear_active_zone(struct btrfs_device *device, u64 pos)
 {
 	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-	unsigned int zno = (pos >> zone_info->zone_size_shift);
+	unsigned int zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 
 	/* We can use any number of zones */
 	if (zone_info->max_active_zones == 0)
@@ -1109,14 +1102,14 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 {
 	struct btrfs_zoned_device_info *zinfo = device->zone_info;
-	const u8 shift = zinfo->zone_size_shift;
-	unsigned long begin = start >> shift;
-	unsigned long end = (start + size) >> shift;
+	unsigned long begin = bdev_zone_no(device->bdev, start >> SECTOR_SHIFT);
+	unsigned long end =
+		bdev_zone_no(device->bdev, (start + size) >> SECTOR_SHIFT);
 	u64 pos;
 	int ret;
 
-	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
-	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
+	ASSERT(btrfs_zoned_is_aligned(start, zinfo->zone_size));
+	ASSERT(btrfs_zoned_is_aligned(size, zinfo->zone_size));
 
 	if (end > zinfo->nr_zones)
 		return -ERANGE;
@@ -1140,8 +1133,9 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 		/* Free regions should be empty */
 		btrfs_warn_in_rcu(
 			device->fs_info,
-		"zoned: resetting device %s (devid %llu) zone %llu for allocation",
-			rcu_str_deref(device->name), device->devid, pos >> shift);
+			"zoned: resetting device %s (devid %llu) zone %u for allocation",
+			rcu_str_deref(device->name), device->devid,
+			bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT));
 		WARN_ON_ONCE(1);
 
 		ret = btrfs_reset_device_zone(device, pos, zinfo->zone_size,
@@ -1238,7 +1232,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return 0;
 
 	/* Sanity check */
-	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+	if (!btrfs_zoned_is_aligned(length, fs_info->zone_size)) {
 		btrfs_err(fs_info,
 		"zoned: block group %llu len %llu unaligned to zone size %llu",
 			  logical, length, fs_info->zone_size);
@@ -1326,7 +1320,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
 		 */
-		WARN_ON(!IS_ALIGNED(physical[i], fs_info->zone_size));
+		WARN_ON(!btrfs_zoned_is_aligned(physical[i], fs_info->zone_size));
 		nofs_flag = memalloc_nofs_save();
 		ret = btrfs_get_dev_zone(device, physical[i], &zone);
 		memalloc_nofs_restore(nofs_flag);
@@ -1352,10 +1346,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		switch (zone.cond) {
 		case BLK_ZONE_COND_OFFLINE:
 		case BLK_ZONE_COND_READONLY:
-			btrfs_err(fs_info,
-		"zoned: offline/readonly zone %llu on device %s (devid %llu)",
-				  physical[i] >> device->zone_info->zone_size_shift,
-				  rcu_str_deref(device->name), device->devid);
+			btrfs_err(
+				fs_info,
+				"zoned: offline/readonly zone %u on device %s (devid %llu)",
+				bdev_zone_no(device->bdev,
+					     physical[i] >> SECTOR_SHIFT),
+				rcu_str_deref(device->name), device->devid);
 			alloc_offsets[i] = WP_MISSING_DEV;
 			break;
 		case BLK_ZONE_COND_EMPTY:
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b9c435961361..c578bdb6bf2f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -23,7 +23,6 @@ struct btrfs_zoned_device_info {
 	 * zoned block device.
 	 */
 	u64 zone_size;
-	u8  zone_size_shift;
 	u32 nr_zones;
 	unsigned int max_active_zones;
 	atomic_t active_zones_left;
@@ -274,7 +273,8 @@ static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 	if (!zone_info)
 		return false;
 
-	return test_bit(pos >> zone_info->zone_size_shift, zone_info->seq_zones);
+	return test_bit(bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT),
+			zone_info->seq_zones);
 }
 
 static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
@@ -284,7 +284,8 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	if (!zone_info)
 		return true;
 
-	return test_bit(pos >> zone_info->zone_size_shift, zone_info->empty_zones);
+	return test_bit(bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT),
+			zone_info->empty_zones);
 }
 
 static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
@@ -296,7 +297,7 @@ static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
 	if (!zone_info)
 		return;
 
-	zno = pos >> zone_info->zone_size_shift;
+	zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 	if (set)
 		set_bit(zno, zone_info->empty_zones);
 	else
@@ -350,7 +351,8 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 		return false;
 
 	zone_size = device->zone_info->zone_size;
-	if (!IS_ALIGNED(physical, zone_size) || !IS_ALIGNED(length, zone_size))
+	if (!btrfs_zoned_is_aligned(physical, zone_size) ||
+	    !btrfs_zoned_is_aligned(length, zone_size))
 		return false;
 
 	return true;
-- 
2.25.1

