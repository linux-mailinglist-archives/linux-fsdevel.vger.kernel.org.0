Return-Path: <linux-fsdevel+bounces-48710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAD8AB3265
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784EA189C5AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 08:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A325CC4A;
	Mon, 12 May 2025 08:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i010sXlk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6643B25A342;
	Mon, 12 May 2025 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747040162; cv=none; b=dpMJ76uwqhjZbh6PPopK5ukvdZxpcKRQvBEEDHbp9nlms0+mRgVYXn6ICh8ohJp9+ofFi09FCN8jHLnw1Py6JCqrXGCAn6k5WhwESOcfsygwxqD4jGAagS0WpkgmL10+Fr3jTCBmYzJ6Q6Ftm6k0L2fz7fnqzXqBoCd71qd/tUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747040162; c=relaxed/simple;
	bh=ZpqOa39wRBgmaQK3FnarDF0LgWmcV9qjAJ4w9KLR6+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U91VSaym8XUdIpaEHkB6r2A8P5hThReLStI1t4dH9FhFukXGuBhp1LgXwUl3Y0z9XI6gfuiTJf6orGeMN1DZRn/S7EndGiiT1PCrX8dDthZYHNpFODwDarj4gOSwhHvgq1hJMToSnla7/1qqS/oy85OUaA2c5BNA9UZHJFnUBf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i010sXlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D69C4CEEF;
	Mon, 12 May 2025 08:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747040161;
	bh=ZpqOa39wRBgmaQK3FnarDF0LgWmcV9qjAJ4w9KLR6+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i010sXlkR43N7sMa+oOenSf2wA2YENOmoKb2WksjGJ1YGq9WPSd6EVcZoUkHoKPQB
	 iwxLgBpZeiBpAgnejIOlntgokHkeSMbhEedJSuztMQGTV0LuG0r4ilbtLuZS8Bqmwu
	 dqW2hChHr0Pr+vasChdFObcVV8fVKVy4EoMYbNJjoWa9oNvwmfSgOjwDLkJncle2lG
	 vJ795NRSck0DDMFl3Vokm21RM71j8T4q5gytnoALRHFlRZ0mwqMMjS8VNuiMyVJ+Mw
	 BqaheCmboZDGwY8cNRBNjzHPGdR5B+tGORXBGwwRJD1deOFfHlXwlZuHuH1IkKWNR/
	 ousOl2qo6Q2YA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 May 2025 10:55:23 +0200
Subject: [PATCH v6 4/9] coredump: add coredump socket
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250512-work-coredump-socket-v6-4-c51bc3450727@kernel.org>
References: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
In-Reply-To: <20250512-work-coredump-socket-v6-0-c51bc3450727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15291; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ZpqOa39wRBgmaQK3FnarDF0LgWmcV9qjAJ4w9KLR6+4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQobm/vnXI0ruhsx5XrPm+/Time8z5U6eeUksPPXm5PC
 FmXbnA+pKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiclcZ/oo2Fd/QW/Vr8f9w
 6w+Fv45vXLDaqeKnHV/wyYs5qz+xX4hl+J+csH8d+/ZTLS8f9D9SKFD4e//V2X6jjW8nWO1+vef
 CtDROAA==
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

        @address SO_COOKIE

The "@" at the beginning indicates to the kernel that the abstract
AF_UNIX coredump socket will be used to process coredumps. The address
is given by @address and must be followed by the socket cookie of the
coredump listening socket.

The socket cookie is used to verify the socket connection. If the
coredump server restarts or crashes and someone recycles the socket
address the kernel will detect that the address has been recycled as the
socket cookie will have necessarily changed and refuse to connect.

The coredump socket is located in the initial network namespace. When a
task coredumps it opens a client socket in the initial network namespace
and connects to the coredump socket.

- The coredump server uses SO_PEERPIDFD to get a stable handle on the
  connected crashing task. The retrieved pidfd will provide a stable
  reference even if the crashing task gets SIGKILLed while generating
  the coredump.

- By setting core_pipe_limit non-zero userspace can guarantee that the
  crashing task cannot be reaped behind it's back and thus process all
  necessary information in /proc/<pid>. The SO_PEERPIDFD can be used to
  detect whether /proc/<pid> still refers to the same process.

  The core_pipe_limit isn't used to rate-limit connections to the
  socket. This can simply be done via AF_UNIX sockets directly.

- The pidfd for the crashing task will grow new information how the task
  coredumps.

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
handle them instead of relying on super privileged coredumping helpers
that have and continue to cause significant CVEs.

