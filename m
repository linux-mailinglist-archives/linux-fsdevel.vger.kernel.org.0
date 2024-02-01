Return-Path: <linux-fsdevel+bounces-9926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4AF84639F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC96F1C22BB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F344652D;
	Thu,  1 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V7kqggJW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917346435
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827571; cv=none; b=SvgppewZtSJck/9xDptqMlQB32WQ+mK9GWzSjsRhe3dcogxBvtMTIRS23+WjJkpYjEBl3/pi3c/4ubSWWw1tIxPovIX/4ujuzqeTUha7DJEeirbIKuzLZXzIpQykppCROCbvjRU/lVBD7YKOBtQhh9mmO2ngUrcNAJrRreQClIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827571; c=relaxed/simple;
	bh=9UfGXYFJaXiX/QPVwGbZJBnefvErg/xze3xXY2rgbts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/Nhi2z65+puAIYY1ZdoDyPICSqI050C/KthQKD9+WmHNzi9XCvAGLFE5SBfHDjjtfKq/QxeCX9K9gZy3Zc6JeIAmANHKYZ8OEXqadbe7XVWqXduYZmrEliv8sfXRIC1Xi/O+eR6/QR2psifMzVbPuyrWxbwvJUyyuxD8HdlNZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V7kqggJW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0PCgY0pKLRJKEtVUcAJOm71vipyZh1XinEayZbDdllk=; b=V7kqggJWTFobmagcdS+o+4XOKy
	t+Jaj1dMmUDxBHQJjWW6icjRRreB/Mw81Na/4njTF+pItVYvn04w817e4CyKKzVLU7tvvFJCs0vWo
	a5hZ4CVsT7szRfZMKDMWJq+/6tv+auUlQx+Sek3L1lDy//bt59b2CHBurLlVODSLzUtb9YpvgsaVn
	xC3UOHdvselrCjxm5yNOgtem/kQkcCTBEcVofTq295SjsfaZUAeL2Gix7fm12Bkn6U03uWiPGfp6q
	5lKyt7VuTdZAXJwHDseLApqiWTMvYnTdsmf8TlXOVmaajJ+m7RefDgMMPckgIAc4Kj7ZcJzUxPp83
	nwczSmJw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H18E-1lCB;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/13] jfs: Convert insert_metapage() to take a folio
Date: Thu,  1 Feb 2024 22:45:53 +0000
Message-ID: <20240201224605.4055895-5-willy@infradead.org>
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

Both of its callers now have a folio, so convert this function.
Use folio_attach_private() instead of manually setting folio->private.
This also gets the expected refcount of the folio correct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 4ef85e264f51..6fa7023f5bc9 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -87,25 +87,23 @@ static inline struct metapage *page_to_mp(struct page *page, int offset)
 	return mp_anchor(page)->mp[offset >> L2PSIZE];
 }
 
-static inline int insert_metapage(struct page *page, struct metapage *mp)
+static inline int insert_metapage(struct folio *folio, struct metapage *mp)
 {
 	struct meta_anchor *a;
 	int index;
 	int l2mp_blocks;	/* log2 blocks per metapage */
 
-	if (PagePrivate(page))
-		a = mp_anchor(page);
-	else {
+	a = folio->private;
+	if (!a) {
 		a = kzalloc(sizeof(struct meta_anchor), GFP_NOFS);
 		if (!a)
 			return -ENOMEM;
-		set_page_private(page, (unsigned long)a);
-		SetPagePrivate(page);
-		kmap(page);
+		folio_attach_private(folio, a);
+		kmap(&folio->page);
 	}
 
 	if (mp) {
-		l2mp_blocks = L2PSIZE - page->mapping->host->i_blkbits;
+		l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
 		index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
 		a->mp_count++;
 		a->mp[index] = mp;
@@ -127,8 +125,7 @@ static inline void remove_metapage(struct page *page, struct metapage *mp)
 	a->mp[index] = NULL;
 	if (--a->mp_count == 0) {
 		kfree(a);
-		set_page_private(page, 0);
-		ClearPagePrivate(page);
+		detach_page_private(page);
 		kunmap(page);
 	}
 }
@@ -150,20 +147,18 @@ static inline struct metapage *page_to_mp(struct page *page, int offset)
 	return PagePrivate(page) ? (struct metapage *)page_private(page) : NULL;
 }
 
-static inline int insert_metapage(struct page *page, struct metapage *mp)
+static inline int insert_metapage(struct folio *folio, struct metapage *mp)
 {
 	if (mp) {
-		set_page_private(page, (unsigned long)mp);
-		SetPagePrivate(page);
-		kmap(page);
+		folio_attach_private(folio, mp);
+		kmap(&folio->page);
 	}
 	return 0;
 }
 
 static inline void remove_metapage(struct page *page, struct metapage *mp)
 {
-	set_page_private(page, 0);
-	ClearPagePrivate(page);
+	detach_page_private(page);
 	kunmap(page);
 }
 
@@ -496,7 +491,7 @@ static int metapage_read_folio(struct file *fp, struct folio *folio)
 					     &xlen);
 		if (pblock) {
 			if (!folio->private)
-				insert_metapage(&folio->page, NULL);
+				insert_metapage(folio, NULL);
 			inc_io(&folio->page);
 			if (bio)
 				submit_bio(bio);
@@ -658,7 +653,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		mp->logical_size = size;
 		mp->data = folio_address(folio) + page_offset;
 		mp->index = lblock;
-		if (unlikely(insert_metapage(&folio->page, mp))) {
+		if (unlikely(insert_metapage(folio, mp))) {
 			free_metapage(mp);
 			goto unlock;
 		}
-- 
2.43.0


