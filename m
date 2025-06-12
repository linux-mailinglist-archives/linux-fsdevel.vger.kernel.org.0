Return-Path: <linux-fsdevel+bounces-51497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 574D9AD7407
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 16:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AD616BCBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 14:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4D62512C8;
	Thu, 12 Jun 2025 14:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SfrpOPeW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBD24E4A8;
	Thu, 12 Jun 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749738902; cv=none; b=KA5ZnwSCOV7A4Q4Npog+P5huBOI+XbvOpd/a/Y3mWc8Tx1gTw8LlkgwlOkQxAEKMB+quV47Ul7uPNWLHeao+PCRPhsakzfR1Q72c9a7OATAyTRXoN8p9DKSMkhhK0UT90KXoaJ7T7cVEWjHxjTePs6yq/T8zFtAfu3x556JQ7V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749738902; c=relaxed/simple;
	bh=x47xEvySNBbTPsIUgjRpFi6E+lwckEVa5g4MNNONcgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c39unsCMbHY2n9ZRXYyr2qAlfX5TvKo40DIE3hop0Zmh8UcakxkgouBindWWyARb5hIxwgJpD+RD8WpQRYNh2d98hSaf//FOjsZ6uv4BYT5BXWd4vtJh0O8LXHX9YOEgWO9owIkh7mEESF+VF6UTDlYN03Jd7bw8Fvg7ZO5FDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SfrpOPeW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=cEUjOGSiAcpALrQTqdsEIZR+Zxcg7kt1Nbfj3HDDR/I=; b=SfrpOPeW7klkIJAUyhQQULU7SH
	Q9R0mX7rcoR6l2xS9K3G/lNCD5KiielJX7kHygMhoRbiJCrs07s3jQjk8Vga0fbjfklwgY3c5hHEN
	wL09VaPKXkchOk1g7Wdzg+iBJEbFFn3KDXYb8OfbolPdBrU0WmtDKwSLvXOAt4pT1gWKZfLLiPlHy
	YqL7Lz4Y/X+tzCj4V1wCnwWR54ElNwP7IuvSxqjudE7RMeLxFol5hSv+/DJ3bX8T1Nz7Kypn8y8mt
	uLQKwPxUmgPZSl+zD9DhvWsSJxEBvJczfFqWoAji6AzHPV2leQlhqjrZzII7pg/7bpNo/htXsVv6y
	lNZvZDnA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPj0y-0000000BwyW-2ow1;
	Thu, 12 Jun 2025 14:34:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] mm: Remove zero_user()
Date: Thu, 12 Jun 2025 15:34:41 +0100
Message-ID: <20250612143443.2848197-6-willy@infradead.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250612143443.2848197-1-willy@infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users have now been converted to either memzero_page() or
folio_zero_range().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index e48d7f27b0b9..a30526cc53a7 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -292,12 +292,6 @@ static inline void zero_user_segment(struct page *page,
 	zero_user_segments(page, start, end, 0, 0);
 }
 
-static inline void zero_user(struct page *page,
-	unsigned start, unsigned size)
-{
-	zero_user_segments(page, start, start + size, 0, 0);
-}
-
 #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 static inline void copy_user_highpage(struct page *to, struct page *from,
-- 
2.47.2


