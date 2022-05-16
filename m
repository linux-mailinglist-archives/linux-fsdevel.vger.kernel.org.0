Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5516A528591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243858AbiEPNjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiEPNji (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:39:38 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E821E2ED66
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:39:36 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516133928euoutp029d061f69e18730a24b642370bf90dcfd~vmYFJ0FxJ1691716917euoutp02P
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:39:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516133928euoutp029d061f69e18730a24b642370bf90dcfd~vmYFJ0FxJ1691716917euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652708368;
        bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lGtjbgmGFr2YxtOx2xcRZIY2OWyIRIMYbS01ZS/PpxA5hEcY6pd459l6tvH1g2IKO
         HHV7XOx9/DrTxYMCaw4T+JoDU1M//BSmRxI3i+cPqR2kAqsLFKfxHwLijj71J0NVSv
         /VBh0BxZWe4HpmRa8WpBTQI8jo1RSJY31FvBrZAo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516133928eucas1p17f913d0f1876cd98dcc58f76f736ade6~vmYEsE7iP0943109431eucas1p1M;
        Mon, 16 May 2022 13:39:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.8D.09887.01452826; Mon, 16
        May 2022 14:39:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133927eucas1p1bab57e07c14c1194705e254afdd5d346~vmYEMRaTH0242102421eucas1p1n;
        Mon, 16 May 2022 13:39:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516133927eusmtrp20361a1951764c888368339cde1da5799~vmYELPEDL2486924869eusmtrp2W;
        Mon, 16 May 2022 13:39:27 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-64-62825410e4a6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 02.09.09404.F0452826; Mon, 16
        May 2022 14:39:27 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133927eusmtip18398a47cd4b3d6f2c96039f7a1ceee72~vmYEAZeBt0855508555eusmtip1b;
        Mon, 16 May 2022 13:39:27 +0000 (GMT)
Received: from localhost (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 16 May 2022 14:39:26 +0100
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     <axboe@kernel.dk>, <naohiro.aota@wdc.com>,
        <damien.lemoal@opensource.wdc.com>, <Johannes.Thumshirn@wdc.com>,
        <snitzer@kernel.org>, <dsterba@suse.com>, <jaegeuk@kernel.org>,
        <hch@lst.de>
CC:     <linux-btrfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jonathan.derrick@linux.dev>, <bvanassche@acm.org>,
        Keith Busch <kbusch@kernel.org>, <gost.dev@samsung.com>,
        <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "Josef Bacik" <josef@toxicpanda.com>,
        <linux-block@vger.kernel.org>, Alasdair Kergon <agk@redhat.com>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        "Sagi Grimberg" <sagi@grimberg.me>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, Chaitanya Kulkarni <kch@nvidia.com>,
        <linux-fsdevel@vger.kernel.org>, Chris Mason <clm@fb.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Mon, 16 May 2022 15:39:12 +0200
Message-ID: <20220516133921.126925-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG851zenraWXZanH6pZGaVjSiReWHuy0SciX8cd0WyZYubcS0e
        LuNS1lpUDLFy2yBgodtUKEzYrdh2dlBgoIUIxBbFAqFDoWMQgs0Qxr1kEgaMcnDhv+d939/7
        fM+bfBQuuUFKqYSUM6wqRZ4kI4VEvWOhczf9QaZij76ORtb7Dhyt2B0kMv+pI9GV6QUc6XXX
        +GjR1YWjpkkDD3U/vYQh+/d6DN0w38XQY2spjgruTBNoKX9wtZc9jKN/h/eiYZ+HQPrWhwB5
        e0sx1OQJRT0jVXxkb7pHIPetMhJd/9nLR0W58zjqK/ICVOy08dDN8SkCtXu2vRnEuH9/m1lu
        t5BMcdYkn+karCYYt0vD1JjySKZS+y3O2H68yNzu15JMYdYkyTTmDPGYqeZekrHW9hKMreMC
        U2Sr5jFzNS9GiU8II06zSQlprOrVyM+E8V0T3VjqSsC5kv5BoAX9m/KBgIJ0ODRrZ4l8IKQk
        dBWAOZN5PK7wAXh7tBznijkAr+rrsGcrv1m+43MDI4D1VSX8/6nOoen1lVoAy4qdq2YURdK7
        4KW8NWgz3QLgQncV5i9w+j4PLrTX437fQPpj2DChJfyaoF+GmeP1a1pEvwHdS0ace3s7LOn5
        h+83FdAH4ezlwxwihvdKHq/h+CqSVWfAOQ1hy+go7schLYMGdxjnkgF/cTzgc9olhLkz73DI
        Uejq2sG1A+GYs3YdCYIrjdfXj78AvX2LaydCOhtAXaOV5HYPwssPkjh5BGbmpnEyAPZNiLks
        AVBff3U9iwh+lSspAsGlG9KXbkhfuiF9BcBNYCurUSfHsep9KezZMLU8Wa1JiQuLUSbXgNXf
        3LHs9DUA49hMWCvAKNAKIIXLNov2nNMqJKLT8vPprEp5SqVJYtWtYBtFyLaKYhJ+lUvoOPkZ
        NpFlU1nVsylGCaRaLDwtsEf32lt/iF/KyZRbmsceuTKivYpIxvGoWZnf8CQkdr9deSRZ9vQ9
        wfHcnYrzn8Ah+3Si+kTBYd81IDWEPPnSIFcccmENppbw/baZvq+XgtpgT9Td4Ur9LUt1vHe7
        WHqy1fh+VPGYceWvD0MLRc+frJ6XNT730dFPTebUEE0HdkVqGIqPDp3j5RWORFQcGqyI3fJ3
        2bs329oGYqWeWN8m3Fo2MHjMpIxRzYqzFw4sQ0t6Uec3mV8UBKeYKk+9En02whWTQTnjytMj
        L/ZOGW3HdzvKl1mBcMs+J5q/o3uoPfa5eSdY9LTogg/s+EGNmRoH5rCgkYDxxJ9iX3+hSUao
        4+V7d+Eqtfw/D6uZRDwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsVy+t/xu7r8IU1JBtfeaVusP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLPYsmMVmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocXDL7dYLCYdusZo8fTqLCaLvbe0LS49XsFusWfvSRaLy7vmsFnMX/aU
        3WJC21dmixsTnjJaTDy+mdVi3ev3LBYnbkk7yHhcvuLt8e/EGjaPic3v2D3O39vI4nH5bKnH
        plWdbB4LG6Yye2xeUu+x+2YDm0dv8zs2j52t91k93u+7yuaxfstVFo/Np6s9JmzeyOrxeZNc
        gGCUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsb5
        txeYCv7zVcy8eY+xgfEmTxcjJ4eEgInE9jXz2LsYuTiEBJYyShy6MZ0ZIiEj8enKR3YIW1ji
        z7UuNoiij4wSaw7vgerYwigx6fhLoAwHB5uAlkRjJ1hcROAgo8TPCyuYQLqZBU6xSszbKAdS
        IywQJvHhgy9ImEVAVaLp9TYWEJtXwEri8t/lUIvlJWZe+s4OUs4pYC3xqc8exBQCKln/pgii
        WlDi5MwnLBDD5SWat85mhrAlJA6+eMEMUi4hoCQx+7IexMBaiVf3dzNOYBSZhaR7FpLuWUi6
        FzAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAhMXNuO/dyyg3Hlq496hxiZOBgPMUpwMCuJ
        8BpUNCQJ8aYkVlalFuXHF5XmpBYfYjQFenIis5Rocj4wdeaVxBuaGZgamphZGphamhkrifN6
        FnQkCgmkJ5akZqemFqQWwfQxcXBKNTCtEHCYzbPrqcmaxul6ExqbVOb+aFpkUL6qrGLvxlfB
        u3U/qW/wPHZayam+UTEoPMBdJGbVPK4k1RWPrE4lPV3xcvmDvZYBRc3L5DadP99apMG65rnI
        ur03530332RzopdpPuMRC1b/gMZF5z2PKK8OSA+qfSV9+r+m9E3m3Yabbt36vDn8lPX8je31
        ns8eSr+ODHgtLnhZi6eSf5G2p5b+hWUT5mqkCj91O65ycrda5s65yf6B5eHffc1Vbt4WCN2d
        GfKh+XNB/fOHDd90Xy8JPRe3L6a3SbUgVvi1E+Pxtqft8YE196LLfew0Pl1YPvmfqZTtDZYn
        S0JDueY386pVfNDPaOYV/xPOr9hw+IgSS3FGoqEWc1FxIgCY9rvo5QMAAA==
X-CMS-MailID: 20220516133927eucas1p1bab57e07c14c1194705e254afdd5d346
X-Msg-Generator: CA
X-RootMTR: 20220516133927eucas1p1bab57e07c14c1194705e254afdd5d346
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516133927eucas1p1bab57e07c14c1194705e254afdd5d346
References: <20220516133921.126925-1-p.raghav@samsung.com>
        <CGME20220516133927eucas1p1bab57e07c14c1194705e254afdd5d346@eucas1p1.samsung.com>
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

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32d7bd7b1..967790f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

