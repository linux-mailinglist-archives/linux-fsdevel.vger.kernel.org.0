Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4D2528582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243849AbiEPNjm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEPNjh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:39:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BDD2ED6D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:39:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516133926euoutp02695eb3b5f7529c64ddc4064ff6016e69~vmYDSz1v31619516195euoutp02t
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:39:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516133926euoutp02695eb3b5f7529c64ddc4064ff6016e69~vmYDSz1v31619516195euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652708366;
        bh=qm0Anrgo2LRVYYSLS0+cudW9OU5s2MlxyVDAMmEqCV0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=faAznkGxmAVswsHkNcHQux+GXkC7+mxlmLi/Mr+GnqbUj/YM2288T+YIpJBRKsypH
         WCOKJW4ZsfsN53t3NNeRWzppXrFQtZcIw9HlJLCiPEw3l8b+mridW4xxyVlqZdXBdW
         KrADJ+InAAEnoOGE7TH05/Znqv2p9mNptKRKVxfQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516133925eucas1p1420eaae564513c721731fd2576c15897~vmYCc9e2d1351113511eucas1p1O;
        Mon, 16 May 2022 13:39:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7B.8D.09887.D0452826; Mon, 16
        May 2022 14:39:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685~vmYB8l_5Y1348813488eucas1p1Z;
        Mon, 16 May 2022 13:39:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516133925eusmtrp13fdd91aa67297264273541394fda3a28~vmYB7c2a10312203122eusmtrp1b;
        Mon, 16 May 2022 13:39:25 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-5e-6282540d840f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2E.02.09522.D0452826; Mon, 16
        May 2022 14:39:25 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133925eusmtip1fea492112f4c915b97ebeaa172d419bc~vmYBs5nFp0855508555eusmtip1Z;
        Mon, 16 May 2022 13:39:25 +0000 (GMT)
