Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC710D881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2019 17:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfK2QdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 11:33:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:57529 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfK2QdL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 11:33:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:09 -0800
X-IronPort-AV: E=Sophos;i="5.69,257,1571727600"; 
   d="scan'208";a="241095624"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2019 08:33:08 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH V3 2/3] fs: Move swap_[de]activate to file_operations
Date:   Fri, 29 Nov 2019 08:32:59 -0800
Message-Id: <20191129163300.14749-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191129163300.14749-1-ira.weiny@intel.com>
References: <20191129163300.14749-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

swap_activate() and swap_deactivate() have nothing to do with address
spaces.  We want to be able to change the address space operations on
the fly to allow changing inode flags dynamically.

Switching address space operations can be difficult to do reliably.[1]
Therefore, to simplify switching address space operations we reduce the
number of functions in those operations by moving swap_activate() and
swap_deactivate() out of the address space operations.

No functionality is changed with this patch.

This has been tested with XFS but not NFS, f2fs, or btrfs.

Also note we move some functions to facilitate compilation.  But there
are no functional changes are contained within those diffs.

[1] https://lkml.org/lkml/2019/11/11/572

Cc: Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: David Sterba <dsterba@suse.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V0:
	Update cover letter.
	fix btrfs as per Andrew's comments
	change xfs_iomap_swapfile_activate() to xfs_file_swap_activate()

Changes from V2:
	Add review for xfs part
	Add Ack for btrfs part
	Rebased to latest linux-next and fix btrfs conflict mentioned by
	David.
		... a simple rename of btrfs_block_group_cache to
		    btrfs_block_group.

 fs/btrfs/file.c    | 341 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/inode.c   | 340 --------------------------------------------
 fs/f2fs/data.c     | 122 ----------------
 fs/f2fs/file.c     | 122 ++++++++++++++++
 fs/nfs/file.c      |   4 +-
 fs/xfs/xfs_aops.c  |  13 --
 fs/xfs/xfs_file.c  |  12 ++
 include/linux/fs.h |  10 +-
 mm/swapfile.c      |  12 +-
 9 files changed, 487 insertions(+), 489 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0cb43b682789..677d7965d5f6 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -16,6 +16,7 @@
 #include <linux/btrfs.h>
 #include <linux/uio.h>
 #include <linux/iversion.h>
+#include <linux/swap.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "transaction.h"
@@ -27,6 +28,7 @@
 #include "qgroup.h"
 #include "compression.h"
 #include "delalloc-space.h"
