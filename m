Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5B3E475B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 16:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhHIOTn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbhHIOTj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:19:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7CDC061798;
        Mon,  9 Aug 2021 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=e/hMr9qV3lYuoExuGo8ptlwF2KxcgT3KNTD6PJZ/mnk=; b=LcdQbBNS9XkSbbdubrlmjEs4kt
        CQA+10SkoQ7oBciWNnRLhJKjR2feUZZ0CeHZcXUMzruTD7b5cDQv1Ajslx71MlIyKJbD4aDaa4jrE
        YZv3l2Fl7HGLmsqfGco8THzc95rGm2rTmm4zaC5k8eDYO09SEvoEJvgotDJkOo1nnsAFWrR7QlCYc
        zYF6hEiLKAFewD94R5+LW+DveXN3PvJ2FSj1jdR7HSr8uGXKMG/i9WLobPB9u6vPE+Uuo5kNylZsH
        me0B83H4YX+3rVw88+Y1eZaCBOs8bXo7tE1XNtbF1djEP0bZLdsI78X6kknlp2097KVGefG0bHNtm
        Y4LIN3bA==;
Received: from [2001:4bb8:184:6215:d19a:ace4:57f0:d5ad] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD66f-00B45s-N4; Mon, 09 Aug 2021 14:18:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 1/5] mm: hide laptop_mode_wb_timer entirely behind the BDI API
Date:   Mon,  9 Aug 2021 16:17:40 +0200
Message-Id: <20210809141744.1203023-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210809141744.1203023-1-hch@lst.de>
References: <20210809141744.1203023-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't leak the detaіls of the timer into the block layer, instead
initialize the timer in bdi_alloc and delete it in bdi_unregister.
Note that this means the timer is initialized (but not armed) for
non-block queues as well now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c    | 5 -----
 mm/backing-dev.c    | 3 +++
 mm/page-writeback.c | 2 --
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 04477697ee4b..5897bc37467d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -394,10 +394,7 @@ void blk_cleanup_queue(struct request_queue *q)
 	/* for synchronous bio-based driver finish in-flight integrity i/o */
 	blk_flush_integrity();
 
-	/* @q won't process any more request, flush async actions */
-	del_timer_sync(&q->backing_dev_info->laptop_mode_wb_timer);
 	blk_sync_queue(q);
-
 	if (queue_is_mq(q))
 		blk_mq_exit_queue(q);
 
@@ -546,8 +543,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 
 	atomic_set(&q->nr_active_requests_shared_sbitmap, 0);
 
-	timer_setup(&q->backing_dev_info->laptop_mode_wb_timer,
-		    laptop_mode_timer_fn, 0);
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index f5561ea7d90a..cd06dca232c3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -807,6 +807,7 @@ struct backing_dev_info *bdi_alloc(int node_id)
 	bdi->capabilities = BDI_CAP_WRITEBACK | BDI_CAP_WRITEBACK_ACCT;
 	bdi->ra_pages = VM_READAHEAD_PAGES;
 	bdi->io_pages = VM_READAHEAD_PAGES;
+	timer_setup(&bdi->laptop_mode_wb_timer, laptop_mode_timer_fn, 0);
 	return bdi;
 }
 EXPORT_SYMBOL(bdi_alloc);
@@ -928,6 +929,8 @@ static void bdi_remove_from_list(struct backing_dev_info *bdi)
 
 void bdi_unregister(struct backing_dev_info *bdi)
 {
+	del_timer_sync(&bdi->laptop_mode_wb_timer);
+
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 9f63548f247c..c12f67cbfa19 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2010,7 +2010,6 @@ int dirty_writeback_centisecs_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
-#ifdef CONFIG_BLOCK
 void laptop_mode_timer_fn(struct timer_list *t)
 {
 	struct backing_dev_info *backing_dev_info =
@@ -2045,7 +2044,6 @@ void laptop_sync_completion(void)
 
 	rcu_read_unlock();
 }
-#endif
 
 /*
  * If ratelimit_pages is too high then we can get into dirty-data overload
-- 
2.30.2

