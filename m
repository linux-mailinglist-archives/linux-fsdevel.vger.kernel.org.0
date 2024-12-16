Return-Path: <linux-fsdevel+bounces-37511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF769F35FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 17:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6752C7A36CF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 16:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139B2066E0;
	Mon, 16 Dec 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kWfCA+n0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B232063E1;
	Mon, 16 Dec 2024 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366436; cv=none; b=q06SOQy+lmVs6c/ScQF6Uii9MxhCouiWOcstz/177iJvVRlp4ofSyJQZnowpmkaYqSJTV37AGO4GA9juhw84qjsQ2acH9t18NWS3WyXB0v4r6TawIHszUVgQIXP7rjpD2vafg5H+aVgIxooR1v8FbMl0LoBC/TZlMvUxPRi5PBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366436; c=relaxed/simple;
	bh=H7nXlHgIHsZvrbgkYqoJPhsqvdQdVHO+LhoFVhoY5Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7nbrq7sUxtofd48B+WfCI0d6OkcAdNjq1sXlhKjNZr8/uz1E5nEMQ+waTx8bfZgxar2sfXV84ww7bwEg6bs6ZFBJOwAqv8asgrcUPk0D2iFtzyqaJr72IPvXjjxMMOxtOwgsTfyedhF8U/MXH74vzOqpExfcNQRI1scfmdDVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kWfCA+n0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Qu/PiL85fu1e3QcMJHhgZFh62m9BJTBqStwrlLOLtZQ=; b=kWfCA+n0L40xOuhLiv91kDlJhr
	2T2FXHN8IBznmYsGX8qZ36MMuO5FzKzQimyLDB9b2O/1rt2dnl/C37LMZISbzu3DoRG9uS/RS5RK5
	v78DL1Ddk4mulAZaXdEruEj8LiaRBOpzVFnOyAzNj52NAb63/QlBZPHOVVkXlFeXMaE3Gim0jHVm2
	NBkci6eYlT4nadFfn/usX5ttZqo4epj3HdrSA3iNtMJdvmtV+c3Q0qpfpZ2ROIdNUIBH3MzzjsMbD
	MuDrDPs4E0yP9J5ypdlyyoRuwFFEOMn4MCE3XKfSIDF8hlSr/jJU7/WBnhiEDFDGqMF/naRsWflDE
	hzGliwiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDw0-00000000Ez8-1qLx;
	Mon, 16 Dec 2024 16:27:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/5] squashfs; Convert squashfs_copy_cache() to take a folio
Date: Mon, 16 Dec 2024 16:26:58 +0000
Message-ID: <20241216162701.57549-4-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216162701.57549-1-willy@infradead.org>
References: <20241216162701.57549-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove accesses to page->index and page->mapping.  Also use folio
APIs where available.  This code still assumes order 0 folios.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c       | 46 ++++++++++++++++++++++------------------
 fs/squashfs/file_cache.c |  2 +-
 fs/squashfs/squashfs.h   |  4 ++--
 3 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 5b81e26b1226..1f27e8161319 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -378,13 +378,15 @@ void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer,
 }
 
 /* Copy data into page cache  */
-void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
-	int bytes, int offset)
+void squashfs_copy_cache(struct folio *folio,
+		struct squashfs_cache_entry *buffer, size_t bytes,
+		size_t offset)
 {
-	struct inode *inode = page->mapping->host;
+	struct address_space *mapping = folio->mapping;
+	struct inode *inode = mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = page->index & ~mask, end_index = start_index | mask;
+	int start_index = folio->index & ~mask, end_index = start_index | mask;
 
 	/*
 	 * Loop copying datablock into pages.  As the datablock likely covers
@@ -394,25 +396,27 @@ void squashfs_copy_cache(struct page *page, struct squashfs_cache_entry *buffer,
 	 */
 	for (i = start_index; i <= end_index && bytes > 0; i++,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
-		struct page *push_page;
-		int avail = buffer ? min_t(int, bytes, PAGE_SIZE) : 0;
+		struct folio *push_folio;
+		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
 
-		TRACE("bytes %d, i %d, available_bytes %d\n", bytes, i, avail);
+		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
 
-		push_page = (i == page->index) ? page :
-			grab_cache_page_nowait(page->mapping, i);
+		push_folio = (i == folio->index) ? folio :
+			__filemap_get_folio(mapping, i,
+					FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
+					mapping_gfp_mask(mapping));
 
-		if (!push_page)
+		if (!push_folio)
 			continue;
 
-		if (PageUptodate(push_page))
-			goto skip_page;
+		if (folio_test_uptodate(push_folio))
+			goto skip_folio;
 
-		squashfs_fill_page(push_page, buffer, offset, avail);
-skip_page:
-		unlock_page(push_page);
-		if (i != page->index)
-			put_page(push_page);
+		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
+skip_folio:
+		folio_unlock(push_folio);
+		if (i != folio->index)
+			folio_put(push_folio);
 	}
 }
 
@@ -430,16 +434,16 @@ static int squashfs_readpage_fragment(struct folio *folio, int expected)
 			squashfs_i(inode)->fragment_block,
 			squashfs_i(inode)->fragment_size);
 	else
-		squashfs_copy_cache(&folio->page, buffer, expected,
+		squashfs_copy_cache(folio, buffer, expected,
 			squashfs_i(inode)->fragment_offset);
 
 	squashfs_cache_put(buffer);
 	return res;
 }
 
-static int squashfs_readpage_sparse(struct page *page, int expected)
+static int squashfs_readpage_sparse(struct folio *folio, int expected)
 {
-	squashfs_copy_cache(page, NULL, expected, 0);
+	squashfs_copy_cache(folio, NULL, expected, 0);
 	return 0;
 }
 
@@ -470,7 +474,7 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 			goto out;
 
 		if (res == 0)
-			res = squashfs_readpage_sparse(&folio->page, expected);
+			res = squashfs_readpage_sparse(folio, expected);
 		else
 			res = squashfs_readpage_block(folio, block, res, expected);
 	} else
diff --git a/fs/squashfs/file_cache.c b/fs/squashfs/file_cache.c
index 0360d22a77d4..40e59a43d098 100644
--- a/fs/squashfs/file_cache.c
+++ b/fs/squashfs/file_cache.c
@@ -29,7 +29,7 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize, int expec
 		ERROR("Unable to read page, block %llx, size %x\n", block,
 			bsize);
 	else
-		squashfs_copy_cache(&folio->page, buffer, expected, 0);
+		squashfs_copy_cache(folio, buffer, expected, 0);
 
 	squashfs_cache_put(buffer);
 	return res;
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 0f5373479516..9295556ecfd0 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -68,8 +68,8 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
 
 /* file.c */
 void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
-void squashfs_copy_cache(struct page *, struct squashfs_cache_entry *, int,
-				int);
+void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
+		size_t bytes, size_t offset);
 
 /* file_xxx.c */
 int squashfs_readpage_block(struct folio *, u64 block, int bsize, int expected);
-- 
2.45.2


