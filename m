Return-Path: <linux-fsdevel+bounces-17190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F28A8AA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A692869F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734B8175550;
	Wed, 17 Apr 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXthGP/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD1D173324
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376624; cv=none; b=ACI5LXxMEaXut4x/AqI17W6tcEgEMOt6Y2rLptnVn9ZU3cFHkbq2Bn2ptwNmLes1ByOgm80/vXHuVBMd2KWfaulO7TkjwQGC+WB0AFKCn2CV1zVuYOJqx7XjxPbxsQhLvHOzbpeOSvD7xmda+qvQ0cx+fEAB2D6eYPuHFWZr0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376624; c=relaxed/simple;
	bh=j+N0sJeft/8K757uXz1eGUzvdzNrBvWnvi7EFC6AUSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKtDTBbBHDGFKQj3EuS6i3YceJ+S6NHuZJCvgutcKkKEdVHGXTpT+HbrJNZtyl523lbYPcByw1r9hGOW49pyZnbUMtJHNETmE8lMv4iuOGUrf+pX9TFxXr2WG89rNTnm+C245G6NAyIFk+CdvO4a9wy4Y3pjhi7taKYvi/QOGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CXthGP/0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=sS8rs1wx/Vl16CBWO9lzK3hSfWUZFOa9GJzDUV3BYdU=; b=CXthGP/0Rk65VjNx6X5FCvuTtk
	DmkyYPcE5tMEq3KojDqbKY9cwhn06pPI8VTcUWhz2lGJSrZhTzsc9eA+kBtbjORa308RybJ0tmLjf
	Jx/LH0bBtxyNNWCAfTBt0eY6+fGqNQtle1yjFGTUutWWtOCs7FiZqo6uN5xDKnbq2bogaRyLDj+5E
	WO/IHz0kc97Ny29WGloE3K58LUOcOqdQoW//od+vJq40DzhGlOpC2eRHZovRBbLEInPq+NzjkeoEX
	l8kgq3CL07a+JsBFet7xMvWk95kLZ4X2tb9hH528SDyxYTDFtbdnwNOVJ5HRiCxLlTUkuOBu7kMaY
	CZdwMvbg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003QtE-2P6d;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 06/13] jfs: Convert drop_metapage and remove_metapage to take a folio
Date: Wed, 17 Apr 2024 18:56:50 +0100
Message-ID: <20240417175659.818299-7-willy@infradead.org>
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

All callers now have a folio, so pass it in instead of the page.
Removes a couple of calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 4515dc1ac40e..9fc52c27b0ce 100644
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
+	struct meta_anchor *a = folio->private;
+	int l2mp_blocks = L2PSIZE - folio->mapping->host->i_blkbits;
 	int index;
 
 	index = (mp->index >> l2mp_blocks) & (MPS_PER_PAGE - 1);
@@ -125,8 +125,8 @@ static inline void remove_metapage(struct page *page, struct metapage *mp)
 	a->mp[index] = NULL;
 	if (--a->mp_count == 0) {
 		kfree(a);
-		detach_page_private(page);
-		kunmap(page);
+		folio_detach_private(folio);
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


