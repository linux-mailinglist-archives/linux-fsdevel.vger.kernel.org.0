Return-Path: <linux-fsdevel+bounces-48556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E14CAB10A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C07B2443D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 10:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3FC2900BB;
	Fri,  9 May 2025 10:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiGXqAqn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF428ECE1;
	Fri,  9 May 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786372; cv=none; b=eSHhKibMaLhahE9WkHQtZySR7xHMWbzs+15+ZqfDaPR/52jifo+TAbFJTkMS/TZsPp4BS1dn8jj2l6LGSM+6ovSwbEO2fB5vMFvHSNxaHXO9aseYq5lTwF73oeqxb+MDeZ15IB2i6VckZDMxNvaKXvG969ZOy2ZiBCy9reeGg8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786372; c=relaxed/simple;
	bh=azxZtsE6L5/MGp5HZA52bIWnlvYbF3pnUPwM2hjgfrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFkiLVAr8bPd/Sz7PPFfUtx1hx4T6Qcdep7ey9hiRm9FGIvJUN8bIrXGeeqpHazGP0Oh4hu87tcbNj+WVbWv+r5Y/jo9jF0diBPbZ9MrFKaYQvE2VKVGsFsXjglRZlrlhy4lEyE1CmPtjfpNsSfxaxGeD5pvdaS5q6BCRFnIJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiGXqAqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F55C4CEEF;
	Fri,  9 May 2025 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746786372;
	bh=azxZtsE6L5/MGp5HZA52bIWnlvYbF3pnUPwM2hjgfrU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PiGXqAqnucrYMHj8iwb1f19LQY4lKmBdjBaFBzPL/ZNMPg+C7Zc2bLYv2C3+dj32t
	 4Hkymy907MXwmHO1lO2W/h1KAlDGcpw0CJ72HJ+LKWbm9CHsKZCt0oWB1u0hVaL59e
	 rczY3kwi5qOpx/6PerdA/s2+LKXNR3Nxk1gBURwjfUQlkDOoBtd0naxdZ9Tiohs3iI
	 QGU9EqyctWQhl55J6mA+F6sS6US3qit/+ojeCB+ekWpOUQC2coJE/LWoiK7Pu3Fj0q
	 H3yJhK0K2rCR1ifMZE87G6VTBkBZCVINW2SGvII9RqJkL27By0E3yv/g2L1jlusPmJ
	 aNPY6ve5LPZhw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 09 May 2025 12:25:36 +0200
Subject: [PATCH v5 4/9] coredump: add coredump socket
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-work-coredump-socket-v5-4-23c5b14df1bc@kernel.org>
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15710; i=brauner@kernel.org;
 h=from:subject:message-id; bh=azxZtsE6L5/MGp5HZA52bIWnlvYbF3pnUPwM2hjgfrU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTI3tDat8wiTCmK4Xipb2XQTPWzhpHn54lyXrWODOwyX
 3CIWyK+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgF4CJpjAxnW/bMOJl7/+7hc1Hv
 HN9ZvjhQL9TwyvPwwQsh/Rf0pVZ+ZfjDw6PT9taIvS37a1znAfV1z1LY/Z9G7ao9X/JbRe384YW
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
  To capture coredumps for the coredump server itself a bpf program
  should be run at connect to redirect it to another socket in
  userspace. This can be useful for debugging crashing coredump servers.

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
 fs/coredump.c            | 155 ++++++++++++++++++++++++++++++++++++++++++++---
 include/linux/coredump.h |  14 +++++
 net/unix/af_unix.c       |  21 +++++--
 3 files changed, 178 insertions(+), 12 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b2eda7b176e4..d3599d671c51 100644
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
@@ -247,6 +255,34 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 		++pat_ptr;
 		if (!(*pat_ptr))
 			return -ENOMEM;
