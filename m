Return-Path: <linux-fsdevel+bounces-49014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9758AB78A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 00:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDCD44E085B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4230224AE1;
	Wed, 14 May 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwPvtKDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF632248B9;
	Wed, 14 May 2025 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747260259; cv=none; b=JHTXOFt6m/AfpieFF0haTn2A+i2R+1iwJjie4y7eDcQkmdKAwSX2kR6Ns+rP6OurO5Gl894WSq5eNHhalOPikpCaW3Zk/KH+hmDOMuCToEAoQ5xodzKErPxIP1ruA84Bw2hxJCVazVkkDmd7nMglrZgesyCcc71jea55Cc93XMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747260259; c=relaxed/simple;
	bh=dAiDeq66rsr9gQnMOf7li8SkADl+B7AVWPSfQn9RwlQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W2MS1fTetYUZfvbDXqSSMQr56W3Q9z0II9AdRYTxi6j/uEsQs9gdZ9Iaz0zUNg91fhWTzIaNd03D3yI9A+u9hefq08jB28bGJECZuCRJgT7P3kfzbl4q+B8t5blzJbRsZj9cAhxxXdDQSaEPqir4oVTJT4ADT0v7lNG2rD4T5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwPvtKDq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C90C4CEE3;
	Wed, 14 May 2025 22:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747260258;
	bh=dAiDeq66rsr9gQnMOf7li8SkADl+B7AVWPSfQn9RwlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dwPvtKDqRTTGFtAU5ZDmUyMcbVQB900/9fVELdl89j5e5pOVkO5HdPGieH4S7SBa8
	 eNWd2U9G91vjtu/OzDjMUVzEJqH/PnPx5lbVPAeRkR7vM7MJLy5FC0FS6w8APk9qno
	 thtdZ34JhGlZWJrkz8jeVb8zO+v55Q5iDmMcfIIkAv/aM0Fu7hPXwUL9w3GHWx83d6
	 TZhfo9Bz5jj/RdTBfec+r4cmJw0G+81+yFlp3i3Ku9OHT2pZIpPzPTqZ87FQmU2Q05
	 mtpUS28vXR9blfum9LTNE3eK3oChe89Wdi+sJf6vinFOSbT0RklsdNKPAJMrYPvfQR
	 clN+QkSubtiWg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 15 May 2025 00:03:37 +0200
Subject: [PATCH v7 4/9] coredump: add coredump socket
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-work-coredump-socket-v7-4-0a1329496c31@kernel.org>
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14598; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dAiDeq66rsr9gQnMOf7li8SkADl+B7AVWPSfQn9RwlQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSoCnuY759h68ShcJ91jsCj6f8dTFcWaMTLG//p9p3jx
 b1lN49aRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQmzWX4K361sE/DrOapYEjC
 1qyf+hfs7njp3g9iNWK5NTfhmQdvAMP/iNZtZ26fXKVbFvtM92H/pRixDuaP6y9zPJc9JKRjsNy
 WGQA=
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
 fs/coredump.c       | 133 ++++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/net.h |   1 +
 net/unix/af_unix.c  |  53 ++++++++++++++++-----
 3 files changed, 166 insertions(+), 21 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index a70929c3585b..e1256ebb89c1 100644
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
@@ -247,6 +255,33 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
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
+		/* Require absolute paths. */
+		if (cn->corename[0] != '/')
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
@@ -393,11 +428,20 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
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
 
@@ -801,6 +845,55 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		}
 		break;
 	}
