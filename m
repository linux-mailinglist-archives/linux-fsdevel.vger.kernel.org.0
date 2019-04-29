Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13326DB54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfD2Eyx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:28440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfD2EyI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566293"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:07 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 05/10] mm/gup: Take FL_LONGTERM lease if not set by user
Date:   Sun, 28 Apr 2019 21:53:54 -0700
Message-Id: <20190429045359.8923-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429045359.8923-1-ira.weiny@intel.com>
References: <20190429045359.8923-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

If a user has failed to take a F_LONGTERM lease on a file and they
do a longterm pin on the pages associated with a file, take a
FL_LONGTERM lease for them.

If the user has not taken a lease on the file they are trying to pin
create a FL_LONGTERM lease and attach it to the inode associated with
the memory being pinned.

If the user has already taken a lease ref count the lease such that it
will not be removed until all the GUP pins have been removed.  This
prevents the user from removing the GUP lease and tricking the kernel
into thinking the memory is free.

Follow on patches will send a SIGBUS if the user does not remove their
GUP pins and the FS needs the pages in question.  This should only
happen if they have not planned the use of the file correctly and are
allowing other processes to truncate/hold punch a file they are actively
trying to access.

This is similar to what would happen if the memory was accessed through
a regular CPU instruction with a couple of exceptions.

1) The SIGBUS is sent when the memory becomes invalid rather than
   waiting for an access by the process.  This is because we don't know
   when the device may try to access the page.  So we assume that the
   page gets "accessed immediately."

2) Hole punch is treated like a truncate.  As such SIGBUS is sent rather
   than attempting to allocate file space as a normal CPU access would.
---
 fs/locks.c         | 179 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |   4 +
 mm/gup.c           |   7 +-
 mm/huge_memory.c   |   6 +-
 4 files changed, 187 insertions(+), 9 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 31c8b761a578..ae508d192223 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -343,8 +343,10 @@ struct file_lock *locks_alloc_lock(void)
 {
 	struct file_lock *fl = kmem_cache_zalloc(filelock_cache, GFP_KERNEL);
 
-	if (fl)
+	if (fl) {
 		locks_init_lock_heads(fl);
+		kref_init(&fl->gup_ref);
+	}
 
 	return fl;
 }
@@ -607,6 +609,14 @@ static const struct lock_manager_operations lease_manager_ops = {
 	.lm_setup = lease_setup,
 };
 
+static int lease_modify_longterm(struct file_lock *fl, int arg,
+				 struct list_head *dispose);
+static const struct lock_manager_operations lease_longterm_ops = {
+	.lm_break = lease_break_callback,
+	.lm_change = lease_modify_longterm,
+	.lm_setup = lease_setup,
+};
+
 /*
  * Initialize a lease, use the default lock manager operations
  */
@@ -621,12 +631,15 @@ static int lease_init(struct file *filp, long type, unsigned int flags,
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
-	if (flags & FL_LONGTERM)
+	if (flags & FL_LONGTERM) {
 		fl->fl_flags |= FL_LONGTERM;
+		fl->fl_lmops = &lease_longterm_ops;
+	} else {
+		fl->fl_lmops = &lease_manager_ops;
+	}
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
-	fl->fl_lmops = &lease_manager_ops;
 	return 0;
 }
 
@@ -1506,6 +1519,55 @@ int lease_modify(struct file_lock *fl, int arg, struct list_head *dispose)
 }
 EXPORT_SYMBOL(lease_modify);
 
