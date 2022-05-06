Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4A351D2D7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389830AbiEFIO6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389823AbiEFIO4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:14:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FB67D29
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081110euoutp029ca64511ef9351c112de070c831f5823~sdclPLPfz2385223852euoutp02e
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506081110euoutp029ca64511ef9351c112de070c831f5823~sdclPLPfz2385223852euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824670;
        bh=qm0Anrgo2LRVYYSLS0+cudW9OU5s2MlxyVDAMmEqCV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KgVGAgJ7IhydgqnUmVeHw7z7ZrJrVQET7erqChqjXzRd9D7ZHs1stTZFW0gVqKMRT
         n62Jx7UEstbPY+qdioxjzNz9Ab21opXKE23M3lo6GwC7bl49Mfe5icj89kW6JMy2o+
         XH5CdyJWCnObOMyl3E9Gzikdo99hv40XFyxS6+2U=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506081109eucas1p295781fbeaf12c041e70e48545704d25f~sdcjnj07r1186311863eucas1p2G;
        Fri,  6 May 2022 08:11:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 94.05.09887.C18D4726; Fri,  6
        May 2022 09:11:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506081108eucas1p2ca72ccafb05dfdcc5b8ba9393da1ce60~sdcjBJ5f41330313303eucas1p2P;
        Fri,  6 May 2022 08:11:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506081108eusmtrp1cd3eeb0040d1f44067a31d3ea2623ed1~sdci_xet53086630866eusmtrp1c;
        Fri,  6 May 2022 08:11:08 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-2b-6274d81c9af8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.E2.09522.C18D4726; Fri,  6
        May 2022 09:11:08 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081108eusmtip19260a40a3b2603466a9a3224b90303cb~sdcip8bxI0384703847eusmtip1X;
        Fri,  6 May 2022 08:11:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com,
        axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        snitzer@kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        gost.dev@samsung.com, jonathan.derrick@linux.dev,
        jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 02/11] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Fri,  6 May 2022 10:10:56 +0200
Message-Id: <20220506081105.29134-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xbZRzdd+/tvRe03V1p0o+BI5AtmzPAwCV+AkGNmNzEOJ3JYpyiK3DX
        kfFY+pggTjte4yWUsol0RLc5BcrL0YqWwRiNQBEGhFItJIBlsAyUR6VMeQhSLov775zvd853
        zi/50bi4gdxLJ6aoOEWKLCmI9Caau1b6g/0dqrgjlnWEGn/pwtFmaxeJasdKSPTF4gqOdCVf
        Umjt3gCO2uavCtDgPxcxNHLXjKHWGzoM1dR2YmiqUY+joruLBKrJduJo3RmGnO5RAuksvwI0
        bddjqG30OTR0v5pCrW09BLK1VJLo6++mKaTNXcaRQzsNUGm3UYCWvs2mUMMfCwSyjvq9/Axr
        G36d3bDWkWxp1jzFDozfIljbPTXbZMgn2euaKzhrvPkZe3tEQ7KfZ82TrDlnQsAu3LGTbLHJ
        ANhGk51gjb0ZrNZ4S/CW+KR3VAKXlHieU4RGn/I+Y6+Zos4tH0i7X24HGjC0rwB40ZA5Cq+v
        asgC4E2LmWoAb9qyd4gbwMrZhzhPlgB0OnXkY0uWPY/iB1UADufUYjyZAdBkHdkiNE0yh+HF
        /G2RhCkEsGTiEuVx44xRAAfrT3uwD/MeLLVOYx5MMAfgYo4L93iFzIuwbljIhwXAiqG/t61e
        TATMLJvZLiFk9sCeiimC/zIAZv1wFef19d7Q1sHwOAY+mjNjPPaBs90misf+sLesiOBxBpx2
        rG1vCZnsrZ7mRtLTATKRsLgvyQNx5lnY2BLKy1+BhaPtgFeIoGNuD99ABHXN5Tj/LIR5uWJe
        HQTNK1M7oRDaMit3QlnY2V4ItCBQ/8Qu+id20f+few3gBiDl1MpkOacMT+E+ClHKkpXqFHlI
        fGpyE9g66d6NbvdPoGrWFWIBGA0sANJ4kEToo1fFiYUJsvSPOUXqhwp1Eqe0AD+aCJIK4xO/
        l4kZuUzFneW4c5zi8RSjvfZqsIbjLlR/2j/6/b7gSPmfhlJFejX1TUeZGXxVjPQCqXTX09rw
        D4p23/49bCL5hnvXO6LWvw5OHqqa//S1/pW1k+O/HZ9ZbTvr2k0//6b18kv9acFHB6KOLK+u
        n8fflr2xtpLipA7GDXUcG+jbFxENvEwOMV1xSTwWGBivGNxwG9oe7OcWnGlP6eZCCNWP4a6W
        f4ex0Z/LcstNSamZec1X5uTW/AQ/luE2xyyb65uxLSJ5aea7eTGuihilRCutdcSSkyceXbgs
        HNJGFRKR/fsnKyWhrxold3zbI6vSh081yY5h47EZnxx6wbcnIlGsu1b/YGn8YZ7oREFdavJk
        gO+FTnUQoTwjCzuMK5Sy/wBhplYsQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7oyN0qSDLq2CFusP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlnsWTSJyWLl6qNMFk/Wz2K2
        6DnwgcViZctDZos/Dw0tHn65xWIx6dA1RounV2cxWey9pW1x6fEKdos9e0+yWFzeNYfNYv6y
        p+wWE9q+MlvcmPCU0WLi8c2sFp+XtrBbrHv9nsXixC1pB1mPy1e8Pf6dWMPmMbH5HbvH+Xsb
        WTwuny312LSqk81jYcNUZo/NS+o9dt9sYPPobX7H5rGz9T6rx/t9V9k8+rasYvRYv+Uqi8fm
        09UeEzZvZA0QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DLuLryCXvBV9WKx9OvMjYwXpLrYuTkkBAwkWi+2sHexcjFISSwlFHix9QLLBAJCYnb
        C5sYIWxhiT/Xutggip4zSiyacZG1i5GDg01AS6KxE6xZRGAqo8SldSdZQBxmgdOsEls3HWAC
        6RYWiJTo7r0MNolFQFXiQ+tHZpBmXgFLiTVXeCEWyEvMvPSdHcTmFLCSaJr8kg3EFgIqmb9k
        DyuIzSsgKHFy5hOw45iB6pu3zmaewCgwC0lqFpLUAkamVYwiqaXFuem5xYZ6xYm5xaV56XrJ
        +bmbGIEpZduxn5t3MM579VHvECMTB+MhRgkOZiURXuFZJUlCvCmJlVWpRfnxRaU5qcWHGE2B
        zp7ILCWanA9Mankl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxr
        FV9/kDLRu+sVyHzK9t4+hUXFJc/08xr3zTp29lCdmA1H9r8z8ZuvfPVZ05df6mk/p4x/thnX
        XpHXT1+5fJ5iWGz+7Ejjr5My6WG7z+799r9PurructaXfT7916SEG5/x3duY9z4uvCUgdvLt
        QyUXzy02vql9Rf3yu0lXzf8rm+Tlf/Xe+qZvGhN/snFhQqDq8n13ru4VCVN++qH20b3/ien7
        Nlo4GJ7QszV5oNRxxLp5hdiCxqdKP5x752XOqpE3ZKt88SBcgY+NJUtrD1N/xMPSj9vCzHlN
        zXSDH/16qCfXfZPbw6z7wla19yx7EzaHiR8pZjzyjuWh3iT7ygT3Kf//bLH4WCGha/0wqEmJ
        pTgj0VCLuag4EQASMj+OsgMAAA==
