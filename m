Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137CD528B37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343984AbiEPQyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbiEPQye (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030B033EB2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165429euoutp02865b1145814b3a33b46fba6cb8dcf07b~vpCWJAg9K2209122091euoutp02G
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165429euoutp02865b1145814b3a33b46fba6cb8dcf07b~vpCWJAg9K2209122091euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720069;
        bh=LMzILViEYGl7DXa37dpeTA+tqVrqwK5EcVpc6Ix2yY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A0c8uYz+W5tocQRMiMunWf0GDS6Tq/DOaWfbk6yR6QKHl8AvCRU16JTyHy4AWjsBq
         Zq9oRlSwREqbSpwn//0BmARib60MbhD6xwPE5IEK+QyexLwF2lWBuV/NYpAvcKskuB
         pbvgrCxMOBCgxBXG1YM6cM3O7d1wXjhUBdm4EQuk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165427eucas1p1b7937c8e93a50f9ab55b194314c0ebb2~vpCUkQ-KR3100231002eucas1p1I;
        Mon, 16 May 2022 16:54:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.40.10009.3C182826; Mon, 16
        May 2022 17:54:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9~vpCT-y5rM1659616596eucas1p1t;
        Mon, 16 May 2022 16:54:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165427eusmtrp19cc052b58b95fdd70c470b667b9eaf31~vpCT-DoC-2961829618eusmtrp1K;
        Mon, 16 May 2022 16:54:27 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-4e-628281c36dfb
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3E.89.09522.2C182826; Mon, 16
        May 2022 17:54:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165426eusmtip112dc0f7e69af738ccc790922191cbea1~vpCTmyPXE2383423834eusmtip1p;
        Mon, 16 May 2022 16:54:26 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 06/13] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Date:   Mon, 16 May 2022 18:54:09 +0200
Message-Id: <20220516165416.171196-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7qHG5uSDN7OVrFYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DKePd7K2PBIcmKrXdvMjYwfhLpYuTk
        kBAwkVg9byNbFyMXh5DACkaJS/dPsEA4XxglZkyYAZX5zCjx58dTdpiWl6e+sIDYQgLLGSU6
        topBFD1nlFh78iZrFyMHB5uAlkRjJ1i9iECWxLQTDxlBapgFFjNJrNwzGaxZWCBBYs/ec2wg
        NouAqsTv1cvA4rwCVhLXXlxjhVgmLzHz0nd2kJmcAtYSq7u4IUoEJU7OfAJWzgxU0rx1NjPI
        fAmB2ZwSV/o/MUP0ukgsab/LCGELS7w6vgXqARmJ05N7WCDsaomnN35DNbcwSvTvXM8GskwC
        aFnfmRwQk1lAU2L9Ln2IckeJjS19zBAVfBI33gpCnMAnMWnbdKgwr0RHmxBEtZLEzp9PoJZK
        SFxumgO11ENi1+lDjBMYFWcheWYWkmdmIexdwMi8ilE8tbQ4Nz212DAvtVyvODG3uDQvXS85
        P3cTIzDZnf53/NMOxrmvPuodYmTiYDzEKMHBrCTCa1DRkCTEm5JYWZValB9fVJqTWnyIUZqD
        RUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qBqVhL7+LHimNKfa2/GNM0u17wTGx8XHj5qqDc
        ozWJSvUhCnmcp98p393KXzrf9+ehuftOdWu9Uy56voUx4byaoTOL676iZNboOMeVm7a+dH33
        7u6pJRfrZkyYkj5nV+lLiacnXm1b1bvmXuiDyNSZS9OWWE84U1j74LPsiU+1HV5Ln0RNsJtS
        kDQzpv388ncM5lFqB2dVTH6hxiS48Yd8se3Wy9mfQ1r38BtdSnjM+OparpD1pj2axpYBbkdS
        dY0fzdJ4qZlooHPlxuHJKZOEw5eIHcpVVe4tW32y5Etrcd2tJTcjuWLnZX1abnVI6zZnD8sW
        pgM3645Vf8gws38nH3Hz4YyKqQ3XJHR+3Kq/6qbEUpyRaKjFXFScCADVPX7M5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xu7qHGpuSDPaus7RYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLePd7K2PBIcmKrXdvMjYwfhLpYuTkkBAwkXh56gtLFyMXh5DAUkaJ
        JU3rGCESEhK3FzZB2cISf651sUEUPWWUuN+9DqiDg4NNQEuisZMdpEZEoEBiTv8WsEHMAmuZ
        JF7/eM8IUiMsECfR+1wZpIZFQFXi9+plLCA2r4CVxLUX11gh5stLzLz0nR2knFPAWmJ1FzdI
        WAio5OuTW+wQ5YISJ2c+AWtlBipv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6hUn5haX
        5qXrJefnbmIExuW2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIrwGFQ1JQrwpiZVVqUX58UWlOanF
        hxhNgc6eyCwlmpwPTAx5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TByc
        Ug1MLoEdnFe0ths1swlvms4q/mmL4Fujvn8HLxz4ppOS/UZs1rLfpiZqAtu6777Stf8oMWfe
        Jr9qP7ukzYH/VhlYTxNlc55/9Hz+zQ5JhapXG79t2Jpg2/NtdbDXq4R3Rmxdj6I2c0e9lvmy
        58ArG2YH6+zEHffCn9V5Xfh0ZLq4GePRjlBX4T1/TctMsr6tqbc+WBl71HEVm0+Ub/77c4si
        pbUvBIb220m4uL8ouhv9csmM82Hy88JzeFJVpNTsamccO7naQ+PLmiyF+LKz2bfvebE0e7Kd
        /LTwvUje9Rv1VuXml/R/J8X/uxD+7MmGlXUJrL32e+3UUzYvFPp/u+Xh3mSWZimeEEsGHYeV
        cQJKLMUZiYZazEXFiQCKFWZPVAMAAA==
