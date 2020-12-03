Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA832CCCAF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 03:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgLCCbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 21:31:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727102AbgLCCbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 21:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606962608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=diMj16ahBGwEq8pYSOBxqO/Ej1QXLVqYLZQqL2xljj8=;
        b=ZVL7Juk0QeUgWds6z83GHCXM1teNiLnrs/zh2GEHqIoKXQx38G6g1XfEn+2E8LUXLAhHKH
        amZWjyKdOlrzjS/9cITMZfo0XESLFtMHdJfm2WLqbSgt4UsbL3BmoWta6fnz3d28wkflKP
        OF1BzYlw2A9+dK+NFRMZ1WZ8bl//vFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-Ug3Mt5beOIKmILLh1VTHYw-1; Wed, 02 Dec 2020 21:30:04 -0500
X-MC-Unique: Ug3Mt5beOIKmILLh1VTHYw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64B8C185E493;
        Thu,  3 Dec 2020 02:30:03 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD36C5D6AC;
        Thu,  3 Dec 2020 02:30:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH V2 2/2] block: rename the local variable for holding return value of bio_iov_iter_nvecs
Date:   Thu,  3 Dec 2020 10:29:40 +0800
Message-Id: <20201203022940.616610-3-ming.lei@redhat.com>
In-Reply-To: <20201203022940.616610-1-ming.lei@redhat.com>
References: <20201203022940.616610-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the local variable for holding return value of bio_iov_iter_nvecs is
'nr_pages', which is a bit misleading, and the actual meaning is number
of bio vectors, and it is also used for this way.

So rename the local variable, and no function change.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/block_dev.c       | 30 +++++++++++++++---------------
 fs/iomap/direct-io.c | 14 +++++++-------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index fbcc900229af..d699f3af1a09 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -215,7 +215,7 @@ static void blkdev_bio_end_io_simple(struct bio *bio)
 
 static ssize_t
 __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
-		int nr_pages)
+		int nr_vecs)
 {
 	struct file *file = iocb->ki_filp;
 	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
@@ -230,16 +230,16 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
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
@@ -350,7 +350,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 }
 
 static ssize_t
-__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
+__blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_vecs)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = bdev_file_inode(file);
@@ -368,7 +368,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 	    (bdev_logical_block_size(bdev) - 1))
 		return -EINVAL;
 
-	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio = bio_alloc_bioset(GFP_KERNEL, nr_vecs, &blkdev_dio_pool);
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -417,8 +417,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		dio->size += bio->bi_iter.bi_size;
 		pos += bio->bi_iter.bi_size;
 
-		nr_pages = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES);
-		if (!nr_pages) {
+		nr_vecs = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES);
+		if (!nr_vecs) {
 			bool polled = false;
 
 			if (iocb->ki_flags & IOCB_HIPRI) {
@@ -448,7 +448,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio = bio_alloc(GFP_KERNEL, nr_vecs);
 	}
 
 	if (!is_poll)
@@ -480,15 +480,15 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 static ssize_t
 blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 {
-	int nr_pages;
+	int nr_vecs;
 
-	nr_pages = bio_iov_iter_nvecs(iter, BIO_MAX_PAGES + 1);
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
index 0635469e811a..cc779ecc8144 100644
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
 
-	nr_pages = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
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
 
-		nr_pages = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
+		nr_vecs = bio_iov_iter_nvecs(dio->submit.iter, BIO_MAX_PAGES);
 		iomap_dio_submit_bio(dio, iomap, bio, pos);
 		pos += n;
-	} while (nr_pages);
+	} while (nr_vecs);
 
 	/*
 	 * We need to zeroout the tail of a sub-block write if the extent type
-- 
2.28.0

