Return-Path: <linux-fsdevel+bounces-17195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A94F8A8AAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFAA1F243A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EDB176FBE;
	Wed, 17 Apr 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wQQ90zw5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFC173354
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376626; cv=none; b=BTuAQFgtNQRt0wuaGnfhKx/XaqASB1ksL/ISqUB44wQ/qoZy8ntOOlDQ8ZGxoHVWj5AL1gJCDKafgSGxC3BOIzjec+aHW2t9BI3pDBU0k8zfNqb2PmXj5Zjq2o+2HVXPNHaZqUUUlSVMDZlxXn8+r3pS9ux/NGi6l2XS5Z60/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376626; c=relaxed/simple;
	bh=aGNDPdwYiFts6uu0/k7lNpsnxDs45dhWAL1nw0VUA2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyilwRIiG5Bf6pRfZlOZOAmTTzS5AYFk6H/8fItjR2i/eUmPPmfF6nbqONZwX+zvgygaMZzMR4cUciVGT87XF16J2f8b3cWIh4zIKb4OXvDM/YQMhuiHqF4MEMA5MvE+T0S6RbdhiUmz0IIg97Gvsr0CgmWT/I4UBzO0m87y/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wQQ90zw5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=yJvA2xiVaXaAWuVDhUJWcuurFOmXe1XpmHEJxpnBpFs=; b=wQQ90zw5gCxgjOcfC0NTK0TSeO
	8bm6W0yyJHKUXy0c7fc7D1+PXw6WNS2rwTxadtc34+xG69R5Z1ueQrBesG9TIwk47AYxGzaFxclFa
	/u/cHLT2wJio1vyBr74ti2ArQwxybJRWJ0RiRqnVIZyPCz8rXiOOCoFA4MaJD89bMmMrW1sLNssPK
	U/kkYKUtdygZ9/TXvRSrIWUBmrikV0y2KyzXfGf7dCxi2rPgehkTDueD3Yax/p28cqj58IvFQ0OWN
	s6+vR1Htby4+oOO5wyl/Uhcc8JPCpvxoHU/k3kLgCDJ42cEYiUN69jraRm5vwW0/Dgxzov6eyIzXR
	VeTiVCKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wo-00000003Qty-3fNE;
	Wed, 17 Apr 2024 17:57:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 12/13] jfs: Change metapage->page to metapage->folio
Date: Wed, 17 Apr 2024 18:56:56 +0100
Message-ID: <20240417175659.818299-13-willy@infradead.org>
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

