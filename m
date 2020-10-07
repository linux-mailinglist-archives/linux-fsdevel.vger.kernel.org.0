Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41B72855EE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgJGBHz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727348AbgJGBHh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VFrVqw9KuhAa13TFtFjIwkeBEZjDqLpZTN3c7enFIAY=;
        b=hQcb79OwDNXpEzPpS8XDVbA5RuC+wPM7zbA96aszzWK5HFuO/F3sezZN93EyX5OMf+pOP0
        CteHA5HIICrtPZqiSPOcWHDj2Ag0IERiT4YVsogs81XgMzT3e/k/LjIdYsdaythXxvcOAZ
        ej1O3D/qdZd0KfT9gCJ7mw6G2t5g/VY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-HK98L8yOPs-t9J4-SlOTQw-1; Tue, 06 Oct 2020 21:07:30 -0400
X-MC-Unique: HK98L8yOPs-t9J4-SlOTQw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C66D190A3E0;
        Wed,  7 Oct 2020 01:07:28 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 180BE5D9D2;
        Wed,  7 Oct 2020 01:07:25 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 06/14] mm: add struct address_space to set_page_dirty() callback
Date:   Tue,  6 Oct 2020 21:05:55 -0400
Message-Id: <20201007010603.3452458-7-jglisse@redhat.com>
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

Add struct address_space to set_page_dirty() callback arguments.

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
// Part 1 is grepping all function that are use as callback for set_page_dirty.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .set_page_dirty = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (set_page_dirty callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
int fn(
+struct address_space *__mapping,
T1 I1) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1;
type T1;
@@
int fn(
+struct address_space *__mapping,
T1 I1);

@p2r3 depends on part2@
identifier virtual.fn;
type T1;
@@
int fn(
+struct address_space *,
T1);

@p2r4 depends on part2@
identifier virtual.fn;
expression E1;
@@
fn(
+MAPPING_NULL,
E1)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for set_page_dirty.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part3@
@@
file=open('/tmp/unicorn-files', 'w')
file.write("./include/linux/pagemap.h\n")
file.write("./mm/page-writeback.c\n")
file.write("./include/linux/mm.h\n")
file.write("./include/linux/fs.h\n")
file.close()

