Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA9953F113
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jun 2022 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbiFFUv1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiFFUtq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:49:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2FEF5B6;
        Mon,  6 Jun 2022 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=52TXjMDH2lUY3R09liZNjO+IjMsaCFATm2t/b+KQCF8=; b=SZdEFZWXMJtFPOJuECFsGH4n90
        q7ier+E1yPXVQU4Nd1lYIGA05aBdagpFc4iTt8PjgeKc8E++hHnQYInhlsw3wbFpf5nxp3H2fcfme
        0Xx+q8n2owHljzIVuJKc0MDo+cUizE5viLTjZLfP5xwl/nmCSSlMfDWIQiYSrFSnV+41z2epAxAgz
        c5hI+6eJnPB8FSW9f2DBRPcvqpAvUVkxshVm7oCqFdrliaskJ+h+S7JjdTqvzkHPpD7vXrhjHIlQV
        QHRESAfyNVHF1VHQMM7Gir9jrNAHNPAhLTN9Pq43f+cwmm1aYDR8JwDm6N7iYlMQcSUd+o2cWsMba
        zygq/t9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyJWw-00B19H-IZ; Mon, 06 Jun 2022 20:40:54 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-aio@kvack.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 00/20] Convert aops->migratepage to aops->migrate_folio
Date:   Mon,  6 Jun 2022 21:40:30 +0100
Message-Id: <20220606204050.2625949-1-willy@infradead.org>
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

I plan to submit these patches through my pagecache tree in the upcoming
merge window.  I'm pretty happy that most filesystems are now using
common code for ->migrate_folio; it's not something that most filesystem
people want to care about.  I'm running xfstests using xfs against it now,
but it's little more than compile tested for other filesystems.

Matthew Wilcox (Oracle) (20):
  fs: Add aops->migrate_folio
  mm/migrate: Convert fallback_migrate_page() to
    fallback_migrate_folio()
  mm/migrate: Convert writeout() to take a folio
  mm/migrate: Convert buffer_migrate_page() to buffer_migrate_folio()
  mm/migrate: Convert expected_page_refs() to folio_expected_refs()
  btrfs: Convert btree_migratepage to migrate_folio
  nfs: Convert to migrate_folio
  mm/migrate: Convert migrate_page() to migrate_folio()
  mm/migrate: Add filemap_migrate_folio()
  btrfs: Convert btrfs_migratepage to migrate_folio
  ubifs: Convert to filemap_migrate_folio()
  f2fs: Convert to filemap_migrate_folio()
  aio: Convert to migrate_folio
  hugetlb: Convert to migrate_folio
  balloon: Convert to migrate_folio
  secretmem: Convert to migrate_folio
  z3fold: Convert to migrate_folio
  zsmalloc: Convert to migrate_folio
  fs: Remove aops->migratepage()
  mm/folio-compat: Remove migration compatibility functions

 Documentation/filesystems/locking.rst       |   5 +-
 Documentation/filesystems/vfs.rst           |  13 +-
 Documentation/vm/page_migration.rst         |  33 +--
 block/fops.c                                |   2 +-
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |   4 +-
 fs/aio.c                                    |  36 ++--
 fs/btrfs/disk-io.c                          |  22 +-
 fs/btrfs/inode.c                            |  26 +--
 fs/ext2/inode.c                             |   4 +-
 fs/ext4/inode.c                             |   4 +-
 fs/f2fs/checkpoint.c                        |   4 +-
 fs/f2fs/data.c                              |  40 +---
 fs/f2fs/f2fs.h                              |   4 -
 fs/f2fs/node.c                              |   4 +-
 fs/gfs2/aops.c                              |   2 +-
 fs/hugetlbfs/inode.c                        |  19 +-
 fs/iomap/buffered-io.c                      |  25 ---
 fs/nfs/file.c                               |   4 +-
 fs/nfs/internal.h                           |   6 +-
 fs/nfs/write.c                              |  16 +-
 fs/ntfs/aops.c                              |   6 +-
 fs/ocfs2/aops.c                             |   2 +-
 fs/ubifs/file.c                             |  29 +--
 fs/xfs/xfs_aops.c                           |   2 +-
 fs/zonefs/super.c                           |   2 +-
 include/linux/buffer_head.h                 |  10 +
 include/linux/fs.h                          |  18 +-
 include/linux/iomap.h                       |   6 -
 include/linux/migrate.h                     |  22 +-
 include/linux/pagemap.h                     |   6 +
 mm/balloon_compaction.c                     |  15 +-
 mm/compaction.c                             |   5 +-
 mm/folio-compat.c                           |  22 --
 mm/ksm.c                                    |   2 +-
 mm/migrate.c                                | 217 ++++++++++++--------
 mm/migrate_device.c                         |   3 +-
 mm/secretmem.c                              |   6 +-
 mm/shmem.c                                  |   2 +-
 mm/swap_state.c                             |   2 +-
 mm/z3fold.c                                 |   8 +-
 mm/zsmalloc.c                               |   8 +-
 41 files changed, 287 insertions(+), 379 deletions(-)

-- 
2.35.1

