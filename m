Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE61C1AD275
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Apr 2020 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgDPWBe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 18:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728349AbgDPWBd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:01:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E980FC061A10
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Bxxac8rPpxFCn2vMZy1pjVgSDM6NCTXbjhuygetfgds=; b=awS7UAjv8YBFhXkF/tcYNeXjRL
        MSqnk5aDAj4IQCIOds+UYkCCRTQRvOCvZRu1l85xwNPUug9q8+2INvQIBrOe9dQjse3f12HEtbKmG
        bZcQTU7sXXN5EaHB9umiIoZm/U7rtnu7NPQ2C/bhbeWvj+9Ep+1DxUY0ZyXZxt/PiCldF9DEdIKYs
        /kh1RH/TDCb3NjMtdT5vYtXpbJsZG2RdB4WZbfBr+JroHQ14D48wLJQtec/X0bbk++e9ixhpJa/3e
        IXTBQUrtna6jhxyANv/bk1h+XGNtamrqW2jzGXTgk/+8BCZQ73mhO+utiBLr24OBXnzuPF2ArT7Ad
        IKS/J8Og==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jPCZg-0003Ud-LO; Thu, 16 Apr 2020 22:01:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>
Subject: [PATCH v3 08/11] mm: Move PG_writeback into the bottom byte
Date:   Thu, 16 Apr 2020 15:01:27 -0700
Message-Id: <20200416220130.13343-9-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200416220130.13343-1-willy@infradead.org>
References: <20200416220130.13343-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

By placing PG_writeback in the bottom byte along with PG_locked and
PG_waiters, we will be able to use the same optimisation as PG_locked
in the next patch.  Add BUILD_BUGs to ensure that all three bits stay
in the bottom byte.

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

