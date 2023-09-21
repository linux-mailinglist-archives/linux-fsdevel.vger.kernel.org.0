Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5C7A9FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 22:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjIUU2o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 16:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjIUU2V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:28:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F6659D;
        Thu, 21 Sep 2023 13:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=sOagZNuf5a1AJuwVUYKOAYZ0jbYyZkDR5exYYeeQdZg=; b=qhUuPhLgO1AQC/FRuI8FDpalpa
        6+IRwXybfxE/U3BYnVUngAMdIhjgiVf7/6P/Fr3DbZiEBShREgJLlb3bGcy+n9LDvFJ/4JlDN9Aib
        yF7SHkBwOv1WBq0amITgy44JLwhX4tznPvdn06ByeKFqS5XDsWG7ImAb4UDe6pqZBRWDn6plYi5kg
        Pu88DODgFJg2Ksxznpkq5txxHnjVyNCAiWQgcSHTD2Vd3hqE8c/QAZe3d73hXO1g7pfJLdMjaZBRl
        aWexwUnI0s+UWnQbJatRBsGMNHzSzqH81Z1yvfsdIr9V/E8Ypr1JZT8+gXG36yDZOEaf9bQJ4L7ky
        f6mKqP+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qjPxk-00DrVt-3z; Thu, 21 Sep 2023 20:07:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 07/10] ext2: Handle large block size directories in ext2_delete_entry()
Date:   Thu, 21 Sep 2023 21:07:44 +0100
Message-Id: <20230921200746.3303942-7-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230921200746.3303942-1-willy@infradead.org>
References: <20230921200746.3303942-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the block size is > PAGE_SIZE, we need to calculate these offsets
relative to the start of the folio, not the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/dir.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index 2fc910e99234..7e75cfaa709c 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -586,16 +586,20 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
  */
 int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
 {
-	struct inode *inode = page->mapping->host;
-	char *kaddr = (char *)((unsigned long)dir & PAGE_MASK);
-	unsigned from = offset_in_page(dir) & ~(ext2_chunk_size(inode)-1);
-	unsigned to = offset_in_page(dir) +
-				ext2_rec_len_from_disk(dir->rec_len);
+	struct folio *folio = page_folio(page);
+	struct inode *inode = folio->mapping->host;
+	size_t from, to;
+	char *kaddr;
 	loff_t pos;
-	ext2_dirent *pde = NULL;
-	ext2_dirent *de = (ext2_dirent *)(kaddr + from);
+	ext2_dirent *de, *pde = NULL;
 	int err;
 
+	from = offset_in_folio(folio, dir);
+	to = from + ext2_rec_len_from_disk(dir->rec_len);
+	kaddr = (char *)dir - from;
+	from &= ~(ext2_chunk_size(inode)-1);
+	de = (ext2_dirent *)(kaddr + from);
+
 	while ((char*)de < (char*)dir) {
 		if (de->rec_len == 0) {
 			ext2_error(inode->i_sb, __func__,
@@ -606,18 +610,18 @@ int ext2_delete_entry(struct ext2_dir_entry_2 *dir, struct page *page)
 		de = ext2_next_entry(de);
 	}
 	if (pde)
-		from = offset_in_page(pde);
-	pos = page_offset(page) + from;
-	lock_page(page);
-	err = ext2_prepare_chunk(page, pos, to - from);
+		from = offset_in_folio(folio, pde);
+	pos = folio_pos(folio) + from;
+	folio_lock(folio);
+	err = ext2_prepare_chunk(&folio->page, pos, to - from);
 	if (err) {
-		unlock_page(page);
+		folio_unlock(folio);
 		return err;
 	}
 	if (pde)
 		pde->rec_len = ext2_rec_len_to_disk(to - from);
 	dir->inode = 0;
-	ext2_commit_chunk(page, pos, to - from);
+	ext2_commit_chunk(&folio->page, pos, to - from);
 	inode->i_mtime = inode_set_ctime_current(inode);
 	EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL;
 	mark_inode_dirty(inode);
-- 
2.40.1

