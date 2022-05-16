Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A748528B60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiEPQzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343969AbiEPQyj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:39 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD313C716
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:38 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165436euoutp01849a5bd6efaa5a078d03b2748141d798~vpCdB8JUg2836428364euoutp01P
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165436euoutp01849a5bd6efaa5a078d03b2748141d798~vpCdB8JUg2836428364euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720076;
        bh=8MOzPxdRNLcObOcfdHsKDSsDiJAEHid0X7DZChiwQRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZdFZKGYyJhhAXEYPGudaV/LR/WSC1UaKEBQgDN9H3Z1xv4F/+Y/dHL3dkvPKWFek
         9AbPPwMW1ZGXywk1ykQ1tJN7s+UyGB0B1bing9vbgbO71ZIoCny0insPl3b+p8sgvC
         0/dsHgY0WPk3oxeABE7PQcTFENwobsBGRsmkdoLY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165435eucas1p25e4514aea76156f58bbd4b55393fe2a2~vpCbr4a7r0930109301eucas1p2z;
        Mon, 16 May 2022 16:54:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 14.4A.09887.BC182826; Mon, 16
        May 2022 17:54:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165434eucas1p12b178fb83cc93470933e3d72c40e9004~vpCahQk6u0957909579eucas1p1t;
        Mon, 16 May 2022 16:54:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165434eusmtrp221b0a508a330117089d1382091d5eaa5~vpCagXzN41030710307eusmtrp23;
        Mon, 16 May 2022 16:54:34 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-49-628281cb2e59
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 91.10.09404.9C182826; Mon, 16
        May 2022 17:54:33 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165433eusmtip1f24d790faf28b78ebae9f4ad2376538f~vpCaBwBE00975309753eusmtip1g;
        Mon, 16 May 2022 16:54:33 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 11/13] null_blk: allow non power of 2 zoned devices
Date:   Mon, 16 May 2022 18:54:14 +0200
Message-Id: <20220516165416.171196-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djPc7qnG5uSDP6dEbRYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTRc+BDywWe29pW1x6vILdYs/ekywWl3fNYbOY
        v+wpu8WNCU8ZLT4vbWG3WHPzKYuDgMe/E2vYPHbOusvucflsqcemVZ1sHpuX1HvsvtkAFG69
        z+rxft9VNo++LasYPdZvucrisfl0tcfnTXIBPFFcNimpOZllqUX6dglcGX9X3WcvuK9b8fVu
        O1MD4xqVLkZODgkBE4ljTw8xdzFycQgJrGCUePJoGiOE84VRou/CaXYI5zOjxI+7s5hgWg5P
        WMzaxcgBlFjOKLHWESQsJPCcUeLE4hSQMJuAlkRjJztIWEQgS2LaiYdgM5kFDjNJPD86nxUk
        ISzgJvG5YxkLiM0ioCqx7+gGsDivgLXE//3vGSFWyUvMvPSdHWQmJ1B8dRc3RImgxMmZT8Ba
        mYFKmrfOBntAQmA5p8S3mYdZIXpdJBr/vWGHsIUlXh3fAmXLSPzfOR/qlWqJpzd+QzW3MEr0
        71zPBrJMAmhZ35kcEJNZQFNi/S59iHJHiV93jrBDVPBJ3HgrCHECn8SkbdOZIcK8Eh1tQhDV
        ShI7fz6BWiohcblpDgtEiYfE2vlGExgVZyH5ZRaSX2YhrF3AyLyKUTy1tDg3PbXYKC+1XK84
        Mbe4NC9dLzk/dxMjMPGd/nf8yw7G5a8+6h1iZOJgPMQowcGsJMJrUNGQJMSbklhZlVqUH19U
        mpNafIhRmoNFSZw3OXNDopBAemJJanZqakFqEUyWiYNTqoHJ5cXMyuX9W+VlX3/j803S51Pv
        1vn9Kcg/+PVxoQZTkYQVdfsi3mm84ZWPmBhsf7JYOrdr5fNmy8NXJA7d//v39dEY21Wqz8yZ
        TLxqtAwfqll4ixa+zFvjUmmpuvrymiQOtjus5/pP6xXtvlVTcehRimaDz/Y1YuKOEsWzV7ac
        fszlb35M+MPXC8Xu/Fp37VNu7F9wtqRgmnaD8up191UPbnr2VHF6dfSkuS3pwR+ulXk/9F1x
        W85n87SNiY7fPLRS/wg4O75I3HVdL13II3xxjaVm2L9KgdC33HKKF23LHj7KrZfjDzBaoM4U
        pP/k5Rmh8qy8K3PEM38+mdzJNzklIPj5g7jLS16uKnwSXq7EUpyRaKjFXFScCABUiwk/6wMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7onG5uSDGYcsrBYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTRc+BDywWe29pW1x6vILdYs/ekywWl3fNYbOY
        v+wpu8WNCU8ZLT4vbWG3WHPzKYuDgMe/E2vYPHbOusvucflsqcemVZ1sHpuX1HvsvtkAFG69
        z+rxft9VNo++LasYPdZvucrisfl0tcfnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
        lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GX9X3WcvuK9b8fVuO1MD4xqVLkZODgkBE4nDExaz
        djFycQgJLGWUuHzrFBtEQkLi9sImRghbWOLPtS42iKKnjBIzz78Dcjg42AS0JBo72UFqRAQK
        JOb0b2EBsZkFzjNJ7F/vDmILC7hJfO5YBhZnEVCV2Hd0AyuIzStgLfF//3uo+fISMy99ZwcZ
        yQkUX93FDRIWErCS+PrkFjtEuaDEyZlPoMbLSzRvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nz
        i430ihNzi0vz0vWS83M3MQIjdduxn1t2MK589VHvECMTB+MhRgkOZiURXoOKhiQh3pTEyqrU
        ovz4otKc1OJDjKZAZ09klhJNzgemirySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTU
        gtQimD4mDk6pBibRZ7c1v+UW/8pmsdngc7QoccO2z3KKRxmaZ9lt+nXt5rUDc9/+PbDd11V/
        roJ9yh+PE0fC5Ip8tS+dulrhX6wsEvB8vv41exshrZ+Mm5bfspSRabXwXfzuoKSlunpl0Eb1
        ++q8zo7LVwsv+yP+jO2F3PHrH+dt2VMwecaNwKcPn62fsp+PtWOayAbV339XZL4/3ntqxaVZ
        0fVTlnK/3tpbOjNFIXnJvAfy3bcmzxKQb/QwfmT3dXPZ5XkCBwrlM2QcGflWMbwJnDp75vML
        m+OVXJVbH1g9Y17Pamu43q1f3NA5ypQ5Ke3GBj3Bi3llGV+WFU1g4zrY6FxYyPqX+7yEz40v
        VzcIHJ0Z67P0jeNqJZbijERDLeai4kQAX7lHJV0DAAA=
