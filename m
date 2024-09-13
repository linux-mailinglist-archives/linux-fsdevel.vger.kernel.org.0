Return-Path: <linux-fsdevel+bounces-29333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C26E19782D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426A41F25BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5DB18C36;
	Fri, 13 Sep 2024 14:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2H8wtEw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE8611187;
	Fri, 13 Sep 2024 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726238587; cv=none; b=iT/E1BIRHoi0fZHY0+B3F7I4kFDTAJfi0JCaRt3IM5kt5KkkviPhlcq9wna5Sxo9UsPHWY9vc8MbWBjOue9WRWXNAC0bJ993Gijc7jetWLF7CBcZiDTqwW/3UBcCRosIunjFCQWtFWzn/hJXrpigW1xU3CyNCZgyvNrxhUgMI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726238587; c=relaxed/simple;
	bh=RuDnm1HLhwgpxLm3DZPgYwmubG9wOGUTl4+SoQ89sEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TC5XxrbSrJCXAiffxBi6dZj6+BC70WVlkQnHn9Cop1ytk4QHkQ3Hr/6oWzS/24KMt8AS/nFjXHp9E/49oxiGHlFzO1G2oJTo9HQ4qP39iFziJemVSBuHwQvwnQTyTwr+bIaxbbwqZ0q0VAdzRx7yTMSNxHbo/7Rwtde/3roW+3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2H8wtEw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDBAC4CEC0;
	Fri, 13 Sep 2024 14:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238587;
	bh=RuDnm1HLhwgpxLm3DZPgYwmubG9wOGUTl4+SoQ89sEM=;
	h=From:To:Cc:Subject:Date:From;
	b=R2H8wtEwHp1AA02QDvoFv3ge5IwORq0F7OZURl8WHzk/Jj1xYSXeANCwtY0A8vl7S
	 rxEBggN2vlNrf1Vy1ffVDyX1pZdFmu/Cb90aVKm0hztEmuRZvWBS8tb08GgbCRoiYn
	 +UPUM6g8z6n+5OT2h/aIwbsQAc66nQzYUg2XU8+mElLE9GAdXR2mA1i9gFw1hB3HS9
	 UHhJRN7jL8uhuW7pYJOW+I7oB7Uy3T2raxIrsQO31WhPpT65Iho+XMz+Rjt0qAHZQW
	 c6kF1NA6i2KupnBJbNgaNqu5r/Uk1Mv3fAvLJD7a0vug964BY2vXMD6A+k5RtzF0mS
	 iFa4ZfpUB0KWQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs folio
Date: Fri, 13 Sep 2024 16:42:31 +0200
Message-ID: <20240913-vfs-folio-b8a42a052abc@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10601; i=brauner@kernel.org; h=from:subject:message-id; bh=RuDnm1HLhwgpxLm3DZPgYwmubG9wOGUTl4+SoQ89sEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ98c/x9+Yxu39yv2npTNFz7rtdjhqfenhITOnl+97yj otawqrLO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyJJaRYYpakgL/FO1N216U TIq75nJ5v+fLKOcLnlfsVFb6HjOtEGBk2Pgs6qs93ywV+a2KUq6fnP8lmzXyrGX4xaZ94Gdt5Fp 2bgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains work to port write_begin and write_end to rely on folios
for various filesystems.

This converts ocfs2, vboxfs, orangefs, jffs2, hostfs, fuse, f2fs,
ecryptfs, ntfs3, nilfs2, reiserfs, minixfs, qnx6, sysv, ufs, and
squashfs.

After this series lands a bunch of the filesystems in this list do not
mention struct page anymore.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known merge conflicts.

Merge conflicts with other trees
================================

Most of the conflicts are mechanical conversion. The only nasty
conversion is f2fs. The provided conflict resolution by Stephen has been
acked by the f2fs maintainer.

(1) linux-next: manual merge of the vfs-brauner tree with the f2fs tree
    https://lore.kernel.org/all/20240905101845.0a47926a@canb.auug.org.au

