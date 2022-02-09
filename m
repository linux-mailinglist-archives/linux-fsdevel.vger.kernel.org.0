Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE474AFE3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiBIUWa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:22:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiBIUWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A16E036C12
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IdfdJx2aU2YqQCEDc2CwfkIoIjETBjiGZBPO+Z2zGgM=; b=a/qX/1WPQtO4Wr6H5LjKTTgpyj
        8nKtnsM0uwoGxgtowI9eAgRQLt+4/0ZBHn8ez7LZVP/XyiC4Xr5Pb12lQSV9aa2P+1qwaff9raEr0
        ZCP0qf5mNw9Xz4nIa2y9125zyalHwXBE85fVkBMgWWiQyp2PsPjVPRQPYwONSn1/BQf6NUaRjIxz6
        zHhRbscTuFiY0FnTLXU1NDCPU/Afe3QHQDd3dDRM0oZnm+laM24llUhrkIxMzDqwptqK66wVFdRhI
        F2JjvWyTPfq5VZD2rvYsaFGwyGFmif0T4wIzZlOh0f+1xSKr0ObsCfwCIi/Zaeszcrc0mAWx2fGO3
        UY4dXl3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTq-008coo-BY; Wed, 09 Feb 2022 20:22:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/56] Filesystem folio conversions for 5.18
Date:   Wed,  9 Feb 2022 20:21:19 +0000
Message-Id: <20220209202215.2055748-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As I threatened ;-) previously, here are a number of filesystem changes
that I'm going to try to push into 5.18.

Trond's going to take the first two through the NFS tree, so I'll drop
them as soon as they appear in -next.  I should probably send patches 3
and 6 as bugfixes before 5.18.  Review & testing appreciated.  This is
all against current Linus tree as of today.  xfstests running now against
xfs, with a root of ext4, so that's at least partially tested.  I probably
shan't do detailed testing of any of the filesystems I modified here since
it's pretty much all mechanical.

