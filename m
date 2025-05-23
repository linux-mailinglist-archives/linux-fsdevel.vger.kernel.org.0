Return-Path: <linux-fsdevel+bounces-49770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83964AC22F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 14:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41951C008AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 12:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B4B34545;
	Fri, 23 May 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gplhgMxk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F626ADD;
	Fri, 23 May 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748004551; cv=none; b=LZUT88dUeS6dgC+FappEKbcd7218Uid/x22YF5JS+tdHVH4S9awbBXae3FCS9FV7CyawknQGqUH6bEeg1muaTmpTuADsZPKSzHxc0JTntySlHn7EkfNgNVG2/6buUGdOUUvUkTa52lFCfsdZus34u93IovlZ/clbdVDbEvg2/Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748004551; c=relaxed/simple;
	bh=gTEYpsNlc2qTjVq+ArxyDs8muGDEPhbsR+yxgnqZBxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHxVwHkBjuKxA3EMsAHPzhRu+R/IOfZUP+rFE0CG3qh0qUJW0H63DLbiLfnPIqFl6oGxMzo7NxZQsdn80hURjdSUFqCQUanyl/oep3dU4o6YFV6NF+SSCg/PFBfHPTwT3v6kiBnnyFuY5acM+jT71EUcp6326japRScek28IMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gplhgMxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A9C4CEE9;
	Fri, 23 May 2025 12:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748004549;
	bh=gTEYpsNlc2qTjVq+ArxyDs8muGDEPhbsR+yxgnqZBxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gplhgMxkqq/vS9s/sJvL7TgaPj4v1fT1RVxueCSS0AapDdX+5HJvedXGPdoiBOCjW
	 KZkCX0TcYBt32wAT8JSkBn5BcZQn4rPF/b5Hdhml4MM+PrRpn29VcgFUAbTAQubS2b
	 UyN3gFeBsskoLTKHHIpfllgu4qYj2lhIvCgvlnTZOD6Ns1kU5owzPF7P21/LR4RZS8
	 pSmKVywxbYN7d2DfvXCVRxL6JH6LFEDjXaJNbPjwUN/4o5TXqEJb/xzJcsLdY1at+E
	 UJtT7kUvv2+RJV1Keltum/ByjkCtQqcbsSpzL4CcyDzWvYhCNOb4o7AFxjRmEBSNXE
	 0G3eJt3+ME7YQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v6.16] vfs coredump
Date: Fri, 23 May 2025 14:42:11 +0200
Message-ID: <20250523-vfs-coredump-66643655f2fe@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250523-vfs-pidfs-aa1d59a1e9b3@brauner>
References: <20250523-vfs-pidfs-aa1d59a1e9b3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9533; i=brauner@kernel.org; h=from:subject:message-id; bh=YQDYM1t+qaDZx39X5Zae6jcGUsNwYxVSsWoV1vYNiJA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQY5CaJKfzz3zCn01hS3n3JN7mbsTt3d4rL9n1d5xB1J PJQYqxvRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwET+v2dkmDJ9tV9xhdKTdQ95 K3qXFKpK813jL3u+fO6amZ86ZjN+e8rIsNV8r+yer/xf73EsvrVKLWPC7mldtvee6XcH7Sl9nZt /kB0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This pull request uses the pidfs pull request as base I'm sending out
separately as:

https://lore.kernel.org/20250523-vfs-pidfs-aa1d59a1e9b3@brauner

The reason is simply that the work here is sufficiently standalone that
it deserves a separate pull request but it builds on the work in the
pidfs pull request. Because it uses the ability for SO_PEERPIDFD to hand
out pidfds for reaped tasks.

I'm appending the full stat which includes the pidfd work just for
completeness sake.

/* Summary */

This adds support for sending coredumps over an AF_UNIX socket. It also
makes (implicit) use of the new SO_PEERPIDFD ability to hand out pidfds
for reaped peer tasks.

The new coredump socket will allow userspace to not have to rely on
usermode helpers for processing coredumps and provides a saf way to
handle them instead of relying on super privileged coredumping helpers.

This will also be significantly more lightweight since the kernel
doens't have to do a fork()+exec() for each crashing process to spawn a
usermodehelper. Instead the kernel just connects to the AF_UNIX socket
and userspace can process it concurrently however it sees fit. Support
for userspace is incoming starting with systemd-coredump.

There's more work coming in that direction next cycle. The rest below
goes into some details and background.

Coredumping currently supports two modes:

(1) Dumping directly into a file somewhere on the filesystem.
(2) Dumping into a pipe connected to a usermode helper process
    spawned as a child of the system_unbound_wq or kthreadd.

For simplicity I'm mostly ignoring (1). There's probably still some
users of (1) out there but processing coredumps in this way can be
considered adventurous especially in the face of set*id binaries.

The most common option should be (2) by now. It works by allowing
userspace to put a string into /proc/sys/kernel/core_pattern like:

        |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h

