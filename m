Return-Path: <linux-fsdevel+bounces-49768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC2AC22EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5600BA255CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BE3EA98;
	Fri, 23 May 2025 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCCZWlnG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FC22615;
	Fri, 23 May 2025 12:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004062; cv=none; b=IfeYEwzpbjnIrumLR67aLdQXvKiaLiW/7Ebh5sR0wCz9FUjJjRE7XEiGa/uf+SiZlTHr6ewkHCot1Gmg5tuQOdAkOJJhc834v13vtmLWnCWzezWVA8vSIjb1mcak3cOLcH4PWaZaol7WacbmuI1vUG7i9yACtTLj+8ymtzslMvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004062; c=relaxed/simple;
	bh=ZoXPGBMK34S3hwGwDWnwtbk3EiApmAGlYybHZYAaUUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpcKlPHhfAT5BjzfZ2/M7CgQF/7VNGeT7njLP/TJ8LTvggUybFcoIbqWhFzD/8eQg9lQOf5dgMmY6nlB+QR+DKjQ/I6lWZ0be9774Jv4MV5MrST4NlvzM0vW1Wn/Gwj82e26Dm45GBiQBSFtBLBoINYZX3JzrTz9CBLDH7VMU7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCCZWlnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E847CC4CEEF;
	Fri, 23 May 2025 12:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004062;
	bh=ZoXPGBMK34S3hwGwDWnwtbk3EiApmAGlYybHZYAaUUE=;
	h=From:To:Cc:Subject:Date:From;
	b=DCCZWlnGUy+YY8jWbCXQWwyr1npMFB/JVB9NncChQOIIeHhZSU+u53oOUni6PNJL6
	 SHFELiW91Nid10cC2t803ZNWWLMy5YqjvqLikY1FhmBbJRzn9t1lqezvv58wGzUdJ5
	 HCVYkfQP9YzA+QP1EI/J6hM6/p234fZ5VgXVnDWx3CfrQBd0SMppF3RfTKQ7Q5s12f
	 bLNe+NYOf0eUhUrloStDygyn4gTtFXCU8gyqCNAjVxa42O/P1AzfKPQJR0N5oF2GmT
	 bB78tnajTJPOR+RnvHoCOD1TGGlAnF8Qw5PLjI1XG5wD81T55td612kN5sGjqijxhA
	 hNI7UTd+OZkcQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs pidfs
Date: Fri, 23 May 2025 14:40:47 +0200
Message-ID: <20250523-vfs-pidfs-aa1d59a1e9b3@brauner>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10317; i=brauner@kernel.org; h=from:subject:message-id; bh=ZoXPGBMK34S3hwGwDWnwtbk3EiApmAGlYybHZYAaUUE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5FwNdZp5cuLzzBst/87mbLM39rgj15a27fZCweQNM /69jYxV7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjINl9GhmMdt9ZsqX4b8/kt n2twYLReVVPkFJcpJ08Kn1hWsnz5HiWGf9ZnVqk1zSp8cLt1zco0Kd25z5MX9J5Sr3kqq7zFZNZ HVR4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This pull request serves as the base for the coredump pull request I'm
sending separately:

https://lore.kernel.org/20250523-vfs-coredump-66643655f2fe@brauner

The reason is simply that this branch has been in -next for such a long
time that clearly delineating both topics by moving things around would
have caused more churn for little gain since the relationship is tight
enough that it fits into both categories.

/* Summary */

This contains pidfs updates for this cycle:

Features:

