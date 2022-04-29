Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB0151520C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379640AbiD2Ray (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379644AbiD2R3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46345A76C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=R6LbfKQvTFbi1836ZzFHIxDANLvoYzMJ5oh4xMfFpAY=; b=hfWyEG9Ke2FD4kuDhgHVB2rO+C
        QLigGpED8QfS5ULhD+UHVKJFs3dUB2Ut8wxborRW1wLP3vHT/VkPzB1FnEkTdam4fWWXyMKUYKCbh
        Ea7n1T+jSMh7L8vD9FilV1HFnKFptX896tNmgJxFgKjMnZ5V591vapkyT9o3qt/PDa6Q6inG0cU7J
        jou4qS1ZOy+aU31ppzg7xth3gR75nUdPwII5a4XcsEd8UEVLCI97WMHTX5yD7k/tVDBXi/Dfdmpy1
        /FuDpFVfQWNZFGdVqAOpGl5sJJolVz3Ju6VBtO7BSK3j1/QEn0ivyI4AXMZYkcHb4WI+H45ezLcoA
        3WszwLug==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNf-00Cde0-Jo; Fri, 29 Apr 2022 17:26:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 69/69] mm,fs: Remove stray references to ->readpage
Date:   Fri, 29 Apr 2022 18:25:56 +0100
Message-Id: <20220429172556.3011843-70-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220429172556.3011843-1-willy@infradead.org>
References: <20220429172556.3011843-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get rid of all references to readpage.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ceph/addr.c          | 2 +-
 include/linux/fs.h      | 7 ++-----
 kernel/events/uprobes.c | 7 ++++---
 mm/filemap.c            | 4 ++--
 mm/memory.c             | 4 ++--
 mm/readahead.c          | 4 ++--
 mm/shmem.c              | 2 +-
 mm/swapfile.c           | 2 +-
 8 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 3acd33da6d8c..e040b92bb17c 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1772,7 +1772,7 @@ int ceph_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct address_space *mapping = file->f_mapping;
 
-	if (!mapping->a_ops->readpage)
+	if (!mapping->a_ops->read_folio)
 		return -ENOEXEC;
 	file_accessed(file);
 	vma->vm_ops = &ceph_vmops;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5ecc4b74204d..f812f5aa07dd 100644
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
@@ -335,10 +335,7 @@ static inline bool is_sync_kiocb(struct kiocb *kiocb)
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	union {
-		int (*readpage)(struct file *, struct page *);
-		int (*read_folio)(struct file *, struct folio *);
-	};
+	int (*read_folio)(struct file *, struct folio *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6418083901d4..a9bc3c98f76a 100644
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
-	if (mapping->a_ops->readpage)
+	if (mapping->a_ops->read_folio)
 		page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
 	else
 		page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
@@ -1143,7 +1143,8 @@ static int __uprobe_register(struct inode *inode, loff_t offset,
 		return -EINVAL;
 
 	/* copy_insn() uses read_mapping_page() or shmem_read_mapping_page() */
-	if (!inode->i_mapping->a_ops->readpage && !shmem_mapping(inode->i_mapping))
+	if (!inode->i_mapping->a_ops->read_folio &&
+	    !shmem_mapping(inode->i_mapping))
 		return -EIO;
 	/* Racy, just to catch the obvious mistakes */
 	if (offset > i_size_read(inode))
diff --git a/mm/filemap.c b/mm/filemap.c
index 132015e42384..079f8cca7959 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2414,7 +2414,7 @@ static int filemap_read_folio(struct file *file, struct address_space *mapping,
 
 	/*
 	 * A previous I/O error may have been due to temporary failures,
-	 * eg. multipath errors.  PG_error will be set again if readpage
+	 * eg. multipath errors.  PG_error will be set again if read_folio
 	 * fails.
 	 */
 	folio_clear_error(folio);
@@ -2636,7 +2636,7 @@ static int filemap_get_pages(struct kiocb *iocb, struct iov_iter *iter,
  * @already_read: Number of bytes already read by the caller.
  *
  * Copies data from the page cache.  If the data is not currently present,
- * uses the readahead and readpage address_space operations to fetch it.
+ * uses the readahead and read_folio address_space operations to fetch it.
  *
  * Return: Total number of bytes copied, including those already read by
  * the caller.  If an error happens before any bytes are copied, returns
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
index 2004aa58ae24..ef506df2de7f 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -253,8 +253,8 @@ void page_cache_ra_unbounded(struct readahead_control *ractl,
 	}
 
 	/*
-	 * Now start the IO.  We ignore I/O errors - if the page is not
-	 * uptodate then the caller will launch readpage again, and
+	 * Now start the IO.  We ignore I/O errors - if the folio is not
+	 * uptodate then the caller will launch read_folio again, and
 	 * will then handle the error.
 	 */
 	read_pages(ractl);
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
index 63c61f8b2611..ecd45bdbad9b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3041,7 +3041,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/*
 	 * Read the swap header.
 	 */
-	if (!mapping->a_ops->readpage) {
+	if (!mapping->a_ops->read_folio) {
 		error = -EINVAL;
 		goto bad_swap_unlock_inode;
 	}
-- 
2.34.1

