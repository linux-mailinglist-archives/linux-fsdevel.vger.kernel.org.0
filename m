Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B677225D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjFEMaO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjFEMaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:30:00 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182C3E8
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:53 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230605122951epoutp0281af997005b42f03273b6c0bc644e853~lwyMaFG680802408024epoutp02N
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230605122951epoutp0281af997005b42f03273b6c0bc644e853~lwyMaFG680802408024epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968191;
        bh=H1PdiFvQZD1R853saHzyRCE8capZ0U3aPv5cQi8i5WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCuHr4EKm8alYf4gZ75wfkT7o9JhJG88K/v06hB7cvw9R1Mz8rVxWfA9VvN4jCW/k
         hrmBCbCDRZojjdnWTqHXh8+jGF0sKdagpSZmZyf555Whu3y6LvAGbz3e+OhWjoCChJ
         ydnbxwtYi0dwArlwODWI4llgqMcksiB+cz3G05tU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230605122950epcas5p136d93b014386a849cfd5869aaec685f3~lwyLul6So0215902159epcas5p1h;
        Mon,  5 Jun 2023 12:29:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4QZXx91CgYz4x9Pv; Mon,  5 Jun
        2023 12:29:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.5D.16380.D35DD746; Mon,  5 Jun 2023 21:29:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122349epcas5p2de6c758bc38194ebfb1fd8c700e45608~lws7aUZgZ3244532445epcas5p2G;
        Mon,  5 Jun 2023 12:23:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605122349epsmtrp29f7a21e8ed8ea1907e7bb327a40f384c~lws7ZGsem1056310563epsmtrp2Z;
        Mon,  5 Jun 2023 12:23:49 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-11-647dd53dac52
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.D5.28392.5D3DD746; Mon,  5 Jun 2023 21:23:49 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122343epsmtip245dddb1bc0bcc26599c570b39b4b9fcb~lws2FYJfX2527325273epsmtip2l;
        Mon,  5 Jun 2023 12:23:43 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 7/9] dm: Add support for copy offload
