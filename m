Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F0740B4C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjF1IZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:25:26 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:42515 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbjF1IXM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:23:12 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230628055511epoutp02c661403f43a5d418171e09d966584d5d~svPLqV66P0980409804epoutp02K
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 05:55:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230628055511epoutp02c661403f43a5d418171e09d966584d5d~svPLqV66P0980409804epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687931711;
        bh=NTNc+ItbCseABSQzv97aAbiEUsQCH4xnwesge+a7EpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OtOyLG5J97wBNt09koDybIQKq+iWoruU4B3zbgGLhMhzOq+BbM2B+dOcplcl6OUO7
         YKcPpWhkNBziGZ9PjIM8R9C/qt7hw/pD/Iwnp/ntdtEO+iFB9elHbp+L4Ur5zhga5O
         KOQfq6U+6/8ZNKnUEErA5xf1ojS3QW+fA88j/b60=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230628055510epcas5p3581da359ff5c1cb2ab56c3fb616c7237~svPK1qwWr1930919309epcas5p38;
        Wed, 28 Jun 2023 05:55:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QrW591PSPz4x9Px; Wed, 28 Jun
        2023 05:55:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        03.7E.06099.C3BCB946; Wed, 28 Jun 2023 14:55:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9~smBz6usKp0481604816epcas5p42;
        Tue, 27 Jun 2023 18:40:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627184010epsmtrp1e62f43f8d5e9edee5eee964fb3729ddf~smBz5RKXE1856518565epsmtrp1I;
        Tue, 27 Jun 2023 18:40:10 +0000 (GMT)
