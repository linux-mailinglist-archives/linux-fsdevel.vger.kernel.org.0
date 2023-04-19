Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8536E7914
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjDSLze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjDSLy6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:54:58 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576AC146E4
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 04:54:52 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230419115450epoutp04d0ab9fe6f0962b613a118c4a16392bc8~XU-Nc7BRI1729017290epoutp04u
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230419115450epoutp04d0ab9fe6f0962b613a118c4a16392bc8~XU-Nc7BRI1729017290epoutp04u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681905290;
        bh=1P2BJZZ/eKH4o2N5bmfZBmLKhHrfzdv6MvJHTRtfiUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nAU6wTNjtajIT/PXkVH2o1l5ki14ETpvxojrYz7qm38OG+sxVsphMdWw1MqNz4+if
         L/frOi8/7RUhJZZU5sPE9OfAn7hgA7eTtX7JIB42gN0Xoh9zFnUHsHNBBDlJ8bRGBq
         y8HRpG0uPUSEJS6wZVk/32bJwXXc+ljjJt0xJYfA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230419115449epcas5p4b6fef3a1490cdf7179b603d68e3a331e~XU-M4v5Wx0259102591epcas5p4q;
        Wed, 19 Apr 2023 11:54:49 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1fNS1RwPz4x9Pw; Wed, 19 Apr
        2023 11:54:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        21.9D.09540.886DF346; Wed, 19 Apr 2023 20:54:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114751epcas5p19249dff6e6e2c37795c80f973fd7eee3~XU5HWS7WI1730317303epcas5p1C;
        Wed, 19 Apr 2023 11:47:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419114751epsmtrp1e418d528391252100c289c23958e45e2~XU5HU-fbr1843518435epsmtrp1Z;
        Wed, 19 Apr 2023 11:47:51 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-95-643fd688b523
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        77.93.08609.7E4DF346; Wed, 19 Apr 2023 20:47:51 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114748epsmtip19e3a900286e835c811f8e90d86182423~XU5ET-Z4x2496324963epsmtip1F;
        Wed, 19 Apr 2023 11:47:48 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 7/9] dm: Add support for copy offload