@p3r1 depends on part3 exists@
expression E1, E2;
identifier FN;
position P;
@@
FN@P(...) {...
(
E1.a_ops->set_page_dirty(E2)
|
E1->a_ops->set_page_dirty(E2)
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
struct address_space_operations { ... int (*set_page_dirty)(
+struct address_space *,
struct page *page); ... };

@p4r2 depends on part4@
expression E1, E2;
@@
E1.a_ops->set_page_dirty(
+MAPPING_NULL,
E2)

@p4r3 depends on part4@
expression E1, E2;
@@
E1->a_ops->set_page_dirty(
+MAPPING_NULL,
E2)

@p4r4 depends on part4@
@@
{...
-int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
+int (*spd)(struct address_space *, struct page *) = mapping->a_ops->set_page_dirty;
...
return (*spd)(
+MAPPING_NULL,
page);
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
 drivers/video/fbdev/core/fb_defio.c |  3 ++-
 fs/afs/dir.c                        |  3 ++-
 fs/afs/internal.h                   |  2 +-
 fs/afs/write.c                      |  4 ++--
 fs/btrfs/disk-io.c                  |  5 +++--
 fs/btrfs/extent_io.c                |  2 +-
 fs/btrfs/inode.c                    |  8 +++++---
 fs/buffer.c                         |  3 ++-
 fs/ceph/addr.c                      |  5 +++--
 fs/cifs/cifssmb.c                   |  2 +-
 fs/ext4/inode.c                     | 10 ++++++----
 fs/f2fs/checkpoint.c                |  5 +++--
 fs/f2fs/data.c                      |  7 ++++---
 fs/f2fs/node.c                      |  5 +++--
 fs/gfs2/aops.c                      |  5 +++--
 fs/hugetlbfs/inode.c                |  3 ++-
 fs/iomap/buffered-io.c              |  4 ++--
 fs/libfs.c                          |  5 +++--
 fs/nfs/write.c                      |  6 +++---
 fs/nilfs2/inode.c                   |  5 +++--
 fs/nilfs2/page.c                    |  2 +-
 fs/nilfs2/segment.c                 |  4 ++--
 fs/ntfs/aops.c                      |  2 +-
 fs/ntfs/file.c                      |  2 +-
 fs/reiserfs/inode.c                 |  7 ++++---
 fs/ubifs/file.c                     |  9 +++++----
 include/linux/buffer_head.h         |  3 ++-
 include/linux/fs.h                  |  5 +++--
 include/linux/iomap.h               |  2 +-
 include/linux/mm.h                  |  6 ++++--
 include/linux/swap.h                |  3 ++-
 mm/page-writeback.c                 | 12 +++++++-----
 mm/page_io.c                        |  6 +++---
 33 files changed, 90 insertions(+), 65 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231a..32340ff1d7243 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -151,7 +151,8 @@ static const struct vm_operations_struct fb_deferred_io_vm_ops = {
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
 
-static int fb_deferred_io_set_page_dirty(struct page *page)
+static int fb_deferred_io_set_page_dirty(struct address_space *__mapping,
+					 struct page *page)
 {
 	if (!PageDirty(page))
 		SetPageDirty(page);
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 1d2e61e0ab047..ebcf074bcaaa2 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -44,7 +44,8 @@ static int afs_dir_releasepage(struct page *page, gfp_t gfp_flags);
 static void afs_dir_invalidatepage(struct page *page, unsigned int offset,
 				   unsigned int length);
 
-static int afs_dir_set_page_dirty(struct page *page)
+static int afs_dir_set_page_dirty(struct address_space *__mapping,
+				  struct page *page)
 {
 	BUG(); /* This should never happen. */
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index fc1c80c5ddb88..264f28759c737 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1422,7 +1422,7 @@ extern int afs_check_volume_status(struct afs_volume *, struct afs_operation *);
 /*
  * write.c
  */
-extern int afs_set_page_dirty(struct page *);
+extern int afs_set_page_dirty(struct address_space *, struct page *);
 extern int afs_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index ef0ea031130af..199cbf73b9be4 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -16,10 +16,10 @@
 /*
  * mark a page as having been made dirty and thus needing writeback
  */
-int afs_set_page_dirty(struct page *page)
+int afs_set_page_dirty(struct address_space *__mapping, struct page *page)
 {
 	_enter("");
-	return __set_page_dirty_nobuffers(page);
+	return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 }
 
 /*
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 51ca16ab59e07..7f548f9f5ace1 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -980,7 +980,8 @@ static void btree_invalidatepage(struct page *page, unsigned int offset,
 	}
 }
 
-static int btree_set_page_dirty(struct page *page)
+static int btree_set_page_dirty(struct address_space *__mapping,
+				struct page *page)
 {
 #ifdef DEBUG
 	struct extent_buffer *eb;
@@ -992,7 +993,7 @@ static int btree_set_page_dirty(struct page *page)
 	BUG_ON(!atomic_read(&eb->refs));
 	btrfs_assert_tree_locked(eb);
 #endif
-	return __set_page_dirty_nobuffers(page);
+	return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 }
 
 static const struct address_space_operations btree_aops = {
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a940edb1e64f2..02569dffe8e14 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1514,7 +1514,7 @@ void extent_range_redirty_for_io(struct inode *inode, u64 start, u64 end)
 	while (index <= end_index) {
 		page = find_get_page(inode->i_mapping, index);
 		BUG_ON(!page); /* Pages should be in the extent_io_tree */
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		account_page_redirty(page);
 		put_page(page);
 		index++;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e73dc72dbd984..9f35648ba06d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -735,7 +735,8 @@ static noinline int compress_file_range(struct async_chunk *async_chunk)
 	if (async_chunk->locked_page &&
 	    (page_offset(async_chunk->locked_page) >= start &&
 	     page_offset(async_chunk->locked_page)) <= end) {
-		__set_page_dirty_nobuffers(async_chunk->locked_page);
+		__set_page_dirty_nobuffers(MAPPING_NULL,
+					   async_chunk->locked_page);
 		/* unlocked later on in the async handlers */
 	}
 
@@ -9814,9 +9815,10 @@ int btrfs_prealloc_file_range_trans(struct inode *inode,
 					   min_size, actual_len, alloc_hint, trans);
 }
 
-static int btrfs_set_page_dirty(struct page *page)
+static int btrfs_set_page_dirty(struct address_space *__mapping,
+				struct page *page)
 {
-	return __set_page_dirty_nobuffers(page);
+	return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 }
 
 static int btrfs_permission(struct inode *inode, int mask)
diff --git a/fs/buffer.c b/fs/buffer.c
index c99a468833828..6fb6cf497feb8 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -638,7 +638,8 @@ EXPORT_SYMBOL_GPL(__set_page_dirty);
  * FIXME: may need to call ->reservepage here as well.  That's rather up to the
  * address_space though.
  */
-int __set_page_dirty_buffers(struct page *page)
+int __set_page_dirty_buffers(struct address_space *__mapping,
+			     struct page *page)
 {
 	int newly_dirty;
 	struct address_space *mapping = page_mapping(page);
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8d348fb29102f..b2b2c8f8118e4 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -72,7 +72,8 @@ static inline struct ceph_snap_context *page_snap_context(struct page *page)
  * Dirty a page.  Optimistically adjust accounting, on the assumption
  * that we won't race with invalidate.  If we do, readjust.
  */
-static int ceph_set_page_dirty(struct page *page)
+static int ceph_set_page_dirty(struct address_space *__mapping,
+			       struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode;
@@ -127,7 +128,7 @@ static int ceph_set_page_dirty(struct page *page)
 	page->private = (unsigned long)snapc;
 	SetPagePrivate(page);
 
-	ret = __set_page_dirty_nobuffers(page);
+	ret = __set_page_dirty_nobuffers(MAPPING_NULL, page);
 	WARN_ON(!PageLocked(page));
 	WARN_ON(!page->mapping);
 
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 0496934feecb7..a555efb817b0c 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2105,7 +2105,7 @@ cifs_writev_complete(struct work_struct *work)
 	for (i = 0; i < wdata->nr_pages; i++) {
 		struct page *page = wdata->pages[i];
 		if (wdata->result == -EAGAIN)
-			__set_page_dirty_nobuffers(page);
+			__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		else if (wdata->result < 0)
 			SetPageError(page);
 		end_page_writeback(page);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f8a4d324a6041..528eec0b02bf2 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3589,17 +3589,19 @@ const struct iomap_ops ext4_iomap_report_ops = {
  * So what we do is to mark the page "pending dirty" and next time writepage
  * is called, propagate that into the buffers appropriately.
  */
-static int ext4_journalled_set_page_dirty(struct page *page)
+static int ext4_journalled_set_page_dirty(struct address_space *__mapping,
+					  struct page *page)
 {
 	SetPageChecked(page);
-	return __set_page_dirty_nobuffers(page);
+	return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 }
 
-static int ext4_set_page_dirty(struct page *page)
+static int ext4_set_page_dirty(struct address_space *__mapping,
+			       struct page *page)
 {
 	WARN_ON_ONCE(!PageLocked(page) && !PageDirty(page));
 	WARN_ON_ONCE(!page_has_buffers(page));
-	return __set_page_dirty_buffers(page);
+	return __set_page_dirty_buffers(MAPPING_NULL, page);
 }
 
 static const struct address_space_operations ext4_aops = {
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4c3c1299c628d..f4594b08270a4 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -432,14 +432,15 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 	return nwritten;
 }
 
-static int f2fs_set_meta_page_dirty(struct page *page)
+static int f2fs_set_meta_page_dirty(struct address_space *__mapping,
+				    struct page *page)
 {
 	trace_f2fs_set_page_dirty(page, META);
 
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_META);
 		f2fs_set_page_private(page, 0);
 		f2fs_trace_pid(page);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 888569093c9f5..12350175133aa 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3734,7 +3734,8 @@ int f2fs_release_page(struct page *page, gfp_t wait)
 	return 1;
 }
 
-static int f2fs_set_data_page_dirty(struct page *page)
+static int f2fs_set_data_page_dirty(struct address_space *__mapping,
+				    struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 
@@ -3743,7 +3744,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	if (!PageUptodate(page))
 		SetPageUptodate(page);
 	if (PageSwapCache(page))
-		return __set_page_dirty_nobuffers(page);
+		return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 
 	if (f2fs_is_atomic_file(inode) && !f2fs_is_commit_atomic_write(inode)) {
 		if (!IS_ATOMIC_WRITTEN_PAGE(page)) {
@@ -3758,7 +3759,7 @@ static int f2fs_set_data_page_dirty(struct page *page)
 	}
 
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		f2fs_update_dirty_page(inode, page);
 		return 1;
 	}
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 290e5fdc3bfb9..648a2d7f307bd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2072,7 +2072,8 @@ static int f2fs_write_node_pages(struct address_space *mapping,
 	return 0;
 }
 
-static int f2fs_set_node_page_dirty(struct page *page)
+static int f2fs_set_node_page_dirty(struct address_space *__mapping,
+				    struct page *page)
 {
 	trace_f2fs_set_page_dirty(page, NODE);
 
@@ -2083,7 +2084,7 @@ static int f2fs_set_node_page_dirty(struct page *page)
 		f2fs_inode_chksum_set(F2FS_P_SB(page), page);
 #endif
 	if (!PageDirty(page)) {
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		inc_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
 		f2fs_set_page_private(page, 0);
 		f2fs_trace_pid(page);
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 826dd0677fdb9..8911771f95c5c 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -624,10 +624,11 @@ void adjust_fs_space(struct inode *inode)
  * Returns: 1 if it dirtyed the page, or 0 otherwise
  */
  
-static int jdata_set_page_dirty(struct page *page)
+static int jdata_set_page_dirty(struct address_space *__mapping,
+				struct page *page)
 {
 	SetPageChecked(page);
-	return __set_page_dirty_buffers(page);
+	return __set_page_dirty_buffers(MAPPING_NULL, page);
 }
 
 /**
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daaf..b675b615cead0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -947,7 +947,8 @@ static int hugetlbfs_symlink(struct inode *dir,
 /*
  * mark the head page dirty
  */
-static int hugetlbfs_set_page_dirty(struct page *page)
+static int hugetlbfs_set_page_dirty(struct address_space *__mapping,
+				    struct page *page)
 {
 	struct page *head = compound_head(page);
 
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3fb..26f7fe7c80adc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -661,7 +661,7 @@ iomap_write_begin(struct inode *inode, loff_t pos, unsigned len, unsigned flags,
 }
 
 int
-iomap_set_page_dirty(struct page *page)
+iomap_set_page_dirty(struct address_space *__mapping, struct page *page)
 {
 	struct address_space *mapping = page_mapping(page);
 	int newly_dirty;
@@ -705,7 +705,7 @@ __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 	if (unlikely(copied < len && !PageUptodate(page)))
 		return 0;
 	iomap_set_range_uptodate(page, offset_in_page(pos), len);
-	iomap_set_page_dirty(page);
+	iomap_set_page_dirty(MAPPING_NULL, page);
 	return copied;
 }
 
diff --git a/fs/libfs.c b/fs/libfs.c
index 7df05487cdde6..899feec2eb683 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1156,7 +1156,7 @@ int noop_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 EXPORT_SYMBOL(noop_fsync);
 
-int noop_set_page_dirty(struct page *page)
+int noop_set_page_dirty(struct address_space *__mapping, struct page *page)
 {
 	/*
 	 * Unlike __set_page_dirty_no_writeback that handles dirty page
@@ -1206,7 +1206,8 @@ EXPORT_SYMBOL(kfree_link);
  * nop .set_page_dirty method so that people can use .page_mkwrite on
  * anon inodes.
  */
-static int anon_set_page_dirty(struct page *page)
+static int anon_set_page_dirty(struct address_space *__mapping,
+			       struct page *page)
 {
 	return 0;
 };
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b7fe16714d9cc..c4f04b191b72f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -808,7 +808,7 @@ static void
 nfs_mark_request_dirty(struct nfs_page *req)
 {
 	if (req->wb_page)
-		__set_page_dirty_nobuffers(req->wb_page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, req->wb_page);
 }
 
 /*
@@ -1376,7 +1376,7 @@ int nfs_updatepage(struct file *file, struct page *page,
 	if (status < 0)
 		nfs_set_pageerror(mapping);
 	else
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 out:
 	dprintk("NFS:       nfs_updatepage returns %d (isize %lld)\n",
 			status, (long long)i_size_read(inode));
@@ -1792,7 +1792,7 @@ static void
 nfs_commit_resched_write(struct nfs_commit_info *cinfo,
 		struct nfs_page *req)
 {
-	__set_page_dirty_nobuffers(req->wb_page);
+	__set_page_dirty_nobuffers(MAPPING_NULL, req->wb_page);
 }
 
 /*
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 00a22de8e2376..1cedff7bc4e13 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -201,10 +201,11 @@ static int nilfs_writepage(struct address_space *__mapping, struct page *page,
 	return 0;
 }
 
-static int nilfs_set_page_dirty(struct page *page)
+static int nilfs_set_page_dirty(struct address_space *__mapping,
+				struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	int ret = __set_page_dirty_nobuffers(page);
+	int ret = __set_page_dirty_nobuffers(MAPPING_NULL, page);
 
 	if (page_has_buffers(page)) {
 		unsigned int nr_dirty = 0;
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index b175f1330408a..5137b82fb43d5 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -270,7 +270,7 @@ int nilfs_copy_dirty_pages(struct address_space *dmap,
 				       "found empty page in dat page cache");
 
 		nilfs_copy_page(dpage, page, 1);
-		__set_page_dirty_nobuffers(dpage);
+		__set_page_dirty_nobuffers(MAPPING_NULL, dpage);
 
 		unlock_page(dpage);
 		put_page(dpage);
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index e3726aca28ed6..1a4ea72ad50f1 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1732,10 +1732,10 @@ static void nilfs_end_page_io(struct page *page, int err)
 
 	if (!err) {
 		if (!nilfs_page_buffers_clean(page))
-			__set_page_dirty_nobuffers(page);
+			__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		ClearPageError(page);
 	} else {
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 		SetPageError(page);
 	}
 
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index d920cb780a4ea..3d3a6b6bc6717 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1749,7 +1749,7 @@ void mark_ntfs_record_dirty(struct page *page, const unsigned int ofs) {
 		set_buffer_dirty(bh);
 	} while ((bh = bh->b_this_page) != head);
 	spin_unlock(&mapping->private_lock);
-	__set_page_dirty_nobuffers(page);
+	__set_page_dirty_nobuffers(MAPPING_NULL, page);
 	if (unlikely(buffers_to_free)) {
 		do {
 			bh = buffers_to_free->b_this_page;
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f42967b738eb6..c863f62351a62 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1660,7 +1660,7 @@ static int ntfs_commit_pages_after_write(struct page **pages,
 			 * Put the page on mapping->dirty_pages, but leave its
 			 * buffers' dirty state as-is.
 			 */
-			__set_page_dirty_nobuffers(page);
+			__set_page_dirty_nobuffers(MAPPING_NULL, page);
 			err = 0;
 		} else
 			ntfs_error(vi->i_sb, "Page is not uptodate.  Written "
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 5a34ab78f66cd..9ef4365c07fdd 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3209,14 +3209,15 @@ static void reiserfs_invalidatepage(struct page *page, unsigned int offset,
 	return;
 }
 
-static int reiserfs_set_page_dirty(struct page *page)
+static int reiserfs_set_page_dirty(struct address_space *__mapping,
+				   struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	if (reiserfs_file_data_log(inode)) {
 		SetPageChecked(page);
-		return __set_page_dirty_nobuffers(page);
+		return __set_page_dirty_nobuffers(MAPPING_NULL, page);
 	}
-	return __set_page_dirty_buffers(page);
+	return __set_page_dirty_buffers(MAPPING_NULL, page);
 }
 
 /*
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index fcc6c307313f2..5af8c311d38f0 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -572,7 +572,7 @@ static int ubifs_write_end(struct file *file, struct address_space *mapping,
 	if (!PagePrivate(page)) {
 		SetPagePrivate(page);
 		atomic_long_inc(&c->dirty_pg_cnt);
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 	}
 
 	if (appending) {
@@ -1446,13 +1446,14 @@ static ssize_t ubifs_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	return generic_file_write_iter(iocb, from);
 }
 
-static int ubifs_set_page_dirty(struct page *page)
+static int ubifs_set_page_dirty(struct address_space *__mapping,
+				struct page *page)
 {
 	int ret;
 	struct inode *inode = page->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 
-	ret = __set_page_dirty_nobuffers(page);
+	ret = __set_page_dirty_nobuffers(MAPPING_NULL, page);
 	/*
 	 * An attempt to dirty a page without budgeting for it - should not
 	 * happen.
@@ -1570,7 +1571,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
 			ubifs_convert_page_budget(c);
 		SetPagePrivate(page);
 		atomic_long_inc(&c->dirty_pg_cnt);
-		__set_page_dirty_nobuffers(page);
+		__set_page_dirty_nobuffers(MAPPING_NULL, page);
 	}
 
 	if (update_time) {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5a..07fe6d613ed9f 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -396,7 +396,8 @@ __bread(struct block_device *bdev, sector_t block, unsigned size)
 	return __bread_gfp(bdev, block, size, __GFP_MOVABLE);
 }
 
-extern int __set_page_dirty_buffers(struct page *page);
+extern int __set_page_dirty_buffers(struct address_space *__mapping,
+				    struct page *page);
 
 #else /* CONFIG_BLOCK */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index acd51e3880762..0b1e2c231dcf8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -378,7 +378,7 @@ struct address_space_operations {
 	int (*writepages)(struct address_space *, struct writeback_control *);
 
 	/* Set a page dirty.  Return true if this dirtied it */
-	int (*set_page_dirty)(struct page *page);
+	int (*set_page_dirty)(struct address_space *, struct page *page);
 
 	/*
 	 * Reads in the requested pages. Unlike ->readpage(), this is
@@ -3223,7 +3223,8 @@ extern int simple_rename(struct inode *, struct dentry *,
 extern void simple_recursive_removal(struct dentry *,
                               void (*callback)(struct dentry *));
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
-extern int noop_set_page_dirty(struct page *page);
+extern int noop_set_page_dirty(struct address_space *__mapping,
+			       struct page *page);
 extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 4d1d3c3469e9a..781f22ee0a53b 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -156,7 +156,7 @@ ssize_t iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *from,
 		const struct iomap_ops *ops);
 int iomap_readpage(struct page *page, const struct iomap_ops *ops);
 void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
-int iomap_set_page_dirty(struct page *page);
+int iomap_set_page_dirty(struct address_space *__mapping, struct page *page);
 int iomap_is_partially_uptodate(struct page *page, unsigned long from,
 		unsigned long count);
 int iomap_releasepage(struct page *page, gfp_t gfp_mask);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d165961c58c45..1bf229c4176bc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1796,8 +1796,10 @@ extern void do_invalidatepage(struct page *page, unsigned int offset,
 			      unsigned int length);
 
 void __set_page_dirty(struct page *, struct address_space *, int warn);
-int __set_page_dirty_nobuffers(struct page *page);
-int __set_page_dirty_no_writeback(struct page *page);
+int __set_page_dirty_nobuffers(struct address_space *__mapping,
+			       struct page *page);
+int __set_page_dirty_no_writeback(struct address_space *__mapping,
+				  struct page *page);
 int redirty_page_for_writepage(struct writeback_control *wbc,
 				struct page *page);
 void account_page_dirtied(struct page *page, struct address_space *mapping);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index f2355fca8b38b..b0316c44869d2 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -397,7 +397,8 @@ extern int swap_writepage(struct address_space *__mapping, struct page *page,
 extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
-extern int swap_set_page_dirty(struct page *page);
+extern int swap_set_page_dirty(struct address_space *__mapping,
+			       struct page *page);
 
 int add_swap_extent(struct swap_info_struct *sis, unsigned long start_page,
 		unsigned long nr_pages, sector_t start_block);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index de15d2febc5ae..78ead3581040e 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2403,7 +2403,8 @@ EXPORT_SYMBOL(write_one_page);
 /*
  * For address_spaces which do not use buffers nor write back.
  */
-int __set_page_dirty_no_writeback(struct page *page)
+int __set_page_dirty_no_writeback(struct address_space *__mapping,
+				  struct page *page)
 {
 	if (!PageDirty(page))
 		return !TestSetPageDirty(page);
@@ -2470,7 +2471,8 @@ void account_page_cleaned(struct page *page, struct address_space *mapping,
  * hold the page lock, but e.g. zap_pte_range() calls with the page mapped and
  * the pte lock held, which also locks out truncation.
  */
-int __set_page_dirty_nobuffers(struct page *page)
+int __set_page_dirty_nobuffers(struct address_space *__mapping,
+			       struct page *page)
 {
 	lock_page_memcg(page);
 	if (!TestSetPageDirty(page)) {
@@ -2537,7 +2539,7 @@ int redirty_page_for_writepage(struct writeback_control *wbc, struct page *page)
 	int ret;
 
 	wbc->pages_skipped++;
-	ret = __set_page_dirty_nobuffers(page);
+	ret = __set_page_dirty_nobuffers(MAPPING_NULL, page);
 	account_page_redirty(page);
 	return ret;
 }
@@ -2560,7 +2562,7 @@ int set_page_dirty(struct page *page)
 
 	page = compound_head(page);
 	if (likely(mapping)) {
-		int (*spd)(struct page *) = mapping->a_ops->set_page_dirty;
+		int (*spd)(struct address_space *, struct page *) = mapping->a_ops->set_page_dirty;
 		/*
 		 * readahead/lru_deactivate_page could remain
 		 * PG_readahead/PG_reclaim due to race with end_page_writeback
@@ -2577,7 +2579,7 @@ int set_page_dirty(struct page *page)
 		if (!spd)
 			spd = __set_page_dirty_buffers;
 #endif
-		return (*spd)(page);
+		return (*spd)(MAPPING_NULL, page);
 	}
 	if (!PageDirty(page)) {
 		if (!TestSetPageDirty(page))
diff --git a/mm/page_io.c b/mm/page_io.c
index 067159b23ee54..60617b6420c01 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -452,7 +452,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	return ret;
 }
 
-int swap_set_page_dirty(struct page *page)
+int swap_set_page_dirty(struct address_space *__mapping, struct page *page)
 {
 	struct swap_info_struct *sis = page_swap_info(page);
 
@@ -460,8 +460,8 @@ int swap_set_page_dirty(struct page *page)
 		struct address_space *mapping = sis->swap_file->f_mapping;
 
 		VM_BUG_ON_PAGE(!PageSwapCache(page), page);
-		return mapping->a_ops->set_page_dirty(page);
+		return mapping->a_ops->set_page_dirty(MAPPING_NULL, page);
 	} else {
-		return __set_page_dirty_no_writeback(page);
+		return __set_page_dirty_no_writeback(MAPPING_NULL, page);
 	}
 }
-- 
2.26.2

