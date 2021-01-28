Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375DE306E22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbhA1HHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhA1HGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:06:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67DC061573;
        Wed, 27 Jan 2021 23:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=WrcE9wDLGwcgqmg9jOBMPtFnKP9h0xvtDeRBx/lUkUM=; b=R4a+DNuRMUROgC5bZJpYYWEIKq
        cG+V8j2Im9pzS9xlxg7vBc9Pq2AnAjWq7DNKFQbCwfk9M5unx0e5ExjyMnQUDHmLhQWO1FcqUVAu0
        tSeIo4KLmO2eS51f28D2jIEsCTr1RA+uEMWeDhE/S/yItfs0luLTHRw32i+CPdTvtMNfMzGNRrJof
        M8UGoJHkk4qLcKzC5ZOZ1ol7BXk32+zn6rSXCsHaYAT5qeKbo9tl3OwFUGi0Px/FNYfpodwHXEJhs
        Oh2JGB90MNWCasKj6cvLUJT2e0ejCsxAniSVlprgeN42swk0wSwY4Sr9VGJzUSGh26IcNS8LwA8lB
        YLgKDZCw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51MF-00848W-Mn; Thu, 28 Jan 2021 07:04:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/25] mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
Date:   Thu, 28 Jan 2021 07:03:59 +0000
Message-Id: <20210128070404.1922318-21-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Turn wait_on_page_locked() and wait_on_page_locked_killable() into
wrappers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 757e437e7f09..546565a7907c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -730,16 +730,14 @@ extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
  * ie with increased "page->count" so that the page won't
  * go away during the wait..
  */
-static inline void wait_on_page_locked(struct page *page)
+static inline void wait_on_folio_locked(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	if (FolioLocked(folio))
 		wait_on_folio_bit(folio, PG_locked);
 }
 
-static inline int wait_on_page_locked_killable(struct page *page)
+static inline int wait_on_folio_locked_killable(struct folio *folio)
 {
-	struct folio *folio = page_folio(page);
 	if (!FolioLocked(folio))
 		return 0;
 	return wait_on_folio_bit_killable(folio, PG_locked);
@@ -759,6 +757,16 @@ static inline void wait_on_page_fscache(struct page *page)
 		wait_on_folio_bit(folio, PG_fscache);
 }
 
+static inline void wait_on_page_locked(struct page *page)
+{
+	wait_on_folio_locked(page_folio(page));
+}
+
+static inline int wait_on_page_locked_killable(struct page *page)
+{
+	return wait_on_folio_locked_killable(page_folio(page));
+}
+
 int put_and_wait_on_page_locked(struct page *page, int state);
 void wait_on_folio_writeback(struct folio *folio);
 static inline void wait_on_page_writeback(struct page *page)
-- 
2.29.2

