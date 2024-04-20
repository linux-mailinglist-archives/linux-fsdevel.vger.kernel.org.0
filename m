Return-Path: <linux-fsdevel+bounces-17352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD6C8AB905
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C826B2243E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06B29402;
	Sat, 20 Apr 2024 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqdJT0nE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571AB17C69
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581466; cv=none; b=tsQ6/CN1HT8yvZlVUdJvfx19McLzDFf+xd/cPc4Dg+hXItEBNt8YylmUNNCbVBJQtx6y6++vWVyn4KZ+knvblzs2qbvkpj45LHDzzMb53PY0M0owPqBWAFBg7ohdKNtPzmbAK+uYJnARrNTKuMTLWkZBVUn2C94Gvf0Nldx4GqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581466; c=relaxed/simple;
	bh=41a/0SgujA/3O6m5BW8LSiYQoeLxaFQClmNrnbg8ivI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOEcXoOdq5VaHOn3/pRaO2Salp5Iv4qnyPmtEDNOFs19igMyVFpz0Era5WHmN1rdYgXyXv28bTnq3ZRns01/39GRJhKIR3ODj2jn3VOz/Pq0vPjLn6DoH8Mkehr/xZakMKHCvZsnniucW3Dk5TneBFB1ejThSBg0lzeE5EuUdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqdJT0nE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=KHvcC88/pFabYoyBrEUaVAQ7LuFYjaoB++gJdYEMqMk=; b=vqdJT0nEXCKSdIsJzTGyeB8zZb
	7ce6yZkOlsM/ZJe9kVOk3cGuSBx0iufVxvmEnXhkX4y+RXp1LRADSafM9rEGBg9s0uP0dhg3+Y1xo
	Set/EFY76hIoKb/AeznBt9DP6kDkioRbtMYJZW8hwyzUHHvA6jk6HBcwVlcTAiUT5dA9iQ8RfcozM
	JL4F7LB6P/7eDCiWDL30wjjJmrgO3idiDnfo8O+azSzAz0M+Ov5FRVMOKZgMuO63YP4qbi139O6xw
	5Jsy15obZODuLOL2WIxKlfb6GU8bodz6FqD4x5o4twVQJlnCxJI629dMpbi+zl4zXo8xkrCuHtPOv
	4QCexmfA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oe-000000095gf-1OC7;
	Sat, 20 Apr 2024 02:51:00 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	linux-mm@kvack.org
Subject: [PATCH 26/30] mm/memory-failure: Stop setting the folio error flag
Date: Sat, 20 Apr 2024 03:50:21 +0100
Message-ID: <20240420025029.2166544-27-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nobody checks the error flag any more, so setting it accomplishes
nothing.  Remove the obsolete parts of this comment; it hasn't
been true since errseq_t was used to track writeback errors in 2017.

Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: linux-mm@kvack.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ec30611ec5ad..e065dd9be21e 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1092,7 +1092,6 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 {
 	struct address_space *mapping = page_mapping(p);
 
-	SetPageError(p);
 	/* TBD: print more information about the file. */
 	if (mapping) {
 		/*
@@ -1100,34 +1099,6 @@ static int me_pagecache_dirty(struct page_state *ps, struct page *p)
 		 * who check the mapping.
 		 * This way the application knows that something went
 		 * wrong with its dirty file data.
-		 *
-		 * There's one open issue:
-		 *
-		 * The EIO will be only reported on the next IO
-		 * operation and then cleared through the IO map.
-		 * Normally Linux has two mechanisms to pass IO error
-		 * first through the AS_EIO flag in the address space
-		 * and then through the PageError flag in the page.
-		 * Since we drop pages on memory failure handling the
-		 * only mechanism open to use is through AS_AIO.
-		 *
-		 * This has the disadvantage that it gets cleared on
-		 * the first operation that returns an error, while
-		 * the PageError bit is more sticky and only cleared
-		 * when the page is reread or dropped.  If an
-		 * application assumes it will always get error on
-		 * fsync, but does other operations on the fd before
-		 * and the page is dropped between then the error
-		 * will not be properly reported.
-		 *
-		 * This can already happen even without hwpoisoned
-		 * pages: first on metadata IO errors (which only
-		 * report through AS_EIO) or when the page is dropped
-		 * at the wrong time.
-		 *
-		 * So right now we assume that the application DTRT on
-		 * the first EIO, but we're not worse than other parts
-		 * of the kernel.
 		 */
 		mapping_set_error(mapping, -EIO);
 	}
-- 
2.43.0