X-AuditID: b6c32a4b-d308d700000017d3-7c-649bcb3c4ecd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.FC.64355.A0D2B946; Wed, 28 Jun 2023 03:40:10 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184006epsmtip21e67d1f396e8d0186c25289c09310537~smBwE2oOQ0383803838epsmtip2c;
        Tue, 27 Jun 2023 18:40:06 +0000 (GMT)
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
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 2/9] block: Add copy offload support infrastructure
Date:   Wed, 28 Jun 2023 00:06:16 +0530
Message-Id: <20230627183629.26571-3-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230627183629.26571-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1STZRzm/b6Pb2Me6AOBXpGM5gEF4jJh9EIQevDUl9RpJ+J0Ks6hyb4D
        i7GtbUil5wQCEsRFJTM2k2uJUBLXBuPmJi4g4RgCSiFqWxcMQTrliIA2BuZ/z+/5Pc/7u7zn
        x8bdzrG82GKpilFIhRIuySE6DP4BQTHDGlHodQ1ATUOXcXT0+AqOGqfLSHTXsAjQpwtLODL1
        FwA0ZnJBt/piUc89jSO60d+Joe6akxg63ziAoZP6CYDM42oM9UwFoupjdQTq7hkk0FjXGRJV
        fmlmoY8ntSQ6Z1zFkL48F0NaUw5AHcuVOLpwd55A301tR6MrRke0bDlD7vWmx67F053qaRY9
        erOZoFvrA+ixK5l0S0MhSbfWfUjrbmSTdG1puSNdknuPpO+bpwh6vnecpEvbGgDdOnyY/rNl
        B91imsME1Jvp0WmMUMQofBhpikwklqbGcOMTkuOS+RGhvCBeJHqG6yMVZjAx3P0vCYKeF0us
        2+H6HBJKMq2UQKhUckOei1bIMlWMT5pMqYrhMnKRRB4uD1YKM5SZ0tRgKaOK4oWG7uFbhW+n
        p5ksFkJekfbepe+3Z4OcxCLgxIZUOOwxDbOKAIftRukAzJsrJe3BIoAPlopZD4O6Hy2sTUt9
        Xg5hT3QC+O/R3A1LPgaLmk1WFZtNUoFweI1t492pbBx+o6sFtgCnjDi8fD8Ht4m2Ui/AgZUD
        tlcJyhd2/NxO2LAzFQVzr84CmwRSIbBsxtVGO1HPQt3oJUe7xBUOVpjW5Tj1JMxt1+C25yGl
        c4J/dJcS9k73w+u6XzfwVjhrbNuYwAv+XnZsA2fB85/Uk3ZzHoDqSTWwJ2Jh/lDZep845Q+b
        ukLs9BPw1NAFzF7YBZYsmzA77wy1ZzfxTvhVUxVpx9vgxIOcDUzDZvUEbl9WKYDGpl7iOPBR
        PzKQ+pGB1P+XrgJ4A9jGyJUZqYySLw+TMlkPfzlFltEC1i8mIF4L7txaCNYDjA30ALJxrruz
        p+W0yM1ZJHz/A0YhS1ZkShilHvCtCz+Be3mkyKwnJ1Ul88IjQ8MjIiLCI8MieNzHna9Olojc
        qFShiklnGDmj2PRhbCevbEwsKSjyEwz9tfS0od1S3FY8FVa9J73Gk1N/pCv9dsWOdOlawbsp
        Dp81/rY0PWuu+1yT9MWrWXvN/8zf5LzVkSRTtwzGubxe+9ORb4Uhsa4Jtz3iB31VhZKLM4kN
        vfx+2Bx8TezxdaU/P3fXR6lxW15ZE4QY+rCEBL2HQ98P40R8fdBB0t3owtG5V7NWOf3vNJqj
        EkMvDngEz6wu/SILXGziGBzeiD6LzY0oRtbYwdqFXeXm/KqdUS+nnPJz862M7w7ydIzcV2Mw
        Gk8vl2QIDu9+SuvAqy18ccQ78rHXevVDW4LE7PKKQ+CO/O+1gxr+gegGf23HvhN7YaJfyhVv
        lyTf3X5cQpkm5AXgCqXwP73o3tS6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSvC6X7uwUg6NzJSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFpMO
        XWO0eHp1FpPF3lvaFgvblrBY7Nl7ksXi8q45bBbzlz1lt+i+voPNYvnxf0wWhyY3M1nseNLI
        aLHt93xmi3Wv37NYnLglbXH+73FWi98/5rA5yHhcvuLtsXPWXXaP8/c2snhsXqHlcflsqcem
        VZ1sHpuX1HvsvtnA5rG4bzKrR2/zOzaPj09vsXi833eVzaNvyypGj82nqz0+b5Lz2PTkLVOA
        QBSXTUpqTmZZapG+XQJXxpMfP1gKZmZUHDkj3cDYGNrFyMkhIWAisaKlkaWLkYtDSGA7o8Sn
        D7uZIRKSEsv+HoGyhSVW/nvODlHUzCRx6cMloAQHB5uAtsTp/xwgcRGBLmaJzp3vWEAamAVu
        M0vMPCsDUiMs4C5x9K8XSJhFQFVi2+OtYCW8AlYSzRdfMYKUSAjoS/TfFwQJcwpYS+w+f4QV
        JCwEVPL+eABEtaDEyZlPoIbLSzRvnc08gVFgFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL
        89L1kvNzNzGCo14raAfjsvV/9Q4xMnEwHmKU4GBWEuEV+zE9RYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjivck5nipBAemJJanZqakFqEUyWiYNTqoFph2BmEXcgX/z2ZMHTDme/7OCZclHz8FT3
        SO6CuoZWBYEJWw/aS9rrvv9mZrrvckhJWNfs3TXtbI/tQp1a65m3hM8zUGHdWq3SzS4/T+H8
        9r/XHgsnnGOT79K+vLZeomrbx52nDSvCO35xHTmR4K1y8rqYdLhBZdnSR6LuX7lCNQK7Dn/e
        8ruevepL4Tzm5zxiLcLKP9Ys6H6numr5giY1i6daidES3yre39PuNjx2Ub+p94+mvuxFpRnt
        juwn+7q7P5af2RdykYdV9L6m1IPlV/xuPOQ/L/Rv0sqgiANrIxxbjh92FH6z+odK9fyrYa/k
        ku4yuGS76UhbMV5Udcn2imfYEj3VJMGOYVufhxJLcUaioRZzUXEiAAjW5SppAwAA
X-CMS-MailID: 20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184010epcas5p4bb6581408d9b67bbbcad633fb26689c9@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce blkdev_copy_offload which takes similar arguments as
copy_file_range and performs copy offload between two bdevs.
Introduce REQ_OP_COPY_DST, REQ_OP_COPY_SRC operation.
Issue REQ_OP_COPY_DST with destination info along with taking a plug.
This flows till request layer and waits for src bio to get merged.
Issue REQ_OP_COPY_SRC with source info and this bio reaches request
layer and merges with dst request.
For any reason, if request comes to driver with either only one of src/dst
info we fail the copy offload.

