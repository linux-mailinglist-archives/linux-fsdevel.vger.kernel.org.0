Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863814E2A9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Mar 2022 15:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349115AbiCUO3G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349206AbiCUO10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:27:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CC11A12
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Mar 2022 07:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=4NemR9fXDZx0PqMBWRU4v36V6QLKgfWsG/XUNnRFxSQ=; b=r7OFnh31UpBL2URPV1DPsnjDP4
        mwbEcwWw39zmZczhM9WH79tLZf0AjMzq3i3sPsej+pI4nCXOEtx+CpCVbA+7Itf1te2u+/4KkO3Ty
        Dg0CZq27BrMv4viPZpkIeBQgnF6JZduZ6TAvvpyDSRJyGAEBxqzIG8OcEz4PFBEoXASKqyzToyv/7
        e4qhlL7b05Af98TZNCQYYm0G01iGDqmLbr2GEAJAvfPG+cmB4OPpBMEIBdm1jo9dSrJU8zGs2CbKo
        vCnJ2WjtSQXAIelDmHh+DBfRogR9JpX2qu9WYAG+maiyou2jas4xb0575hj2MWiqbQQzRNS9juVjR
        2nGr5y2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWItj-00Ae1M-1d; Mon, 21 Mar 2022 14:20:39 +0000
Date:   Mon, 21 Mar 2022 14:20:39 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] Folio patches for 5.18 (FS part)
Message-ID: <YjiJt4L7mkPrA/En@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the second of two folio-related pull requests for this merge
window.  These are the filesystem related patches.  There's very little
'exciting' in here; it's largely mechanical changes to convert pages
to folios.  There's a fair amount of conflict with filesystem trees,
so you may want to delay this pull until later in the merge window to
fix all the conflicts at once.

https://lore.kernel.org/linux-next/20220315205259.71b4238a@canb.auug.org.au/
https://lore.kernel.org/linux-next/YjDQYKIPaeOEd+7e@mit.edu/T/#t
https://lore.kernel.org/linux-next/20220315204540.4f9f6b66@canb.auug.org.au/
https://lore.kernel.org/linux-next/20220315203112.03f6120c@canb.auug.org.au/
https://lore.kernel.org/linux-next/20220315202816.7ff33386@canb.auug.org.au/
https://lore.kernel.org/linux-next/20220315202512.62f54300@canb.auug.org.au/

(I think that was all of the conflicts that had to be resolved)

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.18b

for you to fetch changes up to 3a3bae50af5d73fab5da20484029de77ca67bb2e:

  fs: Remove aops ->set_page_dirty (2022-03-16 13:37:05 -0400)

----------------------------------------------------------------
Filesystem folio changes for 5.18

Primarily this series converts some of the address_space operations
to take a folio instead of a page.

->is_partially_uptodate() takes a folio instead of a page and changes the
type of the 'from' and 'count' arguments to make it obvious they're bytes.
->invalidatepage() becomes ->invalidate_folio() and has a similar type change.
->launder_page() becomes ->launder_folio()
->set_page_dirty() becomes ->dirty_folio() and adds the address_space as
an argument.

There are a couple of other misc changes up front that weren't worth
separating into their own pull request.

