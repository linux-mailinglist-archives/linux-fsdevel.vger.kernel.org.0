Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD61114430
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfLEP4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 10:56:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:35568 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729855AbfLEP4r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:56:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA964AF8A;
        Thu,  5 Dec 2019 15:56:45 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hch@infradead.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, jthumshirn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 5/8] fs: Remove dio_end_io()
Date:   Thu,  5 Dec 2019 09:56:27 -0600
Message-Id: <20191205155630.28817-6-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191205155630.28817-1-rgoldwyn@suse.de>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Since we removed the last user of dio_end_io(), remove the helper
function dio_end_io().

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/direct-io.c     | 19 -------------------
 include/linux/fs.h |  1 -
 2 files changed, 20 deletions(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 9329ced91f1d..9d6fc6467d9c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -405,25 +405,6 @@ static void dio_bio_end_io(struct bio *bio)
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
index 5bc75cff3536..eab2c26fb32a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3154,7 +3154,6 @@ enum {
 	DIO_SKIP_HOLES	= 0x02,
 };
 
-void dio_end_io(struct bio *bio);
 void dio_warn_stale_pagecache(struct file *filp);
 
 ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
-- 
2.16.4

