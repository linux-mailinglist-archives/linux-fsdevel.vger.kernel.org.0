Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE5D635024
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiKWGNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiKWGN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:27 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F1DF2C24
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:24 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221123061323epoutp02fef706d1697d487ce5aee6939872e7b4~qIgHUeG2F1821418214epoutp02y
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221123061323epoutp02fef706d1697d487ce5aee6939872e7b4~qIgHUeG2F1821418214epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184003;
        bh=0FPx7LMsKlfQgDSh7pdXmYYh7T24JtpfZN1TEoPvn7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KONw9b5EggwVSQtG5RFa6eT8a1ZFy448ET40VG/kpDwM7LcAf8w0+ElvunNOG1dCP
         BvrMQyx4fUKghzZhteCiM02uKWqK2IlKyNat4MqVPBjXtjRaO+oU1z1qFaGBmxxTCW
         Uo+J72qMUBkpJApZOUlRD9pVRywhgX8rfzJyb6Wk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221123061322epcas5p4a63e3bc9742748460f0cbdd214de1c25~qIgGnUrYd1580315803epcas5p40;
        Wed, 23 Nov 2022 06:13:22 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NH9mJ3lqvz4x9Pv; Wed, 23 Nov
        2022 06:13:20 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.17.56352.00ABD736; Wed, 23 Nov 2022 15:13:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221123061021epcas5p276b6d48db889932282d017b27c9a3291~qIdd7WvBX1320613206epcas5p23;
        Wed, 23 Nov 2022 06:10:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123061021epsmtrp2aa0cf5e084413f713e1638c588adf37a~qIdd6Dns30451404514epsmtrp2L;
        Wed, 23 Nov 2022 06:10:21 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-ce-637dba00b25d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.B2.18644.D49BD736; Wed, 23 Nov 2022 15:10:21 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061017epsmtip1f6dbbd226075454fb5dd076fb3daff6e~qIdaiGQur2539625396epsmtip1Y;
        Wed, 23 Nov 2022 06:10:17 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>
