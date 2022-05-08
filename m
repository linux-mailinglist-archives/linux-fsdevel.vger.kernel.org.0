Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7D751F170
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiEHUgZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiEHUfi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DF132
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=inEmJHGev4aO35LgR59fjLr0G4onxFYh1TE4wGTZTLc=; b=S1ar/AWcpwXeOCfR/KyZ3uIcHG
        pxmLZV0wN31RMrqPS0IyUuUgqXzkIvnt1xFieYrD+yQ678TaaYX1P8Bftb57f917KE7QVnX2fY2rG
        KxOVKQBgGCt/GmY5uSzEr7WgRp1AdxGuuoCQDMxqirP+pvomGP4nvz/kpLSxgL7SNf2EYZIyMlEHc
        C1emL+7MqGe0Awwrn7YqJCHcZbVXZq9+M7yOiMlz9KMccE19vmPSyzZlhP15E4iQD9APtXCZVY8/q
        Tgo9BxRWK7p54mvMnmuJWAP6KGF5jA/Ev+mKhouiroecfuOoJSgLJUVvBQ8wEcznYsP54Tmt+kI4k
        WSTtsz5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ7-002nqQ-OU; Sun, 08 May 2022 20:31:41 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 37/37] mm,fs: Remove aops->readpage
Date:   Sun,  8 May 2022 21:31:31 +0100
Message-Id: <20220508203131.667959-38-willy@infradead.org>
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

With all implementations of aops->readpage converted to aops->read_folio,
we can stop checking whether it's set and remove the member from aops.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/btrfs/file.c         |  2 +-
 fs/buffer.c             |  5 +----
 fs/ceph/addr.c          |  2 +-
 include/linux/fs.h      |  3 +--
 kernel/events/uprobes.c |  5 ++---
 mm/filemap.c            | 11 ++++-------
 mm/memory.c             |  4 ++--
 mm/readahead.c          | 12 ++++--------
 mm/shmem.c              |  2 +-
 mm/swapfile.c           |  2 +-
 10 files changed, 18 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 373df5ebaf8d..57fba5abb059 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2402,7 +2402,7 @@ static int btrfs_file_mmap(struct file	*filp, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = filp->f_mapping;
 
-	if (!mapping->a_ops->readpage && !mapping->a_ops->read_folio)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 
 	file_accessed(filp);
diff --git a/fs/buffer.c b/fs/buffer.c
index ec0c52c8848e..786ef5b98c80 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2827,10 +2827,7 @@ int nobh_truncate_page(struct address_space *mapping,
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!folio_test_uptodate(folio)) {
-		if (mapping->a_ops->read_folio)
-			err = mapping->a_ops->read_folio(NULL, folio);
-		else
-			err = mapping->a_ops->readpage(NULL, &folio->page);
+		err = mapping->a_ops->read_folio(NULL, folio);
 		if (err) {
 			folio_put(folio);
 			goto out;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index be3e47784f08..e040b92bb17c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1772,7 +1772,7 @@ int ceph_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->readpage && !mapping->a_ops->read_folio)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &ceph_vmops;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ad942183a2c..f812f5aa07dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -262,7 +262,7 @@ struct iattr {
  *  			trying again.  The aop will be taking reasonable
  *  			precautions not to livelock.  If the caller held a page
  *  			reference, it should drop it before retrying.  Returned
- *  			by readpage().
+ *  			by read_folio().
  *
  * address_space_operation functions return these large constants to indicate
  * special semantics to the caller.  These are much larger than the bytes in a
@@ -335,7 +335,6 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
 	int (*read_folio)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index a340b1043efa..a9bc3c98f76a 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -787,10 +787,10 @@ static int __copy_insn(struct address_space *mapping, struct file *filp,
 	struct page *page;
 	/*
 	 * Ensure that the page that has the original instruction is populated
-	 * and in page-cache. If ->readpage == NULL it must be shmem_mapping(),
+	 * and in page-cache. If ->read_folio == NULL it must be shmem_mapping(),
 	 * see uprobe_register().
 	 */
-	if (mapping->ops->read_folio || mapping->a_ops->readpage)
+	if (mapping->a_ops->read_folio)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
 	else
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
@@ -1144,7 +1144,6 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
 	if (!inode->i_mapping->a_ops->read_folio &&
-	    !inode->i_mapping->a_ops->readpage &&
 	    !shmem_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
diff --git a/mm/filemap.c b/mm/filemap.c
index 96e3d7ffd98e..6ede3ab76a5a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2414,15 +2414,12 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 
 	/*
 	 * A previous I/O error may have been due to temporary failures,
-	 * eg. multipath errors.  PG_error will be set again if readpage
+	 * eg. multipath errors.  PG_error will be set again if read_folio
 	 * fails.
 	 */
 	folio_clear_error(folio);
 	/* Start the actual read. The read will unlock the page. */
-	if (mapping->a_ops->read_folio)
-		error = mapping->a_ops->read_folio(file, folio);
-	else
-		error = mapping->a_ops->readpage(file, &folio->page);
+	error = mapping->a_ops->read_folio(file, folio);
 	if (error)
 		return error;
 
@@ -2639,7 +2636,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
  * @already_read: Number of bytes already read by the caller.
  *
  * Copies data from the page cache.  If the data is not currently present,
- * uses the readahead and readpage address_space operations to fetch it.
+ * uses the readahead and read_folio address_space operations to fetch it.
  *
  * Return: Total number of bytes copied, including those already read by
  * the caller.  If an error happens before any bytes are copied, returns
@@ -3450,7 +3447,7 @@ int generic_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->read_folio && !mapping->a_ops->readpage)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &generic_file_vm_ops;
diff --git a/mm/memory.c b/mm/memory.c
index 76e3af9639d9..2a12028a3749 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -555,11 +555,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps readpage:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
-		 mapping ? mapping->a_ops->readpage : NULL);
+		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
 }
diff --git a/mm/readahead.c b/mm/readahead.c
index 76024c20a5a5..39983a3a93f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -170,12 +170,9 @@ static void read_pages(struct readahead_control *rac)
 			}
 			folio_unlock(folio);
 		}
