Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A005A67D65D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjAZUZt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjAZUYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:55 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8A5728ED;
        Thu, 26 Jan 2023 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6nWGi4oOmhc7aGpc2yEDO3lz/Me2HXzFePEcirx6YtI=; b=CxVl80kA21lvOFu1Hj125JMKiP
        wYNNTNaeeJ/q6X1aRe9Dwdw81zNTD3eGJEzYnEpc9O3sAw4HJugtuJLEOgXttaslJ79a/zQUA3OUq
        1Uk/3KPr+OKBW7RycbiJLbWK3t+TPw5Jm6cDlchnmgNGPnXWrmPaclQB+fkxwhI+Mj5F4XA2WLZF2
        xcxLoz/IS9LHmci0gciNMzohWUk60B4dHdxwCRN836GmOTh18f60C37DOHnlzzmXh5A9sJ4PI8R+g
        KxXlkKK2cRbAtfoOsyHZ6f2UxaK2BW1HH41BADzY1c2mHKuI4wPQgvT7LEzMCDJMvkH/JspwWlrkW
        7ZtYK9JQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073jc-8H; Thu, 26 Jan 2023 20:24:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/31] ext4: Convert ext4_readpage_inline() to take a folio
Date:   Thu, 26 Jan 2023 20:23:53 +0000
Message-Id: <20230126202415.1682629-10-willy@infradead.org>
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

Use the folio API in this function, saves a few calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/ext4.h   |  2 +-
 fs/ext4/inline.c | 14 +++++++-------
 fs/ext4/inode.c  |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 7a132e8648f4..d2998800855c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3549,7 +3549,7 @@ extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
 				 unsigned int len);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
 
-extern int ext4_readpage_inline(struct inode *inode, struct page *page);
+int ext4_readpage_inline(struct inode *inode, struct folio *folio);
 extern int ext4_try_to_write_inline_data(struct address_space *mapping,
 					 struct inode *inode,
 					 loff_t pos, unsigned len,
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2b42ececa46d..38f6282cc012 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -502,7 +502,7 @@ static int ext4_read_inline_page(struct inode *inode, struct page *page)
 	return ret;
 }
 
-int ext4_readpage_inline(struct inode *inode, struct page *page)
+int ext4_readpage_inline(struct inode *inode, struct folio *folio)
 {
 	int ret = 0;
 
@@ -516,16 +516,16 @@ int ext4_readpage_inline(struct inode *inode, struct page *page)
 	 * Current inline data can only exist in the 1st page,
 	 * So for all the other pages, just set them uptodate.
 	 */
-	if (!page->index)
-		ret = ext4_read_inline_page(inode, page);
-	else if (!PageUptodate(page)) {
-		zero_user_segment(page, 0, PAGE_SIZE);
-		SetPageUptodate(page);
+	if (!folio->index)
+		ret = ext4_read_inline_page(inode, &folio->page);
+	else if (!folio_test_uptodate(folio)) {
+		folio_zero_segment(folio, 0, PAGE_SIZE);
+		folio_mark_uptodate(folio);
 	}
 
 	up_read(&EXT4_I(inode)->xattr_sem);
 
-	unlock_page(page);
+	folio_unlock(folio);
 	return ret >= 0 ? 0 : ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fcd904123384..c627686295e0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3300,7 +3300,7 @@ static int ext4_read_folio(struct file *file, struct folio *folio)
 	trace_ext4_readpage(page);
 
 	if (ext4_has_inline_data(inode))
-		ret = ext4_readpage_inline(inode, page);
+		ret = ext4_readpage_inline(inode, folio);
 
 	if (ret == -EAGAIN)
 		return ext4_mpage_readpages(inode, NULL, page);
-- 
2.35.1

