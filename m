Return-Path: <linux-fsdevel+bounces-56495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85562B17A9E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6695467CF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1AA8F6F;
	Fri,  1 Aug 2025 00:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpDHG83O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7543B33993
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008078; cv=none; b=a0AdLG6hLTmheCVXD3yJfqBdA0LWY+L5aFDsNgqtiQtEqJjW1z1Al4MTJIXzYHFUXp0WanG8Cny9Dp6cXBNGLdp8mNVy2FMqx8HG5UyrDPCEnh+2m4U0RUEU7T8iLXAEp2vueJV2lBRoEvTGPwd6CMuA/kL9gHTtuLLtmvQa/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008078; c=relaxed/simple;
	bh=RYzSeb3f8+o9UqC82KSMcaI6JyCI7QRk8cbXhaYtKgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsOiQa3JeEv1qffX6L+3dR2pQI6W2mREI/V2sHinJX0XlasoDnvTrF6fVSPmmWNGOViKHYOcv7FD1MhJboLtq8QVPYw9vC+79KTB5wnMtqYJGh6A6S2bCtJlxznrdw3MnJlMoaUxF9e3L5YlmOejtybtBXUhEsSua0Au51zWTVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XpDHG83O; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso326592a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008076; x=1754612876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgsCeFlo0QeXkQOENhkfXRkOGlZ0DSVecFbnvZAG94g=;
        b=XpDHG83OUxbgktsMb9GaR3LF6HUAdqOMwOC8iOQe/gLO9gcFZGqB7MONunV/b2jXzp
         Zd+APN3gsL1KYuY/BfvDV4np1EcQaXnB+CZgllLScZ+cxkJ7ihuxYserZkbbgzHkZ4lh
         fQkFYTrmuac0tdHhAE+vHWmqSTfVawBDbltkH6/W86/NQS0dbevSE08HJOrEb5elI0Nc
         vn/mNKqBtfm1GdQ3gTbs0WttxYC9INpHcj/h48KVNa6NmtD5jbra7RB07wlay9dgIFal
         BuCNdjrsQ0cnwTMwGdLBQvilVWpwQbOMugRLTB5pMSbcLS91dwICjc4+K6ee0+q+hXEc
         CJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008076; x=1754612876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgsCeFlo0QeXkQOENhkfXRkOGlZ0DSVecFbnvZAG94g=;
        b=vkgtR5AuXLME/iJ5C+0NGUihO1qqpJ3YXSL5mrNMbQXPGgFjyhWGLhjGKZOXaqGc0Q
         c7jw3V0cGd/NF4yNOzwHM8UQ2uO/BCKElD/NYaYAFZwBcbFEdk1xKxh5rn51HzgU3QY0
         6+D2my+C9hTlRPnW/uEPlPBvsmAXBeV0jUhD/LDEPKqLe1RBg06BWql6aXr26Bb8Po9h
         zpW8IRFkD2XFdVep7dhfmP/5GACEakrkKK1UaW9pix1GBM24QSrxUmPsfMnJD4ZdbzAp
         Y0mrFbS80USO+SRlcd5ZWJ8iJqs6Vg6128MJ/twyuBqm0pIiAnSjnF0MDI7Mo4Nm+26r
         4MSw==
X-Forwarded-Encrypted: i=1; AJvYcCXuwZeI5XOFfpGh3s0kIZKni3AvWMv16cv0X0m682W6n26Rs6dfrS1k+iLqri1Qn6W58gDOm4d6+o0yg/p8@vger.kernel.org
X-Gm-Message-State: AOJu0YwVblkQHymaIL6f5G+MbP+9vwS7bD/mOR+shLP1CH4QOp5gpVdO
	UmaFBdT4E74m1nSuUwcZi9+Z5F7MOumv+xHRYP9Rkmxejf1kdaqwSzX8
X-Gm-Gg: ASbGncugmAimtCPYP0yPkereDw02vSdjqKRWrqDgDwLNVrVo0wJwWjqmE2wocWTnDN5
	F0Y4MNgbb3cibcKIBt6nusLzP+rIrva2Ik5Bw0ig2O13FxDAhwlHfgDjPZ5LQUPIxlSHrDGr5Tu
	RKa0FIgScWuS5EJDDa3hNjb30vVwovnCAGH+Fo/uH49C6N8SLJqcVrI8rvlxCpiZ1YaiFGsiU7r
	qfWVE3T6kU4wUjo/YwaBiqGpGccszIccMBUZguu1m61YN6VfylCTOWg9q1yMR9+/MzBrgYPJn1x
	/87FXignHTQDZaFiUdkMF3t61OZ7qzIHswca53Ea0v5NtuFZDc+IDE31DGvSVDCkRz2L12a7Ss+
	oDzrQuTjIch7c7uPHXQ==
