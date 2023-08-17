Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E5E77FED0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Aug 2023 22:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353975AbjHQUC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Aug 2023 16:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353293AbjHQUB6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Aug 2023 16:01:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010ED35A1;
        Thu, 17 Aug 2023 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bUPjHvzlWVcWX9UJqkemVI7IHdqjNPgKTYkfH7CfxMQ=; b=TnrdBxOadVAKKF/x+KRk8JT1CP
        saGOso0p4s8qvutJ95UU68HoddFpHrsy7+zW5tSFOk3mjK26HwYRPXQW0mpm8Ek7y0UTOJj+/T+be
        lrgGp7S6nyEeMe4Afog4yHFInj3nX+GLiEJjAPZvqMaPgx5kC17dhEweIhH+nKkcdlRQZBtxIDEf4
        zjs/bonRzvOorlDFpc+45JMo0nvs/skylqNhUfMi2Pu7uzHZPMJZi6fC2D5gpcR8KS6KQWkxlBwyW
        SYbtHHczu3LLVPHc7c5vpSYX8/YMYTNKzSVH4dYlMLoMP+jlTWI5lBNlvEuNSTHPR0U+ah1iB0tnO
        j60G9OsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qWjBo-005A49-BI; Thu, 17 Aug 2023 20:01:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-cxl@vger.kernel.org
Subject: [PATCH] mm: Change calling convention for ->huge_fault
Date:   Thu, 17 Aug 2023 21:01:50 +0100
Message-Id: <20230817200150.1230317-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the unnecessary encoding of page order into an enum and allow
->huge_fault to be called with the vma lock held instead of the mmap_lock.
These two changes are intentionally bundled together to give people a
reasonable chance of noticing that Something Has Changed and they should
audit their driver.

The switch constructs have to be changed to if/else constructs to prevent
GCC from warning on builds with 3-level page tables where PMD_ORDER and
PUD_ORDER have the same value.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 Documentation/filesystems/locking.rst | 18 +++++++++++----
 Documentation/filesystems/porting.rst | 10 ++++++++
 drivers/dax/device.c                  | 22 +++++++-----------
 fs/dax.c                              | 33 +++++++--------------------
 fs/erofs/data.c                       |  6 ++---
 fs/ext2/file.c                        |  2 +-
 fs/ext4/file.c                        | 11 ++++-----
 fs/fuse/dax.c                         | 20 ++++++++--------
 fs/xfs/xfs_file.c                     | 24 +++++++++----------
 fs/xfs/xfs_trace.h                    | 22 ++++++++----------
 include/linux/dax.h                   |  4 ++--
 include/linux/mm.h                    | 10 +-------
 include/linux/pgtable.h               |  3 +++
 mm/memory.c                           | 30 +++++-------------------
 14 files changed, 92 insertions(+), 123 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index ab64356eff1a..d4c8a40234e1 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -635,9 +635,11 @@ vm_operations_struct
 
 prototypes::
 
-	void (*open)(struct vm_area_struct*);
-	void (*close)(struct vm_area_struct*);
-	vm_fault_t (*fault)(struct vm_area_struct*, struct vm_fault *);
+	void (*open)(struct vm_area_struct *);
+	void (*close)(struct vm_area_struct *);
+	vm_fault_t (*fault)(struct vm_fault *);
+	vm_fault_t (*huge_fault)(struct vm_fault *, unsigned int order);
+	vm_fault_t (*map_pages)(struct vm_fault *, pgoff_t start, pgoff_t end);
 	vm_fault_t (*page_mkwrite)(struct vm_area_struct *, struct vm_fault *);
 	vm_fault_t (*pfn_mkwrite)(struct vm_area_struct *, struct vm_fault *);
 	int (*access)(struct vm_area_struct *, unsigned long, void*, int, int);
@@ -650,7 +652,8 @@ ops		mmap_lock	PageLocked(page)
 open:		yes
 close:		yes
 fault:		yes		can return with page locked
