Return-Path: <linux-fsdevel+bounces-39584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C91A15D1C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 14:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6C8188605B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 13:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5844518C00B;
	Sat, 18 Jan 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzy6Qgqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10FDA95C;
	Sat, 18 Jan 2025 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737205524; cv=none; b=PbK+peNk4rnXm8LmShc+5Wp5UKn3xl4zQzalofzioR4RLseBLaxMcutXe5iwqC+1CDvXEftkwYEyS4gXK5Qh6PRDd/86HltvhzfPta9QyS86xQUuPOyRxtqIbAlcQ26kSvbIBlCb6kCzqiv8dSyhnfxR/sbeCT9uxM7xSMv7E9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737205524; c=relaxed/simple;
	bh=kOo96Q5ZeoKL8kcavm9FQv8wUg/r+9DBcZykswn4f50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t205l1+q3UlVcf8KvSQAbg1d8pDbgDGKev/yyyQK+XYy/ojf77hCWk7NSPDCzxvCWphXldSfwej2XWc6Sut5HmD2wet9ODVvolqt7V1ZCgZ74yhw6uWjc0SxfufeBraylHpdh7Pws87HfDXeL/vGEfjJeDGwec1VwneT5WdJPh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzy6Qgqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D2DC4CED1;
	Sat, 18 Jan 2025 13:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737205524;
	bh=kOo96Q5ZeoKL8kcavm9FQv8wUg/r+9DBcZykswn4f50=;
	h=From:To:Cc:Subject:Date:From;
	b=qzy6QgqhoRqVMDwQHQhyaJ0TI7muNIjfM5sepSSmk4BAXewE9oQcf0F+SbHGDvxLz
	 cOcpEnw+soxPD9ZoyXZ0wwNLUN4ckfsm2p6REqKAvQ471zyiZ6UJsQxmGdqPntyfi9
	 9ObXrnoyWCZHiswZ/8fOVIx7mdkzp82ulpT5YTJTy+zgKz6vpZkmmXmXBLzxqRrxWv
	 FbPLIwOUTOxnxegrrmL++g5ud3IuzdjMoPRKtZeUCd1i3vCTScBhXF2+Fn1YqTFkfi
	 PjX7m8jFN4LDUwL/jTUtCTYwRTRwX5FpsbwXCHKA8zhl4t56qziSrwv4iREZVFbHYq
	 7Y3e+EvjufJUw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] pid namespace
Date: Sat, 18 Jan 2025 14:04:59 +0100
Message-ID: <20250118-kernel-pid-ae69412addff@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5904; i=brauner@kernel.org; h=from:subject:message-id; bh=kOo96Q5ZeoKL8kcavm9FQv8wUg/r+9DBcZykswn4f50=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR3L2f9sfw2T3eQ+4HDniY+mZM2nJ+6R8XVzkM+y7K2Y pr54k/3O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyMJiR4dK0DB9Jj923UzIe WhnUrpqoeGiVrc1aKV/lY3M/TVhy4Asjw/vmx1vaNgmK835OMdV6aX7M9VBa3OqtUoXmooIPPq5 m5AcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

The pid_max sysctl is a global value. For a long time the default value
has been 65535 and during the pidfd dicussions Linus proposed to bump
pid_max by default (cf. [1]). Based on this discussion systemd started
bumping pid_max to 2^22. So all new systems now run with a very high
pid_max limit with some distros having also backported that change.
The decision to bump pid_max is obviously correct. It just doesn't make
a lot of sense nowadays to enforce such a low pid number. There's
sufficient tooling to make selecting specific processes without typing
really large pid numbers available.

In any case, there are workloads that have expections about how large
pid numbers they accept. Either for historical reasons or architectural
reasons. One concreate example is the 32-bit version of Android's bionic
libc which requires pid numbers less than 65536. There are workloads
where it is run in a 32-bit container on a 64-bit kernel. If the host
has a pid_max value greater than 65535 the libc will abort thread
creation because of size assumptions of pthread_mutex_t.

