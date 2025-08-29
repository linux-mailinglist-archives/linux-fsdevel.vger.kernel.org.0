Return-Path: <linux-fsdevel+bounces-59680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B857B3C5B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AB747C48CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A803148B2;
	Fri, 29 Aug 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp5Wcq7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F672609D9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756510810; cv=none; b=D+SJF0pcGeua4bxEq2OSUMd4tn1iVQWtfU4znxmdn71mddUJ89K3uvJs5m/90/AI4R8igFFxM5YSoqVRhTczEJbzEJfuRt+VQMKcTzwt8YTP9frg+Ln14KeVDgJ8/Oq8PGdEPEgxz0Pc4b/Yx+/kcESU/+E2i4XF2YZe9STcmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756510810; c=relaxed/simple;
	bh=uGMqfelnw/tgOC/cTB4VY/uUEDM6rvYyDiolxqavDD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6vD8dEfbPF1ftAuAd14q5/JGHym0WarrBFFHTwa/yBN0T+x+sS3d9Gk/rZW+GjL3hE7sLZS9tMpzvDPFvClx6YsWebCi7IiCNxywXyCYc0+iRfzP6jqd+wQn5rD/bgwx/p1X0gxyFbrNjFe6JOUHpFMY/+5J+4pmgNOAI0xx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp5Wcq7k; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2445827be70so29199175ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756510808; x=1757115608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGpw0mdO7CMkEmFTqe/yJx/RGR5vQk5tTnmLJYozAKc=;
        b=Gp5Wcq7kSMkBcFJuaNOrxL/KbBFdl7JqWtIVhITld/Vs1hgoS4/U9PJEBTCbAKfFvU
         NuOqdtbXGLMJMaaLZK977GwHDqaM6ETRubWRXHeUD2qIPrwtf1DCNoYPFXuGF9VxAV6n
         k40aDKf26CRYDem6uBm2Sslx/gD4kdQn/O5W5VX03GgU3J4NVne9DEfZkWY+kkPQGN2x
         BJgam/JOJxRTQ8Alb2J6L+7wurxGBGIssgDU5lpFceNKhHsk8oayHtwGZYJIoprXL+NB
         6Qk+AEvDdEduG7cTWYevna0t7+g2d/SU1uaPVK24hWwlr8aOJ9NOE4uM3gtRbAs0OQSg
         A64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756510808; x=1757115608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGpw0mdO7CMkEmFTqe/yJx/RGR5vQk5tTnmLJYozAKc=;
        b=B50MYQv9vIMiKdzrNS+pt1m7/CmSL7+ufEGaOR6kDv14YMBhw9kqoknlddze3mmq1V
         pvQIIumQ5m0FzLUMlhC89IYuJwTk+76DpGlFZgIrSYG44+p6C9w4+yhv/yjrYGqaLIro
         0of49GmD1Trycfsbcf6eH6fC52rOpoVH0FWvUNHxPf5oR0lupNmfA89ClgLdIN0xKRXs
         FGlQ6Zeu4J0oOVw3mp3lN+x/cxcX+9AA7fBQ7+Ib1m3smbq5TcKLSEdh2y4SpBjXvVdV
         92gOLScGy01afdwXNuLc3riBuft9xV3/Da+Pu0dKMdtNn49W+8TRlICTDnfsI4UX0598
         P9wA==
X-Forwarded-Encrypted: i=1; AJvYcCVgwri+BAd2JmBLzlQQ+RVZD1p45WhkO4CClWehDLK0RxlAqIeyXo7ROXKwdmPN0b3qFci/W+FnuaHYLUDb@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oj8Y2cMsMfWKDCvpvtomRanT8nKw1lGpkvpI4wJSUvU6bvyf
	DrBGkgfhOIklhw/bmKALXXwgyRpUgQzIiee6510GupLdy9gqC4tQphAt