+#include "block-group.h"
 
 static struct kmem_cache *btrfs_inode_defrag_cachep;
 /*
@@ -3444,6 +3446,343 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 	return generic_file_open(inode, filp);
 }
 
+#ifdef CONFIG_SWAP
+/*
+ * Add an entry indicating a block group or device which is pinned by a
+ * swapfile. Returns 0 on success, 1 if there is already an entry for it, or a
+ * negative errno on failure.
+ */
+static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
+				  bool is_block_group)
+{
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_swapfile_pin *sp, *entry;
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+
+	sp = kmalloc(sizeof(*sp), GFP_NOFS);
+	if (!sp)
+		return -ENOMEM;
+	sp->ptr = ptr;
+	sp->inode = inode;
+	sp->is_block_group = is_block_group;
+
+	spin_lock(&fs_info->swapfile_pins_lock);
+	p = &fs_info->swapfile_pins.rb_node;
+	while (*p) {
+		parent = *p;
+		entry = rb_entry(parent, struct btrfs_swapfile_pin, node);
+		if (sp->ptr < entry->ptr ||
+		    (sp->ptr == entry->ptr && sp->inode < entry->inode)) {
+			p = &(*p)->rb_left;
+		} else if (sp->ptr > entry->ptr ||
+			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
+			p = &(*p)->rb_right;
+		} else {
+			spin_unlock(&fs_info->swapfile_pins_lock);
+			kfree(sp);
+			return 1;
+		}
+	}
+	rb_link_node(&sp->node, parent, p);
+	rb_insert_color(&sp->node, &fs_info->swapfile_pins);
+	spin_unlock(&fs_info->swapfile_pins_lock);
+	return 0;
+}
+
+/* Free all of the entries pinned by this swapfile. */
+static void btrfs_free_swapfile_pins(struct inode *inode)
+{
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct btrfs_swapfile_pin *sp;
+	struct rb_node *node, *next;
+
+	spin_lock(&fs_info->swapfile_pins_lock);
+	node = rb_first(&fs_info->swapfile_pins);
+	while (node) {
+		next = rb_next(node);
+		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
+		if (sp->inode == inode) {
+			rb_erase(&sp->node, &fs_info->swapfile_pins);
+			if (sp->is_block_group)
+				btrfs_put_block_group(sp->ptr);
+			kfree(sp);
+		}
+		node = next;
+	}
+	spin_unlock(&fs_info->swapfile_pins_lock);
+}
+
+struct btrfs_swap_info {
+	u64 start;
+	u64 block_start;
+	u64 block_len;
+	u64 lowest_ppage;
+	u64 highest_ppage;
+	unsigned long nr_pages;
+	int nr_extents;
+};
+
+static int btrfs_add_swap_extent(struct swap_info_struct *sis,
+				 struct btrfs_swap_info *bsi)
+{
+	unsigned long nr_pages;
+	u64 first_ppage, first_ppage_reported, next_ppage;
+	int ret;
+
+	first_ppage = ALIGN(bsi->block_start, PAGE_SIZE) >> PAGE_SHIFT;
+	next_ppage = ALIGN_DOWN(bsi->block_start + bsi->block_len,
+				PAGE_SIZE) >> PAGE_SHIFT;
+
+	if (first_ppage >= next_ppage)
+		return 0;
+	nr_pages = next_ppage - first_ppage;
+
+	first_ppage_reported = first_ppage;
+	if (bsi->start == 0)
+		first_ppage_reported++;
+	if (bsi->lowest_ppage > first_ppage_reported)
+		bsi->lowest_ppage = first_ppage_reported;
+	if (bsi->highest_ppage < (next_ppage - 1))
+		bsi->highest_ppage = next_ppage - 1;
+
+	ret = add_swap_extent(sis, bsi->nr_pages, nr_pages, first_ppage);
+	if (ret < 0)
+		return ret;
+	bsi->nr_extents += ret;
+	bsi->nr_pages += nr_pages;
+	return 0;
+}
+
+static void btrfs_swap_deactivate(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	btrfs_free_swapfile_pins(inode);
+	atomic_dec(&BTRFS_I(inode)->root->nr_swapfiles);
+}
+
+static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
+			       sector_t *span)
+{
+	struct inode *inode = file_inode(file);
+	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_state *cached_state = NULL;
+	struct extent_map *em = NULL;
+	struct btrfs_device *device = NULL;
+	struct btrfs_swap_info bsi = {
+		.lowest_ppage = (sector_t)-1ULL,
+	};
+	int ret = 0;
+	u64 isize;
+	u64 start;
+
+	/*
+	 * If the swap file was just created, make sure delalloc is done. If the
+	 * file changes again after this, the user is doing something stupid and
+	 * we don't really care.
+	 */
+	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
+	if (ret)
+		return ret;
+
+	/*
+	 * The inode is locked, so these flags won't change after we check them.
+	 */
+	if (BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS) {
+		btrfs_warn(fs_info, "swapfile must not be compressed");
+		return -EINVAL;
+	}
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)) {
+		btrfs_warn(fs_info, "swapfile must not be copy-on-write");
+		return -EINVAL;
+	}
+	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
+		btrfs_warn(fs_info, "swapfile must not be checksummed");
+		return -EINVAL;
+	}
+
+	/*
+	 * Balance or device remove/replace/resize can move stuff around from
+	 * under us. The EXCL_OP flag makes sure they aren't running/won't run
+	 * concurrently while we are mapping the swap extents, and
+	 * fs_info->swapfile_pins prevents them from running while the swap file
+	 * is active and moving the extents. Note that this also prevents a
+	 * concurrent device add which isn't actually necessary, but it's not
+	 * really worth the trouble to allow it.
+	 */
+	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+		btrfs_warn(fs_info,
+	   "cannot activate swapfile while exclusive operation is running");
+		return -EBUSY;
+	}
+	/*
+	 * Snapshots can create extents which require COW even if NODATACOW is
+	 * set. We use this counter to prevent snapshots. We must increment it
+	 * before walking the extents because we don't want a concurrent
+	 * snapshot to run after we've already checked the extents.
+	 */
+	atomic_inc(&BTRFS_I(inode)->root->nr_swapfiles);
+
+	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
+
+	lock_extent_bits(io_tree, 0, isize - 1, &cached_state);
+	start = 0;
+	while (start < isize) {
+		u64 logical_block_start, physical_block_start;
+		struct btrfs_block_group *bg;
+		u64 len = isize - start;
+
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto out;
+		}
+
+		if (em->block_start == EXTENT_MAP_HOLE) {
+			btrfs_warn(fs_info, "swapfile must not have holes");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (em->block_start == EXTENT_MAP_INLINE) {
+			/*
+			 * It's unlikely we'll ever actually find ourselves
+			 * here, as a file small enough to fit inline won't be
+			 * big enough to store more than the swap header, but in
+			 * case something changes in the future, let's catch it
+			 * here rather than later.
+			 */
+			btrfs_warn(fs_info, "swapfile must not be inline");
+			ret = -EINVAL;
+			goto out;
+		}
+		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
+			btrfs_warn(fs_info, "swapfile must not be compressed");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		logical_block_start = em->block_start + (start - em->start);
+		len = min(len, em->len - (start - em->start));
+		free_extent_map(em);
+		em = NULL;
+
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL);
+		if (ret < 0) {
+			goto out;
+		} else if (ret) {
+			ret = 0;
+		} else {
+			btrfs_warn(fs_info,
+				   "swapfile must not be copy-on-write");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		em = btrfs_get_chunk_map(fs_info, logical_block_start, len);
+		if (IS_ERR(em)) {
+			ret = PTR_ERR(em);
+			goto out;
+		}
+
+		if (em->map_lookup->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
+			btrfs_warn(fs_info,
+				   "swapfile must have single data profile");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		if (device == NULL) {
+			device = em->map_lookup->stripes[0].dev;
+			ret = btrfs_add_swapfile_pin(inode, device, false);
+			if (ret == 1)
+				ret = 0;
+			else if (ret)
+				goto out;
+		} else if (device != em->map_lookup->stripes[0].dev) {
+			btrfs_warn(fs_info, "swapfile must be on one device");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		physical_block_start = (em->map_lookup->stripes[0].physical +
+					(logical_block_start - em->start));
+		len = min(len, em->len - (logical_block_start - em->start));
+		free_extent_map(em);
+		em = NULL;
+
+		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
+		if (!bg) {
+			btrfs_warn(fs_info,
+			   "could not find block group containing swapfile");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = btrfs_add_swapfile_pin(inode, bg, true);
+		if (ret) {
+			btrfs_put_block_group(bg);
+			if (ret == 1)
+				ret = 0;
+			else
+				goto out;
+		}
+
+		if (bsi.block_len &&
+		    bsi.block_start + bsi.block_len == physical_block_start) {
+			bsi.block_len += len;
+		} else {
+			if (bsi.block_len) {
+				ret = btrfs_add_swap_extent(sis, &bsi);
+				if (ret)
+					goto out;
+			}
+			bsi.start = start;
+			bsi.block_start = physical_block_start;
+			bsi.block_len = len;
+		}
+
+		start += len;
+	}
+
+	if (bsi.block_len)
+		ret = btrfs_add_swap_extent(sis, &bsi);
+
+out:
+	if (!IS_ERR_OR_NULL(em))
+		free_extent_map(em);
+
+	unlock_extent_cached(io_tree, 0, isize - 1, &cached_state);
+
+	if (ret)
+		btrfs_swap_deactivate(file);
+
+	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+
+	if (ret)
+		return ret;
+
+	if (device)
+		sis->bdev = device->bdev;
+	*span = bsi.highest_ppage - bsi.lowest_ppage + 1;
+	sis->max = bsi.nr_pages;
+	sis->pages = bsi.nr_pages - 1;
+	sis->highest_bit = bsi.nr_pages - 1;
+	return bsi.nr_extents;
+}
+#else
+static void btrfs_swap_deactivate(struct file *file)
+{
+}
+
+static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
+			       sector_t *span)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
 	.read_iter      = generic_file_read_iter,
@@ -3459,6 +3798,8 @@ const struct file_operations btrfs_file_operations = {
 	.compat_ioctl	= btrfs_compat_ioctl,
 #endif
 	.remap_file_range = btrfs_remap_file_range,
+	.swap_activate	= btrfs_swap_activate,
+	.swap_deactivate = btrfs_swap_deactivate,
 };
 
 void __cold btrfs_auto_defrag_exit(void)
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 56032c518b26..938e9d4e1ba2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -27,7 +27,6 @@
 #include <linux/uio.h>
 #include <linux/magic.h>
 #include <linux/iversion.h>
-#include <linux/swap.h>
 #include <linux/sched/mm.h>
 #include <asm/unaligned.h>
 #include "misc.h"
@@ -10647,343 +10646,6 @@ void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end)
 	}
 }
 
