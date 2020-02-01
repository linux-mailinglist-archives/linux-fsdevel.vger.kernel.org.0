Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70B14F84E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgBAPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBAPMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KDUOzl0MVOTcqaG0+tJFJVgrha2fmSoI/N94AdkJq5c=; b=U/60ZvEXY+pLVht5o2+SfdHqov
        4paaOeykETdvtFfhbUtphGL37w3zZ2zybA8uAZnCJRKuo4HkDGZt/7CFUVbBp8uXHRP9HuWOKXz6I
        SfWuNMo31G1PyVvL3u7myJxpeuCklzZSYLlBXEtOnC1irHK+VgGZtsp2Enkf12+mpTi8X5qwD0Osn
        VEEpzQL57iBtmRTkCuMHFQYRrJLP0i6eTGjtM+8KawYfAKYFGf2J+p8ZWaVNE1yNmJq0xP944EzNC
        RZtyOJdk4edDTid0C8yvvJkywiCv98bJLwuUS8D881F9gQfRuA+qRbs4eIwTodWapOR8Elds15tld
        qG/KqF7w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006I3-Dv; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] fuse: Convert from readpages to readahead
Date:   Sat,  1 Feb 2020 07:12:39 -0800
Message-Id: <20200201151240.24082-12-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201151240.24082-1-willy@infradead.org>
References: <20200201151240.24082-1-willy@infradead.org>
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ce715380143c..5460ff1bf155 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -911,9 +911,8 @@ struct fuse_fill_data {
 	unsigned int max_pages;
 };
 
-static int fuse_readpages_fill(void *_data, struct page *page)
+static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
 {
-	struct fuse_fill_data *data = _data;
 	struct fuse_io_args *ia = data->ia;
 	struct fuse_args_pages *ap = &ia->ap;
 	struct inode *inode = data->inode;
@@ -929,10 +928,8 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 					fc->max_pages);
 		fuse_send_readpages(ia, data->file);
 		data->ia = ia = fuse_io_alloc(NULL, data->max_pages);
-		if (!ia) {
-			unlock_page(page);
+		if (!ia)
 			return -ENOMEM;
-		}
 		ap = &ia->ap;
 	}
 
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
 
@@ -966,21 +960,24 @@ static int fuse_readpages(struct file *file, struct address_space *mapping,
 	data.inode = inode;
 	data.nr_pages = nr_pages;
 	data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
-;
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
+	while (nr_pages) {
+		struct page *page = readahead_page(mapping, start++);
+
+		if (fuse_readpages_fill(&data, page) != 0)
+			goto out;
+		nr_pages--;
 	}
+
+	if (data.ia->ap.num_pages)
+		fuse_send_readpages(data.ia, file);
+	else
+		fuse_io_free(data.ia);
 out:
-	return err;
+	return nr_pages;
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -3358,10 +3355,10 @@ static const struct file_operations fuse_file_operations = {
 
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