+static void release_longterm_lease(struct kref *kref)
+{
+	struct file_lock *fl = container_of(kref, struct file_lock, gup_ref);
+
+	locks_delete_lock_ctx(fl, NULL);
+}
+
+/*
+ * LONGTERM leases are special in that they may be held by the GUP code and
+ * therefore can't be modified in the same way as regular file leases.
+ *
+ * Specifically the lease is refcounted by GUP based on the number of pages are
+ * which want to hold the lease.
+ */
+static int lease_modify_longterm(struct file_lock *fl, int arg,
+				 struct list_head *dispose)
+{
+	int error = assign_type(fl, arg);
+
+	if (error)
+		return error;
+	lease_clear_pending(fl, arg);
+	locks_wake_up_blocks(fl);
+
+	if (arg == F_UNLCK) {
+		struct file *filp = fl->fl_file;
+
+		/*
+		 * Users who take the longterm lease get a reference to it.
+		 * This modify will remove that reference if it exists.  But
+		 * only that reference.  This means that the GUP code must exit
+		 * before the LONGTERM lease will be fully removed.
+		 */
+		if (filp) {
+			f_delown(filp);
+			filp->f_owner.signum = 0;
+
+			fasync_helper(0, fl->fl_file, 0, &fl->fl_fasync);
+			if (fl->fl_fasync != NULL) {
+				printk(KERN_ERR "locks_delete_lock: fasync == %p\n", fl->fl_fasync);
+				fl->fl_fasync = NULL;
+			}
+
+			kref_put(&fl->gup_ref, release_longterm_lease);
+		}
+	}
+	return 0;
+}
+
 static bool past_time(unsigned long then)
 {
 	if (!then)
@@ -1794,6 +1856,33 @@ check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
 	return ret;
 }
 
+/*
+ * Note the locks could eventually be optimized to lock over smaller areas
+ * of the file.  But for now we do this per inode.
+ *
+ * The rational is due to the most common use case where we don't expect users
+ * to to be removing any of the pages of the file while it is being used by the
+ * longterm pin.  Should the user want to alter the file in this way they will
+ * be required to release the pins alter the file and restablish the pins.
+ *
+ * inode->i_flctx->flc_lock must be held.
+ */
+static struct file_lock *find_longterm_lease(struct inode *inode)
+{
+	struct file_lock *ret = NULL;
+	struct file_lock *fl;
+
+	list_for_each_entry(fl, &inode->i_flctx->flc_lease, fl_list) {
+		if (fl->fl_flags & FL_LONGTERM &&
+		    fl->fl_pid == current->tgid) {
+			ret = fl;
+			break;
+		}
+	}
+
+	return ret;
+}
+
 static int
 generic_add_lease(struct file *filp, long arg, struct file_lock **flp, void **priv)
 {
@@ -2986,3 +3075,87 @@ bool mapping_inode_has_longterm(struct page *page)
 }
 EXPORT_SYMBOL_GPL(mapping_inode_has_longterm);
 
+/*
+ * if the user has not already taken a longterm lease on a devmap FS page do it
+ * for them.
+ *
+ * Heavily borrowed frem the NFS code.
+ */
+bool page_set_longterm_lease(struct page *page)
+{
+	struct file_lock_context *ctx;
+	struct inode *inode;
+	struct file_lock *new_fl, *existing_fl;
+
+	/*
+	 * We should never be here unless we are a "page cache" page
+	 * And we are a devm managed page
+	 */
+	if (WARN_ON(!page) ||
+	    WARN_ON(PageAnon(page)) ||
+	    WARN_ON(!page->mapping) ||
+	    WARN_ON(!page->mapping->host) ||
+	    WARN_ON(!page_is_devmap_managed(page)))
+		return false;
+
+	new_fl = lease_alloc(NULL, F_RDLCK, FL_LONGTERM);
+	if (IS_ERR(new_fl))
+		return false;
+
+	/* Ensure page->mapping isn't freed while we look at it */
+	/* No locking needed...  mm sem is held. */
+	inode = page->mapping->host;
+
+	ctx = locks_get_lock_context(inode, F_RDLCK);
+	percpu_down_read(&file_rwsem);
+	spin_lock(&ctx->flc_lock);
+
+	existing_fl = find_longterm_lease(inode);
+	if (!existing_fl) {
+		existing_fl = new_fl;
+		locks_insert_lock_ctx(new_fl, &ctx->flc_lease);
+	} else {
+		kref_get(&existing_fl->gup_ref);
+	}
+
+	spin_unlock(&ctx->flc_lock);
+	percpu_up_read(&file_rwsem);
+
+	if (existing_fl != new_fl)
+		locks_free_lock(new_fl);
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(page_set_longterm_lease);
+
+void page_remove_longterm_lease(struct page *page)
+{
+	struct file_lock_context *ctx;
+	struct inode *inode;
+	struct file_lock *found;
+
+	/*
+	 * We should never be here unless we are a "page cache" page
+	 * And we are a devm managed page
+	 */
+	if (WARN_ON(!page) ||
+	    WARN_ON(PageAnon(page)) ||
+	    WARN_ON(!page->mapping) ||
+	    WARN_ON(!page->mapping->host) ||
+	    WARN_ON(!page_is_devmap_managed(page)))
+		return;
+
+	inode = page->mapping->host;
+
+	ctx = locks_get_lock_context(inode, F_RDLCK);
+
+	found = NULL;
+	percpu_down_read(&file_rwsem);
+	spin_lock(&ctx->flc_lock);
+	found = find_longterm_lease(inode);
+	if (found)
+		kref_put(&found->gup_ref, release_longterm_lease);
+	spin_unlock(&ctx->flc_lock);
+	percpu_up_read(&file_rwsem);
+}
+EXPORT_SYMBOL_GPL(page_remove_longterm_lease);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ace21c6feb19..be2d08080aa5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -40,6 +40,7 @@
 #include <linux/fs_types.h>
 #include <linux/build_bug.h>
 #include <linux/stddef.h>
+#include <linux/kref.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -1093,6 +1094,7 @@ struct file_lock {
 			int state;		/* state of grant or error if -ve */
 		} afs;
 	} fl_u;
