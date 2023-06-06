Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230D724FF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 00:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjFFWfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 18:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbjFFWew (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:34:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028481BE9
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 15:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Caz/R9K/an880SZlqoAQNJ80gGi+htRBSdsbSsE1UqQ=; b=s9+CYIx318AqnjsAsC292UOitm
        zkVoyf4/Zs3fa6n5fLzOh1VEXSrFg9+NyUL3+P1YyIsi9g6l5yANhfyL18xicuvFV/RvNv5htWe0f
        khsRerzeLne4k3ltnQpfNJVUcnG4c8NHt+0dyoo3NXyxw0k19DGNZLx3cNlC86KMoZso69SIx7S5y
        XxAySQQJXgKlLmE+u0cZzIw6DHxdVhpZMIWV88KxgGdtw9jiLQfpvG0tSQee38iLGApOVZPA8RFE7
        LzNfNdWBoIyJlH7qAbbpOyzhxxLTwEaAcBP9xfU+HGMyjgDuFisSeiPiKKNtYatZg8OfsIBh/q/25
        nDlRQC9g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6fFV-00DbF6-NH; Tue, 06 Jun 2023 22:33:57 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 11/14] buffer: Convert init_page_buffers() to folio_init_buffers()
Date:   Tue,  6 Jun 2023 23:33:43 +0100
Message-Id: <20230606223346.3241328-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230606223346.3241328-1-willy@infradead.org>
References: <20230606223346.3241328-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the folio API and pass the folio from both callers.
Saves a hidden call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c4fc4b3b8aab..9b789f109a57 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -934,15 +934,14 @@ static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 }
 
 /*
- * Initialise the state of a blockdev page's buffers.
+ * Initialise the state of a blockdev folio's buffers.
  */ 
-static sector_t
-init_page_buffers(struct page *page, struct block_device *bdev,
-			sector_t block, int size)
+static sector_t folio_init_buffers(struct folio *folio,
+		struct block_device *bdev, sector_t block, int size)
 {
-	struct buffer_head *head = page_buffers(page);
+	struct buffer_head *head = folio_buffers(folio);
 	struct buffer_head *bh = head;
-	int uptodate = PageUptodate(page);
+	bool uptodate = folio_test_uptodate(folio);
 	sector_t end_block = blkdev_max_block(bdev, size);
 
 	do {
@@ -998,9 +997,8 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	bh = folio_buffers(folio);
 	if (bh) {
 		if (bh->b_size == size) {
-			end_block = init_page_buffers(&folio->page, bdev,
-						(sector_t)index << sizebits,
-						size);
+			end_block = folio_init_buffers(folio, bdev,
+					(sector_t)index << sizebits, size);
 			goto done;
 		}
 		if (!try_to_free_buffers(folio))
@@ -1016,7 +1014,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	 */
 	spin_lock(&inode->i_mapping->private_lock);
 	link_dev_buffers(&folio->page, bh);
-	end_block = init_page_buffers(&folio->page, bdev,
+	end_block = folio_init_buffers(folio, bdev,
 			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->private_lock);
 done:
-- 
2.39.2

