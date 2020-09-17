Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D467326E277
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgIQRcb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIQRcX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:32:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90C8C061756;
        Thu, 17 Sep 2020 10:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aWpQMjG3K8ZDoYTgVEFk+u0gKdJASH29rDnXXsv40lc=; b=Dm9rJToEv5QoeUIJDeph7dhbur
        gwoCjoXk9z1ys8KpcSBYDLqMT1Nf9EFz+Di0leYbFE5iZpQ2FsehXcNytcb7rtXI7r1VnUrM1hLma
        dGJif67i/BDBbYjrRBKTuAnyU02ItS4wtrrKv/t2uYMMnOm6P3bfZfKMgoZJ3Fmsso+OPYh+4ZoG8
        9mHzNkUPE7tykFIPua0nL8LW2g1A6Pv5FYGycK9iZvU5oO08nVV8vnAeCt2ymhT2e4mWjJ692JRDZ
        cmweQaexCBfUhP/AjFVJul91JZlvLR6EYZF2uPkEpjjGUADqOOrFSX8ODkTr1ziOMsyYRLd5xDLHC
        MDtCfFdQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxjT-0002bF-Rq; Thu, 17 Sep 2020 17:30:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-ide@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: [PATCH 14/14] block: mark blkdev_get static
Date:   Thu, 17 Sep 2020 18:57:20 +0200
Message-Id: <20200917165720.3285256-15-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no users outside the core block code left now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c         | 3 +--
 include/linux/blkdev.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 2898d69be6b3e4..6b9d19ffa5af7b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1616,7 +1616,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
+static int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
 	int ret, perm = 0;
 
@@ -1637,7 +1637,6 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 	bdput(bdev);
 	return ret;
 }
-EXPORT_SYMBOL(blkdev_get);
 
 /**
  * blkdev_get_by_path - open a block device by name
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bd96fbab9b4c8..14117995091224 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1975,7 +1975,6 @@ void blkdev_show(struct seq_file *seqf, off_t offset);
 #define BLKDEV_MAJOR_MAX	0
 #endif
 
-int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-- 
2.28.0

