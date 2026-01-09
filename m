Return-Path: <linux-fsdevel+bounces-73026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425AD08A82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 09 Jan 2026 11:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE46F300BDB2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jan 2026 10:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C2F339714;
	Fri,  9 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2QE0N4x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F23385A3;
	Fri,  9 Jan 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767955216; cv=none; b=YYNa06zwLRD9ml33ZHvDXgFbSiFS/BGGhmHBzvcMWCtg7PcCRkynu28vt9QQ1xxDGzdX0lDY9BFQlxi0VfFjR153f8N9H5zUKMw6CeJIAhaAIDia6VrpkyN+dMYbn+AoDMj/EzTD+ESuI32Ch/mc/0lxaY3HQK06MDaH3Os8hYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767955216; c=relaxed/simple;
	bh=BGcYI9jqHXf7s/m+PSXbgbxK0T2s7hHg9CWJtKEqbLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9PF+dAy+BEorYskk1qmxrlkjQimTej5xH94/pRhAuPtKiwuD88kfNv09BEv89rX+ckvM4GYxIbgqct96PFZowdhVqlULLxRLqflWYRW3SZqmd8mfAAvtk4/+jI1hoPWldHuXGKsniotH2y+uO7gT4m/+7SV7h151L5wsELWHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2QE0N4x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB04C4CEF1;
	Fri,  9 Jan 2026 10:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767955216;
	bh=BGcYI9jqHXf7s/m+PSXbgbxK0T2s7hHg9CWJtKEqbLY=;
	h=From:To:Cc:Subject:Date:From;
	b=U2QE0N4x5I1MI5JO7Ro03W6oDnAr5gh3z8Eu1gpvVZ6tvsJ4plTjiHB2A89hErPsI
	 KZkHM5CGl54RSbRtQfWQ0FrkhBt6M84pQxKZt8q7S1f2yTry1/BFPjsj32C2sGQNvA
	 Q5i5x0JoUk3dK9yuBdxbvI+KdulzJpLVWVSXoS9CI21RHxFaRh9fA8b//prXOi75z+
	 Kwisr15nRk07ETYkPPwMJr2XqVdeRZkU5zjOFJD7BjdhcP2Civ8JtyKGuL5dROHbxl
	 rBCfOceMmPVGmMpqPhpnI9bSRST7adnD/YGKtX5INaNmUGhInj8xC0Lc5GCkBZ8rkH
	 81CxJM4l4hw4Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  9 Jan 2026 11:39:37 +0100
Message-ID: <20260109-vfs-fixes-221725170b4e@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5321; i=brauner@kernel.org; h=from:subject:message-id; bh=BGcYI9jqHXf7s/m+PSXbgbxK0T2s7hHg9CWJtKEqbLY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQm3Pq8521wPotOUcr0nZnLVSfEHV925TfTy0ldVvlCX FWFGwP/dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyE5wLD/9LM35UPQhs716kp rRTvz33EMH9DwH0Z46YZ+y9OuJpS/oyRYXdH6r8jkdencxWsaM0MK9zzdGN3OsM27Ybj+jJ7Wf0 +MgAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Remove incorrect __user annotation from struct xattr_args::value.

- Documentation fix: Add missing kernel-doc description for the @isnew
  parameter in ilookup5_nowait() to silence Sphinx warnings.

- Documentation fix: Fix kernel-doc comment for __start_dirop() - the
  function name in the comment was wrong and the @state parameter was
  undocumented.

