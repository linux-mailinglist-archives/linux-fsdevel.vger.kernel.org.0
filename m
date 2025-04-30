Return-Path: <linux-fsdevel+bounces-47717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A78AA497C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A117D7A59E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDED25C802;
	Wed, 30 Apr 2025 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCqxBvFw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5D248F79;
	Wed, 30 Apr 2025 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746011146; cv=none; b=I8DVHUWYTJUWPyZwvz4lZ9MTbHL+6WI+UJoe1odPXWizwN0Cm6DvY63FAq626oc0pr1l2obp1KnlAvHZCQ7SJPbjLcttYusLJfKIAOequB88M18W6/AgHvQODSK8qckmYoPG4Z9FsmiitOyhNxbm0ud1a9juxJiH+c9NozkXABg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746011146; c=relaxed/simple;
	bh=rPv6qVX5JlEcsRtxg8Y314e0BE18pesr8G6M49510wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B1tyiLP2V/N8ZDwCtZOh7aE4FExCGPzjmyrHWl8Onp1Pn5mhq7JquyzzpIa/D+sS/MAkjXZeiBMIAJXeQxAB0bS7VSfDhJQP+9oYlM6V7PeWWvofB2xdC8eyvfB2oUCBTIiqKG9tCce7TGb6FtE+MSHTlQELMUXJm1Km6tYVnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCqxBvFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE7BC4CEEA;
	Wed, 30 Apr 2025 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746011146;
	bh=rPv6qVX5JlEcsRtxg8Y314e0BE18pesr8G6M49510wg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XCqxBvFwfo93Z2tugogXqJaJ4n/PueULAMH5Zg/5lSG6pQjYHXI2JGAbd8jiM3OBR
	 f5Brqn7tEgMcednDrAbYgnYHUCo26yQ+P2RQansOnfVMyfpfMhK3yeVUeUvW/zGrnn
	 HWKlXhNP0eCLqI9fAUAPhz0hx3CABwBmOexGckOqvcNEnHb+RpYmHG8aZCefDtd1MR
	 WaufXRbC4zz7BTo2OMabFWvbtj98kUFziA2u1hUTDWDcoaKNj7Yngzy9WlYrYzRIuN
	 7X9idWWnjwedcm6FSyKG8T/wJClGeEbs1DOzHfIi0rvYZmtxJt8xNbRbhJpVHukIaa
	 S3zNro36kNzQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 30 Apr 2025 13:05:03 +0200
Subject: [PATCH RFC 3/3] coredump: support AF_UNIX sockets
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-work-coredump-socket-v1-3-2faf027dbb47@kernel.org>
References: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
In-Reply-To: <20250430-work-coredump-socket-v1-0-2faf027dbb47@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rPv6qVX5JlEcsRtxg8Y314e0BE18pesr8G6M49510wg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQIMf+o2nQzNlMgSa/8Y8dPp+9VT1m6C8wv1c++WJh0e
 glP/vRLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNhMWVkmG241k00l9Ndyzfz
 XvLe8Kb3GjarGJqC2o9/1f6/QFS6mpHh2LonfbbXI432LFn3wjt+bsP5H7vjPPZ8iihbvNJWSP0
 IFwA=
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
 fs/coredump.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1779299b8c61..db914ff20a5e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -45,6 +45,9 @@
 #include <linux/elf.h>
 #include <linux/pidfs.h>
 #include <uapi/linux/pidfd.h>
+#include <linux/net.h>
+#include <uapi/linux/un.h>
+#include <linux/socket.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -79,6 +82,7 @@ unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 enum coredump_type_t {
 	COREDUMP_FILE = 1,
 	COREDUMP_PIPE = 2,
+	COREDUMP_SOCK = 3,
 };
 
 struct core_name {
@@ -232,13 +236,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	cn->corename = NULL;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
+	else if (*pat_ptr == ':')
+		cn->core_type = COREDUMP_SOCK;
 	else
 		cn->core_type = COREDUMP_FILE;
 	if (expand_corename(cn, core_name_size))
 		return -ENOMEM;
 	cn->corename[0] = '\0';
 
-	if (cn->core_type == COREDUMP_PIPE) {
+	switch (cn->core_type) {
+	case COREDUMP_PIPE: {
 		int argvs = sizeof(core_pattern) / 2;
 		(*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
 		if (!(*argv))
@@ -247,6 +254,35 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		++pat_ptr;
 		if (!(*pat_ptr))
 			return -ENOMEM;
+		break;
+	}
+	case COREDUMP_SOCK: {
+		/* skip ':' */
+		++pat_ptr;
+		/* no spaces */
+		if (!(*pat_ptr))
+			return -EINVAL;
+		/* must be an absolute path */
+		if (!(*pat_ptr == '/'))
+			return -EINVAL;
+		err = cn_printf(cn, "%s", pat_ptr);
+		if (err)
+			return err;
+		/*
+		 * No need to parse any other options. Relevant
+		 * information can be retrieved from the peer pidfd
+		 * retrievable via SO_PEERPIDFD by the receiver or via
+		 * /proc/<pid>, using the SO_PEERPIDFD to guard against
+		 * pid recycling when opening /proc/<pid>.
+		 *
+		 * Hell, we could even add a PIDFD_COREDUMP struct
+		 * retrievable via an ioctl.
+		 */
+		return 0;
+	}
+	default:
+		WARN_ON_ONCE(cn->core_type != COREDUMP_FILE);
+		break;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -801,6 +837,49 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+		struct file *file __free(fput) = NULL;
+		struct sockaddr_un unix_addr = {
+			.sun_family = AF_UNIX,
+		};
+		struct sockaddr_storage *addr;
+
+		retval = strscpy(unix_addr.sun_path, cn.corename, sizeof(unix_addr.sun_path));
+		if (retval < 0)
+			goto close_fail;
+
+		file = __sys_socket_file(AF_UNIX, SOCK_STREAM, 0);
+		if (IS_ERR(file))
+			goto close_fail;
+
+		/*
+		 * It is possible that the userspace process which is
+		 * supposed to handle the coredump and is listening on
+		 * the AF_UNIX socket coredumps. This should be fine
+		 * though. If this was the only process which was
+		 * listen()ing on the AF_UNIX socket for coredumps it
+		 * obviously won't be listen()ing anymore by the time it
+		 * gets here. So the __sys_connect_file() call will
+		 * often fail with ECONNREFUSED and the coredump.
+		 *
+		 * In general though, userspace should just mark itself
+		 * non dumpable and not do any of this nonsense. We
+		 * shouldn't work around this.
+		 */
+		addr = (struct sockaddr_storage *)(&unix_addr);
+		retval = __sys_connect_file(file, addr, sizeof(unix_addr), O_CLOEXEC);
+		if (retval)
+			goto close_fail;
+
+		/* The peer isn't supposed to write and we for sure won't read. */
+		retval =  __sys_shutdown_sock(sock_from_file(file), SHUT_RD);
+		if (retval)
+			goto close_fail;
+
+		cprm.file = no_free_ptr(file);
+		cprm.limit = RLIM_INFINITY;
+		break;
+	}
 	default:
 		WARN_ON_ONCE(true);
 		retval = -EINVAL;
@@ -1070,7 +1149,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != ':') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "

-- 
2.47.2


