Return-Path: <linux-fsdevel+bounces-48552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FFBAB108B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D1E7AA2F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20228ECD2;
	Fri,  9 May 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqzozV0x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BAF38FA3;
	Fri,  9 May 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786352; cv=none; b=WpVD2OQRUT2XTIJsDeL71qFv5DQRjk0W7iiNBaGJJm5e6Qy8r3pal1mfZvdIhr8cYzfhWJNL5X5C1sD676fm7Ran/lzjZRlacAMGA6QoHslmh25yFTwrUQeQSliVnf/AwZOlw8ciGe3twl5i8sOHFLcHZb+XWAq4Sm4Fj1lr2no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786352; c=relaxed/simple;
	bh=8sRv/+iF3yRRBpas6tcFwWDiIqyYpSGIQICXbwUI6AY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jLqnKS4OZgWzJTo4uEsl+lVJKG4sOWMbGLsIZlpHizmexRrUULSiQawWnUx9TvBBW2WAnpKz4x7j1rA+1OYOsj31swTvDMCDxYlBU7DxzLszkOQpQhUo3s4ay+2piHVbrc5Krr5vz59d/rWMRO14d9Y9jWckilI3NQw9hN39AJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqzozV0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E078C4CEE4;
	Fri,  9 May 2025 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786352;
	bh=8sRv/+iF3yRRBpas6tcFwWDiIqyYpSGIQICXbwUI6AY=;
	h=From:Subject:Date:To:Cc:From;
	b=TqzozV0xWov/rEz3DQAehzrCfg/wS18XeZJ/ApBrjkZCoiziesb1+swyl8r6MuSjg
	 L5lDWYg61dCSEwakv1Iez25y8AvDJpDyyF/CbkGEw/+3y9j5WutxthbWecxX8Imum9
	 dsG45AmkaMg3vniC2DUnktSmzWyRqQsWwXrJ9komGlyrCPirW0y67eaWuQKG3+wNyW
	 PcoiulgMOPhNVx0aGFgIPDlhF4xQcCBacHrL83uuPkwdYCr9wavAKPDJfd0Y4FiPtY
	 Nxa/PxmgBJI3s1Pah3iLm4d9mix/8aBc2Qlb0iIsMn+hjOnQWrVtEgws7WtCxEyGv3
	 R2t7fWSMqabpA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v5 0/9] coredump: add coredump socket
Date: Fri, 09 May 2025 12:25:32 +0200
Message-Id: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABzYHWgC/3XPTW7DIBAF4KtErIsFA4S4q96jyoKfIUZujQUpa
 RX57sVRpaZKvXyL972ZKymYIxbyvLuSjDWWmKYW1NOOuMFMJ6TRt0yAgWISenpJeaQuZfQf7zM
 tyY14pgftHAtca+gdadU5Y4ifN/b12LI1BanNZnLDitVQ6L7j+26OPpS1MMRyTvnrdkbla+1nU
 bD/FyunjEIwgYH21kr9MmKe8K1L+UTWyQq/imKwoUBTpADVt99CcI+KuFfUhiKagvwgIDDkaPB
 BkfeK3lBkU9o/GATXFjz7oyzL8g0ZL2BOrAEAAA==
X-Change-ID: 20250429-work-coredump-socket-87cc0f17729c
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>
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
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=9863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8sRv/+iF3yRRBpas6tcFwWDiIqyYpSGIQICXbwUI6AY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tAyUmHsnNd0N6EoTtH/4Z1Nyncev047XqDHYst2w
 /xJTkxPRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERaJzP8Uz7+9PleP4ctV9nD
 ugWqpEoWN+pX+PqXR10ODvgoU1e4hJHh4ApR+17lm2p7K3hnn7vmXdynnPz1kam11xYpyZyHQUG
 cAA==
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
Changes in v5:
- Don't use a prefix just the specific address.
- Link to v4: https://lore.kernel.org/20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org

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
Christian Brauner (9):
      coredump: massage format_corname()
      coredump: massage do_coredump()
      coredump: reflow dump helpers a little
      coredump: add coredump socket
      pidfs, coredump: add PIDFD_INFO_COREDUMP
      coredump: show supported coredump modes
      coredump: validate socket name as it is written
      selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
      selftests/coredump: add tests for AF_UNIX coredumps

 fs/coredump.c                                     | 395 +++++++++++++++++-----
 fs/pidfs.c                                        |  75 ++++
 include/linux/coredump.h                          |  14 +
 include/linux/net.h                               |   1 +
 include/linux/pidfs.h                             |  10 +
 include/uapi/linux/pidfd.h                        |  22 ++
 net/unix/af_unix.c                                |  28 +-
 tools/testing/selftests/coredump/stackdump_test.c | 231 ++++++++++++-
 tools/testing/selftests/pidfd/pidfd.h             |  23 ++
 9 files changed, 703 insertions(+), 96 deletions(-)
---
base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
change-id: 20250429-work-coredump-socket-87cc0f17729c


