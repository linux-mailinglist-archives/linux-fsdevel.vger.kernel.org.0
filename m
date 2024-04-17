Return-Path: <linux-fsdevel+bounces-17196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D448A8AAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC75286F28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAD5176FC5;
	Wed, 17 Apr 2024 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FR9aHjN7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC317173339
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376626; cv=none; b=bv6lV6OgQ23Gk83gVEQsH5mdYpbHGOpKqZKGAbzIkbh5mknGZP9jyRZWIOGLkjbWdwh3goT9OpY7tXj7yfGwLaY2BcPb/BzeFrAD80qp6QBcbjXZRaYdpTDpa0l2TplqC+mGs+CGl2P7Wxe/Niv+zB08upJ0hxrsBwgH43t3ffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376626; c=relaxed/simple;
	bh=oofNNbl5+h1VD8Kv5t8GDpowHQom4l45zPJpNeTinhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhYYIDjj2Sufh21xrhVp389vbTngRMl1CWiZEqJphf7tc/ZbVghS8u1FE67ZqW0sRCPlYYpr9dK3BTV7KQn5UMyDv82wGHAObWzBII19C0AMUuabLh/gRqgr0JbK0DaOWFqCwaBcz+TJCEyqyOMw0IpIYUlHYqUgAB5RHyVKF44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FR9aHjN7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=VUQI/4UJNr/4nPHTlNprImSpOiOHO1pGt7lumGnWtUA=; b=FR9aHjN7EmWmmMtZZpyyFi3+ep
	Vz0eiJu84/tNYty31gHXdgxsqSTEeNIkSbdBJJlBsHhYguiF8JYpZid7bBCC6alLp/iwG1lQhb3Ni
	g1hu1hPLBBonA1Coz4vXsaHeR/R6eZe6KvnHStLcnD87cumnFwkdL58wc3KX9DeA3cOP9JTxfpGa/
	eXBFYoHnwUJJK/FdOtMcy3Nlm9mDL3Cc3oHVxtsfi5DeSjothkpJ2Hj1CWSq6zVu+hN7uM3PVz/8x
	RosDhCZyhRJ5bkJQcTZW2ghsbSsQMtsFb4qZpZkio5xLBZ/ZpJcNHh+/fRRtJTyGhXj0PLIcHw1zB
	VOQZYk0A==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wo-00000003Qtb-1ItG;
	Wed, 17 Apr 2024 17:57:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/13] jfs: Convert page_to_mp to folio_to_mp
Date: Wed, 17 Apr 2024 18:56:53 +0100
Message-ID: <20240417175659.818299-10-willy@infradead.org>
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

Access folio->private directly instead of testing the page private flag.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 90a284d3bef7..67d5d417fe01 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -80,11 +80,13 @@ struct meta_anchor {
 };
 #define mp_anchor(page) ((struct meta_anchor *)page_private(page))
 
-static inline struct metapage *page_to_mp(struct page *page, int offset)
+static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
-	if (!PagePrivate(page))
+	struct meta_anchor *anchor = folio->private;
+
+	if (!anchor)
 		return NULL;
-	return mp_anchor(page)->mp[offset >> L2PSIZE];
+	return anchor->mp[offset >> L2PSIZE];
 }
 
 static inline int insert_metapage(struct folio *folio, struct metapage *mp)
@@ -144,9 +146,9 @@ static inline void dec_io(struct folio *folio, void (*handler) (struct folio *))
 }
 
 #else
-static inline struct metapage *page_to_mp(struct page *page, int offset)
+static inline struct metapage *folio_to_mp(struct folio *folio, int offset)
 {
-	return PagePrivate(page) ? (struct metapage *)page_private(page) : NULL;
+	return folio->private;
 }
 
 static inline int insert_metapage(struct folio *folio, struct metapage *mp)
@@ -303,7 +305,7 @@ static void last_write_complete(struct folio *folio)
 	unsigned int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 		if (mp && test_bit(META_io, &mp->flag)) {
 			if (mp->lsn)
 				remove_from_logsync(mp);
@@ -359,7 +361,7 @@ static int metapage_write_folio(struct folio *folio,
 	folio_start_writeback(folio);
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 
 		if (!mp || !test_bit(META_dirty, &mp->flag))
 			continue;
@@ -526,7 +528,7 @@ static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 	int offset;
 
 	for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-		mp = page_to_mp(&folio->page, offset);
+		mp = folio_to_mp(folio, offset);
 
 		if (!mp)
 			continue;
@@ -620,7 +622,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		folio_lock(folio);
 	}
 
-	mp = page_to_mp(&folio->page, page_offset);
+	mp = folio_to_mp(folio, page_offset);
 	if (mp) {
 		if (mp->logical_size != size) {
 			jfs_error(inode->i_sb,
@@ -804,7 +806,7 @@ void __invalidate_metapages(struct inode *ip, s64 addr, int len)
 		if (IS_ERR(folio))
 			continue;
 		for (offset = 0; offset < PAGE_SIZE; offset += PSIZE) {
-			mp = page_to_mp(&folio->page, offset);
+			mp = folio_to_mp(folio, offset);
 			if (!mp)
 				continue;
 			if (mp->index < addr)
-- 
2.43.0


