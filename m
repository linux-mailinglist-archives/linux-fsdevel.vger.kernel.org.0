Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0516510A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgBSVBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:01:07 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbgBSVBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Vi9zRPzZG0WAGJnjLPY0Z7JD7evHL99FPGROsolVlqA=; b=gz+VLPn63u9exWSVjS/Fwdfh6a
        3VyIkB3ZEkV24M8qzt6ByllMr0D7lrA3dZggQF5d8QQkcY7ipnDSzTAckLI7esmSEWY+IrBmYC2A/
        bf6MiIqzGO6lEnt3toY4r0HQsfpkMAwh6QXflhaktbNiKPFQ8X7LGSwnxZHJ6rFIPCdIj1tzWXlhG
        T+Zmkx1DnCzIK/1+nKXM/6CeiFY7xrD7bvELS/z+pv3v1S48Ad68oLEm+0f95v9pyIAEIW3hK2UQV
        8IiHRoThuvpc2qbUqjYYPAo359pmAloQGOvkCnd8icesJ5/Wp01JXz0hQ0AUrnK/uMBfUB5sOh8Ex
        KW5ZmNcA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4WSv-0008Tq-2n; Wed, 19 Feb 2020 21:01:05 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v7 10/24] mm: Add readahead address space operation
Date:   Wed, 19 Feb 2020 13:00:49 -0800
Message-Id: <20200219210103.32400-11-willy@infradead.org>
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

This replaces ->readpages with a saner interface:
 - Return void instead of an ignored error code.
 - Page cache is already populated with locked pages when ->readahead
   is called.
 - New arguments can be passed to the implementation without changing
   all the filesystems that use a common helper function like
   mpage_readahead().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  6 +++++-
 Documentation/filesystems/vfs.rst     | 15 +++++++++++++++
 include/linux/fs.h                    |  2 ++
 include/linux/pagemap.h               | 18 ++++++++++++++++++
 mm/readahead.c                        | 12 ++++++++++--
 5 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 5057e4d9dcd1..0af2e0e11461 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -239,6 +239,7 @@ prototypes::
 	int (*readpage)(struct file *, struct page *);
 	int (*writepages)(struct address_space *, struct writeback_control *);
 	int (*set_page_dirty)(struct page *page);
+	void (*readahead)(struct readahead_control *);
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
 	int (*write_begin)(struct file *, struct address_space *mapping,
@@ -271,7 +272,8 @@ writepage:		yes, unlocks (see below)
 readpage:		yes, unlocks
 writepages:
 set_page_dirty		no
-readpages:
+readahead:		yes, unlocks
+readpages:		no
 write_begin:		locks the page		 exclusive
 write_end:		yes, unlocks		 exclusive
 bmap:
@@ -295,6 +297,8 @@ the request handler (/dev/loop).
 ->readpage() unlocks the page, either synchronously or via I/O
 completion.
 
+->readahead() unlocks the pages that I/O is attempted on like ->readpage().
+
 ->readpages() populates the pagecache with the passed pages and starts
 I/O against them.  They come unlocked upon I/O completion.
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 7d4d09dd5e6d..ed17771c212b 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -706,6 +706,7 @@ cache in your filesystem.  The following members are defined:
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
 		int (*set_page_dirty)(struct page *page);
+		void (*readahead)(struct readahead_control *);
 		int (*readpages)(struct file *filp, struct address_space *mapping,
 				 struct list_head *pages, unsigned nr_pages);
 		int (*write_begin)(struct file *, struct address_space *mapping,
@@ -781,12 +782,26 @@ cache in your filesystem.  The following members are defined:
 	If defined, it should set the PageDirty flag, and the
 	PAGECACHE_TAG_DIRTY tag in the radix tree.
 
+``readahead``
+	Called by the VM to read pages associated with the address_space
+	object.  The pages are consecutive in the page cache and are
+	locked.  The implementation should decrement the page refcount
+	after starting I/O on each page.  Usually the page will be
+	unlocked by the I/O completion handler.  If the filesystem decides
+	to stop attempting I/O before reaching the end of the readahead
+	window, it can simply return.  The caller will decrement the page
+	refcount and unlock the remaining pages for you.  Set PageUptodate
+	if the I/O completes successfully.  Setting PageError on any page
+	will be ignored; simply unlock the page if an I/O error occurs.
+
 ``readpages``
 	called by the VM to read pages associated with the address_space
 	object.  This is essentially just a vector version of readpage.
 	Instead of just one page, several pages are requested.
 	readpages is only used for read-ahead, so read errors are
 	ignored.  If anything goes wrong, feel free to give up.
+	This interface is deprecated and will be removed by the end of
+	2020; implement readahead instead.
 
 ``write_begin``
 	Called by the generic buffered write code to ask the filesystem
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..d4e2d2964346 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -292,6 +292,7 @@ enum positive_aop_returns {
 struct page;
 struct address_space;
 struct writeback_control;
+struct readahead_control;
 
 /*
  * Write life time hint values.
@@ -375,6 +376,7 @@ struct address_space_operations {
 	 */
 	int (*readpages)(struct file *filp, struct address_space *mapping,
 			struct list_head *pages, unsigned nr_pages);
+	void (*readahead)(struct readahead_control *);
 
 	int (*write_begin)(struct file *, struct address_space *mapping,
 				loff_t pos, unsigned len, unsigned flags,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 4989d330fada..b3008605fd1b 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -669,6 +669,24 @@ static inline struct page *readahead_page(struct readahead_control *rac)
 	return page;
 }
 
+/* The byte offset into the file of this readahead block */
+static inline loff_t readahead_pos(struct readahead_control *rac)
+{
+	return (loff_t)rac->_index * PAGE_SIZE;
+}
+
+/* The number of bytes in this readahead block */
+static inline loff_t readahead_length(struct readahead_control *rac)
+{
+	return (loff_t)rac->_nr_pages * PAGE_SIZE;
+}
+
+/* The index of the first page in this readahead block */
+static inline unsigned int readahead_index(struct readahead_control *rac)
+{
+	return rac->_index;
+}
+
 /* The number of pages in this readahead block */
 static inline unsigned int readahead_count(struct readahead_control *rac)
 {
diff --git a/mm/readahead.c b/mm/readahead.c
index aaa209559ba2..07cdfbf00f4b 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -124,7 +124,14 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages)
 
 	blk_start_plug(&plug);
 
-	if (aops->readpages) {
+	if (aops->readahead) {
+		aops->readahead(rac);
+		/* Clean up the remaining pages */
+		while ((page = readahead_page(rac))) {
+			unlock_page(page);
+			put_page(page);
+		}
+	} else if (aops->readpages) {
 		aops->readpages(rac->file, rac->mapping, pages,
 				readahead_count(rac));
 		/* Clean up the remaining pages */
@@ -234,7 +241,8 @@ void force_page_cache_readahead(struct address_space *mapping,
 	struct file_ra_state *ra = &filp->f_ra;
 	unsigned long max_pages;
 
-	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages))
+	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readpages &&
+			!mapping->a_ops->readahead))
 		return;
 
 	/*
-- 
2.25.0

