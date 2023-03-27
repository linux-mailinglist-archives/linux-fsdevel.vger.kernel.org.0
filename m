Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF89C6CD44F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjC2IRn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjC2IQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:16:38 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21604C34
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:16:28 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230329081627epoutp0141f2d96b12788db4ca99990c4fa291a9~Q1dic8koN1329513295epoutp012
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:16:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230329081627epoutp0141f2d96b12788db4ca99990c4fa291a9~Q1dic8koN1329513295epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680077787;
        bh=yoRFN8EbW7IWQW15oore9Bn4KQVBbxBNv9lbpiBp+v0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r011OhMgEwdVDiZn6siDPoHdLoEMOexkyQi9hW1UYtqpmw9+qTAfkc7efsMmG5IxY
         Q9/ax7kEVW0abCSRQU9ZorR3bSZG35pZhG+/vT3afdFtuYNSrqr6aQkaIdeckjeTpc
         3ucFBmNFgOOdjsVQpZeR8GROzgfX+rcAahrq9atc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230329081626epcas5p3b03079a343e247ea82e50a52a134188d~Q1dhxTPTL0829808298epcas5p3R;
        Wed, 29 Mar 2023 08:16:26 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PmfX902Rlz4x9Q1; Wed, 29 Mar
        2023 08:16:25 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.BD.10528.8D3F3246; Wed, 29 Mar 2023 17:16:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230327084312epcas5p377810b172aa6048519591518f8c308d0~QOiVHfUy03103731037epcas5p3W;
        Mon, 27 Mar 2023 08:43:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230327084312epsmtrp286ec9b83f4cc477d036bbb430103e0f9~QOiVGSVuc2690526905epsmtrp2G;
        Mon, 27 Mar 2023 08:43:12 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-d9-6423f3d896ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.D5.31821.02751246; Mon, 27 Mar 2023 17:43:12 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084309epsmtip1fbc0ef7c19d6306421092c5c2f1356d6~QOiR2sZpk3056530565epsmtip1U;
        Mon, 27 Mar 2023 08:43:09 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
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
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 7/9] dm: Add support for copy offload.
Date:   Mon, 27 Mar 2023 14:10:55 +0530
Message-Id: <20230327084103.21601-8-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230327084103.21601-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc+5tL4WlcikMj5BpueocEko7Sj04mCbT5RIWQ8K2LBtL19Fr
        YZS2a4u6sWWVCgihPBQZFhy6GJJCpA4YArU+KPIyyEKFDWaHbiCbjyrURDaCrLVl87/P7/E9
        v8fJj4PzqoOiOLkqPaNVyZQUEcLqcsS+Fv+LZ7NcWHFXgqwjAzgqql7BUaurikD3HYsA1T3+
        G0fLo2M4srsb2GjqSg+GLn5/DEOW1msYsp1ZwNC11YcEOtY3CdDchBlD9uk4dNE+zELO3kYC
        NTXPBaG+40YMdc8eBqhruQlHbfcfsdDQdDQaWxlk74a082Y6bZ4ZJegesyuIHvvtBxbtHC2g
        21vKCLrj7De0bcpA0Caj25tQPMOmH12aIOjKzhZAd1wvpD3tG+n22YdYRuiHeSk5jEzOaPmM
        Klstz1UpUqn0TOlb0iSJUBQvSkY7KL5Kls+kUnveyYh/O1fp3QPFPyBTFnhdGTKdjkp4M0Wr
        LtAz/By1Tp9KMRq5UiPWCHSyfF2BSiFQMfqdIqHw9SRv4id5OQMuN0tTEX3IPtTPNoDDkeUg
        mANJMbw1VkuUgxAOj7QB+I+lA/MbiwD+OmwNGB4Ae5d+xtYkFybduI95ZC+AR64f9CcZMdha
        de55gCC3wf75YuALRJAlOFyYK2P5DJy8jcGmorPeCIcTTiZDuwn6BCxyK/TccbJ9bq7XPTV3
        wIeQTIBVM2G+jGByJ2zsHmH7mEuGweGTsywf4+QmaPyxAfe9DklrMCyyN7P9je6BdaXfBjgc
        3hvsDPJzFPS47YSfFXDJORcYTAONA5eAn3fB4pEq3NcDTsZCa2+C3/0KPDHShvnrroOm5dmA
        lAu7v1tjCpZaGgMMof2GIcA0HHA2Av+uTACeNp4PqgZ88wvzmF+Yx/x/6dMAbwEbGI0uX8Ho
        kjQiFXPwv0/OVue3g+ensT2tG7huPxb0AYwD+gDk4FQEd3mSkvO4ctkXXzJatVRboGR0fSDJ
        u+4aPOrlbLX3tlR6qUicLBRLJBJxcqJERK3nbksdzuaRCpmeyWMYDaNd02Gc4CgDVuM48rQr
        9KULlqAua0zoUoFNceavxVff2/Lxicrxhn3szLi2fYfE0TT47N7+slHNncuXI0ueGAWdd231
        5nW3JIlotW5PWqjHNchyKbPGS6317+7FpeNLhbGxJoeg+OiE0HtlfE1NxAd7nUMOs7WXG1kd
        lTxWOUUR6+ul3Frr7g3PylLSe6xvxK+qPj0Vt3gj6w93egf6vbhiV3neSuWOkukaQc65+Sch
        o+/3yzdlNj6QmmLmuWHSsrbNV58aPiLiHmRt+em8FLmrlXpeOFVrsSj52rnPp0T2ka0n/0y8
        6TjarCq0mDJjNhL144YrPV9Ln+Wdmqa1X1217a9dqBenUSxdjky0HdfqZP8CP7GRxaMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnK5CuGKKwZ0GTYv1p44xWzRN+Mts
        sfpuP5vF68OfGC2mffjJbPH77Hlmi73vZrNa3Dywk8liz6JJTBYrVx9lsti98COTxdH/b9ks
        Jh26xmjx9OosJou9t7Qt9uw9yWJxedccNov5y56yWxya3MxkseNJI6PFtt/zmS3WvX7PYnHi
        lrTF+b/HWR0kPC5f8faYdf8sm8fOWXfZPc7f28jicflsqcemVZ1sHpuX1HvsvtnA5tHb/A6o
        oPU+q8f7fVfZPPq2rGL02Hy62uPzJjmPTU/eMgXwR3HZpKTmZJalFunbJXBlHLv7jqWgR7pi
        74kjrA2MjWJdjJwcEgImEtuvvWPuYuTiEBLYwSixtPkfM0RCQuLUy2WMELawxMp/z9khihqZ
        JB4fnscEkmATUJc48ryVESQhIjCBWeLS/QY2EIdZ4B2TxKqHy1i7GDk4hAUsJfb2SoA0sAio
        Snx+eBkszAsUvvm0DMSUENCX6L8vCFLBKWAlMWfHKVYQWwioor99F9gqXgFBiZMzn7CA2MwC
        8hLNW2czT2AUmIUkNQtJagEj0ypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOC41tLa
        wbhn1Qe9Q4xMHIyHGCU4mJVEeDd7K6YI8aYkVlalFuXHF5XmpBYfYpTmYFES573QdTJeSCA9
        sSQ1OzW1ILUIJsvEwSnVwOTB8CBgvtV1R3mz7ZfWLuRps7rF3fvx8B3R078i5h/dtuBj/ul5
        jxQWvq6XiPVYq+AjphmT+YQv7N7rvncH6zV5HuU+m3C86MnJ7XYBJVk3BHw7p3+avkZZbqLH
        lK079+VXfBEKilXmuzQh5qhafK6Pi0iPR4v6rga74+EB3BW7VlRxvv2st1lDSdozWIjxzb3m
        59aZx1rUhN5rNSw3qbvBxMFnsTSmuShtjcLdNa6+y1cdfRG77bbl8YWP9qsUTX5qW/Rk8tdp
        1255GjkUen256rqD6QX3ZK6i2fM/FicLs16qLLyQqCciJxf77PUVkbWJm2LyXGW5N+fesour
        nehQbXJinsq0VvuVZh+XPFViKc5INNRiLipOBADBCLKqWgMAAA==
X-CMS-MailID: 20230327084312epcas5p377810b172aa6048519591518f8c308d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084312epcas5p377810b172aa6048519591518f8c308d0
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084312epcas5p377810b172aa6048519591518f8c308d0@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 7899f5fb4c13..45e894b9e3be 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1863,6 +1863,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
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
@@ -1945,6 +1978,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		/* Must also clear copy limits... */
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_sectors_hw = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 2d0f934ba6e6..08ec51000af8 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1693,6 +1693,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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
index 7975483816e4..44969a20295e 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -380,6 +380,11 @@ struct dm_target {
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

