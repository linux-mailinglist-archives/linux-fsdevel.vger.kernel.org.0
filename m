Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B4E4B4451
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242157AbiBNIgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:36:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242149AbiBNIgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:36:41 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4A94F472;
        Mon, 14 Feb 2022 00:36:11 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220214083609epoutp01607522428af862a444d322516ac30c74~TmiRjM7mR1004510045epoutp01e;
        Mon, 14 Feb 2022 08:36:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220214083609epoutp01607522428af862a444d322516ac30c74~TmiRjM7mR1004510045epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827770;
        bh=l8y9YIQatSjWKA1VT3EIziglsZq7xzC4RJS+MLkmrv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+XdKpjwhi4oERZotVvXzndFIqfjfbeuYNhw/4x2hq6PXjgvhCxn7+vAPL18SGn+Y
         ZOyf7a6tk2bCPGNsAVJ2C8mvRBFMn9xYBoahJkCUreVYIv15qGbUW8kPuOt8JRyYei
         BT5VT7cQ+LSZKF7avooOjMj1ELXmGRTDj6oPGVcE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220214083609epcas5p3b54754d3fa83cb27a2fceddb96a6586b~TmiRK3TtR2552125521epcas5p3b;
        Mon, 14 Feb 2022 08:36:09 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JxyH74RDkz4x9Pr; Mon, 14 Feb
        2022 08:36:03 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.07.06423.3741A026; Mon, 14 Feb 2022 17:36:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4~TmIp4Xabc2239022390epcas5p3K;
        Mon, 14 Feb 2022 08:06:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214080649epsmtrp1d094b9eacc8993b8a46c37c4150afd95~TmIp3i47q0046200462epsmtrp1V;
        Mon, 14 Feb 2022 08:06:49 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-91-620a14730caf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.F1.29871.99D0A026; Mon, 14 Feb 2022 17:06:49 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080644epsmtip251c38a47e899471516f26528f3ac9dc3~TmIk8FVhf2207122071epsmtip2c;
        Mon, 14 Feb 2022 08:06:43 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/10] dm: Add support for copy offload.
