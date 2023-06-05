Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A77225C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFEMaG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbjFEM3n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:43 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86660D2
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:41 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230605122939epoutp03b4fd2418eaa3e33fa40a88a141adf559~lwyB9To2B1131011310epoutp03J
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230605122939epoutp03b4fd2418eaa3e33fa40a88a141adf559~lwyB9To2B1131011310epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968179;
        bh=zUsRGAnFK4MYn0CIcdQ1QIVt7eT1JTxOky0uRhgN1RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wjawjtwu0p02VDfEH5pb9Evg72QC9c4JnldUlMpi4rduWz7RwH/GH2gKTDnKSYZJz
         cOp6cxGCUrZIqoVGzFgCjdq4A6kJnIJXc5HripHvsSQrFKdPKZb9ricKBQLS5sRvXq
         9+VIArf03chUe3NLIq2nGW8b0V0egpAJHYADFhQk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122938epcas5p44ce472b062119d34b73bea811b4495fa~lwyAwaV4G1407614076epcas5p4F;
        Mon,  5 Jun 2023 12:29:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QZXww5kP3z4x9Pr; Mon,  5 Jun
        2023 12:29:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.F6.44881.035DD746; Mon,  5 Jun 2023 21:29:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122239epcas5p236a716d16fa1d1a2dfff856158deb5af~lwr6aRzdQ2830028300epcas5p2a;
        Mon,  5 Jun 2023 12:22:39 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605122239epsmtrp2f271b064dcc3e26955698db8682ab4eb~lwr6X1iFE0879508795epsmtrp2W;
        Mon,  5 Jun 2023 12:22:39 +0000 (GMT)
X-AuditID: b6c32a4a-c47ff7000001af51-78-647dd5307c53
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.C5.28392.F83DD746; Mon,  5 Jun 2023 21:22:39 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122234epsmtip228b80cbb7dc1de7f7d1b0755231f14a3~lwr1f4M562245922459epsmtip2J;
        Mon,  5 Jun 2023 12:22:34 +0000 (GMT)
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
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 4/9] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date:   Mon,  5 Jun 2023 17:47:20 +0530
Message-Id: <20230605121732.28468-5-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TazBcZxjud846dmOY4xL5rFy221GDuKygnyBMaswZ2ozEn1TT6rLHpdjd
        7K5KKm13o2EisSSadLqUxErdWluXGtdWVhC3iiIZWkGsGNnUdTJ0RNRa2vx73ud9n+e9fPMx
        casqUzYzQSijJUJ+EpfYw6hvd3J09Rj5QuAxo3dEmp5OHF3M3cBR5XgOgfTtywDdXPwHR7q2
        TICGdBZo8rdA1Dqfb4JG2xox1FJ8HUPllR0Yar69hKHr2ocAzYyoMNQ65oJuZ5QwUEtrNwMN
        NRUQqOiHGVN05VEDgUq7XmFIm5eOoQadAqD69SIcVekXGOj+mD0a2OgyQetrBUTQAWpoOIxS
        TfQTVKNq3JQaeFzNoGrLnKmh/hSqpuIyQdWWfEU1j8oJSq3MM6Gy0+cJamlmjEEt/DpCUMq6
        CkDV9qZRKzUHwy0jE/3jab6AlnBoYYxIkCCMC+CGRUS9G+Xt48Fz5fmid7gcIT+ZDuAGvxfu
        GpKQtHUiLuczflLKFhXOl0q57sf8JaIUGc2JF0llAVxaLEgSe4ndpPxkaYowzk1Iy47yPDw8
        vbcKP0mMz9bcwcWvHM5Va0oJORg9lAVYTEh6QeWDGiIL7GFakc0A3nk2yzAGywA+v6E2MQYr
        ABZtTjF2JZMZP+0kmgCsyNjY0V/C4MDLKdMswGQSpAvs3WQaeBuyDIeK1b5tX5zswmHnkgI3
        WFmTH8GnbZ3AgBmkAyxZM/RjMc3Jo/De2JVtI0i6w5wJSwPNIv3gXL8WN5ZYwu7vdNsT4eQh
        mP5LPm7wh+QfLDh5d4EwjhoMu6aLTYzYGj7rqjM1YjZcmW/dqUmF5d+UEUbx1wCqHqmAMREI
        L/Xk4IYhcNIJaprcjfQBeKOnCjM2toDZ6zrMyJvDhsJd/Bb8UXNrx98OPlxV7GAK1r3QmRqv
        pQRQrlBjuYCjem0h1WsLqf5vfQvgFcCOFkuT42ipt9hTSKf+984xouQasP1xnEMbwNTkopsW
        YEygBZCJc23Mm0LTBFbmAv75z2mJKEqSkkRLtcB76+DXcPbeGNHWzxPKonhevh5ePj4+Xr5H
        fHjcfeaOAd0xVmQcX0Yn0rSYluzqMCaLLcea9SH2/QNvaPShsZ3Mw3YFdX+ymvoPMjYGn0S8
        +bQus9GWnZ8pyw88k+ueSh7+nROJ8vZfveYiP3vm+JH7eYknzGZ00fyPI02OdduWJPWGfdtc
        +NfQqWELQtHB+tK3peJ0sdOp8I6ILNGL9g8uZqYx5hQs0pNjM9HnNzvmHJYZjav19m0Bk5/y
        jkuDKwdL1e9PR3MWTs6dK33sGXAiRyl7uWoer9xU4E9az374/G5DSZ9ZdQytcYDhF/auX1ZF
        7Fv7OcReMYDl2y1O4/vTrVdjN80KtRH++VcvNNmyBX1/DwapU8frL7sEve2n8vv+HjwZu9Q5
        e5M8P6Itly9HodPDD7gMaTyf54xLpPx/AQAthoPBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845OzsK2nHdPlMzRpoYaa3bp86KwDpkVlCIFJajnaY1dW5Z
        2QXNlaVimpbgpl103iYlatk0Z7YsM1u3peW6WbpCoja7WqbWHEH/Pfx+z/v89VI47w0xk4pL
        2MPKE0RSPulMNN7ke8/PNR0WL/h4dTKqvXsbR+l5oziqeZlLog83PwNUaPuJo4G24wCZBlxR
        3/UVSP9JzUG9bU0YainNx1B1zS0MXbswhKF8Qw9Alm4VhvTmeehChoZALfpOApmai0l0rsLC
        RdlPdSSq7BjDkKFAiSHdwBGAGkfO4ejSByuB7pg90IPRDg4aGS4mV3oxpifhjOq1kWSaVC+5
        zINXdQTTUOXPmIzJTL02k2QaNKnMtd40kik7WcBhcpSfSGbIYiYYa2s3yZy8rAVMQ9dB5kv9
        rI1uW5yFYlYat5eVBy6PcY7NqS3HZWM+++tqK8k00OudBZwoSC+GfRkXOVnAmeLROgDLuzq4
        DuEOK0bbcUeeAqvH3nMdJSUG085YsSxAUSQ9D3aNU3Y+lb6MQ+OvAo79AKef47DI6GnPU+it
        sDBfOcEJ2gdqhssmsgsdDNvN2Vz7DqQDYe5rNzt2okPgoNGA2zHvb6XbKnS03WBn0QDhWPeG
        yitqPA/Qqv+U6j91HmBa4M7KFPGSeMVCmSCB3RegEMUrkhMkATsS4+vBxBf4++tAi9YWYAAY
        BQwAUjh/qkvz2oNinotYlHKAlSdulydLWYUBeFAEf4bLw6zO7TxaItrD7mZZGSv/ZzHKaWYa
        Ftl/1/uGdH2w8NQbT7NuUVDMlaMRukZJ+9hqkLohpOwhPsgpzMuWC1tiXqzhnJ62Ifrez225
        O0w9KX2U+JCgu0cT8EiwJmewaqdNWLFkWP3tV2ytxJLU2vquuOGspu7U7nF3imd1C2t+rzuu
        r7y1NrD3u8+SE5lRcdPFNX3pJavMR8fv19m8jCfa3s2OijbYHheJ1EOaj0GZSaEjzVJ1yNy5
        P/iTEzfLuMcEtz301zdFWHxb5Y9dO7g1kybNkYY1gYr+4HE/vwMZHqVeg56l/Snpm79UBQX2
        JEt+L4h8ti/sa7jWN3Ra+a63XkvXLS86Q0WOLktNCnUNni4W8JW+ESX5fEIRK1roj8sVoj92
        6+OjdAMAAA==
