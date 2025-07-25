Return-Path: <linux-fsdevel+bounces-56027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9DB11D91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A99A1C81913
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865472ECD28;
	Fri, 25 Jul 2025 11:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqemWJAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F52EBDFA;
	Fri, 25 Jul 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442863; cv=none; b=JE+zOvVUszer7sitvju+KLsLIIZ2D2Y34YCkplfFO9bjsMYg6n8UB9X15f7F0zpaz5cBmztEbTJqS0cAJJrBPu7UPfrAFjkSht0rIGw/xFdDqYAxkZXPjPsKv6ZM0gVJbkOT0lx6BxQ+0nHwATGYxEhwXj+0XyRWGT6oxQzBkqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442863; c=relaxed/simple;
	bh=Odj46TXlpc02N81pr+iMPuWnyQUw8qTRSFM+20ts8v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaoOOz43BQGrYR1xDQWl3HiNaRy/tVgOayLe3YgRbBLgadKHovqQnURXkRTthuSW3vBe5CkNaQnM9EdNcDPyRYKm5nK8o3R4PBoDyc1V04fcgFJsxlOuIOJsFNckl51DtLw+5Pt6CtoQfxQof8NkuN8n0TyZ0YDOAsCHgspmn1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqemWJAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97CE7C4CEEF;
	Fri, 25 Jul 2025 11:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442862;
	bh=Odj46TXlpc02N81pr+iMPuWnyQUw8qTRSFM+20ts8v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqemWJAFQQxL/0CqcLO15q4/wt1ImYdaylVQclz8STxW/dnQX8EzhVUp7mckIKaYI
	 UPAYCxHpgrmnrALmfk3aNxR0G0dXUr7FTr2A2EBCfEZJQjRii/OAhTS6S7ww/r+48x
	 v3BKeWOVgCrrwOq7hpvwVBP0Vc0w0envIKFnjvVHbTn0/4XKBelG1LH/IVyUdUxcfU
	 qckLAhFyWRHHTmWcCn5ePnF2uIUhODJTNm+eUD3cuYf9iA8fqDI0C08qC225AvoLcm
	 cNBnQsRa7et5HgbsgIFjNCpPyvGC4i5urkxzSdcybuk4ZooquFakSaICVc3tinDZZG
	 lJZk5cGUydtyg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 07/14 for v6.17] vfs mmap
