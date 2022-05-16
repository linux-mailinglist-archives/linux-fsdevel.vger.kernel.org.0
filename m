Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F17A528589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbiEPNjk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbiEPNjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:39:36 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCCB2ED5E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:39:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516133928euoutp0173a1c189cdf960d8a9f950b739a82d1c~vmYEiLrha1620316203euoutp01n
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:39:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516133928euoutp0173a1c189cdf960d8a9f950b739a82d1c~vmYEiLrha1620316203euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652708368;
        bh=IJFvu7Txlqq4QbkiUAdYp5LUxrFDgYD73zO+DTftg+Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mi7Xs+2DNyU1uSAcsBMXGfbgJFReTNy/+ASMIaA1SVBOIhO9BunN9My7lkixjb5iK
         wib0STjQ6RZZ0MF3rrIvSfkaJybGgn7u73mDNCvzU4suFwljrrn9tSdXmwStvAkXWK
         Od0tBNIQGlnOwh0mZgq/8wqCw18XuwJMak9VlMFE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516133927eucas1p122d438c502813e5d8e9ce1dc6e441a37~vmYD2eBBu1349413494eucas1p1O;
        Mon, 16 May 2022 13:39:27 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.8D.09887.F0452826; Mon, 16
        May 2022 14:39:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4~vmYDKZOUU3151131511eucas1p1j;
        Mon, 16 May 2022 13:39:26 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516133926eusmtrp174af8671b36c1e39eea07ca2cc88c788~vmYDJC_8M0312203122eusmtrp1d;
        Mon, 16 May 2022 13:39:26 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-62-6282540fd992
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.12.09522.E0452826; Mon, 16
        May 2022 14:39:26 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220516133926eusmtip2d219a7d8011c216ec7799bbaa6786ab3~vmYC5lFEU2362623626eusmtip27;
        Mon, 16 May 2022 13:39:26 +0000 (GMT)
Received: from localhost (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 16 May 2022 14:39:25 +0100
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
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 03/13] nvme: zns: Allow ZNS drives that have
 non-power_of_2 zone size
