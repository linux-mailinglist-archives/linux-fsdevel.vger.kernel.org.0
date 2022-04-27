Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E800C5120E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241754AbiD0QHL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241560AbiD0QGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DDC3CE9A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160303euoutp0252363620be74673ba65b450cb4efefae~pzFAlHrhQ1479314793euoutp02g
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220427160303euoutp0252363620be74673ba65b450cb4efefae~pzFAlHrhQ1479314793euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075383;
        bh=hUBpZxkDXTvCbRzniY5oQe/mcS4maRVWN0mf8iYt6nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nUD3Zlljb1W0hKuro0V+VuS6AzNwVXo2IEBdL3HytZKp+pf4rjul8PwzEA8TIpSkW
         7nJJ26TxElUXLp2CtpMD3NhzFJm4XRSCZtZ8SLFKMrDjwWSNHWQG3aYZcTV1wLjxje
         ypI6XKbLcp0CGsseTYr04mRkmN9XIp9n3ttp424c=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160300eucas1p2820b4ac90e9eb0636191f5d6b6009ac5~pzE_szwrg2336123361eucas1p2k;
        Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id D4.0A.10260.43969626; Wed, 27
        Apr 2022 17:03:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a~pzE_QB5uM0602706027eucas1p1M;
        Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427160300eusmtrp11a05ef21462b132cd88f3aeacf09747f~pzE_N2fo72077420774eusmtrp1H;
        Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-85-626969340c0e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.97.09404.43969626; Wed, 27
        Apr 2022 17:03:00 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160300eusmtip201f34f7356e5fa50793f41df667dbd86~pzE93FBDa0262002620eusmtip2N;
        Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
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
Subject: [PATCH 04/16] block: allow blk-zoned devices to have non-power-of-2
 zone size
Date:   Wed, 27 Apr 2022 18:02:43 +0200
Message-Id: <20220427160255.300418-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGOffc3luq1duKcoZDA3GZ6AA/WHYG09Fs2a66LOr8w5EsrsAN
        EFsgLR0CWyjCXGGMQpkyCjJQRD62tUgVscUwIl8ilBUrYBiECcvEUBigjoFs7Voz/3ve9/ze
        5znvyeFDsZHy4yckpnCKRKkskBKQ1zqXrMFhCQnRuzpb92LD7U6IG37VUvjc3BLEvWf7CKzT
        fkfj5T4rxK2OMh4e+CuLwCNtLQSua+gg8KRBD3F+2xyJn+WNOXs5ExCvTOzGuvZ7AE/Z9QRu
        vb8T2x7U0th24X1sae0h8eCNcgp/XzNF48IzjyEeLpwCuKiriYcXLuXQ+KdHsyTuvr850p8d
        vHuIXe3+gWKLsh00ax1rJNnBPhV7pT6XYqvUZyHbVJ3JmisXCNY8oqbYb7IdFNvy5TiPnb1p
        p9gCUz1gDSY7yRY2NfIOi6MEb8VysoTPOEXo/k8F8Y1VD+jk3o2nzFoLrQa3RXnAm4+YMPR1
        7yWQBwR8MVMLkLZ5zlMsAnTBbCPcxQJA/6ibqecj7W0mD3UZoDvTpR7qIUCdZQPOgs+nmB0o
        K5d29X2YYYCKjMb/IMhMQzRgGiJcVhuY4+jb0XHo0iTzCsr/e4jn0kImHFXUnOe547aiUttT
        2mXqzUSgwvnjbkSEekonSZeGTiT7ahl0+SOmToB0agdwz76Lhn6f8fhsQNNdJtqtX0a9xfmk
        W2egqeFlz3CO8wVaDJQrDDnDCu7IXBIyQchwI9SNS9Dq5RwPsQ4Nz4jcV1iHdNdKoLstRJoz
        YjcdiFqWJj2hCA2eLveEsiinoo0uBAH6F5bRv7CM/v/cSgDrgS+nUsrjOOXeRC41RCmVK1WJ
        cSExSfIrwPmpe1e7Hl8HtdN/hrQDgg/aAeLDQB/hojk+WiyMlaalc4qkEwqVjFO2g818MtBX
        GJNglIqZOGkKd5LjkjnF81OC7+2nJjIWnn08sk3U9V7cB4pHofbqXVlfjRO6AEPW3U82pd5q
        YJPD7dvfWGO9KB+lFHHF8TMy66g6WHAycmv6kST52E6tRXJs7b4hWlG+/ORNSVpfz/XuCT/J
        bMpyR2rUO7+t2ZS+RTN+9ZfKe9qCqvhtPlBy86gl4+fXS95e9Boit1N7cmUzH22xcRsLin6E
        1ijB06bGksOOiy+l+b52LJJ3KrdWmKc63TNazjR1HInwPuB/6/ND4cUHeOv7g/YsZOp8+873
        9wOvCvMKnH015ol1Ler8IrvGWHzUcOLhfs2HB5k/kg9aYvdF+4u85jW1mSt1460RzfqgxID1
        loBzydXB80v5YZpAUhkv3b0DKpTSfwG1UqsyQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7ommZlJBjO3iFmsP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
        8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
        xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehkbFz5mLzgtWrG7fw97A+MpwS5GTg4JAROJQwe2MHYxcnEICSxllFi/fj8rREJC4vbC
        JkYIW1jiz7UuNoii54wS9w7uB3I4ONgEtCQaO9lB4iICTxgl7v98zALiMAs0sEjcmriLCaRb
        WCBMYtGrScwgNouAqkTPr+tgG3gFrCTmLZsLtU1eYual7+wgQzkFrCUmfIoACQsBlXQvugVV
        LihxcuYTFhCbGai8eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yfu4kR
        mFK2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuH9sjsjSYg3JbGyKrUoP76oNCe1+BCjKdDZE5ml
        RJPzgUktryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBKU0o8r2c
        c0vGDb+Q+80WSYcz9VMqFQJXmlr3rDjkvSuF6+j/Llk+9atRm7jPldSJbjlj8zXssc7Li6rc
        zI9Zfz2vemEqe/lL4M4V8y7O3sGeVlD3c1/SyWMh+6fv2iavcjNQTPpmROjh7Nq1T65JWh64
        qcdQ77JNV/DM6hn3pzQs0lDmEHL2vX3280kOownb3x/vnDRjVva6xaqyTzdHfqy/s+6Ktk9T
        pO/R7x3+PVfOqG2Z+jdbbTLnprD3AQ1q7wXMvc9POl6rMJFZ+XCW2ffljOKruvI1Us5+Zn63
        zvts5/bb59ledTZtEoxalqum/V0s+hVb8CG2swu3K/ZoXVwlVmcjEfzgz4t/O1c+P6zEUpyR
        aKjFXFScCAAgq28nsgMAAA==
