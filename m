Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121E50FCA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349852AbiDZMSS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349832AbiDZMSO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:18:14 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19643B8D;
        Tue, 26 Apr 2022 05:15:02 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220426121459epoutp017ee6522e724ee4bbfd092a738a84e3d0~pcUm7r7hV2247722477epoutp01R;
        Tue, 26 Apr 2022 12:14:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220426121459epoutp017ee6522e724ee4bbfd092a738a84e3d0~pcUm7r7hV2247722477epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975299;
        bh=tqXJBdcELALEIuFjFoScxTSZS/LJo98WnLSlGhz8AJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FgM6N/lgH+TA4NGsMRPUNMRbWsAfUZzs3Havh17DPs9cGGcHUVU4Y8pHWH4tiAMax
         oGv/nZSfOAJ1iEosGQW3fLjZk2KLn8f1zpKbC5PSrZ6GwSzSWumXq67udNc+mMVScY
         5FW3/aMC/BZgB9NHzhm4+Y7pcGt4RkdQ/Ybri1MU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220426121459epcas5p15efc43d1ebe2e6d28f7302c036c598e3~pcUmGCle50384703847epcas5p1g;
        Tue, 26 Apr 2022 12:14:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Kngmv0qYDz4x9Pt; Tue, 26 Apr
        2022 12:14:55 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.3F.09827.E32E7626; Tue, 26 Apr 2022 21:14:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220426101921epcas5p341707619b5e836490284a42c92762083~pavpK3rUF2402324023epcas5p3y;
        Tue, 26 Apr 2022 10:19:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426101921epsmtrp1c93fb5e33ffceee41e1d965b9e3c13e9~pavpIvLBS2263822638epsmtrp1W;
        Tue, 26 Apr 2022 10:19:21 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-f7-6267e23ee567
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D7.AA.08924.927C7626; Tue, 26 Apr 2022 19:19:21 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426101915epsmtip1e9c7141da10bbb26f46630ee8a0de460~pavjguXAW0426304263epsmtip1g;
        Tue, 26 Apr 2022 10:19:15 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 02/10] block: Add copy offload support infrastructure
