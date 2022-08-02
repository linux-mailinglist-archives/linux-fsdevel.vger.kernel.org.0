Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35B588089
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 18:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbiHBQ5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiHBQ4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:56:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB6140B0;
        Tue,  2 Aug 2022 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=LUYZ91fgBjlrpD7laxD0m0Uj+y50AqmmSOqwUbX21is=; b=ZvCeW4toPs57Du8AJZfHecJtDI
        3IEmxXo0K4Vz37PB3ivNjeIu8gXOY0tBtfxRY5LrlJrSS61tDHxqd0G3DnH48xUQxFztOaM7AQ5Kt
        qd+WjJxMg7nw6dXh3VkjyHw7d7TpUyW5VhZLoZg7U2CYEWuUvBmrW9XolpftgHYbIWKvr8dnwFMc0
        REmK7BjQ2YyNuW3o7Yl8CtwNP8sXqMLeJ+Q7EE+8I9V7fm6xX+NRrYGPilymJukYARdHRaraBUHfI
        7PMMxfahjZvn9C0xnjFKEGUiVwxB5vjEkm1p3scJI3Ww8UbjTKXTxSkqvaackxmK6oOR/waP4iD7o
        FHerMtTQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIvCD-008WRR-B4; Tue, 02 Aug 2022 16:56:41 +0000
Date:   Tue, 2 Aug 2022 17:56:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Pagecache changes for 6.0-rc1
Message-ID: <YulXSSBzxPPGkNaV@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit 0840a7914caa14315a3191178a9f72c742477860:

  Merge tag 'char-misc-5.19-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2022-06-25 10:07:36 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-6.0

for you to fetch changes up to cf5e7a652168fba45410ac6f5b363fcf8677dea5:

  fs: remove the NULL get_block case in mpage_writepages (2022-08-02 12:34:04 -0400)

