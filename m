Return-Path: <linux-fsdevel+bounces-49240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9402DAB9AE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 13:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BBB9A204D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 11:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093EE2376F5;
	Fri, 16 May 2025 11:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRAKNQLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFA205502;
	Fri, 16 May 2025 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747394747; cv=none; b=JSDaT6iJwP0H+FvBOxm8mTlzE1Q+SFnVXzAhpumXmMzSn25mbGBI4SQyoRprW4hmpEz9VGEsl46uflRqkzY7JWeZPnsPrfus+S1XkRHDof7vTF0142pFVCFy7qPIrBxi+ZoUWLuUeBFY0FiFCZ/gTBCQx7mpOMM5YzCIjdyQ4tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747394747; c=relaxed/simple;
	bh=JSUb+s1ZNYZ8DHhbDt8HVJmgigVCml681sMr15uJZmo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l/Fk0vEkZlTqVyN80MEuulDIRv2/7wxanBFSlvjXnz25KiQRNRkRxZ+1iaNjFx9krOY6/6VMv2Y2yz1F3iMm7AyFKioUiydBDAIj3ykbV4CVrdXxiimhkgMcxG9+2EgJptSKffHUppOgZTfuHKB7JHlOJDGf16ZmLK00jW5cAMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRAKNQLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73819C4CEE4;
	Fri, 16 May 2025 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747394747;
	bh=JSUb+s1ZNYZ8DHhbDt8HVJmgigVCml681sMr15uJZmo=;
	h=From:Subject:Date:To:Cc:From;
	b=NRAKNQLCPNms/CUO5TV+mppU7aLHZW/mqkoURWhOG76kM90OIVp/dscZHm7+E0Tov
	 eVTOZsXOxw7NbQo1B01buxDlLKBDsFrp2H4wciclBjl/OiYSnYtbQ1cPyVQrvWr9Ip
	 5eslCnvqkK6ZUvKTvmIMADsv8Whi9fWOyXavSxkp4W4+uoVcz0O1ntCAqFTJxoDt3v
	 T5aXmmnkEbLZCiccl3xBI9gWyacjC7lfU3ZFOUiUUwe/A3idqqoHVVTI6HR2UZB3WZ
	 Inh1QhipA0tdxDhOaM4e4NVCUB83xFGQyT987JBnpVbhcxrnM0MdziQAMqsJo+7AKE
	 kReebharYsz6g==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH v8 0/9] coredump: add coredump socket
Date: Fri, 16 May 2025 13:25:27 +0200
Message-Id: <20250516-work-coredump-socket-v8-0-664f3caf2516@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKcgJ2gC/3XRwU7EIBAG4FfZcJYGBihbT76H8VDosCXV0sBaN
 Zu+u9ONiTW1xzn83ww/N1YwRyzs8XRjGedYYhppOD+cmO/b8YI8djQzEGCEhoZ/pDxwnzJ2728
 TL8kPeOVn670I0lpoPKPolDHEzzv7/EKzawtyl9vR9ys2h8LrStbVFLtQ1kAfyzXlr/sZs1xjP
 xuV+H/jLLngENogwHbOafs0YB7xtUr5wtaVM/wqRsCBAqRoBaaht4Xg94raKuZAUaSgPCsIAiW
 2uFP0VrEHiiaF3oNBSeugEzvFbJWDn5jN2ovyxkndBen8Tqk3ijzqpSbFG4orTQfDvhe7VY56s
 aSIVipodFN7Jf8oy7J8Azk+vPd+AgAA
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
 Luca Boccassi <luca.boccassi@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-security-module@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Serge Hallyn <serge@hallyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=8905; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JSUb+s1ZNYZ8DHhbDt8HVJmgigVCml681sMr15uJZmo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoK2xNVLW4XujmcuWZjeAzBqeW75Jqkld+x+8vdLny4
 W0ux9LIjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInEfWT4p8nV5bVOW1UuoLnr
 s8PC3t2bcpeJ3b5SuFnWkHPzPQsjb0aGJamPkoXXaJrkC5+8O6vYzqxr59VF1pmBew2b/+3seBH
 IBwA=
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

