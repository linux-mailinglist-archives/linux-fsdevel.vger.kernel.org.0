Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63C2FA723
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405768AbhARRKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406785AbhARRER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:04:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D014C0613D3;
        Mon, 18 Jan 2021 09:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Kylbs0g4ewc+jvtnrfyqm6ClOMM1NzhqiyDdrSqfr0c=; b=hc15vIjFAuuafy9VINn06pE1JT
        HOz8GsraikGCaeI5c1i5jbMbFus/8BfOl6qf5EiSNFP3H8vdGnwrCgr7u8x4h4IZTLMs50cYhHk1X
        NH9D2UoHBj3Zb5dDqfgSwvnv5cM4Zhy+c7dJhC0ue0KBxzAVC7WECDSf1OhOxHExAClXWryyvX3Mt
        VYjG3JPXJ+JjpjNfWhndj2D1JAr0IAIJuSStXdl95Ev0Q4elrG92TLInqEbxhGV8Lc27LdOG79k93
        FRLRNKe2gqBaPD84jOrEmympzYM/yvgnC/FlhpoP6VEmsDvzVOZX+694hwcAXv/4MS6G7iztWgh4b
        s4tCcWNA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xw0-00D7Vn-TS; Mon, 18 Jan 2021 17:03:24 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/27] mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
Date:   Mon, 18 Jan 2021 17:01:43 +0000
Message-Id: <20210118170148.3126186-23-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
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
index 619bfc6ea1ff..d28b53f91275 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -729,21 +729,29 @@ extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
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
 extern void put_and_wait_on_page_locked(struct page *page);
 
 void wait_on_folio_writeback(struct folio *folio);
-- 
2.29.2

