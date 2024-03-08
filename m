Return-Path: <linux-fsdevel+bounces-13991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F288761AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 11:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D6AA2810E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65553E06;
	Fri,  8 Mar 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkRiCyOC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB3B524CC;
	Fri,  8 Mar 2024 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892844; cv=none; b=Iy3DdWVqYo72ZXQymHd3501dssIWwE3e/Lws61Z/XWkA7c6aqlleF2FzPago+CjcUlbmk7GCAwh1yA5fno+rU6OzlN0+IPw/yQf9KRoCkM9LaU598JV27ocPmxjvSMsmAtCzwaM5SA2EyZupcQXPvpmFkZCO6sZWU1VWHAKbH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892844; c=relaxed/simple;
	bh=wLHITFIk4LEoGaWRHY2bZCqHCqdzsyz5t+z3zGnZCWM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cpwrj+3pdI7NylQFIietsFPz16ZMg1RJhmRwTZjAYnzp+qD/hP7R+O2rUhb0s9+d2fscltM9E+LwPGWkA1s06ahbT9zlLda8tx4RFFNvp4jyDpX2JP/C4YorsIUG7clgfceq5UtYxD03DfTKG1qe//WFjAauqbRfUJnee+nCtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkRiCyOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B9C433F1;
	Fri,  8 Mar 2024 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709892844;
	bh=wLHITFIk4LEoGaWRHY2bZCqHCqdzsyz5t+z3zGnZCWM=;
	h=From:To:Cc:Subject:Date:From;
	b=LkRiCyOCnGhxC4e47aIVyLbv0qKIjnYBV+ewm0u05sL/Iu5+HErNCZLbCErW0toVi
	 8Xfs3QecUic7LxCpi8MSF5+SkBP4nXxyskrTHjnPgTyHxdIObX0maSRRU4k7DLcyG5
	 3kbOpuB4bfg6tfYQp7KdYfbfFZFng+/f2VuEt4nysoWjkrAgY3qHoxLis08Hp85T2z
	 q5lCAxdS/Nbb2UH/gfAwpHEoGw40rxl/Omuoc9IDWqvm8mzO54WRPZCsDVJJTOZKwo
	 WRgDUYVdMjlK67u4Tz4PGJWJaWdzUEpQBCtaiJvfU2XnxuFbtRQxCoQt8qZsl/ui44
	 gfOVlsIet86Vw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] vfs pidfd
Date: Fri,  8 Mar 2024 11:13:50 +0100
Message-ID: <20240308-vfs-pidfd-b106369f5406@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9201; i=brauner@kernel.org; h=from:subject:message-id; bh=wLHITFIk4LEoGaWRHY2bZCqHCqdzsyz5t+z3zGnZCWM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS+evKwY0P5O/4twWc//1DVEhE4vKKGYYHZk8V3A6OZu reEq9ps6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI3VpGhpkLm5+vbCq3/25i 8Kz4uUR566bn1/JPOarzzl/ZO2n+MWmGf+bRE7gu8Z8vYTTzmLy4LLfGr+DQguX9UzmYnov+aJC 8xw8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains updates for pidfds:

* Until now pidfds could only be created for thread-group leaders but
  not for threads. There was no technical reason for this. We simply had
  no users that needed support for this. Now we do have users that need
  support for this.

  This introduces a new PIDFD_THREAD flag for pidfd_open(). If that flag
  is set pidfd_open() creates a pidfd that refers to a specific thread.

  In addition, we now allow clone() and clone3() to be called with
  CLONE_PIDFD | CLONE_THREAD which wasn't possible before.

  A pidfd that refers to an individual thread differs from a pidfd that
  refers to a thread-group leader:

  (1) Pidfs are pollable. A task may poll a pidfd and get notified when
      the task has exited.

      For thread-group leader pidfds the polling task is woken if the
      thread-group is empty. In other words, if the thread-group leader
      task exits when there are still threads alive in its thread-group
      the polling task will not be woken when the thread-group leader
      exits but rather when the last thread in the thread-group exits.

      For thread-specific pidfds the polling task is woken if the thread
      exits.

  (2) Passing a thread-group leader pidfd to pidfd_send_signal() will
      generate thread-group directed signals like kill(2) does.

      Passing a thread-specific pidfd to pidfd_send_signal() will
      generate thread-specific signals like tgkill(2) does.

      The default scope of the signal is thus determined by the type of
      the pidfd.

      Since use-cases exist where the default scope of the provided
      pidfd needs to be overriden the following flags are added to
      pidfd_send_signal():

      - PIDFD_SIGNAL_THREAD
        Send a thread-specific signal.

      - PIDFD_SIGNAL_THREAD_GROUP
        Send a thread-group directed signal.

      - PIDFD_SIGNAL_PROCESS_GROUP
        Send a process-group directed signal.

      The scope change will only work if the struct pid is actually used
      for this scope. For example, in order to send a thread-group
      directed signal the provided pidfd must be used as a thread-group
      leader and similarly for PIDFD_SIGNAL_PROCESS_GROUP the struct pid
      must be used as a process group leader.

