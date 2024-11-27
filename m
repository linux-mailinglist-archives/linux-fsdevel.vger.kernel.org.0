Return-Path: <linux-fsdevel+bounces-36019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9597C9DAAE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4E29164964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E020010E;
	Wed, 27 Nov 2024 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOGo769g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48420328B6;
	Wed, 27 Nov 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722079; cv=none; b=c9cIYrkBiROqViO2SGKzHLizF9Mwc6bGkctNYpwBPCU7A5bt9I+wHWlnmjcCZURkF0DHEtA+iWNiDP1xqRoiKHPX9jG6MW1WYtWHEX32F2YSZTYCk8KqXVHeKm7l4cV3n1nxkg7u6XlBDuFc0Ky5nVYg7QpXzsoBSE6olY9up/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722079; c=relaxed/simple;
	bh=yplFH8W7Y+J109iyuIuu/LadReT3tZ4Zb8K7yt+vvf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUAI6D7TfZWTiebUZ3ij2EtxKosZjKUcACsxc7bBecZcr8ijjwOeUFocUMVMTk/y8XaXhpOEVGKcOgovlc3Gg8o2kMqg28fQI+rjmrpoHnobtj5UYhpEzWgdY3oOgtWemeGXjOAksIx+3/9gGEs56MqSaxrAU26tv49Qxgl9fH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOGo769g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5ADC4CECC;
	Wed, 27 Nov 2024 15:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732722078;
	bh=yplFH8W7Y+J109iyuIuu/LadReT3tZ4Zb8K7yt+vvf4=;
	h=From:To:Cc:Subject:Date:From;
	b=IOGo769gRF6NaThfG/aRem8w6lMd6q3TVKX7KTAre+QIMv8oQIu7CFwTN/RGYB/p8
	 BcfVMajnUjipgemFOEfrlQozVn8n2oHVUezC3xXJLcoLbzplrJYS6DO1GgkTt9oSk5
	 YY+0kUx2brcTjWciQNZizNxvhFcpX22laSewEW2bRmPISm1OPb0hC7HDppTuUgnnyg
	 m3bNRA6iBbr1cE1RLOwjSa3gjq6rqpF3rYXR0PMcKaH7u9yoTb7P9JeMazcL4xioHx
	 wwwAxg/f2dGlQWyuErlr3KIXNKoj5QqJQZj/z6PhoFKZKuTD+mGJQbbdoS4vIA5Ews
	 mBVd8jVCmU74A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed, 27 Nov 2024 16:41:03 +0100
Message-ID: <20241127-vfs-fixes-08465cd270d3@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3804; i=brauner@kernel.org; h=from:subject:message-id; bh=yplFH8W7Y+J109iyuIuu/LadReT3tZ4Zb8K7yt+vvf4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS720649Haj5NJ7K4IuCnFJ3mjnt8k9w+9a7/6Kw0GoS XUT1562jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIns+8fI0MCpYmU/q1VwRtyZ rFsGprs91A+dm5/frjTnhJpEqOEMJUaGrdMsVjHPmad9SOk913Qm7Z7e8yd/Lt85RS/x+puv7iK b2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

I was sent a bug fix for the backing file rework that relied on the
overlayfs pull request. The vfs.fixes branch used an earlier mainline
commit as base. So I thought how to resolve this and my solution was to
create a new ovl.fixes branch which contained the overlayfs changes for
v6.13 and then apply the fix on top of it. That branch was then merged
into vfs.fixes with an explanation why. Let me know if I should do this
differently next time.

/* Summary */

This contains various fixes for this cycle:

- Fix a few iomap bugs.

- Fix a wrong argument in backing file callback.

- Fix security mount option retrieval in statmount().

- Cleanup how statmount() handles unescaped options.

- Add a missing inode_owner_or_capable() check for setting write hints.

- Clear the return value in read_kcore_iter() after a successful
  iov_iter_zero().

- Fix a mount_setattr() selftest.

- Fix function signature in mount api documentation.

- Remove duplicate include header in the fscache code.

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

All patches have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit e7675238b9bf4db0b872d5dbcd53efa31914c98f:

  Merge tag 'ovl-update-6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs (2024-11-22 20:55:42 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.13-rc1.fixes

for you to fetch changes up to cf87766dd6f9ddcceaa8ee26e3cbd7538e42dd19:

  Merge branch 'ovl.fixes' (2024-11-26 18:15:06 +0100)

Please consider pulling these changes from the signed vfs-6.13-rc1.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.13-rc1.fixes

----------------------------------------------------------------
Amir Goldstein (1):
      fs/backing_file: fix wrong argument in callback

Brian Foster (4):
      iomap: warn on zero range of a post-eof folio
      iomap: reset per-iter state on non-error iter advances
      iomap: lift zeroed mapping handling into iomap_zero_range()
      iomap: elide flush from partial eof zero range

Christian Brauner (3):
      Merge patch series "iomap: zero range flush fixes"
      statmount: fix security option retrieval
      Merge branch 'ovl.fixes'

Christoph Hellwig (1):
      fs: require inode_owner_or_capable for F_SET_RW_HINT

Jiri Olsa (1):
      fs/proc/kcore.c: Clear ret value in read_kcore_iter after successful iov_iter_zero

Michael Ellerman (1):
      selftests/mount_setattr: Fix failures on 64K PAGE_SIZE kernels

Miklos Szeredi (1):
      statmount: clean up unescaped option handling

Randy Dunlap (1):
      fs_parser: update mount_api doc to match function signature

Thorsten Blum (1):
      fscache: Remove duplicate included header

 Documentation/filesystems/mount_api.rst            |  3 +-
 fs/backing-file.c                                  |  3 +-
 fs/fcntl.c                                         |  3 +
 fs/iomap/buffered-io.c                             | 90 +++++++++++-----------
 fs/iomap/iter.c                                    | 11 ++-
 fs/namespace.c                                     | 46 +++++------
 fs/netfs/fscache_io.c                              |  1 -
 fs/proc/kcore.c                                    |  1 +
 .../selftests/mount_setattr/mount_setattr_test.c   |  2 +-
 9 files changed, 81 insertions(+), 79 deletions(-)

