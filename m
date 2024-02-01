Return-Path: <linux-fsdevel+bounces-9936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE16B8463BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09471C25FD2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6047F46;
	Thu,  1 Feb 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rgaVwvnQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969D745BF8
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827574; cv=none; b=YqeSLkmLCQfoWDjqSY5Dyvygn8nf7IHdZ9ru4WyWP9V/bB1+zaIGyeUr1/bMx82INbolhrDCgunmPKXCysWW4C5sNhZ4RjGTs/h1hpc+3KLmyF+8bApQWynT5DeTqtZ5wBWToMLvxleemMAGbK6FBAY/RthBvDXQ1gKms2RAiio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827574; c=relaxed/simple;
	bh=TsPz2rBrbm7DLppgXoS0Fk86EHiRFuhHEKiyL4l81SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzZmpbZ1IfXoQ1a21Tfl9FtTAjl+11eFzPcWQQV8LfSFyz3h6tGiT4ZlI2wg8FQ8/xQQnnAZwPMrzVoS55ejJU7Oj2c/vyS/KkdR/8nWnCBonEIGiC4Zx9Pj6npU1wsdQOszDsUQUeB5lTyPp6+nvPgfvRtMW1/5id+fQGpzpfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rgaVwvnQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sE/YQ5G34kCC0ntB4hwruHztmMrVkvB6/wZslSYOwFA=; b=rgaVwvnQo8pRztT4oviAFnMDdq
	njyPDWS/GlDj8yL86ODrgSAmQsa2ZwNde3ebCd+1DIlHOA0oki22/vpQ86xeNz2h1lPB+gworl2km
	R9iF8maNxq8Fai60JKgByrekYgBcZWT1MM2VBC7z2WCV8vQLaNtH1gZT85P1mQvzO4ZSLxXxQ5Z8X
	WdZL7IfG41wHrFg7eva9sDgg/4hiK7VhnB2gku0OWX8HHc7pvE7DR4HM1CQ44PyNJ5SVgHsgfa3h6
	8J+xJ+m/8c6SVTzFgV0e9MkmPc0m4PXRlkkYeDXPCs4dSIDhvP1ldE4kx58ViFi7EcrVVolQglWS5
	2OeG68PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H18S-2dzi;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/13] jfs: Convert drop_metapage and remove_metapage to take a folio
Date: Thu,  1 Feb 2024 22:45:55 +0000
Message-ID: <20240201224605.4055895-7-willy@infradead.org>
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

All callers now have a folio, so pass it in instead of the page.
Removes a couple of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 4515dc1ac40e..56bd11f9ded5 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -112,10 +112,10 @@ static inline int insert_metapage(struct folio *folio, struct metapage *mp)
 	return 0;
 }
 
-static inline void remove_metapage(struct page *page, struct metapage *mp)
+static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 {
-	struct meta_anchor *a = mp_anchor(page);
-	int l2mp_blocks = L2PSIZE - page->mapping->host->i_blkbits;
+	struct meta_anchor *a = mp_anchor(&folio->page);
+	int l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
 	int index;
 
 	index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
@@ -125,8 +125,8 @@ static inline void remove_metapage(struct page *page, struct metapage *mp)
 	a->mp[index] = NULL;
 	if (--a->mp_count == 0) {
 		kfree(a);
-		detach_page_private(page);
-		kunmap(page);
+		folio_detach_private(&folio->page);
+		kunmap(&folio->page);
 	}
 }
 
@@ -156,10 +156,10 @@ static inline int insert_metapage(struct folio *folio, struct metapage *mp)
 	return 0;
 }
 
-static inline void remove_metapage(struct page *page, struct metapage *mp)
+static inline void remove_metapage(struct folio *folio, struct metapage *mp)
 {
-	detach_page_private(page);
-	kunmap(page);
+	folio_detach_private(folio);
+	kunmap(&folio->page);
 }
 
 #define inc_io(page) do {} while(0)
@@ -214,12 +214,12 @@ void metapage_exit(void)
 	kmem_cache_destroy(metapage_cache);
 }
 
-static inline void drop_metapage(struct page *page, struct metapage *mp)
+static inline void drop_metapage(struct folio *folio, struct metapage *mp)
 {
 	if (mp->count || mp->nohomeok || test_bit(META_dirty, &mp->flag) ||
 	    test_bit(META_io, &mp->flag))
 		return;
-	remove_metapage(page, mp);
+	remove_metapage(folio, mp);
 	INCREMENT(mpStat.pagefree);
 	free_metapage(mp);
 }
@@ -539,7 +539,7 @@ static bool metapage_release_folio(struct folio *folio, gfp_t gfp_mask)
 		}
 		if (mp->lsn)
 			remove_from_logsync(mp);
-		remove_metapage(&folio->page, mp);
+		remove_metapage(folio, mp);
 		INCREMENT(mpStat.pagefree);
 		free_metapage(mp);
 	}
@@ -774,7 +774,7 @@ void release_metapage(struct metapage * mp)
 		remove_from_logsync(mp);
 
 	/* Try to keep metapages from using up too much memory */
-	drop_metapage(&folio->page, mp);
+	drop_metapage(folio, mp);
 
 	folio_unlock(folio);
 	folio_put(folio);
-- 
2.43.0


