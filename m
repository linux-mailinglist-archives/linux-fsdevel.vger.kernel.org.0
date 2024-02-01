Return-Path: <linux-fsdevel+bounces-9929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ADA8463A7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E207428E8EE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2835E47768;
	Thu,  1 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bjawtGmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFD45BF3
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827572; cv=none; b=mrn/GM9MlXDk0rS2iGdWuUVtZKMA0C1fPArRHmuSxqVvboqRjj+zt6B+wUwleBkfKsMl3hbHMlT3QIb2CSidd28d2YMmnBgnNnBMU3lLsx7ay/HD5Y2u/+6ocPBc6a9pFaX0S+wKsyAe/lJeQJXJnT4TTJhyL63a3TT4yow0jmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827572; c=relaxed/simple;
	bh=cURxK2KUshULHqrONMckeuplfDrRc1Fmb34cL83urOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiJ8YfqgrszWThg9by9MrFXNLG1HyrPxghZB4RBE9sN89DJ8GbFhwswetLpp9Q33JhRMwIh8G9kYfxBgC3+rZ9E+OroLIASpG5fyLHR65FvAKskFrdYgckPMc3D4RMByDi5Vbj/1/fIcw8VC5aWHbA/ux3MpT/W6UUHl38jA0Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bjawtGmG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=SEpa6480I+pdiTlB5C3vLDzZUjMsrv32xMAaAlalAus=; b=bjawtGmGb34tM5sVRDqHL+w8q4
	TvczJWUJXrGM/KJMcNTq28RvhuxlhnSWTRSVIuxe7uu+/5PElWli9PuatNUxe6uYy5zqtUjyOfxJT
	PmXvc7a1w5pTg0ONF4f3V+eb+1yJjBX2Y/yNIAvbTaCUVe8+I6MFinY/u1UMt8nAvDInQl8GWj7O2
	d+fsxzIhZFDpR3HQ8GwxB57J4rZshhgFZEWKi4I+BZhNgDPYOkLZx5vlyy3podanMjlEt3s+FVJqM
	6UtjXXGkgMvSBIuuQKYFFbFBdpQK9ZVjPMZX4zGrckrX2C+u76LmtsiF1mcwPAnlabdoAu86fE4bR
	F8LQlgCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfou-0000000H198-1YSo;
	Thu, 01 Feb 2024 22:46:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/13] jfs: Change metapage->page to metapage->folio
Date: Thu,  1 Feb 2024 22:46:01 +0000
Message-ID: <20240201224605.4055895-13-willy@infradead.org>
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
index cb6d1fda66a7..985486aa7abf 100644
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
index 23e81d713c62..d2578860b630 100644
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
@@ -648,7 +648,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		mp = alloc_metapage(GFP_NOFS);
 		if (!mp)
 			goto unlock;
-		mp->page = &folio->page;
+		mp->folio = folio;
 		mp->sb = inode->i_sb;
 		mp->flag = 0;
 		mp->xflag = COMMIT_PAGE;
@@ -681,11 +681,11 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
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
@@ -718,7 +718,7 @@ static int metapage_write_one(struct folio *folio)
 
 void force_metapage(struct metapage *mp)
 {
-	struct folio *folio = page_folio(mp->page);
+	struct folio *folio = mp->folio;
 	jfs_info("force_metapage: mp = 0x%p", mp);
 	set_bit(META_forcewrite, &mp->flag);
 	clear_bit(META_sync, &mp->flag);
@@ -733,26 +733,26 @@ void force_metapage(struct metapage *mp)
 
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


