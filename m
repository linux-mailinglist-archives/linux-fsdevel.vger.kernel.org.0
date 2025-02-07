Return-Path: <linux-fsdevel+bounces-41179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6598A2C0FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A548C188CFE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179471DE896;
	Fri,  7 Feb 2025 10:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5J1kZmA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0311917E7;
	Fri,  7 Feb 2025 10:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925538; cv=none; b=iD14NRylZ29YIlIjEF2diolHVTR3CSKUa+sZM7zI6mKrBKV0fVGMhM5KYh7MUarw/qRtBcLSzCo+gbHOIWjLYndpyBujbHIRti5hoOzmejIYxJ6GXMdhSKiHvT5rC171aaYRsRMcLixDYG21ZYcxalCE+WJSjNN+TkoHmRSSf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925538; c=relaxed/simple;
	bh=owovfkvRgIM8aMv4cO8gkk9tmITsZMDX0UD/zXEAZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSir31HfTxUoaWQiyDeDMThfFYAqCl1AAh865p+pkgVs0hGmomXioG8H6ksx2PF5jL+EK5bxfnYcugbqYierBdepXrSQrPRJGOiEE0XW836DszxbRg5kMTkMYuhVaiSr8No+xUyz87zXk7agW2emc4x7eejREUOs843RZvpuGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5J1kZmA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AB5C4CED1;
	Fri,  7 Feb 2025 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738925537;
	bh=owovfkvRgIM8aMv4cO8gkk9tmITsZMDX0UD/zXEAZVY=;
	h=From:To:Cc:Subject:Date:From;
	b=b5J1kZmAteh7WfPywdnYLBkaPAmVBsj/GSWUo4IfrWou9++ncVJ0YJGPzW52Foshr
	 5usn51EjSeoE//m2klscIiUMSLR0jiRW9jPslIKhPpd4/3aoUCmcn9bIdsVeElvIOR
	 mda1S8G0CJGAoz7da/dHnVXFZBuI49yjRRAheOeOUw65kOoJ8ciyUmqEa71GwPqDiH
	 i8OOTxottjeUXLL5Ud6AqZ3tdn9W03tasi7BhxGXVVk3Sac0xrYDgLRuOEmGPmGJ/3
	 dP+aJydrV1LK9662cHKpC+6hwRzoYldkCO5g7zdHcSDFdYtueqoptlz0OLr1iay8sm
	 JwVUhxTNeicfg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  7 Feb 2025 11:52:03 +0100
Message-ID: <20250207-vfs-fixes-304444b009fc@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4321; i=brauner@kernel.org; h=from:subject:message-id; bh=owovfkvRgIM8aMv4cO8gkk9tmITsZMDX0UD/zXEAZVY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQvfXq16yn/wc82l5qeHJkck9Mc8NE69FD3kfqd+hsOt Uz38fHL7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZgI335Ghi/yZ2+5/2v02raq w+wls1kn7722zTue3y8q2bJ7lTDLwiCGf2qzzkZozBXYJ1qloTjpWcBcu9Tdu6oz0jNUSo+om3y 5ygEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

- Fix fsnotify FMODE_NONOTIFY* handling.
  This also disables fsnotify on all pseudo files by default apart from
  very selection exceptions. This carries a regression risk so we need
  to watch out and adapt accordingly. However, it is overall a
  significant improvement over the current status quo where every rando
  file can get fsnotify enabled.

- Cleanup and simplify lockref_init() after recent lockref changes.

- Fix vboxfs build with gcc-15.

- Add an assert into inode_set_cached_link() to catch corrupt links.

- Allow users to also use an empty string check to detect whether a
  given mount option string was empty or not.

- Fix how security options were appended to statmount()'s ->mnt_opt field.

- Fix statmount() selftests to always check the returned mask.

- Fix uninitialized value in vfs_statx_path().

- Fix pidfs_ioctl() sanity checks to guard against ioctl() overloading
  and preserve extensibility.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.14-rc2.fixes

for you to fetch changes up to 37d11cfc63604b3886308e2111d845d148ced8bc:

  vfs: sanity check the length passed to inode_set_cached_link() (2025-02-07 10:29:59 +0100)

Please consider pulling these changes from the signed vfs-6.14-rc2.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.14-rc2.fixes

----------------------------------------------------------------
Amir Goldstein (3):
      fsnotify: use accessor to set FMODE_NONOTIFY_*
      fsnotify: disable notification by default for all pseudo files
      fsnotify: disable pre-content and permission events by default

Andreas Gruenbacher (3):
      gfs2: use lockref_init for gl_lockref
      gfs2: switch to lockref_init(..., 1)
      lockref: remove count argument of lockref_init

Brahmajit Das (1):
      vboxsf: fix building with GCC 15

Christian Brauner (3):
      Merge patch series "further lockref cleanups"
      Merge patch series "Fix for huge faults regression"
      pidfs: improve ioctl handling

Mateusz Guzik (1):
      vfs: sanity check the length passed to inode_set_cached_link()

Miklos Szeredi (3):
      statmount: let unset strings be empty
      fs: fix adding security options to statmount.mnt_opt
      selftests: always check mask returned by statmount(2)

Su Hui (1):
      fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()

 drivers/tty/pty.c                                  |  2 +-
 fs/dcache.c                                        |  2 +-
 fs/erofs/zdata.c                                   |  2 +-
 fs/file_table.c                                    | 16 +++++++
 fs/gfs2/glock.c                                    |  2 +-
 fs/gfs2/main.c                                     |  1 -
 fs/gfs2/quota.c                                    |  4 +-
 fs/namespace.c                                     | 54 ++++++++++++----------
 fs/notify/fsnotify.c                               | 18 +++++---
 fs/open.c                                          | 11 +++--
 fs/pidfs.c                                         | 12 ++++-
 fs/pipe.c                                          |  6 +++
 fs/stat.c                                          |  4 +-
 fs/vboxsf/super.c                                  |  3 +-
 include/linux/fs.h                                 | 20 +++++++-
 include/linux/fsnotify.h                           |  4 +-
 include/linux/lockref.h                            |  7 +--
 net/socket.c                                       |  5 ++
 .../filesystems/statmount/statmount_test.c         | 22 ++++++++-
 19 files changed, 143 insertions(+), 52 deletions(-)

