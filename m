Return-Path: <linux-fsdevel+bounces-37993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BCF9F9CD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 23:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2CDA1898579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 22:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CDA227B8E;
	Fri, 20 Dec 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DYzJo6ry"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711AA21C180
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 22:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734734801; cv=none; b=N2beryqO5lvntDsRz+MUJyevkhc+00mlDa+gvls1BNP1MDsn7fnhCEWcMVRYkJT7x4MOoK7+gZ+/mP8YcVP6PcLjBzymI2QmEx5FDd+p0lfE3QeNCaPHLTJz407Qv5dDMTcfA33i6xeRjoS7ghZGjfZXCTfatgOpIfnjyqRt7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734734801; c=relaxed/simple;
	bh=MGh0v9zGiTVXQP1tmKZU6Rjuk5J68nH6nxFeGxLe/n0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWyPS5RcB5dAOnx+q45hahNNe30HTTHrh0qdkoxHKE0XB1nDJ0okh4pE7AMYh/kceFIMkuawqqVzM2zCvG+VpZLcCIw7fqY838FmkPVlclU+lfCe+Z0dB3HXkN76DNDmxnmFmP/nzguVHhKbSwN3aBiNGXoAaAX27HO7iihsCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DYzJo6ry; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=Fh0BaEx2us0AW3iGfQsY36K6B+upK8UEcVRgMrbaSTg=; b=DYzJo6ryyeKvR9ZNy/KiM26VDN
	Hn1j758wK1VjEK3H6hlAc/Ur4DFP4tVN7VxUxU5rpBH/707U6dSrjx5P+vRLTZH6FgUsiA2cbSPWk
	zOJPaMQw8UOrLstSurlRPhMTnE1SIOLp3PJI8IiVVSb+6s9RbR1DS6n6Y3n12CyN1Y1aGXmibOIEy
	bqNVAjnVcuc9FobfLzDegVDGtGBsO0yBhZiLdtJVts008bDW1I/MvfykWWyp8tIcDmtM128Vk/SWX
	L6wSDYEC42PkaQMG+dEC6raLnB0NEX7AZAFJmadL7LGdGBzC4OWA36qaqazRSNsBjcQYKeoh6PfAS
	8lYAXSsg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOllV-000000032Nn-0Yss;
	Fri, 20 Dec 2024 22:46:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a folio
Date: Fri, 20 Dec 2024 22:46:28 +0000
Message-ID: <20241220224634.723899-5-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220224634.723899-1-willy@infradead.org>
References: <20241220224634.723899-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

squashfs_fill_page is only used in this file, so make it static.
Use kmap_local instead of kmap_atomic, and return a bool so that
the caller can use folio_end_read() which saves an atomic operation
over calling folio_mark_uptodate() followed by folio_unlock().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/squashfs/file.c     | 21 ++++++++++++---------
 fs/squashfs/squashfs.h |  1 -
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 1f27e8161319..da25d6fa45ce 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int index, u64 *block)
 	return squashfs_block_size(size);
 }
 
-void squashfs_fill_page(struct page *page, struct squashfs_cache_entry *buffer, int offset, int avail)
+static bool squashfs_fill_page(struct folio *folio,
+		struct squashfs_cache_entry *buffer, size_t offset,
+		size_t avail)
 {
-	int copied;
+	size_t copied;
 	void *pageaddr;
 
-	pageaddr = kmap_atomic(page);
+	pageaddr = kmap_local_folio(folio, 0);
 	copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
 	memset(pageaddr + copied, 0, PAGE_SIZE - copied);
-	kunmap_atomic(pageaddr);
+	kunmap_local(pageaddr);
 
-	flush_dcache_page(page);
-	if (copied == avail)
-		SetPageUptodate(page);
+	flush_dcache_folio(folio);
+
+	return copied == avail;
 }
 
 /* Copy data into page cache  */
@@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
 		struct folio *push_folio;
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
+		bool uptodate = true;
 
 		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
 
@@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
 		if (folio_test_uptodate(push_folio))
 			goto skip_folio;
 
-		squashfs_fill_page(&push_folio->page, buffer, offset, avail);
+		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
 skip_folio:
-		folio_unlock(push_folio);
+		folio_end_read(push_folio, uptodate);
 		if (i != folio->index)
 			folio_put(push_folio);
 	}
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 9295556ecfd0..37f3518a804a 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -67,7 +67,6 @@ extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
 				u64, u64, unsigned int);
 
 /* file.c */
-void squashfs_fill_page(struct page *, struct squashfs_cache_entry *, int, int);
 void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
 		size_t bytes, size_t offset);
 
-- 
2.45.2


