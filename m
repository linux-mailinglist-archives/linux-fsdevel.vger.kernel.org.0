Return-Path: <linux-fsdevel+bounces-56021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37E4B11D83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 13:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70B0AE2492
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jul 2025 11:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA7C2E92DB;
	Fri, 25 Jul 2025 11:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2whp472"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFF2E8E1B;
	Fri, 25 Jul 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753442853; cv=none; b=f4Xd01R3Rs+ABaTmiK/2J86Ozyq8nREKWDk5si2GdaXBasqFhdqJmO9joZCCEz3IGQ2KF1QBFTaKKQKLrJgqo2MZ6hv7A2ODA0kKFqT9K9RN2cXel5FDSd4YnpyM1sTX3p7wyzB6RTxkExt38NuFV/Mx6OnCW02345gd0kpW/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753442853; c=relaxed/simple;
	bh=OyRpips3GPTn7W0xfBDWpml/Nfc4p6TCMaJh1ZonQyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAWepCvMneH1SfsNVXXey3mrvOmJMdjg1Cf3nYVthVKu//omVY6HdgvDICYQg3J6eYwWIsEJDk8R7PNaQf9Jx/1yUSXHAFJ2xJLL184YqlVgLXBCQh4XdEIRQ9vBDCrupWLZHjJUOrlEqOgGnqf2k3uWfWMp70wlvmyM+pM6aVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2whp472; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D9F7C4CEE7;
	Fri, 25 Jul 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753442853;
	bh=OyRpips3GPTn7W0xfBDWpml/Nfc4p6TCMaJh1ZonQyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n2whp472IHjfN7aytCQCTfiQl5aZBSdEzhSGmHZGoGpk1yB5iOv5hnXyrQiNiFBQY
	 VRMpRPLFAkMaCCmB+Ip/vOS8dPAUZSI2Bic3AzXSFv4U6N8w7QZvAxipjYKRLRLZz6
	 94jzNX8mkWG/ckMOoguKAcfEEE1Y5P03wPZrwU7xafTcuyNrDhh8C15oTy/Lk1KLYj
	 /wxzs07TXn+tB4H05BBsbtz4DhE7o3SZ9wlQxYuLr70kB6CrIUF6nDC4JF8HbQ/JS2
	 MUrgCq13niRjQBEvzUjQKuLjZ+Ujc1jpJ5KuhBz6MBIloaAgvRNzLISt4HVfyZWMe3
	 TRLvsJaELua1g==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/14 for v6.17] vfs coredump
Date: Fri, 25 Jul 2025 13:27:16 +0200
Message-ID: <20250725-vfs-coredump-6c7c0c4edd03@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
References: <20250725-vfs-617-1bcbd4ae2ea6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8931; i=brauner@kernel.org; h=from:subject:message-id; bh=OyRpips3GPTn7W0xfBDWpml/Nfc4p6TCMaJh1ZonQyI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ0Z4n+/no5KOm7oeqULb2fObg0FxWzz1jquXS2sN7dT 31FDpYvO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby9SAjw4NkEauT4SpHW6z/ 3c7YKOcs9Sn1aOW+jMXXm4ozXkr7TWVkuKMcL8cl/ouz+KOt75G6MoXqUB+2x4x6O5YukL/GKri fCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */
This contains an extension to the coredump socket and a proper rework
of the coredump code.

- This extends the coredump socket to allow the coredump server to tell
  the kernel how to process individual coredumps. This allows for
  fine-grained coredump management. Userspace can decide to just let the
  kernel write out the coredump, or generate the coredump itself, or
  just reject it.

  * COREDUMP_KERNEL
    The kernel will write the coredump data to the socket.

  * COREDUMP_USERSPACE
    The kernel will not write coredump data but will indicate to the
    parent that a coredump has been generated. This is used when
    userspace generates its own coredumps.

  * COREDUMP_REJECT
    The kernel will skip generating a coredump for this task.

  * COREDUMP_WAIT
    The kernel will prevent the task from exiting until the coredump
    server has shutdown the socket connection.

  The flexible coredump socket can be enabled by using the "@@" prefix
  instead of the single "@" prefix for the regular coredump socket:

    @@/run/systemd/coredump.socket

- Cleanup the coredump code properly while we have to touch it anyway.
  Split out each coredump mode in a separate helper so it's easy to
  grasp what is going on and make the code easier to follow. The core
  coredump function should now be very trivial to follow.

/* Testing */

gcc (Debian 14.2.0-19) 14.2.0
Debian clang version 19.1.7 (3)

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

This will have a merge conflict with mainline that can be resolved as follows:

diff --cc tools/testing/selftests/coredump/stackdump_test.c
index 68f8e479ac36,a4ac80bb1003..000000000000
--- a/tools/testing/selftests/coredump/stackdump_test.c
+++ b/tools/testing/selftests/coredump/stackdump_test.c
@@@ -418,59 -430,31 +430,35 @@@ TEST_F(coredump, socket_detect_userspac
                close(ipc_sockets[1]);

                fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
-               if (fd_coredump < 0) {
-                       fprintf(stderr, "Failed to accept coredump socket connection\n");
-                       close(fd_server);
-                       _exit(EXIT_FAILURE);
-               }
+               if (fd_coredump < 0)
+                       goto out;

-               fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
-               ret = getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD,
-                                &fd_peer_pidfd, &fd_peer_pidfd_len);
-               if (ret < 0) {
-                       fprintf(stderr, "%m - Failed to retrieve peer pidfd for coredump socket connection\n");
-                       close(fd_coredump);
-                       close(fd_server);
-                       _exit(EXIT_FAILURE);
-               }
+               fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+               if (fd_peer_pidfd < 0)
+                       goto out;

