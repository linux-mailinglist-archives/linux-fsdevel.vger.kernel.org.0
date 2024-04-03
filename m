Return-Path: <linux-fsdevel+bounces-16057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC6E89773A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 19:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800D81C26D1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF1815664D;
	Wed,  3 Apr 2024 17:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XWofgbCO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA5152528;
	Wed,  3 Apr 2024 17:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165048; cv=none; b=cp+JX+7MOHCbIG6RwQ2/iQHv9fCdUcDnNSIT+E2+FeFkhJu8yGmZkLvjE4fyfTYPfFHanooQdxrwcORUMxSWsAUGGbNega6rX4x69Efc4G8KZf7fptVuLyAyOeSeIol6GNRAY8gqEH2KfRd4cD8Caefg6wqPzS+lJLxmiKAgVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165048; c=relaxed/simple;
	bh=9bxa4JAngwV80MxLuPRqrM0gaKW2B7kJlsDhXUehOD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NuVtwY5ZkHQKKC7B8h9h45l/+Pc6M3F3dAKzWnGh5dQQoVJ0wTsb91QJEtHLVA+ULiwgs7jSEBEz2zU0QuheJPAugxv8polip8r0VTnHnWQphM60TD5pI6eh60MzOyGAxf4aoMExEqfOUZJkClkmv/emnShiWgY7Vy7PHdWQ6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XWofgbCO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=tBGp0m4rP+enzlrsf3ccGBNId/y2C42201kaK1fW0Os=; b=XWofgbCOhbVR7Gw3R7ay47Dv2V
	N7V0V4s8LakRTiUDa/L4fakuqLTTtl05FgWBwIFVltewUr2sqBfZePfmSO/TSMldmk9xVnoaof81T
	b4eVM9Xy6CTFq151ZmjRp0cYjjH8eDY6K3n/B6D6hu3HdCvos/QyXFWhhT2bW5lgEgjKa6SUZdBbU
	eUfPLmMeeR+Z8dIEROE0GW0BbgqBzQh7MCPLIbALaTH2+YoinNX7jxcvxwLQd6lu2Iarp835FWieN
	QRPcRC/rBXrOpvB2NKgVKZ0qVBOAl8Y4fz8jEU6R2L9NDFRLXj/09KiuDY0Zn68kv5b5JOZ1YJyhp
	tvaj3kmA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rs4LE-0000000651k-2qHC;
	Wed, 03 Apr 2024 17:24:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev
Subject: [PATCH 4/4] gfs2: Convert gfs2_aspace_writepage() to use a folio
Date: Wed,  3 Apr 2024 18:23:51 +0100
Message-ID: <20240403172400.1449213-5-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403172400.1449213-1-willy@infradead.org>
References: <20240403172400.1449213-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the incoming struct page to a folio and use it throughout.
Saves six calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/meta_io.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f814054c8cd0..2b26e8d529aa 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -32,14 +32,14 @@
 
 static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wbc)
 {
+	struct folio *folio = page_folio(page);
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
 	blk_opf_t write_flags = REQ_META | REQ_PRIO | wbc_to_write_flags(wbc);
 
-	BUG_ON(!PageLocked(page));
-	BUG_ON(!page_has_buffers(page));
+	BUG_ON(!folio_test_locked(folio));
 
-	head = page_buffers(page);
+	head = folio_buffers(folio);
 	bh = head;
 
 	do {
@@ -55,7 +55,7 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 		if (wbc->sync_mode != WB_SYNC_NONE) {
 			lock_buffer(bh);
 		} else if (!trylock_buffer(bh)) {
-			redirty_page_for_writepage(wbc, page);
+			folio_redirty_for_writepage(wbc, folio);
 			continue;
 		}
 		if (test_clear_buffer_dirty(bh)) {
@@ -69,8 +69,8 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 	 * The page and its buffers are protected by PageWriteback(), so we can
 	 * drop the bh refcounts early.
 	 */
-	BUG_ON(PageWriteback(page));
-	set_page_writeback(page);
+	BUG_ON(folio_test_writeback(folio));
+	folio_start_writeback(folio);
 
 	do {
 		struct buffer_head *next = bh->b_this_page;
@@ -80,10 +80,10 @@ static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wb
 		}
 		bh = next;
 	} while (bh != head);
-	unlock_page(page);
+	folio_unlock(folio);
 
 	if (nr_underway == 0)
-		end_page_writeback(page);
+		folio_end_writeback(folio);
 
 	return 0;
 }
-- 
2.43.0


