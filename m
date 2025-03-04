Return-Path: <linux-fsdevel+bounces-43056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81853A4D8E4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891FE7A89A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC51FDE03;
	Tue,  4 Mar 2025 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te7kvjWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC21FDA9D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081279; cv=none; b=Fv+yk/OJZdLQyyA/uzZjEqBwjO+PWwlOMkUcklnyJeu2qEU1LaJJyHS6jmw/qYJa9E8gsdMmiSceNslTS0XiYGnmIHgj5cL1GaYpc4s37/ThOUQnyr5TMEqjEcve6AlSpp9jr0Bw2/BeJqg2ZHpkThPAlJxIo5LnIGSexjU6+j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081279; c=relaxed/simple;
	bh=+VgV9nECdZYpwMtw1XRy1qAEgzF6xYEi+wEeDAC/cx8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TZePU9JVZtobk/CVYOGb36KdCzYeKjvcB6SB4lO1xxwJTzrV/HXLscY796lSN1dJfLpVpuV7Wc0tJYzv2ZQaxzWysME/fEcMmNjUM2vg5jJnOdV1+mqB9q8VcC2GTr+ZVIHkI8/yIAgiu6nYzE4ceUbRQIaZLkm1jb6BmjYOoOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te7kvjWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BE6C4CEE9;
	Tue,  4 Mar 2025 09:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081277;
	bh=+VgV9nECdZYpwMtw1XRy1qAEgzF6xYEi+wEeDAC/cx8=;
	h=From:Subject:Date:To:Cc:From;
	b=Te7kvjWzohLPH7EdBqaPg2tX+CEikvuTXIOAsGshRMt00HkuzwHQGpngWwlTtqGxB
	 5kf018Gp8uxCI2dA2A1Ufi9BchJgYcgf8en1AAPQDpkyXal1XW7wRty9SljMoQqykH
	 AbNNVKa+6gTqqzA1exh5gQNAJMVtDIuzt9ejPDRACoOMpZD+RyJk881MXBMgTLLj6q
	 eWHfQfFTtRvMusAlW78ZZvTFrWywkgyjQ4tetvnnHMNJIroQSuZbIktKBLy8Sik/7U
	 TezwYvN2hELo675EAknDhArTl/s/48Uzo9s6q/+5kf++Yc4C5urTqrekbEO+aNR+Qz
	 E+tq3PWPuL1gQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v2 00/15] pidfs: provide information after task has been
 reaped
Date: Tue, 04 Mar 2025 10:41:00 +0100
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKzKxmcC/4WOywqDMBREf6Vk3Yi59UVX/Y8ikpirXgyJJJK2i
 P/eKHTd5YGZM7OxgJ4wsPtlYx4jBXI2AVwvrJ+kHZGTTswghzIHqPnL+ZkvpIfAZzKmc7YzMqx
 db1xALuGm9QBCq6JmybF4HOh9+p9tYiVTSHlp++mwxmSpMlFmp/AoTBRW5z/nnyiO2m+6+TMdB
 c95qXSNlVIFNPiY0Vs0mfMja/d9/wLxtM2D7AAAAA==
X-Change-ID: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=3775; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+VgV9nECdZYpwMtw1XRy1qAEgzF6xYEi+wEeDAC/cx8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Vrj1qvowenyNfCbv2ZYc6ZBh80eYSN95anZZnGH
 DsudnFKRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETynjEyzP98dw1vQdqZQznt
 C1x+Xdq+6XfOrAMWV7R/Fv9NSN5WG8DI0D0rS23PiTfq+lERAgn12+a93XFrZv7+s6E7vNiquO8
 U8gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

Various tools need access to information about a process/task even after
it has already been reaped. For example, systemd's journal logs
and uses such information as the cgroup id and exit status to deal with
processes that have been sent via SCM_PIDFD or SCM_PEERPIDFD. By the
time the pidfd is received the process might have already been reaped.

This series aims to provide information by extending the PIDFD_GET_INFO
ioctl to retrieve the exit code and cgroup id. There might be other
stuff that we would want in the future.

Pidfd
polling allows waiting on either task exit or for a task to have been
reaped. The contract for PIDFD_INFO_EXIT is simply that EPOLLHUP must
be observed before exit information can be retrieved, i.e., exit
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

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Call pidfs_exit() from release_task().
- Don't provide exit information once the task has exited but once the
  task has been reaped. This makes for simpler semantics. Thus, call
  pidfs_exit() from release_task().
- Link to v1: https://lore.kernel.org/r/20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org

---
Christian Brauner (15):
      pidfs: switch to copy_struct_to_user()
      pidfd: rely on automatic cleanup in __pidfd_prepare()
      pidfs: move setting flags into pidfs_alloc_file()
      pidfs: add inode allocation
      pidfs: record exit code and cgroupid at exit
      pidfs: allow to retrieve exit information
      selftests/pidfd: fix header inclusion
      pidfs/selftests: ensure correct headers for ioctl handling
      selftests/pidfd: move more defines to common header
      selftests/pidfd: add first PIDFD_INFO_EXIT selftest
      selftests/pidfd: add second PIDFD_INFO_EXIT selftest
      selftests/pidfd: add third PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fourth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add fifth PIDFD_INFO_EXIT selftest
      selftests/pidfd: add sixth PIDFD_INFO_EXIT selftest

 fs/internal.h                                     |   1 +
 fs/libfs.c                                        |   4 +-
 fs/pidfs.c                                        | 182 +++++++++--
 include/linux/pidfs.h                             |   1 +
 include/uapi/linux/pidfd.h                        |   3 +-
 kernel/exit.c                                     |   2 +
 kernel/fork.c                                     |  15 +-
 tools/testing/selftests/pidfd/.gitignore          |   1 +
 tools/testing/selftests/pidfd/Makefile            |   2 +-
 tools/testing/selftests/pidfd/pidfd.h             |  86 +++++
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c |   1 +
 tools/testing/selftests/pidfd/pidfd_info_test.c   | 372 ++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c   |  26 --
 tools/testing/selftests/pidfd/pidfd_setns_test.c  |  45 ---
 14 files changed, 636 insertions(+), 105 deletions(-)
---
base-commit: b1e809e7f64ad47dd232ff072d8ef59c1fe414c5
change-id: 20250227-work-pidfs-kill_on_last_close-a23ddf21db47