- Allow to hand out pidfds for reaped tasks for AF_UNIX SO_PEERPIDFD
  socket option.

  SO_PEERPIDFD is a socket option that allows to retrieve a pidfd for
  the process that called connect() or listen(). This is heavily used to
  safely authenticate clients in userspace avoiding security bugs due to
  pid recycling races (dbus, polkit, systemd, etc.).

  SO_PEERPIDFD currently doesn't support handing out pidfds if the
  sk->sk_peer_pid thread-group leader has already been reaped. In this
  case it currently returns EINVAL. Userspace still wants to get a pidfd
  for a reaped process to have a stable handle it can pass on. This is
  especially useful now that it is possible to retrieve exit information
  through a pidfd via the PIDFD_GET_INFO ioctl()'s PIDFD_INFO_EXIT flag.

  Another summary has been provided by David Rheinsberg:

  > A pidfd can outlive the task it refers to, and thus user-space must
  > already be prepared that the task underlying a pidfd is gone at the time
  > they get their hands on the pidfd. For instance, resolving the pidfd to
  > a PID via the fdinfo must be prepared to read `-1`.
  >
  > Despite user-space knowing that a pidfd might be stale, several kernel
  > APIs currently add another layer that checks for this. In particular,
  > SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
  > but returns a stale pidfd if the task is reaped immediately after the
  > respective alive-check.
  >
  > This has the unfortunate effect that user-space now has two ways to
  > check for the exact same scenario: A syscall might return
  > EINVAL/ESRCH/... *or* the pidfd might be stale, even though there is no
  > particular reason to distinguish both cases. This also propagates
  > through user-space APIs, which pass on pidfds. They must be prepared to
  > pass on `-1` *or* the pidfd, because there is no guaranteed way to get a
  > stale pidfd from the kernel.
  > Userspace must already deal with a pidfd referring to a reaped task as
  > the task may exit and get reaped at any time will there are still many
  > pidfds referring to it.

  In order to allow handing out reaped pidfd SO_PEERPIDFD needs to ensure
  that PIDFD_INFO_EXIT information is available whenever a pidfd for a
  reaped task is created by PIDFD_INFO_EXIT. The uapi promises that reaped
  pidfds are only handed out if it is guaranteed that the caller sees the
  exit information:

  TEST_F(pidfd_info, success_reaped)
  {
          struct pidfd_info info = {
                  .mask = PIDFD_INFO_CGROUPID | PIDFD_INFO_EXIT,
          };

          /*
           * Process has already been reaped and PIDFD_INFO_EXIT been set.
           * Verify that we can retrieve the exit status of the process.
           */
          ASSERT_EQ(ioctl(self->child_pidfd4, PIDFD_GET_INFO, &info), 0);
          ASSERT_FALSE(!!(info.mask & PIDFD_INFO_CREDS));
          ASSERT_TRUE(!!(info.mask & PIDFD_INFO_EXIT));
          ASSERT_TRUE(WIFEXITED(info.exit_code));
          ASSERT_EQ(WEXITSTATUS(info.exit_code), 0);
  }

  To hand out pidfds for reaped processes we thus allocate a pidfs entry
  for the relevant sk->sk_peer_pid at the time the sk->sk_peer_pid is
  stashed and drop it when the socket is destroyed. This guarantees that
  exit information will always be recorded for the sk->sk_peer_pid task
  and we can hand out pidfds for reaped processes.

- Hand a pidfd to the coredump usermode helper process.

  Give userspace a way to instruct the kernel to install a pidfd for the
  crashing process into the process started as a usermode helper. There's
  still tricky race-windows that cannot be easily or sometimes not closed
  at all by userspace. There's various ways like looking at the start time
  of a process to make sure that the usermode helper process is started
  after the crashing process but it's all very very brittle and fraught
  with peril.

  The crashed-but-not-reaped process can be killed by userspace before
  coredump processing programs like systemd-coredump have had time to
  manually open a PIDFD from the PID the kernel provides them, which means
  they can be tricked into reading from an arbitrary process, and they run
  with full privileges as they are usermode helper processes.

  Even if that specific race-window wouldn't exist it's still the safest
  and cleanest way to let the kernel provide the pidfd directly instead of
  requiring userspace to do it manually. In parallel with this commit we
  already have systemd adding support for this in [1].

  When the usermode helper process is forked we install a pidfd file
  descriptor three into the usermode helper's file descriptor table so
  it's available to the exec'd program.

  Since usermode helpers are either children of the system_unbound_wq
  workqueue or kthreadd we know that the file descriptor table is empty
  and can thus always use three as the file descriptor number.

  Note, that we'll install a pidfd for the thread-group leader even if a
  subthread is calling do_coredump(). We know that task linkage hasn't
  been removed yet and even if this @current isn't the actual thread-group
  leader we know that the thread-group leader cannot be reaped until
  @current has exited.

