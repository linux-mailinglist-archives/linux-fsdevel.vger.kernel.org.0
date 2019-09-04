Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 524A6A7868
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfIDCKc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727891AbfIDCKb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:31 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8E6641D8DF0B184D0233;
        Wed,  4 Sep 2019 10:10:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:21 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 15/25] erofs: localize erofs_grab_bio()
Date:   Wed, 4 Sep 2019 10:09:02 +0800
Message-ID: <20190904020912.63925-16-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph pointed out [1], "erofs_grab_bio tries to
handle a bio_alloc failure, except that the function will
not actually fail due the mempool backing it."

Sorry about useless code, fix it now and
localize erofs_grab_bio [2].

[1] https://lore.kernel.org/r/20190830162812.GA10694@infradead.org/
[2] https://lore.kernel.org/r/20190902122016.GL15931@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/data.c     | 28 +++++++++++++++-------------
 fs/erofs/internal.h | 29 -----------------------------
 fs/erofs/zdata.c    | 10 +++++++---
 3 files changed, 22 insertions(+), 45 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index be11b5ea9d2e..0136ea117934 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -38,6 +38,19 @@ static inline void read_endio(struct bio *bio)
 	bio_put(bio);
 }
 
+static struct bio *erofs_grab_raw_bio(struct super_block *sb,
+				      erofs_blk_t blkaddr,
+				      unsigned int nr_pages)
+{
+	struct bio *bio = bio_alloc(GFP_NOIO, nr_pages);
+
+	bio->bi_end_io = read_endio;
+	bio_set_dev(bio, sb->s_bdev);
+	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
+	bio->bi_private = sb;
+	return bio;
+}
+
 /* prio -- true is used for dir */
 struct page *__erofs_get_meta_page(struct super_block *sb,
 				   erofs_blk_t blkaddr, bool prio, bool nofail)
@@ -62,12 +75,7 @@ struct page *__erofs_get_meta_page(struct super_block *sb,
 	if (!PageUptodate(page)) {
 		struct bio *bio;
 
-		bio = erofs_grab_bio(sb, blkaddr, 1, sb, read_endio, nofail);
-		if (IS_ERR(bio)) {
-			DBG_BUGON(nofail);
-			err = PTR_ERR(bio);
-			goto err_out;
-		}
+		bio = erofs_grab_raw_bio(sb, blkaddr, 1);
 
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
 			err = -EFAULT;
@@ -276,13 +284,7 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 		if (nblocks > BIO_MAX_PAGES)
 			nblocks = BIO_MAX_PAGES;
 
-		bio = erofs_grab_bio(sb, blknr, nblocks, sb,
-				     read_endio, false);
-		if (IS_ERR(bio)) {
-			err = PTR_ERR(bio);
-			bio = NULL;
-			goto err_out;
-		}
+		bio = erofs_grab_raw_bio(sb, blknr, nblocks);
 	}
 
 	err = bio_add_page(bio, page, PAGE_SIZE, 0);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cc1ea98c5c89..000ea92b36a3 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -411,35 +411,6 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 /* data.c */
-static inline struct bio *erofs_grab_bio(struct super_block *sb,
-					 erofs_blk_t blkaddr,
-					 unsigned int nr_pages,
-					 void *bi_private, bio_end_io_t endio,
-					 bool nofail)
-{
-	const gfp_t gfp = GFP_NOIO;
-	struct bio *bio;
-
-	do {
-		if (nr_pages == 1) {
-			bio = bio_alloc(gfp | (nofail ? __GFP_NOFAIL : 0), 1);
-			if (!bio) {
-				DBG_BUGON(nofail);
-				return ERR_PTR(-ENOMEM);
-			}
-			break;
-		}
-		bio = bio_alloc(gfp, nr_pages);
-		nr_pages /= 2;
-	} while (!bio);
-
-	bio->bi_end_io = endio;
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_iter.bi_sector = (sector_t)blkaddr << LOG_SECTORS_PER_BLOCK;
-	bio->bi_private = bi_private;
-	return bio;
-}
-
 static inline void __submit_bio(struct bio *bio, unsigned int op,
 				unsigned int op_flags)
 {
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f06a2fad7af2..21ade322cc81 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1263,9 +1263,13 @@ static bool z_erofs_vle_submit_all(struct super_block *sb,
 		}
 
 		if (!bio) {
-			bio = erofs_grab_bio(sb, first_index + i,
-					     BIO_MAX_PAGES, bi_private,
-					     z_erofs_vle_read_endio, true);
+			bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
+
+			bio->bi_end_io = z_erofs_vle_read_endio;
+			bio_set_dev(bio, sb->s_bdev);
+			bio->bi_iter.bi_sector = (sector_t)(first_index + i) <<
+				LOG_SECTORS_PER_BLOCK;
+			bio->bi_private = bi_private;
 			++nr_bios;
 		}
 
-- 
2.17.1

