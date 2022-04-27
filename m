Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8C512078
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241429AbiD0QHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241608AbiD0QGx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC623CAADD
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160259euoutp0293eed0e8e963e6ba35734a6d8a9e7419~pzE9Tvx7B1479314793euoutp02Z
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:02:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220427160259euoutp0293eed0e8e963e6ba35734a6d8a9e7419~pzE9Tvx7B1479314793euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075379;
        bh=kk01EsRG9bOHVzhx2cg7vI10rthuoQfVL8TCej8gbAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqFqteqGXSEnxZPhnX9rym6n42YAt++KmTUYH1akFOm0A7L9YLhwHpvVJ5z+0TJl9
         A71EFZm4I1wTNw7c+GIBonIM8041uzM6cxt8uvhd7XeS0ftGXi1kqVecDOT0q+lFCo
         xeb6kGclgglBpZfHmT9Vj1NgpQ/SIdZW/rLg5myE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160257eucas1p248f9fb67b38f65e92cd401d8333f1f48~pzE7tOLRh2334023340eucas1p2g;
        Wed, 27 Apr 2022 16:02:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 40.0A.10260.13969626; Wed, 27
        Apr 2022 17:02:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895~pzE7TkyRS2335223352eucas1p2Z;
        Wed, 27 Apr 2022 16:02:57 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427160257eusmtrp29abf9fbaa39f05eb9b4bd28a52f41a07~pzE7Sr62r2598325983eusmtrp2c;
        Wed, 27 Apr 2022 16:02:57 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-7e-62696931489b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 9B.71.09522.13969626; Wed, 27
        Apr 2022 17:02:57 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160256eusmtip1cbd768be896ffc9fa5c108cd32dcf1a6~pzE67wefT0884308843eusmtip1h;
        Wed, 27 Apr 2022 16:02:56 +0000 (GMT)
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
Subject: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date:   Wed, 27 Apr 2022 18:02:40 +0200
Message-Id: <20220427160255.300418-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se1BUZRjG+8539pzDjmuH1dEv6ebOaGGGMEZ+E0YxOniwGeCf2GiYkQVO
        sAWr7Epg6bTcDFaTywTCAgNYEFeXe1xEaUEuIcGwYMAQRrKjILAYEpctjOXQ5H/P+36/533f
        Z+ZjoPQ6tYdRqs7yapUiXEaJyYbO1f43XZTKIOdLeY7Y8HMnxOW/pVA4c2EV4t6MPgKnp2TR
        2NrXD3HrfI4ID6zEEni0rYnApeW3CTxl0EN8uW2BxP/oJjZ6CZMQ/z3pgtONdwE2D+sJ3Dr2
        Bh68X0LjwWsn8I3WHhKbmnMpnF9spnHqxSWIR1LNAKd11YrwYlECja8/spC4e8zh/Zc409AH
        3Hp3BcWlxc/TXP9ENcmZ+qK4mrJkiivUZkCu9vuvuJaCRYJrGdVS3Dfx8xTXlHhPxFluDlPc
        lboywBnqhkkutbZa5Cv9WHw0hA9Xfs6rD7kHisMst/afSWJjLGurQAsaJTpgxyD2LZRQnAJ1
        QMxI2RKAEjtnCaF4AtBYaRYtFIsAxa0li3SA2bQs1kcI/R8Aim9cEwnFNEC5+krKBlHsARSb
        vGneyY4AlFZVtTkWsjMQDdT9StiW72AD0f2lAdqmSXYfmjMvQ5uWsO+gnyz1pHDgKyh7cJm2
        DbVj3VDqnx8JiD3qyZ7aROAGEl+fs5kBsUVi9G3hVUrwHkdzGfNQ0DvQTFcdLegX0dOmfELQ
        XyLziHXLnABQSpOBEmK6oSt3wm0Sso7I0HxIwD2QtqN+i9iORubshRO2o/SGq1BoS1DSRalA
        y1DT6tTWUoRMcblboTiUXRVHpIK9+mfC6J8Jo/9/bwGAZWA3H6WJCOU1h1V8tJNGEaGJUoU6
        BZ+OqAEbX7p3vWupEZTMPHYyAoIBRoAYKNspedISFiSVhCjOfcGrT59SR4XzGiNwYEjZbkmw
        skohZUMVZ/nPeP4Mr/7vlWDs9mgJ57FrxzpaypPk28yPjpS997Z94ct7f/8x0hCou6Ct+DTT
        xzQiD5qCmdW3tnnq7PhdFTEOQSGqx9Ou4wULN2oVp9r78Yf+d/c93OUXG3D+QnPA5TKmx+Ne
        a87t4NKObBQ9kCaK9HTeb0l54fga3VnSoPOdtVLe098praqAoIyArNcr7Y95JMBqpf+Kw8MA
        l+wVL6/JyEsFeHbtqOcvbWLSNOeGcr52Hf9kVO7zHHKslOe99m510Tlv18SV5UBj++Gbzxe7
        6yas3Udq8h7QXvLxkxPrMX5yX+apn7d/dO+DO/nuV17V5p4kq+rP5x/kR2eHRq0KY277wT9i
        PIdkPieS/gqUkZowhcsBqNYo/gWtMydhQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xu7qGmZlJBmsu8VisP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
        8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
        xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehnv96sVdAhUvP/1k7GBcQdvFyMHh4SAicTnrbldjFwcQgJLGSV+PNjF2MXICRSXkLi9
        sAnKFpb4c62LDaLoOaPEll2TmECa2QS0JBo72UHiIgJPGCXu/3zMAuIwCzSwSNyauIsJpFtY
        IE5i5rFDzCA2i4CqxNun38FsXgEriYPvt7JAbJCXmHnpOzvIUE4Ba4kJnyJAwkJAJd2LbrFC
        lAtKnJz5BKycGai8eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltsqFecmFtcmpeul5yfu4kR
        mE62Hfu5eQfjvFcf9Q4xMnEwHmKU4GBWEuH9sjsjSYg3JbGyKrUoP76oNCe1+BCjKdDZE5ml
        RJPzgQktryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBidvFgLde
        KU2Y82fPlJdpbQYOeVKdrT8nT3Zp9Pj6z2de32p1k57g7xxG05c4HVkckRoT84zVlGX/068R
        548EqHmt61bz5bh/wTjjCUfeQ4bqHexaC7W2bOSLuPV7i+rMeyH8OUptHw5s2bp94dn6fd48
        xw08429uNq5fmZm7q8uq/KTxmvVfZy5uYXjf25yisU2u2EFIbncqy0K7WYa9j2bz3DRWNlwc
        /0XLevpHofcCOleeiO5kuMZeM2mD2aZzB1k4tN5POijOtaC4/L/gnT1nPbS5plTdKfk1cZv4
        KyPNxzP+OphweMVyeCp8dXoVczXr7Lbu0mUBOSv/Oa3N3OHt8YV/9cX87Pf163yclFiKMxIN
        tZiLihMBAepjMLADAAA=
X-CMS-MailID: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 8 +++++++-
 include/linux/blkdev.h | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8838..1dff4a8bd51d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -117,10 +117,16 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >>
+		       ilog2(zone_sectors);
+
+	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 60d016138997..c4e4c7071b7b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -665,9 +665,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1