Received: from localhost (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 16 May 2022 14:39:24 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <axboe@kernel.dk>, <naohiro.aota@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <Johannes.Thumshirn@wdc.com>,
        <snitzer@kernel.org>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
        <hch@lst.de>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.derrick@linux.dev>, <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>, <gost.dev@samsung.com>,
        <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        <linux-block@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        "Sagi Grimberg" <sagi@grimberg.me>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, Chaitanya Kulkarni <kch@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 02/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
Date:   Mon, 16 May 2022 15:39:10 +0200
Message-ID: <20220516133921.126925-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957e1tI6i6FwTu6ydLIH3NYwczlHZpNs0VvYlxmMicDt1Hl
        Doh8pQXp5nTlGwoKIuhsYepcBIS1o7SG8jFoE8q3ZXyFdSLrAFEYINAyGmcd9eLCf895z++c
        8zzJy8MFVWQgLz4plZEmSRJEpDdxx+K6u4P/SeaJ0PK6XUjbY8HRsxYLiWrHi0l0+bELR6XF
        33PRk34rjloX1Bw0sJaBoZraDgxNaVU4Kmp/TKCnyvvrb9l2HP1rD0N2h41ApeZRgKZHVBhq
        tb2FBieruailtZtAQ00VJLp2a5qLSnKdOBormQboYmcDB2nmFgnUZRPuE9JDw4dod1cdSV/M
        WuDS1vv1BD3Un0brbheQ9A1FOU43/PQd3fy7gqTPZy2QtDFngkMv/jpC0lr9CEGXNNRz6BXd
        VjqvvRD7mIr03hvDJMSfZqQ734v2jhupmeKmOIPlk1dGgAIMblUCLx6k3oYVPT8CJfDmCahq
        AHWF9zYKB4A/mPJJtlgB8IbZyX0x0qF+tNGoAnDm7nnif2pc7QIeSkDpASwyBysBj0dS22FG
        AdfD+FEmAF0D1ZinwKlqDmxyrxGeAV8qCuaNduMeTVDBsDGzCfNoPhUOZ4qdBHs6CF4d/Ifr
        WepF7YHLF95nER/YfXXqOYKvI1kGNc5qCE0PH+IeHFIiqB4Ss1vOwp8tfc/9QKrDGzq7awDb
        +BBOFK2SrPaFs536jcSvwd5LRRsWzsDpsSc4O5wNYLFRS7IH9sALfQkssx/mtfVg7PMWODbv
        w9rZAkvvXNmww4f5uYISsE21KYBqUwDVpgDXAX4bBDBpssRYRrYriUkXyySJsrSkWPHJ5EQd
        WP/Lve5ORyOoml0SmwHGA2YAebjIjx8qV5wQ8GMkX3/DSJO/lKYlMDIzEPIIUQD/ZPwvEgEV
        K0llTjFMCiN90cV4XoEKrLLVVPHnb+/OPSqLK9htqHBEhNwTC6POyemvhueFiy1W9RpmDcoM
        OWUkyAPHTK9G2CbLonNtGn+DX/S8IUiT2tQsbUt2bxMqjxZaGs4OV3dFTM7w33l91cY1RXMq
        NDuXsqIUkW3pz8Z8NMdGz+zTO+zWwP0fZLuP+/YFiv2+rdE+PbijQ/rXS8vte0uWT6OP+t9o
        Tg3oHpip7J0IPcD17xg8mj+rXPLZHT5er6du2vuP5/heltf6Z7zy5jw6l/p5+CFD/KdzxuIj
        8r7FuqVbX5Sn/F31cqPAMn5TW3TQP/IPL1PZ1OrC/Bh+OOPIA/+wnHw1KPwstzLd9eBwVEyI
        cUUnImRxkrDtuFQm+Q+YXt6WOgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xu7q8IU1JBjNu81msP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLlauPMlk8WT+L2aLnwAcWi79d94Bi
        LQ+ZLf48NLR4+OUWi8WkQ9cYLZ5encVksfeWtsWlxyvYLfbsPclicXnXHDaL+cuesltMaPvK
        bHFjwlNGi4nHN7NarHv9nsXixC1pB2mPy1e8Pf6dWMPmMbH5HbvH+XsbWTwuny312LSqk81j
        YcNUZo/NS+o9dt9sYPPobX7H5rGz9T6rx/t9V9k81m+5yuIxYfNGVo/Pm+Q82g90MwUIROnZ
        FOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlXF35hL3g
        q2rF4+lXGRsYL8l1MXJySAiYSByd/ZKti5GLQ0hgKaPE7nvX2SASMhKfrnxkh7CFJf5c64Iq
        +sgo8WDVe0YIZwujxP+pJ5i7GDk42AS0JBo72UHiIgIHGSV+XljBBNLNLLCCVeLPnloQW1gg
        UqK9+wnYBhYBVYkdTbvAangFrCSe939lgdgmLzHz0nd2kJmcAtYSn/rsQUwhoJL1b4ogqgUl
        Ts58wgIxXV6ieetsZghbQuLgixdg10gIKEnMvqwHMbBW4tX93YwTGEVmIemehaR7FpLuBYzM
        qxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQJT1rZjPzfvYJz36qPeIUYmDsZDjBIczEoivAYV
        DUlCvCmJlVWpRfnxRaU5qcWHGE2BnpzILCWanA9Mmnkl8YZmBqaGJmaWBqaWZsZK4ryeBR2J
        QgLpiSWp2ampBalFMH1MHJxSDUxN+iGxUjvt+Vf/sP2k2T/lwS32rKTtJSw1+28oWN9/XvV6
        9qzq7csEZwWFTyruVtjNYdS5PqhS9lJEPv/mhDW2PtkmsuZyZ1Tast9YyKd3nprxZ1nVNLMv
        LHJHf7+SP6o36Xdz7o/m/aWBFVv7Cw7cjthb/pVr83mjr/zNTt92T763p/jdlKqPN7q5Fb4c
        1uS+IZB+JLuzf566r5nLq79pF+R3iR9KOrBwX9IL9Rb3+54X2MT4zR0tHJoSjiy9ttxbKIP5
        np+k9Lfth7wvRKf2NYsUHmG6ax4c/6or9sYZ03O8T38+0JuZdnyxwuyjlkyzlBzXd+uUeK7b
        yjP7YZigdTz/5f3ezf2xLZx5f5VYijMSDbWYi4oTAc0L/zniAwAA
X-CMS-MailID: 20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685
X-Msg-Generator: CA
X-RootMTR: 20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685
References: <20220516133921.126925-1-p.raghav@samsung.com>
        <CGME20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685@eucas1p1.samsung.com>
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

