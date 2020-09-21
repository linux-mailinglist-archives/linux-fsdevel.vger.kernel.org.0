Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F3271B65
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Sep 2020 09:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIUHUU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Sep 2020 03:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIUHUQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:20:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A2DC0613D7;
        Mon, 21 Sep 2020 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2ayaBUOXfktvOTjNfjilWVR81vP6mBqMDpKHyQ4yF8I=; b=muTdr9Q0kCcwvowRu+pixikTkn
        uEtunHlWR3/cO5sYwYPymYqroPkHU0rym28z4VZlm/kV1pDkDphJXGfWVXkO8Y06r4AsthRjqt8mG
        Gl/8BiFkKPlmxx2qMDJHL3fiIkm7EpJhYUWve6JERJGa4DWTAGUZpjKJh3hYRknB+rKQqKIhoRH3T
        j3Mu06iqpSGA5MvyZwvU8GPVna2ZJ29V6d/J+MF4i3TsvhBCj3f3NaqdsJlD2Rsw5eMttqsEiIR2b
        S/iJT0hXO9FTy3SjX0aEmBlcq4C5HiqeUlB7aQq5ERWuZkY9sLRCEXY3nvaBiu4p/0zcCp/qng9V1
        hOD8k12Q==;
Received: from p4fdb0c34.dip0.t-ipconnect.de ([79.219.12.52] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKG7G-0003GN-Vf; Mon, 21 Sep 2020 07:20:03 +0000
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
Subject: [PATCH 12/14] mm: split swap_type_of
Date:   Mon, 21 Sep 2020 09:19:56 +0200
Message-Id: <20200921071958.307589-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921071958.307589-1-hch@lst.de>
References: <20200921071958.307589-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

swap_type_of is used for two entirely different purposes:

 (1) check what swap type a given device/offset corresponds to
 (2) find the first available swap device that can be written to

Mixing both in a single function creates an unreadable mess.  Create two
separate functions instead, and switch both to pass a dev_t instead of
a struct block_device to further simplify the code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/swap.h |  3 ++-
 kernel/power/swap.c  | 17 ++++++++---------
 kernel/power/user.c  | 16 ++++------------
 mm/swapfile.c        | 39 +++++++++++++++++++++------------------
 4 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4b9..4340a7b6e7a1dc 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -467,7 +467,8 @@ extern int swapcache_prepare(swp_entry_t);
 extern void swap_free(swp_entry_t);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
 extern int free_swap_and_cache(swp_entry_t);
-extern int swap_type_of(dev_t, sector_t, struct block_device **);
+int swap_type_of(dev_t device, sector_t offset);
+int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct page *, struct block_device **);
 extern sector_t swapdev_block(int, pgoff_t);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 01e2858b5fe367..9d3ffbfe08dbf6 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -335,12 +335,17 @@ static int swsusp_swap_check(void)
 {
 	int res;
 
-	res = swap_type_of(swsusp_resume_device, swsusp_resume_block,
-			&hib_resume_bdev);
+	if (swsusp_resume_device)
+		res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
+	else
+		res = find_first_swap(&swsusp_resume_device);
 	if (res < 0)
 		return res;
-
 	root_swap = res;
+
+	hib_resume_bdev = bdget(swsusp_resume_device);
+	if (!hib_resume_bdev)
+		return -ENOMEM;
 	res = blkdev_get(hib_resume_bdev, FMODE_WRITE, NULL);
 	if (res)
 		return res;
@@ -349,12 +354,6 @@ static int swsusp_swap_check(void)
 	if (res < 0)
 		blkdev_put(hib_resume_bdev, FMODE_WRITE);
 
-	/*
-	 * Update the resume device to the one actually used,
-	 * so the test_resume mode can use it in case it is
-	 * invoked from hibernate() to test the snapshot.
-	 */
-	swsusp_resume_device = hib_resume_bdev->bd_dev;
 	return res;
 }
 
diff --git a/kernel/power/user.c b/kernel/power/user.c
index b5815685b944fe..6510a8f7687f42 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -69,8 +69,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
-		data->swap = swsusp_resume_device ?
-			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
+		data->swap = swap_type_of(swsusp_resume_device, 0);
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
 		error = __pm_notifier_call_chain(PM_HIBERNATION_PREPARE, -1, &nr_calls);
@@ -210,7 +209,6 @@ struct compat_resume_swap_area {
 static int snapshot_set_swap_area(struct snapshot_data *data,
 		void __user *argp)
 {
-	struct block_device *bdev;
 	sector_t offset;
 	dev_t swdev;
 
@@ -237,16 +235,10 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
 	 */
-	if (!swdev) {
-		data->swap = -1;
-		return -EINVAL;
-	}
-	data->swap = swap_type_of(swdev, offset, &bdev);
+	data->swap = swap_type_of(swdev, offset);
 	if (data->swap < 0)
-		return -ENODEV;
-
-	data->dev = bdev->bd_dev;
-	bdput(bdev);
+		return swdev ? -ENODEV : -EINVAL;
+	data->dev = swdev;
 	return 0;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7438c4affc75fa..b90f8692074397 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1801,13 +1801,12 @@ int free_swap_and_cache(swp_entry_t entry)
  *
  * This is needed for the suspend to disk (aka swsusp).
  */
-int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
+int swap_type_of(dev_t device, sector_t offset)
 {
-	struct block_device *bdev = NULL;
 	int type;
 
-	if (device)
-		bdev = bdget(device);
+	if (!device)
+		return -1;
 
 	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
@@ -1816,30 +1815,34 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 
-		if (!bdev) {
-			if (bdev_p)
-				*bdev_p = bdgrab(sis->bdev);
-
-			spin_unlock(&swap_lock);
-			return type;
-		}
-		if (bdev == sis->bdev) {
+		if (device == sis->bdev->bd_dev) {
 			struct swap_extent *se = first_se(sis);
 
 			if (se->start_block == offset) {
-				if (bdev_p)
-					*bdev_p = bdgrab(sis->bdev);
-
 				spin_unlock(&swap_lock);
-				bdput(bdev);
 				return type;
 			}
 		}
 	}
 	spin_unlock(&swap_lock);
-	if (bdev)
-		bdput(bdev);
+	return -ENODEV;
+}
 
+int find_first_swap(dev_t *device)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+
+		if (!(sis->flags & SWP_WRITEOK))
+			continue;
+		*device = sis->bdev->bd_dev;
+		spin_unlock(&swap_lock);
+		return type;
+	}
+	spin_unlock(&swap_lock);
 	return -ENODEV;
 }
 
-- 
2.28.0