X-CMS-MailID: 20230605122239epcas5p236a716d16fa1d1a2dfff856158deb5af
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122239epcas5p236a716d16fa1d1a2dfff856158deb5af
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122239epcas5p236a716d16fa1d1a2dfff856158deb5af@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 block/blk-lib.c        | 26 ++++++++++++++++++++++++++
 block/fops.c           | 20 ++++++++++++++++++++
 fs/read_write.c        |  7 +++++--
 include/linux/blkdev.h |  4 ++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 99b65af8bfc1..31cfd5026367 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -534,6 +534,32 @@ ssize_t blkdev_copy_offload(
 }
 EXPORT_SYMBOL_GPL(blkdev_copy_offload);
 
+/* Copy source offset from source block device to destination block
+ * device. Returns the length of bytes copied.
+ */
+ssize_t blkdev_copy_offload_failfast(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, gfp_t gfp_mask)
+{
+	struct request_queue *in_q = bdev_get_queue(bdev_in);
+	struct request_queue *out_q = bdev_get_queue(bdev_out);
+	ssize_t ret = 0;
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
+EXPORT_SYMBOL_GPL(blkdev_copy_offload_failfast);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/fops.c b/block/fops.c
index f56811a925a0..9189f3239c9c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -599,6 +599,25 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				struct file *file_out, loff_t pos_out,
+				size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t comp_len = 0;
+
+	if ((file_in->f_iocb_flags & IOCB_DIRECT) &&
+		(file_out->f_iocb_flags & IOCB_DIRECT))
+		comp_len = blkdev_copy_offload_failfast(in_bdev, pos_in,
+				out_bdev, pos_out, len, GFP_KERNEL);
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
@@ -692,6 +711,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..d27148a2543f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1447,7 +1447,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 		return -EOVERFLOW;
 
 	/* Shorten the copy to EOF */
-	size_in = i_size_read(inode_in);
+	size_in = i_size_read(file_in->f_mapping->host);
+
 	if (pos_in >= size_in)
 		count = 0;
 	else
@@ -1708,7 +1709,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
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
index 69fe977afdc9..a634768a2318 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1057,6 +1057,10 @@ ssize_t blkdev_copy_offload(
 		struct block_device *bdev_in, loff_t pos_in,
 		struct block_device *bdev_out, loff_t pos_out,
 		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+ssize_t blkdev_copy_offload_failfast(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, gfp_t gfp_mask);
 struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
 		gfp_t gfp_mask);
 void bio_map_kern_endio(struct bio *bio);
-- 
2.35.1.500.gb896f729e2

