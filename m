Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBFA1394FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAMPhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:37:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57858 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SXAvnYjcl6qequNwK8pgR/rQT6gLXY9+s/CAcN+XqLc=; b=n14KrJrFKqwJGKJyWhG5HgE/nm
        Np64Aehxm7IYOTM+02fPOAQ23CiYbX1GuQojaxO0PNE2Q939pySyF5PzKQa96oJuO5rcOBz9mPcSz
        4eZ927zi+xeCjUN26AStyqAYnB1hsoxuhaDQzDb6A2D5BXsg7ZeXBtZ10EnIR1Num8EGLq/l67Okm
        6mOzRPBzy9EYFHt0m3wfmuq0Myag0sknVP0wXdu/UAtLweNBi/VAA564YZ+7zcpKcuxWjD3nNTE+4
        OzcsSNfHmwGLLLaQ7x84znlybgQy9zySk8UN2oLSPoaWQj0pzkC3qIUt6jHVucwRZtO0AZIFbD7uj
        k/K8FPWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00076I-6S; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [PATCH 4/8] mm/fs: Add a_ops->readahead
Date:   Mon, 13 Jan 2020 07:37:42 -0800
Message-Id: <20200113153746.26654-5-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This will replace ->readpages with a saner interface:
 - No return type (errors are ignored for read ahead anyway)
 - Pages are already in the page cache when ->readpages is called
 - Pages are passed in a pagevec instead of a linked list

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  8 +++++-
 Documentation/filesystems/vfs.rst     |  9 ++++++
 include/linux/fs.h                    |  3 ++
 mm/readahead.c                        | 40 ++++++++++++++++++++++++++-
 4 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 5057e4d9dcd1..1e2f1186fd1a 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -239,6 +239,8 @@ prototypes::
 	int (*readpage)(struct file *, struct page *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	int (*set_page_dirty)(struct page *page);
+	int (*readahead)(struct file *, struct address_space *,
+			struct pagevec *, pgoff_t index);
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 	int (*write_begin)(struct file *, struct address_space *mapping,
@@ -271,7 +273,8 @@ writepage:		yes, unlocks (see below)
 readpage:		yes, unlocks
 writepages:
 set_page_dirty		no
-readpages:
+readpages:              no
+readahead:              yes, unlocks
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
@@ -298,6 +301,9 @@ completion.
 ->readpages() populates the pagecache with the passed pages and starts
 I/O against them.  They come unlocked upon I/O completion.
 
+->readahead() starts I/O against the pages.  They come unlocked upon
+I/O completion.
+
 ->writepage() is used for two purposes: for "memory cleansing" and for
 "sync".  These are quite different operations and the behaviour may differ
 depending upon the mode.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..63d0f0dbbf9c 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -706,6 +706,8 @@ cache in your filesystem.  The following members are defined:
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		int (*set_page_dirty)(struct page *page);
+		int (*readahead)(struct file *, struct address_space *,
+				 struct pagevec *, pgoff_t index);
 		int (*readpages)(struct file *filp, struct address_space *mapping,
 				 struct list_head *pages, unsigned nr_pages);
 		int (*write_begin)(struct file *, struct address_space *mapping,
@@ -781,6 +783,13 @@ cache in your filesystem.  The following members are defined:
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
+``readahead``
+	called by the VM to read pages associated with the address_space
+	object.  This is essentially a vector version of readpage.
+	Instead of just one page, several pages are requested.
+	Since this is readahead, attempt to start I/O on each page and
+        let the I/O completion path set errors on the page.
+
 ``readpages``
 	called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of readpage.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..2769f89666fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -52,6 +52,7 @@ struct hd_geometry;
 struct iovec;
 struct kiocb;
 struct kobject;
+struct pagevec;
 struct pipe_inode_info;
 struct poll_table_struct;
 struct kstatfs;
@@ -375,6 +376,8 @@ struct address_space_operations {
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
+	void (*readahead)(struct file *, struct address_space *,
+			struct pagevec *, pgoff_t offset);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
diff --git a/mm/readahead.c b/mm/readahead.c
index 76a70a4406b5..2fe0974173ea 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -123,7 +123,45 @@ static unsigned read_pages(struct address_space *mapping, struct file *filp,
 	struct page *page;
 	unsigned int nr_pages = pagevec_count(pvec);
 
-	if (mapping->a_ops->readpages) {
+	if (mapping->a_ops->readahead) {
+		/*
+		 * When we remove support for ->readpages, we'll call
+		 * add_to_page_cache_lru() in the parent and all this
+		 * grot goes away.
+		 */
+		unsigned char first = pvec->first;
+		unsigned char saved_nr = pvec->nr;
+		pgoff_t base = offset;
+		pagevec_for_each(pvec, page) {
+			if (!add_to_page_cache_lru(page, mapping, offset++,
+						gfp)) {
+				unsigned char saved_first = pvec->first;
+
+				pvec->nr = pvec->first - 1;
+				pvec->first = first;
+				mapping->a_ops->readahead(filp, mapping, pvec,
+						base + first);
+				first = pvec->nr + 1;
+				pvec->nr = saved_nr;
+				pvec->first = saved_first;
+
+				put_page(page);
+			}
+		}
+		pvec->first = first;
+		offset = base + first;
+		mapping->a_ops->readahead(filp, mapping, pvec, offset);
+		/*
+		 * Ideally the implementation would at least attempt to
+		 * start I/O against all the pages, but there are times
+		 * when it makes more sense to just give up.  Take care
+		 * of any un-attempted pages here.
+		 */
+		pagevec_for_each(pvec, page) {
+			unlock_page(page);
+			put_page(page);
+		}
+	} else if (mapping->a_ops->readpages) {
 		LIST_HEAD(pages);
 
 		pagevec_for_each(pvec, page) {
-- 
2.24.1