(2) linux-next: manual merge of the vfs-brauner tree with the ext4 tree
    https://lore.kernel.org/r/20240904091532.4b0dee26@canb.auug.org.au

(3) linux-next: manual merge of the vfs-brauner tree with the mm tree
    https://lore.kernel.org/r/20240902112101.2728f045@canb.auug.org.au

(4) linux-next: manual merge of the vfs-brauner tree with the exfat tree
    https://lore.kernel.org/r/20240812081046.369bbba5@canb.auug.org.au

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.folio

for you to fetch changes up to 84e0e03b308816a48c67f6da2168fcea6d49eda8:

  Squashfs: Ensure all readahead pages have been used (2024-08-23 13:11:36 +0200)

Please consider pulling these changes from the signed vfs-6.12.folio tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.folio

----------------------------------------------------------------
Christian Brauner (3):
      Merge branch 'work.write.end'
      Merge patch series "Finish converting jffs2 to folios"
      Merge patch series "Squashfs: Update code to not use page->index"

Matthew Wilcox (Oracle) (56):
      ufs: Convert ufs_get_page() to use a folio
      ufs: Convert ufs_get_page() to ufs_get_folio()
      ufs: Convert ufs_check_page() to ufs_check_folio()
      ufs: Convert ufs_find_entry() to take a folio
      ufs: Convert ufs_set_link() and ufss_dotdot() to take a folio
      ufs: Convert ufs_delete_entry() to work on a folio
      ufs: Convert ufs_make_empty() to use a folio
      ufs: Convert ufs_prepare_chunk() to take a folio
      ufs; Convert ufs_commit_chunk() to take a folio
      ufs: Convert directory handling to kmap_local
      sysv: Convert dir_get_page() to dir_get_folio()
      sysv: Convert sysv_find_entry() to take a folio
      sysv: Convert sysv_set_link() and sysv_dotdot() to take a folio
      sysv: Convert sysv_delete_entry() to work on a folio
      sysv: Convert sysv_make_empty() to use a folio
      sysv: Convert sysv_prepare_chunk() to take a folio
      sysv: Convert dir_commit_chunk() to take a folio
      qnx6: Convert qnx6_get_page() to qnx6_get_folio()
      qnx6: Convert qnx6_find_entry() to qnx6_find_ino()
      qnx6: Convert qnx6_longname() to take a folio
      qnx6: Convert qnx6_checkroot() to use a folio
      qnx6: Convert qnx6_iget() to use a folio
      qnx6: Convert directory handling to use kmap_local
      minixfs: Convert dir_get_page() to dir_get_folio()
      minixfs: Convert minix_find_entry() to take a folio
      minixfs: Convert minix_set_link() and minix_dotdot() to take a folio
      minixfs: Convert minix_delete_entry() to work on a folio
      minixfs: Convert minix_make_empty() to use a folio
      minixfs: Convert minix_prepare_chunk() to take a folio
      minixfs: Convert dir_commit_chunk() to take a folio
      fs: Convert block_write_begin() to use a folio
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
      jffs2: Convert jffs2_do_readpage_nolock to take a folio
      jffs2: Use a folio in jffs2_garbage_collect_dnode()

