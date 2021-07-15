Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3224E3C9784
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 06:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbhGOEgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 00:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbhGOEgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 00:36:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122B8C061760;
        Wed, 14 Jul 2021 21:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=2QhJOnhbBGpurxBsSiN6RweehqGlvEhV4vRfvwJDCqY=; b=VdhdcYNoV1MkrQ3VBH1GgzOKgF
        A/wRWT70Vs+uOEAt3Sfc5BSBws1S85UCBZrX0AVMJvA/QbHGQfoo2fPAanOHtwiQvSMG98grPpk8l
        H9ehxdkac23hfRq5Die4zaNLxrWrp/YhYGIJvZnsFMJJbvHJbdzQRrARCqDZss9YJa9vso+kPfIAz
        iJyxSF2nYiqoEUYygAGLKtdC8ur2pNUPjjr8iVnX5LGLxyLI9WLO2PX25G0mpVuh05vwqEWXVfCWp
        vnfNBFBZFsKR2Mim/KBk5T++66idN9Lv6+sFIKen1QEQzpEHkfzRVq29UXEjYt7IMq1xvYcgdIki/
        yc64ZFvA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3t2p-002xjW-Bw; Thu, 15 Jul 2021 04:32:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 070/138] mm/writeback: Convert tracing writeback_page_template to folios
Date:   Thu, 15 Jul 2021 04:35:56 +0100
Message-Id: <20210715033704.692967-71-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename writeback_dirty_page() to writeback_dirty_folio() and
wait_on_page_writeback() to folio_wait_writeback().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/trace/events/writeback.h | 20 ++++++++++----------
 mm/page-writeback.c              |  6 +++---
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 297871ca0004..7dccb66474f7 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -52,11 +52,11 @@ WB_WORK_REASON
 
 struct wb_writeback_work;
 
-DECLARE_EVENT_CLASS(writeback_page_template,
+DECLARE_EVENT_CLASS(writeback_folio_template,
 
-	TP_PROTO(struct page *page, struct address_space *mapping),
+	TP_PROTO(struct folio *folio, struct address_space *mapping),
 
-	TP_ARGS(page, mapping),
+	TP_ARGS(folio, mapping),
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
@@ -69,7 +69,7 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
 		__entry->ino = mapping ? mapping->host->i_ino : 0;
-		__entry->index = page->index;
+		__entry->index = folio->index;
 	),
 
 	TP_printk("bdi %s: ino=%lu index=%lu",
@@ -79,18 +79,18 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 	)
 );
 
-DEFINE_EVENT(writeback_page_template, writeback_dirty_page,
+DEFINE_EVENT(writeback_folio_template, writeback_dirty_folio,
 
-	TP_PROTO(struct page *page, struct address_space *mapping),
+	TP_PROTO(struct folio *folio, struct address_space *mapping),
 
-	TP_ARGS(page, mapping)
+	TP_ARGS(folio, mapping)
 );
 
-DEFINE_EVENT(writeback_page_template, wait_on_page_writeback,
+DEFINE_EVENT(writeback_folio_template, folio_wait_writeback,
 
-	TP_PROTO(struct page *page, struct address_space *mapping),
+	TP_PROTO(struct folio *folio, struct address_space *mapping),
 
-	TP_ARGS(page, mapping)
+	TP_ARGS(folio, mapping)
 );
 
 DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e02c86eb445..2dc410b110ff 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2426,7 +2426,7 @@ static void folio_account_dirtied(struct folio *folio,
 {
 	struct inode *inode = mapping->host;
 
-	trace_writeback_dirty_page(&folio->page, mapping);
+	trace_writeback_dirty_folio(folio, mapping);
 
 	if (mapping_can_writeback(mapping)) {
 		struct bdi_writeback *wb;
@@ -2852,7 +2852,7 @@ EXPORT_SYMBOL(__folio_start_writeback);
 void folio_wait_writeback(struct folio *folio)
 {
 	while (folio_test_writeback(folio)) {
-		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		trace_folio_wait_writeback(folio, folio_mapping(folio));
 		folio_wait_bit(folio, PG_writeback);
 	}
 }
@@ -2874,7 +2874,7 @@ EXPORT_SYMBOL_GPL(folio_wait_writeback);
 int folio_wait_writeback_killable(struct folio *folio)
 {
 	while (folio_test_writeback(folio)) {
-		trace_wait_on_page_writeback(&folio->page, folio_mapping(folio));
+		trace_folio_wait_writeback(folio, folio_mapping(folio));
 		if (folio_wait_bit_killable(folio, PG_writeback))
 			return -EINTR;
 	}
-- 
2.30.2

