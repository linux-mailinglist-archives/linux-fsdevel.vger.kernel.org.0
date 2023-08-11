Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099AB779418
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 18:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjHKQPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbjHKQPm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:15:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D5C273E;
        Fri, 11 Aug 2023 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mGLxLmLqoMtqKqObPpHvI58V/LNR6g3q9ebkb1KeSj4=; b=qovPmxo6vngNv6zu0MhFQMQVHu
        JY/vfqtADdsSKY48Foze9fiVOUY3EU3/VEqkPES+ALe5cZIxWHqsapi6R9IED0OuShRmmW4PkvOvp
        Kf9j7PWrHUhPDOVezbqHIXon6GD+UAvTOtuFgvJYqqm6j82cL+oz2fq3uk98sN8msmz1cEPUO0nBc
        zHl+CIGgWFQ3wfAIA1IGVYBGERRuhswJjYLxSpu5X8MnF/+wQBbrAKNCpJW/KYa3RTVNdUCPDreXm
        eXsPvj/6KL/F6q8Q0rrBFNWrCr8VxSY4taIg3tqe/hzCTW3OTtexFfCjslQP/k4qYAB8oSEwV+k4D
        P7Kr/r0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qUUnT-0027kW-0A; Fri, 11 Aug 2023 16:15:31 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH 1/3] buffer: Pass GFP flags to folio_alloc_buffers()
Date:   Fri, 11 Aug 2023 17:15:26 +0100
Message-Id: <20230811161528.506437-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230811161528.506437-1-willy@infradead.org>
References: <20230811161528.506437-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of creating entirely new flags, inherit them from grow_dev_page().
The other callers create the same flags that this function used to create.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c                 | 17 +++++++++--------
 include/linux/buffer_head.h |  2 +-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..7326acc29541 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -920,16 +920,12 @@ int remove_inode_buffers(struct inode *inode)
  * which may not fail from ordinary buffer allocations.
  */
 struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
-					bool retry)
+					gfp_t gfp)
 {
 	struct buffer_head *bh, *head;
-	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
 	long offset;
 	struct mem_cgroup *memcg, *old_memcg;
 
-	if (retry)
-		gfp |= __GFP_NOFAIL;
-
 	/* The folio lock pins the memcg */
 	memcg = folio_memcg(folio);
 	old_memcg = set_active_memcg(memcg);
@@ -972,7 +968,11 @@ EXPORT_SYMBOL_GPL(folio_alloc_buffers);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 				       bool retry)
 {
-	return folio_alloc_buffers(page_folio(page), size, retry);
+	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
+	if (retry)
+		gfp |= __GFP_NOFAIL;
+
+	return folio_alloc_buffers(page_folio(page), size, gfp);
 }
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
@@ -1074,7 +1074,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 			goto failed;
 	}
 
-	bh = folio_alloc_buffers(folio, size, true);
+	bh = folio_alloc_buffers(folio, size, gfp_mask);
 
 	/*
 	 * Link the folio to the buffers and initialise them.  Take the
@@ -1665,8 +1665,9 @@ void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
 				unsigned long b_state)
 {
 	struct buffer_head *bh, *head, *tail;
+	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT | __GFP_NOFAIL;
 
-	head = folio_alloc_buffers(folio, blocksize, true);
+	head = folio_alloc_buffers(folio, blocksize, gfp);
 	bh = head;
 	do {
 		bh->b_state |= b_state;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6cb3e9af78c9..d17efb8b7976 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -200,7 +200,7 @@ void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset);
 bool try_to_free_buffers(struct folio *);
 struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
-					bool retry);
+					gfp_t gfp);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
-- 
2.40.1

