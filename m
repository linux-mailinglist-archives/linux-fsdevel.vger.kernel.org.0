Return-Path: <linux-fsdevel+bounces-55505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6023B0AF73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 12:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E59562852
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Jul 2025 10:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A42376E6;
	Sat, 19 Jul 2025 10:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PoiwaSL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BDF221FCD;
	Sat, 19 Jul 2025 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752922779; cv=none; b=b6jR2AGUnpoC4s6cn41o80HGKN7bfR0JCKO1bCA2cF96dIvQ6N7/Oj+bGtgcV6SBeSgLzmbb77wt4m4B3MVsNVQFf7oZaqjTNUh4E3MfyI+WmHOg6V2gYUsnVwTrDRc3oU8WS/KY6x0ASgcw6zHAK8hHRtGjURZeoLVYuho07XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752922779; c=relaxed/simple;
	bh=0Z9uacVG6TvX12qae+8okbz7XM8Pza7grx3UtvRkaFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PHVL664juu/eUkDLBm9OwmzYR9Xuwmihj6Oh8DduIBwgif8etmD7NOgI9PaAlA2ytYkynLvKrVT9nJswfAgVbeEJaUA3XRHoFMN4IPPR94YmPbAC0XZcnjB+DC/ScMIgfIRh8EfkV/NIXRrQP/8yb1yN+3XtJdEIDpyo3huyPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PoiwaSL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE1AC4CEE3;
	Sat, 19 Jul 2025 10:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752922777;
	bh=0Z9uacVG6TvX12qae+8okbz7XM8Pza7grx3UtvRkaFs=;
	h=From:To:Cc:Subject:Date:From;
	b=PoiwaSL0wf0IsKK/7gXktWBJ7pqT0mqRluhA12xcx3mWTNT94Pe5NlVZywopBkiBk
	 2IHCtOyomkFEr8/6Akg0jKCsrw+yEfpZ3U7jpQ5dBmiQWd74Vrf+6iv2f6D9/I4Y58
	 xUTwF2BMx7japfgOSsWn0Qr4lBA7vENbbVXC4n4W3QfHqdWmcN+FEfQA1sSdr7Cp7O
	 /pjAvPooIX70wMsYC+FdoZJKd69NyvE4XAg1BhU3Mw4dZAXWPkiO444GX0GOlVH0vC
	 uQq2Vx8pzRoj26w3Bgk2yIdhuSOoXQRR9RibOiPWONOQoMStRmO3AEw6Il5hhiZc5D
	 PtvoEEeHdZdYg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Sat, 19 Jul 2025 12:59:10 +0200
Message-ID: <20250719-vfs-fixes-6414760dc851@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3043; i=brauner@kernel.org; h=from:subject:message-id; bh=0Z9uacVG6TvX12qae+8okbz7XM8Pza7grx3UtvRkaFs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRUVzX/Fy6VXsmqG+p47E3Xy+KEzrA9aTVz+LzEPX7k6 In79dh1lLIwiHExyIopsji0m4TLLeep2GyUqQEzh5UJZAgDF6cATKRTkuF/TXmbrWjy4ls2R0M2 zi9fLFt3Z9+P76k1Vr++lC1+MP/sE0aGJZeEq+2DJ54Tmz9X3GKeUGwgIzfvhr8JF2v+XFuqV/G FEQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains a few fixes for this cycle:

- Fix a memory leak in fcntl_dirnotify().

- Raise SB_I_NOEXEC on secrement superblock instead of messing with
  flags on the mount.

- Add fsdevel and block mailing lists to uio entry. We had a few
  instances were very questionable stuff was added without either block
  or the VFS being aware of it.

- Fix netfs copy-to-cache so that it performs collection with ceph+fscache.

- Fix netfs race between cache write completion and ALL_QUEUED being set.

- Verify the inode mode when loading entries from disk in isofs.

- Avoid state_lock in iomap_set_range_uptodate().

- Fix PIDFD_INFO_COREDUMP check in PIDFD_GET_INFO ioctl.

- Fix the incorrect return value in __cachefiles_write().

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

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

  Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc7.fixes

for you to fetch changes up to a88cddaaa3bf7445357a79a5c351c6b6d6f95b7d:

  MAINTAINERS: add block and fsdevel lists to iov_iter (2025-07-16 14:46:53 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc7.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc7.fixes

----------------------------------------------------------------
Al Viro (1):
      fix a leak in fcntl_dirnotify()

Christian Brauner (3):
      secretmem: use SB_I_NOEXEC
      Merge patch series "netfs: Fix use of fscache with ceph"
      MAINTAINERS: add block and fsdevel lists to iov_iter

David Howells (2):
      netfs: Fix copy-to-cache so that it performs collection with ceph+fscache
      netfs: Fix race between cache write completion and ALL_QUEUED being set

Jan Kara (1):
      isofs: Verify inode mode when loading from disk

Jinliang Zheng (1):
      iomap: avoid unnecessary ifs_set_range_uptodate() with locks

Laura Brehm (1):
      coredump: fix PIDFD_INFO_COREDUMP ioctl check

Zizhi Wo (1):
      cachefiles: Fix the incorrect return value in __cachefiles_write()

 MAINTAINERS                  |  2 ++
 fs/cachefiles/io.c           |  2 --
 fs/cachefiles/ondemand.c     |  4 +---
 fs/iomap/buffered-io.c       |  3 +++
 fs/isofs/inode.c             |  9 ++++++++-
 fs/netfs/read_pgpriv2.c      |  5 +++++
 fs/notify/dnotify/dnotify.c  |  8 ++++----
 fs/pidfs.c                   |  2 +-
 include/trace/events/netfs.h | 30 ++++++++++++++++++++++++++++++
 mm/secretmem.c               | 13 +++++++++----
 10 files changed, 63 insertions(+), 15 deletions(-)

