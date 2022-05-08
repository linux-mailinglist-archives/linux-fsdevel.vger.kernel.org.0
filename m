Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252A151F12C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiEHUdp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiEHUdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:33:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE21BE3B
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uDj5DxG3H7YRfOGAJ3YA6PkQEsj+cHI1NeRXev9Cdzg=; b=FrMlCBgV7XvBFnFYvHBAtyHNIs
        +KyuuoX2Wmy7WkiPOPSWdyUcJqlr1wWSPxpAGwmKKnrPcBQmxOhN4L9z50tkqTLwXaIP4i76iB5KV
        d0iaJ4H7Ok4WN4+8kElwv2lQ283Mjsg+xXjrrlza0++aVALVqrcQFubs/hGf328EaHxIAkVm+o9Cd
        z6qB49iN9cEkcH5J49fKnWzqUcULb7/UvqEbAc3MRQG2Ebn684L+AmWwOeP7h9ELSrpeJn40z4zte
        QJ7Lsqvi5NlTSnrJXo0arTQ9Dn/W5uZuepYsTt2EGdeiLpGToqWKh1pJNlUgAHGDv/NmMDoTPztSp
        MJObihIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnXI-002nXV-NL; Sun, 08 May 2022 20:29:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/25] Remove AOP flags (and related cleanups)
Date:   Sun,  8 May 2022 21:29:16 +0100
Message-Id: <20220508202941.667024-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YngbFluT9ftR5dqf@casper.infradead.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
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

This started out as just removing the AOP_FLAG_*, but turned into
removing pagecache_write_begin/end(), and then Smatch found an
unnecessary stack variable in ntfs3.

Matthew Wilcox (Oracle) (25):
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
  ntfs3: Remove fsdata parameter from ntfs_extend_initialized_size()
  hfs: Call hfs_write_begin() and generic_write_end() directly
  hfsplus: Call hfsplus_write_begin() and generic_write_end() directly
  ext4: Call aops write_begin() and write_end() directly
  f2fs: Call aops write_begin() and write_end() directly
  i915: Call aops write_begin() and write_end() directly
  fs: Remove pagecache_write_begin() and pagecache_write_end()

 Documentation/filesystems/locking.rst       |  2 +-
 Documentation/filesystems/netfs_library.rst |  1 -
 Documentation/filesystems/porting.rst       |  2 +-
 Documentation/filesystems/vfs.rst           |  5 +--
 block/fops.c                                |  6 +--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c   | 23 ++++++------
 fs/9p/vfs_addr.c                            |  4 +-
 fs/adfs/inode.c                             |  4 +-
 fs/affs/file.c                              | 10 ++---
 fs/afs/internal.h                           |  2 +-
 fs/afs/write.c                              |  4 +-
 fs/bfs/file.c                               |  5 +--
 fs/buffer.c                                 | 27 +++++++-------
 fs/ceph/addr.c                              |  4 +-
 fs/cifs/file.c                              |  4 +-
 fs/ecryptfs/mmap.c                          |  4 +-
 fs/exfat/inode.c                            |  4 +-
 fs/ext2/inode.c                             | 11 ++----
 fs/ext4/ext4.h                              |  2 -
 fs/ext4/inline.c                            | 41 ++++++++++-----------
 fs/ext4/inode.c                             | 19 +++++-----
 fs/ext4/move_extent.c                       | 13 +++++--
 fs/ext4/namei.c                             |  7 +++-
 fs/ext4/verity.c                            |  9 +++--
 fs/f2fs/data.c                              |  5 +--
 fs/f2fs/f2fs.h                              |  9 ++++-
 fs/f2fs/super.c                             |  2 +-
 fs/f2fs/verity.c                            |  9 +++--
 fs/fat/inode.c                              |  4 +-
 fs/fuse/file.c                              |  7 ++--
 fs/hfs/extent.c                             |  6 +--
 fs/hfs/hfs_fs.h                             |  2 +
 fs/hfs/inode.c                              |  7 ++--
 fs/hfsplus/extents.c                        |  8 ++--
 fs/hfsplus/hfsplus_fs.h                     |  2 +
 fs/hfsplus/inode.c                          |  7 ++--
 fs/hostfs/hostfs_kern.c                     |  4 +-
 fs/hpfs/file.c                              |  4 +-
 fs/hugetlbfs/inode.c                        |  2 +-
 fs/jffs2/file.c                             |  6 +--
 fs/jfs/inode.c                              |  5 +--
 fs/libfs.c                                  |  4 +-
 fs/minix/inode.c                            |  5 +--
 fs/namei.c                                  | 28 ++++++--------
 fs/netfs/buffered_read.c                    | 10 ++---
 fs/nfs/file.c                               |  4 +-
 fs/nilfs2/inode.c                           |  5 +--
 fs/nilfs2/recovery.c                        |  2 +-
 fs/ntfs3/file.c                             |  7 +---
 fs/ntfs3/inode.c                            | 18 ++++-----
 fs/ntfs3/ntfs_fs.h                          |  5 +++
 fs/ocfs2/aops.c                             |  2 +-
 fs/omfs/file.c                              |  5 +--
 fs/orangefs/inode.c                         |  7 ++--
 fs/reiserfs/inode.c                         |  4 +-
 fs/sysv/itree.c                             |  4 +-
 fs/ubifs/file.c                             | 11 +++---
 fs/udf/file.c                               |  4 +-
 fs/udf/inode.c                              |  4 +-
 fs/ufs/inode.c                              |  5 +--
 include/linux/buffer_head.h                 |  6 +--
 include/linux/fs.h                          | 22 +----------
 include/linux/netfs.h                       |  2 +-
 include/linux/pagemap.h                     |  2 +-
 include/trace/events/ext4.h                 | 21 ++++-------
 include/trace/events/f2fs.h                 | 12 ++----
 mm/filemap.c                                | 24 +-----------
 mm/folio-compat.c                           |  4 +-
 mm/shmem.c                                  |  2 +-
 69 files changed, 233 insertions(+), 298 deletions(-)

-- 
2.34.1
