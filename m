Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569D32855EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbgJGBHe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51584 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727261AbgJGBHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oj1J5z5H8I/P159EdJkp/eoU7pYGDRFNShpqo+JUQzE=;
        b=Mf6noy3F8rH2KuvzBQQYj5FE7+M1dx2CXGVsi5Doi+l/VgQOdqBOcQPZf49Oac7i50fxoE
        fHIc6cO1dstIrsexdtEFee/fBxmVq3V6CTZrw3r153ZPpOpwqf1PUZbY4brcmtt0tI2pqY
        U64UZAEWvb4ATyCw5KI7MPlIfu6q2is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-5XBVyk55OEmmE-aC95Owaw-1; Tue, 06 Oct 2020 21:07:26 -0400
X-MC-Unique: 5XBVyk55OEmmE-aC95Owaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E467B100854F;
        Wed,  7 Oct 2020 01:07:24 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D82545D9D2;
        Wed,  7 Oct 2020 01:07:18 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 05/14] mm: add struct address_space to writepage() callback
Date:   Tue,  6 Oct 2020 21:05:54 -0400
Message-Id: <20201007010603.3452458-6-jglisse@redhat.com>
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

Add struct address_space to writepage() callback arguments.

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
// Part 1 is grepping all function that are use as callback for writepage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .writepage = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (writepage callback one)
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
type T1, T2;
@@
int fn(
+struct address_space *__mapping,
T1, T2);

@p2r4 depends on part2@
identifier virtual.fn;
expression E1, E2;
@@
fn(
+MAPPING_NULL,
E1, E2)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for writepage.

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
E1.a_ops->writepage(E2, E3)
|
E1->a_ops->writepage(E2, E3)
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
struct address_space_operations { ... int (*writepage)(
+struct address_space *,
struct page *page, ...); ... };

@p4r2 depends on part4@
expression E1, E2, E3;
@@
E1.a_ops->writepage(
+MAPPING_NULL,
E2, E3)

@p4r3 depends on part4@
expression E1, E2, E3;
@@
E1->a_ops->writepage(
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
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 3 ++-
 fs/9p/vfs_addr.c                          | 4 +++-
 fs/adfs/inode.c                           | 3 ++-
 fs/affs/file.c                            | 3 ++-
 fs/afs/internal.h                         | 3 ++-
 fs/afs/write.c                            | 3 ++-
 fs/bfs/file.c                             | 3 ++-
 fs/block_dev.c                            | 3 ++-
 fs/btrfs/inode.c                          | 3 ++-
 fs/ceph/addr.c                            | 3 ++-
 fs/cifs/file.c                            | 3 ++-
 fs/ecryptfs/mmap.c                        | 4 +++-
 fs/exfat/inode.c                          | 3 ++-
 fs/ext2/inode.c                           | 8 +++++---
 fs/ext4/inode.c                           | 2 +-
 fs/f2fs/checkpoint.c                      | 3 ++-
 fs/f2fs/data.c                            | 3 ++-
 fs/f2fs/node.c                            | 3 ++-
 fs/fat/inode.c                            | 3 ++-
 fs/fuse/file.c                            | 3 ++-
 fs/gfs2/aops.c                            | 7 +++++--
 fs/gfs2/meta_io.c                         | 4 +++-
 fs/hfs/inode.c                            | 3 ++-
 fs/hfsplus/inode.c                        | 3 ++-
 fs/hostfs/hostfs_kern.c                   | 3 ++-
 fs/hpfs/file.c                            | 3 ++-
 fs/jfs/inode.c                            | 3 ++-
 fs/jfs/jfs_metapage.c                     | 4 +++-
 fs/minix/inode.c                          | 3 ++-
 fs/mpage.c                                | 2 +-
 fs/nfs/write.c                            | 3 ++-
 fs/nilfs2/inode.c                         | 3 ++-
 fs/nilfs2/mdt.c                           | 3 ++-
 fs/ntfs/aops.c                            | 3 ++-
 fs/ocfs2/aops.c                           | 3 ++-
 fs/omfs/file.c                            | 3 ++-
 fs/orangefs/inode.c                       | 4 +++-
 fs/reiserfs/inode.c                       | 4 +++-
 fs/sysv/itree.c                           | 3 ++-
 fs/ubifs/file.c                           | 3 ++-
 fs/udf/file.c                             | 3 ++-
 fs/udf/inode.c                            | 5 +++--
 fs/ufs/inode.c                            | 3 ++-
 fs/vboxsf/file.c                          | 3 ++-
 fs/xfs/xfs_aops.c                         | 2 +-
 fs/zonefs/super.c                         | 3 ++-
 include/linux/fs.h                        | 3 ++-
 include/linux/nfs_fs.h                    | 3 ++-
 include/linux/swap.h                      | 7 +++++--
 mm/migrate.c                              | 2 +-
 mm/page-writeback.c                       | 4 ++--
 mm/page_io.c                              | 3 ++-
 mm/shmem.c                                | 5 +++--
 mm/vmscan.c                               | 2 +-
 54 files changed, 120 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 38113d3c0138e..73c17231c142d 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -266,7 +266,8 @@ shmem_writeback(struct drm_i915_gem_object *obj)
 			int ret;
 
 			SetPageReclaim(page);
-			ret = mapping->a_ops->writepage(page, &wbc);
+			ret = mapping->a_ops->writepage(MAPPING_NULL, page,
+							&wbc);
 			if (!PageWriteback(page))
 				ClearPageReclaim(page);
 			if (!ret)
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 79fa773dbe95e..c7a8037df9fcf 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -178,7 +178,9 @@ static int v9fs_vfs_writepage_locked(struct page *page)
 	return err;
 }
 
