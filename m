Return-Path: <linux-fsdevel+bounces-494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7F37CB442
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 22:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA7DB217E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 20:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EBF381A6;
	Mon, 16 Oct 2023 20:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeeHRWZP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51B374C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 20:11:37 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F613A;
	Mon, 16 Oct 2023 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=ww/KyQmZLUBfrbCXL0JtfwVQmCdaEySGJqhTjl+W3Yo=; b=eeeHRWZP6iP9MVTlau71wh1/Ye
	hlycThR6DJpI5xME/aBZpsTFNev59ay9bJK87wFSeA/jaREIoxsm5TmSB5aLFhypZskVPhq4ZK5UZ
	Si/5VKLeA8v80BgmswicOKx5uUhehBheDVu6DXV0XV0Jr3qlhyyUJcihl/bO/xFX+ctpRIDgqomBZ
	QoUiabWvLs+fRull59qucgK0UmE1F1lDqFNomWYWr5GTuwXIEqxIZ6wAFj9OUZgzSG+OY7piO6nHZ
	b2uwk8N0YRur7vAl2YSviS8Hfwr+Pq0lfH/b5av3RhPPEkLcmOR+GFIAZB9X6/45o50IMX/G3gQ8V
	xwHgURaA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qsTvo-0085aK-FF; Mon, 16 Oct 2023 20:11:16 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nilfs@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	ocfs2-devel@lists.linux.dev,
	reiserfs-devel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 00/27] Finish the create_empty_buffers() transition
Date: Mon, 16 Oct 2023 21:10:47 +0100
Message-Id: <20231016201114.1928083-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

v2:
 - Added the patch to fix the return type from grow_dev_page()
 - Fixed typo in subject line noticed by Andreas
 - Fixed missed assignment to 'bh' spotted by Andreas
 - Exported folio_copy() spotted by Ryusuke
 - Added various Reviewed-by tags from Pankaj, Ryusuke & Andreas

Matthew Wilcox (Oracle) (27):
  buffer: Return bool from grow_dev_folio()
  buffer: Make folio_create_empty_buffers() return a buffer_head
  mpage: Convert map_buffer_to_folio() to folio_create_empty_buffers()
  ext4: Convert to folio_create_empty_buffers
  buffer: Add get_nth_bh()
  gfs2: Convert inode unstuffing to use a folio
  gfs2: Convert gfs2_getbuf() to folios
  gfs2: Convert gfs2_getjdatabuf to use a folio
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

 fs/buffer.c                 |  68 +++++-----
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
 mm/util.c                   |   1 +
 23 files changed, 481 insertions(+), 515 deletions(-)

-- 
2.40.1


