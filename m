Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0A528B33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbiEPQym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343914AbiEPQyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750413CA42
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:33 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165431euoutp015732ff8fe96c92753179d448e5d6ecc5~vpCYLA7OJ2836428364euoutp01N
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165431euoutp015732ff8fe96c92753179d448e5d6ecc5~vpCYLA7OJ2836428364euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720071;
        bh=bvw6RhJqyk6cpxv/AsypEgXjWF1fz2EYC8nTp3xSTNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBADAfmmxh9dDQD7Su+WpQrvk2tmYG/PM3mOU/mbQWSn5kz7gig8P+wjljL89kThR
         BwOqBso/YXncG8bNrDGvQ/FjX69RHlAJ9katHFiGlWNmQmRsV+hYm+3akUxkcF3WcL
         YblblXIAq4Aa9d2vod5dCET4szojykqblqvk4Qak=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165430eucas1p121f4df66d6ce57ba399426c27d51d7b1~vpCW2mLfQ3183531835eucas1p1U;
        Mon, 16 May 2022 16:54:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F1.E6.10260.6C182826; Mon, 16
        May 2022 17:54:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230~vpCWbT6kq0201202012eucas1p2O;
        Mon, 16 May 2022 16:54:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165429eusmtrp199c722809802237e5a9f8a60f6f61fdf~vpCWaWz5_2961829618eusmtrp1O;
        Mon, 16 May 2022 16:54:29 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-50-628281c6ce2b
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 10.99.09522.5C182826; Mon, 16
        May 2022 17:54:29 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165429eusmtip21e540dfc6bbca12792d8c5e43ca34a89~vpCWHpK430678106781eusmtip2z;
        Mon, 16 May 2022 16:54:29 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices align
 with sb log offsets
Date:   Mon, 16 May 2022 18:54:11 +0200
Message-Id: <20220516165416.171196-9-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOKsWRmVeSWpSXmKPExsWy7djPc7rHGpuSDBbOYbFYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbf4
        vLSF3WLNzacsDnwe/06sYfPYOesuu8fls6Uem5fUe+y+2QAUab3P6vF+31U2j74tqxg91m+5
        yuLxeZNcAFcUl01Kak5mWWqRvl0CV8aTlz1sBb8UK9Y1LWVtYLwk1cXIySEhYCLx/t4jti5G
        Lg4hgRWMEs3PTzJDOF8YJXae/QjlfGaUOHVyMwtMy9s9y1hBbCGB5YwSU9oDIIqeM0p8nL2Q
        vYuRg4NNQEuisZMdpEZEIEti2omHjCA1zAK/GSWebp0NNkhYIEHi4dfPbCA2i4CqxJSlH5hB
        bF4BK4lXWz8yQSyTl5h56TvYTE4Ba4nVXdwQJYISJ2c+ARvDDFTSvHU2M0R5P6fEtfsuELaL
        xNW/N9kgbGGJV8e3sEPYMhKnJ/dA/VIt8fTGb7AnJQRaGCX6d65nA9klAbSr70wOiMksoCmx
        fpc+RLmjxKVvn5khKvgkbrwVhLiAT2LStulQYV6JjjYhiGoliZ0/n0AtlZC43DQHaqmHxIvb
        z5kmMCrOQvLLLCS/zELYu4CReRWjeGppcW56arFxXmq5XnFibnFpXrpecn7uJkZgWjv97/jX
        HYwrXn3UO8TIxMF4iFGCg1lJhNegoiFJiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0
        xJLU7NTUgtQimCwTB6dUA1PIs2txJho7X3dNXd5ne1NHszu45Jj28nV6HP5NJt0LkuM+N8Uc
        XmP96seN289vWXwWPHgzwyZWZkXebc/6ufo7Zb19rLd4MBda7Y9cu27ezMXb5OTEbj4yNQoN
        CC6Mkco5dCf99O2ge+dzgzx/F334dGD1dq4rMuZhlwv23swKKZzmMFcpbMKcPbefPZPbU3Bt
        83umz38Uiz9uikjX/9Ry/0mNx3ITgVezV5xZZv0j96qpgcvjm0rCPiwKqZJ7C98w7j24cPKd
        Vjkel0V2kyPKKn/+KQnbs9npS9j34tMumqYiM38dVlErsmj75LJxYVuz72WNb6JaaRbWCo8+
        bBaZVbLmc1uRwuZe00N/DrxUYinOSDTUYi4qTgQAh4MYLNoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xe7pHG5uSDO4/VLJYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbf4
        vLSF3WLNzacsDnwe/06sYfPYOesuu8fls6Uem5fUe+y+2QAUab3P6vF+31U2j74tqxg91m+5
        yuLxeZNcAFeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsaTlz1sBb8UK9Y1LWVtYLwk1cXIySEhYCLxds8y1i5GLg4hgaWMElMnbmOFSEhI3F7Y
        xAhhC0v8udbFBlH0lFHixNOLQAkODjYBLYnGTnaQGhGBAok5/VtYQGqYBVqZJCZsnQGWEBaI
        k/gy4xXYIBYBVYkpSz8wg9i8AlYSr7Z+ZIJYIC8x89J3dpCZnALWEqu7uEHCQkAlX5/cYoco
        F5Q4OfMJC4jNDFTevHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy021CtOzC0uzUvXS87P3cQI
        jMJtx35u3sE479VHvUOMTByMhxglOJiVRHgNKhqShHhTEiurUovy44tKc1KLDzGaAp09kVlK
        NDkfmAbySuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYPKzOeRUL
        LBJl9456Up96aNMnUXWvvStEGHjfLvhwO3Wl/xazncqeV+r/NtTH+KyP1zlWdHN6k+5it+Dq
        K3/XWUe9emaT85jdwfhfQ5vkl0WfYtWNV6zetWmH1NMTzxqKd75zePjG7++/7zHeATvv/mrL
        2D1r2ofERz/clbfdmrHQfTH/L8c5czUWvujZmyvmYB2/h0Ntwe72ZT9CBY7PnXFq1yenf8Kd
        pRPmfnmYZzP75CY2M0Wu3y686VJtYpO5Z55Q7AqVe/BfmzN494FLVYfi/l4rfDr1g9bKG4vi
        8w4KvwrvTAiYsF3h7FuL16YK10/z3bFIDBCeGl4bURm7w+a3gX03W7Yue0yg1aW9nEosxRmJ
        hlrMRcWJAGnHloFLAwAA