+		break;
+	}
+	case COREDUMP_SOCK: {
+		err = cn_printf(cn, "%s", pat_ptr);
+		if (err)
+			return err;
+
+		/*
+		 * We can potentially allow this to be changed later but
+		 * I currently see no reason to.
+		 */
+		if (strcmp(cn->corename, "@linuxafsk/coredump.socket"))
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
+	case COREDUMP_FILE:
+		break;
+	default:
+		WARN_ON_ONCE(true);
+		return -EINVAL;
 	}
 
 	/* Repeat as long as we have more pattern to process and more output
@@ -393,11 +429,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
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
 
@@ -583,6 +628,37 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
 	return 0;
 }
 
+#ifdef CONFIG_UNIX
+static const struct sockaddr_un coredump_unix_socket = {
+	.sun_family = AF_UNIX,
+	.sun_path = "\0linuxafsk/coredump.socket",
+};
+/* Without trailing NUL byte. */
+#define COREDUMP_UNIX_SOCKET_ADDR_SIZE            \
+	(offsetof(struct sockaddr_un, sun_path) + \
+	 sizeof("\0linuxafsk/coredump.socket") - 1)
+
+/*
+ * Ensure that only a process privileged over the initial network
+ * namespace can bind the coredump server address. Protect us against
+ * the coredump server crashing, or intentionally restarting and an
+ * unprivileged process binding the coredump server address to receive
+ * coredumps.
+ */
+int unix_may_bind_coredump_addr(struct net *net, struct sockaddr_un *sunname, int len)
+{
+	if (net != &init_net)
+		return 0;
+	if (COREDUMP_UNIX_SOCKET_ADDR_SIZE != len)
+		return 0;
+	if (memcmp(&coredump_unix_socket, sunname, len))
+		return 0;
+	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
+		return 0;
+	return -ECONNREFUSED;
+}
+#endif
+
 void do_coredump(const kernel_siginfo_t *siginfo)
 {
 	struct core_state core_state;
@@ -801,6 +877,45 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+#ifdef CONFIG_UNIX
+		struct file *file __free(fput) = NULL;
+		struct socket *socket;
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
+		retval = kernel_connect(socket,
+					(struct sockaddr *)(&coredump_unix_socket),
+					COREDUMP_UNIX_SOCKET_ADDR_SIZE, O_NONBLOCK);
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
@@ -838,8 +953,32 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
+			__kernel_read(cprm.file, &(char){}, 1, NULL);
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
@@ -1069,7 +1208,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 76e41805b92d..aa6820df916d 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -7,6 +7,8 @@
 #include <linux/fs.h>
 #include <asm/siginfo.h>
 
+struct sockaddr_un;
+
 #ifdef CONFIG_COREDUMP
 struct core_vma_metadata {
 	unsigned long start, end;
@@ -76,4 +78,16 @@ extern void validate_coredump_safety(void);
 static inline void validate_coredump_safety(void) {}
 #endif
 
+#if defined(CONFIG_COREDUMP) && defined(CONFIG_UNIX)
+int unix_may_bind_coredump_addr(struct net *net, struct sockaddr_un *sunname,
+				int len);
+#elif defined(CONFIG_UNIX)
+static inline int unix_may_bind_coredump_addr(struct net *net,
+					      struct sockaddr_un *sunname,
+					      int len)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_COREDUMP_H */
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..05e5a4737333 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -101,6 +101,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/coredump.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -436,6 +437,18 @@ static struct sock *__unix_find_socket_byname(struct net *net,
 	return NULL;
 }
 
+static int unix_may_bind_name(struct net *net, struct sockaddr_un *sunname,
+			      int len, unsigned int hash)
+{
+	struct sock *s;
+
+	s = __unix_find_socket_byname(net, sunname, len, hash);
+	if (s)
+		return -EADDRINUSE;
+
+	return unix_may_bind_coredump_addr(net, sunname, len);
+}
+
 static inline struct sock *unix_find_socket_byname(struct net *net,
 						   struct sockaddr_un *sunname,
 						   int len, unsigned int hash)
@@ -1258,10 +1271,10 @@ static int unix_autobind(struct sock *sk)
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash)) {
+	if (unix_may_bind_name(net, addr->name, addr->len, new_hash)) {
 		unix_table_double_unlock(net, old_hash, new_hash);
 
-		/* __unix_find_socket_byname() may take long time if many names
+		/* unix_may_bind_name() may take long time if many names
 		 * are already in use.
 		 */
 		cond_resched();
@@ -1379,7 +1392,8 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 	new_hash = unix_abstract_hash(addr->name, addr->len, sk->sk_type);
 	unix_table_double_lock(net, old_hash, new_hash);
 
-	if (__unix_find_socket_byname(net, addr->name, addr->len, new_hash))
+	err = unix_may_bind_name(net, addr->name, addr->len, new_hash);
+	if (err)
 		goto out_spin;
 
 	__unix_set_addr_hash(net, sk, addr, new_hash);
@@ -1389,7 +1403,6 @@ static int unix_bind_abstract(struct sock *sk, struct sockaddr_un *sunaddr,
 
 out_spin:
 	unix_table_double_unlock(net, old_hash, new_hash);
-	err = -EADDRINUSE;
 out_mutex:
 	mutex_unlock(&u->bindlock);
 out:

-- 
2.47.2


