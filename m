Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968FF667362
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jan 2023 14:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbjALNjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Jan 2023 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjALNiG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:38:06 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534794F13A
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 05:37:33 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230112133731epoutp0368854f7697124ad3b8a0a8160e3a68b2~5k0LQig6L2187321873epoutp03K
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 13:37:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230112133731epoutp0368854f7697124ad3b8a0a8160e3a68b2~5k0LQig6L2187321873epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673530651;
        bh=xxiDP6QZKfeqkiRLoXjxlMN+FlItKe4BO652Ksxx5Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jsce4rKGyQiKl5XjIg2wDNbmjh3Netg8iOt/reKPr5u/kcNPlRih5QBUjLplK7rg8
         R3LkEkIOWwJmTrSSpnOu6g1Kfd7Aw89Pd90Ow90PWoxrjSb/pThd6us15374NyqwJZ
         3M+A5wx1WMsCYjLE+WOAzOPnxptThHYYUYabSwt4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230112133730epcas5p3115034feada6d2eb43b03735703670da~5k0J99zGe0296902969epcas5p3_;
        Thu, 12 Jan 2023 13:37:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Nt5Fh4n3gz4x9Pv; Thu, 12 Jan
        2023 13:37:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.7D.62806.81D00C36; Thu, 12 Jan 2023 22:37:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230112120210epcas5p41524bba73af1dcf283d21b9c7ee9d239~5jg63K7pf1219512195epcas5p45;
        Thu, 12 Jan 2023 12:02:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230112120210epsmtrp104d470e1504fcb5fa6721c082d747ad3~5jg62S8B62544625446epsmtrp1L;
        Thu, 12 Jan 2023 12:02:10 +0000 (GMT)
X-AuditID: b6c32a4a-ea5fa7000000f556-d4-63c00d18ac89
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        63.C5.02211.2C6FFB36; Thu, 12 Jan 2023 21:02:10 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230112120207epsmtip27ad59d8d34c5e51703861416dce1293a~5jg4PDTug1331213312epsmtip2v;
        Thu, 12 Jan 2023 12:02:07 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 7/9] dm: Add support for copy offload.
