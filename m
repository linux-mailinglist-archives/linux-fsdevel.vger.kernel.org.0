Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F3C7A76A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbjITI7y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjITI7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:22 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A751BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:42 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230920085841epoutp03b5965852e9970877b1d28f740dead538~Gj7Xr4gcA1764817648epoutp037
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230920085841epoutp03b5965852e9970877b1d28f740dead538~Gj7Xr4gcA1764817648epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200321;
        bh=zohq6qFcyNQPlL9CW1gp72Nbdr99RwoaaLJ8/DxbinM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjRORKPKWwdNEX125R3gRx6iZHENFQzfHk9BtRzQ75h7biE8KXgwu216qFOcN4vtp
         9CqQ902AwVy9J2qRXnOfxDkVr1EneweJfV+YxNQf2mJvckwIScbtWUYR1rPj757rN8
         IKzeCIXZE7QkuNuSpO6hKSCuNFkjKw/GOKR97ejA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230920085840epcas5p3beb33fd273b4b923788b1dad210b43b3~Gj7W4-4Zz1154211542epcas5p3e;
        Wed, 20 Sep 2023 08:58:40 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RrCB66xRDz4x9Q9; Wed, 20 Sep
        2023 08:58:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        54.F1.19094.E34BA056; Wed, 20 Sep 2023 17:58:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081548epcas5p14d9620a58744270e4f31a7cea4eec920~GjV7u96b42942529425epcas5p1j;
        Wed, 20 Sep 2023 08:15:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230920081548epsmtrp2376c601f064748387c98462119b603fd~GjV7t1bN80262802628epsmtrp2U;
        Wed, 20 Sep 2023 08:15:48 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-c7-650ab43e328d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.0F.08742.43AAA056; Wed, 20 Sep 2023 17:15:48 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081545epsmtip11c54e63139d09068832067b7cda16d8d~GjV4v7hjY0186201862epsmtip1g;
        Wed, 20 Sep 2023 08:15:45 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 09/12] dm: Add support for copy offload
