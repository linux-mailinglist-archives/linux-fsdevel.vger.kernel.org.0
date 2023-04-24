Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA686EC59F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 07:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjDXFwh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 01:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjDXFvt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 01:51:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E245246BF;
        Sun, 23 Apr 2023 22:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DeEMnLNut18pjb9zsoS5o5eSPuPyLSQ1uVXA5zuWlvs=; b=eaGzgbZaXKx1KyoFV6zGe9nYHJ
        ZwankVTk2pK/HLEjyW9HXQbEvrT6olrOT1KuAt81GdNbakAo0iy44P4Damhh264EH/+JUBMVsDYUM
        /kugXtMO6Gv9hObKPdcxPihekCau7Ms1S+MMRj+dlBau86GBhMGLzLMEMWBDJjhuLS9zMvKps3MPN
        MHHySMYe2QhwxmEt9zHbO8D812jGdIzNJbIexnk/RGuGbtYWA/Htqd9xtyVpBl2gYuBEHgvrzgeQe
        VeoXtT8G1+qTJKrcrVDwi79thfMJRDrNOMiZDFn8W6VhlJiNx0v1TuyWCgTI6FGUeXrqgZWtaCrV4
        p1Am25Kg==;
Received: from [2001:4bb8:189:a74f:e8a5:5f73:6d2:23b8] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pqp5e-00FPC9-1d;
        Mon, 24 Apr 2023 05:50:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/17] block: use iomap for writes to block devices
Date:   Mon, 24 Apr 2023 07:49:25 +0200
Message-Id: <20230424054926.26927-17-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230424054926.26927-1-hch@lst.de>
References: <20230424054926.26927-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use iomap in buffer_head compat mode to write to block devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig |  1 +
 block/fops.c  | 33 +++++++++++++++++++++++++++++----
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 941b2dca70db73..672b08f0096ab4 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -5,6 +5,7 @@
 menuconfig BLOCK
        bool "Enable the block layer" if EXPERT
        default y
+       select IOMAP
        select SBITMAP
        help
 	 Provide block layer support for the kernel.
diff --git a/block/fops.c b/block/fops.c
index 318247832a7bcf..7910636f8df33b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -15,6 +15,7 @@
 #include <linux/falloc.h>
 #include <linux/suspend.h>
 #include <linux/fs.h>
+#include <linux/iomap.h>
 #include <linux/module.h>
 #include "blk.h"
 
@@ -386,6 +387,27 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
 }
 
+static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
+		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct block_device *bdev = I_BDEV(inode);
+	loff_t isize = i_size_read(inode);
+
+	iomap->bdev = bdev;
+	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
+	if (WARN_ON_ONCE(iomap->offset >= isize))
+		return -EIO;
+	iomap->type = IOMAP_MAPPED;
+	iomap->addr = iomap->offset;
+	iomap->length = isize - iomap->offset;
+	iomap->flags |= IOMAP_F_BUFFER_HEAD;
+	return 0;
+}
+
+static const struct iomap_ops blkdev_iomap_ops = {
+	.iomap_begin		= blkdev_iomap_begin,
+};
+
 static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, blkdev_get_block, wbc);
@@ -530,6 +552,11 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	return written;
 }
 
+static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops);
+}
+
 /*
  * Write data to the block device.  Only intended for the block device itself
  * and the raw driver which basically is a fake block device.
@@ -575,16 +602,14 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, size);
 	}
 
-	current->backing_dev_info = bdev->bd_disk->bdi;
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from))
 			ret = direct_write_fallback(iocb, from, ret,
-					generic_perform_write(iocb, from));
+					blkdev_buffered_write(iocb, from));
 	} else {
-		ret = generic_perform_write(iocb, from);
+		ret = blkdev_buffered_write(iocb, from);
 	}
-	current->backing_dev_info = NULL;
 
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
-- 
2.39.2