Date:   Tue, 26 Apr 2022 15:42:30 +0530
Message-Id: <20220426101241.30100-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd87p6YEEOBYXPmEG7CSbIJfK7eMmMwM5m24j7oeJC2FHOBYG
        tE0L6i6ZXEQjDLkYBhQCqBsOURiIjFsBYQyBITBuQoaIFAzrxn0CLeiorZv/nvfJ83zv875f
        XgoXDPCtqShJHCeXsDFC0pSobd/n4BTwRHzStQmiyu5fcdQ0tsJD5RMZJPpucQNHC/emeSg7
        I4+PdL19OBpUmyPVfAEP9a8nYmi6+gWGxlrrMdR0LRtDZeUdGHp64zpAjVeXMLQ5JUJTq+ME
        ym4bAWhmWIkh1bgjalJ1EWiwoZBExaUzfJQ2WkeiZo0KRzc6n2PogXKTRFmdd3ioTp0IUK2u
        GEftj4YJVKFZIND9cRuU8u0GH/VtdfLe3csMDh1hlJO9JJOVPM9n6pUTfKbvURXBDPbGM9U3
        L5HMne/PMVce3gBM41gCyST91oEzecurJJOePE8y9SmTPGZpZpxgFpqHyRCrE9F+kRwbwcnt
        OEm4NCJKIvYXHvkk7L0wD09XkZPIG3kJ7SRsLOcvDDwa4nQ4KmZ7j0K702xM/DYVwioUQpeD
        fnJpfBxnFylVxPkLOVlEjMxd5qxgYxXxErGzhIvzEbm6HvDYFn4WHakZWgKy4eNnNbPNeAK4
        HJwKTChIu8OkxAIsFZhSAroRwPXNFNJQLAOoLCsGhmIFwB7tBPHK0p83a7Q0ANjfUm1UpWCw
        v+TJtoqiSNoR9ryg9IadNAHL1tYIvQanF/nw1oCOp9dY0gzsyvXXawjaHhYPzfH12Iz2gV0v
        Cvl6CaRdYMbkDj1tQvvCHzrmMYNkB+zKV7/Mg9O2MPluAa5/HtIXTGF3+RxpCBoIW0s6+QZs
        Cf/srDFiaziXccGIz8CfL5RgBvN5AFO7u41TBsCBpi1MHwKn98HKBhcDvRvmdFdghsbmMF2n
        xgy8GawreoXfgrcqS4wZdsGRtUQjZmCRSk0YdnUZwGez01gmsFO+NpDytYGU/7cuAfhNsIuT
        KWLFnMJDdkDCnfnvl8OlsdXg5W05fFAHph4vOrcBjAJtAFK4cKdZjv2pkwKzCPaLLzm5NEwe
        H8Mp2oDH9sKzcOs3wqXbxymJCxO5e7u6e3p6unu7eYqEVmY94p9YAS1m47hojpNx8lc+jDKx
        TsCOhwZecqNC3dIa2f2coD0oycpsw/uBKvkjq7lycF1HnQ2ysHkz/2+Qc6hIE3l7nuQ0aMqk
        8v6HtqsP3g85d/VYepLDU4W0hzzBHPNtt9fiv0s9qnTsobdr3zn2rMpL7BUU6MlwnzPX/Ezr
        HjqGhkuqhVm78+kNYWnCNxu1AetlVr/8qPJtDaKSCnr2FhYG2EgWTvncTrnfu5q/su6QueQu
        ISzv1dpWiNTn55YTTgckTDxqGdGm9H1tqbuYKyvLDZ14bKfMO3SQH5VmHTtqUTWrDf5r8aJJ
        y+E/1KM1Fm6N+cEbd/dUHM3Rfvr846/+KZ1X5xXIBObaGtv9exjLzCtbSEgoIlmRAy5XsP8C
        kAMhVOQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03SbUxTZxTA8T333t5emmCuxekjJDM2mMWiQO2mZ0OY2bLsEs2UZZkb2eKK
        3BUYL11rN9kyV+hcBpuiTCYUMhy+NEBWERSLFKJ1wLqBhZQWW2MJsRSWbkUqCUWKzEKW+O3k
        +f+e5Hw4DCn+ThDP5Bcf4dXFikIJLaI6b0te2L51QJmT+u8v8XD5z34SLO5HAmi9X0XDzw8X
        SJi59UAA1VW1QlgcspPg8K2BnmC9AIbDZQQ8aF8mwH2ziwBLUzUBza19BEwZzyPo/nWWgMiE
        DCbmPBRUW10IJp0GAno8SWDpsVHguNFAQ+OlSSH8MGamoTfQQ4Jx4AkBdwwRGk4PdAjA7CtD
        0LnYSMJtr5MCU2CGgj88CXD8xwUh2JcGBHsSOcfoXs4wPkRzp/VBIddluC/k7N4rFOcY0nLt
        LRU013HhG+6nu0bEdbt1NFc+2EdytaE5mjuhD9Jc1/FxATc76aG4mV4nfWBDtmh3Ll+Y/zmv
        Tsn4WJQXGJ1FKufBowF/L6lDJ9+qRDEMZl/Cw7V+ohKJGDFrRrhmzEWtho340tLv5Ooch5uf
        TAlXkZ7A3d97nwaGodkk/NcyEzXrWAo3z89TUUOytQw2tX5LRE0cy2Hb2fSoodgtuHH0b2F0
        jmVfxbblBmGUYDYFV42vjT7HsGn4Yl9w5af4Kbm7eHRVr8W2Ot/KZiS7Ceuv1ZOnEGt4Jhme
        SecQ0YI28ipNkbJII1PtKOa/SNYoijTaYmXy4ZKidrRyKlKpGVlaHiZbEcEgK8IMKVkXW7Pl
        kxxxbK6i9EteXXJIrS3kNVaUwFCSDbHDlbZDYlapOMJ/yvMqXv1/JZiYeB2he6cu64xovjSt
        /HGr8attfOb0i7fK4+JLd2Xcu+rIypTvYHg3t7tNFO7tXqNq886dKZAoN5+QN9mUZc4K2b7I
        Y1/HTi1177d+ddo271w41xU4NtJlauo07ax5H4fXZ3+kvxgK+637phXKgvOT+q8/e2X7I4U8
        0bi/M0dmO1ywpH/5ueyCppg7b+8/VxcqyysUua8w4RKXfU9qvR2/odiUbfngusAmf28Cn3Rp
        I9c3vy6hq82qvZfL7TcGw2SSf8xlPvu8VNy27H8t1OLLKOEPjkxHGhzpwwsX+t+t6xiskKeb
        /plRZSZIk3VZiadCu45NvZnizRd7PhxRHtiaGpRQmjyFTEqqNYr/AP+WeWiZAwAA
X-CMS-MailID: 20220426101921epcas5p341707619b5e836490284a42c92762083
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101921epcas5p341707619b5e836490284a42c92762083
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426101921epcas5p341707619b5e836490284a42c92762083@epcas5p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blkdev_issue_copy which supports source and destination bdevs,
and an array of (source, destination and copy length) tuples.
Introduce REQ_COPY copy offload operation flag. Create a read-write
bio pair with a token as payload and submitted to the device in order.
Read request populates token with source specific information which
is then passed with write request.
This design is courtesy Mikulas Patocka's token based copy

