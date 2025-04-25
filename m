Return-Path: <linux-fsdevel+bounces-47418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799A6A9D416
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 23:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899DC1BC56C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 21:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27B224B04;
	Fri, 25 Apr 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg574WEH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9771221DBC;
	Fri, 25 Apr 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745616193; cv=none; b=MVtmWbrfc8y88WABEdtbUFOjfH5L4sOYvK1G33vwJ5FX38X3aZhoD6i/WXq6hqlpXUNkvZfBgvub+vCTN0PkAW3s9llKPM48RKRWfSnXmLcc6I0vke4jsXP3syvJ6jy3lkpXil3xfBlGswq1hGMTMu7DNTB0xEglzZk1pX7j2Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745616193; c=relaxed/simple;
	bh=6fjTmNSFrlTdsaBLXQ/GnLckkpWkOX+NxpTc0rHAaO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=skuHFEP66TcuHvWDKfedhBHccT1wxVvLvlbueqPFUXlTN7JsmsARGIj+iRm4U1yW2pEjrmRZMf/hTrs9Zk2b7Py01zFUjKoi/ZpxHepFnF/O05dfbwmeaPsaGLxZ8PO4mi+ilUqUEgjiDPsqgc0g7JTMoi+ngikJQV1Z8IbiI8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg574WEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C29C4CEE4;
	Fri, 25 Apr 2025 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745616193;
	bh=6fjTmNSFrlTdsaBLXQ/GnLckkpWkOX+NxpTc0rHAaO4=;
	h=From:To:Cc:Subject:Date:From;
	b=Qg574WEHUhuhCKcIUzPme+SaUW33YIp/65c8R6n0wg6lUM8I5jSGV+QVMsbuBJ2zg
	 zXHVkK7S0QQUX5m9nSCNtQI9vHovy5nWFP9xH2s1/c9J1022Cd8dTfuEpZUk4HTmZ3
	 xKgzFoTLqj56jCDjE3NJvG7V4ncciBwdYmQQNEs45ikgpAlddQjOYNZ9wK68OjezoC
	 Q8RSnT7fqtMEoZ2tDsEyFftTI26kpecwBSUcglT6MY6+Tc8GyzMV6hhckyb2Ra3nFb
	 0tvRKiBauQJGmFRNW6I/s2GMZr50ratR+8Y7j/9e60Xial5ryTIsZ8i42rcf+rEMIV
	 XDmo1vKcUFROA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Fri, 25 Apr 2025 23:22:54 +0200
Message-ID: <20250425-vfs-fixes-dc6a1661a28f@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4803; i=brauner@kernel.org; h=from:subject:message-id; bh=6fjTmNSFrlTdsaBLXQ/GnLckkpWkOX+NxpTc0rHAaO4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRw/9W/srO2wOHiouJlFbHaMXxRIkqCdv2ZWx6bWDw5/ q/Gv6igo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIWrQz/NDMW757mekb0ie2y vKPejm5XRb32H+Zblusbqs8oUL3Vn+Gf9u6P0kkq74P0jTRvO595JnzPqtz7zrK8qVf9X/1d9tS FDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

- For some reason we went from zero to three maintainers for HFS/HFS+ in
  a matter of days. The lesson to learn from this might just be that we
  need to threaten code removal more often!?

- Fix a regression introduced by enabling large folios for lage logical
  block sizes. This has caused issues for noref migration with large
  folios due to sleeping while in an atomic context.

  New sleeping variants of pagecache lookup helpers are introduced.
  These helpers take the folio lock instead of the mapping's private
  spinlock. The problematic users are converted to the sleeping variants
  and serialize against noref migration. Atomic users will bail on
  seeing the new BH_Migrate flag.

  This also shrinks the critical region of the mapping's private lock
  and the new blocking callers reduce contention on the spinlock for
  bdev mappings.

- Fix two bugs in do_move_mount() when with MOVE_MOUNT_BENEATH.
  The first bug is using a mountpoint that is located on a mount we're
  not holding a reference to. The second bug is putting the mountpoint
  after we've called namespace_unlock() as it's no longer guaranteed
  that it does stay a mountpoint.

- Remove a pointless call to vfs_getattr_nosec() in the devtmpfs code
  just to query i_mode instead of simply querying the inode directly.
  This also avoids lifetime issues for the dm code by an earlier bugfix
  this cycle that moved bdev_statx() handling into vfs_getattr_nosec().

- Fix AT_FDCWD handling with getname_maybe_null() in the xattr code.

- Fix a performance regression for files when multiple callers issue a
  close when it's not the last reference.

- Remove a duplicate noinline annotation from pipe_clear_nowait().

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

The following changes since commit a33b5a08cbbdd7aadff95f40cbb45ab86841679e:

  Merge tag 'sched_ext-for-6.15-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext (2025-04-21 19:16:29 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc4.fixes

for you to fetch changes up to f520bed25d17bb31c2d2d72b0a785b593a4e3179:

  fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2) (2025-04-25 12:11:56 +0200)

Please consider pulling these changes from the signed vfs-6.15-rc4.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc4.fixes

----------------------------------------------------------------
Al Viro (1):
      fix a couple of races in MNT_TREE_BENEATH handling by do_move_mount()

Christian Brauner (1):
      Merge patch series "fs/buffer: split pagecache lookups into atomic or blocking"

Christoph Hellwig (1):
      devtmpfs: don't use vfs_getattr_nosec to query i_mode

Davidlohr Bueso (7):
      fs/buffer: split locking for pagecache lookups
      fs/buffer: introduce sleeping flavors for pagecache lookups
      fs/buffer: use sleeping version of __find_get_block()
      fs/ocfs2: use sleeping version of __find_get_block()
      fs/jbd2: use sleeping version of __find_get_block()
      fs/ext4: use sleeping version of sb_find_get_block()
      mm/migrate: fix sleep in atomic for large folios and buffer heads

Jan Kara (1):
      fs/xattr: Fix handling of AT_FDCWD in setxattrat(2) and getxattrat(2)

Mateusz Guzik (1):
      fs: fall back to file_ref_put() for non-last reference

T.J. Mercier (1):
      splice: remove duplicate noinline from pipe_clear_nowait

Viacheslav Dubeyko (1):
      MAINTAINERS: add HFS/HFS+ maintainers

Yangtao Li (1):
      MAINTAINERS: hfs/hfsplus: add myself as maintainer

 MAINTAINERS                 | 10 +++++--
 drivers/base/devtmpfs.c     | 22 ++++++--------
 fs/buffer.c                 | 73 +++++++++++++++++++++++++++++++++------------
 fs/ext4/ialloc.c            |  3 +-
 fs/ext4/mballoc.c           |  3 +-
 fs/file.c                   |  2 +-
 fs/jbd2/revoke.c            | 15 ++++++----
 fs/namespace.c              | 69 ++++++++++++++++++++++--------------------
 fs/ocfs2/journal.c          |  2 +-
 fs/splice.c                 |  2 +-
 fs/xattr.c                  |  4 +--
 include/linux/buffer_head.h |  9 ++++++
 include/linux/file_ref.h    | 19 ++++--------
 mm/migrate.c                |  8 +++--
 14 files changed, 145 insertions(+), 96 deletions(-)

