Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B37A589C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 06:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbjISEvu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 00:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjISEvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 00:51:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAC811F;
        Mon, 18 Sep 2023 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=awyfojKMhU8AzVa7YcEsBxlpTOVclzCuTyUo6TQYiIY=; b=Cw5LiD0vn95PKN2IeCDFvMkRoz
        nIpR3aa2vwbEJhByXcLQUey3cSZoM0mbiK6C+/GUbOFLQ+E3zUMIvi2DG5x6byLlj0amRrNqfwcCn
        LtMopE0Vn0VS9LVDPKOgfrGBkn29dQ9iOGK93n8Ir7Tt5XPeJl2z3mVUSITyJQ6jfKGH/LDc1qOOC
        wDjdKBiaRCirlxe/g8scAyXXtJosfVIDgPKczCCQ5grKrjYrChyEcCzmVJhyAF33sTewGexLVVGwO
        NbHItyH31kAC+tgaegnX0uitTTong1uJkS11wM2b20JpvHaggRs1KVl1ADobtfqliNwoOibJInErH
        gpxaWVJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiSi2-00FFkF-10; Tue, 19 Sep 2023 04:51:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 00/26] Finish the create_empty_buffers() transition
Date:   Tue, 19 Sep 2023 05:51:09 +0100
Message-Id: <20230919045135.3635437-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pankaj recently added folio_create_empty_buffers() as the folio
equivalent to create_empty_buffers().  This patch set finishes
the conversion by first converting all remaining filesystems
to call folio_create_empty_buffers(), then renaming it back
to create_empty_buffers().  I took the opportunity to make a few
simplifications like making folio_create_empty_buffers() return the head
buffer and extracting get_nth_bh() from nilfs2.

A few of the patches in this series aren't directly related to
create_empty_buffers(), but I saw them while I was working on this and
thought they'd be easy enough to add to this series.  Compile-tested only,
other than ext4.

Matthew Wilcox (Oracle) (26):
  buffer: Make folio_create_empty_buffers() return a buffer_head
  mpage: Convert map_buffer_to_folio() to folio_create_empty_buffers()
  ext4: Convert to folio_create_empty_buffers
  buffer: Add get_nth_bh()
  gfs2: Convert inode unstuffing to use a folio
  gfs2: Convert gfs2_getbuf() to folios
  gfs2; Convert gfs2_getjdatabuf to use a folio
  gfs2: Convert gfs2_write_buf_to_page() to use a folio
  nilfs2: Convert nilfs_mdt_freeze_buffer to use a folio
  nilfs2: Convert nilfs_grab_buffer() to use a folio
  nilfs2: Convert nilfs_copy_page() to nilfs_copy_folio()
  nilfs2: Convert nilfs_mdt_forget_block() to use a folio
  nilfs2: Convert nilfs_mdt_get_frozen_buffer to use a folio
  nilfs2: Remove nilfs_page_get_nth_block
  nilfs2: Convert nilfs_lookup_dirty_data_buffers to use
    folio_create_empty_buffers
  ntfs: Convert ntfs_read_block() to use a folio
  ntfs: Convert ntfs_writepage to use a folio
  ntfs: Convert ntfs_prepare_pages_for_non_resident_write() to folios
  ntfs3: Convert ntfs_zero_range() to use a folio
  ocfs2: Convert ocfs2_map_page_blocks to use a folio
  reiserfs: Convert writepage to use a folio
  ufs: Add ufs_get_locked_folio and ufs_put_locked_folio
  ufs: Use ufs_get_locked_folio() in ufs_alloc_lastblock()
  ufs; Convert ufs_change_blocknr() to use folios
  ufs: Remove ufs_get_locked_page()
  buffer: Remove folio_create_empty_buffers()

 fs/buffer.c                 |  29 ++--
 fs/ext4/inode.c             |  14 +-
 fs/ext4/move_extent.c       |  11 +-
 fs/gfs2/aops.c              |   2 +-
 fs/gfs2/bmap.c              |  48 ++++---
 fs/gfs2/meta_io.c           |  61 ++++-----
 fs/gfs2/quota.c             |  37 +++---
 fs/mpage.c                  |   3 +-
 fs/nilfs2/mdt.c             |  66 +++++-----
 fs/nilfs2/page.c            |  76 +++++------
 fs/nilfs2/page.h            |  11 --
 fs/nilfs2/segment.c         |   7 +-
 fs/ntfs/aops.c              | 255 +++++++++++++++++-------------------
 fs/ntfs/file.c              |  89 ++++++-------
 fs/ntfs3/file.c             |  31 ++---
 fs/ocfs2/aops.c             |  19 +--
 fs/reiserfs/inode.c         |  80 +++++------
 fs/ufs/balloc.c             |  20 ++-
 fs/ufs/inode.c              |  25 ++--
 fs/ufs/util.c               |  34 +++--
 fs/ufs/util.h               |  10 +-
 include/linux/buffer_head.h |  28 +++-
 22 files changed, 458 insertions(+), 498 deletions(-)

-- 
2.40.1