Date:   Wed, 20 Sep 2023 13:37:46 +0530
Message-Id: <20230920080756.11919-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRzned/t3eBYvQIeDyuTRtIJARtt86GA5CJ6T6vj8q7rvJR28ArE
        2Hb7RYkZIr/EY5tYmZsgHRwgeIATaAJLghKHISE4YIF2OqxzByqkZYi0uVH+9/l8nu+vz/e5
        LxsPKmdx2bkyNa2USaQ8IoDRPbg5Kia5M4DmG1xi1D58AUf37i8zUOusnkCuwUWAnP3lAFkX
        TEw03X8OQ6daf8JQ9YAdoLmrRgxZHdHo27IGBuqz2hhovOcEgU42zrHQ4UkLgZqGHmNoyjAH
        kMV5AKDu5ZM4anPdYaCLjufQ6MoQc2sodc44y6JGr51hUOMjGsrccoigzjZ8QfVOFxFUve4o
        k6o6uEBQ9+YcDOrO91cJStfZAqgl8wuU2TmPpXN25iXm0JIsWhlOyzLlWbmy7CTe9h0Zb2aI
        xHxBjCABbeGFyyT5dBIv9Z30mLRcqds6L1wrkWrcUrpEpeLFJScq5Ro1HZ4jV6mTeLQiS6oQ
        KmJVknyVRpYdK6PVrwn4/HiRO/DjvJyKywu44sewT0/fHMOLwK2QSuDPhqQQ3lw0MSpBADuI
        7AOw97ti3EsWAXSV9PvIAwCr9GVgLaX+ktH3YAVw0mXCvKQUg4biGncUm02Q0fDSKtujh5BF
        OOzorQcegpPTGBw53415SgWTr8PqGjPuwQxyEyy12ZgezHHrh1ZLMU8hSMZB/fV1HtnfLS81
        TLK8Ieug7biT4cE4uREe7DI9mQiSJn9o+MPC9I6aCvVlJsKLg+HtoU6WF3Ph0oLVpxfAU182
        E97kEgCNk0afzzdg6bAe9wyBk5the0+cV94Avxpuw7yNn4FVy07Mq3OgpXYNR8DT7XW++mHQ
        /tcBH6ag/vwV37Z1AK40d7IMINz4lCHjU4aM/7euA3gL4NIKVX42nSlSCGJkdMF/H50pzzeD
        JxcRlW4BrR0rsQMAY4MBANk4L4STHxlAB3GyJJ/tpZXyDKVGSqsGgMi98SM4d32m3H1SMnWG
        QJjAF4rFYmHCq2IBL5TjKq3JCiKzJWo6j6YVtHItD2P7c4uwFwlp1bHlfYXFZ2+32WWRh1nV
        jyyz1ydCTrylOsPc3wAujD1Mfkm9u7Bx/ed/b3lIvB0dEVIxvi/l0YYH5Zf70V3/yOniXXVU
        49Z5P9eex99ENJekOXfurdVpfjGPT6Tx/T6o3b87UTLbMq+Nabo2Y4vfKKXnqeP/3GrSKuX6
        EW3Xxe2y+yVax5VuZsHyR4N+rbB2suUVaUWS6909Myk67ScVP3+t+XPGeoM71rfY9NvLO+zj
        gUdsol14qrrDVngj7Af7VCIdqHs2vtLataQ7Jvowc1teT9iKflNg6GhFeav9/cG6bVNRsbXP
        dx2V/7oaLnQkTvxuCSL9gg1xtCNh4m7KezyGKkciiMKVKsm/YnSQgZoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTcRjG+59zdnZczU5T2N8Mg4VCSaZ0+2Mp9aE8fZHKCLpArTyZ5Oba
        1CysJqKlecMiaJqXWpabuVqpM1uJpnMus6g0l3ahbYrS0ixJp1tOCfr2vM/veZ/3w0vhgmZi
        OZUoTWHlUnGSiOQRDW2ioLUbNDw2vN2wAum6OnA0/ttFIO1gEYlG234CZGu5BJDRWcpB/S1N
        GKrRtmOopLUXIPt7FYaM1lBUlaMm0FOjmUBvn5SRqKLazkVX+gwkumtyY+hDsR0ggy0ToAZX
        BY7qRn8QqNMaiHpmTZxtQqZJNchlej49JJi33amMXpNLMo/UF5nmfiXJ3C68ymEKspwkM263
        EsyPZ+9JpvCxBjAT+iBGb/uO7eYf5G2NZ5MS01j5uuijvJOXXzlx2YuA9Npvb3AlcPjnAR8K
        0hvgbYsKzwM8SkA3A+jKe85ZAAGwevYFvqD9YI17iLsQysJgf3XHHKAokg6FFg/l9f3pPBzm
        NjkJ74DTdgyOT00C77YfvQWW3NTPNxF0MMw2m+cv8Of8XE825i2C9DpY9HmZ1/aZsyfUfVyv
        FtCR0PK6grsQXwbNN2yEV+P0SphVX4oXA1r1H1L9hyoBpgEBrEwhSZAoImQRUvZMmEIsUaRK
        E8KOJ0v0YP6/a1YbQKNmLKwVYBRoBZDCRf58SQiPFfDjxWfPsfLkI/LUJFbRCgIpQiTkC4cL
        4gV0gjiFPcWyMlb+j2KUz3Il9mAix2+XK1KzNebCAXdy13SHNi0GO+bDGksTu4FHMirMeNOx
        qXe71JmTxrk/5jaFzCxh6PrUrj2O9NDfv7Cv6/dFTo1xSCz9cXRdzZdHlwe6PpuU11tehgt0
        K0umzwV79sYYlSqHMmrHoaNZnYz12oW+WJG/aSg8LmT0mi528UB5pTm7Nj8luaJQ8t0t6R35
        GWWrPFHf/mm3LqApKUNmbL8Xl88b/tIYNpj2x+Kr3n5w063IjQMjZewp+1DnZHTsDK/6252Z
        4jKL53hBprVBiC1ShsvPb5ad1jYsDR5eX9DmUAb5uoodq6oO7NfWfqxrrIq+eqVw5zvd4YeT
        bkO5iFCcFEesweUK8V93BZtWTgMAAA==
X-CMS-MailID: 20230920081548epcas5p14d9620a58744270e4f31a7cea4eec920
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081548epcas5p14d9620a58744270e4f31a7cea4eec920
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081548epcas5p14d9620a58744270e4f31a7cea4eec920@epcas5p1.samsung.com>
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
 drivers/md/dm-table.c         | 37 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 +++++++
 include/linux/device-mapper.h |  3 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 37b48f63ae6a..8803c351624c 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1878,6 +1878,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				   sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !q->limits.max_copy_sectors;
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
+		    ti->type->iterate_devices(ti, device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1960,6 +1992,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_hw_sectors = 0;
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 64a1f306c96c..eca336487d44 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1714,6 +1714,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+	    max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+		      ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 69d0435c7ebb..98db52d1c773 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -396,6 +396,9 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/* copy offload is supported */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