Convert all the users to operate on a folio.  Saves sixteen calls to
compound_head().  We still use sizeof(struct page) in print_hex_dump,
otherwise it will go into the second and third pages of the folio which
won't exist for jfs folios (since they are not large).  This needs a
better solution, but finding it can be postponed.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_logmgr.c   |  2 +-
 fs/jfs/jfs_metapage.c | 26 +++++++++++++-------------
 fs/jfs/jfs_metapage.h | 16 ++++++++--------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9609349e92e5..270808b6219b 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1600,7 +1600,7 @@ void jfs_flush_journal(struct jfs_log *log, int wait)
 					       mp, sizeof(struct metapage), 0);
 				print_hex_dump(KERN_ERR, "page: ",
 					       DUMP_PREFIX_ADDRESS, 16,
-					       sizeof(long), mp->page,
+					       sizeof(long), mp->folio,
 					       sizeof(struct page), 0);
 			} else
 				print_hex_dump(KERN_ERR, "tblock:",
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index c88a7bc3f736..19854bd8dfea 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -47,9 +47,9 @@ static inline void __lock_metapage(struct metapage *mp)
 	do {
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		if (metapage_locked(mp)) {
-			unlock_page(mp->page);
+			folio_unlock(mp->folio);
 			io_schedule();
-			lock_page(mp->page);
+			folio_lock(mp->folio);
 		}
 	} while (trylock_metapage(mp));
 	__set_current_state(TASK_RUNNING);
@@ -57,7 +57,7 @@ static inline void __lock_metapage(struct metapage *mp)
 }
 
 /*
- * Must have mp->page locked
+ * Must have mp->folio locked
  */
 static inline void lock_metapage(struct metapage *mp)
 {
@@ -649,7 +649,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		mp = alloc_metapage(GFP_NOFS);
 		if (!mp)
 			goto unlock;
-		mp->page = &folio->page;
+		mp->folio = folio;
 		mp->sb = inode->i_sb;
 		mp->flag = 0;
 		mp->xflag = COMMIT_PAGE;
@@ -682,11 +682,11 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 void grab_metapage(struct metapage * mp)
 {
 	jfs_info("grab_metapage: mp = 0x%p", mp);
-	get_page(mp->page);
-	lock_page(mp->page);
+	folio_get(mp->folio);
+	folio_lock(mp->folio);
 	mp->count++;
 	lock_metapage(mp);
-	unlock_page(mp->page);
+	folio_unlock(mp->folio);
 }
 
 static int metapage_write_one(struct folio *folio)
@@ -719,7 +719,7 @@ static int metapage_write_one(struct folio *folio)
 
 void force_metapage(struct metapage *mp)
 {
-	struct folio *folio = page_folio(mp->page);
+	struct folio *folio = mp->folio;
 	jfs_info("force_metapage: mp = 0x%p", mp);
 	set_bit(META_forcewrite, &mp->flag);
 	clear_bit(META_sync, &mp->flag);
@@ -734,26 +734,26 @@ void force_metapage(struct metapage *mp)
 
 void hold_metapage(struct metapage *mp)
 {
-	lock_page(mp->page);
+	folio_lock(mp->folio);
 }
 
 void put_metapage(struct metapage *mp)
 {
 	if (mp->count || mp->nohomeok) {
 		/* Someone else will release this */
-		unlock_page(mp->page);
+		folio_unlock(mp->folio);
 		return;
 	}
-	get_page(mp->page);
+	folio_get(mp->folio);
 	mp->count++;
 	lock_metapage(mp);
-	unlock_page(mp->page);
+	folio_unlock(mp->folio);
 	release_metapage(mp);
 }
 
 void release_metapage(struct metapage * mp)
 {
-	struct folio *folio = page_folio(mp->page);
+	struct folio *folio = mp->folio;
 	jfs_info("release_metapage: mp = 0x%p, flag = 0x%lx", mp, mp->flag);
 
 	folio_lock(folio);
diff --git a/fs/jfs/jfs_metapage.h b/fs/jfs/jfs_metapage.h
index 4179f9df4deb..2e5015c2705b 100644
--- a/fs/jfs/jfs_metapage.h
+++ b/fs/jfs/jfs_metapage.h
@@ -24,7 +24,7 @@ struct metapage {
 	wait_queue_head_t wait;
 
 	/* implementation */
-	struct page *page;
+	struct folio *folio;
 	struct super_block *sb;
 	unsigned int logical_size;
 
@@ -90,14 +90,14 @@ static inline void discard_metapage(struct metapage *mp)
 
 static inline void metapage_nohomeok(struct metapage *mp)
 {
-	struct page *page = mp->page;
-	lock_page(page);
+	struct folio *folio = mp->folio;
+	folio_lock(folio);
 	if (!mp->nohomeok++) {
 		mark_metapage_dirty(mp);
-		get_page(page);
-		wait_on_page_writeback(page);
+		folio_get(folio);
+		folio_wait_writeback(folio);
 	}
-	unlock_page(page);
+	folio_unlock(folio);
 }
 
 /*
@@ -107,7 +107,7 @@ static inline void metapage_nohomeok(struct metapage *mp)
 static inline void metapage_wait_for_io(struct metapage *mp)
 {
 	if (test_bit(META_io, &mp->flag))
-		wait_on_page_writeback(mp->page);
+		folio_wait_writeback(mp->folio);
 }
 
 /*
@@ -116,7 +116,7 @@ static inline void metapage_wait_for_io(struct metapage *mp)
 static inline void _metapage_homeok(struct metapage *mp)
 {
 	if (!--mp->nohomeok)
-		put_page(mp->page);
+		folio_put(mp->folio);
 }
 
 static inline void metapage_homeok(struct metapage *mp)
-- 
2.43.0


