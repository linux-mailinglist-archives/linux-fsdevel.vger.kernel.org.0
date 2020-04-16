Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 180CC1ACB56
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442558AbgDPPqP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 11:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2896217AbgDPPqK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:46:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9852C061A10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 08:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iyas/lh8oLu1mcm5Nt3d+9HrXPcr/oP3NSQnuH/r6Vc=; b=GTtNV/HjK2L41/44EdQmz/+063
        d9Yzl0BDP1B4uW9Y54W/DVjO0lXqj9LNGSl8qVrgI95UEOimcv13CJ3I3y070O9N4bOnmcILcJqgI
        7uos9QssekvZkVULETgJ04UMT9Xo8yccQeLbTNQ6rCOZ8mku4zBR4ZeWsbZEh87V3h4o0G7ztlYnU
        9X9X5IXPMfIGCJuHA66gbUlykM3Jy+azVPjU1HRGvVBtfQxxoZqCIJi2KnrsVvqOS+hO/MQnPrWps
        JMuj1eknAx+cQEBArILn5GIkudAbSZRHTjpKfrChM8i1d4BJl8i00oHGefaRryAMw+2N4+TIk2r18
        DnB65zSg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6iN-00006R-Es; Thu, 16 Apr 2020 15:46:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v2 2/5] mm: Move PG_writeback into the bottom byte
Date:   Thu, 16 Apr 2020 08:46:03 -0700
Message-Id: <20200416154606.306-3-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416154606.306-1-willy@infradead.org>
References: <20200416154606.306-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By placing PG_writeback in the bottom byte along with PG_locked and
PG_waiters, we will be able to use the same optimisation as PG_locked
in a subsequent patch.  Add BUILD_BUGs to ensure that all three bits
stay in the bottom byte.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
---
 include/linux/page-flags.h | 4 ++--
 mm/filemap.c               | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7b2bb3..af7c0ff5f517 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -103,13 +103,14 @@
  */
 enum pageflags {
 	PG_locked,		/* Page is locked. Don't touch. */
+	PG_writeback,		/* Page is under writeback */
 	PG_referenced,
 	PG_uptodate,
 	PG_dirty,
 	PG_lru,
 	PG_active,
+	PG_waiters,		/* Page has waiters, check its waitqueue */
 	PG_workingset,
-	PG_waiters,		/* Page has waiters, check its waitqueue. Must be bit #7 and in the same byte as "PG_locked" */
 	PG_error,
 	PG_slab,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
@@ -117,7 +118,6 @@ enum pageflags {
 	PG_reserved,
 	PG_private,		/* If pagecache, has fs-private data */
 	PG_private_2,		/* If pagecache, has fs aux data */
-	PG_writeback,		/* Page is under writeback */
 	PG_head,		/* A head page */
 	PG_mappedtodisk,	/* Has blocks allocated on-disk */
 	PG_reclaim,		/* To be reclaimed asap */
diff --git a/mm/filemap.c b/mm/filemap.c
index e475117e89eb..b7c5d2402370 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1266,6 +1266,7 @@ EXPORT_SYMBOL_GPL(add_page_wait_queue);
 void unlock_page(struct page *page)
 {
 	BUILD_BUG_ON(PG_waiters != 7);
+	BUILD_BUG_ON(PG_locked > 7);
 	page = compound_head(page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	if (clear_bit_unlock_is_negative_byte(PG_locked, &page->flags))
@@ -1279,12 +1280,13 @@ EXPORT_SYMBOL(unlock_page);
  */
 void end_page_writeback(struct page *page)
 {
+	BUILD_BUG_ON(PG_writeback > 7);
 	/*
 	 * TestClearPageReclaim could be used here but it is an atomic
 	 * operation and overkill in this particular case. Failing to
 	 * shuffle a page marked for immediate reclaim is too mild to
 	 * justify taking an atomic operation penalty at the end of
-	 * ever page writeback.
+	 * every page writeback.
 	 */
 	if (PageReclaim(page)) {
 		ClearPageReclaim(page);
-- 
2.25.1

