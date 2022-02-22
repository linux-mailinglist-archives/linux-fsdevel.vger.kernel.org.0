Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39EF4C0249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiBVTsx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 14:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiBVTsw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:48:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE52B65C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Feb 2022 11:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7R8UPC8xfiSpiaSQ/FTgWPVECIXvkksKDAcNugwKdwY=; b=XUkcEVtW1yLhTzfBd2bmiH0Oyb
        em5DN2dlx/xh1H0+Yhhq4KVUraSO2vahFTuW4/wGM0/9vpaILMDYRvHefKICqU54ywrm0tSJTeh5g
        eK+pTAtr/v7JgeupNWVSrqlfIe6mdnAs2ycr66J0vUpYrDcdIQsmB65p16V19/qNukA3ZMNcoqoLa
        aM224HUE1zO2kJerqZIPBAAkpE/aaRH/cSinBOUryPX0iWzEmYJ4+o7edJSlswhEl3mvEo9jf3Swc
        /8H8yBTqPUzfFUM1hOg4SB3Pb2ypl0TUEeqS9JYWbMW6UnvIVDG/PiyJTU+MrL22GeVjNS8e/RPYk
        O1pBcexw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMb94-0035zR-TY; Tue, 22 Feb 2022 19:48:22 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/22] Remove aop flags
Date:   Tue, 22 Feb 2022 19:47:58 +0000
Message-Id: <20220222194820.737755-1-willy@infradead.org>
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

Thanks to Edward, we can now remove all the AOP_FLAG uses in the kernel
and remove the flags parameter from all write_begin implementations.

Edward Shishkin (1):
  reiserfs: Stop using AOP_FLAG_CONT_EXPAND flag

Matthew Wilcox (Oracle) (21):
  fs: Pass an iocb to generic_perform_write()
  fs: Move pagecache_write_begin() and pagecache_write_end()
  filemap: Remove AOP_FLAG_CONT_EXPAND
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
  fs: Remove aop flags argument from pagecache_write_begin()
  fs: Remove aop_flags parameter from netfs_write_begin()
  fs: Remove aop flags parameter from block_write_begin()
  fs: Remove aop flags parameter from cont_write_begin()
  fs: Remove aop flags parameter from grab_cache_page_write_begin()
  affs: Use pagecache_write_begin() & pagecache_write_end()
  f2fs: Use pagecache_write_begin() & pagecache_write_end()
  fs: Remove aop flags parameter from nobh_write_begin()
  fs: Remove flags parameter from aops->write_begin

 Documentation/filesystems/locking.rst       |  2 +-
 Documentation/filesystems/netfs_library.rst |  1 -
 Documentation/filesystems/porting.rst       |  2 +-
 Documentation/filesystems/vfs.rst           |  5 +--
 block/fops.c                                |  6 +--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c   |  6 +--
 fs/9p/vfs_addr.c                            |  4 +-
 fs/adfs/inode.c                             |  4 +-
 fs/affs/file.c                              | 14 ++++---
 fs/afs/internal.h                           |  2 +-
 fs/afs/write.c                              |  4 +-
 fs/bfs/file.c                               |  5 +--
 fs/buffer.c                                 | 20 +++++-----
 fs/ceph/addr.c                              |  6 +--
 fs/ceph/file.c                              |  2 +-
 fs/cifs/file.c                              |  4 +-
 fs/ecryptfs/mmap.c                          |  4 +-
 fs/exfat/inode.c                            |  4 +-
 fs/ext2/inode.c                             | 11 ++----
 fs/ext4/ext4.h                              |  2 -
 fs/ext4/file.c                              |  2 +-
 fs/ext4/inline.c                            | 41 ++++++++++-----------
 fs/ext4/inode.c                             | 19 +++++-----
 fs/ext4/move_extent.c                       | 13 +++++--
 fs/ext4/namei.c                             |  7 +++-
 fs/ext4/verity.c                            |  2 +-
 fs/f2fs/data.c                              |  5 +--
 fs/f2fs/f2fs.h                              |  9 ++++-
 fs/f2fs/file.c                              |  2 +-
 fs/f2fs/super.c                             |  5 +--
 fs/f2fs/verity.c                            |  2 +-
 fs/fat/inode.c                              |  4 +-
 fs/fuse/file.c                              |  7 ++--
 fs/hfs/extent.c                             |  2 +-
 fs/hfs/inode.c                              |  4 +-
 fs/hfsplus/extents.c                        |  2 +-
 fs/hfsplus/inode.c                          |  4 +-
 fs/hostfs/hostfs_kern.c                     |  4 +-
 fs/hpfs/file.c                              |  4 +-
 fs/hugetlbfs/inode.c                        |  2 +-
 fs/jffs2/file.c                             |  6 +--
 fs/jfs/inode.c                              |  5 +--
 fs/libfs.c                                  |  4 +-
 fs/minix/inode.c                            |  5 +--
 fs/namei.c                                  | 25 +++++--------
 fs/netfs/read_helper.c                      |  8 +---
 fs/nfs/file.c                               |  6 +--
 fs/nilfs2/inode.c                           |  5 +--
 fs/nilfs2/recovery.c                        |  2 +-
 fs/ntfs3/file.c                             |  2 +-
 fs/ntfs3/inode.c                            |  8 ++--
 fs/ocfs2/aops.c                             |  2 +-
 fs/omfs/file.c                              |  5 +--
 fs/orangefs/inode.c                         |  7 ++--
 fs/reiserfs/inode.c                         | 20 ++++------
 fs/sysv/itree.c                             |  4 +-
 fs/ubifs/file.c                             | 11 +++---
 fs/udf/file.c                               |  4 +-
 fs/udf/inode.c                              |  4 +-
 fs/ufs/inode.c                              |  5 +--
 include/linux/buffer_head.h                 |  6 +--
 include/linux/fs.h                          | 25 ++-----------
 include/linux/netfs.h                       |  2 +-
 include/linux/pagemap.h                     | 22 ++++++++++-
 include/trace/events/ext4.h                 | 21 ++++-------
 include/trace/events/f2fs.h                 | 12 ++----
 mm/filemap.c                                | 34 ++++-------------
 mm/folio-compat.c                           |  4 +-
 mm/shmem.c                                  |  2 +-
 69 files changed, 227 insertions(+), 287 deletions(-)

-- 
2.34.1

