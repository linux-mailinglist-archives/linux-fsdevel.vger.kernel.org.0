Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE6E6C844E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCXSD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCXSCV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48D41CBF6;
        Fri, 24 Mar 2023 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Xw2QcaDbs9FD/LXdlXsrVQbL81H3GOPupeRYBB+hCYI=; b=JU327FMY5i+zpq1XrUT8OwRFLi
        Z6JJGjHdaD4tlGBwyFgZHdA1rP7i4xBIpgz5bECuMiDoxe9csuEhUTdROd2Kr1/dAbgWy0CtLLB4i
        ok3LPqXKblSaFWP1sQ/0q8L6cE2wzFxkN9yhRCRt14ly1IRM2oA383Pyg7Rl8xDoNQnMtPNJ6nfPS
        WQuSRwCXdZNm/VxNJ0llFAdO80zRAUihia9VqdB5p1kEihDDQG5cAua7MtBnxnSbA8DO0tgE1ma/q
        dr62HTLBZ6pbSNSnV6AObteSo7b5TCdEvvk9ysxr+DDwT2M07OoKp0HwNOZ5v2FGi/w/bXDM0Y1mV
        K1SZck0A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljN-0057aQ-Bz; Fri, 24 Mar 2023 18:01:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 19/29] ext4: Convert ext4_journalled_zero_new_buffers() to use a folio
Date:   Fri, 24 Mar 2023 18:01:19 +0000
Message-Id: <20230324180129.1220691-20-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230324180129.1220691-1-willy@infradead.org>
References: <20230324180129.1220691-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove a call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 172b4ca43981..92418efe1afe 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1359,24 +1359,24 @@ static int ext4_write_end(struct file *file,
  */
 static void ext4_journalled_zero_new_buffers(handle_t *handle,
 					    struct inode *inode,
-					    struct page *page,
+					    struct folio *folio,
 					    unsigned from, unsigned to)
 {
 	unsigned int block_start = 0, block_end;
 	struct buffer_head *head, *bh;
 
-	bh = head = page_buffers(page);
+	bh = head = folio_buffers(folio);
 	do {
 		block_end = block_start + bh->b_size;
 		if (buffer_new(bh)) {
 			if (block_end > from && block_start < to) {
-				if (!PageUptodate(page)) {
+				if (!folio_test_uptodate(folio)) {
 					unsigned start, size;
 
 					start = max(from, block_start);
 					size = min(to, block_end) - start;
 
-					zero_user(page, start, size);
+					folio_zero_range(folio, start, size);
 					write_end_fn(handle, inode, bh);
 				}
 				clear_buffer_new(bh);
@@ -1413,10 +1413,11 @@ static int ext4_journalled_write_end(struct file *file,
 
 	if (unlikely(copied < len) && !folio_test_uptodate(folio)) {
 		copied = 0;
-		ext4_journalled_zero_new_buffers(handle, inode, page, from, to);
+		ext4_journalled_zero_new_buffers(handle, inode, folio,
+						 from, to);
 	} else {
 		if (unlikely(copied < len))
-			ext4_journalled_zero_new_buffers(handle, inode, page,
+			ext4_journalled_zero_new_buffers(handle, inode, folio,
 							 from + copied, to);
 		ret = ext4_walk_page_buffers(handle, inode,
 					     folio_buffers(folio),
-- 
2.39.2

