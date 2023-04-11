Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E296DD51D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjDKIVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjDKIUP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:20:15 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038F344A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:19:47 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230411081945epoutp023a7735b306b9e9eb587c38349379b80c~U05IfXIB20589705897epoutp02R
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 08:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230411081945epoutp023a7735b306b9e9eb587c38349379b80c~U05IfXIB20589705897epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681201185;
        bh=3oNvHZOTqNqlN+q+wZYXheAb4+r+epzc3PSTrslmBBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHtWEoyXYfSlNY7aTlWuec23AQwEYVn79UB/NiKGbGZuD23gCJajKbNf1S6kvZ6o/
         soXRaSpn9Acs65Tum3RP3vWmybtPbxv/tlMZh0jzkLhyt6zGTCLXpU3dPlFZmgHEjc
         NgUB53Eq4L4qj8ypy+8gkMsv23dZKqAa4Kbe1k+o=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230411081944epcas5p32c059cbc4322d2f40a830470c4961fae~U05Hws4EY0205802058epcas5p3V;
        Tue, 11 Apr 2023 08:19:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Pwdzy6Jcqz4x9QK; Tue, 11 Apr
        2023 08:19:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.EC.09987.E1815346; Tue, 11 Apr 2023 17:19:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230411081342epcas5p22a4c587babd6a373cfa709d9609f65f4~U0z2KF_911873318733epcas5p2C;
        Tue, 11 Apr 2023 08:13:42 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230411081342epsmtrp165a97aca7b9f744fe5e1ac9e658333dc~U0z2HYLTt1918219182epsmtrp1T;
        Tue, 11 Apr 2023 08:13:42 +0000 (GMT)
