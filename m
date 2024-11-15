Return-Path: <linux-fsdevel+bounces-34905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108E9CE0AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 14:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C9A728E44B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1383C1CD20F;
	Fri, 15 Nov 2024 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K5epvNOz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AF1BDAAE;
	Fri, 15 Nov 2024 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731678832; cv=none; b=NTbeGXl4jgbVlRQIuk3uzkxPeV82nU55Drs6cAoBeaSzm62N87ulSvTnHbFYsHMLdkVr/v8C2aW61PelNK6n8T1Xp8k96AL/RLW8SOzkS7R/zC3CTnMezkk3yV/EnkBbfhmONMTzGXec68er6cP12PcXoW/aADRbi+JLbZqpdhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731678832; c=relaxed/simple;
	bh=8YSDgCYXzA6K2eERni91kOdPgiXbvcIrSHhP1QsHqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZ9bL+W42/riB3Evfo3c1c+LsT9/k4IoCcbgScPu7CT4dRMZwAryD/yVviO/thjcIi1AHhaHnVoaXXJr+Bg/UHIUbnJbMBlfR9sRGKmkQVKTKDBrt1R5aSvLAClfQhuTb5Kusn/KYV0DQy7wRxPVz0sEcbOrRDqSEVjls0SIs2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K5epvNOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF42EC4CED2;
	Fri, 15 Nov 2024 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731678832;
	bh=8YSDgCYXzA6K2eERni91kOdPgiXbvcIrSHhP1QsHqXc=;
	h=From:To:Cc:Subject:Date:From;
	b=K5epvNOzo3ynrhRDfcqQr1jFdjVOyJ67Ae/qn1yoiEbYwWYzB2cilPy4gDYK4C53z
	 KBvhF7xvYHBmU4fKb/jC0WiHQYfo+jhJmiE8kYJZeolf+Db92zLW+OFHmTiWHCA7RT
	 RxhXG9wJ8UvCSPpuo/lb0aqer4iuSWURXlFctM/8fPdhEcG2aRRzdLqpf3q53J2WxU
	 FwLJm4nBCU2ypvJLrbvBwLC32y5nLotq9/mbpxxTOvAIEy+Axk0R638bkmbhTTLzyw
	 YYqDVT4b/iJULkQ6/cRwRaYBGJ+gcniyvhWZU89DyF4IG3MhwVlCuyhRc4r6/pnuRt
	 He5IxsLsH5M9w==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs multigrain timestamps
Date: Fri, 15 Nov 2024 14:49:52 +0100
Message-ID: <20241115-vfs-mgtime-1dd54cc6d322@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8208; i=brauner@kernel.org; h=from:subject:message-id; bh=8YSDgCYXzA6K2eERni91kOdPgiXbvcIrSHhP1QsHqXc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSbB7a8+5E94/XFhQ0ss1Zzl0ytOzQz8EnDnpPXo5YpX X6+9+AioY5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJHA1hZFiYXvZpqmXt6neM T222RKkHvHzd8uPXociio/+qtV8s9xNi+MMvkjTPX/3SDffPn9fcfv5jyYXK6g9btaYc+rvZx0r 2ixAXAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This is another try at implementing multigrain timestamps. This time
with significant help from the timekeeping maintainers to reduce the
performance impact.

Thomas provided a base branch that contains the required timekeeping
interfaces for the VFS. It serves as the base for the multi-grain
timestamp work:

- Multigrain timestamps allow the kernel to use fine-grained timestamps
  when an inode's attributes is being actively observed via ->getattr().
  With this support, it's possible for a file to get a fine-grained
  timestamp, and another modified after it to get a coarse-grained stamp
  that is earlier than the fine-grained time. If this happens then the
  files can appear to have been modified in reverse order, which breaks
  VFS ordering guarantees.

  To prevent this, a floor value is maintained for multigrain
  timestamps. Whenever a fine-grained timestamp is handed out, record
  it, and when later coarse-grained stamps are handed out, ensure they
  are not earlier than that value. If the coarse-grained timestamp is
  earlier than the fine-grained floor, return the floor value instead.

  The timekeeper changes add a static singleton atomic64_t into
  timekeeper.c that is used to keep track of the latest fine-grained
  time ever handed out. This is tracked as a monotonic ktime_t value to
  ensure that it isn't affected by clock jumps. Because it is updated at
  different times than the rest of the timekeeper object, the floor
  value is managed independently of the timekeeper via a cmpxchg()
  operation, and sits on its own cacheline.

  Tow new public timekeeper interfaces are added:

  (1) ktime_get_coarse_real_ts64_mg() fills a timespec64 with the later
      of the coarse-grained clock and the floor time

  (2) ktime_get_real_ts64_mg() gets the fine-grained clock value, and
      tries to swap it into the floor. A timespec64 is filled with the
      result.

