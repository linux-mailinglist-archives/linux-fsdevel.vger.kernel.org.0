Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 587F914F844
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2020 16:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgBAPMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Feb 2020 10:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51822 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBAPMm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Feb 2020 10:12:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dB7ywmsatelLVL7Psw2UVkpn4TS1ismlyPRVqvsNN4I=; b=RnoVi6fUM/M58i6TYhoTLY0TL
        V7I9zpJWwCzNP2scBs5DKrt7H9v8YkzB+zy/W4DudHEy5O3nZ2nS+CmMmx7gYjNpb//bY/tIKKSyZ
        BoIYl7MaogIfsM0Y9tjCirctp4DMLxm6KpweOFcDQtxE+etr4078ycEjYIbRbs9F7wyfbU5GGbVy3
        fnFz1u13IqALNOQOFhi0zXFNp8K2To+TxPFBQ7dryOGOMrqog5fJewQfdZiz2SpgzlRxhq5dAlgjj
        JO1o3SZNAvTMRVCpWVcSJwTwalk4DOgKQ0oSw60THP3NVyDBfjsNRTxzLp1iNTUgC+HvKJkv6LBzz
        TzfPOsY9g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixuRu-0006HE-1K; Sat, 01 Feb 2020 15:12:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH v4 00/12] Change readahead API
Date:   Sat,  1 Feb 2020 07:12:28 -0800
Message-Id: <20200201151240.24082-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

I would particularly value feedback on this from the gfs2 and ocfs2
maintainers.  They have non-trivial changes, and a review on patch 5
would be greatly appreciated.

This series adds a readahead address_space operation to eventually
replace the readpages operation.  The key difference is that
pages are added to the page cache as they are allocated (and
then looked up by the filesystem) instead of passing them on a
list to the readpages operation and having the filesystem add
them to the page cache.  It's a net reduction in code for each
implementation, more efficient than walking a list, and solves
the direct-write vs buffered-read problem reported by yu kuai at
https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/

v4:
 - Rebase on current Linus (a62aa6f7f50a ("Merge tag 'gfs2-for-5.6'"))
 - Add comment to __do_page_cache_readahead() acknowledging we don't
   care _that_ much about setting PageReadahead.
 - Fix the return value check of add_to_page_cache_lru().
 - Add a missing call to put_page() in __do_page_cache_readahead() if
   we fail to insert the page.
 - Improve the documentation of ->readahead (including indentation
   problem identified by Randy).
 - Fix off by one error in read_pages() (Dave Chinner).
 - Fix nr_pages manipulation in btrfs (Dave Chinner).
 - Remove bogus refcount fix in erofs (Gao Xiang, Dave Chinner).
 - Update ext4 patch for Merkle tree readahead.
 - Update f2fs patch for Merkle tree readahead.
 - Reinstate next_page label in f2fs_readpages() now it's used by the
   compression code.
 - Reinstate call to fuse_wait_on_page_writeback (Miklos Szeredi).
 - Remove a double-unlock in the error path in fuse.
 - Remove an odd fly-speck in fuse_readpages().
 - Make nr_pages loop in fuse_readpages less convoluted (Dave Chinner).

Matthew Wilcox (Oracle) (12):
  mm: Fix the return type of __do_page_cache_readahead
  readahead: Ignore return value of ->readpages
  readahead: Put pages in cache earlier
  mm: Add readahead address space operation
  fs: Convert mpage_readpages to mpage_readahead
  btrfs: Convert from readpages to readahead
  erofs: Convert uncompressed files from readpages to readahead
  erofs: Convert compressed files from readpages to readahead
  ext4: Convert from readpages to readahead
  f2fs: Convert from readpages to readahead
  fuse: Convert from readpages to readahead
  iomap: Convert from readpages to readahead

 Documentation/filesystems/locking.rst |  7 ++-
 Documentation/filesystems/vfs.rst     | 14 +++++
 drivers/staging/exfat/exfat_super.c   |  9 +--
 fs/block_dev.c                        |  9 +--
 fs/btrfs/extent_io.c                  | 19 +++---
 fs/btrfs/extent_io.h                  |  2 +-
 fs/btrfs/inode.c                      | 18 +++---
 fs/erofs/data.c                       | 33 ++++------
 fs/erofs/zdata.c                      | 21 +++----
 fs/ext2/inode.c                       | 12 ++--
 fs/ext4/ext4.h                        |  5 +-
 fs/ext4/inode.c                       | 24 ++++----
 fs/ext4/readpage.c                    | 20 +++---
 fs/ext4/verity.c                      | 16 +++--
 fs/f2fs/data.c                        | 35 +++++------
 fs/f2fs/f2fs.h                        |  5 +-
 fs/f2fs/verity.c                      | 16 +++--
 fs/fat/inode.c                        |  8 +--
 fs/fuse/file.c                        | 37 +++++------
 fs/gfs2/aops.c                        | 20 +++---
 fs/hpfs/file.c                        |  8 +--
 fs/iomap/buffered-io.c                | 74 +++++-----------------
 fs/iomap/trace.h                      |  2 +-
 fs/isofs/inode.c                      |  9 +--
 fs/jfs/inode.c                        |  8 +--
 fs/mpage.c                            | 38 ++++--------
 fs/nilfs2/inode.c                     | 13 ++--
 fs/ocfs2/aops.c                       | 32 +++++-----
 fs/omfs/file.c                        |  8 +--
 fs/qnx6/inode.c                       |  8 +--
 fs/reiserfs/inode.c                   | 10 +--
 fs/udf/inode.c                        |  8 +--
 fs/xfs/xfs_aops.c                     | 10 +--
 include/linux/fs.h                    |  2 +
 include/linux/iomap.h                 |  2 +-
 include/linux/mpage.h                 |  2 +-
 include/linux/pagemap.h               | 12 ++++
 include/trace/events/erofs.h          |  6 +-
 include/trace/events/f2fs.h           |  6 +-
 mm/internal.h                         |  2 +-
 mm/migrate.c                          |  2 +-
 mm/readahead.c                        | 89 ++++++++++++++++++---------
 42 files changed, 332 insertions(+), 349 deletions(-)

-- 
2.24.1

