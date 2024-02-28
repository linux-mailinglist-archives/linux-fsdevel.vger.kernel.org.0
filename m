Return-Path: <linux-fsdevel+bounces-13120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB886B715
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9CF1F2355D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061BD4085D;
	Wed, 28 Feb 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pFm81e4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E534B79B86
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144558; cv=none; b=fIWHAroZJBojTxpqgcZf3BTqtILleYd6Lbpte210bmupD0sUIl8B2FT2e/hAoRuIjAjikpGKtC4ACPozVLuJYZxtLMsowFXgsqqCpSLfSHI1u0LwkOSia9QGEaaMNCtc04u9PUiVcCTuq6wo1DUKdEOhpJoP7DbsBaTR9/cXa1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144558; c=relaxed/simple;
	bh=+lMPliMvFhF2O2sC3+WFo2bvoMMN9PBZepW5cPwxtS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p43gxwmUwJdgn/XQ7ZAtHP6PSeAbEbUmtXZTgze+g/lWykLyRo1kIWdJ8i5kuGb7xxGeBU/5w+V+pRqWANHMTF37rfvaWajwgk1UfMWEUcU5OdngwXkSm+B2BzOhzmzcA7xHFgn28s+4dc0k09CwiZmLN01LAXKRl+pxpvNbL7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pFm81e4b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=zyLVkLIMvfYhi7iymKpQZImO3Ib0JWZlKPrLFkzRDOc=; b=pFm81e4bb+QtvK5+4H/e9fu/ca
	mDosN7UQ10AaICUT4M41ananaVFX+K5PU3cy09vMfhRQ48/C2saMliUm5n/PgBPNe3sYVx3jCGWF4
	cOliMJqNps/mIkTxPSq4kcOQmCtqW6CbXiYj7xBGpK6Dk89Tpp5dJWoNOvFpCjpb1l7Qnb2nM0LCT
	zPNLpho0r7Dyv0dockjEJHcxuuolGuN1+236cAXNbZ4gTVSb0O4/hP46FKEoouDqLwmNyY+GBHpud
	oPOqkRGPM3ADoF7GwTXspm0FTROU1+KbMUEp/gjWwVd8EE1f/QRtgemhdmVlBR9kSu0ys11PaKc0F
	OXac9udA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOZf-00000005sUS-1bQo;
	Wed, 28 Feb 2024 18:22:35 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 1/1] mm: Convert pagecache_isize_extended to use a folio
Date: Wed, 28 Feb 2024 18:22:28 +0000
Message-ID: <20240228182230.1401088-2-willy@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228182230.1401088-1-willy@infradead.org>
References: <20240228182230.1401088-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove four hidden calls to compound_head().  Also exit early if the
filesystem block size is >= PAGE_SIZE instead of just equal to PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..25776e1915b8 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -781,31 +781,29 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 {
 	int bsize = i_blocksize(inode);
 	loff_t rounded_from;
-	struct page *page;
-	pgoff_t index;
+	struct folio *folio;
 
 	WARN_ON(to > inode->i_size);
 
-	if (from >= to || bsize == PAGE_SIZE)
+	if (from >= to || bsize >= PAGE_SIZE)
 		return;
 	/* Page straddling @from will not have any hole block created? */
 	rounded_from = round_up(from, bsize);
 	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
 		return;
 
-	index = from >> PAGE_SHIFT;
-	page = find_lock_page(inode->i_mapping, index);
-	/* Page not cached? Nothing to do */
-	if (!page)
+	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
+	/* Folio not cached? Nothing to do */
+	if (IS_ERR(folio))
 		return;
 	/*
-	 * See clear_page_dirty_for_io() for details why set_page_dirty()
+	 * See folio_clear_dirty_for_io() for details why folio_mark_dirty()
 	 * is needed.
 	 */
-	if (page_mkclean(page))
-		set_page_dirty(page);
-	unlock_page(page);
-	put_page(page);
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 }
 EXPORT_SYMBOL(pagecache_isize_extended);
 
-- 
2.43.0


