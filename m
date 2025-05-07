Return-Path: <linux-fsdevel+bounces-48396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28123AAE65D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 18:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 367441B64BB9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCD928C2B0;
	Wed,  7 May 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad0l6oW3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2FA28C016;
	Wed,  7 May 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634426; cv=none; b=KszaneyWTmIU0KqetPy215/dNoULMMsYqBXFAY3A3uLcM94wCiwGcmttMFx45cMt/7bVKqDqJ/P9NN0j7YpaHLeYEEqW5g732/S4pnz0FvOsS3atXA30pZ4uSgahXQQD7R3znFEqmDx9sYXSexD073uH9747u/dxbrCuuI73vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634426; c=relaxed/simple;
	bh=8bXswNOrFtotfHg5zaGmPfwbInVnOxrxdm1Nj8YuAfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Sk046XIGWWuWrMVfrClkPt4jpUnxBtXOpKjCt9DoF1SWGesH8z92I7J1sufI9C/sVbvRO+OwUJtdL4bUt+kPdl/DAcyXsOfeMVkfRAomGJGQQLfGNcRHFit2i0OTqcQpwEHlZWf2OeZthfKYoCzE0tEt5E1eyns+Xj9sRDXvb10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad0l6oW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6C8C4CEF0;
	Wed,  7 May 2025 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746634426;
	bh=8bXswNOrFtotfHg5zaGmPfwbInVnOxrxdm1Nj8YuAfg=;
	h=From:Subject:Date:To:Cc:From;
	b=Ad0l6oW33fH02Fw3FIM2swFS5b7JrkcWsLDeS093YDP+amnuiC76jaEVLF7JdryRe
	 b4VYob2N8UvqDiBnOSPBfyDAJdC4NSw/BFfFtFiXgRSka7ifvckORuBOmMnNALEPTd
	 udYleOp3yV0QmkcvhWABHN+ob3OI2TYMBy1MdLNaxjyTm+bWMyXMN7nmgWhEqcH8j2
	 9zzhwbHm6ZQXlL2dx0i0UTA5qG7hfg0fqsigDGMCncsHxTbph5CLynXvO/mA0U9fSZ
	 30/Apv0UXOxsMVqFQws7LpfPKJe33Jd3KGhkSrzzAscnKYkFJSAbdfPk82ajBAaLDX
	 rN1sbawn+gzFQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 00/11] coredump: add coredump socket
Date: Wed, 07 May 2025 18:13:33 +0200
Message-Id: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK2GG2gC/3XPQW7CMBAF0KsgrzuRPU4w6ar3QCwcZ0ystHE0B
 tMK5e44CKmtWpZ/8d+fuYpEHCiJ181VMOWQQpxKqF82wg12OhKEvmSBEhtZYwuXyCO4yNSfP2Z
 I0Y10gp1xTnplDLZOlOrM5MPnnd0fSu5sIujYTm5YsewTbCu1rebQ+7QWhpBOkb/uZ2S11h6LW
 v6/mBVIQG+9RNN3XW3eRuKJ3qvIR7FOZvxWGolPFCxKrbFpy2/eu7+K/qk0TxRdFFI7jV6SIku
 /lGVZbmfa/sFmAQAA
X-Change-ID: 20250429-work-coredump-socket-87cc0f17729c
To: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9790; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8bXswNOrFtotfHg5zaGmPfwbInVnOxrxdm1Nj8YuAfg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRIt20xZfhY1sIXuaGeif/czo3vv206vVzAeuni8ocrY
 vp/7H8c0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARS2tGhj1Xatqe2eiKye5R
 U7gg7rTIacJGfYb6qwIMx3fcmbjuTycjw/3HOoq7eYRU/+s7GLjoamhufmLRZl3ZY6z6lJ9HaaI
 zDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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

In the example core_pattern shown above systemd-coredump is spawned as a
usermode helper. There's various conceptual consequences of this
(non-exhaustive list):

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

This series adds a new mode:

(3) Dumping into an abstract AF_UNIX socket.

Userspace can set /proc/sys/kernel/core_pattern to:

        @linuxafsk/coredump_socket

The "@" at the beginning indicates to the kernel that the abstract
AF_UNIX coredump socket will be used to process coredumps.

The coredump socket uses the fixed address "linuxafsk/coredump.socket"
for now.

The coredump socket is located in the initial network namespace. To bind
the coredump socket userspace must hold CAP_SYS_ADMIN in the initial
user namespace. Listening and reading can happen from whatever
unprivileged context is necessary to safely process coredumps.

When a task coredumps it opens a client socket in the initial network
namespace and connects to the coredump socket.

- The coredump server should use SO_PEERPIDFD to get a stable handle on
  the connected crashing task. The retrieved pidfd will provide a stable
  reference even if the crashing task gets SIGKILLed while generating
  the coredump.

