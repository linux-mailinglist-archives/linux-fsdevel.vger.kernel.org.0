Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E929955E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 19:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789832AbgJZSbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 14:31:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:47260 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1789824AbgJZSbn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Nxr3mPTUTpTqNHQZgTOz1Cs76dGKRGwiKCi73s14jS4=; b=AvQOhwnb29KFpHetuF8xRT99VV
        i8gl5AB+jf/uhEqufUz88wxjT/paeS3Rh1DaYQ9NbhHEN+5ZFXil+zW0/etcNn5VlB3/gXu3w9gv5
        PJfCafIsc2b7mqgQAl4g79A+WThihEMzUiceLq3ejap/cq/xJ+sUlWzx2um7dJfp12yIOodh7sdYV
        j4CrWK15YfOYhy0gk92KD//1A16vxbBk04zZPVZGgCYaS85dj5OPTzGt6Lwy8Jse+bYYYEDGUrmj+
        jO1TD9NSXQBtno+1QwKSgRkRtrEZqMogO+18xAHjt1uZ0cdvUNZhdXLTftkC5VruphqUw3L6Ki/8c
        na6JiiGQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX7HS-0002jU-94; Mon, 26 Oct 2020 18:31:42 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/9] mm: Return head pages from grab_cache_page_write_begin
Date:   Mon, 26 Oct 2020 18:31:30 +0000
Message-Id: <20201026183136.10404-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026183136.10404-1-willy@infradead.org>
References: <20201026183136.10404-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function is only called from filesystems on their own mapping,
so no caller will be surprised by getting back a head page when they
were expecting a tail page.  This lets us remove a call to thp_head()
in wait_for_stable_page().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c        | 12 ++++++++++--
 mm/page-writeback.c |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2214a2c48dd1..62bc6affeb70 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3327,15 +3327,23 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 }
 EXPORT_SYMBOL(generic_file_direct_write);
 
-/*
+/**
+ * grab_cache_page_write_begin - Find or create a page for buffered writes.
+ * @mapping: The address space we're writing to.
+ * @index: The index we're writing to.
+ * @flags: %AOP_FLAG_NOFS to prevent memory reclaim calling the filesystem.
+ *
  * Find or create a page at the given pagecache position. Return the locked
  * page. This function is specifically for buffered writes.
+ *
+ * Return: The head page found in the cache, or NULL if no page could be
+ * created (due to lack of memory).
  */
 struct page *grab_cache_page_write_begin(struct address_space *mapping,
 					pgoff_t index, unsigned flags)
 {
 	struct page *page;
-	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT;
+	int fgp_flags = FGP_LOCK|FGP_WRITE|FGP_CREAT|FGP_HEAD;
 
 	if (flags & AOP_FLAG_NOFS)
 		fgp_flags |= FGP_NOFS;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7709f0e223f5..3671568d433f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2849,7 +2849,7 @@ EXPORT_SYMBOL_GPL(wait_on_page_writeback);
  */
 void wait_for_stable_page(struct page *page)
 {
-	page = thp_head(page);
+	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 	if (page->mapping->host->i_sb->s_iflags & SB_I_STABLE_WRITES)
 		wait_on_page_writeback(page);
 }
-- 
2.28.0

