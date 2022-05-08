Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0651F194
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbiEHUhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 16:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiEHUgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 16:36:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F067A11146
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IeYZN3K/nsBQDQdrVJp1iXIKKccXdRFOgvyN5YJGMHE=; b=MS8o+khpy3wKd1UhtvxBSzvx55
        tV8dXvy5NGXCDAadZDKrLWTsUEtND94dYu4zIIiMKB1tNWLi7l77Ip/LkY8P07OlvD4Ozj5QuhkcI
        rt5gdpsdgMFLY0HFhPHIwZrIE8SLT/vC8OJHuCS2j6t9z73G38Dpl4PQRLKEsJ1w8RuEyKc1kvKun
        RBsyBeSZTsRww1ux5kR2UmGEjiStchOZZJUgGw1KZ5z92SWBFleSfn3SnSZFw9kIBH0ksczTcev7q
        9PZ6F5UEw/NSUKe/DwsX5prCyGpE3osx2jdUEFQshMRR8ve25ttmL83pM+AGXDkaT+GRIqcvZb9D5
        EcHMiwHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nnnaC-002o0i-Qg; Sun, 08 May 2022 20:32:48 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/26] Convert aops->releasepage to aops->release_folio
Date:   Sun,  8 May 2022 21:32:21 +0100
Message-Id: <20220508203247.668791-1-willy@infradead.org>
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

Convert all filesystems.  The last five patches are further cleanups
that are enabled by this change.

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