- When a coredump connection is initiated use the socket cookie as the
  coredump cookie and store it in the pidfd. The receiver can now easily
  authenticate that the connection is coming from the kernel.

  Unless the coredump server expects to handle connection from
  non-crashing task it can validate that the connection has been made from
  a crashing task:

     fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
     getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);

     struct pidfd_info info = {
             info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
     };

     ioctl(pidfd, PIDFD_GET_INFO, &info);
     /* Refuse connections that aren't from a crashing task. */
     if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
             close(fd_coredump);

     /*
      * Make sure that the coredump cookie matches the connection cookie.
      * If they don't it's not the coredump connection from the kernel.
      * We'll get another connection request in a bit.
      */
     getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
     if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
             close(fd_coredump);

  The kernel guarantees that by the time the connection is made the
  coredump info is available.

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
  * PIDFD_COREDUMP_SKIP	is raised if the task skipped coredumping (e.g.,
    undumpable).
  * PIDFD_COREDUMP_USER	is raised if this is a regular coredump and
    doesn't need special care by the coredump server.
  * IDFD_COREDUMP_ROOT is raised if the generated coredump should be
    treated as sensitive and the coredump server should restrict to the
    generated coredump to sufficiently privileged users.

- Since unix_stream_connect() runs bpf programs during connect it's
  possible to even redirect or multiplex coredumps to other sockets.

- The coredump server should mark itself as non-dumpable.
  To capture coredumps for the coredump server itself a bpf program
  should be run at connect to redirect it to another socket in
  userspace. This can be useful for debugging crashing coredump servers.

- A container coredump server in a separate network namespace can simply
  bind to linuxafsk/coredump.socket and systemd-coredump fowards
  coredumps to the container.

- Fwiw, one idea is to handle coredumps via per-user/session coredump
  servers that run with that users privileges.

  The coredump server listens on the coredump socket and accepts a
  new coredump connection. It then retrieves SO_PEERPIDFD for the
  client, inspects uid/gid and hands the accepted client to the users
  own coredump handler which runs with the users privileges only.

The new coredump socket will allow userspace to not have to rely on
usermode helpers for processing coredumps and provides a safer way to
handle them instead of relying on super privileged coredumping helpers.

This will also be significantly more lightweight since no fork()+exec()
for the usermodehelper is required for each crashing process. The
coredump server in userspace can just keep a worker pool.

This is easy to test:

(a) coredump processing (we're using socat):

    > cat coredump_socket.sh
    #!/bin/bash

    set -x

    sudo bash -c "echo '@linuxafsk/coredump.socket' > /proc/sys/kernel/core_pattern"
    sudo socat --statistics abstract-listen:linuxafsk/coredump.socket,fork FILE:core_file,create,append,trunc

(b) trigger a coredump:

    user1@localhost:~/data/scripts$ cat crash.c
    #include <stdio.h>
    #include <unistd.h>

    int main(int argc, char *argv[])
    {
            fprintf(stderr, "%u\n", (1 / 0));
            _exit(0);
    }

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v4:
- Expose the coredump socket cookie through the pidfd. This allows the
  coredump server to easily recognize coredump socket connections.
- Link to v3: https://lore.kernel.org/20250505-work-coredump-socket-v3-0-e1832f0e1eae@kernel.org

Changes in v3:
- Use an abstract unix socket.
- Add documentation.
- Add selftests.
- Link to v2: https://lore.kernel.org/20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org

Changes in v2:
- Expose dumpability via PIDFD_GET_INFO.
- Place COREDUMP_SOCK handling under CONFIG_UNIX.
- Link to v1: https://lore.kernel.org/20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org

---
Christian Brauner (11):
      coredump: massage format_corname()
      coredump: massage do_coredump()
      coredump: reflow dump helpers a little
      net: reserve prefix
      coredump: add coredump socket
      coredump: validate socket name as it is written
      coredump: show supported coredump modes
      pidfs, coredump: add PIDFD_INFO_COREDUMP
      pidfs, coredump: allow to verify coredump connection
      selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
      selftests/coredump: add tests for AF_UNIX coredumps

 fs/coredump.c                                     | 378 ++++++++++++++++------
 fs/pidfs.c                                        |  73 +++++
 include/linux/net.h                               |   1 +
 include/linux/pidfs.h                             |   4 +
 include/uapi/linux/pidfd.h                        |  17 +
 include/uapi/linux/un.h                           |   2 +
 net/unix/af_unix.c                                |  46 ++-
 tools/testing/selftests/coredump/stackdump_test.c | 273 +++++++++++++++-
 tools/testing/selftests/pidfd/pidfd.h             |  23 ++
 9 files changed, 721 insertions(+), 96 deletions(-)
---
base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
change-id: 20250429-work-coredump-socket-87cc0f17729c


