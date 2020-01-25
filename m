Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9990C1492A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 02:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729814AbgAYBgA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jan 2020 20:36:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36760 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387678AbgAYBf7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r6GOkDmHzXzhSVqOAD8xlLIM6J6vOicE1/PE/yHNhJg=; b=u/qkoarH8z0iijq33ZVQ9301v
        9Rwk5QUWYJuir0JRz2g3gAvmwfEk2dveuO6cp6kOah1H+gU5RcgFpZyz8DOTwcq4u41wsYNesptA0
        DXWwxdfd621h81YVmJJ6QyYt9XLzBwRj4Jjxdi+im2s9zwR/Mdkn5Xy9ag9DkFKXzAcHngeQJznAY
        IH/oeFxaS/lqVzfpSuTithOrftDc8EsfLSUsRuMvpblcWkatJapDh1LX+b0NnrjN3vpcLlh3vxdyB
        4FxYQxNjeDWA6ghvaA058mgMgNJpasVgaPd45I3lX1j0F1vfqg5aArs0bf9j0xFTI4zgAeO6rnM94
        yjHIU1COw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivAMd-0006VA-6E; Sat, 25 Jan 2020 01:35:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 00/12] Change readahead API
Date:   Fri, 24 Jan 2020 17:35:41 -0800
Message-Id: <20200125013553.24899-1-willy@infradead.org>
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
 Documentation/filesystems/vfs.rst     | 11 ++++
 drivers/staging/exfat/exfat_super.c   |  9 ++--
 fs/block_dev.c                        |  9 ++--
 fs/btrfs/extent_io.c                  | 15 ++----
 fs/btrfs/extent_io.h                  |  2 +-
 fs/btrfs/inode.c                      | 18 +++----
 fs/erofs/data.c                       | 34 +++++-------
 fs/erofs/zdata.c                      | 21 +++-----
 fs/ext2/inode.c                       | 12 ++---
 fs/ext4/ext4.h                        |  2 +-
 fs/ext4/inode.c                       | 24 ++++-----
 fs/ext4/readpage.c                    | 20 +++----
 fs/f2fs/data.c                        | 33 +++++-------
 fs/fat/inode.c                        |  8 +--
 fs/fuse/file.c                        | 35 ++++++------
 fs/gfs2/aops.c                        | 20 ++++---
 fs/hpfs/file.c                        |  8 +--
 fs/iomap/buffered-io.c                | 74 ++++++--------------------
 fs/iomap/trace.h                      |  2 +-
 fs/isofs/inode.c                      |  9 ++--
 fs/jfs/inode.c                        |  8 +--
 fs/mpage.c                            | 38 +++++---------
 fs/nilfs2/inode.c                     | 13 ++---
 fs/ocfs2/aops.c                       | 32 +++++------
 fs/omfs/file.c                        |  8 +--
 fs/qnx6/inode.c                       |  8 +--
 fs/reiserfs/inode.c                   | 10 ++--
 fs/udf/inode.c                        |  8 +--
 fs/xfs/xfs_aops.c                     | 10 ++--
 include/linux/fs.h                    |  2 +
 include/linux/iomap.h                 |  2 +-
 include/linux/mpage.h                 |  2 +-
 include/linux/pagemap.h               | 12 +++++
 include/trace/events/erofs.h          |  6 +--
 include/trace/events/f2fs.h           |  6 +--
 mm/internal.h                         |  2 +-
 mm/migrate.c                          |  2 +-
 mm/readahead.c                        | 76 +++++++++++++++++----------
 39 files changed, 289 insertions(+), 329 deletions(-)

-- 
2.24.1

