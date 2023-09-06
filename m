Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B09794282
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243558AbjIFRzv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjIFRzr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:55:47 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0341F19A4
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:55:07 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230906175445epoutp03b77bb0e93d6408367def379947a467da~CYNbJKc9w1120911209epoutp03o
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230906175445epoutp03b77bb0e93d6408367def379947a467da~CYNbJKc9w1120911209epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022885;
        bh=zcZNECiRVLUz6kLQ0aORLlf+XCJDTvu9EB90O/f7EvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8G8f2/fnpX8X01owsr1X1cCrEXdVD+QAXvJF2o6SlYyLp9myoMZnVgSdc5r1n85g
         7wm3JO8KvQb3BE4VDVXwcsDAnOkCtL/7ochTstQhSo6zYb44IwjzlWcxapR2eQZ0hB
         igMBEUv/qN84LuPw/+73HiMLFranjwpJQWG4wFTk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230906175444epcas5p30ce70a231b0320d66b92bf78b3a925a2~CYNZ7SHJw2652926529epcas5p3u;
        Wed,  6 Sep 2023 17:54:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Rgql70Jk6z4x9Pp; Wed,  6 Sep
        2023 17:54:43 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.E9.09638.2ECB8F46; Thu,  7 Sep 2023 02:54:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2~CXPwsmNjD2437224372epcas5p3P;
        Wed,  6 Sep 2023 16:44:07 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164407epsmtrp2f91c203a03d2021346bd345f74f3b2ca~CXPwrnkUM1133211332epsmtrp2r;
        Wed,  6 Sep 2023 16:44:07 +0000 (GMT)
X-AuditID: b6c32a4a-6d5ff700000025a6-78-64f8bce2f611
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.86.08649.75CA8F46; Thu,  7 Sep 2023 01:44:07 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164405epsmtip20dd79d5f98a452b252d16cf2b4372005~CXPuHE-T40127201272epsmtip2g;
        Wed,  6 Sep 2023 16:44:05 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 09/12] dm: Add support for copy offload
