Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E180C72D166
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 23:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbjFLVFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 17:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbjFLVEn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:04:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08DB10F9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 14:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0jkJkWCuyQJ6JHYCEaQP7K47NHBMN43bMAiZZ3L65AM=; b=siXEE0FV8LliLis0imD3MgWr0S
        aBbgj1Ef1wsCkNerL/qfbEkhsYzePKuZgj4wvIk64rJvws95Ih5rJQkjOuYjoApVRq/k7tJIYL/81
        tnKXQMDJRTjsMV2N3GCp5UmUmh6CT8SEfYoqdVsjeZubbsA/iG55KUGp6Kuptvz7TJ/Ptbl/FqQPx
        o4fg7kzaEuFLZg06zZKBFLxmJTCkSTmC8nwqAAWv2lCzdQngv3UrXiaIv3KDhNklErXAdMbpuY6ku
        pYRHthCj53VjinR4pC9ZeM0Jer+i+4y9I3oa7BEDgCE+JMTPcS0i0gaVbRpLtaN8kZqpQWoJ9ARrf
        twslX8EA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q8ofX-0033xE-Ur; Mon, 12 Jun 2023 21:01:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        cluster-devel@redhat.com, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v3 11/14] buffer: Convert init_page_buffers() to folio_init_buffers()
Date:   Mon, 12 Jun 2023 22:01:38 +0100
Message-Id: <20230612210141.730128-12-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230612210141.730128-1-willy@infradead.org>
References: <20230612210141.730128-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index 06d031e28bee..9b9dee417467 100644
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