-map_pages:	read
+huge_fault	maybe
+map_pages:	maybe
 page_mkwrite:	yes		can return with page locked
 pfn_mkwrite:	yes
 access:		yes
@@ -664,6 +667,13 @@ then ensure the page is not already truncated (invalidate_lock will block
 subsequent truncate), and then return with VM_FAULT_LOCKED, and the page
 locked. The VM will unlock the page.
 
+->huge_fault() is called when there is no PUD or PMD entry present.  This
+gives the filesystem the opportunity to install a PUD or PMD sized page.
+Filesystems can also use the ->fault method to return a PMD sized page,
+so implementing this function may not be necessary.  In particular,
+filesystems should not call filemap_fault() from ->huge_fault().
+The mmap_lock may not be held when this method is called.
+
 ->map_pages() is called when VM asks to map easy accessible pages.
 Filesystem should find and map pages associated with offsets from "start_pgoff"
 till "end_pgoff". ->map_pages() is called with the RCU lock held and must
diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 0f5da78ef4f9..e49228ebae33 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -938,3 +938,13 @@ file pointer instead of struct dentry pointer.  d_tmpfile() is similarly
 changed to simplify callers.  The passed file is in a non-open state and on
 success must be opened before returning (e.g. by calling
 finish_open_simple()).
+
+---
+
+**mandatory**
+
+Calling convention for ->huge_fault has changed.  It now takes a page
+order instead of an enum page_entry_size, and it may be called without the
+mmap_lock held.  All in-tree users have been audited and do not seem to
+depend on the mmap_lock being held, but out of tree users should verify
+for themselves.
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 30665a3ff6ea..93ebedc5ec8c 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -228,32 +228,26 @@ static vm_fault_t __dev_dax_pud_fault(struct dev_dax *dev_dax,
 }
 #endif /* !CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
 
-static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
-		enum page_entry_size pe_size)
+static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 {
 	struct file *filp = vmf->vma->vm_file;
 	vm_fault_t rc = VM_FAULT_SIGBUS;
 	int id;
 	struct dev_dax *dev_dax = filp->private_data;
 
-	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) size = %d\n", current->comm,
+	dev_dbg(&dev_dax->dev, "%s: %s (%#lx - %#lx) order:%d\n", current->comm,
 			(vmf->flags & FAULT_FLAG_WRITE) ? "write" : "read",
-			vmf->vma->vm_start, vmf->vma->vm_end, pe_size);
+			vmf->vma->vm_start, vmf->vma->vm_end, order);
 
 	id = dax_read_lock();
-	switch (pe_size) {
-	case PE_SIZE_PTE:
+	if (order == 0)
 		rc = __dev_dax_pte_fault(dev_dax, vmf);
-		break;
-	case PE_SIZE_PMD:
+	else if (order == PMD_ORDER)
 		rc = __dev_dax_pmd_fault(dev_dax, vmf);
-		break;
-	case PE_SIZE_PUD:
+	else if (order == PUD_ORDER)
 		rc = __dev_dax_pud_fault(dev_dax, vmf);
-		break;
-	default:
+	else
 		rc = VM_FAULT_SIGBUS;
-	}
 
 	dax_read_unlock(id);
 
