Return-Path: <linux-fsdevel+bounces-41955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2AA3933B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 06:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7101891546
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 05:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB231CD205;
	Tue, 18 Feb 2025 05:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ggIwAahp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A71B6D18
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2025 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857932; cv=none; b=VtfYiOL3ALt+v7Dr/wJt1FGf4hMO029BgP3R2jOOG9kvd2xrAb8mHk6yps252cHCPxJAkr6foQgNURHOxPo+34qbEN7weOdmOomXLisZL/qBg1JjrbpXVMVa9Qh59YkWNZvwFjsbvDTVoCu5U2VSsqGYc0AA8lctoN+MvamCONc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857932; c=relaxed/simple;
	bh=HaVqAtAT+4UyUKBiw+yxhQ/Y0rgOzwfRoLtxCcv2oxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX5BbWXiGER176EosessF9xiU69VG2lrbWFxR4sfIjdwxWscfZyGLWaWuz9wAQbDLQnOCaKqHCqLaNrhcRNkWrlm1zuYXPihiwQEpbo5sDPQgSAv5Ql6X9zdIiHAkReCj/wHR+hHanTWl7dRi1oZJtxyevlGBnWjEref7mjOYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ggIwAahp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=h7EseUmE3Pl3dQ/iQ4R00hALFgHaX/qw5tdhtdPzOA4=; b=ggIwAahpYTfzpunMOO/Y4kkBsa
	+UW+FeGvk+AXlMfiEwXIqDuoBZ0o4MEJ29Kx7BHv0ZVqxQsa9s1BtvVGrKGDPJQn+KlYF5vQFjC9x
	muY/Kj/ItT6FclsGm45LuucCGN7wvzPEZUuEFB4RUBbed0mReSOn1N60rfsXqGx6lMZuDVM8aa8sK
	4+vKjhGZVBUptcNWdQ53SkT0gxIIbKzbM9i4jpK7NA9uEcYk1HSmKCa7x9n2rsYf5iGj+0qJPi6/A
	kNxZb49BrmPMkd5k+z1AjiEO2dJEkhdAZN1FurMiIzt0SlAwHq2Fvrz97bAWE2npZFIdpPkmNq7uL
	IPGzl2PA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkGWe-00000002Tte-3jDZ;
	Tue, 18 Feb 2025 05:52:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/27] f2fs: Convert truncate_partial_data_page() to use a folio
Date: Tue, 18 Feb 2025 05:51:58 +0000
Message-ID: <20250218055203.591403-25-willy@infradead.org>
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

Retrieve a folio from the page cache and use it throughout.
Saves five hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/f2fs/file.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f2f298c75921..db2778758dda 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -707,31 +707,33 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 	loff_t offset = from & (PAGE_SIZE - 1);
 	pgoff_t index = from >> PAGE_SHIFT;
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 
 	if (!offset && !cache_only)
 		return 0;
 
 	if (cache_only) {
-		page = find_lock_page(mapping, index);
-		if (page && PageUptodate(page))
+		folio = filemap_lock_folio(mapping, index);
+		if (IS_ERR(folio))
+		       return 0;
+		if (folio_test_uptodate(folio))
 			goto truncate_out;
-		f2fs_put_page(page, 1);
+		f2fs_folio_put(folio, true);
 		return 0;
 	}
 
-	page = f2fs_get_lock_data_page(inode, index, true);
-	if (IS_ERR(page))
-		return PTR_ERR(page) == -ENOENT ? 0 : PTR_ERR(page);
+	folio = f2fs_get_lock_data_folio(inode, index, true);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
-	f2fs_wait_on_page_writeback(page, DATA, true, true);
-	zero_user(page, offset, PAGE_SIZE - offset);
+	f2fs_folio_wait_writeback(folio, DATA, true, true);
+	folio_zero_segment(folio, offset, folio_size(folio));
 
 	/* An encrypted inode should have a key and truncate the last page. */
 	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
 	if (!cache_only)
-		set_page_dirty(page);
-	f2fs_put_page(page, 1);
+		folio_mark_dirty(folio);
+	f2fs_folio_put(folio, true);
 	return 0;
 }
 
-- 
2.47.2


