Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674D7290941
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410588AbgJPQFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409168AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABBC0613D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RskGYvjuNvSVFj6g0/TxhC/GfOlxapv7tRidhB1Djwg=; b=V4+vkH2k+ifMkZ6HvLI+rBY4sR
        RIbJBR+VOPDXAvSAm0L37gSH4ZER+HAiGLPEoz3Gd33bV6rFxUN1WKZuhXHxd58mHKFl2qtX18UAr
        4MA3urew1HxCakG47h9hWtoYqfdIKnj0JkTkvZbxhC6mdoT2CpMxgo+f+B3an2CeXxEuoquNkkH80
        uowLcLgSYxYE56XZOFCYGz1Y3FHSfwAFE4D3WENd2NZrrmFkVRrdnS+A0fPjCytCyHGKJhzcK1wan
        sS7T7agUK8c9L0Czs1nQv/5SrwHCvxmfGzzm7FXT3qSr+InGm0U/I/9TujD5yiqAHQriBhOklH8B9
        kEyOlUmg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDl-0004sK-Lv; Fri, 16 Oct 2020 16:04:45 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH v3 03/18] fs: Add AOP_UPDATED_PAGE return value
Date:   Fri, 16 Oct 2020 17:04:28 +0100
Message-Id: <20201016160443.18685-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow synchronous ->readpage implementations to execute more
efficiently by skipping the re-locking of the page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst |  7 ++++---
 Documentation/filesystems/vfs.rst     | 21 ++++++++++++++-------
 fs/buffer.c                           | 15 +++++++++------
 fs/cachefiles/rdwr.c                  |  8 ++++++++
 include/linux/fs.h                    |  5 +++++
 mm/filemap.c                          | 15 +++++++++++++--
 mm/page_io.c                          |  7 ++++++-
 mm/readahead.c                        |  3 ++-
 8 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 64f94a18d97e..06a7a8bf2362 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -269,7 +269,7 @@ locking rules:
 ops			PageLocked(page)	 i_rwsem
 ======================	======================== =========
 writepage:		yes, unlocks (see below)
-readpage:		yes, unlocks
+readpage:		yes, may unlock
 writepages:
 set_page_dirty		no
 readahead:		yes, unlocks
@@ -294,8 +294,9 @@ swap_deactivate:	no
 ->write_begin(), ->write_end() and ->readpage() may be called from
 the request handler (/dev/loop).
 
-->readpage() unlocks the page, either synchronously or via I/O
-completion.
+->readpage() may return AOP_UPDATED_PAGE if the page is now Uptodate
+or 0 if the page will be unlocked asynchronously by I/O completion.
+If it returns -errno, it should unlock the page.
 
 ->readahead() unlocks the pages that I/O is attempted on like ->readpage().
 
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index ca52c82e5bb5..16248c299aaa 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -643,7 +643,7 @@ set_page_dirty to write data into the address_space, and writepage and
 writepages to writeback data to storage.
 
 Adding and removing pages to/from an address_space is protected by the
-inode's i_mutex.
+inode's i_rwsem held exclusively.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
 typically remains set until writepage asks for it to be written.  This
@@ -757,12 +757,19 @@ cache in your filesystem.  The following members are defined:
 
 ``readpage``
 	called by the VM to read a page from backing store.  The page
-	will be Locked when readpage is called, and should be unlocked
-	and marked uptodate once the read completes.  If ->readpage
-	discovers that it needs to unlock the page for some reason, it
-	can do so, and then return AOP_TRUNCATED_PAGE.  In this case,
-	the page will be relocated, relocked and if that all succeeds,
-	->readpage will be called again.
+	will be Locked and !Uptodate when readpage is called.  Ideally,
+	the filesystem will bring the page Uptodate and return
+	AOP_UPDATED_PAGE.  If the filesystem encounters an error, it
+	should unlock the page and return a negative errno without marking
+	the page Uptodate.  It does not need to mark the page as Error.
+	If the filesystem returns 0, this means the page will be unlocked
+	asynchronously by I/O completion.  The VFS will wait for the
+	page to be unlocked, so there is no advantage to executing this
+	operation asynchronously.
+
+	The filesystem can also return AOP_TRUNCATED_PAGE to indicate
+	that it had to unlock the page to avoid a deadlock.  The caller
+	will re-check the page cache and call ->readpage again.
 
 ``writepages``
 	called by the VM to write out pages associated with the
