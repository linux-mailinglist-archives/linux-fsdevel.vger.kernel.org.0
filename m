Return-Path: <linux-fsdevel+bounces-23850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA20933FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 319C9B246EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB75182A6A;
	Wed, 17 Jul 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m+3VEIpn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCB217F393
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721231245; cv=none; b=XOcEWDpxMOO4OHaZear9+N17FXJOwdqgEaFql8TkxS6Yua3IzVgCac2xNvrLpVe4EkpXMdOF1aDWblnx/bq/DU0CphlobI6R8orR3pHCOdmsnbN0woCsdDK7nCYVo6d0ArGr18Jg07FDm8puhObjq5foopK7br0XKhcEpDYFFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721231245; c=relaxed/simple;
	bh=mxS6q3nFQfGpvHpzBvJzQZPAAaGvW7jut6fLh45RE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QswwbHOkd4mo5m7ZM8ZpLfhpAKJQ5u61AnOHc2RuKCMpxpZMKF1p9ZW0C0cHlONrEhOKTdILnMDVjFxzvskLmIN/mfJLHBC3ZTTp1KbEyLnYEo1RxPYApzbagX1ihcQgaioOdJzaE9zWLRndlELDaJM/Hg74YkQ3uYnJ3pOyen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m+3VEIpn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Bpldg8UDtYHNa8J0prcKSZ8wKCRjZqF3V/Lai06lO20=; b=m+3VEIpn+OU3Zcwy6K47AZF1zv
	2y+3miy8RCBZVoY00C5pkYM17n4TCSHrdvZG0ESt2Okc5ZgMMghgQOIX3iLjKoc0bjFRhk9133uwJ
	Vo0ykDetmy1fkoSCCrvgVL2Dag+2gxPRUryllHjvkiThoAUg69Mcv5VmAZJblABhqxUBeZu2u/q5O
	PHVqhuO0EaYzqI5rIau5ezKP0PNUkw4d/f0Hqwx62ZeUzk82GWDnxFjqfJVEKv58zUeNoNJhghhaN
	T04euYHhVkcWmGgJyDCm7Gsbzin4ZizxiCmbgFfBPsqBxCzjyp1wrR3E+AtQWGuBO6nXscsKBTUBM
	W5n6ZiJA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU6sB-00000000ztx-3915;
	Wed, 17 Jul 2024 15:47:19 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 00/23] Convert write_begin / write_end to take a folio
Date: Wed, 17 Jul 2024 16:46:50 +0100
Message-ID: <20240717154716.237943-1-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You can find the full branch at
http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/write-end
aka
git://git.infradead.org/users/willy/pagecache.git write-end

On top of the ufs, minix, sysv and qnx6 directory handling patches, this
patch series converts us to using folios for write_begin and write_end.
That's the last mention of 'struct page' in several filesystems.

I'd like to get some version of these patches into the 6.12 merge
window.

