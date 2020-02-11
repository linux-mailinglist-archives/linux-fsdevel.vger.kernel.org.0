Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E004A158764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 02:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgBKBEC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 20:04:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54850 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgBKBEA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 20:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=g3I96AED9xpuGVWKIIlCSpxOQGT6kirVfcGE/lGEHHY=; b=IXp8ySq9j05vmGKD4e3tUEEGfd
        hOOyiHFx8qObGT74MoBcbdPXktSRwwJozKH2633qw95TupzWzEwuw1RJ+zmC1prIg4EQiX6bkcTS/
        0aEQnOicMRpSjIA7dWMiAfE/9Cf++1qsl2uYViTvYIU9O27fy+VPmGQaU+EVbrXiIS/Ve7Cz47wmm
        QwBj1rPdBjR5+Q91XSAGgtCeOxAmZq1V5TIWdDqAdbUwe1ENxNkasVWcWE/bLyd5sZX47hK5A5qP4
        3u2UGE1vs769eDMQYnouLR87lD0ngEJvRttC6ZyZmpI+LPbwedvBRKxNUYNCE7pOiiMAsD7nQkHUb
        vwpQTIXg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1Jxu-0001ne-9M; Tue, 11 Feb 2020 01:03:50 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v5 00/13] Change readahead API
Date:   Mon, 10 Feb 2020 17:03:35 -0800
Message-Id: <20200211010348.6872-1-willy@infradead.org>
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

v5 switches to passing a readahead_control struct (mirroring the
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

This version deletes a lot more lines than previous versions of the patch
-- we're net -97 lines instead of -17 with v4.  It'll be even more when
we can finish the conversion and remove all the ->readpages support code,
including read_cache_pages().

Also new in v5 is patch 5 which adds page_cache_readahead_limit() and
converts ext4 and f2fs to use it for their Merkel trees.

Matthew Wilcox (Oracle) (13):
  mm: Fix the return type of __do_page_cache_readahead
  mm: Ignore return value of ->readpages
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
  iomap: Convert from readpages to readahead

 Documentation/filesystems/locking.rst |   6 +-
 Documentation/filesystems/vfs.rst     |  13 +++
 drivers/staging/exfat/exfat_super.c   |   7 +-
 fs/block_dev.c                        |   7 +-
 fs/btrfs/extent_io.c                  |  48 +++------
 fs/btrfs/extent_io.h                  |   3 +-
 fs/btrfs/inode.c                      |  16 ++-
 fs/erofs/data.c                       |  39 +++----
 fs/erofs/zdata.c                      |  29 ++----
 fs/ext2/inode.c                       |  10 +-
 fs/ext4/ext4.h                        |   3 +-
 fs/ext4/inode.c                       |  23 ++---
 fs/ext4/readpage.c                    |  22 ++--
 fs/ext4/verity.c                      |  35 +------
 fs/f2fs/data.c                        |  50 ++++-----
 fs/f2fs/f2fs.h                        |   5 +-
 fs/f2fs/verity.c                      |  35 +------
 fs/fat/inode.c                        |   7 +-
 fs/fuse/file.c                        |  46 ++++-----
 fs/gfs2/aops.c                        |  23 ++---
 fs/hpfs/file.c                        |   7 +-
 fs/iomap/buffered-io.c                | 103 ++++++-------------
 fs/iomap/trace.h                      |   2 +-
 fs/isofs/inode.c                      |   7 +-
 fs/jfs/inode.c                        |   7 +-
 fs/mpage.c                            |  38 +++----
 fs/nilfs2/inode.c                     |  15 +--
 fs/ocfs2/aops.c                       |  34 +++---
 fs/omfs/file.c                        |   7 +-
 fs/qnx6/inode.c                       |   7 +-
 fs/reiserfs/inode.c                   |   8 +-
 fs/udf/inode.c                        |   7 +-
 fs/xfs/xfs_aops.c                     |  13 +--
 fs/zonefs/super.c                     |   7 +-
 include/linux/fs.h                    |   2 +
 include/linux/iomap.h                 |   3 +-
 include/linux/mpage.h                 |   4 +-
 include/linux/pagemap.h               |  84 +++++++++++++++
 include/trace/events/erofs.h          |   6 +-
 include/trace/events/f2fs.h           |   6 +-
 mm/internal.h                         |   2 +-
 mm/migrate.c                          |   2 +-
 mm/readahead.c                        | 143 ++++++++++++++++----------
 43 files changed, 422 insertions(+), 519 deletions(-)

-- 
2.25.0

