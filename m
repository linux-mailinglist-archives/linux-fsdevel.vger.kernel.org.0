Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22752858B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbiEPNjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEPNje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:39:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673B02ED5D
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:39:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516133925euoutp026f82d90a45761e47e367f8aef0720522~vmYB7uw4Y1691716917euoutp02H
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:39:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516133925euoutp026f82d90a45761e47e367f8aef0720522~vmYB7uw4Y1691716917euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652708365;
        bh=lp2K3w6bYU/ZGZyfjOrT9sOG4NQYsIr+x+HLsdgsemk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nOWORd4AfFrN7l2w3S0xmHEnQ/ZbOO8LVWl2IOPyzjDMFINWUxOjgcKGByZ65pXGs
         rkcNkfGAssHJY36MUNPcfYF0EVpqiE0cYJBlDVomJ7XN5KM31xlq74o7VMEgfUYapP
         HVlg3xJo2p8220y11HRvZSMBCHRRGWMU88mqOkPQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516133924eucas1p1ce443c5d9f87c66f4894c04cd19e36a9~vmYBI5QGu2650326503eucas1p18;
        Mon, 16 May 2022 13:39:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id FB.63.10009.C0452826; Mon, 16
        May 2022 14:39:24 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe~vmYAu07kH0938909389eucas1p1H;
        Mon, 16 May 2022 13:39:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516133924eusmtrp2253fa48c94ce75c557e02eed2bde92ce~vmYAt3p8V2487324873eusmtrp2W;
        Mon, 16 May 2022 13:39:24 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-d1-6282540c215b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BD.F8.09404.B0452826; Mon, 16
        May 2022 14:39:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220516133923eusmtip2914598b7fb7adcf22231e7d26d1c0a73~vmYAj0utC1834618346eusmtip2e;
        Mon, 16 May 2022 13:39:23 +0000 (GMT)
