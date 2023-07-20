Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1429175B0C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjGTOFn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjGTOFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:05:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D6A211D;
        Thu, 20 Jul 2023 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=FviJ2yeCGqBqXQbTzRBmfPSUTBs1/XNV2kCvgMLKD4c=; b=qfgHEX10lEj4flWctKOvhcyM0M
        cNFGZnU1gk4ET3nG6rquI9Tpm3hN+yb//YIrG8r1fEhPAwbMqW6LP6snaOtTo/PRc0jluPzT0O5ER
        hXHfYA1w/l2zF5BquPeGQsthe8FOQSfH8+blJHEQw/6Pc8KYpOY6eAwDm4b4JGyQl2cN0ivmFTl6M
        0yBTKNhEK+akJ92/gXbUCDB/PU/GepysHzFcaL3q9vyJarhfjKwcqC+Sn//OJkf4oSNm0jr7cSBmr
        fMAWGfE0GT6ET76ehq7mLgkuf0FeEEwA1C1k11lSvMgRX94FkvQpfD6jIoDPtIOm8ALLlj5djIHrJ
        eM5euuXA==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMUHE-00BKuF-0C;
        Thu, 20 Jul 2023 14:05:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] block: use iomap for writes to block devices
Date:   Thu, 20 Jul 2023 16:04:51 +0200
Message-Id: <20230720140452.63817-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720140452.63817-1-hch@lst.de>
References: <20230720140452.63817-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use iomap in buffer_head compat mode to write to block devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig |  1 +
 block/fops.c  | 31 +++++++++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 86122e459fe046..1a13ef0b1ca10c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -5,6 +5,7 @@
 menuconfig BLOCK
        bool "Enable the block layer" if EXPERT
        default y
+       select FS_IOMAP
        select SBITMAP
        help
 	 Provide block layer support for the kernel.
diff --git a/block/fops.c b/block/fops.c
index 0c37c35003c3b7..31d356c83f27a3 100644
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
@@ -555,6 +577,11 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
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
@@ -604,9 +631,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from))
 			ret = direct_write_fallback(iocb, from, ret,
-					generic_perform_write(iocb, from));
+					blkdev_buffered_write(iocb, from));
 	} else {
-		ret = generic_perform_write(iocb, from);
+		ret = blkdev_buffered_write(iocb, from);
 	}
 
 	if (ret > 0)
-- 
2.39.2

