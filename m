Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7F851D315
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389944AbiEFIPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389873AbiEFIPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:15:07 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3F468301
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:19 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081117euoutp025cf260067381ae4a9ad6cafd00c7907d~sdcrJwaVc2420124201euoutp02p
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506081117euoutp025cf260067381ae4a9ad6cafd00c7907d~sdcrJwaVc2420124201euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824677;
        bh=OUOs5yoREFPm133MftqN/52v0OJCiB1b6vGYcsnZpfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox2fxTOQi0JUjHEBmT3xShiTOMD2IrUcliRLqN4hpmQe0qP3cZT9cVMr7twwEwBhf
         X4VCDMst7t0sqEpLYa+bvvpY21brNNwnyAHEl+YeXso/Sll5qFA2GXWLRCQOqMfvOx
         qkZZpBomnfOtaPPgbSilhvbUDKYghi7x2wUNTaoA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220506081115eucas1p149ff9d68b993fc4a5063dd222afc58ef~sdcpXq2fr1708917089eucas1p1E;
        Fri,  6 May 2022 08:11:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 3C.3C.10260.328D4726; Fri,  6
        May 2022 09:11:15 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220506081114eucas1p1a9d86eb429a6f68c29d1980891f49786~sdco8BQZr1692416924eucas1p1y;
        Fri,  6 May 2022 08:11:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506081114eusmtrp1042f84b3b164a08add28bf24c817eece~sdco6cXhB3089330893eusmtrp1U;
        Fri,  6 May 2022 08:11:14 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-eb-6274d823e841
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 69.F2.09522.228D4726; Fri,  6
        May 2022 09:11:14 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081114eusmtip2ca889afa28846abc5660f97364a054cd~sdcolMwDn2098320983eusmtip2B;
        Fri,  6 May 2022 08:11:14 +0000 (GMT)
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
Subject: [PATCH v3 08/11] btrfs: zoned: relax the alignment constraint for
 zoned devices
Date:   Fri,  6 May 2022 10:11:02 +0200
Message-Id: <20220506081105.29134-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTVxjGd3pvby/direF4Qk4dXWE4DIciOZsyGYXEq/ZZiRmGXOTWfAK
        ZKW6ls4PllgpdIUxWiCCFhKHVFY+uoKtzAp0pmZ8DFiBggE6JYSyhQ+RAc4xJhv1YuZ/z3nP
        7znP8yaHxEQWIpTMkGcxCrlUJib4eHP7svu1bcNZKa8PGfjI+nM7hv5tbSdQ/V09gcrmlzFU
        or/IQyu9bgy1zVVwUd9f5zlo5JaDg1qvlHBQbf1PHOSzGjFUeGseR7W54xj6ZzwajS+N4qjE
        dQegySEjB7WNvooGJsw81NrWhSPPzUoCXa6Z5CGD9iGGhg2TABV32Lho8WouD30/8wBHnaNh
        e1+iPYPv0qudDQRdrJnj0e57TTjt6VXR1+ryCbpKfQGjbaZzdMuImqC/0cwRtCNvjEs/cA4R
        dJG9DtBW+xBO27qzaYOtiXtQdJi/5xgjy/iCUex46yg/3fnYjp2coE43mbw8NbgrKAABJKRi
        oaG8ligAfFJEmQHsmRnA2MMSgE7NGO6nRNQigD9cjX3q0FpMOAt9B2Cn1k2w0BSAt0vXIJIk
        qO3wfD7PzwRTXwOoH/uK52cwysaFfZbjfiaIOgyNZWH+MU6Fw6rFaY5fC6g3YGO/jstmbYGX
        Bh49sQZQb8Kc0imCZYSw65IPZ5/cAjXXK56UhpSFD8sn8jDWnABHVhd4rA6C0x32db0JdpcW
        4qzOhpPDK+vm3LWiDivhLwepOFjUI/NLjIqE1ps7WFwCZyvLAEsEwuH7QrZCICxpLsfYsQDq
        tCKWFkPHsm89FEJPTuV6KA1Now6uAbxsfGYZ4zPLGP/P/RZgdWAjo1JmpjHKnXLmVJRSmqlU
        ydOiUk9kXgNrP7p7tePhDWCe/iPKBTgkcAFIYuJgQZAxK0UkOCY9c5ZRnPhUoZIxShcII3Hx
        RkFqRqNURKVJs5jPGOYko3h6yyEDQtWcQwUtvz+XTA5Mki9IIg+dqq5O3bVvIV3/QW9i3eO8
        zSHB4ae58o8cpsWGBMVv6hTlzninWzKjR0XFVcnJfd7rZRezowOrvX2S3XFJ4sScqOoD3oj4
        NOnlXQstAce1+0Ljv4xTdplvuAvyrBnCIy2z5ed0fdOeWotYFv1ekdd35ExN7+dUzeaYkAMj
        zuDIqoKkxM57H7p6TXtcGwI3rdY0R9T0k++/czQqQpLcOGP8ZZDv01nlXZ8EXDFt3TDv3u38
        O+nFqdv7hdIfNRWq+ldC7Gefb/CUmhOKRq2xd5B0//2Yg28XdusebZuIH4zpWdmq7NcvhEcI
        nfl7db8uueb+nP1YjCvTpdHbMYVS+h9evVhdQAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7pKN0qSDGYf0LBYf+oYs8X/PcfY
        LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
        0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
        T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
        snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
        p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXse/vFuaCxwIVG5fcZm9gvMvbxcjJISFgItG2dgkLiC0ksJRR4tM6aYi4hMTthU2M
        ELawxJ9rXWxdjFxANc8ZJS78+87UxcjBwSagJdHYyQ4SFxGYyihxad1JFhCHWeA0q8TWTQeY
        QLqFBSIkOhdcBpvEIqAqsfDzK7A4r4ClxIaLHawQG+QlZl76zg5icwpYSTRNfskGcZGlxPwl
        e1gh6gUlTs58AnYpM1B989bZzBMYBWYhSc1CklrAyLSKUSS1tDg3PbfYUK84Mbe4NC9dLzk/
        dxMjMKVsO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIrPKskSYg3JbGyKrUoP76oNCe1+BCjKdDd
        E5mlRJPzgUktryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBaf/n
        CanXEmV6eT3vemyJ0Dg/8Yul3eG7Tz7sXshw1vS/zZmLMUtaNe9MWhM/WYh3Fv/aiHPB6r2R
        1fdNT/7aKrvx5r/Zex8vD2pPsp+p8C84v44344Xf6uhbK5Y/bTyn5L4q+e+Sw2cet/62bqye
        mSzHy9Off8B4WvWT/OC+U7cSS+58kXWxOvr3617RaemOiSwPt9pZHb9d8HFJ/acdRxQUu0NW
        Ba//cvHD26JZ7ludgmPMPrx5+sPEXEf/ktz3Q5ODJ/+5tTm/0yrw7vZUTakkZuW1Ua/OPxG9
        LdtbdljKd9Ka1w49/fOOafMWrCzs/G8bUa2TpfUxbG/HHuULB+aeW71LqXv+oYdxQS4dmzcq
        sRRnJBpqMRcVJwIAVe6YGbIDAAA=
