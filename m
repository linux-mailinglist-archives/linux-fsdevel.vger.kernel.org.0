Return-Path: <linux-fsdevel+bounces-70156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D755C92A1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954143AEC95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 16:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78DD2D8785;
	Fri, 28 Nov 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDyS/hEu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273682D781E;
	Fri, 28 Nov 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764348680; cv=none; b=QsXWMhHw7RPaBqKD+LP5v5Vr7hh9wvUoeoEyw4ECUGlheH3hFMEkEqKjeUloe41If9rTAyqffoWpvMtNqyOi7XC8s8epMRQrSHHU1TOAEg2pBsCcf0NjLB6Mb3VR4rdNh0htfq8AE09KCwDUht857sFBjo5RDWpPUFhExD+u+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764348680; c=relaxed/simple;
	bh=RyPom7KxKdfujps1/t+h+hzloxXukEX1VS1R+0d9Bd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITgEaJCGZV1Y7Lfs+8AKpAFasqb01KDhS2qtSS9zRZ4j5t/m5lB+6UZHsyXv7FJQASQYUrxs6UugwWG6Ymi6tfKl8JtFn3/VdMQvbVonnBTDr5qZ4+upTpinXyN78lbRZUR+/lvlrji5t4AgKeIh/yMbOfPCVQZ0BmD6EMd+Naw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDyS/hEu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4C4C19423;
	Fri, 28 Nov 2025 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764348679;
	bh=RyPom7KxKdfujps1/t+h+hzloxXukEX1VS1R+0d9Bd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDyS/hEuXJRdT3Fz5eBMzJ+XPUT4HhroLB3nqSfVNSz/7zbOnqto3+SGIoTuS8z8p
	 JCKopB1Ryk8UfkykHx31hP/QCinf0HihhNpyEGMPfTgKWI/+qyvU4qE/AcoBK+lF+t
	 kRYN6w5lvru/R7+fx+geNqrAzmpUV97uJPX1utzIY22LvzuZqsaSZIom5kS6yInZ8I
	 gO5Y1foSJWfznvyFJnNcoZJ+Pa2tCBh6SUlQ6S6DT45didOEJwaMFdfTj5Mr3zjfkZ
	 hRrlephZwFz9yDot4cylrcxNpHDPsS9vI0mULkibqmyqvexzNboUfaxIYNJhclO/Gz
	 ohArzZXDmNBew==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 06/17 for v6.19] vfs coredump
Date: Fri, 28 Nov 2025 17:48:17 +0100
Message-ID: <20251128-vfs-coredump-v619-c8892d7188f7@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251128-vfs-v619-77cd88166806@brauner>
References: <20251128-vfs-v619-77cd88166806@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5312; i=brauner@kernel.org; h=from:subject:message-id; bh=RyPom7KxKdfujps1/t+h+hzloxXukEX1VS1R+0d9Bd4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRqXnqkZKz/fKlRvdcUMX4n62zTUz7veSqfpjQzBOSpP +GTDcjqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjUFUaGEwXze7b7GjXsCa5e t0ZYmGV9tKSpdrOggdzMMLlnf1c1MPzT5l/Ktzdw8uXt+1U///OKT7O9I+H39/vCdef4tLq13h1 gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains the pidfd changes for this cycle.

Features

- Expose Coredump Signal via pidfd

  Expose the signal that caused the coredump through the pidfd interface.
  The recent changes to rework coredump handling to rely on unix sockets
  are in the process of being used in systemd. The previous systemd
  coredump container interface requires the coredump file descriptor and
  basic information including the signal number to be sent to the container.
  This means the signal number needs to be available before sending the
  coredump to the container.

- Add supported_mask Field to pidfd

  Add a new supported_mask field to struct pidfd_info that indicates which
  information fields are supported by the running kernel. This allows
  userspace to detect feature availability without relying on error codes
  or kernel version checks.

Cleanups

