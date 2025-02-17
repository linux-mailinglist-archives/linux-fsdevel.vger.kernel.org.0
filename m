Return-Path: <linux-fsdevel+bounces-41892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF25A38C3C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 20:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959E83B15CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA5523717D;
	Mon, 17 Feb 2025 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rJri8FlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60808187858
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2025 19:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739820014; cv=none; b=aKGS8U/SZ7ZySf5Dzp1j6QD07VZ4tpKJWpCE48qpWVNBcQxVRlAIpeDZCzu7qQ3cBc/J1/wLy9nnLrLWLut0frFXfU9oJ7Zikt4COQRcHDBe7n8zLpPXA5a97ChIWuTsuNCvUWzdiAPZjcbMWX2webMG4uFwGAXnNbNLthknAGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739820014; c=relaxed/simple;
	bh=SKhyeJaE8ssAxAgGdUB9eFRd425omTeGcmz+rHXViTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeBEoh6y32WAlcjYcIEGB9+NXO7BdwLwUA/WclllkWMSFysJ69zfkupLHBUpk38ISGOrKNbuPlNGEfysk8Z+wj40hm7HPRDSiwMTGbb/Q+uZG7OGbBm433/8qDV6TwcQUH7zm0L4TBReIAyP3pX3SwKy1UJbMmXgfgjK2UW8HAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rJri8FlG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BFsH9QAI2na8Ehr8EVKOMkw6rcymXneSI8UT5C9tTyE=; b=rJri8FlGfREkB95xC59cKRmfff
	95KyKR06lfzicmDOIR8qvngWjrFlT2V0rTWZi9hO8lsqsqMrMPa8UckoR4EMxhIRda0NNFxP8IQmt
	n0hzkG3hTShqFPrw6t1yH2511bRMlGGRPcX3e0GlD4aPdplTXwys0jiYJtn/2bgx+MChCorN0RxcQ
	l5xzqdsyyNIJPHY62YEW6XF6par9rT/TiyluLWLLnGuOXTmdbx8XoMP5o+UJOJksyywYQNyShUtKV
	gmKgsSVxFnTH49UJKn4sqpaiUlqSFKk643/lRUqJQqLKAg11hu1vATJrDEUrdJiTsrHg4cp49qFvo
	2AfmUeIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk6f5-00000001pvZ-310X;
	Mon, 17 Feb 2025 19:20:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/3] fs: Remove folio_file_mapping()
Date: Mon, 17 Feb 2025 19:20:08 +0000
Message-ID: <20250217192009.437916-3-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217192009.437916-1-willy@infradead.org>
References: <20250217192009.437916-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No callers of this function remain as filesystems no longer see
swapfile pages through their normal read/write paths.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 975c56fb4f85..ad7c0f615e9b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -535,26 +535,6 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 struct address_space *folio_mapping(struct folio *);
 struct address_space *swapcache_mapping(struct folio *);
 
-/**
- * folio_file_mapping - Find the mapping this folio belongs to.
- * @folio: The folio.
- *
- * For folios which are in the page cache, return the mapping that this
- * page belongs to.  Folios in the swap cache return the mapping of the
- * swap file or swap device where the data is stored.  This is different
- * from the mapping returned by folio_mapping().  The only reason to
- * use it is if, like NFS, you return 0 from ->activate_swapfile.
- *
- * Do not call this for folios which aren't in the page cache or swap cache.
- */
-static inline struct address_space *folio_file_mapping(struct folio *folio)
-{
-	if (unlikely(folio_test_swapcache(folio)))
-		return swapcache_mapping(folio);
-
-	return folio->mapping;
-}
-
 /**
  * folio_flush_mapping - Find the file mapping this folio belongs to.
  * @folio: The folio.
-- 
2.47.2


