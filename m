Return-Path: <linux-fsdevel+bounces-17564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EA18AFC4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65E3E282708
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673EC2E85E;
	Tue, 23 Apr 2024 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GXqibsIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAFC2E647;
	Tue, 23 Apr 2024 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912970; cv=none; b=rKUEm+jTIbHpS1628fQ1bEHg2kr0/5arAbRpIMRLbOUYJdyY6d/bNJe+4xHTSDwvLVS5lbWdmR01g6CG/YGwuRPutx15IvK8Cq4rWeO47mpdD9SH2fGH1oHddVuaC0aK3WW2u/eI1TxDTfkw6vNrIMotmsMdqLsxHfuVNskjIQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912970; c=relaxed/simple;
	bh=b/AEiwuu1jH80Px8Xd6RO8rH7YWktD0bHMXARyA5LOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1T+VANQk80MRpFT6LdBW+0cDq35vQo94b6L7wP9ZB1avZwCOVuDqj5fPaWPTVUWQ1ujxXfN8gJyIV8bgGWYYgWOqQc5EC6zIm4E6UKnFYVFSa0Y9CmLfKSPFUV29kQLtDF3SVXd/cZx4HKs3Z4qUCK9TXqtiExIDvE6ZxBOkKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GXqibsIW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=6BdbrjGMJLxdb5ZMK/G6foThAN9UndlEGGEDv4wlWRI=; b=GXqibsIW/9Se+tRhLO20+7a/v9
	wsmcZhSZd4aKV02wYbXtdOm7xh9lbELNh6lQxP5GxA27iIrRPW1rK/Ymdtqpu/+/nGFyAzNy9lxxP
	vy6pUdo+sbheXOrI4jhKUlZ6Ipc8ez5vku8zL1C7HWAh5Bri1s4bZXyjWL8pl+8/66uAUJKoXWRUz
	3l94tyRtywEBnqZANW5qHke2GMUTLpyMRSsIt3MczQUwOdg6NTMK+fBrHg0SKG1L5aBKO9/X9mPsn
	+iuTcNxlzraFoaUd4AYsaG73ZFUkHXpkDEIEYj9kpBzwsfM/1YOZAAJd1F/v7zGZqC0EVto1KhuBu
	8OzRZSlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzP3K-0000000HG6O-308H;
	Tue, 23 Apr 2024 22:55:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 6/6] mm: Remove page_mapping()
Date: Tue, 23 Apr 2024 23:55:37 +0100
Message-ID: <20240423225552.4113447-7-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423225552.4113447-1-willy@infradead.org>
References: <20240423225552.4113447-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All callers are now converted, delete this compatibility wrapper.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 1 -
 mm/folio-compat.c       | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index b6f14e9a2d98..941f7ed714b9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -399,7 +399,6 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 #endif
 }
 
-struct address_space *page_mapping(struct page *);
 struct address_space *folio_mapping(struct folio *);
 struct address_space *swapcache_mapping(struct folio *);
 
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index f31e0ce65b11..f05906006b3c 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -10,12 +10,6 @@
 #include <linux/swap.h>
 #include "internal.h"
 
-struct address_space *page_mapping(struct page *page)
-{
-	return folio_mapping(page_folio(page));
-}
-EXPORT_SYMBOL(page_mapping);
-
 void unlock_page(struct page *page)
 {
 	return folio_unlock(page_folio(page));
-- 
2.43.0


