Return-Path: <linux-fsdevel+bounces-41941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D678A3932F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AD16E007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F3B1B0F19;
	Tue, 18 Feb 2025 05:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="buDlQGGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05A1B0421
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=VpnqBRY2AU0RWRTI6JiqT+ohnm3tFKIF46xX1LZa9jeEr3Vj9yKRha+sD4G8Y64V2fN0ipmCJ/m4tkWAHRk3HfSpoULbHEvp0SdcZUZQ6MjcwRTNiM/lk/8q3B/54perdwEVSO+f/TFX0wLU2lcpwv7ajD3bYb27kDv3SNdSM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=ijGgX8qLVzNxqmvHzNa+9NLpqszXJgKam6w8QEasmKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIEh/Q/3WWJbbQi4oSG3O9eB26vDNNQv3+1Z3OmAv+t+PcRJiw/OulX3YZMUa+7KXKoUwBliP1XGRD0w5FgB76I5Afl6X/iTdv5yVieaQ0lwYNYy2hzZQKoHx1eDY4HY8RGdrzUeC0qZcmVcv+lVtqHQgIKX/KpcwU9cmp34MUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=buDlQGGg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=b2LjOng3A6H4X2K1CNXMkHeMrgOtLbNaX8tityBDoz0=; b=buDlQGGg/zzqcIJk9d/joN107h
	Msj51PPo4TLUCZ4Zf1uQrHUYY3CG1w0diHC0G0vSI2d7rryjSgorXR3t6EGiVV/sA3PEAg822Jb1T
	LBFLcRsvdfzbo6jr8TCzME1tAJGN0nEPsgTYCOVKfBnlbzeJ8LPVSZyResKQDoO51qMSJoOgo/4cw
	pp1dRuSaGyaDS1zh7r8cp3fVRAwMlbthUOBq21bj6aeaEJhTI+OqVQZwCpyot+wlucR2aFI3mXM8R
	V6vQK8S+tZdc2Lt91Jy6dS68ylO9+kgtySQ2wkxjTR3RBE3AvRghbsMYIT0+HnXXJa/aww1lDvDXG
	4xTu/K9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002Trd-0tDF;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/27] f2fs: Convert f2fs_fsync_node_pages() to use a folio
Date: Tue, 18 Feb 2025 05:51:41 +0000
Message-ID: <20250218055203.591403-8-willy@infradead.org>
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
 fs/f2fs/node.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1ff6f5888950..415bda9acd0e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1804,7 +1804,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		int i;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
@@ -1814,63 +1814,63 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 				goto out;
 			}
 
-			if (!IS_DNODE(page) || !is_cold_node(page))
+			if (!IS_DNODE(&folio->page) || !is_cold_node(&folio->page))
 				continue;
-			if (ino_of_node(page) != ino)
+			if (ino_of_node(&folio->page) != ino)
 				continue;
 
-			lock_page(page);
+			folio_lock(folio);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(folio->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
-			if (ino_of_node(page) != ino)
+			if (ino_of_node(&folio->page) != ino)
 				goto continue_unlock;
 
-			if (!PageDirty(page) && page != last_page) {
+			if (!folio_test_dirty(folio) && &folio->page != last_page) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			f2fs_wait_on_page_writeback(page, NODE, true, true);
+			f2fs_folio_wait_writeback(folio, NODE, true, true);
 
-			set_fsync_mark(page, 0);
-			set_dentry_mark(page, 0);
+			set_fsync_mark(&folio->page, 0);
+			set_dentry_mark(&folio->page, 0);
 
-			if (!atomic || page == last_page) {
-				set_fsync_mark(page, 1);
+			if (!atomic || &folio->page == last_page) {
+				set_fsync_mark(&folio->page, 1);
 				percpu_counter_inc(&sbi->rf_node_block_count);
-				if (IS_INODE(page)) {
+				if (IS_INODE(&folio->page)) {
 					if (is_inode_flag_set(inode,
 								FI_DIRTY_INODE))
-						f2fs_update_inode(inode, page);
-					set_dentry_mark(page,
+						f2fs_update_inode(inode, &folio->page);
+					set_dentry_mark(&folio->page,
 						f2fs_need_dentry_mark(sbi, ino));
 				}
 				/* may be written by other thread */
-				if (!PageDirty(page))
-					set_page_dirty(page);
+				if (!folio_test_dirty(folio))
+					folio_mark_dirty(folio);
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			ret = __write_node_page(page, atomic &&
-						page == last_page,
+			ret = __write_node_page(&folio->page, atomic &&
+						&folio->page == last_page,
 						&submitted, wbc, true,
 						FS_NODE_IO, seq_id);
 			if (ret) {
-				unlock_page(page);
+				folio_unlock(folio);
 				f2fs_put_page(last_page, 0);
 				break;
 			} else if (submitted) {
 				nwritten++;
 			}
 
-			if (page == last_page) {
-				f2fs_put_page(page, 0);
+			if (&folio->page == last_page) {
+				f2fs_folio_put(folio, false);
 				marked = true;
 				break;
 			}
-- 
2.47.2


