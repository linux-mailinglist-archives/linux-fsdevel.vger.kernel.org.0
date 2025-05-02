Return-Path: <linux-fsdevel+bounces-47916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB01AA7264
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8ED53BF419
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842D255F2A;
	Fri,  2 May 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhwusinW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B140253F0C;
	Fri,  2 May 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189778; cv=none; b=e9gKThroqJplM0Toi2svd5iJhwADiMaCtngYf5Z7mAAvd4TnMbeKcBvsCF34YCYstQwEzNWY9I4/NbQSrHzcJZzkDw0S/lZ+xhf1ZqAiT2Tt5wluNAjYD9EzEMAuFduXa6tZzOj0pWinHq/q7teAA3C3qNrIqNzsroFe3tPUcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189778; c=relaxed/simple;
	bh=/vJ8Xys/h8H5d+TJXIiBTPL4YzXjsAeeRGWurXNqgJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BKZVWmQVAKHCZT5RrbHL0RCm0bXiu7Un3WBEcO9HRLdor191C1IJk5fg0nNAJXZEBOdE1TMmR5EOYhEB3TlU4D2+gEsOMkCZrUq4yAj5O3wvJUYwOjYkF5e5RL93grLrjsRIe0yScT7jSYeDDQRJIAs1FZ1FBrelqyM+tP85RMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhwusinW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7FE7C4CEE4;
	Fri,  2 May 2025 12:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746189778;
	bh=/vJ8Xys/h8H5d+TJXIiBTPL4YzXjsAeeRGWurXNqgJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HhwusinWMsE2RgWhvZSdQ7d+uMwvzxcYQZAtzOQGYe0yLNWRp9CEHyDZZyhoIZyB5
	 lmi2KI0JRGoqITAh9ogpyLUfBdrdJxNInOvBC8jXdYqE2ECChGhZA1hM1I0kMWc3oX
	 srgFKAKBzkFKzrUscLQwGBdtE18KDnal+rAG+rTh/UAEGj4IhMA6Ool4zdi1lCkhJJ
	 C+luWSFJqQ2/1XlbxMXp+J8J7UBiZVSb69+DHx1lmvg7EmbA3M1BDrBmfFM++6gJj7
	 bXvXYUuWEwPwsWEB5vCjhDQmwcOFgTJqFKKaqXCRhwWl4Gy1xJ/i9azpK1RxyJZ2uW
	 ZhidTQPdOElXA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 May 2025 14:42:34 +0200
Subject: [PATCH RFC v2 3/6] coredump: support AF_UNIX sockets
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-work-coredump-socket-v2-3-43259042ffc7@kernel.org>
References: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
In-Reply-To: <20250502-work-coredump-socket-v2-0-43259042ffc7@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9998; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/vJ8Xys/h8H5d+TJXIiBTPL4YzXjsAeeRGWurXNqgJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSI7N3vu57X7WPGuhsih9idTCTNgyScvYS1fWzqN0zKj
 t4ryaLRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJHk1Qz/i1ojbuXOLn4b5XSD
 wWB/XdyKXQwfw8QKp77eJfFCuCothpFh99UDsU7Xc+6XX3R+sjDKaWuL2Ma5tx5uj3Nd2H3r924
 ZdgA=
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
 fs/coredump.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 5 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 1779299b8c61..9a6cba233db9 100644
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
@@ -247,6 +254,39 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
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
+		 * For simplicitly we simply refuse spaces in the socket
+		 * path. It's in line with what we do for pipes.
+		 */
+		if (strchr(cn->corename, ' '))
+			return -EINVAL;
+
+		/*
+		 * Currently no need to parse any other options.
+		 * Relevant information can be retrieved from the peer
+		 * pidfd retrievable via SO_PEERPIDFD by the receiver or
+		 * via /proc/<pid>, using the SO_PEERPIDFD to guard
+		 * against pid recycling when opening /proc/<pid>.
+		 */
+		return 0;
+	}
+	default:
+		WARN_ON_ONCE(cn->core_type != COREDUMP_FILE);
+		break;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+		struct file *file __free(fput) = NULL;
+#ifdef CONFIG_UNIX
+		ssize_t addr_size;
+		struct sockaddr_un unix_addr = {
+			.sun_family = AF_UNIX,
+		};
+		struct sockaddr_storage *addr;
+
+		/*
+		 * TODO: We need to really support core_pipe_limit to
+		 * prevent the task from being reaped before userspace
+		 * had a chance to look at /proc/<pid>.
+		 *
+		 * I need help from the networking people (or maybe Oleg
+		 * also knows?) how to do this.
+		 *
+		 * IOW, we need to wait for the other side to shutdown
+		 * the socket/terminate the connection.
+		 *
+		 * We could just read but then userspace could sent us
+		 * SCM_RIGHTS and we just shouldn't need to deal with
+		 * any of that.
+		 */
+		if (WARN_ON_ONCE(core_pipe_limit)) {
+			retval = -EINVAL;
+			goto close_fail;
+		}
+
+		retval = strscpy(unix_addr.sun_path, cn.corename, sizeof(unix_addr.sun_path));
+		if (retval < 0)
+			goto close_fail;
+		addr_size = offsetof(struct sockaddr_un, sun_path) + retval + 1,
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
+		retval = __sys_connect_file(file, addr, addr_size, O_CLOEXEC);
+		if (retval)
+			goto close_fail;
+
+		/* The peer isn't supposed to write and we for sure won't read. */
+		retval =  __sys_shutdown_sock(sock_from_file(file), SHUT_RD);
+		if (retval)
+			goto close_fail;
+
+		cprm.limit = RLIM_INFINITY;
+#endif
+		cprm.file = no_free_ptr(file);
+		break;
+	}
 	default:
 		WARN_ON_ONCE(true);
 		retval = -EINVAL;
@@ -818,7 +925,10 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 * have this set to NULL.
 		 */
 		if (!cprm.file) {
-			coredump_report_failure("Core dump to |%s disabled", cn.corename);
+			if (cn.core_type == COREDUMP_PIPE)
+				coredump_report_failure("Core dump to |%s disabled", cn.corename);
+			else
+				coredump_report_failure("Core dump to :%s disabled", cn.corename);
 			goto close_fail;
 		}
 		if (!dump_vma_snapshot(&cprm))
@@ -839,8 +949,25 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
 	}
-	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
-		wait_for_dump_helpers(cprm.file);
+
+	if (core_pipe_limit) {
+		switch (cn.core_type) {
+		case COREDUMP_PIPE:
+			wait_for_dump_helpers(cprm.file);
+			break;
+		case COREDUMP_SOCK: {
+			/*
+			 * TODO: Wait for the coredump handler to shut
+			 * down the socket so we prevent the task from
+			 * being reaped.
+			 */
+			break;
+		}
+		default:
+			break;
+		}
+	}
+
 close_fail:
 	if (cprm.file)
 		filp_close(cprm.file, NULL);
@@ -1070,7 +1197,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != ':') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "

-- 
2.47.2


