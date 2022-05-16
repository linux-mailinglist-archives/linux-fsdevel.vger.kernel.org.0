Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94857528B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344032AbiEPQzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343952AbiEPQyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CD13C73E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:33 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165430euoutp01ac372e64cac5a3aeef572c28c56e5d45~vpCW6g1ux2241022410euoutp01_
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165430euoutp01ac372e64cac5a3aeef572c28c56e5d45~vpCW6g1ux2241022410euoutp01_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720070;
        bh=v9pKtSXVKfv3MO12A+XlAy96VR3If9OGCSyPe0WYtqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJyUg3Xx7d/T05JlQboNVpDnuD2C0HyQC4NZQ9nteyVg+/0/W8f3WysP3dg4guis/
         rAFPDeaJu/pmznm1jOkRI/pVT2vITqtKA5ZG29QKrS3/gY4O/6i3ZSJZfBi9NTLKsx
         e4eBs4VwWmxLp0AXVwvdEWsnGWOKahfp0o3eD7Fw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165428eucas1p22c7c8955b8a9ceced9cab91a9c65ceaa~vpCViJXK00201202012eucas1p2M;
        Mon, 16 May 2022 16:54:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.4A.09887.4C182826; Mon, 16
        May 2022 17:54:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce~vpCVM0dkm0955109551eucas1p1q;
        Mon, 16 May 2022 16:54:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165428eusmtrp2e56d4a6f4333117d0ef788ccef02efe7~vpCVMGoNz1030710307eusmtrp2v;
        Mon, 16 May 2022 16:54:28 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-3b-628281c4732b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 2F.00.09404.4C182826; Mon, 16
        May 2022 17:54:28 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165427eusmtip26b6dcee5944cdacbd76773df89c38a05~vpCU2E_4h0611206112eusmtip24;
        Mon, 16 May 2022 16:54:27 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 07/13] btrfs: zoned: use generic btrfs zone helpers to
 support npo2 zoned devices