Date:   Wed, 19 Apr 2023 17:13:12 +0530
Message-Id: <20230419114320.13674-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230419114320.13674-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVATVxzH+3bDZqHGWRHGZ2pbGkYtUEKCITwuYabgrFoZevzRsX/gDlmO
        AkkmR7m0TUSpoICcrUENSkcEFUaucopFkUuEIUoHKEgZcFSMiDClqJQSAq3/fX7H93e9eSRu
        f4rLJ2PkGlYlZ+IEhB2n7pbLTvcTg4Ey0ePrBKrsvoOjo6eXcHRlNJtA07deAlT4YhFH462B
        qOV5kQ0autmAoeaLuRgqu9KOoaYLsxhqXzYTKLdtEKCpBwYMtQy7oeaWLg4yNZ4lkPHSFBe1
        5aViqH5SD1DdayOOKqZnOKhz+D3Ut9RhEwRp0/39tOFhL0E3GEa5dN/YdQ5t6tXSVeXpBF39
        yw9005COoDNTnxP0zI0HBJ1VUw7o6p4Ueq7qA7pq0oyFbTwY6x/NMjJW5cTKIxSyGHlUgGD/
        l+GfhntJRWJ3sQ/yFjjJmXg2QBD8WZj7npi4lQsInL5j4rQrrjBGrRZ47PZXKbQa1ilaodYE
        CFilLE4pUQrVTLxaK48SylmNr1gk8vRaSTwUGz1ZUgKUNfzEiceduA40OmYAWxJSEniq/w4n
        A9iR9lQTgOdzytaMlwDW6qfXjDkAnxaP2KxL8otMhDXQCGCf7hlhCdhTxzGYNSHLACRJUG6w
        Z5m05DhQaTicnUpfrYRTAxh8UzODWwSbKR84d21gtSqH2g7H7w+tMo/yhaUlr3BLIUh5wOyH
        myxuW8oPlt7Iw60pm2DXmUmOhXHqQ5haW4Rb6kOqxBaaF65i1kmDobG0FbfyZvi0o4ZrZT58
        kp22xgmwLP8yYRUfA9DwuwFYA4HweHf26hA45QIrGz2s7vdhQXcFZm28EWa+nlzrxYP159fZ
        GV6tLCasvBUOLujXmIY9f2Vg1stlAdhU2M05DZwMby1keGshw/+tiwFeDraySnV8FKv2UnrK
        2YT/njlCEV8FVr+F67568Of4C2EbwEjQBiCJCxx4d0N8ZfY8GZOUzKoU4SptHKtuA14rB8/B
        +Y4RipV/JdeEiyU+IolUKpX47JKKBVt4OwO6IuypKEbDxrKsklWt6zDSlq/DPE8W6oJ+3fBz
        inna8/KjeZQZqQ+u/7x9b/zI3/cOG/v8Q0JTooeoNO5NRh+7QRKEA5KhyTfN7t7mAZ1v6xHj
        SOS2tJRDJ0w970qnL4REmKuEs5ec60IXOz+e65h1EO7+YmZJdDCL+0eu//jXJ9+p7j98+5ue
        A3NuttWu9Hx/KG/gWWJHcmT695pCfUHyaC9Wm9g/fG7q0UI+Xzh/jQ/ctBNnikSlvq29LpRz
        YKaRPHskM2dB3Ji6/OP2eYef/DySbjumNW175ZddYfeJuJkdKx08MP/RV//sSeof6s7bV3Ds
        yW+mgC2DA0xLTHKDZq8qXHrOc8e9sF3e3x69m9C3OJYbJOCooxmxK65SM/8CI3yEVZ8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzH932ep6fn4uxx/fC9apkzP3ZWZJpv+ZERHmPJH0YZ7uaeFeqc
        u87vqWSjU8rVqKuUSnXXMJVc3JFLiOzoynYXSi6ZSj+uLWmFu9j899r79f58Pn98KJxnInyp
        g9JEVi4VxwtID6KuURAQ2NsWLlmWNTof3Xn5DEfnsiZxVPUhk0R9jSMAXR0ax1HX43Bk/J7v
        hqwN9RgylKgxpK1qwtDDG8MYavo1QCK16R1APe0aDBltS5DB2Ewgy4MCEhWV97gjU3YqhvT2
        FIDqJopwdLtvkEAvbH7IPPncbR1kLG1bGU3na5Kp13xwZ8wf7xKM5bWSqdalkUxNWRLz0JpM
        Mhmp30lm8FE7yVyu1QGm5tVpxlEdwFTbB7CoWTEeqyVs/MFjrHzpWpFHnL20FMhqfU90f32B
        J4MH3irAoSC9AubkW0gV8KB4tB7Asif38WnBh+WTT/+yJ9RO9bpPl1IxaFRdBCpAUSS9BL76
        RTlzLzoLh62dya5NON2FQXPvqJtz2pMOhY5brS4m6AWwq83qYi4dBitKf+LORZBeCjM7Zztj
        Dr0KVjzKdh3m/amkm6bAdH02bM6zE07G6bkw9V4+ngVozX9K858qBpgO8FmZIiE2QREsWy5l
        jwcpxAkKpTQ26MCRhGrgerNQqAcG3VCQCWAUMAFI4QIvbsvGMAmPKxGfPMXKj+yXK+NZhQn4
        UYRgDveNqnk/j44VJ7KHWVbGyv9ZjOL4JmPlV/KCpyICaiPCutMtaYW7ZlRmYCLOuu4c9cJF
        UeqNXfXbDGMF45LbSSPplZ9ztEHvSDyiBno3fLQP7NYj2Bi5cy/G507tSnGIvIo3ZPhfQwEV
        uZttcSVfrmsL40Wx/mWd4Rda2yr4jw3ejsCWe4sLA/fYrMdvPn2/KeSyT4ZxWPSytoM/sSN8
        3oRx7JsmNL09LXrm2TXD/XXtMR1q8/bNsvuO8TkWn9ZPE9FeX2MKFnL0N/fdamw545MTEuk2
        FtmwXizN6x+2zli5vq5HvKAD+JaURWf2s99WLtv29pBnWqSsv8+2yFEojFJajmZfz5WiuPMh
        Qu2Wk5d+NFm+PFcKCEWcOFiIyxXi3zWsV8RVAwAA
X-CMS-MailID: 20230419114751epcas5p19249dff6e6e2c37795c80f973fd7eee3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419114751epcas5p19249dff6e6e2c37795c80f973fd7eee3
References: <20230419114320.13674-1-nj.shetty@samsung.com>
        <CGME20230419114751epcas5p19249dff6e6e2c37795c80f973fd7eee3@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 53 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 1398f1d6e83e..b3269271e761 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1867,6 +1867,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_copy(q);
+}
+
+static bool dm_table_supports_copy(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_offload_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_offload_supported')
+		 * and it relies on _all_ data devices having copy support.
+		 */
+		if (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti,
+			     device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1949,6 +1982,14 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_sectors_hw = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 3b694ba3a106..ab9069090a7d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1720,6 +1720,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+			max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+			ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index a52d2b9a6846..04016bd76e73 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -398,6 +398,11 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/*
+	 * copy offload is supported
+	 */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

