Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613FF2855FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgJGBIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbgJGBHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7N2mjBwp8HLhjDivzCXg+PKFLbZWVE6k56VjjRdZtmo=;
        b=WQaRrIAikef4SOAUljwXv/rKS6bCmTYdig3QpJtDlGNRXkf6rVbUhsh7huDAM9lfL6jpnH
        S/4bBE+iOHcCLLSQ7DgrVrm7ypuJQQx6qeC+NMYjWwuv7cS0GhwN8p0XmBFIVrEQtaMjUK
        HAPZH852nA45vOhANanvnM0S2THpSNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-yeGEYydnMLCukqEiYdasag-1; Tue, 06 Oct 2020 21:07:33 -0400
X-MC-Unique: yeGEYydnMLCukqEiYdasag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1547F10BBEC4;
        Wed,  7 Oct 2020 01:07:32 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2FBB5D9D2;
        Wed,  7 Oct 2020 01:07:28 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 07/14] mm: add struct address_space to invalidatepage() callback
Date:   Tue,  6 Oct 2020 21:05:56 -0400
Message-Id: <20201007010603.3452458-8-jglisse@redhat.com>
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

Add struct address_space to invalidatepage() callback arguments.

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
// Part 1 is grepping all function that are use as callback for invalidatepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .invalidatepage = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (invalidatepage callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
void fn(
+struct address_space *__mapping,
T1 I1, T2 I2, T3 I3) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1, I2, I3;
type T1, T2, T3;
@@
void fn(
+struct address_space *__mapping,
T1 I1, T2 I2, T3 I3);

@p2r3 depends on part2@
identifier virtual.fn;
expression E1, E2, E3;
@@
fn(
+MAPPING_NULL,
E1, E2, E3)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for invalidatepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part3@
@@
file=open('/tmp/unicorn-files', 'w')
file.write("./include/linux/pagemap.h\n")
file.write("./include/linux/mm.h\n")
file.write("./include/linux/fs.h\n")
file.write("./mm/readahead.c\n")
file.write("./mm/truncate.c\n")
file.write("./mm/filemap.c\n")
file.close()

