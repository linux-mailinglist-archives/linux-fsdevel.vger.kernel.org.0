Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B37E211451
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGAUXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727933AbgGAUXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:23:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF37C08C5C1;
        Wed,  1 Jul 2020 13:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YzDDaoK/+bKkYUNaHNfEKBPE908qYyeOFsntDjI1DdQ=; b=D4A1jiPWfpQ253RFClW+SZtFzi
        nk4LTqbjEnnVmFG20wAOrF9gdCg5RqWbXrurE/HqYzG7eiXet9XBv+tMeJSjLlwu48uHE3bjc2U9I
        CpQLVTYg2blsirxYcm19vUpD5vA1zxLH+OtbqVkCacRD9XKLiB2UvwAHR03JuPH+DG76DWdF00S0M
        pH5H3FRiY2vz7VTuaPG5fz1zHuui8yVLZhUvhPU37oBlAf58/FafUnxKWIG8QEG3GoZz96CRWsaQ6
        ZlgUdQX7C/Yrohy5lBNPmUJYwZ/v+vHRcRsSebCvNX3aOl/S7VDQ1s7noNgnQaUdczkrb0lO5oYYV
        SxPwXpXg==;
Received: from [2001:4bb8:18c:3b3b:379a:a079:66b5:89c3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqjGQ-0002Tw-1z; Wed, 01 Jul 2020 20:23:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/23] fs: default to generic_file_splice_read for files having ->read_iter
Date:   Wed,  1 Jul 2020 22:09:50 +0200
Message-Id: <20200701200951.3603160-23-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701200951.3603160-1-hch@lst.de>
References: <20200701200951.3603160-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a file implements the ->read_iter method, the iter based splice read
works and is always preferred over the ->read based one.  Use it by
default in do_splice_to and remove all the direct assignment of
generic_file_splice_read to file_operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/adfs/file.c          | 1 -
 fs/affs/file.c          | 1 -
 fs/afs/file.c           | 1 -
 fs/bfs/file.c           | 1 -
 fs/block_dev.c          | 1 -
 fs/btrfs/file.c         | 1 -
 fs/ceph/file.c          | 1 -
 fs/cifs/cifsfs.c        | 6 ------
 fs/coda/file.c          | 1 -
 fs/cramfs/inode.c       | 1 -
 fs/ecryptfs/file.c      | 1 -
 fs/exfat/file.c         | 1 -
 fs/ext2/file.c          | 1 -
 fs/ext4/file.c          | 1 -
 fs/f2fs/file.c          | 1 -
 fs/fat/file.c           | 1 -
 fs/fuse/file.c          | 1 -
 fs/gfs2/file.c          | 2 --
 fs/hfs/inode.c          | 1 -
 fs/hfsplus/inode.c      | 1 -
 fs/hostfs/hostfs_kern.c | 1 -
 fs/hpfs/file.c          | 1 -
 fs/jffs2/file.c         | 1 -
 fs/jfs/file.c           | 1 -
 fs/minix/file.c         | 1 -
 fs/nfs/file.c           | 1 -
 fs/nfs/nfs4file.c       | 1 -
 fs/nilfs2/file.c        | 1 -
 fs/ntfs/file.c          | 1 -
 fs/ocfs2/file.c         | 2 --
 fs/omfs/file.c          | 1 -
 fs/ramfs/file-mmu.c     | 1 -
 fs/ramfs/file-nommu.c   | 1 -
 fs/read_write.c         | 1 -
 fs/reiserfs/file.c      | 1 -
 fs/romfs/mmap-nommu.c   | 1 -
 fs/splice.c             | 2 ++
 fs/sysv/file.c          | 1 -
 fs/ubifs/file.c         | 1 -
 fs/udf/file.c           | 1 -
 fs/ufs/file.c           | 1 -
 fs/vboxsf/file.c        | 1 -
 fs/xfs/xfs_file.c       | 1 -
 fs/zonefs/super.c       | 1 -
 mm/shmem.c              | 1 -
 45 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/fs/adfs/file.c b/fs/adfs/file.c
