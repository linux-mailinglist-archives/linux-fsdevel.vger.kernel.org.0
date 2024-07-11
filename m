Return-Path: <linux-fsdevel+bounces-23538-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08BE92DF50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914231C21F68
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 05:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD44F1F8;
	Thu, 11 Jul 2024 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9NrvbX/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDA20312;
	Thu, 11 Jul 2024 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674575; cv=none; b=bssANFueJz77G+Q+RFXayE04JvkaPD+CZhR8xdMEwE8hreBiG2/hiPtOF7hcL8ArAM4737BCylSnSGikqnHBXX5xKR9jg7ZFDD9qJ88pF1etxncz6Eb+wa4ZDdVnlg7fgKkNfBWpzrIFY/DfQzDVe3DJDEQLfjoTW+GVp+Zb5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674575; c=relaxed/simple;
	bh=3mq68wnh89QhdTG3ycaKxXy1VslZgsI6uKtfnxrJKOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f6E+71xLsO4Jl+EvQzXMm50TLpRfKC0AR7BBdwQ8sat3481M3TiWPDgo37iYYTZkOy8kSAJzoLkGg4gz7W2CdSLdCpi/+UUHCKZdWJmonps9QBe3ovDvyeC1NArFxJZl6U+G1XyRFlLxfcr8rsDTi7uGuh7Hp9XkO6wAEsGcC8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9NrvbX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9637EC116B1;
	Thu, 11 Jul 2024 05:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720674575;
	bh=3mq68wnh89QhdTG3ycaKxXy1VslZgsI6uKtfnxrJKOY=;
	h=From:To:Cc:Subject:Date:From;
	b=q9NrvbX/oX/k35lLO8q7wvLSzVvstvCAcObMHW32njE39nucF0a/Ouk48dMJiSQ1K
	 XXOHIsk5Mn0S/dROc4yRRN9YbMdMMKulfNgduegxJCkoJ7JkxXvwpIdFSk9vrNATxL
	 WcXdqHSn9c4DB3IDuJuT26tsgLBR1TOLvzDmaAu0dTwkEwdJyNUWxQLz/TRC5nkEud
	 +LSrCnwRAZI4onpYDDT+kOVhFumI8yldiFIZvy62t/7J6afq+6/LLlHdQZEde69FKj
	 0rAvGYc50KRAsUCbnZ/e5K5Wjzd+IvXY9vKRL+mRk0u4LMHE4Tccrjjy8S/+yl1EPy
	 Sc12uX6UcfP9g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Thu, 11 Jul 2024 07:09:27 +0200
Message-ID: <20240711-vfs-fixes-b2bdd616763d@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5441; i=brauner@kernel.org; h=from:subject:message-id; bh=3mq68wnh89QhdTG3ycaKxXy1VslZgsI6uKtfnxrJKOY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT1Z3IKHs9f/26Rr0Pkzw9/58//LPgt+ND7tq/nl7ccX Rdd9EjyZkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEJBcy/FOK8D/PyLlSjOdI z/xpq9mvhzzZ3jdP1FlngvR1tR1NTlcYGc77nZtm1nzf4wzb5zuznBZNuejYmsgi1L834ueJXdV WpzkB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

/* Summary */
This contains fixes for this merge window:

cachefiles:
- Export an existing and add a new cachefile helper to be used in filesystems
  to fix reference count bugs.
- Use the newly added fscache_ty_get_volume() helper to get a reference count
  on an fscache_volume to handle volumes that are about to be removed cleanly.
- After withdrawing a fscache_cache via FSCACHE_CACHE_IS_WITHDRAWN wait for all
  ongoing cookie lookups to complete and for the object count to reach zero.
- Propagate errors from vfs_getxattr() to avoid an infinite loop in
  cachefiles_check_volume_xattr() because it keeps seeing ESTALE.
- Don't send new requests when an object is dropped by raising
  CACHEFILES_ONDEMAND_OJBSTATE_DROPPING.
- Cancel all requests for an object that is about to be dropped.
- Wait for the ondemand_boject_worker to finish before dropping a cachefiles
  object to prevent use-after-free.
- Use cyclic allocation for message ids to better handle id recycling.
- Add missing lock protection when iterating through the xarray when polling.

