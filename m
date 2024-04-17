Return-Path: <linux-fsdevel+bounces-17191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AEC8A8AA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6A0B23E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938F5175555;
	Wed, 17 Apr 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KPuJI7ig"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987A173332
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376625; cv=none; b=WggRqETal4ZQ6NjiJELG5iDEk9OFdK6T/vxlGLz+WG9Z6GTeICSncalvutyY/ZCvzN/zGuE8FZKTYpnpNlsiZbF/D/QVOCEj9y1xLxhas0/STiHXjglQI5dKYCLjgK+lF/XRW0qWRpCXjKhZMoUw9QHZi508fMjgJmtnbRsKT5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376625; c=relaxed/simple;
	bh=GwMD92vvwZZEXt9Yhr9D2aB8qaNM6YrSg8WK3m2JGsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyZ2fenXwUclmC4HQnsmNZ/QRe4opYWnoJL19U9yZIPBzfRQVYzE2gssnlLR/z8GXhwl1Lc2dMkzf1bOc88gNcDZKBuoZsoC2Leq0CEJlvgnSZWPh/sDwmSxLUX/rjBzROCMRzMMX7Nc0BkBK8272Yu2/ajpH3A2m5JVB7Y8hQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KPuJI7ig; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=70jxymNpw9Th1vyC07ZqXoHBqQpblwJUSywRcB4Q7KY=; b=KPuJI7igms+Ot2DNxNt1uDBx7R
	PHvwZmpFfFs5yE/f70BlwDyOEKQN2UiXDdFWYWz3SwYGRNiXvqxw4uZXDfhbO92ckMHUicnGEz8rH
	JAnFj03oFVkGumqd08PnzuK+h0NHrEYGe0xu0DobStFr6ExZa3s4seBZqFuFwvLxtiutHZvU8VTsg
	stWUV3fEuR81FWHFpavScJ5//QHfyQKVNwzfg/rDg+wEp3z28dZ60xutOialFbdZn+bEfSKOGAQbk
	PmKbX+XWfap9dRXKmi6bXTeRExUJdivUTy6/j4Vo3sTdWnrHzdRjdoOKjzjHZH4FxFmlMJjG7uWZN
	CfenH9AA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003QtL-2wUa;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/13] jfs: Convert dec_io to take a folio
Date: Wed, 17 Apr 2024 18:56:51 +0100
Message-ID: <20240417175659.818299-8-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417175659.818299-1-willy@infradead.org>
References: <20240417175659.818299-1-willy@infradead.org>
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
index 9fc52c27b0ce..dd540df0a617 100644
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


