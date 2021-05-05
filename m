Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FCF373F76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhEEQVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbhEEQVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 12:21:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059E4C061574;
        Wed,  5 May 2021 09:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=dqkC8rmvOviV5bazjnXxbNlOFCbuiP1RmVNh1h4r+MY=; b=v/3W28v/ThZ/16Qv3+i259pWMT
        0CNLhA8eTfKv+eiX9wg9hOD81yCu2oWSX+yyDrWJ3CnMZ4fcgajRRWXJUJqiRC60Ez2dkCFMbCCB8
        WbFHF3FZthxG+GP1J+e5fgkj7AcY23S6hd7HCqKmpxGn5xTESe3QEGxB6VSg3vMmCqeMAUJWUc2jq
        sREfMMhk07x9c+x9ewPOst7tOpKugTnMrt8vn2/7SxCXj8TueNKVCcmMk3FleG58Vk+j+ylft6nNv
        j4FJB76RTbs/p7gGVqt81NwKFR0nvtJgUifnNgDXlqvocmfqkA/POiyRXvBgY23t2JoS9OmDn27x7
        NtUvXw8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leKEL-000ZvQ-EV; Wed, 05 May 2021 16:19:04 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 63/96] mm/writeback: Add folio_account_cleaned
Date:   Wed,  5 May 2021 16:05:55 +0100
Message-Id: <20210505150628.111735-64-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get the statistics right; compound pages were being accounted as a
single page.  Also move the declaration to filemap.h since this is
part of the page cache.  Add a wrapper for account_page_cleaned().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h      |  3 ---
 include/linux/pagemap.h |  7 +++++++
 mm/page-writeback.c     | 11 ++++++-----
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 59655bde6c32..0beb94071a15 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -39,7 +39,6 @@ struct anon_vma_chain;
 struct file_ra_state;
 struct user_struct;
 struct writeback_control;
-struct bdi_writeback;
 struct pt_regs;
 
 extern int sysctl_page_lock_unfairness;
@@ -1994,8 +1993,6 @@ int __set_page_dirty_nobuffers(struct page *page);
 int __set_page_dirty_no_writeback(struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
-void account_page_cleaned(struct page *page, struct address_space *mapping,
-			  struct bdi_writeback *wb);
 bool folio_mark_dirty(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 84f0a823820b..a5933bcb5f00 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -840,6 +840,13 @@ static inline void __set_page_dirty(struct page *page,
 {
 	__folio_mark_dirty((struct folio *)page, mapping, warn);
 }
+void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
+			  struct bdi_writeback *wb);
+static inline void account_page_cleaned(struct page *page,
+		struct address_space *mapping, struct bdi_writeback *wb)
+{
+	return folio_account_cleaned(page_folio(page), mapping, wb);
+}
 
 void page_endio(struct page *page, bool is_write, int err);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 93a00d3efa55..261eb64387a9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2449,14 +2449,15 @@ static void folio_account_dirtied(struct folio *folio,
  *
  * Caller must hold lock_page_memcg().
  */
-void account_page_cleaned(struct page *page, struct address_space *mapping,
+void folio_account_cleaned(struct folio *folio, struct address_space *mapping,
 			  struct bdi_writeback *wb)
 {
 	if (mapping_can_writeback(mapping)) {
-		dec_lruvec_page_state(page, NR_FILE_DIRTY);
-		dec_zone_page_state(page, NR_ZONE_WRITE_PENDING);
-		dec_wb_stat(wb, WB_RECLAIMABLE);
-		task_io_account_cancelled_write(PAGE_SIZE);
+		long nr = folio_nr_pages(folio);
+		lruvec_stat_mod_folio(folio, NR_FILE_DIRTY, -nr);
+		zone_stat_mod_folio(folio, NR_ZONE_WRITE_PENDING, -nr);
+		wb_stat_mod(wb, WB_RECLAIMABLE, -nr);
+		task_io_account_cancelled_write(folio_size(folio));
 	}
 }
 
-- 
2.30.2

