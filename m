Return-Path: <linux-fsdevel+bounces-41945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDBBA39335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778AC1890BAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804F1C3C07;
	Tue, 18 Feb 2025 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ro41HNEt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF34A1B0F18
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857930; cv=none; b=Hfl065vf7/O7cHYhuOsWEkoRRWsJNrBmQTkBKh+HA+psviVrX2c/E6ikZCQPT4LhtTqa89IFOFb7QXqnGSy7J4dvouBJT8NsJXgD4OlTtgdV9b7Rh2gpdsf/0wR9b3lqEtQTTiECVzwUNAiC/Q6FGmC0lE1HSofU9E3XHzdl4Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857930; c=relaxed/simple;
	bh=xmvvLKU6S0oSkqz1hMaZs08cba4+OFQ5IYNynPrldYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hT4R9bBC4KfVYEZ6ckbXXHRZEGGiSK+7KMnmpo395oPP8++DA4Tyh2fmpwpVORBScaxJg/ymR11d9aGBXCY2uDUVFuOZ+4L+XC+4Atbrg7MV+9UtpF6RHpsa0jDQntuExpJDv3HAy61AWf/1MTR6qeC+fgYLznyBg7duduVHFKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ro41HNEt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YLhaJqMFtJssujjlGsqYJzBlDzSSPVjntuvommLyzm4=; b=Ro41HNEt4KXKyLQfksiukOOls+
	Y7p6AepqIaMsBeQ4/cbftPxr8QURdlytyph0GxW/JRpNBmQbVTFSV479ldDi3HhwIWHn7n1FywvO5
	Qb14o3Qr9Py6kHNlTxkFFkBRzdnoHBAQk01bOdTRVfL82zwrZ6Ysov0QD5OBfApSoY4SOMpOg7Vkv
	X7aUPqkYE5BIKoPk7AJ0w300O0wDhTQD1GcTbOAOUA/luEUDW6S8RHckBzpEvJuoZqEcFgsENwmOK
	fI7E6AD+V2F0IeBhgFhJHuYRVleS9Y58QjAeZUPfpB8igSTVbTeHjn+G96At86F/NFF44xp+lVkn+
	dkkcb4Ew==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWc-00000002Trk-1SGJ;
	Tue, 18 Feb 2025 05:52:06 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/27] f2fs: Convert last_fsync_dnode() to use a folio
Date: Tue, 18 Feb 2025 05:51:42 +0000
Message-ID: <20250218055203.591403-9-willy@infradead.org>
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

Use the folio APIs where they exist.  Saves several hidden calls to
compound_head().  Also removes a reference to page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/node.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 415bda9acd0e..66260fae3cc8 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1565,7 +1565,7 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 {
 	pgoff_t index;
 	struct folio_batch fbatch;
-	struct page *last_page = NULL;
+	struct folio *last_folio = NULL;
 	int nr_folios;
 
 	folio_batch_init(&fbatch);
@@ -1577,45 +1577,45 @@ static struct page *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 		int i;
 
 		for (i = 0; i < nr_folios; i++) {
-			struct page *page = &fbatch.folios[i]->page;
+			struct folio *folio = fbatch.folios[i];
 
 			if (unlikely(f2fs_cp_error(sbi))) {
-				f2fs_put_page(last_page, 0);
+				f2fs_folio_put(last_folio, false);
 				folio_batch_release(&fbatch);
 				return ERR_PTR(-EIO);
 			}
 
-			if (!IS_DNODE(page) || !is_cold_node(page))
+			if (!IS_DNODE(&folio->page) || !is_cold_node(&folio->page))
 				continue;
-			if (ino_of_node(page) != ino)
+			if (ino_of_node(&folio->page) != ino)
 				continue;
 
-			lock_page(page);
+			folio_lock(folio);
 
-			if (unlikely(page->mapping != NODE_MAPPING(sbi))) {
+			if (unlikely(folio->mapping != NODE_MAPPING(sbi))) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
-			if (ino_of_node(page) != ino)
+			if (ino_of_node(&folio->page) != ino)
 				goto continue_unlock;
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (last_page)
-				f2fs_put_page(last_page, 0);
+			if (last_folio)
+				f2fs_folio_put(last_folio, false);
 
-			get_page(page);
-			last_page = page;
-			unlock_page(page);
+			folio_get(folio);
+			last_folio = folio;
+			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
-	return last_page;
+	return &last_folio->page;
 }
 
 static int __write_node_page(struct page *page, bool atomic, bool *submitted,
-- 
2.47.2


