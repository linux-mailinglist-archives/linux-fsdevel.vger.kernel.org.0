Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EC95151D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379528AbiD2R32 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378214AbiD2R3Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:29:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E3972FC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 10:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=V7CxheuPIV+NYe/s6vD9HbLKq6XnRjZaCBwduFnBbXU=; b=cfIe7Tiv9dOksGkevibtbvPWf6
        dsulnlSSfb67aqMHDidTmfhvBlEWUXqC80s9YeLRHSbCpiS6jekFElb7RmGJVfiG2eyTqEXcZG2TX
        jNvQ2Ywd1jUcSSF5m7D7Vhc/AZFaf8fR5zdyXHej4kTv1AdaWsma+N+PMkS5tgoSUZyFPVG9S6X8K
        U36tZvNjl3lZ5HcJeAeFGyQ7TFLkkED0xpZ/6yrWiS6GdkOvFdPda5DQ3tHFmcR8Gutgysci5ea8+
        xLfQc+obKH6X8KU03nlxgD9a/mfTr1f+8qra4/GdoA7XGmIsPXr72oX0BHK9fW+G06yKfAKcHKJaK
        vep4pekQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nkUNW-00CdWz-1b; Fri, 29 Apr 2022 17:26:02 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/69] Filesystem/page cache patches for 5.19
Date:   Fri, 29 Apr 2022 18:24:47 +0100
Message-Id: <20220429172556.3011843-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I've just pushed these out to my git tree:
git://git.infradead.org/users/willy/pagecache.git for-next

Some of these have been posted before, and have all the trailers added
that I saw.  The conversion from ->readpage to ->read_folio is new.

Matthew Wilcox (Oracle) (68):
  scsicam: Fix use of page cache
  ext4: Use page_symlink() instead of __page_symlink()
  namei: Merge page_symlink() and __page_symlink()
  namei: Convert page_symlink() to use memalloc_nofs_save()
  f2fs: Convert f2fs_grab_cache_page() to use scoped memory APIs
  ext4: Allow GFP_FS allocations in
    ext4_da_convert_inline_data_to_extent()
  ext4: Use scoped memory API in mext_page_double_lock()
  ext4: Use scoped memory APIs in ext4_da_write_begin()
  ext4: Use scoped memory APIs in ext4_write_begin()
  fs: Remove AOP_FLAG_NOFS
  fs: Remove aop_flags parameter from netfs_write_begin()
  fs: Remove aop flags parameter from block_write_begin()
  fs: Remove aop flags parameter from cont_write_begin()
  fs: Remove aop flags parameter from grab_cache_page_write_begin()
  fs: Remove aop flags parameter from nobh_write_begin()
  fs: Remove flags parameter from aops->write_begin
  buffer: Call aops write_begin() and write_end() directly
  namei: Call aops write_begin() and write_end() directly
  ntfs3: Call ntfs_write_begin() and ntfs_write_end() directly
  hfs: Call hfs_write_begin() and generic_write_end() directly
  hfsplus: Call hfsplus_write_begin() and generic_write_end() directly
  ext4: Call aops write_begin() and write_end() directly
  f2fs: Call aops write_begin() and write_end() directly
  i915: Call aops write_begin() and write_end() directly
  fs: Remove pagecache_write_begin() and pagecache_write_end()
  filemap: Update the folio_lock documentation
  filemap: Update the folio_mark_dirty documentation
  readahead: Use a folio in read_pages()
  fs: Convert is_dirty_writeback() to take a folio
  mm/readahead: Convert page_cache_async_readahead to take a folio
  buffer: Rewrite nobh_truncate_page() to use folios
  fs: Introduce aops->read_folio
  fs: read_folio documentation
  fs: Convert netfs_readpage to netfs_read_folio
  fs: Convert iomap_readpage to iomap_read_folio
  fs: Convert block_read_full_page() to block_read_full_folio()
  fs: Convert mpage_readpage to mpage_read_folio
  fs: Convert simple_readpage to simple_read_folio
  affs: Convert affs to read_folio
  afs: Convert afs_symlink_readpage to afs_symlink_read_folio
  befs: Convert befs to read_folio
  btrfs: Convert btrfs to read_folio
  cifs: Convert cifs to read_folio
  coda: Convert coda to read_folio
  cramfs: Convert cramfs to read_folio
  ecryptfs: Convert ecryptfs to read_folio
  efs: Convert efs symlinks to read_folio
  erofs: Convert erofs zdata to read_folio
  ext4: Convert ext4 to read_folio
  f2fs: Convert f2fs to read_folio
  freevxfs: Convert vxfs_immed to read_folio
  fuse: Convert fuse to read_folio
  hostfs: Convert hostfs to read_folio
  hpfs: Convert symlinks to read_folio
  isofs: Convert symlinks and zisofs to read_folio
  jffs2: Convert jffs2 to read_folio
  jfs: Convert metadata pages to read_folio
  nfs: Convert nfs to read_folio
  ntfs: Convert ntfs to read_folio
  ocfs2: Convert ocfs2 to read_folio
  orangefs: Convert orangefs to read_folio
  romfs: Convert romfs to read_folio
  squashfs: Convert squashfs to read_folio
  ubifs: Convert ubifs to read_folio
  udf: Convert adinicb and symlinks to read_folio
  vboxsf: Convert vboxsf to read_folio
  mm: Convert swap_readpage to call read_folio instead of readpage
  mm,fs: Remove stray references to ->readpage

