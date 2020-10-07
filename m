Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8865D2855EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Oct 2020 03:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgJGBHa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Oct 2020 21:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbgJGBH3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Oct 2020 21:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602032842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x9P1LLBMEqzQNwfhkpMvWTYhDdcbv8FiPKdWarVUmqA=;
        b=bW6vAIceSj2lEv5KXwM8riXU2WNklYdJbADfBVPK0JD0r7B+DleIRHePbhQtLDYvEjR2qc
        iruDJxzigwUCslDInNyHYe/NKvO7UQPQvlB5dp4RZq97NvYOqjwcSmpV2sPBmHSftrwdB2
        K5Y2oihLzOck4gcfCOWq6e1GxHwN9uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-qi7AfLtkMKeHTwZXSBKEdw-1; Tue, 06 Oct 2020 21:07:20 -0400
X-MC-Unique: qi7AfLtkMKeHTwZXSBKEdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFF4C803F5B;
        Wed,  7 Oct 2020 01:07:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-161.rdu2.redhat.com [10.10.119.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6E25D9D2;
        Wed,  7 Oct 2020 01:07:17 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH 04/14] mm: add struct address_space to readpage() callback
Date:   Tue,  6 Oct 2020 21:05:53 -0400
Message-Id: <20201007010603.3452458-5-jglisse@redhat.com>
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

Add struct address_space to readpage() callback arguments.

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
// Part 1 is grepping all function that are use as callback for readpage.

// initialize file where we collect all function name (erase it)
@initialize:python depends on part1@
@@
file=open('/tmp/unicorn-functions', 'w')
file.close()

// match function name use as a callback
@p1r2 depends on part1@
identifier I1, FN;
@@
struct address_space_operations I1 = {..., .readpage = FN, ...};

@script:python p1r3 depends on p1r2@
funcname << p1r2.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  file.close()

@p1r4 depends on part1 exists@
expression E1, E2, E3;
identifier FN;
type T1;
@@
{...
(
read_cache_page(E1, E2, (T1)FN, E3)
|
read_cache_pages(E1, E2, (T1)FN, E3)
)
...}

@script:python p1r5 depends on p1r4@
funcname << p1r4.FN;
@@
if funcname != "NULL":
  file=open('/tmp/unicorn-functions', 'a')
  file.write(funcname + '\n')
  print(funcname)
  file.close()

// -------------------------------------------------------------------
// Part 2 modify callback

// Add address_space argument to the function (readpage callback one)
@p2r1 depends on part2@
identifier virtual.fn;
identifier I1, I2;
type T1, T2;
@@
int fn(T1 I1,
+struct address_space *__mapping,
T2 I2) { ... }

@p2r2 depends on part2@
identifier virtual.fn;
identifier I1, I2;
type T1, T2;
@@
int fn(T1 I1,
+struct address_space *__mapping,
T2 I2);

@p2r3 depends on part2@
identifier virtual.fn;
type T1, T2;
@@
int fn(T1,
+struct address_space *,
T2);

@p2r4 depends on part2@
identifier virtual.fn;
expression E1, E2;
@@
fn(E1,
+MAPPING_NULL,
E2)

// ----------------------------------------------------------------------------
// Part 3 is grepping all function that are use the callback for readpage.

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
E1.a_ops->readpage(E2, E3)
|
E1->a_ops->readpage(E2, E3)
)
...}

@script:python p3r2 depends on p3r1@
P << p3r1.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

@p3r4 depends on part3 exists@
expression E1, E2, E3, E4;
identifier FN;
position P;
@@
FN@P(...) {...
(
read_cache_page(E1, E2, E3, E4)
|
read_cache_pages(E1, E2, E3, E4)
)
...}

@script:python p3r5 depends on p3r4@
P << p3r4.P;
@@
file=open('/tmp/unicorn-files', 'a')
file.write(P[0].file + '\n')
file.close()

// -------------------------------------------------------------------
// Part 4 generic modification
@p4r1 depends on part4@
@@
struct address_space_operations { ... int (*readpage)(struct file *,
+struct address_space *,
struct page *); ... };

@p4r2 depends on part4@
expression E1, E2, E3;
@@
E1.a_ops->readpage(E2,
+MAPPING_NULL,
E3)

@p4r3 depends on part4@
expression E1, E2, E3;
@@
E1->a_ops->readpage(E2,
+MAPPING_NULL,
E3)

@p4r4 depends on part4@
@@
-typedef int (*filler_t)(void *, struct page *);
+typedef int (*filler_t)(void *, struct address_space *, struct page *);

@p4r5 depends on part4 exists@
identifier FN, I1;
expression E1, E2;
@@
FN(..., filler_t I1, ...) {...
I1(E1,
+MAPPING_NULL,
E2)
...}

