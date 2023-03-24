Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8BA6C843E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 19:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjCXSDA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 14:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCXSCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:02:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A2A1DBB0;
        Fri, 24 Mar 2023 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=38asVv3di4Eft0TAyxJHVa3D6XL7ozd7QdZLvOUUQPQ=; b=MCzLqm8Bi1/gBR9b43pRGbgI0O
        OE1lIt+d0kWYQYTapxGZz/4joRuHDieJxBx0q4+NjosQJ6JY16gPN3lumrTeJbxE/kGqZYgOMdqZL
        TKhcOpOaX5LUJ/5mkfNE3MIf804nUMHu/MqS7K+kYs9jSmrGt6SFQS6i5UisHcF5gOmUJPo8cgC2j
        XbgtL8GhkfH1YwcFzL3kXZeQLSIdemhLvt7wGEh6/4aaXLpjZslDjPevwCtGYYycWMsGqIsY54SpY
        NDWKsSnTGEjOvY7sDyvJSKbH4OvqmgRpE5TyKCDavHdHGXUeqIN27bIwYkHPmSBwwpaxbVeafUVJH
        SL/QwKbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pfljM-0057aK-V3; Fri, 24 Mar 2023 18:01:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 18/29] ext4: Use a folio in ext4_journalled_write_end()
Date:   Fri, 24 Mar 2023 18:01:18 +0000
Message-Id: <20230324180129.1220691-19-willy@infradead.org>
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

Convert the incoming page to a folio to remove a few calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inode.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index af2bfabfbd27..172b4ca43981 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1392,6 +1392,7 @@ static int ext4_journalled_write_end(struct file *file,
 				     loff_t pos, unsigned len, unsigned copied,
 				     struct page *page, void *fsdata)
 {
+	struct folio *folio = page_folio(page);
 	handle_t *handle = ext4_journal_current_handle();
 	struct inode *inode = mapping->host;
 	loff_t old_size = inode->i_size;
@@ -1410,25 +1411,26 @@ static int ext4_journalled_write_end(struct file *file,
 	if (ext4_has_inline_data(inode))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
-	if (unlikely(copied < len) && !PageUptodate(page)) {
+	if (unlikely(copied < len) && !folio_test_uptodate(folio)) {
 		copied = 0;
 		ext4_journalled_zero_new_buffers(handle, inode, page, from, to);
 	} else {
 		if (unlikely(copied < len))
 			ext4_journalled_zero_new_buffers(handle, inode, page,
 							 from + copied, to);
-		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
+		ret = ext4_walk_page_buffers(handle, inode,
+					     folio_buffers(folio),
 					     from, from + copied, &partial,
 					     write_end_fn);
 		if (!partial)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 	}
 	if (!verity)
 		size_changed = ext4_update_inode_size(inode, pos + copied);
 	ext4_set_inode_state(inode, EXT4_STATE_JDATA);
 	EXT4_I(inode)->i_datasync_tid = handle->h_transaction->t_tid;
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	if (old_size < pos && !verity)
 		pagecache_isize_extended(inode, old_size, pos);
-- 
2.39.2