index 754afb14a6ff74..b089b91c1870ae 100644
--- a/fs/adfs/file.c
+++ b/fs/adfs/file.c
@@ -28,7 +28,6 @@ const struct file_operations adfs_file_operations = {
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
 	.write_iter	= generic_file_write_iter,
-	.splice_read	= generic_file_splice_read,
 };
 
 const struct inode_operations adfs_file_inode_operations = {
diff --git a/fs/affs/file.c b/fs/affs/file.c
index a85817f54483f7..7d51cc2e3dabfa 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -975,7 +975,6 @@ const struct file_operations affs_file_operations = {
 	.open		= affs_file_open,
 	.release	= affs_file_release,
 	.fsync		= affs_file_fsync,
-	.splice_read	= generic_file_splice_read,
 };
 
 const struct inode_operations affs_file_inode_operations = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index 6f6ed1605cfe30..2476f10383fbdd 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -32,7 +32,6 @@ const struct file_operations afs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= afs_file_write,
 	.mmap		= afs_file_mmap,
-	.splice_read	= generic_file_splice_read,
 	.fsync		= afs_fsync,
 	.lock		= afs_lock,
 	.flock		= afs_flock,
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 0dceefc54b48ab..39088cc7492308 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -27,7 +27,6 @@ const struct file_operations bfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
 };
 
 static int bfs_move_block(unsigned long from, unsigned long to,
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0ae656e022fd57..0aa66a6075eb11 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -2160,7 +2160,6 @@ const struct file_operations def_blk_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 };
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 2520605afc256e..322cc65902d107 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3507,7 +3507,6 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
 	.read_iter      = generic_file_read_iter,
