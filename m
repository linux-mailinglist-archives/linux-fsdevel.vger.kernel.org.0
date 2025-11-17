Return-Path: <linux-fsdevel+bounces-68748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF4C64FD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 82E9E34CA5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D929B783;
	Mon, 17 Nov 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AaN8wI2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1315855E;
	Mon, 17 Nov 2025 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394809; cv=none; b=pbhbNSZ6UrmniqFPaznT9OS8BS4QiPGSKk0w9ya2IlERtmjBOV0qcsB6VtylKGXupF5k01YlZ3QKDBMjWpqlWGTufDzKNcZ2I1QNVtJlgYbKRtq6Sff2CmPq5phh5WaNTOWeZAsdvOPB+RhWIeGAhUOfT1GPFLxG1koTt2XOXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394809; c=relaxed/simple;
	bh=NCf7E/7q2n+OhBTFdagfl5WbMcYuzVz0SW3TlNK78sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ovyr3Q0d3UOVkM+jlCDONw5jPGEIEO20obsmNj97uff2JRjI5pCSAvoP8i2qCpFE8BVOostKd00s5YuGFo7M7PcpdooN7S4QABf4sBZ1hiIoes0Mm3arlmA/OjAckyryBM9eKvG0Nhse+vAjrtzMMcTuSukD4AykmF41nH859cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AaN8wI2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E56C19421;
	Mon, 17 Nov 2025 15:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763394809;
	bh=NCf7E/7q2n+OhBTFdagfl5WbMcYuzVz0SW3TlNK78sk=;
	h=From:To:Cc:Subject:Date:From;
	b=AaN8wI2wlrl0F5ISHFFg6jPflcTvO1fhMgcqRrfvxHNxJIMcVtyRUzk+q/kEezd5D
	 b7nTroAgPAFV9jz5Qdiq9kZZlw1yliw65fN4tf0sUTutqFoUDVnwvgXVOL0d6mJUFa
	 hgEdrkmdZz2S30Fq9iaN+vmkNjDhbmDvoK5+v9wy/08v/T6n1Q00Uzzg6D+Q47b2ZM
	 Jb2dWmwCEhvi8SqVFaLIhcLryQWTOYkdyb2GcdvHCaAbx6leeSTd5o5BBjvtGUobqq
	 kERUG+gEDKii+e8XDnf4mPbz5DsDgOs1EwtvUjMKE/h3QKyyhV3+4t/tSpizg5hxLJ
	 PcQfYbkD+cG0Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 17 Nov 2025 16:53:18 +0100
Message-ID: <20251117-vfs-fixes-26f16ac8a672@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4655; i=brauner@kernel.org; h=from:subject:message-id; bh=NCf7E/7q2n+OhBTFdagfl5WbMcYuzVz0SW3TlNK78sk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKu7w7WRCedz8p7RFT5JRHbx9O239ZaE+4+STRjQGca xLPv7Tr6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI7hRGhsfel223rJd/eGC6 bhV3mtNijhPnrsi5L//azzs379SJjjhGhtcmH+2TmQ3uRDzJ9ixKMdV0qT0wVaHHdE9C4K6lVq+ 3MQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Fix unitialized variable in statmount_string().

- Fix hostfs mounting when passing host root during boot.

- Fix dynamic lookup to fail on cell lookup failure.

- Fix missing file type when reading bfs inodes from disk.

- Enforce checking of sb_min_blocksize() calls and update all callers
  accordingly.

- Restore write access before closing files opened by open_exec() in
  binfmt_misc.

- Always freeze efivarfs during suspend/hibernate cycles.

- Fix statmount()'s and listmount()'s grab_requested_mnt_ns() helper to
  actually allow mount namespace file descriptor in addition to mount
  namespace ids.

- Fix tmpfs remount when noswap is specified.

- Switch Landlock to iput_not_last() to remove false-positives from
  might_sleep() annotations in iput().

- Remove dead node_to_mnt_ns() code.

- Ensure that per-queue kobjects are successfully created.

/* Testing */

gcc (Debian 15.2.0-7) 15.2.0
Debian clang version 19.1.7 (10)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09:

  Merge tag 'f2fs-fix-6.18-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs (2025-10-16 10:58:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.18-rc7.fixes

for you to fetch changes up to e9d50b78fdfe675b038ddaec7a139dbe3082174c:

  Merge patch series "fs: add iput_not_last()" (2025-11-12 10:47:52 +0100)

Please consider pulling these changes from the signed vfs-6.18-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.18-rc7.fixes

----------------------------------------------------------------
Alok Tiwari (1):
      virtio-fs: fix incorrect check for fsvq->kobj

Andrei Vagin (1):
      fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

Andy Shevchenko (1):
      mnt: Remove dead code which might prevent from building

Christian Brauner (3):
      Merge patch series "sb_min_blocksize() fixes"
      power: always freeze efivarfs
      Merge patch series "fs: add iput_not_last()"

David Howells (1):
      afs: Fix dynamic lookup to fail on cell lookup failure

Hongbo Li (1):
      hostfs: Fix only passing host root in boot stage with new mount

Mateusz Guzik (2):
      fs: add iput_not_last()
      landlock: fix splats from iput() after it started calling might_sleep()

Mike Yuan (1):
      shmem: fix tmpfs reconfiguration (remount) when noswap is set

Tetsuo Handa (1):
      bfs: Reconstruct file type when loading from disk

Yongpeng Yang (5):
      vfat: fix missing sb_min_blocksize() return value checks
      exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
      isofs: check the return value of sb_min_blocksize() in isofs_fill_super
      xfs: check the return value of sb_min_blocksize() in xfs_fs_fill_super
      block: add __must_check attribute to sb_min_blocksize()

Zhen Ni (1):
      fs: Fix uninitialized 'offp' in statmount_string()

Zilin Guan (1):
      binfmt_misc: restore write access before closing files opened by open_exec()

 block/bdev.c               |  2 +-
 fs/afs/cell.c              | 78 +++++++++++++++++++++++++++++++++++++++-------
 fs/afs/dynroot.c           |  3 +-
 fs/afs/internal.h          | 12 ++++++-
 fs/afs/mntpt.c             |  3 +-
 fs/afs/proc.c              |  3 +-
 fs/afs/super.c             |  2 +-
 fs/afs/vl_alias.c          |  3 +-
 fs/bfs/inode.c             | 19 ++++++++++-
 fs/binfmt_misc.c           |  4 ++-
 fs/efivarfs/super.c        |  1 +
 fs/exfat/super.c           |  5 ++-
 fs/fat/inode.c             |  6 +++-
 fs/fuse/virtio_fs.c        |  2 +-
 fs/hostfs/hostfs_kern.c    | 29 ++++++++++-------
 fs/inode.c                 | 12 +++++++
 fs/isofs/inode.c           |  5 +++
 fs/namespace.c             | 46 +++++++++++----------------
 fs/super.c                 | 13 ++++++--
 fs/xfs/xfs_super.c         |  5 ++-
 include/linux/fs.h         |  8 +++--
 include/uapi/linux/mount.h |  2 +-
 kernel/power/hibernate.c   |  9 ++----
 kernel/power/suspend.c     |  3 +-
 mm/shmem.c                 | 15 +++++----
 security/landlock/fs.c     |  7 ++---
 26 files changed, 206 insertions(+), 91 deletions(-)

