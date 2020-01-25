Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633C01492BE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387678AbgAYBgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:36:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36718 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729746AbgAYBfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rNf4spS5QJiA7zUUxqFAPWvZ/F/BZM215Bjzf21QLTw=; b=VK4QKtydrkwHDtvbzimD4MpoSB
        oNKvDQBWBmHqOnBJehp0qjFUgxuwIPVkVjlDUfuIcXB+3rAZYzuHXgsLpO6T8rizhjsOvB1L4Yv1J
        dOKnJJvnx8i/uQGkF1AHUqx1pvR4misb6LYqpvqmOOAjwwUjQcnLT1kA8uO0+JiePzO9Aex/x02VZ
        /ITvv52FWbuM9/dHbGDwWIVUiq+mBu+lLS6PlMH2B6t6HpC7vybr1RrXtZ6BO62g+0GO+mny5vrhz
        bOpTTyVWgYFR7iccCZ4Le/JlgknwJhtuh5POOMtvQCEzDF7yCb20RitgtFWf384lHOqWQN+6sw/G2
        ccAC4Qbg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006W4-Hk; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] fuse: Convert from readpages to readahead
Date:   Fri, 24 Jan 2020 17:35:52 -0800
Message-Id: <20200125013553.24899-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200125013553.24899-1-willy@infradead.org>
References: <20200125013553.24899-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in fuse.  Switching away from the
read_cache_pages() helper gets rid of an implicit call to put_page(),
so we can get rid of the get_page() call in fuse_readpages_fill().
We can also get rid of the call to fuse_wait_on_page_writeback() as
this page is newly allocated and so cannot be under writeback.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce715380143c..b6d0ed7d805b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -911,16 +911,13 @@ struct fuse_fill_data {
 	unsigned int max_pages;
 };
 
-static int fuse_readpages_fill(void *_data, struct page *page)
+static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
 {
-	struct fuse_fill_data *data = _data;
 	struct fuse_io_args *ia = data->ia;
 	struct fuse_args_pages *ap = &ia->ap;
 	struct inode *inode = data->inode;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	fuse_wait_on_page_writeback(inode, page->index);
-
 	if (ap->num_pages &&
 	    (ap->num_pages == fc->max_pages ||
 	     (ap->num_pages + 1) * PAGE_SIZE > fc->max_read ||
@@ -942,7 +939,6 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 		return -EIO;
 	}
 
-	get_page(page);
 	ap->pages[ap->num_pages] = page;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	ap->num_pages++;
@@ -950,15 +946,13 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 	return 0;
 }
 
-static int fuse_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *pages, unsigned nr_pages)
+static unsigned fuse_readahead(struct file *file, struct address_space *mapping,
+			  pgoff_t start, unsigned nr_pages)
 {
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_fill_data data;
-	int err;
 
-	err = -EIO;
 	if (is_bad_inode(inode))
 		goto out;
 
@@ -968,19 +962,24 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
 	data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
 ;
 	data.ia = fuse_io_alloc(NULL, data.max_pages);
-	err = -ENOMEM;
 	if (!data.ia)
 		goto out;
 
-	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
-	if (!err) {
-		if (data.ia->ap.num_pages)
-			fuse_send_readpages(data.ia, file);
-		else
-			fuse_io_free(data.ia);
+	while (nr_pages--) {
+		struct page *page = readahead_page(mapping, start++);
+		int err = fuse_readpages_fill(&data, page);
+
+		if (!err)
+			continue;
+		nr_pages++;
+		goto out;
 	}
+	if (data.ia->ap.num_pages)
+		fuse_send_readpages(data.ia, file);
+	else
+		fuse_io_free(data.ia);
 out:
-	return err;
+	return nr_pages;
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -3358,10 +3357,10 @@ static const struct file_operations fuse_file_operations = {
 
 static const struct address_space_operations fuse_file_aops  = {
 	.readpage	= fuse_readpage,
+	.readahead	= fuse_readahead,
 	.writepage	= fuse_writepage,
 	.writepages	= fuse_writepages,
 	.launder_page	= fuse_launder_page,
-	.readpages	= fuse_readpages,
 	.set_page_dirty	= __set_page_dirty_nobuffers,
 	.bmap		= fuse_bmap,
 	.direct_IO	= fuse_direct_IO,
-- 
2.24.1

