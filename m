Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAF4179A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Sep 2021 19:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343814AbhIXRUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Sep 2021 13:20:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347724AbhIXRT4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632503902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98vjdU3chxPFXFBTBaOBXAwecDWuSSqTqG27FOFg2mk=;
        b=Xf2npMzd164GNd4Xu/JEIQgdsO5NWrlVMCeFAjXM5dbcYL87fHLlxTE7AXW39kIU5BhMPo
        yKXoghbaKh/RV4UARADyJIx52i9JYpAf6mkZs0kJf2FsTs/1LbN8JQoy6Bh0NXTCyfl2S1
        91BsCTWiI4JmBZmAPAijggGCQMqYnUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-4OSQiREVNYWeJbgSSn2jwg-1; Fri, 24 Sep 2021 13:18:21 -0400
X-MC-Unique: 4OSQiREVNYWeJbgSSn2jwg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05801084681;
        Fri, 24 Sep 2021 17:18:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ACB519724;
        Fri, 24 Sep 2021 17:18:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v3 2/9] mm: Add 'supports' field to the
 address_space_operations to list features
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, dhowells@redhat.com, dhowells@redhat.com,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        jlayton@kernel.org, torvalds@linux-foundation.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 18:18:14 +0100
Message-ID: <163250389458.2330363.17234460134406104577.stgit@warthog.procyon.org.uk>
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rather than depending on .direct_IO to point to something to indicate that
direct I/O is supported, add a 'supports' bitmask that we can test, since
we only need one bit.

We can then remove noop_direct_IO, ceph_direct_io and cifs_direct_io.

[Question: Some filesystems support read DIO but not write DIO - should I
 split the flag?]

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Darrick J. Wong <djwong@kernel.org>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: ceph-devel@vger.kernel.org
cc: Steve French <sfrench@samba.org>
cc: linux-cifs@vger.kernel.org
cc: linux-xfs@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---

 Documentation/filesystems/vfs.rst |    8 ++++++++
 block/fops.c                      |    1 +
 drivers/block/loop.c              |    6 +++---
 fs/9p/vfs_addr.c                  |    1 +
 fs/affs/file.c                    |    1 +
 fs/btrfs/inode.c                  |    2 +-
 fs/ceph/addr.c                    |   13 +------------
 fs/cifs/file.c                    |   21 +--------------------
 fs/erofs/data.c                   |    2 +-
 fs/exfat/inode.c                  |    1 +
 fs/ext2/inode.c                   |    4 +++-
 fs/ext4/inode.c                   |    8 ++++----
 fs/f2fs/data.c                    |    1 +
 fs/fat/inode.c                    |    1 +
 fs/fcntl.c                        |    2 +-
 fs/fuse/dax.c                     |    2 +-
 fs/fuse/file.c                    |    1 +
 fs/gfs2/aops.c                    |    2 +-
 fs/hfs/inode.c                    |    1 +
 fs/hfsplus/inode.c                |    1 +
 fs/jfs/inode.c                    |    1 +
 fs/libfs.c                        |   12 ------------
 fs/nfs/file.c                     |    1 +
 fs/nilfs2/inode.c                 |    1 +
 fs/ntfs3/inode.c                  |    1 +
 fs/ocfs2/aops.c                   |    1 +
 fs/open.c                         |    3 ++-
 fs/orangefs/inode.c               |    1 +
 fs/overlayfs/file.c               |    2 +-
 fs/overlayfs/inode.c              |    3 +--
 fs/reiserfs/inode.c               |    1 +
 fs/udf/file.c                     |    1 +
 fs/udf/inode.c                    |    1 +
 fs/xfs/xfs_aops.c                 |    4 ++--
 fs/zonefs/super.c                 |    2 +-
 include/linux/fs.h                |    4 +++-
 36 files changed, 53 insertions(+), 65 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index bf5c48066fac..abb844792d6a 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -721,6 +721,7 @@ cache in your filesystem.  The following members are defined:
 .. code-block:: c
 
 	struct address_space_operations {
+		unsigned int supports;
 		int (*writepage)(struct page *page, struct writeback_control *wbc);
 		int (*readpage)(struct file *, struct page *);
 		int (*writepages)(struct address_space *, struct writeback_control *);
@@ -755,6 +756,13 @@ cache in your filesystem.  The following members are defined:
 		int (*swap_deactivate)(struct file *);
 	};
 
