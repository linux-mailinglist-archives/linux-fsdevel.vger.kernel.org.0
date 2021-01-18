Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F692FA75F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407141AbhARRVb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406862AbhARRDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:03:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E0C061786;
        Mon, 18 Jan 2021 09:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=E7LRD3fcVDvsB9HUN1R1ioAxMdx8PfnLFsCs+5WgdVQ=; b=rZMooSdA5c2cL0uXzBL4v7sPp7
        DFYAs0zP6BIJeXpvgNbIXfluIGXtX7kO+irPq/FagQNECqXOFfk2Q6Hf0X/BNYOrbiTbnIubADB/1
        DKQa8lJ6aK5p2fuus52/CshrwVKesDa3MzaWZW/mAwcDEANYw8uoT2fd4siKjk6a6iGpl58mf86KI
        h+BpUt+5zv2zIRYVXrZ27BJuWeAgyjI8FSFSUPCLG0TWoOe1ASFCKfmzlZa1VxjRRiwD77LoUmxSp
        uE0oNbI23A7MFnbVctloLsgo9Oel3a9eAmDB2dLQS22L1xt3+tcTkxHrmJ4O5WXaVUIUi2M71FWlj
        9urk5BUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1Xul-00D7Io-Ds; Mon, 18 Jan 2021 17:02:03 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/27] mm: Add folio_index, folio_page and folio_contains
Date:   Mon, 18 Jan 2021 17:01:30 +0000
Message-Id: <20210118170148.3126186-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118170148.3126186-1-willy@infradead.org>
References: <20210118170148.3126186-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

folio_index() is the equivalent of page_index() for folios.  folio_page()
finds the page in a folio for a page cache index.  folio_contains()
tells you whether a folio contains a particular page cache index.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index a739ada01d27..c27b74c63b5e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -447,6 +447,29 @@ static inline bool thp_contains(struct page *head, pgoff_t index)
 	return page_index(head) == (index & ~(thp_nr_pages(head) - 1UL));
 }
 
+static inline pgoff_t folio_index(struct folio *folio)
+{
+        if (unlikely(FolioSwapCache(folio)))
+                return __page_file_index(&folio->page);
+        return folio->page.index;
+}
+
+static inline struct page *folio_page(struct folio *folio, pgoff_t index)
+{
+	index -= folio_index(folio);
+	VM_BUG_ON_FOLIO(index >= folio_nr_pages(folio), folio);
+	return &folio->page + index;
+}
+
+/* Does this folio contain this index? */
+static inline bool folio_contains(struct folio *folio, pgoff_t index)
+{
+	/* HugeTLBfs indexes the page cache in units of hpage_size */
+	if (PageHuge(&folio->page))
+		return folio->page.index == index;
+	return index - folio_index(folio) < folio_nr_pages(folio);
+}
+
 /*
  * Given the page we found in the page cache, return the page corresponding
  * to this index in the file
-- 
2.29.2