-static int v9fs_vfs_writepage(struct page *page, struct writeback_control *wbc)
+static int v9fs_vfs_writepage(struct address_space *__mapping,
+			      struct page *page,
+			      struct writeback_control *wbc)
 {
 	int retval;
 
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 2a29f7d4a4dd0..26c1b6e1a47d3 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -33,7 +33,8 @@ adfs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh,
 	return 0;
 }
 
-static int adfs_writepage(struct page *page, struct writeback_control *wbc)
+static int adfs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page, adfs_get_block, wbc);
 }
diff --git a/fs/affs/file.c b/fs/affs/file.c
index a20d5a1298335..fd2216031b27e 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -370,7 +370,8 @@ affs_get_block(struct inode *inode, sector_t block, struct buffer_head *bh_resul
 	return -ENOSPC;
 }
 
-static int affs_writepage(struct page *page, struct writeback_control *wbc)
+static int affs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page, affs_get_block, wbc);
 }
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 18042b7dab6a8..fc1c80c5ddb88 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1429,7 +1429,8 @@ extern int afs_write_begin(struct file *file, struct address_space *mapping,
 extern int afs_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata);
-extern int afs_writepage(struct page *, struct writeback_control *);
+extern int afs_writepage(struct address_space *__mapping, struct page *,
+			 struct writeback_control *);
 extern int afs_writepages(struct address_space *, struct writeback_control *);
 extern ssize_t afs_file_write(struct kiocb *, struct iov_iter *);
 extern int afs_fsync(struct file *, loff_t, loff_t, int);
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 4b2265cb18917..ef0ea031130af 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -647,7 +647,8 @@ static int afs_write_back_from_locked_page(struct address_space *mapping,
  * write a page back to the server
  * - the caller locked the page for us
  */
-int afs_writepage(struct page *page, struct writeback_control *wbc)
+int afs_writepage(struct address_space *__mapping, struct page *page,
+		  struct writeback_control *wbc)
 {
 	int ret;
 
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 4154c23e23e24..b57a8b39dd2f7 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -150,7 +150,8 @@ static int bfs_get_block(struct inode *inode, sector_t block,
 	return err;
 }
 
-static int bfs_writepage(struct page *page, struct writeback_control *wbc)
+static int bfs_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page, bfs_get_block, wbc);
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index b8e6e1995f396..b50c93932dfdf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -593,7 +593,8 @@ int thaw_bdev(struct block_device *bdev, struct super_block *sb)
 }
 EXPORT_SYMBOL(thaw_bdev);
 
