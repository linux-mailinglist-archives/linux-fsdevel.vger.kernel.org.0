Return-Path: <linux-fsdevel+bounces-17432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8F98AD4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2021C2114B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9A61553BD;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DL4BNm07"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFD415533A;
	Mon, 22 Apr 2024 19:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814331; cv=none; b=PGKmL13Tu/BuGDgVHlzqTUGdFU9rhcCWOmQbmZS/p/BzDfE6xXILDjqphmf7dc/jrG4nL5yyEUEmPEtIM8XPPOm6BX7rlJZ/OtAO7sVT8V5xUzB5VIsAlpEvwTxV2z5oHidXDaGwn0DZRTinkAgE3tioWX0A8ws6maGcEw+AvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814331; c=relaxed/simple;
	bh=uPDerVXe2UZggM4wJuFXw0DncMuTpdmYUfyGZ6A17Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=El14krWffGM8fN/kBLBcwqhYWVgu975V8B5lvGGJukChHJ9ENv4d8vNLaQ+pH2Z60V/prYH2iQu4pzJjy+UGhhmgJThDvNTxaXcFOkhmyEELpjXCgZgPhHdAWfbGDiHhRpv491E37yRdlkSniAJEtl5YeS8yD5Cbd3D32FLc4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DL4BNm07; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PJmvraMWuUCE1znYmS9Vz7eaEL+OTUYhdOXwfVsOtUU=; b=DL4BNm07bSN3bTA/2ka59ScY8S
	IedTvbDQbAEsar/hHdFAEW1radzoneH1CHvdscrDfyKs5s1j8BgT0MKvXfxNIY1cTk5DJzsQXxjW2
	61F3gaopTvU9ebGPNb8MntSrEvXsC+Klc4VJOAJeP+E6RcK28W+ZNRgGdrxXVyzbLBXvCiCTp0r04
	RJZ/81Gp+rYKEfoWkDz7GGX3G6fWYeXm9YEbq7ftiDHc+u4STrzj2Bydev/cnZnrDERkv9p3O/Pck
	zoKBxz9zQbihqbeAZPuFDStamwU9M1gYXFqc/S/+hguhKnC3J33ZHt6ksKUWq5Urzan00OEOp+cPI
	SFNLyAlg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOa-0000000EpOv-0HUV;
	Mon, 22 Apr 2024 19:32:08 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/11] ntfs3: Convert ntfs_get_frame_pages() to use a folio
Date: Mon, 22 Apr 2024 20:32:00 +0100
Message-ID: <20240422193203.3534108-11-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422193203.3534108-1-willy@infradead.org>
References: <20240422193203.3534108-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function still takes an array of pages, but use a folio internally.
This function would deadlock against itself if used with large folios
(as it locks each page), so we can be a little sloppy with the conversion
back from folio to page for now.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/file.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 2f903b6ce157..40d3e7d0567a 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -824,23 +824,24 @@ static int ntfs_get_frame_pages(struct address_space *mapping, pgoff_t index,
 	*frame_uptodate = true;
 
 	for (npages = 0; npages < pages_per_frame; npages++, index++) {
-		struct page *page;
+		struct folio *folio;
 
-		page = find_or_create_page(mapping, index, gfp_mask);
-		if (!page) {
+		folio = __filemap_get_folio(mapping, index,
+				FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp_mask);
+		if (IS_ERR(folio)) {
 			while (npages--) {
-				page = pages[npages];
-				unlock_page(page);
-				put_page(page);
+				folio = page_folio(pages[npages]);
+				folio_unlock(folio);
+				folio_put(folio);
 			}
 
 			return -ENOMEM;
 		}
 
-		if (!PageUptodate(page))
+		if (!folio_test_uptodate(folio))
 			*frame_uptodate = false;
 
-		pages[npages] = page;
+		pages[npages] = &folio->page;
 	}
 
 	return 0;
-- 
2.43.0


