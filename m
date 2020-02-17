Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAE0E161AC7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 19:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgBQSsK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 13:48:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48148 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbgBQSqW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 13:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=T1hWdYf0rB2BfBCCA/ycayjeULcD1RhEgE660nEF24U=; b=sDP0FQJf/K4vAFf0xbBt1NG5yU
        BQo1zx2sDVZ4f5cBkmFWO1G5RYV/E561hS2Td5IkHpV55ScSQW46Pj3wPG/gZaXv5iWHZLxlFtSnT
        BjLdIL++tZJlAw+Xzc28cr0VXtl8dDkruXjAEG9us+5NgJF/WpeRWy/LlJXX4j3I+4+SEJhRWETgz
        Pc3A3JXDX5ggpPhYiDZYGDq58my+Q7ybdYT8YK8UL/adpWVgbm5fu+cJicN73uRbmjyuszU+cwKHN
        CfFecxgyQQHpcERi6MFkYvGkiqN5jvoxW64RDHCkUV7Phh5O9263P2GEglbrJexeT6DAt54eb4wHq
        2EZUCDbw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPL-00058b-99; Mon, 17 Feb 2020 18:46:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 00/19] Change readahead API
Date:   Mon, 17 Feb 2020 10:45:41 -0800
Message-Id: <20200217184613.19668-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This series adds a readahead address_space operation to eventually
replace the readpages operation.  The key difference is that
pages are added to the page cache as they are allocated (and
then looked up by the filesystem) instead of passing them on a
list to the readpages operation and having the filesystem add
them to the page cache.  It's a net reduction in code for each
implementation, more efficient than walking a list, and solves
the direct-write vs buffered-read problem reported by yu kuai at
https://lore.kernel.org/linux-fsdevel/20200116063601.39201-1-yukuai3@huawei.com/

The only unconverted filesystems are those which use fscache.
Their conversion is pending Dave Howells' rewrite which will make the
conversion substantially easier.

v6:
 - Name the private members of readahead_control with a leading underscore
   (suggested by Christoph Hellwig)
 - Fix whitespace in rst file
 - Remove misleading comment in btrfs patch
 - Add readahead_next() API and use it in iomap
 - Add iomap_readahead kerneldoc.
 - Fix the mpage_readahead kerneldoc
 - Make various readahead functions return void
 - Keep readahead_index() and readahead_offset() pointing to the start of
   this batch through the body.  No current user requires this, but it's
   less surprising.
 - Add kerneldoc for page_cache_readahead_limit
 - Make page_idx an unsigned long, and rename it to just 'i'
 - Get rid of page_offset local variable
 - Add patch to call memalloc_nofs_save() before allocating pages (suggested
   by Michal Hocko)
 - Resplit a lot of patches for more logical progression and easier review
   (suggested by John Hubbard)
 - Added sign-offs where received, and I deemed still relevant

v5 switched to passing a readahead_control struct (mirroring the
writepages_control struct passed to writepages).  This has a number of
advantages:
 - It fixes a number of bugs in various implementations, eg forgetting to
   increment 'start', an off-by-one error in 'nr_pages' or treating 'start'
   as a byte offset instead of a page offset.
 - It allows us to change the arguments without changing all the
   implementations of ->readahead which just call mpage_readahead() or
   iomap_readahead()
 - Figuring out which pages haven't been attempted by the implementation
   is more natural this way.
 - There's less code in each implementation.

Matthew Wilcox (Oracle) (19):
  mm: Return void from various readahead functions
  mm: Ignore return value of ->readpages
  mm: Use readahead_control to pass arguments
  mm: Rearrange readahead loop
  mm: Remove 'page_offset' from readahead loop
  mm: rename readahead loop variable to 'i'
  mm: Put readahead pages in cache earlier
  mm: Add readahead address space operation
  mm: Add page_cache_readahead_limit
  fs: Convert mpage_readpages to mpage_readahead
  btrfs: Convert from readpages to readahead
  erofs: Convert uncompressed files from readpages to readahead
  erofs: Convert compressed files from readpages to readahead
  ext4: Convert from readpages to readahead
  f2fs: Convert from readpages to readahead
  fuse: Convert from readpages to readahead
  iomap: Restructure iomap_readpages_actor
  iomap: Convert from readpages to readahead
  mm: Use memalloc_nofs_save in readahead path

 Documentation/filesystems/locking.rst |   6 +-
 Documentation/filesystems/vfs.rst     |  13 ++
 drivers/staging/exfat/exfat_super.c   |   7 +-
 fs/block_dev.c                        |   7 +-
 fs/btrfs/extent_io.c                  |  46 ++-----
 fs/btrfs/extent_io.h                  |   3 +-
 fs/btrfs/inode.c                      |  16 +--
 fs/erofs/data.c                       |  39 ++----
 fs/erofs/zdata.c                      |  29 ++--
 fs/ext2/inode.c                       |  10 +-
 fs/ext4/ext4.h                        |   3 +-
 fs/ext4/inode.c                       |  23 ++--
 fs/ext4/readpage.c                    |  22 ++-
 fs/ext4/verity.c                      |  35 +----
 fs/f2fs/data.c                        |  50 +++----
 fs/f2fs/f2fs.h                        |   5 +-
 fs/f2fs/verity.c                      |  35 +----
 fs/fat/inode.c                        |   7 +-
 fs/fuse/file.c                        |  46 +++----
 fs/gfs2/aops.c                        |  23 ++--
 fs/hpfs/file.c                        |   7 +-
 fs/iomap/buffered-io.c                | 118 +++++++----------
 fs/iomap/trace.h                      |   2 +-
 fs/isofs/inode.c                      |   7 +-
 fs/jfs/inode.c                        |   7 +-
 fs/mpage.c                            |  38 ++----
 fs/nilfs2/inode.c                     |  15 +--
 fs/ocfs2/aops.c                       |  34 ++---
 fs/omfs/file.c                        |   7 +-
 fs/qnx6/inode.c                       |   7 +-
 fs/reiserfs/inode.c                   |   8 +-
 fs/udf/inode.c                        |   7 +-
 fs/xfs/xfs_aops.c                     |  13 +-
 fs/zonefs/super.c                     |   7 +-
 include/linux/fs.h                    |   2 +
 include/linux/iomap.h                 |   3 +-
 include/linux/mpage.h                 |   4 +-
 include/linux/pagemap.h               |  90 +++++++++++++
 include/trace/events/erofs.h          |   6 +-
 include/trace/events/f2fs.h           |   6 +-
 mm/internal.h                         |   8 +-
 mm/migrate.c                          |   2 +-
 mm/readahead.c                        | 184 +++++++++++++++++---------
 43 files changed, 474 insertions(+), 533 deletions(-)


base-commit: 11a48a5a18c63fd7621bb050228cebf13566e4d8
-- 
2.25.0

