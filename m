Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCAE16F1DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 22:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgBYVt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 16:49:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgBYVso (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2x6mr17+IWiABUrH32RRedDjvVTqyCBcBDcULt4oGp0=; b=PZ8e3cBzBVyhOkiqBpWxfXN4l5
        xX1H3oq8gNl24M5eLkiGq7cvdo2d/+LXFFgro13sGXfH/TxL1lz+SitBPjbM5nJUIBJduLCRfuoZN
        lRSg3soAax+qgzq+tFKq2E0HwX5+ZJtvf6GARvAtg6KQo5TkEGqUNUehXdbHRXTX7r2bf5VT2g+wM
        5pRT9wV3BS+lN7qCiNtsR4XhVhj39d8PJfS6AYi99sUACj5L+7nDfMOvgg28i24COXeeWH+zc44ZZ
        HQsScXR6OxEB5TS4Qd6yNiuyPu8nhF4G5y5x+DBEtU4CfZ/gyo52apJLlS4vHweapHlWzAkyaGWbh
        yQkniXbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6i4H-0007pX-2l; Tue, 25 Feb 2020 21:48:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v8 05/25] mm: Add new readahead_control API
Date:   Tue, 25 Feb 2020 13:48:18 -0800
Message-Id: <20200225214838.30017-6-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225214838.30017-1-willy@infradead.org>
References: <20200225214838.30017-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Filesystems which implement the upcoming ->readahead method will get
their pages by calling readahead_page() or readahead_page_batch().
These functions support large pages, even though none of the filesystems
to be converted do yet.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 140 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 24894b9b90c9..232892d37071 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -638,6 +638,146 @@ static inline int add_to_page_cache(struct page *page,
 	return error;
 }
 
+/**
+ * struct readahead_control - Describes a readahead request.
+ *
+ * A readahead request is for consecutive pages.  Filesystems which
+ * implement the ->readahead method should call readahead_page() or
+ * readahead_page_batch() in a loop and attempt to start I/O against
+ * each page in the request.
+ *
+ * Most of the fields in this struct are private and should be accessed
+ * by the functions below.
+ *
+ * @file: The file, used primarily by network filesystems for authentication.
+ *	  May be NULL if invoked internally by the filesystem.
+ * @mapping: Readahead this filesystem object.
+ */
+struct readahead_control {
+	struct file *file;
+	struct address_space *mapping;
+/* private: use the readahead_* accessors instead */
+	pgoff_t _index;
+	unsigned int _nr_pages;
+	unsigned int _batch_count;
+};
+
+/**
+ * readahead_page - Get the next page to read.
+ * @rac: The current readahead request.
+ *
+ * Context: The page is locked and has an elevated refcount.  The caller
+ * should decreases the refcount once the page has been submitted for I/O
+ * and unlock the page once all I/O to that page has completed.
+ * Return: A pointer to the next page, or %NULL if we are done.
+ */
+static inline struct page *readahead_page(struct readahead_control *rac)
+{
+	struct page *page;
+
+	BUG_ON(rac->_batch_count > rac->_nr_pages);
+	rac->_nr_pages -= rac->_batch_count;
+	rac->_index += rac->_batch_count;
+
+	if (!rac->_nr_pages) {
+		rac->_batch_count = 0;
+		return NULL;
+	}
+
+	page = xa_load(&rac->mapping->i_pages, rac->_index);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	rac->_batch_count = hpage_nr_pages(page);
+
+	return page;
+}
+
+static inline unsigned int __readahead_batch(struct readahead_control *rac,
+		struct page **array, unsigned int array_sz)
+{
+	unsigned int i = 0;
+	XA_STATE(xas, &rac->mapping->i_pages, 0);
+	struct page *page;
+
+	BUG_ON(rac->_batch_count > rac->_nr_pages);
+	rac->_nr_pages -= rac->_batch_count;
+	rac->_index += rac->_batch_count;
+	rac->_batch_count = 0;
+
+	xas_set(&xas, rac->_index);
+	rcu_read_lock();
+	xas_for_each(&xas, page, rac->_index + rac->_nr_pages - 1) {
+		VM_BUG_ON_PAGE(!PageLocked(page), page);
+		VM_BUG_ON_PAGE(PageTail(page), page);
+		array[i++] = page;
+		rac->_batch_count += hpage_nr_pages(page);
+
+		/*
+		 * The page cache isn't using multi-index entries yet,
+		 * so the xas cursor needs to be manually moved to the
+		 * next index.  This can be removed once the page cache
+		 * is converted.
+		 */
+		if (PageHead(page))
+			xas_set(&xas, rac->_index + rac->_batch_count);
+
+		if (i == array_sz)
+			break;
+	}
+	rcu_read_unlock();
+
+	return i;
+}
+
+/**
+ * readahead_page_batch - Get a batch of pages to read.
+ * @rac: The current readahead request.
+ * @array: An array of pointers to struct page.
+ *
+ * Context: The pages are locked and have an elevated refcount.  The caller
+ * should decreases the refcount once the page has been submitted for I/O
+ * and unlock the page once all I/O to that page has completed.
+ * Return: The number of pages placed in the array.  0 indicates the request
+ * is complete.
+ */
+#define readahead_page_batch(rac, array)				\
+	__readahead_batch(rac, array, ARRAY_SIZE(array))
+
+/**
+ * readahead_pos - The byte offset into the file of this readahead request.
+ * @rac: The readahead request.
+ */
+static inline loff_t readahead_pos(struct readahead_control *rac)
+{
+	return (loff_t)rac->_index * PAGE_SIZE;
+}
+
+/**
+ * readahead_length - The number of bytes in this readahead request.
+ * @rac: The readahead request.
+ */
+static inline loff_t readahead_length(struct readahead_control *rac)
+{
+	return (loff_t)rac->_nr_pages * PAGE_SIZE;
+}
+
+/**
+ * readahead_index - The index of the first page in this readahead request.
+ * @rac: The readahead request.
+ */
+static inline pgoff_t readahead_index(struct readahead_control *rac)
+{
+	return rac->_index;
+}
+
+/**
+ * readahead_count - The number of pages in this readahead request.
+ * @rac: The readahead request.
+ */
+static inline unsigned int readahead_count(struct readahead_control *rac)
+{
+	return rac->_nr_pages;
+}
+
 static inline unsigned long dir_pages(struct inode *inode)
 {
 	return (unsigned long)(inode->i_size + PAGE_SIZE - 1) >>
-- 
2.25.0

