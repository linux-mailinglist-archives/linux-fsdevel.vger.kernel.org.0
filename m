Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6588869E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbfHIW7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:59:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:60827 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730626AbfHIW7H (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:59:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:03 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="175282026"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:59:03 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 14/19] fs/locks: Associate file pins while performing GUP
Date:   Fri,  9 Aug 2019 15:58:28 -0700
Message-Id: <20190809225833.6657-15-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

When a file back area is being pinned add the appropriate file pin
information to the appropriate file or mm owner.  This information can
then be used by admins to determine who is causing a failure to change
the layout of a file.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c         | 195 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mm.h |  35 +++++++-
 mm/gup.c           |   8 +-
 mm/huge_memory.c   |   4 +-
 4 files changed, 230 insertions(+), 12 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 14892c84844b..02c525446d25 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -168,6 +168,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/hashtable.h>
 #include <linux/percpu.h>
+#include <linux/sched/mm.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/filelock.h>
@@ -2972,9 +2973,194 @@ static int __init filelock_init(void)
 }
 core_initcall(filelock_init);
 
+static struct file_file_pin *alloc_file_file_pin(struct inode *inode,
+						 struct file *file)
+{
+	struct file_file_pin *fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
+
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&fp->list);
+	kref_init(&fp->ref);
+	return fp;
+}
+
+static int add_file_pin_to_f_owner(struct vaddr_pin *vaddr_pin,
+				   struct inode *inode,
+				   struct file *file)
+{
+	struct file_file_pin *fp;
+
+	list_for_each_entry(fp, &vaddr_pin->f_owner->file_pins, list) {
+		if (fp->file == file) {
+			kref_get(&fp->ref);
+			return 0;
+		}
+	}
+
+	fp = alloc_file_file_pin(inode, file);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	fp->file = get_file(file);
+	/* NOTE no reference needed here.
+	 * It is expected that the caller holds a reference to the owner file
+	 * for the duration of this pin.
+	 */
+	fp->f_owner = vaddr_pin->f_owner;
+
+	spin_lock(&fp->f_owner->fp_lock);
+	list_add(&fp->list, &fp->f_owner->file_pins);
+	spin_unlock(&fp->f_owner->fp_lock);
+
+	return 0;
+}
+
+static void release_file_file_pin(struct kref *ref)
+{
+	struct file_file_pin *fp = container_of(ref, struct file_file_pin, ref);
+
+	spin_lock(&fp->f_owner->fp_lock);
+	list_del(&fp->list);
+	spin_unlock(&fp->f_owner->fp_lock);
+	fput(fp->file);
+	kfree(fp);
+}
+
+static struct mm_file_pin *alloc_mm_file_pin(struct inode *inode,
+					     struct file *file)
+{
+	struct mm_file_pin *fp = kzalloc(sizeof(*fp), GFP_ATOMIC);
+
+	if (!fp)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&fp->list);
+	kref_init(&fp->ref);
+	return fp;
+}
+
+/**
+ * This object bridges files and the mm struct for the purpose of tracking
+ * which files have GUP pins on them.
+ */
+static int add_file_pin_to_mm(struct vaddr_pin *vaddr_pin, struct inode *inode,
+			      struct file *file)
+{
+	struct mm_file_pin *fp;
+
+	list_for_each_entry(fp, &vaddr_pin->mm->file_pins, list) {
+		if (fp->inode == inode) {
+			kref_get(&fp->ref);
+			return 0;
+		}
+	}
+
+	fp = alloc_mm_file_pin(inode, file);
+	if (IS_ERR(fp))
+		return PTR_ERR(fp);
+
+	fp->inode = igrab(inode);
+	if (!fp->inode) {
+		kfree(fp);
+		return -EFAULT;
+	}
+
+	fp->file = get_file(file);
+	fp->mm = vaddr_pin->mm;
+	mmgrab(fp->mm);
+
+	spin_lock(&fp->mm->fp_lock);
+	list_add(&fp->list, &fp->mm->file_pins);
+	spin_unlock(&fp->mm->fp_lock);
+
+	return 0;
+}
+
+static void release_mm_file_pin(struct kref *ref)
+{
+	struct mm_file_pin *fp = container_of(ref, struct mm_file_pin, ref);
+
+	spin_lock(&fp->mm->fp_lock);
+	list_del(&fp->list);
+	spin_unlock(&fp->mm->fp_lock);
+
+	mmdrop(fp->mm);
+	fput(fp->file);
+	iput(fp->inode);
+	kfree(fp);
+}
+
+static void remove_file_file_pin(struct vaddr_pin *vaddr_pin)
+{
+	struct file_file_pin *fp;
+	struct file_file_pin *tmp;
+
+	list_for_each_entry_safe(fp, tmp, &vaddr_pin->f_owner->file_pins,
+				 list) {
+		kref_put(&fp->ref, release_file_file_pin);
+	}
+}
+
+static void remove_mm_file_pin(struct vaddr_pin *vaddr_pin,
+			       struct inode *inode)
+{
+	struct mm_file_pin *fp;
+	struct mm_file_pin *tmp;
+
+	list_for_each_entry_safe(fp, tmp, &vaddr_pin->mm->file_pins, list) {
+		if (fp->inode == inode)
+			kref_put(&fp->ref, release_mm_file_pin);
+	}
+}
+
+static bool add_file_pin(struct vaddr_pin *vaddr_pin, struct inode *inode,
+			 struct file *file)
+{
+	bool ret = true;
+
+	if (!vaddr_pin || (!vaddr_pin->f_owner && !vaddr_pin->mm))
+		return false;
+
+	if (vaddr_pin->f_owner) {
+		if (add_file_pin_to_f_owner(vaddr_pin, inode, file))
+			ret = false;
+	} else {
+		if (add_file_pin_to_mm(vaddr_pin, inode, file))
+			ret = false;
+	}
+
+	return ret;
+}
+
+void mapping_release_file(struct vaddr_pin *vaddr_pin, struct page *page)
+{
+	struct inode *inode;
+
+	if (WARN_ON(!page) || WARN_ON(!vaddr_pin) ||
+	    WARN_ON(!vaddr_pin->mm && !vaddr_pin->f_owner))
+		return;
+
+	if (PageAnon(page) ||
+	    !page->mapping ||
+	    !page->mapping->host)
+		return;
+
+	inode = page->mapping->host;
+
+	if (vaddr_pin->f_owner)
+		remove_file_file_pin(vaddr_pin);
+	else
+		remove_mm_file_pin(vaddr_pin, inode);
+}
+EXPORT_SYMBOL_GPL(mapping_release_file);
+
 /**
  * mapping_inode_has_layout - ensure a file mapped page has a layout lease
  * taken
+ * @vaddr_pin: pin owner information to store with this pin if a proper layout
+ * is lease is found.
  * @page: page we are trying to GUP
  *
  * This should only be called on DAX pages.  DAX pages which are mapped through
@@ -2983,9 +3169,12 @@ core_initcall(filelock_init);
  * This allows the user to opt-into the fact that truncation operations will
  * fail for the duration of the pin.
  *
+ * Also if the proper layout leases are found we store pining information into
+ * the owner passed in via the vaddr_pin structure.
+ *
  * Return true if the page has a LAYOUT lease associated with it's file.
  */
