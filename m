Return-Path: <linux-fsdevel+bounces-7795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4370182B0BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F6B1F24E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE3C4C3C8;
	Thu, 11 Jan 2024 14:38:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B62148CED;
	Thu, 11 Jan 2024 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 11 Jan
 2024 17:38:36 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig
	<hch@lst.de>
Subject: [PATCH 5.10 1/2] mm/truncate: Inline invalidate_complete_page() into its one caller
Date: Thu, 11 Jan 2024 14:37:46 +0000
Message-ID: <20240111143747.4418-2-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111143747.4418-1-r.smirnov@omp.ru>
References: <20240111143747.4418-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/11/2024 14:25:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182570 [Jan 11 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;r.smirnovsmtp.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/11/2024 14:31:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/11/2024 1:37:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Commit 1b8ddbeeb9b819e62b7190115023ce858a159f5c upstream.

invalidate_inode_page() is the only caller of invalidate_complete_page()
and inlining it reveals that the first check is unnecessary (because we
hold the page locked, and we just retrieved the mapping from the page).
Actually, it does make a difference, in that tail pages no longer fail
at this check, so it's now possible to remove a tail page from a mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 kernel/futex/core.c |  2 +-
 mm/truncate.c       | 31 +++++--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index cde0ca876b93..cbbebc3de1d3 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -578,7 +578,7 @@ static int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	 * found it, but truncated or holepunched or subjected to
 	 * invalidate_complete_page2 before we got the page lock (also
 	 * cases which we are happy to fail).  And we hold a reference,
-	 * so refcount care in invalidate_complete_page's remove_mapping
+	 * so refcount care in invalidate_inode_page's remove_mapping
 	 * prevents drop_caches from setting mapping to NULL beneath us.
 	 *
 	 * The case we do have to guard against is when memory pressure made
diff --git a/mm/truncate.c b/mm/truncate.c
index 8914ca4ce4b1..03998fd86e4a 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -190,30 +190,6 @@ static void truncate_cleanup_page(struct page *page)
 	ClearPageMappedToDisk(page);
 }
 
-/*
- * This is for invalidate_mapping_pages().  That function can be called at
- * any time, and is not supposed to throw away dirty pages.  But pages can
- * be marked dirty at any time too, so use remove_mapping which safely
- * discards clean, unused pages.
- *
- * Returns non-zero if the page was successfully invalidated.
- */
-static int
-invalidate_complete_page(struct address_space *mapping, struct page *page)
-{
-	int ret;
-
-	if (page->mapping != mapping)
-		return 0;
-
-	if (page_has_private(page) && !try_to_release_page(page, 0))
-		return 0;
-
-	ret = remove_mapping(mapping, page);
-
-	return ret;
-}
-
 int truncate_inode_page(struct address_space *mapping, struct page *page)
 {
 	VM_BUG_ON_PAGE(PageTail(page), page);
@@ -258,7 +234,10 @@ int invalidate_inode_page(struct page *page)
 		return 0;
 	if (page_mapped(page))
 		return 0;
-	return invalidate_complete_page(mapping, page);
+	if (page_has_private(page) && !try_to_release_page(page, 0))
+		return 0;
+
+	return remove_mapping(mapping, page);
 }
 
 /**
@@ -645,7 +624,7 @@ void invalidate_mapping_pagevec(struct address_space *mapping,
 }
 
 /*
- * This is like invalidate_complete_page(), except it ignores the page's
+ * This is like invalidate_inode_page(), except it ignores the page's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
  * invalidation guarantees, and cannot afford to leave pages behind because
  * shrink_page_list() has a temp ref on them, or because they're transiently
-- 
2.34.1


