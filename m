Return-Path: <linux-fsdevel+bounces-3037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8847EF5F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 17:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7262812F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7523DBB3;
	Fri, 17 Nov 2023 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eajgtCer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D4F194
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 08:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5qnFXc1Xogmh7PAIEEQ0Shj70PekKGvUt3R6/VGwhqA=; b=eajgtCermKMU/e17PoydSMDg9r
	+kz5k6bnBxxa9t7In5z9eci5kjX7tVUaXqZh+9RxzYJvhLiGT60uRDBHbuA7no6VvrrnVthyJvuLV
	pl8i/tVkgrMfhjjfvaaEHuvF3NDpQ24zf4m9HqFihpQ3vBLF/XeFwCdxQzgjv5m5frpWsQdT5zUDa
	HPb1KANQtiPQum5YxUn4dme7qift/JXUa9/FMi4K2LX/2Jm5zmMt7AY6/sLWHv3umATpyaGAr/Fl3
	FWf/7zyh0qZpLFdDLd5hEQ3ul1AJfw8Rt6Ix+cMsejBKKv50kztvCiYuXE8ayVRz2nOZBekrg05Dg
	+MngwkxA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r41Uc-00AKZj-Na; Fri, 17 Nov 2023 16:14:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 4/6] memory-failure: Use a folio in me_huge_page()
Date: Fri, 17 Nov 2023 16:14:45 +0000
Message-Id: <20231117161447.2461643-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231117161447.2461643-1-willy@infradead.org>
References: <20231117161447.2461643-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function was already explicitly calling compound_head();
unfortunately the compiler can't know that and elide the redundant
calls to compound_head() buried in page_mapping(), unlock_page(), etc.
Switch to using a folio, which does let us elide these calls.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/memory-failure.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e73f2047ffcb..d97d247c0224 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1182,25 +1182,25 @@ static int me_swapcache_clean(struct page_state *ps, struct page *p)
  */
 static int me_huge_page(struct page_state *ps, struct page *p)
 {
+	struct folio *folio = page_folio(p);
 	int res;
-	struct page *hpage = compound_head(p);
 	struct address_space *mapping;
 	bool extra_pins = false;
 
-	mapping = page_mapping(hpage);
+	mapping = folio_mapping(folio);
 	if (mapping) {
-		res = truncate_error_page(hpage, page_to_pfn(p), mapping);
+		res = truncate_error_page(&folio->page, page_to_pfn(p), mapping);
 		/* The page is kept in page cache. */
 		extra_pins = true;
-		unlock_page(hpage);
+		folio_unlock(folio);
 	} else {
-		unlock_page(hpage);
+		folio_unlock(folio);
 		/*
 		 * migration entry prevents later access on error hugepage,
 		 * so we can free and dissolve it into buddy to save healthy
 		 * subpages.
 		 */
-		put_page(hpage);
+		folio_put(folio);
 		if (__page_handle_poison(p) >= 0) {
 			page_ref_inc(p);
 			res = MF_RECOVERED;
-- 
2.42.0