Date: Fri, 25 Jul 2025 13:27:22 +0200
Message-ID: <20250725-vfs-mmap-f49018b134e1@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9139; i=brauner@kernel.org; h=from:subject:message-id; bh=Odj46TXlpc02N81pr+iMPuWnyQUw8qTRSFM+20ts8v8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4k1qSXnZVUvs/hadvmgTfoT3+SoDNbC+zFPS5+2H wy0SNvQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJH5qxn+R8po3d/4eeec+gWm C/0d11Tc+BS28Jm0Y8jlGpvE9P0vHBn+Vxo9Yln8tsBktg7H6Va5CUcPc5+5pnR+BpvO3Tc951Y 8ZAIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
Last cycle we introduce f_op->mmap_prepare() in c84bf6dd2b83 ("mm:
introduce new .mmap_prepare() file callback").

This is preferred to the existing f_op->mmap() hook as it does require a
VMA to be established yet, thus allowing the mmap logic to invoke this
hook far, far earlier, prior to inserting a VMA into the virtual address
space, or performing any other heavy handed operations.

This allows for much simpler unwinding on error, and for there to be a
single attempt at merging a VMA rather than having to possibly reattempt
a merge based on potentially altered VMA state.

Far more importantly, it prevents inappropriate manipulation of
incompletely initialised VMA state, which is something that has been the
cause of bugs and complexity in the past.

The intent is to gradually deprecate f_op->mmap, and in that vein this
series coverts the majority of file systems to using f_op->mmap_prepare.

Prerequisite steps are taken - firstly ensuring all checks for mmap
capabilities use the file_has_valid_mmap_hooks() helper rather than
directly checking for f_op->mmap (which is now not a valid check) and
secondly updating daxdev_mapping_supported() to not require a VMA
parameter to allow ext4 and xfs to be converted.

Commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
nested file systems") handles the nasty edge-case of nested file systems
like overlayfs, which introduces a compatibility shim to allow
f_op->mmap_prepare() to be invoked from an f_op->mmap() callback.

This allows for nested filesystems to continue to function correctly
with all file systems regardless of which callback is used. Once we
finally convert all file systems, this shim can be removed.

As a result, ecryptfs, fuse, and overlayfs remain unaltered so they can
nest all other file systems.

We additionally do not update resctl - as this requires an update to
remap_pfn_range() (or an alternative to it) which we defer to a later
series, equally we do not update cramfs which needs a mixed mapping
insertion with the same issue, nor do we update procfs, hugetlbfs, syfs
or kernfs all of which require VMAs for internal state and hooks. We
shall return to all of these later.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This will have a merge conflict with mainline that can be resolved as follows:

diff --cc Documentation/filesystems/porting.rst
index 200226bfd6cf,48fff4c407f3..000000000000
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@@ -1249,9 -1252,12 +1249,21 @@@ an extra reference to new mount - it sh

  ---

 +collect_mounts()/drop_collected_mounts()/iterate_mounts() are gone now.
 +Replacement is collect_paths()/drop_collected_path(), with no special
 +iterator needed.  Instead of a cloned mount tree, the new interface returns
 +an array of struct path, one for each mount collect_mounts() would've
 +created.  These struct path point to locations in the caller's namespace
 +that would be roots of the cloned mounts.
++
++---
++
+ **highly recommended**
+
+ The file operations mmap() callback is deprecated in favour of
+ mmap_prepare(). This passes a pointer to a vm_area_desc to the callback
+ rather than a VMA, as the VMA at this stage is not yet valid.
+
+ The vm_area_desc provides the minimum required information for a filesystem
+ to initialise state upon memory mapping of a file-backed region, and output
+ parameters for the file system to set this state.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.mmap_prepare

for you to fetch changes up to 425c8bb39b032bfb338857476eff5bbee324343e:

  doc: update porting, vfs documentation to describe mmap_prepare() (2025-07-23 15:09:14 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.mmap_prepare tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.mmap_prepare

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "convert the majority of file systems to mmap_prepare"

Lorenzo Stoakes (11):
      mm: rename call_mmap/mmap_prepare to vfs_mmap/mmap_prepare
      mm/nommu: use file_has_valid_mmap_hooks() helper
      fs: consistently use can_mmap_file() helper
      fs/dax: make it possible to check dev dax support without a VMA
      fs/ext4: transition from deprecated .mmap hook to .mmap_prepare
      fs/xfs: transition from deprecated .mmap hook to .mmap_prepare
      mm/filemap: introduce generic_file_*_mmap_prepare() helpers
      fs: convert simple use of generic_file_*_mmap() to .mmap_prepare()
      fs: convert most other generic_file_*mmap() users to .mmap_prepare()
      fs: replace mmap hook with .mmap_prepare for simple mappings
      doc: update porting, vfs documentation to describe mmap_prepare()

 Documentation/filesystems/porting.rst      | 12 +++++++++++
 Documentation/filesystems/vfs.rst          | 22 +++++++++++++++----
 block/fops.c                               | 12 +++++------
 drivers/gpu/drm/i915/gem/i915_gem_dmabuf.c |  2 +-
 fs/9p/vfs_file.c                           | 13 ++++++------
 fs/adfs/file.c                             |  2 +-
 fs/affs/file.c                             |  2 +-
 fs/afs/file.c                              | 12 +++++------
 fs/aio.c                                   |  8 +++----
 fs/backing-file.c                          |  4 ++--
 fs/bcachefs/fs.c                           |  8 +++----
 fs/bfs/file.c                              |  2 +-
 fs/binfmt_elf.c                            |  4 ++--
 fs/binfmt_elf_fdpic.c                      |  2 +-
 fs/btrfs/file.c                            |  7 +++---
 fs/ceph/addr.c                             |  6 +++---
 fs/ceph/file.c                             |  2 +-
 fs/ceph/super.h                            |  2 +-
 fs/coda/file.c                             |  6 +++---
 fs/ecryptfs/file.c                         |  2 +-
 fs/erofs/data.c                            | 16 +++++++-------
 fs/exfat/file.c                            | 10 +++++----
 fs/ext2/file.c                             | 12 ++++++-----
 fs/ext4/file.c                             | 13 ++++++------
 fs/f2fs/file.c                             |  7 +++---
 fs/fat/file.c                              |  2 +-
 fs/hfs/inode.c                             |  2 +-
 fs/hfsplus/inode.c                         |  2 +-
 fs/hostfs/hostfs_kern.c                    |  2 +-
 fs/hpfs/file.c                             |  2 +-
 fs/jffs2/file.c                            |  2 +-
 fs/jfs/file.c                              |  2 +-
 fs/minix/file.c                            |  2 +-
 fs/nfs/file.c                              | 13 ++++++------
 fs/nfs/internal.h                          |  2 +-
 fs/nfs/nfs4file.c                          |  2 +-
 fs/nilfs2/file.c                           |  8 +++----
 fs/ntfs3/file.c                            | 15 +++++++------
 fs/ocfs2/file.c                            |  4 ++--
 fs/ocfs2/mmap.c                            |  5 +++--
 fs/ocfs2/mmap.h                            |  2 +-
 fs/omfs/file.c                             |  2 +-
 fs/orangefs/file.c                         | 10 +++++----
 fs/ramfs/file-mmu.c                        |  2 +-
 fs/ramfs/file-nommu.c                      | 12 +++++------
 fs/read_write.c                            |  2 +-
 fs/romfs/mmap-nommu.c                      |  6 +++---
 fs/smb/client/cifsfs.c                     | 12 +++++------
 fs/smb/client/cifsfs.h                     |  4 ++--
 fs/smb/client/file.c                       | 16 +++++++-------
 fs/ubifs/file.c                            | 10 ++++-----
 fs/ufs/file.c                              |  2 +-
 fs/vboxsf/file.c                           |  8 +++----
 fs/xfs/xfs_file.c                          | 15 +++++++------
 fs/zonefs/file.c                           | 10 +++++----
 include/linux/dax.h                        | 16 ++++++++------
 include/linux/fs.h                         | 13 ++++++------
 ipc/shm.c                                  |  2 +-
 mm/filemap.c                               | 29 +++++++++++++++++++++++++
 mm/internal.h                              |  2 +-
 mm/mmap.c                                  |  2 +-
 mm/nommu.c                                 |  2 +-
 mm/vma.c                                   |  2 +-
 tools/testing/vma/vma_internal.h           | 34 ++++++++++++++++++++++++------
 64 files changed, 281 insertions(+), 187 deletions(-)

