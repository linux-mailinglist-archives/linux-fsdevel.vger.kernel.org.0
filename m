Return-Path: <linux-fsdevel+bounces-24188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8FB93AEC4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 11:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1EDE1F24F87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D85A152511;
	Wed, 24 Jul 2024 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPVCObqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3F433B5;
	Wed, 24 Jul 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721812867; cv=none; b=IeP/FWWbhxJcFnb3Nn4qCrQsNywDDCTFxGFB9ekBuPYiLV0pg/H+qRe3tI2kSUeP3zLDzTMSF3iGp/xI8RsmnTgiwDG0Uc99HYFzLgbBq0LOZkYwPFMY3FhVYbMt5b66vIAJoJdvHyr8pWq8pJ5o4aC+HMAyWBXWLuVQakEZGxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721812867; c=relaxed/simple;
	bh=j/OhrurHGosZNsGAT13e9akh5g958hutQSyv9oC95bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sjRp52qa7lNB35mKFx/cLYUOMNFjgbC5EsxY45M1pRuu2gffbCpwGlnar9rZqwl/XaOIhTblkE+onLCFYXR9JS8BlSfF2xEQuEPXqHs9YNhW1w7XFP+p9h9VoPa2JPsbhB1SANWnwgjDvjwnh03JyXZB0LKDEw3nv1EHtLGqbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPVCObqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1086C4AF0E;
	Wed, 24 Jul 2024 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721812867;
	bh=j/OhrurHGosZNsGAT13e9akh5g958hutQSyv9oC95bA=;
	h=From:To:Cc:Subject:Date:From;
	b=XPVCObqxiyU4jCAyoZ3AThaXXRnsRCTHzpQpbZkpydTiPvYhzeYN/JknYk035lG8u
	 EvLRI96ZHPurNYPqZjrQd6l3z1oZmGwkEOtPigEEvnrr6M0eWbHa5JUJBCKs/1BzA+
	 2sD9uiYaLdzINLPjV/KdB1aibwvMpnIL5uu4eieCeOxjkqgoDv2mPuFhsngo0sSb+E
	 dLk1fT7TG9cyfadPQcQ60DrmqrUUcQVW8jZqe1EdyWbPowi7ISAcGP+91eK16CY2gC
	 bTsRmGEl8XrOa3ouWXF6HDov3awQa7kLZKZv/O6e3l3POT3qTU4MAoHRkXucAi9k4H
	 8Qlw+zi0jFrIw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Wed, 24 Jul 2024 11:19:49 +0200
Message-ID: <20240724-vfs-fixes-620fa9859ef0@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5841; i=brauner@kernel.org; h=from:subject:message-id; bh=j/OhrurHGosZNsGAT13e9akh5g958hutQSyv9oC95bA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQtOG7WukV+41OTliSZVUsvrjx9UlK8Y//6JmvZR2c3c /CK/hY70VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRm3MY/udb691xrLyvsGBW DlOB4VejruKbk4JiKyTLnphtvuu5N4qRofXKnQ+rV+zzmq0x4f6EwJenbs3byb8p57COj6zUm48 T9RkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

/* Summary */
This contains fixes for this merge window:

VFS:

- The new 64bit mount ids start after the old mount id, i.e., at the first
  non-32 bit value. However, we started counting one id too late and thus lost
  4294967296 as the first valid id. Fix that.

- Update a few comments on some vfs_*() creation helpers.

- Move copying of the xattr name out from the locks required to start a
  filesystem write.

- Extend the filelock lock UAF fix to the compat code as well.

- Now that we added the ability to look up an inode under RCU it's possible
  that lockless hash lookup can find and lock an inode after it gets I_FREEING
  set. It then waits until inode teardown in evict() is finished.

  The flag however is still set after evict() has woken up all waiters. If the
  inode lock is taken late enough on the waiting side after hash removal and
  wakeup happened the waiting thread will never be woken.

  Before RCU based lookup this was synchronized via the inode_hash_lock. But
  since unhashing requires the inode lock as well we can check whether the
  inode is unhashed while holding inode lock even without holding
  inode_hash_lock.

pidfd:

