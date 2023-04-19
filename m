Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810396E7911
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbjDSLzC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbjDSLyp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:54:45 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6D714F5B
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 04:54:39 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419115438epoutp037c8cc76348ad468f7515fc2199863eff~XU-CAeZIx1371913719epoutp03_
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419115438epoutp037c8cc76348ad468f7515fc2199863eff~XU-CAeZIx1371913719epoutp03_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681905278;
        bh=Z2LnmpXCeKveNBOyEvE4QzoJ7tl7STCy44ODCcmiAWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUDjwC6i8dJU4tbPFSeIQ2+15zoQ2Whp1Na8mTJyy3o4EAxjqUwkyE+k9VJ9ymFPv
         LcB8o7dZPVdmyLTlAYJwL4q0BWtBlixGg5jJkTX2Evyjk5yT/NQ9GYmBgaS+8XAZDZ
         MYTdZ/10BU9As+gDROQTsRb8d3YSGnbAujpkKTRc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230419115437epcas5p3c6249257f01eee32ddc9a14293f9b2e8~XU-BPcNcy1261612616epcas5p35;
        Wed, 19 Apr 2023 11:54:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Q1fNC56FSz4x9Pt; Wed, 19 Apr
        2023 11:54:35 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.1D.09961.B76DF346; Wed, 19 Apr 2023 20:54:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230419114723epcas5p461a6d54ffc6cc5c32ee9d5ab37978135~XU4tL4L9m0326203262epcas5p45;
        Wed, 19 Apr 2023 11:47:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230419114723epsmtrp2ad7279e1070694177e5d45cd57f14a30~XU4tK01uf2737927379epsmtrp2P;
        Wed, 19 Apr 2023 11:47:23 +0000 (GMT)
X-AuditID: b6c32a49-52dfd700000026e9-67-643fd67b99e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D5.97.08279.BC4DF346; Wed, 19 Apr 2023 20:47:23 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114720epsmtip1660107e95db765e14dfba3b279361149~XU4p7mRkg2495924959epsmtip1C;
        Wed, 19 Apr 2023 11:47:19 +0000 (GMT)
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
Subject: [PATCH v10 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date:   Wed, 19 Apr 2023 17:13:09 +0530
Message-Id: <20230419114320.13674-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230419114320.13674-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOOaccTjE1hwLjE4aWOjbRQFst9QPlEkB3NsgkYctgCWMNPVAC
        tF0vw42Y4Rg6UEAuNVjYZIIU8MJFMAi0m2UgF4EIApNZxQyWIIOCZLINHWtt3fz3vM/7PO/t
        y0dg7G+cvYh0mZpWysSZXNyFcb3Xf1dAzlS4hK8r3Ambh/ox+NWZ5xi8ZC7B4WLvEwSeXfkL
        g7M/hEPDcpUTvPfjDRT2XChDYeOlPhR2f7+Kwr7NJRyWmaYQOD+pQ6FhZg/sMQwy4ERXNQ7P
        1887Q1N5Hgo7544j8PrGeQxeXbQw4MCMNxx7fsspAlATd2Mo3cMRnLqhMztTYw9aGdTEiIZq
        ayrAqWt1X1Ld93JxqihvGacsxkmcKm5vQqhrwznUWtt2qm1uCY3b+lHGQSktltBKDi1LkUvS
        ZWmh3Jj45KjkIBFfECAIhvu5HJk4iw7lRsfGBRxOz7RegMv5TJypsVJxYpWKyws7qJRr1DRH
        KlepQ7m0QpKpECoCVeIslUaWFiij1SECPn9vkFX4SYb00axCUbTr6B+jejwXafAtRAgCkELw
        z0JMIeJCsMluBNSPn0bswRME5PdfQO3BUwR0FOVZM8wXjrpcvUNlQEBLrh63JdhkPgouVylt
        ZXFyDxjeJGwad/IEBlbnCxi2ACPHUfCs3YLZDG5kErh9s8DJZmCQfuCnSpWNZpEhoMI4zLCP
        xwMlD11tNJM8APTGcswucQWD5+YYNoyRO0BeRxVmKw/IWiZYmTjFsA8aDf5sXEXt2A08vtXu
        bMdeYG3ZgNtxNmisaMDt5q8RoJvWObYMB/lDJZhtCIz0B81dPDvtA7RDV1F7462gaGPOUZ8F
        Or97iXeCy801jvrbwNT6cQemwLkas+NWxQhYMCSeQTi6V/bRvbKP7v/ONQjWhGyjFaqsNFoV
        pBDI6Oz/njhFntWGvPgSu9/pRMyzK4EmBCUQEwIIjOvOun0oRMJmScSff0Er5clKTSatMiFB
        1nOXYl4eKXLrn5KpkwXCYL5QJBIJg/eJBFxP1luhgylsMk2spjNoWkErX/pQgumViyrX17qz
        Uenab67RpCk/8SRTO7rkWn/FM2JlqOJbz9oy0bF9PuXR7//Oh368w+MdRPWk79iy4VdtoDau
        1Bg5O51E+MW6BGUcm0w40BMR4q5wmxekayO1v/RXfuwXo2fSG33FTib3qvulwTXM0/qL1S2a
        SsvK23d2eJteOzX6uuXnO2bWyadHUsOq14ExyX/AP6HcaaEjMOTBmwPKTzcs5qO8zb3enhc/
        CAu7X8D2bd2e86jl7t9+71WOJH7YWvNu3nSncEtkk8cb5XUtuv2Pn/EUvctGjhorSsjJiT9R
        OxPV39DVcZPZH6UtiJVsiZd6+BgGj6QW1/Kau1LHzi5eIdo9uQyVVCzYjSlV4n8BIa8zkZsE
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSnO7pK/YpBtP2S1isP3WM2aJpwl9m
        i9V3+9ksXh/+xGgx7cNPZosH++0t9r6bzWpx88BOJos9iyYxWaxcfZTJYvfCj0wWR/+/ZbOY
        dOgao8XTq7OYLPbe0rbYs/cki8XlXXPYLOYve8pucWhyM5PFjieNjBbbfs9ntlj3+j2LxYlb
        0hbn/x5ndZDwuHzF22PW/bNsHjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S77H7ZgObR2/zOzaP
        9/uusnn0bVnF6LH5dLXH501yHpuevGUK4IvisklJzcksSy3St0vgynj4oKCgV6Pi67nlbA2M
        KxS7GDk5JARMJJY0LGfsYuTiEBLYzShx6OZmFoiEpMSyv0eYIWxhiZX/nrNDFDUzSTzcMRso
        wcHBJqAtcfo/B0hcRGACs8Sl+w1sIA6zwAMmifPPv7CCdAsLREt0b1jICNLAIqAqcWRGMUiY
        V8BKYsq+0ywgYQkBfYn++4IgYU4Ba4nl+yaD7RUCKuk59I8RolxQ4uTMJ2C3MQvISzRvnc08
        gVFgFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgiNZS3MH4/ZVH/QO
        MTJxMB5ilOBgVhLhdbexSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qBqS1r1vfc7a2zrXasU2KY8oTB/+CnS2p7RQQVCm1DdNbPPCGlprK4xOPXsbDH
        uraLX+Ubz03RmJd66sddedHsheH1hukhlnXd05WC6mNOfFSXOq/b+tmK/97y7Ss3cItJWzAq
        182ZsJH1WM2MC02rEuflXI3zet11SD9r20+r/jbPc1/FzvIu6l6uOGllyJkEs8Tr91t+F19J
        9hSzjHQRe1HPNr83ab2RkUL+7b+KE/o7H7hkJlwq03z1N3fatyKREu8r6vOlF7zYfunTxA0v
        2Y3+Saw5YpWpofB/95dnUcfd7DjmGdTMCE7+8T6QuaL69G972VcH94kqvWDcHH5126X0UCuz
        RywbeGbrndWuVGIpzkg01GIuKk4EAERXN8JTAwAA
X-CMS-MailID: 20230419114723epcas5p461a6d54ffc6cc5c32ee9d5ab37978135
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419114723epcas5p461a6d54ffc6cc5c32ee9d5ab37978135
References: <20230419114320.13674-1-nj.shetty@samsung.com>
        <CGME20230419114723epcas5p461a6d54ffc6cc5c32ee9d5ab37978135@epcas5p4.samsung.com>
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

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, and fallback to generic_copy_file_range incase
device copy offload capability is absent.
Modify checks to allow bdevs to use copy_file_range.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c        | 23 +++++++++++++++++++++++
 block/fops.c           | 20 ++++++++++++++++++++
 fs/read_write.c        | 11 +++++++++--
 include/linux/blkdev.h |  3 +++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index ba32545eb8d5..7d6ef85692a6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -523,6 +523,29 @@ int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
 }
 EXPORT_SYMBOL_GPL(blkdev_issue_copy);
 