Date:   Mon, 14 Feb 2022 13:29:58 +0530
Message-Id: <20220214080002.18381-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxidu7vZJHRCl4f0Sm2NsbYCAomG9GJVHMV2UTtDdZzWjiOusCZI
        SNIktNY6UyCVEeShSB2IbY3UMfIoKBVKkVDEoTyCqEOhkhERgVLFBjVVQ0Vo4krrv3POPd/5
        7vfduQLcv40fLEjWGFm9hlFLSB+i7mJIaLgh0Gen1JY9H1V3/oqjxn4XD1UMFJDo6L1JHE1c
        GOahwoJiPuoZ8UU25zEeuuLOwNBwzQyGGksLMVRW0YqhMev3AJ0/cR9D2fYrGJoakqHWmb9I
        VNjSB9BorxlDNkcYarR1EKin4RsSHT81ykcHf68nUdO4DUfWtmkMdZunSFQ/kgFQ3ZPjOLp4
        o5dAVeMTBMo6+xCg/bmTfHT5aRtvtYTu+W0DbR68RNKHTU4+/bN5gE9fvnGWoE2W6wTdcymN
        rinPJukfT35JH7lmBfT5/nSSzuxqxeniB3+TdJ7JSdL3Rx0EPdHUS8YHfZyyQsUySaxezGoS
        tUnJGuVKyYbNCWsTohRSWbgsGr0tEWuYVHalJHZjfPi7yWrP/iTiTxl1mkeKZwwGSeSqFXpt
        mpEVq7QG40oJq0tS6+S6CAOTakjTKCM0rHG5TCpdGuUx7khRNV0b4ukevLrHVZZBpIOxoBwg
        EEBKDo8NEDnAR+BPnQcw86dTgCMPAHSUnvMQoYc8ArA4N3K2wPXUyHlsAFp7b/E4sh+Dednd
        pNdEUmHQPiPw1gZSBCx7/PhZB5xykbC98gnmPQig3oHO6juE109Qi+Af5VqvLKKWQ1NTEe7F
        kFoITwxd4Hmx0GNvHrfinMcPdpSMEF6MU/OhqfYY7s2H1LQQHnF0E9xFY+FkJcHlBMA7bef4
        HA6Gtwuy+Jz/IIDurkGMI8UAmg6ZSM4VA682PsW8QTgVAqsbIjn5Nfh1ZxXGNfaFeU9GME4X
        wfrvZvFCWFlteR4zF/Y9zniOadj81STOLSsfwB9KMolDQGx+YSDzCwOZ/29tAXg5mMvqDKlK
        1hClk2nYz/5740Rtag149qNC4+rBwM17ES0AE4AWAAW4JFC0/ZJwp78oifl8L6vXJujT1Kyh
        BUR5Fn4YD56TqPV8SY0xQSaPlsoVCoU8eplCJnlFZFeeYfwpJWNkU1hWx+pn6zCBMDgdW+to
        zpJ1Fq0+vH5ZsDtuzTQbNHjqtL7z5CP3J31BbW+NYXH7lrZ3zyv1+faotMjSV97uJ+n9U3y9
        LmiXrWuvcrf0F0Un69ix2Y0zqtQDxemu2G3vrftn1/CcdnZCUVK2u/n9rs6N6tDpmDOblNqA
        mhz7R84l64edJcKKkObX5dYiWnpNs+LNxVlTi0Sj87etCdz30pb8rdKYD4uGQsX49JBc+MaC
        kCPT9ti7eduzAzT2qwfm7Mm/W87zRf2Bp80uyzljfm5cjmWRv+lh1p6qDxi/RzM9DfC+uKz2
        9rwvUu5W+XYsdodsWmKNKKwL24XJo+/cutm0KmnHy1u3dKiWmy2166okhEHFyEJxvYH5F+aG
        uCvaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCSvO5MXq4kg5/X+S3WnzrGbLHn5mdW
        i9V3+9kspn34yWzx/uBjVotJ/TPYLS4/4bPY+242q8WFH41MFo83/Wey2LNoEpPFytVHmSye
        L1/MaLF74Ucmi87TF5gs/jw0tDj6/y2bxaRD1xgtnl6dxWSx95a2xZ69J1ksLu+aw2Yxf9lT
        dovu6zvYLPa93stssfz4PyaLc7P+sFnseNLIaLHt93xmi8P3rrJYrHv9nsWibeNXRovWnp/s
        Fuf/Hmd1UPK4fMXbY9b9s2weE5vfsXvsnHWX3eP8vY0sHs0L7rB4XD5b6rFpVSebx+Yl9R6T
        byxn9Nh9s4HNo+nMUWaPGZ++sHn0Nr9j8/j49BaLx/t9V9kCxKK4bFJSczLLUov07RK4Mvbd
        eMha8Em64vPKRpYGxudiXYwcHBICJhKf/5Z0MXJxCAnsZpRofDOPsYuREyguKbHs7xFmCFtY
        YuW/5+wQRc1MEm1vfrCDNLMJaEuc/s8BUiMiwCKx8vt3FpAaZoG57BJnXp9hB0kIC1hLvFv/
        igWknkVAVeLZqnyQMK+AlUTzvilQ85UlFj48yApicwKVH3i9HCwuBFQz4+ohdoh6QYmTM5+w
        gNjMAvISzVtnM09gFJiFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzg
        JKKluYNx+6oPeocYmTgYDzFKcDArifDGneVMEuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetk
        vJBAemJJanZqakFqEUyWiYNTqoHJp07ar2qOwYSmHZ2P/+kWr1vJmFfjNyvrz/FOfaHGl/u+
        /U5Y7LVyc/iX6HmL9TLSoqqqliarvVKWb8k8U8V96MmpHp0QIaOFjPV7fvc1rfx3bXM/4z/7
        J4fj5aw1XlafuzM5pXLOlsp5ndzyMi+CP59JyjbOXta6/IfN1XXJi8LMdjXdX7I4OMU5/dHm
        A3uCJRmnMR15VvNqRnPl9P9xdu9sPEtKGw/vTFu+8/VRW6lDoa7Mb+Tn3Tr05OfbSJ5SEY6u
        SfU+hgtmXH7E5u8uVyhuPMG9c+eFW49MnvdO2bmLnVl9WmuKzOddFbOL+l9uXrXq7sX20k67
        4md/3ToYDi99JG75dXpkQ/jHGLPjSizFGYmGWsxFxYkAtXupRZEDAAA=
X-CMS-MailID: 20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080649epcas5p36ab21e7d33b99eac1963e637389c8be4@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 45 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  6 +++++
 include/linux/device-mapper.h |  5 ++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e2..8dc9ae6a6a86 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1903,6 +1903,38 @@ static bool dm_table_supports_nowait(struct dm_table *t)
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
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_supported') and it relies on _all_ data devices having copy support.
+		 */
+		if (ti->copy_supported &&
+		    (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti, device_not_copy_capable, NULL)))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -2000,6 +2032,19 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	} else
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		/* Must also clear discard limits... */
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_hw_copy_sectors = 0;
+		q->limits.max_copy_range_sectors = 0;
+		q->limits.max_hw_copy_range_sectors = 0;
+		q->limits.max_copy_nr_ranges = 0;
+		q->limits.max_hw_copy_nr_ranges = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (dm_table_supports_secure_erase(t))
 		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ab9cc91931f9..3b4cd49c489d 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1372,6 +1372,12 @@ static int __split_and_process_non_flush(struct clone_info *ci)
 	if (__process_abnormal_io(ci, ti, &r))
 		return r;
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+				max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("%s: Error IO size(%u) is greater than maximum target size(%llu)\n",
+				__func__, ci->sector_count, max_io_len(ti, ci->sector));
+		return -EIO;
+	}
 	len = min_t(sector_t, max_io_len(ti, ci->sector), ci->sector_count);
 
 	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index b26fecf6c8e8..acfd4018125a 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -362,6 +362,11 @@ struct dm_target {
 	 * zone append operations using regular writes.
 	 */
 	bool emulate_zone_append:1;
+
+	/*
+	 * copy offload is supported
+	 */
+	bool copy_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.30.0-rc0