Matthew Wilcox (Oracle) (23):
  reiserfs: Convert grab_tail_page() to use a folio
  reiserfs: Convert reiserfs_write_begin() to use a folio
  block: Use a folio in blkdev_write_end()
  buffer: Use a folio in generic_write_end()
  nilfs2: Use a folio in nilfs_recover_dsync_blocks()
  ntfs3: Remove reset_log_file()
  buffer: Convert block_write_end() to take a folio
  ecryptfs: Convert ecryptfs_write_end() to use a folio
  ecryptfs: Use a folio in ecryptfs_write_begin()
  f2fs: Convert f2fs_write_end() to use a folio
  f2fs: Convert f2fs_write_begin() to use a folio
  fuse: Convert fuse_write_end() to use a folio
  fuse: Convert fuse_write_begin() to use a folio
  hostfs: Convert hostfs_write_end() to use a folio
  jffs2: Convert jffs2_write_end() to use a folio
  jffs2: Convert jffs2_write_begin() to use a folio
  orangefs: Convert orangefs_write_end() to use a folio
  orangefs: Convert orangefs_write_begin() to use a folio
  vboxsf: Use a folio in vboxsf_write_end()
  fs: Convert aops->write_end to take a folio
  fs: Convert aops->write_begin to take a folio
  ocfs2: Convert ocfs2_write_zero_page to use a folio
  buffer: Convert __block_write_begin() to take a folio

 Documentation/filesystems/locking.rst     |  6 +-
 Documentation/filesystems/vfs.rst         | 12 ++--
 block/fops.c                              | 12 ++--
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 47 ++++++------
 fs/adfs/inode.c                           |  5 +-
 fs/affs/file.c                            | 22 +++---
 fs/bcachefs/fs-io-buffered.c              |  8 +--
 fs/bcachefs/fs-io-buffered.h              |  6 +-
 fs/bfs/file.c                             |  4 +-
 fs/buffer.c                               | 46 ++++++------
 fs/ceph/addr.c                            | 13 ++--
 fs/ecryptfs/mmap.c                        | 86 +++++++++++-----------
 fs/exfat/file.c                           |  8 +--
 fs/exfat/inode.c                          |  9 ++-
 fs/ext2/dir.c                             |  4 +-
 fs/ext2/inode.c                           |  8 +--
 fs/ext4/ext4.h                            |  4 +-
 fs/ext4/inline.c                          | 14 ++--
 fs/ext4/inode.c                           | 37 +++++-----
 fs/ext4/verity.c                          |  8 +--
 fs/f2fs/data.c                            | 87 ++++++++++++-----------
 fs/f2fs/super.c                           |  8 +--
 fs/f2fs/verity.c                          |  8 +--
 fs/fat/inode.c                            |  9 ++-
 fs/fuse/file.c                            | 47 ++++++------
 fs/hfs/extent.c                           |  6 +-
 fs/hfs/hfs_fs.h                           |  2 +-
 fs/hfs/inode.c                            |  5 +-
 fs/hfsplus/extents.c                      |  6 +-
 fs/hfsplus/hfsplus_fs.h                   |  2 +-
 fs/hfsplus/inode.c                        |  5 +-
 fs/hostfs/hostfs_kern.c                   | 23 +++---
 fs/hpfs/file.c                            |  9 ++-
 fs/hugetlbfs/inode.c                      |  4 +-
 fs/iomap/buffered-io.c                    |  2 +-
 fs/jffs2/file.c                           | 66 +++++++++--------
 fs/jfs/inode.c                            |  8 +--
 fs/libfs.c                                | 13 ++--
 fs/minix/dir.c                            |  2 +-
 fs/minix/inode.c                          |  6 +-
 fs/namei.c                                | 10 +--
 fs/nfs/file.c                             |  7 +-
 fs/nilfs2/dir.c                           |  4 +-
 fs/nilfs2/inode.c                         | 10 +--
 fs/nilfs2/recovery.c                      | 16 ++---
 fs/ntfs3/file.c                           |  9 ++-
 fs/ntfs3/inode.c                          | 51 ++-----------
 fs/ntfs3/ntfs_fs.h                        |  5 +-
 fs/ocfs2/aops.c                           | 12 ++--
 fs/ocfs2/aops.h                           |  2 +-
 fs/ocfs2/file.c                           | 17 ++---
 fs/ocfs2/mmap.c                           |  6 +-
 fs/omfs/file.c                            |  4 +-
 fs/orangefs/inode.c                       | 39 +++++-----
 fs/reiserfs/inode.c                       | 57 ++++++++-------
 fs/sysv/dir.c                             |  2 +-
 fs/sysv/itree.c                           |  6 +-
 fs/ubifs/file.c                           | 13 ++--
 fs/udf/file.c                             |  2 +-
 fs/udf/inode.c                            | 12 ++--
 fs/ufs/dir.c                              |  2 +-
 fs/ufs/inode.c                            | 10 +--
 fs/vboxsf/file.c                          | 24 +++----
 include/linux/buffer_head.h               | 14 ++--
 include/linux/fs.h                        |  6 +-
 mm/filemap.c                              |  6 +-
 mm/shmem.c                                | 10 ++-
 67 files changed, 482 insertions(+), 551 deletions(-)

-- 
2.43.0


