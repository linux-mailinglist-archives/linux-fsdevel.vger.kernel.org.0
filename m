Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B50E26E247
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Sep 2020 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgIQRXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Sep 2020 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbgIQRXn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:23:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F53C06174A;
        Thu, 17 Sep 2020 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IWdgcM61fs+kVN3dvCku1mkt6uj7ZA5jubNT+EiUHzI=; b=PkTOoVHQ0Jo76SGurVUyndfTWr
        oVlryAN694M2ij3f+WvWLoHAp1MCHnxFGtmXwjo3Fqu9bZ5wRhknnuO9pv5cQELskjyVwh1FoFq5Y
        cpv6+VhjR0LCt+gwmvoal7FfwbLgG1fgk6Kr3UNCIvbxZptb28oOcGjz8+vTfqvJRrjqjBISFy6+d
        ZGk9yxuCcU8aP4XxOmG3i33Cc1MrPXwHzxjgqj7er9FsWcvLbFo4Ve+o+Xy4W6IBtHaf3jtEmVNRf
        X1E6YzC8zihmv5lkPHfuPrxtnuVi5+39b8UzchBhAPATAH1udG3XKKxJvLVUTr8APnyRzaEbxtzjC
        nzR1mX0g==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIxd8-00026l-LT; Thu, 17 Sep 2020 17:23:34 +0000
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
Subject: [PATCH 11/14] PM: rewrite is_hibernate_resume_dev to not require an inode
Date:   Thu, 17 Sep 2020 18:57:17 +0200
Message-Id: <20200917165720.3285256-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917165720.3285256-1-hch@lst.de>
References: <20200917165720.3285256-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just check the dev_t to help simplifying the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c          |  2 +-
 include/linux/suspend.h |  4 ++--
 kernel/power/user.c     | 12 ++++++------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1a9325f4315769..2898d69be6b3e4 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1885,7 +1885,7 @@ ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (bdev_read_only(I_BDEV(bd_inode)))
 		return -EPERM;
 
-	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode))
+	if (IS_SWAPFILE(bd_inode) && !is_hibernate_resume_dev(bd_inode->i_rdev))
 		return -ETXTBSY;
 
 	if (!iov_iter_count(from))
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index cb9afad82a90c8..8af13ba60c7e45 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -473,9 +473,9 @@ static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 #endif /* CONFIG_HIBERNATION */
 
 #ifdef CONFIG_HIBERNATION_SNAPSHOT_DEV
-int is_hibernate_resume_dev(const struct inode *);
+int is_hibernate_resume_dev(dev_t dev);
 #else
-static inline int is_hibernate_resume_dev(const struct inode *i) { return 0; }
+static inline int is_hibernate_resume_dev(dev_t dev) { return 0; }
 #endif
 
 /* Hibernation and suspend events */
diff --git a/kernel/power/user.c b/kernel/power/user.c
index d5eedc2baa2a10..b5815685b944fe 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -35,12 +35,12 @@ static struct snapshot_data {
 	bool ready;
 	bool platform_support;
 	bool free_bitmaps;
-	struct inode *bd_inode;
+	dev_t dev;
 } snapshot_state;
 
-int is_hibernate_resume_dev(const struct inode *bd_inode)
+int is_hibernate_resume_dev(dev_t dev)
 {
-	return hibernation_available() && snapshot_state.bd_inode == bd_inode;
+	return hibernation_available() && snapshot_state.dev == dev;
 }
 
 static int snapshot_open(struct inode *inode, struct file *filp)
@@ -101,7 +101,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	data->frozen = false;
 	data->ready = false;
 	data->platform_support = false;
-	data->bd_inode = NULL;
+	data->dev = 0;
 
  Unlock:
 	unlock_system_sleep();
@@ -117,7 +117,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 
 	swsusp_free();
 	data = filp->private_data;
-	data->bd_inode = NULL;
+	data->dev = 0;
 	free_all_swap_pages(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
@@ -245,7 +245,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 	if (data->swap < 0)
 		return -ENODEV;
 
-	data->bd_inode = bdev->bd_inode;
+	data->dev = bdev->bd_dev;
 	bdput(bdev);
 	return 0;
 }
-- 
2.28.0