+	case COREDUMP_SOCK: {
+#ifdef CONFIG_UNIX
+		struct file *file __free(fput) = NULL;
+		struct sockaddr_un addr = {
+			.sun_family = AF_UNIX,
+		};
+		ssize_t addr_len;
+		struct socket *socket;
+
+		retval = strscpy(addr.sun_path, cn.corename, sizeof(addr.sun_path));
+		if (retval < 0)
+			goto close_fail;
+		addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
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
+				coredump_report_failure("Coredump socket %s receive queue full", addr.sun_path);
+			else
+				coredump_report_failure("Coredump socket connection %s failed %d", addr.sun_path, retval);
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
@@ -838,8 +931,32 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
@@ -1069,7 +1186,7 @@ EXPORT_SYMBOL(dump_align);
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
 
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..a9d1c9ba2961 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -85,10 +85,13 @@
 #include <linux/file.h>
 #include <linux/filter.h>
 #include <linux/fs.h>
+#include <linux/fs_struct.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
+#include <linux/net.h>
+#include <linux/pidfs.h>
 #include <linux/poll.h>
 #include <linux/proc_fs.h>
 #include <linux/sched/signal.h>
@@ -100,7 +103,6 @@
 #include <linux/splice.h>
 #include <linux/string.h>
 #include <linux/uaccess.h>
-#include <linux/pidfs.h>
 #include <net/af_unix.h>
 #include <net/net_namespace.h>
 #include <net/scm.h>
@@ -1146,7 +1148,7 @@ static int unix_release(struct socket *sock)
 }
 
 static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
-				  int type)
+				  int type, unsigned int flags)
 {
 	struct inode *inode;
 	struct path path;
@@ -1154,13 +1156,38 @@ static struct sock *unix_find_bsd(struct sockaddr_un *sunaddr, int addr_len,
 	int err;
 
 	unix_mkname_bsd(sunaddr, addr_len);
-	err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
-	if (err)
-		goto fail;
 
-	err = path_permission(&path, MAY_WRITE);
-	if (err)
-		goto path_put;
+	if (flags & SOCK_COREDUMP) {
+		struct path root;
+		struct cred *kcred;
+		const struct cred *cred;
+
+		err = -ENOMEM;
+		kcred = prepare_kernel_cred(&init_task);
+		if (!kcred)
+			goto fail;
+
+		task_lock(&init_task);
+		get_fs_root(init_task.fs, &root);
+		task_unlock(&init_task);
+
+		cred = override_creds(kcred);
+		err = vfs_path_lookup(root.dentry, root.mnt, sunaddr->sun_path,
+				      LOOKUP_BENEATH | LOOKUP_NO_SYMLINKS |
+				      LOOKUP_NO_MAGICLINKS, &path);
+		put_cred(revert_creds(cred));
+		path_put(&root);
+		if (err)
+			goto fail;
+	} else {
+		err = kern_path(sunaddr->sun_path, LOOKUP_FOLLOW, &path);
+		if (err)
+			goto fail;
+
+		err = path_permission(&path, MAY_WRITE);
+		if (err)
+			goto path_put;
+	}
 
 	err = -ECONNREFUSED;
 	inode = d_backing_inode(path.dentry);
@@ -1210,12 +1237,12 @@ static struct sock *unix_find_abstract(struct net *net,
 
 static struct sock *unix_find_other(struct net *net,
 				    struct sockaddr_un *sunaddr,
-				    int addr_len, int type)
+				    int addr_len, int type, int flags)
 {
 	struct sock *sk;
 
 	if (sunaddr->sun_path[0])
-		sk = unix_find_bsd(sunaddr, addr_len, type);
+		sk = unix_find_bsd(sunaddr, addr_len, type, flags);
 	else
 		sk = unix_find_abstract(net, sunaddr, addr_len, type);
 
@@ -1473,7 +1500,7 @@ static int unix_dgram_connect(struct socket *sock, struct sockaddr *addr,
 		}
 
 restart:
-		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type);
+		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, 0);
 		if (IS_ERR(other)) {
 			err = PTR_ERR(other);
 			goto out;
@@ -1620,7 +1647,7 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 
 restart:
 	/*  Find listening sock. */
-	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type);
+	other = unix_find_other(net, sunaddr, addr_len, sk->sk_type, flags);
 	if (IS_ERR(other)) {
 		err = PTR_ERR(other);
 		goto out_free_skb;
@@ -2089,7 +2116,7 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
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


