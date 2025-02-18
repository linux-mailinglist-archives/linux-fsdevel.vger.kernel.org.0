Return-Path: <linux-fsdevel+bounces-41959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 681BFA39345
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954BF3ACE2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AAD1B6D01;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tSAtJlIK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B21AF0B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857933; cv=none; b=bb9iiBmYCeGUHFiO74gOdXtsJwGJoBLPNqivZy+lIO1IrdOqt/mb8kuwLrATlxDlEzMG/kQfBIX55mePnRFW5Pot1L4HTjf5nqpf6Q0GrqsTbwZ5f1YjuuYO5vLsAwaVO6ehqSobhGKSa3272u3JexV+QkmHM7nFtawF7PnO1Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857933; c=relaxed/simple;
	bh=0q/gCC/THEhYvEkloUENQMnYw4G0dG7emMlZeXkPoDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3J0igCddbpzEdnLSP8xU3nJPaHJe6l7NKVk8ML8c45z+SL3YxyJtHVgn3JXR5GB9gUuI+MBJr2fa+8yGzC2fKW6UkZVWvASzASdqqmGvSDBW/se0yzm2mRy2u/GIRerOhpkkJ4FP61Ru6JfAdQ15+XKsAWbxPMyXT7JTVoXtpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tSAtJlIK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=jiRrKyO8yENyMontqvs0dcauGFA0fTCVfBBYRPRE/z4=; b=tSAtJlIKX4Xt/HiKZ00aLLy9Lt
	pRfq7RPniB/TA3IDao3m1/2LxduNNgNFuyq34oRXsOF995Q5SvHWATqNZq+/HyRumhueLRKFyaMzE
	xhW0RXjCC8LhCi7vMXaCqtXW6Rea5qMUOFl9RU/zgQP+7V13uknevtPOPt2RPg1Ly6NiK7JSm+0zA
	GlQDPdlsVN9vHwsohTSh4+AUbPPhxAjZrlj69PRq3pVuqDK3zX3i5tyduJTWSc7ZtQjWM22uRUptl
	sZrE3PpaZNJOjoSTbgDvDF5pjutjlrMJXLVmdUCj0/iMAqUvJkFTe6+9d6RKdjMfCneIodJ0WA16w
	5zehYxSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWf-00000002Tts-0dXy;
	Tue, 18 Feb 2025 05:52:09 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/27] f2fs: Add f2fs_find_data_folio()
Date: Tue, 18 Feb 2025 05:52:00 +0000
Message-ID: <20250218055203.591403-27-willy@infradead.org>
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

Convert f2fs_find_data_page() to f2fs_find_data_folio() and add a
compatibility wrapper.  Saves six hidden calls to compound_head().
This was the last caller of f2fs_get_read_data_page(), so remove
the compatibility wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 33 ++++++++++++++++++---------------
 fs/f2fs/f2fs.h | 12 +++++-------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e891c95bc525..f1554a5a3d7a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1279,30 +1279,33 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 	return ERR_PTR(err);
 }
 
-struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
+struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
 					pgoff_t *next_pgofs)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
-	page = find_get_page_flags(mapping, index, FGP_ACCESSED);
-	if (page && PageUptodate(page))
-		return page;
-	f2fs_put_page(page, 0);
+	folio = __filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
+	if (IS_ERR(folio))
+		goto read;
+	if (folio_test_uptodate(folio))
+		return folio;
+	f2fs_folio_put(folio, false);
 
-	page = f2fs_get_read_data_page(inode, index, 0, false, next_pgofs);
-	if (IS_ERR(page))
-		return page;
+read:
+	folio = f2fs_get_read_data_folio(inode, index, 0, false, next_pgofs);
+	if (IS_ERR(folio))
+		return folio;
 
-	if (PageUptodate(page))
-		return page;
+	if (folio_test_uptodate(folio))
+		return folio;
 
-	wait_on_page_locked(page);
-	if (unlikely(!PageUptodate(page))) {
-		f2fs_put_page(page, 0);
+	folio_wait_locked(folio);
+	if (unlikely(!folio_test_uptodate(folio))) {
+		f2fs_folio_put(folio, false);
 		return ERR_PTR(-EIO);
 	}
-	return page;
+	return folio;
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index c78ba3c7d642..a2298eca2576 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3897,8 +3897,8 @@ int f2fs_get_block_locked(struct dnode_of_data *dn, pgoff_t index);
 int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index);
 struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
-struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
-							pgoff_t *next_pgofs);
+struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
+		pgoff_t *next_pgofs);
 struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct page *f2fs_get_new_data_page(struct inode *inode,
@@ -3926,12 +3926,10 @@ int f2fs_init_post_read_wq(struct f2fs_sb_info *sbi);
 void f2fs_destroy_post_read_wq(struct f2fs_sb_info *sbi);
 extern const struct iomap_ops f2fs_iomap_ops;
 
-static inline struct page *f2fs_get_read_data_page(struct inode *inode,
-		pgoff_t index, blk_opf_t op_flags, bool for_write,
-		pgoff_t *next_pgofs)
+static inline struct page *f2fs_find_data_page(struct inode *inode,
+		pgoff_t index, pgoff_t *next_pgofs)
 {
-	struct folio *folio = f2fs_get_read_data_folio(inode, index, op_flags,
-			for_write, next_pgofs);
+	struct folio *folio = f2fs_find_data_folio(inode, index, next_pgofs);
 
 	return &folio->page;
 }
-- 
2.47.2


