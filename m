Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4A2DC653
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Dec 2020 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgLPSZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Dec 2020 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbgLPSZO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8284DC0619D6;
        Wed, 16 Dec 2020 10:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0L6frvK+PnSLx5jvqHgY9tuRpy+KHxsnXUNvK+DbpUk=; b=HubEENrtOSbGlDjpvv3rjiMat7
        7R0jq9qAUTsQ/rw0e6ewdl63KB2nKUI77P98C8B+M/aG8oxVgd6aJQqDPW45r/+ju+JMIIRrOCcCs
        gaQqqCLzprxCA9/2Y1Fq5hWuGHNHxQKVAjBas0UDKi8gX7H0ZKLxrgg43kAKVY1kN1b8wH87A+/Ic
        wyKliWFFqWlR1PuiAdyvtfFiyg57wbDQoMIhvLaDDL1hAGUIWQIl8Zyof7Sw56w234KkwHEkz6VWZ
        TkzFSqTRwC7nKsx7kZhAv4kuk4D0tuv2QfXAN+8Hlgd+nbs5ymgzn1c5cjDQKTSRiizkPj0IG65x6
        THlLso2g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kpbSi-00078s-7g; Wed, 16 Dec 2020 18:23:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/25] mm: Add wait_on_folio_locked & wait_on_folio_locked_killable
Date:   Wed, 16 Dec 2020 18:23:32 +0000
Message-Id: <20201216182335.27227-23-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201216182335.27227-1-willy@infradead.org>
References: <20201216182335.27227-1-willy@infradead.org>
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
index ac4d3e2ac86c..22f9774d8a83 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -727,21 +727,29 @@ extern int wait_on_folio_bit_killable(struct folio *folio, int bit_nr);
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
 
 void wait_on_page_writeback(struct page *page);
-- 
2.29.2

