Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20670C082
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEVN4F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 09:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbjEVNzg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 09:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5BDE5E
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 06:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684763536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UjNSdKZrHlxBh3wA/Y9ZbKC56elC+Zea+akHU7SRJyo=;
        b=XjjBFlQgOMMHUafe/9ako47LSbUsPUrqQqt5+/tW/BOqROga6baejiTUr/ftVBcYx1XLtB
        8grJ2bxENktjHaPIkypaaBV00BCQ/yQyAWzB4qOXNxc4Nh8Y1/PiA/gyw6vs6OiAbtkf3t
        UeOjqtM2dHoKEseJ6RfIojKurT01uP4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-F0Xhti4EOvm6lSyMZ6HFgg-1; Mon, 22 May 2023 09:52:15 -0400
X-MC-Unique: F0Xhti4EOvm6lSyMZ6HFgg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EC1E185A78B;
        Mon, 22 May 2023 13:52:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92ECD2166B25;
        Mon, 22 May 2023 13:52:11 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v22 28/31] splice: Use filemap_splice_read() instead of generic_file_splice_read()
Date:   Mon, 22 May 2023 14:50:15 +0100
Message-Id: <20230522135018.2742245-29-dhowells@redhat.com>
In-Reply-To: <20230522135018.2742245-1-dhowells@redhat.com>
References: <20230522135018.2742245-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace pointers to generic_file_splice_read() with calls to
filemap_splice_read().

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 block/fops.c            | 2 +-
 fs/adfs/file.c          | 2 +-
 fs/affs/file.c          | 2 +-
 fs/afs/file.c           | 2 +-
 fs/bfs/file.c           | 2 +-
 fs/btrfs/file.c         | 2 +-
 fs/cramfs/inode.c       | 2 +-
 fs/ecryptfs/file.c      | 4 ++--
 fs/erofs/data.c         | 2 +-
 fs/exfat/file.c         | 2 +-
 fs/ext2/file.c          | 2 +-
 fs/ext4/file.c          | 2 +-
 fs/fat/file.c           | 2 +-
 fs/fuse/file.c          | 2 +-
 fs/gfs2/file.c          | 4 ++--
 fs/hfs/inode.c          | 2 +-
 fs/hfsplus/inode.c      | 2 +-
 fs/hostfs/hostfs_kern.c | 2 +-
 fs/hpfs/file.c          | 2 +-
 fs/jffs2/file.c         | 2 +-
 fs/jfs/file.c           | 2 +-
 fs/minix/file.c         | 2 +-
 fs/nilfs2/file.c        | 2 +-
 fs/ntfs/file.c          | 2 +-
 fs/ntfs3/file.c         | 2 +-
 fs/ocfs2/file.c         | 2 +-
 fs/omfs/file.c          | 2 +-
 fs/ramfs/file-mmu.c     | 2 +-
 fs/ramfs/file-nommu.c   | 2 +-
 fs/read_write.c         | 2 +-
 fs/reiserfs/file.c      | 2 +-
 fs/romfs/mmap-nommu.c   | 2 +-
 fs/sysv/file.c          | 2 +-
 fs/ubifs/file.c         | 2 +-
 fs/udf/file.c           | 2 +-
 fs/ufs/file.c           | 2 +-
 fs/vboxsf/file.c        | 2 +-
 37 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d2e6be4e3d1c..6c9aa028af6e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -691,7 +691,7 @@ const struct file_operations def_blk_fops = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 };