Received: from localhost (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 16 May 2022 14:39:23 +0100
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 01/13] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date:   Mon, 16 May 2022 15:39:09 +0200
Message-ID: <20220516133921.126925-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG8957e3tprF4q6BtAl1TdFsyYHYt7HWxOQ7K7sWzGj8WRLfNS
        7oBYUFuKOONW+cpEPgqbMIoLU5kgoEUoDLRAabAFLYLlI9BFTcPHCBPEViMdFEe9uPDf75zn
        Oe9zTvJSuKSaDKISk1M4ZTKrkJIiosniufvWqv3psdsejgQj/W0Ljl4YLSSquV9AouJZD46K
        Cn4VovmeXhy1zpQJUN/caQwZLxZh6ErNLQyN6XU4yjXNEsib82Cpl+nE0YJThpxPHQQqMg8B
        ND6ow1CrYyuyj1YJkbG1m0D9N86TqPzyuBBps5/haFg7DlChtUGArv3zmEBdjuCPQpj+gWhm
        sauWZAozZoRM74PrBNPfo2bqq8+QzAXNOZxpqPiRuTmiIZm8jBmSacl6KGAetw2SjN4wSDAN
        d04y2obrAsZdv3GPf4woMo5TJKZyyrc/PCRKyL90ERwtDUgzuX/GNMBB5wA/CtLvwrmi55iP
        JXQVgDXlqTlAtMRPAWzMH8T5wg3gcHel8NXEv4VZQl6oBNDU9oj439U+OQf4wgBg9YBtSaEo
        kg6Fp8+8nAigOwD09FVhvgKnbwugy9uJ+UxraTm0V4b7Igh6C3w2kwV8LKbfh01z88vRr8FS
        +3Ohz+5HR0BX/k7e4g+7S8cIH+NLlozGMpxnCDsmJ3GfHdJSWNYfxr9yCl612F6uA+l7Ipit
        bSd5IQrqb15b5rVwympYjg2BL1rKMZ5PwvHheZwfzgSwoEVP8gERMN+m4D274C/NIwTfXg2H
        p/35dVbDoqaS5XXE8KdsiRZs1q04QLfiAN2KA34HeDVYz6lVSfGcSpbMHQ9TsUkqdXJ8mPxI
        Uj1Y+s53Fq2uZvDb1JMwM8AoYAaQwqUB4m1pmliJOI498T2nPPKtUq3gVGYQTBHS9WJ5Yh0r
        oePZFO4wxx3llK9UjPIL0mA7PqvtXNeZ5nY6N02VxJS7jP2JadvtgW15Iqc5e+Lv0b49Z6MT
        G1Ki/jK9sWVnWfgH9xMEpyTTtoC41K7Z3e3rGvcVFG/IdG/slV0GjU+aD83jsTEzrxfbLXFv
        pqZHZRyrOBe9Y3ueQ9uTbcGTHiVExBgpmfzKlyHH9R9XKJjvRvdfna6jOrxJBj8zqvvKsm/V
        4q2FPw8GbCCHJu1315QLTDCUTMk7nD5kG26vE0eumXBsjg6fuPG5bcqz68DXQbnvpQyIMqzJ
        f7xzfm+7fOvsPdbk8gZ/M7bpUpM10JB24lhtiWJ3ri7ykwnDwQOfBqqtfmf3ekWeXrbzhy8W
        LgSypVYpoUpgZaG4UsX+B1fD49w9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsVy+t/xe7o8IU1JBuscLNafOsZs8X/PMTaL
        1Xf72SymffjJbDGpfwa7xe+z55kt9r6bzWpx4Ucjk8WeRZOYLFauPspk8WT9LGaLngMfWCz+
        dt0DirU8ZLb489DQ4uGXWywWkw5dY7R4enUWk8XeW9oWlx6vYLfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MarHu9XsWixO3pB1kPC5f8fb4d2INm8fE5nfsHufvbWTxuHy21GPT
        qk42j4UNU5k9Ni+p99h9s4HNo7f5HZvHztb7rB7v911l81i/5SqLx+bT1R4TNm9k9fi8SS5A
        MErPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7MstUjfLkEvo2/x
        IsaCmSIVBz5PZmpgvCXQxcjJISFgIvFrYit7FyMXh5DAUkaJeRsesUAkZCQ+XfnIDmELS/y5
        1sUGUfSRUaL77HoWCGcLo8S1hs2sXYwcHGwCWhKNnWCTRAQOMkr8vLCCCcRhFjjFKvHz+Bew
        scICiRKzfrwHG8sioCrx9V0rI4jNK2Alse3Hb6h18hIzL31nBxnKKWAt8anPHsQUAipZ/6YI
        olpQ4uTMJ2ATmYGqm7fOZoawJSQOvnjBDFIuIaAkMfuyHsTAWolX93czTmAUmYWkexaS7llI
        uhcwMq9iFEktLc5Nzy020itOzC0uzUvXS87P3cQITF3bjv3csoNx5auPeocYmTgYDzFKcDAr
        ifAaVDQkCfGmJFZWpRblxxeV5qQWH2I0BXpyIrOUaHI+MHnmlcQbmhmYGpqYWRqYWpoZK4nz
        ehZ0JAoJpCeWpGanphakFsH0MXFwSjUwmQr9iUw/e0nf+tSnt6ynug+pnNI79T+xwvf034qz
        Hx79CLmyMCXo/pv7M4TW/NX87cRjvrVS+3Tm4ckpBz9E736VcMdr0kMmC88S/hPLWDfOv39n
        0ZPwBanL0mdsb3FS+XqrfvbsI44Bsbaap9s1ND9mXMhJq3275rHdXK6/76rXfOLQflB7IIlt
        xdML52fcW9y9+WugrnZMzPHkgOo7HKtme22XV+k+3mKXuc2g8tmaEPslTrobTl6bdKq4tnfT
        8+nv72bNijrsvL9K9Mts79R1p90f3paqrLY9xxzsuvvVm1cP/1y5fCy14llm+detJqF7n59X
        esqfLVC35feLKQ+UzJXfGi48f/aF8NzlOWxFSizFGYmGWsxFxYkARGhRPuYDAAA=
X-CMS-MailID: 20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe
X-Msg-Generator: CA
X-RootMTR: 20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe
References: <20220516133921.126925-1-p.raghav@samsung.com>
        <CGME20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 13 ++++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8..140230134 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
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
index 1b24c1fb3..22fe512ee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
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