-	.splice_read	= generic_file_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.mmap		= btrfs_file_mmap,
 	.open		= btrfs_file_open,
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 160644ddaeed70..e28c27751e6b3b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2507,7 +2507,6 @@ const struct file_operations ceph_file_fops = {
 	.fsync = ceph_fsync,
 	.lock = ceph_lock,
 	.flock = ceph_flock,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl = ceph_ioctl,
 	.compat_ioctl = compat_ptr_ioctl,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 0fb99d25e8a8a0..74da1dfe08c6fa 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1235,7 +1235,6 @@ const struct file_operations cifs_file_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1255,7 +1254,6 @@ const struct file_operations cifs_file_strict_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1275,7 +1273,6 @@ const struct file_operations cifs_file_direct_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
@@ -1293,7 +1290,6 @@ const struct file_operations cifs_file_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap  = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1311,7 +1307,6 @@ const struct file_operations cifs_file_strict_nobrl_ops = {
 	.fsync = cifs_strict_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_strict_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = cifs_llseek,
 	.unlocked_ioctl	= cifs_ioctl,
@@ -1329,7 +1324,6 @@ const struct file_operations cifs_file_direct_nobrl_ops = {
 	.fsync = cifs_fsync,
 	.flush = cifs_flush,
 	.mmap = cifs_file_mmap,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.unlocked_ioctl  = cifs_ioctl,
 	.copy_file_range = cifs_copy_file_range,
diff --git a/fs/coda/file.c b/fs/coda/file.c
index 128d63df5bfb62..8dd438f2c09fe2 100644
--- a/fs/coda/file.c
+++ b/fs/coda/file.c
@@ -301,5 +301,4 @@ const struct file_operations coda_file_operations = {
 	.open		= coda_open,
 	.release	= coda_release,
 	.fsync		= coda_fsync,
-	.splice_read	= generic_file_splice_read,
 };
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 912308600d393d..0645c1af27c07d 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -485,7 +485,6 @@ static unsigned int cramfs_physmem_mmap_capabilities(struct file *file)
 static const struct file_operations cramfs_physmem_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
-	.splice_read		= generic_file_splice_read,
 	.mmap			= cramfs_physmem_mmap,
 #ifndef CONFIG_MMU
 	.get_unmapped_area	= cramfs_physmem_get_unmapped_area,
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 5fb45d865ce511..03210a02fe6c00 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -420,5 +420,4 @@ const struct file_operations ecryptfs_main_fops = {
 	.release = ecryptfs_release,
 	.fsync = ecryptfs_fsync,
 	.fasync = ecryptfs_fasync,
-	.splice_read = generic_file_splice_read,
 };
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index fce03f31878735..708d1360c13ec1 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -352,7 +352,6 @@ const struct file_operations exfat_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 60378ddf1424b0..1c0828e0198440 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -191,7 +191,6 @@ const struct file_operations ext2_file_operations = {
 	.release	= ext2_release_file,
 	.fsync		= ext2_fsync,
 	.get_unmapped_area = thp_get_unmapped_area,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2a01e31a032c4c..f5dc9a4e0937d1 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -896,7 +896,6 @@ const struct file_operations ext4_file_operations = {
 	.release	= ext4_release_file,
 	.fsync		= ext4_sync_file,
 	.get_unmapped_area = thp_get_unmapped_area,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ext4_fallocate,
 };
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3268f8dd59bbaf..6b34caf13b5668 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4033,6 +4033,5 @@ const struct file_operations f2fs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= f2fs_compat_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 42134c58c87e19..e7a0342ccfe1f0 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -208,7 +208,6 @@ const struct file_operations fat_file_operations = {
 	.unlocked_ioctl	= fat_generic_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.fsync		= fat_file_fsync,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= fat_fallocate,
 };
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e573b0cd2737dc..a404e147bb2cf7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3382,7 +3382,6 @@ static const struct file_operations fuse_file_operations = {
 	.fsync		= fuse_fsync,
 	.lock		= fuse_file_lock,
 	.flock		= fuse_file_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index fe305e4bfd3734..d23babc0c292b8 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1323,7 +1323,6 @@ const struct file_operations gfs2_file_fops = {
 	.fsync		= gfs2_fsync,
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
@@ -1354,7 +1353,6 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= generic_setlease,
 	.fallocate	= gfs2_fallocate,
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 2f224b98ee94a6..6181d3818e17c0 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -682,7 +682,6 @@ static const struct file_operations hfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
 	.fsync		= hfs_file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index e3da9e96b83578..7bd61ba08fbc9e 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -358,7 +358,6 @@ static const struct file_operations hfsplus_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
 	.fsync		= hfsplus_file_fsync,
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e977..c6453e3768294c 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -379,7 +379,6 @@ static int hostfs_fsync(struct file *file, loff_t start, loff_t end,
 
 static const struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
-	.splice_read	= generic_file_splice_read,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 077c25128eb741..53951f29f25e50 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -213,7 +213,6 @@ const struct file_operations hpfs_file_ops =
 	.mmap		= generic_file_mmap,
 	.release	= hpfs_file_release,
 	.fsync		= hpfs_file_fsync,
-	.splice_read	= generic_file_splice_read,
 	.unlocked_ioctl	= hpfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index f8fb89b10227ce..6e986a99669779 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -56,7 +56,6 @@ const struct file_operations jffs2_file_operations =
 	.unlocked_ioctl=jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
-	.splice_read =	generic_file_splice_read,
 };
 
 /* jffs2_file_inode_operations */
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 930d2701f2062b..fb209673943697 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -141,7 +141,6 @@ const struct file_operations jfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
diff --git a/fs/minix/file.c b/fs/minix/file.c
index c50b0a20fcd9c1..e787789b43fa95 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -19,7 +19,6 @@ const struct file_operations minix_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
 };
 
 static int minix_setattr(struct dentry *dentry, struct iattr *attr)
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index ccd6c1637b270b..8ba06f6c3ec5af 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -851,7 +851,6 @@ const struct file_operations nfs_file_operations = {
 	.fsync		= nfs_file_fsync,
 	.lock		= nfs_lock,
 	.flock		= nfs_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd359..3e3793cb217ec1 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -415,7 +415,6 @@ const struct file_operations nfs4_file_operations = {
 	.fsync		= nfs_file_fsync,
 	.lock		= nfs_lock,
 	.flock		= nfs_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.check_flags	= nfs_check_flags,
 	.setlease	= simple_nosetlease,
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index 64bc81363c6cc0..cb3269c52dabc7 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -140,7 +140,6 @@ const struct file_operations nilfs_file_operations = {
 	.open		= generic_file_open,
 	/* .release	= nilfs_release_file, */
 	.fsync		= nilfs_sync_file,
-	.splice_read	= generic_file_splice_read,
 };
 
 const struct inode_operations nilfs_file_inode_operations = {
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index f42967b738eb67..8c1759e9185dd7 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -2012,7 +2012,6 @@ const struct file_operations ntfs_file_ops = {
 #endif /* NTFS_RW */
 	.mmap		= generic_file_mmap,
 	.open		= ntfs_file_open,
-	.splice_read	= generic_file_splice_read,
 };
 
 const struct inode_operations ntfs_file_inode_ops = {
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 85979e2214b39d..86069cae29047e 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2671,7 +2671,6 @@ const struct file_operations ocfs2_fops = {
 #endif
 	.lock		= ocfs2_lock,
 	.flock		= ocfs2_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
@@ -2717,7 +2716,6 @@ const struct file_operations ocfs2_fops_no_plocks = {
 	.compat_ioctl   = ocfs2_compat_ioctl,
 #endif
 	.flock		= ocfs2_flock,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index d7b5f09d298c9d..0dddc6c644c10c 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -340,7 +340,6 @@ const struct file_operations omfs_file_operations = {
 	.write_iter = generic_file_write_iter,
 	.mmap = generic_file_mmap,
 	.fsync = generic_file_fsync,
-	.splice_read = generic_file_splice_read,
 };
 
 static int omfs_setattr(struct dentry *dentry, struct iattr *attr)
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index 12af0490322f9d..d1e76267e9c323 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -43,7 +43,6 @@ const struct file_operations ramfs_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.llseek		= generic_file_llseek,
 	.get_unmapped_area	= ramfs_mmu_get_unmapped_area,
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 41469545495608..9336086e60fefd 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -43,7 +43,6 @@ const struct file_operations ramfs_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.write_iter		= generic_file_write_iter,
 	.fsync			= noop_fsync,
-	.splice_read		= generic_file_splice_read,
 	.splice_write		= iter_file_splice_write,
 	.llseek			= generic_file_llseek,
 };
diff --git a/fs/read_write.c b/fs/read_write.c
index 2a2e4efed47395..21b017a5377d3f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -29,7 +29,6 @@ const struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.mmap		= generic_file_readonly_mmap,
-	.splice_read	= generic_file_splice_read,
 };
 
 EXPORT_SYMBOL(generic_ro_fops);
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 0b641ae694f123..4f71c3aca2b8c1 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -247,7 +247,6 @@ const struct file_operations reiserfs_file_operations = {
 	.fsync = reiserfs_sync_file,
 	.read_iter = generic_file_read_iter,
 	.write_iter = generic_file_write_iter,
-	.splice_read = generic_file_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = generic_file_llseek,
 };
diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 2c4a23113fb5f2..f37e27fa0c1084 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -78,7 +78,6 @@ static unsigned romfs_mmap_capabilities(struct file *file)
 const struct file_operations romfs_ro_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
-	.splice_read		= generic_file_splice_read,
 	.mmap			= romfs_mmap,
 	.get_unmapped_area	= romfs_get_unmapped_area,
 	.mmap_capabilities	= romfs_mmap_capabilities,
diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07ff..52485158023778 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -868,6 +868,8 @@ static long do_splice_to(struct file *in, loff_t *ppos,
 
 	if (in->f_op->splice_read)
 		return in->f_op->splice_read(in, ppos, pipe, len, flags);
+	if (in->f_op->read_iter)
+		return generic_file_splice_read(in, ppos, pipe, len, flags);
 	return default_file_splice_read(in, ppos, pipe, len, flags);
 }
 
diff --git a/fs/sysv/file.c b/fs/sysv/file.c
index 45fc79a18594f1..d023922c0e44c7 100644
--- a/fs/sysv/file.c
+++ b/fs/sysv/file.c
@@ -26,7 +26,6 @@ const struct file_operations sysv_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
 };
 
 static int sysv_setattr(struct dentry *dentry, struct iattr *attr)
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 49fe062ce45ec2..a3af46b3950811 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1668,7 +1668,6 @@ const struct file_operations ubifs_file_operations = {
 	.mmap           = ubifs_file_mmap,
 	.fsync          = ubifs_fsync,
 	.unlocked_ioctl = ubifs_ioctl,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.open		= fscrypt_file_open,
 #ifdef CONFIG_COMPAT
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 628941a6b79afb..6c796ef2bd8331 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -250,7 +250,6 @@ const struct file_operations udf_file_operations = {
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= generic_file_fsync,
-	.splice_read		= generic_file_splice_read,
 	.llseek			= generic_file_llseek,
 };
 
diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index 7e087581be7e0c..7a6dbb32d22cb6 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -41,5 +41,4 @@ const struct file_operations ufs_file_operations = {
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
 };
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index c4ab5996d97a83..30671e1226dbed 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -200,7 +200,6 @@ const struct file_operations vboxsf_reg_fops = {
 	.open = vboxsf_file_open,
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
-	.splice_read = generic_file_splice_read,
 };
 
 const struct inode_operations vboxsf_reg_iops = {
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 00db81eac80d6c..964bc733e765a4 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1297,7 +1297,6 @@ const struct file_operations xfs_file_operations = {
 	.llseek		= xfs_file_llseek,
 	.read_iter	= xfs_file_read_iter,
 	.write_iter	= xfs_file_write_iter,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iomap_dio_iopoll,
 	.unlocked_ioctl	= xfs_file_ioctl,
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 07bc42d62673ce..d9f5fbeb55062e 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -869,7 +869,6 @@ static const struct file_operations zonefs_file_operations = {
 	.llseek		= zonefs_file_llseek,
 	.read_iter	= zonefs_file_read_iter,
 	.write_iter	= zonefs_file_write_iter,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iomap_dio_iopoll,
 };
diff --git a/mm/shmem.c b/mm/shmem.c
index a0dbe62f8042e7..f019ff50084403 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3756,7 +3756,6 @@ static const struct file_operations shmem_file_operations = {
 	.read_iter	= shmem_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= shmem_fallocate,
 #endif
-- 
2.26.2