diff --git a/fs/adfs/file.c b/fs/adfs/file.c
index 754afb14a6ff..ee80718aaeec 100644
--- a/fs/adfs/file.c
+++ b/fs/adfs/file.c
@@ -28,7 +28,7 @@ const struct file_operations adfs_file_operations = {
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
 	.write_iter	= generic_file_write_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 const struct inode_operations adfs_file_inode_operations = {
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 8daeed31e1af..e43f2f007ac1 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -1001,7 +1001,7 @@ const struct file_operations affs_file_operations = {
 	.open		= affs_file_open,
 	.release	= affs_file_release,
 	.fsync		= affs_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 const struct inode_operations affs_file_inode_operations = {
diff --git a/fs/afs/file.c b/fs/afs/file.c
index d8a6b09dadf7..d37dd201752b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -603,5 +603,5 @@ static ssize_t afs_file_splice_read(struct file *in, loff_t *ppos,
 	if (ret < 0)
 		return ret;
 
-	return generic_file_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 57ae5ee6deec..adc2230079c6 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -27,7 +27,7 @@ const struct file_operations bfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 static int bfs_move_block(unsigned long from, unsigned long to,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index f649647392e0..71426c6408fa 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3825,7 +3825,7 @@ static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 const struct file_operations btrfs_file_operations = {
 	.llseek		= btrfs_file_llseek,
 	.read_iter      = btrfs_file_read_iter,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.write_iter	= btrfs_file_write_iter,
 	.splice_write	= iter_file_splice_write,
 	.mmap		= btrfs_file_mmap,
diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 006ef68d7ff6..27c6597aa1be 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -473,7 +473,7 @@ static unsigned int cramfs_physmem_mmap_capabilities(struct file *file)
 static const struct file_operations cramfs_physmem_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
-	.splice_read		= generic_file_splice_read,
+	.splice_read		= filemap_splice_read,
 	.mmap			= cramfs_physmem_mmap,
 #ifndef CONFIG_MMU
 	.get_unmapped_area	= cramfs_physmem_get_unmapped_area,
diff --git a/fs/ecryptfs/file.c b/fs/ecryptfs/file.c
index 284395587be0..ce0a3c5ed0ca 100644
--- a/fs/ecryptfs/file.c
+++ b/fs/ecryptfs/file.c
@@ -47,7 +47,7 @@ static ssize_t ecryptfs_read_update_atime(struct kiocb *iocb,
 /*
  * ecryptfs_splice_read_update_atime
  *
- * generic_file_splice_read updates the atime of upper layer inode.  But, it
+ * filemap_splice_read updates the atime of upper layer inode.  But, it
  * doesn't give us a chance to update the atime of the lower layer inode.  This
  * function is a wrapper to generic_file_read.  It updates the atime of the
  * lower level inode if generic_file_read returns without any errors. This is
@@ -61,7 +61,7 @@ static ssize_t ecryptfs_splice_read_update_atime(struct file *in, loff_t *ppos,
 	ssize_t rc;
 	const struct path *path;
 
-	rc = generic_file_splice_read(in, ppos, pipe, len, flags);
+	rc = filemap_splice_read(in, ppos, pipe, len, flags);
 	if (rc >= 0) {
 		path = ecryptfs_dentry_to_lower_path(in->f_path.dentry);
 		touch_atime(path);
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6fe9a779fa91..db5e4b7636ec 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -448,5 +448,5 @@ const struct file_operations erofs_file_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= erofs_file_read_iter,
 	.mmap		= erofs_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index e99183a74611..3cbd270e0cba 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -389,7 +389,7 @@ const struct file_operations exfat_file_operations = {
 #endif
 	.mmap		= generic_file_mmap,
 	.fsync		= exfat_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 6b4bebe982ca..d1ae0f0a3726 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -192,7 +192,7 @@ const struct file_operations ext2_file_operations = {
 	.release	= ext2_release_file,
 	.fsync		= ext2_fsync,
 	.get_unmapped_area = thp_get_unmapped_area,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 9f8bbd9d131c..e8261900f4f3 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -155,7 +155,7 @@ static ssize_t ext4_file_splice_read(struct file *in, loff_t *ppos,
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
 		return -EIO;
-	return generic_file_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
 /*
diff --git a/fs/fat/file.c b/fs/fat/file.c
index 795a4fad5c40..456477946dd9 100644
--- a/fs/fat/file.c
+++ b/fs/fat/file.c
@@ -209,7 +209,7 @@ const struct file_operations fat_file_operations = {
 	.unlocked_ioctl	= fat_generic_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.fsync		= fat_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= fat_fallocate,
 };
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 89d97f6188e0..4553124f5406 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3252,7 +3252,7 @@ static const struct file_operations fuse_file_operations = {
 	.lock		= fuse_file_lock,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.flock		= fuse_file_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 300844f50dcd..0f5ad5165361 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1568,7 +1568,7 @@ const struct file_operations gfs2_file_fops = {
 	.fsync		= gfs2_fsync,
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
@@ -1599,7 +1599,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= generic_setlease,
 	.fallocate	= gfs2_fallocate,
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 1f7bd068acf0..441d7fc952e3 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -694,7 +694,7 @@ static const struct file_operations hfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.fsync		= hfs_file_fsync,
 	.open		= hfs_file_open,
 	.release	= hfs_file_release,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index b21660475ac1..7d1a675e037d 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -372,7 +372,7 @@ static const struct file_operations hfsplus_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.fsync		= hfsplus_file_fsync,
 	.open		= hfsplus_file_open,
 	.release	= hfsplus_file_release,
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index 28b4f15c19eb..87998df499f4 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -381,7 +381,7 @@ static int hostfs_fsync(struct file *file, loff_t start, loff_t end,
 
 static const struct file_operations hostfs_file_fops = {
 	.llseek		= generic_file_llseek,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 88952d4a631e..1bb8d97cd9ae 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -259,7 +259,7 @@ const struct file_operations hpfs_file_ops =
 	.mmap		= generic_file_mmap,
 	.release	= hpfs_file_release,
 	.fsync		= hpfs_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.unlocked_ioctl	= hpfs_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 };
diff --git a/fs/jffs2/file.c b/fs/jffs2/file.c
index 96b0275ce957..2345ca3f09ee 100644
--- a/fs/jffs2/file.c
+++ b/fs/jffs2/file.c
@@ -56,7 +56,7 @@ const struct file_operations jffs2_file_operations =
 	.unlocked_ioctl=jffs2_ioctl,
 	.mmap =		generic_file_readonly_mmap,
 	.fsync =	jffs2_fsync,
-	.splice_read =	generic_file_splice_read,
+	.splice_read =	filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 };
 
diff --git a/fs/jfs/file.c b/fs/jfs/file.c
index 2ee35be49de1..01b6912e60f8 100644
--- a/fs/jfs/file.c
+++ b/fs/jfs/file.c
@@ -144,7 +144,7 @@ const struct file_operations jfs_file_operations = {
 	.read_iter	= generic_file_read_iter,
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fsync		= jfs_fsync,
 	.release	= jfs_release,
diff --git a/fs/minix/file.c b/fs/minix/file.c
index 0dd05d47724a..906d192ab7f3 100644
--- a/fs/minix/file.c
+++ b/fs/minix/file.c
@@ -19,7 +19,7 @@ const struct file_operations minix_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 static int minix_setattr(struct mnt_idmap *idmap,
diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index a265d391ffe9..a9eb3487efb2 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -140,7 +140,7 @@ const struct file_operations nilfs_file_operations = {
 	.open		= generic_file_open,
 	/* .release	= nilfs_release_file, */
 	.fsync		= nilfs_sync_file,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write   = iter_file_splice_write,
 };
 
diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
index c481b14e4fd9..e5e0ed58670b 100644
--- a/fs/ntfs/file.c
+++ b/fs/ntfs/file.c
@@ -1992,7 +1992,7 @@ const struct file_operations ntfs_file_ops = {
 #endif /* NTFS_RW */
 	.mmap		= generic_file_mmap,
 	.open		= ntfs_file_open,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 const struct inode_operations ntfs_file_inode_ops = {
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 667c9dc68b58..036efd85f60c 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -770,7 +770,7 @@ static ssize_t ntfs_file_splice_read(struct file *in, loff_t *ppos,
 		return -EOPNOTSUPP;
 	}
 
-	return generic_file_splice_read(in, ppos, pipe, len, flags);
+	return filemap_splice_read(in, ppos, pipe, len, flags);
 }
 
 /*
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 86add13b5f23..42549fc81468 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2827,7 +2827,7 @@ const struct file_operations ocfs2_fops_no_plocks = {
 	.compat_ioctl   = ocfs2_compat_ioctl,
 #endif
 	.flock		= ocfs2_flock,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= ocfs2_fallocate,
 	.remap_file_range = ocfs2_remap_file_range,
diff --git a/fs/omfs/file.c b/fs/omfs/file.c
index 0101f1f87b56..de8f57ee39ec 100644
--- a/fs/omfs/file.c
+++ b/fs/omfs/file.c
@@ -334,7 +334,7 @@ const struct file_operations omfs_file_operations = {
 	.write_iter = generic_file_write_iter,
 	.mmap = generic_file_mmap,
 	.fsync = generic_file_fsync,
-	.splice_read = generic_file_splice_read,
+	.splice_read = filemap_splice_read,
 };
 
 static int omfs_setattr(struct mnt_idmap *idmap,
diff --git a/fs/ramfs/file-mmu.c b/fs/ramfs/file-mmu.c
index 12af0490322f..c7a1aa3c882b 100644
--- a/fs/ramfs/file-mmu.c
+++ b/fs/ramfs/file-mmu.c
@@ -43,7 +43,7 @@ const struct file_operations ramfs_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= noop_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.llseek		= generic_file_llseek,
 	.get_unmapped_area	= ramfs_mmu_get_unmapped_area,
diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 9fbb9b5256f7..efb1b4c1a0a4 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -43,7 +43,7 @@ const struct file_operations ramfs_file_operations = {
 	.read_iter		= generic_file_read_iter,
 	.write_iter		= generic_file_write_iter,
 	.fsync			= noop_fsync,
-	.splice_read		= generic_file_splice_read,
+	.splice_read		= filemap_splice_read,
 	.splice_write		= iter_file_splice_write,
 	.llseek			= generic_file_llseek,
 };
diff --git a/fs/read_write.c b/fs/read_write.c
index a21ba3be7dbe..b07de77ef126 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -29,7 +29,7 @@ const struct file_operations generic_ro_fops = {
 	.llseek		= generic_file_llseek,
 	.read_iter	= generic_file_read_iter,
 	.mmap		= generic_file_readonly_mmap,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 EXPORT_SYMBOL(generic_ro_fops);
diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index b54cc7048f02..8eb3ad3e8ae9 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -247,7 +247,7 @@ const struct file_operations reiserfs_file_operations = {
 	.fsync = reiserfs_sync_file,
 	.read_iter = generic_file_read_iter,
 	.write_iter = generic_file_write_iter,
-	.splice_read = generic_file_splice_read,
+	.splice_read = filemap_splice_read,
 	.splice_write = iter_file_splice_write,
 	.llseek = generic_file_llseek,
 };
diff --git a/fs/romfs/mmap-nommu.c b/fs/romfs/mmap-nommu.c
index 4578dc45e50a..4520ca413867 100644
--- a/fs/romfs/mmap-nommu.c
+++ b/fs/romfs/mmap-nommu.c
@@ -78,7 +78,7 @@ static unsigned romfs_mmap_capabilities(struct file *file)
 const struct file_operations romfs_ro_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
-	.splice_read		= generic_file_splice_read,
+	.splice_read		= filemap_splice_read,
 	.mmap			= romfs_mmap,
 	.get_unmapped_area	= romfs_get_unmapped_area,
 	.mmap_capabilities	= romfs_mmap_capabilities,
diff --git a/fs/sysv/file.c b/fs/sysv/file.c
index 50eb92557a0f..c645f60bdb7f 100644
--- a/fs/sysv/file.c
+++ b/fs/sysv/file.c
@@ -26,7 +26,7 @@ const struct file_operations sysv_file_operations = {
 	.write_iter	= generic_file_write_iter,
 	.mmap		= generic_file_mmap,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
 
 static int sysv_setattr(struct mnt_idmap *idmap,
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 979ab1d9d0c3..6738fe43040b 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1669,7 +1669,7 @@ const struct file_operations ubifs_file_operations = {
 	.mmap           = ubifs_file_mmap,
 	.fsync          = ubifs_fsync,
 	.unlocked_ioctl = ubifs_ioctl,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.open		= fscrypt_file_open,
 #ifdef CONFIG_COMPAT
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 8238f742377b..29daf5d5cb67 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -209,7 +209,7 @@ const struct file_operations udf_file_operations = {
 	.write_iter		= udf_file_write_iter,
 	.release		= udf_release_file,
 	.fsync			= generic_file_fsync,
-	.splice_read		= generic_file_splice_read,
+	.splice_read		= filemap_splice_read,
 	.splice_write		= iter_file_splice_write,
 	.llseek			= generic_file_llseek,
 };
diff --git a/fs/ufs/file.c b/fs/ufs/file.c
index 7e087581be7e..6558882a89ef 100644
--- a/fs/ufs/file.c
+++ b/fs/ufs/file.c
@@ -41,5 +41,5 @@ const struct file_operations ufs_file_operations = {
 	.mmap		= generic_file_mmap,
 	.open           = generic_file_open,
 	.fsync		= generic_file_fsync,
-	.splice_read	= generic_file_splice_read,
+	.splice_read	= filemap_splice_read,
 };
diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 572aa1c43b37..2307f8037efc 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -217,7 +217,7 @@ const struct file_operations vboxsf_reg_fops = {
 	.open = vboxsf_file_open,
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
-	.splice_read = generic_file_splice_read,
+	.splice_read = filemap_splice_read,
 };
 
 const struct inode_operations vboxsf_reg_iops = {

