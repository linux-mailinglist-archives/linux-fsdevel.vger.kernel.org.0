Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBC27288E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 16:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIUOoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 10:44:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:55288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgIUOoJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:44:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EC4B4AC4C;
        Mon, 21 Sep 2020 14:44:43 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 01/15] fs: remove dio_end_io()
Date:   Mon, 21 Sep 2020 09:43:39 -0500
Message-Id: <20200921144353.31319-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921144353.31319-1-rgoldwyn@suse.de>
References: <20200921144353.31319-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we removed the last user of dio_end_io(), remove the helper
function dio_end_io().

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/direct-io.c     | 19 -------------------
 include/linux/fs.h |  2 --
 2 files changed, 21 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 183299892465..abf535b036ab 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -386,25 +386,6 @@ static void dio_bio_end_io(struct bio *bio)
 	spin_unlock_irqrestore(&dio->bio_lock, flags);
 }
 
-/**
- * dio_end_io - handle the end io action for the given bio
- * @bio: The direct io bio thats being completed
- *
- * This is meant to be called by any filesystem that uses their own dio_submit_t
- * so that the DIO specific endio actions are dealt with after the filesystem
- * has done it's completion work.
- */
-void dio_end_io(struct bio *bio)
-{
-	struct dio *dio = bio->bi_private;
-
-	if (dio->is_async)
-		dio_bio_end_aio(bio);
-	else
-		dio_bio_end_io(bio);
-}
-EXPORT_SYMBOL_GPL(dio_end_io);
-
 static inline void
 dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 	      struct block_device *bdev,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..8e2842a9c0b3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3079,8 +3079,6 @@ enum {
 	DIO_SKIP_HOLES	= 0x02,
 };
 
-void dio_end_io(struct bio *bio);
-
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 			     struct block_device *bdev, struct iov_iter *iter,
 			     get_block_t get_block,
-- 
2.26.2