Larger copy will be divided, based on max_copy_sectors limit.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-core.c          |   5 ++
 block/blk-lib.c           | 177 ++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c         |  21 +++++
 block/blk.h               |   9 ++
 block/elevator.h          |   1 +
 include/linux/bio.h       |   4 +-
 include/linux/blk_types.h |  21 +++++
 include/linux/blkdev.h    |   4 +
 8 files changed, 241 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 99d8b9812b18..e6714391c93f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -796,6 +796,11 @@ void submit_bio_noacct(struct bio *bio)
 		if (!q->limits.max_write_zeroes_sectors)
 			goto not_supported;
 		break;
+	case REQ_OP_COPY_SRC:
+	case REQ_OP_COPY_DST:
+		if (!blk_queue_copy(q))
+			goto not_supported;
+		break;
 	default:
 		break;
 	}
diff --git a/block/blk-lib.c b/block/blk-lib.c
index e59c3069e835..10c3eadd5bf6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -115,6 +115,183 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(blkdev_issue_discard);
 
+/*
+ * For synchronous copy offload/emulation, wait and process all in-flight BIOs.
+ * This must only be called once all bios have been issued so that the refcount
+ * can only decrease. This just waits for all bios to make it through
+ * blkdev_copy_(offload/emulate)_(read/write)_endio.
+ */
+static ssize_t blkdev_copy_wait_io_completion(struct cio *cio)
+{
+	ssize_t ret;
+
+	if (cio->endio)
+		return 0;
+
+	if (atomic_read(&cio->refcount)) {
+		__set_current_state(TASK_UNINTERRUPTIBLE);
+		blk_io_schedule();
+	}
+
+	ret = cio->comp_len;
+	kfree(cio);
+
+	return ret;
+}
+
+static void blkdev_copy_offload_read_endio(struct bio *bio)
+{
+	struct cio *cio = bio->bi_private;
+	sector_t clen;
+
+	if (bio->bi_status) {
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) - cio->pos_out;
+		cio->comp_len = min_t(sector_t, clen, cio->comp_len);
+	}
+	bio_put(bio);
+
+	if (!atomic_dec_and_test(&cio->refcount))
+		return;
+	if (cio->endio) {
+		cio->endio(cio->private, cio->comp_len);
+		kfree(cio);
+	} else
+		blk_wake_io_task(cio->waiter);
+}
+
+/*
+ * __blkdev_copy_offload	- Use device's native copy offload feature.
+ * we perform copy operation by sending 2 bio.
+ * 1. We take a plug and send a REQ_OP_COPY_DST bio along with destination
+ * sector and length. Once this bio reaches request layer, we form a request and
+ * wait for src bio to arrive.
+ * 2. We issue REQ_OP_COPY_SRC bio along with source sector and length. Once
+ * this bio reaches request layer and find a request with previously sent
+ * destination info we merge the source bio and return.
+ * 3. Release the plug and request is sent to driver
+ *
+ * Returns the length of bytes copied or error if encountered
+ */
+static ssize_t __blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct cio *cio;
+	struct bio *read_bio, *write_bio;
+	sector_t rem, copy_len, max_copy_len;
+	struct blk_plug plug;
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	atomic_set(&cio->refcount, 0);
+	cio->waiter = current;
+	cio->endio = endio;
+	cio->private = private;
+
+	max_copy_len = min(bdev_max_copy_sectors(bdev_in),
+			bdev_max_copy_sectors(bdev_out)) << SECTOR_SHIFT;
+
+	cio->pos_in = pos_in;
+	cio->pos_out = pos_out;
+	/* If there is a error, comp_len will be set to least successfully
+	 * completed copied length
+	 */
+	cio->comp_len = len;
+	for (rem = len; rem > 0; rem -= copy_len) {
+		copy_len = min(rem, max_copy_len);
+
+		write_bio = bio_alloc(bdev_out, 0, REQ_OP_COPY_DST, gfp_mask);
+		if (!write_bio)
+			goto err_write_bio_alloc;
+		write_bio->bi_iter.bi_size = copy_len;
+		write_bio->bi_iter.bi_sector = pos_out >> SECTOR_SHIFT;
+
+		blk_start_plug(&plug);
+		read_bio = blk_next_bio(write_bio, bdev_in, 0, REQ_OP_COPY_SRC,
+						gfp_mask);
+		read_bio->bi_iter.bi_size = copy_len;
+		read_bio->bi_iter.bi_sector = pos_in >> SECTOR_SHIFT;
+		read_bio->bi_end_io = blkdev_copy_offload_read_endio;
+		read_bio->bi_private = cio;
+
+		atomic_inc(&cio->refcount);
+		submit_bio(read_bio);
+		blk_finish_plug(&plug);
+		pos_in += copy_len;
+		pos_out += copy_len;
+	}
+
+	return blkdev_copy_wait_io_completion(cio);
+
+err_write_bio_alloc:
+	cio->comp_len = min_t(sector_t, cio->comp_len, (len - rem));
+	if (!atomic_read(&cio->refcount)) {
+		kfree(cio);
+		return -ENOMEM;
+	}
+	return blkdev_copy_wait_io_completion(cio);
+}
+
+static inline ssize_t blkdev_copy_sanity_check(
+	struct block_device *bdev_in, loff_t pos_in,
+	struct block_device *bdev_out, loff_t pos_out,
+	size_t len)
+{
+	unsigned int align = max(bdev_logical_block_size(bdev_out),
+					bdev_logical_block_size(bdev_in)) - 1;
+
+	if (bdev_read_only(bdev_out))
+		return -EPERM;
+
+	if ((pos_in & align) || (pos_out & align) || (len & align) || !len ||
+		len >= COPY_MAX_BYTES)
+		return -EINVAL;
+
+	return 0;
+}
+
+/*
+ * @bdev_in:	source block device
+ * @pos_in:	source offset
+ * @bdev_out:	destination block device
+ * @pos_out:	destination offset
+ * @len:	length in bytes to be copied
+ * @endio:	endio function to be called on completion of copy operation,
+ *		for synchronous operation this should be NULL
+ * @private:	endio function will be called with this private data, should be
+ *		NULL, if operation is synchronous in nature
+ * @gfp_mask:   memory allocation flags (for bio_alloc)
+ *
+ * Returns the length of bytes copied or error if encountered
+ *
+ * Description:
+ *	Copy source offset from source block device to destination block
+ *	device. If copy offload is not supported or fails, fallback to
+ *	emulation. Max total length of copy is limited to COPY_MAX_BYTES
+ */
+ssize_t blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t endio, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *q_in = bdev_get_queue(bdev_in);
+	struct request_queue *q_out = bdev_get_queue(bdev_out);
+	ssize_t ret;
+
+	ret = blkdev_copy_sanity_check(bdev_in, pos_in, bdev_out, pos_out, len);
+	if (ret)
+		return ret;
+
+	if (blk_queue_copy(q_in) && blk_queue_copy(q_out))
+		ret = __blkdev_copy_offload(bdev_in, pos_in, bdev_out, pos_out,
+			   len, endio, private, gfp_mask);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy_offload);
+
 static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 65e75efa9bd3..bfd86c54df22 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -922,6 +922,9 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
 	if (!rq_mergeable(rq) || !bio_mergeable(bio))
 		return false;
 