@p4r6 depends on part4 exists@
struct address_space_operations *aops;
expression E1, E2;
@@
aops->readpage(E1,
+MAPPING_NULL,
E2)
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
 fs/9p/vfs_addr.c            | 11 +++++++----
 fs/adfs/inode.c             |  3 ++-
 fs/affs/file.c              |  6 ++++--
 fs/affs/symlink.c           |  4 +++-
 fs/afs/file.c               |  6 ++++--
 fs/befs/linuxvfs.c          | 13 +++++++++----
 fs/bfs/file.c               |  3 ++-
 fs/block_dev.c              |  4 +++-
 fs/btrfs/ctree.h            |  3 ++-
 fs/btrfs/disk-io.c          |  3 ++-
 fs/btrfs/file.c             |  2 +-
 fs/btrfs/free-space-cache.c |  2 +-
 fs/btrfs/inode.c            |  5 +++--
 fs/btrfs/ioctl.c            |  2 +-
 fs/btrfs/relocation.c       |  2 +-
 fs/btrfs/send.c             |  2 +-
 fs/buffer.c                 |  2 +-
 fs/cachefiles/rdwr.c        |  6 +++---
 fs/ceph/addr.c              |  3 ++-
 fs/cifs/file.c              |  3 ++-
 fs/coda/symlink.c           |  4 +++-
 fs/cramfs/inode.c           |  3 ++-
 fs/ecryptfs/mmap.c          |  4 +++-
 fs/efs/inode.c              |  3 ++-
 fs/efs/symlink.c            |  4 +++-
 fs/erofs/data.c             |  4 +++-
 fs/erofs/zdata.c            |  4 +++-
 fs/exfat/inode.c            |  3 ++-
 fs/ext2/inode.c             |  3 ++-
 fs/ext4/inode.c             |  3 ++-
 fs/f2fs/data.c              |  4 +++-
 fs/fat/inode.c              |  3 ++-
 fs/freevxfs/vxfs_immed.c    |  6 ++++--
 fs/freevxfs/vxfs_subr.c     |  6 ++++--
 fs/fuse/dir.c               |  4 +++-
 fs/fuse/file.c              |  3 ++-
 fs/gfs2/aops.c              |  8 +++++---
 fs/hfs/inode.c              |  3 ++-
 fs/hfsplus/inode.c          |  4 +++-
 fs/hostfs/hostfs_kern.c     |  3 ++-
 fs/hpfs/file.c              |  3 ++-
 fs/hpfs/namei.c             |  4 +++-
 fs/isofs/compress.c         |  3 ++-
 fs/isofs/inode.c            |  3 ++-
 fs/isofs/rock.c             |  4 +++-
 fs/jffs2/file.c             | 11 +++++++----
 fs/jffs2/os-linux.h         |  3 ++-
 fs/jfs/inode.c              |  3 ++-
 fs/jfs/jfs_metapage.c       |  3 ++-
 fs/libfs.c                  |  3 ++-
 fs/minix/inode.c            |  3 ++-
 fs/nfs/dir.c                |  3 ++-
 fs/nfs/file.c               |  2 +-
 fs/nfs/read.c               |  6 ++++--
 fs/nfs/symlink.c            |  3 ++-
 fs/nilfs2/inode.c           |  3 ++-
 fs/ntfs/aops.c              |  3 ++-
 fs/ocfs2/aops.c             |  3 ++-
 fs/ocfs2/symlink.c          |  4 +++-
 fs/omfs/file.c              |  3 ++-
 fs/orangefs/inode.c         |  4 +++-
 fs/qnx4/inode.c             |  3 ++-
 fs/qnx6/inode.c             |  3 ++-
 fs/reiserfs/inode.c         |  3 ++-
 fs/romfs/super.c            |  3 ++-
 fs/squashfs/file.c          |  4 +++-
 fs/squashfs/symlink.c       |  4 +++-
 fs/sysv/itree.c             |  3 ++-
 fs/ubifs/file.c             |  3 ++-
 fs/udf/file.c               |  4 +++-
 fs/udf/inode.c              |  3 ++-
 fs/udf/symlink.c            |  4 +++-
 fs/ufs/inode.c              |  3 ++-
 fs/vboxsf/file.c            |  3 ++-
 fs/xfs/xfs_aops.c           |  2 +-
 fs/zonefs/super.c           |  3 ++-
 include/linux/fs.h          |  5 +++--
 include/linux/nfs_fs.h      |  2 +-
 include/linux/pagemap.h     |  2 +-
 mm/filemap.c                |  9 +++++----
 mm/page_io.c                |  2 +-
 mm/readahead.c              |  4 ++--
 82 files changed, 207 insertions(+), 106 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2d..79fa773dbe95e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -35,7 +35,8 @@
  * @page: structure to page
  *
  */
-static int v9fs_fid_readpage(void *data, struct page *page)
+static int v9fs_fid_readpage(void *data, struct address_space *__mapping,
+			     struct page *page)
 {
 	struct p9_fid *fid = data;
 	struct inode *inode = page->mapping->host;
@@ -80,9 +81,11 @@ static int v9fs_fid_readpage(void *data, struct page *page)
  *
  */
 
-static int v9fs_vfs_readpage(struct file *filp, struct page *page)
+static int v9fs_vfs_readpage(struct file *filp,
+			     struct address_space *__mapping,
+			     struct page *page)
 {
-	return v9fs_fid_readpage(filp->private_data, page);
+	return v9fs_fid_readpage(filp->private_data, MAPPING_NULL, page);
 }
 
 /**
@@ -279,7 +282,7 @@ static int v9fs_write_begin(struct file *filp, struct address_space *mapping,
 	if (len == PAGE_SIZE)
 		goto out;
 
-	retval = v9fs_fid_readpage(v9inode->writeback_fid, page);
+	retval = v9fs_fid_readpage(v9inode->writeback_fid, MAPPING_NULL, page);
 	put_page(page);
 	if (!retval)
 		goto start;
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 32620f4a7623e..2a29f7d4a4dd0 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -38,7 +38,8 @@ static int adfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, adfs_get_block, wbc);
 }
 
-static int adfs_readpage(struct file *file, struct page *page)
+static int adfs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return block_read_full_page(page, adfs_get_block);
 }
diff --git a/fs/affs/file.c b/fs/affs/file.c
index d91b0133d95da..a20d5a1298335 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -375,7 +375,8 @@ static int affs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, affs_get_block, wbc);
 }
 
-static int affs_readpage(struct file *file, struct page *page)
+static int affs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return block_read_full_page(page, affs_get_block);
 }
@@ -627,7 +628,8 @@ affs_extent_file_ofs(struct inode *inode, u32 newsize)
 }
 
 static int
-affs_readpage_ofs(struct file *file, struct page *page)
+affs_readpage_ofs(struct file *file, struct address_space *__mapping,
+		  struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	u32 to;
diff --git a/fs/affs/symlink.c b/fs/affs/symlink.c
index a7531b26e8f02..f6fca124002e8 100644
--- a/fs/affs/symlink.c
+++ b/fs/affs/symlink.c
@@ -11,7 +11,9 @@
 
 #include "affs.h"
 
-static int affs_symlink_readpage(struct file *file, struct page *page)
+static int affs_symlink_readpage(struct file *file,
+				 struct address_space *__mapping,
+				 struct page *page)
 {
 	struct buffer_head *bh;
 	struct inode *inode = page->mapping->host;
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 371d1488cc549..908f9e3196251 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -17,7 +17,8 @@
 #include "internal.h"
 
 static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
-static int afs_readpage(struct file *file, struct page *page);
+static int afs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page);
 static void afs_invalidatepage(struct page *page, unsigned int offset,
 			       unsigned int length);
 static int afs_releasepage(struct page *page, gfp_t gfp_flags);
@@ -388,7 +389,8 @@ int afs_page_filler(void *data, struct page *page)
  * read page from file, directory or symlink, given a file to nominate the key
  * to be used
  */
-static int afs_readpage(struct file *file, struct page *page)
+static int afs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	struct key *key;
 	int ret;
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 2482032021cac..4bf5395fb4eeb 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -40,7 +40,8 @@ MODULE_LICENSE("GPL");
 
 static int befs_readdir(struct file *, struct dir_context *);
 static int befs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-static int befs_readpage(struct file *file, struct page *page);
+static int befs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page);
 static sector_t befs_bmap(struct address_space *mapping, sector_t block);
 static struct dentry *befs_lookup(struct inode *, struct dentry *,
 				  unsigned int);