-	} else if (aops->read_folio) {
-		while ((folio = readahead_folio(rac)) != NULL)
-			aops->read_folio(rac->file, folio);
 	} else {
 		while ((folio = readahead_folio(rac)) != NULL)
-			aops->readpage(rac->file, &folio->page);
+			aops->read_folio(rac->file, folio);
 	}
 
 	blk_finish_plug(&plug);
@@ -256,8 +253,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	}
 
 	/*
-	 * Now start the IO.  We ignore I/O errors - if the page is not
-	 * uptodate then the caller will launch readpage again, and
+	 * Now start the IO.  We ignore I/O errors - if the folio is not
+	 * uptodate then the caller will launch read_folio again, and
 	 * will then handle the error.
 	 */
 	read_pages(ractl);
@@ -305,8 +302,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
 
-	if (unlikely(!mapping->a_ops->read_folio &&
-		     !mapping->a_ops->readpage && !mapping->a_ops->readahead))
+	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
 
 	/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 0f557a512171..f3e8de8ff75c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4162,7 +4162,7 @@ int shmem_zero_setup(struct vm_area_struct *vma)
  *
  * This behaves as a tmpfs "read_cache_page_gfp(mapping, index, gfp)",
  * with any new page allocations done using the specified allocation flags.
- * But read_cache_page_gfp() uses the ->readpage() method: which does not
+ * But read_cache_page_gfp() uses the ->read_folio() method: which does not
  * suit tmpfs, since it may have pages in swapcache, and needs to find those
  * for itself; although drivers/gpu/drm i915 and ttm rely upon this support.
  *
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7c19098b8b45..ecd45bdbad9b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3041,7 +3041,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/*
 	 * Read the swap header.
 	 */
-	if (!mapping->a_ops->read_folio && !mapping->a_ops->readpage) {
+	if (!mapping->a_ops->read_folio) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
 	}
-- 
2.34.1