That's a fairly specific use-case however, in general specific workloads
that are moved into containers running on a host with a new kernel and a
new systemd can run into issues with large pid_max values. Obviously
making assumptions about the size of the allocated pid is suboptimal but
we have userspace that does it.

Of course, giving containers the ability to restrict the number of
processes in their respective pid namespace indepent of the global limit
through pid_max is something desirable in itself and comes in handy in
general.

Independent of motivating use-cases the existence of pid namespaces
makes this also a good semantical extension and there have been prior
proposals pushing in a similar direction.
The trick here is to minimize the risk of regressions which I think is
doable. The fact that pid namespaces are hierarchical will help us here.

What we mostly care about is that when the host sets a low pid_max
limit, say (crazy number) 100 that no descendant pid namespace can
allocate a higher pid number in its namespace. Since pid allocation is
hierarchial this can be ensured by checking each pid allocation against
the pid namespace's pid_max limit. This means if the allocation in the
descendant pid namespace succeeds, the ancestor pid namespace can reject
it. If the ancestor pid namespace has a higher limit than the descendant
pid namespace the descendant pid namespace will reject the pid
allocation. The ancestor pid namespace will obviously not care about
this.

All in all this means pid_max continues to enforce a system wide limit
on the number of processes but allows pid namespaces sufficient leeway
in handling workloads with assumptions about pid values and allows
containers to restrict the number of processes in a pid namespace
through the pid_max interface.

[1]: https://lore.kernel.org/linux-api/CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com

/* Testing */

gcc version 14.2.0 (Debian 14.2.0-6)
Debian clang version 16.0.6 (27+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This will have a merge conflict with vfs-6.14.mount pull request sent in
https://lore.kernel.org/r/20250118-vfs-pidfs-5921bfa5632a@brauner
and it can be resolved as follows:

diff --cc kernel/pid.c
index aa2a7d4da455,ce3e94e26a0f..000000000000
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@@ -61,10 -60,13 +61,8 @@@ struct pid init_struct_pid =
        }, }
  };

- int pid_max = PID_MAX_DEFAULT;
-
- int pid_max_min = RESERVED_PIDS + 1;
- int pid_max_max = PID_MAX_LIMIT;
+ static int pid_max_min = RESERVED_PIDS + 1;
+ static int pid_max_max = PID_MAX_LIMIT;
 -/*
 - * Pseudo filesystems start inode numbering after one. We use Reserved
 - * PIDs as a natural offset.
 - */
 -static u64 pidfs_ino = RESERVED_PIDS;

  /*
   * PID-map pages start out as NULL, they get allocated upon

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-6.14-rc1.pid

for you to fetch changes up to c625aa276319f51e307ca10401baac4628bb25c2:

  Merge patch series "pid_namespace: namespacify sysctl kernel.pid_max" (2024-12-02 11:25:26 +0100)

Please consider pulling these changes from the signed kernel-6.14-rc1.pid tag.

Thanks!
Christian

----------------------------------------------------------------
kernel-6.14-rc1.pid

----------------------------------------------------------------
Christian Brauner (3):
      pid: allow pid_max to be set per pid namespace
      tests/pid_namespace: add pid_max tests
      Merge patch series "pid_namespace: namespacify sysctl kernel.pid_max"

 include/linux/pid.h                              |   3 -
 include/linux/pid_namespace.h                    |  10 +-
 kernel/pid.c                                     | 125 +++++++-
 kernel/pid_namespace.c                           |  43 ++-
 kernel/sysctl.c                                  |   9 -
 kernel/trace/pid_list.c                          |   2 +-
 kernel/trace/trace.h                             |   2 -
 kernel/trace/trace_sched_switch.c                |   2 +-
 tools/testing/selftests/pid_namespace/.gitignore |   1 +
 tools/testing/selftests/pid_namespace/Makefile   |   2 +-
 tools/testing/selftests/pid_namespace/pid_max.c  | 358 +++++++++++++++++++++++
 11 files changed, 521 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/pid_namespace/pid_max.c

