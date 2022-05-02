Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A3D516A78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 07:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383385AbiEBF7t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 01:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiEBF7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 01:59:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866DC1FA43
        for <linux-fsdevel@vger.kernel.org>; Sun,  1 May 2022 22:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UYkFQPHPA+bZmD+J7R5LYC4O2pds8v7XV9bOtA9U9r8=; b=TsBH9fgtHehF8cH7qmy58862By
        RaffVqXorxTcpRsEmzOJM+b9e2jAsgjs31LPO2KbhH3f2Nl/JzAsrrDwMIxoYbfI8tkMDm94KNwbB
        4xeGqJ+hh6Gdt/xY8c9D73lpCW2yqaOIdQplNZO12EDZDV3j9NNMr5aRjI4LPKOTut0VmeV9+jsx3
        qjyt4XZUknYAq/b2Fz7YZhy7Yn9wNmhI5cM7lLNmQ9fHXRybcu16OK0a3Q68ipM1CQsHBoJNnVTQ5
        wM9oA+5BQkWl0C7StQjERohXvjH1x/3lMyGwiF2wYiK21x/BSAxIhoweOZAeMUBg/VHZsQglAXZ1m
        yreo3XpQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlP2e-00EZVP-Rs; Mon, 02 May 2022 05:56:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/26] Converting release_page to release_folio
Date:   Mon,  2 May 2022 06:55:48 +0100
Message-Id: <20220502055614.3473032-1-willy@infradead.org>
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

Continuing my quest to convert all the aops from pages to folios
... release_folio.

Matthew Wilcox (Oracle) (26):
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

 .../filesystems/caching/netfs-api.rst         |  4 +-
 Documentation/filesystems/locking.rst         | 14 ++---
 Documentation/filesystems/vfs.rst             | 45 ++++++++--------
 fs/9p/vfs_addr.c                              | 17 +++---
 fs/afs/dir.c                                  |  7 ++-
 fs/afs/file.c                                 | 11 ++--
 fs/afs/internal.h                             |  2 +-
 fs/btrfs/disk-io.c                            | 12 ++---
 fs/btrfs/extent_io.c                          | 14 ++---
 fs/btrfs/file.c                               |  2 +-
 fs/btrfs/inode.c                              | 24 ++++-----
 fs/buffer.c                                   | 54 +++++++++----------
 fs/ceph/addr.c                                | 24 ++++-----
 fs/cifs/file.c                                | 14 ++---
 fs/erofs/super.c                              | 16 +++---
 fs/ext4/inode.c                               | 20 +++----
 fs/f2fs/checkpoint.c                          |  2 +-
 fs/f2fs/compress.c                            |  2 +-
 fs/f2fs/data.c                                | 32 +++++------
 fs/f2fs/f2fs.h                                |  2 +-
 fs/f2fs/node.c                                |  2 +-
 fs/gfs2/aops.c                                | 44 +++++++--------
 fs/gfs2/inode.h                               |  2 +-
 fs/gfs2/meta_io.c                             |  4 +-
 fs/hfs/inode.c                                | 23 ++++----
 fs/hfsplus/inode.c                            | 23 ++++----
 fs/iomap/buffered-io.c                        | 22 ++++----
 fs/iomap/trace.h                              |  2 +-
 fs/jbd2/commit.c                              | 14 ++---
 fs/jbd2/transaction.c                         | 14 ++---
 fs/jfs/jfs_metapage.c                         | 16 +++---
 fs/mpage.c                                    |  2 +-
 fs/nfs/file.c                                 | 22 ++++----
 fs/nfs/fscache.h                              | 14 ++---
 fs/nilfs2/inode.c                             |  1 -
 fs/ocfs2/aops.c                               | 10 ++--
 fs/orangefs/inode.c                           |  6 +--
 fs/reiserfs/inode.c                           | 20 +++----
 fs/reiserfs/journal.c                         | 14 ++---
 fs/ubifs/file.c                               | 18 +++----
 fs/xfs/xfs_aops.c                             |  2 +-
 fs/zonefs/super.c                             |  2 +-
 include/linux/buffer_head.h                   |  4 +-
 include/linux/fs.h                            |  2 +-
 include/linux/iomap.h                         |  2 +-
 include/linux/jbd2.h                          |  2 +-
 include/linux/page-flags.h                    |  2 +-
 include/linux/pagemap.h                       |  4 --
 mm/filemap.c                                  |  6 +--
 mm/migrate.c                                  |  2 +-
 mm/vmscan.c                                   |  2 +-
 51 files changed, 309 insertions(+), 312 deletions(-)

-- 
2.34.1

