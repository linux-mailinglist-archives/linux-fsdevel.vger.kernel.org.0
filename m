Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E45D6C845C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjCXSDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjCXSCZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274D81A64F;
        Fri, 24 Mar 2023 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=t+wvSi/YBrRGPLw0i7IYXYaNsx3M/0RgcY21ktDo5Zg=; b=jKL5GRzcWAc72WFlti0jCKM6Th
        tfho/VzzwqHDwKeC0VlLEvrP/pCcaaJ8YrpYaSyJQ1oBGYlCxJGwdbgUcjjEaK9kPLh9GID9jaQ3q
        H/rwY8+C4WHiAJDOMHQDnvuBYyicttXcs7anKzwPJFJTS5Ja+xFB9VPPzKTGzJRJvfVCqtWevripe
        +BT7ypbVK4Ex6i0pHIXYCIsY0KvZ7DBONFXRjwMvar5JPpjVOHGMwxNzL5PPH44OeRiTQge0erR0q
        WLXKmjj8bv1CSWGSWQm6x4ZpJNEDVnietA03JPxwEDKgMnbWtmXObURLGAcxrEpJGsR7be40W4/4m
        SW1wNMUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057a2-IF; Fri, 24 Mar 2023 18:01:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/29] ext4: Convert ext4_write_inline_data_end() to use a folio
Date:   Fri, 24 Mar 2023 18:01:15 +0000
Message-Id: <20230324180129.1220691-16-willy@infradead.org>
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

Convert the incoming page to a folio so that we call compound_head()
only once instead of seven times.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 4c819b6c70c1..b9fb1177fff6 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -732,20 +732,21 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 			       unsigned copied, struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	int no_expand;
 	void *kaddr;
 	struct ext4_iloc iloc;
 	int ret = 0, ret2;
 
-	if (unlikely(copied < len) && !PageUptodate(page))
+	if (unlikely(copied < len) && !folio_test_uptodate(folio))
 		copied = 0;
 
 	if (likely(copied)) {
 		ret = ext4_get_inode_loc(inode, &iloc);
 		if (ret) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			ext4_std_error(inode->i_sb, ret);
 			goto out;
 		}
@@ -759,30 +760,30 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 		 */
 		(void) ext4_find_inline_data_nolock(inode);
 
-		kaddr = kmap_atomic(page);
+		kaddr = kmap_local_folio(folio, 0);
 		ext4_write_inline_data(inode, &iloc, kaddr, pos, copied);
-		kunmap_atomic(kaddr);
-		SetPageUptodate(page);
-		/* clear page dirty so that writepages wouldn't work for us. */
-		ClearPageDirty(page);
+		kunmap_local(kaddr);
+		folio_mark_uptodate(folio);
+		/* clear dirty flag so that writepages wouldn't work for us. */
+		folio_clear_dirty(folio);
 
 		ext4_write_unlock_xattr(inode, &no_expand);
 		brelse(iloc.bh);
 
 		/*
-		 * It's important to update i_size while still holding page
+		 * It's important to update i_size while still holding folio
 		 * lock: page writeout could otherwise come in and zero
 		 * beyond i_size.
 		 */
 		ext4_update_inode_size(inode, pos + copied);
 	}
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	/*
-	 * Don't mark the inode dirty under page lock. First, it unnecessarily
-	 * makes the holding time of page lock longer. Second, it forces lock
-	 * ordering of page lock and transaction start for journaling
+	 * Don't mark the inode dirty under folio lock. First, it unnecessarily
+	 * makes the holding time of folio lock longer. Second, it forces lock
+	 * ordering of folio lock and transaction start for journaling
 	 * filesystems.
 	 */
 	if (likely(copied))
-- 
2.39.2