-#ifdef CONFIG_SWAP
-/*
- * Add an entry indicating a block group or device which is pinned by a
- * swapfile. Returns 0 on success, 1 if there is already an entry for it, or a
- * negative errno on failure.
- */
-static int btrfs_add_swapfile_pin(struct inode *inode, void *ptr,
-				  bool is_block_group)
-{
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct btrfs_swapfile_pin *sp, *entry;
-	struct rb_node **p;
-	struct rb_node *parent = NULL;
-
-	sp = kmalloc(sizeof(*sp), GFP_NOFS);
-	if (!sp)
-		return -ENOMEM;
-	sp->ptr = ptr;
-	sp->inode = inode;
-	sp->is_block_group = is_block_group;
-
-	spin_lock(&fs_info->swapfile_pins_lock);
-	p = &fs_info->swapfile_pins.rb_node;
-	while (*p) {
-		parent = *p;
-		entry = rb_entry(parent, struct btrfs_swapfile_pin, node);
-		if (sp->ptr < entry->ptr ||
-		    (sp->ptr == entry->ptr && sp->inode < entry->inode)) {
-			p = &(*p)->rb_left;
-		} else if (sp->ptr > entry->ptr ||
-			   (sp->ptr == entry->ptr && sp->inode > entry->inode)) {
-			p = &(*p)->rb_right;
-		} else {
-			spin_unlock(&fs_info->swapfile_pins_lock);
-			kfree(sp);
-			return 1;
-		}
-	}
-	rb_link_node(&sp->node, parent, p);
-	rb_insert_color(&sp->node, &fs_info->swapfile_pins);
-	spin_unlock(&fs_info->swapfile_pins_lock);
-	return 0;
-}
-
-/* Free all of the entries pinned by this swapfile. */
-static void btrfs_free_swapfile_pins(struct inode *inode)
-{
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct btrfs_swapfile_pin *sp;
-	struct rb_node *node, *next;
-
-	spin_lock(&fs_info->swapfile_pins_lock);
-	node = rb_first(&fs_info->swapfile_pins);
-	while (node) {
-		next = rb_next(node);
-		sp = rb_entry(node, struct btrfs_swapfile_pin, node);
-		if (sp->inode == inode) {
-			rb_erase(&sp->node, &fs_info->swapfile_pins);
-			if (sp->is_block_group)
-				btrfs_put_block_group(sp->ptr);
-			kfree(sp);
-		}
-		node = next;
-	}
-	spin_unlock(&fs_info->swapfile_pins_lock);
-}
-
-struct btrfs_swap_info {
-	u64 start;
-	u64 block_start;
-	u64 block_len;
-	u64 lowest_ppage;
-	u64 highest_ppage;
-	unsigned long nr_pages;
-	int nr_extents;
-};
-
-static int btrfs_add_swap_extent(struct swap_info_struct *sis,
-				 struct btrfs_swap_info *bsi)
-{
-	unsigned long nr_pages;
-	u64 first_ppage, first_ppage_reported, next_ppage;
-	int ret;
-
-	first_ppage = ALIGN(bsi->block_start, PAGE_SIZE) >> PAGE_SHIFT;
-	next_ppage = ALIGN_DOWN(bsi->block_start + bsi->block_len,
-				PAGE_SIZE) >> PAGE_SHIFT;
-
-	if (first_ppage >= next_ppage)
-		return 0;
-	nr_pages = next_ppage - first_ppage;
-
-	first_ppage_reported = first_ppage;
-	if (bsi->start == 0)
-		first_ppage_reported++;
-	if (bsi->lowest_ppage > first_ppage_reported)
-		bsi->lowest_ppage = first_ppage_reported;
-	if (bsi->highest_ppage < (next_ppage - 1))
-		bsi->highest_ppage = next_ppage - 1;
-
-	ret = add_swap_extent(sis, bsi->nr_pages, nr_pages, first_ppage);
-	if (ret < 0)
-		return ret;
-	bsi->nr_extents += ret;
-	bsi->nr_pages += nr_pages;
-	return 0;
-}
-
-static void btrfs_swap_deactivate(struct file *file)
-{
-	struct inode *inode = file_inode(file);
-
-	btrfs_free_swapfile_pins(inode);
-	atomic_dec(&BTRFS_I(inode)->root->nr_swapfiles);
-}
-
-static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
-			       sector_t *span)
-{
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
-	struct extent_state *cached_state = NULL;
-	struct extent_map *em = NULL;
-	struct btrfs_device *device = NULL;
-	struct btrfs_swap_info bsi = {
-		.lowest_ppage = (sector_t)-1ULL,
-	};
-	int ret = 0;
-	u64 isize;
-	u64 start;
-
-	/*
-	 * If the swap file was just created, make sure delalloc is done. If the
-	 * file changes again after this, the user is doing something stupid and
-	 * we don't really care.
-	 */
-	ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
-	if (ret)
-		return ret;
-
-	/*
-	 * The inode is locked, so these flags won't change after we check them.
-	 */
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_COMPRESS) {
-		btrfs_warn(fs_info, "swapfile must not be compressed");
-		return -EINVAL;
-	}
-	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW)) {
-		btrfs_warn(fs_info, "swapfile must not be copy-on-write");
-		return -EINVAL;
-	}
-	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
-		btrfs_warn(fs_info, "swapfile must not be checksummed");
-		return -EINVAL;
-	}
-
-	/*
-	 * Balance or device remove/replace/resize can move stuff around from
-	 * under us. The EXCL_OP flag makes sure they aren't running/won't run
-	 * concurrently while we are mapping the swap extents, and
-	 * fs_info->swapfile_pins prevents them from running while the swap file
-	 * is active and moving the extents. Note that this also prevents a
-	 * concurrent device add which isn't actually necessary, but it's not
-	 * really worth the trouble to allow it.
-	 */
-	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
-		btrfs_warn(fs_info,
-	   "cannot activate swapfile while exclusive operation is running");
-		return -EBUSY;
-	}
-	/*
-	 * Snapshots can create extents which require COW even if NODATACOW is
-	 * set. We use this counter to prevent snapshots. We must increment it
-	 * before walking the extents because we don't want a concurrent
-	 * snapshot to run after we've already checked the extents.
-	 */
-	atomic_inc(&BTRFS_I(inode)->root->nr_swapfiles);
-
-	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
-
-	lock_extent_bits(io_tree, 0, isize - 1, &cached_state);
-	start = 0;
-	while (start < isize) {
-		u64 logical_block_start, physical_block_start;
-		struct btrfs_block_group *bg;
-		u64 len = isize - start;
-
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-			goto out;
-		}
-
-		if (em->block_start == EXTENT_MAP_HOLE) {
-			btrfs_warn(fs_info, "swapfile must not have holes");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (em->block_start == EXTENT_MAP_INLINE) {
-			/*
-			 * It's unlikely we'll ever actually find ourselves
-			 * here, as a file small enough to fit inline won't be
-			 * big enough to store more than the swap header, but in
-			 * case something changes in the future, let's catch it
-			 * here rather than later.
-			 */
-			btrfs_warn(fs_info, "swapfile must not be inline");
-			ret = -EINVAL;
-			goto out;
-		}
-		if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags)) {
-			btrfs_warn(fs_info, "swapfile must not be compressed");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		logical_block_start = em->block_start + (start - em->start);
-		len = min(len, em->len - (start - em->start));
-		free_extent_map(em);
-		em = NULL;
-
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL);
-		if (ret < 0) {
-			goto out;
-		} else if (ret) {
-			ret = 0;
-		} else {
-			btrfs_warn(fs_info,
-				   "swapfile must not be copy-on-write");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		em = btrfs_get_chunk_map(fs_info, logical_block_start, len);
-		if (IS_ERR(em)) {
-			ret = PTR_ERR(em);
-			goto out;
-		}
-
-		if (em->map_lookup->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
-			btrfs_warn(fs_info,
-				   "swapfile must have single data profile");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		if (device == NULL) {
-			device = em->map_lookup->stripes[0].dev;
-			ret = btrfs_add_swapfile_pin(inode, device, false);
-			if (ret == 1)
-				ret = 0;
-			else if (ret)
-				goto out;
-		} else if (device != em->map_lookup->stripes[0].dev) {
-			btrfs_warn(fs_info, "swapfile must be on one device");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		physical_block_start = (em->map_lookup->stripes[0].physical +
-					(logical_block_start - em->start));
-		len = min(len, em->len - (logical_block_start - em->start));
-		free_extent_map(em);
-		em = NULL;
-
-		bg = btrfs_lookup_block_group(fs_info, logical_block_start);
-		if (!bg) {
-			btrfs_warn(fs_info,
-			   "could not find block group containing swapfile");
-			ret = -EINVAL;
-			goto out;
-		}
-
-		ret = btrfs_add_swapfile_pin(inode, bg, true);
-		if (ret) {
-			btrfs_put_block_group(bg);
-			if (ret == 1)
-				ret = 0;
-			else
-				goto out;
-		}
-
-		if (bsi.block_len &&
-		    bsi.block_start + bsi.block_len == physical_block_start) {
-			bsi.block_len += len;
-		} else {
-			if (bsi.block_len) {
-				ret = btrfs_add_swap_extent(sis, &bsi);
-				if (ret)
-					goto out;
-			}
-			bsi.start = start;
-			bsi.block_start = physical_block_start;
-			bsi.block_len = len;
-		}
-
-		start += len;
-	}
-
-	if (bsi.block_len)
-		ret = btrfs_add_swap_extent(sis, &bsi);
-
-out:
-	if (!IS_ERR_OR_NULL(em))
-		free_extent_map(em);
-
-	unlock_extent_cached(io_tree, 0, isize - 1, &cached_state);
-
-	if (ret)
-		btrfs_swap_deactivate(file);
-
-	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
-
-	if (ret)
-		return ret;
-
-	if (device)
-		sis->bdev = device->bdev;
-	*span = bsi.highest_ppage - bsi.lowest_ppage + 1;
-	sis->max = bsi.nr_pages;
-	sis->pages = bsi.nr_pages - 1;
-	sis->highest_bit = bsi.nr_pages - 1;
-	return bsi.nr_extents;
-}
-#else
-static void btrfs_swap_deactivate(struct file *file)
-{
-}
-
-static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
-			       sector_t *span)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 static const struct inode_operations btrfs_dir_inode_operations = {
 	.getattr	= btrfs_getattr,
 	.lookup		= btrfs_lookup,
@@ -11050,8 +10712,6 @@ static const struct address_space_operations btrfs_aops = {
 	.releasepage	= btrfs_releasepage,
 	.set_page_dirty	= btrfs_set_page_dirty,
 	.error_remove_page = generic_error_remove_page,
-	.swap_activate	= btrfs_swap_activate,
-	.swap_deactivate = btrfs_swap_deactivate,
 };
 
 static const struct inode_operations btrfs_file_inode_operations = {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9067c7e68992..aad7981edead 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -14,7 +14,6 @@
 #include <linux/pagevec.h>
 #include <linux/blkdev.h>
 #include <linux/bio.h>
-#include <linux/swap.h>
 #include <linux/prefetch.h>
 #include <linux/uio.h>
 #include <linux/cleancache.h>
@@ -3143,125 +3142,6 @@ int f2fs_migrate_page(struct address_space *mapping,
 }
 #endif
 
-#ifdef CONFIG_SWAP
-/* Copied from generic_swapfile_activate() to check any holes */
-static int check_swap_activate(struct file *swap_file, unsigned int max)
-{
-	struct inode *inode = swap_file->f_mapping->host;
-	unsigned blocks_per_page;
-	unsigned long page_no;
-	unsigned blkbits;
-	sector_t probe_block;
-	sector_t last_block;
-	sector_t lowest_block = -1;
-	sector_t highest_block = 0;
-
-	blkbits = inode->i_blkbits;
-	blocks_per_page = PAGE_SIZE >> blkbits;
-
-	/*
-	 * Map all the blocks into the extent list.  This code doesn't try
-	 * to be very smart.
-	 */
-	probe_block = 0;
-	page_no = 0;
-	last_block = i_size_read(inode) >> blkbits;
-	while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
-		unsigned block_in_page;
-		sector_t first_block;
-
-		cond_resched();
-
-		first_block = bmap(inode, probe_block);
-		if (first_block == 0)
-			goto bad_bmap;
-
-		/*
-		 * It must be PAGE_SIZE aligned on-disk
-		 */
-		if (first_block & (blocks_per_page - 1)) {
-			probe_block++;
-			goto reprobe;
-		}
-
-		for (block_in_page = 1; block_in_page < blocks_per_page;
-					block_in_page++) {
-			sector_t block;
-
-			block = bmap(inode, probe_block + block_in_page);
-			if (block == 0)
-				goto bad_bmap;
-			if (block != first_block + block_in_page) {
-				/* Discontiguity */
-				probe_block++;
-				goto reprobe;
-			}
-		}
-
-		first_block >>= (PAGE_SHIFT - blkbits);
-		if (page_no) {	/* exclude the header page */
-			if (first_block < lowest_block)
-				lowest_block = first_block;
-			if (first_block > highest_block)
-				highest_block = first_block;
-		}
-
-		page_no++;
-		probe_block += blocks_per_page;
-reprobe:
-		continue;
-	}
-	return 0;
-
-bad_bmap:
-	pr_err("swapon: swapfile has holes\n");
-	return -EINVAL;
-}
-
-static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
-				sector_t *span)
-{
-	struct inode *inode = file_inode(file);
-	int ret;
-
-	if (!S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
-		return -EROFS;
-
-	ret = f2fs_convert_inline_inode(inode);
-	if (ret)
-		return ret;
-
-	ret = check_swap_activate(file, sis->max);
-	if (ret)
-		return ret;
-
-	set_inode_flag(inode, FI_PIN_FILE);
-	f2fs_precache_extents(inode);
-	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
-	return 0;
-}
-
-static void f2fs_swap_deactivate(struct file *file)
-{
-	struct inode *inode = file_inode(file);
-
-	clear_inode_flag(inode, FI_PIN_FILE);
-}
-#else
-static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
-				sector_t *span)
-{
-	return -EOPNOTSUPP;
-}
-
-static void f2fs_swap_deactivate(struct file *file)
-{
-}
-#endif
-
 const struct address_space_operations f2fs_dblock_aops = {
 	.readpage	= f2fs_read_data_page,
 	.readpages	= f2fs_read_data_pages,
@@ -3274,8 +3154,6 @@ const struct address_space_operations f2fs_dblock_aops = {
 	.releasepage	= f2fs_release_page,
 	.direct_IO	= f2fs_direct_IO,
 	.bmap		= f2fs_bmap,
-	.swap_activate  = f2fs_swap_activate,
-	.swap_deactivate = f2fs_swap_deactivate,
 #ifdef CONFIG_MIGRATION
 	.migratepage    = f2fs_migrate_page,
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 85af112e868d..601ea20aadc9 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/uuid.h>
 #include <linux/file.h>
 #include <linux/nls.h>
+#include <linux/swap.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -3473,6 +3474,125 @@ long f2fs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 #endif
 
+#ifdef CONFIG_SWAP
+/* Copied from generic_swapfile_activate() to check any holes */
+static int check_swap_activate(struct file *swap_file, unsigned int max)
+{
+	struct inode *inode = swap_file->f_mapping->host;
+	unsigned blocks_per_page;
+	unsigned long page_no;
+	unsigned blkbits;
+	sector_t probe_block;
+	sector_t last_block;
+	sector_t lowest_block = -1;
+	sector_t highest_block = 0;
+
+	blkbits = inode->i_blkbits;
+	blocks_per_page = PAGE_SIZE >> blkbits;
+
+	/*
+	 * Map all the blocks into the extent list.  This code doesn't try
+	 * to be very smart.
+	 */
+	probe_block = 0;
+	page_no = 0;
+	last_block = i_size_read(inode) >> blkbits;
+	while ((probe_block + blocks_per_page) <= last_block && page_no < max) {
+		unsigned block_in_page;
+		sector_t first_block;
+
+		cond_resched();
+
+		first_block = bmap(inode, probe_block);
+		if (first_block == 0)
+			goto bad_bmap;
+
+		/*
+		 * It must be PAGE_SIZE aligned on-disk
+		 */
+		if (first_block & (blocks_per_page - 1)) {
+			probe_block++;
+			goto reprobe;
+		}
+
+		for (block_in_page = 1; block_in_page < blocks_per_page;
+					block_in_page++) {
+			sector_t block;
+
+			block = bmap(inode, probe_block + block_in_page);
+			if (block == 0)
+				goto bad_bmap;
+			if (block != first_block + block_in_page) {
+				/* Discontiguity */
+				probe_block++;
+				goto reprobe;
+			}
+		}
+
+		first_block >>= (PAGE_SHIFT - blkbits);
+		if (page_no) {	/* exclude the header page */
+			if (first_block < lowest_block)
+				lowest_block = first_block;
+			if (first_block > highest_block)
+				highest_block = first_block;
+		}
+
+		page_no++;
+		probe_block += blocks_per_page;
+reprobe:
+		continue;
+	}
+	return 0;
+
+bad_bmap:
+	pr_err("swapon: swapfile has holes\n");
+	return -EINVAL;
+}
+
+static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
+				sector_t *span)
+{
+	struct inode *inode = file_inode(file);
+	int ret;
+
+	if (!S_ISREG(inode->i_mode))
+		return -EINVAL;
+
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return -EROFS;
+
+	ret = f2fs_convert_inline_inode(inode);
+	if (ret)
+		return ret;
+
+	ret = check_swap_activate(file, sis->max);
+	if (ret)
+		return ret;
+
+	set_inode_flag(inode, FI_PIN_FILE);
+	f2fs_precache_extents(inode);
+	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
+	return 0;
+}
+
+static void f2fs_swap_deactivate(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	clear_inode_flag(inode, FI_PIN_FILE);
+}
+#else
+static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
+				sector_t *span)
+{
+	return -EOPNOTSUPP;
+}
+
+static void f2fs_swap_deactivate(struct file *file)
+{
+}
+#endif
+
 const struct file_operations f2fs_file_operations = {
 	.llseek		= f2fs_llseek,
 	.read_iter	= generic_file_read_iter,
@@ -3489,4 +3609,6 @@ const struct file_operations f2fs_file_operations = {
 #endif
 	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
+	.swap_activate  = f2fs_swap_activate,
+	.swap_deactivate = f2fs_swap_deactivate,
 };
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 8eb731d9be3e..013d6b5d9ca8 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -520,8 +520,6 @@ const struct address_space_operations nfs_file_aops = {
 	.launder_page = nfs_launder_page,
 	.is_dirty_writeback = nfs_check_dirty_writeback,
 	.error_remove_page = generic_error_remove_page,
-	.swap_activate = nfs_swap_activate,
-	.swap_deactivate = nfs_swap_deactivate,
 };
 
 /*
@@ -847,5 +845,7 @@ const struct file_operations nfs_file_operations = {
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
+	.swap_activate = nfs_swap_activate,
+	.swap_deactivate = nfs_swap_deactivate,
 };
 EXPORT_SYMBOL_GPL(nfs_file_operations);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3a688eb5c5ae..99f578a9ed90 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -631,17 +631,6 @@ xfs_vm_readpages(
 	return iomap_readpages(mapping, pages, nr_pages, &xfs_read_iomap_ops);
 }
 
-static int
-xfs_iomap_swapfile_activate(
-	struct swap_info_struct		*sis,
-	struct file			*swap_file,
-	sector_t			*span)
-{
-	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
-	return iomap_swapfile_activate(sis, swap_file, span,
-			&xfs_read_iomap_ops);
-}
-
 const struct address_space_operations xfs_address_space_operations = {
 	.readpage		= xfs_vm_readpage,
 	.readpages		= xfs_vm_readpages,
@@ -655,7 +644,6 @@ const struct address_space_operations xfs_address_space_operations = {
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
-	.swap_activate		= xfs_iomap_swapfile_activate,
 };
 
 const struct address_space_operations xfs_dax_aops = {
@@ -663,5 +651,4 @@ const struct address_space_operations xfs_dax_aops = {
 	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= noop_set_page_dirty,
 	.invalidatepage		= noop_invalidatepage,
-	.swap_activate		= xfs_iomap_swapfile_activate,
 };
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c93250108952..7c5e67907b0a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1294,6 +1294,17 @@ xfs_file_mmap(
 	return 0;
 }
 
+static int
+xfs_file_swap_activate(
+	struct swap_info_struct		*sis,
+	struct file			*swap_file,
+	sector_t			*span)
+{
+	sis->bdev = xfs_inode_buftarg(XFS_I(file_inode(swap_file)))->bt_bdev;
+	return iomap_swapfile_activate(sis, swap_file, span,
+			&xfs_read_iomap_ops);
+}
+
 const struct file_operations xfs_file_operations = {
 	.llseek		= xfs_file_llseek,
 	.read_iter	= xfs_file_read_iter,
@@ -1314,6 +1325,7 @@ const struct file_operations xfs_file_operations = {
 	.fallocate	= xfs_file_fallocate,
 	.fadvise	= xfs_file_fadvise,
 	.remap_file_range = xfs_file_remap_range,
+	.swap_activate	= xfs_file_swap_activate,
 };
 
 const struct file_operations xfs_dir_file_operations = {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index a7badbc3e680..80f6e35c52a1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -400,11 +400,6 @@ struct address_space_operations {
 					unsigned long);
 	void (*is_dirty_writeback) (struct page *, bool *, bool *);
 	int (*error_remove_page)(struct address_space *, struct page *);
-
-	/* swapfile support */
-	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
-				sector_t *span);
-	void (*swap_deactivate)(struct file *file);
 };
 
 extern const struct address_space_operations empty_aops;
