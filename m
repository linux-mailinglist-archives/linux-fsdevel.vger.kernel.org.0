Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6D6528B63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiEPQzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbiEPQyz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:55 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34E83C729
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:38 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165437euoutp021d56a44561384367e61c679c6e310170~vpCd8pl1V2798927989euoutp02V
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165437euoutp021d56a44561384367e61c679c6e310170~vpCd8pl1V2798927989euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720077;
        bh=sIFPzJwmw91La4IivNRzQIhJyFo2l0eG5WseB5ln2h4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USBwESHi0aC1sCVpZw2ZQJMFpt0F4X+44QhGlBf2ZM+PLxZ3HE4N3M+Stshhfph7b
         ALKrzUXd9Qnp2vTsK1CqkOieIfChJ3BhIVWgp93vcWheSzQ5IepAj9zGEXV0HJ493Q
         gD9VC3JGw5ZydM8ZPDMnTVv4XNv8FtLx/tQb5lMA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165436eucas1p2b02b2f7c641bc1bbfa9bef655babcbd5~vpCclYJ7J2458224582eucas1p2f;
        Mon, 16 May 2022 16:54:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 09.40.10009.CC182826; Mon, 16
        May 2022 17:54:36 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165435eucas1p1dff8d9d039a76278ef1c09dba4b4e1fe~vpCb6_gGK2301423014eucas1p1g;
        Mon, 16 May 2022 16:54:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165435eusmtrp141329befc30bbab3ee03ebbe79411840~vpCb6N5eD2961829618eusmtrp1S;
        Mon, 16 May 2022 16:54:35 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-5e-628281ccad79
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.99.09522.BC182826; Mon, 16
        May 2022 17:54:35 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165434eusmtip100c87a23ecdeb7aa39972989a236a63d~vpCbUU0uF0975309753eusmtip1h;
        Mon, 16 May 2022 16:54:34 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v4 12/13] null_blk: use zone_size_sects_shift for power of 2
 zoned devices