-static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
+static int blkdev_writepage(struct address_space *__mapping,
+			    struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, blkdev_get_block, wbc);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1213671571bb2..e73dc72dbd984 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8011,7 +8011,8 @@ int btrfs_readpage(struct file *file, struct address_space *__mapping,
 	return extent_read_full_page(page, btrfs_get_extent, 0);
 }
 
-static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
+static int btrfs_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	int ret;
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 69a19e1b6b2ec..8d348fb29102f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -761,7 +761,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int ceph_writepage(struct page *page, struct writeback_control *wbc)
+static int ceph_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	int err;
 	struct inode *inode = page->mapping->host;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f1d974218dfcd..ca7df2a2dde0f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2516,7 +2516,8 @@ cifs_writepage_locked(struct page *page, struct writeback_control *wbc)
 	return rc;
 }
 
-static int cifs_writepage(struct page *page, struct writeback_control *wbc)
+static int cifs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	int rc = cifs_writepage_locked(page, wbc);
 	unlock_page(page);
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 163cfff9c2a1f..dea69ef240f39 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -48,7 +48,9 @@ struct page *ecryptfs_get_locked_page(struct inode *inode, loff_t index)
  * the lower filesystem.  In OpenPGP-compatible mode, we operate on
  * entire underlying packets.
  */
-static int ecryptfs_writepage(struct page *page, struct writeback_control *wbc)
+static int ecryptfs_writepage(struct address_space *__mapping,
+			      struct page *page,
+			      struct writeback_control *wbc)
 {
 	int rc;
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2c8f3f6b65ae5..e165e7e91a1fe 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -370,7 +370,8 @@ static void exfat_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, exfat_get_block);
 }
 
-static int exfat_writepage(struct page *page, struct writeback_control *wbc)
+static int exfat_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	return block_write_full_page(page, exfat_get_block, wbc);
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 46f10453ab32e..21b6b75b0ef0f 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -865,7 +865,8 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 				    ext2_get_block);
 }
 
-static int ext2_writepage(struct page *page, struct writeback_control *wbc)
+static int ext2_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page, ext2_get_block, wbc);
 }
@@ -921,8 +922,9 @@ ext2_nobh_write_begin(struct file *file, struct address_space *mapping,
 	return ret;
 }
 
