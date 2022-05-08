Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B7F51F157
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbiEHUfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiEHUfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:35:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B4EC6D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iQ1h7KTwxnRVxLZI8bsjXJ1ukrKxSMWB4fQuVGsWrMg=; b=vXc6UR0NDXI7zLEKL5IfTZC9PW
        OteMMk+QffoH4Nzt56PD7JG3VCM6Lvz08Ky6eEcEUv41IjBDcMnESTiUUmZO65ppqpWFF5GWqf6H1
        oVLChQR42L6WqiSN20rsSY36srJYHLmIKNn/uTCxWp5tJWBq8pCYog1AbfaRrIQHjkoAOu5A0eNhi
        fTNfrjmzYTglOGBYyFuw5sR4/XevlD7SEps5TCKZ+6vJwQ6Q5RLspQXRarRlYiCEpoGjNlNT14G+y
        DEXEvffB1sFxpSjHLKndfojY0YNxqH9vReQmJ4XdGj89WgHOkH9HBAA2Am0m26ZdSGoVf2k8hMHZJ
        aeLAExzg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnZ2-002nmw-K6; Sun, 08 May 2022 20:31:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/37] Convert aops->read_page to aops->read_folio
Date:   Sun,  8 May 2022 21:30:54 +0100
Message-Id: <20220508203131.667959-1-willy@infradead.org>
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

Thanks to Christoph & Kees for pointing out that I'd inadvertently
broken CFI builds; I basically open-coded Kees' suggestion.

The swap_readpage commit is broken out to ease the merge.  Now that
Andrew's using git, I can look into basing on part of his tree, and
that way we can resolve the conflict before Linus sees it.

