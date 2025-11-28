Return-Path: <linux-fsdevel+bounces-70160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09075C92A3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC46B34DB9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CA82EAB6B;
	Fri, 28 Nov 2025 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXC7SmAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00C2E92A3;
	Fri, 28 Nov 2025 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348686; cv=none; b=rVokbJCiWWZ6T1667YGvMh2WJ9opXIe2m0bLXR3NjqyBdFfd9D2MlsjFwxcG0llNkOo9xHDkywjjjizubEz4k7534YXfNyC+OEz4xRM8MkIx5TCTs0dVBqN9gPmccEgl6jiwVLRf+ngEdDHwSURWoC8Ozid/Kh3Jl+CbwVzb2Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348686; c=relaxed/simple;
	bh=QNbXCptVSFM5kcaDDRT0+pRJYkeFaL3dtftBTlj6mIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EE8xm0sCYsh12oftxZxacKDFftVL9wC1RqPO8wZONTRDAGKlvpsLrrpm/dqJIMEfDOtHIVCNpDM5zhLjb7nczhexNXh1/zZLU45iWCJrgoO/sgdgOLSUkAJwNqC1sX/ZlpDi8JCwwYMw35hhbMGFZOAQ5yxvq3I9B7H7eTKO8Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXC7SmAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD2BC4CEF1;
	Fri, 28 Nov 2025 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348686;
	bh=QNbXCptVSFM5kcaDDRT0+pRJYkeFaL3dtftBTlj6mIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXC7SmAbC5AsVurA3Nn3MbDixMnnbfOwfZ4qRZ2Z+CkqcldYLrGVp8p4W+0QmIf40
	 8ybRJQDZHL6j8HcM3VIOUpjrtTFGz7zEhd8NI47kRBSHI8AzD6f9UJBr6t7OEDcUL/
	 llDM3Zhs/PDJMNQZhhn4nOYt6gyUJLI1Xac3yufl+BcOe9yoCiPMlcLU9C49SR8tS+
	 lIHTvFn2rdUalSpfX649kaPlGzNuGIsFDf7glR4/Y/RTwOO1IBETLmbs6qsuV+cpU1
	 myAIzgGV5XCzsllBXTkrF77aVCOyLcAlhOZdkyjcDMzjOU3oBWKkrTvoOvg7VaHWE8
	 BqPYQ/R2xUCRg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 10/17 for v6.19] vfs super guards
Date: Fri, 28 Nov 2025 17:48:21 +0100
Message-ID: <20251128-vfs-super-guards-v619-45069c20bd0d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3965; i=brauner@kernel.org; h=from:subject:message-id; bh=QNbXCptVSFM5kcaDDRT0+pRJYkeFaL3dtftBTlj6mIU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnosyjZ9y1Tl+J8z1SJ5eLNKHovP4JGPONBYv3K9c 03KLO4THaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpm8TI8OCSbu/J27Fyj3zq 2DV7z1Y2zXm2aYciY3Gaf67NE4XcCEaGFzatPCytH99LTu8sDLON33Ut/UFcDPOP+c8fHJtkO2k FHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This starts the work of introducing guards for superblock related locks.
Note that this branch includes the fs_header cleanups as a dependency.

Introduce super_write_guard for scoped superblock write protection. This
provides a guard-based alternative to the manual sb_start_write() and
sb_end_write() pattern, allowing the compiler to automatically handle
the cleanup.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.guards

for you to fetch changes up to 73fd0dba0beb1d2d1695ee5452eac8dfabce3f9e:

  Merge patch series "fs: introduce super write guard" (2025-11-05 22:59:31 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.guards tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.guards

----------------------------------------------------------------
Christian Brauner (13):
      fs: rename fs_types.h to fs_dirent.h
      fs: add fs/super_types.h header
      fs: add fs/super.h header
      Merge patch series "fs: start to split up fs.h"
      fs: add super_write_guard
      btrfs: use super write guard in btrfs_reclaim_bgs_work()
      btrfs: use super write guard btrfs_run_defrag_inode()
      btrfs: use super write guard in sb_start_write()
      ext4: use super write guard in write_mmp_block()
      btrfs: use super write guard in relocating_repair_kthread()
      open: use super write guard in do_ftruncate()
      xfs: use super write guard in xfs_file_ioctl()
      Merge patch series "fs: introduce super write guard"

Mateusz Guzik (1):
      fs: inline current_umask() and move it to fs_struct.h

 fs/9p/acl.c                               |   1 +
 fs/Makefile                               |   2 +-
 fs/btrfs/block-group.c                    |  10 +-
 fs/btrfs/defrag.c                         |   7 +-
 fs/btrfs/inode.c                          |   1 +
 fs/btrfs/volumes.c                        |   9 +-
 fs/ext4/mmp.c                             |   8 +-
 fs/f2fs/acl.c                             |   1 +
 fs/fat/inode.c                            |   1 +
 fs/{fs_types.c => fs_dirent.c}            |   2 +-
 fs/fs_struct.c                            |   6 -
 fs/hfsplus/options.c                      |   1 +
 fs/hpfs/super.c                           |   1 +
 fs/nilfs2/nilfs.h                         |   1 +
 fs/ntfs3/super.c                          |   1 +
 fs/ocfs2/acl.c                            |   1 +
 fs/omfs/inode.c                           |   1 +
 fs/open.c                                 |   9 +-
 fs/smb/client/file.c                      |   1 +
 fs/smb/client/inode.c                     |   1 +
 fs/smb/client/smb1ops.c                   |   1 +
 fs/xfs/xfs_ioctl.c                        |   6 +-
 include/linux/fs.h                        | 528 +-----------------------------
 include/linux/fs/super.h                  | 238 ++++++++++++++
 include/linux/fs/super_types.h            | 335 +++++++++++++++++++
 include/linux/{fs_types.h => fs_dirent.h} |  11 +-
 include/linux/fs_struct.h                 |   6 +
 include/linux/namei.h                     |   1 +
 28 files changed, 620 insertions(+), 571 deletions(-)
 rename fs/{fs_types.c => fs_dirent.c} (98%)
 create mode 100644 include/linux/fs/super.h
 create mode 100644 include/linux/fs/super_types.h
 rename include/linux/{fs_types.h => fs_dirent.h} (92%)

