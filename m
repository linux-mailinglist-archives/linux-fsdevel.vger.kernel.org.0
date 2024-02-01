Return-Path: <linux-fsdevel+bounces-9930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666B68463AB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 23:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239DD28DD9A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 22:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54ED447774;
	Thu,  1 Feb 2024 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T6Cz7rsx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0941236
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 22:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706827572; cv=none; b=ElQE4VTlpCBReOmGQYPbFK9jL0Sd/T9ck8eiy5OcrjnkaGAG162RItVm6+/+BxDNTWKJFCJW2U+e/jCFftBdVPp72kqJ5LK/z3I4KyO3VeyaFkNjy8LB82v2v+qN4xtWhpxc8KkBCJ7/f2YOufEkixTPsdi3JPPCci8A09IM0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706827572; c=relaxed/simple;
	bh=JzGSwdb5fhgSdCrU9j5WulRWL7FiCQUVqemfXjOCT6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0iMmjX9/oQe3VCPXdJ2tVo1PNeHXReG5xQTyd2rd2Eg9ah/8F0CLJVNgHJFO0STMHvP/xdCdmAdif2r3fzvzaNZQK5Mpd42hsaUpWu7dMSwnctnnz5HGzZCuiS7OfMoL94rt6Zw/59PjohH4NsrmlyVzQ+jzhHHjph32oUjGVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T6Cz7rsx; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=OTufa8taMJlZYmWBs6HvMsiwrkZelXub51uPI5R94M4=; b=T6Cz7rsxNF0Zrez6iJziDt4OwS
	SMMCR59woXJ6MGYGSYtJXYyixcQKIkeoDQPVS/H8ifPWmIc3zbks4jQpfiWk4UqpthLHS4L6ogKR0
	jXj30yjrojdgX9u5pZi82+P1JyuaVavThYO6kCD6nV0K1EvIhjgAwL8nPdcCn7VYIJk6j7XdSk0qa
	sbnSaWSj9f7fgAxkHRYiBKyGeze/XG79dq8oKUklw0EcAEKs8k7erlOrX/ebMUTWF9Q3CSfINpVOq
	DtlcMduDp+Q4fgJ8qrjQws0CMV29ZxfEQPvpNLwb5h4eEGaryeVyQxjd9P9W11dxWvcTDIktl+eHL
	zUj9l9oA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVfou-0000000H191-12DU;
	Thu, 01 Feb 2024 22:46:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Dave Kleikamp <shaggy@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/13] jfs: Convert force_metapage to use a folio
Date: Thu,  1 Feb 2024 22:46:00 +0000
Message-ID: <20240201224605.4055895-12-willy@infradead.org>
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

Convert the mp->page to a folio and operate on it.  That lets us
convert metapage_write_one() to take a folio.  Replaces five calls to
compound_head() with one.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/jfs/jfs_metapage.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index bc62d4bb4712..23e81d713c62 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -688,9 +688,8 @@ void grab_metapage(struct metapage * mp)
 	unlock_page(mp->page);
 }
 
-static int metapage_write_one(struct page *page)
+static int metapage_write_one(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	struct address_space *mapping = folio->mapping;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
@@ -719,17 +718,17 @@ static int metapage_write_one(struct page *page)
 
 void force_metapage(struct metapage *mp)
 {
-	struct page *page = mp->page;
+	struct folio *folio = page_folio(mp->page);
 	jfs_info("force_metapage: mp = 0x%p", mp);
 	set_bit(META_forcewrite, &mp->flag);
 	clear_bit(META_sync, &mp->flag);
-	get_page(page);
-	lock_page(page);
-	set_page_dirty(page);
-	if (metapage_write_one(page))
+	folio_get(folio);
+	folio_lock(folio);
+	folio_mark_dirty(folio);
+	if (metapage_write_one(folio))
 		jfs_error(mp->sb, "metapage_write_one() failed\n");
 	clear_bit(META_forcewrite, &mp->flag);
-	put_page(page);
+	folio_put(folio);
 }
 
 void hold_metapage(struct metapage *mp)
@@ -770,7 +769,7 @@ void release_metapage(struct metapage * mp)
 		folio_mark_dirty(folio);
 		if (test_bit(META_sync, &mp->flag)) {
 			clear_bit(META_sync, &mp->flag);
-			if (metapage_write_one(&folio->page))
+			if (metapage_write_one(folio))
 				jfs_error(mp->sb, "metapage_write_one() failed\n");
 			folio_lock(folio);
 		}
-- 
2.43.0


