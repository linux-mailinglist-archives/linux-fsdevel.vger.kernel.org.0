Return-Path: <linux-fsdevel+bounces-41954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41565A3933C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D245216F7DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108EE1CDA0B;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XSHGHpVV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541EC1B6D01
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=CSRm49qRf+ne2Dxvh5B2DEhWEXcHgC5Oqns+zTOaSkfpWv8nxMI2Lt8shKjayx45UD240tVcRXo98uCPsRaQ2A91NlX69ZiWNH4J9uYu8KGZ7RqZ3uJ9LRCD2NcbNjNNrdig0RVsnhyoxQTJzDCaB62DuThW1o8ow0IIx+aZnzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=bsqlnxFHjT25Kx/uUy2yJwpm8vdte9+A6Tp0IEx/JNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAg4Bx0hAcp9GrQjBrc520pTwH+5X2PpEWEs1BXYhZtDPIuRSqqbl+7Ds2T5thh81JTRKF2FVTppPUEilQYYX4+En7ePVHRifn0nUZRQcA0IdTLCSKm57IXcC5/BDGx12OPMNK+32I2oZE/ejrBJK9HKCYDltAaLEMVdwyyyUGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XSHGHpVV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=hYeLmkCKBphS48/Z/sVHXsQHr69hpdPqzRtRINtafVY=; b=XSHGHpVV+Wg1KSwrioFia3K61d
	tNE36QOpT8hkCRUMfAgRk/DH6J00v4OaRpXT+i0OANwRWyY14XIJT/vJ+Iu5X7dTdhPZZeL6paU0B
	3ouakgd9IVc8uq5/E/KaZzXecamLBuxbDKqYCyj2H+vmt6uV/U823xD+a8yzaIZQDQfVk9gz0qmB3
	Sf4GKuazyvrWqCL21cWfiD2J/KjSAz8SFXqJlcILHaaew322CGcncaCeKAp4yHFVQ+t2B98/Xf6cs
	NtM7maXo+5VPo4C27C5Avxz+OKcx1z9LfO7bfbVddoDXDLTOcordGuiXASSPa7prfr4QudrtHUxXn
	bv4CCjmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002TtP-1rim;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/27] f2fs: Add f2fs_get_lock_data_folio()
Date: Tue, 18 Feb 2025 05:51:56 +0000
Message-ID: <20250218055203.591403-23-willy@infradead.org>
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

Convert f2fs_get_lock_data_page() to f2fs_get_lock_data_folio() and
add a compatibility wrapper.  Removes three hidden calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 18 +++++++++---------
 fs/f2fs/f2fs.h | 10 +++++++++-
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f0747c7f669d..e891c95bc525 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1310,23 +1310,23 @@ struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
  * Because, the callers, functions in dir.c and GC, should be able to know
  * whether this page exists or not.
  */
-struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
+struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 							bool for_write)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
-	page = f2fs_get_read_data_page(inode, index, 0, for_write, NULL);
-	if (IS_ERR(page))
-		return page;
+	folio = f2fs_get_read_data_folio(inode, index, 0, for_write, NULL);
+	if (IS_ERR(folio))
+		return folio;
 
 	/* wait for read completion */
-	lock_page(page);
-	if (unlikely(page->mapping != mapping || !PageUptodate(page))) {
-		f2fs_put_page(page, 1);
+	folio_lock(folio);
+	if (unlikely(folio->mapping != mapping || !folio_test_uptodate(folio))) {
+		f2fs_folio_put(folio, true);
 		return ERR_PTR(-EIO);
 	}
-	return page;
+	return folio;
 }
 
 /*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3e02df63499e..c78ba3c7d642 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3899,7 +3899,7 @@ struct folio *f2fs_get_read_data_folio(struct inode *inode, pgoff_t index,
 		blk_opf_t op_flags, bool for_write, pgoff_t *next_pgofs);
 struct page *f2fs_find_data_page(struct inode *inode, pgoff_t index,
 							pgoff_t *next_pgofs);
-struct page *f2fs_get_lock_data_page(struct inode *inode, pgoff_t index,
+struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct page *f2fs_get_new_data_page(struct inode *inode,
 			struct page *ipage, pgoff_t index, bool new_i_size);
@@ -3936,6 +3936,14 @@ static inline struct page *f2fs_get_read_data_page(struct inode *inode,
 	return &folio->page;
 }
 
+static inline struct page *f2fs_get_lock_data_page(struct inode *inode,
+		pgoff_t index, bool for_write)
+{
+	struct folio *folio = f2fs_get_lock_data_folio(inode, index, for_write);
+
+	return &folio->page;
+}
+
 /*
  * gc.c
  */
-- 
2.47.2


