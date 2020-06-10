Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223CC1F5CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgFJUPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730577AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10935C00863B;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=mmPoGnRfA4TUBSdV1ap2zn7Ew2a8qCnx8Rp9BKBKl4s=; b=Q5FK+pK0rlhrqdQfcRpYaQNhyr
        9ERE6UdAQr92hPMbjQZaSR5ylWRW5PjUBvl0S98MdVV1cmRWTQBfI6DjgaHA5QgTMk9o+4YZefDFQ
        ujIFF9I4t50ykVeBiDedoUZ98B96D3Op4PnbePR9YyBhA4+9IK9LlhSQPjg9/RQRUIEfRGuxaQJAX
        g2GrClrm5J9SRCH2mm1DlmaO59hh4JEpYl4kFUkvT2KKIJRMU53JdILUluaWtzQVQDk4CoWxhkup/
        oXlPFQLp6+orAWifK/R6CoiLOnDCCYy0IPybyQA2HShydsk9CInMgFQpxox701IJEFOl0z1LTamw8
        9FJaHaaw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003XP-UF; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 41/51] mm: Fix truncation for pages of arbitrary size
Date:   Wed, 10 Jun 2020 13:13:35 -0700
Message-Id: <20200610201345.13273-42-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
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
index 152974888124..a9fde773179b 100644
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
+		unsigned int nr = thp_nr_pages(page);
 		unmap_mapping_pages(mapping, page->index, nr, false);
 	}
 
 	if (page_has_private(page))
-		do_invalidatepage(page, 0, PAGE_SIZE);
+		do_invalidatepage(page, 0, thp_size(page));
 
 	/*
 	 * Some filesystems seem to re-dirty the page even after
-- 
2.26.2

