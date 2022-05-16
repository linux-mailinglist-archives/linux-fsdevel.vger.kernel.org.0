Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A029528B2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiEPQyf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343879AbiEPQyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4924F3C711
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165425euoutp017b6b25e027eafa04aa184c230f9439a2~vpCSHJq4R2836428364euoutp01H
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165425euoutp017b6b25e027eafa04aa184c230f9439a2~vpCSHJq4R2836428364euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720065;
        bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPRV74XvfZD/Srf4Pvh5UdLPS71mZCRWcuLS8bADEtZ4NDs7z4mhxzR1HpYYOJ6Au
         T+fX2nb5z5DQsUXAbGWUQCst5by+1zvFZ5dyE+MP0xafrP4vSPFJl/SY++6+K8lrHv
         Cgohay58NbarWtGqihLFMWOWK6tMFdM5JX6fPmgU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165423eucas1p158930326081e188da90c844c41449d67~vpCQpqA1T3100231002eucas1p1G;
        Mon, 16 May 2022 16:54:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B4.40.10009.FB182826; Mon, 16
        May 2022 17:54:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165422eucas1p174acec28848a9c2178376f092af3fa1c~vpCQK_Iy22562625626eucas1p1X;
        Mon, 16 May 2022 16:54:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165422eusmtrp2535ec901b9fcfc699f53e88d7145bca3~vpCQKB3a51030710307eusmtrp2r;
        Mon, 16 May 2022 16:54:22 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-45-628281bf30ff
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9C.00.09404.EB182826; Mon, 16
        May 2022 17:54:22 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165422eusmtip15250a2577700f87549716a5010c26ef5~vpCP3mI__2390423904eusmtip1u;
        Mon, 16 May 2022 16:54:22 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Mon, 16 May 2022 18:54:06 +0200
Message-Id: <20220516165416.171196-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djP87r7G5uSDKbckLRYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DK2LpgClPBFrGKj7cOsDQwrhXqYuTk
        kBAwkXj05BhbFyMXh5DACkaJH00vWCCcL4wSSze3MUM4nxklDt/tYodpOXQOJrGcUeLJ9i5G
        COc5o8Tytf+B+jk42AS0JBo7wRpEBLIkpp14CFbDLLCYSWLlnslgNcICURJXNjmA1LAIqEo8
        +7KQFcTmFbCS+LyxlxVimbzEzEvf2UHKOQWsJVZ3cUOUCEqcnPmEBcRmBipp3job7B4Jgfmc
        EjPffGWG6HWR6DsBM0dY4tXxLVAPyEj83zmfCcKulnh64zdUcwujRP/O9WwgyySAlvWdyQEx
        mQU0Jdbv0ocod5S4uWQ2VAWfxI23ghAn8ElM2jadGSLMK9HRBg1cJYmdP59ALZWQuNw0hwXC
        9pC4cX4V0wRGxVlInpmF5JlZCHsXMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECEx2
        p/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwGlQ0JAnxpiRWVqUW5ccXleakFh9ilOZgURLnTc7c
        kCgkkJ5YkpqdmlqQWgSTZeLglGpgmuSs6+WTvTBt5Tan/oTrV9zFzfWfiBodeq/he5yjmzHn
        3oum2a98jxQm/2Z3OKjZ53ozYoltu8e3o7Ea05ccNXALvztH9drG9LfZdgmnjRVqj9V0N7/R
        Dsye1ndhbWBH8J7bYde3WL/3zdPMjvj7b0dta4p5/yW++dzavZVndu8LeJZ6ynqbXSD/78ln
        M/47POYs0JiTWqehZ5X/PSZ0kzLn18XyVpzfFbk9Lli86nuS8uS03LmoB29PKEsfeLynmyF1
        wtPf1cUyW4PlBYX33d3Vb9JcKrGEZ2sf+89JM2sUVql4/Z/6O3mFT8mxvHMn/sWu+6DL+T3d
        s/R4ldWW3U0P47POr385g33KgQu6SizFGYmGWsxFxYkAHlO3teUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsVy+t/xu7r7GpuSDE4uNrNYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DL2LpgClPBFrGKj7cOsDQwrhXqYuTkkBAwkTh0ro25i5GLQ0hgKaPE
        rU1P2SESEhK3FzYxQtjCEn+udbFBFD1llGg5fBkowcHBJqAl0dgJVi8iUCAxp38LC0gNs8Ba
        JonXP96DNQsLREhcfL6AGcRmEVCVePZlISuIzStgJfF5Yy8rxAJ5iZmXvrODzOQUsJZY3cUN
        EhYCKvn65BY7RLmgxMmZT1hAbGag8uats5knMArMQpKahSS1gJFpFaNIamlxbnpusZFecWJu
        cWleul5yfu4mRmBkbjv2c8sOxpWvPuodYmTiYDzEKMHBrCTCa1DRkCTEm5JYWZValB9fVJqT
        WnyI0RTo7InMUqLJ+cDUkFcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fE
        wSnVwJTtXWfCzMs3t5YrfM+9w/OKrcv3FO1V59/Sb6jNqWZquEXvqunu1BANBrf32ZNnSc58
        2ir+pox31e2OH6/8itJvXeiZsNLpwLvdO74xp5xZnN1Sa/nBrzyZbffZLTfjArW3svwsWNjT
        9tH+w8zTrAu6bnDPvfxgavqvxOBpF6e/jgt4M+WWuIvYb58dMma3Ckt4Pt7Z7WL+jPUyT9fv
        sy8eiN/dcPfV1/7l1+V9bsydIPTGN+RwX2PDsWYp7nVVCcf3srf8iBLZtPmZ5Kqqx2lbVrDN
        v3nSQs7vmuEMPgWOvqRjFUWilwOP77GUvLo9lXdO+eGVntIfXV5kFfqesBWb6J05vWurUtXr
        3rAPrPxKLMUZiYZazEXFiQCIvkauVQMAAA==
X-CMS-MailID: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165422eucas1p174acec28848a9c2178376f092af3fa1c
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165422eucas1p174acec28848a9c2178376f092af3fa1c@eucas1p1.samsung.com>
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

