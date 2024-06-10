Return-Path: <linux-fsdevel+bounces-21341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7168B9023E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 16:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A45EB29415
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF58484DE7;
	Mon, 10 Jun 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRM1CBXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA423B0;
	Mon, 10 Jun 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718028648; cv=none; b=LCs7aI3mHHQ916BqaTAPAZnQlowyL988hew5shaolyZIJhKch7vTxx6Y52DRg1l/XbmigvWYsxdEbLrQlNbx5l+VxNcnvcHzwFBKpkKDHjVpAzLcZsuadA0vlHeKTw8SG1wZCumXckqbD+bD3Mv6MqJlei1m08O5J5I3Y26bd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718028648; c=relaxed/simple;
	bh=2eh5fXSWeeSBjf8qN/ZVFdd9bpC1U/JqDHicBRIk/Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5jl0YU55lyuzNJo9rAsmOtEzCVF2lp7ZuUwlam8hyvZ3TG+kSqrZxAzOpY4rrlqqyLAyhiQepPYFm6dqU24U3XWsfsvElYqHedMV/ON6V9s02ROslqfRW5Rj4FcO2Xax10T5xyR4uIFPzE/NU+ib+h6T9w5sRQPNkj5cBg8a5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRM1CBXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A755C2BBFC;
	Mon, 10 Jun 2024 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718028647;
	bh=2eh5fXSWeeSBjf8qN/ZVFdd9bpC1U/JqDHicBRIk/Pw=;
	h=From:To:Cc:Subject:Date:From;
	b=VRM1CBXRqwMoesfO3Wii8BrMsr5/tU4dKUfTJOL1f0kZY/3iQs6v0UGxgI0vQkJf7
	 orT66yVpsiQJ2jA/516zMTzxsK/k85RO88j6AEXB++9N6+Z7JAZ0acMcao40QFOWyt
	 w9TxJdP6PkAg0G6VqOzOJmWBLx8324I/jW+53dkb0WVfYi+f0Z7B14gZBPMaGf3KcW
	 L3+/P5NHvK5esZyJYqF2oDvdoGXAXgjub6JWdxkfrqnLY8nPlZmuLXeveLF2WeM9uA
	 2qOU9tuDg03H0jQdXRQ2jpcR2J5xI26Vjx/2glj4jwr3tJVS7YBB/eLbTkHnVFqLF3
	 V8zaklaa6yM7A==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs fixes
Date: Mon, 10 Jun 2024 16:09:10 +0200
Message-ID: <20240610-vfs-fixes-a84527e50cdb@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4766; i=brauner@kernel.org; h=from:subject:message-id; bh=2eh5fXSWeeSBjf8qN/ZVFdd9bpC1U/JqDHicBRIk/Pw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSlc8asD7dKf5/7cc81ybuSCtmN/vO2pq+QXT09OpeT8 3x68s2IjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkXmb4p2UdonB/wduKg9YW vRc/qi9Z7eP03dXNdrXuCtvZxXJxDIwMWw88Yl20dMvWQ+WTAl/cKdRedPpgxfS3CyJZy0/Fvy3 4ywwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains fixes for this merge window:

* Restore debugfs behavior of ignoring unknown mount options.
* Fix kernel doc for netfs_wait_for_oustanding_io().
* Remove unneeded fdtable.h include in cachefiles.
* Fix struct statx comment after new addition for this cycle.
* Fix data zeroing behavior when an extent spans the block that contains i_size.
* Restore i_size increasing in iomap_write_end() for now to avoid stale data
  exposure on xfs with a realtime device.
* Fix a check in find_next_fd().
* Improve trace output for cachefiles_obj_{get,put}_ondemand_fd().
* Remove requests from the request list in cachefiles to prevent accessing
  already freed requests.
* Fix UAF when issuing restore command while the daemon is still alive by
  adding an additional reference count to cachefile requests.
* Fix UAF in cachefiles by grabbing a reference during xarray lookup with
  xa_lock() held.
* Simplify error handling in cachefiles_ondemand_daemon_read().
* Add consistency checks to cachefiles read and open requests to avoid crashes.
* Add a spinlock to protect ondemand_id variable which is used to determine
  whether an anonymous cachefiles fd has already been closed.
* Make on-demand reads for cachefiles killable allowing to handle broken
  cachefiles daemon better.
* Flush all requests after the kernel has been marked dead via CACHEFILES_DEAD
  to avoid hung-tasks.
* Ensure that closed requests are marked as such to avoid reusing them with a
  reopen request.
* Defer fd_install() until after copy_to_user() succeeded in cachefiles and
  thereby get rid of having to use close_fd().
* Ensure that anonymous cachefiles on-demand fds are reused while they are
  valid to avoid pinning already freed cookies.

/* Testing */
clang: Debian clang version 16.0.6 (27)
gcc: (Debian 13.2.0-25) 13.2.0

All patches are based on mainline. No build failures or warnings were observed.

/* Conflicts */
No known conflicts.

The following changes since commit 2bfcfd584ff5ccc8bb7acde19b42570414bf880b:

  Merge tag 'pmdomain-v6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm (2024-05-27 08:18:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.10-rc4.fixes

for you to fetch changes up to f5ceb1bbc98c69536d4673a97315e8427e67de1b:

  iomap: Fix iomap_adjust_read_range for plen calculation (2024-06-05 17:27:03 +0200)

Please consider pulling these changes from the signed vfs-6.10-rc4.fixes tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.10-rc4.fixes

----------------------------------------------------------------
Baokun Li (11):
      cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
      cachefiles: remove requests from xarray during flushing requests
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
      cachefiles: fix slab-use-after-free in cachefiles_ondemand_daemon_read()
      cachefiles: remove err_put_fd label in cachefiles_ondemand_daemon_read()
      cachefiles: add consistency check for copen/cread
      cachefiles: add spin_lock for cachefiles_ondemand_info
      cachefiles: never get a new anonymous fd if ondemand_id is valid
      cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
      cachefiles: flush all requests after setting CACHEFILES_DEAD
      cachefiles: make on-demand read killable

Christian Brauner (3):
      debugfs: continue to ignore unknown mount options
      netfs: fix kernel doc for nets_wait_for_outstanding_io()
      Merge patch series "cachefiles: some bugfixes and cleanups for ondemand requests"

Gao Xiang (1):
      cachefiles: remove unneeded include of <linux/fdtable.h>

John Garry (1):
      statx: Update offset commentary for struct statx

Ritesh Harjani (IBM) (1):
      iomap: Fix iomap_adjust_read_range for plen calculation

Yuntao Wang (1):
      fs/file: fix the check in find_next_fd()

Zhang Yi (1):
      iomap: keep on increasing i_size in iomap_write_end()

Zizhi Wo (1):
      cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 218 ++++++++++++++++++++++++++++----------
 fs/debugfs/inode.c                |  10 +-
 fs/file.c                         |   4 +-
 fs/iomap/buffered-io.c            |  56 +++++-----
 include/linux/netfs.h             |   2 +-
 include/trace/events/cachefiles.h |   8 +-
 include/uapi/linux/stat.h         |   2 +-
 9 files changed, 215 insertions(+), 93 deletions(-)