@@ -262,7 +256,7 @@ static vm_fault_t dev_dax_huge_fault(struct vm_fault *vmf,
 
 static vm_fault_t dev_dax_fault(struct vm_fault *vmf)
 {
-	return dev_dax_huge_fault(vmf, PE_SIZE_PTE);
+	return dev_dax_huge_fault(vmf, 0);
 }
 
 static int dev_dax_may_split(struct vm_area_struct *vma, unsigned long addr)
diff --git a/fs/dax.c b/fs/dax.c
index 906ecbd541a3..8fafecbe42b1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -30,17 +30,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
 
-static inline unsigned int pe_order(enum page_entry_size pe_size)
-{
-	if (pe_size == PE_SIZE_PTE)
-		return PAGE_SHIFT - PAGE_SHIFT;
-	if (pe_size == PE_SIZE_PMD)
-		return PMD_SHIFT - PAGE_SHIFT;
-	if (pe_size == PE_SIZE_PUD)
-		return PUD_SHIFT - PAGE_SHIFT;
-	return ~0;
-}
-
 /* We choose 4096 entries - same as per-zone page wait tables */
 #define DAX_WAIT_TABLE_BITS 12
 #define DAX_WAIT_TABLE_ENTRIES (1 << DAX_WAIT_TABLE_BITS)
@@ -49,9 +38,6 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
 #define PG_PMD_COLOUR	((PMD_SIZE >> PAGE_SHIFT) - 1)
 #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
 
-/* The order of a PMD entry */
-#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
-
 static wait_queue_head_t wait_table[DAX_WAIT_TABLE_ENTRIES];
 
 static int __init init_dax_wait_table(void)
@@ -1908,7 +1894,7 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
 /**
  * dax_iomap_fault - handle a page fault on a DAX file
  * @vmf: The description of the fault
- * @pe_size: Size of the page to fault in
+ * @order: Order of the page to fault in
  * @pfnp: PFN to insert for synchronous faults if fsync is required
  * @iomap_errp: Storage for detailed error code in case of error
  * @ops: Iomap ops passed from the file system
@@ -1918,17 +1904,15 @@ static vm_fault_t dax_iomap_pmd_fault(struct vm_fault *vmf, pfn_t *pfnp,
  * has done all the necessary locking for page fault to proceed
  * successfully.
  */
-vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
+vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 		    pfn_t *pfnp, int *iomap_errp, const struct iomap_ops *ops)
 {
-	switch (pe_size) {
-	case PE_SIZE_PTE:
+	if (order == 0)
 		return dax_iomap_pte_fault(vmf, pfnp, iomap_errp, ops);
-	case PE_SIZE_PMD:
+	else if (order == PMD_ORDER)
 		return dax_iomap_pmd_fault(vmf, pfnp, ops);
-	default:
+	else
 		return VM_FAULT_FALLBACK;
-	}
 }
 EXPORT_SYMBOL_GPL(dax_iomap_fault);
 
@@ -1979,19 +1963,18 @@ dax_insert_pfn_mkwrite(struct vm_fault *vmf, pfn_t pfn, unsigned int order)
 /**
  * dax_finish_sync_fault - finish synchronous page fault
  * @vmf: The description of the fault
- * @pe_size: Size of entry to be inserted
+ * @order: Order of entry to be inserted
  * @pfn: PFN to insert
  *
  * This function ensures that the file range touched by the page fault is
  * stored persistently on the media and handles inserting of appropriate page
  * table entry.
  */
-vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		enum page_entry_size pe_size, pfn_t pfn)
+vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf, unsigned int order,
+		pfn_t pfn)
 {
 	int err;
 	loff_t start = ((loff_t)vmf->pgoff) << PAGE_SHIFT;
-	unsigned int order = pe_order(pe_size);
 	size_t len = PAGE_SIZE << order;
 
 	err = vfs_fsync_range(vmf->vma->vm_file, start, start + len - 1, 1);
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index db5e4b7636ec..0c2c99c58b5e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -413,14 +413,14 @@ const struct address_space_operations erofs_raw_access_aops = {
 
 #ifdef CONFIG_FS_DAX
 static vm_fault_t erofs_dax_huge_fault(struct vm_fault *vmf,
-		enum page_entry_size pe_size)
+		unsigned int order)
 {
-	return dax_iomap_fault(vmf, pe_size, NULL, NULL, &erofs_iomap_ops);
+	return dax_iomap_fault(vmf, order, NULL, NULL, &erofs_iomap_ops);
 }
 
 static vm_fault_t erofs_dax_fault(struct vm_fault *vmf)
 {
-	return erofs_dax_huge_fault(vmf, PE_SIZE_PTE);
+	return erofs_dax_huge_fault(vmf, 0);
 }
 
 static const struct vm_operations_struct erofs_dax_vm_ops = {
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 0b4c91c62e1f..1039e5bf90af 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -103,7 +103,7 @@ static vm_fault_t ext2_dax_fault(struct vm_fault *vmf)
 	}
 	filemap_invalidate_lock_shared(inode->i_mapping);
 
-	ret = dax_iomap_fault(vmf, PE_SIZE_PTE, NULL, NULL, &ext2_iomap_ops);
+	ret = dax_iomap_fault(vmf, 0, NULL, NULL, &ext2_iomap_ops);
 
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 	if (write)
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index c457c8517f0f..2dc3f8301225 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -723,8 +723,7 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 }
 
 #ifdef CONFIG_FS_DAX