----------------------------------------------------------------
Matthew Wilcox (Oracle) (53):
      iomap: Fix iomap_invalidatepage tracepoint
      fs: read_mapping_page() should take a struct file argument
      fs/remap_range: Pass the file pointer to read_mapping_folio()
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
      fs: Convert trivial uses of __set_page_dirty_nobuffers to filemap_dirty_folio
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

 Documentation/filesystems/caching/netfs-api.rst |   7 +-
 Documentation/filesystems/locking.rst           |  42 ++++----
 Documentation/filesystems/vfs.rst               |  46 ++++-----
 block/fops.c                                    |   3 +-
 drivers/dax/device.c                            |   3 +-
 drivers/video/fbdev/core/fb_defio.c             |   9 +-
 fs/9p/vfs_addr.c                                |  37 ++-----
 fs/adfs/inode.c                                 |   3 +-
 fs/affs/file.c                                  |   6 +-
 fs/afs/dir.c                                    |  18 ++--
 fs/afs/file.c                                   |  28 +++---
 fs/afs/internal.h                               |   6 +-
 fs/afs/write.c                                  |  10 +-
 fs/aio.c                                        |   2 +-
 fs/bfs/file.c                                   |   3 +-
 fs/btrfs/ctree.h                                |   3 +
 fs/btrfs/disk-io.c                              |  47 ++++-----
 fs/btrfs/extent-io-tree.h                       |   4 +-
 fs/btrfs/extent_io.c                            |  35 +++----
 fs/btrfs/inode.c                                |  84 ++++++++--------
 fs/buffer.c                                     |  96 +++++++++---------
 fs/ceph/addr.c                                  |  83 ++++++++--------
 fs/ceph/cache.h                                 |  13 +--
 fs/cifs/file.c                                  |  39 ++++----
 fs/ecryptfs/mmap.c                              |   5 +-
 fs/erofs/super.c                                |  17 ++--
 fs/exfat/inode.c                                |   3 +-
 fs/ext2/inode.c                                 |   9 +-
 fs/ext4/inode.c                                 | 127 ++++++++++++------------
 fs/f2fs/checkpoint.c                            |  31 +++---
 fs/f2fs/compress.c                              |   2 +-
 fs/f2fs/data.c                                  |  56 +++++------
 fs/f2fs/f2fs.h                                  |   5 +-
 fs/f2fs/node.c                                  |  29 +++---
 fs/fat/inode.c                                  |   3 +-
 fs/fscache/io.c                                 |  28 +++---
 fs/fuse/dax.c                                   |   3 +-
 fs/fuse/dir.c                                   |   2 +-
 fs/fuse/file.c                                  |  16 +--
 fs/gfs2/aops.c                                  |  43 ++++----
 fs/gfs2/meta_io.c                               |   6 +-
 fs/hfs/inode.c                                  |   6 +-
 fs/hfsplus/inode.c                              |   6 +-
 fs/hostfs/hostfs_kern.c                         |   3 +-
 fs/hpfs/file.c                                  |   3 +-
 fs/hugetlbfs/inode.c                            |   2 +-
 fs/iomap/buffered-io.c                          |  46 ++++-----
 fs/iomap/trace.h                                |   2 +-
 fs/jbd2/journal.c                               |   2 +-
 fs/jbd2/transaction.c                           |  31 +++---
 fs/jfs/inode.c                                  |   3 +-
 fs/jfs/jfs_metapage.c                           |  14 +--
 fs/libfs.c                                      |  15 +--
 fs/minix/inode.c                                |   3 +-
 fs/mpage.c                                      |   2 +-
 fs/nfs/file.c                                   |  32 +++---
 fs/nfs/write.c                                  |   8 +-
 fs/nilfs2/inode.c                               |  40 ++++----
 fs/nilfs2/mdt.c                                 |   3 +-
 fs/ntfs/aops.c                                  |  21 ++--
 fs/ntfs3/inode.c                                |   2 +-
 fs/ocfs2/aops.c                                 |   4 +-
 fs/omfs/file.c                                  |   3 +-
 fs/orangefs/inode.c                             | 121 +++++++++++-----------
 fs/reiserfs/inode.c                             |  40 ++++----
 fs/reiserfs/journal.c                           |   4 +-
 fs/remap_range.c                                |  16 +--
 fs/sysv/itree.c                                 |   3 +-
 fs/ubifs/file.c                                 |  34 +++----
 fs/udf/file.c                                   |   3 +-
 fs/udf/inode.c                                  |   3 +-
 fs/ufs/inode.c                                  |   3 +-
 fs/vboxsf/file.c                                |   2 +-
 fs/xfs/xfs_aops.c                               |   7 +-
 fs/zonefs/super.c                               |   4 +-
 include/linux/buffer_head.h                     |   9 +-
 include/linux/fs.h                              |  14 ++-
 include/linux/fscache.h                         |   8 +-
 include/linux/iomap.h                           |   5 +-
 include/linux/jbd2.h                            |   4 +-
 include/linux/mm.h                              |   3 -
 include/linux/nfs_fs.h                          |   2 +-
 include/linux/pagemap.h                         |  29 +++++-
 include/linux/swap.h                            |   2 +-
 include/trace/events/ext4.h                     |  30 +++---
 mm/filemap.c                                    |   8 +-
 mm/page-writeback.c                             |  36 ++++---
 mm/page_io.c                                    |  15 +--
 mm/readahead.c                                  |   2 +-
 mm/rmap.c                                       |   4 +-
 mm/secretmem.c                                  |   2 +-
 mm/shmem.c                                      |   2 +-
 mm/swap_state.c                                 |   2 +-
 mm/truncate.c                                   |  42 ++++----
 94 files changed, 848 insertions(+), 874 deletions(-)