Matthew Wilcox (Oracle) (37):
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

 Documentation/filesystems/fscrypt.rst       |  2 +-
 Documentation/filesystems/fsverity.rst      |  2 +-
 Documentation/filesystems/locking.rst       | 10 ++--
 Documentation/filesystems/netfs_library.rst |  8 +--
 Documentation/filesystems/vfs.rst           | 20 ++++----
 block/fops.c                                |  6 +--
 fs/9p/vfs_addr.c                            |  2 +-
 fs/adfs/inode.c                             |  6 +--
 fs/affs/file.c                              | 11 +++--
 fs/affs/symlink.c                           |  5 +-
 fs/afs/file.c                               | 17 +++----
 fs/befs/linuxvfs.c                          | 17 ++++---
 fs/bfs/file.c                               |  6 +--
 fs/btrfs/ctree.h                            |  2 +-
 fs/btrfs/file.c                             |  7 +--
 fs/btrfs/free-space-cache.c                 |  2 +-
 fs/btrfs/inode.c                            |  7 +--
 fs/btrfs/ioctl.c                            |  2 +-
 fs/btrfs/relocation.c                       |  8 +--
 fs/btrfs/send.c                             |  2 +-
 fs/buffer.c                                 | 55 +++++++++++----------
 fs/ceph/addr.c                              |  4 +-
 fs/cifs/file.c                              | 13 ++---
 fs/coda/symlink.c                           |  7 +--
 fs/cramfs/README                            |  8 +--
 fs/cramfs/inode.c                           |  7 +--
 fs/ecryptfs/mmap.c                          | 11 +++--
 fs/efs/inode.c                              |  8 +--
 fs/efs/symlink.c                            |  5 +-
 fs/erofs/data.c                             |  6 +--
 fs/erofs/zdata.c                            |  7 +--
 fs/exfat/inode.c                            |  6 +--
 fs/ext2/inode.c                             |  8 +--
 fs/ext4/inode.c                             |  9 ++--
 fs/ext4/move_extent.c                       |  4 +-
 fs/ext4/readpage.c                          |  4 +-
 fs/f2fs/data.c                              |  5 +-
 fs/fat/inode.c                              |  6 +--
 fs/freevxfs/vxfs_immed.c                    | 15 +++---
 fs/freevxfs/vxfs_subr.c                     | 17 +++----
 fs/fuse/dir.c                               | 10 ++--
 fs/fuse/file.c                              |  5 +-
 fs/gfs2/aops.c                              | 18 +++----
 fs/hfs/inode.c                              |  8 +--
 fs/hfsplus/inode.c                          |  8 +--
 fs/hostfs/hostfs_kern.c                     |  5 +-
 fs/hpfs/file.c                              |  6 +--
 fs/hpfs/namei.c                             |  5 +-
 fs/iomap/buffered-io.c                      | 16 +++---
 fs/isofs/compress.c                         |  5 +-
 fs/isofs/inode.c                            |  6 +--
 fs/isofs/rock.c                             |  7 +--
 fs/jffs2/file.c                             | 10 ++--
 fs/jffs2/fs.c                               |  2 +-
 fs/jfs/inode.c                              |  6 +--
 fs/jfs/jfs_metapage.c                       |  5 +-
 fs/libfs.c                                  | 14 +++---
 fs/minix/inode.c                            |  6 +--
 fs/mpage.c                                  | 18 ++++---
 fs/netfs/buffered_read.c                    | 15 +++---
 fs/nfs/file.c                               |  4 +-
 fs/nfs/read.c                               |  3 +-
 fs/nilfs2/inode.c                           | 10 ++--
 fs/ntfs/aops.c                              | 40 ++++++++-------
 fs/ntfs/aops.h                              |  6 +--
 fs/ntfs/attrib.c                            |  2 +-
 fs/ntfs/compress.c                          |  4 +-
 fs/ntfs/file.c                              |  4 +-
 fs/ntfs/inode.c                             |  4 +-
 fs/ntfs/mft.h                               |  2 +-
 fs/ntfs3/inode.c                            |  9 ++--
 fs/ocfs2/alloc.c                            |  2 +-
 fs/ocfs2/aops.c                             | 11 +++--
 fs/ocfs2/file.c                             |  2 +-
 fs/ocfs2/refcounttree.c                     |  6 ++-
 fs/ocfs2/symlink.c                          |  5 +-
 fs/omfs/file.c                              |  6 +--
 fs/orangefs/inode.c                         | 33 ++++++-------
 fs/qnx4/inode.c                             |  7 +--
 fs/qnx6/inode.c                             |  6 +--
 fs/reiserfs/file.c                          |  2 +-
 fs/reiserfs/inode.c                         | 12 ++---
 fs/romfs/super.c                            |  9 ++--
 fs/squashfs/file.c                          |  5 +-
 fs/squashfs/super.c                         |  2 +-
 fs/squashfs/symlink.c                       |  5 +-
 fs/sysv/itree.c                             |  6 +--
 fs/ubifs/file.c                             | 12 +++--
 fs/ubifs/super.c                            |  2 +-
 fs/udf/file.c                               | 10 ++--
 fs/udf/inode.c                              |  6 +--
 fs/udf/symlink.c                            |  5 +-
 fs/ufs/inode.c                              |  8 +--
 fs/vboxsf/file.c                            |  5 +-
 fs/xfs/xfs_aops.c                           |  8 +--
 fs/zonefs/super.c                           |  6 +--
 include/linux/buffer_head.h                 |  2 +-
 include/linux/fs.h                          |  4 +-
 include/linux/iomap.h                       |  2 +-
 include/linux/mpage.h                       |  2 +-
 include/linux/netfs.h                       |  2 +-
 include/linux/nfs_fs.h                      |  2 +-
 kernel/events/uprobes.c                     |  7 +--
 mm/filemap.c                                | 10 ++--
 mm/memory.c                                 |  4 +-
 mm/page_io.c                                |  2 +-
 mm/readahead.c                              | 16 +++---
 mm/shmem.c                                  |  2 +-
 mm/swapfile.c                               |  2 +-
 109 files changed, 444 insertions(+), 404 deletions(-)

-- 
2.34.1
