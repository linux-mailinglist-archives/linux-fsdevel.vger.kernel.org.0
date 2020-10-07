Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6A12855F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgJGBHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbgJGBHp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IriaecYx7OO0AtHHMf6obSiIrGUgAAlWP3UaNhWyD8k=;
        b=OwukHzUiJix52YDRe9jFsFHlKj3ogmDqg4TF4Qo/XnPrgPaZink2juPUw3b+6BnEPXnoJS
        1LDDEfViEAi3fEQKCcznDi+YP08DDBjYuQ9FPUGUKj0t7W4DlY1bFi+AUR3E9TN7xci6dv
        1RJlnR+RpIrdFmtkxBRtwl8LdNSwGX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-aoI3yRfYMMOsuqfW6u4AQA-1; Tue, 06 Oct 2020 21:07:37 -0400
X-MC-Unique: aoI3yRfYMMOsuqfW6u4AQA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 481C310BBEC4;
        Wed,  7 Oct 2020 01:07:36 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C1B25D9D2;
        Wed,  7 Oct 2020 01:07:32 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 08/14] mm: add struct address_space to releasepage() callback
Date:   Tue,  6 Oct 2020 21:05:57 -0400
Message-Id: <20201007010603.3452458-9-jglisse@redhat.com>
In-Reply-To: <20201007010603.3452458-1-jglisse@redhat.com>
References: <20201007010603.3452458-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This is part of patchset to remove dependency on struct page.mapping
field so that we can temporarily update it to point to a special
structure tracking temporary page state (note that original mapping
pointer is preserved and can still be accessed but at a cost).

Add struct address_space to releasepage() callback arguments.

Note that this patch does not make use of the new argument, nor does
it use a valid one at call site (by default this patch just use NULL
for new argument value).

Use following script (from root of linux kernel tree):

./that-script.sh that-semantic-patch.spatch

%<--------------------------------------------------------------------
#!/bin/sh
spatch_file=$1

echo PART1 ===========================================================

# P1 find callback functions name
spatch  --dir . --no-includes -D part1 --sp-file $spatch_file

echo PART2 ===========================================================

# P2 change callback function prototype
cat /tmp/unicorn-functions | sort | uniq | while read func ; do
    for file in $( git grep -l $func -- '*.[ch]' ) ; do
        echo $file
        spatch --no-includes --in-place -D part2 \
               -D fn=$func --sp-file $spatch_file $file
    done
done

echo PART 3 ==========================================================

# P3 find all function which call the callback
spatch --dir . --include-headers -D part3 --sp-file $spatch_file

echo PART 4===========================================================

# P4 change all funcitons which call the callback
cat /tmp/unicorn-files | sort | uniq | while read file ; do
    echo $file
    spatch --no-includes --in-place -D part4 \
           --sp-file $spatch_file $file
done
-------------------------------------------------------------------->%

With the following semantic patch:

%<--------------------------------------------------------------------
virtual part1, part2, part3, part4

// ----------------------------------------------------------------------------
// Part 1 is grepping all function that are use as callback for releasepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .releasepage = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (releasepage callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1, I2;
type T1, T2;
@@
int fn(
+struct address_space *__mapping,
T1 I1, T2 I2) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1, I2;
type T1, T2;
@@
int fn(
+struct address_space *__mapping,
T1 I1, T2 I2);

@p2r3 depends on part2@
identifier virtual.fn;
expression E1, E2;
@@
fn(
+MAPPING_NULL,
E1, E2)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for releasepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part3@
@@
file=open('/tmp/unicorn-files', 'w')
file.write("./include/linux/pagemap.h\n")
file.write("./include/linux/mm.h\n")
file.write("./include/linux/fs.h\n")
file.write("./mm/readahead.c\n")
file.write("./mm/filemap.c\n")
file.close()

@p3r1 depends on part3 exists@
expression E1, E2, E3;
identifier FN;
position P;
@@
FN@P(...) {...
(
E1.a_ops->releasepage(E2, E3)
|
E1->a_ops->releasepage(E2, E3)
)
...}

@script:python p3r2 depends on p3r1@
P << p3r1.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

// -------------------------------------------------------------------
// Part 4 generic modification
@p4r1 depends on part4@
@@
struct address_space_operations { ... int (*releasepage)(
+struct address_space *,
struct page *, ...); ... };