Date:   Mon, 16 May 2022 18:54:10 +0200
Message-Id: <20220516165416.171196-8-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7pHGpuSDN50alqsvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJouVq48yWfQc+MBisfeWtsWlxyvYLfbsPclicXnXHDaL+cueslvc
        mPCU0eLz0hZ2izU3n7I48Hv8O7GGzWPnrLvsHpfPlnpsWtXJ5rF5Sb3H7psNQOHW+6we7/dd
        ZfPo27KK0WP9lqssHp83yQVwR3HZpKTmZJalFunbJXBlTF/SyVxwtKLi88tv7A2MV5O7GDk5
        JARMJD4d2sbUxcjFISSwglFi6blX7CAJIYEvjBKXvhdC2J8ZJS43ssI0HDv/gQ2iYTmjxL//
        rSwQznNGid4Ts4EcDg42AS2Jxk6wQSICWRLTTjxkBKlhFljMJLFyz2QWkISwQJrEtOfTwGwW
        AVWJtiNn2EBsXgEriUv/zrBDbJOXmHnpOzvITE4Ba4nVXdwQJYISJ2c+AWtlBipp3jqbGWS+
        hMBsTolDUzuZIHpdJFZfOQ5lC0u8Or4FaqaMxP+d86Hi1RJPb/yGam5hlOjfuZ4NZJkE0LK+
        MzkgJrOApsT6XfoQ5Y4SMx7vZYWo4JO48VYQ4gQ+iUnbpjNDhHklOtqEIKqVJHb+fAK1VELi
        ctMcFgjbQ2JW632mCYyKs5A8MwvJM7MQ9i5gZF7FKJ5aWpybnlpslJdarlecmFtcmpeul5yf
        u4kRmOpO/zv+ZQfj8lcf9Q4xMnEwHmKU4GBWEuE1qGhIEuJNSaysSi3Kjy8qzUktPsQozcGi
        JM6bnLkhUUggPbEkNTs1tSC1CCbLxMEp1cAkn2+TEzDr6wL96UFpSaX/wpWEKw9dXed8fomy
        T1Hz8zl8r5obeQr+i66ZJbvRV3NWiPF5Hktrrc3r2g5oVi5iefT57WcNg+rVb4I3lexViH2+
        6uhxE1Gt8/3pL2pmf1Rfrj4jxV3pRO1cV54v5/r2tVsYyB9lOtk6pZnFb0LTxD/9PmZyxydP
        lbo6IWZz7uIQbolPaWJREjF9EWaX7e2Ulq+5Hsb5Qrdu9rpw54m1isZOXN5HPqycoCz72UZw
        UYUa6/wHud/d/+26szqi/9TpY2aty35vmfgn13Tm3P073Fvj5Es3Tt32dHvSd2b5c/0my5fb
        lFks8LnTa+ZV/L3srkGhnrlv66UYhkKT1V1KLMUZiYZazEXFiQAczCbb5AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7pHGpuSDFr/CFisvtvPZvH77Hlm
        i73vZrNaXPjRyGRx88BOJouVq48yWfQc+MBisfeWtsWlxyvYLfbsPclicXnXHDaL+cueslvc
        mPCU0eLz0hZ2izU3n7I48Hv8O7GGzWPnrLvsHpfPlnpsWtXJ5rF5Sb3H7psNQOHW+6we7/dd
        ZfPo27KK0WP9lqssHp83yQVwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlTF/SyVxwtKLi88tv7A2MV5O7GDk5JARMJI6d/8DWxcjFISSwlFFi
        x5rvbBAJCYnbC5sYIWxhiT/XuqCKnjJKdJ56zt7FyMHBJqAl0djJDlIjIlAgMad/CwtIDbPA
        WiaJ1z/egzULC6RI7Ov7xwpiswioSrQdOQO2gFfASuLSvzPsEAvkJWZe+g42k1PAWmJ1FzdI
        WAio5OuTW+wQ5YISJ2c+YQGxmYHKm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFRnrFibnF
        pXnpesn5uZsYgZG57djPLTsYV776qHeIkYmD8RCjBAezkgivQUVDkhBvSmJlVWpRfnxRaU5q
        8SFGU6CzJzJLiSbnA1NDXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
        p1QDUxzXzm+6D7RW+vB3LH1ey3b/h0wtzxf2PUZTBRL+MLbF2X++bPinapPR2nLWNYnZRrqd
        U8pnMQuLzzpV4yl/cuHD3qlHjMwfvp+VLnLx3f3vh07GLXib9SKohO9DTKDlrtyYl2+3Bqsu
        WrJCRD3tXP/E85EHUixUvz8XOHXfVTuHr0n1LP9a5ROLeyfJLtm0Lbe6ahd3e3zuTHWnGduf
        LFbfb5e5YeEnXsegD/K6zYozdLJ2ml2Nb1NZ+uKHRqiTUEtvyxrzRetW/rk+y7BfrUTXjH+p
        o+T67q4d8x4XhCyUMhRMVWX3i/C8wfuwW3HifIP9N1e9W1DStHe2oa6jwKf1gn+W7J/eqHfb
        +93PNCWW4oxEQy3mouJEALkRar9VAwAA
X-CMS-MailID: 20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165428eucas1p1374b5f9592db3ca6a6551aff975537ce@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add helpers to calculate alignment, round up and round down
for zoned devices. These helpers encapsulates the necessary handling for
power_of_2 and non-power_of_2 zone sizes. Optimized calculations are
performed for zone sizes that are power_of_2 with log and shifts.

btrfs_zoned_is_aligned() is added instead of reusing bdev_zone_aligned()
helper due to some use cases in btrfs where zone alignment is checked
before having access to the underlying block device such as in this
function: btrfs_load_block_group_zone_info().

Use the generic btrfs zone helpers to calculate zone index, check zone
alignment, round up and round down operations.

The zone_size_shift field is not needed anymore as generic helpers are
used for calculation.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/volumes.c | 24 +++++++++-------
 fs/btrfs/zoned.c   | 72 ++++++++++++++++++++++------------------------
 fs/btrfs/zoned.h   | 43 +++++++++++++++++++++++----
 3 files changed, 85 insertions(+), 54 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 94f851592..3d6b9a25a 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1408,7 +1408,7 @@ static u64 dev_extent_search_start(struct btrfs_device *device, u64 start)
 		 * allocator, because we anyway use/reserve the first two zones
 		 * for superblock logging.
 		 */