Date:   Wed,  6 Sep 2023 22:08:34 +0530
Message-Id: <20230906163844.18754-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1DTZRzHfb7fL1+G57qvSPaMNNZI7oBjbMbgIcFMsb4K2i7u6vTqaMe+
        Dg7Y1n5AmHdMFwWogPnjjlGCbCcwUoyQSFjBEKeg8WPxs1MKRmnATFdAEdnmRvnf6/1+ns/n
        83w+z/Ow8MAHZDArU65hVHJJNo9cTbR0hYdHTbYvSgV3ftiCGnuu4ajhdhmJZroeAuTo+Bgg
        i7PSD411fI2h+oZuDH1iHQZoesiAIct4JDr3kYlA7ZYbBLJf+ZREVeen/VGt7R8MjZZPA9Sy
        VIWjizP3CXR9/FnUt2zz2xZE9935gqDtt7R0k7mYpL80FdBtYzqSNpae9KOP650k/WB6nKDv
        fzNE0qXNZkC7mp6jmxxzmHjN/qyEDEYiZVRcRp6ukGbKZYm85NS0HWmiWIEwShiP4nhcuSSH
        SeQlpYijXs3MdrfJ4+ZKsrVuSyxRq3nRWxNUCq2G4WYo1JpEHqOUZitjlHy1JEetlcv4ckbz
        klAg2Cxyb3w3K0PXPQSUVznvOxdHgA78HFQCAliQioGmok6yBKxmBVJtAP7dVusTDwEs+3PO
        zyvmARxcqPJbCalpqfEtWAD8w1FCeEUhBk311W7BYpFUJOx9xPL4QZQOh5fajMAjcKoYg71L
        vaQn1TpqC5xrb3/MBLUJHu13Yp5gttvXW/I9CKloWDax1rMjwO0eOTwAPMym1sIbFQ7CwzgV
        AvWXK3FPekjpA+DNMZvvpEmwqK6f8PI6+Kut2d/LwdDltJBezoP1p+pIb/CHABpGDMC78DIs
        7CnDPYfAqXDYeCXaa2+Ep3suYt7CT8HjSw7M67Nh69kVDoWfN1b78nPg8MJhH9PQuPC9b1il
        7snN2/3LAdfwREOGJxoy/F+6GuBmwGGU6hwZoxYpN8uZvP+uOV2R0wQev/2I3a3gpx9/41sB
        xgJWAFk4L4jtDJmXBrKlkvyDjEqRptJmM2orELnnfQIPfjpd4f48ck2aMCZeEBMbGxsT/2Ks
        kPcMe6bwM2kgJZNomCyGUTKqlTiMFRCsw4615b/17U3XmXwVNjE8NvmOaVAjMs92JlekpJrO
        mUO+Ex/gNGXtnEpaHFhltx9yvJB7stjmSoyOvMa/PHAKn2oOORQWlucU6veM1h4Qc1SzV110
        Kj0Kp02tnGNZb/e8UjjqEn1Vt7F/VfTW1/aZtjuKyv0t4iMJ681pBXot5xejcajy7vb5DYP3
        mOG/imuSTzQU2Tpt+cuhayY32MnegF2D2/gpGaGhYu3BsAuaD+re2Oc8P/H8/ppc5lZpxG6z
        NXRCsKd4r67ielzXhXvc9PXdVtnY3ZG+KZHy0t5Nr3OXct7TOvh1nDeNrlnTUZ0sDhf8fjqh
        IOzRzNkdHabbRQvLPEKdIRFG4Cq15F9lcJJohAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSvG74mh8pBv/nmFisP3WM2WL13X42
        i9eHPzFaPDnQzmix991sVoubB3YyWaxcfZTJYtKha4wWT6/OYrLYe0vbYmHbEhaLPXtPslhc
        3jWHzWL+sqfsFsuP/2OyuDHhKaPFtt/zmS3WvX7PYnHilrTF+b/HWR1EPM7f28jicflsqcem
        VZ1sHpuX1HvsvtnA5rG4bzKrR2/zOzaPj09vsXi833eVzaNvyypGj8+b5Dw2PXnLFMATxWWT
        kpqTWZZapG+XwJXRcPQqY8ERyYp3P64zNjA+E+li5OSQEDCRWLRtEWsXIxeHkMBuRonZm58y
        QSQkJZb9PcIMYQtLrPz3nB2iqJlJ4s/iP0AJDg42AW2J0/85QOIiAl3MEp0737GAOMwCk5kk
        Vp1fygLSLSxgLfF2zx42EJtFQFWi+8I7JpBmXqB4895KEFNCQF+i/74gSAUnULSp8SIjiC0k
        YCVxZ9VrMJtXQFDi5MwnYBOZBeQlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnJhgWGeanl
        esWJucWleel6yfm5mxjBUamlsYPx3vx/eocYmTgYDzFKcDArifC+k/+WIsSbklhZlVqUH19U
        mpNafIhRmoNFSZzXcMbsFCGB9MSS1OzU1ILUIpgsEwenVAPT0gkH3gpIrzHIjI36MSXrdeSH
        dStef42faJPyfhe/5jbeTTsms50+am+448GdVcyFj46EfVVNnCqak5MTbxd5L7zp1fuw+dtC
        T07++DU1kefn5Lu+JUcendwjvv2X505NthrenG+u9aIr/RhP11t/6rhedvDwogWy9985t2T0
        P6l1rlG3cGje4uf844zHGt2zMtlHX647ZCtnzeIuN01j1z/Nj9NfRU1j2H8+wkTMTKf17dSW
        qyF9bF9CdonOOb2mn2fy5sOPbC4nhQid3yWhdOryw+VfF0ce/HhtrePhBc1SvKGzedljrr+6
        fTK16OgJz/KTJ0y+Ljx4Tcf11/t+zotV4tm/p6sG/i54Z+P2LViJpTgj0VCLuag4EQAQCbn8
        OQMAAA==
X-CMS-MailID: 20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index 7d208b2b1a19..a192c19b68e4 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1862,6 +1862,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
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
@@ -1944,6 +1976,11 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
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
index f0f118ab20fa..f9d6215e6d4d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1732,6 +1732,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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

