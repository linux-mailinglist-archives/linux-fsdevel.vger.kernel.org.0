Return-Path: <linux-fsdevel+bounces-17326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB778AB8E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C51F217DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD6479DD;
	Sat, 20 Apr 2024 02:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KvloMV0X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7E379F6
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581451; cv=none; b=NGHN2d+Abwc2L3xQcBiaZ4NSRvMEl2yxnLHXl+9qqksfySpCBNUMj/V5VJbS8GODstOpW5554C9T3xw44ws/5Wj6xX9RJ6xsWpdCdo6z/ZNz5KXhX3ofoYAV/SmwYtOhSax73QbbCfERPva+aEi7PvSO8biZ63ikNPxGrg07/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581451; c=relaxed/simple;
	bh=PRX6KlJUsaaPFg8OvVkWBoq4vffTbDR7hsUvhUjcDlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tyfjmBi5syWqtdrdoynWj+EsUh6mmNTkzSXMTHPOijsWtieDBM5PajHM2avaTm/O5eRqNAm7m7zoKycNapdGsjaB2EzECTXrEjvK/9GhFbhCbmF+mQ5wPzrfg0m/eOWF56654Mzf6IkYORRnjaUd2hb+gog+9crzem451MHoyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KvloMV0X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=+AYemDyRNXF7Y77XIBHs0ndHktj5Du5D1auXiCRD6+c=; b=KvloMV0XxZj9W2tlfTOg9g7djT
	5vIh0qK0pUypRKNRA+H6V74R6kQLTodkJkwf9v0qBiWQHzb+ymXDctOdtx81sDsQuLn79rgkponD7
	VvcwM352CxaY8SMvkqA9QBzCSggxIqhNRU+z+3Wi9+aH5EAl6+GPvpyK3DMlbnH68p0da0dTfhvgW
	dNQZ2qu+ZgWeda5f5O9M7PqClrQQRmehdMq4OQuObr9eXC6NPIoWCfPniOMSRAe+JnmhDaG1dm805
	UfOWmSMLsk1EoV082P9hcK7ZoINCGA3GlBGbD9TFftJsfLgZH0MVNt5w4iWgnBjnALmy2JLkSYaMh
	Ep7lL0Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oQ-000000095eH-3AlU;
	Sat, 20 Apr 2024 02:50:46 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net
Subject: [PATCH 05/30] jfs: Remove use of folio error flag
Date: Sat, 20 Apr 2024 03:50:00 +0100
Message-ID: <20240420025029.2166544-6-willy@infradead.org>
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

Store the blk_status per folio (if we can have multiple metapages per
folio) instead of setting the folio error flag.  This will allow us to
reclaim a precious folio flag shortly.

Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 47 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 19854bd8dfea..df575a873ec6 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -76,6 +76,7 @@ static mempool_t *metapage_mempool;
 struct meta_anchor {
 	int mp_count;
 	atomic_t io_count;
+	blk_status_t status;
 	struct metapage *mp[MPS_PER_PAGE];
 };
 
@@ -138,12 +139,16 @@ static inline void inc_io(struct folio *folio)
 	atomic_inc(&anchor->io_count);
 }
 
-static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
+static inline void dec_io(struct folio *folio, blk_status_t status,
+		void (*handler)(struct folio *, blk_status_t))
 {
 	struct meta_anchor *anchor = folio->private;
 
+	if (anchor->status == BLK_STS_OK)
+		anchor->status = status;
+
 	if (atomic_dec_and_test(&anchor->io_count))
-		handler(folio);
+		handler(folio, anchor->status);
 }
 
 #else
@@ -168,7 +173,7 @@ static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 }
 
 #define inc_io(folio) do {} while(0)
-#define dec_io(folio, handler) handler(folio)
+#define dec_io(folio, status, handler) handler(folio, status)
 
 #endif
 
@@ -258,23 +263,20 @@ static sector_t metapage_get_blocks(struct inode *inode, sector_t lblock,
 	return lblock;
 }
 
-static void last_read_complete(struct folio *folio)
+static void last_read_complete(struct folio *folio, blk_status_t status)
 {
-	if (!folio_test_error(folio))
-		folio_mark_uptodate(folio);
-	folio_unlock(folio);
+	if (status)
+		printk(KERN_ERR "Read error %d at %#llx\n", status,
+				folio_pos(folio));
+
+	folio_end_read(folio, status == 0);
 }
 
 static void metapage_read_end_io(struct bio *bio)
 {
 	struct folio *folio = bio->bi_private;
 
-	if (bio->bi_status) {
-		printk(KERN_ERR "metapage_read_end_io: I/O error\n");
-		folio_set_error(folio);
-	}
-
-	dec_io(folio, last_read_complete);
+	dec_io(folio, bio->bi_status, last_read_complete);
 	bio_put(bio);
 }
 
@@ -300,11 +302,17 @@ static void remove_from_logsync(struct metapage *mp)
 	LOGSYNC_UNLOCK(log, flags);
 }
 
-static void last_write_complete(struct folio *folio)
+static void last_write_complete(struct folio *folio, blk_status_t status)
 {
 	struct metapage *mp;
 	unsigned int offset;
 
+	if (status) {
+		int err = blk_status_to_errno(status);
+		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
+		mapping_set_error(folio->mapping, err);
+	}
+
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
 		mp = folio_to_mp(folio, offset);
 		if (mp && test_bit(META_io, &mp->flag)) {
@@ -326,12 +334,7 @@ static void metapage_write_end_io(struct bio *bio)
 
 	BUG_ON(!folio->private);
 
-	if (bio->bi_status) {
-		int err = blk_status_to_errno(bio->bi_status);
-		printk(KERN_ERR "metapage_write_end_io: I/O error\n");
-		mapping_set_error(folio->mapping, err);
-	}
-	dec_io(folio, last_write_complete);
+	dec_io(folio, bio->bi_status, last_write_complete);
 	bio_put(bio);
 }
 
@@ -454,10 +457,10 @@ static int metapage_write_folio(struct folio *folio,
 		       4, bio, sizeof(*bio), 0);
 	bio_put(bio);
 	folio_unlock(folio);
-	dec_io(folio, last_write_complete);
+	dec_io(folio, BLK_STS_OK, last_write_complete);
 err_out:
 	while (bad_blocks--)
-		dec_io(folio, last_write_complete);
+		dec_io(folio, BLK_STS_OK, last_write_complete);
 	return -EIO;
 }
 
-- 
2.43.0


