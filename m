Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C7F69CB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjBTMtR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbjBTMtK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:49:10 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FE1CAF3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:35 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220124834epoutp038d5869fac4b6670a69051cfec0d60bd0~FiTkDMmid2509725097epoutp03b
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220124834epoutp038d5869fac4b6670a69051cfec0d60bd0~FiTkDMmid2509725097epoutp03b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897314;
        bh=s/gsPXisGnHj5x7odGOR5QtxX7QomcTNLxphM7Mn6Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+QkyB7xiR/lG0EmC76+zd2cZCF0gXRDhI4JidOMQCJgLsi8Y28XHAOSUZm10MpLY
         vquAL5rKSeg1vizzH58NCC49WzejBDwhd4TUoMZ/A5HWnjEtyKqHMLrjUxRz8jYwCa
         6xGOO1/erjRkg4Li53HdYZ4yWaoES6LhR8RJKBBc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230220124833epcas5p2cc50788c454811886b7df2a4aafacecd~FiTjaW5Oh1601516015epcas5p2X;
        Mon, 20 Feb 2023 12:48:33 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PL2KC5KBjz4x9Pt; Mon, 20 Feb
        2023 12:48:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        70.59.06765.F1C63F36; Mon, 20 Feb 2023 21:48:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105503epcas5p2cb05eb671de6954b7604e49ebd23ce41~Fgwc5-wb01660316603epcas5p2D;
        Mon, 20 Feb 2023 10:55:03 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220105503epsmtrp23bda6ee826dd76ec1000659f955cf78d~Fgwc4wiAU1664116641epsmtrp2V;
        Mon, 20 Feb 2023 10:55:03 +0000 (GMT)
X-AuditID: b6c32a4b-20fff70000011a6d-b6-63f36c1f3f33
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.8C.05839.78153F36; Mon, 20 Feb 2023 19:55:03 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105458epsmtip2562bae17173ca10a9ba68190220eb74b~FgwY0Ift80747307473epsmtip2s;
        Mon, 20 Feb 2023 10:54:58 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 4/8] fs, block: copy_file_range for def_blk_ops for
 direct block device.
Date:   Mon, 20 Feb 2023 16:23:27 +0530
Message-Id: <20230220105336.3810-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc+4tty2z2xVRDpiNWuIcGKAV6E4NOBbQ3QQXWdyWbHFiV+6A
        UNraliGwjO8FQVagbsy6AQoYoAsdFR1fnayICEiIImwICBgwAwOInYBD1rW7sPnf7zzv85z3
        nPfkcHC302wvToJCS6sVUrmAcGVd7fT19feW22TCgjt7kKn3Bo6yi9dxZBzXEejbx89wtNY/
        gCPLwnkXNNLRgqH2i6UYqjN2YajtwhKGuuzzBCq1DgM0M2TAkOXeXtRu6WGhwdbvCVRxaYaN
        rPocDDVPZwF0da0CRw2PFlno5r2daGC92yXcgxq8G0UZJvoJqsUwzqYG7jeyqMH+ZMpcf5qg
        LldnUG0jmQRVlLPgMORNuFCLvwwR1NdN9YC63JdO2cyvUebpeSz6lY8TQ+NpaSyt5tMKmTI2
        QREXJog6GhMREyIWivxFEvSmgK+QJtFhgsjD0f6HEuSOEQj4n0vlyQ4pWqrRCAIPhKqVyVqa
        H6/UaMMEtCpWrgpWBWikSZpkRVyAgtbuFwmF+0IcxhOJ8aO5c5jK/vqpunIjngnM/ALA5UAy
        GD7M/wlzshvZBqDVuKUAuDr4CYB/j+sAs1gGcGZ0Cd9MlFyrwZiCxZEoXMGZeA4GO1d3FwAO
        hyD3wj47xym7k2MYbOnzcfpxchKDFdnVwFnYRn4CTbVjbKefRe6GX3WmOWUeKYGL3YWYU4Zk
        INRNbHUil9wPV3JTGcdW2HNumuVknPSGOVfO487dIVnFhc9tHYA5ZiS8PjjlwvA2ONfdxGbY
        C9oWLATDKbDubC3BhHMBNPxm2Ai/BfN6dbizMU76QlNrICO/Cr/pbcCYxi/DorVpjNF5sLl8
        k33gj6bKjf094fBK1gZTsHGohmDGVgSg/WEHuxjwDS9cyPDChQz/t64EeD3wpFWapDhaE6IK
        UtAp/z2xTJlkBv/+Cb+oZvBg8nGAFWAcYAWQgwvceXaeTebGi5WmptFqZYw6WU5rrCDEMe4S
        3Gu7TOn4VAptjChYIgwWi8XBkiCxSODB2xPWI3Mj46RaOpGmVbR6M4dxuF6Z2KM/j/l4V3Tf
        Uhhrf3Bt6tWnPxe2RCg7j1Zlt+2z/PXpFPF7xq4DSSPveJS8tMqblLybpqi8tqPmqf7M4OzK
        wV8/GIAjw0+K9RdbD3amB7nFJk5kf1GjW5aL2LcX8pt4n93Fl2p4J0+421q5w7vGjtusxlHD
        7bddD0viClPeSCuWmWasnlOpJYl+o1H6xiuHjt04eX3nbEQperbMCw+VpNeXRU5xzgTFmD7q
        vfTdh3Pm41Pvp9SBmez52e3z+XeiJQ/aqyfUR5IapNHvZXQO+5zTjaStinPS87xPPV382WaX
        7AhPzfpDb90SXhyyzr2Q2XUro4NbVlte9eU862ZZX0TBkftdApYmXiryw9Ua6T8u6XEBnAQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWy7bCSvG574Odkg/5mPov1p44xWzRN+Mts
        sfpuP5vFtA8/mS1+nz3PbLH33WxWi5sHdjJZ7Fk0icli5eqjTBa7F35ksjj6/y2bxaRD1xgt
        nl6dxWSx95a2xZ69J1ksLu+aw2Yxf9lTdotDk5uZLHY8aWS02PZ7PrPFutfvWSxO3JK2OP/3
        OKuDuMflK94es+6fZfPYOesuu8f5extZPC6fLfXYtKqTzWPzknqP3Tcb2Dx6m98BFbTeZ/V4
        v+8qm0ffllWMHptPV3t83iTnsenJW6YA/igum5TUnMyy1CJ9uwSujNstr5gK/qtVrJy3mrmB
        cZNCFyMnh4SAicTE/UuZQGwhgd2MEstXsELEJSWW/T3CDGELS6z895y9i5ELqKaRSeLEr89A
        DgcHm4C2xOn/HCBxEYFnTBJn7z1iBnGYBd4xSax6uAxskrBAtMT/uR9ZQRpYBFQl2g5XgYR5
        BSwl3h/vZgIJSwjoS/TfFwQxOQWsJL63VEKcYylxYtJmRohqQYmTM5+wgNjMAvISzVtnM09g
        FJiFJDULSWoBI9MqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgSNbS3MG4fdUHvUOM
        TByMhxglOJiVRHj/835OFuJNSaysSi3Kjy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFq
        EUyWiYNTqoEp0PxteVATo43V1uAVK7QtD1Rq8KisTilWu5edovdNsf1E+molh122Zw7V1FgH
        Xr/M9fhZJnPrI7nbwqujnkT1vDrK6HPP99/txYqXd0qraL2p1TUtdrm9IL966QopWWueQ91T
        Bfddlpp/k6Xu1tK3SZta9jaqdfXukij569kj8C6Xcb3/v7O+CzwqLs44+VDbx9Hz6qUz75bd
        mLv0/d4bIhLHu/+8XGKX039Ff5PD4j1xbj/7Deeu+6ixwEbTY7+GwcIlr6518p87sNz4hFlM
        I98REcPtDc1OrPn69eFT10Z9c+Q5vs5bcZoi+8pvTDabM3+5l3dd6pnWOefG/et2bJPlzmi+
        V1s8e+/kPDV3JZbijERDLeai4kQAGpeiJVMDAAA=
