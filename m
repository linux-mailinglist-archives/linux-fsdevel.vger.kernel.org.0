Return-Path: <linux-fsdevel+bounces-58297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB1B2C412
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 14:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2F4B7A4EA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 12:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237F232C333;
	Tue, 19 Aug 2025 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVPewsaq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74C1DC9B5;
	Tue, 19 Aug 2025 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607686; cv=none; b=OZnyHXgKg3SB8gkjIOxx/uCwA/0iZBuC8zg3mIFwU5y71Uq40VEdmdSw3bHykXdHhTcUvAHoi8+iku1Yo4GnZUjK2Sfimq42cenhfHiu447/63gAApLOVYVYVeuKJmt08YPM8Amk6Wfh0NY2517sVtD9egkiNk+FX2t+nb9eKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607686; c=relaxed/simple;
	bh=v+nlukooyHgiiAzOjRBCWU5iDkofOBDlFVD92uktfbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXzT2Rh9sSJUuOVJPRQwR2VAsmtR/7eABEIpmrWxmOmSPSx/yGZft1jXUpem/wciGALEMld6DuXhPnky9Xuz8pn5+4OmVtySxBJdRIPDcy5czXKlHIw1vmieZ//TIQxI9dqq6++GHs7J3lbEx8eHBxHl1foztTc/HPsCVbKpI2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVPewsaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE68C4CEF1;
	Tue, 19 Aug 2025 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755607686;
	bh=v+nlukooyHgiiAzOjRBCWU5iDkofOBDlFVD92uktfbw=;
	h=From:To:Cc:Subject:Date:From;
	b=lVPewsaqbQIuJ0t3bzUzChQT0LnErbAOZDM9m+oOYqjM00Q2YkRPG6p3+yEpNge2v
	 bp0RWxBaEda/G05TMyw+ZNpcA+Ib73LZMKmFhoJWgII0sHL4cLjKr3kKe/yPzYpb/W
	 5iCGXYu+jMzNkULPP6dfmT7CLDiXSeQpeXEuqMNXBJ6VrzJz3WEP5C27Hx1qoFRAGH
	 E+IREyOQao9jlZUCQLO9Bm1p6ukXRaK58KczZdprloFe3xc5zHcMmwqhx+hzWWYX7W
	 PS1s/z7Ji177TU9MNZ3jO5iie6udBd1hWfoZsfU5NvACSxanGXUAWErLQBW3d5c+Pp
	 oDQCK/y1l0KQA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Tue, 19 Aug 2025 14:46:16 +0200
Message-ID: <20250819-vfs-fixes-69c14bc8543f@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4524; i=brauner@kernel.org; h=from:subject:message-id; bh=v+nlukooyHgiiAzOjRBCWU5iDkofOBDlFVD92uktfbw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQsKSpbe0SvdwPH4Zdflhc55M/5OPdLb0DL9nVHz7Jdu uD+wNRod0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE8lgYGRYKnfPzOC5cmlo9 oy7VxoWnnf2MzP99aoxnJzGd3iYwOY6RYa1s1K+19Rp27Xy50bZBjXs0f7/a+fO5tXVAkGUi7+E 5zAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Fix two memory leaks in pidfs.

- Prevent changing the idmapping of an already idmapped mount without
  OPEN_TREE_CLONE through open_tree_attr().

- Don't fail listing extended attributes in kernfs when no extended
  attributes are set.

- Fix the return value in coredump_parse().

- Fix the error handling for unbuffered writes in netfs.

- Fix broken data integrity guarantees for O_SYNC writes via iomap.

- Fix UAF in __mark_inode_dirty().

- Keep inode->i_blkbits constant in fuse.

- Fix coredump selftests.

- Fix get_unused_fd_flags() usage in do_handle_open().

- Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES.

- Fix use-after-free in bh_read().

- Fix incorrect lflags value in the move_mount() syscall.

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

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc3.fixes

for you to fetch changes up to a2c1f82618b0b65f1ef615aa9cfdac8122537d69:

  signal: Fix memory leak for PIDFD_SELF* sentinels (2025-08-19 13:51:28 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc3.fixes

----------------------------------------------------------------
Adrian Huang (Lenovo) (2):
      pidfs: Fix memory leak in pidfd_info()
      signal: Fix memory leak for PIDFD_SELF* sentinels

Aleksa Sarai (2):
      open_tree_attr: do not allow id-mapping changes without OPEN_TREE_CLONE
      selftests/mount_setattr: add smoke tests for open_tree_attr(2) bug

Christian Brauner (2):
      Merge patch series "open_tree_attr: do not allow id-mapping changes without OPEN_TREE_CLONE"
      kernfs: don't fail listing extended attributes

Dan Carpenter (1):
      coredump: Fix return value in coredump_parse()

David Howells (1):
      netfs: Fix unbuffered write error handling

Jan Kara (1):
      iomap: Fix broken data integrity guarantees for O_SYNC writes

Jiufei Xue (1):
      fs: writeback: fix use-after-free in __mark_inode_dirty()

Joanne Koong (1):
      fuse: keep inode->i_blkbits constant

Nam Cao (1):
      selftests/coredump: Remove the read() that fails the test

Thomas Bertschinger (1):
      fhandle: do_handle_open() should get FD with user flags

Vlastimil Babka (1):
      module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to EXPORT_SYMBOL_FOR_MODULES

Ye Bin (1):
      fs/buffer: fix use-after-free when call bh_read() helper

Yuntao Wang (1):
      fs: fix incorrect lflags value in the move_mount syscall

 Documentation/core-api/symbol-namespaces.rst       | 11 ++--
 drivers/tty/serial/8250/8250_rsa.c                 |  8 +--
 fs/anon_inodes.c                                   |  2 +-
 fs/buffer.c                                        |  2 +-
 fs/coredump.c                                      |  2 +-
 fs/fhandle.c                                       |  2 +-
 fs/fs-writeback.c                                  |  9 +--
 fs/fuse/inode.c                                    |  5 --
 fs/iomap/direct-io.c                               | 14 ++--
 fs/kernfs/inode.c                                  |  4 +-
 fs/namespace.c                                     | 35 ++++++----
 fs/netfs/read_collect.c                            |  4 +-
 fs/netfs/write_collect.c                           | 10 ++-
 fs/netfs/write_issue.c                             |  4 +-
 fs/pidfs.c                                         |  2 +-
 fs/splice.c                                        |  3 +
 include/linux/export.h                             |  2 +-
 include/linux/netfs.h                              |  1 +
 kernel/signal.c                                    |  6 +-
 tools/testing/selftests/coredump/stackdump_test.c  |  3 -
 .../selftests/mount_setattr/mount_setattr_test.c   | 77 ++++++++++++++++++----
 21 files changed, 138 insertions(+), 68 deletions(-)

