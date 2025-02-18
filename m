Return-Path: <linux-fsdevel+bounces-41939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03703A3932E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2A91890962
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ED91B87EE;
	Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="To9K0osl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368891B0F19
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857929; cv=none; b=uwCP+MRwVSWBy8W4fvKZMs2nD7QV02o3wOwT2mO2I8RYx3q1XF8l9eemgxiTH0e/B1hql8qnK1Zjbdi73wvbrwrAtu/PnfWHvzz4FufoKRtd1x76K4GhV72cLr184o3LZJL3ggrm3BtaQaRQ/8VK20haLgDnT0IlsGSmue7niKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857929; c=relaxed/simple;
	bh=ygPfNe6NNMEXI8oMbwoLB2Le9q+nIt4Ru7tKTQb1i7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijodUy2TGLzTKrW7K1gPxqiQyqvzDSVJ1fdZYwfk8XRCn9N7I6R55wZvL0IekbYGl54lggLasYzh6kyd/w7qysmCOdSwChCiJ43idZE9iuBanYrYFUfFhFP2r0PQt74wVE1onzoiF4US46jJcmtI1xyrU4FBd9riwEDheZdy+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=To9K0osl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yAaVeiHD23nVKO8KVwkuhk4japhxoOiPMc+XdWBH8f4=; b=To9K0osl8GD6peEwzGARMm7NwL
	RQDVStinFl03xfpMo3zcxroTMGrn1TXAIrzp3LtdCxFHJ97IREsqHH9oKB63hMWmn8nkfZQnsOB7v
	OU4PBgXxbbQLOJLVVNeSSn9VPgC8YkWcyz14LYlcsyOyJevD99SVQv/GpI4Vmlpp0OEtJbXfCeRE9
	i1zPN90l8Pqn49hxDAs3V3b9IwlGrbdq0CaQjeRYXksNroWfYuyxLGvz0WAq2QApouNGZ8H5X73Ji
	4aVVKBalNoAx/1yT3nC9/SEQNrMhls4gQavMBZTQqxr1bwmAa1vB1NL5oXjrZ6hOFXeb7u4Mx400q
	s3PykuYA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002Trr-20eq;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/27] f2fs: Return a folio from last_fsync_dnode()
Date: Tue, 18 Feb 2025 05:51:43 +0000
Message-ID: <20250218055203.591403-10-willy@infradead.org>
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

Convert last_page to last_folio in f2fs_fsync_node_pages() and
use folio APIs where they exist.  Saves a few hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 66260fae3cc8..1bd151d71b6b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1561,7 +1561,7 @@ static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
 	iput(inode);
 }
 
-static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
+static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
 	struct folio_batch fbatch;
@@ -1615,7 +1615,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
-	return &last_folio->page;
+	return last_folio;
 }
 
 static int __write_node_page(struct page *page, bool atomic, bool *submitted,
@@ -1783,16 +1783,16 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	pgoff_t index;
 	struct folio_batch fbatch;
 	int ret = 0;
-	struct page *last_page = NULL;
+	struct folio *last_folio = NULL;
 	bool marked = false;
 	nid_t ino = inode->i_ino;
 	int nr_folios;
 	int nwritten = 0;
 
 	if (atomic) {
-		last_page = last_fsync_dnode(sbi, ino);
-		if (IS_ERR_OR_NULL(last_page))
-			return PTR_ERR_OR_ZERO(last_page);
+		last_folio = last_fsync_dnode(sbi, ino);
+		if (IS_ERR_OR_NULL(last_folio))
+			return PTR_ERR_OR_ZERO(last_folio);
 	}
 retry:
 	folio_batch_init(&fbatch);
@@ -1808,7 +1808,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			bool submitted = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
-				f2fs_put_page(last_page, 0);
+				f2fs_folio_put(last_folio, false);
 				folio_batch_release(&fbatch);
 				ret = -EIO;
 				goto out;
@@ -1829,7 +1829,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			if (ino_of_node(&folio->page) != ino)
 				goto continue_unlock;
 
-			if (!folio_test_dirty(folio) && &folio->page != last_page) {
+			if (!folio_test_dirty(folio) && folio != last_folio) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
@@ -1839,7 +1839,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 			set_fsync_mark(&folio->page, 0);
 			set_dentry_mark(&folio->page, 0);
 
-			if (!atomic || &folio->page == last_page) {
+			if (!atomic || folio == last_folio) {
 				set_fsync_mark(&folio->page, 1);
 				percpu_counter_inc(&sbi->rf_node_block_count);
 				if (IS_INODE(&folio->page)) {
@@ -1858,18 +1858,18 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto continue_unlock;
 
 			ret = __write_node_page(&folio->page, atomic &&
-						&folio->page == last_page,
+						folio == last_folio,
 						&submitted, wbc, true,
 						FS_NODE_IO, seq_id);
 			if (ret) {
 				folio_unlock(folio);
-				f2fs_put_page(last_page, 0);
+				f2fs_folio_put(last_folio, false);
 				break;
 			} else if (submitted) {
 				nwritten++;
 			}
 
-			if (&folio->page == last_page) {
+			if (folio == last_folio) {
 				f2fs_folio_put(folio, false);
 				marked = true;
 				break;
@@ -1883,11 +1883,11 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 	}
 	if (!ret && atomic && !marked) {
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
-			   ino, page_folio(last_page)->index);
-		lock_page(last_page);
-		f2fs_wait_on_page_writeback(last_page, NODE, true, true);
-		set_page_dirty(last_page);
-		unlock_page(last_page);
+			   ino, last_folio->index);
+		folio_lock(last_folio);
+		f2fs_folio_wait_writeback(last_folio, NODE, true, true);
+		folio_mark_dirty(last_folio);
+		folio_unlock(last_folio);
 		goto retry;
 	}
 out:
-- 
2.47.2


