Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4127FD6504
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2019 16:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732680AbfJNOVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Oct 2019 10:21:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732262AbfJNOVt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Oct 2019 10:21:49 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F7B2A6780DE5798AD35;
        Mon, 14 Oct 2019 22:21:42 +0800 (CST)
Received: from localhost.localdomain (10.175.124.28) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 14 Oct 2019 22:21:36 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <hch@infradead.org>, <linux-xfs@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <yangerkun@huawei.com>, <yi.zhang@huawei.com>, <houtao1@huawei.com>
Subject: [PATCH] iomap: fix the logic about poll io in iomap_dio_bio_actor
Date:   Mon, 14 Oct 2019 22:43:13 +0800
Message-ID: <20191014144313.26313-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just set REQ_HIPRI for the last bio in iomap_dio_bio_actor. Because
multi bio created by this function can goto different cpu since this
process can be preempted by other process. And in iomap_dio_rw we will
just poll for the last bio. Fix it by only set polled for the last bio.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/iomap/direct-io.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 1fc28c2da279..05dee6e7ca64 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -59,15 +59,16 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
 static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio)
+		struct bio *bio, bool is_poll)
 {
 	atomic_inc(&dio->ref);
 
-	if (dio->iocb->ki_flags & IOCB_HIPRI)
+	if (is_poll) {
 		bio_set_polled(bio, dio->iocb);
-
-	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-	dio->submit.cookie = submit_bio(bio);
+		dio->submit.last_queue = bdev_get_queue(iomap->bdev);
+		dio->submit.cookie = submit_bio(bio);
+	} else
+		submit_bio(bio);
 }
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -191,7 +192,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio);
+	iomap_dio_submit_bio(dio, iomap, bio, false);
 }
 
 static loff_t
@@ -255,6 +256,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 
 	do {
 		size_t n;
+		bool is_poll = false;
+
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
 			return 0;
@@ -301,7 +304,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied += n;
 
 		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-		iomap_dio_submit_bio(dio, iomap, bio);
+
+		/* Only set poll for the last bio. */
+		if (!nr_pages && dio->iocb->ki_flags & IOCB_HIPRI)
+			is_poll = true;
+
+		iomap_dio_submit_bio(dio, iomap, bio, is_poll);
 	} while (nr_pages);
 
 	/*
-- 
2.17.2

