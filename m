Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8DD51200D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241706AbiD0QHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241713AbiD0QG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:56 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF3D3D2803
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:14 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160308euoutp02a0eb11546769177dd9ddafda49e9b72d~pzFFZkhpP1441914419euoutp025
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220427160308euoutp02a0eb11546769177dd9ddafda49e9b72d~pzFFZkhpP1441914419euoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075388;
        bh=ffM16ryPWJ6fYXTfy7LXC81hPnUdkDXlmIiQv6XuFeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czoz1DZUIJLQgdra6izfn4a61lOGG0j0S0wfOzB8x8exfU2X28fKGL4qHJ39d5VY+
         WUWf6Ztcs04m1E8JqK34dwgeFD3FR5hg2Gn9H9P3VqQgSn+f+UY+tgMYC/+lovSBtC
         XAT+CPidHuIqFVx2zfla6R15Zl23cUuwQEDlt4o8=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160306eucas1p2e570e1b4e34a5067bb507ed05d2d73a6~pzFDvZ7kA0627806278eucas1p29;
        Wed, 27 Apr 2022 16:03:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 5A.0A.10260.A3969626; Wed, 27
        Apr 2022 17:03:06 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427160305eucas1p26831c19df0b2097e42209edcf73526b7~pzFDM2UI22337723377eucas1p2c;
        Wed, 27 Apr 2022 16:03:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427160305eusmtrp1235314abc78e18282c5dc2e5777199f2~pzFDL4Ere2077420774eusmtrp1T;
        Wed, 27 Apr 2022 16:03:05 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-92-6269693aae9b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.A7.09404.93969626; Wed, 27
        Apr 2022 17:03:05 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160305eusmtip22f05675131d051368efed5b5a469ebf6~pzFC4wzQ40262002620eusmtip2Q;
        Wed, 27 Apr 2022 16:03:05 +0000 (GMT)
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
Subject: [PATCH 09/16] btrfs: zoned: Make sb_zone_number function non power
 of 2 compatible