Date:   Mon,  5 Jun 2023 17:47:23 +0530
Message-Id: <20230605121732.28468-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHPfe2t8Ws7AISDw+32k0IGB6dpTtVGWQjcjPcVrdlEXErHVwe
        AdqutwwHWYCBOjSCwJihOB5KeG4ghUEBYVJRxnuOh5MBGkLjJlsBGQEkwqgtm/99zvf8vr/X
        yeHi9hUcZ26sQkOrFfJ4AbGT1XzTw93Lf+zLSN+H/WxU33cbR7VTOQSau/kYoG8X1nA0e+Ms
        QCOztujBTwGow1TERvdutGLo+pU8DFXX3sJQe9kihvIM4wAZx7QY6pjYj8rOlLPQ9Y5eFhpp
        u0ygkgojB52/qydQZc8Ghgz5GRjSz6YD1LxegqO6uXkW+nnCBQ0/7WGj9dXLRKArNTIaQmnv
        DxJUq3aKQw1PN7CoxipPamQwkdLVZBFUY3kq1X4vjaCuZuezqQsZJoJaNE6wqPnOMYLKbqoB
        VGN/CrWke0lqdyLucAwtj6TVfFoRoYyMVUT7C0I+kL0l8xP7Cr2EEvS6gK+QJ9D+gqCjUq8j
        sfFb2xHwP5fHJ25JUjnDCHzeOKxWJmpofoyS0fgLaFVkvEqk8mbkCUyiItpbQWsOCn19X/Pb
        CgyPi/m7c5mlanI+9SQ/Pg20OZ4DNlxIimBOazvrHNjJtSfbAZwbXSUsh8cAGv8xAXOUPbkE
        4GDL7m3H4m8twBLUBmBrXr7VcRqDZ550cc4BLpcg98P+Ta5Z30VW4TB9ZeBZDZwsx2H1Xwts
        cyoHUgK75hsxM7PIfVCf/hVmNvPIg3Cg6SMzQtIH5ty3M0fYkIfgn4MG3Mw80g72Fs6yzIyT
        L8OMH4twc3pIDtnAlj+mCEunQfBK7pCVHeCjniaOhZ3hkqnDqifB6m+qCIs5E0DtXS2wXATA
        0305uLkJnPSA9W0+FnkPLOirwyyFbeGF9VnMovOgvnibX4Hf15da8zvB8ZV0K1PQmGGw7job
        wFHdGOci4GufG0j73EDa/0uXArwGONEqJiGaZvxUBxR00n+PHKFM0IFnH8YzRA9mHix4GwDG
        BQYAubhgF6/t7ZRIe16k/ItkWq2UqRPjacYA/Lb2nYs7O0Yot36cQiMTiiS+IrFYLJIcEAsF
        u3nu/r0R9mS0XEPH0bSKVm/7MK6NcxoGiAr/ZF7oypzXd8FRyYpEt0+iujJ3iEMq9bLNfTMc
        terksvvTcN0d+4LR5l/6J7tXz+aWc08uf33+UtkIf3hgr0/WcePRzXBhlKT8qnL5jtR0S8kZ
        y607XsSQoS7GydrxUwPN0hTTh06Btx8Vn+g6psceagaQg9uLqQEz3dOZP5Q21BcUKd50Ueo2
        dpjePRQ+JG73zArLW7tYqcv+9FVPVYJgOkktwYIL63yPBI2WdhtySukJ6aUpR9m13KlfM6Tv
        e78QcY39XtWUm2vYrGtwQtbehtDAzD1B74RVh9EeMtu1jsacjzfaaGqO7i1hFx5jOidTlaGf
        FXvxf28nFkWlAhYTIxd64mpG/i8/msbEuQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCSvO7Vy7UpBu/7WS3WnzrGbLH6bj+b
        xevDnxgtpn34yWzx5EA7o8XlJ3wWD/bbW+x9N5vV4uaBnUwWexZNYrJYufook8XuhR+ZLCYd
        usZo8fTqLCaLvbe0LRa2LWGx2LP3JIvF5V1z2CzmL3vKbtF9fQebxfLj/5gsDk1uZrLY8aSR
        0WLb7/nMFutev2exOHFL2uL83+OsFr9/zGFzkPG4fMXbY9b9s2weO2fdZfc4f28ji8fmFVoe
        l8+Wemxa1cnmsXlJvcfumw1sHov7JrN69Da/Y/P4+PQWi8f7fVfZPPq2rGL02Hy62uPzJrkA
        wSgum5TUnMyy1CJ9uwSujLf7vrIUbJGq+DU5p4Fxl2gXIyeHhICJxMcb2xm7GLk4hAR2MEp0
        bmtnhkhISiz7ewTKFpZY+e85O0RRM5PE843NQB0cHGwC2hKn/3OAxEUEtjBLnP01mRXEYRbY
        xizx4cMXdpBuYQFLiYPvNzOB2CwCqhI7GpuYQJp5BawkzmwJAzElBPQl+u8LglRwClhLvDx7
        iBkkLARUcfW9DUiYV0BQ4uTMJywgNrOAvETz1tnMExgFZiFJzUKSWsDItIpRMrWgODc9t9iw
        wCgvtVyvODG3uDQvXS85P3cTIzj+tbR2MO5Z9UHvECMTB+MhRgkOZiUR3l1e1SlCvCmJlVWp
        RfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MIkbP1hnzBXvn/7r08Hs
        PyxMm8T0AyI23dS9++JZ7gGm9Vou2mt3WV/4t0Xnzc0qfZO5U75qesgEzp1RVXd5s8gBF/ue
        E2dnPb+9KEssXMjrbVOVpf0XPpf1tY01RdtKTqXZmlfo5r8T3P5DMs3GXit3qd7XtfwxG1NL
        LM5apX/9sf3Xq1+iKkLzmb0/Rnav+9Z5bt+8xkuLDbnEnphtylaPdPI9utGco8uFZ/eC2Q9C
        7qh9Ut46pVeJ5WfBtpyjupVT2mPU7sTLu2Umz74jdd1D79Ck73dj8jn+Hbq6Lif6ftcRbSZP
        /ozlp38HKzDbsnrO3byYd9bUevMbLE59sssr51+XOd9npt3b991mthJLcUaioRZzUXEiAC14
        gQpuAwAA
X-CMS-MailID: 20230605122349epcas5p2de6c758bc38194ebfb1fd8c700e45608
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122349epcas5p2de6c758bc38194ebfb1fd8c700e45608
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122349epcas5p2de6c758bc38194ebfb1fd8c700e45608@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
index 4361a01bff3a..d9f45a1f0a77 100644
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