Matthew Wilcox (Oracle) (56):
  Convert NFS from readpages to readahead
  readahead: Remove read_cache_pages()
  iomap: Fix iomap_invalidatepage tracepoint
  fs: read_mapping_page() should take a struct file argument
  fs/remap_range: Pass the file pointer to read_mapping_folio()
  scsicam: Fix use of page cache
  buffer: Add folio_buffers()
  fs: Convert is_partially_uptodate to folios
  fs: Turn do_invalidatepage() into folio_invalidate()
  btrfs: Use folio_invalidate()
  ceph: Use folio_invalidate()
  ext4: Use folio_invalidate()
  fs: Add invalidate_folio() aops method
  iomap: Remove iomap_invalidatepage()
  fs: Turn block_invalidatepage into block_invalidate_folio
  fs: Remove noop_invalidatepage()
  9p: Convert to invalidate_folio
  afs: Convert directory aops to invalidate_folio
  afs: Convert invalidatepage to invalidate_folio
  btrfs: Convert from invalidatepage to invalidate_folio
  ceph: Convert from invalidatepage to invalidate_folio
  cifs: Convert from invalidatepage to invalidate_folio
  erofs: Convert from invalidatepage to invalidate_folio
  ext4: Convert invalidatepage to invalidate_folio
  f2fs: Convert invalidatepage to invalidate_folio
  gfs2: Convert invalidatepage to invalidate_folio
  jfs: Convert from invalidatepage to invalidate_folio
  nfs: Convert from invalidatepage to invalidate_folio
  orangefs: Convert from invalidatepage to invalidate_folio
  reiserfs: Convert from invalidatepage to invalidate_folio
  ubifs: Convert from invalidatepage to invalidate_folio
  fs: Remove aops->invalidatepage
  fs: Add aops->launder_folio
  9p: Convert from launder_page to launder_folio
  afs: Convert from launder_page to launder_folio
  cifs: Convert from launder_page to launder_folio
  fuse: Convert from launder_page to launder_folio
  nfs: Convert from launder_page to launder_folio
  orangefs: Convert launder_page to launder_folio
  fs: Remove aops->launder_page
  fs: Add aops->dirty_folio
  fscache: Convert fscache_set_page_dirty() to fscache_dirty_folio()
  btrfs: Convert from set_page_dirty to dirty_folio
  fs: Convert trivial uses of __set_page_dirty_nobuffers to
    filemap_dirty_folio
  btrfs: Convert extent_range_redirty_for_io() to use folios
  afs: Convert afs_dir_set_page_dirty() to afs_dir_dirty_folio()
  f2fs: Convert f2fs_set_meta_page_dirty to f2fs_dirty_meta_folio
  f2fs: Convert f2fs_set_data_page_dirty to f2fs_dirty_data_folio
  f2fs: Convert f2fs_set_node_page_dirty to f2fs_dirty_node_folio
  ubifs: Convert ubifs_set_page_dirty to ubifs_dirty_folio
  mm: Convert swap_set_page_dirty() to swap_dirty_folio()
  nilfs: Convert nilfs_set_page_dirty() to nilfs_dirty_folio()
  fs: Convert __set_page_dirty_buffers to block_dirty_folio
  fs: Convert __set_page_dirty_no_writeback to noop_dirty_folio
  fb_defio: Use noop_dirty_folio()
  fs: Remove aops ->set_page_dirty

 .../filesystems/caching/netfs-api.rst         |   7 +-
 Documentation/filesystems/locking.rst         |  42 +++---
 Documentation/filesystems/vfs.rst             |  46 +++----
 block/fops.c                                  |   3 +-
 drivers/dax/device.c                          |   3 +-
 drivers/scsi/scsicam.c                        |   8 +-
 drivers/video/fbdev/core/fb_defio.c           |   9 +-
 fs/9p/vfs_addr.c                              |  37 ++---
 fs/adfs/inode.c                               |   3 +-
 fs/affs/file.c                                |   6 +-
 fs/afs/dir.c                                  |  18 +--
 fs/afs/file.c                                 |  28 ++--
 fs/afs/internal.h                             |   6 +-
 fs/afs/write.c                                |  10 +-
 fs/aio.c                                      |   2 +-
 fs/bfs/file.c                                 |   3 +-
 fs/btrfs/ctree.h                              |   3 +
 fs/btrfs/disk-io.c                            |  47 +++----
 fs/btrfs/extent-io-tree.h                     |   4 +-
 fs/btrfs/extent_io.c                          |  35 ++---
 fs/btrfs/inode.c                              |  84 ++++++------
 fs/buffer.c                                   |  96 +++++++------
 fs/ceph/addr.c                                |  83 ++++++------
 fs/ceph/cache.h                               |  13 +-
 fs/cifs/file.c                                |  39 +++---
 fs/ecryptfs/mmap.c                            |   5 +-
 fs/erofs/super.c                              |  17 ++-
 fs/exfat/inode.c                              |   3 +-
 fs/ext2/inode.c                               |   9 +-
 fs/ext4/inode.c                               | 127 +++++++++---------
 fs/f2fs/checkpoint.c                          |  31 ++---
 fs/f2fs/compress.c                            |   2 +-
 fs/f2fs/data.c                                |  56 ++++----
 fs/f2fs/f2fs.h                                |   5 +-
 fs/f2fs/node.c                                |  29 ++--
 fs/fat/inode.c                                |   3 +-
 fs/fscache/io.c                               |  28 ++--
 fs/fuse/dax.c                                 |   3 +-
 fs/fuse/dir.c                                 |   2 +-
 fs/fuse/file.c                                |  16 +--
 fs/gfs2/aops.c                                |  43 +++---
 fs/gfs2/meta_io.c                             |   6 +-
 fs/hfs/inode.c                                |   6 +-
 fs/hfsplus/inode.c                            |   6 +-
 fs/hostfs/hostfs_kern.c                       |   2 +-
 fs/hpfs/file.c                                |   3 +-
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/iomap/buffered-io.c                        |  46 +++----
 fs/iomap/trace.h                              |   2 +-
 fs/jbd2/journal.c                             |   2 +-
 fs/jbd2/transaction.c                         |  31 +++--
 fs/jfs/inode.c                                |   3 +-
 fs/jfs/jfs_metapage.c                         |  14 +-
 fs/libfs.c                                    |  15 +--
 fs/minix/inode.c                              |   3 +-
 fs/mpage.c                                    |   2 +-
 fs/nfs/file.c                                 |  34 ++---
 fs/nfs/nfstrace.h                             |   6 +-
 fs/nfs/read.c                                 |  21 +--
 fs/nfs/write.c                                |   8 +-
 fs/nilfs2/inode.c                             |  41 +++---
 fs/nilfs2/mdt.c                               |   3 +-
 fs/ntfs/aops.c                                |  21 ++-
 fs/ntfs3/inode.c                              |   2 +-
 fs/ocfs2/aops.c                               |   4 +-
 fs/omfs/file.c                                |   3 +-
 fs/orangefs/inode.c                           | 121 ++++++++---------
 fs/reiserfs/inode.c                           |  40 +++---
 fs/reiserfs/journal.c                         |   4 +-
 fs/remap_range.c                              |  16 +--
 fs/sysv/itree.c                               |   3 +-
 fs/ubifs/file.c                               |  34 ++---
 fs/udf/file.c                                 |   3 +-
 fs/udf/inode.c                                |   3 +-
 fs/ufs/inode.c                                |   3 +-
 fs/vboxsf/file.c                              |   2 +-
 fs/xfs/xfs_aops.c                             |   7 +-
 fs/zonefs/super.c                             |   4 +-
 include/linux/buffer_head.h                   |   9 +-
 include/linux/fs.h                            |  14 +-
 include/linux/fscache.h                       |   8 +-
 include/linux/iomap.h                         |   5 +-
 include/linux/jbd2.h                          |   4 +-
 include/linux/mm.h                            |   3 -
 include/linux/nfs_fs.h                        |   5 +-
 include/linux/pagemap.h                       |  31 ++++-
 include/linux/swap.h                          |   2 +-
 include/trace/events/ext4.h                   |  30 ++---
 mm/filemap.c                                  |   8 +-
 mm/page-writeback.c                           |  36 +++--
 mm/page_io.c                                  |  15 ++-
 mm/readahead.c                                |  76 -----------
 mm/rmap.c                                     |   4 +-
 mm/secretmem.c                                |   2 +-
 mm/shmem.c                                    |   2 +-
 mm/swap_state.c                               |   2 +-
 mm/truncate.c                                 |  42 +++---
 97 files changed, 871 insertions(+), 967 deletions(-)

-- 
2.34.1

