Return-Path: <linux-fsdevel+bounces-9933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E218463B9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D121C25FC8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED72047A5D;
	Thu,  1 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WInZvy/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4A746436
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827573; cv=none; b=pZGjZWP8e0omO2mbBvcEWfuqAddzMSOeUjH9ydZgZa1EnjURT2fDOKOIEtH0CUq+AVZwlJMPZL6XMh/Fs8iOCFZAEBAG1LETr6ys1pn/1CSpl/CWITuAKxRBPuw/fHKqF834XcFWJyUH1XYMlrPkj9w3qb/Zm9hj4jwNA9RhtgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827573; c=relaxed/simple;
	bh=R/j/mpy5FYdaCA6f5XT3xRhtd4gggV1Y5ODCj9J9xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXZ/SQvCV1+rGjHgLFmCrpZfQU4wSNLVHmJhWqG861UxGoBLWzqTl34LWtRiadczbHDAEMctFzK/EH6heAxjfwwaiPF0LGej6vIPjpvX6IPViq2trEwb18sv/gXXuC7YTBzIVWBrSmyEpjYZv2/aM4aKN0foaWjwlNPH+sipc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WInZvy/F; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4QSquTYLKHZMdgXIzTVuP0S/DNZqzdRCkwu58GLEUNk=; b=WInZvy/F19WIn97ASCVykcpWnn
	mjVvuK0kcL7GRkldeTFI94ooH0Ii+xvAkgkYFkUn2RMNtmxAqOBlLZDQ3x4tRqmtCOxb33ccEyaae
	Xpw9tL12OaTnKStVxtgDBPUnU2lVST1OEKAGUisMAFNpiCbPqD5lv6ICBjje5dlwYa1+QYPdnRaTQ
	ufh/5hqxIlCmp1BHPE6BFaf04Fb+ErpYU1m26VI/crO/xYYj6Cg8c3RYoEhyn85J2napRQETS4XyI
	3OB1x+Mqn3ScyAhwvxveG0XQBJ2X1fN3bPGQTm3RqRDnQNRCdy2M+4prX9Q2ihD7K+0JiN/k2aSQq
	6VQeJtcg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H18Z-38fm;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/13] jfs: Convert dec_io to take a folio
Date: Thu,  1 Feb 2024 22:45:56 +0000
Message-ID: <20240201224605.4055895-8-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201224605.4055895-1-willy@infradead.org>
References: <20240201224605.4055895-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This means also converting the two handlers to take a folio.
Saves four calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 56bd11f9ded5..552e6e97537c 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -135,10 +135,12 @@ static inline void inc_io(struct page *page)
 	atomic_inc(&mp_anchor(page)->io_count);
 }
 
-static inline void dec_io(struct page *page, void (*handler) (struct page *))
+static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
 {
-	if (atomic_dec_and_test(&mp_anchor(page)->io_count))
-		handler(page);
+	struct meta_anchor *anchor = folio->private;
+
+	if (atomic_dec_and_test(&anchor->io_count))
+		handler(folio);
 }
 
 #else
@@ -163,7 +165,7 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 }
 
 #define inc_io(page) do {} while(0)
-#define dec_io(page, handler) handler(page)
+#define dec_io(folio, handler) handler(folio)
 
 #endif
 
@@ -253,11 +255,11 @@ static sector_t metapage_get_blocks(struct inode *inode, sector_t lblock,
 	return lblock;
 }
 
-static void last_read_complete(struct page *page)
+static void last_read_complete(struct folio *folio)
 {
-	if (!PageError(page))
-		SetPageUptodate(page);
-	unlock_page(page);
+	if (!folio_test_error(folio))
+		folio_mark_uptodate(folio);
+	folio_unlock(folio);
 }
 
 static void metapage_read_end_io(struct bio *bio)
@@ -269,7 +271,7 @@ static void metapage_read_end_io(struct bio *bio)
 		folio_set_error(folio);
 	}
 
-	dec_io(&folio->page, last_read_complete);
+	dec_io(folio, last_read_complete);
 	bio_put(bio);
 }
 
@@ -295,13 +297,13 @@ static void remove_from_logsync(struct metapage *mp)
 	LOGSYNC_UNLOCK(log, flags);
 }
 
-static void last_write_complete(struct page *page)
+static void last_write_complete(struct folio *folio)
 {
 	struct metapage *mp;
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(page, offset);
+		mp = page_to_mp(&folio->page, offset);
 		if (mp && test_bit(META_io, &mp->flag)) {
 			if (mp->lsn)
 				remove_from_logsync(mp);
@@ -312,7 +314,7 @@ static void last_write_complete(struct page *page)
 		 * safe unless I have the page locked
 		 */
 	}
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 }
 
 static void metapage_write_end_io(struct bio *bio)
@@ -326,7 +328,7 @@ static void metapage_write_end_io(struct bio *bio)
 		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
 		mapping_set_error(folio->mapping, err);
 	}
-	dec_io(&folio->page, last_write_complete);
+	dec_io(folio, last_write_complete);
 	bio_put(bio);
 }
 
@@ -449,10 +451,10 @@ static int metapage_write_folio(struct folio *folio,
 		       4, bio, sizeof(*bio), 0);
 	bio_put(bio);
 	folio_unlock(folio);
-	dec_io(&folio->page, last_write_complete);
+	dec_io(folio, last_write_complete);
 err_out:
 	while (bad_blocks--)
-		dec_io(&folio->page, last_write_complete);
+		dec_io(folio, last_write_complete);
 	return -EIO;
 }
 
-- 
2.43.0