Date:   Mon, 16 May 2022 18:54:15 +0200
Message-Id: <20220516165416.171196-13-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7pnGpuSDFae5rFYfbefzeL32fPM
        Fq3t35gs9r6bzWpx4Ucjk8XNAzuZLFauPspk0XPgA4vF3lvaFpcer2C32LP3JIvF5V1z2Czm
        L3vKbvF5aQu7xZqbT1kc+D3+nVjD5rFz1l12j8tnSz02L6n32H2zASjSep/V4/2+q2wefVtW
        MXqs33KVxePzJjmP9gPdTAHcUVw2Kak5mWWpRfp2CVwZeyZuZy1YLFhx6MN2xgbG03xdjJwc
        EgImEnunz2HvYuTiEBJYwSix+Nx5NgjnC6PEqkNHoDKfGSUu3nrDBtOyYd4GqKrljBKXP51g
        AkkICTxnlNjVxdXFyMHBJqAl0djJDhIWEciSmHbiISNIPbPAUiaJw7OPgQ0SFoiR2PLxJpjN
        IqAqsfXAWzCbV8BaomtCFyvEMnmJmZe+s4PM5ASKr+7ihigRlDg58wkLiM0MVNK8dTYzyHwJ
        gdmcEn8v3Ic61EVi8aTJzBC2sMSr41vYIWwZidOTe1gg7GqJpzd+QzW3MEr071zPBrJMAmhZ
        35kcEJNZQFNi/S59iHJHiaVv/rJCVPBJ3HgrCHECn8SkbdOZIcK8Eh1tQhDVShI7fz6BWioh
        cblpDtRSD4nd/VeYJjAqzkLyzCwkz8xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+
        7iZGYLI7/e/4px2Mc1991DvEyMTBeIhRgoNZSYTXoKIhSYg3JbGyKrUoP76oNCe1+BCjNAeL
        kjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVANT7qdJ29VzReKfCzzelBuoJtSprhecukLkmc//
        e4rvP4Z17JOOKPY5sXNXyzuDKZfP2mbeyy7q3mc+UVWC/+e1mLUvP7+QTw8/5eCZa/JP/8K0
        ILXHWqffGVuVbT+u+eZkyeM1IXNExFt/yKqGffHQKz62pzhkunjlY4tA9UXzNp7ulDb0famV
        VPbV5dFEfePKC5xe/8UPW2tG8/73+jdDJkC798DbeIXe+C3arYJ230r1c0VffiphTT+xQy+3
        Ij7C9XjP5u2ME3fpn/vF8kNjYuMx2xzLvp0xlXfSgk4n3T2q+/qUcbKx9o4g9vgG+aYTZbHT
        vTLPv9X8FbFQxHeFcLb0tYUp9VknDVfcF1ZiKc5INNRiLipOBAC1PO3r5QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7qnG5uSDHY1SVusvtvPZvH77Hlm
        i9b2b0wWe9/NZrW48KORyeLmgZ1MFitXH2Wy6DnwgcVi7y1ti0uPV7Bb7Nl7ksXi8q45bBbz
        lz1lt/i8tIXdYs3NpywO/B7/Tqxh89g56y67x+WzpR6bl9R77L7ZABRpvc/q8X7fVTaPvi2r
        GD3Wb7nK4vF5k5xH+4FupgDuKD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1Ml
        fTublNSczLLUIn27BL2MPRO3sxYsFqw49GE7YwPjab4uRk4OCQETiQ3zNrB1MXJxCAksZZRY
        sew9I0RCQuL2wiYoW1jiz7UuqKKnjBIff68Acjg42AS0JBo72UFqRAQKJOb0b2EBqWEWWM8k
        sWPbZCaQhLBAlMT60xNZQWwWAVWJrQfesoHYvALWEl0TulghFshLzLz0nR1kJidQfHUXN0hY
        SMBK4uuTW+wQ5YISJ2c+YQGxmYHKm7fOZp7AKDALSWoWktQCRqZVjCKppcW56bnFhnrFibnF
        pXnpesn5uZsYgZG57djPzTsY5736qHeIkYmD8RCjBAezkgivQUVDkhBvSmJlVWpRfnxRaU5q
        8SFGU6CzJzJLiSbnA1NDXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
        p1QDk+XOE8YZDzfvvxB7kTGk8vLRQ8obJlemrM9zvBTjs/w+e9K6LXLqHK03V06tWf/+/pE9
        LxIWJDy9/XWdz8SrPXs7Amfq8B8Q/uUVHqx7xcHlEstJgaXTZYuvsx/aLnVSXt3uYsN7yWnc
        qT+7V59bNo9p724xQwmJQO8r/2efZFm/STJWJ+5RNL95yoK56ZL79S4X3ta/8lPY7YByS/jh
        rg8x+UFJL0pbhCaHbpEPb9t70nsjW0RHgpWy4gc2QbE1vKIWzprXXq2S2/i9Yodxzi0PqX+H
        NJ5Z27jK+xj+bUnds6Pp+k1Gxoh8tui0zIlcD8wtD/xWqwndO3mqatbnE3dS6g4ZnblTub7k
        MK84uxJLcUaioRZzUXEiAK3MTqZVAwAA
X-CMS-MailID: 20220516165435eucas1p1dff8d9d039a76278ef1c09dba4b4e1fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165435eucas1p1dff8d9d039a76278ef1c09dba4b4e1fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165435eucas1p1dff8d9d039a76278ef1c09dba4b4e1fe
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165435eucas1p1dff8d9d039a76278ef1c09dba4b4e1fe@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of doing is_power_of_2 and ilog2 operation for every IO, cache
the zone_size_sects_shift variable and use it for power of 2 zoned
devices.

This variable will be set to zero for non power of 2 zoned devices.

Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/null_blk/null_blk.h |  6 ++++++
 drivers/block/null_blk/zoned.c    | 10 ++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 4525a65e1..3bbae8be4 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -76,6 +76,12 @@ struct nullb_device {
 	unsigned int imp_close_zone_no;
 	struct nullb_zone *zones;
 	sector_t zone_size_sects;
+	/*
+	 * zone_size_sects_shift is only useful when the zone size is
+	 * power of 2. This variable is set to zero when zone size is non
+	 * power of 2.
+	 */
+	unsigned int zone_size_sects_shift;
 	bool need_zone_res_mgmt;
 	spinlock_t zone_res_lock;
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 00c34e65e..806bef98a 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -13,8 +13,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
-	if (is_power_of_2(dev->zone_size_sects))
-		return sect >> ilog2(dev->zone_size_sects);
+	if (dev->zone_size_sects_shift)
+		return sect >> dev->zone_size_sects_shift;
 
 	return div64_u64(sect, dev->zone_size_sects);
 }
@@ -82,6 +82,12 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+
+	if (is_power_of_2(dev->zone_size_sects))
+		dev->zone_size_sects_shift = ilog2(dev->zone_size_sects);
+	else
+		dev->zone_size_sects_shift = 0;
+
 	dev->nr_zones =
 		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
 			  dev->zone_size_sects);
-- 
2.25.1

