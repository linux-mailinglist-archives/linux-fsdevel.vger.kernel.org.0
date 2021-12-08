Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC04346CC84
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 05:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbhLHE3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Dec 2021 23:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240104AbhLHE0s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:26:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A29C0698C4
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Dec 2021 20:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=e0hyHWAmzlXP+aObqjdWnAJ+TFDQXw//r2+3SQKN8pQ=; b=MC0SZlqDdsPCFEh/D6J0RPxNXW
        zkz67m1pLbrEZR5ngrhJ94reVvmupJyALO1vhSOhi2+IhDDEn7OjzXcm5SW83shxAa7/ps5gmwmV/
        UL3QZtt9/TpojRlRKpQ+4xstwEQBhzo7eDFsWPulepYtEKWpMLdt3zBhlL1uJ599OgcGbsosSOJ9A
        oLqFpYte+Ej/3Fu+AMn5RG4NghNAsY16LJk69ipPqN/X9OAe2e60EK6MOv3lU0NHCIqx437/qw5En
        +luVWqHvHUq/6oKD4LX9f5Q4CQvmWP9mNrfwaYUOvjrHPXE4lqIVKnmAxOoCYrbCXupZx/rAH7Unv
        RVXEGAcA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muoU4-0084Yp-BJ; Wed, 08 Dec 2021 04:23:12 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 23/48] filemap: Convert do_async_mmap_readahead to take a folio
Date:   Wed,  8 Dec 2021 04:22:31 +0000
Message-Id: <20211208042256.1923824-24-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208042256.1923824-1-willy@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call page_cache_async_ra() directly instead of indirecting through
page_cache_async_readahead().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index c4f887c277d0..0838b08557f5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3001,25 +3001,25 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
  * was pinned if we have to drop the mmap_lock in order to do IO.
  */
 static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
-					    struct page *page)
+					    struct folio *folio)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	struct address_space *mapping = file->f_mapping;
+	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
-	pgoff_t offset = vmf->pgoff;
 
 	/* If we don't want any read-ahead, don't bother */
 	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
 		return fpin;
+
 	mmap_miss = READ_ONCE(ra->mmap_miss);
 	if (mmap_miss)
 		WRITE_ONCE(ra->mmap_miss, --mmap_miss);
-	if (PageReadahead(page)) {
+
+	if (folio_test_readahead(folio)) {
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-		page_cache_async_readahead(mapping, ra, file,
-					   page, offset, ra->ra_pages);
+		page_cache_async_ra(&ractl, folio, ra->ra_pages);
 	}
 	return fpin;
 }
@@ -3069,12 +3069,13 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	page = find_get_page(mapping, offset);
 	if (likely(page)) {
+		struct folio *folio = page_folio(page);
 		/*
 		 * We found the page, so try async readahead before waiting for
 		 * the lock.
 		 */
 		if (!(vmf->flags & FAULT_FLAG_TRIED))
-			fpin = do_async_mmap_readahead(vmf, page);
+			fpin = do_async_mmap_readahead(vmf, folio);
 		if (unlikely(!PageUptodate(page))) {
 			filemap_invalidate_lock_shared(mapping);
 			mapping_locked = true;
-- 
2.33.0