@@ -1856,6 +1851,11 @@ struct file_operations {
 				   struct file *file_out, loff_t pos_out,
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
+
+	/* swapfile support */
+	int (*swap_activate)(struct swap_info_struct *sis, struct file *file,
+				sector_t *span);
+	void (*swap_deactivate)(struct file *file);
 } __randomize_layout;
 
 struct inode_operations {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bb3261d45b6a..d2de8d668708 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2293,11 +2293,10 @@ static void destroy_swap_extents(struct swap_info_struct *sis)
 
 	if (sis->flags & SWP_ACTIVATED) {
 		struct file *swap_file = sis->swap_file;
-		struct address_space *mapping = swap_file->f_mapping;
 
 		sis->flags &= ~SWP_ACTIVATED;
-		if (mapping->a_ops->swap_deactivate)
-			mapping->a_ops->swap_deactivate(swap_file);
+		if (swap_file->f_op->swap_deactivate)
+			swap_file->f_op->swap_deactivate(swap_file);
 	}
 }
 
@@ -2381,8 +2380,7 @@ EXPORT_SYMBOL_GPL(add_swap_extent);
 static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 {
 	struct file *swap_file = sis->swap_file;
-	struct address_space *mapping = swap_file->f_mapping;
-	struct inode *inode = mapping->host;
+	struct inode *inode = swap_file->f_mapping->host;
 	int ret;
 
 	if (S_ISBLK(inode->i_mode)) {
@@ -2391,8 +2389,8 @@ static int setup_swap_extents(struct swap_info_struct *sis, sector_t *span)
 		return ret;
 	}
 
-	if (mapping->a_ops->swap_activate) {
-		ret = mapping->a_ops->swap_activate(sis, swap_file, span);
+	if (swap_file->f_op->swap_activate) {
+		ret = swap_file->f_op->swap_activate(sis, swap_file, span);
 		if (ret >= 0)
 			sis->flags |= SWP_ACTIVATED;
 		if (!ret) {
-- 
2.21.0

