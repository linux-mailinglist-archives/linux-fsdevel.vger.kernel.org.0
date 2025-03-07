Return-Path: <linux-fsdevel+bounces-43434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB350A56995
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 14:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDBB1893863
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4BE21C9FD;
	Fri,  7 Mar 2025 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X62+uKJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1221ADA4
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Mar 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355660; cv=none; b=gWCjJc6sfX5hRuFyHeDXrKXyrvNDg5u8Gs4hpDpGFId5TvKFg7rkMU/+SC02OLiE4WOaK0mt1pHZB89SUWHEEXpNbA7xiTnYlkn9dQeUMLLbXxFiqKZHEbECxE98W55Cs97nwnt2rRGLLoq8cz+jUD/L1PrOhyMQN402w21Ofl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355660; c=relaxed/simple;
	bh=GP5Ddi/5B/pGaXC397iVxa56WO7oihm+nV64sVM8/f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5cWOgTGW+J3hlGonvAGs/mA3VQi286wtDQpR/UkZivpGWqgvB+VfN54/KXg6rJ9b1y7qFdc3O1ghO7Cwt2eal2a9sXBo9oXAjX25XUSo8CaJ8O3zmbxn+PKes3cgOW/haFgqYfiVqIMPItNVOIH+p5TtRNVQGbdddC6w6YNUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X62+uKJW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TkS8MMSXr1V47Aygjy0xD3fBh6jvlfrlC7n0css79m8=; b=X62+uKJW5uRc3AljrZOB8IJcR5
	FcWRKLLJWmGSKzfnl4nxJjjgjv9O1gFQr2Szy9TLcBuGwadTSn34XR9hOcZkcZB41Pi+9vltTSGsj
	I5/5wHK5D1RaK79iQCgyfbAFpEJuEk5yD2wnvMggodf32rYwV4qgFknQP1XxeJieUk5Dffkwer1v0
	P1PMhVwX0aSgYrj9gT+Fdm8zYV1k4WH7jzshbgcNhuIWt3B2Qu/RHhF1rKuIRU4FoMfpkyTN43Cmm
	kXhVONT5gXXOwk7DWD7OpEqI5fKlE2Ht6lIInk/kTeTe6+SDyXkE3Lxa5g5W15n2omOLZ1ep3SK1d
	bhjLPAUw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tqY9Y-0000000CXGa-2Mrx;
	Fri, 07 Mar 2025 13:54:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	intel-gfx@lists.freedesktop.org
Subject: [PATCH 08/11] shmem: Add shmem_writeout()
Date: Fri,  7 Mar 2025 13:54:08 +0000
Message-ID: <20250307135414.2987755-9-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307135414.2987755-1-willy@infradead.org>
References: <20250307135414.2987755-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This will be the replacement for shmem_writepage().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/shmem_fs.h |  7 ++++---
 mm/shmem.c               | 20 ++++++++++++++------
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0b273a7b9f01..5f03a39a26f7 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -104,10 +104,11 @@ static inline bool shmem_mapping(struct address_space *mapping)
 	return false;
 }
 #endif /* CONFIG_SHMEM */
-extern void shmem_unlock_mapping(struct address_space *mapping);
-extern struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
+void shmem_unlock_mapping(struct address_space *mapping);
+struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 					pgoff_t index, gfp_t gfp_mask);
-extern void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
+int shmem_writeout(struct folio *folio, struct writeback_control *wbc);
+void shmem_truncate_range(struct inode *inode, loff_t start, loff_t end);
 int shmem_unuse(unsigned int type);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/mm/shmem.c b/mm/shmem.c
index ba162e991285..427b7f70fffb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1536,12 +1536,20 @@ int shmem_unuse(unsigned int type)
 	return error;
 }
 
-/*
- * Move the page from the page cache to the swap cache.
- */
 static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
+	return shmem_writeout(page_folio(page), wbc);
+}
+
+/**
+ * shmem_writeout - Write the folio to swap
+ * @folio: The folio to write
+ * @wbc: How writeback is to be done
+ *
+ * Move the folio from the page cache to the swap cache.
+ */
+int shmem_writeout(struct folio *folio, struct writeback_control *wbc)
+{
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct shmem_inode_info *info = SHMEM_I(inode);
@@ -1586,9 +1594,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 try_split:
 		/* Ensure the subpages are still dirty */
 		folio_test_set_dirty(folio);
-		if (split_huge_page_to_list_to_order(page, wbc->list, 0))
+		if (split_folio_to_list(folio, wbc->list))
 			goto redirty;
-		folio = page_folio(page);
 		folio_clear_dirty(folio);
 	}
 
@@ -1660,6 +1667,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	folio_unlock(folio);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(shmem_writeout);
 
 #if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
 static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
-- 
2.47.2


