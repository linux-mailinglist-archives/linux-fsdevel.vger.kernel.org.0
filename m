Return-Path: <linux-fsdevel+bounces-24028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F68A937BD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4741F22B6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99091474B4;
	Fri, 19 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwTonYp8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E9144D10;
	Fri, 19 Jul 2024 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411475; cv=none; b=qyaXh6eJ+Z4PeN1LTC5PUa6VRNFi24UdRXGtLDdFCsOTKAgP4CAXTihaAO8J7N7LqP7NIKZMQ2Vr9xQ3uUx5wC291yvBKWg8cs1A/p/GGkz9W9KBwqbhOpxe1TzaYYrrtImys1T1QHIwPcfCoKPJJ9phRMFVPLdvp6H17KYEfFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411475; c=relaxed/simple;
	bh=kzC2qViMsx88k0vwIV8SmdhFDbNiHbTy+4O/lYIKLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eQkS4OmCwZVvgfd/5V+pW6n3ILU9Yp9riDkISqPlqmvboAsp4ENgdkgMoxkuttmHShniWFhqW5bV3ejK7E1yNS/erH268b77SmC3UI7pnUMUUtovYhAQa1Ti06K5tSWSS0Uf5KRMoH/DpdKcN87i9xSaqJb7lL1pDD0UkJ2sbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YwTonYp8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lCjuoji/Ly/uEdVza3rXJtH7Pa69hmvgSCUDuwqa04k=; b=YwTonYp8munhY24OleHYHuvcZU
	jQ0GUEbz78avHqznFXsEPc197GNyxOJGdUrWFtB9lLEbcTtfBZLLAJUakFw8hfzJScHqkmldLM4qO
	tMNhZy9vWebgepquITQv/JhPxRbbpqZyUOrngCinKin+3STOIM7b3VxO4fffBhWGO7aLcEg0Gq4js
	FHfTQZ4jT+TRp+vm+v4l50Karzg5FsDblLEDawrpgEKUcF45iDQFtxkbDdN2EVI2LlA5UrwBL3rhh
	Ak48iFKHM6UFSLkJdWcO1Q7CXEjfTbafF0y4xRQ7P5cE8OgBhqQZ3quUZrfkQFRmsRM3aiEODG8Ge
	CdWIVQUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrl9-00000003J4k-1wX4;
	Fri, 19 Jul 2024 17:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] gfs2: Remove gfs2_jdata_writepage()
Date: Fri, 19 Jul 2024 18:51:03 +0100
Message-ID: <20240719175105.788253-4-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719175105.788253-1-willy@infradead.org>
References: <20240719175105.788253-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no remaining callers of gfs2_jdata_writepage() other than
vmscan, which is known to do more harm than good.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/aops.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 10d5acd3f742..68fc8af14700 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -138,35 +138,6 @@ static int __gfs2_jdata_write_folio(struct folio *folio,
 	return gfs2_write_jdata_folio(folio, wbc);
 }
 
-/**
- * gfs2_jdata_writepage - Write complete page
- * @page: Page to write
- * @wbc: The writeback control
- *
- * Returns: errno
- *
- */
-
-static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc)
-{
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
-	struct gfs2_inode *ip = GFS2_I(inode);
-	struct gfs2_sbd *sdp = GFS2_SB(inode);
-
-	if (gfs2_assert_withdraw(sdp, ip->i_gl->gl_state == LM_ST_EXCLUSIVE))
-		goto out;
-	if (folio_test_checked(folio) || current->journal_info)
-		goto out_ignore;
-	return __gfs2_jdata_write_folio(folio, wbc);
-
-out_ignore:
-	folio_redirty_for_writepage(wbc, folio);
-out:
-	folio_unlock(folio);
-	return 0;
-}
-
 /**
  * gfs2_writepages - Write a bunch of dirty pages back to disk
  * @mapping: The mapping to write
@@ -748,7 +719,6 @@ static const struct address_space_operations gfs2_aops = {
 };
 
 static const struct address_space_operations gfs2_jdata_aops = {
-	.writepage = gfs2_jdata_writepage,
 	.writepages = gfs2_jdata_writepages,
 	.read_folio = gfs2_read_folio,
 	.readahead = gfs2_readahead,
-- 
2.43.0