* Move pidfds from the anonymous inode infrastructure to a tiny
  pseudo filesystem. This will unblock further work that we weren't able
  to do simply because of the very justified limitations of anonymous
  inodes. Moving pidfds to a tiny pseudo filesystem allows for statx on
  pidfds to become useful for the first time. They can now be compared
  by inode number which are unique for the system lifetime.

  Instead of stashing struct pid in file->private_data we can now stash
  it in inode->i_private. This makes it possible to introduce concepts
  that operate on a process once all file descriptors have been closed.
  A concrete example is kill-on-last-close. Another side-effect is that
  file->private_data is now freed up for per-file options for pidfds.

  Now, each struct pid will refer to a different inode but the same
  struct pid will refer to the same inode if it's opened multiple times.
  In contrast to now where each struct pid refers to the same inode.

  The tiny pseudo filesystem is not visible anywhere in userspace
  exactly like e.g., pipefs and sockfs. There's no lookup, there's no
  complex inode operations, nothing. Dentries and inodes are always
  deleted when the last pidfd is closed.

  We allocate a new inode and dentry for each struct pid and we reuse
  that inode and dentry for all pidfds that refer to the same struct
  pid. The code is entirely optional and fairly small. If it's not
  selected we fallback to anonymous inodes. Heavily inspired by nsfs.

  The dentry and inode allocation mechanism is moved into generic
  infrastructure that is now shared between nsfs and pidfs. The
  path_from_stashed() helper must be provided with a stashing location,
  an inode number, a mount, and the private data that is supposed to be
  used and it will provide a path that can be passed to dentry_open().

  The helper will try retrieve an existing dentry from the provided
  stashing location. If a valid dentry is found it is reused. If not a
  new one is allocated and we try to stash it in the provided location.
  If this fails we retry until we either find an existing dentry or the
  newly allocated dentry could be stashed. Subsequent openers of the
  same namespace or task are then able to reuse it.

* Currently it is only possible to get notified when a task has exited,
  i.e., become a zombie and userspace gets notified with EPOLLIN. We now
  also support waiting until the task has been reaped, notifying
  userspace with EPOLLHUP.

* Ensure that ESRCH is reported for getfd if a task is exiting instead
  of the confusing EBADF.

* Various smaller cleanups to pidfd functions.

/* Testing */
clang: Debian clang version 16.0.6 (19)
gcc: (Debian 13.2.0-7) 13.2.0

All patches are based on v6.8-rc1 and have been sitting in linux-next.
No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with other trees
================================

[1] linux-next: manual merge of the vfs-brauner tree with the mm tree
    https://lore.kernel.org/linux-next/20240221103200.165d8cd5@canb.auug.org.au

[2] linux-next: manual merge of the vfs-brauner tree with the cifs tree
    https://lore.kernel.org/linux-next/20240226110343.28e340eb@canb.auug.org.au

Merge conflicts with mainline
=============================

No known conflicts.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.9.pidfd

for you to fetch changes up to e9c5263ce16d96311c118111ac779f004be8b473:

  libfs: improve path_from_stashed() (2024-03-01 22:31:40 +0100)

Please consider pulling these changes from the signed vfs-6.9.pidfd tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.9.pidfd

----------------------------------------------------------------
Christian Brauner (9):
      pidfd: allow to override signal scope in pidfd_send_signal()
      pidfd: move struct pidfd_fops
      pidfd: add pidfs
      libfs: add path_from_stashed()
      nsfs: convert to path_from_stashed() helper
      pidfs: convert to path_from_stashed() helper
      libfs: improve path_from_stashed() helper
      libfs: add stashed_dentry_prune()
      libfs: improve path_from_stashed()

Oleg Nesterov (11):
      pidfd: cleanup the usage of __pidfd_prepare's flags
      pidfd: don't do_notify_pidfd() if !thread_group_empty()
      pidfd: implement PIDFD_THREAD flag for pidfd_open()
      pidfd_poll: report POLLHUP when pid_task() == NULL
      pidfd: kill the no longer needed do_notify_pidfd() in de_thread()
      pid: kill the obsolete PIDTYPE_PID code in transfer_pid()
      pidfd: change do_notify_pidfd() to use __wake_up(poll_to_key(EPOLLIN))
      pidfd: exit: kill the no longer used thread_group_exited()
      pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together
      signal: fill in si_code in prepare_kill_siginfo()
      pidfd: change pidfd_send_signal() to respect PIDFD_THREAD

Tycho Andersen (2):
      pidfd: getfd should always report ESRCH if a task is exiting
      selftests: add ESRCH tests for pidfd_getfd()

Wang Jinchao (1):
      fork: Using clone_flags for legacy clone check

 fs/Kconfig                                       |   7 +
 fs/Makefile                                      |   2 +-
 fs/exec.c                                        |   1 -
 fs/internal.h                                    |   7 +
 fs/libfs.c                                       | 142 +++++++++++
 fs/nsfs.c                                        | 121 +++-------
 fs/pidfs.c                                       | 290 +++++++++++++++++++++++
 include/linux/ns_common.h                        |   2 +-
 include/linux/pid.h                              |  10 +-
 include/linux/pidfs.h                            |   9 +
 include/linux/proc_ns.h                          |   2 +-
 include/linux/sched/signal.h                     |   2 -
 include/uapi/linux/magic.h                       |   1 +
 include/uapi/linux/pidfd.h                       |   8 +-
 init/main.c                                      |   2 +
 kernel/exit.c                                    |  31 +--
 kernel/fork.c                                    | 147 ++----------
 kernel/nsproxy.c                                 |   2 +-
 kernel/pid.c                                     |  57 +++--
 kernel/signal.c                                  | 110 ++++++---
 tools/testing/selftests/pidfd/pidfd_getfd_test.c |  31 ++-
 21 files changed, 686 insertions(+), 298 deletions(-)
 create mode 100644 fs/pidfs.c
 create mode 100644 include/linux/pidfs.h

