Return-Path: <linux-fsdevel+bounces-47714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9465AA4974
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987B51BC29D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8D25A2C9;
	Wed, 30 Apr 2025 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhtuDTpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3558F221F35;
	Wed, 30 Apr 2025 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011133; cv=none; b=pnhWvkx+SCXxOyjW0K38KOHeZB/AHCm8F4CfUgNIcBn4bEJsy64hAhTQyCGLQDMRODo5MRcdLcs6JDfg1nO79gJWgrqHwb8cE43XZAl6n+U/S1NQio1i+JlNSkP0dTvI1t3FyWwXTKLaS+IKAGsT1uMRweZUjQLJiItshrOQiR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011133; c=relaxed/simple;
	bh=nQrASJ6hdVZOdSLWPhEr1DleCbN40IIG8C9hTJrUoPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jK79LJCsuSHPApNMTLAZIO51MSXpzNDS3R6EL0pJHN1LdRuCSkT+xbYvSEJXZwL42YV/x9zsjYe84hdROrzqoPVCp/n3Ekn0Jjw/lIe67ab52gKnYF9VgX1NdP2cmfugv/etJEFvmkcW4aAJuYINlMOePCMlHinMCiTNRwshW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhtuDTpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81121C4CEE9;
	Wed, 30 Apr 2025 11:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746011132;
	bh=nQrASJ6hdVZOdSLWPhEr1DleCbN40IIG8C9hTJrUoPc=;
	h=From:Subject:Date:To:Cc:From;
	b=GhtuDTpH/HkACn8tSfiUklpASOuhO/C98x0A3Ood3J7HKFwfXJMGAEjQSveuZ7n0r
	 YYma3pvwztypVtQtY4GNUXwf3fRmMNncyUeqWSdA7lLmT7vHS3ampVRlxL42GPXg5N
	 kUwsiSOJLN2yH2exsZulJfFqZTKhj9Jm0Cd4Optp1SbdYLN0dguPTnK8OB/0DlgKSl
	 cSTMx2LpEwYXRru/m4G32yxusTFjn7UDuHXZa8L87+K5D1PXZ/Fshq9bsA1b+45ywK
	 xyrpFTwCeos6AVkNnDAzZN9PvjjlPzzhkgLu/eEIuu+R10v5JqhRWWRrezNn/X4I5Z
	 QInEMwzZvtb/Q==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/3] coredump: support AF_UNIX sockets
Date: Wed, 30 Apr 2025 13:05:00 +0200
Message-Id: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0DEmgC/zXMQQrCMBCF4auUWTslCdpYt4IHcCsu0unEhmJSM
 lqF0rsbBZf/g/ctIJwDCxyqBTLPQUKKJfSmAhpcvDGGvjQYZXZqa1p8pTwipcz98z6hJBr5gXt
 LpLy21rQE5Tpl9uH9Yy9wPh3hWsbOCWOXXaThK85esKl1U/8xWNcP6GXQnY8AAAA=
X-Change-ID: 20250429-work-coredump-socket-87cc0f17729c
To: linux-fsdevel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
 Oleg Nesterov <oleg@redhat.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nQrASJ6hdVZOdSLWPhEr1DleCbN40IIG8C9hTJrUoPc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQIMX/3vbNgemrJCh1x413lhw1stm97ynD8et7heV68f
 P/Opzk96ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIWgWG/z5ng0QbU6QUfmtH
 te2VmrXM8Gh8pWuSmPFzN+PSnX0/LzH8s6t4FuMxu0623TvS13p1XJfGV07GvLidruXxB5xu7mp
 iBgA=
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
Christian Brauner (3):
      coredump: massage format_corname()
      coredump: massage do_coredump()
      coredump: support AF_UNIX sockets

 fs/coredump.c | 241 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 168 insertions(+), 73 deletions(-)
---
base-commit: 80e14080a00bc429a4ee440d17746a49867df663
change-id: 20250429-work-coredump-socket-87cc0f17729c