X-Gm-Gg: ASbGncue9xXVi1cJ4QgOKVuyx3GQpVV/Q5LV0iGt6dNZTFsATXfBaG1ik/twPlNTTw0
	s4f06PKd7/X+evuDTJHb+1fEkFoPdZ3YNign0PVFXAIbaDnapL2hKg9L9cgKcy+vuGzKYMNgtfz
	dHWrtiW9wUZTM/27EJ/sobSqO9QcEODIGA/MGF1CF7ajj2dZaM3LycD+OHNloN9vQuJU+ZuhsI5
	UW0uf3V4s/BP/tAc22a0JlYmXK4BYVIICTuPMI+cZw2K0HLM30oiKvrW0/g225tuMTTJFAIOQbJ
	PGlUZWyZwF5xZdMiZRdWyuv9UM49j8/uqO0SLKMHFiIMBuci25UNv2kEIY5kmUgodlhl8y6jyR0
	/ft0xcLpEjdcA2MZcrzNyD6J0x8g=
X-Google-Smtp-Source: AGHT+IErcgarYy/T/LbpOd01mEs/a9St9zKIi7FuGSacJVKNtjl6t5fcTCh4n3hQ+dLs6MtazbkK0w==
X-Received: by 2002:a17:903:2b0d:b0:248:cb07:6df0 with SMTP id d9443c01a7336-24944a11330mr6113675ad.5.1756510807822;
        Fri, 29 Aug 2025 16:40:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903758b89sm36026645ad.59.2025.08.29.16.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:40:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 12/12] iomap: add granular dirty and writeback accounting
Date: Fri, 29 Aug 2025 16:39:42 -0700
Message-ID: <20250829233942.3607248-13-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829233942.3607248-1-joannelkoong@gmail.com>
References: <20250829233942.3607248-1-joannelkoong@gmail.com>
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
 fs/iomap/buffered-io.c | 140 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 4f021dcaaffe..bf33a5361a39 100644
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
@@ -139,6 +141,29 @@ static unsigned ifs_next_clean_block(struct folio *folio,
 		blks + start_blk) - blks;
 }
 
+static unsigned ifs_count_dirty_pages(struct folio *folio)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned block_size = i_blocksize(inode);
+	unsigned start_blk, end_blk;
+	unsigned blks, nblks = 0;
+
+	start_blk = 0;
+	blks = i_blocks_per_folio(inode, folio);
+	end_blk = (i_size_read(inode) - 1) >> inode->i_blkbits;
+	end_blk = min(end_blk, i_blocks_per_folio(inode, folio) - 1);
+
+	while (start_blk <= end_blk) {
+		start_blk = ifs_next_dirty_block(folio, start_blk, end_blk);
+		if (start_blk > end_blk)
+			break;
+		nblks++;
+		start_blk++;
+	}
+
+	return nblks * (block_size >> PAGE_SHIFT);
+}
+
 static unsigned ifs_find_dirty_range(struct folio *folio,
 		struct iomap_folio_state *ifs, u64 *range_start, u64 range_end)
 {
@@ -220,6 +245,58 @@ static void iomap_set_range_dirty(struct folio *folio, size_t off, size_t len)
 		ifs_set_range_dirty(folio, ifs, off, len);
 }
 
