Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6677951D2FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389848AbiEFIPs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389877AbiEFIPH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:15:07 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDC568307
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:20 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081115euoutp0131f028ebf81a04f3c73e2a7878c1d389~sdcpLia5t2376223762euoutp01n
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220506081115euoutp0131f028ebf81a04f3c73e2a7878c1d389~sdcpLia5t2376223762euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824675;
        bh=LMzILViEYGl7DXa37dpeTA+tqVrqwK5EcVpc6Ix2yY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obP4nF7chR4bizNpPP4tT3YwhWmITRtJcuxwOUr1oUk/UX96RZoauA4G8l4G0zeIg
         mC049hre2KQPq/WQ4sKYBy3KQLdG6UMHBMbsAvfwBFJfyfAozDaHXrKVPhFp/nnKGK
         mtmkm7jfAOQY1orlMwE7h4KflOFV9GruFyN1sjTs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506081113eucas1p2f26a6d8f18f7cbb7ff59652198904281~sdcneF8rQ1186311863eucas1p2N;
        Fri,  6 May 2022 08:11:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id C3.17.10009.128D4726; Fri,  6
        May 2022 09:11:13 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506081112eucas1p2f6116cb713749c259a6da533df9c2505~sdcm-zlTq0616806168eucas1p2r;
        Fri,  6 May 2022 08:11:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506081112eusmtrp1cb2b5b25d973a47abc875150c38a6a35~sdcm_v8_A3089330893eusmtrp1R;
        Fri,  6 May 2022 08:11:12 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-96-6274d8216386
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F4.F9.09404.028D4726; Fri,  6
        May 2022 09:11:12 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081112eusmtip29939a1aabce6a042ae1abb239d666502~sdcmlVHIw2136621366eusmtip2V;
        Fri,  6 May 2022 08:11:12 +0000 (GMT)
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
Subject: [PATCH v3 06/11] btrfs: zoned: Make sb_zone_number function non
 power of 2 compatible