Phillip Lougher (5):
      Squashfs: Update page_actor to not use page->index
      Squashfs: Update squashfs_readahead() to not use page->index
      Squashfs: Update squashfs_readpage_block() to not use page->index
      Squashfs: Rewrite and update squashfs_readahead_fragment() to not use page->index
      Squashfs: Ensure all readahead pages have been used

 Documentation/filesystems/locking.rst     |   6 +-
 Documentation/filesystems/vfs.rst         |  12 +-
 block/fops.c                              |  12 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  47 +++---
 fs/adfs/inode.c                           |   5 +-
 fs/affs/file.c                            |  22 ++-
 fs/bcachefs/fs-io-buffered.c              |   8 +-
 fs/bcachefs/fs-io-buffered.h              |   6 +-
 fs/bfs/file.c                             |   4 +-
 fs/buffer.c                               |  63 ++++----
 fs/ceph/addr.c                            |  13 +-
 fs/ecryptfs/mmap.c                        |  86 +++++------
 fs/exfat/file.c                           |   8 +-
 fs/exfat/inode.c                          |   9 +-
 fs/ext2/dir.c                             |   4 +-
 fs/ext2/inode.c                           |   8 +-
 fs/ext4/ext4.h                            |   4 +-
 fs/ext4/inline.c                          |  14 +-
 fs/ext4/inode.c                           |  37 +++--
 fs/ext4/verity.c                          |   8 +-
 fs/f2fs/data.c                            |  87 +++++------
 fs/f2fs/super.c                           |   8 +-
 fs/f2fs/verity.c                          |   8 +-
 fs/fat/inode.c                            |   9 +-
 fs/fuse/file.c                            |  47 +++---
 fs/hfs/extent.c                           |   6 +-
 fs/hfs/hfs_fs.h                           |   2 +-
 fs/hfs/inode.c                            |   5 +-
 fs/hfsplus/extents.c                      |   6 +-
 fs/hfsplus/hfsplus_fs.h                   |   2 +-
 fs/hfsplus/inode.c                        |   5 +-
 fs/hostfs/hostfs_kern.c                   |  23 +--
 fs/hpfs/file.c                            |   9 +-
 fs/hugetlbfs/inode.c                      |   4 +-
 fs/iomap/buffered-io.c                    |   2 +-
 fs/jffs2/file.c                           |  88 ++++++------
 fs/jffs2/gc.c                             |  25 ++--
 fs/jfs/inode.c                            |   8 +-
 fs/libfs.c                                |  13 +-
 fs/minix/dir.c                            | 134 +++++++++--------
 fs/minix/inode.c                          |   8 +-
 fs/minix/minix.h                          |  40 +++---
 fs/minix/namei.c                          |  32 ++---
 fs/namei.c                                |  10 +-
 fs/nfs/file.c                             |   7 +-
 fs/nilfs2/dir.c                           |   4 +-
 fs/nilfs2/inode.c                         |  10 +-
 fs/nilfs2/recovery.c                      |  16 +--
 fs/ntfs3/file.c                           |   9 +-
 fs/ntfs3/inode.c                          |  51 +------
 fs/ntfs3/ntfs_fs.h                        |   5 +-
 fs/ocfs2/aops.c                           |  12 +-
 fs/ocfs2/aops.h                           |   2 +-
 fs/ocfs2/file.c                           |  17 +--
 fs/ocfs2/mmap.c                           |   6 +-
 fs/omfs/file.c                            |   4 +-
 fs/orangefs/inode.c                       |  39 +++--
 fs/qnx6/dir.c                             |  88 ++++++------
 fs/qnx6/inode.c                           |  25 ++--
 fs/qnx6/namei.c                           |   4 +-
 fs/qnx6/qnx6.h                            |   9 +-
 fs/reiserfs/inode.c                       |  57 ++++----
 fs/squashfs/file.c                        |  86 +++++++----
 fs/squashfs/file_direct.c                 |  19 +--
 fs/squashfs/page_actor.c                  |  11 +-
 fs/squashfs/page_actor.h                  |   6 +-
 fs/sysv/dir.c                             | 158 ++++++++++----------
 fs/sysv/itree.c                           |   8 +-
 fs/sysv/namei.c                           |  32 ++---
 fs/sysv/sysv.h                            |  20 +--
 fs/ubifs/file.c                           |  13 +-
 fs/udf/file.c                             |   2 +-
 fs/udf/inode.c                            |  12 +-
 fs/ufs/dir.c                              | 231 ++++++++++++++----------------
 fs/ufs/inode.c                            |  12 +-
 fs/ufs/namei.c                            |  39 +++--
 fs/ufs/ufs.h                              |  20 +--
 fs/ufs/util.h                             |   6 +-
 fs/vboxsf/file.c                          |  24 ++--
 include/linux/buffer_head.h               |  14 +-
 include/linux/fs.h                        |   6 +-
 mm/filemap.c                              |   6 +-
 mm/shmem.c                                |  11 +-
 83 files changed, 994 insertions(+), 1064 deletions(-)