- Drop struct pidfs_exit_info and prepare to drop exit_info pointer,
  simplifying the internal publication mechanism for exit and coredump
  information retrievable via the pidfd ioctl.

- Use guard() for task_lock in pidfs.

- Reduce wait_pidfd lock scope.

- Add missing PIDFD_INFO_SIZE_VER1 constant.

- Add missing BUILD_BUG_ON() assert on struct pidfd_info.

Fixes

- Fix PIDFD_INFO_COREDUMP handling.

Selftests

- Split out coredump socket tests and common helpers into separate files
  for better organization.

- Fix userspace coredump client detection issues.

- Handle edge-triggered epoll correctly.

- Ignore ENOSPC errors in tests.

- Add debug logging to coredump socket tests, socket protocol tests,
  and test helpers.

- Add tests for PIDFD_INFO_COREDUMP_SIGNAL.

- Add tests for supported_mask field.

- Update pidfd header for selftests.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3+b1)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.19-rc1.coredump

for you to fetch changes up to 390d967653e17205f0e519f691b7d6be0a05ff45:

  pidfs: reduce wait_pidfd lock scope (2025-11-05 00:09:06 +0100)

Please consider pulling these changes from the signed vfs-6.19-rc1.coredump tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.19-rc1.coredump

----------------------------------------------------------------
Christian Brauner (24):
      pidfs: use guard() for task_lock
      pidfs: fix PIDFD_INFO_COREDUMP handling
      pidfs: add missing PIDFD_INFO_SIZE_VER1
      pidfs: add missing BUILD_BUG_ON() assert on struct pidfd_info
      pidfd: add a new supported_mask field
      pidfs: prepare to drop exit_info pointer
      pidfs: drop struct pidfs_exit_info
      pidfs: expose coredump signal
      selftests/pidfd: update pidfd header
      selftests/pidfd: add first supported_mask test
      selftests/pidfd: add second supported_mask test
      selftests/coredump: split out common helpers
      selftests/coredump: split out coredump socket tests
      selftests/coredump: fix userspace client detection
      selftests/coredump: fix userspace coredump client detection
      selftests/coredump: handle edge-triggered epoll correctly
      selftests/coredump: add debug logging to test helpers
      selftests/coredump: add debug logging to coredump socket tests
      selftests/coredump: add debug logging to coredump socket protocol tests
      selftests/coredump: ignore ENOSPC errors
      selftests/coredump: add first PIDFD_INFO_COREDUMP_SIGNAL test
      selftests/coredump: add second PIDFD_INFO_COREDUMP_SIGNAL test
      Merge patch series "coredump: cleanups & pidfd extension"
      pidfs: reduce wait_pidfd lock scope

 fs/pidfs.c                                         |  113 +-
 include/uapi/linux/pidfd.h                         |   11 +-
 tools/testing/selftests/coredump/.gitignore        |    4 +
 tools/testing/selftests/coredump/Makefile          |    8 +-
 .../coredump/coredump_socket_protocol_test.c       | 1568 ++++++++++++++++++
 .../selftests/coredump/coredump_socket_test.c      |  742 +++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   59 +
 .../selftests/coredump/coredump_test_helpers.c     |  383 +++++
 tools/testing/selftests/coredump/stackdump_test.c  | 1662 +-------------------
 tools/testing/selftests/pidfd/pidfd.h              |   15 +-
 tools/testing/selftests/pidfd/pidfd_info_test.c    |   73 +
 11 files changed, 2927 insertions(+), 1711 deletions(-)
 create mode 100644 tools/testing/selftests/coredump/.gitignore
 create mode 100644 tools/testing/selftests/coredump/coredump_socket_protocol_test.c
 create mode 100644 tools/testing/selftests/coredump/coredump_socket_test.c
 create mode 100644 tools/testing/selftests/coredump/coredump_test.h
 create mode 100644 tools/testing/selftests/coredump/coredump_test_helpers.c