-bool mapping_inode_has_layout(struct page *page)
+bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page)
 {
 	bool ret = false;
 	struct inode *inode;
@@ -3003,12 +3192,12 @@ bool mapping_inode_has_layout(struct page *page)
 	if (inode->i_flctx &&
 	    !list_empty_careful(&inode->i_flctx->flc_lease)) {
 		spin_lock(&inode->i_flctx->flc_lock);
-		ret = false;
 		list_for_each_entry(fl, &inode->i_flctx->flc_lease, fl_list) {
 			if (fl->fl_pid == current->tgid &&
 			    (fl->fl_flags & FL_LAYOUT) &&
 			    (fl->fl_flags & FL_EXCLUSIVE)) {
-				ret = true;
+				ret = add_file_pin(vaddr_pin, inode,
+						   fl->fl_file);
 				break;
 			}
 		}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d37cafbef9a..657c947bda49 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -981,9 +981,11 @@ struct vaddr_pin {
 };
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
+void mapping_release_file(struct vaddr_pin *vaddr_pin, struct page *page);
 void __put_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
-static inline bool put_devmap_managed_page(struct page *page)
+
+static inline bool page_is_devmap_managed(struct page *page)
 {
 	if (!static_branch_unlikely(&devmap_managed_key))
 		return false;
@@ -992,7 +994,6 @@ static inline bool put_devmap_managed_page(struct page *page)
 	switch (page->pgmap->type) {
 	case MEMORY_DEVICE_PRIVATE:
 	case MEMORY_DEVICE_FS_DAX:
-		__put_devmap_managed_page(page);
 		return true;
 	default:
 		break;
@@ -1000,11 +1001,39 @@ static inline bool put_devmap_managed_page(struct page *page)
 	return false;
 }
 
+static inline bool put_devmap_managed_page(struct page *page)
+{
+	bool is_devmap = page_is_devmap_managed(page);
+	if (is_devmap)
+		__put_devmap_managed_page(page);
+	return is_devmap;
+}
+
+static inline bool put_devmap_managed_user_page(struct vaddr_pin *vaddr_pin,
+						struct page *page)
+{
+	bool is_devmap = page_is_devmap_managed(page);
+
+	if (is_devmap) {
+		if (page->pgmap->type == MEMORY_DEVICE_FS_DAX)
+			mapping_release_file(vaddr_pin, page);
+
+		__put_devmap_managed_page(page);
+	}
+
+	return is_devmap;
+}
+
 #else /* CONFIG_DEV_PAGEMAP_OPS */
 static inline bool put_devmap_managed_page(struct page *page)
 {
 	return false;
 }
+static inline bool put_devmap_managed_user_page(struct vaddr_pin *vaddr_pin,
+						struct page *page)
+{
+	return false;
+}
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
 
 static inline bool is_device_private_page(const struct page *page)
@@ -1574,7 +1603,7 @@ int account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc);
 int __account_locked_vm(struct mm_struct *mm, unsigned long pages, bool inc,
 			struct task_struct *task, bool bypass_rlim);
 
-bool mapping_inode_has_layout(struct page *page);
+bool mapping_inode_has_layout(struct vaddr_pin *vaddr_pin, struct page *page);
 
 /* Container for pinned pfns / pages */
 struct frame_vector {
diff --git a/mm/gup.c b/mm/gup.c
index 10cfd30ff668..eeaa0ddd08a6 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -34,7 +34,7 @@ static void __put_user_page(struct vaddr_pin *vaddr_pin, struct page *page)
 	 * page is free and we need to inform the device driver through
 	 * callback. See include/linux/memremap.h and HMM for details.
 	 */
-	if (put_devmap_managed_page(page))
+	if (put_devmap_managed_user_page(vaddr_pin, page))
 		return;
 
 	if (put_page_testzero(page))
@@ -272,7 +272,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 
 		if (unlikely(flags & FOLL_LONGTERM) &&
 		    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
-		    !mapping_inode_has_layout(page)) {
+		    !mapping_inode_has_layout(ctx->vaddr_pin, page)) {
 			page = ERR_PTR(-EPERM);
 			goto out;
 		}
@@ -1915,7 +1915,7 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
 		if (pte_devmap(pte) &&
 		    unlikely(flags & FOLL_LONGTERM) &&
 		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
-		    !mapping_inode_has_layout(head)) {
+		    !mapping_inode_has_layout(vaddr_pin, head)) {
 			put_user_page(head);
 			goto pte_unmap;
 		}
@@ -1972,7 +1972,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 
 		if (unlikely(flags & FOLL_LONGTERM) &&
 		    pgmap->type == MEMORY_DEVICE_FS_DAX &&
-		    !mapping_inode_has_layout(page)) {
+		    !mapping_inode_has_layout(vaddr_pin, page)) {
 			undo_dev_pagemap(nr, nr_start, pages);
 			return 0;
 		}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7e09f2f17ed8..2d700e21d4af 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -957,7 +957,7 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (unlikely(flags & FOLL_LONGTERM) &&
 	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
-	    !mapping_inode_has_layout(page))
+	    !mapping_inode_has_layout(ctx->vaddr_pin, page))
 		return ERR_PTR(-EPERM);
 
 	get_page(page);
@@ -1104,7 +1104,7 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 
 	if (unlikely(flags & FOLL_LONGTERM) &&
 	    (*pgmap)->type == MEMORY_DEVICE_FS_DAX &&
-	    !mapping_inode_has_layout(page))
+	    !mapping_inode_has_layout(ctx->vaddr_pin, page))
 		return ERR_PTR(-EPERM);
 
 	get_page(page);
-- 
2.20.1