Subject: [PATCH v5 03/10] block: add emulation for copy
Date:   Wed, 23 Nov 2022 11:28:20 +0530
Message-Id: <20221123055827.26996-4-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2XDhtdXXHyuJnFewKLgOEtqOUD4Rp0G1nYQvoMhPdCCvljFtp
        S0+RSUQuyrgo1wiMSgTGYAOnbEUYUkGsQxDGUBioLI6rxm2hOFiGBglrObD573me932f9/Ll
        42KCAo6QG6Mx0HqNUi0m1uMtN9zcPNe1paikZfeEsLH3JgYzCpcweOFBAQEX+wcw2G495wDv
        d15BYf2FLhSaq/9CYdfyDAEn/h7FYbFlBIEPh40obB/1gFfbb+FwqK2CgJV1DzmwqLvJAbZO
        pyOwZbESg/O1pzjw0p+zOOwZ3QanTmcjcGCp22EvoIxj/QR1xfiAQw389j1ODfUnUqaGHIJq
        +iqVMt9PI6i8k1ZbQuaYAzXbMUxQ+ZcbEGre5ExldZ5GKdP0DBq68UhcQDStjKT1Ilqj0kbG
        aKICxcEfhO8L91FIZZ4yP+grFmmU8XSgeP97oZ5vx6htRxCLjirViTYpVMkwYsmbAXptooEW
        RWsZQ6CY1kWqdXKdF6OMZxI1UV4a2uAvk0rf8LElfhIX/XmRQFcd8lnJzG1OGjKwNxfhcQEp
        B2f7vubkIuu5AtKMgOvPTQhL5hBQaP6ZYMk8AqrPXOSslRRbrTgbaEPA0sWnqyQTBem5kzbC
        5RKkB+hb5tp1RzIfBdnmTsxOMLITBZkdGajdajPpC5qGWIyTO8HNwYGVFnzSHyzm5q0YAVIC
        CsY22WUeuRv8dKcNZVM2gVvl07gdY+QOcLL53Io/IGt44LY5D2NH3Q+651pwFm8Gf3RfXl1B
        COat7QSLk0D92W8ItvgUAox3jQgb2AMyewsw+xAY6QYa2ySs7ARKei+hbOONIG9xGmV1Pmg9
        v4ZdwLeNVav+W8HIQvoqpkDLnX9Wr52PgF8XatFCRGR8YSHjCwsZ/29dhWANyFZax8RH0YyP
        zltDJ/33zCptvAlZ+Rnuwa3I5PgTLwuCchELAriY2JGf+u5xlYAfqTyWTOu14fpENc1YEB/b
        wYsw4Ssqre1raQzhMrmfVK5QKOR+3gqZeAu/5gt3lYCMUhroOJrW0fq1OpTLE6ah5TOFRxoP
        W2t+OJFyQuYcVJKiIF93TKgc8z0UFpL1zOBZaymY89++cHD5w6SOfROzVwdfzZkqDa6TwLwz
        PDfXsVKq7DH/qTIWBJVr33rM1Jl+L/Ze15zcccB1d0ME1rCTEJX2uE7uepScUlbhcv67d8aF
        WE/l4efcTueQsCfbgybcmT6e9H0nAdkaOv7lMVpYESj5aEvqwbj8rLk9vrruNo+M4ohnoqOu
        yRtSnXpjhzf4p3nclR+QBrhjN1pimeWYqbJa/tK1mtckrSnqqtiPuV01qdnKhE9xcX1ImGXw
        kJV+9HKGy44k4cLIruYfdeqcyo6E4/citr1kuo5fw6N+cfAU40y0UuaO6Rnlv1+4NM6iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsWy7bCSnK7vztpkgztn2SzWnzrGbNE04S+z
        xeq7/WwWv8+eZ7bY+242q8XNAzuZLFauPspksXvhRyaLo//fslk8/HKLxWLSoWuMFk+vzmKy
        2HtL22LP3pMsFpd3zWGzmL/sKbvFxOObWS12PGlktNj2ez6zxeelLewW616/Z7E4cUva4nF3
        B6PF+b/HWR0kPGbdP8vmsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB59Da/Aypovc/q
        8X7fVTaPvi2rGD0+b5LzaD/QzeSx6clbpgC+KC6blNSczLLUIn27BK6MtolCBQv9K6a+vcDe
        wHjeoYuRk0NCwERi0rt3LCC2kMAORom1//Ih4pISy/4eYYawhSVW/nvO3sXIBVTTzCRx+fh8
        oAYODjYBbYnT/zlA4iICC4Di914xgzjMAmeYJBoufWAC6RYWMJfYfLkJzGYRUJU4duk8O4jN
        K2Al8burF2yQhIC+RP99QZAwp4C1xJmLu5hAwkJAJXuW6UBUC0qcnPkE7E5mAXmJ5q2zmScw
        CsxCkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwNGtp7WDcs+qD3iFG
        Jg7GQ4wSHMxKIrz1njXJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgt
        gskycXBKNTCd9ZScvPPbYdWgDyIHbj9fp3iHjUm4/YBmbkRgXFL+NfspWideNgef6eq75rXO
        g3dL/4NzC78b735drP33pGJD/KW7K40O7jCuCuNbfXKS66Hpz8p+fQ6RF4y+MunvxcCWB1OP
        BrrKZF2TSppzrELMMUTW0WO6w4GibSY/y0+VfOSuX/M3Z7H0rCufQwSENerK3blag+3lUtyu
        2B3eIq7Lu5jzEceiyc0fXuRf8C2SlPtx5sTKVMVJVu/vs0y/fmyD2blFh9nnOr9e+mPL0u0z
        u9yN9kb17lweVnxhHa/0TYtT6yWKE8yq2VYEPJUO/nKv3Vsx4qmM49o/LOzGfD0cZ1yFp/gc
        3Bi4J65Xw1FSiaU4I9FQi7moOBEAx7T9r1UDAAA=
