Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09133722CFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 18:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjFEQuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbjFEQui (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:50:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EAB123
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 09:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=p/LjSwLBCR6T07jlUXyD9dDJ8ioTDJhWZ6Y1cFLG9iY=; b=QohFDthQBiIITP+QTD/j2mdKl7
        oggCWQH4FYbbHbz0maY3PoETDai6nwMeXsLh3I1mwzfmzmljtGDJLAmDDdiXNs3sxhduAO6nU2IOT
        RkadT/+w+cMO6zziGv/CnXiQQLWh/I2VezTCGKEISs5ni4op+IDz+c2dREbl9iM4s9ujnxYjWD4ts
        5NvBnlvbczNnArG16306/1VC8XXFg+nKqYsm5akICvnptMknDkN83W01Dk6aeVb1wbReA3etSWykj
        UqJs4G7StB8twBeqyi59HU8hzRoSfQQBplg9dIVR6t3PR+ZqT2SVSY06djYBzEZSMPV/tOH5hIcqz
        y4LXsygQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q6DPa-00CCat-L0; Mon, 05 Jun 2023 16:50:30 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] ubifs: Convert ubifs_writepage to use a folio
Date:   Mon,  5 Jun 2023 17:50:27 +0100
Message-Id: <20230605165029.2908304-3-willy@infradead.org>
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

We still pass the page down to do_writepage(), but ubifs_writepage()
itself is now large folio safe.  It also contains far fewer hidden calls
to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ubifs/file.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 8bb4cb9d528f..1c7a99c36906 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1006,21 +1006,18 @@ static int do_writepage(struct page *page, int len)
 static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 		void *data)
 {
-	struct page *page = &folio->page;
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	loff_t i_size =  i_size_read(inode), synced_i_size;
-	pgoff_t end_index = i_size >> PAGE_SHIFT;
-	int err, len = i_size & (PAGE_SIZE - 1);
-	void *kaddr;
+	int err, len = folio_size(folio);
 
 	dbg_gen("ino %lu, pg %lu, pg flags %#lx",
-		inode->i_ino, page->index, page->flags);
-	ubifs_assert(c, PagePrivate(page));
+		inode->i_ino, folio->index, folio->flags);
+	ubifs_assert(c, folio->private != NULL);
 
-	/* Is the page fully outside @i_size? (truncate in progress) */
-	if (page->index > end_index || (page->index == end_index && !len)) {
+	/* Is the folio fully outside @i_size? (truncate in progress) */
+	if (folio_pos(folio) >= i_size) {
 		err = 0;
 		goto out_unlock;
 	}
@@ -1029,9 +1026,9 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 	synced_i_size = ui->synced_i_size;
 	spin_unlock(&ui->ui_lock);
 
-	/* Is the page fully inside @i_size? */
-	if (page->index < end_index) {
-		if (page->index >= synced_i_size >> PAGE_SHIFT) {
+	/* Is the folio fully inside i_size? */
+	if (folio_pos(folio) + len < i_size) {
+		if (folio_pos(folio) >= synced_i_size) {
 			err = inode->i_sb->s_op->write_inode(inode, NULL);
 			if (err)
 				goto out_redirty;
@@ -1044,20 +1041,18 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 			 * with this.
 			 */
 		}
-		return do_writepage(page, PAGE_SIZE);
+		return do_writepage(&folio->page, len);
 	}
 
 	/*
-	 * The page straddles @i_size. It must be zeroed out on each and every
+	 * The folio straddles @i_size. It must be zeroed out on each and every
 	 * writepage invocation because it may be mmapped. "A file is mapped
 	 * in multiples of the page size. For a file that is not a multiple of
 	 * the page size, the remaining memory is zeroed when mapped, and
 	 * writes to that region are not written out to the file."
 	 */
-	kaddr = kmap_atomic(page);
-	memset(kaddr + len, 0, PAGE_SIZE - len);
-	flush_dcache_page(page);
-	kunmap_atomic(kaddr);
+	folio_zero_segment(folio, offset_in_folio(folio, i_size), len);
+	len = offset_in_folio(folio, i_size);
 
 	if (i_size > synced_i_size) {
 		err = inode->i_sb->s_op->write_inode(inode, NULL);
@@ -1065,16 +1060,16 @@ static int ubifs_writepage(struct folio *folio, struct writeback_control *wbc,
 			goto out_redirty;
 	}
 
-	return do_writepage(page, len);
+	return do_writepage(&folio->page, len);
 out_redirty:
 	/*
-	 * redirty_page_for_writepage() won't call ubifs_dirty_inode() because
+	 * folio_redirty_for_writepage() won't call ubifs_dirty_inode() because
 	 * it passes I_DIRTY_PAGES flag while calling __mark_inode_dirty(), so
 	 * there is no need to do space budget for dirty inode.
 	 */
-	redirty_page_for_writepage(wbc, page);
+	folio_redirty_for_writepage(wbc, folio);
 out_unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return err;
 }
 
-- 
2.39.2

