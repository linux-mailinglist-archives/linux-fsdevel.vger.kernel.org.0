Return-Path: <linux-fsdevel+bounces-17188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B518A8A94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23A7285F47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA4174ECF;
	Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wBRSrmZj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8926172BD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376624; cv=none; b=kQhG7PC8vqOynWCQuQqhaBmCfCZ4HgijRWTz0ddM5zMuF7o17nlmIwoi/AUdf8oXcwtLuSiNgb1qXdqONHutanc4GlEIEWLOi8O1AlqgLeMXLeJuiJlZZ5TJJB+HnUT1by8ny7w0m1sSve58sBtuFtdeCqmTjfy3z8hahk6CGx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376624; c=relaxed/simple;
	bh=9UfGXYFJaXiX/QPVwGbZJBnefvErg/xze3xXY2rgbts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA/FxWUv4uJMP9gx69lEmUSbQN9foXR6HUMYJCGTvc0VC3bAGvvtu8yIKee98BX9jPp+Ir0EUG4DPPCuej7MmWBm+9T0wPGuJhA2RND2xtaWtUIcYP1R78y6hOqC4Mv6EylAEojYearfDdbbbJ/oTFnTeoROUGKoe03U/3yVxv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wBRSrmZj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=0PCgY0pKLRJKEtVUcAJOm71vipyZh1XinEayZbDdllk=; b=wBRSrmZj7H5v53cuCpt7dhDGvF
	7dtIPP9HiqsHJlioKZugckk3kdpqdA6TmimP2JD7Bl+THXU4Lb42LjxEr11e/poxNoRQR004amI7P
	Vtmf0BJEn7hVRLwqWWMlXoB06lS4XIvfVGTah+QJeA6v8hp/KN5bS8tBwZlKRWcByvT9vIJPqkwfe
	ht7tFCFZA0/6omv0d0i10VsFGeXC3v5yM5Z0NeR1dtb8hn5q1+XGHSwzjEyMR8TRFLwmP+ED47hkk
	TqmFBpaPCR2DOPWTKxPiitnlj/oX4QOrSvMF5KdE9rRNS/vSljgbTYqgxTM0sljciBDbmpnMF1f+t
	jv0x63fQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003Qsz-1DxV;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 04/13] jfs: Convert insert_metapage() to take a folio
Date: Wed, 17 Apr 2024 18:56:48 +0100
Message-ID: <20240417175659.818299-5-willy@infradead.org>
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


