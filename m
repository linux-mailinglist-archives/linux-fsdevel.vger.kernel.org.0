Return-Path: <linux-fsdevel+bounces-34917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59779CE0F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 15:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BDF0284BC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE801CEAD5;
	Fri, 15 Nov 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpGlFiuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B441CDA01;
	Fri, 15 Nov 2024 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679769; cv=none; b=dXQA/dUULkdiXRqxsLJcUJiPJs0jvmgFqY5KBiCPNgxOvvekNFerHvtVdy6WsOlTCFhDNbOopS5MdMmwKF48rK5ewkys47LCBWnJl08iIlgMyEe1kLOxzR3RGVgp0dx+Dv1wgKih6J1SNKMEVgEcScmVGCbLER3uBeSVQ7gVBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679769; c=relaxed/simple;
	bh=W6BOkKkAOh5aQ4X0OZSjyp8Bmd0wWiBq7TuVyPyaoOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ptyv+QcZVOhcxk8VC1uP6ob1mG4sVODmFSE43MH3QO6A5MXLQFgeQtbZRKQS0QgrWBhMug+fEH65V74qXrILVw/dussIk0XsWEmI/RHzGNiZjnSHoY4Yf/ET/iiBW1WzY79w+JwKRmHUoop0sBXF1v578cditKD/ZeQY9F8acns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpGlFiuu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6722FC4CECF;
	Fri, 15 Nov 2024 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679768;
	bh=W6BOkKkAOh5aQ4X0OZSjyp8Bmd0wWiBq7TuVyPyaoOQ=;
	h=From:To:Cc:Subject:Date:From;
	b=mpGlFiuuap959G0nKtJ/0PzGQZxXOdntvs+OaaqHz7DZSEUkJnzJCBK0M0Jcp2CuF
	 GuRUQaFZl/ZFYLdgNCn9vRj7mPQzht7SAyLeSIeJdJE7FctbjAUzW/GxNdD7+hHHG5
	 gtIglqEKZwwnqJ+jTdKaVBuxe2fv2cPgrIZiO8SNxUPyY1UqPC5SYkmP+MJHuaV6C3
	 wZLxAkeCZ51WpDwaLC1PNpDWojXkFQGi9dGIqCbY8/pVoTMgiw+0eQcvpJWdGTD5qc
	 1Z7mojh2UM7ZEqBiL0EX2M5jbpBbVn8pHNAyEs9hBajMe+B+RDakyT41cO/cMhKAa8
	 KC/a6jIFWHC5w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs untorn writes
Date: Fri, 15 Nov 2024 15:09:21 +0100
Message-ID: <20241115-vfs-untorn-writes-7229611aeacc@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3978; i=brauner@kernel.org; h=from:subject:message-id; bh=W6BOkKkAOh5aQ4X0OZSjyp8Bmd0wWiBq7TuVyPyaoOQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbhwlVrpHm0p/eEn8/5E303Wv6k947XhA8cDf6+a9nH 3duL9n9oKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAilkUM/yzuhkQcnhDm6mPp kB7w2vJN7ZzPK49U/RfL7b0ieEG0Sp6RoUnxeLe1+5XH0kfkHj98sbao4W6B6v55uWdvvsjk3G7 EygYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

An atomic write is a write issed with torn-write protection. This means
for a power failure or any hardware failure all or none of the data from
the write will be stored, never a mix of old and new data.

This work is already supported for block devices. If a block device is
opened with O_DIRECT and the block device supports atomic write, then
FMODE_CAN_ATOMIC_WRITE is added to the file of the opened block device.

This pull request contains the work to expand atomic write support to
filesystems, specifically ext4 and XFS. Currently, only support for
writing exactly one filesystem block atomically is added.

Since it's now possible to have filesystem block size > page size for
XFS, it's possible to write 4K+ blocks atomically on x86.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 9852d85ec9d492ebef56dc5f229416c925758edc:

  Linux 6.12-rc1 (2024-09-29 15:06:19 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.untorn.writes

for you to fetch changes up to 54079430c5dbf041363ab39a0c254cd9e4f6aed5:

  iomap: drop an obsolete comment in iomap_dio_bio_iter (2024-11-11 14:35:06 +0100)

Please consider pulling these changes from the signed vfs-6.13.untorn.writes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.untorn.writes

----------------------------------------------------------------
Christian Brauner (1):
      Merge tag 'fs-atomic_2024-11-05' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux into vfs.untorn.writes

Christoph Hellwig (1):
      iomap: drop an obsolete comment in iomap_dio_bio_iter

John Garry (8):
      block/fs: Pass an iocb to generic_atomic_write_valid()
      fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
      block: Add bdev atomic write limits helpers
      fs: Export generic_atomic_write_valid()
      fs: iomap: Atomic write support
      xfs: Support atomic write for statx
      xfs: Validate atomic writes
      xfs: Support setting FMODE_CAN_ATOMIC_WRITE

Ritesh Harjani (IBM) (4):
      ext4: Add statx support for atomic writes
      ext4: Check for atomic writes support in write iter
      ext4: Support setting FMODE_CAN_ATOMIC_WRITE
      ext4: Do not fallback to buffered-io for DIO atomic write

 Documentation/filesystems/iomap/operations.rst | 15 +++++++++
 block/fops.c                                   | 22 +++++++------
 fs/ext4/ext4.h                                 | 10 ++++++
 fs/ext4/file.c                                 | 24 ++++++++++++++
 fs/ext4/inode.c                                | 39 ++++++++++++++++++++---
 fs/ext4/super.c                                | 31 +++++++++++++++++++
 fs/iomap/direct-io.c                           | 43 ++++++++++++++++++++------
 fs/iomap/trace.h                               |  3 +-
 fs/read_write.c                                | 16 ++++++----
 fs/xfs/xfs_buf.c                               |  7 +++++
 fs/xfs/xfs_buf.h                               |  4 +++
 fs/xfs/xfs_file.c                              | 16 ++++++++++
 fs/xfs/xfs_inode.h                             | 15 +++++++++
 fs/xfs/xfs_iops.c                              | 22 +++++++++++++
 include/linux/blkdev.h                         | 16 ++++++++++
 include/linux/fs.h                             |  2 +-
 include/linux/iomap.h                          |  1 +
 17 files changed, 254 insertions(+), 32 deletions(-)

