Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09277A0852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Sep 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbjINPAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjINPAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:00:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D681FD4;
        Thu, 14 Sep 2023 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gnp4zYg/dh0OPQ0vZTxju98qMfcg0ybl9RK8Nl8ZMaA=; b=f9EJx7cQZC7GvKHXj5JPLmpgIX
        cwcZWHRx9Uw13HXnNkeq3Tt5XH567W8MjrNAZBHyxG7oYaHCAN2UhkAkUKoaGGPNu3qin9vbirUWd
        E9L78YD4zE5ejTtNQBaIxdoffp9PREV03O1+vYn+b/8tKJHVg/B8uEKwlBwptcoc6+y3kLfq51mVd
        PcsELXb5SxaDuNmhtOGSLNG+uK3B+vipNueG7U23w7qzBozJIZ+pmZ1CipkTkp11FnEYe0XPtTn/0
        Zti6dCzvWx4d8hcvM3Gq7TinP1qLy8h8HPp0iehHAOwUmOVTHEHwi7ESebSrVdvulJEMKrXkv6tr6
        SsXfaC8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qgnpF-003XOK-Mu; Thu, 14 Sep 2023 15:00:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     akpm@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Hui Zhu <teawater@antgroup.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: [PATCH v2 1/8] buffer: Pass GFP flags to folio_alloc_buffers()
Date:   Thu, 14 Sep 2023 16:00:04 +0100
Message-Id: <20230914150011.843330-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230914150011.843330-1-willy@infradead.org>
References: <20230914150011.843330-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2379564e5aea..a01b00d48de2 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -915,16 +915,12 @@ int remove_inode_buffers(struct inode *inode)
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
@@ -967,7 +963,11 @@ EXPORT_SYMBOL_GPL(folio_alloc_buffers);
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
 
@@ -1069,7 +1069,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 			goto failed;
 	}
 
-	bh = folio_alloc_buffers(folio, size, true);
+	bh = folio_alloc_buffers(folio, size, gfp_mask | __GFP_ACCOUNT);
 
 	/*
 	 * Link the folio to the buffers and initialise them.  Take the
@@ -1644,8 +1644,9 @@ void folio_create_empty_buffers(struct folio *folio, unsigned long blocksize,
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
index 4ede47649a81..79131e9941e7 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -195,7 +195,7 @@ void touch_buffer(struct buffer_head *bh);
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset);
 struct buffer_head *folio_alloc_buffers(struct folio *folio, unsigned long size,
-					bool retry);
+					gfp_t gfp);
 struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		bool retry);
 void create_empty_buffers(struct page *, unsigned long,
-- 
2.40.1