Larger copy will be divided, based on max_copy_sectors,
max_copy_range_sector limits.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 block/blk-lib.c           | 232 ++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   2 +
 include/linux/blk_types.h |  21 ++++
 include/linux/blkdev.h    |   2 +
 include/uapi/linux/fs.h   |  14 +++
 5 files changed, 271 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 09b7e1200c0f..ba9da2d2f429 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -117,6 +117,238 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * Wait on and process all in-flight BIOs.  This must only be called once
+ * all bios have been issued so that the refcount can only decrease.
+ * This just waits for all bios to make it through bio_copy_end_io. IO
+ * errors are propagated through cio->io_error.
+ */
+static int cio_await_completion(struct cio *cio)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cio->lock, flags);
+	if (cio->refcount) {
+		cio->waiter = current;
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		spin_unlock_irqrestore(&cio->lock, flags);
+		blk_io_schedule();
+		/* wake up sets us TASK_RUNNING */
+		spin_lock_irqsave(&cio->lock, flags);
+		cio->waiter = NULL;
+		ret = cio->io_err;
+	}
+	spin_unlock_irqrestore(&cio->lock, flags);
+	kvfree(cio);
+
+	return ret;
+}
+
+static void bio_copy_end_io(struct bio *bio)
+{
+	struct copy_ctx *ctx = bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+	unsigned long flags;
+	bool wake = false;
+
+	if (bio->bi_status) {
+		cio->io_err = bio->bi_status;
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - ctx->start_sec;
+		cio->rlist[ri].comp_len = min_t(sector_t, clen, cio->rlist[ri].comp_len);
+	}
+	__free_page(bio->bi_io_vec[0].bv_page);
+	kfree(ctx);
+	bio_put(bio);
+
+	spin_lock_irqsave(&cio->lock, flags);
+	if (((--cio->refcount) <= 0) && cio->waiter)
+		wake = true;
+	spin_unlock_irqrestore(&cio->lock, flags);
+	if (wake)
+		wake_up_process(cio->waiter);
+}
+
+/*
+ * blk_copy_offload	- Use device's native copy offload feature
+ * Go through user provide payload, prepare new payload based on device's copy offload limits.
+ */
+int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
+{
+	struct request_queue *sq = bdev_get_queue(src_bdev);
+	struct request_queue *dq = bdev_get_queue(dst_bdev);
+	struct bio *read_bio, *write_bio;
+	struct copy_ctx *ctx;
+	struct cio *cio;
+	struct page *token;
+	sector_t src_blk, copy_len, dst_blk;
+	sector_t remaining, max_copy_len = LONG_MAX;
+	unsigned long flags;
+	int ri = 0, ret = 0;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	cio->rlist = rlist;
+	spin_lock_init(&cio->lock);
+
+	max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
+	max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
+			(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
+
+	for (ri = 0; ri < nr_srcs; ri++) {
+		cio->rlist[ri].comp_len = rlist[ri].len;
+		src_blk = rlist[ri].src;
+		dst_blk = rlist[ri].dst;
+		for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
+			copy_len = min(remaining, max_copy_len);
+
+			token = alloc_page(gfp_mask);
+			if (unlikely(!token)) {
+				ret = -ENOMEM;
+				goto err_token;
+			}
+
+			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_ctx;
+			}
+			ctx->cio = cio;
+			ctx->range_idx = ri;
+			ctx->start_sec = dst_blk;
+
+			read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
+					gfp_mask);
+			if (!read_bio) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+			read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
+			__bio_add_page(read_bio, token, PAGE_SIZE, 0);
+			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
+			read_bio->bi_iter.bi_size = copy_len;
+			ret = submit_bio_wait(read_bio);
+			bio_put(read_bio);
+			if (ret)
+				goto err_read_bio;
+
+			write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
+					gfp_mask);
+			if (!write_bio) {
+				ret = -ENOMEM;
+				goto err_read_bio;
+			}
+			write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
+			__bio_add_page(write_bio, token, PAGE_SIZE, 0);
+			/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
+			write_bio->bi_iter.bi_size = copy_len;
+			write_bio->bi_end_io = bio_copy_end_io;
+			write_bio->bi_private = ctx;
+
+			spin_lock_irqsave(&cio->lock, flags);
+			++cio->refcount;
+			spin_unlock_irqrestore(&cio->lock, flags);
+
+			submit_bio(write_bio);
+			src_blk += copy_len;
+			dst_blk += copy_len;
+		}
+	}
+
+	/* Wait for completion of all IO's*/
+	return cio_await_completion(cio);
+
+err_read_bio:
+	kfree(ctx);
+err_ctx:
+	__free_page(token);
+err_token:
+	rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
+
+	cio->io_err = ret;
+	return cio_await_completion(cio);
+}
+
+static inline int blk_copy_sanity_check(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *rlist, int nr)
+{
+	unsigned int align_mask = max(
+			bdev_logical_block_size(dst_bdev), bdev_logical_block_size(src_bdev)) - 1;
+	sector_t len = 0;
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (rlist[i].len)
+			len += rlist[i].len;
+		else
+			return -EINVAL;
+		if ((rlist[i].dst & align_mask) || (rlist[i].src & align_mask) ||
+				(rlist[i].len & align_mask))
+			return -EINVAL;
+		rlist[i].comp_len = 0;
+	}
+
+	if (len && len >= MAX_COPY_TOTAL_LENGTH)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline bool blk_check_copy_offload(struct request_queue *src_q,
+		struct request_queue *dest_q)
+{
+	if (blk_queue_copy(dest_q) && blk_queue_copy(src_q))
+		return true;
+
+	return false;
+}
+
+/*
+ * blkdev_issue_copy - queue a copy
+ * @src_bdev:	source block device
+ * @nr_srcs:	number of source ranges to copy
+ * @rlist:	array of source/dest/len
+ * @dest_bdev:	destination block device
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ *
+ * Description:
+ *	Copy source ranges from source block device to destination block device.
+ *	length of a source range cannot be zero.
+ */
+int blkdev_issue_copy(struct block_device *src_bdev, int nr,
+		struct range_entry *rlist, struct block_device *dest_bdev, gfp_t gfp_mask)
+{
+	struct request_queue *src_q = bdev_get_queue(src_bdev);
+	struct request_queue *dest_q = bdev_get_queue(dest_bdev);
+	int ret = -EINVAL;
+
+	if (!src_q || !dest_q)
+		return -ENXIO;
+
+	if (!nr)
+		return -EINVAL;
+
+	if (nr >= MAX_COPY_NR_RANGE)
+		return -EINVAL;
+
+	if (bdev_read_only(dest_bdev))
+		return -EPERM;
+
+	ret = blk_copy_sanity_check(src_bdev, dest_bdev, rlist, nr);
+	if (ret)
+		return ret;
+
+	if (blk_check_copy_offload(src_q, dest_q))
+		ret = blk_copy_offload(src_bdev, nr, rlist, dest_bdev, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_issue_copy);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk.h b/block/blk.h
index 434017701403..6010eda58c70 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -291,6 +291,8 @@ static inline bool blk_may_split(struct request_queue *q, struct bio *bio)
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index c62274466e72..f5b01f284c43 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -418,6 +418,7 @@ enum req_flag_bits {
 	/* for driver use */
 	__REQ_DRV,
 	__REQ_SWAP,		/* swapping request. */
+	__REQ_COPY,		/* copy request */
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -443,6 +444,7 @@ enum req_flag_bits {
 
 #define REQ_DRV			(1ULL << __REQ_DRV)
 #define REQ_SWAP		(1ULL << __REQ_SWAP)
+#define REQ_COPY		(1ULL << __REQ_COPY)
 
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
@@ -459,6 +461,11 @@ enum stat_group {
 	NR_STAT_GROUPS
 };
 
+static inline bool op_is_copy(unsigned int op)
+{
+	return (op & REQ_COPY);
+}
+
 #define bio_op(bio) \
 	((bio)->bi_opf & REQ_OP_MASK)
 
@@ -533,4 +540,18 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+struct cio {
+	struct range_entry *rlist;
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+	spinlock_t lock;		/* protects refcount and waiter */
+	int refcount;
+	blk_status_t io_err;
+};
+
+struct copy_ctx {
+	int range_idx;
+	sector_t start_sec;
+	struct cio *cio;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3596fd37fae7..c6cb3fe82ba2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1121,6 +1121,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *src_rlist, struct block_device *dest_bdev, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bdf7b404b3e7..822c28cebf3a 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -64,6 +64,20 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/* Maximum no of entries supported */
+#define MAX_COPY_NR_RANGE	(1 << 12)
+
+/* maximum total copy length */
+#define MAX_COPY_TOTAL_LENGTH	(1 << 27)
+
+/* Source range entry for copy */
+struct range_entry {
+	__u64 src;
+	__u64 dst;
+	__u64 len;
+	__u64 comp_len;
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
-- 
2.35.1.500.gb896f729e2