X-CMS-MailID: 20230220105503epcas5p2cb05eb671de6954b7604e49ebd23ce41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105503epcas5p2cb05eb671de6954b7604e49ebd23ce41
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105503epcas5p2cb05eb671de6954b7604e49ebd23ce41@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For direct block device, use copy_file_range to issue device copy offload,
and fallback to generic_copy_file_range incase device copy offload
capability is absent. Modify checks to allow bdevs to use copy_file_range.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-lib.c        | 22 ++++++++++++++++++++++
 block/fops.c           | 18 ++++++++++++++++++
 fs/read_write.c        | 11 +++++++++--
 include/linux/blkdev.h |  3 +++
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 74f58faf82d8..6593de525a26 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -475,6 +475,28 @@ static inline bool blk_check_copy_offload(struct request_queue *q_in,
 	return blk_queue_copy(q_in) && blk_queue_copy(q_out);
 }
 
+int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *in_q = bdev_get_queue(bdev_in);
+	struct request_queue *out_q = bdev_get_queue(bdev_out);
+	int ret = -EINVAL;
+	bool offload = false;
+
+	ret = blk_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	offload = blk_check_copy_offload(in_q, out_q);
+	if (offload)
+		ret = __blk_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
+				len, end_io, private, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 /*
  * @bdev_in:	source block device
  * @pos_in:	source offset
diff --git a/block/fops.c b/block/fops.c
index 50d245e8c913..bcb9ee6565ea 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -596,6 +596,23 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	int comp_len;
+
+	comp_len = blkdev_copy_offload(in_bdev, pos_in, out_bdev, pos_out, len,
+			    NULL, NULL, GFP_KERNEL);
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
@@ -679,6 +696,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/read_write.c b/fs/read_write.c
index 7a2ff6157eda..62e925e9b2f0 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/blkdev.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -1448,7 +1449,11 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
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
@@ -1709,7 +1714,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
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
index 766761911190..ca7828b25d90 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1066,6 +1066,9 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 int blkdev_issue_copy(struct block_device *bdev_in, loff_t pos_in,
 		      struct block_device *bdev_out, loff_t pos_out, size_t len,
 		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+int blkdev_copy_offload(struct block_device *bdev_in, loff_t pos_in,
+		      struct block_device *bdev_out, loff_t pos_out, size_t len,
+		      cio_iodone_t end_io, void *private, gfp_t gfp_mask);
 struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		gfp_t gfp_mask);
 void bio_map_kern_endio(struct bio *bio);
-- 
2.35.1.500.gb896f729e2