+	if ((req_op(rq) == REQ_OP_COPY_DST) && (bio_op(bio) == REQ_OP_COPY_SRC))
+		return true;
+
 	if (req_op(rq) != bio_op(bio))
 		return false;
 
@@ -951,6 +954,8 @@ enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
 {
 	if (blk_discard_mergable(rq))
 		return ELEVATOR_DISCARD_MERGE;
+	else if (blk_copy_offload_mergable(rq, bio))
+		return ELEVATOR_COPY_OFFLOAD_MERGE;
 	else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
 		return ELEVATOR_BACK_MERGE;
 	else if (blk_rq_pos(rq) - bio_sectors(bio) == bio->bi_iter.bi_sector)
@@ -1053,6 +1058,20 @@ static enum bio_merge_status bio_attempt_discard_merge(struct request_queue *q,
 	return BIO_MERGE_FAILED;
 }
 
+static enum bio_merge_status bio_attempt_copy_offload_merge(
+	struct request_queue *q, struct request *req, struct bio *bio)
+{
+	if (req->__data_len != bio->bi_iter.bi_size)
+		return BIO_MERGE_FAILED;
+
+	req->biotail->bi_next = bio;
+	req->biotail = bio;
+	req->nr_phys_segments = blk_rq_nr_phys_segments(req) + 1;
+	req->__data_len += bio->bi_iter.bi_size;
+
+	return BIO_MERGE_OK;
+}
+
 static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 						   struct request *rq,
 						   struct bio *bio,
@@ -1073,6 +1092,8 @@ static enum bio_merge_status blk_attempt_bio_merge(struct request_queue *q,
 		break;
 	case ELEVATOR_DISCARD_MERGE:
 		return bio_attempt_discard_merge(q, rq, bio);
+	case ELEVATOR_COPY_OFFLOAD_MERGE:
+		return bio_attempt_copy_offload_merge(q, rq, bio);
 	default:
 		return BIO_MERGE_NONE;
 	}
diff --git a/block/blk.h b/block/blk.h
index 608c5dcc516b..440bfa148461 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -156,6 +156,13 @@ static inline bool blk_discard_mergable(struct request *req)
 	return false;
 }
 