X-CMS-MailID: 20220506081114eucas1p1a9d86eb429a6f68c29d1980891f49786
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081114eucas1p1a9d86eb429a6f68c29d1980891f49786
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081114eucas1p1a9d86eb429a6f68c29d1980891f49786
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081114eucas1p1a9d86eb429a6f68c29d1980891f49786@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checks were in place to return error when a non power-of-2 zoned devices
is detected. Remove those checks as non power-of-2 zoned devices are
now supported.

Relax the zone size constraint to align with a sane default of 1MB.
This 1M default has been chosen as the minimum alignment requirement
for zone sizes to make sure zones align with sectorsize in different
architectures.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3023c871e..a6b15fbe1 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -54,6 +54,13 @@
  */
 #define BTRFS_MAX_ZONE_SIZE		SZ_8G
 
+/*
+ * A minimum alignment of 1MB is chosen for zoned devices as their zone sizes
+ * can be non power of 2. This is to make sure the zones correctly align to the
+ * sectorsize.
+ */
+#define BTRFS_ZONED_MIN_ALIGN_SECTORS       ((u64)SZ_1M >> SECTOR_SHIFT)
+
 #define SUPER_INFO_SECTORS	((u64)BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT)
 
 static inline bool sb_zone_is_full(const struct blk_zone *zone)
@@ -394,8 +401,8 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	/* Check if it's power of 2 (see is_power_of_2) */
-	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
+	ASSERT(zone_sectors != 0 &&
+	       IS_ALIGNED(zone_sectors, BTRFS_ZONED_MIN_ALIGN_SECTORS));
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
 
 	/* We reject devices with a zone size larger than 8GB */
@@ -834,9 +841,11 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
 	ASSERT(rw == READ || rw == WRITE);
 
-	if (!is_power_of_2(bdev_zone_sectors(bdev)))
-		return -EINVAL;
 	nr_sectors = bdev_nr_sectors(bdev);
+
+	if (!IS_ALIGNED(nr_sectors, BTRFS_ZONED_MIN_ALIGN_SECTORS))
+		return -EINVAL;
+
 	nr_zones = bdev_zone_no(bdev, nr_sectors);
 
 	sb_zone = sb_zone_number(bdev, mirror);
-- 
2.25.1

