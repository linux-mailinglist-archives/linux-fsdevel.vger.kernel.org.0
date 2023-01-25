Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05D6D67B36A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAYNfF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjAYNfA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:35:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8EA51C74;
        Wed, 25 Jan 2023 05:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=jVkXgiX++B6ZRBSVBAQLBWXDo+TKW/LQnC8PttvWfoI=; b=jpPymmd9O3sK/QGD+ihLjY6MQw
        DujfARMhHkJboFbptXRG3wcOjROYaih0gEIyYQ62LZVDUAgArAKCyD8OCwjzY6z/naqsY2qirNzk6
        ilVJSvbs/au6I8kbHKpxEMoXr4kQ+PIXBx1Xx05PUmL47nkfz1F+kf+Vv2AKaDc+l3ObIsNC38cn8
        JxvQTVAJfCpZs6htcmZCXlun2hpg6aZGiqB+MjWGH2YZ1xt9fR7clMZ5B8g0ihcuH/72NKZHCUQHv
        wY9Mvjy501914NspkIOys3opWFybPv4UVzJIlny+xpsxGrYLH50vRDjbdL9W0IIis2vQexz/hNkUn
        YYxaSGBA==;
Received: from [2001:4bb8:19a:27af:c78f:9b0d:b95c:d248] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKfvS-007P3i-N5; Wed, 25 Jan 2023 13:34:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/7] mm: use an on-stack bio for synchronous swapin
Date:   Wed, 25 Jan 2023 14:34:33 +0100
Message-Id: <20230125133436.447864-5-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
References: <20230125133436.447864-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Optimize the synchronous swap in case by using an on-stack bio instead
of allocating one using bio_alloc.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_io.c | 69 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index ce0b3638094f85..21ce4505f00607 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -52,10 +52,9 @@ static void end_swap_bio_write(struct bio *bio)
 	bio_put(bio);
 }
 
-static void end_swap_bio_read(struct bio *bio)
+static void __end_swap_bio_read(struct bio *bio)
 {
 	struct page *page = bio_first_page_all(bio);
-	struct task_struct *waiter = bio->bi_private;
 
 	if (bio->bi_status) {
 		SetPageError(page);
@@ -63,18 +62,16 @@ static void end_swap_bio_read(struct bio *bio)
 		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
 				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
 				     (unsigned long long)bio->bi_iter.bi_sector);
-		goto out;
+	} else {
+		SetPageUptodate(page);
 	}
-
-	SetPageUptodate(page);
-out:
 	unlock_page(page);
-	WRITE_ONCE(bio->bi_private, NULL);
+}
+
+static void end_swap_bio_read(struct bio *bio)
+{
+	__end_swap_bio_read(bio);
 	bio_put(bio);
-	if (waiter) {
-		blk_wake_io_task(waiter);
-		put_task_struct(waiter);
-	}
 }
 
 int generic_swapfile_activate(struct swap_info_struct *sis,
@@ -445,10 +442,11 @@ static void swap_readpage_fs(struct page *page,
 		*plug = sio;
 }
 
-static void swap_readpage_bdev(struct page *page, bool synchronous,
+static void swap_readpage_bdev_sync(struct page *page,
 		struct swap_info_struct *sis)
 {
-	struct bio *bio;
+	struct bio_vec bv;
+	struct bio bio;
 
 	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
 	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
@@ -456,30 +454,37 @@ static void swap_readpage_bdev(struct page *page, bool synchronous,
 		return;
 	}
 
-	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
-	bio->bi_iter.bi_sector = swap_page_sector(page);
-	bio->bi_end_io = end_swap_bio_read;
-	bio_add_page(bio, page, thp_size(page), 0);
+	bio_init(&bio, sis->bdev, &bv, 1, REQ_OP_READ);
+	bio.bi_iter.bi_sector = swap_page_sector(page);
+	bio_add_page(&bio, page, thp_size(page), 0);
 	/*
 	 * Keep this task valid during swap readpage because the oom killer may
 	 * attempt to access it in the page fault retry time check.
 	 */
-	if (synchronous) {
-		get_task_struct(current);
-		bio->bi_private = current;
-	}
+	get_task_struct(current);
 	count_vm_event(PSWPIN);
-	bio_get(bio);
-	submit_bio(bio);
-	while (synchronous) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (!READ_ONCE(bio->bi_private))
-			break;
+	submit_bio_wait(&bio);
+	__end_swap_bio_read(&bio);
+	put_task_struct(current);
+}
+
+static void swap_readpage_bdev_async(struct page *page,
+		struct swap_info_struct *sis)
+{
+	struct bio *bio;
 
-		blk_io_schedule();
+	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
+	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
+		count_vm_event(PSWPIN);
+		return;
 	}
-	__set_current_state(TASK_RUNNING);
-	bio_put(bio);
+
+	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
+	bio->bi_iter.bi_sector = swap_page_sector(page);
+	bio->bi_end_io = end_swap_bio_read;
+	bio_add_page(bio, page, thp_size(page), 0);
+	count_vm_event(PSWPIN);
+	submit_bio(bio);
 }
 
 void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
@@ -509,8 +514,10 @@ void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 		unlock_page(page);
 	} else if (data_race(sis->flags & SWP_FS_OPS)) {
 		swap_readpage_fs(page, plug);
+	} else if (synchronous) {
+		swap_readpage_bdev_sync(page, sis);
 	} else {
-		swap_readpage_bdev(page, synchronous, sis);
+		swap_readpage_bdev_async(page, sis);
 	}
 
 	if (workingset) {
-- 
2.39.0