+	struct kref gup_ref;
 } __randomize_layout;
 
 struct file_lock_context {
@@ -1152,6 +1154,8 @@ extern int lease_modify(struct file_lock *, int, struct list_head *);
 struct files_struct;
 extern void show_fd_locks(struct seq_file *f,
 			 struct file *filp, struct files_struct *files);
+bool page_set_longterm_lease(struct page *page);
+void page_remove_longterm_lease(struct page *page);
 #else /* !CONFIG_FILE_LOCKING */
 static inline int fcntl_getlk(struct file *file, unsigned int cmd,
 			      struct flock __user *user)
diff --git a/mm/gup.c b/mm/gup.c
index 5ae1dd31a58d..1ee17f2339f7 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -51,6 +51,9 @@ void put_user_page(struct page *page)
 {
 	page = compound_head(page);
 
+	if (page_is_devmap_managed(page))
+		page_remove_longterm_lease(page);
+
 	/*
 	 * For devmap managed pages we need to catch refcount transition from
 	 * GUP_PIN_COUNTING_BIAS to 1, when refcount reach one it means the
@@ -294,7 +297,7 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 			goto no_page;
 
 		if (unlikely(flags & FOLL_LONGTERM) &&
-		    !mapping_inode_has_longterm(page)) {
+		    !page_set_longterm_lease(page)) {
 			page = ERR_PTR(-EINVAL);
 			goto out;
 		}
@@ -1877,7 +1880,7 @@ static int __gup_device_huge(unsigned long pfn, unsigned long addr,
 		pages[*nr] = page;
 
 		if (unlikely(flags & FOLL_LONGTERM) &&
-		    !mapping_inode_has_longterm(page)) {
+		    !page_set_longterm_lease(page)) {
 			undo_dev_pagemap(nr, nr_start, pages);
 			return 0;
 		}
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 8819624c740f..6a8c039fe6ff 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -915,9 +915,8 @@ struct page *follow_devmap_pmd(struct vm_area_struct *vma, unsigned long addr,
 	// FIXME combine logic
 	if (unlikely(flags & FOLL_LONGTERM)) {
 		WARN_ON_ONCE(PageAnon(page));
-		if (!mapping_inode_has_longterm(page)) {
+		if (!page_set_longterm_lease(page))
 			return NULL;
-		}
 	}
 
 	get_page(page);
@@ -1065,9 +1064,8 @@ struct page *follow_devmap_pud(struct vm_area_struct *vma, unsigned long addr,
 	// FIXME combine logic remove Warn
 	if (unlikely(flags & FOLL_LONGTERM)) {
 		WARN_ON_ONCE(PageAnon(page));
-		if (!mapping_inode_has_longterm(page)) {
+		if (!page_set_longterm_lease(page))
 			return NULL;
-		}
 	}
 
 	get_page(page);
-- 
2.20.1

