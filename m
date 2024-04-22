Return-Path: <linux-fsdevel+bounces-17431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF508AD4EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 21:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A41EB213F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 19:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E9F1553BC;
	Mon, 22 Apr 2024 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fNZfG4W8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC315532D;
	Mon, 22 Apr 2024 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814331; cv=none; b=AbiqRS2V8iWwU2KHWE5qwo2GyDxH2X+oqIoDTMS5RC/AoaHg5cSeWUTN+f+q9yzW4djI5nzbnJrfTAEAk1ScryfU4fywjo3KsvL4QdBaofiXgq4ZMTpcloEdIGGg3DI3DaC/j24J7x000eekca4h9ezb+M2zJa+TlEX3IyexKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814331; c=relaxed/simple;
	bh=z43HQPlnbpQWzNfMMe6SGRFVI4CtmRZQWOv/Ybowqg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ihU6VdxsMbLS5gGzm0s8gxHnigD3M7oCVVsaXhRSHU7GoEuNX4g1XEUs+EfwlS1wMkMH1DxtgcLsnp3PrTDfPlhPId/JYh1EJAjmzt/hLVmcwQlGAT1uyX5hE8kxHlz4GQOQ4d4A6SG0ukwzbIcVoK8iSVg5S1CAs48u9GqRSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fNZfG4W8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=J2jUvJdcQN4gwLHeLivK6x8gzEN8L6yg8m4bc9uB1LM=; b=fNZfG4W8ZoeWhwN+3gMugZbLx8
	vUrUmuIuIDYgISnA3tK8NcLGLdovzgTkdp6PxYrDOI7lBraKxfmCuJR4Tbv6H61WOMiEsLpNHxbrE
	0pwJa6GYHQ0UrxnuwlfIPiyEeKXhFTCRlGegEBaPXV8vpqeYP1zf0JgVasYgbnnyybhagdLjubUSm
	mkF6W2Yyix8+jJHl08jes7GCD5Mmt6iizzDB2Gva5NdIqTuOyh+OK7GliRWcnRq7FM/x+QV+zUjxV
	bo51/STooleSfn7frEs5fD0WQMtdHQKb3pi9rAJLw3wqvFgbDwMZoLYpXRNtkU1eCNBovAEEhOGLw
	gwZpo+Yg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryzOZ-0000000EpO8-0JFG;
	Mon, 22 Apr 2024 19:32:07 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/11] ntfs3: Convert ntfs_write_begin to use a folio
Date: Mon, 22 Apr 2024 20:31:52 +0100
Message-ID: <20240422193203.3534108-3-willy@infradead.org>
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

Retrieve a folio from the page cache instead of a precise page.
This function is now large folio safe, but its called function is not.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ntfs3/inode.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index bdaea9c783ad..794d2aa3a5ab 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -913,24 +913,25 @@ int ntfs_write_begin(struct file *file, struct address_space *mapping,
 
 	*pagep = NULL;
 	if (is_resident(ni)) {
-		struct page *page =
-			grab_cache_page_write_begin(mapping, pos >> PAGE_SHIFT);
+		struct folio *folio = __filemap_get_folio(mapping,
+				pos >> PAGE_SHIFT, FGP_WRITEBEGIN,
+				mapping_gfp_mask(mapping));
 
-		if (!page) {
-			err = -ENOMEM;
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			goto out;
 		}
 
 		ni_lock(ni);
-		err = attr_data_read_resident(ni, page);
+		err = attr_data_read_resident(ni, &folio->page);
 		ni_unlock(ni);
 
 		if (!err) {
-			*pagep = page;
+			*pagep = &folio->page;
 			goto out;
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (err != E_NTFS_NONRESIDENT)
 			goto out;
-- 
2.43.0