Date:   Mon, 16 May 2022 15:39:11 +0200
Message-ID: <20220516133921.126925-4-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516133921.126925-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUxTZxTH89x7e3tprN6WMp9AM7YqX7oAsjn3TJlKZNs17oPELTNmyCrc
        QCNFbOlwOqEd8iIyC9W6UbYMEwUEofQFpggIXQYy3gxvA8ZgZHZh4EALCBXEUa4ufPuf5/z+
        5/xP8lC4+BrpTymTUlh1kiJRRgqI2hZPV/Cmj78+ts1olCDLry04el7fQqKKPwwkuvLIgyOj
        4Ts+WursxlHDdBEP3V/UY+hGxS8YemAx4yiv6RGBnuWOrr6dG8fR8ngYGp8bJpDROQCQq9+M
        oYbhN1DPX2V8VN/QRqDeuu9J9GOJi4/ys+ZxNJjvAqig1c5DVVMzBLo3HLA3gOntO8Cs3LtJ
        MgUZ03yme9RKML2dWsZWfp5krupMOGO/ls7cGdKRzDcZ0yRzO3OMx8w09pOMxdFPMPl2K4+Z
        tb3KZDddwA7SRwThcWyi8gtWHbr7c0FCTfFlLNnxyqnHw02EDlSKc4EPBent0NV5icwFAkpM
        lwG4YnQTXDEH4POSJT5XzAJY/aSUeGlpbG7DuEYpgCP/VIP/qaHL9XwvJaYdABqMylxAUSQt
        h/rza5MkdDOAnvtla26cLuPBupVFwgv50kdgn22v10vQQXC+6yfcq4X0Tmi6/gPGbQ6EhT0L
        fC/uQ++C7ot7OEQE2wofrIXDV5GMmiKc0xA2T0zgXhzSMljUG8JNOQsrWzrW4kC6TQA7r9zg
        c0wkdC18wjG+cLLVwee0FLZfyntx+xnoGlzCOe+51QtvW0jOuwte7EjkZAScnxZzciMc/FfE
        hdkIjbXfvggjhDlZ4nyw1bwuvnldfPO6+MUALwebWa1GFc9q3kxiU0M0CpVGmxQfEntCZQOr
        H7l9pXXuFiidfBziBBgFnABSuEwi3HZKd0wsjFN8eZpVn4hRaxNZjRMEUIRsszBWWa0Q0/GK
        FPY4yyaz6pddjPLx12El2SdfH0haiLGnTL0TcTJc7qYfBlduyCx862fz8Zm7jWO+trd3BhnY
        gFtB/gf7DpVb3u1p6JFK5dJU62d+pqc7BGdStjgjt6Qtffpw62tnx6RubUWW0K8gwnq0PWqf
        zbMcbTLkHdjg+1sQFeUXeHOqeoTUBFr9nrrvWHaPRj2JC/7oEJZ2uHI/IcrJtqdNSK4368sX
        ZrMnh+r2fVXtDN/0zI/17FhOH4nJqTUlNNmqTodCk1X+/nSNpDvmqNlQnhrK10cGF28XLP5Z
        EqaK7i77/W/P1cyMmg8Kox2q8NKAKrd2QBTRkRw7eTdN8N6e4kbQJYqv+zBPeVh2oSO9w6SP
        lhGaBEWYHFdrFP8BmTVqYTcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsVy+t/xe7p8IU1JBo0NKhbrTx1jtvi/5xib
        xeq7/WwW0z78ZLaY1D+D3eL32fPMFnvfzWa1uPCjkcli5eqjTBZP1s9itug58IHF4m/XPaBY
        y0Nmiz8PDS0efrnFYjHp0DVGi6dXZzFZ7L2lbXHp8Qp2iz17T7JYXN41h81i/rKn7BYT2r4y
        W9yY8JTRYuLxzawW616/Z7E4cUvaQdrj8hVvj38n1rB5TGx+x+5x/t5GFo/LZ0s9Nq3qZPNY
        2DCV2WPzknqP3Tcb2Dx6m9+xeexsvc/q8X7fVTaP9VuusnhM2LyR1ePzJjmP9gPdTAECUXo2
        RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZWxdMYSrY
        Ilbx8dYBlgbGtUJdjJwcEgImEvsOnmTqYuTiEBJYyiix7fJ0FoiEjMSnKx/ZIWxhiT/Xutgg
        ij4ySvROaIHq2MIo0bx4E1AHBwebgJZEYyc7SFxE4CCjxM8LK5hAupkFVrBK/NlTC2ILC0RI
        XHy+gBnEZhFQlfh6bjuYzStgJTF16VwmiG3yEjMvfWcHmckpYC3xqc8exBQCKln/pgiiWlDi
        5MwnLBDT5SWat85mhrAlJA6+eMEMUi4hoCQx+7IexMBaiVf3dzNOYBSZhaR7FpLuWUi6FzAy
        r2IUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAhMWduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8BpU
        NCQJ8aYkVlalFuXHF5XmpBYfYjQFenIis5Rocj4waeaVxBuaGZgamphZGphamhkrifN6FnQk
        CgmkJ5akZqemFqQWwfQxcXBKNTCZb17z8x47fzufkEuD3RsrlbrSo17yj/Nf16gr8rCpy2lv
        aH0YtCmR20b4oXpX5PKzJXvPnnIOjzqVnZ8//ddKHeuT8iW/1sTsXxsnuc54srvro/IAZr25
        O7vj96wrt90yqXBW09d30RK+J/pLJsRfeLasLbuQd/PJn64TxZ12LH88qSLl+2qz6X2ZtxrN
        zk0NvXbQYjqnTUxkjzljz9KIZ2tjhTsq/jNpbdyx5vkxnhXL3fetOLzz0nr9z0yTa3qnvph9
        3962zKunk/3ipDV8XfFCusfN7N5vMO7/yM7kKF92IXKW8xYb5efCa2fm5nZ8ahaM+OtQFXhh
        sXfmEuWz8ys/fL77MaPm2jHe9rtKLMUZiYZazEXFiQApbGJp4gMAAA==
X-CMS-MailID: 20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4
X-Msg-Generator: CA
X-RootMTR: 20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4
References: <20220516133921.126925-1-p.raghav@samsung.com>
        <CGME20220516133926eucas1p15c7ba425b67ce4ac824c6bd3263e2dd4@eucas1p1.samsung.com>
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

