Return-Path: <linux-fsdevel+bounces-47913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C4AA725B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1C89C4704
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A690253B7C;
	Fri,  2 May 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kx1uL2En"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AF248F46;
	Fri,  2 May 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189765; cv=none; b=lRCj4I0SMEUMFhKY8vm7RvkVkqqNycChZgK26gFm3xiAQBguhc428yGcbaqCEX7VNK12ZycINQpuGF8hTlylV3DJolng5WuooFrUfjQv0bCLHSwCHl/KmhPA3allaiIvcIf0BF0n6NNCFvtXvrHFupsXqs4oJGZqXmEopdFQ+IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189765; c=relaxed/simple;
	bh=MgdmhzLKR4Mx/HocbGM9V7rUCi4u9dxVVe407WZLWVU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ISwcnGkaaLA0dNSez9F5YLGVXCrTGNC7pgS9lZzYFVlXvYfjBamd0LRL916lzRyWj/tbZZQBqMPbThu4LorMIQdZyAi/29v/M9+AqEKe73AXjOqXIqvjKbxjM3+2/8DdD/b3hK3GnaCreN5Cinw8mPH/rfAVBxtdNAormPVjDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kx1uL2En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79334C4CEF0;
	Fri,  2 May 2025 12:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189764;
	bh=MgdmhzLKR4Mx/HocbGM9V7rUCi4u9dxVVe407WZLWVU=;
	h=From:Subject:Date:To:Cc:From;
	b=Kx1uL2En8cPqdXcGN07sWTwitFsA6Se/FFMq9Hj7LErEXDxKiFozEbNgJcMWdsyM4
	 RtDHW/edlof9Y6o2p9NgAeMvBP0+XWLPw2xsO8YdgDLfkQkLIEbwK5y5yaOAjhjE+Y
	 4pwLxOLW9mkJt+7/i43rfGqrB2MgZsQ/SE4JHXYQGpHB8QKh1H49QQ9MFR24OD8j0E
	 RJI1opLpOx6gFRdFDLHJV6iUnb4vuqvUg35keWW62XpHok0reR2wgIMKnZOlyN4e9+
	 UE8Yh0uOVGOjkCRlda3FIp5lHE3Od3a2DX0wxBk06v7WaQhI1nonPELAGO+EoG1Yb1
	 4Yj8MsIyIWKRw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/6] coredump: support AF_UNIX sockets
Date: Fri, 02 May 2025 14:42:31 +0200
Message-Id: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALe9FGgC/22OwQ6CMBBEf8Xs2SWlIhVPJiZ+gFfDoZQtNCglW
 0QN4d8FvHqcSd6bGSEQOwpw3IzANLjgfDsHud2AqXVbEbpyziCF3ItEZvjy3KDxTOXz0WHwpqE
 eD8oYYWOlZGZgRjsm696r9gbXyxnyuSx0ICxYt6ZejIMNmEZxGnWutGGhahd6z5/1yxCv7G92J
 /7PDjEKlFZbIVVZFIk6NcQt3SPPFeTTNH0B4w1pJ98AAAA=
X-Change-ID: 20250429-work-coredump-socket-87cc0f17729c
To: Eric Dumazet <edumazet@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5895; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MgdmhzLKR4Mx/HocbGM9V7rUCi4u9dxVVe407WZLWVU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7N0f0u8lcKYgpaAguPM8y0zplSys13cweD6WF2bs3
 ny//pxJRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQYzjP8lb4nFODWNf3w+hdx
 Jx8tjlRmynf+qCV4nk/Vb7uzauZCQYb/LtPEF/JveFhQ+3qFz2IN6+7PAuKnElteZxx/6m17NcS
 RHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

I need some help with the following questions:

