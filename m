Return-Path: <linux-fsdevel+bounces-70158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 872C4C92A0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 757E64E3B73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C0F2DF149;
	Fri, 28 Nov 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WD7wd7wo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20212DE1E6;
	Fri, 28 Nov 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348683; cv=none; b=dyXR3lRDZLh9QNiptDTuOeJQG7C7cE/s3MpRMSIQa8zbPjNb51Cud8zMSJvLb/l2lqaBvOxFRdLKpfK1a7YGNpM8n+7GEugtntUvnzam/IsztumtNxyi4QRyfXmsnF8uIb0q3oZQbTszBJvWh2r74PRZ/pNoL/A2W2W9+zB84yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348683; c=relaxed/simple;
	bh=4pqZz70qIdFoZEA3/hQ/yglVAYP1296YBmglUpPr43c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTBJ/yNf4i38T9NQqCH9H5+M6hC1TRWzMAdGdGUBYp8Ul8WFKfMYkXxOtJo7T7Lmhvpn2AjlxuM5gTp9pDwIkQ1ZZOcMx/DQxEjEQBGwUHCbykeesXsQO4figRxcRwuG3yUJmLGyqHeG7DYnvxtM88lSVwDiy61c7JGr1hbdhM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WD7wd7wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E45C116C6;
	Fri, 28 Nov 2025 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348681;
	bh=4pqZz70qIdFoZEA3/hQ/yglVAYP1296YBmglUpPr43c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WD7wd7woZ4IAdJ6DZgFbC/y5diR958N5Dts034BEp09F9AhXLcFq29oZshRoh5cpy
	 0wxkh64Fcp1bWY+/h12W1c4JbGJcfBIHS2336kxpqrdOkPJX+jzW7T0+RkuAP5Thlp
	 DhyJtrviw2Hu4J05nIQRfveY/gsq9h9v9HQVfTP7xuKWXH/3tr955qPjofz1/1NVMj
	 QsU57aighGU1LonQHNr75mA75HR273S9B8x35Kh0EH6WzWuAZplsiYy2qm3kdvmmUR
	 4wWzkvK2VU2+MfKs8m2xgOoZfEQ0F8jH+IR1H7Kh9btpzwlCJcLjh0iSDGR5bGR/JM
	 5FsB1hQNkQayQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/17 for v6.19] vfs folio
Date: Fri, 28 Nov 2025 17:48:18 +0100
Message-ID: <20251128-vfs-folio-v619-e62bd8562ec0@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4174; i=brauner@kernel.org; h=from:subject:message-id; bh=4pqZz70qIdFoZEA3/hQ/yglVAYP1296YBmglUpPr43c=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnrUmRj26HJkrLnHw+IXzg+qZH62vncQdnmwNc/kd IOy4f2pHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABeRYWT4sCuvzNfp2QXmwk5T lQnlmodXP9DIVZBQdZjczH4rvHQ2I8OX6TpKmQf9C7vWhW/3679rN/PSmZ6DC7cd6+VwW/FHyJE DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Add a new folio_next_pos() helper function that returns the file position
of the first byte after the current folio. This is a common operation in
filesystems when needing to know the end of the current folio.

The helper is lifted from btrfs which already had its own version, and
is now used across multiple filesystems and subsystems:

- btrfs
- buffer
- ext4
- f2fs
- gfs2
- iomap
- netfs
- xfs
- mm

This fixes a long-standing bug in ocfs2 on 32-bit systems with files
larger than 2GiB. Presumably this is not a common configuration, but the
fix is backported anyway. The other filesystems did not have bugs, they
were just mildly inefficient.

This also introduce uoff_t as the unsigned version of loff_t. A recent
commit inadvertently changed a comparison from being unsigned (on 64-bit
systems) to being signed (which it had always been on 32-bit systems),
leading to sporadic fstests failures.

Generally file sizes are restricted to being a signed integer, but in
places where -1 is passed to indicate "up to the end of the file", it is
convenient to have an unsigned type to ensure comparisons are always
unsigned regardless of architecture.

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

[1]: https://lore.kernel.org/linux-next/20251103085832.5d7ff280@canb.auug.org.au

[2]: https://lore.kernel.org/linux-next/20251124100508.64a6974a@canb.auug.org.au

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.folio

for you to fetch changes up to 37d369fa97cc0774ea4eab726d16bcb5fbe3a104:

  fs: Add uoff_t (2025-11-25 10:07:42 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.folio tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.folio

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Add and use folio_next_pos()"

Matthew Wilcox (Oracle) (11):
      filemap: Add folio_next_pos()
      btrfs: Use folio_next_pos()
      buffer: Use folio_next_pos()
      ext4: Use folio_next_pos()
      f2fs: Use folio_next_pos()
      gfs2: Use folio_next_pos()
      iomap: Use folio_next_pos()
      netfs: Use folio_next_pos()
      xfs: Use folio_next_pos()
      mm: Use folio_next_pos()
      fs: Add uoff_t

 fs/btrfs/compression.h                 |  4 ++--
 fs/btrfs/defrag.c                      |  7 ++++---
 fs/btrfs/extent_io.c                   | 16 ++++++++--------
 fs/btrfs/file.c                        |  9 +++++----
 fs/btrfs/inode.c                       | 11 ++++++-----
 fs/btrfs/misc.h                        |  5 -----
 fs/btrfs/ordered-data.c                |  2 +-
 fs/btrfs/subpage.c                     |  5 +++--
 fs/buffer.c                            |  2 +-
 fs/ext4/inode.c                        | 10 +++++-----
 fs/f2fs/compress.c                     |  2 +-
 fs/gfs2/aops.c                         |  3 +--
 fs/iomap/buffered-io.c                 | 10 ++++------
 fs/netfs/buffered_write.c              |  2 +-
 fs/netfs/misc.c                        |  2 +-
 fs/ocfs2/alloc.c                       |  2 +-
 fs/xfs/scrub/xfarray.c                 |  2 +-
 fs/xfs/xfs_aops.c                      |  2 +-
 include/linux/mm.h                     |  8 ++++----
 include/linux/pagemap.h                | 11 +++++++++++
 include/linux/shmem_fs.h               |  2 +-
 include/linux/types.h                  |  1 +
 include/uapi/asm-generic/posix_types.h |  1 +
 mm/shmem.c                             |  8 ++++----
 mm/truncate.c                          |  4 ++--
 25 files changed, 70 insertions(+), 61 deletions(-)

