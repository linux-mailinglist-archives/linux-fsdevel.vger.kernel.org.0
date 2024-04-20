Return-Path: <linux-fsdevel+bounces-17324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97F8AB8DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 04:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2A51F21599
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Apr 2024 02:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E396FD9;
	Sat, 20 Apr 2024 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CSFQb9dk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F3D524A
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Apr 2024 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713581447; cv=none; b=RhqZmcFugMtSgfPR72V8YaPEMmYfYOWziiyE1q+/i25rfiD7Qkr2p9GZgu2zTKRWGG6D4wtjm3s6SbqXuL8ameRmaVj89klqALsSzMMM7dQUUW+Z2cgRhp9dspCcampMzwGdI0aU1r47W5zNQigPxBx2A4EpElijbDr8uxw2caE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713581447; c=relaxed/simple;
	bh=YpJ3mZy6TPAy0hoaqE7CMg5t2A7eRdqjOp+9+mYz0tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qtf4M9PovDNqOE75NYFg9RLSOEXAFM4MuasZlX3XDUvS5O/5JW0vFTXl3rd34ti61HtClku2Agd4iXcowNAeuEywa+P6awC9t37EELDNFPEmt4W6JNe4J+oaPRMVX1f2pmCU6FYR5MHyeyvccYJq1gy/HOeun7K00S2xGYD6vdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CSFQb9dk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0/iJQC2gSE+9kcnMHymBAExdB8KrkSaHPKjiArToVU4=; b=CSFQb9dkDlQHPCusHYq5jDYbxl
	1rWnYh7Pk34LZ3DaXehWY9etxa7iMB5mUSwOPSSNjW+kKQkDBwlaYFvm3uJAhlK7gqHEWYHnxA3EU
	VgbchiXfJ5iU0rnxk5nGqP3+QrvN6ChFpyQPYEAyt57uDcGBMy9SBWqTC5IQJIJ0p7KuCaFl5XzG5
	JsIdQTnZL5LJFfbP/V5lKfJDjL8IZUs+RDaGJbL4+yI0LIiD2HfE0I5+r1T6d0a97+i+6jinJoBB/
	nDgsdDeTzVNRmksD4TCTPH7+fvgjyD30gPaZxqWy6eZDOtbmnVbdvlXV3QyRUqBzAl84Acb7MJMOu
	TkDunwmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ry0oJ-000000095dB-1ad7;
	Sat, 20 Apr 2024 02:50:39 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/30] Remove PG_error flag
Date: Sat, 20 Apr 2024 03:49:55 +0100
Message-ID: <20240420025029.2166544-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


We've been steadily reducing the number of places which rely on
PG_error.  There are only two left, so the first five patches remove
those dependencies.

Every patch after the jfs patch is independent, and can be taken by the
respective maintainer immediately.  They might depend on patches I sent
in the last week or two (eg jfs, ntfs3).

Obviously I've done no testing beyond compilation.  All patches can
be found on linux-fsdevel.  I've bcc'd this cover letter to all the
maintainers, and cc'd each patch to whoever's listed in the MAINTAINERS
file.

Matthew Wilcox (Oracle) (30):
  btrfs: Use a folio in wait_dev_supers()
  btrfs: Use a folio in write_dev_supers()
  btrfs: Use the folio iterator in btrfs_end_super_write()
  btrfs: Remove use of the folio error flag
  jfs: Remove use of folio error flag
  bcachefs: Remove calls to folio_set_error
  befs: Convert befs_symlink_read_folio() to use folio_end_read()
  coda: Convert coda_symlink_filler() to use folio_end_read()
  ext2: Remove call to folio_set_error()
  ext4: Remove calls to to set/clear the folio error flag
  fuse: Convert fuse_readpages_end() to use folio_end_read()
  hostfs: Convert hostfs_read_folio() to use a folio
  isofs: Remove calls to set/clear the error flag
  jffs2: Remove calls to set/clear the folio error flag
  nfs: Remove calls to folio_set_error
  nilfs2: Remove calls to folio_set_error() and folio_clear_error()
  ntfs3: Remove calls to set/clear the error flag
  orangefs: Remove calls to set/clear the error flag
  reiserfs: Remove call to folio_set_error()
  romfs: Convert romfs_read_folio() to use a folio
  smb: Remove calls to set folio error flag
  squashfs: Convert squashfs_symlink_read_folio to use folio APIs
  squashfs: Remove calls to set the folio error flag
  ufs: Remove call to set the folio error flag
  vboxsf: Convert vboxsf_read_folio() to use a folio
  mm/memory-failure: Stop setting the folio error flag
  iomap: Remove calls to set and clear folio error flag
  buffer: Remove calls to set and clear the folio error flag
  fs: Remove calls to set and clear the folio error flag
  mm: Remove PG_error

 Documentation/filesystems/vfs.rst      |  3 +-
 fs/bcachefs/fs-io-buffered.c           | 12 +---
 fs/befs/linuxvfs.c                     | 10 ++-
 fs/btrfs/disk-io.c                     | 84 +++++++++++---------------
 fs/btrfs/extent_io.c                   |  2 +-
 fs/btrfs/volumes.h                     |  5 ++
 fs/buffer.c                            |  7 +--
 fs/coda/symlink.c                      | 10 +--
 fs/ext2/dir.c                          |  1 -
 fs/ext4/move_extent.c                  |  4 +-
 fs/ext4/page-io.c                      |  3 -
 fs/ext4/readpage.c                     |  1 -
 fs/fuse/file.c                         | 10 +--
 fs/hostfs/hostfs_kern.c                | 23 ++-----
 fs/iomap/buffered-io.c                 |  8 ---
 fs/isofs/compress.c                    |  4 --
 fs/jffs2/file.c                        | 14 +----
 fs/jfs/jfs_metapage.c                  | 47 +++++++-------
 fs/mpage.c                             | 13 +---
 fs/nfs/read.c                          |  2 -
 fs/nfs/symlink.c                       | 12 +---
 fs/nfs/write.c                         |  1 -
 fs/nilfs2/dir.c                        |  1 -
 fs/nilfs2/segment.c                    |  8 +--
 fs/ntfs3/frecord.c                     |  4 --
 fs/orangefs/inode.c                    | 13 +---
 fs/orangefs/orangefs-bufmap.c          |  4 +-
 fs/proc/page.c                         |  1 -
 fs/reiserfs/inode.c                    |  1 -
 fs/romfs/super.c                       | 22 ++-----
 fs/smb/client/file.c                   |  2 -
 fs/squashfs/file.c                     |  6 +-
 fs/squashfs/file_direct.c              |  3 +-
 fs/squashfs/symlink.c                  | 35 +++++------
 fs/ufs/dir.c                           |  1 -
 fs/vboxsf/file.c                       | 18 ++----
 include/linux/page-flags.h             |  6 +-
 include/trace/events/mmflags.h         |  1 -
 include/uapi/linux/kernel-page-flags.h |  2 +-
 mm/filemap.c                           |  8 ---
 mm/memory-failure.c                    | 29 ---------
 mm/migrate.c                           |  2 -
 42 files changed, 129 insertions(+), 314 deletions(-)

-- 
2.43.0


