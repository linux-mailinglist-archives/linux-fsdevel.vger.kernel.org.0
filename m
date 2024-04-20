Return-Path: <linux-fsdevel+bounces-17332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1498AB8EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55093281BB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87C913ADC;
	Sat, 20 Apr 2024 02:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oswz8Xuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9CDF6C;
	Sat, 20 Apr 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581454; cv=none; b=oHCCX03eh1NYAwx2KPS1NFlsvzEk3g7VbxT5qrFRyJpxFPSfHo4waL249BHbSox5dpB5UgncEXMgW4Kw/TtqyRxfYnx38w6gdQy8jmEXWpknBYQsg+gijnBjke9NjQaHcFi1gBvaqG/6pZJ2wUm9hcRZPqJKPPQR4Od5ZeIaOCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581454; c=relaxed/simple;
	bh=0pUhsRmxI57MJbaxxpksnWkU0obUAmCXJosmad6eEok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=owcWlQ1sw9NL7cbUQrLk8XviA6JXBKQxfVNyt3+8c7j64/ZGtVKWryX6WMVtHJD1fdvdkoBcdyupfRs+hgdrj/okksMGv6TNmBZFODCzEqTT3ioSsJBPeC88Je0gPDhCxv4a3P5vC0EhIYW9spGr1eZ46vPbSuSTFOkHgUozUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oswz8Xuq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dNECBjnrSSu5e/nvTW6lm2Csp1lUOxKAeyT8FWOeI68=; b=oswz8Xuq7L0CKI1a3NqA3G3jRw
	VcrviRBG60j7Fk2f/5UKOMBIE8SK70zDo7Lnoo66jGDqMwttPRKz5cAaDAygba1D0tHEho3mGqyGt
	N/Aqc5xPlBK3LAkTL+skBwE+RYzFk7uBw91W4OOP3PcgQeveAs9o9Y9kN7i8/qunDdduWOC1P8lg6
	vo13HtktVbS6UNojDReIhWkDBnWBXbPkP0V56hDajxZUtKOGGdsv+o89hw48bqo/GB3T365GITcPG
	v+GUdLPnbHhWIY2nZUBiMwxTqT6+T5aWVi6bsgVwV+Q65G4RyjTdHjGQVuG5YdW/4u7pcECE7H+Ar
	/r7HmNSA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oT-000000095es-3oI4;
	Sat, 20 Apr 2024 02:50:50 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 10/30] ext4: Remove calls to to set/clear the folio error flag
Date: Sat, 20 Apr 2024 03:50:05 +0100
Message-ID: <20240420025029.2166544-11-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks this flag on ext4 folios, stop setting and clearing it.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext4/move_extent.c | 4 +---
 fs/ext4/page-io.c     | 3 ---
 fs/ext4/readpage.c    | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 7cd4afa4de1d..204f53b23622 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -199,10 +199,8 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 			continue;
 		if (!buffer_mapped(bh)) {
 			err = ext4_get_block(inode, block, bh, 0);
-			if (err) {
-				folio_set_error(folio);
+			if (err)
 				return err;
-			}
 			if (!buffer_mapped(bh)) {
 				folio_zero_range(folio, block_start, blocksize);
 				set_buffer_uptodate(bh);
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 312bc6813357..ad5543866d21 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -117,7 +117,6 @@ static void ext4_finish_bio(struct bio *bio)
 
 		if (bio->bi_status) {
 			int err = blk_status_to_errno(bio->bi_status);
-			folio_set_error(folio);
 			mapping_set_error(folio->mapping, err);
 		}
 		bh = head = folio_buffers(folio);
@@ -441,8 +440,6 @@ int ext4_bio_write_folio(struct ext4_io_submit *io, struct folio *folio,
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(folio_test_writeback(folio));
 
-	folio_clear_error(folio);
-
 	/*
 	 * Comments copied from block_write_full_folio:
 	 *
diff --git a/fs/ext4/readpage.c b/fs/ext4/readpage.c
index 21e8f0aebb3c..8494492582ab 100644
--- a/fs/ext4/readpage.c
+++ b/fs/ext4/readpage.c
@@ -289,7 +289,6 @@ int ext4_mpage_readpages(struct inode *inode,
 
 				if (ext4_map_blocks(NULL, inode, &map, 0) < 0) {
 				set_error_page:
-					folio_set_error(folio);
 					folio_zero_segment(folio, 0,
 							  folio_size(folio));
 					folio_unlock(folio);
-- 
2.43.0


