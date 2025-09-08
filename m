Return-Path: <linux-fsdevel+bounces-60491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA6B488F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3730C16C065
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BF41DDC2A;
	Mon,  8 Sep 2025 09:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuTNOxnC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9AE2EC54E;
	Mon,  8 Sep 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324772; cv=none; b=fKQNftEPdBEhdLdG9Ud02PtgeCoFF7+CxquuAlJbAkfVzDp7FTECBwj6yKMwza/zob5dxeNBYka6TyEgscEPfFV0aoUzrjF5JY59X4eWmMegodQNoSgPSfmcl1pnOtflajirgBFASNxU9Nb98+fu5SXw3uiJpR395HJGk90J0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324772; c=relaxed/simple;
	bh=VLrpnyvJPUnUuHxgJ/fJtXwAK+nZcoeURy5sVJG4cls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwgasrPtUzS42Fn6EAasXaWSXnpIQDCPeOHUx8DMCtJYCb812WcGA3Un+tL0Ar9+ck/vQt3HCoIo07elKSZPr9m+rr804rhaDP3dW/Se5G3VxbbM9QR8zrwsmLd0iAGVBsmK+jgphs6ggR6AWp5r9U+hT16RULDVo67wOCAMnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuTNOxnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6D7C4CEF9;
	Mon,  8 Sep 2025 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757324771;
	bh=VLrpnyvJPUnUuHxgJ/fJtXwAK+nZcoeURy5sVJG4cls=;
	h=From:To:Cc:Subject:Date:From;
	b=PuTNOxnCyow54A7XEWGStCET9VmAWuzQG9lw9+nyWBVlWfAHpywgHq93JNwWjDIBJ
	 LR5YC8MKM4Y+jQjnxXdjr+7p5geXgtauUPpGPeKoZDJMfph1C7RK+Wp2GATQJk/vqJ
	 /fC+MHK0duutgIllR0UQc9hBnZpABOMwPnpbjcjypn+xuRolidHeLxzedsW3sMq5rv
	 Iec4QlJlNux1hen/QRl6H3k25tlLQ9oWetOCx9g+wjJg26sGvHRhe1bXuExYQ8bzyX
	 g931wKB9LWna368Zm0ghXJhjd+xUlRuBzgvpvOSj/Anaw8QSS9Eto+j/X+rE1hfxU/
	 n1unGsSSXe5NA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon,  8 Sep 2025 11:45:58 +0200
Message-ID: <20250908-vfs-fixes-0096f8ec89ff@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5589; i=brauner@kernel.org; h=from:subject:message-id; bh=VLrpnyvJPUnUuHxgJ/fJtXwAK+nZcoeURy5sVJG4cls=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTsW3rL8myXrZH3muBlwQJK168+Ea9RbdW6kTXPZcEcx eksDxRvd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAFyEnZFh0n/bKTfV1UNt+E/G xuoWPSgtlWOc9bjgkrjg/ahFmTKNDP8r4/Zt+BzEIMf3I2z2Iu6FInJ3rvWqfd388avx/GNrpof yAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

the fixes tree was filled before Link: tags were ousted. Only one of
the patches in the series carries a Link: tag and that one actually has
a useful discussion attached to it.

Please also be aware that patches in the various branches for the v6.18
merge window will have Link: tags applied and I don't want to rebase
them all just to drop them. I'll mention that during the merge window
once more as a reminder.

Going forward no tags are applied to individual commits. But I will
continue adding tags to the cover letter in the merge message for patch
series as I often modify the merge message so they point back to the
original cover letter.

/* Summary */

This contains a few fixes for this cycle:

# fuse

- Prevent opening of non-regular backing files.
  Fuse doesn't support non-regular files anyway.

- Check whether copy_file_range() returns a larger size than requested.

- Prevent overflow in copy_file_range() as fuse currently only supports
  32-bit sized copies.

- Cache the blocksize value if the server returned a new value as
  inode->i_blkbits isn't modified directly anymore.

- Fix i_blkbits handling for iomap partial writes.
  By default i_blkbits is set to PAGE_SIZE which causes iomap to mark
  the whole folio as uptodate even on a partial write. But fuseblk
  filesystems support choosing a blocksize smaller than PAGE_SIZE
  risking data corruption. Simply enforce PAGE_SIZE as blocksize for
  fuseblk's internal inode for now.

- Prevent out-of-bounds acces in fuse_dev_write() when the number of
  bytes to be retrieved is truncated to the fc->max_pages limit.

# virtiofs

- Fix page faults for DAX page addresses.

# Misc

- Tighten file handle decoding from userns.
  Check that the decoded dentry itself has a valid idmapping in the user
  namespace.

- Fix mount-notify selftests.

- Fix some indentation errors.

- Add an FMODE_ flag to indicate IOCB_HAS_METADATA availability.
  This will be moved to an FOP_* flag with a bit more rework needed for
  that to happen not suitable for a fix.

- Don't silently ignore metadata for sync read/write.

- Don't pointlessly log warning when reading coredump sysctls.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc6.fixes

for you to fetch changes up to e1bf212d0604d2cbb5514e47ccec252b656071fb:

  fuse: virtio_fs: fix page fault for DAX page address (2025-09-05 15:56:30 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc6.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc6.fixes

----------------------------------------------------------------
Amir Goldstein (2):
      fuse: do not allow mapping a non-regular backing file
      fhandle: use more consistent rules for decoding file handle from userns

Christian Brauner (3):
      Merge patch series "io_uring / dio metadata fixes"
      coredump: don't pointlessly check and spew warnings
      Merge tag 'fuse-fixes-6.17-rc5' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse into vfs.fixes

Christoph Hellwig (2):
      fs: add a FMODE_ flag to indicate IOCB_HAS_METADATA availability
      block: don't silently ignore metadata for sync read/write

Edward Adam Davis (1):
      fuse: Block access to folio overlimit

Guopeng Zhang (1):
      fs: fix indentation style

Haiyue Wang (1):
      fuse: virtio_fs: fix page fault for DAX page address

Joanne Koong (2):
      fuse: reflect cached blocksize if blocksize was changed
      fuse: fix fuseblk i_blkbits for iomap partial writes

Miklos Szeredi (2):
      fuse: check if copy_file_range() returns larger than requested size
      fuse: prevent overflow in copy_file_range return value

Xing Guo (1):
      selftests/fs/mount-notify: Fix compilation failure.

 block/fops.c                                           | 13 ++++++++-----
 fs/coredump.c                                          |  4 ++++
 fs/exec.c                                              |  2 +-
 fs/fhandle.c                                           |  8 ++++++++
 fs/fuse/dev.c                                          |  2 +-
 fs/fuse/dir.c                                          |  3 ++-
 fs/fuse/file.c                                         |  5 ++++-
 fs/fuse/fuse_i.h                                       | 14 ++++++++++++++
 fs/fuse/inode.c                                        | 16 ++++++++++++++++
 fs/fuse/passthrough.c                                  |  5 +++++
 fs/fuse/virtio_fs.c                                    |  2 +-
 fs/namespace.c                                         |  2 +-
 include/linux/fs.h                                     |  3 ++-
 io_uring/rw.c                                          |  3 +++
 .../filesystems/mount-notify/mount-notify_test.c       | 17 ++++++++---------
 .../filesystems/mount-notify/mount-notify_test_ns.c    | 18 ++++++++----------
 16 files changed, 86 insertions(+), 31 deletions(-)

