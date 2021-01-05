Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1D2EABED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 14:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbhAEN26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 08:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727898AbhAEN26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609853251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AuJdJsTyCFlQnRguqyE12Pcn4kKOYDILhxDjEZQeYnM=;
        b=fRmYpGfqDkxqv/MHb35kxTXaf13bzNKEsf26igXsFvZJ6s0v58aqsokrib0iF/YzLqqGLQ
        9UoQlVcJTmIXklTz86NZG58TuNoKyLRhAjtYTBLe3wQfdOB78ltlWBOTcMIfwfI3frnc4z
        79pMEPF4DvIAvUHiOL4LXfV+qKYKYug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-MsXiY_ljOQi7HEXjF9cZsA-1; Tue, 05 Jan 2021 08:27:28 -0500
X-MC-Unique: MsXiY_ljOQi7HEXjF9cZsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1267EA0CBE;
        Tue,  5 Jan 2021 13:27:27 +0000 (UTC)
Received: from localhost (ovpn-12-37.pek2.redhat.com [10.72.12.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A91D1002382;
        Tue,  5 Jan 2021 13:27:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH] fs: block_dev: compute nr_vecs hint for improving writeback bvecs allocation
Date:   Tue,  5 Jan 2021 21:26:47 +0800
Message-Id: <20210105132647.3818503-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Writeback code always allocates bio with max allowed bvecs(BIO_MAX_PAGES)
since it is hard to know in advance how many pages will be written in
single bio. And BIO_MAX_PAGES bvecs takes one 4K page.

On the other hand, for workloads of random IO, most of writeback bios just
uses <= 4 bvecs; for workloads of sequential IO, attributes to multipage
bvec, quite a lot of pages are contiguous because of space/time locality
for pages in sequential IO workloads, then either nr_bvecs is small enough
or size of bio is very big. So in reality, it is quite often to see most
of writeback bios just uses <=4 bvecs, which can be allocated inline. This
can be observed in normal tests(kernel build, git clone kernel, dbench,
...)

So improve bvec allocation by using Exponential Weighted Moving Average(
EWMA) to compute nr_bvecs hint for writeback bio. With this simple
approach, it is observed[1] that most of writeback bios just need <=4
nr_bvecs in normal workloads, then bvecs can be allocated inline with bio
together, meantime one extra 4k allocation is avoided.

[1] bpftrace script for observing writeback .bi_max_vcnt & .bi_vcnt
histogram
http://people.redhat.com/minlei/tests/tools/wb_vcnt.bt

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: linux-xfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c            |  1 +
 fs/iomap/buffered-io.c    | 13 +++++++++----
 include/linux/bio.h       |  2 --
 include/linux/blk_types.h | 31 +++++++++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 3e5b02f6606c..0490f16a96db 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -880,6 +880,7 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
 #ifdef CONFIG_SYSFS
 	INIT_LIST_HEAD(&bdev->bd_holder_disks);
 #endif
+	bdev->bd_wb_nr_vecs_hint = BIO_MAX_PAGES / 2;
 	bdev->bd_stats = alloc_percpu(struct disk_stats);
 	if (!bdev->bd_stats) {
 		iput(inode);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..1e031af182db 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1210,6 +1210,7 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 		return error;
 	}
 
+	bdev_update_wb_nr_vecs_hint(wpc->iomap.bdev, ioend->io_bio);
 	submit_bio(ioend->io_bio);
 	return 0;
 }
@@ -1221,7 +1222,8 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	struct iomap_ioend *ioend;
 	struct bio *bio;
 
-	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &iomap_ioend_bioset);
+	bio = bio_alloc_bioset(GFP_NOFS, bdev_wb_nr_vecs_hint(wpc->iomap.bdev),
+			&iomap_ioend_bioset);
 	bio_set_dev(bio, wpc->iomap.bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
@@ -1248,11 +1250,13 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
  * traversal in iomap_finish_ioend().
  */
 static struct bio *
-iomap_chain_bio(struct bio *prev)
+iomap_chain_bio(struct bio *prev, struct block_device *bdev)
 {
 	struct bio *new;
 
-	new = bio_alloc(GFP_NOFS, BIO_MAX_PAGES);
+	bdev_update_wb_nr_vecs_hint(bdev, prev);
+
+	new = bio_alloc(GFP_NOFS, bdev_wb_nr_vecs_hint(bdev));
 	bio_copy_dev(new, prev);/* also copies over blkcg information */
 	new->bi_iter.bi_sector = bio_end_sector(prev);
 	new->bi_opf = prev->bi_opf;
@@ -1308,7 +1312,8 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio, len)) {
 			wpc->ioend->io_bio =
-				iomap_chain_bio(wpc->ioend->io_bio);
+				iomap_chain_bio(wpc->ioend->io_bio,
+						wpc->iomap.bdev);
 		}
 		bio_add_page(wpc->ioend->io_bio, page, len, poff);
 	}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 70914dd6a70d..ad0cd1a2abbe 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -19,8 +19,6 @@
 #define BIO_BUG_ON
 #endif
 
-#define BIO_MAX_PAGES		256
-
 #define bio_prio(bio)			(bio)->bi_ioprio
 #define bio_set_prio(bio, prio)		((bio)->bi_ioprio = prio)
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 866f74261b3b..078e212f5e1f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -24,6 +24,7 @@ struct block_device {
 	sector_t		bd_start_sect;
 	struct disk_stats __percpu *bd_stats;
 	unsigned long		bd_stamp;
+	unsigned short		bd_wb_nr_vecs_hint;
 	bool			bd_read_only;	/* read-only policy */
 	dev_t			bd_dev;
 	int			bd_openers;
@@ -307,6 +308,8 @@ enum {
 	BIO_FLAG_LAST
 };
 
+#define BIO_MAX_PAGES		256
+
 /* See BVEC_POOL_OFFSET below before adding new flags */
 
 /*
@@ -565,4 +568,32 @@ struct blk_rq_stat {
 	u64 batch;
 };
 
+/* called before submitting writeback bios */
+static inline void bdev_update_wb_nr_vecs_hint(struct block_device *bdev,
+		struct bio *bio)
+{
+	unsigned short nr_vecs;
+
+	if (!bdev)
+		return;
+
+	nr_vecs = bdev->bd_wb_nr_vecs_hint;
+	/*
+	 * If this bio is full, double current nr_vecs_hint for fast convergence.
+	 * Otherwise use Exponential Weighted Moving Average to figure out the
+	 * hint
+	 */
+	if (bio->bi_vcnt >= bio->bi_max_vecs)
+		nr_vecs *= 2;
+	else
+		nr_vecs = (nr_vecs * 3 + bio->bi_vcnt + 3) / 4;
+
+	bdev->bd_wb_nr_vecs_hint = clamp_val(nr_vecs, 1, BIO_MAX_PAGES);
+}
+
+static inline unsigned short bdev_wb_nr_vecs_hint(struct block_device *bdev)
+{
+	return bdev->bd_wb_nr_vecs_hint;
+}
+
 #endif /* __LINUX_BLK_TYPES_H */
-- 
2.28.0

