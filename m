Return-Path: <linux-fsdevel+bounces-43220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD423A4FB3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889C816AC1B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF15D1E2847;
	Wed,  5 Mar 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4D6/OIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA1D1C8612
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169307; cv=none; b=k7SttZZOcDNZlKCicWZckeaYFnBWalbB8zr7jyekeD1n+DC7JW6ge0FRf2G4JJhTTqzla+HHS5ULzCmeVXKxo+H3FzqoyXvjYrO+zCREPy2+mNtDhaK6x3CNsjnWjDZA0VTDbkccO9jezP02sbyLr8srBirOCfTdTjY/awrlOfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169307; c=relaxed/simple;
	bh=PakJbtOLsErmvHODbt34x1pDlUJ1YJztU3tgcBWwbo4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z2VQzscTzMKysXIDRFsTlN/3mkKbLCWrOfAHq34kooE6LSV7u97rMahmlj+CCm/3oZYf5gGJ/1UdeLfzMhKk8N4UtD61itC446njXlWjwWt03j1tJK2BqHxucJS0ZkFwxJDjYK8raKgAfX3QZz7jsj73Yr89ysol+7Q7DsXyKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4D6/OIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FB0C4CEE2;
	Wed,  5 Mar 2025 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169306;
	bh=PakJbtOLsErmvHODbt34x1pDlUJ1YJztU3tgcBWwbo4=;
	h=From:Subject:Date:To:Cc:From;
	b=k4D6/OIUU1rGnrLG3c/szj5vwyocFI0pK7iizGLl3WnZMA11LjYRTOEQ6GudjfAF6
	 /0e9mY1Aa6R6sFrreZ6HRHtaRoz+T8c1i7n2YXVxZXA/C+0csgl3sfi6uFXjKltMEj
	 f28uKpHD7uy2/IPmY23RdyrQVK661wQvNBBDfFF0ObPmxC7OmIviPn1+nfGFO+qZUP
	 nw22w8yaDHcDz5ED5vDxvD+9npyTBNLT828AqDLXEFhaQWiKetFPO74l0lcEJ/Q62p
	 naFp4OfzVHAkR+b7DrNR9h6A+AYQOSPOGFJjkNxQNDiWdtvr92OY+si/Su+ZEeiiS3
	 +R6SdcKC+MJvA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v3 00/16] pidfs: provide information after task has been
 reaped
Date: Wed, 05 Mar 2025 11:08:10 +0100
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIoiyGcC/4XO0QqCMBQG4FeJXTfR42zRVe8RIZs70+HYZJNVh
 O/eFCK68vKH83//eZOIwWAkl8ObBEwmGu9yqI8H0g3C9UiNyplACU0JwOnDh5FORulIR2Nt611
 rRZzbzvqIVECtlIZKScZJNqaA2jw3/3bPWYp8JINw3bCqKSunomqKDVwLg4mzD6/tn1Stte/0e
 Wc6VbSkjVQcT1IyOON1xODQFj70ZN1O8OPqku1xkDnGtBKdFoJL/scty/IBwD6nUzsBAAA=
X-Change-ID: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4178; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PakJbtOLsErmvHODbt34x1pDlUJ1YJztU3tgcBWwbo4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJq+z95BuiX2Wt3eTauDGjhZs/o68pjv9EzUupFye
 KKX2U2DjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlsW8jwV+B9kmvdnOIFdk3p
 sQzJB63/RXC63ueyXbUpwIPzplTzIUaGeyXXz7rcn/f9Jfu8F/Ofic98lxdXLec7qz/R5ADTl78
 fuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Various tools need access to information about a process/task even after
it has already been reaped. For example, systemd's journal logs and uses
such information as the cgroup id and exit status to deal with processes
that have been sent via SCM_PIDFD or SCM_PEERPIDFD. By the time the
pidfd is received the process might have already been reaped.

This series aims to provide information by extending the PIDFD_GET_INFO
ioctl to retrieve the exit code and cgroup id. There might be other
stuff that we would want in the future.

Pidfd polling allows waiting on either task exit or for a task to have
been reaped. The contract for PIDFD_INFO_EXIT is simply that EPOLLHUP
must be observed before exit information can be retrieved, i.e., exit
information is only provided once the task has been reaped.

Note, that if a thread-group leader exits before other threads in the
thread-group then exit information will only be available once the
thread-group is empty. This aligns with wait() as well, where reaping of
a thread-group leader that exited before the thread-group was empty is
delayed until the thread-group is empty.

With PIDFD_INFO_EXIT autoreaping might actually become usable because it
means a parent can ignore SIGCHLD or set SA_NOCLDWAIT and simply use
pidfd polling and PIDFD_INFO_EXIT to get get status information for its
children. The kernel will autocleanup right away instead of delaying.

This includes expansive selftests including for thread-group behior and
multi-threaded exec by a non-thread-group leader thread.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v3:
- Fix various minor issues.
- Link to v2: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org

Changes in v2:
- Call pidfs_exit() from release_task().
- Don't provide exit information once the task has exited but once the
  task has been reaped. This makes for simpler semantics. Thus, call
  pidfs_exit() from release_task().
- Link to v1: https://lore.kernel.org/r/20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org

---
Christian Brauner (16):
      pidfs: switch to copy_struct_to_user()
      pidfd: rely on automatic cleanup in __pidfd_prepare()
      pidfs: move setting flags into pidfs_alloc_file()
      pidfs: use private inode slab cache
      pidfs: record exit code and cgroupid at exit
      pidfs: allow to retrieve exit information
      selftests/pidfd: fix header inclusion
      pidfs/selftests: ensure correct headers for ioctl handling
      selftests/pidfd: expand common pidfd header
      selftests/pidfd: add first PIDFD_INFO_EXIT selftest
      selftests/pidfd: add second PIDFD_INFO_EXIT selftest
      selftests/pidfd: add third PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fourth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fifth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add sixth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add seventh PIDFD_INFO_EXIT selftest

 fs/internal.h                                     |   1 +
 fs/libfs.c                                        |   4 +-
 fs/pidfs.c                                        | 182 +++++++-
 include/linux/pidfs.h                             |   1 +
 include/uapi/linux/pidfd.h                        |   3 +-
 kernel/exit.c                                     |   2 +
 kernel/fork.c                                     |  15 +-
 tools/testing/selftests/pidfd/.gitignore          |   2 +
 tools/testing/selftests/pidfd/Makefile            |   4 +-
 tools/testing/selftests/pidfd/pidfd.h             |  93 ++++
 tools/testing/selftests/pidfd/pidfd_exec_helper.c |  12 +
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |   1 +
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 497 ++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c   |  26 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  |  45 --
 15 files changed, 783 insertions(+), 105 deletions(-)
---
base-commit: b1e809e7f64ad47dd232ff072d8ef59c1fe414c5
change-id: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47


