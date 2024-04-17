Return-Path: <linux-fsdevel+bounces-17186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 136A58A8A93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B2F2850B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 17:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74E174EC1;
	Wed, 17 Apr 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CEdoqhRI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2256172BCF
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Apr 2024 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376624; cv=none; b=lyOgD5mGFlsrAYwOKfj8K6mLQqdk+LxIsfp0NU9GGp5GJ6oTuvqfyE/4R4tB1IsB2g4eAVieBelxpqQaR9S6KCrrM5lE9cKOE7jE8ATdaKSlmEVFqnP+386Ij/5I0e5NFp4bQ0SS67BoFaGT5GK6Ay7/uqBko51P2QjzT3f2mjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376624; c=relaxed/simple;
	bh=4b3G/+T3wt+YVnTF1aSwniBeH1KOIEVwE1fET7SzUXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTeKPrF+TzRDFl3AF/5F4OTcCm8/pFowaalkc7kUPWzs4MLkh+P5ghwpK6mDo1PzLRxwey5+8Krh0NxOtq59wftr9qN1Q2iiNf8saspCpnU91H6y4lfIstWumYK2vPaNiL0QRD4qGulf1hlFkkWEFt8BH/4XE0CP0x1wY+lE8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CEdoqhRI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1hiBfCsxHjQnrQb499TeqPNt73gL1h2Ah7TqxU7+CxY=; b=CEdoqhRIG3rbUmX+HBTnIVn6li
	SK0HQpAFyLD3gWNDbBu3VHF2GOotjGc7JTjX4B9vBZDkXMPLM4Hai40Ru4xJmCHiuIxnPcvSFtHhH
	D2sfCYPTglSO8QjvAYW5B8LVTXpgLH/y/3NUrlM3ZYydB30wu+ESEZqW9PVe35iGxMzPEfS7LsyQh
	Ax/RQqqIK//JwknJ6AiRVif6dMuinatvQl9t2v4h+ds/dSFAaI8Z9YWN8CME54fCA45xulWj3hD0j
	SeJ5Xe35fZOuZ1tl9XbII2VwxBpSWLCLfH3GD2wZhxBP5pOJBRMNiinnKGSlfHMtbi5+3t8kyNaXG
	kkLnII7Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9Wn-00000003Qss-0eVL;
	Wed, 17 Apr 2024 17:57:01 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/13] jfs: Convert __get_metapage to use a folio
Date: Wed, 17 Apr 2024 18:56:47 +0100
Message-ID: <20240417175659.818299-4-willy@infradead.org>
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


