Return-Path: <linux-fsdevel+bounces-8176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54DD830AD1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 17:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB5A1C213C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 16:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB69225DD;
	Wed, 17 Jan 2024 16:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TAaCu2iG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D762225CC;
	Wed, 17 Jan 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508178; cv=none; b=H1qCiBMsGZwe0Byekwp1wvdt3ODhoKW7FkzT93SO+4ouaTTzrAd+Ldc1YL+wCg+6oWqdfFTQNm6FAlHzn/CX549FiPDKf+9BfVTh4YcXPb33mvwFknBHOcJmTA7Zys2pt1Ue83lsQ0LD6DQe0awyDmUqI4bn5B2gG7dN5Ra0XqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508178; c=relaxed/simple;
	bh=h307bOLSO3nusiV3WaoFwV58aYDmd61p002n9twFjCE=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition; b=Lirxu8N+yPlkvWTqgCXbxrABewwCabZMW/dEjnqK1fp4sF9p9PXWMFEsqsWSR/6xqlR32++Ox6nzZjuRK6Pfd/GP81ZD+tQZEOtH0kfLNtOJpzha00Cey7lY81ndjweYKwVgbes4Kwvnl2SbhpliKCXlRc8RPzv0BF/7/Bl7cYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TAaCu2iG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=7mSq1hGoGilIDfYeHQ7nB1+JqT0DHuQGU8BN+MKG5/I=; b=TAaCu2iG2AwF4bX1YXEII39KUN
	hC7pn+VaUNr8JnOSz9FiLCkk/JIlkpCNHK1jJp/zgDTnm79AGFuZE8pC89VgVFdh3M33E+pm0iclw
	1hgNspKt66iAmHVOT8ZHSH+1h2G+yqWKgooJCuhdnmkSxv44AsXhNkUkFzHbBk8A73SzicEf6tAzR
	2ygLVyqyYDA6KWowKZmNjOvOnhe+Ape7hTpos4DF1FqynqBjZ4nbkwVSSINoNHJM6vUqk4ObL1UEu
	9AEBmV3RNCR1VJbeB8bBI4RAwm74I57rHLhxLIJ8aOzwZGqbI9sxX+PcsggKfJr0N41mXesdwZ8EQ
	dh/fNAzg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rQ8aM-00000000KIj-2hVw;
	Wed, 17 Jan 2024 16:16:14 +0000
Date: Wed, 17 Jan 2024 16:16:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: fstests@vger.kernel.org
Subject: [RFC] pagecache_isize_extended
Message-ID: <Zaf9TgExOXsOYvW4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I hadn't looked at pagecache_isize_extended() before, and I'm not
entirely sure it's doing the right thing for large folios.  Usually
we decline to create folios which extend past EOF [1], and we try to split
folios on truncate.  But folio splitting can fail, and I think we might
run into problems with a store to a folio which straddles i_size.

Do we have any xfstests which cover this?  I'm not quite sure how to
write such a test.

[1] or at least EOF rounded up to PAGE_SIZE


diff --git a/mm/truncate.c b/mm/truncate.c
index 725b150e47ac..3025c579db52 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -781,8 +781,7 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 {
 	int bsize = i_blocksize(inode);
 	loff_t rounded_from;
-	struct page *page;
-	pgoff_t index;
+	struct folio *folio;
 
 	WARN_ON(to > inode->i_size);
 
@@ -793,19 +792,18 @@ void pagecache_isize_extended(struct inode *inode, loff_t from, loff_t to)
 	if (to <= rounded_from || !(rounded_from & (PAGE_SIZE - 1)))
 		return;
 
-	index = from >> PAGE_SHIFT;
-	page = find_lock_page(inode->i_mapping, index);
-	/* Page not cached? Nothing to do */
-	if (!page)
+	folio = filemap_lock_folio(inode->i_mapping, from / PAGE_SIZE);
+	/* Folio not cached? Nothing to do */
+	if (!folio)
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
 