-               memset(&info, 0, sizeof(info));
-               info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP;
-               ret = ioctl(fd_peer_pidfd, PIDFD_GET_INFO, &info);
-               if (ret < 0) {
-                       fprintf(stderr, "Failed to retrieve pidfd info from peer pidfd for coredump socket connection\n");
-                       close(fd_coredump);
-                       close(fd_server);
-                       close(fd_peer_pidfd);
-                       _exit(EXIT_FAILURE);
-               }
+               if (!get_pidfd_info(fd_peer_pidfd, &info))
+                       goto out;

-               if (!(info.mask & PIDFD_INFO_COREDUMP)) {
-                       fprintf(stderr, "Missing coredump information from coredumping task\n");
-                       close(fd_coredump);
-                       close(fd_server);
-                       close(fd_peer_pidfd);
-                       _exit(EXIT_FAILURE);
-               }
+               if (!(info.mask & PIDFD_INFO_COREDUMP))
+                       goto out;

-               if (info.coredump_mask & PIDFD_COREDUMPED) {
-                       fprintf(stderr, "Received unexpected connection from coredumping task\n");
-                       close(fd_coredump);
-                       close(fd_server);
-                       close(fd_peer_pidfd);
-                       _exit(EXIT_FAILURE);
-               }
+               if (info.coredump_mask & PIDFD_COREDUMPED)
+                       goto out;

 +              ret = read(fd_coredump, &c, 1);
 +
-               close(fd_coredump);
-               close(fd_server);
-               close(fd_peer_pidfd);
-               close(fd_core_file);
-
+               exit_code = EXIT_SUCCESS;
+ out:
+               if (fd_peer_pidfd >= 0)
+                       close(fd_peer_pidfd);
+               if (fd_coredump >= 0)
+                       close(fd_coredump);
+               if (fd_server >= 0)
+                       close(fd_server);
 +              if (ret < 1)
 +                      _exit(EXIT_FAILURE);
-               _exit(EXIT_SUCCESS);
+               _exit(exit_code);
        }
        self->pid_coredump_server = pid_coredump_server;

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-6.17-rc1.coredump

for you to fetch changes up to 5c21c5f22d0701ac6c1cafc0e8de4bf42e5c53e5:

  cleanup: add a scoped version of CLASS() (2025-07-11 16:01:07 +0200)

Please consider pulling these changes from the signed vfs-6.17-rc1.coredump tag.

Thanks!
Christian

----------------------------------------------------------------
vfs-6.17-rc1.coredump

----------------------------------------------------------------
Christian Brauner (33):
      coredump: allow for flexible coredump handling
      selftests/coredump: fix build
      selftests/coredump: cleanup coredump tests
      tools: add coredump.h header
      selftests/coredump: add coredump server selftests
      Merge patch series "coredump: allow for flexible coredump handling"
      coredump: cleanup coredump socket functions
      coredump: rename format_corename()
      coredump: make coredump_parse() return bool
      coredump: fix socket path validation
      coredump: validate that path doesn't exceed UNIX_PATH_MAX
      fs: move name_contains_dotdot() to header
      coredump: don't allow ".." in coredump socket path
      coredump: validate socket path in coredump_parse()
      selftests/coredump: make sure invalid paths are rejected
      coredump: rename do_coredump() to vfs_coredump()
      coredump: split file coredumping into coredump_file()
      coredump: prepare to simplify exit paths
      coredump: move core_pipe_count to global variable
      coredump: split pipe coredumping into coredump_pipe()
      coredump: move pipe specific file check into coredump_pipe()
      coredump: use a single helper for the socket
      coredump: add coredump_write()
      coredump: auto cleanup argv
      coredump: directly return
      cred: add auto cleanup method
      coredump: auto cleanup prepare_creds()
      coredump: add coredump_cleanup()
      coredump: order auto cleanup variables at the top
      coredump: avoid pointless variable
      coredump: add coredump_skip() helper
      Merge patch series "coredump: further cleanups"
      cleanup: add a scoped version of CLASS()

 Documentation/security/credentials.rst             |    2 +-
 .../translations/zh_CN/security/credentials.rst    |    2 +-
 drivers/base/firmware_loader/main.c                |   31 +-
 fs/coredump.c                                      |  868 ++++++----
 include/linux/cleanup.h                            |    8 +
 include/linux/coredump.h                           |    4 +-
 include/linux/cred.h                               |    2 +
 include/linux/fs.h                                 |   16 +
 include/uapi/linux/coredump.h                      |  104 ++
 kernel/signal.c                                    |    2 +-
 tools/include/uapi/linux/coredump.h                |  104 ++
 tools/testing/selftests/coredump/Makefile          |    2 +-
 tools/testing/selftests/coredump/config            |    3 +
 tools/testing/selftests/coredump/stackdump_test.c  | 1689 +++++++++++++++++---
 14 files changed, 2239 insertions(+), 598 deletions(-)
 create mode 100644 include/uapi/linux/coredump.h
 create mode 100644 tools/include/uapi/linux/coredump.h
 create mode 100644 tools/testing/selftests/coredump/config