- The VFS has always used coarse-grained timestamps when updating the
  ctime and mtime after a change. This has the benefit of allowing
  filesystems to optimize away a lot metadata updates, down to around 1
  per jiffy, even when a file is under heavy writes.

  Unfortunately, this has always been an issue when we're exporting via
  NFSv3, which relies on timestamps to validate caches. A lot of changes
  can happen in a jiffy, so timestamps aren't sufficient to help the
  client decide when to invalidate the cache. Even with NFSv4, a lot of
  exported filesystems don't properly support a change attribute and are
  subject to the same problems with timestamp granularity. Other
  applications have similar issues with timestamps (e.g backup
  applications).

  If we were to always use fine-grained timestamps, that would improve
  the situation, but that becomes rather expensive, as the underlying
  filesystem would have to log a lot more metadata updates.

  This adds a way to only use fine-grained timestamps when they are
  being actively queried. Use the (unused) top bit in
  inode->i_ctime_nsec as a flag that indicates whether the current
  timestamps have been queried via stat() or the like. When it's set, we
  allow the kernel to use a fine-grained timestamp iff it's necessary to
  make the ctime show a different value.

  This solves the problem of being able to distinguish the timestamp
  between updates, but introduces a new problem: it's now possible for a
  file being changed to get a fine-grained timestamp. A file that is
  altered just a bit later can then get a coarse-grained one that
  appears older than the earlier fine-grained time. This violates
  timestamp ordering guarantees.

  This is where the earlier mentioned timkeeping interfaces help. A
  global monotonic atomic64_t value is kept that acts as a timestamp
  floor. When we go to stamp a file, we first get the latter of the
  current floor value and the current coarse-grained time. If the inode
  ctime hasn't been queried then we just attempt to stamp it with that
  value.

  If it has been queried, then first see whether the current coarse time
  is later than the existing ctime. If it is, then we accept that value.
  If it isn't, then we get a fine-grained time and try to swap that into
  the global floor. Whether that succeeds or fails, we take the
  resulting floor time, convert it to realtime and try to swap that into
  the ctime.

  We take the result of the ctime swap whether it succeeds or fails,
  since either is just as valid.

  Filesystems can opt into this by setting the FS_MGTIME fstype flag.
  Others should be unaffected (other than being subject to the same
  floor value as multigrain filesystems).

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches are based on v6.12-rc2 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

(1) linux-next: manual merge of the vfs-brauner tree with the btrfs tree
    https://lore.kernel.org/r/20241016085129.3954241d@canb.auug.org.au

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13.mgtime

for you to fetch changes up to 9fed2c0f2f0771b990d068ef0a2b32e770ae6d48:

  fs: reduce pointer chasing in is_mgtime() test (2024-11-14 10:45:53 +0100)

Please consider pulling these changes from the signed vfs-6.13.mgtime tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13.mgtime

----------------------------------------------------------------
Christian Brauner (2):
      Merge tag 'timers-core-for-vfs' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip into vfs.mgtime
      Merge patch series "timekeeping/fs: multigrain timestamp redux"

Jeff Layton (13):
      fs: add infrastructure for multigrain timestamps
      fs: have setattr_copy handle multigrain timestamps appropriately
      timekeeping: Add interfaces for handling timestamps with a floor value
      timekeeping: Add percpu counter for tracking floor swap events
      fs: handle delegated timestamps in setattr_copy_mgtime
      fs: tracepoints around multigrain timestamp events
      fs: add percpu counters for significant multigrain timestamp events
      Documentation: add a new file documenting multigrain timestamps
      xfs: switch to multigrain timestamps
      ext4: switch to multigrain timestamps
      btrfs: convert to multigrain timestamps
      tmpfs: add support for multigrain timestamps
      fs: reduce pointer chasing in is_mgtime() test

 Documentation/filesystems/index.rst         |   1 +
 Documentation/filesystems/multigrain-ts.rst | 125 ++++++++++++
 fs/attr.c                                   |  61 +++++-
 fs/btrfs/file.c                             |  25 +--
 fs/btrfs/super.c                            |   3 +-
 fs/ext4/super.c                             |   2 +-
 fs/inode.c                                  | 284 +++++++++++++++++++++++++---
 fs/stat.c                                   |  46 ++++-
 fs/xfs/libxfs/xfs_trans_inode.c             |   6 +-
 fs/xfs/xfs_iops.c                           |  10 +-
 fs/xfs/xfs_super.c                          |   2 +-
 include/linux/fs.h                          |  37 +++-
 include/linux/timekeeping.h                 |   5 +
 include/trace/events/timestamp.h            | 124 ++++++++++++
 kernel/time/timekeeping.c                   | 105 ++++++++++
 kernel/time/timekeeping_debug.c             |  13 ++
 kernel/time/timekeeping_internal.h          |  15 ++
 mm/shmem.c                                  |   2 +-
 18 files changed, 793 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/filesystems/multigrain-ts.rst
 create mode 100644 include/trace/events/timestamp.h

