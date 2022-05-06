Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1D51D2EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 10:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389893AbiEFIPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 04:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389832AbiEFIO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 04:14:59 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACD966C95
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 01:11:17 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220506081111euoutp02284574489ceaee2027c55a5bb913ddfa~sdcmQMlJo2422724227euoutp02p
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 08:11:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220506081111euoutp02284574489ceaee2027c55a5bb913ddfa~sdcmQMlJo2422724227euoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651824671;
        bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ti0TDsRWtQcoTqksGh7F0d3wO/5pt9G3DViOyIP1msJDOgSCY2kWwcLms0a9JMkyf
         rz950fE0dgAHycnefUHeiPdOibwkV3cHYwxuu1ytDz0aNeOL79BCwHzK9HuyIb0bHq
         Wc6PYMKdep578eJIilYCXMW2mJRCRs/8HqVm26t8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220506081110eucas1p2cfc43e30c9c38c97e466527376ef9f90~sdckiaQVi1314813148eucas1p2Z;
        Fri,  6 May 2022 08:11:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.05.09887.D18D4726; Fri,  6
        May 2022 09:11:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220506081109eucas1p26bbb68a1740b1af923ed862a93112780~sdcj-rG7n1919419194eucas1p2Q;
        Fri,  6 May 2022 08:11:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220506081109eusmtrp2db398a0a3f09537f71805983a29bb2c9~sdcj_iEtg2593625936eusmtrp2V;
        Fri,  6 May 2022 08:11:09 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-2d-6274d81df581
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.E9.09404.D18D4726; Fri,  6
        May 2022 09:11:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220506081109eusmtip22afa82e359d99dbc946388ce73357abc~sdcjmtyWb1925719257eusmtip28;
        Fri,  6 May 2022 08:11:09 +0000 (GMT)
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
Subject: [PATCH v3 03/11] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Fri,  6 May 2022 10:10:57 +0200
Message-Id: <20220506081105.29134-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjeuff29lKtu7RGDiox6z4SIYAYNQdcHG5k3m3qdMk+QqZb0Tsg
        FjAtzDl+WIGBgCsFYYwWpDD5BosUyLCwkW7jGwUqs3YDSgdxYFZorDIsgVluzfz3PO/7POd9
        nzeHwkXN5FYqPjGZlSdKZRJSQLT3LN8KDrAkx+yaHYpA+oEeHK119pCoYSKPRN8tLuOoIO97
        PnIP38ZRl0PLQyP/XsTQve4ODHVWFmCoruE3DM3oNTi63L1IoLqMaRytTIehaZeVQAWm3wGa
        HddgqMsahMb+quWjzq5+AplvlpKovHqWj9SZj3BkUc8ClN9r4KGHVRl8dP3BAoH6rNsiAxjz
        nfeY1b5GkslPd/CZ25M3CMY8nMK01GeTTIWyCGcM1y4wxntKkvk23UEyHd9M8ZiFn8ZJRtVa
        Dxh96zjBGAZTGbXhBu+YKFrw+mlWFv8lKw898Lkgrk1XiJ1t3fKV09pNKEGTKAf4UJDeA92P
        ikAOEFAiuhZAq82Ic8QFYPr1uzyOPASw26HkP7MUXs73NmoAbG4ZwjgyB+DAip3MARRF0oHw
        YjbfU99M5wKYN5W17sZpAw+ONH3hwWI6Gg45npAeTNCvQpPSgnmwkA6H7UsOgpu2A5aMLa17
        fegImHZljuQ0vrC/ZIbg3twB09u063tDuk4AK1ddOGeOguZMTzoPFsP53lZvhO1wraMc43Aq
        nLW4veaMp5t26NcTQHo/VA3JPBCnd0L9zVBOfhCOZhZ5FZug5R9fboVNsKC9GOfKQngp03te
        CexYnvEOhdCcVupNxUDzsg2owUua58Jonguj+X+uDuD1wI9NUSTEsordiey5EIU0QZGSGBty
        KimhBTz91IOrva4fQc28M8QEMAqYAKRwyWahWJMcIxKelp7/mpUnfSZPkbEKE9hGERI/4an4
        ZqmIjpUms2dY9iwrf9bFKJ+tSkwdpG1q+2H0QvEH9wecR97Ya2jMov3r3+7bV1iXdAK+sm97
        SdYLbXbV3NVjh29Zjzv/viTQ8Wt507ZfUh4Yh2Kr84xXQqePv7Pr/YmR4I1RfknnbFPqT8p+
        vnu0XTXfvNasN1L+47K33AcrMQHqx87nlFVENEoCI13DCSFX7ftVWF3aZPnRqABjzUp9bont
        0MbKl2NOssMr2tQ3x/6Y3G0/Qr0mNsw1sNc+HgkN+mgyYDhr8PHh4BNnFtOK3St2fUV4T+Sn
        0d3ZE6Nhj+N0YVAn/nXvu1V3qsP9D6S+uHB/6sMtMmuj3XeprHenUFwqO9RWtUHmjMzVxmyw
        Gf9UmPY8GTgpIRRx0rBAXK6Q/gdbsHbUQwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xe7qyN0qSDLr3ilmsP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLmwd2MlnsWTSJyWLl6qNMFk/Wz2K2
        6DnwgcViZctDZos/Dw0tHn65xWIx6dA1RounV2cxWey9pW1x6fEKdos9e0+yWFzeNYfNYv6y
        p+wWE9q+MlvcmPCU0WLi8c2sFp+XtrBbrHv9nsXixC1pB1mPy1e8Pf6dWMPmMbH5HbvH+Xsb
        WTwuny312LSqk81jYcNUZo/NS+o9dt9sYPPobX7H5rGz9T6rx/t9V9k8+rasYvRYv+Uqi8fm
        09UeEzZvZA0QitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxL
        LdK3S9DL2LpgClPBFrGKj7cOsDQwrhXqYuTkkBAwkZjSM5G1i5GLQ0hgKaPEk5cfGSESEhK3
        FzZB2cISf651sUEUPWeU+HX9IFMXIwcHm4CWRGMnO0hcRGAqo8SldSdZQBxmgdOsEls3HWAC
        6RYWiJDoO3UWzGYRUJU41HADzOYVsJTY9v0dC8QGeYmZl76zg9icAlYSTZNfsoHYQkA185fs
        YYWoF5Q4OfMJWD0zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93
        EyMwqWw79nPLDsaVrz7qHWJk4mA8xCjBwawkwis8qyRJiDclsbIqtSg/vqg0J7X4EKMp0N0T
        maVEk/OBaS2vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGJYZaH
        oMzujjB13YSji04LiYfp7lthlhT+O1X7+ekjgseaumLvrX8l/79ad+f3PXdkDvwT6Hu7sosz
        iuPlCo7cK1LMCa33/8pKeZrNmC+9oOXLF7ZA5+sRfHMr8kK35UyccUNHQ3D3Xu35k2WjH8st
        6aiLSpn13HOVjsIB39Apz0LedrLUzOc8x/XY5HZFYrV9uxX35lsLb7w+6/SjMcLW6v7TSzlZ
        s7bkTp0lHF4dvO3o/oNqx99qtiyUYEw7Lv+o3/ju0XqrH7Hsa63vrC//cjLgupHL9tv3J2+d
        lPR5zgGf830h6geOLKsrtl5nPKPQ1P7m1R69a8tzzrAkZEUd1f1b9qaMZ03noT32BkcalFiK
        MxINtZiLihMBVhMFw7MDAAA=
