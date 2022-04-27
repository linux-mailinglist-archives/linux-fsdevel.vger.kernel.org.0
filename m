Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F58511F29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbiD0QHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241640AbiD0QGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156F03CD5B8
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:06 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160301euoutp014b1bddd61d6cb11968fddaae18cc2930~pzE-UXcg_0318203182euoutp01M
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220427160301euoutp014b1bddd61d6cb11968fddaae18cc2930~pzE-UXcg_0318203182euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075381;
        bh=BWD7vHeyj4CQ5Yi8P8N3Y/UNmrAcLUZCdK4xuanhqxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjtnpqS6TFmG2lS3q3AvbSUlERHkrFUlQO9oURtx63Y8neTC073fmMr39BfnCvCBw
         DTvzJ0X8IPJMoeRECHcpODziirNBHPHsusQTuxwb6EylE22GYnBKu6saD8rcytElZS
         FMexbXBDvDOgUTbirA0LbgEUR7hJIW8gG1tIYbU8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160300eucas1p2fc7475012e90a1a33a382c42587b4446~pzE9zxJ3a2333423334eucas1p2i;
        Wed, 27 Apr 2022 16:03:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 48.D7.10009.33969626; Wed, 27
        Apr 2022 17:02:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38~pzE9RHMr30646906469eucas1p2D;
        Wed, 27 Apr 2022 16:02:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220427160259eusmtrp23acd8a811248a150d7112d6be62c6f22~pzE9QGU2h2598325983eusmtrp2e;
        Wed, 27 Apr 2022 16:02:59 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-74-6269693374d0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5F.71.09522.33969626; Wed, 27
        Apr 2022 17:02:59 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160259eusmtip2e40409a4ed4d05babb2748470116c200~pzE85iTMw3126231262eusmtip23;
        Wed, 27 Apr 2022 16:02:59 +0000 (GMT)
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
Subject: [PATCH 03/16] block: add bdev_zone_no helper
Date:   Wed, 27 Apr 2022 18:02:42 +0200
Message-Id: <20220427160255.300418-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/t8H549rOY9bBTfUDN3l1eoEAceX9PrSkue8vJE7Yf5B0x4
        hOkYuDGjqGsEIySRwSUojvxR5JzhgBE1kY6gGAgEMWf8/nGwUgqGsJkcCTGeefnf+/P5vj7v
        9+dz96Wh+CoVTMuVaZxKKVNIKSFZ2zz368YIufzgC5MjUdh8oxniK4MFFC6enoO47VQHgYsK
        TgvwfEcnxPVTZ/1w1/1MAvc2WAl8+covBB43l0J8omGaxA/yhpZ62aMQ/zsajosabwHsdJQS
        uL5vPe4eMwpw98VofL2+lcT2awYKn/vGKcD6HA/EPXonwIU2ix+eLc8W4Kt/uUjc0rfy5dWs
        /eZOdqHlW4otzJoSsJ1DVSRr79Cw1abjFHtBewqylq8/YevOzxJsXa+WYvOzpijWqhv2Y10/
        Oij2ZI0JsOYaB8nqLVV+u8XvCbcmcAr5MU4V9lKcMOm3wX6YOken5485BFpQK8gD/jRiIlFJ
        xQiRB4S0mDECZMo5LuALN0Anqv6EXkrMzALkaoh4ONHuaoU8dAmg03dnfcUdgMp198g8QNMU
        E4IyeadApgegwsrK5QzITEDUVfM74bWSMJvQ9125pFeTzLPojilzWYuYF9ED4xjBx61BZ7r/
        EXhN/ZktSD/zLo8EoNYz48s4XEKyvju7vARiyoXINHmb5GdfRe6Fdp+PBE3YanxHr0KL1nO+
        fgZy9sz7hrMBKrCaKW8YWgo72a7wSsg8j8zXwnj8FZT/uQvyxArUMxnAr7ACFdWW+NoilJsj
        5mkpss6N+0IRsn9qIHmERc6hBD1YW/rILaWP3FL6f+x5AE0giNOokxM5dbiSez9ULUtWa5SJ
        ofEpydVg6Uu3LdhmfgBlE3dDGwFBg0aAaCgNFLnrkg6KRQmyDz7kVCmxKo2CUzeClTQpDRLF
        yytlYiZRlsYd4bhUTvXwlaD9g7WEZEPMvg0HYtvagz8e3rar2FLzUcxUncjWJ4RNnkPF15ty
        5bWBm9clWDXRbz9WWZ9Rvcm9TfFl01f3IzcrRpvTKy7Z9yy8ufPnXmtq5eEDhpm9uuDwzoCn
        oqV1sh7wmkdOr6eTYmy3d/8d8kV7Q5lsY7UkdvsR+b7Fxcv9Eap17tyS/bqBsB1vGLWBcdNp
        yqwKGf1H1XaDZcD/aFOacWtUimo6zdAR6XzL03XjyVXPVe1N2ZL62XDGgHH/4Ux7/457T+9a
        kGgCgn4yzN8kPU90DXvWONzR8HXz6rX6fvqornsw9NCI5FZUR8tkWbzNZCMvuGKPse/ERT0j
        0CY/3qhKL+m3SEl1kiw8BKrUsv8AISTrFkEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7rGmZlJBrf3CVusP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
        8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
        xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehkX795mLvjJUdH7+Cp7A+M29i5GTg4JAROJM+9PMncxcnEICSxllNjxYCMbREJC4vbC
        JkYIW1jiz7UuNoii54wSXe8OAiU4ONgEtCQaO9lB4iICTxgl7v98zALiMAs0sEjcmriLCaRb
        WMBUYvuFDhYQm0VAVeLlqkYwm1fASuLvisdMEBvkJWZe+s4OMpRTwFpiwqcIkLAQUEn3olus
        EOWCEidnPgFrZQYqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn525i
        BKaUbcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4v+zOSBLiTUmsrEotyo8vKs1JLT7EaAp09kRm
        KdHkfGBSyyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYNrIxBaw
        Sy67r63yerDW7GjF6Z/3hq64+z+gLHfPf97UvG3l3H80rxz+mefGVa23MNb2RKru/orLi/tN
        z3z3cN/UVPiYZ0foLudwrnx/OfV2+9tHrqn8NVovFP3hueHTTUyeAT/uqKpx9O3daHzgVfi/
        faF66SdDju+60LTy4bWk5m9a7ow1Xgyq9+vyu1YEPlEJVUzZ0L1i/u8tTJd/mRxSKvvMvI3j
        d55F8FohnR9qzZXlMvfYLiZJRJmvYG2K8bwxo/1e5OTK9evt/bOm3Jit5CH4+o78hvNM964s
        SWa92MliZFcX9Oqdzbwvem15DxN4zxxjvCvwR9j3zGNjUZG7WgErmRpLu0pXxgVkKrEUZyQa
        ajEXFScCAJFoJ62yAwAA
X-CMS-MailID: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160259eucas1p25aab0637fec229cd1140e6aa08678f38@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Many places in the filesystem for zoned devices open code this function
to find the zone number for a given sector with power of 2 assumption.
This generic helper can be used to calculate zone number for a given
sector in a block device

This helper internally uses blk_queue_zone_no to find the zone number.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f8f2d2998afb..55293e0a8702 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1392,6 +1392,15 @@ static inline bool bdev_zone_aligned(struct block_device *bdev, sector_t sec)
 	return false;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	if (q)
+		return blk_queue_zone_no(q, sec);
+	return 0;
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

