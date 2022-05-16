Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1FB528B3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiEPQyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343889AbiEPQyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FEE3C4A7
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165427euoutp0238e8a3b1586f357430dd52c72747177b~vpCUkhpYA2209122091euoutp02E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165427euoutp0238e8a3b1586f357430dd52c72747177b~vpCUkhpYA2209122091euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720067;
        bh=U9RzqUijJL5PmqUeIybgHDju5FpS85GPewMJfUjtd+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IN62OkIhN5o+kavxdh0Ge0egk1f4KwjShLynxaWCaLEhPR8H4CAHORMnNaqBvSBvp
         nyoCdqHbeFBec///IPpUiIJOZd6jLUkXSmUl06zMSa9Ei6diOw9DkkREbhhXb9TB0h
         3evbgEE5hBfaD9uScIOekJL5kgQsTGjYlQojF0o0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165426eucas1p22e48539c1842dfe465d51988e5d8d7c3~vpCTS2WST2458324583eucas1p2b;
        Mon, 16 May 2022 16:54:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1F.3A.09887.2C182826; Mon, 16
        May 2022 17:54:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999~vpCSuPtbz2457724577eucas1p2W;
        Mon, 16 May 2022 16:54:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165425eusmtrp1a1b2c812009ed084ac50bf44b3ff450d~vpCSrm8wt2961829618eusmtrp1J;
        Mon, 16 May 2022 16:54:25 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-35-628281c24bd2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 3D.89.09522.1C182826; Mon, 16
        May 2022 17:54:25 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165425eusmtip23750993d6d829aa7eb563f0768582ffe~vpCSVIM863184631846eusmtip2C;
        Mon, 16 May 2022 16:54:25 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 05/13] btrfs: zoned: Cache superblock location in
 btrfs_zoned_device_info
Date:   Mon, 16 May 2022 18:54:08 +0200
Message-Id: <20220516165416.171196-6-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87qHGpuSDKZu5LNYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DK+HHvPEvBAfGK9e+62BoYFwt3MXJy
        SAiYSFz+uIyxi5GLQ0hgBaPEzUNbGUESQgJfGCVan5dDJD4zShyYMIURpqNrWyMTRGI5o8Tj
        rm8sEM5zRol35/uAMhwcbAJaEo2d7CANIgJZEtNOPARbwSywmEli5Z7JLCA1wgJxEpd7PEBq
        WARUJW5u62cDsXkFrCSuXm+DWiYvMfPSd3aQck4Ba4nVXdwQJYISJ2c+YQGxmYFKmrfOZgYZ
        LyEwm1Pi6dqNYPUSAi4SH797Q4wRlnh1fAs7hC0jcXpyDwuEXS3x9MZvqN4WRon+nevZIHqt
        JfrO5ICYzAKaEut36UOUO0o09X2AquCTuPFWEOICPolJ26YzQ4R5JTrahCCqlSR2/nwCtVRC
        4nLTHKilHhLPbi5gm8CoOAvJL7OQ/DILYe8CRuZVjOKppcW56anFRnmp5XrFibnFpXnpesn5
        uZsYgYnu9L/jX3YwLn/1Ue8QIxMH4yFGCQ5mJRFeg4qGJCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK8yZkbEoUE0hNLUrNTUwtSi2CyTBycUg1MPfNv3fbcs7447qZBgXTHRu/9u7+6HxDN19R6
        XH5ZZe7Ldp+9mUKqW/1jPu1oytsovF4/svvuXgXz38vyt6xtZdx7I6ahSnKdSFOMw/qNOtvC
        vX038X2+sXLrgZqLdxv+C1aoCDk2bhC7F6UobGXZtUfP4and5Ovhmnvb9X+tnv/yo1fnYqvg
        6CKuIh+WzVanWI9qupik32M7ffnGHZOvN7Z9KeE5EvDvjPim8L31kQrKqtt0HZ0U3yR5HP2Z
        pByz+5ZE6wbrkzt9Phc+5w+SO8C37vOqUOP3Df535f7zKS7c8tFF8bOoR/ma1pRUsbA7+7PM
        Zp/v236R7YDd7achv/SrXwoJ/7W2MJ2x86mWEktxRqKhFnNRcSIAfHa3XOMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xe7oHG5uSDA5NUbJYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DL+HHvPEvBAfGK9e+62BoYFwt3MXJySAiYSHRta2TqYuTiEBJYyihx
        dvFZJoiEhMTthU2MELawxJ9rXWwQRU8ZJZZtOABUxMHBJqAl0djJDlIjIlAgMad/CwtIDbPA
        WiaJ1z/egzULC8RI3P5wiQXEZhFQlbi5rZ8NxOYVsJK4er0NaoG8xMxL39lBZnIKWEus7uIG
        CQsBlXx9cosdolxQ4uTMJ2BjmIHKm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgZG57djPzTsY5736qHeIkYmD8RCjBAezkgivQUVDkhBvSmJlVWpRfnxRaU5q
        8SFGU6CzJzJLiSbnA1NDXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
        p1QDE4dS2nTrJXalG46+jG/5FDyhZlJP/rS/s55ZMvlZSHItkd/Pwyz+/+TOvQVG092vrtjs
        P1Vf8cktuymbeXoK01bZpR/ZMNFpaoqvhVzA4yNxXwJZORd5hN4/8dd1tU/kpmhdvgomz+9b
        eMsmZW+Rfsm/w2+J9eFnotm+HyTt2ZXefSlm61I53P/hXoLggmXJ1/8ft5HXuXqYa+KeWkM1
        jsIN/amxpTbF4a/VjjW6TH/zWvFOyoLVnH99DguzxjyZrHjz3ZFtHkc3XH/49MWUtsIJy+18
        ua85vC6N7ZzE8niu4vfwi/M/L5LObVnext2ubGvAdVmbxZvx3NnmbLn51YptvLNvdtmobi7c
        1VZUosRSnJFoqMVcVJwIADq56hhVAwAA