X-CMS-MailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
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

Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.
These are fixed at these locations so that recovery tools can reliably
retrieve the superblocks even if one of the mirror gets corrupted.

power of 2 zone sizes align at these offsets irrespective of their
value but non power of 2 zone sizes will not align.

To make sure the first zone at mirror 1 and mirror 2 align, write zero
operation is performed to move the write pointer of the first zone to
the expected offset. This operation is performed only after a zone reset
of the first zone, i.e., when the second zone that contains the sb is FULL.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/btrfs/zoned.c | 68 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 3023c871e..805aeaa76 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -760,11 +760,44 @@ int btrfs_check_mountopts_zoned(struct btrfs_fs_info *info)
 	return 0;
 }
 
+static int fill_sb_wp_offset(struct block_device *bdev, struct blk_zone *zone,
+			     int mirror, u64 *wp_ret)
+{
+	u64 offset = 0;
+	int ret = 0;
+
+	ASSERT(!is_power_of_two_u64(zone->len));
+	ASSERT(zone->wp == zone->start);
+	ASSERT(mirror != 0);
+
+	switch (mirror) {
+	case 1:
+		div64_u64_rem(BTRFS_SB_LOG_FIRST_OFFSET >> SECTOR_SHIFT,
+			      zone->len, &offset);
+		break;
+	case 2:
+		div64_u64_rem(BTRFS_SB_LOG_SECOND_OFFSET >> SECTOR_SHIFT,
+			      zone->len, &offset);
+		break;
+	}
+
+	ret =  blkdev_issue_zeroout(bdev, zone->start, offset, GFP_NOFS, 0);
+	if (ret)
+		return ret;
+
+	zone->wp += offset;
+	zone->cond = BLK_ZONE_COND_IMP_OPEN;
+	*wp_ret = zone->wp << SECTOR_SHIFT;
+
+	return 0;
+}
+
 static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
-			   int rw, u64 *bytenr_ret)
+			   int rw, int mirror, u64 *bytenr_ret)
 {
 	u64 wp;
 	int ret;
+	bool zones_empty = false;
 
 	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
 		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
@@ -775,13 +808,31 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 	if (ret != -ENOENT && ret < 0)
 		return ret;
 
+	if (ret == -ENOENT)
+		zones_empty = true;
+
 	if (rw == WRITE) {
 		struct blk_zone *reset = NULL;
+		bool is_sb_offset_write_req = false;
+		u32 reset_zone_nr = -1;
 
-		if (wp == zones[0].start << SECTOR_SHIFT)
+		if (wp == zones[0].start << SECTOR_SHIFT) {
 			reset = &zones[0];
-		else if (wp == zones[1].start << SECTOR_SHIFT)
+			reset_zone_nr = 0;
+		} else if (wp == zones[1].start << SECTOR_SHIFT) {
 			reset = &zones[1];
+			reset_zone_nr = 1;
+		}
+
+		/*
+		 * Non po2 zone sizes will not align naturally at
+		 * mirror 1 (512GB) and mirror 2 (4TB). The wp of the
+		 * 1st zone in those superblock mirrors need to be
+		 * moved to align at those offsets.
+		 */
+		is_sb_offset_write_req =
+			(zones_empty || (reset_zone_nr == 0)) && mirror &&
+			!is_power_of_2(zones[0].len);
 
 		if (reset && reset->cond != BLK_ZONE_COND_EMPTY) {
 			ASSERT(sb_zone_is_full(reset));
@@ -795,6 +846,13 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
 			reset->cond = BLK_ZONE_COND_EMPTY;
 			reset->wp = reset->start;
 		}
+
+		if (is_sb_offset_write_req) {
+			ret = fill_sb_wp_offset(bdev, &zones[0], mirror, &wp);
+			if (ret)
+				return ret;
+		}
+
 	} else if (ret != -ENOENT) {
 		/*
 		 * For READ, we want the previous one. Move write pointer to
@@ -851,7 +909,7 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 	if (ret != BTRFS_NR_SB_LOG_ZONES)
 		return -EIO;
 
-	return sb_log_location(bdev, zones, rw, bytenr_ret);
+	return sb_log_location(bdev, zones, rw, mirror, bytenr_ret);
 }
 
 int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
@@ -877,7 +935,7 @@ int btrfs_sb_log_location(struct btrfs_device *device, int mirror, int rw,
 
 	return sb_log_location(device->bdev,
 			       &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror],
-			       rw, bytenr_ret);
+			       rw, mirror, bytenr_ret);
 }
 
 static inline bool is_sb_log_zone(struct btrfs_zoned_device_info *zinfo,
-- 
2.25.1

