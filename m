Return-Path: <linux-fsdevel+bounces-41952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF4A39340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8903AC4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6CA1CD1E4;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0ZzdIsU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C01B3955
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857931; cv=none; b=CuFWoFgIYwzdEr/T2CCYQZ7KS96rSoWovCFy3ilUFxuW2D3Eo/letETLwhqd7sjoR+JlvLJ6L+gY1j5aZHfA8WCPsOk616K5K0UyQtI4MKx7JIqc8lRk2d+/Zsb6lrae/kw2Ftif0Bb+O3bUkyOMgRnUkjsKrxyI5/3nceJXB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857931; c=relaxed/simple;
	bh=btYj4Q3A9GjBzsYUp70R77KvhxuOxxjlUukVL1odi0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQBJtLFt/IR+w9mE5oQAx7otuUw6siQ7vkf6vZ8Fhes5tvdmjqSmzsydDF7o/Quar19Ts3nyvUD2Y9RUfomtNuz1y5LEmU3S3Yezl8v949lVURp9Gw7WhQXtCvkoOE2sShvqjB8++0sZIeHdXFXpZehA1+AspQ4xRpzkaclaZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d0ZzdIsU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LFlLLRTVmgKkQKhNmYuJA0ZpitkM3pare4EZQGvBJWA=; b=d0ZzdIsUMGW7mYPvmZhvMXEdJz
	hXym8/R65DPb0VW0TiH0Np9ZzWBnUi9Wmr3ty3pNgnSC6D8a04PSTG8JqCILC/Jg9PTdfUioRLF5o
	IISY+FZDqTetPIWu/AbxFfVuzCENl2XHPJI1xtPARekdR6pm7u3QpjOSk7Q+PAWSM/thII6cgK/wX
	Eq5FjrpgQ2UYAnyosB35exiPpFC2KAgMh/qpds0qr9NSapvVYs18Eobt7kfzmjrxOrRXX5JkTSxUh
	ibzLFMNzetsJNlXMPrDR4iGaRvIaWFPWjgm3TuBU96ekKSSySK/duVZd9gbJteIp3Zv2K0Ishkwuh
	WQw8ek7A==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWd-00000002TsS-1fdx;
	Tue, 18 Feb 2025 05:52:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/27] f2fs: Convert f2fs_write_end_io() to use a folio_iter
Date: Tue, 18 Feb 2025 05:51:48 +0000
Message-ID: <20250218055203.591403-15-willy@infradead.org>
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

Iterate over each folio in the bio instead of each page.
Follow the pattern in ext4 for handling bounce folios.  Removes
a few calls to compound_head() and references to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/data.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 24c5cb1f5ada..5ec4395ef06d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -319,8 +319,7 @@ static void f2fs_read_end_io(struct bio *bio)
 static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
-	struct bio_vec *bvec;
-	struct bvec_iter_all iter_all;
+	struct folio_iter fi;
 
 	iostat_update_and_unbind_ctx(bio);
 	sbi = bio->bi_private;
@@ -328,34 +327,41 @@ static void f2fs_write_end_io(struct bio *bio)
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
 		bio->bi_status = BLK_STS_IOERR;
 
-	bio_for_each_segment_all(bvec, bio, iter_all) {
-		struct page *page = bvec->bv_page;
-		enum count_type type = WB_DATA_TYPE(page, false);
+	bio_for_each_folio_all(fi, bio) {
+		struct folio *folio = fi.folio;
+		enum count_type type;
 
-		fscrypt_finalize_bounce_page(&page);
+		if (fscrypt_is_bounce_folio(folio)) {
+			struct folio *io_folio = folio;
+
+			folio = fscrypt_pagecache_folio(io_folio);
+			fscrypt_free_bounce_page(&io_folio->page);
+		}
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		if (f2fs_is_compressed_page(page)) {
-			f2fs_compress_write_end_io(bio, page);
+		if (f2fs_is_compressed_page(&folio->page)) {
+			f2fs_compress_write_end_io(bio, &folio->page);
 			continue;
 		}
 #endif
 
+		type = WB_DATA_TYPE(&folio->page, false);
+
 		if (unlikely(bio->bi_status)) {
-			mapping_set_error(page->mapping, -EIO);
+			mapping_set_error(folio->mapping, -EIO);
 			if (type == F2FS_WB_CP_DATA)
 				f2fs_stop_checkpoint(sbi, true,
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
-				page_folio(page)->index != nid_of_node(page));
+		f2fs_bug_on(sbi, folio->mapping == NODE_MAPPING(sbi) &&
+				folio->index != nid_of_node(&folio->page));
 
 		dec_page_count(sbi, type);
-		if (f2fs_in_warm_node_list(sbi, page))
-			f2fs_del_fsync_node_entry(sbi, page);
-		clear_page_private_gcing(page);
-		end_page_writeback(page);
+		if (f2fs_in_warm_node_list(sbi, &folio->page))
+			f2fs_del_fsync_node_entry(sbi, &folio->page);
+		clear_page_private_gcing(&folio->page);
+		folio_end_writeback(folio);
 	}
 	if (!get_pages(sbi, F2FS_WB_CP_DATA) &&
 				wq_has_sleeper(&sbi->cp_wait))
-- 
2.47.2