X-CMS-MailID: 20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165425eucas1p29fcd11d7051d9d3a9a9efc17cd3b6999@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of calculating the superblock location every time, cache the
superblock zone location in btrfs_zoned_device_info struct and use it to
locate the zone index.

The functions such as btrfs_sb_log_location_bdev() and
btrfs_reset_sb_log_zones() which work directly on block_device shall
continue to use the sb_zone_number because btrfs_zoned_device_info
struct might not have been initialized at that point.

This patch will enable non power-of-2 zoned devices to not perform
division to lookup superblock and its mirror location.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 13 +++++++++----
 fs/btrfs/zoned.h |  1 +
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 06f22c021..e8c7cebb2 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -511,6 +511,11 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 			   max_active_zones - nactive);
 	}
 
+	/* Cache the sb zone number */
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; ++i) {
+		zone_info->sb_zone_location[i] =
+			sb_zone_number(zone_info->zone_size_shift, i);
+	}
 	/* Validate superblock log */
 	nr_zones = BTRFS_NR_SB_LOG_ZONES;
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
@@ -518,7 +523,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		u64 sb_wp;
 		int sb_pos = BTRFS_NR_SB_LOG_ZONES * i;
 
-		sb_zone = sb_zone_number(zone_info->zone_size_shift, i);
+		sb_zone = zone_info->sb_zone_location[i];
 		if (sb_zone + 1 >= zone_info->nr_zones)
 			continue;
 
@@ -866,7 +871,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 		return 0;
 	}
 
-	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	zone_num = zinfo->sb_zone_location[mirror];
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return -ENOENT;
 
@@ -883,7 +888,7 @@ static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
 	if (!zinfo)
 		return false;
 
-	zone_num = sb_zone_number(zinfo->zone_size_shift, mirror);
+	zone_num = zinfo->sb_zone_location[mirror];
 	if (zone_num + 1 >= zinfo->nr_zones)
 		return false;
 
@@ -1011,7 +1016,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 			u32 sb_zone;
 			u64 sb_pos;
 
-			sb_zone = sb_zone_number(shift, i);
+			sb_zone = zinfo->sb_zone_location[i];
 			if (!(end <= sb_zone ||
 			      sb_zone + BTRFS_NR_SB_LOG_ZONES <= begin)) {
 				have_sb = true;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 10f31d1c8..694ab6d1e 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -27,6 +27,7 @@ struct btrfs_zoned_device_info {
 	unsigned long *active_zones;
 	struct blk_zone *zone_cache;
 	struct blk_zone sb_zones[2 * BTRFS_SUPER_MIRROR_MAX];
+	u32 sb_zone_location[BTRFS_SUPER_MIRROR_MAX];
 };
 
 #ifdef CONFIG_BLK_DEV_ZONED
-- 
2.25.1

