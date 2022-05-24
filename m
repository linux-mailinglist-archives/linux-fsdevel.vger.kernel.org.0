Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD9E5331C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 May 2022 21:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiEXTey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 May 2022 15:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238881AbiEXTey (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 May 2022 15:34:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C11B71A1F;
        Tue, 24 May 2022 12:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EN+abiaSmC+CqbXP7kkIzWSw7eN9ToCXYZY15rbT7GI=; b=BALR1aw0P3ggIvAymcm8s4rdXr
        9XoszMXBvL/HHAP6LmsGDFLCkF6f9FFBUsSXOAWpwA69yA8wjPdVMEPEB/jU0m3GlbGcGReRE99zg
        NbUEaaPrIfM8z5SFt2hFT+ZNqXAHnr5NY/jffcYnfZfZibWFGMxk1aKQLBv+JU2K3mtafwMVvdwVu
        WvWNvDzwCJqIJ7+VIH5BqGu5gC47qTcIuck6UhBT6YV+axtSrzPPjw9ChGxTY3+LcSy8CWJWbqxa2
        F+2BuOKDLtAsAnv8tdyN6C4qW6Bvg8wCBQv8xlzGBCdsEt1GUiyXGjFb4mbGvxX5NFlmC3QaMpc3P
        DLrcUwig==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntaIn-00HMXU-OH; Tue, 24 May 2022 19:34:45 +0000
Date:   Tue, 24 May 2022 20:34:45 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] Page cache changes for 5.19
Message-ID: <Yo0zVZ7giRMWe+w5@casper.infradead.org>
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

These are the page cache changes for 5.19.  There are a few conflicts
with other peoples work:

btrfs: https://lore.kernel.org/linux-next/20220502174305.1cbf7b40@canb.auug.org.au/
btrfs: https://lore.kernel.org/linux-next/20220510183908.7571cb73@canb.auug.org.au/
erofs: https://lore.kernel.org/linux-next/20220502180425.7305c335@canb.auug.org.au/
f2fs: https://lore.kernel.org/linux-next/20220509174106.323ac148@canb.auug.org.au/
mm: https://lore.kernel.org/linux-next/20220503161444.11003568@canb.auug.org.au/
mm: https://lore.kernel.org/linux-next/20220502193603.77d31442@canb.auug.org.au/

The following changes since commit 379c72654524d97081f8810a0e4284a16f78a25e:

  Merge tag 'sound-5.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2022-05-08 10:10:51 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/willy/pagecache.git tags/folio-5.19

for you to fetch changes up to 516edb456f121e819d2130571004ed82f9566c4d:

  nilfs2: Fix some kernel-doc comments (2022-05-12 10:49:23 -0400)

----------------------------------------------------------------
Page cache changes for 5.19

 - Appoint myself page cache maintainer

 - Fix how scsicam uses the page cache

 - Use the memalloc_nofs_save() API to replace AOP_FLAG_NOFS

 - Remove the AOP flags entirely

 - Remove pagecache_write_begin() and pagecache_write_end()

 - Documentation updates

 - Convert several address_space operations to use folios:
   - is_dirty_writeback
   - readpage becomes read_folio
   - releasepage becomes release_folio
   - freepage becomes free_folio

 - Change filler_t to require a struct file pointer be the first argument
   like ->read_folio

----------------------------------------------------------------
Matthew Wilcox (Oracle) (105):
      scsicam: Fix use of page cache
      ext4: Use page_symlink() instead of __page_symlink()
      namei: Merge page_symlink() and __page_symlink()
      namei: Convert page_symlink() to use memalloc_nofs_save()
      f2fs: Convert f2fs_grab_cache_page() to use scoped memory APIs
      ext4: Allow GFP_FS allocations in ext4_da_convert_inline_data_to_extent()
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
      ntfs3: Remove fsdata parameter from ntfs_extend_initialized_size()
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
      fs: Add read_folio documentation
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
      mm,fs: Remove aops->readpage
      jffs2: Pass the file pointer to jffs2_do_readpage_unlock()
      nfs: Pass the file pointer to nfs_symlink_filler()
      fs: Change the type of filler_t
      mm/filemap: Hoist filler_t decision to the top of do_read_cache_folio()
      fs: Add aops->release_folio
      iomap: Convert to release_folio
      9p: Convert to release_folio
      afs: Convert to release_folio
      btrfs: Convert to release_folio
      ceph: Convert to release_folio
      cifs: Convert to release_folio
      erofs: Convert to release_folio
      ext4: Convert to release_folio
      f2fs: Convert to release_folio
      gfs2: Convert to release_folio
      hfs: Convert to release_folio
      hfsplus: Convert to release_folio
      jfs: Convert to release_folio
      nfs: Convert to release_folio
      nilfs2: Remove comment about releasepage
      ocfs2: Convert to release_folio
      orangefs: Convert to release_folio
      reiserfs: Convert to release_folio
      ubifs: Convert to release_folio
      fs: Remove last vestiges of releasepage
      reiserfs: Convert release_buffer_page() to use a folio
      jbd2: Convert jbd2_journal_try_to_free_buffers to take a folio
      jbd2: Convert release_buffer_page() to use a folio
      fs: Change try_to_free_buffers() to take a folio
      fs: Convert drop_buffers() to use a folio
      fs: Add free_folio address space operation
      orangefs: Convert to free_folio
      nfs: Convert to free_folio
      secretmem: Convert to free_folio
      fs: Remove aops->freepage
      Appoint myself page cache maintainer