(3) Dumping into an AF_UNIX socket.

Userspace can set /proc/sys/kernel/core_pattern to:

        @/path/to/coredump.socket

The "@" at the beginning indicates to the kernel that an AF_UNIX
coredump socket will be used to process coredumps.

The coredump socket must be located in the initial mount namespace.
When a task coredumps it opens a client socket in the initial network
namespace and connects to the coredump socket.

- The coredump server should use SO_PEERPIDFD to get a stable handle on
  the connected crashing task. The retrieved pidfd will provide a stable
  reference even if the crashing task gets SIGKILLed while generating
  the coredump.

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
  * PIDFD_COREDUMP_ROOT is raised if the generated coredump should be
    treated as sensitive and the coredump server should restrict access
    to the generated coredump to sufficiently privileged users.

- The coredump server should mark itself as non-dumpable.

- A container coredump server in a separate network namespace can simply
  bind to another well-know address and systemd-coredump fowards
  coredumps to the container.

- Coredumps could in the future also be handled via per-user/session
  coredump servers that run only with that users privileges.

  The coredump server listens on the coredump socket and accepts a
  new coredump connection. It then retrieves SO_PEERPIDFD for the
  client, inspects uid/gid and hands the accepted client to the users
  own coredump handler which runs with the users privileges only
  (It must of coure pay close attention to not forward crashing suid
  binaries.).

The new coredump socket will allow userspace to not have to rely on
usermode helpers for processing coredumps and provides a safer way to
handle them instead of relying on super privileged coredumping helpers.

This will also be significantly more lightweight since no fork()+exec()
for the usermodehelper is required for each crashing process. The
coredump server in userspace can just keep a worker pool.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v8:
- Drop coredump_cookie now that we don't need it anymore. Connections
  can just be filtered by removing the ability to connect to the socket
  path.
- Fix a few minor bugs.
- Link to v7: https://lore.kernel.org/20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org

Changes in v7:
- Use regular AF_UNIX sockets instead of abstract AF_UNIX sockets. This
  fixes the permission problems as userspace can ensure that the socket
  path cannot be rebound by arbitrary unprivileged userspace via regular
  path permissions.

  This means:
  - We don't require privilege checks on a reserved abstract AF_UNIX
    namespace
  - We don't require a fixed address for the coredump socket.
  - We don't need to use abstract unix sockets at all.
  - We don't need  special socket cookie magic in the
    /proc/sys/kernel/core_pattern handler.
  - We are able to set /proc/sys/kernel/core_pattern statically without
    having any socket bound.

  That's all complaints addressed.

  Simply massage unix_find_bsd() to be able to handle this and always
  lookup the coredump socket in the initial mount namespace with
  appropriate credentials. The same thing we do for looking up other
  parts in the kernel like this. Only the lookup happens this way.
  Actual connection credentials are obviously from the coredumping task.
- Link to v6: https://lore.kernel.org/20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org

Changes in v6:
- Use the socket cookie to verify the coredump server.
- Link to v5: https://lore.kernel.org/20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org

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
      coredump: massage format_corename()
      coredump: massage do_coredump()
      coredump: reflow dump helpers a little
      coredump: add coredump socket
      pidfs, coredump: add PIDFD_INFO_COREDUMP
      coredump: show supported coredump modes
      coredump: validate socket name as it is written
      selftests/pidfd: add PIDFD_INFO_COREDUMP infrastructure
      selftests/coredump: add tests for AF_UNIX coredumps

 fs/coredump.c                                     | 381 +++++++++++++-----
 fs/pidfs.c                                        |  55 +++
 include/linux/net.h                               |   1 +
 include/linux/pidfs.h                             |   5 +
 include/uapi/linux/pidfd.h                        |  16 +
 net/unix/af_unix.c                                |  54 ++-
 tools/testing/selftests/coredump/stackdump_test.c | 467 +++++++++++++++++++++-
 tools/testing/selftests/pidfd/pidfd.h             |  22 +
 8 files changed, 895 insertions(+), 106 deletions(-)
---
base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
change-id: 20250429-work-coredump-socket-87cc0f17729c


