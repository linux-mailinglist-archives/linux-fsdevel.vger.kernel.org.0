Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E819813B7CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 03:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgAOCiv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 21:38:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgAOCit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:38:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FokUiDNkX0vDvA4I4b4gMyDmQibGXxBuPyNO9gCWLN8=; b=RONClEle8E7N2zN2xq6MEvYS0T
        wXbGCKaTkkPf51j+fFgQrTjfeiXIRxjB2yjBEXDzoJQjT+2fPcCKmFpWlzyWIgSkhu5Mx7AJf/myR
        HP/9XjA8202ce7W/u13TMqFnTXlj7IAkrVFNHhG8SBa573CjQmmSB/6xoFzRTsCOzdOgKcyFuRgWH
        ex9QL+SqUoFdz3S2/mP5JutIJRVT7qfWt3UAcTX+MnUGLYbtvwYp8oDfQeeW+xHuZEFzf+/DoHg6A
        u6IibUwKMG4/2kMJEtC55R8C/t33hqLijzYpde7W9yayBlEzhm1AwC7IMRkE89nVvGU1PAhtxwKHn
        AG++ELHg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irYZy-0008Aq-4y; Wed, 15 Jan 2020 02:38:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Chris Mason <clm@fb.com>
Subject: [PATCH v2 5/9] mm: Add readahead address space operation
Date:   Tue, 14 Jan 2020 18:38:39 -0800
Message-Id: <20200115023843.31325-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200115023843.31325-1-willy@infradead.org>
References: <20200115023843.31325-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This replaces ->readpages with a saner interface:
 - Return the number of pages not read instead of an ignored error code.
 - Pages are already in the page cache when ->readahead is called.
 - Implementation looks up the pages in the page cache instead of
   having them passed in a linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  7 ++++++-
 Documentation/filesystems/vfs.rst     | 11 +++++++++++
 include/linux/fs.h                    |  2 ++
 include/linux/pagemap.h               | 12 ++++++++++++
 mm/readahead.c                        | 13 ++++++++++++-
 5 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 5057e4d9dcd1..d8a5dde914b5 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -239,6 +239,8 @@ prototypes::
 	int (*readpage)(struct file *, struct page *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	int (*set_page_dirty)(struct page *page);
+	unsigned (*readahead)(struct file *, struct address_space *,
+				 pgoff_t start, unsigned nr_pages);
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 	int (*write_begin)(struct file *, struct address_space *mapping,
@@ -271,7 +273,8 @@ writepage:		yes, unlocks (see below)
 readpage:		yes, unlocks
 writepages:
 set_page_dirty		no
-readpages:
+readahead:              yes, unlocks
+readpages:              no
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
@@ -295,6 +298,8 @@ the request handler (/dev/loop).
 ->readpage() unlocks the page, either synchronously or via I/O
 completion.
 
+->readahead() unlocks the page like ->readpage().
+
 ->readpages() populates the pagecache with the passed pages and starts
 I/O against them.  They come unlocked upon I/O completion.
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..bb06fb7b120b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -706,6 +706,8 @@ cache in your filesystem.  The following members are defined:
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		int (*set_page_dirty)(struct page *page);
+		unsigned (*readahead)(struct file *filp, struct address_space *mapping,
+				 pgoff_t start, unsigned nr_pages);
 		int (*readpages)(struct file *filp, struct address_space *mapping,
 				 struct list_head *pages, unsigned nr_pages);
 		int (*write_begin)(struct file *, struct address_space *mapping,
@@ -781,6 +783,15 @@ cache in your filesystem.  The following members are defined:
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
+``readahead``
+	called by the VM to read pages associated with the address_space
+	object.  The pages are consecutive in the page cache and are
+        locked.  The implementation should decrement the page refcount after
+        attempting I/O on each page.  Usually the page will be unlocked by
+        the I/O completion handler.  If the function does not attempt I/O on
+        some pages, return the number of pages which were not read so the
+        common code can unlock the pages for you.
+
 ``readpages``
 	called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of readpage.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98e0349adb52..a10f3a72e5ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -375,6 +375,8 @@ struct address_space_operations {
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
+	unsigned (*readahead)(struct file *, struct address_space *,
+			pgoff_t start, unsigned nr_pages);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 37a4d9e32cd3..0821f584c43c 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -630,6 +630,18 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+/*
+ * Only call this from a ->readahead implementation.
+ */
+static inline
+struct page *readahead_page(struct address_space *mapping, loff_t pos)
+{
+	struct page *page = xa_load(&mapping->i_pages, pos / PAGE_SIZE);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+
+	return page;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
diff --git a/mm/readahead.c b/mm/readahead.c
index 5a6676640f20..6d65dae6dad0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -121,7 +121,18 @@ static void read_pages(struct address_space *mapping, struct file *filp,
 
 	blk_start_plug(&plug);
 
-	if (mapping->a_ops->readpages) {
+	if (mapping->a_ops->readahead) {
+		unsigned left = mapping->a_ops->readahead(filp, mapping,
+				start, nr_pages);
+
+		while (left) {
+			struct page *page = readahead_page(mapping,
+					start + nr_pages - left - 1);
+			unlock_page(page);
+			put_page(page);
+			left--;
+		}
+	} else if (mapping->a_ops->readpages) {
 		mapping->a_ops->readpages(filp, mapping, pages, nr_pages);
 		/* Clean up the remaining pages */
 		put_pages_list(pages);
-- 
2.24.1