Date:   Fri,  6 May 2022 10:11:00 +0200
Message-Id: <20220506081105.29134-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG9/Wcnh6aQQ4twjdhMTbIImQgbMm+ObeBmuwElylLlmW6TSuc
        IVlB08u8sMReWGlBoJSAUl2mjiHgpEiBcGkZKwpiQSulWyE47KDbcIqKUGQ4meXUzP9+7+15
        3jd5SUzQSKwmc/LkjDRPLBERfLytb/Haq2s98r0b9BUkMl/tw9CytY9A52+WEajq/iKGjGUn
        eGhp6DqGbDMnucj5SMVBoz0dHGQ9a+Sg+vOXOWjKbMLQsZ77OKov8GLosTcZeefGcGS0/wKQ
        z23iINtYAhqerOMhq20AR67OUwT6rtbHQwbtPIY8Bh9A5f0WLnr4QwEPNf59D0dXxqJTX6Zd
        I9voJ1d+JOhyzQyPvv7bRZx2DSno5gY9QZ9RVmK0peYo3TWqJOgSzQxBd3wzwaXvdbsJurSl
        AdDmFjdOWxz5tMFykbtDsJO/KYuR5HzFSJPe2cPfN7PUCg7YXzrUenMUKMFsRBEIISH1Oqxq
        rOAVAT4poOoAdJbrABvMAejytHPY4CGAvd/7eM9GJooHuWzhHIDqc3aCDaYBbPOPYUWAJAkq
        Hqr0K7oRVDGAZROFK9MYZeFC54UvAiyk9sB/3Fo8wDi1Dv40cnaFQ6k34Z3ukqDbGlg9vLDC
        IdRGqK6YJtiecDhQPYWzmmugpvUkxvbX86F/HGd5K6yu0wXzQni7vyWoGQMdFceCPfnQ51nC
        AotCquDpoh1mInAApN6CpYOSAGLUemjuTGKzabC18GsWw6Dnbji7QBg0th3H2HQo1GkFrLYI
        dixOBT0hdKlPBT1pOK40cg1grem5U0zPnWL63/Y0wBpAFKOQ5WYzsuQ85mCiTJwrU+RlJ2bu
        z20GT1/a8aR/th18e/tBoh1wSGAHkMREEaFCk3yvIDRLfPgII92/W6qQMDI7iCZxUVRoZk6T
        WEBli+XMlwxzgJE+q3LIkNVKTrr1jRTgOOG9lLZ7046MgQXDrXWa8k9+p0oPpaesv5xyxwJi
        lelY1nZL7yuVn5kblMYe20HJR7u6fk4dipVxtL2Pm5t0xB9Nat1cmtD97qe6NsGk9bXa/lj1
        Tntc3zTz4jXVUrb/harDKLxN/oHw3/yluUp9zaMw/9XOuMHCGkGf01ksjKheuJGV0b41NXGL
        1XirSxvt3LBL+Xl0jezItqJVMfOKxrSE7Znz8ZHz6JLzQ29nyds2LNIljxl3Li4ftSa1v//n
        cpSmf2E2UaeP0KtqHQXvDfnL2sM/xm2bRXDjFi6Kw4dVdy/8lZEeOdJFOFZ1T/Y+sPETNntv
        WH+lRbhsnzg5HpPKxP8BwsRvkUEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7oKN0qSDD43KFqsP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlnsWTSJyWLl6qNMFk/Wz2K2
        6DnwgcViZctDZos/Dw0tHn65xWIx6dA1RounV2cxWey9pW1x6fEKdos9e0+yWFzeNYfNYv6y
        p+wWE9q+MlvcmPCU0WLi8c2sFp+XtrBbrHv9nsXixC1pB1mPy1e8Pf6dWMPmMbH5HbvH+Xsb
        WTwuny312LSqk81jYcNUZo/NS+o9dt9sYPPobX7H5rGz9T6rx/t9V9k8+rasYvRYv+Uqi8fm
        09UeEzZvZA0QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DLePd7K2PBIcmKrXdvMjYwfhLpYuTkkBAwkbjffYa1i5GLQ0hgKaPEgTtNzBAJCYnb
        C5sYIWxhiT/Xutggip4zStxZ0wOU4OBgE9CSaOxkB4mLCExllLi07iQLiMMscJpVYuumA0wg
        3cICcRL7rswEm8oioCqx/8oiFhCbV8BS4s2+XnaIDfISMy99B7M5Bawkmia/ZAOxhYBq5i/Z
        wwpRLyhxcuYTsF5moPrmrbOZJzAKzEKSmoUktYCRaRWjSGppcW56brGRXnFibnFpXrpecn7u
        JkZgUtl27OeWHYwrX33UO8TIxMF4iFGCg1lJhFd4VkmSEG9KYmVValF+fFFpTmrxIUZToLsn
        MkuJJucD01peSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAPTaru7
        fqkiB7Z/3z5HteR47P51U/ZdY+n3yMv8+8JY4PdZ72Ml8am+T+b/nthqoLU87bHUqT1OtSxc
        wufWGRsUy33KY4g/UZZeqNU1wS7I0rx99mHnz9KyF1r2VG/o+uJ/JNvn1rkyj+TEQ3uYns7O
        e3TwjEJKdsVMz9RnIZOt5vWWBzVfWi50Sq0mOvRtndrlmTziddzvw31l/n4LuVMR/PvaLfFr
        AV0vnB9NK2Oa6r908aLU8/H7Eq8meIuwXbt+s8nG7GrTm5LrPAH3f3WXHGZWm5XZdmrKhOlF
        k5aa5O+YFCNZIPzSYrsUw+ovj9y5HXRWuZ7j3X1la5bOjbf3fjfG9Sf67unRFTx9obReiaU4
        I9FQi7moOBEAETYNDLMDAAA=
X-CMS-MailID: 20220506081112eucas1p2f6116cb713749c259a6da533df9c2505
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081112eucas1p2f6116cb713749c259a6da533df9c2505
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081112eucas1p2f6116cb713749c259a6da533df9c2505
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081112eucas1p2f6116cb713749c259a6da533df9c2505@eucas1p2.samsung.com>
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
index e8c7cebb2..5be2ef7bb 100644
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
@@ -514,7 +519,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 	/* Cache the sb zone number */
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
 		zone_info->sb_zone_location[i] =
-			sb_zone_number(zone_info->zone_size_shift, i);
+			sb_zone_number(bdev, i);
 	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
@@ -839,7 +844,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
@@ -963,7 +968,7 @@ int btrfs_reset_sb_log_zones(struct block_device *bdev, int mirror)
 	nr_sectors = bdev_nr_sectors(bdev);
 	nr_zones = nr_sectors >> zone_sectors_shift;
 
-	sb_zone = sb_zone_number(zone_sectors_shift + SECTOR_SHIFT, mirror);
+	sb_zone = sb_zone_number(bdev, mirror);
 	if (sb_zone + 1 >= nr_zones)
 		return -ENOENT;
 
-- 
2.25.1