+/* Returns the length of bytes copied */
+int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      gfp_t gfp_mask)
+{
+	struct request_queue *in_q = bdev_get_queue(bdev_in);
+	struct request_queue *out_q = bdev_get_queue(bdev_out);
+	int ret = 0;
+
+	if (blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len))
+		return 0;
+
+	if (blk_queue_copy(in_q) && blk_queue_copy(out_q)) {
+		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
+				len, NULL, NULL, gfp_mask);
+		if (ret < 0)
+			return 0;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..042a62c81468 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -611,6 +611,25 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	int comp_len = 0;
+
+	if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
+		(file_out->f_iocb_flags & IOCB_DIRECT))
+		comp_len = blkdev_copy_offload(in_bdev, pos_in, out_bdev,
+				 pos_out, len, GFP_KERNEL);
+	if (comp_len != len)
+		comp_len = generic_copy_file_range(file_in, pos_in + comp_len,
+			file_out, pos_out + comp_len, len - comp_len, flags);
+
+	return comp_len;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -694,6 +713,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/read_write.c b/fs/read_write.c
index a21ba3be7dbe..47e848fcfd42 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/blkdev.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -1447,7 +1448,11 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
-	size_in = i_size_read(inode_in);
+	if (S_ISBLK(inode_in->i_mode))
+		size_in = bdev_nr_bytes(I_BDEV(file_in->f_mapping->host));
+	else
+		size_in = i_size_read(inode_in);
+
 	if (pos_in >= size_in)
 		count = 0;
 	else
@@ -1708,7 +1713,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+
+	if ((!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode)) &&
+		(!S_ISBLK(inode_in->i_mode) || !S_ISBLK(inode_out->i_mode)))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a54153610800..533ad682e0ca 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1057,6 +1057,9 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
 		      struct block_device *bdev_out, loff_t pos_out, size_t len,
 		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      gfp_t gfp_mask);
 struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		gfp_t gfp_mask);
 void bio_map_kern_endio(struct bio *bio);
-- 
2.35.1.500.gb896f729e2

