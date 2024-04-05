Return-Path: <linux-fsdevel+bounces-16178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88095899BD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208291F23858
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8598616C691;
	Fri,  5 Apr 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyBJA0fh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3D16132B;
	Fri,  5 Apr 2024 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712316205; cv=none; b=lx1W0/mJVZi7tw9Q6vJLj31dfoK2fE7Nq/QcJBgauWMQ6Ekf7GwWNSF9FDBxPuJJZQQjrrhCeKdISkVPNftwskkZDIAFt3NptQaUjo76zjEiYErr2/ersf4kHf2gO0s1GvmgRSJGMr7TmTS238f4Q5g7NjqNKefgnpv9k3JfBio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712316205; c=relaxed/simple;
	bh=8jmFCfcAxxgCnDgB/AyUUYHnD8n+q6i6mhP2+L/Xzx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=en9fLvCjQh7DqL7vamJbdQtr1qN7YiLJTI1yqrem/FRBrG1/K6fVi9Id0QwW3k81L2y929XawbszBg6KKh38BZRcAzB4HsfHmG34QIBEphT3raiLngqp9eOSWg/9/jjzytHvQAkfyP6tzuJl7aZhPqIapLYUUmpEKeQzE37mRH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyBJA0fh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F20C433C7;
	Fri,  5 Apr 2024 11:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712316204;
	bh=8jmFCfcAxxgCnDgB/AyUUYHnD8n+q6i6mhP2+L/Xzx4=;
	h=From:To:Cc:Subject:Date:From;
	b=kyBJA0fhcHsZdD8nqwa0Gr1aJ5MAqPiS25/Ug8KxCe3rk95OOG9SL+m5h3c3Epq/0
	 tcXn7BDcxCw+dNebwGHRQwUe0psO6B4RJkfMvqEza/nTgFlrSN8bZVKyfBN/YEowxI
	 9aIQPpCOffMdvE6x6PFlDFbsLWIoAYE0AMA08v8Jw1UmIsNgGQFWmI1gCelOAVD8Q7
	 PVmWeRyvJRue/DPoLhLV2JT1VdAEbNLltrqnP+yj/640psRg2In1nPpzLkQXvDjZ1T
	 rS479xp4p4U7jjjT+SISL7TL5jr0OPJujAUgT63P6bE/PFk9793C2xrUGcVhvP7m/1
	 BKqzgWBXrLcaQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri,  5 Apr 2024 13:22:56 +0200
Message-ID: <20240405-vfs-fixes-3b957d5fde0f@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3551; i=brauner@kernel.org; h=from:subject:message-id; bh=8jmFCfcAxxgCnDgB/AyUUYHnD8n+q6i6mhP2+L/Xzx4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTx3xdwNJS3mmHIzGozc47nB/94l5Sl8f0ThZrnTdBcP WXVy4StHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM52s/IcOEKw2yPJ5KyfL/j vrVUWvVdL9KQtGVxDuu2ura44X7YPIb/Tj9bmZ8KBtdWzDS9qPXBXflitUkqo7r9QSm2fpPgis8 8AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few small fixes. This comes with some delay because I
wanted to wait on people running their reproducers and the Easter
Holidays meant that those replies came in a little later than usual:

* Fix handling of preventing writes to mounted block devices.

  Since last kernel we allow to prevent writing to mounted block devices
  provided CONFIG_BLK_DEV_WRITE_MOUNTED isn't set and the block device
  is opened with restricted writes. When we switched to opening block
  devices as files we altered the mechanism by which we recognize when a
  block device has been opened with write restrictions. The detection
  logic assumed that only read-write mounted filesystems would apply
  write restrictions to their block devices from other openers. That of
  course is not true since it also makes sense to apply write
  restrictions for filesystems that are read-only.

  Fix the detection logic using an FMODE_* bit. We still have a few left
  since we freed up a couple a while ago. I also picked up a patch to
  free up four additional FMODE_* bits scheduled for the next merge window.

* Fix counting the number of writers to a block device. This just
  changes the logic to be consistent.

* Fix a bug in aio causing a NULL pointer derefernce after we
  implemented batched processing in aio.

* Finally, add the changes we discussed that allows to yield block
  devices early even though file closing itself is deferred. This also
  allows us to remove two holder operations to get and release the
  holder to align lifetime of file and holder of the block device.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.9-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc3.fixes

for you to fetch changes up to caeb4b0a11b3393e43f7fa8e0a5a18462acc66bd:

  aio: Fix null ptr deref in aio_complete() wakeup (2024-04-05 11:20:28 +0200)

Please consider pulling these changes from the signed vfs-6.9-rc3.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9-rc3.fixes

----------------------------------------------------------------
Christian Brauner (3):
      block: handle BLK_OPEN_RESTRICT_WRITES correctly
      block: count BLK_OPEN_RESTRICT_WRITES openers
      fs,block: yield devices early

Kent Overstreet (1):
      aio: Fix null ptr deref in aio_complete() wakeup

 block/bdev.c                    | 84 ++++++++++++++++++++++++++++++++---------
 drivers/mtd/devices/block2mtd.c |  2 +-
 fs/aio.c                        |  2 +-
 fs/bcachefs/super-io.c          |  2 +-
 fs/cramfs/inode.c               |  2 +-
 fs/ext4/super.c                 |  8 ++--
 fs/f2fs/super.c                 |  2 +-
 fs/jfs/jfs_logmgr.c             |  4 +-
 fs/reiserfs/journal.c           |  2 +-
 fs/romfs/super.c                |  2 +-
 fs/super.c                      | 24 ++----------
 fs/xfs/xfs_buf.c                |  2 +-
 fs/xfs/xfs_super.c              |  6 +--
 include/linux/blkdev.h          | 11 +-----
 include/linux/fs.h              |  2 +
 15 files changed, 89 insertions(+), 66 deletions(-)