- Allow to tell when a task has not been found from finding the wrong
  task when creating a pidfd.

  We currently report EINVAL whenever a struct pid has no tasked attached
  anymore thereby conflating two concepts:

  (1) The task has already been reaped.
  (2) The caller requested a pidfd for a thread-group leader but the pid
      actually references a struct pid that isn't used as a thread-group
      leader.

  This is causing issues for non-threaded workloads as in where they
  expect ESRCH to be reported, not EINVAL.

  So allow userspace to reliably distinguish between (1) and (2).

- Make it possible to detect when a pidfs entry would outlive the struct
  pid it pinned.

- Add a range of new selftests.

Cleanups:

- Remove unneeded NULL check from pidfd_prepare() for passed struct pid.

- Avoid pointless reference count bump during release_task().

Fixes:

- Various fixes to the pidfd and coredump selftests.

- Fix error handling for replace_fd() when spawning coredump usermode helper.

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

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.pidfs

for you to fetch changes up to db56723ceaec87aa5cf871e623f464934b266228:

  pidfs: detect refcount bugs (2025-05-06 13:59:00 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.pidfs tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.pidfs

----------------------------------------------------------------
Christian Brauner (20):
      selftests/pidfd: adapt to recent changes
      pidfd: remove unneeded NULL check from pidfd_prepare()
      pidfd: improve uapi when task isn't found
      selftest/pidfd: add test for thread-group leader pidfd open for thread
      Merge patch series "pidfd: improve uapi when task isn't found"
      exit: move wake_up_all() pidfd waiters into __unhash_process()
      pidfs: ensure consistent ENOENT/ESRCH reporting
      Merge patch series "pidfs: ensure consistent ENOENT/ESRCH reporting"
      net, pidfd: report EINVAL for ESRCH
      pidfs: register pid in pidfs
      net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid
      pidfs: get rid of __pidfd_prepare()
      net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid
      Merge patch series "net, pidfs: enable handing out pidfds for reaped sk->sk_peer_pid"
      Merge patch series "selftests: coredump: Some bug fixes"
      pidfs: move O_RDWR into pidfs_alloc_file()
      coredump: fix error handling for replace_fd()
      coredump: hand a pidfd to the usermode coredump helper
      Merge patch series "coredump: hand a pidfd to the usermode coredump helper"
      pidfs: detect refcount bugs

Nam Cao (3):
      selftests: coredump: Properly initialize pointer
      selftests: coredump: Fix test failure for slow machines
      selftests: coredump: Raise timeout to 2 minutes

Oleg Nesterov (1):
      release_task: kill the no longer needed get/put_pid(thread_pid)

 fs/coredump.c                                     | 65 +++++++++++++++--
 fs/pidfs.c                                        | 82 ++++++++++++++++++---
 include/linux/coredump.h                          |  1 +
 include/linux/pid.h                               |  2 +-
 include/linux/pidfs.h                             |  3 +
 include/uapi/linux/pidfd.h                        |  2 +-
 kernel/exit.c                                     | 10 ++-
 kernel/fork.c                                     | 88 ++++++++++-------------
 kernel/pid.c                                      |  6 +-
 net/core/sock.c                                   | 12 +++-
 net/unix/af_unix.c                                | 85 +++++++++++++++++++---
 tools/testing/selftests/coredump/stackdump_test.c | 10 ++-
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 13 ++--
 13 files changed, 286 insertions(+), 93 deletions(-)