-static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
-		enum page_entry_size pe_size)
+static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 {
 	int error = 0;
 	vm_fault_t result;
@@ -740,7 +739,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	 * read-only.
 	 *
 	 * We check for VM_SHARED rather than vmf->cow_page since the latter is
-	 * unset for pe_size != PE_SIZE_PTE (i.e. only in do_cow_fault); for
+	 * unset for order != 0 (i.e. only in do_cow_fault); for
 	 * other sizes, dax_iomap_fault will handle splitting / fallback so that
 	 * we eventually come back with a COW page.
 	 */
@@ -764,7 +763,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 	} else {
 		filemap_invalidate_lock_shared(mapping);
 	}
-	result = dax_iomap_fault(vmf, pe_size, &pfn, &error, &ext4_iomap_ops);
+	result = dax_iomap_fault(vmf, order, &pfn, &error, &ext4_iomap_ops);
 	if (write) {
 		ext4_journal_stop(handle);
 
@@ -773,7 +772,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 			goto retry;
 		/* Handling synchronous page fault? */
 		if (result & VM_FAULT_NEEDDSYNC)
-			result = dax_finish_sync_fault(vmf, pe_size, pfn);
+			result = dax_finish_sync_fault(vmf, order, pfn);
 		filemap_invalidate_unlock_shared(mapping);
 		sb_end_pagefault(sb);
 	} else {
@@ -785,7 +784,7 @@ static vm_fault_t ext4_dax_huge_fault(struct vm_fault *vmf,
 
 static vm_fault_t ext4_dax_fault(struct vm_fault *vmf)
 {
-	return ext4_dax_huge_fault(vmf, PE_SIZE_PTE);
+	return ext4_dax_huge_fault(vmf, 0);
 }
 
 static const struct vm_operations_struct ext4_dax_vm_ops = {
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 8e74f278a3f6..23904a6a9a96 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -784,8 +784,8 @@ static int fuse_dax_writepages(struct address_space *mapping,
 	return dax_writeback_mapping_range(mapping, fc->dax->dev, wbc);
 }
 
-static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
-				   enum page_entry_size pe_size, bool write)
+static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf, unsigned int order,
+		bool write)
 {
 	vm_fault_t ret;
 	struct inode *inode = file_inode(vmf->vma->vm_file);
@@ -809,7 +809,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	 * to populate page cache or access memory we are trying to free.
 	 */
 	filemap_invalidate_lock_shared(inode->i_mapping);
-	ret = dax_iomap_fault(vmf, pe_size, &pfn, &error, &fuse_iomap_ops);
+	ret = dax_iomap_fault(vmf, order, &pfn, &error, &fuse_iomap_ops);
 	if ((ret & VM_FAULT_ERROR) && error == -EAGAIN) {
 		error = 0;
 		retry = true;
@@ -818,7 +818,7 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 	}
 
 	if (ret & VM_FAULT_NEEDDSYNC)
-		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+		ret = dax_finish_sync_fault(vmf, order, pfn);
 	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	if (write)
@@ -829,24 +829,22 @@ static vm_fault_t __fuse_dax_fault(struct vm_fault *vmf,
 
 static vm_fault_t fuse_dax_fault(struct vm_fault *vmf)
 {
-	return __fuse_dax_fault(vmf, PE_SIZE_PTE,
-				vmf->flags & FAULT_FLAG_WRITE);
+	return __fuse_dax_fault(vmf, 0, vmf->flags & FAULT_FLAG_WRITE);
 }
 
-static vm_fault_t fuse_dax_huge_fault(struct vm_fault *vmf,
-			       enum page_entry_size pe_size)
+static vm_fault_t fuse_dax_huge_fault(struct vm_fault *vmf, unsigned int order)
 {
-	return __fuse_dax_fault(vmf, pe_size, vmf->flags & FAULT_FLAG_WRITE);
+	return __fuse_dax_fault(vmf, order, vmf->flags & FAULT_FLAG_WRITE);
 }
 
 static vm_fault_t fuse_dax_page_mkwrite(struct vm_fault *vmf)
 {
-	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+	return __fuse_dax_fault(vmf, 0, true);
 }
 
 static vm_fault_t fuse_dax_pfn_mkwrite(struct vm_fault *vmf)
 {
-	return __fuse_dax_fault(vmf, PE_SIZE_PTE, true);
+	return __fuse_dax_fault(vmf, 0, true);
 }
 
 static const struct vm_operations_struct fuse_dax_vm_ops = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 4f502219ae4f..203700278ddb 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1287,11 +1287,11 @@ xfs_file_llseek(
 static inline vm_fault_t
 xfs_dax_fault(
 	struct vm_fault		*vmf,
-	enum page_entry_size	pe_size,
+	unsigned int		order,
 	bool			write_fault,
 	pfn_t			*pfn)
 {
-	return dax_iomap_fault(vmf, pe_size, pfn, NULL,
+	return dax_iomap_fault(vmf, order, pfn, NULL,
 			(write_fault && !vmf->cow_page) ?
 				&xfs_dax_write_iomap_ops :
 				&xfs_read_iomap_ops);
@@ -1300,7 +1300,7 @@ xfs_dax_fault(
 static inline vm_fault_t
 xfs_dax_fault(
 	struct vm_fault		*vmf,
-	enum page_entry_size	pe_size,
+	unsigned int		order,
 	bool			write_fault,
 	pfn_t			*pfn)
 {
@@ -1322,14 +1322,14 @@ xfs_dax_fault(
 static vm_fault_t
 __xfs_filemap_fault(
 	struct vm_fault		*vmf,
-	enum page_entry_size	pe_size,
+	unsigned int		order,
 	bool			write_fault)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
 	struct xfs_inode	*ip = XFS_I(inode);
 	vm_fault_t		ret;
 
-	trace_xfs_filemap_fault(ip, pe_size, write_fault);
+	trace_xfs_filemap_fault(ip, order, write_fault);
 
 	if (write_fault) {
 		sb_start_pagefault(inode->i_sb);
@@ -1340,9 +1340,9 @@ __xfs_filemap_fault(
 		pfn_t pfn;
 
 		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-		ret = xfs_dax_fault(vmf, pe_size, write_fault, &pfn);
+		ret = xfs_dax_fault(vmf, order, write_fault, &pfn);
 		if (ret & VM_FAULT_NEEDDSYNC)
-			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
+			ret = dax_finish_sync_fault(vmf, order, pfn);
 		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 	} else {
 		if (write_fault) {
@@ -1373,7 +1373,7 @@ xfs_filemap_fault(
 	struct vm_fault		*vmf)
 {
 	/* DAX can shortcut the normal fault path on write faults! */
-	return __xfs_filemap_fault(vmf, PE_SIZE_PTE,
+	return __xfs_filemap_fault(vmf, 0,
 			IS_DAX(file_inode(vmf->vma->vm_file)) &&
 			xfs_is_write_fault(vmf));
 }
@@ -1381,13 +1381,13 @@ xfs_filemap_fault(
 static vm_fault_t
 xfs_filemap_huge_fault(
 	struct vm_fault		*vmf,
-	enum page_entry_size	pe_size)
+	unsigned int		order)
 {
 	if (!IS_DAX(file_inode(vmf->vma->vm_file)))
 		return VM_FAULT_FALLBACK;
 
 	/* DAX can shortcut the normal fault path on write faults! */
-	return __xfs_filemap_fault(vmf, pe_size,
+	return __xfs_filemap_fault(vmf, order,
 			xfs_is_write_fault(vmf));
 }
 
@@ -1395,7 +1395,7 @@ static vm_fault_t
 xfs_filemap_page_mkwrite(
 	struct vm_fault		*vmf)
 {
-	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
+	return __xfs_filemap_fault(vmf, 0, true);
 }
 
 /*
@@ -1408,7 +1408,7 @@ xfs_filemap_pfn_mkwrite(
 	struct vm_fault		*vmf)
 {
 
-	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
+	return __xfs_filemap_fault(vmf, 0, true);
 }
 
 static const struct vm_operations_struct xfs_file_vm_ops = {
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index f3cc204bb4bf..1904eaf7a2e9 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -802,36 +802,34 @@ DEFINE_INODE_EVENT(xfs_inode_inactivating);
  * ring buffer.  Somehow this was only worth mentioning in the ftrace sample
  * code.
  */
-TRACE_DEFINE_ENUM(PE_SIZE_PTE);
-TRACE_DEFINE_ENUM(PE_SIZE_PMD);
-TRACE_DEFINE_ENUM(PE_SIZE_PUD);
+TRACE_DEFINE_ENUM(PMD_ORDER);
+TRACE_DEFINE_ENUM(PUD_ORDER);
 
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_SHARED);
 TRACE_DEFINE_ENUM(XFS_REFC_DOMAIN_COW);
 
 TRACE_EVENT(xfs_filemap_fault,
-	TP_PROTO(struct xfs_inode *ip, enum page_entry_size pe_size,
-		 bool write_fault),
-	TP_ARGS(ip, pe_size, write_fault),
+	TP_PROTO(struct xfs_inode *ip, unsigned int order, bool write_fault),
+	TP_ARGS(ip, order, write_fault),
 	TP_STRUCT__entry(
 		__field(dev_t, dev)
 		__field(xfs_ino_t, ino)
-		__field(enum page_entry_size, pe_size)
+		__field(unsigned int, order)
 		__field(bool, write_fault)
 	),
 	TP_fast_assign(
 		__entry->dev = VFS_I(ip)->i_sb->s_dev;
 		__entry->ino = ip->i_ino;
-		__entry->pe_size = pe_size;
+		__entry->order = order;
 		__entry->write_fault = write_fault;
 	),
 	TP_printk("dev %d:%d ino 0x%llx %s write_fault %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  __entry->ino,
-		  __print_symbolic(__entry->pe_size,
-			{ PE_SIZE_PTE,	"PTE" },
-			{ PE_SIZE_PMD,	"PMD" },
-			{ PE_SIZE_PUD,	"PUD" }),
+		  __print_symbolic(__entry->order,
+			{ 0,		"PTE" },
+			{ PMD_ORDER,	"PMD" },
+			{ PUD_ORDER,	"PUD" }),
 		  __entry->write_fault)
 )
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 261944ec0887..22cd9902345d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -241,10 +241,10 @@ void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops);
-vm_fault_t dax_iomap_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
+vm_fault_t dax_iomap_fault(struct vm_fault *vmf, unsigned int order,
 		    pfn_t *pfnp, int *errp, const struct iomap_ops *ops);
 vm_fault_t dax_finish_sync_fault(struct vm_fault *vmf,
-		enum page_entry_size pe_size, pfn_t pfn);
+		unsigned int order, pfn_t pfn);
 int dax_delete_mapping_entry(struct address_space *mapping, pgoff_t index);
 int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 				      pgoff_t index);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3f764e84e567..840bae5f23b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -551,13 +551,6 @@ struct vm_fault {
 					 */
 };
 
-/* page entry size for vm->huge_fault() */
-enum page_entry_size {
-	PE_SIZE_PTE = 0,
-	PE_SIZE_PMD,
-	PE_SIZE_PUD,
-};
-
 /*
  * These are the virtual MM functions - opening of an area, closing and
  * unmapping it (needed to keep files on disk up-to-date etc), pointer
@@ -581,8 +574,7 @@ struct vm_operations_struct {
 	int (*mprotect)(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, unsigned long newflags);
 	vm_fault_t (*fault)(struct vm_fault *vmf);
-	vm_fault_t (*huge_fault)(struct vm_fault *vmf,
-			enum page_entry_size pe_size);
+	vm_fault_t (*huge_fault)(struct vm_fault *vmf, unsigned int order);
 	vm_fault_t (*map_pages)(struct vm_fault *vmf,
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
 	unsigned long (*pagesize)(struct vm_area_struct * area);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index db4fe642b3e2..a3f38c03c806 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -5,6 +5,9 @@
 #include <linux/pfn.h>
 #include <asm/pgtable.h>
 
+#define PMD_ORDER	(PMD_SHIFT - PTE_SHIFT)
+#define PUD_ORDER	(PUD_SHIFT - PTE_SHIFT)
+
 #ifndef __ASSEMBLY__
 #ifdef CONFIG_MMU
 
diff --git a/mm/memory.c b/mm/memory.c
index 3b4aaa0d2fff..2947fbc558f6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4873,13 +4873,8 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
 	struct vm_area_struct *vma = vmf->vma;
 	if (vma_is_anonymous(vma))
 		return do_huge_pmd_anonymous_page(vmf);
-	if (vma->vm_ops->huge_fault) {
-		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-			vma_end_read(vma);
-			return VM_FAULT_RETRY;
-		}
-		return vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
-	}
+	if (vma->vm_ops->huge_fault)
+		return vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 	return VM_FAULT_FALLBACK;
 }
 
@@ -4899,11 +4894,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
 
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		if (vma->vm_ops->huge_fault) {
-			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-				vma_end_read(vma);
-				return VM_FAULT_RETRY;
-			}
-			ret = vma->vm_ops->huge_fault(vmf, PE_SIZE_PMD);
+			ret = vma->vm_ops->huge_fault(vmf, PMD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
 				return ret;
 		}
@@ -4923,13 +4914,8 @@ static vm_fault_t create_huge_pud(struct vm_fault *vmf)
 	/* No support for anonymous transparent PUD pages yet */
 	if (vma_is_anonymous(vma))
 		return VM_FAULT_FALLBACK;
-	if (vma->vm_ops->huge_fault) {
-		if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-			vma_end_read(vma);
-			return VM_FAULT_RETRY;
-		}
-		return vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
-	}
+	if (vma->vm_ops->huge_fault)
+		return vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 	return VM_FAULT_FALLBACK;
 }
@@ -4946,11 +4932,7 @@ static vm_fault_t wp_huge_pud(struct vm_fault *vmf, pud_t orig_pud)
 		goto split;
 	if (vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) {
 		if (vma->vm_ops->huge_fault) {
-			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
-				vma_end_read(vma);
-				return VM_FAULT_RETRY;
-			}
-			ret = vma->vm_ops->huge_fault(vmf, PE_SIZE_PUD);
+			ret = vma->vm_ops->huge_fault(vmf, PUD_ORDER);
 			if (!(ret & VM_FAULT_FALLBACK))
 				return ret;
 		}
-- 
2.40.1