@p4r2 depends on part4@
expression E1, E2, E3;
@@
E1.a_ops->releasepage(
+MAPPING_NULL,
E2, E3)

@p4r3 depends on part4@
expression E1, E2, E3;
@@
E1->a_ops->releasepage(
+MAPPING_NULL,
E2, E3)
-------------------------------------------------------------------->%

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
---
 fs/9p/vfs_addr.c       | 3 ++-
 fs/afs/dir.c           | 6 ++++--
 fs/afs/file.c          | 6 ++++--
 fs/block_dev.c         | 3 ++-
 fs/btrfs/disk-io.c     | 5 +++--
 fs/btrfs/inode.c       | 5 +++--
 fs/ceph/addr.c         | 3 ++-
 fs/cifs/file.c         | 3 ++-
 fs/erofs/super.c       | 5 +++--
 fs/ext4/inode.c        | 3 ++-
 fs/f2fs/data.c         | 3 ++-
 fs/f2fs/f2fs.h         | 3 ++-
 fs/gfs2/aops.c         | 3 ++-
 fs/gfs2/inode.h        | 3 ++-
 fs/hfs/inode.c         | 3 ++-
 fs/hfsplus/inode.c     | 3 ++-
 fs/iomap/buffered-io.c | 3 ++-
 fs/jfs/jfs_metapage.c  | 5 +++--
 fs/nfs/file.c          | 3 ++-
 fs/ocfs2/aops.c        | 3 ++-
 fs/orangefs/inode.c    | 3 ++-
 fs/reiserfs/inode.c    | 3 ++-
 fs/ubifs/file.c        | 3 ++-
 include/linux/fs.h     | 2 +-
 include/linux/iomap.h  | 3 ++-
 mm/filemap.c           | 3 ++-
 26 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 357f2e5049c48..0ae4f31b3d7f2 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -123,7 +123,8 @@ static int v9fs_vfs_readpages(struct file *filp, struct address_space *mapping,
  * Returns 1 if the page can be released, false otherwise.
  */
 
-static int v9fs_release_page(struct page *page, gfp_t gfp)
+static int v9fs_release_page(struct address_space *__mapping,
+			     struct page *page, gfp_t gfp)
 {
 	if (PagePrivate(page))
 		return 0;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index d77c13c213d2d..c27524f35281e 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -40,7 +40,8 @@ static int afs_symlink(struct inode *dir, struct dentry *dentry,
 static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		      struct inode *new_dir, struct dentry *new_dentry,
 		      unsigned int flags);
-static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
+static int afs_dir_releasepage(struct address_space *__mapping,
+			       struct page *page, gfp_t gfp_flags);
 static void afs_dir_invalidatepage(struct address_space *__mapping,
 				   struct page *page, unsigned int offset,
 				   unsigned int length);
@@ -1971,7 +1972,8 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
  * Release a directory page and clean up its private state if it's not busy
  * - return true if the page can now be released, false if not
  */
-static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
+static int afs_dir_releasepage(struct address_space *__mapping,
+			       struct page *page, gfp_t gfp_flags)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
 
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 43edfa65c7ac7..496595240f12b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -22,7 +22,8 @@ static int afs_readpage(struct file *file, struct address_space *__mapping,
 static void afs_invalidatepage(struct address_space *__mapping,
 			       struct page *page, unsigned int offset,
 			       unsigned int length);
-static int afs_releasepage(struct page *page, gfp_t gfp_flags);
+static int afs_releasepage(struct address_space *__mapping, struct page *page,
+			   gfp_t gfp_flags);
 
 static int afs_readpages(struct file *filp, struct address_space *mapping,
 			 struct list_head *pages, unsigned nr_pages);
@@ -645,7 +646,8 @@ static void afs_invalidatepage(struct address_space *__mapping,
  * release a page and clean up its private state if it's not busy
  * - return true if the page can now be released, false if not
  */
-static int afs_releasepage(struct page *page, gfp_t gfp_flags)
+static int afs_releasepage(struct address_space *__mapping, struct page *page,
+			   gfp_t gfp_flags)
 {
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
 	unsigned long priv;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b50c93932dfdf..e4cb73598e3c1 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1935,7 +1935,8 @@ EXPORT_SYMBOL_GPL(blkdev_read_iter);
  * Try to release a page associated with block device when the system
  * is under memory pressure.
  */
-static int blkdev_releasepage(struct page *page, gfp_t wait)
+static int blkdev_releasepage(struct address_space *__mapping,
+			      struct page *page, gfp_t wait)
 {
 	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d57d0a6dd2621..c9d640cfa51cb 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -957,7 +957,8 @@ static int btree_readpage(struct file *file, struct address_space *__mapping,
 	return extent_read_full_page(page, btree_get_extent, 0);
 }
 
-static int btree_releasepage(struct page *page, gfp_t gfp_flags)
+static int btree_releasepage(struct address_space *__mapping,
+			     struct page *page, gfp_t gfp_flags)
 {
 	if (PageWriteback(page) || PageDirty(page))
 		return 0;
@@ -972,7 +973,7 @@ static void btree_invalidatepage(struct address_space *__mapping,
 	struct extent_io_tree *tree;
 	tree = &BTRFS_I(page->mapping->host)->io_tree;
 	extent_invalidatepage(tree, page, offset);
-	btree_releasepage(page, GFP_NOFS);
+	btree_releasepage(MAPPING_NULL, page, GFP_NOFS);
 	if (PagePrivate(page)) {
 		btrfs_warn(BTRFS_I(page->mapping->host)->root->fs_info,
 			   "page private not zero on page %llu",
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 062886fc0e750..95bf86a871ffb 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8057,7 +8057,8 @@ static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
 	return ret;
 }
 
-static int btrfs_releasepage(struct page *page, gfp_t gfp_flags)
+static int btrfs_releasepage(struct address_space *__mapping,
+			     struct page *page, gfp_t gfp_flags)
 {
 	if (PageWriteback(page) || PageDirty(page))
 		return 0;
@@ -8116,7 +8117,7 @@ static void btrfs_invalidatepage(struct address_space *__mapping,
 
 	tree = &BTRFS_I(inode)->io_tree;
 	if (offset) {
-		btrfs_releasepage(page, GFP_NOFS);
+		btrfs_releasepage(MAPPING_NULL, page, GFP_NOFS);
 		return;
 	}
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index ed555b0d48bfa..f6739a7b9ad35 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -172,7 +172,8 @@ static void ceph_invalidatepage(struct address_space *__mapping,
 	ClearPagePrivate(page);
 }
 
-static int ceph_releasepage(struct page *page, gfp_t g)
+static int ceph_releasepage(struct address_space *__mapping,
+			    struct page *page, gfp_t g)
 {
 	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
 	     page, page->index, PageDirty(page) ? "" : "not ");
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 84cb64821036c..38d79a9eafa76 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4694,7 +4694,8 @@ static int cifs_write_begin(struct file *file, struct address_space *mapping,
 	return rc;
 }
 
-static int cifs_release_page(struct page *page, gfp_t gfp)
+static int cifs_release_page(struct address_space *__mapping,
+			     struct page *page, gfp_t gfp)
 {
 	if (PagePrivate(page))
 		return 0;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3c0e10d1b4e19..d4082102c180f 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -281,7 +281,8 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 #ifdef CONFIG_EROFS_FS_ZIP
 static const struct address_space_operations managed_cache_aops;
 
-static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
+static int erofs_managed_cache_releasepage(struct address_space *__mapping,
+					   struct page *page, gfp_t gfp_mask)
 {
 	int ret = 1;	/* 0 - busy */
 	struct address_space *const mapping = page->mapping;
@@ -308,7 +309,7 @@ static void erofs_managed_cache_invalidatepage(struct address_space *__mapping,
 	DBG_BUGON(stop > PAGE_SIZE || stop < length);
 
 	if (offset == 0 && stop == PAGE_SIZE)
-		while (!erofs_managed_cache_releasepage(page, GFP_NOFS))
+		while (!erofs_managed_cache_releasepage(MAPPING_NULL, page, GFP_NOFS))
 			cond_resched();
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 27b8d57349d88..2fd0c674136cc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3283,7 +3283,8 @@ static void ext4_journalled_invalidatepage(struct address_space *__mapping,
 	WARN_ON(__ext4_journalled_invalidatepage(page, offset, length) < 0);
 }
 
-static int ext4_releasepage(struct page *page, gfp_t wait)
+static int ext4_releasepage(struct address_space *__mapping,
+		            struct page *page, gfp_t wait)
 {
 	journal_t *journal = EXT4_JOURNAL(page->mapping->host);
 
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b13e430e62435..c6444ffd7d6e9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3720,7 +3720,8 @@ void f2fs_invalidate_page(struct address_space *__mapping, struct page *page,
 	f2fs_clear_page_private(page);
 }
 
-int f2fs_release_page(struct page *page, gfp_t wait)
+int f2fs_release_page(struct address_space *__mapping, struct page *page,
+		      gfp_t wait)
 {
 	/* If this is dirty page, keep PagePrivate */
 	if (PageDirty(page))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index eb6f9aa4007c6..6bb30d2192842 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3472,7 +3472,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 void f2fs_invalidate_page(struct address_space *__mapping, struct page *page,
 			  unsigned int offset,
 			  unsigned int length);
-int f2fs_release_page(struct page *page, gfp_t wait);
+int f2fs_release_page(struct address_space *__mapping, struct page *page,
+		      gfp_t wait);
 #ifdef CONFIG_MIGRATION
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
 			struct page *page, enum migrate_mode mode);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 0c6d2e99a5243..77efc65a412ec 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -723,7 +723,8 @@ static void gfs2_invalidatepage(struct address_space *__mapping,
  * Returns: 1 if the page was put or else 0
  */
 
-int gfs2_releasepage(struct page *page, gfp_t gfp_mask)
+int gfs2_releasepage(struct address_space *__mapping, struct page *page,
+		     gfp_t gfp_mask)
 {
 	struct address_space *mapping = page->mapping;
 	struct gfs2_sbd *sdp = gfs2_mapping2sbd(mapping);
diff --git a/fs/gfs2/inode.h b/fs/gfs2/inode.h
index b52ecf4ffe634..f1e878353cebb 100644
--- a/fs/gfs2/inode.h
+++ b/fs/gfs2/inode.h
@@ -12,7 +12,8 @@
 #include <linux/mm.h>
 #include "util.h"
 
-extern int gfs2_releasepage(struct page *page, gfp_t gfp_mask);
+extern int gfs2_releasepage(struct address_space *__mapping,
+			    struct page *page, gfp_t gfp_mask);
 extern int gfs2_internal_read(struct gfs2_inode *ip,
 			      char *buf, loff_t *pos, unsigned size);
 extern void gfs2_set_aops(struct inode *inode);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 101cc5e10524f..8986c8a0a23b2 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -72,7 +72,8 @@ static sector_t hfs_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, hfs_get_block);
 }
 
-static int hfs_releasepage(struct page *page, gfp_t mask)
+static int hfs_releasepage(struct address_space *__mapping, struct page *page,
+			   gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 1654ee206e7e5..0534280978457 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -66,7 +66,8 @@ static sector_t hfsplus_bmap(struct address_space *mapping, sector_t block)
 	return generic_block_bmap(mapping, block, hfsplus_get_block);
 }
 
-static int hfsplus_releasepage(struct page *page, gfp_t mask)
+static int hfsplus_releasepage(struct address_space *__mapping,
+			       struct page *page, gfp_t mask)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index b94729b7088a7..091f6656f3d6b 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -476,7 +476,8 @@ iomap_is_partially_uptodate(struct page *page, unsigned long from,
 EXPORT_SYMBOL_GPL(iomap_is_partially_uptodate);
 
 int
-iomap_releasepage(struct page *page, gfp_t gfp_mask)
+iomap_releasepage(struct address_space *__mapping, struct page *page,
+		  gfp_t gfp_mask)
 {
 	trace_iomap_releasepage(page->mapping->host, page_offset(page),
 			PAGE_SIZE);
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 5be751fa11e0b..435b55faca4ff 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -528,7 +528,8 @@ static int metapage_readpage(struct file *fp, struct address_space *__mapping,
 	return -EIO;
 }
 
-static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
+static int metapage_releasepage(struct address_space *__mapping,
+				struct page *page, gfp_t gfp_mask)
 {
 	struct metapage *mp;
 	int ret = 1;
@@ -565,7 +566,7 @@ static void metapage_invalidatepage(struct address_space *__mapping,
 
 	BUG_ON(PageWriteback(page));
 
-	metapage_releasepage(page, 0);
+	metapage_releasepage(MAPPING_NULL, page, 0);
 }
 
 const struct address_space_operations jfs_metapage_aops = {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 381288d686386..ddfe95d3da057 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -426,7 +426,8 @@ static void nfs_invalidate_page(struct address_space *__mapping,
  * - Caller holds page lock
  * - Return true (may release page) or false (may not)
  */
-static int nfs_release_page(struct page *page, gfp_t gfp)
+static int nfs_release_page(struct address_space *__mapping,
+			    struct page *page, gfp_t gfp)
 {
 	dfprintk(PAGECACHE, "NFS: release_page(%p)\n", page);
 
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index c597a104e0af4..fdd3c6a55d817 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -501,7 +501,8 @@ static sector_t ocfs2_bmap(struct address_space *mapping, sector_t block)
 	return status;
 }
 
-static int ocfs2_releasepage(struct page *page, gfp_t wait)
+static int ocfs2_releasepage(struct address_space *__mapping,
+			     struct page *page, gfp_t wait)
 {
 	if (!page_has_buffers(page))
 		return 0;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 6ea0ec45754dc..1534dc2df6e5c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -520,7 +520,8 @@ static void orangefs_invalidatepage(struct address_space *__mapping,
 	orangefs_launder_page(page);
 }
 
-static int orangefs_releasepage(struct page *page, gfp_t foo)
+static int orangefs_releasepage(struct address_space *__mapping,
+				struct page *page, gfp_t foo)
 {
 	return !PagePrivate(page);
 }
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index d35c03a7d3f5b..efd149cc897a9 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3230,7 +3230,8 @@ static int reiserfs_set_page_dirty(struct address_space *__mapping,
  * even in -o notail mode, we can't be sure an old mount without -o notail
  * didn't create files with tails.
  */
-static int reiserfs_releasepage(struct page *page, gfp_t unused_gfp_flags)
+static int reiserfs_releasepage(struct address_space *__mapping,
+				struct page *page, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = page->mapping->host;
 	struct reiserfs_journal *j = SB_JOURNAL(inode->i_sb);
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 11ed42c4859f0..7e00370ca3ed1 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1486,7 +1486,8 @@ static int ubifs_migrate_page(struct address_space *mapping,
 }
 #endif
 
-static int ubifs_releasepage(struct page *page, gfp_t unused_gfp_flags)
+static int ubifs_releasepage(struct address_space *__mapping,
+			     struct page *page, gfp_t unused_gfp_flags)
 {
 	struct inode *inode = page->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b471e82546001..989e505de9182 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -399,7 +399,7 @@ struct address_space_operations {
 	sector_t (*bmap)(struct address_space *, sector_t);
 	void (*invalidatepage) (struct address_space *, struct page *,
 				unsigned int, unsigned int);
-	int (*releasepage) (struct page *, gfp_t);
+	int (*releasepage) (struct address_space *, struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
 	/*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 45f23d2268365..cb4b207974756 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -159,7 +159,8 @@ void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
 int iomap_set_page_dirty(struct address_space *__mapping, struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
-int iomap_releasepage(struct page *page, gfp_t gfp_mask);
+int iomap_releasepage(struct address_space *__mapping, struct page *page,
+		      gfp_t gfp_mask);
 void iomap_invalidatepage(struct address_space *__mapping, struct page *page,
 			  unsigned int offset,
 			  unsigned int len);
diff --git a/mm/filemap.c b/mm/filemap.c
index b67a253e5e6c7..eccd5d0554851 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3694,7 +3694,8 @@ int try_to_release_page(struct page *page, gfp_t gfp_mask)
 		return 0;
 
 	if (mapping && mapping->a_ops->releasepage)
-		return mapping->a_ops->releasepage(page, gfp_mask);
+		return mapping->a_ops->releasepage(MAPPING_NULL, page,
+						   gfp_mask);
 	return try_to_free_buffers(page);
 }
 
-- 
2.26.2