+static long iomap_get_range_newly_dirtied(struct folio *folio, loff_t pos,
+		unsigned len)
+{
+	struct inode *inode = folio->mapping->host;
+	unsigned block_size = i_blocksize(inode);
+	unsigned start_blk, end_blk;
+	unsigned nblks = 0;
+
+	start_blk = pos >> inode->i_blkbits;
+	end_blk = (pos + len - 1) >> inode->i_blkbits;
+	end_blk = min(end_blk, i_blocks_per_folio(inode, folio) - 1);
+
+	while (start_blk <= end_blk) {
+		/* count how many clean blocks there are */
+		start_blk = ifs_next_clean_block(folio, start_blk, end_blk);
+		if (start_blk > end_blk)
+			break;
+		nblks++;
+		start_blk++;
+	}
+
+	return nblks * (block_size >> PAGE_SHIFT);
+}
+
+static bool iomap_granular_dirty_pages(struct folio *folio)
+{
+	struct iomap_folio_state *ifs = folio->private;
+
+	if (!ifs)
+		return false;
+
+	return i_blocksize(folio->mapping->host) >= PAGE_SIZE;
+}
+
+static bool iomap_dirty_folio_range(struct address_space *mapping,
+			struct folio *folio, loff_t pos, unsigned len)
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
@@ -712,8 +789,7 @@ bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
 	size_t len = folio_size(folio);
 
 	ifs_alloc(inode, folio, 0);
-	iomap_set_range_dirty(folio, 0, len);
-	return filemap_dirty_folio(mapping, folio);
+	return iomap_dirty_folio_range(mapping, folio, 0, len);
 }
 EXPORT_SYMBOL_GPL(iomap_dirty_folio);
 
@@ -937,8 +1013,8 @@ static bool __iomap_write_end(struct inode *inode, loff_t pos, size_t len,
 	if (unlikely(copied < len && !folio_test_uptodate(folio)))
 		return false;
 	iomap_set_range_uptodate(folio, offset_in_folio(folio, pos), len);
-	iomap_set_range_dirty(folio, offset_in_folio(folio, pos), copied);
-	filemap_dirty_folio(inode->i_mapping, folio);
+	iomap_dirty_folio_range(inode->i_mapping, folio,
+			offset_in_folio(folio, pos), copied);
 	return true;
 }
 
@@ -1613,6 +1689,29 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
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
@@ -1622,7 +1721,7 @@ void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 	WARN_ON_ONCE(ifs && atomic_read(&ifs->write_bytes_pending) <= 0);
 
 	if (!ifs || atomic_sub_and_test(len, &ifs->write_bytes_pending))
-		folio_end_writeback(folio);
+		iomap_folio_end_writeback(folio);
 }
 EXPORT_SYMBOL_GPL(iomap_finish_folio_write);
 
@@ -1710,6 +1809,21 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
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
@@ -1727,6 +1841,8 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 
 	trace_iomap_writeback_folio(inode, pos, folio_size(folio));
 
+	iomap_update_dirty_stats(folio);
+
 	if (!iomap_writeback_handle_eof(folio, inode, &end_pos))
 		return 0;
 	WARN_ON_ONCE(end_pos <= pos);
@@ -1734,6 +1850,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	if (i_blocks_per_folio(inode, folio) > 1) {
 		if (!ifs) {
 			ifs = ifs_alloc(inode, folio, 0);
+			ifs->nr_pages_writeback = folio_nr_pages(folio);
 			iomap_set_range_dirty(folio, 0, end_pos - pos);
 		}
 
@@ -1751,7 +1868,7 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 	 * Set the writeback bit ASAP, as the I/O completion for the single
 	 * block per folio case happen hit as soon as we're submitting the bio.
 	 */
-	folio_start_writeback(folio);
+	iomap_folio_start_writeback(folio);
 
 	/*
 	 * Walk through the folio to find dirty areas to write back.
@@ -1784,10 +1901,10 @@ int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
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
@@ -1809,6 +1926,13 @@ iomap_writepages(struct iomap_writepage_ctx *wpc)
 			PF_MEMALLOC))
 		return -EIO;
 
+	/*
+	 * iomap opts out of the default wbc stats accounting because it does
+	 * its own granular dirty/writeback accounting (see
+	 * iomap_update_dirty_stats()).
+	 */
+	wpc->wbc->no_stats_accounting = true;
+
 	while ((folio = writeback_iter(mapping, wpc->wbc, folio, &error))) {
 		error = iomap_writeback_folio(wpc, folio);
 		folio_unlock(folio);
-- 
2.47.3


