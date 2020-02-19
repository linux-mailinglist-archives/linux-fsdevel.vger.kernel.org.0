Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49C29165132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgBSVDF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:03:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbgBSVBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iTnbXsBsCMnw4G4jluaHETVOvwrUuF/JrDXgH8InvQQ=; b=QLnU+TnAJtozxCTAnM0JMY10lU
        w3DlJ8PJJvrtNPKkg1MB4FIHQxWaOQ1rCvRK3gJlozkHzwXoazIS853rTTg+1a0+pPXkpHdu0yXZf
        wVEjPoEzPlmmjZCt35G+9oNcuHpEYjLtn8GVFmIoaCNyVZtyr2tdqK7haVvST/yiicCVIDToR0rci
        i0TJyk17Fxo0WC05Hy3lSEZzNQZmfIkiEAbu+33d3aKLL8Ynm9PKL+mMXBP5A9a5DHv+hDqjdheXz
        6UGg4+LNawxKGz8F/fgvXUhlDwwP7hGqdw9PPbCZorXwRQUTscIhWfAxW54dNI8MD4iA7CjSkbyNn
        Fu9CyCZw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008VB-FV; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v7 20/24] fuse: Convert from readpages to readahead
Date:   Wed, 19 Feb 2020 13:00:59 -0800
Message-Id: <20200219210103.32400-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200219210103.32400-1-willy@infradead.org>
References: <20200219210103.32400-1-willy@infradead.org>
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
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/fuse/file.c | 46 +++++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9d67b830fb7a..5749505bcff6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -923,9 +923,8 @@ struct fuse_fill_data {
 	unsigned int max_pages;
 };
 
-static int fuse_readpages_fill(void *_data, struct page *page)
+static int fuse_readpages_fill(struct fuse_fill_data *data, struct page *page)
 {
-	struct fuse_fill_data *data = _data;
 	struct fuse_io_args *ia = data->ia;
 	struct fuse_args_pages *ap = &ia->ap;
 	struct inode *inode = data->inode;
@@ -941,10 +940,8 @@ static int fuse_readpages_fill(void *_data, struct page *page)
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
 
@@ -954,7 +951,6 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 		return -EIO;
 	}
 
-	get_page(page);
 	ap->pages[ap->num_pages] = page;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	ap->num_pages++;
@@ -962,37 +958,33 @@ static int fuse_readpages_fill(void *_data, struct page *page)
 	return 0;
 }
 
-static int fuse_readpages(struct file *file, struct address_space *mapping,
-			  struct list_head *pages, unsigned nr_pages)
+static void fuse_readahead(struct readahead_control *rac)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_fill_data data;
-	int err;
+	struct page *page;
 
-	err = -EIO;
 	if (is_bad_inode(inode))
-		goto out;
+		return;
 
-	data.file = file;
+	data.file = rac->file;
 	data.inode = inode;
-	data.nr_pages = nr_pages;
-	data.max_pages = min_t(unsigned int, nr_pages, fc->max_pages);
-;
+	data.nr_pages = readahead_count(rac);
+	data.max_pages = min_t(unsigned int, data.nr_pages, fc->max_pages);
 	data.ia = fuse_io_alloc(NULL, data.max_pages);
-	err = -ENOMEM;
 	if (!data.ia)
-		goto out;
+		return;
 
-	err = read_cache_pages(mapping, pages, fuse_readpages_fill, &data);
-	if (!err) {
-		if (data.ia->ap.num_pages)
-			fuse_send_readpages(data.ia, file);
-		else
-			fuse_io_free(data.ia);
+	while ((page = readahead_page(rac))) {
+		if (fuse_readpages_fill(&data, page) != 0)
+			return;
 	}
-out:
-	return err;
+
+	if (data.ia->ap.num_pages)
+		fuse_send_readpages(data.ia, rac->file);
+	else
+		fuse_io_free(data.ia);
 }
 
 static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
@@ -3373,10 +3365,10 @@ static const struct file_operations fuse_file_operations = {
 
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
2.25.0

