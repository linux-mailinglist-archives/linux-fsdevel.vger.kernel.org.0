Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E91528B56
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344000AbiEPQy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiEPQyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2F827B3C
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:34 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165433euoutp02579ffaac729dfd62bb5aadab367a6406~vpCZmTV192422624226euoutp026
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165433euoutp02579ffaac729dfd62bb5aadab367a6406~vpCZmTV192422624226euoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720073;
        bh=weFwL7xym8S1evRk+xjCjruPIjnMSz8gBoIh9GRufdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Unhk6pcoM2TFZ0M6d6oXLlb26kbT8YXZ8XlqktJssA7S17Cm44Sqx4K8lGU46anl5
         vtAdIB48ZVKoXnfLTFObrmGcYink6e20OiSfxI0JbGirPwRjEker/rtbiGDJREfq8O
         847qdXbY+fbPEcjD/Vv0S+VkSbFpCoHoQ+rfsMFw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165431eucas1p2517dac253453b1c09e2970df07cb1f97~vpCX9VyfF2458324583eucas1p2f;
        Mon, 16 May 2022 16:54:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A1.4A.09887.7C182826; Mon, 16
        May 2022 17:54:31 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165430eucas1p214cca8eaba1db2c98d947444cad4f18f~vpCXitI0O1887918879eucas1p2m;
        Mon, 16 May 2022 16:54:30 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165430eusmtrp168eccddedb796e98be32574b8f4eaee0~vpCXh9pjv2961829618eusmtrp1P;
        Mon, 16 May 2022 16:54:30 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-40-628281c75ba4
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 01.99.09522.6C182826; Mon, 16
        May 2022 17:54:30 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165430eusmtip1d0239fefcd561e73f10f2837d4e5e5f2~vpCXRAz320975309753eusmtip1e;
        Mon, 16 May 2022 16:54:30 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 09/13] btrfs: zoned: relax the alignment constraint for
 zoned devices
Date:   Mon, 16 May 2022 18:54:12 +0200
Message-Id: <20220516165416.171196-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7rHG5uSDGZf4bNYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DKuLPnInvBY4GKC32/WBoY7/J2MXJy
        SAiYSNw4v4a5i5GLQ0hgBaNEw7zfjBDOF0aJuQ/fQDmfGSV2LbzGDtOyb+0edojEckaJv/9X
        sUA4zxkl3i45BNTCwcEmoCXR2AnWICKQJTHtxEOwScwCi5kkVu6ZzAKSEBaIkpg1s58ZxGYR
        UJWYdXknG4jNK2Atcb73KBPENnmJmZe+s4PM5ASKr+7ihigRlDg58wnYGGagkuats8F+kBCY
        zynx49QSNoheF4mDxw6wQtjCEq+Ob4H6QEbi9OQeFgi7WuLpjd9QzS2MEv0717OBLJMAWtZ3
        JgfEZBbQlFi/Sx+i3FGiZ8t7VogKPokbbwUhTuCTmLRtOjNEmFeio00IolpJYufPJ1BLJSQu
        N82BWuohsfDUP+YJjIqzkDwzC8kzsxD2LmBkXsUonlpanJueWmyUl1quV5yYW1yal66XnJ+7
        iRGY7k7/O/5lB+PyVx/1DjEycTAeYpTgYFYS4TWoaEgS4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zpucuSFRSCA9sSQ1OzW1ILUIJsvEwSnVwNSwdW2MVKS27+HevLDZRqslEn9HXo+eaDLtxZ3l
        uQ+WzClesv7Zv0Y2juKmep0r2tmxZYteHtS+Nl9MhZvFL0Ysf8KclQ+dnyxbdo51xYMGFTY7
        iZ29Lkwf1JoqQxKqFrwt3H/+7nfFi8c1Ge4YSccLWr6Tir8ot9FtX82UlKa6bqPwrRvn6L3b
        mP7nzW03mV/z9V1Na5Y/L+zaMiHRJPJIu84V04hOSe6Nake5pv/eelLi/qQ0jz+Szt+iJgr9
        +3+Tx/+VnPiZxTNNljw/71p//4rTX6913qVq4r/edBa5ZT3K5Um15nXTSL379d+VqhrH0zZX
        0hY6urcvzTnRER/2oMIz/eMao2M/a5+kqSqxFGckGmoxFxUnAgDkmIpt5gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7rHGpuSDE69M7BYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLuLPnInvBY4GKC32/WBoY7/J2MXJySAiYSOxbu4e9i5GLQ0hgKaPE
        rCk32SASEhK3FzYxQtjCEn+udbFBFD1llGjsnc7axcjBwSagJdHYyQ5SIyJQIDGnfwsLSA2z
        wFomidc/3oM1CwtESEz/OpcZxGYRUJWYdXkn2AJeAWuJ871HmSAWyEvMvPSdHWQmJ1B8dRc3
        SFhIwEri65Nb7BDlghInZz5hAbGZgcqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJ
        ucWleel6yfm5mxiBkbnt2M/NOxjnvfqod4iRiYPxEKMEB7OSCK9BRUOSEG9KYmVValF+fFFp
        TmrxIUZToLMnMkuJJucDU0NeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwf
        EwenVAOT+P41L+S6Jhg/7b44pXbOrBwPv7Kunmd856cuaz+X8PhRoVm/pfhTh+s6tS8iXif0
        3yhtC3vkOMdd7KXEN6bYI44XfIuZK1but7x3chffVQ6WwM/pXGtX/SxPWt5fUmguPs3TZfGP
        la+MGHc22c3c1PzT2m59zczwTdsmKEVX6z9meHvwgnDrntpLDRcXCsWaciht2uC4ltvJW7Ze
        YuGcQE1+9v47W79InqucNs9NLtFa0oPj3Psp/9wvBP/k2s6lnrvg+ZmdPxfsWFnp8lv5ho72
        qhCNpwy5s2avDYm/XhjAMY9537urKyQbLNbK6vK+XpDjpuc/XUZj88NJuVbqLHeYr757yrBc
        6SKzsLWbEktxRqKhFnNRcSIACnOWkVUDAAA=
X-CMS-MailID: 20220516165430eucas1p214cca8eaba1db2c98d947444cad4f18f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165430eucas1p214cca8eaba1db2c98d947444cad4f18f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165430eucas1p214cca8eaba1db2c98d947444cad4f18f
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165430eucas1p214cca8eaba1db2c98d947444cad4f18f@eucas1p2.samsung.com>
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
index 805aeaa76..4f3687c54 100644
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
@@ -892,9 +899,11 @@ int btrfs_sb_log_location_bdev(struct block_device *bdev, int mirror, int rw,
 
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

