Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CBC511E27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiD0QHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241718AbiD0QG4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121923CB37D
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:14 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160313euoutp011a6399f175b6adabcdfc8410be27dbb7~pzFKMNvXB0318203182euoutp01k
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220427160313euoutp011a6399f175b6adabcdfc8410be27dbb7~pzFKMNvXB0318203182euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075393;
        bh=a76qyKknkM0wvqdFNEHw+s8BT16u2uGhpV7aO9NKOYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTmyJt/Fj7B4+/K/zKEUMK6Ipat+TX8HPxfYnEo40bgAUnZbIsbpsqzG5w9+P2wVG
         TRJQ+J0CtnKw4bAxDzstGzuT7ljO7vhp4g1vXOvaydPr2cFfbL34VktgitNST7VJd0
         0cjytuutkeUKGQMoeGLw6Zp66yTyHmeihbn02hnY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160311eucas1p292a05a97a5799178d307b83156d7614c~pzFInhDTQ0627806278eucas1p2B;
        Wed, 27 Apr 2022 16:03:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 46.14.09887.F3969626; Wed, 27
        Apr 2022 17:03:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214~pzFIDq05j2685026850eucas1p1l;
        Wed, 27 Apr 2022 16:03:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427160311eusmtrp19ad138dbf7fe61a8204739883754e403~pzFICnC7Y2142221422eusmtrp1I;
        Wed, 27 Apr 2022 16:03:11 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-66-6269693f394f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.A7.09404.E3969626; Wed, 27
        Apr 2022 17:03:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160310eusmtip1f0d4275814b6fa6855728a90524835ba~pzFHtPgBm1783517835eusmtip1O;
        Wed, 27 Apr 2022 16:03:10 +0000 (GMT)
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
Subject: [PATCH 14/16] f2fs: call bdev_zone_sectors() only once on
 init_blkz_info()
Date:   Wed, 27 Apr 2022 18:02:53 +0200
Message-Id: <20220427160255.300418-15-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0xTVxzOuef2tnSrXKqZZ8iyUbYs8hIfM2dCxtgjXjcz56Jm0S1Q4QKd
        BVkLc5vJVsZjwoA+HKhtNx3hJTBbaWGWVwhDqmCl4yEgAeRRHciACXsQpq7drZn/fd/3+77f
        d37JEUDxBcpfIEtNZxWpUrmEEpINnSvXw6JlssMRhrsB2NTVCXHNqJrCJYsrEHcXOwisU5/m
        41VHD8Qt8wYedv6dSeDhNhuBz9dcJvC0SQ9xQdsiie/nj7m17AmI/5nYjHXtNwB2DegJ3HIz
        BPdOVfFxb+lO3NxylcR9jUYKn61w8bEm9w+IhzQugLV2Cw8vlWfz8YW7CyS+cnPDq88wff1v
        Mw+u1FKMNmuez/SMXSSZPkcGU1edRzE/qIohYyn7kmk6t0QwTcMqiinMmqcYW844j1loHaCY
        Ims1YEzWAZLRWC7y3hUfFEYlsHLZJ6xi0ytxwmR9jgGmTT/5af7iHhW4JcwHPgJEb0P25hGQ
        D4QCMV0F0NySy0uWAbpudvI4sgRQ22A/9SgyMvo9xQ0qAWpwLXrJDECFtTX8fCAQUHQwyszj
        e/R19BBAWrOZ8BBIz0LktA4SnlVr6f1IvWDkezBJv4AmS8ZJT1hER6LVzBiu7Vl0pvev/3b6
        uGXNvfc9soj2Q1fPTJMeDN2WrHoD9KxHdLkQdU1e5nHZN5C6fgxyeC2atVv5HA5A3ScLSA4f
        R66hVW84GyC1zUR5ypC7rOia3AMhvRGZGjdx9hg0XjAIOccaNPSbH/eENUjXcMori9CJXDHn
        liDbyrS3FKG+r4zeUgYNnzAQGhCof+wY/WPH6P/vPQdgNVjPZihTkljlllT2WLhSmqLMSE0K
        jz+aUgfcX7r7gX35Eqic/T28HRAC0A6QAErWiZabkg+LRQnSzz5nFUdjFRlyVtkONghIyXpR
        vMwsFdNJ0nT2CMumsYpHU0Lg468ishfnfCMqYk5Flh3acYw4GMvL2Tb28M3nf/w1pEQVNzzX
        fMeQbh8N3eV8qZc3c+DQvedeL9+nfahzRvPf2R4+aiwITe7v8A0+re/YutvRa90SPev6uWhi
        pz12qmdk5sWQRPOB2+aBRPvGnBu7nBOWJ1oDS32PNObWyW//cqd//uOG4qDK9rDIn3I+CMr1
        N1effe/+7FP74lt9dLjRFhVhvKayde6teuu77KEEXn1YkJ9oIr4UEfDb2K3irCILO3Up7tYX
        Fefj7DVpNsq4P/Q1eeBHe3oKd3fUlk1KC4dt30BHRGJASODTsj8TurZH7/gQxxRrm7XHv9Ys
        kFEv750LrqzPM1ESUpks3RwMFUrpv+/LY11BBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xu7p2mZlJBv1PLC3WnzrGbLH6bj+b
        xbQPP5ktTk89y2QxqX8Gu8Xvs+eZLfa+m81qceFHI5PFzQM7mSxWrj7KZPFk/Sxmi54DH1gs
        /nbdA4q1PGS2+PPQ0GLSoWuMFk+vzmKy2HtL2+LS4xXsFpcWuVvs2XuSxeLyrjlsFvOXPWW3
        mND2ldnixoSnjBYTj29mtfi8tIXdYt3r9ywWJ25JO8h6XL7i7fHvxBo2j4nN79g9zt/byOJx
        +Wypx6ZVnWweCxumMntsXlLvsXvBZyaP3Tcb2Dx6m9+xeexsvc/q8X7fVTaPvi2rGD3Wb7nK
        4jFh80bWAKEoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQi
        fbsEvYxZrbOZC57wVHR98G9gfMDVxcjJISFgInH77jy2LkYuDiGBpYwSJ7tmM0EkJCRuL2xi
        hLCFJf5c64Iqes4osb/5KVARBwebgJZEYyc7SFxE4AmjxP2fj1lAHGaBBhaJWxN3gU0SFgiW
        +LPzKBuIzSKgKvFo2n0WkGZeAWuJ342OEAvkJWZe+s4OEuYECk/4FAESFhKwkuhedIsVxOYV
        EJQ4OfMJC4jNDFTevHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQI
        TCfbjv3csoNx5auPeocYmTgYDzFKcDArifB+2Z2RJMSbklhZlVqUH19UmpNafIjRFOjqicxS
        osn5wISWVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtKfn//y8
        /uJTqw+fsrirF7fqvdE3B42bVc5X82SyOFT4M+SP8m91/mrY9/Op6sbdO7sm9t4Qil4s5l64
        UmnjntXTbM+9vnze5eQnkfKyjZe3WIQ6uu6W7n5zuWRW6Zk/0yY1/dzU4c2w3CHMiE9swo5M
        qbDrLy683XZWfZnuqSkfFjPfbdsX9UdRRcGIX0/0BluZX/cZH44VwilTVV/8XL2uMrruopIx
        n5SOldf0VV4NNxPT5N8uMLtUGvdAZV7Q5CXmL5tqtI4FxFZkXdozjeHW1Ec9ezUOf5y1xlgn
        oszwi7JpXoxPnErd79RHPCqd9y6Ub47n91vsUL9gT9S9tpsMUVwXt6vuE+jTrzslqcRSnJFo
        qMVcVJwIAAeEaE6wAwAA
