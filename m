Return-Path: <linux-fsdevel+bounces-29710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 896C597CA7E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D5D286262
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FAB19EED2;
	Thu, 19 Sep 2024 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTzKHJqa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D4019CD01;
	Thu, 19 Sep 2024 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726753841; cv=none; b=Vzw8nF22fq/cNY5iIluleA4lR3qx078Xy67klJpH5wlREZU0nqHjhGQ40DUa7njPxwhJCDx7fhh5w63AZHMnNeYd0Z8pM3rRn+VVEaH0oODZWfuuGJZshTvF6l0saFZEzdIcrGvJwbev6q9AzgVg0PTyStMfbDNRRl0McWbyY+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726753841; c=relaxed/simple;
	bh=qU+wcOKBKgsxvhJNNpEX2XBS2YUu0drdapf3EnUG7v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgszc8Dx0dBuhAwEiJHGHlbJ67mphZOHMDW0c19jtwuImG3t2rn24iWMtZC3liBUKGK+ms8b7O8la66FdKhpb+t3uPP1u1+8d5x1Ol96vzbhR5oFJSueHbZL2CNaUGhjFcvlzBebE03g28zHjWusi+pLZMd6M9avF4gtPgdbp24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTzKHJqa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF1BC4CEC4;
	Thu, 19 Sep 2024 13:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726753840;
	bh=qU+wcOKBKgsxvhJNNpEX2XBS2YUu0drdapf3EnUG7v0=;
	h=From:To:Cc:Subject:Date:From;
	b=hTzKHJqaCSzXlOjknpHRwf2Fb7Fs/HQCISGXQ177dpGicQae9gR1idtN6AIOlYWSJ
	 siU1JaIKtYvNCWBK7M5pYF4GkVa3V6P2mes8XnY1lNENqhU7OPLl4+Sf09sxTFLpWX
	 2nn2dfWg1mn5xL6RIgluGfLAXaGGB6eFi5mtsqfLGtRAx4Bp56u+lAvBvQgGQBchrR
	 7mUWrO/ltJO3khLT9wws4jzZokxKBEzDdUJhy3ZC0gvC5lCIgaSzwxBYFD3fvTqYsE
	 +iCC9nMFE9cThsaAsadAIQOaxoDYklGh24K+iI1IF+JLN18lOCxQMKmc62cmKCzogE
	 GImOLXQtYpa7w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs blocksize
Date: Thu, 19 Sep 2024 15:49:53 +0200
Message-ID: <20240913-vfs-blocksize-ab40822b2366@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7183; i=brauner@kernel.org; h=from:subject:message-id; bh=qU+wcOKBKgsxvhJNNpEX2XBS2YUu0drdapf3EnUG7v0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS90dHI+ZH7fYMyZ+Js3d0aDBrG3rvX5TvvTE/yCbn/r mOec8jGjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8Xc7IsKdI/ekjHY1SxRWf 4gJaedgiy+Pkry6Sf/Zh8cL/jnsbmBj++16Yszy76LjRhmjLek/GF92323haru87NWey78+HQiG FXAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

Now that the large folio/xarry bug is sorted this one seems ready.

/* Summary */
This contains the vfs infrastructure as well as the xfs bits to enable
support for block sizes (bs) larger than page sizes (ps) plus a few
fixes to related infrastructure.

There has been efforts over the last 16 years to enable enable Large
Block Sizes (LBS), that is block sizes in filesystems where bs > page
size. Through these efforts we have learned that one of the main
blockers to supporting bs > ps in filesystems has been a way to allocate
pages that are at least the filesystem block size on the page cache
where bs > ps.

Thanks to various previous efforts it is possible to support bs > ps in
XFS with only a few changes in XFS itself. Most changes are to the page
cache to support minimum order folio support for the target block size
on the filesystem.

A motivation for Large Block Sizes today is to support high-capacity
(large amount of Terabytes) QLC SSDs where the internal Indirection Unit
(IU) are typically greater than 4k to help reduce DRAM and so in turn
cost and space. In practice this then allows different architectures to
use a base page size of 4k while still enabling support for block sizes
aligned to the larger IUs by relying on high order folios on the page
cache when needed.

It also allows to take advantage of the drive's support for atomics
larger than 4k with buffered IO support in Linux. As described this year
at LSFMM, supporting large atomics greater than 4k enables databases to
remove the need to rely on their own journaling, so they can disable
double buffered writes, which is a feature different cloud providers are
already enabling through custom storage solutions.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-3)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.11-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

A lot of emphasis has been put on testing using kdevops, starting with
an XFS baseline [1]. The testing has been split into regression and
progression.