X-CMS-MailID: 20221123061021epcas5p276b6d48db889932282d017b27c9a3291
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061021epcas5p276b6d48db889932282d017b27c9a3291
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061021epcas5p276b6d48db889932282d017b27c9a3291@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For the devices which does not support copy, copy emulation is
added. Copy-emulation is implemented by reading from source ranges
into memory and writing to the corresponding destination asynchronously.
For zoned device we maintain a linked list of read submission and try to
submit corresponding write in same order.
Also emulation is used, if copy offload fails or partially completes.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-lib.c        | 241 ++++++++++++++++++++++++++++++++++++++++-
 block/blk-map.c        |   4 +-
 include/linux/blkdev.h |   3 +
 3 files changed, 245 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 2ce3c872ca49..43b1d0ef5732 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -428,6 +428,239 @@ static inline int blk_copy_sanity_check(struct block_device *src_bdev,
 	return 0;
 }
 
+static void *blk_alloc_buf(sector_t req_size, sector_t *alloc_size,
+		gfp_t gfp_mask)
+{
+	int min_size = PAGE_SIZE;
+	void *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp_mask);
+		if (buf) {
+			*alloc_size = req_size;
+			return buf;
+		}
+		/* retry half the requested size */
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
+static void blk_copy_emulate_write_end_io(struct bio *bio)
+{
+	struct copy_ctx *ctx = bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+
+	if (bio->bi_status) {
+		cio->io_err = blk_status_to_errno(bio->bi_status);
+		clen = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+			cio->ranges[ri].dst;
+		cio->ranges[ri].comp_len = min_t(sector_t, clen,
+				cio->ranges[ri].comp_len);
+	}
+	kvfree(page_address(bio->bi_io_vec[0].bv_page));
+	bio_map_kern_endio(bio);
+	if (atomic_dec_and_test(&ctx->refcount))
+		kfree(ctx);
+	if (atomic_dec_and_test(&cio->refcount)) {
+		if (cio->endio) {
+			cio->endio(cio->private, cio->io_err);
+			kfree(cio);
+		} else
+			blk_wake_io_task(cio->waiter);
+	}
+}
+
+static void blk_copy_emulate_read_end_io(struct bio *read_bio)
+{
+	struct copy_ctx *ctx = read_bio->bi_private;
+	struct cio *cio = ctx->cio;
+	sector_t clen;
+	int ri = ctx->range_idx;
+	unsigned long flags;
+
+	if (read_bio->bi_status) {
+		cio->io_err = blk_status_to_errno(read_bio->bi_status);
+		goto err_rw_bio;
+	}
+
+	/* For zoned device, we check if completed bio is first entry in linked
+	 * list,
+	 * if yes, we start the worker to submit write bios.
+	 * if not, then we just update status of bio in ctx,
+	 * once the worker gets scheduled, it will submit writes for all
+	 * the consecutive REQ_COPY_READ_COMPLETE bios.
+	 */
+	if (bdev_is_zoned(ctx->write_bio->bi_bdev)) {
+		spin_lock_irqsave(&cio->list_lock, flags);
+		ctx->status = REQ_COPY_READ_COMPLETE;
+		if (ctx == list_first_entry(&cio->list,
+					struct copy_ctx, list)) {
+			spin_unlock_irqrestore(&cio->list_lock, flags);
+			schedule_work(&ctx->dispatch_work);
+			goto free_read_bio;
+		}
+		spin_unlock_irqrestore(&cio->list_lock, flags);
+	} else
+		schedule_work(&ctx->dispatch_work);
+
+free_read_bio:
+	kfree(read_bio);
+
+	return;
+
+err_rw_bio:
+	clen = (read_bio->bi_iter.bi_sector << SECTOR_SHIFT) -
+					cio->ranges[ri].src;
+	cio->ranges[ri].comp_len = min_t(sector_t, clen,
+					cio->ranges[ri].comp_len);
+	__free_page(read_bio->bi_io_vec[0].bv_page);
+	bio_map_kern_endio(read_bio);
+	if (atomic_dec_and_test(&ctx->refcount))
+		kfree(ctx);
+	if (atomic_dec_and_test(&cio->refcount)) {
+		if (cio->endio) {
+			cio->endio(cio->private, cio->io_err);
+			kfree(cio);
+		} else
+			blk_wake_io_task(cio->waiter);
+	}
+}
+
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ */
+static int blk_copy_emulate(struct block_device *src_bdev,
+		struct block_device *dst_bdev, struct range_entry *ranges,
+		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask)
+{
+	struct request_queue *sq = bdev_get_queue(src_bdev);
+	struct request_queue *dq = bdev_get_queue(dst_bdev);
+	struct bio *read_bio, *write_bio;
+	void *buf = NULL;
+	struct copy_ctx *ctx;
+	struct cio *cio;
+	sector_t src, dst, offset, buf_len, req_len, rem = 0;
+	int ri = 0, ret = 0;
+	unsigned long flags;
+	sector_t max_src_hw_len = min_t(unsigned int, queue_max_hw_sectors(sq),
+			queue_max_segments(sq) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_dst_hw_len = min_t(unsigned int, queue_max_hw_sectors(dq),
+			queue_max_segments(dq) << (PAGE_SHIFT - SECTOR_SHIFT))
+			<< SECTOR_SHIFT;
+	sector_t max_hw_len = min_t(unsigned int,
+			max_src_hw_len, max_dst_hw_len);
+
+	cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
+	if (!cio)
+		return -ENOMEM;
+	cio->ranges = ranges;
+	atomic_set(&cio->refcount, 1);
+	cio->waiter = current;
+	cio->endio = end_io;
+	cio->private = private;
+
+	if (bdev_is_zoned(dst_bdev)) {
+		INIT_LIST_HEAD(&cio->list);
+		spin_lock_init(&cio->list_lock);
+	}
+
+	for (ri = 0; ri < nr; ri++) {
+		offset = ranges[ri].comp_len;
+		src = ranges[ri].src + offset;
+		dst = ranges[ri].dst + offset;
+		/* If IO fails, we truncate comp_len */
+		ranges[ri].comp_len = ranges[ri].len;
+
+		for (rem = ranges[ri].len - offset; rem > 0; rem -= buf_len) {
+			req_len = min_t(int, max_hw_len, rem);
+
+			buf = blk_alloc_buf(req_len, &buf_len, gfp_mask);
+			if (!buf) {
+				ret = -ENOMEM;
+				goto err_alloc_buf;
+			}
+
+			ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
+			if (!ctx) {
+				ret = -ENOMEM;
+				goto err_ctx;
+			}
+
+			read_bio = bio_map_kern(sq, buf, buf_len, gfp_mask);
+			if (IS_ERR(read_bio)) {
+				ret = PTR_ERR(read_bio);
+				goto err_read_bio;
+			}
+
+			write_bio = bio_map_kern(dq, buf, buf_len, gfp_mask);
+			if (IS_ERR(write_bio)) {
+				ret = PTR_ERR(write_bio);
+				goto err_write_bio;
+			}
+
+			ctx->cio = cio;
+			ctx->range_idx = ri;
+			ctx->write_bio = write_bio;
+			atomic_set(&ctx->refcount, 1);
+
+			read_bio->bi_iter.bi_sector = src >> SECTOR_SHIFT;
+			read_bio->bi_iter.bi_size = buf_len;
+			read_bio->bi_opf = REQ_OP_READ | REQ_SYNC;
+			bio_set_dev(read_bio, src_bdev);
+			read_bio->bi_end_io = blk_copy_emulate_read_end_io;
+			read_bio->bi_private = ctx;
+
+			write_bio->bi_iter.bi_size = buf_len;
+			write_bio->bi_opf = REQ_OP_WRITE | REQ_SYNC;
+			bio_set_dev(write_bio, dst_bdev);
+			write_bio->bi_end_io = blk_copy_emulate_write_end_io;
+			write_bio->bi_iter.bi_sector = dst >> SECTOR_SHIFT;
+			write_bio->bi_private = ctx;
+
+			if (bdev_is_zoned(dst_bdev)) {
+				INIT_WORK(&ctx->dispatch_work,
+					blk_zoned_copy_dispatch_work_fn);
+				INIT_LIST_HEAD(&ctx->list);
+				spin_lock_irqsave(&cio->list_lock, flags);
+				ctx->status = REQ_COPY_READ_PROGRESS;
+				list_add_tail(&ctx->list, &cio->list);
+				spin_unlock_irqrestore(&cio->list_lock, flags);
+			} else
+				INIT_WORK(&ctx->dispatch_work,
+					blk_copy_dispatch_work_fn);
+
+			atomic_inc(&cio->refcount);
+			submit_bio(read_bio);
+
+			src += buf_len;
+			dst += buf_len;
+		}
+	}
+
+	/* Wait for completion of all IO's*/
+	return cio_await_completion(cio);
+
+err_write_bio:
+	bio_put(read_bio);
+err_read_bio:
+	kfree(ctx);
+err_ctx:
+	kvfree(buf);
+err_alloc_buf:
+	ranges[ri].comp_len -= min_t(sector_t,
+			ranges[ri].comp_len, (ranges[ri].len - rem));
+
+	cio->io_err = ret;
+	return cio_await_completion(cio);
+}
+
 static inline bool blk_check_copy_offload(struct request_queue *src_q,
 		struct request_queue *dst_q)
 {
@@ -460,15 +693,21 @@ int blkdev_issue_copy(struct block_device *src_bdev,
 	struct request_queue *src_q = bdev_get_queue(src_bdev);
 	struct request_queue *dst_q = bdev_get_queue(dst_bdev);
 	int ret = -EINVAL;
+	bool offload = false;
 
 	ret = blk_copy_sanity_check(src_bdev, dst_bdev, ranges, nr);
 	if (ret)
 		return ret;
 
-	if (blk_check_copy_offload(src_q, dst_q))
+	offload = blk_check_copy_offload(src_q, dst_q);
+	if (offload)
 		ret = blk_copy_offload(src_bdev, dst_bdev, ranges, nr,
 				end_io, private, gfp_mask);
 
+	if (ret || !offload)
+		ret = blk_copy_emulate(src_bdev, dst_bdev, ranges, nr,
+				end_io, private, gfp_mask);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_issue_copy);
diff --git a/block/blk-map.c b/block/blk-map.c
index 19940c978c73..bcf8db2b75f1 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -363,7 +363,7 @@ static void bio_invalidate_vmalloc_pages(struct bio *bio)
 #endif
 }
 
-static void bio_map_kern_endio(struct bio *bio)
+void bio_map_kern_endio(struct bio *bio)
 {
 	bio_invalidate_vmalloc_pages(bio);
 	bio_uninit(bio);
@@ -380,7 +380,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
+struct bio *bio_map_kern(struct request_queue *q, void *data,
 		unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a3b12ad42ed7..b0b18c30a60b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1068,6 +1068,9 @@ int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector,
 int blkdev_issue_copy(struct block_device *src_bdev,
 		struct block_device *dst_bdev, struct range_entry *ranges,
 		int nr, cio_iodone_t end_io, void *private, gfp_t gfp_mask);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+		gfp_t gfp_mask);
+void bio_map_kern_endio(struct bio *bio);
 
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes */
-- 
2.35.1.500.gb896f729e2