X-CMS-MailID: 20220506081109eucas1p26bbb68a1740b1af923ed862a93112780
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081109eucas1p26bbb68a1740b1af923ed862a93112780
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081109eucas1p26bbb68a1740b1af923ed862a93112780
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081109eucas1p26bbb68a1740b1af923ed862a93112780@eucas1p2.samsung.com>
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

Remove the condition which disallows non-power_of_2 zone size ZNS drive
to be updated and use generic method to calculate number of zones
instead of relying on log and shift based calculation on zone size.

The power_of_2 calculation has been replaced directly with generic
calculation without special handling. Both modified functions are not
used in hot paths, they are only used during initialization &
revalidation of the ZNS device.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/zns.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 9f81beb4d..65d2aa68a 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -101,13 +101,6 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 	}
 
 	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
-		dev_warn(ns->ctrl->device,
-			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
-		status = -ENODEV;
-		goto free_data;
-	}
 
 	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
@@ -128,8 +121,13 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	const size_t min_bufsize = sizeof(struct nvme_zone_report) +
 				   sizeof(struct nvme_zone_descriptor);
 
+	/*
+	 * Division is used to calculate nr_zones with no special handling
+	 * for power of 2 zone sizes as this function is not invoked in a
+	 * hot path
+	 */
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 div64_u64(get_capacity(ns->disk), ns->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -182,6 +180,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	int ret, zone_idx = 0;
 	unsigned int nz, i;
 	size_t buflen;
+	u64 remainder = 0;
 
 	if (ns->head->ids.csi != NVME_CSI_ZNS)
 		return -EINVAL;
@@ -197,7 +196,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	/*
+	 * rounddown the sector value to the nearest zone size. roundown macro
+	 * provided in math.h will not work for 32 bit architectures.
+	 * Division is used here with no special handling for power of 2
+	 * zone sizes as this function is not invoked in a hot path
+	 */
+	div64_u64_rem(sector, ns->zsze, &remainder);
+	sector -= remainder;
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-- 
2.25.1