X-CMS-MailID: 20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160311eucas1p151141fc73adc590b40ad6f935b1ac214@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Instead of calling bdev_zone_sectors() multiple times, call
it once and cache the value locally. This will make the
subsequent change easier to read.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/f2fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index ea939db18f88..f64761a15df7 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3678,22 +3678,25 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
 	struct block_device *bdev = FDEV(devi).bdev;
 	sector_t nr_sectors = bdev_nr_sectors(bdev);
 	struct f2fs_report_zones_args rep_zone_arg;
+	u64 zone_sectors;
 	int ret;
 
 	if (!f2fs_sb_has_blkzoned(sbi))
 		return 0;
 
+	zone_sectors = bdev_zone_sectors(bdev);
+
 	if (sbi->blocks_per_blkz && sbi->blocks_per_blkz !=
-				SECTOR_TO_BLOCK(bdev_zone_sectors(bdev)))
+				SECTOR_TO_BLOCK(zone_sectors))
 		return -EINVAL;
-	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(bdev_zone_sectors(bdev));
+	sbi->blocks_per_blkz = SECTOR_TO_BLOCK(zone_sectors);
 	if (sbi->log_blocks_per_blkz && sbi->log_blocks_per_blkz !=
 				__ilog2_u32(sbi->blocks_per_blkz))
 		return -EINVAL;
 	sbi->log_blocks_per_blkz = __ilog2_u32(sbi->blocks_per_blkz);
 	FDEV(devi).nr_blkz = SECTOR_TO_BLOCK(nr_sectors) >>
 					sbi->log_blocks_per_blkz;
-	if (nr_sectors & (bdev_zone_sectors(bdev) - 1))
+	if (nr_sectors & (zone_sectors - 1))
 		FDEV(devi).nr_blkz++;
 
 	FDEV(devi).blkz_seq = f2fs_kvzalloc(sbi,
-- 
2.25.1

