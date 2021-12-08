Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5FE46CC54
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhLHE0n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbhLHE0m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B9C061746
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gVZ3rj3pgutoF/5OlXrYdrDfuJpr8xgCvEFXIoJz1Jc=; b=KP3Iav7r26bF8QCQ/kUMUsXXI6
        woSAaYBE1KSsaNOSmtMKTCEhQo4V/eRqoImEZHjipA7BcI3ovCiggyoV5Ix8hHvZDDijEa1srBoPu
        j+smk4ADhhGCUqFY1Y6BDwoRQVbiqkHCX9P61oPxx5ky/cXfHyP67fEAoibxE1pUQ9HNG/SJFo8+Y
        jyVVMlv3IGMbCXmv9eE2CB3zI6gcTTkdbd/QiYED02LEVxlI5seeRbx5BWEgtuVEBxoctZzMidyaV
        hHjREjrP1zvIg+zFSOSuhN4gufcrEn+L9H9tWWbDfrlbqbBO+lMeobm2nzDRdIZG9gIsHb4C8tSZD
        7bBYYDxw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU1-0084Wn-QP; Wed, 08 Dec 2021 04:23:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 04/48] mm/writeback: Improve __folio_mark_dirty() comment
Date:   Wed,  8 Dec 2021 04:22:12 +0000
Message-Id: <20211208042256.1923824-5-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some notes about how this function needs to be called.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index a613f8ef6a02..91d163f8d36b 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2496,7 +2496,11 @@ void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
  * If warn is true, then emit a warning if the folio is not uptodate and has
  * not been truncated.
  *
- * The caller must hold lock_page_memcg().
+ * The caller must hold lock_page_memcg().  Most callers have the folio
+ * locked.  A few have the folio blocked from truncation through other
+ * means (eg zap_page_range() has it mapped and is holding the page table
+ * lock).  This can also be called from mark_buffer_dirty(), which I
+ * cannot prove is always protected against truncate.
  */
 void __folio_mark_dirty(struct folio *folio, struct address_space *mapping,
 			     int warn)
-- 
2.33.0

