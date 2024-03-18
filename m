Return-Path: <linux-fsdevel+bounces-14738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4C87E938
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 13:20:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 465BC282A6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7283381C1;
	Mon, 18 Mar 2024 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KpK9Smku"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2347A3771C;
	Mon, 18 Mar 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710764411; cv=none; b=JrwopN3YLxxWvHOVNIeXwtX7afEHy95qAQiLsIj1vybuF/4LXowUgeq0yD68y9IFeomfL0pH9Jbu2+BArvB5oSXK0KbHiIPGEiR0uGjxD5b6ZKzBJVKsyaEcQs6bqZikYdEHF78gnnXsXTcZdl0i2dTtE8tAq2kmGra2ftf2ZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710764411; c=relaxed/simple;
	bh=B5o2vdQkYKf0gLGLbgOOM3rM1ASv07qeSLQyl+ljBY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HnslGtnS/kNMnaVTCrwqJT2Wg9KoF7JJ7KIqHWS6MaFHGvCScxa1Di7lcA6y8PVpot82WlfFsCrpGhHgLs8DRNZEj+ACepM9jYfBmNK5yuqI4mryMT/1yKOZRRl1PqdlG1qvf9Jkiizdm9md17q2aQneioAMBMQ7W/LP9ZYN/QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KpK9Smku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1DCC433F1;
	Mon, 18 Mar 2024 12:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710764410;
	bh=B5o2vdQkYKf0gLGLbgOOM3rM1ASv07qeSLQyl+ljBY4=;
	h=From:To:Cc:Subject:Date:From;
	b=KpK9SmkuD1eVJP6NUtXLtYZKpHB1QJF+TESlpo/fn7T8KeZKzmH9bG800/QCKkcXW
	 fQEW/Aq78dySwA4HmZRFqAESyJQYSnALY5axve5g5jYi219pOgBaHuz7hgzAC8i8eQ
	 XxqYvQVr6WqyMr4Uvk66sCC/A9Fr6CyVCYjflWbfhBdm3SHZwUtHJQHvzfK8AOX/Tn
	 iu6wbWgnFiunJblwGAdDkpqt87AUV5eeIY4Y0uAfJgORiT9El8MGlD7gHlEGcQfUMM
	 H7gc5/J7hx2rrOS7Wq334jxkWmT6sIrQpGClZ9hVWKmDjYEBJ0OkKl8/hf2fRyNAz1
	 XK2cOdLBlyicA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 18 Mar 2024 13:19:54 +0100
Message-ID: <20240318-vfs-fixes-e0e7e114b1d1@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2338; i=brauner@kernel.org; h=from:subject:message-id; bh=B5o2vdQkYKf0gLGLbgOOM3rM1ASv07qeSLQyl+ljBY4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT+MCzsj9YMPrl72hP2Vz+3FU5cI9i9fV2blaHHk19Bx 3+p9K1N6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI0ClGhjcLWJKnvp2kdPWH 2MTSh+9vbZ2zym52q9l/ZqdJDJM57tczMtzbbPdSXP5Qq/GpGp6CqBSh6ND9r3/1GhRcCth9+aD PUQ4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains a few small fixes for this merge window:

* Undo the hiding of silly-rename files in afs. If they're hidden they
  can't be deleted by rm manually anymore causing regressions.
* Avoid caching the preferred address for an afs server to avoid
  accidently overriding an explicitly specified preferred server address.
* Fix bad stat() and rmdir() interaction in afs.
* Take a passive reference on the superblock when opening a block device
  so the holder is available to concurrent callers from the block layer.
* Clear private data pointer in fscache_begin_operation() to avoid it
  being falsely treated as valid.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on mainline and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 480e035fc4c714fb5536e64ab9db04fedc89e910:

  Merge tag 'drm-next-2024-03-13' of https://gitlab.freedesktop.org/drm/kernel (2024-03-13 18:34:05 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9-rc1.fixes

for you to fetch changes up to 449ac5514631dd9b9b66dd708dd5beb1428e2812:

  fscache: Fix error handling in fscache_begin_operation() (2024-03-18 10:33:48 +0100)

Please consider pulling these changes from the signed vfs-6.9-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9-rc1.fixes

----------------------------------------------------------------
Christian Brauner (1):
      fs,block: get holder during claim

David Howells (4):
      afs: Revert "afs: Hide silly-rename files from userspace"
      afs: Don't cache preferred address
      afs: Fix occasional rmdir-then-VNOVNODE with generic/011
      fscache: Fix error handling in fscache_begin_operation()

 block/bdev.c           |  7 +++++++
 fs/afs/dir.c           | 10 ----------
 fs/afs/rotate.c        | 21 ++++-----------------
 fs/afs/validation.c    | 16 +++++++++-------
 fs/netfs/fscache_io.c  |  4 +++-
 fs/super.c             | 18 ++++++++++++++++++
 include/linux/blkdev.h | 10 ++++++++++
 7 files changed, 51 insertions(+), 35 deletions(-)

