Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5DB51D311
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbiEFIPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389874AbiEFIPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:15:07 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA296830A
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:20 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081119euoutp02386611b85492bb3a7099be86466ac70d~sdcta8v2m2355923559euoutp020
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506081119euoutp02386611b85492bb3a7099be86466ac70d~sdcta8v2m2355923559euoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824679;
        bh=D05Y2RArrxR/ZcNMh/RJzrqiPuoU2BIWW0WuxZX2YSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VsAfUpBLmXf2/ajLCRPa76Vk/2BChVoQIYsSXcpJuSuPLyMUhp8hcWAW4jkkfKZbh
         vGjh0KiKcK3oLhnpxRRf/1ITtWIz+5/6LMNebgKQRGeza/3Ks/T+0FM5skdon58rcf
         SSIl0T9N0hXie/AAEoJ0JbKZ6RWe/b8VhQPPOQDs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220506081117eucas1p18560a75e4c11c411a21dbd469ad119e1~sdcrdIYrQ1150211502eucas1p1S;
        Fri,  6 May 2022 08:11:17 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 7B.17.10009.528D4726; Fri,  6
        May 2022 09:11:17 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098~sdcq5Y3zG1330813308eucas1p2T;
        Fri,  6 May 2022 08:11:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506081116eusmtrp2b8dd7ad2a8ccfb56457e86d224868712~sdcq4cJxT2593625936eusmtrp2h;
        Fri,  6 May 2022 08:11:16 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-a6-6274d825056e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.03.09522.428D4726; Fri,  6
        May 2022 09:11:16 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081116eusmtip2afe9c6ce26251602c1ec15efeec5e217~sdcqkJr1p2097920979eusmtip2b;
        Fri,  6 May 2022 08:11:16 +0000 (GMT)
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
Subject: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Date:   Fri,  6 May 2022 10:11:04 +0200
Message-Id: <20220506081105.29134-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG8/U7PT00KR4KCV8ARTqZDlcciRlfpuJ0GxwyXWYyNqJZpMrh
        ErmYFjYufwwBQcBJxSnSiiBhykWtUgTLpdEayn2aclmp2QhCycBC3QChMnGUg5n//d73e973
        ed7ko6D4FulFxSelsPIkWYKEFBJNRsdvUn9zyrGPSqs8sabHCPGbNiOJ6/8oJvGlFw6IS4ov
        C/By/2OI22fVfPxk6RQPjzzQ8XBbVQkP19Z38PCERgXx2QcvCFybOwbxv2NBeGzeQuASwzDA
        1iEVD7dbtmPTeI0At7V3E3ig5QqJK65bBViZtwCxWWkF+Hynlo/nfs0V4NvP7QTusnh/upEZ
        GPySWem6STLnc2YFzOM/7xLMQH8q01BXQDLXsi5CRlv9E9M6kkUyP+fMkozu9CifseuHSOZc
        Yx1gNI1DBKPtzWSU2rv8r8WHhbuj2YT4H1j5jpAoYVxLeTM8OS5N653+C2YBzZZC4EIheicy
        vxokCoGQEtM1AC0uLAu4Yh6ghrybgCvmACq5/ZB8O/J62MZ3spi+AZBpMp4TTQF0eW4RFgKK
        IukAdKpgbZMHXQRQ8Wi+wDkAaS0fPbkV42R3OhSVjTv1LhRB+6OrttY1AxH9Cbq4+BJyZr6o
        zLS4Nuuy2s++MLWucUPdZRMEt9MX5dxTr+trhUhZ6sHx56jjTgXBsTua7mwUcOyD3ugqeBxn
        Iqt5GTqDIjp3NahOQzoPQPQudK4vwYmQ/gBpWnZw3X1If30Th67IPOPGBXBFJU2lkGuL0Jk8
        MbdbgnSOiXVPhAayr6xnYVDZSi1PCfxU75yieucU1f+2lQDWAU82VZEYyyqCktgfAxWyREVq
        Umzg8eTEBrD6o3tXOv+5D8qn/w40AB4FDABRUOIhclelHBOLomXpGaw8+ag8NYFVGIA3RUg8
        Rcfj78jEdKwshT3BsidZ+dtXHuXilcXzsnh1tB0pju7Hu/M+Hv3OxxHZNfmqIPmwVBrep7aa
        JBF+B6PSctn85w+NTRulfuXpOTUsk/Ht3hMrwV/s37Cn2br/Uc/32yqYpsyl1wdW3CMaN8ds
        zjV+Ftp92u1pyGya6aBtbM9g61BVwGRwmFeIuskUI7of4Tr44aZ7Wx16y6POopehcSP1v9fo
        3Cu2C23ZKTVhSzOZ+b6Vz5r1+qQzect2cKTP29YQrt7Qe9V81NPHrv1mBnp6LDvCWctXU9WR
        i11RsFIZadi7YJgPLop27FKktxqIfVvea/vl6bXgA2q7yG4/u63vkLFnOMNfGmXrrQ7beeF9
        Dx+i50byszF9soRQxMmCAqBcIfsPe4nZZkAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7oqN0qSDBr3GlqsP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlnsWTSJyWLl6qNMFk/Wz2K2
        6DnwgcViZctDZos/Dw0tHn65xWIx6dA1RounV2cxWey9pW1x6fEKdos9e0+yWFzeNYfNYv6y
        p+wWE9q+MlvcmPCU0WLi8c2sFp+XtrBbrHv9nsXixC1pB1mPy1e8Pf6dWMPmMbH5HbvH+Xsb
        WTwuny312LSqk81jYcNUZo/NS+o9dt9sYPPobX7H5rGz9T6rx/t9V9k8+rasYvRYv+Uqi8fm
        09UeEzZvZA0QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DL2DV3O3PBY92K069eMDcwrlfpYuTkkBAwkfh77Q1rFyMXh5DAUkaJK4evsUMkJCRu
        L2xihLCFJf5c62KDKHrOKPG//SZQEQcHm4CWRGMnO0hcRGAqo8SldSdZQBxmgdOsEls3HWAC
        6RYWcJOY+fg7M4jNIqAqMe/NbjYQm1fASmLq92/MEBvkJWZe+g62mRMo3jT5JViNkIClxPwl
        e1gh6gUlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
        czcxApPKtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8wrNKkoR4UxIrq1KL8uOLSnNSiw8xmgLd
        PZFZSjQ5H5jW8kriDc0MTA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamPh5
        otWbW6LLcvnYl5dub7hT0Mi0J+5k2ZKCg74mbC2t3+IWz+dTX5lXWPzBrrXIZ/LdSyIysrl+
        hfM02iQ/SYpcWn3lU92PHQX8ByxMmve9TDBXspw33VA1xfCwXdq8b4/kZYIrUple3pHTEnJ9
        f+/kTq6yiPrWI6e3fVw5LTP1zAXlUuZ2bb6Lp7WZdITeiR65zd2+4/mS4pfsu/buv/GQrXDP
        lHylFc6T+zdsT1vwXUOm3TQu58isGOWcZZ/OSGXqrL11OeKtkVoDj+x1Wal81Y5vJyW2zvCc
        tmrpe96rSXvarJID76mYPm5j336Iec8Wtb57uldu7t7ZapcsMlXg3RZWucUrD2vz/Ph8WIml
        OCPRUIu5qDgRAJTyJ6yzAwAA
X-CMS-MailID: 20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 5cb4c92cd..ed9a58201 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
 	if (dev->queue_mode == NULL_Q_BIO)
 		dev->mbps = 0;
 
-	if (dev->zoned &&
-	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
-		pr_err("zone_size must be power-of-two\n");
+	if (dev->zoned && !dev->zone_size) {
+		pr_err("zone_size must not be zero\n");
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

