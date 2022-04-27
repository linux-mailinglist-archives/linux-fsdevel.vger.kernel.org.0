Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD29C511F03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 20:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241815AbiD0QHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241399AbiD0QGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:54 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A43CE9B5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:07 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220427160304euoutp02ed8b2b7f12dad8fc24af04632c8b09d3~pzFCbZQEH1060710607euoutp02U
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:03:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220427160304euoutp02ed8b2b7f12dad8fc24af04632c8b09d3~pzFCbZQEH1060710607euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651075385;
        bh=O6Jd6Tzouqxtj71a1kvN5ymqEncAInPsXdGxEKyRKOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=okYuDVNPLpKu25k82IIBR2oTDHR0888dZWh3c1jeYaTMFBDt2IO8QEVtCx3v2lDmK
         yfWMlDv9zYdpwoY4LLo0nkP7WjHCXvfZT3lcxai6MXVc7sk905ppJb+LUB/Tu73gZC
         bYIDJfbqunpzA60pr9KdNMuH19jY4npb3f1CnbpU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220427160303eucas1p22d7897065d614fc598a2b9280bec4adb~pzFA9zWA62335623356eucas1p2b;
        Wed, 27 Apr 2022 16:03:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BE.04.09887.73969626; Wed, 27
        Apr 2022 17:03:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035~pzFAbPWo12290322903eucas1p1u;
        Wed, 27 Apr 2022 16:03:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427160302eusmtrp1f372a17275b8fcf9c53a511412b0283f~pzFAYod592077420774eusmtrp1N;
        Wed, 27 Apr 2022 16:03:02 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-52-62696937cddc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FF.97.09404.63969626; Wed, 27
        Apr 2022 17:03:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.162]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427160302eusmtip1f317e24df26397b4f560f917fa75f11b~pzE-yyoKH1317113171eusmtip1K;
        Wed, 27 Apr 2022 16:03:02 +0000 (GMT)
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
Subject: [PATCH 06/16] nvmet: use blk_queue_zone_no()
Date:   Wed, 27 Apr 2022 18:02:45 +0200
Message-Id: <20220427160255.300418-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220427160255.300418-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG8957e++lse5aNL4ggqCOAYEicdkrELdlEu9gcctwUfZpwRs+
        VkBbO9Ftsa7gpGNQMEwoLIJRUWBrKYxYGIThBsi3LSiosCDgBoSP8RGtBbaWWzP/e857fs95
        zkleGhfrSXc6MeUEJ0+RynxIIVHbYu0OfC0xMTa41/oS0re34KhiKIdEP8xZcdSR34WhvJwC
        Ctm6enDUMFMkQL1Pz2JosMmEoRsVf2BoTK/DUVbTHIFWNMP2t/QRHC2P7EJ5zXcBGu/XYajh
        fgAyj16nkPnyfvRrw20CWeqKSXTp2jiFtOeWcDSgHQcot7VagBauplPo56lZArXd3/LGVtbS
        F8WutlWSbK56hmJ7hqsI1tKlZI3lmSRbqsrH2eorZ9j6kgWMrR9Ukez36hmSNWX8KWBnG/tJ
        NrumHLD6mn6C1VZXCd4TfygMP8rJEr/g5JK9R4QJl8ZM1LFiOq0yI5NUARupAS40ZHbDO+kq
        uxbSYuY6gBUXdRhfLAL4WDtI8MUCgI3TT6nnltlvuym+UQZgW2u70zIBYNXiit1C0yTjD89m
        rkEbmQEAcw2GNQhnJnHYW3MPc0CuzKvQNrO2CMHshHezJ9a0iAmF+cN9GJ/mBQvNTygH7sKE
        Qe38YR7ZAG8XjhEOjdsR9S9FuGM8ZEqFsOHhHMF798GyrHnnHFc42VrjvMADdlzIcjJfwvEB
        m9OcDmCOSU86wqA9LLtT5pA44wf1dRIefxOODg1SPLEeDkxv4FdYD/NqL+L8swiePyfmaR9o
        so45QyG0fFPsDGXhQ1WOQAu8dS8co3vhGN3/uSUALwebOaUiOZ5ThKRwJ4MU0mSFMiU+KC41
        2Qjsf7pjtXXxJiib/CeoGWA0aAaQxn02ihbrE2LFoqPSU6c5eepncqWMUzSDLTThs1kUl2iQ
        ipl46Qnuc447xsmfdzHaxV2Fue0JGJQ13vs0eMErwO+rv7btuRMLr1nKNTcvj3fvNPjH7JcV
        dgeGJQ8HmoPOeMqXzieByoQ4o6DFoJwvNP40uju1QB+y0vSx5HUqu/PZg+WlA+rOhbBbEW+F
        3tj+7pA86hNPy6Nsv01tIZFWLCJmWHPLl/rtkSxq68TB6HdqbYcKopO26S70276rOX4k48mV
        kAduriXiuj7NjhGz6Gt1e2jZKz1Tecf3hhcdupr2QcWq+rEElnoZrPrl00knwzXaj9xH+jzo
        TcF4RJWJ63t5ynfaFvdj3r44BeaZFfl3jHdv5Ns09HZzK3p20P33desOs5I039yq9xNc/92O
        KU8Z46NVHj6EIkG6yx+XK6T/AbMmFzlCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7pmmZlJBufeqFmsP3WM2WL13X42
        i2kffjJbnJ56lsliUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlmsXH2UyeLJ+lnMFj0HPrBY
        /O26BxRrechs8eehocWkQ9cYLZ5encVksfeWtsWlxyvYLS4tcrfYs/cki8XlXXPYLOYve8pu
        MaHtK7PFjQlPGS0mHt/MavF5aQu7xbrX71ksTtySdpD1uHzF2+PfiTVsHhOb37F7nL+3kcXj
        8tlSj02rOtk8FjZMZfbYvKTeY/eCz0weu282sHn0Nr9j89jZep/V4/2+q2wefVtWMXqs33KV
        xWPC5o2sAUJRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF
        +nYJehnzn+xkL5jDUbGmtZOtgfE3WxcjJ4eEgInE+/Zz7F2MXBxCAksZJQ7dWsUOkZCQuL2w
        iRHCFpb4c62LDaLoOaPEtilzgBwODjYBLYnGTrBmEYEnjBL3fz5mAXGYBRpYJG5N3MUEUiQs
        YCrx+x3YNhYBVYlrfS/BbF4BK4mp964wQSyQl5h56Ts7SDmngLXEhE8RIGEhoJLuRbdYIcoF
        JU7OfMICYjMDlTdvnc08gVFgFpLULCSpBYxMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQIT
        yrZjP7fsYFz56qPeIUYmDsZDjBIczEoivF92ZyQJ8aYkVlalFuXHF5XmpBYfYjQFOnsis5Ro
        cj4wpeWVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBpzluoMtPG
        K3C1+c/PW6x+Rh5axbDhjLXQ1hzr5EN5l7WfRYu01XJO3u96W8Djr0Ixq6SQw6KXRu4sc15d
        Epx8WqbMgrnbMolX0OeAo1XJ7s95hcyTNl8IWJcsZtXfw1r+m2PzB4lzd2ev7WcK5jGI19nT
        xf1L+upsh3u2QlwT0uTO6/xcxJb/aYp0zxKp1W+fsLFPv7HzWvxjvX5zro85MWdVb+o1vXOt
        f9Kd/H3dElNB4cyy/WGy+hKfllx5NT0on0FWjFX+V6+Ewl+jI7NqjavYJ3VNXJyUadFqZqDs
        sXPKBsmt988Ur1ip9Fdo9RU7+16Gi61C0wrvBv5anWXTt9+17ZyIitD6L0zvSpVYijMSDbWY
        i4oTAU7HChCxAwAA
X-CMS-MailID: 20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160302eucas1p1aaba7a309778d3440c3315ad899e4035@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Instead of open coding the number of zones given a sector, use the helper
blk_queue_zone_no(). This let's us make modifications to the math if
needed in one place and adds now support for npo2 zone devices.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b09550..e41b6a6ef048 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -243,7 +243,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
-- 
2.25.1

