Return-Path: <linux-fsdevel+bounces-41940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C006DA39339
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF5E83AC387
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028291C07C2;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZBJn8dKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162E1B0F1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=JIj/iZq31oBf51rpBZIoMao+dXzoKzOBCuhlKjTCx5nIGrly7XRdobuheTHHpKfyLGAn/F0XCzxGZ6sKi5RkHHJTJ1AHUYy4xPCSCyMRCAOYE0VyE5NuMec3dXKvJ9lyHQwcEZFCv9uBZwc64XYBKiEBqluz3c1xvcbCJzAi/eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=pnTJOqWZU/WHC4fVU9CwNgpCCNXFluE8bDxDCRI50ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSbYwR08fbICrueVwz95r1zd9zAsON7WhBxnD16DsiATN8ajahaDt+C8Ha2Xh7sLOgA02Y58K8s7hHOvO/TnOXvoIJeTPAWro3NIfbjhAitKhcbx7QMTBS/Eo81hOTG+rewjp288ub3lR2EM8picx97zo4eB8KgTVZQMj4QI4zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZBJn8dKc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=8hfEr/bs2O93cTTYBjuHfYQrmaf2LnuSS7qSOXK8nGg=; b=ZBJn8dKca5FE5jhJgQAJMDN0W3
	ps1D9yGjREvu8T/x6oOTyJ2u30HcwMcb5641vNoqBPsDxuSRD5gxF2yJwnNcr3kBFSpfewiLcfm6z
	/P16nriyVs75bzWhXI5a7UsPG1YDIaKvtdo8nW8fcZ7m8KcrT25cD7wVvfRmUdJHLkVUOJdb65kIB
	+S5nGmfyfgip+RZ+1/up3N0WIHdix+gDb/uC4134lG/CH1lttGZJrQnD3rC9UPUJR5yEeEJEvzRZa
	9G/VZSBmS0mM0FXzN/UBfZdW8NiHd8VOZcGbydXDU1Caj5AvlWUuOLWhU2OFXhge49otVx+p+cCje
	7rGs/MMw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002Try-2aHs;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/27] f2fs: Add f2fs_grab_cache_folio()
Date: Tue, 18 Feb 2025 05:51:44 +0000
Message-ID: <20250218055203.591403-11-willy@infradead.org>
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

Convert f2fs_grab_cache_page() into f2fs_grab_cache_folio()
and add a wrapper.  Removes several calls to deprecated functions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/f2fs.h | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 5e01a08afbd7..cf664ca38905 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2767,33 +2767,46 @@ static inline s64 valid_inode_count(struct f2fs_sb_info *sbi)
 	return percpu_counter_sum_positive(&sbi->total_valid_inode_count);
 }
 
-static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
-						pgoff_t index, bool for_write)
+static inline struct folio *f2fs_grab_cache_folio(struct address_space *mapping,
+		pgoff_t index, bool for_write)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned int flags;
 
 	if (IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION)) {
+		fgf_t fgf_flags;
+
 		if (!for_write)
-			page = find_get_page_flags(mapping, index,
-							FGP_LOCK | FGP_ACCESSED);
+			fgf_flags = FGP_LOCK | FGP_ACCESSED;
 		else
-			page = find_lock_page(mapping, index);
-		if (page)
-			return page;
+			fgf_flags = FGP_LOCK;
+		folio = __filemap_get_folio(mapping, index, fgf_flags, 0);
+		if (!IS_ERR(folio))
+			return folio;
 
 		if (time_to_inject(F2FS_M_SB(mapping), FAULT_PAGE_ALLOC))
-			return NULL;
+			return ERR_PTR(-ENOMEM);
 	}
 
 	if (!for_write)
-		return grab_cache_page(mapping, index);
+		return filemap_grab_folio(mapping, index);
 
 	flags = memalloc_nofs_save();
-	page = grab_cache_page_write_begin(mapping, index);
+	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+			mapping_gfp_mask(mapping));
 	memalloc_nofs_restore(flags);
 
-	return page;
+	return folio;
+}
+
+static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
+						pgoff_t index, bool for_write)
+{
+	struct folio *folio = f2fs_grab_cache_folio(mapping, index, for_write);
+
+	if (IS_ERR(folio))
+		return NULL;
+	return &folio->page;
 }
 
 static inline struct page *f2fs_pagecache_get_page(
-- 
2.47.2


