Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12F1A15875A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBKBEE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:04:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54904 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgBKBED (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gNmBP2JYUyk+l9vVjSopvavD5DUUhW7hR9wGSwi0ypk=; b=q+zRvM7OoP7EzGdrNndsa/IM0V
        CaSZ2sVmqPPX+vs1TCTIqDnfWEdqTT7H4F4EPM8LLvHEJo1TPo6xv6i/pOe0OEL+PMh+tZfA9P/h+
        bo/vteh1oOO5/gTZ6tkdErl8STn2DHsckvps0VfCMnU5OUBIKpgpl1KL7hXhCOZN7ZO9OgLL+DZOq
        1u+7+IPyafu/zUqJdRE+En401twVvpcz6moo7vavL7bY2tVS0y+0kwsextbvsEhMl1/5vMClZbxAz
        U5mfj1kpW+SLhyQxMbPUVn6gBPZTc2ejjxdcYC6bV+NEx5wsUERg9gU3T2zvHN3yQFhH+6xw/JZUA
        HGMS8BpQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001oD-JL; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 09/13] erofs: Convert compressed files from readpages to readahead
Date:   Mon, 10 Feb 2020 17:03:44 -0800
Message-Id: <20200211010348.6872-10-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200211010348.6872-1-willy@infradead.org>
References: <20200211010348.6872-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in erofs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 17f45fcb8c5c..7c02015d501d 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1303,28 +1303,23 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->max_sync_decompress_pages;
 }
 
-static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
-			     struct list_head *pages, unsigned int nr_pages)
+static void z_erofs_readahead(struct readahead_control *rac)
 {
-	struct inode *const inode = mapping->host;
+	struct inode *const inode = rac->mapping->host;
 	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 
-	bool sync = should_decompress_synchronously(sbi, nr_pages);
+	bool sync = should_decompress_synchronously(sbi, readahead_count(rac));
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
-	gfp_t gfp = mapping_gfp_constraint(mapping, GFP_KERNEL);
-	struct page *head = NULL;
+	struct page *page, *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
-			      nr_pages, false);
+	trace_erofs_readpages(inode, readahead_index(rac),
+			readahead_count(rac), false);
 
-	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
-
-	for (; nr_pages; --nr_pages) {
-		struct page *page = lru_to_page(pages);
+	f.headoffset = readahead_offset(rac);
 
+	readahead_for_each(rac, page) {
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
 		/*
 		 * A pure asynchronous readahead is indicated if
@@ -1333,11 +1328,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 		 */
 		sync &= !(PageReadahead(page) && !head);
 
-		if (add_to_page_cache_lru(page, mapping, page->index, gfp)) {
-			list_add(&page->lru, &pagepool);
-			continue;
-		}
-
 		set_page_private(page, (unsigned long)head);
 		head = page;
 	}
@@ -1366,11 +1356,10 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 
 	/* clean up the remaining free pages */
 	put_pages_list(&pagepool);
-	return 0;
 }
 
 const struct address_space_operations z_erofs_aops = {
 	.readpage = z_erofs_readpage,
-	.readpages = z_erofs_readpages,
+	.readahead = z_erofs_readahead,
 };
 
-- 
2.25.0