-static int ext2_nobh_writepage(struct page *page,
-			struct writeback_control *wbc)
+static int ext2_nobh_writepage(struct address_space *__mapping,
+			       struct page *page,
+			       struct writeback_control *wbc)
 {
 	return nobh_writepage(page, ext2_get_block, wbc);
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82283d11cd740..f8a4d324a6041 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1969,7 +1969,7 @@ static int __ext4_journalled_writepage(struct page *page,
  * But since we don't do any block allocation we should not deadlock.
  * Page also have the dirty flag cleared so we don't get recurive page_lock.
  */
-static int ext4_writepage(struct page *page,
+static int ext4_writepage(struct address_space *__mapping, struct page *page,
 			  struct writeback_control *wbc)
 {
 	int ret = 0;
diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ff807e14c8911..4c3c1299c628d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -324,7 +324,8 @@ static int __f2fs_write_meta_page(struct page *page,
 	return AOP_WRITEPAGE_ACTIVATE;
 }
 
-static int f2fs_write_meta_page(struct page *page,
+static int f2fs_write_meta_page(struct address_space *__mapping,
+				struct page *page,
 				struct writeback_control *wbc)
 {
 	return __f2fs_write_meta_page(page, wbc, FS_META_IO);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index dbbfaa8cd9602..888569093c9f5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2893,7 +2893,8 @@ int f2fs_write_single_data_page(struct page *page, int *submitted,
 	return err;
 }
 
-static int f2fs_write_data_page(struct page *page,
+static int f2fs_write_data_page(struct address_space *__mapping,
+					struct page *page,
 					struct writeback_control *wbc)
 {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cb1b5b61a1dab..290e5fdc3bfb9 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1650,7 +1650,8 @@ int f2fs_move_node_page(struct page *node_page, int gc_type)
 	return err;
 }
 
-static int f2fs_write_node_page(struct page *page,
+static int f2fs_write_node_page(struct address_space *__mapping,
+				struct page *page,
 				struct writeback_control *wbc)
 {
 	return __write_node_page(page, false, NULL, wbc, false,
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index 6ef4e7619684d..18485221c9ca3 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -194,7 +194,8 @@ static int fat_get_block(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int fat_writepage(struct page *page, struct writeback_control *wbc)
+static int fat_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page, fat_get_block, wbc);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f7c6b4b711a86..66b31387e878f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1886,7 +1886,8 @@ static int fuse_writepage_locked(struct page *page)
 	return error;
 }
 
-static int fuse_writepage(struct page *page, struct writeback_control *wbc)
+static int fuse_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	int err;
 
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index e3b5f5fa08bec..826dd0677fdb9 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -86,7 +86,8 @@ static int gfs2_get_block_noalloc(struct inode *inode, sector_t lblock,
  * @page: The page
  * @wbc: The writeback control
  */
-static int gfs2_writepage(struct page *page, struct writeback_control *wbc)
+static int gfs2_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
@@ -178,7 +179,9 @@ static int __gfs2_jdata_writepage(struct page *page, struct writeback_control *w
  *
  */
 
-static int gfs2_jdata_writepage(struct page *page, struct writeback_control *wbc)
+static int gfs2_jdata_writepage(struct address_space *__mapping,
+				struct page *page,
+				struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 9856cc2e07950..8681d1b551a67 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -30,7 +30,9 @@
 #include "util.h"
 #include "trace_gfs2.h"
 
-static int gfs2_aspace_writepage(struct page *page, struct writeback_control *wbc)
+static int gfs2_aspace_writepage(struct address_space *__mapping,
+				 struct page *page,
+				 struct writeback_control *wbc)
 {
 	struct buffer_head *bh, *head;
 	int nr_underway = 0;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ae193e389e22e..101cc5e10524f 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -29,7 +29,8 @@ static const struct inode_operations hfs_file_inode_operations;
 
 #define HFS_VALID_MODE_BITS  (S_IFREG | S_IFDIR | S_IRWXUGO)
 
-static int hfs_writepage(struct page *page, struct writeback_control *wbc)
+static int hfs_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page, hfs_get_block, wbc);
 }
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 9955b8dcb8061..1654ee206e7e5 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -29,7 +29,8 @@ static int hfsplus_readpage(struct file *file,
 	return block_read_full_page(page, hfsplus_get_block);
 }
 
-static int hfsplus_writepage(struct page *page, struct writeback_control *wbc)
+static int hfsplus_writepage(struct address_space *__mapping,
+			     struct page *page, struct writeback_control *wbc)
 {
 	return block_write_full_page(page, hfsplus_get_block, wbc);
 }
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 0b78c8bf11717..a350d486a42f9 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -396,7 +396,8 @@ static const struct file_operations hostfs_dir_fops = {
 	.fsync		= hostfs_fsync,
 };
 
-static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
+static int hostfs_writepage(struct address_space *__mapping,
+			    struct page *page, struct writeback_control *wbc)
 {
 	struct address_space *mapping = page->mapping;
 	struct inode *inode = mapping->host;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 28be564b9eba8..0c3858afe720e 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -122,7 +122,8 @@ static int hpfs_readpage(struct file *file, struct address_space *__mapping,
 	return mpage_readpage(page, hpfs_get_block);
 }
 
-static int hpfs_writepage(struct page *page, struct writeback_control *wbc)
+static int hpfs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page, hpfs_get_block, wbc);
 }
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 41b77aac394d6..549bd5aa36bc0 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -280,7 +280,8 @@ int jfs_get_block(struct inode *ip, sector_t lblock,
 	return rc;
 }
 
-static int jfs_writepage(struct page *page, struct writeback_control *wbc)
+static int jfs_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page, jfs_get_block, wbc);
 }
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index e9dae1dccb42b..a6e48e733d3a6 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -332,7 +332,9 @@ static void metapage_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-static int metapage_writepage(struct page *page, struct writeback_control *wbc)
+static int metapage_writepage(struct address_space *__mapping,
+			      struct page *page,
+			      struct writeback_control *wbc)
 {
 	struct bio *bio = NULL;
 	int block_offset;	/* block offset of mp within page */
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 9677f0424a72d..46e169d400be3 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -398,7 +398,8 @@ static int minix_get_block(struct inode *inode, sector_t block,
 		return V2_minix_get_block(inode, block, bh_result, create);
 }
 
-static int minix_writepage(struct page *page, struct writeback_control *wbc)
+static int minix_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	return block_write_full_page(page, minix_get_block, wbc);
 }
diff --git a/fs/mpage.c b/fs/mpage.c
index 830e6cc2a9e72..a2bca7b6c90c6 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -659,7 +659,7 @@ static int __mpage_writepage(struct page *page, struct writeback_control *wbc,
 		bio = mpage_bio_submit(REQ_OP_WRITE, op_flags, bio);
 
 	if (mpd->use_writepage) {
-		ret = mapping->a_ops->writepage(page, wbc);
+		ret = mapping->a_ops->writepage(MAPPING_NULL, page, wbc);
 	} else {
 		ret = -EAGAIN;
 		goto out;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a8..b7fe16714d9cc 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -683,7 +683,8 @@ static int nfs_writepage_locked(struct page *page,
 	return 0;
 }
 
-int nfs_writepage(struct page *page, struct writeback_control *wbc)
+int nfs_writepage(struct address_space *__mapping, struct page *page,
+		  struct writeback_control *wbc)
 {
 	int ret;
 
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index f1e5cc46ce00b..00a22de8e2376 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -170,7 +170,8 @@ static int nilfs_writepages(struct address_space *mapping,
 	return err;
 }
 
-static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
+static int nilfs_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	int err;
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index c0361ce45f62d..bd917df901b0a 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -398,7 +398,8 @@ int nilfs_mdt_fetch_dirty(struct inode *inode)
 }
 
 static int
-nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
+nilfs_mdt_write_page(struct address_space *__mapping, struct page *page,
+		     struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb;
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index ca0bcec9ac2f6..d920cb780a4ea 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -1334,7 +1334,8 @@ static int ntfs_write_mst_block(struct page *page,
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_writepage(struct page *page, struct writeback_control *wbc)
+static int ntfs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	loff_t i_size;
 	struct inode *vi = page->mapping->host;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index a5f9686ae100d..c597a104e0af4 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -401,7 +401,8 @@ static void ocfs2_readahead(struct readahead_control *rac)
  * mapping can't have disappeared under the dirty pages that it is
  * being asked to write back.
  */
-static int ocfs2_writepage(struct page *page, struct writeback_control *wbc)
+static int ocfs2_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	trace_ocfs2_writepage(
 		(unsigned long long)OCFS2_I(page->mapping->host)->ip_blkno,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index c55fd61021b65..e130dfda28526 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -295,7 +295,8 @@ static void omfs_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, omfs_get_block);
 }
 
-static int omfs_writepage(struct page *page, struct writeback_control *wbc)
+static int omfs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page, omfs_get_block, wbc);
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 6d797c789f035..f463cfb435292 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -66,7 +66,9 @@ static int orangefs_writepage_locked(struct page *page,
 	return ret;
 }
 
-static int orangefs_writepage(struct page *page, struct writeback_control *wbc)
+static int orangefs_writepage(struct address_space *__mapping,
+			      struct page *page,
+			      struct writeback_control *wbc)
 {
 	int ret;
 	ret = orangefs_writepage_locked(page, wbc);
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 3f7638fd6eeca..5a34ab78f66cd 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2744,7 +2744,9 @@ static int reiserfs_readpage(struct file *f, struct address_space *__mapping,
 	return block_read_full_page(page, reiserfs_get_block);
 }
 
-static int reiserfs_writepage(struct page *page, struct writeback_control *wbc)
+static int reiserfs_writepage(struct address_space *__mapping,
+			      struct page *page,
+			      struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	reiserfs_wait_on_write_block(inode->i_sb);
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index eaca724493b3d..fa5b348322a63 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -451,7 +451,8 @@ int sysv_getattr(const struct path *path, struct kstat *stat,
 	return 0;
 }
 
-static int sysv_writepage(struct page *page, struct writeback_control *wbc)
+static int sysv_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc)
 {
 	return block_write_full_page(page,get_block,wbc);
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 7b868f220ca7d..fcc6c307313f2 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1003,7 +1003,8 @@ static int do_writepage(struct page *page, int len)
  * on the page lock and it would not write the truncated inode node to the
  * journal before we have finished.
  */
-static int ubifs_writepage(struct page *page, struct writeback_control *wbc)
+static int ubifs_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 6d3a2291856fe..17f664979eed2 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -68,7 +68,8 @@ static int udf_adinicb_readpage(struct file *file,
 	return 0;
 }
 
-static int udf_adinicb_writepage(struct page *page,
+static int udf_adinicb_writepage(struct address_space *__mapping,
+				 struct page *page,
 				 struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 5bceaf7456be7..cf4d8ab143190 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -179,7 +179,8 @@ static void udf_write_failed(struct address_space *mapping, loff_t to)
 	}
 }
 
-static int udf_writepage(struct page *page, struct writeback_control *wbc)
+static int udf_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page, udf_get_block, wbc);
 }
@@ -303,7 +304,7 @@ int udf_expand_file_adinicb(struct inode *inode)
 	/* from now on we have normal address_space methods */
 	inode->i_data.a_ops = &udf_aops;
 	up_write(&iinfo->i_data_sem);
-	err = inode->i_data.a_ops->writepage(page, &udf_wbc);
+	err = inode->i_data.a_ops->writepage(MAPPING_NULL, page, &udf_wbc);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		lock_page(page);
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 4f44e309cfaf5..5bf96e90d8be4 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -467,7 +467,8 @@ static int ufs_getfrag_block(struct inode *inode, sector_t fragment, struct buff
 	return 0;
 }
 
-static int ufs_writepage(struct page *page, struct writeback_control *wbc)
+static int ufs_writepage(struct address_space *__mapping, struct page *page,
+			 struct writeback_control *wbc)
 {
 	return block_write_full_page(page,ufs_getfrag_block,wbc);
 }
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index da3716c5d8174..55d449b7a2b10 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -251,7 +251,8 @@ static struct vboxsf_handle *vboxsf_get_write_handle(struct vboxsf_inode *sf_i)
 	return sf_handle;
 }
 
-static int vboxsf_writepage(struct page *page, struct writeback_control *wbc)
+static int vboxsf_writepage(struct address_space *__mapping,
+			    struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct vboxsf_inode *sf_i = VBOXSF_I(inode);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 3e862efc2d881..6827f6226499a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -559,7 +559,7 @@ static const struct iomap_writeback_ops xfs_writeback_ops = {
 
 STATIC int
 xfs_vm_writepage(
-	struct page		*page,
+	struct address_space *__mapping, struct page		*page,
 	struct writeback_control *wbc)
 {
 	struct xfs_writepage_ctx wpc = { };
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 160190288f711..ee7175cf209a6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -112,7 +112,8 @@ static const struct iomap_writeback_ops zonefs_writeback_ops = {
 	.map_blocks		= zonefs_map_blocks,
 };
 
-static int zonefs_writepage(struct page *page, struct writeback_control *wbc)
+static int zonefs_writepage(struct address_space *__mapping,
+			    struct page *page, struct writeback_control *wbc)
 {
 	struct iomap_writepage_ctx wpc = { };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0326f24608544..acd51e3880762 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -370,7 +370,8 @@ typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
 struct address_space_operations {
-	int (*writepage)(struct page *page, struct writeback_control *wbc);
+	int (*writepage)(struct address_space *, struct page *page,
+			 struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct address_space *, struct page *);
 
 	/* Write back some dirty pages from this mapping. */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6d5b245bfa247..798497c5ebf0e 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -536,7 +536,8 @@ extern void nfs_complete_unlink(struct dentry *dentry, struct inode *);
  * linux/fs/nfs/write.c
  */
 extern int  nfs_congestion_kb;
-extern int  nfs_writepage(struct page *page, struct writeback_control *wbc);
+extern int  nfs_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc);
 extern int  nfs_writepages(struct address_space *, struct writeback_control *);
 extern int  nfs_flush_incompatible(struct file *file, struct page *page);
 extern int  nfs_updatepage(struct file *, struct page *, unsigned int, unsigned int);
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 661046994db4b..f2355fca8b38b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -392,7 +392,8 @@ extern void kswapd_stop(int nid);
 
 /* linux/mm/page_io.c */
 extern int swap_readpage(struct page *page, bool do_poll);
-extern int swap_writepage(struct page *page, struct writeback_control *wbc);
+extern int swap_writepage(struct address_space *__mapping, struct page *page,
+			  struct writeback_control *wbc);
 extern void end_swap_bio_write(struct bio *bio);
 extern int __swap_writepage(struct page *page, struct writeback_control *wbc,
 	bio_end_io_t end_write_func);
@@ -557,7 +558,9 @@ static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
-static inline int swap_writepage(struct page *p, struct writeback_control *wbc)
+static inline int swap_writepage(struct address_space *__mapping,
+				 struct page *p,
+				 struct writeback_control *wbc)
 {
 	return 0;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 04a98bb2f568f..21beb45356760 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -890,7 +890,7 @@ static int writeout(struct address_space *mapping, struct page *page)
 	 */
 	remove_migration_ptes(page, page, false);
 
-	rc = mapping->a_ops->writepage(page, &wbc);
+	rc = mapping->a_ops->writepage(MAPPING_NULL, page, &wbc);
 
 	if (rc != AOP_WRITEPAGE_ACTIVATE)
 		/* unlocked. Relock */
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 4e4ddd67b71e5..de15d2febc5ae 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2308,7 +2308,7 @@ static int __writepage(struct page *page, struct writeback_control *wbc,
 		       void *data)
 {
 	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(page, wbc);
+	int ret = mapping->a_ops->writepage(MAPPING_NULL, page, wbc);
 	mapping_set_error(mapping, ret);
 	return ret;
 }
@@ -2386,7 +2386,7 @@ int write_one_page(struct page *page)
 
 	if (clear_page_dirty_for_io(page)) {
 		get_page(page);
-		ret = mapping->a_ops->writepage(page, &wbc);
+		ret = mapping->a_ops->writepage(MAPPING_NULL, page, &wbc);
 		if (ret == 0)
 			wait_on_page_writeback(page);
 		put_page(page);
diff --git a/mm/page_io.c b/mm/page_io.c
index 8f1748c94c3a8..067159b23ee54 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -244,7 +244,8 @@ int generic_swapfile_activate(struct swap_info_struct *sis,
  * We may have stale swap cache pages in memory: notice
  * them here and get rid of the unnecessary final write.
  */
-int swap_writepage(struct page *page, struct writeback_control *wbc)
+int swap_writepage(struct address_space *__mapping, struct page *page,
+		   struct writeback_control *wbc)
 {
 	int ret = 0;
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 8e2b35ba93ad1..6f540e4f3a993 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1356,7 +1356,8 @@ int shmem_unuse(unsigned int type, bool frontswap,
 /*
  * Move the page from the page cache to the swap cache.
  */
-static int shmem_writepage(struct page *page, struct writeback_control *wbc)
+static int shmem_writepage(struct address_space *__mapping, struct page *page,
+			   struct writeback_control *wbc)
 {
 	struct shmem_inode_info *info;
 	struct address_space *mapping;
@@ -1448,7 +1449,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 
 		mutex_unlock(&shmem_swaplist_mutex);
 		BUG_ON(page_mapped(page));
-		swap_writepage(page, wbc);
+		swap_writepage(MAPPING_NULL, page, wbc);
 		return 0;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6db869339073d..4322bc5ee2d84 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -825,7 +825,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping)
 		};
 
 		SetPageReclaim(page);
-		res = mapping->a_ops->writepage(page, &wbc);
+		res = mapping->a_ops->writepage(MAPPING_NULL, page, &wbc);
 		if (res < 0)
 			handle_write_error(mapping, page, res);
 		if (res == AOP_WRITEPAGE_ACTIVATE) {
-- 
2.26.2