diff --git a/fs/buffer.c b/fs/buffer.c
index 50bbc99e3d96..1d5337517dcd 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2856,14 +2856,17 @@ int nobh_truncate_page(struct address_space *mapping,
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!PageUptodate(page)) {
 		err = mapping->a_ops->readpage(NULL, page);
-		if (err) {
+		if (err < 0) {
 			put_page(page);
 			goto out;
-		}
-		lock_page(page);
-		if (!PageUptodate(page)) {
-			err = -EIO;
-			goto unlock;
+		} else if (err == 0) {
+			lock_page(page);
+			if (!PageUptodate(page)) {
+				err = -EIO;
+				goto unlock;
+			}
+		} else {
+			err = 0;
 		}
 		if (page_has_buffers(page))
 			goto has_buffers;
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 8bda092e60c5..cc4cc535caf5 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -122,6 +122,10 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 		ret = bmapping->a_ops->readpage(NULL, backpage);
 		if (ret < 0)
 			goto discard;
+		if (ret == AOP_UPDATED_PAGE) {
+			ret = 0;
+			goto unlock_discard;
+		}
 	}
 
 	/* but the page may have been read before the monitor was installed, so
@@ -285,6 +289,8 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 	ret = bmapping->a_ops->readpage(NULL, backpage);
 	if (ret < 0)
 		goto read_error;
+	if (ret == AOP_UPDATED_PAGE)
+		unlock_page(backpage);
 
 	/* set the monitor to transfer the data across */
 monitor_backing_page:
@@ -523,6 +529,8 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		ret = bmapping->a_ops->readpage(NULL, backpage);
 		if (ret < 0)
 			goto read_error;
+		if (ret == AOP_UPDATED_PAGE)
+			unlock_page(backpage);
 
 		/* add the netfs page to the pagecache and LRU, and set the
 		 * monitor to transfer the data across */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a08..badf80e133fd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -273,6 +273,10 @@ struct iattr {
  *  			reference, it should drop it before retrying.  Returned
  *  			by readpage().
  *
+ * @AOP_UPDATED_PAGE: The readpage method has brought the page Uptodate
+ * without releasing the page lock.  This is suitable for synchronous
+ * implementations of readpage.
+ *
  * address_space_operation functions return these large constants to indicate
  * special semantics to the caller.  These are much larger than the bytes in a
  * page to allow for functions that return the number of bytes operated on in a
@@ -282,6 +286,7 @@ struct iattr {
 enum positive_aop_returns {
 	AOP_WRITEPAGE_ACTIVATE	= 0x80000,
 	AOP_TRUNCATED_PAGE	= 0x80001,
+	AOP_UPDATED_PAGE	= 0x80002,
 };
 
 #define AOP_FLAG_CONT_EXPAND		0x0001 /* called from cont_expand */
diff --git a/mm/filemap.c b/mm/filemap.c
index 1aaea26556cc..95b68ec1f22c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2254,8 +2254,13 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 * PG_error will be set again if readpage fails.
 		 */
 		ClearPageError(page);
-		/* Start the actual read. The read will unlock the page. */
+		/* Start the actual read. The read may unlock the page. */
 		error = mapping->a_ops->readpage(filp, page);
+		if (error == AOP_UPDATED_PAGE) {
+			unlock_page(page);
+			error = 0;
+			goto page_ok;
+		}
 
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
@@ -2619,7 +2624,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	if (unlikely(!PageUptodate(page)))
 		goto page_not_uptodate;
-
+page_ok:
 	/*
 	 * We've made it this far and we had to drop our mmap_lock, now is the
 	 * time to return to the upper layer and have it re-find the vma and
@@ -2654,6 +2659,8 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	ClearPageError(page);
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	error = mapping->a_ops->readpage(file, page);
+	if (error == AOP_UPDATED_PAGE)
+		goto page_ok;
 	if (!error) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
@@ -2867,6 +2874,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 			err = filler(data, page);
 		else
 			err = mapping->a_ops->readpage(data, page);
+		if (err == AOP_UPDATED_PAGE) {
+			unlock_page(page);
+			goto out;
+		}
 
 		if (err < 0) {
 			put_page(page);
diff --git a/mm/page_io.c b/mm/page_io.c
index faf5ccb42946..f141a171d09c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -376,13 +376,18 @@ static int mapping_readpage(struct file *file, struct address_space *mapping,
 		._index = page->index,
 		._nr_pages = 1,
 	};
+	int ret;
 
 	if (!synchronous && mapping->a_ops->readahead) {
 		mapping->a_ops->readahead(&ractl);
 		return 0;
 	}
 
-	return mapping->a_ops->readpage(file, page);
+	ret = mapping->a_ops->readpage(file, page);
+	if (ret != AOP_UPDATED_PAGE)
+		return ret;
+	unlock_page(page);
+	return 0;
 }
 
 int swap_readpage(struct page *page, bool synchronous)
diff --git a/mm/readahead.c b/mm/readahead.c
index 3c9a8dd7c56c..f182fa731ab3 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -142,7 +142,8 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		rac->_nr_pages = 0;
 	} else {
 		while ((page = readahead_page(rac))) {
-			aops->readpage(rac->file, page);
+			if (aops->readpage(rac->file, page) == AOP_UPDATED_PAGE)
+				unlock_page(page);
 			put_page(page);
 		}
 	}
-- 
2.28.0