@@ -48,7 +49,8 @@ static struct inode *befs_iget(struct super_block *, unsigned long);
 static struct inode *befs_alloc_inode(struct super_block *sb);
 static void befs_free_inode(struct inode *inode);
 static void befs_destroy_inodecache(void);
-static int befs_symlink_readpage(struct file *, struct page *);
+static int befs_symlink_readpage(struct file *, struct address_space *,
+				 struct page *);
 static int befs_utf2nls(struct super_block *sb, const char *in, int in_len,
 			char **out, int *out_len);
 static int befs_nls2utf(struct super_block *sb, const char *in, int in_len,
@@ -109,7 +111,8 @@ static const struct export_operations befs_export_operations = {
  * positions to disk blocks.
  */
 static int
-befs_readpage(struct file *file, struct page *page)
+befs_readpage(struct file *file, struct address_space *__mapping,
+	      struct page *page)
 {
 	return block_read_full_page(page, befs_get_block);
 }
@@ -468,7 +471,9 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int befs_symlink_readpage(struct file *unused, struct page *page)
+static int befs_symlink_readpage(struct file *unused,
+				 struct address_space *__mapping,
+				 struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 0dceefc54b48a..4154c23e23e24 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -155,7 +155,8 @@ static int bfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, bfs_get_block, wbc);
 }
 
-static int bfs_readpage(struct file *file, struct page *page)
+static int bfs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return block_read_full_page(page, bfs_get_block);
 }
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 8ae833e004439..b8e6e1995f396 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -598,7 +598,9 @@ static int blkdev_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, blkdev_get_block, wbc);
 }
 