Miaohe Lin (1):
      filemap: Remove obsolete comment in lock_page

Yang Li (1):
      nilfs2: Fix some kernel-doc comments

 Documentation/filesystems/caching/netfs-api.rst |   4 +-
 Documentation/filesystems/fscrypt.rst           |   2 +-
 Documentation/filesystems/fsverity.rst          |   2 +-
 Documentation/filesystems/locking.rst           |  36 ++--
 Documentation/filesystems/netfs_library.rst     |   9 +-
 Documentation/filesystems/porting.rst           |   2 +-
 Documentation/filesystems/vfs.rst               |  86 +++++-----
 MAINTAINERS                                     |  13 ++
 block/fops.c                                    |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c       |  23 ++-
 drivers/scsi/scsicam.c                          |  11 +-
 fs/9p/vfs_addr.c                                |  23 ++-
 fs/adfs/inode.c                                 |  10 +-
 fs/affs/file.c                                  |  21 +--
 fs/affs/symlink.c                               |   5 +-
 fs/afs/dir.c                                    |   7 +-
 fs/afs/file.c                                   |  28 ++--
 fs/afs/internal.h                               |   4 +-
 fs/afs/write.c                                  |   4 +-
 fs/befs/linuxvfs.c                              |  17 +-
 fs/bfs/file.c                                   |  11 +-
 fs/btrfs/ctree.h                                |   2 +-
 fs/btrfs/disk-io.c                              |  12 +-
 fs/btrfs/extent_io.c                            |  14 +-
 fs/btrfs/file.c                                 |   9 +-
 fs/btrfs/free-space-cache.c                     |   2 +-
 fs/btrfs/inode.c                                |  31 ++--
 fs/btrfs/ioctl.c                                |   2 +-
 fs/btrfs/relocation.c                           |  13 +-
 fs/btrfs/send.c                                 |   5 +-
 fs/buffer.c                                     | 214 ++++++++++++------------
 fs/ceph/addr.c                                  |  32 ++--
 fs/cifs/file.c                                  |  31 ++--
 fs/coda/symlink.c                               |   7 +-
 fs/cramfs/README                                |   8 +-
 fs/cramfs/inode.c                               |   7 +-
 fs/ecryptfs/mmap.c                              |  15 +-
 fs/efs/inode.c                                  |   8 +-
 fs/efs/symlink.c                                |   5 +-
 fs/erofs/data.c                                 |   6 +-
 fs/erofs/super.c                                |  16 +-
 fs/erofs/zdata.c                                |   7 +-
 fs/exfat/inode.c                                |  10 +-
 fs/ext2/inode.c                                 |  19 +--
 fs/ext4/ext4.h                                  |   2 -
 fs/ext4/inline.c                                |  41 +++--
 fs/ext4/inode.c                                 |  48 +++---
 fs/ext4/move_extent.c                           |  17 +-
 fs/ext4/namei.c                                 |   7 +-
 fs/ext4/readpage.c                              |   4 +-
 fs/ext4/verity.c                                |   9 +-
 fs/f2fs/checkpoint.c                            |   2 +-
 fs/f2fs/compress.c                              |   2 +-
 fs/f2fs/data.c                                  |  42 ++---
 fs/f2fs/f2fs.h                                  |  11 +-
 fs/f2fs/node.c                                  |   2 +-
 fs/f2fs/super.c                                 |   2 +-
 fs/f2fs/verity.c                                |   9 +-
 fs/fat/inode.c                                  |  10 +-
 fs/freevxfs/vxfs_immed.c                        |  15 +-
 fs/freevxfs/vxfs_subr.c                         |  17 +-
 fs/fuse/dir.c                                   |  10 +-
 fs/fuse/file.c                                  |  12 +-
 fs/gfs2/aops.c                                  |  81 +++++----
 fs/gfs2/inode.h                                 |   2 +-
 fs/gfs2/meta_io.c                               |   4 +-
 fs/hfs/extent.c                                 |   6 +-
 fs/hfs/hfs_fs.h                                 |   2 +
 fs/hfs/inode.c                                  |  38 ++---
 fs/hfsplus/extents.c                            |   8 +-
 fs/hfsplus/hfsplus_fs.h                         |   2 +
 fs/hfsplus/inode.c                              |  38 ++---
 fs/hostfs/hostfs_kern.c                         |   9 +-
 fs/hpfs/file.c                                  |  10 +-
 fs/hpfs/namei.c                                 |   5 +-
 fs/hugetlbfs/inode.c                            |   2 +-
 fs/iomap/buffered-io.c                          |  38 ++---
 fs/iomap/trace.h                                |   2 +-
 fs/isofs/compress.c                             |   5 +-
 fs/isofs/inode.c                                |   6 +-
 fs/isofs/rock.c                                 |   7 +-
 fs/jbd2/commit.c                                |  14 +-
 fs/jbd2/transaction.c                           |  14 +-
 fs/jffs2/file.c                                 |  23 ++-
 fs/jffs2/fs.c                                   |   2 +-
 fs/jffs2/gc.c                                   |   2 +-
 fs/jffs2/os-linux.h                             |   2 +-
 fs/jfs/inode.c                                  |  11 +-
 fs/jfs/jfs_metapage.c                           |  21 +--
 fs/libfs.c                                      |  18 +-
 fs/minix/inode.c                                |  11 +-
 fs/mpage.c                                      |  20 ++-
 fs/namei.c                                      |  28 ++--
 fs/netfs/buffered_read.c                        |  25 ++-
 fs/nfs/dir.c                                    |   9 +-
 fs/nfs/file.c                                   |  51 +++---
 fs/nfs/fscache.h                                |  14 +-
 fs/nfs/read.c                                   |   3 +-
 fs/nfs/symlink.c                                |  16 +-
 fs/nilfs2/inode.c                               |  27 ++-
 fs/nilfs2/recovery.c                            |   2 +-
 fs/ntfs/aops.c                                  |  40 ++---
 fs/ntfs/aops.h                                  |   6 +-
 fs/ntfs/attrib.c                                |   2 +-
 fs/ntfs/compress.c                              |   4 +-
 fs/ntfs/file.c                                  |   4 +-
 fs/ntfs/inode.c                                 |   4 +-
 fs/ntfs/mft.h                                   |   2 +-
 fs/ntfs3/file.c                                 |   7 +-
 fs/ntfs3/inode.c                                |  27 ++-
 fs/ntfs3/ntfs_fs.h                              |   5 +
 fs/ocfs2/alloc.c                                |   2 +-
 fs/ocfs2/aops.c                                 |  23 +--
 fs/ocfs2/file.c                                 |   2 +-
 fs/ocfs2/refcounttree.c                         |   6 +-
 fs/ocfs2/symlink.c                              |   5 +-
 fs/omfs/file.c                                  |  11 +-
 fs/orangefs/inode.c                             |  52 +++---
 fs/qnx4/inode.c                                 |   7 +-
 fs/qnx6/inode.c                                 |   6 +-
 fs/reiserfs/file.c                              |   2 +-
 fs/reiserfs/inode.c                             |  36 ++--
 fs/reiserfs/journal.c                           |  14 +-
 fs/romfs/super.c                                |   9 +-
 fs/squashfs/file.c                              |   5 +-
 fs/squashfs/super.c                             |   2 +-
 fs/squashfs/symlink.c                           |   5 +-
 fs/sysv/itree.c                                 |  10 +-
 fs/ubifs/file.c                                 |  41 ++---
 fs/ubifs/super.c                                |   2 +-
 fs/udf/file.c                                   |  14 +-
 fs/udf/inode.c                                  |  10 +-
 fs/udf/symlink.c                                |   5 +-
 fs/ufs/inode.c                                  |  13 +-
 fs/vboxsf/file.c                                |   5 +-
 fs/verity/enable.c                              |  29 ++--
 fs/xfs/xfs_aops.c                               |  10 +-
 fs/zonefs/super.c                               |   8 +-
 include/linux/buffer_head.h                     |  14 +-
 include/linux/fs.h                              |  32 +---
 include/linux/iomap.h                           |   4 +-
 include/linux/jbd2.h                            |   2 +-
 include/linux/mpage.h                           |   2 +-
 include/linux/netfs.h                           |   4 +-
 include/linux/nfs_fs.h                          |   2 +-
 include/linux/page-flags.h                      |   2 +-
 include/linux/pagemap.h                         |  78 +++++++--
 include/trace/events/ext4.h                     |  21 +--
 include/trace/events/f2fs.h                     |  12 +-
 kernel/events/uprobes.c                         |   7 +-
 mm/filemap.c                                    |  99 +++++------
 mm/folio-compat.c                               |   4 +-
 mm/memory.c                                     |   4 +-
 mm/migrate.c                                    |   2 +-
 mm/page-writeback.c                             |  10 +-
 mm/page_io.c                                    |   2 +-
 mm/readahead.c                                  |  37 ++--
 mm/secretmem.c                                  |   8 +-
 mm/shmem.c                                      |   4 +-
 mm/swapfile.c                                   |   2 +-
 mm/vmscan.c                                     |  12 +-
 161 files changed, 1232 insertions(+), 1212 deletions(-)