-		return ALIGN(start, device->zone_info->zone_size);
+		return btrfs_zoned_roundup(start, device->zone_info->zone_size);
 	default:
 		BUG();
 	}
@@ -1423,7 +1423,7 @@ static bool dev_extent_hole_check_zoned(struct btrfs_device *device,
 	int ret;
 	bool changed = false;
 
-	ASSERT(IS_ALIGNED(*hole_start, zone_size));
+	ASSERT(btrfs_zoned_is_aligned(*hole_start, zone_size));
 
 	while (*hole_size > 0) {
 		pos = btrfs_find_allocatable_zones(device, *hole_start,
@@ -1560,7 +1560,7 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	search_start = dev_extent_search_start(device, search_start);
 
 	WARN_ON(device->zone_info &&
-		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+		!btrfs_zoned_is_aligned(num_bytes, device->zone_info->zone_size));
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -5111,8 +5111,8 @@ static void init_alloc_chunk_ctl_policy_zoned(
 
 	ctl->max_stripe_size = zone_size;
 	if (type & BTRFS_BLOCK_GROUP_DATA) {
-		ctl->max_chunk_size = round_down(BTRFS_MAX_DATA_CHUNK_SIZE,
-						 zone_size);
+		ctl->max_chunk_size = btrfs_zoned_rounddown(
+			BTRFS_MAX_DATA_CHUNK_SIZE, zone_size);
 	} else if (type & BTRFS_BLOCK_GROUP_METADATA) {
 		ctl->max_chunk_size = ctl->max_stripe_size;
 	} else if (type & BTRFS_BLOCK_GROUP_SYSTEM) {
@@ -5124,9 +5124,10 @@ static void init_alloc_chunk_ctl_policy_zoned(
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
@@ -6729,7 +6730,8 @@ static void submit_stripe_bio(struct btrfs_io_context *bioc,
 	 */
 	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
 		if (btrfs_dev_is_sequential(dev, physical)) {
-			u64 zone_start = round_down(physical, fs_info->zone_size);
+			u64 zone_start = btrfs_zoned_rounddown(physical,
+							fs_info->zone_size);
 
 			bio->bi_iter.bi_sector = zone_start >> SECTOR_SHIFT;
 		} else {
@@ -8051,8 +8053,8 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
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
index 5be2ef7bb..3023c871e 100644
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
@@ -409,9 +409,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	}
 
 	nr_sectors = bdev_nr_sectors(bdev);
-	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
-	zone_info->nr_zones = nr_sectors >> ilog2(zone_sectors);
-	if (!IS_ALIGNED(nr_sectors, zone_sectors))
+	zone_info->nr_zones = bdev_zone_no(bdev, nr_sectors);
+	if (!btrfs_zoned_is_aligned(nr_sectors, zone_sectors))
 		zone_info->nr_zones++;
 
 	max_active_zones = bdev_max_active_zones(bdev);
@@ -823,10 +822,8 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 			       u64 *bytenr_ret)
 {
 	struct blk_zone zones[BTRFS_NR_SB_LOG_ZONES];
-	sector_t zone_sectors;
 	u32 sb_zone;
 	int ret;
-	u8 zone_sectors_shift;
 	sector_t nr_sectors;
 	u32 nr_zones;
 
@@ -837,12 +834,10 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
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
@@ -959,14 +954,12 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
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
@@ -992,18 +985,17 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
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
@@ -1035,8 +1027,9 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
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
@@ -1050,7 +1043,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 static bool btrfs_dev_set_active_zone(struct btrfs_device *device, u64 pos)
 {
 	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-	unsigned int zno = (pos >> zone_info->zone_size_shift);
+	unsigned int zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 
 	/* We can use any number of zones */
 	if (zone_info->max_active_zones == 0)
@@ -1072,7 +1065,7 @@ static bool btrfs_dev_set_active_zone(struct btrfs_device *device, u64 pos)
 static void btrfs_dev_clear_active_zone(struct btrfs_device *device, u64 pos)
 {
 	struct btrfs_zoned_device_info *zone_info = device->zone_info;
-	unsigned int zno = (pos >> zone_info->zone_size_shift);
+	unsigned int zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 
 	/* We can use any number of zones */
 	if (zone_info->max_active_zones == 0)
@@ -1108,14 +1101,14 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
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
@@ -1139,8 +1132,9 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
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
@@ -1237,7 +1231,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		return 0;
 
 	/* Sanity check */
-	if (!IS_ALIGNED(length, fs_info->zone_size)) {
+	if (!btrfs_zoned_is_aligned(length, fs_info->zone_size)) {
 		btrfs_err(fs_info,
 		"zoned: block group %llu len %llu unaligned to zone size %llu",
 			  logical, length, fs_info->zone_size);
@@ -1325,7 +1319,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
 		 */
-		WARN_ON(!IS_ALIGNED(physical[i], fs_info->zone_size));
+		WARN_ON(!btrfs_zoned_is_aligned(physical[i], fs_info->zone_size));
 		nofs_flag = memalloc_nofs_save();
 		ret = btrfs_get_dev_zone(device, physical[i], &zone);
 		memalloc_nofs_restore(nofs_flag);
@@ -1351,10 +1345,12 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
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
index 694ab6d1e..b94ce4d1f 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -9,6 +9,7 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "btrfs_inode.h"
+#include "misc.h"
 
 #define BTRFS_DEFAULT_RECLAIM_THRESH           			(75)
 
@@ -18,7 +19,6 @@ struct btrfs_zoned_device_info {
 	 * zoned block device.
 	 */
 	u64 zone_size;
-	u8  zone_size_shift;
 	u32 nr_zones;
 	unsigned int max_active_zones;
 	atomic_t active_zones_left;
@@ -30,6 +30,36 @@ struct btrfs_zoned_device_info {
 	u32 sb_zone_location[BTRFS_SUPER_MIRROR_MAX];
 };
 
+static inline bool btrfs_zoned_is_aligned(u64 pos, u64 zone_size)
+{
+	u64 remainder = 0;
+
+	if (is_power_of_two_u64(zone_size))
+		return IS_ALIGNED(pos, zone_size);
+
+	div64_u64_rem(pos, zone_size, &remainder);
+	return remainder == 0;
+}
+
+static inline u64 btrfs_zoned_roundup(u64 pos, u64 zone_size)
+{
+	if (is_power_of_two_u64(zone_size))
+		return ALIGN(pos, zone_size);
+
+	return div64_u64(pos + zone_size - 1, zone_size) * zone_size;
+}
+
+static inline u64 btrfs_zoned_rounddown(u64 pos, u64 zone_size)
+{
+	u64 remainder = 0;
+	if (is_power_of_two_u64(zone_size))
+		return round_down(pos, zone_size);
+
+	div64_u64_rem(pos, zone_size, &remainder);
+	pos -= remainder;
+	return pos;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 		       struct blk_zone *zone);
@@ -253,7 +283,8 @@ static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 	if (!zone_info)
 		return false;
 
-	return test_bit(pos >> zone_info->zone_size_shift, zone_info->seq_zones);
+	return test_bit(bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT),
+			zone_info->seq_zones);
 }
 
 static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
@@ -263,7 +294,8 @@ static inline bool btrfs_dev_is_empty_zone(struct btrfs_device *device, u64 pos)
 	if (!zone_info)
 		return true;
 
-	return test_bit(pos >> zone_info->zone_size_shift, zone_info->empty_zones);
+	return test_bit(bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT),
+			zone_info->empty_zones);
 }
 
 static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
@@ -275,7 +307,7 @@ static inline void btrfs_dev_set_empty_zone_bit(struct btrfs_device *device,
 	if (!zone_info)
 		return;
 
-	zno = pos >> zone_info->zone_size_shift;
+	zno = bdev_zone_no(device->bdev, pos >> SECTOR_SHIFT);
 	if (set)
 		set_bit(zno, zone_info->empty_zones);
 	else
@@ -329,7 +361,8 @@ static inline bool btrfs_can_zone_reset(struct btrfs_device *device,
 		return false;
 
 	zone_size = device->zone_info->zone_size;
-	if (!IS_ALIGNED(physical, zone_size) || !IS_ALIGNED(length, zone_size))
+	if (!btrfs_zoned_is_aligned(physical, zone_size) ||
+	    !btrfs_zoned_is_aligned(length, zone_size))
 		return false;
 
 	return true;
-- 
2.25.1