X-CMS-MailID: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160300eucas1p1470fe30535849de6204bb78d7083cb3a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the calculations on zone size to be generic instead of relying on
power_of_2 based logic in the block layer using the helpers wherever
possible.

The only hot path affected by this change for power_of_2 zoned devices
is in blk_check_zone_append() but the effects should be negligible as the
helper blk_queue_zone_aligned() optimizes the calculation for those
devices. Note that the append path cannot be accessed by direct raw access
to the block device but only through a filesystem abstraction.

Finally, remove the check for power_of_2 zone size requirement in
blk-zoned.c

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-core.c  |  3 +--
 block/blk-zoned.c | 12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 937bb6b86331..850caf311064 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 		return BLK_STS_NOTSUPP;
 
 	/* The bio sector must point to the start of a sequential zone */
-	if (pos & (blk_queue_zone_sectors(q) - 1) ||
-	    !blk_queue_zone_is_seq(q, pos))
+	if (!blk_queue_zone_aligned(q, pos) || !blk_queue_zone_is_seq(q, pos))
 		return BLK_STS_IOERR;
 
 	/*
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 1dff4a8bd51d..f7c7c3bd148d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -288,10 +288,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 		return -EINVAL;
 
 	/* Check alignment (handle eventual smaller last zone) */
-	if (sector & (zone_sectors - 1))
+	if (!blk_queue_zone_aligned(q, sector))
 		return -EINVAL;
 
-	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
+	if (!blk_queue_zone_aligned(q, nr_sectors) && end_sector != capacity)
 		return -EINVAL;
 
 	/*
@@ -489,14 +489,14 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	 * smaller last zone.
 	 */
 	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
+		if (zone->len == 0) {
+			pr_warn("%s: Invalid zoned device size",
+				disk->disk_name);
 			return -ENODEV;
 		}
 
 		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
+		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
 	} else if (zone->start + args->zone_sectors < capacity) {
 		if (zone->len != args->zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
-- 
2.25.1