The whole test suite was run to check for regressions on existing
profiles due to the page cache changes.

The split_huge_page_test selftest on XFS filesystem was also run to
check for huge page splits in min order chunks is done correctly.

No regressions were found with these patches added on top.

8k, 16k, 32k and 64k block sizes were used during feature testing. To
compare it with existing support, an ARM VM with 64k base page system
without the patches was used as a reference to check for actual failures
due to LBS support in a 4k base page size system.

No new failures were found with the LBS support.

Some preliminary performance tests with fio on XFS on 4k block size
against pmem and NVMe with buffered IO and Direct IO on vanilla vs these
patches applied was done. There were no regressions detected.

sysbench on postgres and mysql for several hours was run on LBS XFS
without any issues.

There's also an eBPF tool called blkalgn [2] to see if IO sent to the
device is aligned and at least filesystem block size in length.

[1] https://github.com/linux-kdevops/kdevops/blob/master/docs/xfs-bugs.md
[2] https://github.com/iovisor/bcc/pull/4813

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 8400291e289ee6b2bf9779ff1c83a291501f017b:

  Linux 6.11-rc1 (2024-07-28 14:19:55 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.12.blocksize

for you to fetch changes up to 71fdfcdd0dc8344ce6a7887b4675c7700efeffa6:

  Documentation: iomap: fix a typo (2024-09-12 14:07:17 +0200)

Please consider pulling these changes from the signed vfs-6.12.blocksize tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.12.blocksize

----------------------------------------------------------------
Brian Foster (2):
      iomap: fix handling of dirty folios over unwritten extents
      iomap: make zero range flush conditional on unwritten mappings

Christian Brauner (2):
      Merge patch series "enable bs > ps in XFS"
      Merge patch series "iomap: flush dirty cache over unwritten mappings on zero range"

Christoph Hellwig (5):
      iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
      iomap: improve shared block detection in iomap_unshare_iter
      iomap: pass flags to iomap_file_buffered_write_punch_delalloc
      iomap: pass the iomap to the punch callback
      iomap: remove the iomap_file_buffered_write_punch_delalloc return value

Dave Chinner (1):
      xfs: use kvmalloc for xattr buffers

Dennis Lam (1):
      docs:filesystems: fix spelling and grammar mistakes in iomap design page

Josef Bacik (1):
      iomap: add a private argument for iomap_file_buffered_write

Luis Chamberlain (2):
      mm: split a folio in minimum folio order chunks
      iomap: remove set_memor_ro() on zero page

Matthew Wilcox (Oracle) (1):
      fs: Allow fine-grained control of folio sizes

Pankaj Raghav (9):
      filemap: allocate mapping_min_order folios in the page cache
      readahead: allocate folios with mapping_min_order in readahead
      filemap: cap PTE range to be created to allowed zero fill in folio_map_range()
      iomap: fix iomap_dio_zero() for fs bs > system page size
      xfs: expose block size in stat
      xfs: make the calculation generic in xfs_sb_validate_fsb_count()
      xfs: enable block size larger than page size support
      filemap: fix htmldoc warning for mapping_align_index()
      Documentation: iomap: fix a typo

 Documentation/filesystems/iomap/design.rst |   8 +-
 block/fops.c                               |   2 +-
 fs/gfs2/file.c                             |   2 +-
 fs/iomap/buffered-io.c                     | 199 ++++++++++++++++++-----------
 fs/iomap/direct-io.c                       |  42 +++++-
 fs/xfs/libxfs/xfs_attr_leaf.c              |  15 +--
 fs/xfs/libxfs/xfs_ialloc.c                 |   5 +
 fs/xfs/libxfs/xfs_shared.h                 |   3 +
 fs/xfs/xfs_file.c                          |   2 +-
 fs/xfs/xfs_icache.c                        |   6 +-
 fs/xfs/xfs_iomap.c                         |  19 +--
 fs/xfs/xfs_iops.c                          |  12 +-
 fs/xfs/xfs_mount.c                         |   8 +-
 fs/xfs/xfs_super.c                         |  28 ++--
 fs/zonefs/file.c                           |   2 +-
 include/linux/huge_mm.h                    |  28 +++-
 include/linux/iomap.h                      |  13 +-
 include/linux/pagemap.h                    | 124 ++++++++++++++++--
 mm/filemap.c                               |  36 ++++--
 mm/huge_memory.c                           |  65 +++++++++-
 mm/readahead.c                             |  83 +++++++++---
 21 files changed, 506 insertions(+), 196 deletions(-)