(i) The core_pipe_limit setting is of vital importance to userspace
    because it allows it to a) limit the number of concurrent coredumps
    and b) causes the kernel to wait until userspace closes the pipe and
    thus prevents the process from being reaped, allowing userspace to
    parse information out of /proc/<pid>/.

    Pipes already support this. I need to know from the networking
    people (or Oleg :)) how to wait for the userspace side to shutdown
    the socket/terminate the connection.

    I don't want to just read() because then userspace can send us
    SCM_RIGHTS messages and it's really ugly anyway.

(ii) The dumpability setting is of importance for userspace in order to
     know how a given binary is dumped: as regular user or as root user.
     This helps guard against exploits abusing set*id binaries. The
     setting needs to be the same as used at the time of the coredump.

     I'm exposing this as part of PIDFD_GET_INFO. I would like some
     input whether it's fine to simply expose the dumpability this way.
     I'm pretty sure it is. But it'd be good to have @Jann give his
     thoughts here.

Now the actual blurb:

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

In this case systemd-coredump is spawned as a usermode helper. There's
various conceptual consequences of this (non-exhaustive list):

- systemd-coredump is spawned with file descriptor number 0 (stdin)
  to the read-end of the pipe. All other file descriptors are closed.
  That specifically includes 1 (stdout) and 2 (stderr). This has already
  caused bugs because userspace assumed that this cannot happen (Whether
  or not this is a sane assumption is irrelevant.).

- systemd-coredump will be spawned as a child of system_unbound_wq. So
  it is not a child of any userspace process and specifically not a
  child of PID 1 so it cannot be waited upon and is in general a weird
  hybrid upcall.

- systemd-coredump is spawned highly privileged as it is spawned with
  full kernel credentials requiring all kinds of weird privilege
  dropping excercises in userspaces.

This adds another mode:

(3) Dumping into a AF_UNIX socket.

Userspace can set /proc/sys/kernel/core_pattern to:

        :/run/coredump.socket

The ":" at the beginning indicates to the kernel that an AF_UNIX socket
is used to process coredumps. The task generating the coredump simply
connects to the socket and writes the coredump into the socket.

Userspace can get a stable handle on the task generating the coredump by
using the SO_PEERPIDFD socket option. SO_PEERPIDFD uses the thread-group
leader pid stashed during connect(). Even if the task generating the
coredump is a subthread in the thread-group the pidfd of the
thread-group leader is a reliable stable handle. Userspace that's
interested in the credentials of the specific thread that crashed can
use SCM_PIDFD to retrieve them.

The pidfd can be used to safely open and parse /proc/<pid> of the task
and it can also be used to retrieve additional meta information via the
PIDFD_GET_INFO ioctl().

This will allow userspace to not have to rely on usermode helpers for
processing coredumps and thus to stop having to handle super privileged
coredumping helpers.

This is easy to test:

(a) coredump processing (we're using socat):

    > cat coredump_socket.sh
    #!/bin/bash

    set -x

    sudo bash -c "echo ':/tmp/stream.sock' > /proc/sys/kernel/core_pattern"
    socat --statistics unix-listen:/tmp/stream.sock,fork FILE:core_file,create,append,truncate

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
Changes in v2:
- Expose dumpability via PIDFD_GET_INFO.
- Place COREDUMP_SOCK handling under CONFIG_UNIX.
- Link to v1: https://lore.kernel.org/20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org

---
Christian Brauner (6):
      coredump: massage format_corname()
      coredump: massage do_coredump()
      coredump: support AF_UNIX sockets
      coredump: show supported coredump modes
      pidfs, coredump: add PIDFD_INFO_COREDUMP
      selftests/coredump: add tests for AF_UNIX coredumps

 fs/coredump.c                                     | 312 ++++++++++++++++------
 fs/pidfs.c                                        |  58 ++++
 include/linux/pidfs.h                             |   3 +
 include/uapi/linux/pidfd.h                        |  11 +
 tools/testing/selftests/coredump/stackdump_test.c |  50 ++++
 5 files changed, 359 insertions(+), 75 deletions(-)
---
base-commit: 4dd6566b5a8ca1e8c9ff2652c2249715d6c64217
change-id: 20250429-work-coredump-socket-87cc0f17729c


