Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393D867D634
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjAZUYe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbjAZUYY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75013227B3;
        Thu, 26 Jan 2023 12:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=/Ja8vadzBHz2ZdVgW/VI/XY3kcR3lQVt/q1ut0HAdJ8=; b=lTxGnXtC9ti2GmfcgvIMYNtydW
        tADZSr8URUvI49/Lu5qMB99gV/06m+dUgvDt/nYQqp+bkLnDQDZIROt+mKr3IArZ3I/Fmc9T1eSuI
        2hmKqeer5eI/rjYuFUW8qE7XZri6qKtqWMwQ5c2MX5JCSgysOzGSvlfUzDexoF7JBHkpXi3RzwwQZ
        MBsoiTSu+yEqWZi+h9QTrUSkUjF7EfojVjXrnN9NDWPTVt/IJElElhxRl09wtkLS30KECEgQ1ost/
        dlh/ysYOgsIzcUQ7TmwjgBwb4TSuvGc4cOuyC6tecSOWNPNKiAH2pysIn+GAncfkUsv0QMyHwaiOX
        asY9SRCg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nE-0073kh-Gj; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/31] ext4: Convert ext4_journalled_zero_new_buffers() to use a folio
Date:   Thu, 26 Jan 2023 20:24:03 +0000
Message-Id: <20230126202415.1682629-20-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230126202415.1682629-1-willy@infradead.org>
References: <20230126202415.1682629-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index 4f43d7434965..b79e591b7c8e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1376,24 +1376,24 @@ static int ext4_write_end(struct file *file,
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
@@ -1430,10 +1430,11 @@ static int ext4_journalled_write_end(struct file *file,
 
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
2.35.1