X-AuditID: b6c32a4b-7fbff70000002703-5d-6435181e2d29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4A.FD.08609.5B615346; Tue, 11 Apr 2023 17:13:42 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230411081338epsmtip254352bf2c68432e6e66ec343cd492f17~U0zyW-oCI2386223862epsmtip2T;
        Tue, 11 Apr 2023 08:13:37 +0000 (GMT)
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
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 7/9] dm: Add support for copy offload
Date:   Tue, 11 Apr 2023 13:40:34 +0530
Message-Id: <20230411081041.5328-8-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230411081041.5328-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0zTVxTHc3+/8mshKSkg2wUcdl0IAQRaWsoFAcl0+kvYli5mD0kca+gv
        lEcf6WPKyBAhPETkUdBAYbzHAmw4ChIEioaXFoPMoU1kMhnSoGOAIkQIICu0bP73Oed+z/2e
        c24uA3ctpHsykuQaSiUXp3IIJ1r3kJ9voDcMlXAXSv3RtbFRHGWVbOOobbqYQAtDKwBdfbGB
        o5mbR5FxqcoBPbp1A0P9DToMtbSNYKiv/iWGRnYWCaQbNANkeajHkHEqAPUbTTQ02VtNoNpm
        Cx0NlmVjqGfuAkDdm7U4al9YpqE7U15oYvu2QwwkJx/Ekvon4wR5Qz9NJyf+7KCRk+Na0tB6
        kSA7m86TfY8yCfJy9hJBLg88JMiirlZAdt5NJ18ZvEnD3CImco5LiZRSYgmlYlPyBIUkSZ4Y
        xYk9FX8sPlTI5QXywlEYhy0Xy6gozvGPRYEnklKtG+CwvxWnaq0pkVit5gRHR6oUWg3FlirU
        migOpZSkKgXKILVYptbKE4PklCaCx+WGhFqF36RI51vqgPKp57l7Dfm0TDDrXgAcGZAlgI39
        r0EBcGK4svoA7FlsxG3BCoD3LR10W/AKQHPJG3y/pKW8gLAd9AL4uvmxXZWNwbH1sj0VwfKF
        w/M5excfYOXi8KXlIm03wFm/Y3Cra3lP5cZC8A9DDX2XaSwfqNus32OmNZ+1U2H1YFj9gmHx
        E5fdtCMrHG79kE/YJC7QVDlH22WcdQhmX6+yt1frCCfKP7fxcdi+cMXBxm7w79tddBt7wufF
        uXZOhOuTFszGSpg9OgBsfBTmjBXjuy3gLD94rTfYln4PXhlrx2y2zvDy5py9lAl7avaZA/Na
        qu0MofFepp1JOD72o32/hQAO360DJYCtf2sc/Vvj6P+3rgN4K/CglGpZIqUOVfLl1Nn/njlB
        ITOAvW/hH9sDZmdeBA0CjAEGAWTgnAPMtR2+xJUpEad9R6kU8SptKqUeBKHWdZfinu4JCuu/
        kmvieYJwrkAoFArC+UIe512mb5QpwZWVKNZQKRSlpFT7dRjD0TMTy7iZPntm2Xzy/cPsIw61
        t76mzqokHZEzRc3HHie7Vw7FO05GbZ8Y4eeMrDYItCerYngtSvPzhW0vXd5qepylMV/oKnBL
        ykxLkM0MdKw+2OHxL60tf2ZuE/nFBjr7pFXi2s7DF6i1S3e2RoimkI+CTn0ljT6vypuqPXOw
        YqN7RVfE/cL7YENAtCmLbzkkW6molpm6yqZLRXlvapoCMlSn/zLyTsvjNvuXPtkq73lWXubh
        nszI4jwN1xjDvIaPuCRvlGb88v2Q9JzH5gemyJ/DIr4Uad8pkcy3job8thFjqE+bzv3QSee3
        XvTp+n3zs5+md9JH1/+5Wni9jNnZ+SsZ4VPD59DUUjHPH1epxf8C1XKlyJ8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSvO42MdMUg+mfmCzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WD/fYWe9/NZrW4eWAnk8WeRZOYLFauPspksXvhRyaLo//fsllM
        OnSN0eLp1VlMFntvaVvs2XuSxeLyrjlsFvOXPWW3ODS5mclix5NGRottv+czW6x7/Z7F4sQt
        aYvzf4+zOkh4XL7i7THr/lk2j52z7rJ7nL+3kcXj8tlSj02rOtk8Ni+p99h9s4HNo7f5HZvH
        +31X2Tz6tqxi9Nh8utrj8yY5j01P3jIF8EVx2aSk5mSWpRbp2yVwZTxfuYCx4LFUxblFHSwN
        jI9Euxg5OSQETCRWTuli62Lk4hAS2MEocetVAwtEQkLi1MtljBC2sMTKf8/ZIYoamSTmzWxn
        BkmwCahLHHneygiSEBGYwCxx6X4D2ChmgQdMEueff2EFqRIWsJC4vWkeO4jNIqAqMen3QjCb
        Fyje9H8GUAMH0Ap9if77giBhTgFLiT9zO8DCQkAlS/awQFQLSpyc+QTMZhaQl2jeOpt5AqPA
        LCSpWUhSCxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBEezltYOxj2rPugdYmTi
        YDzEKMHBrCTC+/W/cYoQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotg
        skwcnFINTPmCcb2L42xae/jWPFtmeUK74bLT6knaaQFir3TUC3ZoPuqY53mBf09PchmDau6z
        7NJtv/w64s/OesG7b0sxi627huG1T5qS3ou4r/4LLRX6O79Ys+qk1ayU47P33pfwjpq5QvvW
        Ib3Hlyy/TfM9kbFcWKgqke+jbKDc1GSneSxnTBY0xb1X6n05UYHD2t81j9v80++0E0k/zn2L
        /nghz7r4u9DPBfJOrcuPh2//9YFBWKA0sCdoxfSvuzYtyfFjPbdJw9xie1mvg1X3p/nHVfdF
        h1ufCVcsesB18Hm3nWBE1dfvHxfXsHClhBZlx95eEm2+evWKr6lv1S1XTQhm+R9YeWz1/jNV
        Do07KiRYlViKMxINtZiLihMBKOh6SlUDAAA=
X-CMS-MailID: 20230411081342epcas5p22a4c587babd6a373cfa709d9609f65f4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081342epcas5p22a4c587babd6a373cfa709d9609f65f4
References: <20230411081041.5328-1-anuj20.g@samsung.com>
        <CGME20230411081342epcas5p22a4c587babd6a373cfa709d9609f65f4@epcas5p2.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
index 20c6b72a0245..1492bea4d605 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1709,6 +1709,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
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
index 8aa6b3ea91fa..70142fff417c 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -386,6 +386,11 @@ struct dm_target {
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

