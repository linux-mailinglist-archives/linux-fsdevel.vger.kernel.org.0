Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9861E1E7335
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 05:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391774AbgE2DAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 23:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407290AbgE2C6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 22:58:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DCBC008630;
        Thu, 28 May 2020 19:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aYJkiZGtapS3EI3nSaAZcijPUCj2H7jj4UUNli9ipQA=; b=nJnZNf8tfVg7EFBrZJqumiyTyY
        Bje0odEdqWl6kWDiQ3bhdocJf9hVFl1YRGRVwlAtnb/NrM9vo5WaZ8EeOulUxA+7cP824PW/HXH4h
        VLGSQi83MRWRPJg69L7H2pQK3LaR+1ndt7dBtTSabgP2onMW/OgfLIU2PQ3pOcOh2yzd4uTd7KIBa
        4L6TCMaf7tWnFazU2f9tp3M+gmIoa3JnVbc1mH4OMEo4uwO7WlTBiGwsgKhqcA20ICcoiYbc4hSqZ
        U8k2slRo0DGsU5b6SQgcO7QjcXO7gVauUUcwOJdAPrz3QMP63orhBtXR5uEQAhWFAPqen9oCmXGyH
        b6rmnyCw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeVE3-0008Sv-MU; Fri, 29 May 2020 02:58:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 29/39] mm: Fix truncation for pages of arbitrary size
Date:   Thu, 28 May 2020 19:58:14 -0700
Message-Id: <20200529025824.32296-30-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200529025824.32296-1-willy@infradead.org>
References: <20200529025824.32296-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the assumption that a compound page is HPAGE_PMD_SIZE,
and the assumption that any page is PAGE_SIZE.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/truncate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..dad384a4dc6d 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -168,7 +168,7 @@ void do_invalidatepage(struct page *page, unsigned int offset,
  * becomes orphaned.  It will be left on the LRU and may even be mapped into
  * user pagetables if we're racing with filemap_fault().
  *
- * We need to bale out if page->mapping is no longer equal to the original
+ * We need to bail out if page->mapping is no longer equal to the original
  * mapping.  This happens a) when the VM reclaimed the page while we waited on
  * its lock, b) when a concurrent invalidate_mapping_pages got there first and
  * c) when tmpfs swizzles a page between a tmpfs inode and swapper_space.
@@ -177,12 +177,12 @@ static void
 truncate_cleanup_page(struct address_space *mapping, struct page *page)
 {
 	if (page_mapped(page)) {
-		pgoff_t nr = PageTransHuge(page) ? HPAGE_PMD_NR : 1;
+		unsigned int nr = hpage_nr_pages(page);
 		unmap_mapping_pages(mapping, page->index, nr, false);
 	}
 
 	if (page_has_private(page))
-		do_invalidatepage(page, 0, PAGE_SIZE);
+		do_invalidatepage(page, 0, thp_size(page));
 
 	/*
 	 * Some filesystems seem to re-dirty the page even after
-- 
2.26.2

