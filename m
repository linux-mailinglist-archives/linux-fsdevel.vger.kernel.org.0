Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD69567D627
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbjAZUY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:24:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbjAZUYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D154B19D;
        Thu, 26 Jan 2023 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DVlcNZBut+DtNK9F+iP982TEiyv3KpnKHUgwVzUcsfQ=; b=PAOlf7iZiNIxrW59v6BYibTJz5
        R2fba8d66xrSs62DEfSWsjg/f6QN1+FGuOcDHwFkeJ9D2YuGZyxZe1VqH1giu9EJSfVlzEM23feK2
        bbKuVxW06qaLGq6b1Kd9Ed4sf7rCqa3AnHZw6j342Ai/ZaI0WOweepcJwm28LcCUCutJ5A9cqw57u
        2Q3ZBJbjkG/o7tJ4u+fDhf/KmffqTjRjfbS0bTC9nr4KQrv3+Zdn0tuI+uxG9DTd4q+by/WI0BtpT
        V2nlSLuOKGZk6KkUlLh8ljIWB3kEv832QaWXB0AnmFLBODQcNaCN1Bdrfd9QGU+nEB4T3Wrro+q37
        XmZ3wJug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nD-0073kH-VM; Thu, 26 Jan 2023 20:24:20 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/31] ext4: Convert ext4_write_inline_data_end() to use a folio
Date:   Thu, 26 Jan 2023 20:23:59 +0000
Message-Id: <20230126202415.1682629-16-willy@infradead.org>
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

Convert the incoming page to a folio so that we call compound_head()
only once instead of seven times.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inline.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 29294caa20a1..a06dd4f0d17b 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -733,20 +733,21 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
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
@@ -760,30 +761,30 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
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
2.35.1

