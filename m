Return-Path: <linux-fsdevel+bounces-38874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19684A094CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 16:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246C816A316
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 15:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606B0210F7A;
	Fri, 10 Jan 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5LS60Jm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79720551E;
	Fri, 10 Jan 2025 15:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736522206; cv=none; b=rq1DOiuSDtGR6rDPvBAHkhaChVu7aoIse3cH8XO601qBN+kZqegEhC00nWKzd+T9+oTUssS+WdqBQN8QnWkKKUH63zucfotX96QmQJ4sYAicT04Ezvptgqoxt5J3Ews33NTjsKpNq0WRzY7otcGwfD7Pv5YTqvGFEcl5/sNW89U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736522206; c=relaxed/simple;
	bh=zwZaVYEZHnH1fxogahQs/QeM0BNA8Mk5Lj+7KbRSBm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JD0F4qNvfOZPRmmsf6huCzX8TyPdHdQyOm+e+VPyhQrnm2fOjg1WkVxdm3aVKM9RBJmw2VcfbN+tJS3vJin0XsAs1v6jZP+UnEn25T9HBeOCSPrifpfvtn/g8tytB+WBX2hoDkWVYIqAPAEMRHQgb2Zn/PBHzHsuOdv7uEvz83o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5LS60Jm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C57BC4CED6;
	Fri, 10 Jan 2025 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736522206;
	bh=zwZaVYEZHnH1fxogahQs/QeM0BNA8Mk5Lj+7KbRSBm8=;
	h=From:To:Cc:Subject:Date:From;
	b=B5LS60JmoZ+oJywH6V7X70d+V1WhD1EWD2wRb2Fk9DD682lnoo/3/xktJ8m76YzUy
	 H+cYtF1UvOSlLsI36+pb7DJjnAKU9lE2vvPuxj6nuWbOMpC917PpgPctr8XJrn/WNb
	 sQ5ljqNc12or/ghgbqeNOp9ZBlvX/7ZkElpu6UdFi+8JF1X+vZerTudlriA3BB56LB
	 Q4jDhF2cIidUad5DAXLNB4INc/8z2U1ZR5F0gW6JjWFab4c8TtnrPbsHcagH6Whz+u
	 RJ/gYdV7TZrKMPfHxRmI9vJm8i5WHRlGjH2MB6LuZq5E1Xn3BT0lQ+3nuTPdZDScLc
	 DxiaDUXcUepDw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 10 Jan 2025 16:16:12 +0100
Message-ID: <20250110-vfs-fixes-f2d851a32684@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3792; i=brauner@kernel.org; h=from:subject:message-id; bh=zwZaVYEZHnH1fxogahQs/QeM0BNA8Mk5Lj+7KbRSBm8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ3Wp49qMzVvIWJ9075XBfX7EPha3SOMKtKs/Foqyrdf haYeCyxo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIP7BkZNgdOeZK3mcHkglcR 27raSdqiK1wrtNzjHnSv8hHfczN9C8P/xIeZ7DaVh77ufGUWvrSrUOfF9Ddp17fpOV27/Xw/++F vjAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The following fixes are contained in this pull request:

afs:

- Fix the maximum cell name length.

- Fix merge preference rule failure condition.

fuse:

- Fix fuse_get_user_pages() so it doesn't risk misleading the caller to
  think pages have been allocated when they actually haven't.

- Fix direct-io folio offset and length calculation.

netfs:

- Fix async direct-io handling.

- Fix read-retry for filesystems that don't provide a ->prepare_read()
  method.

vfs:

- Prevent truncating 64-bit offsets to 32-bits in iomap.

- Fix memory barrier interactions when polling.

- Remove MNT_ONRB to fix concurrent modification of @mnt->mnt_flags
  leading to MNT_ONRB to not be raised and invalid access to a list
  member. See commit message for details.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit fbfd64d25c7af3b8695201ebc85efe90be28c5a3:

  Merge tag 'vfs-6.13-rc7.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2025-01-06 10:26:39 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc7.fixes.2

for you to fetch changes up to 1623bc27a85a93e82194c8d077eccc464efa67db:

  Merge branch 'vfs-6.14.poll' into vfs.fixes (2025-01-10 12:01:21 +0100)

Please consider pulling these changes from the signed vfs-6.13-rc7.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13-rc7.fixes.2

----------------------------------------------------------------
Bernd Schubert (1):
      fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation failure

Christian Brauner (5):
      Merge tag 'fuse-fixes-6.13-rc7' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse
      fs: kill MNT_ONRB
      Merge tag 'vfs-6.14-rc7.mount.fixes'
      Merge patch series "poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()"
      Merge branch 'vfs-6.14.poll' into vfs.fixes

David Howells (3):
      afs: Fix the maximum cell name length
      netfs: Fix kernel async DIO
      netfs: Fix read-retry for fs with no ->prepare_read()

Joanne Koong (1):
      fuse: fix direct io folio offset and length calculation

Lizhi Xu (1):
      afs: Fix merge preference rule failure condition

Marco Nelissen (1):
      iomap: avoid avoid truncating 64-bit offset to 32 bits

Oleg Nesterov (5):
      poll_wait: add mb() to fix theoretical race between waitqueue_active() and .poll()
      poll_wait: kill the obsolete wait_address check
      io_uring_poll: kill the no longer necessary barrier after poll_wait()
      sock_poll_wait: kill the no longer necessary barrier after poll_wait()
      poll: kill poll_does_not_wait()

 fs/afs/addr_prefs.c     |  6 ++++--
 fs/afs/afs.h            |  2 +-
 fs/afs/afs_vl.h         |  1 +
 fs/afs/vl_alias.c       |  8 ++++++--
 fs/afs/vlclient.c       |  2 +-
 fs/fuse/file.c          | 31 +++++++++++++++++++------------
 fs/iomap/buffered-io.c  |  2 +-
 fs/mount.h              | 15 +++++++++------
 fs/namespace.c          | 14 ++++++--------
 fs/netfs/direct_write.c |  7 ++++++-
 fs/netfs/read_retry.c   |  3 ++-
 include/linux/mount.h   |  3 +--
 include/linux/poll.h    | 26 ++++++++++++--------------
 include/net/sock.h      | 17 +++++++----------
 io_uring/io_uring.c     |  9 ++++-----
 15 files changed, 80 insertions(+), 66 deletions(-)

