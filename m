Return-Path: <linux-fsdevel+bounces-26544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC295A55A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 21:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E403D1C21948
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 19:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E1E170855;
	Wed, 21 Aug 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bz4y1KMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC516E895
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724268908; cv=none; b=nV7JAmQrg40v60pzP9s83zYMLjsEzdj3dmDNtPccSuCXwJVisrWbz3PUdLVYYa2BvnvEcFGiSO31llFxH3/5noqgjR4xAfXZfzxDgii/ABYNVFzCT/mTylLGza+lgkG8pN0MqE5lJh+tgf+WowP2M+0yiqPB+kLjeSOUWPPZVyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724268908; c=relaxed/simple;
	bh=rSBS39uXpIZsM1m8Gfutk+e6ssZCJKIqFV7L8jFeVdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdB/RbWZVQW4BUeN9gjxrfPHhSBKFYf/XbjW9TfnG6p+zdpqlb1SMYMcolyJ3wP0hz2+4CJAks8mlBjOm+YUhK01ZEwGcBuFqT6oQWcR7Y39vZutLLCwtylKX1pDqaYGKhvNkaA/BFiIb19qtdxABCQoP8WEOYd/ww6qKrdhI3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bz4y1KMz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=PFYGF888esVx5is+dDOIN1XZFjPX09/KPzfotQSNrpE=; b=bz4y1KMzS8T/uu3zwWjk/iTFzg
	Dz9zVtDX+aD2O81VUnyS8Ci9+9iROW7x9hQql9Wl5x+3DUJBCFOA8Rc6THDTlZPyNUw1JNh8r97EL
	9Uyvq+us/PqHxShueB0wN+4yqlLVJYl2pJBKi1F822Gmz1+NW14DGHuqCdc3gzGW33NKNnDnyKkzb
	mkjaG4Xmsa2cZq+dwzT7ZSmEdJB0PqXbB/tHlpwQnaFPRAORo7YVew2AdiCEBpTOsF4oPdJogOMHH
	35SWcnbOzIBtUZjARl0d8MNDoJRMzBo0Kiluc4G6jTBIz79/mPp0tqyo0s+9yvEonoR4dgaQC9Jrq
	IVLRVLAg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgr6V-00000009cqj-0l7L;
	Wed, 21 Aug 2024 19:34:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 05/10] mm: Remove PageUnevictable
Date: Wed, 21 Aug 2024 20:34:38 +0100
Message-ID: <20240821193445.2294269-6-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240821193445.2294269-1-willy@infradead.org>
References: <20240821193445.2294269-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is only one caller of PageUnevictable() left; convert it to call
folio_test_unevictable() and remove all the page accessors.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/page-flags.h |  6 +++---
 mm/huge_memory.c           | 16 ++++++++--------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 43a7996c53d4..bdf24f65d998 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -580,9 +580,9 @@ FOLIO_CLEAR_FLAG(swapcache, FOLIO_HEAD_PAGE)
 FOLIO_FLAG_FALSE(swapcache)
 #endif
 
-PAGEFLAG(Unevictable, unevictable, PF_HEAD)
-	__CLEARPAGEFLAG(Unevictable, unevictable, PF_HEAD)
-	TESTCLEARFLAG(Unevictable, unevictable, PF_HEAD)
+FOLIO_FLAG(unevictable, FOLIO_HEAD_PAGE)
+	__FOLIO_CLEAR_FLAG(unevictable, FOLIO_HEAD_PAGE)
+	FOLIO_TEST_CLEAR_FLAG(unevictable, FOLIO_HEAD_PAGE)
 
 #ifdef CONFIG_MMU
 PAGEFLAG(Mlocked, mlocked, PF_NO_TAIL)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index cf8e34f62976..d92f19812c89 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3017,25 +3017,25 @@ static void remap_page(struct folio *folio, unsigned long nr)
 	}
 }
 
-static void lru_add_page_tail(struct page *head, struct page *tail,
+static void lru_add_page_tail(struct folio *folio, struct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
-	VM_BUG_ON_PAGE(!PageHead(head), head);
-	VM_BUG_ON_PAGE(PageLRU(tail), head);
+	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
+	VM_BUG_ON_FOLIO(PageLRU(tail), folio);
 	lockdep_assert_held(&lruvec->lru_lock);
 
 	if (list) {
 		/* page reclaim is reclaiming a huge page */
-		VM_WARN_ON(PageLRU(head));
+		VM_WARN_ON(folio_test_lru(folio));
 		get_page(tail);
 		list_add_tail(&tail->lru, list);
 	} else {
 		/* head is still on lru (and we have it frozen) */
-		VM_WARN_ON(!PageLRU(head));
-		if (PageUnevictable(tail))
+		VM_WARN_ON(!folio_test_lru(folio));
+		if (folio_test_unevictable(folio))
 			tail->mlock_count = 0;
 		else
-			list_add_tail(&tail->lru, &head->lru);
+			list_add_tail(&tail->lru, &folio->lru);
 		SetPageLRU(tail);
 	}
 }
@@ -3134,7 +3134,7 @@ static void __split_huge_page_tail(struct folio *folio, int tail,
 	 * pages to show after the currently processed elements - e.g.
 	 * migrate_pages
 	 */
-	lru_add_page_tail(head, page_tail, lruvec, list);
+	lru_add_page_tail(folio, page_tail, lruvec, list);
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-- 
2.43.0


