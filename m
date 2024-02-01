Return-Path: <linux-fsdevel+bounces-9925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE95A84639D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D4841F24A27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630AD46424;
	Thu,  1 Feb 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QgrQ+9Ua"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE1645018
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827571; cv=none; b=Ym0y4QS7YEF8yPBiQRvDKQf6SHTs7xxPqtoFSNcHS0O+agOBEjU9Z/42O2fVlurRSpbfYHcEZhFOn2JikuV/jPC35a9m2/ib0QMBTszVaOmGSAi2U797spbCIRx7xwL45rmkC5AqlP43QqEFV+8ZMKL4Q3NCwmYA3OMLmDq5a5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827571; c=relaxed/simple;
	bh=4b3G/+T3wt+YVnTF1aSwniBeH1KOIEVwE1fET7SzUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cEnmH2jrRQWCYVzHyIvgs+bajzzvS/WtWoZiBE4+QXLxwa49sJKAV+Yg+NCFRKifY2XWECIXucsKaF0X8fSEYXojGRqpGBk4/NG9EjALJFwxZyCi/r3nPBs1E2UL+L80orKe51RfvdTrG7MQ46WX3isCgVpby7IJAkAvOsIWh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QgrQ+9Ua; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1hiBfCsxHjQnrQb499TeqPNt73gL1h2Ah7TqxU7+CxY=; b=QgrQ+9Ua/rVGJWmUFecax/c262
	ZKtbBOnzKWcouuoFucyUucJfo5V56z3Y43FnHhVCoc5ryno/fTQ+JIIj76nJAcNRTSxlHC3PDR+gz
	GPkpwBtv+UTwBBIXmrXTB4aEp1pxdAQKp+BLNnSwBOyhU0FXion8MQ4CuDbLNefDvfqAU4fmpMdaT
	AY7vRX1LiUzpEaL248+e65+N/AELgnVct/SdIn6akFYrKXADP/iv32l+JwBa+rcKEXk+Bh3fUVg4V
	rqwgRDgmXjxxncF4a3M9HeQOAaYcmK+2XiDe3v007u0dxwTBkHl5FxiQrYbLpuaVLq9eb0bnjJeIf
	rHKJVQtg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfot-0000000H187-1EK8;
	Thu, 01 Feb 2024 22:46:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/13] jfs: Convert __get_metapage to use a folio
Date: Thu,  1 Feb 2024 22:45:52 +0000
Message-ID: <20240201224605.4055895-4-willy@infradead.org>
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

Remove four hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index beecc9ad656e..4ef85e264f51 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -577,7 +577,7 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 	int l2bsize;
 	struct address_space *mapping;
 	struct metapage *mp = NULL;
-	struct page *page;
+	struct folio *folio;
 	unsigned long page_index;
 	unsigned long page_offset;
 
@@ -608,22 +608,22 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 	}
 
 	if (new && (PSIZE == PAGE_SIZE)) {
-		page = grab_cache_page(mapping, page_index);
-		if (!page) {
-			jfs_err("grab_cache_page failed!");
+		folio = filemap_grab_folio(mapping, page_index);
+		if (IS_ERR(folio)) {
+			jfs_err("filemap_grab_folio failed!");
 			return NULL;
 		}
-		SetPageUptodate(page);
+		folio_mark_uptodate(folio);
 	} else {
-		page = read_mapping_page(mapping, page_index, NULL);
-		if (IS_ERR(page)) {
+		folio = read_mapping_folio(mapping, page_index, NULL);
+		if (IS_ERR(folio)) {
 			jfs_err("read_mapping_page failed!");
 			return NULL;
 		}
-		lock_page(page);
+		folio_lock(folio);
 	}
 
-	mp = page_to_mp(page, page_offset);
+	mp = page_to_mp(&folio->page, page_offset);
 	if (mp) {
 		if (mp->logical_size != size) {
 			jfs_error(inode->i_sb,
@@ -649,16 +649,16 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		mp = alloc_metapage(GFP_NOFS);
 		if (!mp)
 			goto unlock;
-		mp->page = page;
+		mp->page = &folio->page;
 		mp->sb = inode->i_sb;
 		mp->flag = 0;
 		mp->xflag = COMMIT_PAGE;
 		mp->count = 1;
 		mp->nohomeok = 0;
 		mp->logical_size = size;
-		mp->data = page_address(page) + page_offset;
+		mp->data = folio_address(folio) + page_offset;
 		mp->index = lblock;
-		if (unlikely(insert_metapage(page, mp))) {
+		if (unlikely(insert_metapage(&folio->page, mp))) {
 			free_metapage(mp);
 			goto unlock;
 		}
@@ -670,12 +670,12 @@ struct metapage *__get_metapage(struct inode *inode, unsigned long lblock,
 		memset(mp->data, 0, PSIZE);
 	}
 
-	unlock_page(page);
+	folio_unlock(folio);
 	jfs_info("__get_metapage: returning = 0x%p data = 0x%p", mp, mp->data);
 	return mp;
 
 unlock:
-	unlock_page(page);
+	folio_unlock(folio);
 	return NULL;
 }
 
-- 
2.43.0