The "|" at the beginning indicates to the kernel that a pipe must be
used. The path following the pipe indicator is a path to a binary that
will be spawned as a usermode helper process. Any additional parameters
pass information about the task that is generating the coredump to the
binary that processes the coredump.

In the example the core_pattern shown causes the kernel to spawn
systemd-coredump as a usermode helper. There's various conceptual
consequences of this (non-exhaustive list):

- systemd-coredump is spawned with file descriptor number 0 (stdin)
  connected to the read-end of the pipe. All other file descriptors are
  closed. That specifically includes 1 (stdout) and 2 (stderr). This has
  already caused bugs because userspace assumed that this cannot happen
  (Whether or not this is a sane assumption is irrelevant.).

- systemd-coredump will be spawned as a child of system_unbound_wq. So
  it is not a child of any userspace process and specifically not a
  child of PID 1. It cannot be waited upon and is in a weird hybrid
  upcall which are difficult for userspace to control correctly.

- systemd-coredump is spawned with full kernel privileges. This
  necessitates all kinds of weird privilege dropping excercises in
  userspace to make this safe.

- A new usermode helper has to be spawned for each crashing process.

This adds a new mode:

(3) Dumping into an AF_UNIX socket.

Userspace can set /proc/sys/kernel/core_pattern to:

        @/path/to/coredump.socket

The "@" at the beginning indicates to the kernel that an AF_UNIX
coredump socket will be used to process coredumps.

The coredump socket must be located in the initial mount namespace.
When a task coredumps it opens a client socket in the initial network
namespace and connects to the coredump socket:

- The coredump server uses SO_PEERPIDFD to get a stable handle on
  the connected crashing task. The retrieved pidfd will provide a stable
  reference even if the crashing task gets SIGKILLed while generating
  the coredump. That is a huge attack vector right now.

- By setting core_pipe_limit non-zero userspace can guarantee that the
  crashing task cannot be reaped behind it's back and thus process all
  necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
  detect whether /proc/<pid> still refers to the same process.

  The core_pipe_limit isn't used to rate-limit connections to the
  socket. This can simply be done via AF_UNIX socket directly.

- The pidfd for the crashing task will contain information how the task
  coredumps. The PIDFD_GET_INFO ioctl gained a new flag
  PIDFD_INFO_COREDUMP which can be used to retreive the coredump
  information.

  If the coredump gets a new coredump client connection the kernel
  guarantees that PIDFD_INFO_COREDUMP information is available.
  Currently the following information is provided in the new
  @coredump_mask extension to struct pidfd_info:

  * PIDFD_COREDUMPED is raised if the task did actually coredump.
  * PIDFD_COREDUMP_SKIP is raised if the task skipped coredumping (e.g.,
    undumpable).
  * PIDFD_COREDUMP_USER is raised if this is a regular coredump and
    doesn't need special care by the coredump server.
  * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
    treated as sensitive and the coredump server should restrict access
    to the generated coredump to sufficiently privileged users.

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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.16-rc1.coredump

for you to fetch changes up to 4e83ae6ec87dddac070ba349d3b839589b1bb957:

  mips, net: ensure that SOCK_COREDUMP is defined (2025-05-23 11:02:16 +0200)

Please consider pulling these changes from the signed vfs-6.16-rc1.coredump tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.16-rc1.coredump

----------------------------------------------------------------
Christian Brauner (30):
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
      coredump: massage format_corename()
      coredump: massage do_coredump()
      coredump: reflow dump helpers a little
      coredump: add coredump socket
      pidfs, coredump: add PIDFD_INFO_COREDUMP
      coredump: show supported coredump modes
      coredump: validate socket name as it is written
      selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
      selftests/coredump: add tests for AF_UNIX coredumps
      Merge patch series "coredump: add coredump socket"
      mips, net: ensure that SOCK_COREDUMP is defined

Nam Cao (3):
      selftests: coredump: Properly initialize pointer
      selftests: coredump: Fix test failure for slow machines
      selftests: coredump: Raise timeout to 2 minutes

Oleg Nesterov (1):
      release_task: kill the no longer needed get/put_pid(thread_pid)

 arch/mips/include/asm/socket.h                    |   9 -
 fs/coredump.c                                     | 461 ++++++++++++++++-----
 fs/pidfs.c                                        | 137 ++++++-
 include/linux/coredump.h                          |   1 +
 include/linux/net.h                               |   4 +-
 include/linux/pid.h                               |   2 +-
 include/linux/pidfs.h                             |   8 +
 include/uapi/linux/pidfd.h                        |  18 +-
 kernel/exit.c                                     |  10 +-
 kernel/fork.c                                     |  88 ++--
 kernel/pid.c                                      |   5 -
 net/core/sock.c                                   |  12 +-
 net/unix/af_unix.c                                | 137 +++++--
 tools/testing/selftests/coredump/stackdump_test.c | 477 +++++++++++++++++++++-
 tools/testing/selftests/pidfd/pidfd.h             |  22 +
 tools/testing/selftests/pidfd/pidfd_info_test.c   |  13 +-
 16 files changed, 1198 insertions(+), 206 deletions(-)

