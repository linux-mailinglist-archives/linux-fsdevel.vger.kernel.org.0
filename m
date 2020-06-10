Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BB61F5CDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgFJURB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbgFJUNt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C423C08C5D1;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=WueiR9ClBR+SuUmlwhBVixkLUapU9LiFVjs2FwKptFw=; b=Ib0/cbiZsMjrh5GZh4ZA8ZsdY2
        klpGZJeArXDdQfA2xiQwLfZNtsV95uw+Q/RHNtGh8hpAOnotLkrSmMge24xAWMgPIZL9d6YQhdPIF
        P05camGYRlTJ1tZNEhJ4tv4nbwD86PMeP30wQ5SAxEZrgJSK68d9usY7lJFV1jiUEYpMen39soRQ4
        yR7pcyiXFKgjgoumY2NiTcWzA/WgduKS2tg0ud4bV5A3+m9xmSoC66ciYwGftMtfGfx35qtwXGOSN
        69rSoh0QIvooYftJKD2LAW91mhgPhd9WJGlRvA8pfxm/loFcLgvSh23dHahH1GVXhnmmrSZJHqY6C
        nPY9qiUA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76Z-0003Up-Vj; Wed, 10 Jun 2020 20:13:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 19/51] mm: Zero the head page, not the tail page
Date:   Wed, 10 Jun 2020 13:13:13 -0700
Message-Id: <20200610201345.13273-20-willy@infradead.org>
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

Pass the head page to zero_user_segment(), not the tail page, and adjust
the byte offsets appropriately.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/shmem.c    | 7 +++++++
 mm/truncate.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index a05d129a45e9..55405d811cfd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -898,11 +898,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		struct page *page = NULL;
 		shmem_getpage(inode, start - 1, &page, SGP_READ);
 		if (page) {
+			struct page *head = thp_head(page);
 			unsigned int top = PAGE_SIZE;
 			if (start > end) {
 				top = partial_end;
 				partial_end = 0;
 			}
+			if (head != page) {
+				unsigned int diff = start - 1 - head->index;
+				partial_start += diff << PAGE_SHIFT;
+				top += diff << PAGE_SHIFT;
+				page = head;
+			}
 			zero_user_segment(page, partial_start, top);
 			set_page_dirty(page);
 			unlock_page(page);
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da356..152974888124 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -374,12 +374,19 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	if (partial_start) {
 		struct page *page = find_lock_page(mapping, start - 1);
 		if (page) {
+			struct page *head = thp_head(page);
 			unsigned int top = PAGE_SIZE;
 			if (start > end) {
 				/* Truncation within a single page */
 				top = partial_end;
 				partial_end = 0;
 			}
+			if (head != page) {
+				unsigned int diff = start - 1 - head->index;
+				partial_start += diff << PAGE_SHIFT;
+				top += diff << PAGE_SHIFT;
+				page = head;
+			}
 			wait_on_page_writeback(page);
 			zero_user_segment(page, partial_start, top);
 			cleancache_invalidate_page(mapping, page);
-- 
2.26.2

