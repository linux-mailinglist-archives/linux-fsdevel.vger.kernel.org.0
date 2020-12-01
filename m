Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BC22CA21F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Dec 2020 13:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgLAMIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 07:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbgLAMIg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606824429;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QkVg2ocyF2lpwIR6qYQdLIliBFfnMIMoP/JN6wJH1Vs=;
        b=DSbGLu8gnb7JOb1Gs1VQL0nCmYFX4bApZWnFyi49GOHp0xZ/a404Yc0/1fXidK9QhPOPcH
        RpBURJu4Wx5IwFqjmivDU3ngwuKlEID8sVgWRxLtQpsWNmjewSrOTe91yj1UgtJ/5JDx+c
        vDhAhWdeBMEwY8/nl9EEciZqfdrnSd0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-Ury-PwEvNf6LQATlDO-uvQ-1; Tue, 01 Dec 2020 07:07:07 -0500
X-MC-Unique: Ury-PwEvNf6LQATlDO-uvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2AF21005E45;
        Tue,  1 Dec 2020 12:07:05 +0000 (UTC)
Received: from localhost (ovpn-12-90.pek2.redhat.com [10.72.12.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B0175C1B4;
        Tue,  1 Dec 2020 12:06:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] block: add bio_iov_iter_nvecs for figuring out nr_vecs
Date:   Tue,  1 Dec 2020 20:06:52 +0800
Message-Id: <20201201120652.487077-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pavel reported that iov_iter_npages is a bit heavy in case of bvec
iter.

Turns out it isn't necessary to iterate every page in the bvec iter,
and we call iov_iter_npages() just for figuring out how many bio
vecs need to be allocated. And we can simply map each vector in bvec iter
to bio's vec, so just return iter->nr_segs from bio_iov_iter_nvecs() for
bvec iter.

Also rename local variable 'nr_pages' as 'nr_vecs' which exactly matches its
real usage.

This patch is based on Mathew's post:

https://lore.kernel.org/linux-block/20201120123931.GN29991@casper.infradead.org/

Cc: Matthew Wilcox <willy@infradead.org>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c       | 30 +++++++++++++++---------------
 fs/iomap/direct-io.c | 14 +++++++-------
 include/linux/bio.h  | 10 ++++++++++
 3 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index d8664f5c1ff6..4fd9bb4306db 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -218,7 +218,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 
 static ssize_t
 __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
-		int nr_pages)
+		int nr_vecs)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
@@ -233,16 +233,16 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	if (nr_pages <= DIO_INLINE_BIO_VECS)
+	if (nr_vecs <= DIO_INLINE_BIO_VECS)
 		vecs = inline_vecs;
 	else {
-		vecs = kmalloc_array(nr_pages, sizeof(struct bio_vec),
+		vecs = kmalloc_array(nr_vecs, sizeof(struct bio_vec),
 				     GFP_KERNEL);
 		if (!vecs)
 			return -ENOMEM;
 	}
 
-	bio_init(&bio, vecs, nr_pages);
+	bio_init(&bio, vecs, nr_vecs);
 	bio_set_dev(&bio, bdev);
 	bio.bi_iter.bi_sector = pos >> 9;
 	bio.bi_write_hint = iocb->ki_hint;
@@ -353,7 +353,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
 
 static ssize_t
-__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
+__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_vecs)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
@@ -371,7 +371,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_bioset(GFP_KERNEL, nr_vecs, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -420,8 +420,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
-		if (!nr_pages) {
+		nr_vecs = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES);
+		if (!nr_vecs) {
 			bool polled = false;
 
 			if (iocb->ki_flags & IOCB_HIPRI) {
@@ -451,7 +451,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio = bio_alloc(GFP_KERNEL, nr_vecs);
 	}
 
 	if (!is_poll)
@@ -483,15 +483,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 static ssize_t
 blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
-	int nr_pages;
+	int nr_vecs;
 
-	nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES + 1);
-	if (!nr_pages)
+	nr_vecs = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES + 1);
+	if (!nr_vecs)
 		return 0;
-	if (is_sync_kiocb(iocb) && nr_pages <= BIO_MAX_PAGES)
-		return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
+	if (is_sync_kiocb(iocb) && nr_vecs <= BIO_MAX_PAGES)
+		return __blkdev_direct_IO_simple(iocb, iter, nr_vecs);
 
-	return __blkdev_direct_IO(iocb, iter, min(nr_pages, BIO_MAX_PAGES));
+	return __blkdev_direct_IO(iocb, iter, min(nr_vecs, BIO_MAX_PAGES));
 }
 
 static __init int blkdev_init(void)
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 933f234d5bec..cc779ecc8144 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -211,7 +211,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	struct bio *bio;
 	bool need_zeroout = false;
 	bool use_fua = false;
-	int nr_pages, ret = 0;
+	int nr_vecs, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
 
@@ -250,9 +250,9 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 	orig_count = iov_iter_count(dio->submit.iter);
 	iov_iter_truncate(dio->submit.iter, length);
 
-	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
-	if (nr_pages <= 0) {
-		ret = nr_pages;
+	nr_vecs = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
+	if (nr_vecs <= 0) {
+		ret = nr_vecs;
 		goto out;
 	}
 
@@ -271,7 +271,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			goto out;
 		}
 
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio = bio_alloc(GFP_KERNEL, nr_vecs);
 		bio_set_dev(bio, iomap->bdev);
 		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
 		bio->bi_write_hint = dio->iocb->ki_hint;
@@ -308,10 +308,10 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		dio->size += n;
 		copied += n;
 
-		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
+		nr_vecs = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
-	} while (nr_pages);
+	} while (nr_vecs);
 
 	/*
 	 * We need to zeroout the tail of a sub-block write if the extent type
diff --git a/include/linux/bio.h b/include/linux/bio.h
index ecf67108f091..b985857ce9d1 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -10,6 +10,7 @@
 #include <linux/ioprio.h>
 /* struct bio, bio_vec and BIO_* flags are defined in blk_types.h */
 #include <linux/blk_types.h>
+#include <linux/uio.h>
 
 #define BIO_DEBUG
 
@@ -807,4 +808,13 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
+static inline int bio_iov_iter_nvecs(const struct iov_iter *i, int maxvecs)
+{
+	if (!iov_iter_count(i))
+		return 0;
+	if (iov_iter_is_bvec(i))
+               return min_t(int, maxvecs, i->nr_segs);
+	return iov_iter_npages(i, maxvecs);
+}
+
 #endif /* __LINUX_BIO_H */
-- 
2.28.0

