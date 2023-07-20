Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C4F75B0BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjGTOFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjGTOFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:05:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A34C211F;
        Thu, 20 Jul 2023 07:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=yaOs2VrbaTQ5mw1fhRctemzRO8G1izk4pie8fEUG7Pg=; b=d4IXxaa5wwC5+QTPqwZACF6baC
        JRSFT/yUddFQ4e0UY/3unt4en7V/gUFgWW3XehEy7vbuPyeS1o5h6ibusSemRJ9GF6zjuH7dy3KS5
        cUxDGvI9gRPpNA/LcUNteFDRq7AWl8O6tBbyq6UHpoKIoKKAWeU5FU1J6tK1QmZ3nLpHhj9EbKUta
        Si1NSYxlGTurFNu21XyAt5SbSzAa8rAXLvO854DUMthK8kWTNgK8tS6tCm44djlZm8Va+f5g9nMHF
        KJzeetajdRSWRG1iMdLh6awhN9EeRwIUTzrv+YB+RkP13LWl919K7HA+2sCYpxjFlqyAL+zYtTXnp
        l3ISmLyA==;
Received: from [2001:4bb8:19a:298e:a587:c3ea:b692:5b8d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qMUH8-00BKq4-2T;
        Thu, 20 Jul 2023 14:05:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] block: open code __generic_file_write_iter for blkdev writes
Date:   Thu, 20 Jul 2023 16:04:49 +0200
Message-Id: <20230720140452.63817-4-hch@lst.de>
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

Open code __generic_file_write_iter to remove the indirect call into
->direct_IO and to prepare using the iomap based write code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index a286bf3325c5d8..eb599a173ef02d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -533,6 +533,29 @@ static int blkdev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+static ssize_t
+blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	size_t count = iov_iter_count(from);
+	ssize_t written;
+
+	written = kiocb_invalidate_pages(iocb, count);
+	if (written) {
+		if (written == -EBUSY)
+			return 0;
+		return written;
+	}
+
+	written = blkdev_direct_IO(iocb, from);
+	if (written > 0) {
+		kiocb_invalidate_post_direct_write(iocb, count);
+		iocb->ki_pos += written;
+	}
+	if (written != -EIOCBQUEUED)
+		iov_iter_revert(from, count - written - iov_iter_count(from));
+	return written;
+}
+
 /*
  * Write data to the block device.  Only intended for the block device itself
  * and the raw driver which basically is a fake block device.
@@ -542,7 +565,8 @@ static int blkdev_release(struct inode *inode, struct file *filp)
  */
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
@@ -569,7 +593,23 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		iov_iter_truncate(from, size);
 	}
 
-	ret = __generic_file_write_iter(iocb, from);
+	ret = file_remove_privs(file);
+	if (ret)
+		return ret;
+
+	ret = file_update_time(file);
+	if (ret)
+		return ret;
+
+	if (iocb->ki_flags & IOCB_DIRECT) {
+		ret = blkdev_direct_write(iocb, from);
+		if (ret >= 0 && iov_iter_count(from))
+			ret = direct_write_fallback(iocb, from, ret,
+					generic_perform_write(iocb, from));
+	} else {
+		ret = generic_perform_write(iocb, from);
+	}
+
 	if (ret > 0)
 		ret = generic_write_sync(iocb, ret);
 	iov_iter_reexpand(from, iov_iter_count(from) + shorted);
-- 
2.39.2