+static inline bool blk_copy_offload_mergable(struct request *req,
+					     struct bio *bio)
+{
+	return ((req_op(req) == REQ_OP_COPY_DST)  &&
+		(bio_op(bio) == REQ_OP_COPY_SRC));
+}
+
 static inline unsigned int blk_rq_get_max_segments(struct request *rq)
 {
 	if (req_op(rq) == REQ_OP_DISCARD)
@@ -303,6 +310,8 @@ static inline bool bio_may_exceed_limits(struct bio *bio,
 		break;
 	}
 
+	if (unlikely(op_is_copy(bio->bi_opf)))
+		return false;
 	/*
 	 * All drivers must accept single-segments bios that are <= PAGE_SIZE.
 	 * This is a quick and dirty check that relies on the fact that
diff --git a/block/elevator.h b/block/elevator.h
index 7ca3d7b6ed82..eec442bbf384 100644
--- a/block/elevator.h
+++ b/block/elevator.h
@@ -18,6 +18,7 @@ enum elv_merge {
 	ELEVATOR_FRONT_MERGE	= 1,
 	ELEVATOR_BACK_MERGE	= 2,
 	ELEVATOR_DISCARD_MERGE	= 3,
+	ELEVATOR_COPY_OFFLOAD_MERGE	= 4,
 };
 
 struct blk_mq_alloc_data;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..a2673f24e493 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -57,7 +57,9 @@ static inline bool bio_has_data(struct bio *bio)
 	    bio->bi_iter.bi_size &&
 	    bio_op(bio) != REQ_OP_DISCARD &&
 	    bio_op(bio) != REQ_OP_SECURE_ERASE &&
-	    bio_op(bio) != REQ_OP_WRITE_ZEROES)
+	    bio_op(bio) != REQ_OP_WRITE_ZEROES &&
+	    bio_op(bio) != REQ_OP_COPY_DST &&
+	    bio_op(bio) != REQ_OP_COPY_SRC)
 		return true;
 
 	return false;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 0bad62cca3d0..336146798e56 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -394,6 +394,9 @@ enum req_op {
 	/* reset all the zone present on the device */
 	REQ_OP_ZONE_RESET_ALL	= (__force blk_opf_t)17,
 
+	REQ_OP_COPY_SRC		= (__force blk_opf_t)18,
+	REQ_OP_COPY_DST		= (__force blk_opf_t)19,
+
 	/* Driver private requests */
 	REQ_OP_DRV_IN		= (__force blk_opf_t)34,
 	REQ_OP_DRV_OUT		= (__force blk_opf_t)35,
@@ -482,6 +485,12 @@ static inline bool op_is_write(blk_opf_t op)
 	return !!(op & (__force blk_opf_t)1);
 }
 
+static inline bool op_is_copy(blk_opf_t op)
+{
+	return (((op & REQ_OP_MASK) == REQ_OP_COPY_SRC) ||
+		((op & REQ_OP_MASK) == REQ_OP_COPY_DST));
+}
+
 /*
  * Check if the bio or request is one that needs special treatment in the
  * flush state machine.
@@ -541,4 +550,16 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+typedef void (cio_iodone_t)(void *private, int comp_len);
+
+struct cio {
+	struct task_struct *waiter;     /* waiting task (NULL if none) */
+	loff_t pos_in;
+	loff_t pos_out;
+	ssize_t comp_len;
+	cio_iodone_t *endio;		/* applicable for async operation */
+	void *private;			/* applicable for async operation */
+	atomic_t refcount;
+};
+
 #endif /* __LINUX_BLK_TYPES_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6098665953e6..963f5c97dec0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1043,6 +1043,10 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
+ssize_t blkdev_copy_offload(
+		struct block_device *bdev_in, loff_t pos_in,
+		struct block_device *bdev_out, loff_t pos_out,
+		size_t len, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