netfs:
- Use standard logging helpers for debug logging.

VFS:
- Fix potential use-after-free in file locks during trace_posix_lock_inode().
  The tracepoint could fire while another task raced it and freed the lock that
  was requested to be traced.
- Only increment the nr_dentry_negative counter for dentries that are present
  on the superblock LRU. Currently, DCACHE_LRU_LIST list is used to detect this
  case. However, the flag is also raised in combination with DCACHE_SHRINK_LIST
  to indicate that dentry->d_lru is used. So checking only DCACHE_LRU_LIST will
  lead to wrong nr_dentry_negative count. Fix the check to not count dentries
  that are on a shrink related list.

Misc:
- hfsplus: fix an uninitialized value issue in copy_name.
- minix: fix minixfs_rename with HIGHMEM. It still uses kunmap() even though we
  switched it to kmap_local_page() a while ago.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

All patches are based on v6.10-rc6. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:

  Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc8.fixes

for you to fetch changes up to 3d1bec293378700dddc087d4d862306702276c23:

  minixfs: Fix minixfs_rename with HIGHMEM (2024-07-10 07:15:36 +0200)

Please consider pulling these changes from the signed vfs-6.10-rc8.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10-rc8.fixes

----------------------------------------------------------------
Baokun Li (7):
      netfs, fscache: export fscache_put_volume() and add fscache_try_get_volume()
      cachefiles: fix slab-use-after-free in fscache_withdraw_volume()
      cachefiles: fix slab-use-after-free in cachefiles_withdraw_cookie()
      cachefiles: propagate errors from vfs_getxattr() to avoid infinite loop
      cachefiles: stop sending new request when dropping object
      cachefiles: cancel all requests for the object that is being dropped
      cachefiles: cyclic allocation of msg_id to avoid reuse

Brian Foster (1):
      vfs: don't mod negative dentry count when on shrinker list

Christian Brauner (1):
      Merge patch series "cachefiles: random bugfixes"

Edward Adam Davis (1):
      hfsplus: fix uninit-value in copy_name

Hou Tao (1):
      cachefiles: wait for ondemand_object_worker to finish when dropping object

Jeff Layton (1):
      filelock: fix potential use-after-free in posix_lock_inode

Jingbo Xu (1):
      cachefiles: add missing lock protection when polling

Matthew Wilcox (Oracle) (1):
      minixfs: Fix minixfs_rename with HIGHMEM

Uwe Kleine-König (1):
      netfs: Switch debug logging to pr_debug()

 fs/cachefiles/cache.c          | 45 +++++++++++++++++++++++++++++++++++-
 fs/cachefiles/daemon.c         |  4 ++--
 fs/cachefiles/internal.h       |  3 +++
 fs/cachefiles/ondemand.c       | 52 +++++++++++++++++++++++++++++++++++++-----
 fs/cachefiles/volume.c         |  1 -
 fs/cachefiles/xattr.c          |  5 +++-
 fs/dcache.c                    | 12 +++++++---
 fs/hfsplus/xattr.c             |  2 +-
 fs/locks.c                     |  2 +-
 fs/minix/namei.c               |  3 +--
 fs/netfs/buffered_read.c       | 14 ++++++------
 fs/netfs/buffered_write.c      | 12 +++++-----
 fs/netfs/direct_read.c         |  2 +-
 fs/netfs/direct_write.c        |  8 +++----
 fs/netfs/fscache_cache.c       |  4 ++--
 fs/netfs/fscache_cookie.c      | 28 +++++++++++------------
 fs/netfs/fscache_io.c          | 12 +++++-----
 fs/netfs/fscache_main.c        |  2 +-
 fs/netfs/fscache_volume.c      | 18 +++++++++++++--
 fs/netfs/internal.h            | 35 +---------------------------
 fs/netfs/io.c                  | 12 +++++-----
 fs/netfs/main.c                |  4 ----
 fs/netfs/misc.c                |  4 ++--
 fs/netfs/write_collect.c       | 16 ++++++-------
 fs/netfs/write_issue.c         | 36 ++++++++++++++---------------
 include/linux/fscache-cache.h  |  6 +++++
 include/trace/events/fscache.h |  4 ++++
 27 files changed, 213 insertions(+), 133 deletions(-)