-static int blkdev_readpage(struct file * file, struct page * page)
+static int blkdev_readpage(struct file * file,
+			   struct address_space *__mapping,
+			   struct page * page)
 {
 	return block_read_full_page(page, blkdev_get_block);
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 9a72896bed2ee..038fe30aadd94 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2976,7 +2976,8 @@ int btrfs_bio_fits_in_stripe(struct page *page, size_t size, struct bio *bio,
 			     unsigned long bio_flags);
 void btrfs_set_range_writeback(struct extent_io_tree *tree, u64 start, u64 end);
 vm_fault_t btrfs_page_mkwrite(struct vm_fault *vmf);
-int btrfs_readpage(struct file *file, struct page *page);
+int btrfs_readpage(struct file *file, struct address_space *__mapping,
+		   struct page *page);
 void btrfs_evict_inode(struct inode *inode);
 int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 struct inode *btrfs_alloc_inode(struct super_block *sb);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9f72b092bc228..51ca16ab59e07 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -951,7 +951,8 @@ static int btree_writepages(struct address_space *mapping,
 	return btree_write_cache_pages(mapping, wbc);
 }
 
-static int btree_readpage(struct file *file, struct page *page)
+static int btree_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	return extent_read_full_page(page, btree_get_extent, 0);
 }
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 4507c3d093994..db14f654973d0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1385,7 +1385,7 @@ static int prepare_uptodate_page(struct inode *inode,
 
 	if (((pos & (PAGE_SIZE - 1)) || force_uptodate) &&
 	    !PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
+		ret = btrfs_readpage(NULL, MAPPING_NULL, page);
 		if (ret)
 			return ret;
 		lock_page(page);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index dc82fd0c80cbb..b2d9e45478fd6 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -386,7 +386,7 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 		}
 		io_ctl->pages[i] = page;
 		if (uptodate && !PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_readpage(NULL, MAPPING_NULL, page);
 			lock_page(page);
 			if (page->mapping != inode->i_mapping) {
 				btrfs_err(BTRFS_I(inode)->root->fs_info,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9570458aa8471..1213671571bb2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4560,7 +4560,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	}
 
 	if (!PageUptodate(page)) {
-		ret = btrfs_readpage(NULL, page);
+		ret = btrfs_readpage(NULL, MAPPING_NULL, page);
 		lock_page(page);
 		if (page->mapping != mapping) {
 			unlock_page(page);
@@ -8005,7 +8005,8 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	return extent_fiemap(inode, fieinfo, start, len);
 }
 
-int btrfs_readpage(struct file *file, struct page *page)
+int btrfs_readpage(struct file *file, struct address_space *__mapping,
+		   struct page *page)
 {
 	return extent_read_full_page(page, btrfs_get_extent, 0);
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 2d9109d9e98f9..9ab9292bfb91d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1321,7 +1321,7 @@ static int cluster_pages_for_defrag(struct inode *inode,
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_readpage(NULL, MAPPING_NULL, page);
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 4ba1ab9cc76db..09d6165d256bd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2734,7 +2734,7 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_readpage(NULL, MAPPING_NULL, page);
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d9813a5b075ac..e8de679bd8186 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -4853,7 +4853,7 @@ static ssize_t fill_read_buf(struct send_ctx *sctx, u64 offset, u32 len)
 		}
 
 		if (!PageUptodate(page)) {
-			btrfs_readpage(NULL, page);
+			btrfs_readpage(NULL, MAPPING_NULL, page);
 			lock_page(page);
 			if (!PageUptodate(page)) {
 				unlock_page(page);
diff --git a/fs/buffer.c b/fs/buffer.c
index 50bbc99e3d960..c99a468833828 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2855,7 +2855,7 @@ int nobh_truncate_page(struct address_space *mapping,
 
 	/* Ok, it's mapped. Make sure it's up-to-date */
 	if (!PageUptodate(page)) {
-		err = mapping->a_ops->readpage(NULL, page);
+		err = mapping->a_ops->readpage(NULL, MAPPING_NULL, page);
 		if (err) {
 			put_page(page);
 			goto out;
diff --git a/fs/cachefiles/rdwr.c b/fs/cachefiles/rdwr.c
index 3080cda9e8245..0da0a49b93e6a 100644
--- a/fs/cachefiles/rdwr.c
+++ b/fs/cachefiles/rdwr.c
@@ -119,7 +119,7 @@ static int cachefiles_read_reissue(struct cachefiles_object *object,
 			goto unlock_discard;
 
 		_debug("reissue read");
-		ret = bmapping->a_ops->readpage(NULL, backpage);
+		ret = bmapping->a_ops->readpage(NULL, MAPPING_NULL, backpage);
 		if (ret < 0)
 			goto unlock_discard;
 	}
@@ -281,7 +281,7 @@ static int cachefiles_read_backing_file_one(struct cachefiles_object *object,
 	newpage = NULL;
 
 read_backing_page:
-	ret = bmapping->a_ops->readpage(NULL, backpage);
+	ret = bmapping->a_ops->readpage(NULL, MAPPING_NULL, backpage);
 	if (ret < 0)
 		goto read_error;
 
@@ -519,7 +519,7 @@ static int cachefiles_read_backing_file(struct cachefiles_object *object,
 		newpage = NULL;
 
 	reread_backing_page:
-		ret = bmapping->a_ops->readpage(NULL, backpage);
+		ret = bmapping->a_ops->readpage(NULL, MAPPING_NULL, backpage);
 		if (ret < 0)
 			goto read_error;
 
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6ea761c84494f..69a19e1b6b2ec 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -288,7 +288,8 @@ static int ceph_do_readpage(struct file *filp, struct page *page)
 	return err < 0 ? err : 0;
 }
 
-static int ceph_readpage(struct file *filp, struct page *page)
+static int ceph_readpage(struct file *filp, struct address_space *__mapping,
+			 struct page *page)
 {
 	int r = ceph_do_readpage(filp, page);
 	if (r != -EINPROGRESS)
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index be46fab4c96d8..f1d974218dfcd 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4547,7 +4547,8 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 	return rc;
 }
 
-static int cifs_readpage(struct file *file, struct page *page)
+static int cifs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	loff_t offset = (loff_t)page->index << PAGE_SHIFT;
 	int rc = -EACCES;
diff --git a/fs/coda/symlink.c b/fs/coda/symlink.c
index 8907d05081988..6d2479c056679 100644
--- a/fs/coda/symlink.c
+++ b/fs/coda/symlink.c
@@ -20,7 +20,9 @@
 #include "coda_psdev.h"
 #include "coda_linux.h"
 
-static int coda_symlink_filler(struct file *file, struct page *page)
+static int coda_symlink_filler(struct file *file,
+			       struct address_space *__mapping,
+			       struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	int error;
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600d393..01b61a2463c4f 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -817,7 +817,8 @@ static struct dentry *cramfs_lookup(struct inode *dir, struct dentry *dentry, un
 	return d_splice_alias(inode, dentry);
 }
 
-static int cramfs_readpage(struct file *file, struct page *page)
+static int cramfs_readpage(struct file *file, struct address_space *__mapping,
+			   struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	u32 maxblock;
diff --git a/fs/ecryptfs/mmap.c b/fs/ecryptfs/mmap.c
index 019572c6b39ac..163cfff9c2a1f 100644
--- a/fs/ecryptfs/mmap.c
+++ b/fs/ecryptfs/mmap.c
@@ -177,7 +177,9 @@ ecryptfs_copy_up_encrypted_with_header(struct page *page,
  *
  * Returns zero on success; non-zero on error.
  */
-static int ecryptfs_readpage(struct file *file, struct page *page)
+static int ecryptfs_readpage(struct file *file,
+			     struct address_space *__mapping,
+			     struct page *page)
 {
 	struct ecryptfs_crypt_stat *crypt_stat =
 		&ecryptfs_inode_to_private(page->mapping->host)->crypt_stat;
diff --git a/fs/efs/inode.c b/fs/efs/inode.c
index 89e73a6f0d361..705ed12ce78f4 100644
--- a/fs/efs/inode.c
+++ b/fs/efs/inode.c
@@ -14,7 +14,8 @@
 #include "efs.h"
 #include <linux/efs_fs_sb.h>
 
-static int efs_readpage(struct file *file, struct page *page)
+static int efs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return block_read_full_page(page,efs_get_block);
 }
diff --git a/fs/efs/symlink.c b/fs/efs/symlink.c
index 923eb91654d5c..ae45c6bd44bc4 100644
--- a/fs/efs/symlink.c
+++ b/fs/efs/symlink.c
@@ -12,7 +12,9 @@
 #include <linux/buffer_head.h>
 #include "efs.h"
 
-static int efs_symlink_readpage(struct file *file, struct page *page)
+static int efs_symlink_readpage(struct file *file,
+				struct address_space *__mapping,
+				struct page *page)
 {
 	char *link = page_address(page);
 	struct buffer_head * bh;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 459ecb42cbd3b..c0ca49afddbd3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -263,7 +263,9 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
  * since we dont have write or truncate flows, so no inode
  * locking needs to be held at the moment.
  */
-static int erofs_raw_access_readpage(struct file *file, struct page *page)
+static int erofs_raw_access_readpage(struct file *file,
+				     struct address_space *__mapping,
+				     struct page *page)
 {
 	erofs_off_t last_block;
 	struct bio *bio;
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6c939def00f95..1da99bd146a22 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1271,7 +1271,9 @@ static void z_erofs_runqueue(struct super_block *sb,
 	z_erofs_decompress_queue(&io[JQ_SUBMIT], pagepool);
 }
 
-static int z_erofs_readpage(struct file *file, struct page *page)
+static int z_erofs_readpage(struct file *file,
+			    struct address_space *__mapping,
+			    struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 7f90204adef53..2c8f3f6b65ae5 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -359,7 +359,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	return err;
 }
 
-static int exfat_readpage(struct file *file, struct page *page)
+static int exfat_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	return mpage_readpage(page, exfat_get_block);
 }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 415c21f0e7508..46f10453ab32e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -870,7 +870,8 @@ static int ext2_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, ext2_get_block, wbc);
 }
 
-static int ext2_readpage(struct file *file, struct page *page)
+static int ext2_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return mpage_readpage(page, ext2_get_block);
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234c..82283d11cd740 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3214,7 +3214,8 @@ static sector_t ext4_bmap(struct address_space *mapping, sector_t block)
 	return iomap_bmap(mapping, block, &ext4_iomap_ops);
 }
 
-static int ext4_readpage(struct file *file, struct page *page)
+static int ext4_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	int ret = -EAGAIN;
 	struct inode *inode = page->mapping->host;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 73683e58a08d5..dbbfaa8cd9602 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2445,7 +2445,9 @@ static int f2fs_mpage_readpages(struct inode *inode,
 	return ret;
 }
 
-static int f2fs_read_data_page(struct file *file, struct page *page)
+static int f2fs_read_data_page(struct file *file,
+			       struct address_space *__mapping,
+			       struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	int ret = -EAGAIN;
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index a0cf99debb1ec..6ef4e7619684d 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -205,7 +205,8 @@ static int fat_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, fat_get_block);
 }
 
-static int fat_readpage(struct file *file, struct page *page)
+static int fat_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return mpage_readpage(page, fat_get_block);
 }
diff --git a/fs/freevxfs/vxfs_immed.c b/fs/freevxfs/vxfs_immed.c
index bfc780c682fb8..8a0d251121aa3 100644
--- a/fs/freevxfs/vxfs_immed.c
+++ b/fs/freevxfs/vxfs_immed.c
@@ -38,7 +38,8 @@
 #include "vxfs_inode.h"
 
 
-static int	vxfs_immed_readpage(struct file *, struct page *);
+static int	vxfs_immed_readpage(struct file *, struct address_space *,
+				      struct page *);
 
 /*
  * Address space operations for immed files and directories.
@@ -63,7 +64,8 @@ const struct address_space_operations vxfs_immed_aops = {
  *   @page is locked and will be unlocked.
  */
 static int
-vxfs_immed_readpage(struct file *fp, struct page *pp)
+vxfs_immed_readpage(struct file *fp, struct address_space *__mapping,
+		    struct page *pp)
 {
 	struct vxfs_inode_info	*vip = VXFS_INO(pp->mapping->host);
 	u_int64_t	offset = (u_int64_t)pp->index << PAGE_SHIFT;
diff --git a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
index e806694d4145e..fcab7a85d6006 100644
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -38,7 +38,8 @@
 #include "vxfs_extern.h"
 
 
-static int		vxfs_readpage(struct file *, struct page *);
+static int		vxfs_readpage(struct file *, struct address_space *,
+					struct page *);
 static sector_t		vxfs_bmap(struct address_space *, sector_t);
 
 const struct address_space_operations vxfs_aops = {
@@ -156,7 +157,8 @@ vxfs_getblk(struct inode *ip, sector_t iblock,
  *   @page is locked and will be unlocked.
  */
 static int
-vxfs_readpage(struct file *file, struct page *page)
+vxfs_readpage(struct file *file, struct address_space *__mapping,
+	      struct page *page)
 {
 	return block_read_full_page(page, vxfs_getblk);
 }
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 26f028bc760b2..e09a82f826427 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1770,7 +1770,9 @@ void fuse_init_dir(struct inode *inode)
 	fi->rdc.version = 0;
 }
 
-static int fuse_symlink_readpage(struct file *null, struct page *page)
+static int fuse_symlink_readpage(struct file *null,
+				 struct address_space *__mapping,
+				 struct page *page)
 {
 	int err = fuse_readlink_page(page->mapping->host, page);
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 43c165e796da2..f7c6b4b711a86 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -839,7 +839,8 @@ static int fuse_do_readpage(struct file *file, struct page *page)
 	return 0;
 }
 
-static int fuse_readpage(struct file *file, struct page *page)
+static int fuse_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	int err;
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index d4af283fc8886..e3b5f5fa08bec 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -468,7 +468,8 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 }
 
 
-static int __gfs2_readpage(void *file, struct page *page)
+static int __gfs2_readpage(void *file, struct address_space *__mapping,
+			   struct page *page)
 {
 	struct gfs2_inode *ip = GFS2_I(page->mapping->host);
 	struct gfs2_sbd *sdp = GFS2_SB(page->mapping->host);
@@ -496,9 +497,10 @@ static int __gfs2_readpage(void *file, struct page *page)
  * @page: The page of the file
  */
 
-static int gfs2_readpage(struct file *file, struct page *page)
+static int gfs2_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
-	return __gfs2_readpage(file, page);
+	return __gfs2_readpage(file, MAPPING_NULL, page);
 }
 
 /**
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index f35a37c65e5ff..ae193e389e22e 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -34,7 +34,8 @@ static int hfs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, hfs_get_block, wbc);
 }
 
-static int hfs_readpage(struct file *file, struct page *page)
+static int hfs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return block_read_full_page(page, hfs_get_block);
 }
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e3da9e96b8357..9955b8dcb8061 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -22,7 +22,9 @@
 #include "hfsplus_raw.h"
 #include "xattr.h"
 
-static int hfsplus_readpage(struct file *file, struct page *page)
+static int hfsplus_readpage(struct file *file,
+			    struct address_space *__mapping,
+			    struct page *page)
 {
 	return block_read_full_page(page, hfsplus_get_block);
 }
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e97..0b78c8bf11717 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -431,7 +431,8 @@ static int hostfs_writepage(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int hostfs_readpage(struct file *file, struct page *page)
+static int hostfs_readpage(struct file *file, struct address_space *__mapping,
+			   struct page *page)
 {
 	char *buffer;
 	loff_t start = page_offset(page);
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 077c25128eb74..28be564b9eba8 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -116,7 +116,8 @@ static int hpfs_get_block(struct inode *inode, sector_t iblock, struct buffer_he
 	return r;
 }
 
-static int hpfs_readpage(struct file *file, struct page *page)
+static int hpfs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return mpage_readpage(page, hpfs_get_block);
 }
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 1aee39160ac5b..02b6457d10c65 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -475,7 +475,9 @@ static int hpfs_rmdir(struct inode *dir, struct dentry *dentry)
 	return err;
 }
 
-static int hpfs_symlink_readpage(struct file *file, struct page *page)
+static int hpfs_symlink_readpage(struct file *file,
+				 struct address_space *__mapping,
+				 struct page *page)
 {
 	char *link = page_address(page);
 	struct inode *i = page->mapping->host;
diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
index bc12ac7e23127..9811e5e1937d5 100644
--- a/fs/isofs/compress.c
+++ b/fs/isofs/compress.c
@@ -296,7 +296,8 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
  * per reference.  We inject the additional pages into the page
  * cache as a form of readahead.
  */
-static int zisofs_readpage(struct file *file, struct page *page)
+static int zisofs_readpage(struct file *file, struct address_space *__mapping,
+			   struct page *page)
 {
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index 78f5c96c76f31..eef14b3d4a7ef 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1175,7 +1175,8 @@ struct buffer_head *isofs_bread(struct inode *inode, sector_t block)
 	return sb_bread(inode->i_sb, blknr);
 }
 
-static int isofs_readpage(struct file *file, struct page *page)
+static int isofs_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	return mpage_readpage(page, isofs_get_block);
 }
diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 94ef92fe806c4..c27d67aba3ead 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -690,7 +690,9 @@ int parse_rock_ridge_inode(struct iso_directory_record *de, struct inode *inode,
  * readpage() for symlinks: reads symlink contents into the page and either
  * makes it uptodate and returns 0 or returns error (-EIO)
  */
-static int rock_ridge_symlink_readpage(struct file *file, struct page *page)
+static int rock_ridge_symlink_readpage(struct file *file,
+				       struct address_space *__mapping,
+				       struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct iso_inode_info *ei = ISOFS_I(inode);
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227c..edb6066979391 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -27,7 +27,8 @@ static int jffs2_write_end(struct file *filp, struct address_space *mapping,
 static int jffs2_write_begin(struct file *filp, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
-static int jffs2_readpage (struct file *filp, struct page *pg);
+static int jffs2_readpage (struct file *filp, struct address_space *__mapping,
+			   struct page *pg);
 
 int jffs2_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
 {
@@ -109,7 +110,8 @@ static int jffs2_do_readpage_nolock (struct inode *inode, struct page *pg)
 	return ret;
 }
 
-int jffs2_do_readpage_unlock(void *data, struct page *pg)
+int jffs2_do_readpage_unlock(void *data, struct address_space *__mapping,
+			     struct page *pg)
 {
 	int ret = jffs2_do_readpage_nolock(data, pg);
 	unlock_page(pg);
@@ -117,13 +119,14 @@ int jffs2_do_readpage_unlock(void *data, struct page *pg)
 }
 
 
-static int jffs2_readpage (struct file *filp, struct page *pg)
+static int jffs2_readpage (struct file *filp, struct address_space *__mapping,
+			   struct page *pg)
 {
 	struct jffs2_inode_info *f = JFFS2_INODE_INFO(pg->mapping->host);
 	int ret;
 
 	mutex_lock(&f->sem);
-	ret = jffs2_do_readpage_unlock(pg->mapping->host, pg);
+	ret = jffs2_do_readpage_unlock(pg->mapping->host, MAPPING_NULL, pg);
 	mutex_unlock(&f->sem);
 	return ret;
 }
diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index ef1cfa61549e6..f711b1cce9abd 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -155,7 +155,8 @@ extern const struct file_operations jffs2_file_operations;
 extern const struct inode_operations jffs2_file_inode_operations;
 extern const struct address_space_operations jffs2_file_address_operations;
 int jffs2_fsync(struct file *, loff_t, loff_t, int);
-int jffs2_do_readpage_unlock(void *data, struct page *pg);
+int jffs2_do_readpage_unlock(void *data, struct address_space *__mapping,
+			     struct page *pg);
 
 /* ioctl.c */
 long jffs2_ioctl(struct file *, unsigned int, unsigned long);
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 6f65bfa9f18d5..41b77aac394d6 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -291,7 +291,8 @@ static int jfs_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, jfs_get_block);
 }
 
-static int jfs_readpage(struct file *file, struct page *page)
+static int jfs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return mpage_readpage(page, jfs_get_block);
 }
diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index a2f5338a5ea18..e9dae1dccb42b 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -468,7 +468,8 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 	return -EIO;
 }
 
-static int metapage_readpage(struct file *fp, struct page *page)
+static int metapage_readpage(struct file *fp, struct address_space *__mapping,
+			     struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct bio *bio = NULL;
diff --git a/fs/libfs.c b/fs/libfs.c
index e0d42e977d9af..7df05487cdde6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -507,7 +507,8 @@ int simple_setattr(struct dentry *dentry, struct iattr *iattr)
 }
 EXPORT_SYMBOL(simple_setattr);
 
-int simple_readpage(struct file *file, struct page *page)
+int simple_readpage(struct file *file, struct address_space *__mapping,
+		    struct page *page)
 {
 	clear_highpage(page);
 	flush_dcache_page(page);
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 7b09a9158e401..9677f0424a72d 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -403,7 +403,8 @@ static int minix_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page, minix_get_block, wbc);
 }
 
-static int minix_readpage(struct file *file, struct page *page)
+static int minix_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	return block_read_full_page(page,minix_get_block);
 }
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index da1fe71ae810d..5a5c021967d3f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -706,7 +706,8 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
  * We only need to convert from xdr once so future lookups are much simpler
  */
 static
-int nfs_readdir_filler(void *data, struct page* page)
+int nfs_readdir_filler(void *data, struct address_space *__mapping,
+		       struct page* page)
 {
 	nfs_readdir_descriptor_t *desc = data;
 	struct inode	*inode = file_inode(desc->file);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be1..02e2112d77f86 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -341,7 +341,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	} else if (!once_thru &&
 		   nfs_want_read_modify_write(file, page, pos, len)) {
 		once_thru = 1;
-		ret = nfs_readpage(file, page);
+		ret = nfs_readpage(file, MAPPING_NULL, page);
 		put_page(page);
 		if (!ret)
 			goto start;
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index eb854f1f86e2e..dadff06079267 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -310,7 +310,8 @@ static void nfs_readpage_result(struct rpc_task *task,
  *  -	The error flag is set for this page. This happens only when a
  *	previous async read operation failed.
  */
-int nfs_readpage(struct file *file, struct page *page)
+int nfs_readpage(struct file *file, struct address_space *__mapping,
+		 struct page *page)
 {
 	struct nfs_open_context *ctx;
 	struct inode *inode = page_file_mapping(page)->host;
@@ -373,7 +374,8 @@ struct nfs_readdesc {
 };
 
 static int
-readpage_async_filler(void *data, struct page *page)
+readpage_async_filler(void *data, struct address_space *__mapping,
+		      struct page *page)
 {
 	struct nfs_readdesc *desc = (struct nfs_readdesc *)data;
 	struct nfs_page *new;
diff --git a/fs/nfs/symlink.c b/fs/nfs/symlink.c
index 76691d94ae5f8..6f77ea2ba7e08 100644
--- a/fs/nfs/symlink.c
+++ b/fs/nfs/symlink.c
@@ -26,7 +26,8 @@
  * and straight-forward than readdir caching.
  */
 
-static int nfs_symlink_filler(void *data, struct page *page)
+static int nfs_symlink_filler(void *data, struct address_space *__mapping,
+			      struct page *page)
 {
 	struct inode *inode = data;
 	int error;
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 745d371d6fea6..f1e5cc46ce00b 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -141,7 +141,8 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
  * @file - file struct of the file to be read
  * @page - the page to be read
  */
-static int nilfs_readpage(struct file *file, struct page *page)
+static int nilfs_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	return mpage_readpage(page, nilfs_get_block);
 }
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index bb0a43860ad26..ca0bcec9ac2f6 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -375,7 +375,8 @@ static int ntfs_read_block(struct page *page)
  *
  * Return 0 on success and -errno on error.
  */
-static int ntfs_readpage(struct file *file, struct page *page)
+static int ntfs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	loff_t i_size;
 	struct inode *vi;
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 3bfb4147895a0..a5f9686ae100d 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -277,7 +277,8 @@ static int ocfs2_readpage_inline(struct inode *inode, struct page *page)
 	return ret;
 }
 
-static int ocfs2_readpage(struct file *file, struct page *page)
+static int ocfs2_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
diff --git a/fs/ocfs2/symlink.c b/fs/ocfs2/symlink.c
index 94cfacc9bad70..8017957fd6529 100644
--- a/fs/ocfs2/symlink.c
+++ b/fs/ocfs2/symlink.c
@@ -54,7 +54,9 @@
 #include "buffer_head_io.h"
 
 
-static int ocfs2_fast_symlink_readpage(struct file *unused, struct page *page)
+static int ocfs2_fast_symlink_readpage(struct file *unused,
+				       struct address_space *__mapping,
+				       struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 2c7b70ee1388c..c55fd61021b65 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -284,7 +284,8 @@ static int omfs_get_block(struct inode *inode, sector_t block,
 	return ret;
 }
 
-static int omfs_readpage(struct file *file, struct page *page)
+static int omfs_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return block_read_full_page(page, omfs_get_block);
 }
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850e..6d797c789f035 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,7 +244,9 @@ static int orangefs_writepages(struct address_space *mapping,
 
 static int orangefs_launder_page(struct page *);
 
-static int orangefs_readpage(struct file *file, struct page *page)
+static int orangefs_readpage(struct file *file,
+			     struct address_space *__mapping,
+			     struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct iov_iter iter;
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index e8da1cde87b9b..f8d92fa828321 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -246,7 +246,8 @@ static void qnx4_kill_sb(struct super_block *sb)
 	}
 }
 
-static int qnx4_readpage(struct file *file, struct page *page)
+static int qnx4_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return block_read_full_page(page,qnx4_get_block);
 }
diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
index 755293c8c71a6..74d24efaf1223 100644
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -94,7 +94,8 @@ static int qnx6_check_blockptr(__fs32 ptr)
 	return 1;
 }
 
-static int qnx6_readpage(struct file *file, struct page *page)
+static int qnx6_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return mpage_readpage(page, qnx6_get_block);
 }
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index 1509775da040a..3f7638fd6eeca 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -2738,7 +2738,8 @@ static int reiserfs_write_full_page(struct page *page,
 	goto done;
 }
 
-static int reiserfs_readpage(struct file *f, struct page *page)
+static int reiserfs_readpage(struct file *f, struct address_space *__mapping,
+			     struct page *page)
 {
 	return block_read_full_page(page, reiserfs_get_block);
 }
diff --git a/fs/romfs/super.c b/fs/romfs/super.c
index e582d001f792e..62957a6fe4c15 100644
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -99,7 +99,8 @@ static struct inode *romfs_iget(struct super_block *sb, unsigned long pos);
 /*
  * read a page worth of data from the image
  */
-static int romfs_readpage(struct file *file, struct page *page)
+static int romfs_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	loff_t offset, size;
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 7b1128398976e..13ef295affc2f 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -444,7 +444,9 @@ static int squashfs_readpage_sparse(struct page *page, int expected)
 	return 0;
 }
 
-static int squashfs_readpage(struct file *file, struct page *page)
+static int squashfs_readpage(struct file *file,
+			     struct address_space *__mapping,
+			     struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
diff --git a/fs/squashfs/symlink.c b/fs/squashfs/symlink.c
index 1430613183e6e..2b9f9fb28b550 100644
--- a/fs/squashfs/symlink.c
+++ b/fs/squashfs/symlink.c
@@ -30,7 +30,9 @@
 #include "squashfs.h"
 #include "xattr.h"
 
-static int squashfs_symlink_readpage(struct file *file, struct page *page)
+static int squashfs_symlink_readpage(struct file *file,
+				     struct address_space *__mapping,
+				     struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index bcb67b0cabe7e..eaca724493b3d 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -456,7 +456,8 @@ static int sysv_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,get_block,wbc);
 }
 
-static int sysv_readpage(struct file *file, struct page *page)
+static int sysv_readpage(struct file *file, struct address_space *__mapping,
+			 struct page *page)
 {
 	return block_read_full_page(page,get_block);
 }
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index b77d1637bbbc8..7b868f220ca7d 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -890,7 +890,8 @@ static int ubifs_bulk_read(struct page *page)
 	return err;
 }
 
-static int ubifs_readpage(struct file *file, struct page *page)
+static int ubifs_readpage(struct file *file, struct address_space *__mapping,
+			  struct page *page)
 {
 	if (ubifs_bulk_read(page))
 		return 0;
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 628941a6b79af..6d3a2291856fe 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -57,7 +57,9 @@ static void __udf_adinicb_readpage(struct page *page)
 	kunmap_atomic(kaddr);
 }
 
-static int udf_adinicb_readpage(struct file *file, struct page *page)
+static int udf_adinicb_readpage(struct file *file,
+				struct address_space *__mapping,
+				struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 	__udf_adinicb_readpage(page);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index adaba8e8b326e..5bceaf7456be7 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -190,7 +190,8 @@ static int udf_writepages(struct address_space *mapping,
 	return mpage_writepages(mapping, wbc, udf_get_block);
 }
 
-static int udf_readpage(struct file *file, struct page *page)
+static int udf_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return mpage_readpage(page, udf_get_block);
 }
diff --git a/fs/udf/symlink.c b/fs/udf/symlink.c
index 25ff91c7e94af..c7766a8a53884 100644
--- a/fs/udf/symlink.c
+++ b/fs/udf/symlink.c
@@ -101,7 +101,9 @@ static int udf_pc_to_char(struct super_block *sb, unsigned char *from,
 	return 0;
 }
 
-static int udf_symlink_filler(struct file *file, struct page *page)
+static int udf_symlink_filler(struct file *file,
+			      struct address_space *__mapping,
+			      struct page *page)
 {
 	struct inode *inode = page->mapping->host;
 	struct buffer_head *bh = NULL;
diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index c843ec858cf7c..4f44e309cfaf5 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -472,7 +472,8 @@ static int ufs_writepage(struct page *page, struct writeback_control *wbc)
 	return block_write_full_page(page,ufs_getfrag_block,wbc);
 }
 
-static int ufs_readpage(struct file *file, struct page *page)
+static int ufs_readpage(struct file *file, struct address_space *__mapping,
+			struct page *page)
 {
 	return block_read_full_page(page,ufs_getfrag_block);
 }
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a8..da3716c5d8174 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -208,7 +208,8 @@ const struct inode_operations vboxsf_reg_iops = {
 	.setattr = vboxsf_setattr
 };
 
-static int vboxsf_readpage(struct file *file, struct page *page)
+static int vboxsf_readpage(struct file *file, struct address_space *__mapping,
+			   struct page *page)
 {
 	struct vboxsf_handle *sf_handle = file->private_data;
 	loff_t off = page_offset(page);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index b35611882ff9c..3e862efc2d881 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -616,7 +616,7 @@ xfs_vm_bmap(
 STATIC int
 xfs_vm_readpage(
 	struct file		*unused,
-	struct page		*page)
+	struct address_space *__mapping, struct page		*page)
 {
 	return iomap_readpage(page, &xfs_read_iomap_ops);
 }
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 8ec7c8f109d7d..160190288f711 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -74,7 +74,8 @@ static const struct iomap_ops zonefs_iomap_ops = {
 	.iomap_begin	= zonefs_iomap_begin,
 };
 
-static int zonefs_readpage(struct file *unused, struct page *page)
+static int zonefs_readpage(struct file *unused,
+			   struct address_space *__mapping, struct page *page)
 {
 	return iomap_readpage(page, &zonefs_iomap_ops);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 7519ae003a082..0326f24608544 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -371,7 +371,7 @@ typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 
 struct address_space_operations {
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
-	int (*readpage)(struct file *, struct page *);
+	int (*readpage)(struct file *, struct address_space *, struct page *);
 
 	/* Write back some dirty pages from this mapping. */
 	int (*writepages)(struct address_space *, struct writeback_control *);
@@ -3227,7 +3227,8 @@ extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
 extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
-extern int simple_readpage(struct file *file, struct page *page);
+extern int simple_readpage(struct file *file, struct address_space *__mapping,
+			   struct page *page);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,
 			struct page **pagep, void **fsdata);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a2c6455ea3fae..6d5b245bfa247 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -562,7 +562,7 @@ nfs_have_writebacks(struct inode *inode)
 /*
  * linux/fs/nfs/read.c
  */
-extern int  nfs_readpage(struct file *, struct page *);
+extern int  nfs_readpage(struct file *, struct address_space *, struct page *);
 extern int  nfs_readpages(struct file *, struct address_space *,
 		struct list_head *, unsigned);
 extern int  nfs_readpage_async(struct nfs_open_context *, struct inode *,
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 9acfc605b3bc3..6473ea9dc1ea9 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -264,7 +264,7 @@ static inline gfp_t readahead_gfp_mask(struct address_space *x)
 	return mapping_gfp_mask(x) | __GFP_NORETRY | __GFP_NOWARN;
 }
 
-typedef int (*filler_t)(void *, struct page *);
+typedef int (*filler_t)(void *, struct address_space *, struct page *);
 
 pgoff_t page_cache_next_miss(struct address_space *mapping,
 			     pgoff_t index, unsigned long max_scan);
diff --git a/mm/filemap.c b/mm/filemap.c
index ba892599a2717..b67a253e5e6c7 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2349,7 +2349,7 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 		 */
 		ClearPageError(page);
 		/* Start the actual read. The read will unlock the page. */
-		error = mapping->a_ops->readpage(filp, page);
+		error = mapping->a_ops->readpage(filp, MAPPING_NULL, page);
 
 		if (unlikely(error)) {
 			if (error == AOP_TRUNCATED_PAGE) {
@@ -2751,7 +2751,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 */
 	ClearPageError(page);
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
-	error = mapping->a_ops->readpage(file, page);
+	error = mapping->a_ops->readpage(file, MAPPING_NULL, page);
 	if (!error) {
 		wait_on_page_locked(page);
 		if (!PageUptodate(page))
@@ -2961,9 +2961,10 @@ static struct page *do_read_cache_page(struct address_space *mapping,
 
 filler:
 		if (filler)
-			err = filler(data, page);
+			err = filler(data, MAPPING_NULL, page);
 		else
-			err = mapping->a_ops->readpage(data, page);
+			err = mapping->a_ops->readpage(data, MAPPING_NULL,
+						       page);
 
 		if (err < 0) {
 			put_page(page);
diff --git a/mm/page_io.c b/mm/page_io.c
index e485a6e8a6cdd..8f1748c94c3a8 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -397,7 +397,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
-		ret = mapping->a_ops->readpage(swap_file, page);
+		ret = mapping->a_ops->readpage(swap_file, MAPPING_NULL, page);
 		if (!ret)
 			count_vm_event(PSWPIN);
 		goto out;
diff --git a/mm/readahead.c b/mm/readahead.c
index cd67c9cfa931a..b42690f62e3ae 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -102,7 +102,7 @@ int read_cache_pages(struct address_space *mapping, struct list_head *pages,
 		}
 		put_page(page);
 
-		ret = filler(data, page);
+		ret = filler(data, MAPPING_NULL, page);
 		if (unlikely(ret)) {
 			read_cache_pages_invalidate_pages(mapping, pages);
 			break;
@@ -142,7 +142,7 @@ static void read_pages(struct readahead_control *rac, struct list_head *pages,
 		rac->_nr_pages = 0;
 	} else {
 		while ((page = readahead_page(rac))) {
-			aops->readpage(rac->file, page);
+			aops->readpage(rac->file, MAPPING_NULL, page);
 			put_page(page);
 		}
 	}
-- 
2.26.2

