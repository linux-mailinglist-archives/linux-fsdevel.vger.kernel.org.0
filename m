Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC930707A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 09:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhA1H5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhA1HFd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:05:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D3FC06178B;
        Wed, 27 Jan 2021 23:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=CxWQAtXy3I5lAmgNKcG2Me1pceWaP119juUXd37vOB0=; b=O+0Akf1AaopB68IjGsMsfPRYER
        jlSVynuejYtvR5pZldi6C6xIU88xCQn9wG52bUrJlPVuOwAX1hvA9vH2ESN5L4CUf1YPO2rBVXo48
        xl+h5iXc++BIFSi6HqytNWZqAbp8gvRXyoPBEOga29LjSLzwox3oxWMhqPnmz3t9WJm/VOydPvTzo
        IoUE7LtDZhL8MT+ByIfsuPegVNTKu/eFjQZmwLQxY8SPdDvPpDbS38wKPmax7TiSs4sBeumx3YC4y
        vq0Q4PRTk1UBWGwWdizC/QepOiVnNwJ4utpo9LKRc9Suxd1GHEWi+o0VyYwCaj5RE2XMAiyPeorud
        fyYyDh9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l51Lo-00847T-RK; Thu, 28 Jan 2021 07:04:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/25] mm: Add folio_index, folio_page and folio_contains
Date:   Thu, 28 Jan 2021 07:03:48 +0000
Message-Id: <20210128070404.1922318-10-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128070404.1922318-1-willy@infradead.org>
References: <20210128070404.1922318-1-willy@infradead.org>
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
index 83d24b41fb04..86956e97cd5e 100644
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

