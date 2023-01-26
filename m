Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD63767D657
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jan 2023 21:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAZUZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Jan 2023 15:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjAZUYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:24:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51E45CFF5;
        Thu, 26 Jan 2023 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Is+CzdfeZTOFVXgC1e+4dswS9N91ktanRCcZICGzugo=; b=fq0qVPC4reDzxrrLeF5yX7aC1Z
        H9LjsQO+LR1umR/s03fJqYyhzv80fJyhOKpcarR8Cy7wSLcplnwUJlbrM9Me+IILje6LaMKmkwnv/
        +YTwHj/vZanxmHv+HRw6xOsgvisjJ3AqYSkSBa1p5QYNukzjoRYtXgqdG0OvLfaLBmJeSiw+KtkN8
        zBo2cFwwq7SWBAnNn8Vd5Cwetlmq1jGFv9YFZ/YzLkjUHcJVtWcEwn3trCyLNc5dJkaUxWOmaUYbx
        EoAOUFc1F6Pc/ry8D4r3DqRSH6w7sBK109PEeR8YJ6jjvJMRKEzLLZqyyEJGezJOQT26vcRAsfHhw
        3wd+VMxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pL8nC-0073jU-Sb; Thu, 26 Jan 2023 20:24:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     "Theodore Tso" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/31] ext4: Convert ext4_writepage() to use a folio
Date:   Thu, 26 Jan 2023 20:23:49 +0000
Message-Id: <20230126202415.1682629-6-willy@infradead.org>
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

Prepare for multi-page folios and save some instructions by converting
to the folio API.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/inode.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b8b3e2e0d9fd..8e3d2cca1e0c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2027,26 +2027,25 @@ static int ext4_writepage(struct page *page,
 
 	trace_ext4_writepage(page);
 	size = i_size_read(inode);
-	if (page->index == size >> PAGE_SHIFT &&
+	len = folio_size(folio);
+	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-		len = size & ~PAGE_MASK;
-	else
-		len = PAGE_SIZE;
+		len = size - folio_pos(folio);
 
+	page_bufs = folio_buffers(folio);
 	/* Should never happen but for bugs in other kernel subsystems */
-	if (!page_has_buffers(page)) {
+	if (!page_bufs) {
 		ext4_warning_inode(inode,
-		   "page %lu does not have buffers attached", page->index);
-		ClearPageDirty(page);
-		unlock_page(page);
+		   "page %lu does not have buffers attached", folio->index);
+		folio_clear_dirty(folio);
+		folio_unlock(folio);
 		return 0;
 	}
 
-	page_bufs = page_buffers(page);
 	/*
 	 * We cannot do block allocation or other extent handling in this
 	 * function. If there are buffers needing that, we have to redirty
-	 * the page. But we may reach here when we do a journal commit via
+	 * the folio. But we may reach here when we do a journal commit via
 	 * journal_submit_inode_data_buffers() and in that case we must write
 	 * allocated buffers to achieve data=ordered mode guarantees.
 	 *
@@ -2062,7 +2061,7 @@ static int ext4_writepage(struct page *page,
 	 */
 	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
 				   ext4_bh_delay_or_unwritten)) {
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		if ((current->flags & PF_MEMALLOC) ||
 		    (inode->i_sb->s_blocksize == PAGE_SIZE)) {
 			/*
@@ -2072,12 +2071,12 @@ static int ext4_writepage(struct page *page,
 			 */
 			WARN_ON_ONCE((current->flags & (PF_MEMALLOC|PF_KSWAPD))
 							== PF_MEMALLOC);
-			unlock_page(page);
+			folio_unlock(folio);
 			return 0;
 		}
 	}
 
-	if (PageChecked(page) && ext4_should_journal_data(inode))
+	if (folio_test_checked(folio) && ext4_should_journal_data(inode))
 		/*
 		 * It's mmapped pagecache.  Add buffers and journal it.  There
 		 * doesn't seem much point in redirtying the page here.
@@ -2087,8 +2086,8 @@ static int ext4_writepage(struct page *page,
 	ext4_io_submit_init(&io_submit, wbc);
 	io_submit.io_end = ext4_init_io_end(inode, GFP_NOFS);
 	if (!io_submit.io_end) {
-		redirty_page_for_writepage(wbc, page);
-		unlock_page(page);
+		folio_redirty_for_writepage(wbc, folio);
+		folio_unlock(folio);
 		return -ENOMEM;
 	}
 	ret = ext4_bio_write_page(&io_submit, page, len);
-- 
2.35.1

