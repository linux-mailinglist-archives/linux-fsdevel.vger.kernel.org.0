Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4F722CF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjFEQur (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjFEQui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8F5127
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0GfcmAeBg6k/hBFcZUxOxfy66QSCNXE92UiLhBOz854=; b=a28EKsM+ya2npBgk2g9nKLGf9n
        03xF44Q1Cm2s/BAE5mVqrV0VW1EPD/wrfBf//JfP2DxPMtG59bYtAW2hyx18tKScXI+uFDd93uV/C
        BMOPcSdbJ/64i1+KeD2kQYvqa+GcGOz7QMWeSMKnkavrXiRIwQCf7yNazr9ZKr1tnR+eo4uy9HA16
        dCbeMMWBCD/Zi5Tab+7evUyIlF36gTJzFbimbByHm2QoK1PxZlQTxxdeoj4wtSe9wMGI0uCX1Hd7J
        5Vy/6cwd1xcGyls8AIJ5+CWMNovFRkbZtZ+liai92SgRClv8FNWsyB9vEI3LuHpKfsW/V4ZxgcU9G
        Dvksdunw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DPa-00CCb3-Sq; Mon, 05 Jun 2023 16:50:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] ubifs: Convert do_writepage() to take a folio
Date:   Mon,  5 Jun 2023 17:50:29 +0100
Message-Id: <20230605165029.2908304-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230605165029.2908304-1-willy@infradead.org>
References: <20230605165029.2908304-1-willy@infradead.org>
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

Replace the call to SetPageError() with a call to mapping_set_error().
Support large folios by using kmap_local_folio() and remapping each time
we cross a page boundary.  Saves a lot of hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 53 +++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index c0e68b3d7582..1b2055d5ec5f 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -900,60 +900,65 @@ static int ubifs_read_folio(struct file *file, struct folio *folio)
 	return 0;
 }
 
-static int do_writepage(struct page *page, int len)
+static int do_writepage(struct folio *folio, size_t len)
 {
 	int err = 0, i, blen;
 	unsigned int block;
 	void *addr;
+	size_t offset = 0;
 	union ubifs_key key;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
 #ifdef UBIFS_DEBUG
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	spin_lock(&ui->ui_lock);
-	ubifs_assert(c, page->index <= ui->synced_i_size >> PAGE_SHIFT);
+	ubifs_assert(c, folio->index <= ui->synced_i_size >> PAGE_SHIFT);
 	spin_unlock(&ui->ui_lock);
 #endif
 
-	/* Update radix tree tags */
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 
-	addr = kmap(page);
-	block = page->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
+	addr = kmap_local_folio(folio, offset);
+	block = folio->index << UBIFS_BLOCKS_PER_PAGE_SHIFT;
 	i = 0;
-	while (len) {
-		blen = min_t(int, len, UBIFS_BLOCK_SIZE);
+	for (;;) {
+		blen = min_t(size_t, len, UBIFS_BLOCK_SIZE);
 		data_key_init(c, &key, inode->i_ino, block);
 		err = ubifs_jnl_write_data(c, inode, &key, addr, blen);
 		if (err)
 			break;
-		if (++i >= UBIFS_BLOCKS_PER_PAGE)
+		len -= blen;
+		if (!len)
 			break;
 		block += 1;
 		addr += blen;
-		len -= blen;
+		if (folio_test_highmem(folio) && !offset_in_page(addr)) {
+			kunmap_local(addr - blen);
+			offset += PAGE_SIZE;
+			addr = kmap_local_folio(folio, offset);
+		}
 	}
+	kunmap_local(addr);
 	if (err) {
-		SetPageError(page);
-		ubifs_err(c, "cannot write page %lu of inode %lu, error %d",
-			  page->index, inode->i_ino, err);
+		mapping_set_error(folio->mapping, err);
+		ubifs_err(c, "cannot write folio %lu of inode %lu, error %d",
+			  folio->index, inode->i_ino, err);
 		ubifs_ro_mode(c, err);
 	}
 
-	ubifs_assert(c, PagePrivate(page));
-	if (PageChecked(page))
+	ubifs_assert(c, folio->private != NULL);
+	if (folio_test_checked(folio))
 		release_new_page_budget(c);
 	else
 		release_existing_page_budget(c);
 
 	atomic_long_dec(&c->dirty_pg_cnt);
-	detach_page_private(page);
-	ClearPageChecked(page);
+	folio_detach_private(folio);
+	folio_clear_checked(folio);
 
-	kunmap(page);
-	unlock_page(page);
-	end_page_writeback(page);
+	folio_unlock(folio);
+	folio_end_writeback(folio);
 	return err;
 }
 
@@ -1041,7 +1046,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 			 * with this.
 			 */
 		}
-		return do_writepage(&folio->page, len);
+		return do_writepage(folio, len);
 	}
 
 	/*
@@ -1060,7 +1065,7 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 			goto out_redirty;
 	}
 
-	return do_writepage(&folio->page, len);
+	return do_writepage(folio, len);
 out_redirty:
 	/*
 	 * folio_redirty_for_writepage() won't call ubifs_dirty_inode() because
@@ -1172,7 +1177,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
 				if (UBIFS_BLOCKS_PER_PAGE_SHIFT)
 					offset = offset_in_folio(folio,
 							new_size);
-				err = do_writepage(&folio->page, offset);
+				err = do_writepage(folio, offset);
 				folio_put(folio);
 				if (err)
 					goto out_budg;
-- 
2.39.2