X-Google-Smtp-Source: AGHT+IGLxXer8eATe2FRIkXxTqTr2zgcYTUHYytich2j2hXUzi91lDRvJqlblF+//rSNcukGIlDAbw==
X-Received: by 2002:a05:6a21:6d99:b0:232:1668:849f with SMTP id adf61e73a8af0-23dc0ead8femr14666806637.38.1754008075653;
        Thu, 31 Jul 2025 17:27:55 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:74::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd9b3b3d4sm969784b3a.10.2025.07.31.17.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:55 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 10/10] iomap: add granular dirty and writeback accounting
Date: Thu, 31 Jul 2025 17:21:31 -0700
Message-ID: <20250801002131.255068-11-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add granular dirty and writeback accounting for large folios. These
stats are used by the mm layer for dirty balancing and throttling.
Having granular dirty and writeback accounting helps prevent
over-aggressive balancing and throttling.

There are 4 places in iomap this commit affects:
a) filemap dirtying, which now calls filemap_dirty_folio_pages()
b) writeback_iter with setting the wbc->no_stats_accounting bit and
calling clear_dirty_for_io_stats()
c) starting writeback, which now calls __folio_start_writeback()
d) ending writeback, which now calls folio_end_writeback_pages()

This relies on using the ifs->state dirty bitmap to track dirty pages in
the folio. As such, this can only be utilized on filesystems where the
block size >= PAGE_SIZE.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 136 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 128 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcc6e0e5334e..626c3c8399cc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -20,6 +20,8 @@ struct iomap_folio_state {
 	spinlock_t		state_lock;
 	unsigned int		read_bytes_pending;
 	atomic_t		write_bytes_pending;
+	/* number of pages being currently written back */
+	unsigned		nr_pages_writeback;
 
 	/*
 	 * Each block has two bits in this bitmap:
@@ -81,6 +83,25 @@ static inline bool ifs_block_is_dirty(struct folio *folio,
 	return test_bit(block + blks_per_folio, ifs->state);
 }
 
+static unsigned ifs_count_dirty_pages(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	struct inode *inode = folio->mapping->host;
+	unsigned block_size = 1 << inode->i_blkbits;
+	unsigned start_blk = 0;
+	unsigned end_blk = min((unsigned)(i_size_read(inode) >> inode->i_blkbits),
+				i_blocks_per_folio(inode, folio));
+	unsigned nblks = 0;
+
+	while (start_blk < end_blk) {
+		if (ifs_block_is_dirty(folio, ifs, start_blk))
+			nblks++;
+		start_blk++;
+	}
+
+	return nblks * (block_size >> PAGE_SHIFT);
+}
+
 static unsigned ifs_find_dirty_range(struct folio *folio,
 		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
 {
@@ -165,6 +186,63 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
 		ifs_set_range_dirty(folio, ifs, off, len);
 }
 
+static long iomap_get_range_newly_dirtied(struct folio *folio, loff_t pos,
+		unsigned len)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	struct inode *inode = folio->mapping->host;
+	unsigned start_blk = pos >> inode->i_blkbits;
+	unsigned end_blk = min((unsigned)((pos + len - 1) >> inode->i_blkbits),
+				i_blocks_per_folio(inode, folio) - 1);
+	unsigned nblks = 0;
+	unsigned block_size = 1 << inode->i_blkbits;
+
+	while (start_blk <= end_blk) {
+		if (!ifs_block_is_dirty(folio, ifs, start_blk))
+			nblks++;
+		start_blk++;
+	}
+
+	return nblks * (block_size >> PAGE_SHIFT);
+}
+
+static bool iomap_granular_dirty_pages(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	struct inode *inode;
+	unsigned block_size;
+
+	if (!ifs)
+		return false;
+
+	inode = folio->mapping->host;
+	block_size = 1 << inode->i_blkbits;
+
+	if (block_size >= PAGE_SIZE) {
+		WARN_ON(block_size & (PAGE_SIZE - 1));
+		return true;
+	}
+	return false;
+}
+
+static bool iomap_dirty_folio_range(struct address_space *mapping, struct folio *folio,
+			loff_t pos, unsigned len)
+{
+	long nr_new_dirty_pages;
+
+	if (!iomap_granular_dirty_pages(folio)) {
+		iomap_set_range_dirty(folio, pos, len);
+		return filemap_dirty_folio(mapping, folio);
+	}
+
+	nr_new_dirty_pages = iomap_get_range_newly_dirtied(folio, pos, len);
+	if (!nr_new_dirty_pages)
+		return false;
+
+	iomap_set_range_dirty(folio, pos, len);
+	return filemap_dirty_folio_pages(mapping, folio, nr_new_dirty_pages);
+}
+
 static struct iomap_folio_state *ifs_alloc(struct inode *inode,
 		struct folio *folio, unsigned int flags)
 {
@@ -661,8 +739,7 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	size_t len = folio_size(folio);
 
 	ifs_alloc(inode, folio, 0);
-	iomap_set_range_dirty(folio, 0, len);
-	return filemap_dirty_folio(mapping, folio);
+	return iomap_dirty_folio_range(mapping, folio, 0, len);
 }
 EXPORT_SYMBOL_GPL(iomap_dirty_folio);
 
@@ -886,8 +963,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return false;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
-	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
-	filemap_dirty_folio(inode->i_mapping, folio);
+	iomap_dirty_folio_range(inode->i_mapping, folio,
+			offset_in_folio(folio, pos), copied);
 	return true;
 }
 
@@ -1560,6 +1637,29 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 }
 EXPORT_SYMBOL_GPL(iomap_start_folio_write);
 
+static void iomap_folio_start_writeback(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (!iomap_granular_dirty_pages(folio))
+		return folio_start_writeback(folio);
+
+	__folio_start_writeback(folio, false, ifs->nr_pages_writeback);
+}
+
+static void iomap_folio_end_writeback(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	long nr_pages_writeback;
+
+	if (!iomap_granular_dirty_pages(folio))
+		return folio_end_writeback(folio);
+
+	nr_pages_writeback = ifs->nr_pages_writeback;
+	ifs->nr_pages_writeback = 0;
+	folio_end_writeback_pages(folio, nr_pages_writeback);
+}
+
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len)
 {
@@ -1569,7 +1669,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
-		folio_end_writeback(folio);
+		iomap_folio_end_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
@@ -1657,6 +1757,21 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
+static void iomap_update_dirty_stats(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+	long nr_dirty_pages;
+
+	if (iomap_granular_dirty_pages(folio)) {
+		nr_dirty_pages = ifs_count_dirty_pages(folio);
+		ifs->nr_pages_writeback = nr_dirty_pages;
+	} else {
+		nr_dirty_pages = folio_nr_pages(folio);
+	}
+
+	clear_dirty_for_io_stats(folio, nr_dirty_pages);
+}
+
 int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
@@ -1674,6 +1789,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
+	iomap_update_dirty_stats(folio);
+
 	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
 	WARN_ON_ONCE(end_pos <= pos);
@@ -1681,6 +1798,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	if (i_blocks_per_folio(inode, folio) > 1) {
 		if (!ifs) {
 			ifs = ifs_alloc(inode, folio, 0);
+			ifs->nr_pages_writeback = folio_nr_pages(folio);
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
 		}
 
@@ -1698,7 +1816,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * Set the writeback bit ASAP, as the I/O completion for the single
 	 * block per folio case happen hit as soon as we're submitting the bio.
 	 */
-	folio_start_writeback(folio);
+	iomap_folio_start_writeback(folio);
 
 	/*
 	 * Walk through the folio to find dirty areas to write back.
@@ -1731,10 +1849,10 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 */
 	if (ifs) {
 		if (atomic_dec_and_test(&ifs->write_bytes_pending))
-			folio_end_writeback(folio);
+			iomap_folio_end_writeback(folio);
 	} else {
 		if (!wb_pending)
-			folio_end_writeback(folio);
+			iomap_folio_end_writeback(folio);
 	}
 	mapping_set_error(inode->i_mapping, error);
 	return error;
@@ -1756,6 +1874,8 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
+	wpc->wbc->no_stats_accounting = true;
+
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
 		folio_unlock(folio);
-- 
2.47.3


