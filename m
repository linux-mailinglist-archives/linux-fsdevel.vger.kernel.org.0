Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C61D211EB5A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 20:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfLMT6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 14:58:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:58960 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728930AbfLMT6B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:58:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE5C2B21F;
        Fri, 13 Dec 2019 19:57:59 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com, fdmanana@kernel.org,
        nborisov@suse.com, dsterba@suse.cz, jthumshirn@suse.de,
        linux-fsdevel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 2/8] iomap: add a filesystem hook for direct I/O bio submission
Date:   Fri, 13 Dec 2019 13:57:44 -0600
Message-Id: <20191213195750.32184-3-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191213195750.32184-1-rgoldwyn@suse.de>
References: <20191213195750.32184-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This helps filesystems to perform tasks on the bio while submitting for
I/O. This could be post-write operations such as data CRC or data
replication for fs-handled RAID.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c  | 14 +++++++++-----
 include/linux/iomap.h |  2 ++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..1a3bf3bd86fb 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -59,7 +59,7 @@ int iomap_dio_iopoll(struct kiocb *kiocb, bool spin)
 EXPORT_SYMBOL_GPL(iomap_dio_iopoll);
 
 static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
-		struct bio *bio)
+		struct bio *bio, loff_t pos)
 {
 	atomic_inc(&dio->ref);
 
@@ -67,7 +67,11 @@ static void iomap_dio_submit_bio(struct iomap_dio *dio, struct iomap *iomap,
 		bio_set_polled(bio, dio->iocb);
 
 	dio->submit.last_queue = bdev_get_queue(iomap->bdev);
-	dio->submit.cookie = submit_bio(bio);
+	if (dio->dops && dio->dops->submit_io)
+		dio->submit.cookie = dio->dops->submit_io(bio,
+				dio->iocb->ki_filp, pos);
+	else
+		dio->submit.cookie = submit_bio(bio);
 }
 
 static ssize_t iomap_dio_complete(struct iomap_dio *dio)
@@ -191,7 +195,7 @@ iomap_dio_zero(struct iomap_dio *dio, struct iomap *iomap, loff_t pos,
 	get_page(page);
 	__bio_add_page(bio, page, len, 0);
 	bio_set_op_attrs(bio, REQ_OP_WRITE, flags);
-	iomap_dio_submit_bio(dio, iomap, bio);
+	iomap_dio_submit_bio(dio, iomap, bio, pos);
 }
 
 static loff_t
@@ -299,11 +303,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		}
 
 		dio->size += n;
-		pos += n;
 		copied += n;
 
 		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
-		iomap_dio_submit_bio(dio, iomap, bio);
+		iomap_dio_submit_bio(dio, iomap, bio, pos);
+		pos += n;
 	} while (nr_pages);
 
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 8b09463dae0d..2b093a23ef1c 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -252,6 +252,8 @@ int iomap_writepages(struct address_space *mapping,
 struct iomap_dio_ops {
 	int (*end_io)(struct kiocb *iocb, ssize_t size, int error,
 		      unsigned flags);
+	blk_qc_t (*submit_io)(struct bio *bio, struct file *file,
+			  loff_t file_offset);
 };
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.16.4

