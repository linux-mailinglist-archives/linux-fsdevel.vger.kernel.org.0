Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7CE18FF3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 21:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCWUY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 16:24:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbgCWUXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qGMDtGI8LcILAiviNIJOK9D4EAi8624WVoxyVV3Hgf4=; b=GpqM04sbe6riKS+15W0ugVavP6
        Apf+u6QJ4Hta+TVnwLxfhu0lR/o5eMq2YMzSRxqV1WJMT4DE/xg6HZkuskBGaovRmyE8hYh5qFqog
        A8xp50rkVr/2QDJyUsy+/I0BbeYMJRhdS3/cwQUttvRr0c0kGgJCCV4czApsFvjjeqe/gvRWH+PSX
        fYFU3xGhaR7WuxJGMj8A9UErysQ5v8qZCwsr/kVdE/uKjzNcVGwEwFsz7IePsFTCUET3a0eG6tW3I
        JuZLWWCOtkaW/6xgEeis+jCq/zpwokSH/5QTXuT+EgNhBqdYo+71WOCT8KdFQum4tnjtU36DwMjiX
        jT07SCtQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGTbC-0003Vj-15; Mon, 23 Mar 2020 20:23:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-xfs@vger.kernel.org,
        Gao Xiang <gaoxiang25@huawei.com>,
        Dave Chinner <dchinner@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v10 19/25] erofs: Convert compressed files from readpages to readahead
Date:   Mon, 23 Mar 2020 13:22:53 -0700
Message-Id: <20200323202259.13363-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200323202259.13363-1-willy@infradead.org>
References: <20200323202259.13363-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in erofs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: William Kucharski <william.kucharski@oracle.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
---
 fs/erofs/zdata.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index acbfe05b1b12..be50a4d9d273 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1305,28 +1305,23 @@ static bool should_decompress_synchronously(struct erofs_sb_info *sbi,
 	return nr <= sbi->ctx.max_sync_decompress_pages;
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
+	f.headoffset = readahead_pos(rac);
 
+	while ((page = readahead_page(rac))) {
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
 		/*
 		 * A pure asynchronous readahead is indicated if
@@ -1335,11 +1330,6 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
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
@@ -1368,11 +1358,10 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 
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
2.25.1

