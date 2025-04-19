Return-Path: <linux-fsdevel+bounces-46727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C04A94572
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 23:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3201894190
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 21:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A91DF98E;
	Sat, 19 Apr 2025 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD9+tV+6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438A1A2860;
	Sat, 19 Apr 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745096661; cv=none; b=nDyZII7GR4GOjNcjSZMEl/mWcOvn5Lym7ZuEpJD1Q8HNYhJi73d9wurQp9hgzhIfM9nPSECGB7ck7FONfUIpVcO1br5CG/9tLu7SHPqkO/AhzOJc6yZyIcjxGVvAjVZkXsjinFQEP0zARjc+poL1egfrKPCYRDWZlr7+fb6ruRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745096661; c=relaxed/simple;
	bh=SnW8ZvvztGN2rE+JhiTwhq8fakQpkcH3dL2/xVS0Phw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qemgf8klO/cBGBB2gGk6+49ArioWYW8ukVmQZT0atreUW+C/Awpv5nJ1Z0iuzHzCNT93e0v/lO4Bs6PTKsTiHSDHCGN2WlO620S1koZy/QdUGeDj16jrvFhf1HGrpNvIjBopfTsPxv173QqiRSGzxkott52mcBHPXxWdyridBYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD9+tV+6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547DCC4CEE7;
	Sat, 19 Apr 2025 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745096660;
	bh=SnW8ZvvztGN2rE+JhiTwhq8fakQpkcH3dL2/xVS0Phw=;
	h=From:To:Cc:Subject:Date:From;
	b=CD9+tV+63FLsS6cX0Cae/YYN9y5hJ5s0d8ptlLID5wDU9gyhhDpGbL7+JQUviq2AG
	 xltonH5gBeP8+q9mzgO44HU3zqgv9At+mojx5wyZ+1NIrPez+VLuOGvU6OiPE05Psh
	 +xWwis2uCVATtn7vQZteYMkpiHfc13NFXxeEo5Gz5N02IDE9F6rVzl6PQ+7dnun6Mh
	 uQQLIkF+ol5LsBrwZBWqcZmI0NuJ1Q8VIO6M0acwvQ1oJ/H8ZHz7CCE49on2nbD8pn
	 EhCfRFI138vpntLjgOHy62dH53+HhNUQGMfpECWCfuEvTxWL4FhLmw+e0L6vHDznb1
	 jdSP4yM1hHuMw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Sat, 19 Apr 2025 23:04:04 +0200
Message-ID: <20250419-vfs-fixes-627259052c9a@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3155; i=brauner@kernel.org; h=from:subject:message-id; bh=SnW8ZvvztGN2rE+JhiTwhq8fakQpkcH3dL2/xVS0Phw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSw8J/xanHdPmm9osbbqtONFbsl8llmBcVtneUUvP2JY qZGyIP6jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlkZjD8lfe8YXT+8mYVq7iz K5b9/ve6o4pn3xdGK05NHrHTC37OVmX4H/DL8PyeOZ/uWAiu4F2wvTfbx3/akvZF09bJ7X7fKOz vywgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This contains various fixes for this cycle:

* Revert the hfs{plus} deprecation warning that's also included in this
  pull request. The commit introducing the deprecation warning resides
  rather early in this branch. So simply dropping it would've rebased
  all other commits which I decided to avoid. Hence the revert in the
  same branch.

* Switch CONFIG_SYSFS_SYCALL default to n and decouple from CONFIG_EXPERT.

* Fix an audit bug caused by changes to our kernel path lookup
  helpers this cycle. Audit needs the parent path even if the dentry it
  tried to look up is negative.

* Ensure that the kernel path lookup helpers leave the passed in path
  argument clean when they return an error. This is consistent with all
  our other helpers.

* Ensure that vfs_getattr_nosec() calls bdev_statx() so the relevant
  information is available to kernel consumers as well.

* Don't set a timer and call schedule() if the timer will expire
  immediately in epoll.

* Make netfs lookup tables with __nonstring.

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

The following changes since commit 834a4a689699090a406d1662b03affa8b155d025:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2025-04-14 10:24:04 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.15-rc3.fixes.2

for you to fetch changes up to 408e4504f97c0aa510330f0a04b7ed028fdf3154:

  Revert "hfs{plus}: add deprecation warning" (2025-04-19 22:48:59 +0200)

Please consider pulling these changes from the signed vfs-6.15-rc3.fixes.2 tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.15-rc3.fixes.2

----------------------------------------------------------------
Christian Brauner (5):
      Kconfig: switch CONFIG_SYSFS_SYCALL default to n
      hfs{plus}: add deprecation warning
      fs: add kern_path_locked_negative()
      fs: ensure that *path_locked*() helpers leave passed path pristine
      Revert "hfs{plus}: add deprecation warning"

Christoph Hellwig (1):
      fs: move the bdex_statx call to vfs_getattr_nosec

Joe Damato (1):
      eventpoll: Set epoll timeout if it's in the future

Kees Cook (1):
      netfs: Mark __nonstring lookup tables

 block/bdev.c              |  3 +-
 fs/eventpoll.c            | 10 +++++-
 fs/namei.c                | 81 +++++++++++++++++++++++++++++++++--------------
 fs/netfs/fscache_cache.c  |  2 +-
 fs/netfs/fscache_cookie.c |  2 +-
 fs/stat.c                 | 32 +++++++++++--------
 include/linux/blkdev.h    |  6 ++--
 include/linux/namei.h     |  1 +
 init/Kconfig              | 20 ++++++------
 kernel/audit_watch.c      | 16 ++++++----
 10 files changed, 112 insertions(+), 61 deletions(-)