- Replace dynamic folio_batch allocation with stack allocation in
  iomap_zero_range(). The dynamic allocation was problematic for ext4-on-iomap
  work (didn't handle allocation failure properly) and triggered lockdep
  complaints. Uses a flag instead to control batch usage.

- Re-add #ifdef guards around PIDFD_GET_<ns-type>_NAMESPACE ioctls. When a
  namespace type is disabled, ns->ops is NULL, causes crashes during inode
  eviction when closing the fd. The ifdefs were removed in a recent
  simplification but are still needed.

- Fixe a race where a folio could be unlocked before the trailing zeros (for
  EOF within the page) were written.

- Split out a dedicated lease_dispose_list() helper since lease code paths
  always know they're disposing of leases. Removes unnecessary runtime flag
  checks and prepares for upcoming lease_manager enhancements.

- Fix userland delegation requests succeeding despite conflicting opens.
  Previously, FL_LAYOUT and FL_DELEG leases bypassed conflict checks (a hack
  for nfsd). Adds new ->lm_open_conflict() lease_manager operation so userland
  delegations get proper conflict checking while nfsd can continue its own
  conflict handling.

- Fix LOOKUP_CACHED path lookups incorrectly falling through to the slow
  path. After legitimize_links() calls were conditionally elided, the routine
  would always fail with LOOKUP_CACHED regardless of whether there were any
  links. Now the flag is checked at the two callsites before calling
  legitimize_links().

- Fix bug in media fd allocation in media_request_alloc().

- Fix mismatched API calls in ecryptfs_mknod(): was calling end_removing()
  instead of end_creating() after ecryptfs_start_creating_dentry().

- Fix dentry reference count leak in ecryptfs_mkdir(): a dget() of the
  lower parent dir was added but never dput()'d, causing BUG during lower
  filesystem unmount due to the still-in-use dentry.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc5.fixes

for you to fetch changes up to 75ddaa4ddc86d31edb15e50152adf4ddee77a6ba:

  pidfs: protect PIDFD_GET_* ioctls() via ifdef (2026-01-06 23:08:12 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc5.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc5.fixes

----------------------------------------------------------------
Al Viro (1):
      get rid of bogus __user in struct xattr_args::value

Bagas Sanjaya (2):
      fs: Describe @isnew parameter in ilookup5_nowait()
      VFS: fix __start_dirop() kernel-doc warnings

Brian Foster (1):
      iomap: replace folio_batch allocation with stack allocation

Christian Brauner (3):
      Merge patch series "filelock: fix conflict detection with userland file delegations"
      Merge patch series "Fix two regressions from start_creating()/start_removing() conversion"
      pidfs: protect PIDFD_GET_* ioctls() via ifdef

David Howells (1):
      netfs: Fix early read unlock of page with EOF in middle

Jeff Layton (2):
      filelock: add lease_dispose_list() helper
      filelock: allow lease_managers to dictate what qualifies as a conflict

Mateusz Guzik (1):
      fs: make sure to fail try_to_unlazy() and try_to_unlazy() for LOOKUP_CACHED

Mathias Krause (1):
      media: mc: fix potential use-after-free in media_request_alloc()

Tyler Hicks (2):
      ecryptfs: Fix improper mknod pairing of start_creating()/end_removing()
      ecryptfs: Release lower parent dentry after creating dir

 Documentation/filesystems/locking.rst |   1 +
 drivers/media/mc/mc-request.c         |   6 +-
 fs/ecryptfs/inode.c                   |   3 +-
 fs/inode.c                            |   3 +
 fs/iomap/buffered-io.c                |  50 +++++++++-----
 fs/iomap/iter.c                       |   6 +-
 fs/locks.c                            | 119 +++++++++++++++++-----------------
 fs/namei.c                            |  21 ++++--
 fs/netfs/read_collect.c               |   2 +-
 fs/nfsd/nfs4layouts.c                 |  23 ++++++-
 fs/nfsd/nfs4state.c                   |  19 ++++++
 fs/pidfs.c                            |  18 +++++
 fs/xfs/xfs_iomap.c                    |  11 ++--
 include/linux/filelock.h              |   1 +
 include/linux/iomap.h                 |   8 ++-
 include/uapi/linux/xattr.h            |   2 +-
 16 files changed, 196 insertions(+), 97 deletions(-)