This will also be significantly more lightweight since no fork()+exec()
for the usermodehelper is required for each crashing process. The
coredump server in userspace can e.g., just keep a worker pool.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c       | 147 +++++++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/net.h |   1 +
 net/socket.c        |   5 +-
 net/unix/af_unix.c  |  24 ++++++---
 4 files changed, 161 insertions(+), 16 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a70929c3585b..15e9d9a252cd 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -44,7 +44,11 @@
 #include <linux/sysctl.h>
 #include <linux/elf.h>
 #include <linux/pidfs.h>
+#include <linux/net.h>
+#include <linux/socket.h>
+#include <net/net_namespace.h>
 #include <uapi/linux/pidfd.h>
+#include <uapi/linux/un.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -79,6 +83,7 @@ unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
 enum coredump_type_t {
 	COREDUMP_FILE = 1,
 	COREDUMP_PIPE = 2,
+	COREDUMP_SOCK = 3,
 };
 
 struct core_name {
@@ -232,13 +237,16 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	cn->corename = NULL;
 	if (*pat_ptr == '|')
 		cn->core_type = COREDUMP_PIPE;
+	else if (*pat_ptr == '@')
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
@@ -247,6 +255,29 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		++pat_ptr;
 		if (!(*pat_ptr))
 			return -ENOMEM;
+		break;
+	}
+	case COREDUMP_SOCK: {
+		/* skip the @ */
+		pat_ptr++;
+		err = cn_printf(cn, "%s", pat_ptr);
+		if (err)
+			return err;
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
+	case COREDUMP_FILE:
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -393,11 +424,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 	 * If core_pattern does not include a %p (as is the default)
 	 * and core_uses_pid is set, then .%pid will be appended to
 	 * the filename. Do not do this for piped commands. */
-	if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
-		err = cn_printf(cn, ".%d", task_tgid_vnr(current));
-		if (err)
-			return err;
+	if (!pid_in_pattern && core_uses_pid) {
+		switch (cn->core_type) {
+		case COREDUMP_FILE:
+			return cn_printf(cn, ".%d", task_tgid_vnr(current));
+		case COREDUMP_PIPE:
+			break;
+		case COREDUMP_SOCK:
+			break;
+		default:
+			WARN_ON_ONCE(true);
+			return -EINVAL;
+		}
 	}
+
 	return 0;
 }
 
@@ -801,6 +841,73 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+#ifdef CONFIG_UNIX
+		struct file *file __free(fput) = NULL;
+		struct sockaddr_un addr = {
+			.sun_family = AF_UNIX,
+		};
+		unsigned int addr_len;
+		struct socket *socket;
+		char *p;
+		u64 sock_cookie;
+
+		p = strchr(cn.corename, ' ');
+		if (!p) {
+			coredump_report_failure("Missing socket cookie");
+			goto close_fail;
+		}
+		*p++ = '\0';
+
+		/* Leave room for the socket cookie. */
+		retval = strscpy(addr.sun_path + 1, cn.corename,
+				 sizeof(addr.sun_path) - sizeof(sock_cookie) - 1);
+		if (retval < 0)
+			goto close_fail;
+		addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
+
+		retval = kstrtou64(p, 0, &sock_cookie);
+		if (retval || !sock_cookie) {
+			coredump_report_failure("Invalid socket cookie");
+			goto close_fail;
+		}
+
+		/* append socket cookie */
+		memcpy((char *)&addr + addr_len, &sock_cookie, sizeof(sock_cookie));
+
+		/*
+		 * It is possible that the userspace process which is
+		 * supposed to handle the coredump and is listening on
+		 * the AF_UNIX socket coredumps. Userspace should just
+		 * mark itself non dumpable.
+		 */
+
+		retval = sock_create_kern(&init_net, AF_UNIX, SOCK_STREAM, 0, &socket);
+		if (retval < 0)
+			goto close_fail;
+
+		file = sock_alloc_file(socket, 0, NULL);
+		if (IS_ERR(file)) {
+			sock_release(socket);
+			goto close_fail;
+		}
+
+		retval = kernel_connect(socket, (struct sockaddr *)(&addr),
+					addr_len, O_NONBLOCK | SOCK_COREDUMP);
+		if (retval) {
+			if (retval == -EAGAIN)
+				coredump_report_failure("Skipping as coredump socket connection %s couldn't complete immediately", cn.corename);
+			goto close_fail;
+		}
+
+		cprm.limit = RLIM_INFINITY;
+		cprm.file = no_free_ptr(file);
+#else
+		coredump_report_failure("Core dump socket support %s disabled", cn.corename);
+		goto close_fail;
+#endif
+		break;
+	}
 	default:
 		WARN_ON_ONCE(true);
 		goto close_fail;
