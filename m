Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E65DCA4BA5
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2019 22:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfIAUJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Sep 2019 16:09:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:50658 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729051AbfIAUJN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:09:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2367DB65F;
        Sun,  1 Sep 2019 20:09:12 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, darrick.wong@oracle.com, hch@lst.de,
        david@fromorbit.com, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 12/15] iomap: use a function pointer for dio submits
Date:   Sun,  1 Sep 2019 15:08:33 -0500
Message-Id: <20190901200836.14959-13-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190901200836.14959-1-rgoldwyn@suse.de>
References: <20190901200836.14959-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This helps filesystems to perform tasks on the bio while
submitting for I/O. Since btrfs requires the position
we are working on, pass pos to iomap_dio_submit_bio()

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c  | 16 +++++++++++-----
 include/linux/iomap.h |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5279029c7a3c..00b8af35cf97 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
 static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio)
+		struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
@@ -67,7 +67,13 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		bio_set_polled(bio, dio->iocb);
 
 	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-	dio->submit.cookie = submit_bio(bio);
+	if (iomap->submit_io) {
+		iomap->submit_io(bio, file_inode(dio->iocb->ki_filp),
+				pos);
+		dio->submit.cookie = BLK_QC_T_NONE;
+	} else {
+		dio->submit.cookie = submit_bio(bio);
+	}
 }
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -195,7 +201,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio);
+	iomap_dio_submit_bio(dio, iomap, bio, pos);
 }
 
 static loff_t
@@ -301,11 +307,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		iov_iter_advance(dio->submit.iter, n);
 
 		dio->size += n;
-		pos += n;
 		copied += n;
 
 		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
-		iomap_dio_submit_bio(dio, iomap, bio);
+		iomap_dio_submit_bio(dio, iomap, bio, pos);
+		pos += n;
 	} while (nr_pages);
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9c082d36286a..465d736d74ac 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -80,6 +80,7 @@ struct iomap {
 	void			*inline_data;
 	void			*private; /* filesystem private */
 	const struct iomap_page_ops *page_ops;
+	dio_submit_t 		*submit_io;
 };
 
 static inline sector_t
-- 
2.16.4

