Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921BC72FD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244289AbjFNLrJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 07:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbjFNLrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:47:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8BA131;
        Wed, 14 Jun 2023 04:47:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id DE9C322530;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686743217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lcE/JSbO8Lz9HATID+PDRS9qocozua81AyOw+OPYyM=;
        b=KDqVI+m5Dn/J4jI0LnZkE5O+DYO1FDTwxkSPwEuf5hkIRWstHnRAkeK/+KHNMRV5oYUW53
        m2orKviGkoEt9g8ncs7QwutiGAixybshvQGl7PvC7iTSRzsLEiRYD5U29S9wwaBglxzRHA
        c4WcgBCO2Fi4fxl880NvoFw8Ii0J1B0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686743217;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9lcE/JSbO8Lz9HATID+PDRS9qocozua81AyOw+OPYyM=;
        b=n0vqZw77i2z/ady7xhtHtq15GKwxQ9+gSlkQq6Tl1vFq+dAZO/uzUEcTz3qN5RNwrhE/p1
        nyWRNQBE6kfy+YDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 7C4A62C142;
        Wed, 14 Jun 2023 11:46:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 7163E51C4E0B; Wed, 14 Jun 2023 13:46:57 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 1/7] brd: use XArray instead of radix-tree to index backing pages
Date:   Wed, 14 Jun 2023 13:46:31 +0200
Message-Id: <20230614114637.89759-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
References: <20230614114637.89759-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

XArray was introduced to hold large array of pointers with a simple API.
XArray API also provides array semantics which simplifies the way we store
and access the backing pages, and the code becomes significantly easier
to understand.

No performance difference was noticed between the two implementation
using fio with direct=1 [1].

[1] Performance in KIOPS:

          |  radix-tree |    XArray  |   Diff
          |             |            |
write     |    315      |     313    |   -0.6%
randwrite |    286      |     290    |   +1.3%
read      |    330      |     335    |   +1.5%
randread  |    309      |     312    |   +0.9%

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/block/brd.c | 93 ++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 69 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index bcad9b926b0c..2f71376afc71 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -19,7 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
-#include <linux/radix-tree.h>
+#include <linux/xarray.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
@@ -28,7 +28,7 @@
 #include <linux/uaccess.h>
 
 /*
- * Each block ramdisk device has a radix_tree brd_pages of pages that stores
+ * Each block ramdisk device has a xarray brd_pages of pages that stores
  * the pages containing the block device's contents. A brd page's ->index is
  * its offset in PAGE_SIZE units. This is similar to, but in no way connected
  * with, the kernel's pagecache or buffer cache (which sit above our block
@@ -40,11 +40,9 @@ struct brd_device {
 	struct list_head	brd_list;
 
 	/*
-	 * Backing store of pages and lock to protect it. This is the contents
-	 * of the block device.
+	 * Backing store of pages. This is the contents of the block device.
 	 */
-	spinlock_t		brd_lock;
-	struct radix_tree_root	brd_pages;
+	struct xarray	        brd_pages;
 	u64			brd_nr_pages;
 };
 
@@ -56,21 +54,8 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 	pgoff_t idx;
 	struct page *page;
 
-	/*
-	 * The page lifetime is protected by the fact that we have opened the
-	 * device node -- brd pages will never be deleted under us, so we
-	 * don't need any further locking or refcounting.
-	 *
-	 * This is strictly true for the radix-tree nodes as well (ie. we
-	 * don't actually need the rcu_read_lock()), however that is not a
-	 * documented feature of the radix-tree API so it is better to be
-	 * safe here (we don't have total exclusion from radix tree updates
-	 * here, only deletes).
-	 */
-	rcu_read_lock();
 	idx = sector >> PAGE_SECTORS_SHIFT; /* sector to page index */
-	page = radix_tree_lookup(&brd->brd_pages, idx);
-	rcu_read_unlock();
+	page = xa_load(&brd->brd_pages, idx);
 
 	BUG_ON(page && page->index != idx);
 
@@ -83,7 +68,7 @@ static struct page *brd_lookup_page(struct brd_device *brd, sector_t sector)
 static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 {
 	pgoff_t idx;
-	struct page *page;
+	struct page *page, *cur;
 	int ret = 0;
 
 	page = brd_lookup_page(brd, sector);
@@ -94,71 +79,42 @@ static int brd_insert_page(struct brd_device *brd, sector_t sector, gfp_t gfp)
 	if (!page)
 		return -ENOMEM;
 
-	if (radix_tree_maybe_preload(gfp)) {
-		__free_page(page);
-		return -ENOMEM;
-	}
+	xa_lock(&brd->brd_pages);
 
-	spin_lock(&brd->brd_lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
 	page->index = idx;
-	if (radix_tree_insert(&brd->brd_pages, idx, page)) {
+
+	cur = __xa_cmpxchg(&brd->brd_pages, idx, NULL, page, gfp);
+
+	if (unlikely(cur)) {
 		__free_page(page);
-		page = radix_tree_lookup(&brd->brd_pages, idx);
-		if (!page)
-			ret = -ENOMEM;
-		else if (page->index != idx)
+		ret = xa_err(cur);
+		if (!ret && (cur->index != idx))
 			ret = -EIO;
 	} else {
 		brd->brd_nr_pages++;
 	}
-	spin_unlock(&brd->brd_lock);
 
-	radix_tree_preload_end();
+	xa_unlock(&brd->brd_pages);
+
 	return ret;
 }
 
 /*
- * Free all backing store pages and radix tree. This must only be called when
+ * Free all backing store pages and xarray. This must only be called when
  * there are no other users of the device.
  */
-#define FREE_BATCH 16
 static void brd_free_pages(struct brd_device *brd)
 {
-	unsigned long pos = 0;
-	struct page *pages[FREE_BATCH];
-	int nr_pages;
-
-	do {
-		int i;
-
-		nr_pages = radix_tree_gang_lookup(&brd->brd_pages,
-				(void **)pages, pos, FREE_BATCH);
-
-		for (i = 0; i < nr_pages; i++) {
-			void *ret;
-
-			BUG_ON(pages[i]->index < pos);
-			pos = pages[i]->index;
-			ret = radix_tree_delete(&brd->brd_pages, pos);
-			BUG_ON(!ret || ret != pages[i]);
-			__free_page(pages[i]);
-		}
-
-		pos++;
+	struct page *page;
+	pgoff_t idx;
 
-		/*
-		 * It takes 3.4 seconds to remove 80GiB ramdisk.
-		 * So, we need cond_resched to avoid stalling the CPU.
-		 */
-		cond_resched();
+	xa_for_each(&brd->brd_pages, idx, page) {
+		__free_page(page);
+		cond_resched_rcu();
+	}
 
-		/*
-		 * This assumes radix_tree_gang_lookup always returns as
-		 * many pages as possible. If the radix-tree code changes,
-		 * so will this have to.
-		 */
-	} while (nr_pages == FREE_BATCH);
+	xa_destroy(&brd->brd_pages);
 }
 
 /*
@@ -372,8 +328,7 @@ static int brd_alloc(int i)
 	brd->brd_number		= i;
 	list_add_tail(&brd->brd_list, &brd_devices);
 
-	spin_lock_init(&brd->brd_lock);
-	INIT_RADIX_TREE(&brd->brd_pages, GFP_ATOMIC);
+	xa_init(&brd->brd_pages);
 
 	snprintf(buf, DISK_NAME_LEN, "ram%d", i);
 	if (!IS_ERR_OR_NULL(brd_debugfs_dir))
-- 
2.35.3

