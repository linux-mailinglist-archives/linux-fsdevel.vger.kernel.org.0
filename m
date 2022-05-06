Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A7251D30C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389909AbiEFIPv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389882AbiEFIPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:15:08 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0754268311
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:21 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081120euoutp01f81030ae95291fe27254b29cd7e9c2a0~sdcubyLvd2290722907euoutp01G
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220506081120euoutp01f81030ae95291fe27254b29cd7e9c2a0~sdcubyLvd2290722907euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824680;
        bh=2XMubIyolz4ZLTc9DAEWfdq40b874mLFKF8nTtEYP/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1dSw+VtkcpEeMiIDVUwkpheUzxNb4HFT/dryBCGIPn4nyAb8PMRi9cDp+Y4Pppp8
         2Wd/rOb9FGzGk5TtNBUvQUYffiKQUcITziO/EaTtnRTZxPnjsGuHDwhhZJEot1LQBg
         ccB6liw0P4iquWO9fecN7mwKfhn38/BylsM+dP6o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506081118eucas1p2cfcc398efecd5a38c185c6cd71cf243e~sdcslGTqR0618406184eucas1p2f;
        Fri,  6 May 2022 08:11:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 53.15.09887.628D4726; Fri,  6
        May 2022 09:11:18 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a~sdcsEWQBd2880428804eucas1p12;
        Fri,  6 May 2022 08:11:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506081118eusmtrp26f98e34ad16879dc8bda415db8d5ed37~sdcr-ioOA2593625936eusmtrp2k;
        Fri,  6 May 2022 08:11:18 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-55-6274d826672c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 05.03.09522.528D4726; Fri,  6
        May 2022 09:11:17 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081117eusmtip1c4f0939db628ec5dc1a8f468ad7710a9~sdcrnO9IP2776127761eusmtip1U;
        Fri,  6 May 2022 08:11:17 +0000 (GMT)
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
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Fri,  6 May 2022 10:11:05 +0200
Message-Id: <20220506081105.29134-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTZxjde+/t7aWk5tpieKPOMRZUmIK4TV43wzQScxdCtrB/sukq3GDD
        h6SlcwMj5XuIQmHK1sIUCVVoDRWKfNjiGBPKh1+zdIMqIoE6wFERgcJwMsrtMv+dc97zPOc8
        yUvhIgO5npImp7KyZEmiPykgmroW72zfPJB6ZEdbRwAy9HbhaNncRSL9UDGJyqYXcVRa/CMf
        Ld2+i6M2ZzkP3VvIxNBgeyuGzFWlGKrVd2JozKDB0en2aQLV5ozg6OVIKBqZtROotON3gBw2
        DYba7O+i+6M1fGRu6yGQ9XoFiS5ccvCRKm8ORwMqB0AlFiMPvdDm8FHd02cE6rZv2PsmY+2P
        ZF51XyGZkmwnn7n7qJ5grLcVTIOugGQuKs/hjLE6gzENKknmTLaTZFpzh3nMsxs2kilq1AHG
        0GgjGGNfOqMy1vM+Ex0U7IljE6Vfs7KQ8K8ERy3WeyDlrOCbXqseKMEl6hTwoiD9PtTWF4BT
        QECJ6BoAH5vGeRyZBdBsM3vICwDbXadXbNTqiO1KDKdfBvC8bobPkQkAa83DfLeJpINgZsGq
        7kMXAlg8nL9KcNrIg0PDRaQ7XEx/Dv8wzmNuTNABsM7QSbixkP4QqjKnCa7gW1B938V3Y68V
        Pev7CZLzrIU96rFVD77iyb5WjrsDIF0rgK6lXE/VCKju3MPtEcNJSyOfwxvhcusFjMPp0DGw
        5JnNWWnaaiC52Y9g0a1EN8TpQGi4HsLZ98Eq+7hn+xo4MLWWa7AGljb9gHOyEH6XJ+Lc/rB1
        ccwTCqE1q8JzFAPLK9V8FXhb89otmtdu0fyfWwlwHfBlFfKkeFa+M5k9HiyXJMkVyfHBsceS
        GsDKn+57ZZltAZcnnwd3AIwCHQBSuL+PUKxJPSISxkm+TWNlxw7LFImsvANsoAh/X2Gs9KpE
        RMdLUtkElk1hZf+9YpTXeiW2UzCRkLf8IJ+yhBGftmcXntBONZsuYjeRxXa1aGvl1p+Hx/vm
        dk/vCDoex5yM8k6TZEivfbKueNONFj/vJ/Cv30i/Hqz5xJfbBHX7wsIKt2XIw3eF7npYs7Dx
        qX1v1MvJxvMu07LXA33ErTJJRMRMWuQv9VmWd9j+8OjuUXFZ/1L0yQrZk9mbVNWWwN262PKQ
        g1tcf9eNfXDoTm7+4875L6pJ6kzGw58C9ivVgedCZ0bnP66L8XUWmqN9R/z221qYkqahNyLt
        c+t8ZM9Nvx42NYz2PsqNKdqsjU3H21GzuNp7qrZX6zyQ8OehhX/0AdUHNqU46MHxs4o8oI7a
        PqF+zyj1J+RHJaFBuEwu+Rey+TUmQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xu7qqN0qSDDYvsbJYf+oYs8X/PcfY
        LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
        0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
        T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
        snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
        p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXcfzyBcaCKVwVpy6vZmxgXMbRxcjBISFgInF1TXQXIxeHkMBSRol1Pf3MXYycQHEJ
        idsLmxghbGGJP9e62CCKnjNKfN78ngmkmU1AS6Kxkx0kLiIwlVHi0rqTLCAOs8BpVolf15+A
        dQsLBEp83v2dFcRmEVCVWLf+KAuIzStgJTGh8QMLxAZ5iZmXvrOD2JxA8abJL9lAbCEBS4n5
        S/awQtQLSpyc+QSsnhmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpec
        n7uJEZhSth37uXkH47xXH/UOMTJxMB5ilOBgVhLhFZ5VkiTEm5JYWZValB9fVJqTWnyI0RTo
        7onMUqLJ+cCkllcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwGS+
        W+dpG8+s4r36PFsDNybJsRZ3K9n19DxeEsPCINj17Ymq+VfpT1cnXz6x49eN31brPs6U7p8i
        MaGvam1hmWhp8AvVgjnX+Bze/6611v8Y+FT97oWt1uZLt/cfWcPfrDu7p/XfbbXUw4ZCyTO2
        qbm4BeiXtUfeEf+leNHy8hyNf0YnGkSu3FPZx+m8/E39jKZdXYoXxa4Hek8qPFm1zv7emZod
        c5ax/Wz4tXBLwuSkT0t/mnP3sfCXveQNZX8dvPrSM0P/OHW+A5J/suIdq7N3XOpYYm3We7m/
        Q+GAnmiZjMA6q/UybSnfXX9Xz95c8Sv3h+AMc0dvg6zE9pcbLtVNFUx1sHwVHCdz4+k2ESWW
        4oxEQy3mouJEAKGoBKayAwAA
X-CMS-MailID: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3e7b1fe15..27dc4ddf2 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	struct request_queue *q = md->queue;
 	unsigned int noio_flag;
 	int ret;
+	struct block_device *bdev = md->disk->part0;
+	sector_t zone_sectors;
+	char bname[BDEVNAME_SIZE];
+
+	zone_sectors = bdev_zone_sectors(bdev);
+
+	if (!is_power_of_2(zone_sectors)) {
+		DMWARN("%s: %s only power of two zone size supported\n",
+		       dm_device_name(md),
+		       bdevname(bdev, bname));
+		return 1;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
-- 
2.25.1

