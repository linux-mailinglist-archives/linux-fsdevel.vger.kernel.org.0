Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D09546CC7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240145AbhLHE26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240209AbhLHE0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B802C0698CC
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=8xbmIsGq9D+rej3BrE9p2VwSQhGNmZUjepcD8zMRSIA=; b=nlhDT7vd2bgRqO+rVD4ENwDbwp
        ph/q9Sk2q1LlWI0cBCKBSD41oNRVG1/Rnprrwi1LVMTIrJd36uiUseWHiHV3Hgw9J3cIPFi8igzgt
        9gH7bIQSWGqTRyqcS5AwiqBX0nUkhOqDOXQpQzW2F/g97ByAvePirmpoDmHqcS99yyPTmuqzezGXU
        GcME17NHhb1bDoiWJDD49B332EP15+1XWZpjW7iAMF7XbGMurKIBXy4+ucSaGh3083qpA9RGzBNPN
        YYw0IfJ8YNC1IgWWiULwXDFJO0InwXlm8uDXEPgsJ7lPK2Z+g+Zc3aH+lUYl+2Zv9vP/OHKIWXfD1
        zHTJwyQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU5-0084Zk-EL; Wed, 08 Dec 2021 04:23:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 30/48] filemap: Use a folio in filemap_page_mkwrite
Date:   Wed,  8 Dec 2021 04:22:38 +0000
Message-Id: <20211208042256.1923824-31-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes a bug for tail pages.  They always have a NULL mapping, so
the check would fail and we would never mark the folio as dirty.
Ends up growing the kernel by 19 bytes although there will be fewer
calls to compound_head() dynamically.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8cca04a79808..4ae9d5befffa 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3349,24 +3349,24 @@ EXPORT_SYMBOL(filemap_map_pages);
 vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
-	struct page *page = vmf->page;
+	struct folio *folio = page_folio(vmf->page);
 	vm_fault_t ret = VM_FAULT_LOCKED;
 
 	sb_start_pagefault(mapping->host->i_sb);
 	file_update_time(vmf->vma->vm_file);
-	lock_page(page);
-	if (page->mapping != mapping) {
-		unlock_page(page);
+	folio_lock(folio);
+	if (folio->mapping != mapping) {
+		folio_unlock(folio);
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
 	/*
-	 * We mark the page dirty already here so that when freeze is in
+	 * We mark the folio dirty already here so that when freeze is in
 	 * progress, we are guaranteed that writeback during freezing will
-	 * see the dirty page and writeprotect it again.
+	 * see the dirty folio and writeprotect it again.
 	 */
-	set_page_dirty(page);
-	wait_for_stable_page(page);
+	folio_mark_dirty(folio);
+	folio_wait_stable(folio);
 out:
 	sb_end_pagefault(mapping->host->i_sb);
 	return ret;
-- 
2.33.0

