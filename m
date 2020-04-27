Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7737A1B9AC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 10:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgD0Iso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 04:48:44 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:3144 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725899AbgD0Ism (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:48:42 -0400
X-IronPort-AV: E=Sophos;i="5.73,323,1583164800"; 
   d="scan'208";a="90547652"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 16:48:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D7A794BCC88C;
        Mon, 27 Apr 2020 16:37:49 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 16:48:32 +0800
Received: from localhost.localdomain (10.167.225.141) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 27 Apr 2020 16:48:31 +0800
From:   Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>
CC:     <linux-mm@kvack.org>, <linux-fsdevel@vger.kernel.org>,
        <darrick.wong@oracle.com>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@lst.de>, <rgoldwyn@suse.de>,
        <qi.fuli@fujitsu.com>, <y-goto@fujitsu.com>
Subject: [RFC PATCH 1/8] fs/dax: Introduce dax-rmap btree for reflink
Date:   Mon, 27 Apr 2020 16:47:43 +0800
Message-ID: <20200427084750.136031-2-ruansy.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
References: <20200427084750.136031-1-ruansy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D7A794BCC88C.A20EE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Normally, when accessing a mmapped file, entering the page fault, the
file's (->mapping, ->index) will be associated with dax entry(represents
for one page or a couple of pages) to facilitate the reverse mapping
search.  But in the case of reflink, a dax entry may be shared by multiple
files or offsets.  In order to establish a reverse mapping relationship in
this case, I introduce a rb-tree to track multiple files and offsets.

The root of the rb-tree is stored in page->private, since I haven't found
it be used in fsdax.  We create the rb-tree and insert the
(->mapping, ->index) tuple in the second time a dax entry is associated,
which means this dax entry is shared.  And delete this tuple from the
rb-tree when disassociating.

Signed-off-by: Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
---
 fs/dax.c            | 153 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/dax.h |   6 ++
 2 files changed, 147 insertions(+), 12 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 11b16729b86f..2f996c566103 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <linux/rbtree.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
@@ -310,6 +311,120 @@ static unsigned long dax_entry_size(void *entry)
 		return PAGE_SIZE;
 }
 