X-CMS-MailID: 20220516165434eucas1p12b178fb83cc93470933e3d72c40e9004
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165434eucas1p12b178fb83cc93470933e3d72c40e9004
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165434eucas1p12b178fb83cc93470933e3d72c40e9004
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165434eucas1p12b178fb83cc93470933e3d72c40e9004@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the power of 2 based calculation with zone size to be generic in
null_zone_no with optimization for power of 2 based zone sizes.

The nr_zones calculation in null_init_zoned_dev has been replaced with a
division without special handling for power of 2 based zone sizes as
this function is called only during the initialization and will not
invoked in the hot path.

Performance Measurement:

Device:
zone size = 128M, blocksize=4k

FIO cmd:

fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
--io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
--loops=4

The following results are an average of 4 runs on AMD Ryzen 5 5600X with
32GB of RAM:

Sequential Write:

x-----------------x---------------------------------x---------------------------------x
|     IOdepth     |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
x-----------------x---------------------------------x---------------------------------x

Sequential read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
x-----------------x---------------------------------x---------------------------------x

Random read:

x-----------------x---------------------------------x---------------------------------x
| IOdepth         |            8                    |            16                   |
x-----------------x---------------------------------x---------------------------------x
|                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
x-----------------x---------------------------------x---------------------------------x
| Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
x-----------------x---------------------------------x---------------------------------x
|  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
x-----------------x---------------------------------x---------------------------------x

Minor variations are noticed in Sequential write with io depth 8 and
in random read with io depth 16. But overall no noticeable differences
were noticed

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/main.c  |  5 ++---
 drivers/block/null_blk/zoned.c | 14 +++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5cb4c92cd..53557e014 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("Invalid zero zone size\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index dae54dd1a..00c34e65e 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	return sect >> ilog2(dev->zone_size_sects);
+	if (is_power_of_2(dev->zone_size_sects))
+		return sect >> ilog2(dev->zone_size_sects);
+
+	return div64_u64(sect, dev->zone_size_sects);
 }
 
 static inline void null_lock_zone_res(struct nullb_device *dev)
@@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
-		return -EINVAL;
-	}
 	if (dev->zone_size > dev->size) {
 		pr_err("Zone size larger than device capacity\n");
 		return -EINVAL;
@@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
-	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
-		>> ilog2(dev->zone_size_sects);
+	dev->nr_zones =
+		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
+			  dev->zone_size_sects);
 
 	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
 				    GFP_KERNEL | __GFP_ZERO);
-- 
2.25.1

