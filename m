Return-Path: <linux-fsdevel+bounces-49765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C50AC22BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC047B15AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248E0128819;
	Fri, 23 May 2025 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o5yhJUQX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF727DA95;
	Fri, 23 May 2025 12:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003988; cv=none; b=Ht9mZbgS8XPZ1ozOjDBlDJKOyetA6IcDbYPFLuvunsPAxn2Wj9Hqho02yiVMuCU3Zqb63n2O0Iz8FAUBJ8GP0c3sNhE3ActuPgY7sgsjDW8zW9XK6MxXWnV9rCRCHC5fMF291DBU9E2Fa5/VryrWJ1fXUA4BpHiiz3DdpsZiotk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003988; c=relaxed/simple;
	bh=tYoDJH0HYBPhPQY/3oL2V+H8GV80um/DRK01YAD/Crc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rtKtOm8dulkmaapxXo6Vh5HVOUU/tkCR9oO88r8AS6qG6Db42iHSXxR9E6h9Pln1e9XkjP7a8/f5VqKG1IA9Pp8iyme/N+ZkNpPLMT5YTgquZK4ZNfqUnqRqK6hMUp5la7TvIj6VrznqVF7U8VpPENG7ZCCsgo64UCw687/3Uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o5yhJUQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453AC4CEE9;
	Fri, 23 May 2025 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748003988;
	bh=tYoDJH0HYBPhPQY/3oL2V+H8GV80um/DRK01YAD/Crc=;
	h=From:To:Cc:Subject:Date:From;
	b=o5yhJUQXlKFISRs8tCTTkrMw3NsckMlKwhILMaUtwDmWpHG4Dt0yV0ruksk4EcrIs
	 fKrX35yyuq8i5lFyfibDvuwcM/c44eRa/j0if4BrhHBcSjDsfmgkbPTE/RkoPPhoFD
	 sssvBV7jz2B5W4YK/K+G+wV0pQg9O3Vo2bxA96x4z+iLEoHTChj1CQAuXO5iYVupOU
	 YpokXpnPPg5M9+b6P81M5P+0OeshdZKQUZTFgCvs8nXO5v1LaMG7kLjFtioJRGly9v
	 fpJSiCytU/zJwJ6as1KfO+VETk8pyzyhhCRbJTNW3Ds00RovrsUaeExxhNeEnIbRrm
	 8rTxLK64crVJw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs writepages
Date: Fri, 23 May 2025 14:39:39 +0200
Message-ID: <20250523-vfs-writepages-edcd7e528060@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2970; i=brauner@kernel.org; h=from:subject:message-id; bh=tYoDJH0HYBPhPQY/3oL2V+H8GV80um/DRK01YAD/Crc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5PT94ZHSvZP5lpc/RG2v9w3z8683JXy3jRPY3paX4 sKmJpjbUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGrPxgZ/h4RDeB5xVel8rno l+oKRwE+39UGa69m6Bo5NE6K12ZzZGTozHReu7Vu/uLFka4Pbs+zlJ635ri1Gq9jyI+Nz23Wd/9 iBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This converts vboxfs from ->writepage() to ->writepages(). This was the last
user of the ->writepage() method. So remove ->writepage() completely and all
references to it.

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

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.writepage

for you to fetch changes up to fb5a381d624bf6ad3dc2541387feb5d835e1f377:

  Merge patch series "Remove aops->writepage" (2025-04-07 09:36:50 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.writepage tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.writepage

----------------------------------------------------------------
Christian Brauner (1):
      Merge patch series "Remove aops->writepage"

Matthew Wilcox (Oracle) (9):
      9p: Add a migrate_folio method
      vboxsf: Convert to writepages
      migrate: Remove call to ->writepage
      writeback: Remove writeback_use_writepage()
      shmem: Add shmem_writeout()
      i915: Use writeback_iter()
      ttm: Call shmem_writeout() from ttm_backup_backup_page()
      mm: Remove swap_writepage() and shmem_writepage()
      fs: Remove aops->writepage

 Documentation/admin-guide/cgroup-v2.rst   |  2 +-
 Documentation/filesystems/fscrypt.rst     |  2 +-
 Documentation/filesystems/locking.rst     | 54 ++--------------------------
 Documentation/filesystems/vfs.rst         | 39 +++++---------------
 block/blk-wbt.c                           |  2 +-
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 32 +++++------------
 drivers/gpu/drm/ttm/ttm_backup.c          |  8 ++---
 fs/9p/vfs_addr.c                          |  1 +
 fs/buffer.c                               |  4 +--
 fs/vboxsf/file.c                          | 47 ++++++++++++------------
 include/linux/fs.h                        |  1 -
 include/linux/shmem_fs.h                  |  7 ++--
 mm/migrate.c                              | 60 ++++---------------------------
 mm/page-writeback.c                       | 28 ++-------------
 mm/page_io.c                              |  3 +-
 mm/shmem.c                                | 33 ++++++++---------
 mm/swap.h                                 |  4 +--
 mm/swap_state.c                           |  1 -
 mm/swapfile.c                             |  2 +-
 mm/vmscan.c                               | 29 ++++++++-------
 20 files changed, 101 insertions(+), 258 deletions(-)