X-CMS-MailID: 20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165427eucas1p1cfd87ca44ec314ea1d2ddc8ece7259f9@eucas1p1.samsung.com>
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

Make the calculation in sb_zone_number function to be generic and work
for both power-of-2 and non power-of-2 zone sizes.

The function signature has been modified to take block device and mirror
as input as this function is only invoked from callers that have access
to the block device. This enables to use the generic bdev_zone_no
function provided by the block layer to calculate the zone number.

Even though division is used to calculate the zone index for non
power-of-2 zone sizes, this function will not be used in the fast path as
the sb_zone_location cache is used for the superblock zone location.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index e8c7cebb2..5be2ef7bb 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -34,9 +34,6 @@
 #define BTRFS_SB_LOG_FIRST_OFFSET	(512ULL * SZ_1G)
 #define BTRFS_SB_LOG_SECOND_OFFSET	(4096ULL * SZ_1G)
 
-#define BTRFS_SB_LOG_FIRST_SHIFT	const_ilog2(BTRFS_SB_LOG_FIRST_OFFSET)
-#define BTRFS_SB_LOG_SECOND_SHIFT	const_ilog2(BTRFS_SB_LOG_SECOND_OFFSET)
-
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
@@ -153,15 +150,23 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 /*
  * Get the first zone number of the superblock mirror
  */
-static inline u32 sb_zone_number(int shift, int mirror)
+static inline u32 sb_zone_number(struct block_device *bdev, int mirror)
 {
 	u64 zone;
 
 	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
 	switch (mirror) {
-	case 0: zone = 0; break;
-	case 1: zone = 1ULL << (BTRFS_SB_LOG_FIRST_SHIFT - shift); break;
-	case 2: zone = 1ULL << (BTRFS_SB_LOG_SECOND_SHIFT - shift); break;
+	case 0:
+		zone = 0;
+		break;
+	case 1:
+		zone = bdev_zone_no(bdev,
+				    BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT);
+		break;
+	case 2:
+		zone = bdev_zone_no(bdev,
+				    BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT);
+		break;
 	}
 
 	ASSERT(zone <= U32_MAX);
@@ -514,7 +519,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	/* Cache the sb zone number */
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
 		zone_info->sb_zone_location[i] =
-			sb_zone_number(zone_info->zone_size_shift, i);
+			sb_zone_number(bdev, i);
 	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
@@ -839,7 +844,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
@@ -963,7 +968,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-- 
2.25.1