Date:   Thu, 12 Jan 2023 17:29:01 +0530
Message-Id: <20230112115908.23662-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230112115908.23662-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1AUZRjH59099hbkcjmwXnGKa5UacPhxBLQQKDMYblpKxWTZMLgd290N
        x915e6fJTMMRSMKAB1l/sDhyhJT86ChABgTETlHgREoEgSRkBmbkCjAv/BGR3bFS/vd5vu/z
        fZ/neX/gqHQRC8TVWiNr0DIaEvMRtV0MCQmDkguKyPvng6imgcso9VnZCko1TFowqnuh0osa
        v9CBUHUNvQjVWf0HQvU+nseoL+yjgJod4RGqe2Ir1dXdL6KGz53EqKpvZsVU+0weoNqWq1DK
        VVsgpmy/LYqovolN1NDKFa+kAJqfGsToDn5STA/9+oOIHh400c31RRjdcjqX7hw3Y3Rp/gJG
        L54fwejjrfWAdjW/QDfPzCOpvvuzElQsk8kaZKxWoctUa5WJ5O53M5IzYmIj5WHyOOpVUqZl
        stlEcsebqWEpao17TFJ2iNGY3FIqw3FkxLYEg85kZGUqHWdMJFl9pkYfrQ/nmGzOpFWGa1lj
        vDwyMirGnXggS3Wj9LKXfjLwE1uFBTOD8Q3FwBuHRDR0XSxDioEPLiU6ASwZdIqF4B6AY04z
        EIL7ANZMz3mtWZzDD1BhoRvAr2t5kRDkI7Cl/3e3BccxYit0PMY9hgDiFgI7HJs9OShRicC+
        +enVnfyJOFj080PgYRERDO88vI56WELEw2q+TeTZBxIR0DLl55G9iddg49ifIiHFD/ZXzKwy
        SgTB/LOVqw1BIt8b1p4ZA0KnO2CxxSIS2B86r7SKBQ6Ec5bCJ3wY1n15BhPMBQDyN/kn5u3w
        6IAF9TSBEiGw6VyEID8PvxqwIULhZ2Dp8gwi6BLYfmqNN8PGJism8EY4+iAPE2ah4UjVqiwl
        jgN43XawDMj4p8bhnxqH/7+wFaD1YCOr57KVLBejj9Kyh/+7ZIUuuxmsvvzQXe1g+vbdcDtA
        cGAHEEfJAElXb49CKslkjuSwBl2GwaRhOTuIcR93ORq4QaFzfx2tMUMeHRcZHRsbGx33Sqyc
        fE7Cnq1SSAklY2SzWFbPGtZ8CO4daEZ8/KI6kUaty1etfDv3Lf/bK0ttqtaQpQV1WUPOTssp
        cSXnMCfbPjWbHGPKnKt97Tdzlws/X1q+M6F2sNakgw0fpfbmbxlriZg4mTbqaj4m2XnNlrYu
        qrxjT9+299YzCcd60p6VOn/C5GXqRzecKVMlFftG/zKHfpBiW1kiE+uvwTprzW7VEe5j5p2r
        vr9M12zan77FWF1in91lvjVzCd7T/73920PW4tfL1adPrKx/Y+8eu6T/QOecX1DVd6nrLu17
        PzxlaH4o/eWhIrb9x6S7PfHJ3h/a8goSsBOyLvyoumHZvGT6fm+jwze4G3VldAXzhfEvWTV1
        eVzWP4kvphtA6CNSxKkYeShq4Jh/AfROagqCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvO6hb/uTDX7c4LdYf+oYs0XThL/M
        Fqvv9rNZ7H03m9Xi5oGdTBYrVx9lsti98COTxdH/b9ksJh26xmjx9OosJou9t7Qt9uw9yWJx
        edccNov5y56yW+x40shose33fGaLz0tb2C3WvX7PYnHilrTF+b/HWR1EPGbdP8vmsXPWXXaP
        8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB59Da/Y/N4v+8qm0ffllWMHp83yXlsevKWKYAnissm
        JTUnsyy1SN8ugSvjSu8x1oK7UhXrZvazNTDeFO1i5OSQEDCReHX5OzOILSSwm1Gi83kyRFxS
        YtnfI8wQtrDEyn/P2bsYuYBqGpkkNp1aztbFyMHBJqAtcfo/B0hcROAZk8TZe4+YQRxmgaVM
        Egv2NbKCdAsLWEp0XvzBCGKzCKhKvPhxCWwqr4CVxMJZ21hABkkI6Ev03xcECXMKWEusufGF
        BeIgK4lZe64yQZQLSpyc+QQsziwgL9G8dTbzBEaBWUhSs5CkFjAyrWKUTC0ozk3PLTYsMMxL
        LdcrTswtLs1L10vOz93ECI5KLc0djNtXfdA7xMjEwXiIUYKDWUmEd8/R/clCvCmJlVWpRfnx
        RaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MOn+u2dx+eyCz54Ky0v0/970
        85saK2KY7mSw7CbX3D/Rh/siPi70/DMnZ1+t1d2TogWsk1+umXzR5IHG04ezo/w5Ot6suHFA
        5e5Nrje3tPLcW9a1aj5a+sHmSPaPTF+d5wkJGzSv3GPX2pOg8p2J8YW1boPOubYVK5Ni7ui6
        P2DsMFY0Frcr/Lz19+pDPEW/XmeXnlnxv8M1xWhBi3pJ2eHmN/Mntv/k33tH5tuG4oWXzC7c
        37rj3sbqhIuBLTt705OfLekxu10xhe9RUKLv9GCO8o+BZcYeK1d8urL6RFvlBzfbs4eOnWSP
        ShaUdvv4osjP94vsnYRnwreaedby3FWQmG3Yd+Zp/7qCHyf27UlRYinOSDTUYi4qTgQAPbEw
        lTkDAAA=
X-CMS-MailID: 20230112120210epcas5p41524bba73af1dcf283d21b9c7ee9d239
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230112120210epcas5p41524bba73af1dcf283d21b9c7ee9d239
References: <20230112115908.23662-1-nj.shetty@samsung.com>
        <CGME20230112120210epcas5p41524bba73af1dcf283d21b9c7ee9d239@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8541d5688f3a..4a1bbbb2493b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1875,6 +1875,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
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
@@ -1957,6 +1990,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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
index b424a6ee27ba..0b04093fbeb2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1690,6 +1690,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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
index 04c6acf7faaa..da4e77e81011 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -379,6 +379,11 @@ struct dm_target {
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