----------------------------------------------------------------
Folio changes for 6.0

 - Fix an accounting bug that made NR_FILE_DIRTY grow without limit
   when running xfstests

 - Convert more of mpage to use folios

 - Remove add_to_page_cache() and add_to_page_cache_locked()

 - Convert find_get_pages_range() to filemap_get_folios()

 - Improvements to the read_cache_page() family of functions

 - Remove a few unnecessary checks of PageError

 - Some straightforward filesystem conversions to use folios

 - Split PageMovable users out from address_space_operations into their
   own movable_operations

 - Convert aops->migratepage to aops->migrate_folio

 - Remove nobh support (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (6):
      ntfs3: refactor ntfs_writepages
      ext2: remove nobh support
      jfs: stop using the nobh helper
      fs: remove the nobh helpers
      fs: don't call ->writepage from __mpage_writepage
      fs: remove the NULL get_block case in mpage_writepages

Matthew Wilcox (Oracle) (72):
      mm: Account dirty folios properly during splits
      mm: Remove __delete_from_page_cache()
      mpage: Convert do_mpage_readpage() to use a folio
      hugetlb: Convert huge_add_to_page_cache() to use a folio
      filemap: Remove add_to_page_cache() and add_to_page_cache_locked()
      filemap: Add filemap_get_folios()
      buffer: Convert clean_bdev_aliases() to use filemap_get_folios()
      ext4: Convert mpage_release_unused_pages() to use filemap_get_folios()
      ext4: Convert mpage_map_and_submit_buffers() to use filemap_get_folios()
      f2fs: Convert f2fs_invalidate_compress_pages() to use filemap_get_folios()
      hugetlbfs: Convert remove_inode_hugepages() to use filemap_get_folios()
      nilfs2: Convert nilfs_copy_back_pages() to use filemap_get_folios()
      vmscan: Add check_move_unevictable_folios()
      shmem: Convert shmem_unlock_mapping() to use filemap_get_folios()
      filemap: Remove find_get_pages_range() and associated functions
      netfs: Remove extern from function prototypes
      filemap: Move 'filler' case to the end of do_read_cache_folio()
      filemap: Handle AOP_TRUNCATED_PAGE in do_read_cache_folio()
      filemap: Use filemap_read_folio() in do_read_cache_folio()
      docs: Improve ->read_folio documentation
      block: Remove check of PageError
      afs: Remove check of PageError
      freevxfs: Remove check of PageError
      hfs: Remove check for PageError
      hfsplus: Remove check for PageError
      ntfs: Remove check for PageError
      ext2: Remove check for PageError
      nilfs2: Remove check for PageError
      ntfs: Remove check for PageError
      ntfs3: Remove check for PageError
      reiserfs: Remove check for PageError
      ufs: Remove checks for PageError
      remap_range: Remove check of uptodate flag
      jfs: Remove check for PageUptodate
      iomap: Remove test for folio error
      orangefs: Remove test for folio error
      buffer: Remove check for PageError
      nfs: Leave pages in the pagecache if readpage failed
      buffer: Don't test folio error in block_read_full_folio()
      squashfs: Return the actual error from squashfs_read_folio()
      hostfs: Handle page write errors correctly
      ocfs2: Use filemap_write_and_wait_range() in ocfs2_cow_sync_writeback()
      cramfs: read_mapping_page() is synchronous
      block: Simplify read_part_sector()
      block: Handle partition read errors more consistently
      block: Use PAGE_SECTORS_SHIFT
      block: Convert read_part_sector() to use a folio
      befs: Convert befs_symlink_read_folio() to use a folio
      coda: Convert coda_symlink_filler() to use a folio
      freevxfs: Convert vxfs_immed_read_folio() to use a folio
      ocfs2: Convert ocfs2_read_folio() to use a folio
      gfs2: Convert gfs2_jhead_process_page() to use a folio
      ext2: Use a folio in ext2_get_page()
      secretmem: Remove isolate_page
      mm: Convert all PageMovable users to movable_operations
      fs: Add aops->migrate_folio
      mm/migrate: Convert fallback_migrate_page() to fallback_migrate_folio()
      mm/migrate: Convert writeout() to take a folio
      mm/migrate: Convert buffer_migrate_page() to buffer_migrate_folio()
      mm/migrate: Convert expected_page_refs() to folio_expected_refs()
      btrfs: Convert btree_migratepage to migrate_folio
      nfs: Convert to migrate_folio
      mm/migrate: Convert migrate_page() to migrate_folio()
      mm/migrate: Add filemap_migrate_folio()
      btrfs: Convert btrfs_migratepage to migrate_folio
      ubifs: Convert to filemap_migrate_folio()
      f2fs: Convert to filemap_migrate_folio()
      aio: Convert to migrate_folio
      hugetlb: Convert to migrate_folio
      secretmem: Convert to migrate_folio
      fs: Remove aops->migratepage()
      mm/folio-compat: Remove migration compatibility functions

 Documentation/admin-guide/cgroup-v1/memcg_test.rst |   2 +-
 Documentation/filesystems/ext2.rst                 |   2 -
 Documentation/filesystems/locking.rst              |   9 +-
 Documentation/filesystems/vfs.rst                  |  65 ++--
 Documentation/vm/page_migration.rst                | 113 +------
 arch/powerpc/platforms/pseries/cmm.c               |  60 +---
 block/fops.c                                       |   2 +-
 block/partitions/check.h                           |   4 +-
 block/partitions/core.c                            |  20 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c        |   4 +-
 drivers/misc/vmw_balloon.c                         |  61 +---
 drivers/virtio/virtio_balloon.c                    |  47 +--
 fs/afs/mntpt.c                                     |   6 -
 fs/aio.c                                           |  36 +-
 fs/befs/linuxvfs.c                                 |  16 +-
 fs/btrfs/disk-io.c                                 |  22 +-
 fs/btrfs/inode.c                                   |  26 +-
 fs/buffer.c                                        | 363 ++-------------------
 fs/coda/symlink.c                                  |  11 +-
 fs/cramfs/inode.c                                  |  17 +-
 fs/ext2/dir.c                                      |  20 +-
 fs/ext2/ext2.h                                     |   1 -
 fs/ext2/inode.c                                    |  53 +--
 fs/ext2/namei.c                                    |  10 +-
 fs/ext2/super.c                                    |   6 +-
 fs/ext4/inode.c                                    |  44 +--
 fs/f2fs/checkpoint.c                               |   4 +-
 fs/f2fs/compress.c                                 |  35 +-
 fs/f2fs/data.c                                     |  40 +--
 fs/f2fs/f2fs.h                                     |   4 -
 fs/f2fs/node.c                                     |   4 +-
 fs/freevxfs/vxfs_immed.c                           |  43 ++-
 fs/freevxfs/vxfs_subr.c                            |   6 -
 fs/gfs2/aops.c                                     |   2 +-
 fs/gfs2/lops.c                                     |  28 +-
 fs/hfs/bnode.c                                     |   4 -
 fs/hfsplus/bnode.c                                 |   4 -
 fs/hostfs/hostfs_kern.c                            |   6 +-
 fs/hugetlbfs/inode.c                               |  69 ++--
 fs/inode.c                                         |   2 +-
 fs/iomap/buffered-io.c                             |  28 --
 fs/jfs/inode.c                                     |  18 +-
 fs/jfs/jfs_metapage.c                              |   2 +-
 fs/mpage.c                                         | 125 +++----
 fs/nfs/file.c                                      |   4 +-
 fs/nfs/internal.h                                  |   6 +-
 fs/nfs/read.c                                      |   4 -
 fs/nfs/write.c                                     |  16 +-
 fs/nilfs2/dir.c                                    |   2 +-
 fs/nilfs2/page.c                                   |  60 ++--
 fs/ntfs/aops.c                                     |   6 +-
 fs/ntfs/aops.h                                     |   7 +-
 fs/ntfs/file.c                                     |   5 -
 fs/ntfs3/inode.c                                   |   8 +-
 fs/ntfs3/ntfs_fs.h                                 |   7 +-
 fs/ocfs2/aops.c                                    |  28 +-
 fs/ocfs2/refcounttree.c                            |  42 +--
 fs/orangefs/inode.c                                |   4 +-
 fs/reiserfs/xattr.c                                |   9 +-
 fs/remap_range.c                                   |  11 +-
 fs/squashfs/file.c                                 |  15 +-
 fs/ubifs/file.c                                    |  29 +-
 fs/ufs/dir.c                                       |   2 +-
 fs/ufs/util.c                                      |  11 -
 fs/xfs/xfs_aops.c                                  |   2 +-
 fs/zonefs/super.c                                  |   2 +-
 include/linux/balloon_compaction.h                 |   6 +-
 include/linux/buffer_head.h                        |  18 +-
 include/linux/fs.h                                 |  20 +-
 include/linux/iomap.h                              |   6 -
 include/linux/migrate.h                            |  78 +++--
 include/linux/mpage.h                              |   2 -
 include/linux/netfs.h                              |  23 +-
 include/linux/page-flags.h                         |   2 +-
 include/linux/pagemap.h                            |  33 +-
 include/linux/pagevec.h                            |  10 -
 include/linux/swap.h                               |   3 +-
 include/uapi/linux/magic.h                         |   4 -
 mm/balloon_compaction.c                            |  10 +-
 mm/compaction.c                                    |  34 +-
 mm/filemap.c                                       | 139 +++-----
 mm/folio-compat.c                                  |  22 --
 mm/huge_memory.c                                   |  11 +-
 mm/hugetlb.c                                       |  14 +-
 mm/ksm.c                                           |   2 +-
 mm/memory-failure.c                                |   2 +-
 mm/migrate.c                                       | 238 ++++++++------
 mm/migrate_device.c                                |   3 +-
 mm/secretmem.c                                     |  13 +-
 mm/shmem.c                                         |  19 +-
 mm/swap.c                                          |  29 --
 mm/swap_state.c                                    |   4 +-
 mm/truncate.c                                      |   2 +-
 mm/util.c                                          |   4 +-
 mm/vmscan.c                                        |  56 ++--
 mm/z3fold.c                                        |  84 +----
 mm/zsmalloc.c                                      | 102 ++----
 97 files changed, 830 insertions(+), 1887 deletions(-)

