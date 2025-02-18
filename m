Return-Path: <linux-fsdevel+bounces-41936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF7A3932C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8EE3AB185
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA951B78F3;
	Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cikHE8bw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0BA1B0435
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857929; cv=none; b=PNx77HJalFEgfvgPvTdf3Bifs1da7B354MJxDRinEV+qRR6mi7x2s1PQZEQ71Fm/8uScWEw4byn5ilt1Wlwo5gVnrsiyGNMya4oJvfF96H66BRiROkd/EAI229fjL5eT2mBkDo9EEUC1Ysxg5OaL1I+CDAWlRBsmIB9RXUpiPZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857929; c=relaxed/simple;
	bh=LVkERnfVKHVgdggCkwIF0cE0Ni51OKUXHzQNI5BJJl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=noBWJH0DmrxfKvy6IlCzcRe0eIhOfe7a8fbbAhbNNSibVftG3bP2tgx7DKj+PEGtePaR3U8dQHsdSw19rRZRsmfCYJ+k1Vy7FPoLHo5aZFBsp+q3ZWw4N7uThstuvbtn78amvnJVK8C923E412/XgBMyPNqz5wKkOmVlZgfAz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cikHE8bw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=eOvERL0a/TZ8CcZnQVc8BdoCqM8a/JUQQunqaHJyubQ=; b=cikHE8bw2QIyuwZQljE4++WIZm
	MN+p0DkkhqGuXAmjqj3LZUV2e2U5D5X2HRsUKF7Vo4PjaniUzCx0c2bHPVhraXkdZrZHJTmsdhfL5
	qTkrX0sT2TBQLsSsgM1esklrTjI9KaaZl7QUHKWZQl4xN/bgMjVvAMKP3Cg9CCS1KmOTnQQZGPvR8
	+AJ/vEbyExAD5g8LGuFT7hQjwh/vT495hqjMICCKe6B+qcWReiKjRxRwYQHhw5j5mM3ji9CAXOH/5
	jYZ1CFy73lL9kDtZJg0Llo08hWki3kvZxIZb07U4jTlLQf7qt7uIWWhgO6H+zUhytuLxYAuiQPqz5
	TwzMAFAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWb-00000002TrP-3x4f;
	Tue, 18 Feb 2025 05:52:05 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/27] f2fs: Convert f2fs_sync_node_pages() to use a folio
Date: Tue, 18 Feb 2025 05:51:39 +0000
Message-ID: <20250218055203.591403-6-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218055203.591403-1-willy@infradead.org>
References: <20250218055203.591403-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the folio APIs where they exist.  Saves several hidden calls to
compound_head().  Also removes a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 522bf84c0209..6022f9200f4c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2000,7 +2000,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 		int i;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
@@ -2016,27 +2016,27 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			 * 1. dentry dnodes
 			 * 2. file dnodes
 			 */
-			if (step == 0 && IS_DNODE(page))
+			if (step == 0 && IS_DNODE(&folio->page))
 				continue;
-			if (step == 1 && (!IS_DNODE(page) ||
-						is_cold_node(page)))
+			if (step == 1 && (!IS_DNODE(&folio->page) ||
+						is_cold_node(&folio->page)))
 				continue;
-			if (step == 2 && (!IS_DNODE(page) ||
-						!is_cold_node(page)))
+			if (step == 2 && (!IS_DNODE(&folio->page) ||
+						!is_cold_node(&folio->page)))
 				continue;
 lock_node:
 			if (wbc->sync_mode == WB_SYNC_ALL)
-				lock_page(page);
-			else if (!trylock_page(page))
+				folio_lock(folio);
+			else if (!folio_trylock(folio))
 				continue;
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(folio->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
@@ -2046,29 +2046,29 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				goto write_node;
 
 			/* flush inline_data */
-			if (page_private_inline(page)) {
-				clear_page_private_inline(page);
-				unlock_page(page);
-				flush_inline_data(sbi, ino_of_node(page));
+			if (page_private_inline(&folio->page)) {
+				clear_page_private_inline(&folio->page);
+				folio_unlock(folio);
+				flush_inline_data(sbi, ino_of_node(&folio->page));
 				goto lock_node;
 			}
 
 			/* flush dirty inode */
-			if (IS_INODE(page) && flush_dirty_inode(page))
+			if (IS_INODE(&folio->page) && flush_dirty_inode(&folio->page))
 				goto lock_node;
 write_node:
-			f2fs_wait_on_page_writeback(page, NODE, true, true);
+			f2fs_folio_wait_writeback(folio, NODE, true, true);
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			set_fsync_mark(page, 0);
-			set_dentry_mark(page, 0);
+			set_fsync_mark(&folio->page, 0);
+			set_dentry_mark(&folio->page, 0);
 
-			ret = __write_node_page(page, false, &submitted,
+			ret = __write_node_page(&folio->page, false, &submitted,
 						wbc, do_balance, io_type, NULL);
 			if (ret)
-				unlock_page(page);
+				folio_unlock(folio);
 			else if (submitted)
 				nwritten++;
 
-- 
2.47.2