Date:   Wed, 27 Apr 2022 18:02:48 +0200
Message-Id: <20220427160255.300418-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxzOuef29tKs7lIqHsW5rQvZxgaKmnAyl4VtZrsJxgc+ZmZ8FLyB
        ulJIK5ubSywPmRCgBdRZHhOq2FKQ8pIIDAY1vGSAo2MD3BCEymQTxBaB4Mgot2b+9/2+8z1+
        v+TQUGKl1tEK1UlOrZIrZZSIrG1b6Al8T6GI2NSSJ8HW220Ql/6po/DFxwsQd13oJnC27pIQ
        L3b3Qtw4lSfAd+YTCDzYXEfgktJWAo9bcyFOb35M4n/Thpe55FGIn40G42zbbwA7+nMJ3Dj0
        Du4bMwtxn/FT/GNjJ4nt9fkUvnzNIcT6lFmIB/QOgLPaqwXYWZwsxOV/T5O4Y8gv9BXW/msY
        u9RRRrFZSVNCtne4kmTt3fFslSWVYou0FyBbffUM21DoJNiGQS3FZiRNUWzd2XsCdrqpn2Iz
        ayyAtdb0k6y+ulKwW/K56P3jnFLxJafe+MExUbQx2yCM61h7ajjfQGrBvDQNeNGI2Yp+aUkU
        pAERLWHMAJmKejyDC6C7nW2AH5wA3fzuLPXc4iobhm4sYUwA1bd686KHACWZ7cI0QNMUE4AS
        UoVuXsoMAJRVUUG4B8hMQnSn5nfC7fZhDiNTbzvpxiTjj7pnL62kipltKMVsI/m2V5Ghb24l
        1GuZ1z85yEu8UadhfEUClyVJN/KgOx8xxSKUqFsS8t7taGLMJuCxD5psr/Hw61FXTron/zRy
        DCx6zMkA6eqslLsMLZdl/qx0Q8i8jaz1G3n5h2g287KAV6xCA4+8+RVWoeza7yFPi9G5FAmv
        lqG6hXFPKUL2xHxPKYtGbpgoPXg994Vjcl84Jvf/3kIALWANF6+JieI0W1TcV0EaeYwmXhUV
        FBkbUwWW/3TXUvvsTWCenAmyAYIGNoBoKJOKXQ3RERLxcfnX33Dq2KPqeCWnsQE/mpStEUcq
        KuQSJkp+kvuC4+I49fNXgvZapyVU5fGBIuX0oRhd3ga69eJqcdq3m8/cmgxITwh5su+NQ+oh
        rVHzWVHJjvICYWJTM5MR5COaeaAr236/+lyzc1Np+N2/8lLX5ty6vot2ZvpuVspUhccmiuWa
        bfOOj0IfFl45+klbP/Hmbik+YHatLhjNIrhrfyTfNnjtcPpfV0zO5VSFGg/Gfpzdu7VEdl/v
        mIl7FBOmM0sGIwq2CGqDZXMTu06E//PynpCxFlm+cXDvS75HAsubfIM39LwlbQYW7ZLpQOqR
        pxHP6rmFFL+Cd21XmMU9O8sy/cJdA/bwn4Z3jozAH+DT84cr66szHogTwvxPnDKtX7SEJO7b
        z/jvlUW+dvqejNREy4MDoFoj/w824O1PQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7qWmZlJBsfP61isP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
        8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
        xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehmLJs1kLzghWXFvzkyWBsYfIl2MnBwSAiYSX9bcY+5i5OIQEljKKPF+xwoWiISExO2F
        TYwQtrDEn2tdbBBFzxklbs8AcTg42AS0JBo72UHiIgJPGCXu/3zMAuIwCzSwSNyauIsJpFtY
        IFqib9czdhCbRUBV4uzXGcwgNq+AtUTbikNQ2+QlZl76zg4ylBMoPuFTBEhYSMBKonvRLVaI
        ckGJkzOfgJUzA5U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC
        U8q2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrxfdmckCfGmJFZWpRblxxeV5qQWH2I0BTp7IrOU
        aHI+MKnllcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwSeoz9Aau
        c5v8yPPef/mGLUcSK5P+ZIqqOZWK3bvHsspW/llBw4I/NU99v5rwSnCbvDs9UV4ibv1S1RY+
        0QuzAmcu+rxcbfJKpbAjr1dFPnF0/e/3KGt67q6Lh6ed1o7PbfBsu6UcGCr/57r8tDk9ftfU
        05LtZqixcLE8ZeAx5p3ztszaP27ijf3Ce701NbNVH+WcnCBwumHJvebD5cd7Za+rRe94yyZ5
        Jef8T+F0+2rR3Kkq/y6fPnlZe5OMUd6yB3t5up4mFNhO6l9Zp2K3iFmj+qXcFRVdZom5qrf0
        FWX3MEgtv/4j1/cEv/n5Q6mMd8w7T7CyH+XpuzUpTcxTtWwlx8xUEZ6pk6r3rZyhxFKckWio
        xVxUnAgAjuFRN7IDAAA=
X-CMS-MailID: 20220427160305eucas1p26831c19df0b2097e42209edcf73526b7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160305eucas1p26831c19df0b2097e42209edcf73526b7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160305eucas1p26831c19df0b2097e42209edcf73526b7
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160305eucas1p26831c19df0b2097e42209edcf73526b7@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 6f76942d0ea5..8f574a474420 100644
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
@@ -515,7 +520,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	/* Cache the sb zone number */
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
 		zone_info->sb_zone_location[i] =
-			sb_zone_number(zone_info->zone_size_shift, i);
+			sb_zone_number(bdev, i);
 	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
@@ -840,7 +845,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
@@ -964,7 +969,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-- 
2.25.1