@@ -838,8 +945,32 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
 	}
-	if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
-		wait_for_dump_helpers(cprm.file);
+
+	/*
+	 * When core_pipe_limit is set we wait for the coredump server
+	 * or usermodehelper to finish before exiting so it can e.g.,
+	 * inspect /proc/<pid>.
+	 */
+	if (core_pipe_limit) {
+		switch (cn.core_type) {
+		case COREDUMP_PIPE:
+			wait_for_dump_helpers(cprm.file);
+			break;
+		case COREDUMP_SOCK: {
+			/*
+			 * We use a simple read to wait for the coredump
+			 * processing to finish. Either the socket is
+			 * closed or we get sent unexpected data. In
+			 * both cases, we're done.
+			 */
+			__kernel_read(cprm.file, &(char){ 0 }, 1, NULL);
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
@@ -1069,7 +1200,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "
diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..139c85d0f2ea 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -81,6 +81,7 @@ enum sock_type {
 #ifndef SOCK_NONBLOCK
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
+#define SOCK_COREDUMP	O_NOCTTY
 
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
diff --git a/net/socket.c b/net/socket.c
index 9a0e720f0859..d62a57a57a28 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3603,7 +3603,10 @@ int kernel_connect(struct socket *sock, struct sockaddr *addr, int addrlen,
 {
 	struct sockaddr_storage address;
 
-	memcpy(&address, addr, addrlen);
+	if (flags & SOCK_COREDUMP)
+		memcpy(&address, addr, addrlen + sizeof(sock->sk->sk_cookie));
+	else
+		memcpy(&address, addr, addrlen);
 
 	return READ_ONCE(sock->ops)->connect(sock, (struct sockaddr *)&address,
 					     addrlen, flags);
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..6b8a7863b41c 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -89,6 +89,8 @@
 #include <linux/kernel.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/net.h>
+#include <linux/pidfs.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/signal.h>
@@ -100,7 +102,6 @@
 #include <linux/splice.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/pidfs.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -1191,7 +1192,7 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 
 static struct sock *unix_find_abstract(struct net *net,
 				       struct sockaddr_un *sunaddr,
-				       int addr_len, int type)
+				       int addr_len, int type, int flags)
 {
 	unsigned int hash = unix_abstract_hash(sunaddr, addr_len, type);
 	struct dentry *dentry;
@@ -1201,6 +1202,15 @@ static struct sock *unix_find_abstract(struct net *net,
 	if (!sk)
 		return ERR_PTR(-ECONNREFUSED);
 
+	if (flags & SOCK_COREDUMP) {
+		u64 sock_cookie;
+
+		memcpy(&sock_cookie, (char *)sunaddr + addr_len, sizeof(sock_cookie));
+		DEBUG_NET_WARN_ON_ONCE(!sock_cookie);
+		if (sock_cookie != atomic64_read(&sk->sk_cookie))
+			return ERR_PTR(-ECONNREFUSED);
+	}
+
 	dentry = unix_sk(sk)->path.dentry;
 	if (dentry)
 		touch_atime(&unix_sk(sk)->path);
@@ -1210,14 +1220,14 @@ static struct sock *unix_find_abstract(struct net *net,
 
 static struct sock *unix_find_other(struct net *net,
 				    struct sockaddr_un *sunaddr,
-				    int addr_len, int type)
+				    int addr_len, int type, int flags)
 {
 	struct sock *sk;
 
 	if (sunaddr->sun_path[0])
 		sk = unix_find_bsd(sunaddr, addr_len, type);
 	else
-		sk = unix_find_abstract(net, sunaddr, addr_len, type);
+		sk = unix_find_abstract(net, sunaddr, addr_len, type, flags);
 
 	return sk;
 }
@@ -1473,7 +1483,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		}
 
 restart:
-		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
+		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, 0);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out;
@@ -1620,7 +1630,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 restart:
 	/*  Find listening sock. */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
+	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
 		goto out_free_skb;
@@ -2089,7 +2099,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 	if (msg->msg_namelen) {
 lookup:
 		other = unix_find_other(sock_net(sk), msg->msg_name,
-					msg->msg_namelen, sk->sk_type);
+					msg->msg_namelen, sk->sk_type, 0);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out_free;

-- 
2.47.2