+static struct kmem_cache *dax_rmap_node_cachep;
+static struct kmem_cache *dax_rmap_root_cachep;
+
+static int __init init_dax_rmap_cache(void)
+{
+	dax_rmap_root_cachep = KMEM_CACHE(rb_root_cached, SLAB_PANIC|SLAB_ACCOUNT);
+	dax_rmap_node_cachep = KMEM_CACHE(shared_file, SLAB_PANIC|SLAB_ACCOUNT);
+	return 0;
+}
+fs_initcall(init_dax_rmap_cache);
+
+struct rb_root_cached *dax_create_rbroot(void)
+{
+	struct rb_root_cached *root = kmem_cache_alloc(dax_rmap_root_cachep,
+						       GFP_KERNEL);
+
+	memset(root, 0, sizeof(struct rb_root_cached));
+	return root;
+}
+
+static bool dax_rmap_insert(struct page *page, struct address_space *mapping,
+			    pgoff_t index)
+{
+	struct rb_root_cached *root = (struct rb_root_cached *)page_private(page);
+	struct rb_node **new, *parent = NULL;
+	struct shared_file *p;
+	bool leftmost = true;
+
+	if (!root) {
+		root = dax_create_rbroot();
+		set_page_private(page, (unsigned long)root);
+		dax_rmap_insert(page, page->mapping, page->index);
+	}
+	new = &root->rb_root.rb_node;
+	/* Figure out where to insert new node */
+	while (*new) {
+		struct shared_file *this = container_of(*new, struct shared_file, node);
+		long result = (long)mapping - (long)this->mapping;
+
+		if (result == 0)
+			result = (long)index - (long)this->index;
+		parent = *new;
+		if (result < 0)
+			new = &((*new)->rb_left);
+		else if (result > 0) {
+			new = &((*new)->rb_right);
+			leftmost = false;
+		} else
+			return false;
+	}
+	p = kmem_cache_alloc(dax_rmap_node_cachep, GFP_KERNEL);
+	p->mapping = mapping;
+	p->index = index;
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&p->node, parent, new);
+	rb_insert_color_cached(&p->node, root, leftmost);
+
+	return true;
+}
+
+static struct shared_file *dax_rmap_search(struct page *page,
+					   struct address_space *mapping,
+					   pgoff_t index)
+{
+	struct rb_root_cached *root = (struct rb_root_cached *)page_private(page);
+	struct rb_node *node = root->rb_root.rb_node;
+
+	while (node) {
+		struct shared_file *this = container_of(node, struct shared_file, node);
+		long result = (long)mapping - (long)this->mapping;
+
+		if (result == 0)
+			result = (long)index - (long)this->index;
+		if (result < 0)
+			node = node->rb_left;
+		else if (result > 0)
+			node = node->rb_right;
+		else
+			return this;
+	}
+	return NULL;
+}
+
+static void dax_rmap_delete(struct page *page, struct address_space *mapping,
+			    pgoff_t index)
+{
+	struct rb_root_cached *root = (struct rb_root_cached *)page_private(page);
+	struct shared_file *this;
+
+	if (!root) {
+		page->mapping = NULL;
+		page->index = 0;
+		return;
+	}
+
+	this = dax_rmap_search(page, mapping, index);
+	rb_erase_cached(&this->node, root);
+	kmem_cache_free(dax_rmap_node_cachep, this);
+
+	if (!RB_EMPTY_ROOT(&root->rb_root)) {
+		if (page->mapping == mapping && page->index == index) {
+			this = container_of(rb_first_cached(root), struct shared_file, node);
+			page->mapping = this->mapping;
+			page->index = this->index;
+		}
+	} else {
+		kmem_cache_free(dax_rmap_root_cachep, root);
+		set_page_private(page, 0);
+		page->mapping = NULL;
+		page->index = 0;
+	}
+}
+
 static unsigned long dax_end_pfn(void *entry)
 {
 	return dax_to_pfn(entry) + dax_entry_size(entry) / PAGE_SIZE;
@@ -341,16 +456,20 @@ static void dax_associate_entry(void *entry, struct address_space *mapping,
 	for_each_mapped_pfn(entry, pfn) {
 		struct page *page = pfn_to_page(pfn);
 
-		WARN_ON_ONCE(page->mapping);
-		page->mapping = mapping;
-		page->index = index + i++;
+		if (!page->mapping) {
+			page->mapping = mapping;
+			page->index = index + i++;
+		} else {
+			dax_rmap_insert(page, mapping, index + i++);
+		}
 	}
 }
 
 static void dax_disassociate_entry(void *entry, struct address_space *mapping,
-		bool trunc)
+				   pgoff_t index, bool trunc)
 {
 	unsigned long pfn;
+	int i = 0;
 
 	if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
 		return;
@@ -359,9 +478,19 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		struct page *page = pfn_to_page(pfn);
 
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
-		WARN_ON_ONCE(page->mapping && page->mapping != mapping);
-		page->mapping = NULL;
-		page->index = 0;
+		WARN_ON_ONCE(!page->mapping);
+		dax_rmap_delete(page, mapping, index + i++);
+	}
+}
+
+static void __dax_decrease_nrexceptional(void *entry,
+					 struct address_space *mapping)
+{
+	if (dax_is_empty_entry(entry) || dax_is_zero_entry(entry) ||
+	    dax_is_pmd_entry(entry)) {
+		mapping->nrexceptional--;
+	} else {
+		mapping->nrexceptional -= PHYS_PFN(dax_entry_size(entry));
 	}
 }
 
@@ -522,10 +651,10 @@ static void *grab_mapping_entry(struct xa_state *xas,
 			xas_lock_irq(xas);
 		}
 
-		dax_disassociate_entry(entry, mapping, false);
+		dax_disassociate_entry(entry, mapping, index, false);
 		xas_store(xas, NULL);	/* undo the PMD join */
 		dax_wake_entry(xas, entry, true);
-		mapping->nrexceptional--;
+		__dax_decrease_nrexceptional(entry, mapping);
 		entry = NULL;
 		xas_set(xas, index);
 	}
@@ -642,9 +771,9 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	    (xas_get_mark(&xas, PAGECACHE_TAG_DIRTY) ||
 	     xas_get_mark(&xas, PAGECACHE_TAG_TOWRITE)))
 		goto out;
-	dax_disassociate_entry(entry, mapping, trunc);
+	dax_disassociate_entry(entry, mapping, index, trunc);
 	xas_store(&xas, NULL);
-	mapping->nrexceptional--;
+	__dax_decrease_nrexceptional(entry, mapping);
 	ret = 1;
 out:
 	put_unlocked_entry(&xas, entry);
@@ -737,7 +866,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
-		dax_disassociate_entry(entry, mapping, false);
+		dax_disassociate_entry(entry, mapping, xas->xa_index, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address);
 		/*
 		 * Only swap our new entry into the page cache if the current
diff --git a/include/linux/dax.h b/include/linux/dax.h
index d7af5d243f24..1e2e81c701b6 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -39,6 +39,12 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct shared_file {
+	struct address_space *mapping;
+	pgoff_t index;
+	struct rb_node node;
+};
+
 extern struct attribute_group dax_attribute_group;
 
 #if IS_ENABLED(CONFIG_DAX)
-- 
2.26.2



