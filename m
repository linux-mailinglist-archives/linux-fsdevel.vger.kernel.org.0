Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C94250B1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 23:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgHXVss (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 17:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXVss (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:48:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD6C061574;
        Mon, 24 Aug 2020 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DBR5Fp4FeMLTXbHKHs/oT7OXQ2LJWa8ts52qpCNQqq0=; b=WeGEh6d1ORkwoAM1hC8njVK2wf
        mH1I2kwXEzglmzZ+gMpy5JZFSRsVVYeT1ii0no5STYlh/bD3fwK0QzP9ect+nLrb9OK6nXAp5PUi5
        R6HxJwiligukjP3KHds+Ccuec3uV7boGPG3wY2lNmKlcXaCvh3pe1VHgTHoKLXpAvtMFZR3MJ0NQD
        75RavrHPVaeua9hSfLU2H2j83Q/suoMB5DkM83fTaeRfkPXJfDM72gH8NjVbK9oiZU97oyKlTSCE1
        svWoxHi64X3crotSmrHAQSXI8hn/4Fik5Up8R0Ql+tTnU8UX7BpiVxPx+Ib68kE5ceWQdya7DJKf8
        iF8bdU+A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAKKY-0004T5-Dl; Mon, 24 Aug 2020 21:48:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: Simplify SEEK_DATA implementation
Date:   Mon, 24 Aug 2020 22:48:41 +0100
Message-Id: <20200824214841.17132-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of finding the first dirty page and then seeing if it matches
the index of a block that is NEW_ADDR, delay the lookup of the dirty
bit until we've actually found a block that's NEW_ADDR.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/file.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8a422400e824..14f478871698 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -376,32 +376,15 @@ int f2fs_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	return f2fs_do_sync_file(file, start, end, datasync, false);
 }
 
-static pgoff_t __get_first_dirty_index(struct address_space *mapping,
-						pgoff_t pgofs, int whence)
-{
-	struct page *page;
-	int nr_pages;
-
-	if (whence != SEEK_DATA)
-		return 0;
-
-	/* find first dirty page index */
-	nr_pages = find_get_pages_tag(mapping, &pgofs, PAGECACHE_TAG_DIRTY,
-				      1, &page);
-	if (!nr_pages)
-		return ULONG_MAX;
-	pgofs = page->index;
-	put_page(page);
-	return pgofs;
-}
-
-static bool __found_offset(struct f2fs_sb_info *sbi, block_t blkaddr,
-				pgoff_t dirty, pgoff_t pgofs, int whence)
+static bool __found_offset(struct address_space *mapping, block_t blkaddr,
+				pgoff_t index, int whence)
 {
 	switch (whence) {
 	case SEEK_DATA:
-		if ((blkaddr == NEW_ADDR && dirty == pgofs) ||
-			__is_valid_data_blkaddr(blkaddr))
+		if (__is_valid_data_blkaddr(blkaddr))
+			return true;
+		if (blkaddr == NEW_ADDR &&
+		    xa_get_mark(&mapping->i_pages, index, PAGECACHE_TAG_DIRTY))
 			return true;
 		break;
 	case SEEK_HOLE:
@@ -417,7 +400,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 	struct inode *inode = file->f_mapping->host;
 	loff_t maxbytes = inode->i_sb->s_maxbytes;
 	struct dnode_of_data dn;
-	pgoff_t pgofs, end_offset, dirty;
+	pgoff_t pgofs, end_offset;
 	loff_t data_ofs = offset;
 	loff_t isize;
 	int err = 0;
@@ -437,8 +420,6 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 
 	pgofs = (pgoff_t)(offset >> PAGE_SHIFT);
 
-	dirty = __get_first_dirty_index(inode->i_mapping, pgofs, whence);
-
 	for (; data_ofs < isize; data_ofs = (loff_t)pgofs << PAGE_SHIFT) {
 		set_new_dnode(&dn, inode, NULL, NULL, 0);
 		err = f2fs_get_dnode_of_data(&dn, pgofs, LOOKUP_NODE);
@@ -471,7 +452,7 @@ static loff_t f2fs_seek_block(struct file *file, loff_t offset, int whence)
 				goto fail;
 			}
 
-			if (__found_offset(F2FS_I_SB(inode), blkaddr, dirty,
+			if (__found_offset(file->f_mapping, blkaddr,
 							pgofs, whence)) {
 				f2fs_put_dnode(&dn);
 				goto found;
-- 
2.28.0