X-CMS-MailID: 20220506081108eucas1p2ca72ccafb05dfdcc5b8ba9393da1ce60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081108eucas1p2ca72ccafb05dfdcc5b8ba9393da1ce60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081108eucas1p2ca72ccafb05dfdcc5b8ba9393da1ce60
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081108eucas1p2ca72ccafb05dfdcc5b8ba9393da1ce60@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checking if a given sector is aligned to a zone is a common
operation that is performed for zoned devices. Add
blk_queue_is_zone_start helper to check for this instead of opencoding it
everywhere.

Convert the calculations on zone size to be generic instead of relying on
power_of_2 based logic in the block layer using the helpers wherever
possible.

The only hot path affected by this change for power_of_2 zoned devices
is in blk_check_zone_append() but blk_queue_is_zone_start() helper is
used to optimize the calculation for po2 zone sizes. Note that the append
path cannot be accessed by direct raw access to the block device but only
through a filesystem abstraction.

Finally, allow non power of 2 zoned devices provided that their zone
capacity and zone size are equal. The main motivation to allow non
power_of_2 zoned device is to remove the unmapped LBA between zcap and
zsze for devices that cannot have a power_of_2 zcap.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c       |  3 +--
 block/blk-zoned.c      | 27 +++++++++++++++++++++------
 include/linux/blkdev.h | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f305cb66c..b7051b7ea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (pos & (blk_queue_zone_sectors(q) - 1) ||
-	    !blk_queue_zone_is_seq(q, pos))
+	if (!blk_queue_is_zone_start(q, pos) || !blk_queue_zone_is_seq(q, pos))
 		return BLK_STS_IOERR;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 140230134..cfc2fb804 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -289,10 +289,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!blk_queue_is_zone_start(q, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!blk_queue_is_zone_start(q, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -490,14 +490,29 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zone size",
+				disk->disk_name);
+			return -ENODEV;
+		}
+
+		/*
+		 * Don't allow zoned device with non power_of_2 zone size with
+		 * zone capacity less than zone size.
+		 */
+		if (!is_power_of_2(zone->len) &&
+		    zone->capacity < zone->len) {
+			pr_warn("%s: Invalid zoned size with non power of 2 zone size and zone capacity < zone size",
+				disk->disk_name);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		/*
+		 * Division is used to calculate nr_zones for both power_of_2
+		 * and non power_of_2 zone sizes as it is not in the hot path.
+		 */
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 22fe512ee..32d7bd7b1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -686,6 +686,22 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 	return div64_u64(sector, zone_sectors);
 }
 
+static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
+{
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+	u64 remainder = 0;
+
+	if (!blk_queue_is_zoned(q))
+		return false;
+
+	if (is_power_of_2(zone_sectors))
+		return IS_ALIGNED(sec, zone_sectors);
+
+	div64_u64_rem(sec, zone_sectors, &remainder);
+	/* if there is a remainder, then the sector is not aligned */
+	return remainder == 0;
+}
+
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
 					 sector_t sector)
 {
@@ -732,6 +748,12 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 {
 	return 0;
 }
+
+static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
+{
+	return false;
+}
+
 static inline unsigned int queue_max_open_zones(const struct request_queue *q)
 {
 	return 0;
-- 
2.25.1

