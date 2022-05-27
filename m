Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80765364FD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 May 2022 17:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353689AbiE0PvO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 May 2022 11:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiE0Pu6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 May 2022 11:50:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23F134E3D
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 May 2022 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2R6wer/aF9PdXluIfdK0itvxmVwjGwl4/WVXZUHl/80=; b=Sw4PQNR60RHbCcuMP1gygyRIL+
        owHZgBCTVKUZcCf/2qE1cn11l4GrRpnaMBiJ4SLvAeOojEdg7Oi1wyBtUt5FsIyv49b23PTR4mFNQ
        +t33JOLJEXW9ajyYkAqtDacjX9RCrprv0/plEWQyhnHA1KvvFCzaEgC8F9P1eSScy6meSXpjj1DxJ
        TzvLme/FUSMUsyV5Is9e2p0AB0srVhtvvVUwyFS6NEB53oskyMrVTHDJt/vozgZnZN9q2ZAFBR+Zs
        PXlpR4q0kPiO+tqHFuEAbLBokp5fJS8Zcxcx4Ys4FX4QHQ54iJDg6mSsuCD5dhSMRzztJjVEZajvu
        HrzT0Dyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nucEa-002CWK-6Q; Fri, 27 May 2022 15:50:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org
Subject: [PATCH 00/24] Begin removing PageError
Date:   Fri, 27 May 2022 16:50:12 +0100
Message-Id: <20220527155036.524743-1-willy@infradead.org>
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

The approach I'm taking is to remove the checks for PageError (and
folio_test_error).  Once nobody is checking the error flag, we can safely
remove all places that set/clear it.

After this series, there are some places which still use it.  Lots of
the converted places are trivial -- they should have been checking the
uptodate flag.  The trickiest are the ones which have multiple steps
and signal "hey, something went wrong with one step in the read of this
page/folio" by setting the error flag.

I'm thinking about (ab)using PageChecked == PG_owner_priv_1 for this
purpose.  It'd be nice to be able to use page->private for this, but
that's not always available.  I know some filesystems already ascribe
a meaning to PG_owner_priv_1, but those can be distinguished by whether
the uptodate flag is set.

Thoughts?  Most of these look like good cleanups that we want to have
anyway.

Matthew Wilcox (Oracle) (24):
  block: Remove check of PageError
  afs: Remove check of PageError
  freevxfs: Remove check of PageError
  gfs: Check PageUptodate instead of PageError
  hfs: Remove check for PageError
  hfsplus: Remove check for PageError
  ntfs: Remove check for PageError
  ext2: Remove check for PageError
  nilfs2: Remove check for PageError
  ntfs: Remove check for PageError
  ntfs3: Remove check for PageError
  reiserfs: Remove check for PageError
  ufs: Remove checks for PageError
  remap_range: Remove check of uptodate flag
  jfs: Remove check for PageUptodate
  iomap: Remove test for folio error
  orangefs: Remove test for folio error
  buffer: Remove check for PageError
  nfs: Leave pages in the pagecache if readpage failed
  btrfs: Use a folio in wait_dev_supers()
  buffer: Don't test folio error in block_read_full_folio()
  squashfs: Return the actual error from squashfs_read_folio()
  hostfs: Handle page write errors correctly
  ocfs2: Use filemap_write_and_wait_range() in
    ocfs2_cow_sync_writeback()

 block/partitions/core.c |  4 ----
 fs/afs/mntpt.c          |  6 ------
 fs/btrfs/disk-io.c      | 19 ++++++++-----------
 fs/buffer.c             | 13 ++++++++-----
 fs/ext2/dir.c           |  3 +--
 fs/freevxfs/vxfs_subr.c |  6 ------
 fs/gfs2/lops.c          |  2 +-
 fs/hfs/bnode.c          |  4 ----
 fs/hfsplus/bnode.c      |  4 ----
 fs/hostfs/hostfs_kern.c |  6 +++---
 fs/iomap/buffered-io.c  |  3 ---
 fs/jfs/jfs_metapage.c   |  2 +-
 fs/nfs/read.c           |  4 ----
 fs/nilfs2/dir.c         |  2 +-
 fs/ntfs/aops.h          |  7 +------
 fs/ntfs/file.c          |  5 -----
 fs/ntfs3/ntfs_fs.h      |  7 +------
 fs/ocfs2/refcounttree.c | 42 ++++++-----------------------------------
 fs/orangefs/inode.c     |  4 +---
 fs/reiserfs/xattr.c     |  9 +--------
 fs/remap_range.c        | 11 +----------
 fs/squashfs/file.c      | 15 ++++++++-------
 fs/ufs/dir.c            |  2 +-
 fs/ufs/util.c           | 11 -----------
 24 files changed, 43 insertions(+), 148 deletions(-)

-- 
2.34.1