Miaohe Lin (1):
  filemap: Remove obsolete comment in lock_page

 Documentation/filesystems/fscrypt.rst       |   2 +-
 Documentation/filesystems/fsverity.rst      |   2 +-
 Documentation/filesystems/locking.rst       |  12 +-
 Documentation/filesystems/netfs_library.rst |   9 +-
 Documentation/filesystems/porting.rst       |   2 +-
 Documentation/filesystems/vfs.rst           |  35 ++---
 block/fops.c                                |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c   |  23 ++-
 drivers/scsi/scsicam.c                      |   8 +-
 fs/9p/vfs_addr.c                            |   6 +-
 fs/adfs/inode.c                             |  10 +-
 fs/affs/file.c                              |  21 +--
 fs/affs/symlink.c                           |   5 +-
 fs/afs/file.c                               |  17 +--
 fs/afs/internal.h                           |   2 +-
 fs/afs/write.c                              |   4 +-
 fs/befs/linuxvfs.c                          |  17 ++-
 fs/bfs/file.c                               |  11 +-
 fs/btrfs/ctree.h                            |   2 +-
 fs/btrfs/file.c                             |   7 +-
 fs/btrfs/free-space-cache.c                 |   2 +-
 fs/btrfs/inode.c                            |   7 +-
 fs/btrfs/ioctl.c                            |   2 +-
 fs/btrfs/relocation.c                       |  13 +-
 fs/btrfs/send.c                             |   5 +-
 fs/buffer.c                                 | 160 ++++++++++----------
 fs/ceph/addr.c                              |   8 +-
 fs/cifs/file.c                              |  17 ++-
 fs/coda/symlink.c                           |   7 +-
 fs/cramfs/README                            |   8 +-
 fs/cramfs/inode.c                           |   7 +-
 fs/ecryptfs/mmap.c                          |  15 +-
 fs/efs/inode.c                              |   8 +-
 fs/efs/symlink.c                            |   5 +-
 fs/erofs/data.c                             |   6 +-
 fs/erofs/zdata.c                            |   7 +-
 fs/exfat/inode.c                            |  10 +-
 fs/ext2/inode.c                             |  19 +--
 fs/ext4/ext4.h                              |   2 -
 fs/ext4/inline.c                            |  41 +++--
 fs/ext4/inode.c                             |  28 ++--
 fs/ext4/move_extent.c                       |  17 ++-
 fs/ext4/namei.c                             |   7 +-
 fs/ext4/readpage.c                          |   4 +-
 fs/ext4/verity.c                            |   9 +-
 fs/f2fs/data.c                              |  10 +-
 fs/f2fs/f2fs.h                              |   9 +-
 fs/f2fs/super.c                             |   2 +-
 fs/f2fs/verity.c                            |   9 +-
 fs/fat/inode.c                              |  10 +-
 fs/freevxfs/vxfs_immed.c                    |  15 +-
 fs/freevxfs/vxfs_subr.c                     |  17 +--
 fs/fuse/dir.c                               |  10 +-
 fs/fuse/file.c                              |  12 +-
 fs/gfs2/aops.c                              |  18 +--
 fs/hfs/extent.c                             |   6 +-
 fs/hfs/hfs_fs.h                             |   2 +
 fs/hfs/inode.c                              |  15 +-
 fs/hfsplus/extents.c                        |   8 +-
 fs/hfsplus/hfsplus_fs.h                     |   2 +
 fs/hfsplus/inode.c                          |  15 +-
 fs/hostfs/hostfs_kern.c                     |   9 +-
 fs/hpfs/file.c                              |  10 +-
 fs/hpfs/namei.c                             |   5 +-
 fs/hugetlbfs/inode.c                        |   2 +-
 fs/iomap/buffered-io.c                      |  16 +-
 fs/isofs/compress.c                         |   5 +-
 fs/isofs/inode.c                            |   6 +-
 fs/isofs/rock.c                             |   7 +-
 fs/jffs2/file.c                             |  16 +-
 fs/jffs2/fs.c                               |   2 +-
 fs/jfs/inode.c                              |  11 +-
 fs/jfs/jfs_metapage.c                       |   5 +-
 fs/libfs.c                                  |  18 +--
 fs/minix/inode.c                            |  11 +-
 fs/mpage.c                                  |  18 ++-
 fs/namei.c                                  |  28 ++--
 fs/netfs/buffered_read.c                    |  25 ++-
 fs/nfs/file.c                               |  29 ++--
 fs/nfs/read.c                               |   3 +-
 fs/nilfs2/inode.c                           |  15 +-
 fs/nilfs2/recovery.c                        |   2 +-
 fs/ntfs/aops.c                              |  40 ++---
 fs/ntfs/aops.h                              |   6 +-
 fs/ntfs/attrib.c                            |   2 +-
 fs/ntfs/compress.c                          |   4 +-
 fs/ntfs/file.c                              |   4 +-
 fs/ntfs/inode.c                             |   4 +-
 fs/ntfs/mft.h                               |   2 +-
 fs/ntfs3/file.c                             |   5 +-
 fs/ntfs3/inode.c                            |  27 ++--
 fs/ntfs3/ntfs_fs.h                          |   5 +
 fs/ocfs2/alloc.c                            |   2 +-
 fs/ocfs2/aops.c                             |  13 +-
 fs/ocfs2/file.c                             |   2 +-
 fs/ocfs2/refcounttree.c                     |   6 +-
 fs/ocfs2/symlink.c                          |   5 +-
 fs/omfs/file.c                              |  11 +-
 fs/orangefs/inode.c                         |  40 +++--
 fs/qnx4/inode.c                             |   7 +-
 fs/qnx6/inode.c                             |   6 +-
 fs/reiserfs/file.c                          |   2 +-
 fs/reiserfs/inode.c                         |  16 +-
 fs/romfs/super.c                            |   9 +-
 fs/squashfs/file.c                          |   5 +-
 fs/squashfs/super.c                         |   2 +-
 fs/squashfs/symlink.c                       |   5 +-
 fs/sysv/itree.c                             |  10 +-
 fs/ubifs/file.c                             |  23 +--
 fs/ubifs/super.c                            |   2 +-
 fs/udf/file.c                               |  14 +-
 fs/udf/inode.c                              |  10 +-
 fs/udf/symlink.c                            |   5 +-
 fs/ufs/inode.c                              |  13 +-
 fs/vboxsf/file.c                            |   5 +-
 fs/verity/enable.c                          |  29 ++--
 fs/xfs/xfs_aops.c                           |   8 +-
 fs/zonefs/super.c                           |   6 +-
 include/linux/buffer_head.h                 |  10 +-
 include/linux/fs.h                          |  28 +---
 include/linux/iomap.h                       |   2 +-
 include/linux/mpage.h                       |   2 +-
 include/linux/netfs.h                       |   4 +-
 include/linux/nfs_fs.h                      |   2 +-
 include/linux/pagemap.h                     |  68 ++++++++-
 include/trace/events/ext4.h                 |  21 +--
 include/trace/events/f2fs.h                 |  12 +-
 kernel/events/uprobes.c                     |   7 +-
 mm/filemap.c                                |  34 +----
 mm/folio-compat.c                           |   4 +-
 mm/memory.c                                 |   4 +-
 mm/page-writeback.c                         |  10 +-
 mm/page_io.c                                |   2 +-
 mm/readahead.c                              |  37 +++--
 mm/shmem.c                                  |   4 +-
 mm/swapfile.c                               |   2 +-
 mm/vmscan.c                                 |   2 +-
 137 files changed, 827 insertions(+), 807 deletions(-)

-- 
2.34.1

