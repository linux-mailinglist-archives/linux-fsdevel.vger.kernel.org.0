Return-Path: <linux-fsdevel+bounces-22868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F05291DE66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 13:53:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08C22845B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D131494B9;
	Mon,  1 Jul 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo1sjpAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC784A27;
	Mon,  1 Jul 2024 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834830; cv=none; b=ny8gVEtPhsyHxNVLnBCB8/C6srLNYzMQ72N21VWMz44CwKwFk7Uv+wnYTL8dA99n/GPfYKHFq51sT8MUdwnVi/BsJ86cF0lNti0zb2qZ3rQ+I92bklvEZVTaUlB6HLy5i/oKEdUmw08nPy7EK6MM56sE+FNolQZTJ/brHRM2JPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834830; c=relaxed/simple;
	bh=mqgE7SL/Jeft4M3I22xP2/ls1oy79EICfoclKw6lKEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O4DZLR1bcj28BqnQI+QY7/+kKWYNeyE/XAliSU0cSfDdU0j8bE3u68k+u3Sq9exD3iuMYnlbRDbQzupGN3SabymnqDoehtPCqWug7b0CBp0640Ynxt6MZOc30FSmntobCcYU+RwBSIaO7B6Ae+E32ADPZaBwfEK4JuGLLpfNzVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo1sjpAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93960C116B1;
	Mon,  1 Jul 2024 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719834830;
	bh=mqgE7SL/Jeft4M3I22xP2/ls1oy79EICfoclKw6lKEM=;
	h=From:To:Cc:Subject:Date:From;
	b=Qo1sjpAzpPsBHVNkE+9ffujZLONFYMwQW1MvvvocMZNdVi7Q9wL1ffQIuO53g4h1l
	 wcZx2uloVo7jXjgwUaDvN3ro8xttDaLvwn6h2HCy4hFOUL6QN2wM558l7Cyws44+E9
	 Yq+dYhZT+QkwB5aVox8QdLR7q+VYKiyyq2pM1bQeu6v9eyTXzFLLT7hnzx/Qbc41iq
	 TH8r1IXzcq8wdjWLsasgBjUTR69ZeI3MZSyvBVLoRvg0Ni4kNg4qoApt592F2iyQNh
	 Yfy2fIaqStQ57RaXizzyd2uXSUE2k0te4xMtw6ehYAALTmhUunKaW5I5DJ5H88rG9k
	 eZdCEUBjPzr0Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon,  1 Jul 2024 13:53:22 +0200
Message-ID: <20240701-vfs-fixes-7af8db39cee3@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3258; i=brauner@kernel.org; h=from:subject:message-id; bh=mqgE7SL/Jeft4M3I22xP2/ls1oy79EICfoclKw6lKEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ1zdi9q2j5+mMPmHV3ZNv552W9W+OypeSoSPX1zy3Lz ZpVd33Y21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRmCuMDIuYvpTrK1WWX+py us24+tjxCH6eD5zSMhLm+upeCdbLahh+s6V57HoWb7Y6N7Y0xIz/SJ8I3/fyk7rJdtvLP5361dj LCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains fixes for this merge window:

Misc:
- Don't misleadingly warn during filesystem thaw operations. It's possible that
  a block device which was frozen before it was mounted can cause a failing
  thaw operation if someone concurrently tried to mount it while that thaw
  operation was issued and the device had already been temporarily claimed for
  the mount (The mount will of course be aborted because the device is frozen).

netfs:
- Fix io_uring based write-through. Make sure that the total request length is
  correctly set.
- Fix partial writes to folio tail.
- Remove some xarray helpers that were intended for bounce buffers which got
  defered to a later patch series.
- Make netfs_page_mkwrite() whether folio->mapping is vallid after acquiring
  the folio lock.
- Make netfs_page_mkrite() flush conflicting data instead of waiting.

fsnotify:
- Ensure that fsnotify creation events are generated before fsnotify open
  events when a file is created via ->atomic_open(). The ordering was broken
  before.
- Ensure that no fsnotify events are generated for O_PATH file descriptors.
  While no fsnotify open events were generated, fsnotify close events were.
  Make it consistent and don't produce any.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

All patches are based on v6.10-rc3. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc7.fixes

for you to fetch changes up to 9d66154f73b7c7007c3be1113dfb50b99b791f8f:

  netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait (2024-06-26 14:19:08 +0200)

Please consider pulling these changes from the signed vfs-6.10-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10-rc7.fixes

----------------------------------------------------------------
Christian Brauner (1):
      fs: don't misleadingly warn during thaw operations

David Howells (5):
      netfs: Fix io_uring based write-through
      netfs: Fix early issue of write op on partial write to folio tail
      netfs: Delete some xarray-wangling functions that aren't used
      netfs: Fix netfs_page_mkwrite() to check folio->mapping is valid
      netfs: Fix netfs_page_mkwrite() to flush conflicting data, not wait

Jan Kara (1):
      fsnotify: Do not generate events for O_PATH file descriptors

NeilBrown (1):
      vfs: generate FS_CREATE before FS_OPEN when ->atomic_open used.

 fs/namei.c                | 10 ++++--
 fs/netfs/buffered_write.c | 12 +++++--
 fs/netfs/direct_write.c   |  3 +-
 fs/netfs/internal.h       |  9 ------
 fs/netfs/misc.c           | 81 -----------------------------------------------
 fs/netfs/write_issue.c    |  2 +-
 fs/open.c                 | 22 +++++++++----
 fs/super.c                | 11 ++++++-
 include/linux/fsnotify.h  |  8 ++++-
 9 files changed, 52 insertions(+), 106 deletions(-)