@p3r1 depends on part3 exists@
expression E1, E2, E3, E4;
identifier FN;
position P;
@@
FN@P(...) {...
(
E1.a_ops->invalidatepage(E2, E3, E4)
|
E1->a_ops->invalidatepage(E2, E3, E4)
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
struct address_space_operations { ... void (*invalidatepage)(
+struct address_space *,
struct page *, ...); ... };

@p4r2 depends on part4@
expression E1, E2, E3, E4;
@@
E1.a_ops->invalidatepage(
+MAPPING_NULL,
E2, E3, E4)

@p4r3 depends on part4@
expression E1, E2, E3, E4;
@@
E1->a_ops->invalidatepage(
+MAPPING_NULL,
E2, E3, E4)

@p4r4 depends on part4 exists@
identifier I1, FN;
expression E1;
@@
FN (...) {...
void (*I1)(struct page *, unsigned int, unsigned int);
...
I1 = E1->a_ops->invalidatepage;
...}

@p4r5 depends on p4r4 exists@
expression E1, E2, E3;
identifier I1, p4r4.FN;
@@
FN(...) {...
void (*I1)(
+struct address_space *,
struct page *, unsigned int, unsigned int);
...
 (*I1)(
+MAPPING_NULL,
E1, E2, E3);
...}

@p4r6 depends on part4@
expression E1, E2, E3;
@@
{...
-void (*invalidatepage)(struct page *, unsigned int, unsigned int);
+void (*invalidatepage)(struct address_space *, struct page *, unsigned int, unsigned int);
...
 (*invalidatepage)(
+MAPPING_NULL,
E1, E2, E3);
...}
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
 fs/9p/vfs_addr.c            |  3 ++-
 fs/afs/dir.c                |  6 ++++--
 fs/afs/file.c               |  6 ++++--
 fs/btrfs/disk-io.c          |  3 ++-
 fs/btrfs/extent_io.c        |  3 ++-
 fs/btrfs/inode.c            |  3 ++-
 fs/buffer.c                 |  3 ++-
 fs/ceph/addr.c              | 12 ++++++++----
 fs/cifs/file.c              |  3 ++-
 fs/erofs/super.c            |  3 ++-
 fs/ext4/inode.c             | 17 +++++++++++------
 fs/f2fs/data.c              |  3 ++-
 fs/f2fs/f2fs.h              |  5 +++--
 fs/gfs2/aops.c              |  6 ++++--
 fs/iomap/buffered-io.c      |  3 ++-
 fs/jfs/jfs_metapage.c       |  3 ++-
 fs/libfs.c                  |  5 +++--
 fs/nfs/file.c               |  3 ++-
 fs/ntfs/aops.c              |  2 +-
 fs/orangefs/inode.c         |  7 ++++---
 fs/reiserfs/inode.c         |  3 ++-
 fs/ubifs/file.c             |  3 ++-
 fs/xfs/xfs_aops.c           |  2 +-
 include/linux/buffer_head.h |  3 ++-
 include/linux/fs.h          |  8 +++++---
 include/linux/iomap.h       |  5 +++--
 mm/truncate.c               |  5 +++--
 27 files changed, 82 insertions(+), 46 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index c7a8037df9fcf..357f2e5049c48 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -137,7 +137,8 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
  * @offset: offset in the page
  */
 
-static void v9fs_invalidate_page(struct page *page, unsigned int offset,
+static void v9fs_invalidate_page(struct address_space *__mapping,
+				 struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	/*
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index ebcf074bcaaa2..d77c13c213d2d 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -41,7 +41,8 @@ static int afs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		      struct inode *new_dir, struct dentry *new_dentry,
 		      unsigned int flags);
 static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
-static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
+static void afs_dir_invalidatepage(struct address_space *__mapping,
+				   struct page *page, unsigned int offset,
 				   unsigned int length);
 
 static int afs_dir_set_page_dirty(struct address_space *__mapping,
@@ -1990,7 +1991,8 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags)
  * - release a page and clean up its private data if offset is 0 (indicating
  *   the entire page)
  */
-static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
+static void afs_dir_invalidatepage(struct address_space *__mapping,
+				   struct page *page, unsigned int offset,
 				   unsigned int length)
 {
 	struct afs_vnode *dvnode = AFS_FS_I(page->mapping->host);
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 908f9e3196251..43edfa65c7ac7 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -19,7 +19,8 @@
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 static int afs_readpage(struct file *file, struct address_space *__mapping,
 			struct page *page);
-static void afs_invalidatepage(struct page *page, unsigned int offset,
+static void afs_invalidatepage(struct address_space *__mapping,
+			       struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 
@@ -607,7 +608,8 @@ static int afs_readpages(struct file *file, struct address_space *mapping,
  * - release a page and clean up its private data if offset is 0 (indicating
  *   the entire page)
  */
-static void afs_invalidatepage(struct page *page, unsigned int offset,
+static void afs_invalidatepage(struct address_space *__mapping,
+			       struct page *page, unsigned int offset,
 			       unsigned int length)
 {
 	struct afs_vnode *vnode = AFS_FS_I(page->mapping->host);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7f548f9f5ace1..d57d0a6dd2621 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -965,7 +965,8 @@ static int btree_releasepage(struct page *page, gfp_t gfp_flags)
 	return try_release_extent_buffer(page);
 }
 
-static void btree_invalidatepage(struct page *page, unsigned int offset,
+static void btree_invalidatepage(struct address_space *__mapping,
+				 struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct extent_io_tree *tree;
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 02569dffe8e14..9877f1222b318 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3632,7 +3632,8 @@ static int __extent_writepage(struct page *page, struct writeback_control *wbc,
 	pg_offset = offset_in_page(i_size);
 	if (page->index > end_index ||
 	   (page->index == end_index && !pg_offset)) {
-		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
+		page->mapping->a_ops->invalidatepage(MAPPING_NULL, page, 0,
+						     PAGE_SIZE);
 		unlock_page(page);
 		return 0;
 	}
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9f35648ba06d8..062886fc0e750 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8091,7 +8091,8 @@ static int btrfs_migratepage(struct address_space *mapping,
 }
 #endif
 
-static void btrfs_invalidatepage(struct page *page, unsigned int offset,
+static void btrfs_invalidatepage(struct address_space *__mapping,
+				 struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
diff --git a/fs/buffer.c b/fs/buffer.c
index 6fb6cf497feb8..1f0f72b76fc2a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1499,7 +1499,8 @@ static void discard_buffer(struct buffer_head * bh)
  * point.  Because the caller is about to free (and possibly reuse) those
  * blocks on-disk.
  */
-void block_invalidatepage(struct page *page, unsigned int offset,
+void block_invalidatepage(struct address_space *__mapping, struct page *page,
+			  unsigned int offset,
 			  unsigned int length)
 {
 	struct buffer_head *head, *bh, *next;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b2b2c8f8118e4..ed555b0d48bfa 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -140,7 +140,8 @@ static int ceph_set_page_dirty(struct address_space *__mapping,
  * dirty page counters appropriately.  Only called if there is private
  * data on the page.
  */
-static void ceph_invalidatepage(struct page *page, unsigned int offset,
+static void ceph_invalidatepage(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
 				unsigned int length)
 {
 	struct inode *inode;
@@ -708,7 +709,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	/* is this a partial page at end of file? */
 	if (page_off >= ceph_wbc.i_size) {
 		dout("%p page eof %llu\n", page, ceph_wbc.i_size);
-		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
+		page->mapping->a_ops->invalidatepage(MAPPING_NULL, page, 0,
+						     PAGE_SIZE);
 		return 0;
 	}
 
@@ -1004,8 +1006,10 @@ static int ceph_writepages_start(struct address_space *mapping,
 				if ((ceph_wbc.size_stable ||
 				    page_offset(page) >= i_size_read(inode)) &&
 				    clear_page_dirty_for_io(page))
-					mapping->a_ops->invalidatepage(page,
-								0, PAGE_SIZE);
+					mapping->a_ops->invalidatepage(MAPPING_NULL,
+								       page,
+								       0,
+								       PAGE_SIZE);
 				unlock_page(page);
 				continue;
 			}
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ca7df2a2dde0f..84cb64821036c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4702,7 +4702,8 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
 	return cifs_fscache_release_page(page, gfp);
 }
 
-static void cifs_invalidate_page(struct page *page, unsigned int offset,
+static void cifs_invalidate_page(struct address_space *__mapping,
+				 struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(page->mapping->host);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index ddaa516c008af..3c0e10d1b4e19 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -295,7 +295,8 @@ static int erofs_managed_cache_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
-static void erofs_managed_cache_invalidatepage(struct page *page,
+static void erofs_managed_cache_invalidatepage(struct address_space *__mapping,
+					       struct page *page,
 					       unsigned int offset,
 					       unsigned int length)
 {
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 528eec0b02bf2..27b8d57349d88 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -135,7 +135,8 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 						   new_size);
 }
 
-static void ext4_invalidatepage(struct page *page, unsigned int offset,
+static void ext4_invalidatepage(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
 				unsigned int length);
 static int __ext4_journalled_writepage(struct page *page, unsigned int len);
 static int ext4_bh_delay_or_unwritten(handle_t *handle, struct buffer_head *bh);
@@ -1572,7 +1573,8 @@ static void mpage_release_unused_pages(struct mpage_da_data *mpd,
 			if (invalidate) {
 				if (page_mapped(page))
 					clear_page_dirty_for_io(page);
-				block_invalidatepage(page, 0, PAGE_SIZE);
+				block_invalidatepage(MAPPING_NULL, page, 0,
+						     PAGE_SIZE);
 				ClearPageUptodate(page);
 			}
 			unlock_page(page);
@@ -1981,7 +1983,8 @@ static int ext4_writepage(struct address_space *__mapping, struct page *page,
 	bool keep_towrite = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
-		inode->i_mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
+		inode->i_mapping->a_ops->invalidatepage(MAPPING_NULL, page, 0,
+							PAGE_SIZE);
 		unlock_page(page);
 		return -EIO;
 	}
@@ -3242,7 +3245,8 @@ static void ext4_readahead(struct readahead_control *rac)
 	ext4_mpage_readpages(inode, rac, NULL);
 }
 
-static void ext4_invalidatepage(struct page *page, unsigned int offset,
+static void ext4_invalidatepage(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
 				unsigned int length)
 {
 	trace_ext4_invalidatepage(page, offset, length);
@@ -3250,7 +3254,7 @@ static void ext4_invalidatepage(struct page *page, unsigned int offset,
 	/* No journalling happens on data buffers when this function is used */
 	WARN_ON(page_has_buffers(page) && buffer_jbd(page_buffers(page)));
 
-	block_invalidatepage(page, offset, length);
+	block_invalidatepage(MAPPING_NULL, page, offset, length);
 }
 
 static int __ext4_journalled_invalidatepage(struct page *page,
@@ -3271,7 +3275,8 @@ static int __ext4_journalled_invalidatepage(struct page *page,
 }
 
 /* Wrapper for aops... */
-static void ext4_journalled_invalidatepage(struct page *page,
+static void ext4_journalled_invalidatepage(struct address_space *__mapping,
+					   struct page *page,
 					   unsigned int offset,
 					   unsigned int length)
 {
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 12350175133aa..b13e430e62435 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3690,7 +3690,8 @@ static ssize_t f2fs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	return err;
 }
 
-void f2fs_invalidate_page(struct page *page, unsigned int offset,
+void f2fs_invalidate_page(struct address_space *__mapping, struct page *page,
+							unsigned int offset,
 							unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d9e52a7f3702f..eb6f9aa4007c6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3469,8 +3469,9 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 				struct writeback_control *wbc,
 				enum iostat_type io_type,
 				int compr_blocks);
-void f2fs_invalidate_page(struct page *page, unsigned int offset,
-			unsigned int length);
+void f2fs_invalidate_page(struct address_space *__mapping, struct page *page,
+			  unsigned int offset,
+			  unsigned int length);
 int f2fs_release_page(struct page *page, gfp_t wait);
 #ifdef CONFIG_MIGRATION
 int f2fs_migrate_page(struct address_space *mapping, struct page *newpage,
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 8911771f95c5c..0c6d2e99a5243 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -103,7 +103,8 @@ static int gfs2_writepage(struct address_space *__mapping, struct page *page,
 	/* Is the page fully outside i_size? (truncate in progress) */
 	offset = i_size & (PAGE_SIZE-1);
 	if (page->index > end_index || (page->index == end_index && !offset)) {
-		page->mapping->a_ops->invalidatepage(page, 0, PAGE_SIZE);
+		page->mapping->a_ops->invalidatepage(MAPPING_NULL, page, 0,
+						     PAGE_SIZE);
 		goto out;
 	}
 
@@ -680,7 +681,8 @@ static void gfs2_discard(struct gfs2_sbd *sdp, struct buffer_head *bh)
 	unlock_buffer(bh);
 }
 
-static void gfs2_invalidatepage(struct page *page, unsigned int offset,
+static void gfs2_invalidatepage(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
 				unsigned int length)
 {
 	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 26f7fe7c80adc..b94729b7088a7 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -494,7 +494,8 @@ iomap_releasepage(struct page *page, gfp_t gfp_mask)
 EXPORT_SYMBOL_GPL(iomap_releasepage);
 
 void
-iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
+iomap_invalidatepage(struct address_space *__mapping, struct page *page,
+		     unsigned int offset, unsigned int len)
 {
 	trace_iomap_invalidatepage(page->mapping->host, offset, len);
 
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a6e48e733d3a6..5be751fa11e0b 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -557,7 +557,8 @@ static int metapage_releasepage(struct page *page, gfp_t gfp_mask)
 	return ret;
 }
 
-static void metapage_invalidatepage(struct page *page, unsigned int offset,
+static void metapage_invalidatepage(struct address_space *__mapping,
+				    struct page *page, unsigned int offset,
 				    unsigned int length)
 {
 	BUG_ON(offset || length < PAGE_SIZE);
diff --git a/fs/libfs.c b/fs/libfs.c
index 899feec2eb683..f4b6db18e62b5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1172,8 +1172,9 @@ int noop_set_page_dirty(struct address_space *__mapping, struct page *page)
 }
 EXPORT_SYMBOL_GPL(noop_set_page_dirty);
 
-void noop_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int length)
+void noop_invalidatepage(struct address_space *__mapping, struct page *page,
+			 unsigned int offset,
+			 unsigned int length)
 {
 	/*
 	 * There is no page cache to invalidate in the dax case, however
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 02e2112d77f86..381288d686386 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -405,7 +405,8 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
  * - Called if either PG_private or PG_fscache is set on the page
  * - Caller holds page lock
  */
-static void nfs_invalidate_page(struct page *page, unsigned int offset,
+static void nfs_invalidate_page(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
 				unsigned int length)
 {
 	dfprintk(PAGECACHE, "NFS: invalidate_page(%p, %u, %u)\n",
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 3d3a6b6bc6717..a9fe68e4c89b5 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1356,7 +1356,7 @@ static int ntfs_writepage(struct address_space *__mapping, struct page *page,
 		 * The page may have dirty, unmapped buffers.  Make them
 		 * freeable here, so the page does not leak.
 		 */
-		block_invalidatepage(page, 0, PAGE_SIZE);
+		block_invalidatepage(MAPPING_NULL, page, 0, PAGE_SIZE);
 		unlock_page(page);
 		ntfs_debug("Write outside i_size - truncated?");
 		return 0;
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index f463cfb435292..6ea0ec45754dc 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -448,9 +448,10 @@ static int orangefs_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-static void orangefs_invalidatepage(struct page *page,
-				 unsigned int offset,
-				 unsigned int length)
+static void orangefs_invalidatepage(struct address_space *__mapping,
+				    struct page *page,
+				    unsigned int offset,
+				    unsigned int length)
 {
 	struct orangefs_write_range *wr;
 	wr = (struct orangefs_write_range *)page_private(page);
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 9ef4365c07fdd..d35c03a7d3f5b 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3156,7 +3156,8 @@ static int invalidatepage_can_drop(struct inode *inode, struct buffer_head *bh)
 }
 
 /* clm -- taken from fs/buffer.c:block_invalidate_page */
-static void reiserfs_invalidatepage(struct page *page, unsigned int offset,
+static void reiserfs_invalidatepage(struct address_space *__mapping,
+				    struct page *page, unsigned int offset,
 				    unsigned int length)
 {
 	struct buffer_head *head, *bh, *next;
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 5af8c311d38f0..11ed42c4859f0 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1288,7 +1288,8 @@ int ubifs_setattr(struct dentry *dentry, struct iattr *attr)
 	return err;
 }
 
-static void ubifs_invalidatepage(struct page *page, unsigned int offset,
+static void ubifs_invalidatepage(struct address_space *__mapping,
+				 struct page *page, unsigned int offset,
 				 unsigned int length)
 {
 	struct inode *inode = page->mapping->host;
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 6827f6226499a..24cd33c5f3466 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,7 +548,7 @@ xfs_discard_page(
 	if (error && !XFS_FORCED_SHUTDOWN(mp))
 		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
 out_invalidate:
-	iomap_invalidatepage(page, 0, PAGE_SIZE);
+	iomap_invalidatepage(MAPPING_NULL, page, 0, PAGE_SIZE);
 }
 
 static const struct iomap_writeback_ops xfs_writeback_ops = {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 07fe6d613ed9f..0902142e93f0d 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -214,7 +214,8 @@ extern int buffer_heads_over_limit;
  * Generic address_space_operations implementations for buffer_head-backed
  * address_spaces.
  */
-void block_invalidatepage(struct page *page, unsigned int offset,
+void block_invalidatepage(struct address_space *__mapping, struct page *page,
+			  unsigned int offset,
 			  unsigned int length);
 int block_write_full_page(struct page *page, get_block_t *get_block,
 				struct writeback_control *wbc);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0b1e2c231dcf8..b471e82546001 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -397,7 +397,8 @@ struct address_space_operations {
 
 	/* Unfortunately this kludge is needed for FIBMAP. Don't use it */
 	sector_t (*bmap)(struct address_space *, sector_t);
-	void (*invalidatepage) (struct page *, unsigned int, unsigned int);
+	void (*invalidatepage) (struct address_space *, struct page *,
+				unsigned int, unsigned int);
 	int (*releasepage) (struct page *, gfp_t);
 	void (*freepage)(struct page *);
 	ssize_t (*direct_IO)(struct kiocb *, struct iov_iter *iter);
@@ -3225,8 +3226,9 @@ extern void simple_recursive_removal(struct dentry *,
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern int noop_set_page_dirty(struct address_space *__mapping,
 			       struct page *page);
-extern void noop_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int length);
+extern void noop_invalidatepage(struct address_space *__mapping,
+				struct page *page, unsigned int offset,
+				unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
 extern int simple_readpage(struct file *file, struct address_space *__mapping,
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 781f22ee0a53b..45f23d2268365 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -160,8 +160,9 @@ int iomap_set_page_dirty(struct address_space *__mapping, struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
-void iomap_invalidatepage(struct page *page, unsigned int offset,
-		unsigned int len);
+void iomap_invalidatepage(struct address_space *__mapping, struct page *page,
+			  unsigned int offset,
+			  unsigned int len);
 #ifdef CONFIG_MIGRATION
 int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode);
diff --git a/mm/truncate.c b/mm/truncate.c
index dd9ebc1da3566..e26b232b66c01 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -152,7 +152,8 @@ static int invalidate_exceptional_entry2(struct address_space *mapping,
 void do_invalidatepage(struct page *page, unsigned int offset,
 		       unsigned int length)
 {
-	void (*invalidatepage)(struct page *, unsigned int, unsigned int);
+	void (*invalidatepage)(struct address_space *, struct page *,
+		               unsigned int, unsigned int);
 
 	invalidatepage = page->mapping->a_ops->invalidatepage;
 #ifdef CONFIG_BLOCK
@@ -160,7 +161,7 @@ void do_invalidatepage(struct page *page, unsigned int offset,
 		invalidatepage = block_invalidatepage;
 #endif
 	if (invalidatepage)
-		(*invalidatepage)(page, offset, length);
+		(*invalidatepage)(MAPPING_NULL, page, offset, length);
 }
 
 /*
-- 
2.26.2

