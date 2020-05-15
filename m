Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDDD1D4EE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgEONSI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbgEONRD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DC3C05BD19;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=aYJkiZGtapS3EI3nSaAZcijPUCj2H7jj4UUNli9ipQA=; b=o4xNijdiMl41kDuFLB3H7T+TfA
        ACNPaBxZh46ndjsZiHyYF3dDxXndNhMFBUhJqvCMnfBteuYm+BEfeAJIul5qFc+AS9zwJZ4YAHjty
        rmoD9yQE518yqJBXyMG6+M5mUj0txhwYqPBT1hDhK49s3rYGZiltF9giu+fLqchQRh/sAXz2jBwMt
        1AbQEcqW+lcCKGgkMN5+s9hOs0DQxMWqO/AhiBHQb78C+oZKlwKCCHSRQ4Zz9WJC0Ug21UmeG0KOZ
        cmcpY9zzaFhYhTguPZAZrROFHS2QEkgoyg17db6hydV0l/96HS1CC6q00yEjQkxoNJ9oAGtH2Jylt
        etBt+Y4g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005kq-B3; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 27/36] mm: Fix truncation for pages of arbitrary size
Date:   Fri, 15 May 2020 06:16:47 -0700
Message-Id: <20200515131656.12890-28-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
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

