Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A245051F150
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbiEHUfe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiEHUfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B8138
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rhLsF9oYqEliaqHvHimDRs4Dm9H91abxXU0VVTTmFQg=; b=FaLWuqKUCs2FX6zmhUgoTbSm0C
        EXOdQ7kwizagZMvIDU3oxvtk81rCEERyACqDgGA4EjXgpsybg6qfYm03p63rfu8IT3898Vw8tHIc/
        jW0Ec04iIIxYUBT91dQ138IwJTPWSfCV4XySHa8GsiN9qFG5OeXwe1e5d1+5YrsxfJ/UVcyGkRslN
        j3iSiD31aHcHPVubXUtzZCBW8U1O09VYLKQtbpSaJeRsYIDy2V2DNDFwEtBNhoAM/yvkO1lYzoIUk
        5L1kyg1gA40gHA6Ak+TjI6JsavsOx4on2NgHaO+V17balUCLHvb9MEaa9XK8WxvkKi+hanN3Z9v5N
        jBHFFvGA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ2-002nmy-O3; Sun, 08 May 2022 20:31:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/37] fs: Introduce aops->read_folio
Date:   Sun,  8 May 2022 21:30:55 +0100
Message-Id: <20220508203131.667959-2-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220508203131.667959-1-willy@infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203131.667959-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change all the callers of ->readpage to call ->read_folio in preference,
if it exists.  This is a transitional duplication, and will be removed
by the end of the series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/file.c         |  2 +-
 fs/buffer.c             |  5 ++++-
 fs/ceph/addr.c          |  2 +-
 include/linux/fs.h      |  1 +
 kernel/events/uprobes.c |  6 ++++--
 mm/filemap.c            |  9 +++++++--
 mm/readahead.c          | 14 +++++++++-----
 mm/swapfile.c           |  2 +-
 8 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 380054c94e4b..59510d7b1c65 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2401,7 +2401,7 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = filp->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->readpage && !mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
 	file_accessed(filp);
diff --git a/fs/buffer.c b/fs/buffer.c
index 9737e0dbe3ec..225d03cd622d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2824,7 +2824,10 @@ int nobh_truncate_page(struct address_space *mapping,
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!folio_test_uptodate(folio)) {
-		err = mapping->a_ops->readpage(NULL, &folio->page);
+		if (mapping->a_ops->read_folio)
+			err = mapping->a_ops->read_folio(NULL, folio);
+		else
+			err = mapping->a_ops->readpage(NULL, &folio->page);
 		if (err) {
 			folio_put(folio);
 			goto out;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index e65541a51b68..42bba2b5d98b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1772,7 +1772,7 @@ int ceph_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->readpage && !mapping->a_ops->read_folio)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &ceph_vmops;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2be852661a29..5ad942183a2c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -336,6 +336,7 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
+	int (*read_folio)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6418083901d4..a340b1043efa 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -790,7 +790,7 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	 * and in page-cache. If ->readpage == NULL it must be shmem_mapping(),
 	 * see uprobe_register().
 	 */
-	if (mapping->a_ops->readpage)
+	if (mapping->ops->read_folio || mapping->a_ops->readpage)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
 	else
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
@@ -1143,7 +1143,9 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		return -EINVAL;
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
-	if (!inode->i_mapping->a_ops->readpage && !shmem_mapping(inode->i_mapping))
+	if (!inode->i_mapping->a_ops->read_folio &&
+	    !inode->i_mapping->a_ops->readpage &&
+	    !shmem_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
diff --git a/mm/filemap.c b/mm/filemap.c
index c15cfc28f9ce..96e3d7ffd98e 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2419,7 +2419,10 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 	 */
 	folio_clear_error(folio);
 	/* Start the actual read. The read will unlock the page. */
-	error = mapping->a_ops->readpage(file, &folio->page);
+	if (mapping->a_ops->read_folio)
+		error = mapping->a_ops->read_folio(file, folio);
+	else
+		error = mapping->a_ops->readpage(file, &folio->page);
 	if (error)
 		return error;
 
@@ -3447,7 +3450,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->read_folio && !mapping->a_ops->readpage)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &generic_file_vm_ops;
@@ -3505,6 +3508,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 filler:
 		if (filler)
 			err = filler(data, &folio->page);
+		else if (mapping->a_ops->read_folio)
+			err = mapping->a_ops->read_folio(data, folio);
 		else
 			err = mapping->a_ops->readpage(data, &folio->page);
 
diff --git a/mm/readahead.c b/mm/readahead.c
index 60a28af25c4e..76024c20a5a5 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -15,7 +15,7 @@
  * explicitly requested by the application.  Readahead only ever
  * attempts to read folios that are not yet in the page cache.  If a
  * folio is present but not up-to-date, readahead will not try to read
- * it. In that case a simple ->readpage() will be requested.
+ * it. In that case a simple ->read_folio() will be requested.
  *
  * Readahead is triggered when an application read request (whether a
  * system call or a page fault) finds that the requested folio is not in
@@ -78,7 +78,7 @@
  * address space operation, for which mpage_readahead() is a canonical
  * implementation.  ->readahead() should normally initiate reads on all
  * folios, but may fail to read any or all folios without causing an I/O
- * error.  The page cache reading code will issue a ->readpage() request
+ * error.  The page cache reading code will issue a ->read_folio() request
  * for any folio which ->readahead() did not read, and only an error
  * from this will be final.
  *
@@ -110,7 +110,7 @@
  * were not fetched with readahead_folio().  This will allow a
  * subsequent synchronous readahead request to try them again.  If they
  * are left in the page cache, then they will be read individually using
- * ->readpage() which may be less efficient.
+ * ->read_folio() which may be less efficient.
  */
 
 #include <linux/kernel.h>
@@ -170,8 +170,11 @@ static void read_pages(struct readahead_control *rac)
 			}
 			folio_unlock(folio);
 		}
+	} else if (aops->read_folio) {
+		while ((folio = readahead_folio(rac)) != NULL)
+			aops->read_folio(rac->file, folio);
 	} else {
-		while ((folio = readahead_folio(rac)))
+		while ((folio = readahead_folio(rac)) != NULL)
 			aops->readpage(rac->file, &folio->page);
 	}
 
@@ -302,7 +305,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
-	if (unlikely(!mapping->a_ops->readpage && !mapping->a_ops->readahead))
+	if (unlikely(!mapping->a_ops->read_folio &&
+		     !mapping->a_ops->readpage && !mapping->a_ops->readahead))
 		return;
 
 	/*
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 63c61f8b2611..7c19098b8b45 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3041,7 +3041,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/*
 	 * Read the swap header.
 	 */
-	if (!mapping->a_ops->readpage) {
+	if (!mapping->a_ops->read_folio && !mapping->a_ops->readpage) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
 	}
-- 
2.34.1