+``supports``
+	provides a list of features supported by address_spaces using this
+	operations set.  The following feature support flags are provided:
+
+	``AS_SUPPORTS_DIRECT_IO``
+		Direct I/O is supported.
+
 ``writepage``
 	called by the VM to write a dirty page to backing store.  This
 	may happen for data integrity reasons (i.e. 'sync'), or to free
diff --git a/block/fops.c b/block/fops.c
index ffce6f6c68dd..84c64d814d0d 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -384,6 +384,7 @@ const struct address_space_operations def_blk_aops = {
 	.direct_IO	= blkdev_direct_IO,
 	.migratepage	= buffer_migrate_page_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..76f7a6d85815 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -237,9 +237,9 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 	 */
 	if (dio) {
 		if (queue_logical_block_size(lo->lo_queue) >= sb_bsize &&
-				!(lo->lo_offset & dio_align) &&
-				mapping->a_ops->direct_IO &&
-				!lo->transfer)
+		    !(lo->lo_offset & dio_align) &&
+		    (mapping->a_ops->supports & AS_SUPPORTS_DIRECT_IO) &&
+		    !lo->transfer)
 			use_dio = true;
 		else
 			use_dio = false;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index cce9ace651a2..4910898af0d7 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -333,4 +333,5 @@ const struct address_space_operations v9fs_addr_operations = {
 	.invalidatepage = v9fs_invalidate_page,
 	.launder_page = v9fs_launder_page,
 	.direct_IO = v9fs_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
diff --git a/fs/affs/file.c b/fs/affs/file.c
index 75ebd2b576ca..7488bd7d3e0c 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -460,6 +460,7 @@ const struct address_space_operations affs_aops = {
 	.write_end = affs_write_end,
 	.direct_IO = affs_direct_IO,
 	.bmap = _affs_bmap
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static inline struct buffer_head *
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 487533c35ddb..b479c97e42fc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10937,7 +10937,6 @@ static const struct address_space_operations btrfs_aops = {
 	.writepage	= btrfs_writepage,
 	.writepages	= btrfs_writepages,
 	.readahead	= btrfs_readahead,
-	.direct_IO	= noop_direct_IO,
 	.invalidatepage = btrfs_invalidatepage,
 	.releasepage	= btrfs_releasepage,
 #ifdef CONFIG_MIGRATION
@@ -10947,6 +10946,7 @@ static const struct address_space_operations btrfs_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate	= btrfs_swap_activate,
 	.swap_deactivate = btrfs_swap_deactivate,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct inode_operations btrfs_file_inode_operations = {
diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 99b80b5c7a93..086d4745b99e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1306,17 +1306,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 	return copied;
 }
 
-/*
- * we set .direct_IO to indicate direct io is supported, but since we
- * intercept O_DIRECT reads and writes early, this function should
- * never get called.
- */
-static ssize_t ceph_direct_io(struct kiocb *iocb, struct iov_iter *iter)
-{
-	WARN_ON(1);
-	return -EINVAL;
-}
-
 const struct address_space_operations ceph_aops = {
 	.readpage = ceph_readpage,
 	.readahead = ceph_readahead,
@@ -1327,7 +1316,7 @@ const struct address_space_operations ceph_aops = {
 	.set_page_dirty = ceph_set_page_dirty,
 	.invalidatepage = ceph_invalidatepage,
 	.releasepage = ceph_releasepage,
-	.direct_IO = ceph_direct_io,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6796fc73b304..a5787cf3d836 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4891,25 +4891,6 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_done_oplock_break(cinode);
 }
 
-/*
- * The presence of cifs_direct_io() in the address space ops vector
- * allowes open() O_DIRECT flags which would have failed otherwise.
- *
- * In the non-cached mode (mount with cache=none), we shunt off direct read and write requests
- * so this method should never be called.
- *
- * Direct IO is not yet supported in the cached mode. 
- */
-static ssize_t
-cifs_direct_io(struct kiocb *iocb, struct iov_iter *iter)
-{
-        /*
-         * FIXME
-         * Eventually need to support direct IO for non forcedirectio mounts
-         */
-        return -EINVAL;
-}
-
 static int cifs_swap_activate(struct swap_info_struct *sis,
 			      struct file *swap_file, sector_t *span)
 {
@@ -4974,7 +4955,6 @@ const struct address_space_operations cifs_addr_ops = {
 	.write_end = cifs_write_end,
 	.set_page_dirty = __set_page_dirty_nobuffers,
 	.releasepage = cifs_release_page,
-	.direct_IO = cifs_direct_io,
 	.invalidatepage = cifs_invalidate_page,
 	.launder_page = cifs_launder_page,
 	/*
@@ -4984,6 +4964,7 @@ const struct address_space_operations cifs_addr_ops = {
 	 */
 	.swap_activate = cifs_swap_activate,
 	.swap_deactivate = cifs_swap_deactivate,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 9db829715652..30f19296b268 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -299,7 +299,7 @@ const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_readpage,
 	.readahead = erofs_readahead,
 	.bmap = erofs_bmap,
-	.direct_IO = noop_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 #ifdef CONFIG_FS_DAX
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index ca37d4344361..f38f42282f54 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -500,6 +500,7 @@ static const struct address_space_operations exfat_aops = {
 	.write_end	= exfat_write_end,
 	.direct_IO	= exfat_direct_IO,
 	.bmap		= exfat_aop_bmap
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static inline unsigned long exfat_hash(loff_t i_pos)
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 333fa62661d5..4ad3655defd9 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -974,6 +974,7 @@ const struct address_space_operations ext2_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 const struct address_space_operations ext2_nobh_aops = {
@@ -988,13 +989,14 @@ const struct address_space_operations ext2_nobh_aops = {
 	.writepages		= ext2_writepages,
 	.migratepage		= buffer_migrate_page,
 	.error_remove_page	= generic_error_remove_page,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct address_space_operations ext2_dax_aops = {
 	.writepages		= ext2_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d18852d6029c..08d3541d8daa 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3662,11 +3662,11 @@ static const struct address_space_operations ext4_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct address_space_operations ext4_journalled_aops = {
@@ -3680,10 +3680,10 @@ static const struct address_space_operations ext4_journalled_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_journalled_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= noop_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct address_space_operations ext4_da_aops = {
@@ -3697,20 +3697,20 @@ static const struct address_space_operations ext4_da_aops = {
 	.bmap			= ext4_bmap,
 	.invalidatepage		= ext4_invalidatepage,
 	.releasepage		= ext4_releasepage,
-	.direct_IO		= noop_direct_IO,
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate  = block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct address_space_operations ext4_dax_aops = {
 	.writepages		= ext4_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.bmap			= ext4_bmap,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= ext4_iomap_swap_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 void ext4_set_aops(struct inode *inode)
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f4fd6c246c9a..4c3643969b69 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4156,6 +4156,7 @@ const struct address_space_operations f2fs_dblock_aops = {
 #ifdef CONFIG_MIGRATION
 	.migratepage    = f2fs_migrate_page,
 #endif
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 void f2fs_clear_page_cache_dirty_tag(struct page *page)
diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index de0c9b013a85..4352981dfb82 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -351,6 +351,7 @@ static const struct address_space_operations fat_aops = {
 	.write_end	= fat_write_end,
 	.direct_IO	= fat_direct_IO,
 	.bmap		= _fat_bmap
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3e2de5..7308e8274ff9 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -58,7 +58,7 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
 	/* Pipe packetized mode is controlled by O_DIRECT flag */
 	if (!S_ISFIFO(inode->i_mode) && (arg & O_DIRECT)) {
 		if (!filp->f_mapping || !filp->f_mapping->a_ops ||
-			!filp->f_mapping->a_ops->direct_IO)
+		    !(filp->f_mapping->a_ops->supports & AS_SUPPORTS_DIRECT_IO))
 				return -EINVAL;
 	}
 
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 281d79f8b3d3..e39468fd7177 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -1325,9 +1325,9 @@ bool fuse_dax_inode_alloc(struct super_block *sb, struct fuse_inode *fi)
 
 static const struct address_space_operations fuse_dax_file_aops  = {
 	.writepages	= fuse_dax_writepages,
-	.direct_IO	= noop_direct_IO,
 	.set_page_dirty	= __set_page_dirty_no_writeback,
 	.invalidatepage	= noop_invalidatepage,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 void fuse_dax_inode_init(struct inode *inode)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..3db64194d346 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3161,6 +3161,7 @@ static const struct address_space_operations fuse_file_aops  = {
 	.direct_IO	= fuse_direct_IO,
 	.write_begin	= fuse_write_begin,
 	.write_end	= fuse_write_end,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 void fuse_init_file_inode(struct inode *inode)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 005e920f5d4a..dc50b53d6abd 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -783,10 +783,10 @@ static const struct address_space_operations gfs2_aops = {
 	.releasepage = iomap_releasepage,
 	.invalidatepage = iomap_invalidatepage,
 	.bmap = gfs2_bmap,
-	.direct_IO = noop_direct_IO,
 	.migratepage = iomap_migrate_page,
 	.is_partially_uptodate = iomap_is_partially_uptodate,
 	.error_remove_page = generic_error_remove_page,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static const struct address_space_operations gfs2_jdata_aops = {
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 4a95a92546a0..5f9e5464a5bf 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -177,6 +177,7 @@ const struct address_space_operations hfs_aops = {
 	.bmap		= hfs_bmap,
 	.direct_IO	= hfs_direct_IO,
 	.writepages	= hfs_writepages,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 6fef67c2a9f0..9f0c27e5e115 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -174,6 +174,7 @@ const struct address_space_operations hfsplus_aops = {
 	.bmap		= hfsplus_bmap,
 	.direct_IO	= hfsplus_direct_IO,
 	.writepages	= hfsplus_writepages,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 const struct dentry_operations hfsplus_dentry_operations = {
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 57ab424c05ff..a477267471a4 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -366,6 +366,7 @@ const struct address_space_operations jfs_aops = {
 	.write_end	= nobh_write_end,
 	.bmap		= jfs_bmap,
 	.direct_IO	= jfs_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/libfs.c b/fs/libfs.c
index 51b4de3b3447..c27f681291e5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1182,18 +1182,6 @@ void noop_invalidatepage(struct page *page, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(noop_invalidatepage);
 
-ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
-{
-	/*
-	 * iomap based filesystems support direct I/O without need for
-	 * this callback. However, it still needs to be set in
-	 * inode->a_ops so that open/fcntl know that direct I/O is
-	 * generally supported.
-	 */
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(noop_direct_IO);
-
 /* Because kfree isn't assignment-compatible with void(void*) ;-/ */
 void kfree_link(void *p)
 {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index aa353fd58240..7403ec6317cb 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -532,6 +532,7 @@ const struct address_space_operations nfs_file_aops = {
 	.error_remove_page = generic_error_remove_page,
 	.swap_activate = nfs_swap_activate,
 	.swap_deactivate = nfs_swap_deactivate,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 2e8eb263cf0f..c57395c01817 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -307,6 +307,7 @@ const struct address_space_operations nilfs_aops = {
 	.invalidatepage		= block_invalidatepage,
 	.direct_IO		= nilfs_direct_IO,
 	.is_partially_uptodate  = block_is_partially_uptodate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static int nilfs_insert_inode_locked(struct inode *inode,
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index db2a5a4c38e4..7b3ac1ab5d04 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1948,6 +1948,7 @@ const struct address_space_operations ntfs_aops = {
 	.direct_IO	= ntfs_direct_IO,
 	.bmap		= ntfs_bmap,
 	.set_page_dirty = __set_page_dirty_buffers,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 const struct address_space_operations ntfs_aops_cmpr = {
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 68d11c295dd3..5a158975a4ff 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2466,4 +2466,5 @@ const struct address_space_operations ocfs2_aops = {
 	.migratepage		= buffer_migrate_page,
 	.is_partially_uptodate	= block_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
diff --git a/fs/open.c b/fs/open.c
index daa324606a41..d679dc0c1801 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -840,7 +840,8 @@ static int do_dentry_open(struct file *f,
 
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
-		if (!f->f_mapping->a_ops || !f->f_mapping->a_ops->direct_IO)
+		if (!f->f_mapping->a_ops ||
+		    !(f->f_mapping->a_ops->supports & AS_SUPPORTS_DIRECT_IO))
 			return -EINVAL;
 	}
 
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index c1bb4c4b5d67..c5bad94dfbd0 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -641,6 +641,7 @@ static const struct address_space_operations orangefs_address_operations = {
 	.freepage = orangefs_freepage,
 	.launder_page = orangefs_launder_page,
 	.direct_IO = orangefs_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 vm_fault_t orangefs_page_mkwrite(struct vm_fault *vmf)
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index d081faa55e83..87d05f1d718a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -83,7 +83,7 @@ static int ovl_change_flags(struct file *file, unsigned int flags)
 
 	if (flags & O_DIRECT) {
 		if (!file->f_mapping->a_ops ||
-		    !file->f_mapping->a_ops->direct_IO)
+		    !(file->f_mapping->a_ops->supports & AS_SUPPORTS_DIRECT_IO))
 			return -EINVAL;
 	}
 
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 832b17589733..9902608b1715 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -660,8 +660,7 @@ static const struct inode_operations ovl_special_inode_operations = {
 };
 
 static const struct address_space_operations ovl_aops = {
-	/* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
-	.direct_IO		= noop_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
index f49b72ccac4c..890d91847d58 100644
--- a/fs/reiserfs/inode.c
+++ b/fs/reiserfs/inode.c
@@ -3436,4 +3436,5 @@ const struct address_space_operations reiserfs_address_space_operations = {
 	.bmap = reiserfs_aop_bmap,
 	.direct_IO = reiserfs_direct_IO,
 	.set_page_dirty = reiserfs_set_page_dirty,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 1baff8ddb754..2cb1b499e5c7 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -131,6 +131,7 @@ const struct address_space_operations udf_adinicb_aops = {
 	.write_begin	= udf_adinicb_write_begin,
 	.write_end	= udf_adinicb_write_end,
 	.direct_IO	= udf_adinicb_direct_IO,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 static ssize_t udf_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1d6b7a50736b..38b799b457d5 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -244,6 +244,7 @@ const struct address_space_operations udf_aops = {
 	.write_end	= generic_write_end,
 	.direct_IO	= udf_direct_IO,
 	.bmap		= udf_bmap,
+	.supports	= AS_SUPPORTS_DIRECT_IO,
 };
 
 /*
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 34fc6148032a..2a4570516591 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -548,17 +548,17 @@ const struct address_space_operations xfs_address_space_operations = {
 	.releasepage		= iomap_releasepage,
 	.invalidatepage		= iomap_invalidatepage,
 	.bmap			= xfs_vm_bmap,
-	.direct_IO		= noop_direct_IO,
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate  = iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.swap_activate		= xfs_iomap_swapfile_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 const struct address_space_operations xfs_dax_aops = {
 	.writepages		= xfs_dax_writepages,
-	.direct_IO		= noop_direct_IO,
 	.set_page_dirty		= __set_page_dirty_no_writeback,
 	.invalidatepage		= noop_invalidatepage,
 	.swap_activate		= xfs_iomap_swapfile_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ddc346a9df9b..37ff541467e8 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -191,8 +191,8 @@ static const struct address_space_operations zonefs_file_aops = {
 	.migratepage		= iomap_migrate_page,
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
-	.direct_IO		= noop_direct_IO,
 	.swap_activate		= zonefs_swap_activate,
+	.supports		= AS_SUPPORTS_DIRECT_IO,
 };
 
 static void zonefs_update_stats(struct inode *inode, loff_t new_isize)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e7a633353fd2..c909ca6c0eb6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -369,7 +369,10 @@ typedef struct {
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *,
 		unsigned long, unsigned long);
 
+#define AS_SUPPORTS_DIRECT_IO	0x00000001
+
 struct address_space_operations {
+	unsigned int supports; /* Bitmask of AS_SUPPORTS_* flags */
 	int (*writepage)(struct page *page, struct writeback_control *wbc);
 	int (*readpage)(struct file *, struct page *);
 
@@ -3391,7 +3394,6 @@ extern void simple_recursive_removal(struct dentry *,
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
 extern void noop_invalidatepage(struct page *page, unsigned int offset,
 		unsigned int length);
-extern ssize_t noop_direct_IO(struct kiocb *iocb, struct iov_iter *iter);
 extern int simple_empty(struct dentry *);
 extern int simple_write_begin(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned flags,