- The nsproxy structure contains nearly all of the namespaces associated with a
  task. When a namespace type isn't supported nsproxy might contain a NULL
  pointer or always point to the initial namespace type. The logic isn't
  consistent. So when deriving namespace fds we need to ensure that the
  namespace type is supported.

  First, so that we don't risk dereferncing NULL pointers. The correct bigger
  fix would be to change all namespaces to always set a valid namespace pointer
  in struct nsproxy independent of whether or not it is compiled in. But that
  requires quite a few changes.

  Second, so that we don't allow deriving namespace fds when the namespace type
  doesn't exist and thus when they couldn't also be derived via /proc/self/ns/.

- Add missing selftests for the new pidfd ioctls to derive namespace fds. This
  simply extends the already existing testsuite.

netfs:

- Fix debug logging and fix kconfig variable name so it actually works.

- Fix writeback that goes both to the server and cache. The streams are only
  activated once a subreq is added. When a server write happens the subreq
  doesn't need to have finished by the time the cache write is started. If the
  server write has already finished by the time the cache write is about to
  start the cache write will operate on a folio that might already have been
  reused. Fix this by preactivating the cache write.

- Limit cachefiles subreq size for cache writes to MAX_RW_COUNT.

The following changes since commit 933069701c1b507825b514317d4edd5d3fd9d417:

  Merge tag '6.11-rc-smb3-server-fixes' of git://git.samba.org/ksmbd (2024-07-21 20:50:39 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.11-rc1.fixes.2

for you to fetch changes up to f5e5e97c719d289025afce07050effcf1f7373ef:

  inode: clarify what's locked (2024-07-24 11:11:40 +0200)

Please consider pulling these changes from the signed vfs-6.11-rc1.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.11-rc1.fixes.2

----------------------------------------------------------------
Christian Brauner (4):
      pidfs: handle kernels without namespaces cleanly
      pidfs: add selftests for new namespace ioctls
      fs: use all available ids
      inode: clarify what's locked

Congjie Zhou (1):
      vfs: correct the comments of vfs_*() helpers

David Howells (5):
      netfs: Revert "netfs: Switch debug logging to pr_debug()"
      netfs: Rename CONFIG_FSCACHE_DEBUG to CONFIG_NETFS_DEBUG
      netfs: Fix writeback that needs to go to both server and cache
      cachefiles: Set the max subreq size for cache writes to MAX_RW_COUNT
      vfs: Fix potential circular locking through setxattr() and removexattr()

Edward Adam Davis (1):
      pidfs: when time ns disabled add check for ioctl

Jann Horn (1):
      filelock: Fix fcntl/close race recovery compat path

Mateusz Guzik (1):
      vfs: handle __wait_on_freeing_inode() and evict() race

 fs/cachefiles/io.c                               |   2 +-
 fs/inode.c                                       |  40 +++-
 fs/locks.c                                       |   9 +-
 fs/namei.c                                       |  26 +--
 fs/namespace.c                                   |   2 +-
 fs/netfs/Kconfig                                 |  18 +-
 fs/netfs/buffered_read.c                         |  14 +-
 fs/netfs/buffered_write.c                        |  12 +-
 fs/netfs/direct_read.c                           |   2 +-
 fs/netfs/direct_write.c                          |   8 +-
 fs/netfs/fscache_cache.c                         |   4 +-
 fs/netfs/fscache_cookie.c                        |  28 +--
 fs/netfs/fscache_io.c                            |  12 +-
 fs/netfs/fscache_main.c                          |   2 +-
 fs/netfs/fscache_volume.c                        |   4 +-
 fs/netfs/internal.h                              |  33 ++-
 fs/netfs/io.c                                    |  12 +-
 fs/netfs/main.c                                  |   4 +
 fs/netfs/misc.c                                  |   4 +-
 fs/netfs/write_collect.c                         |  16 +-
 fs/netfs/write_issue.c                           |  37 ++--
 fs/pidfs.c                                       |  63 ++++--
 fs/xattr.c                                       |  91 ++++----
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 258 ++++++++++++++++++++---
 24 files changed, 488 insertions(+), 213 deletions(-)

