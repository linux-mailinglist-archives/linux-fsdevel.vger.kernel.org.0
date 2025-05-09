Return-Path: <linux-fsdevel+bounces-48625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C730AB18FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 915BC1B62D1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA81A2309BE;
	Fri,  9 May 2025 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITCyaFlF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D96722FAD4;
	Fri,  9 May 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805222; cv=none; b=FdYASzx6xOAy8nDp/Fl8qmllCkAa81eazaFjOJh+xotCCrWOB8pzF+WGGJyLqbmZgJyHbGAJXapjRH+IjtwwJpuLeWxOZpdNP9v6xBJjn6AbT8UAKOsKsDgvryNaphQgFLjCe6M7n8WAcZWQ6ytnsKKEoWDlJkboQBRbqsLRsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805222; c=relaxed/simple;
	bh=X7Y3Bk5TpW29HCt4LTRXWPnb2e2RwdeFAZ2KkehZVxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoGMBj5sgPXDuwsb8xuK+ulzRYaLea6dI1KEXpHE4Owpe/4SibGSWxZoDP9l0S6swwJEhL47FtfDFM3R5oQFZ1AONomim8tOlg5VYY8unkCgw3RhbAd+T7wu7eFnnuruREPR1R1zbA6qUw/iDeKUvRHbxueUj+8/Eb9ZdYNH9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITCyaFlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E22C4CEF5;
	Fri,  9 May 2025 15:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805221;
	bh=X7Y3Bk5TpW29HCt4LTRXWPnb2e2RwdeFAZ2KkehZVxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITCyaFlFKdntc/Z+eE3XUJ/zVMcMnk7fgcIiYV6jfd6D3d09AWugapb4lhXAbzRwi
	 151Yyerk+Dc4XwGiAuXDgxiAJMyhfjSyZeaCxpzuadD5vgLnh2qcFnU6UZbxF2LwTb
	 lBZBTuWCttjmFz/WMLV2hCku+SKtHiDnhJlSJwBzvSpBngn3B0ElJZHb450YF8Fhie
	 e/iQiP0nelz6SYftu5ygz4O5OHuSUgthoPR9Yxe6SVW9wsW79z0SeqTWSPH9VzIRm6
	 NWLCGprSk6lQqjp+f/LRrzm9l/mTQNd0exlxpIwL5fm2RWD+4MqGCFm1omxSJ0ARbl
	 d5jupjdbUwGQQ==
Date: Fri, 9 May 2025 17:40:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: [PATCH v5 4/9] coredump: add coredump socket
Message-ID: <20250509-querschnitt-fotokopien-6ae91dfdac45@brauner>
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org>
 <20250509-work-coredump-socket-v5-4-23c5b14df1bc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cvtza4xbbllnzmw3"
Content-Disposition: inline
In-Reply-To: <20250509-work-coredump-socket-v5-4-23c5b14df1bc@kernel.org>


--cvtza4xbbllnzmw3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> Userspace can set /proc/sys/kernel/core_pattern to:
> 
>         @linuxafsk/coredump_socket

I have one other proposal that:

- avoids reserving a specific address
- doesn't require bpf or lsm to be safe
- allows for safe restart and crashes of the coredump sever

To set up a coredump socket the coredump server must allocate a socket
cookie for the listening socket via SO_COOKIE. The socket cookie must be
used as the prefix in the abstract address for the coredump socket. It
can be followed by a \0 byte and then followed by whatever the coredump
server wants. For example:

12345678\0coredump.socket

When a task crashes and generates a coredump it will find the provided
address but also compare the prefixed SO_COOKIE value with the socket
cookie of the socket listening at that address. If they don't match it
will refuse to connect.

So even if the coredump server restarts or crashes and unprivileged
userspace recycles the socket address for an attack the crashing process
will detect this as the new listening socket will have gotten either a
new or no SO_COOKIE and the crashing process will not connect.

The coredump server just sets /proc/sys/kernel/core_pattern to:

        @SO_COOKIE/whatever

The "@" at the beginning indicates to the kernel that the abstract
AF_UNIX coredump socket will be used to process coredumps and the
indicating the end of the SO_COOKIE and the rest of the name.

Appended what that would look like.

--cvtza4xbbllnzmw3
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment;
	filename="0001-coredump-add-coredump-socket.patch"

From a99749a48d2aafddeca5fd1fab64b907137c1a68 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 5 May 2025 11:33:44 +0200
Subject: [PATCH] coredump: add coredump socket

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

        @SO_COOKIE/whatever

The "@" at the beginning indicates to the kernel that the abstract
AF_UNIX coredump socket will be used to process coredumps.

When the coredump server sets up a coredump socket it must allocate a
socket cookie for it and use it as the prefix in the abstract address.
It may be followed by a zero byte and whatever other name the server may
want.

The crashing process uses the socket cookie to verify the socket
connection. Even if the coredump server restarts or crashes and
unprivileged userspace recycles the socket address the kernel will
detect that the address has been recycled as a new socket cookie will
have been allocated for it.

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

    sudo bash -c "echo '@@socket_cookie/whatever-you-want' > /proc/sys/kernel/core_pattern"
    sudo socat --statistics abstract-listen:socket_cookie\0whatever-you-want,fork FILE:core_file,create,append,trunc

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
 fs/coredump.c            | 133 ++++++++++++++++++++++++++++++++++++---
 include/linux/coredump.h |   2 +
 include/linux/net.h      |   2 +
 net/unix/af_unix.c       |  22 +++++--
 4 files changed, 145 insertions(+), 14 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b2eda7b176e4..6692790bd459 100644
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
 
@@ -801,6 +841,59 @@ void do_coredump(const kernel_siginfo_t *siginfo)
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
+		retval = strscpy(addr.sun_path + 1, cn.corename, strlen(cn.corename));
+		if (retval)
+			goto close_fail;
+
+		/* Format is @socket_cookie\0whatever. */
+		p = strchr(addr.sun_path + 1, '/');
+		if (p)
+			*p = '\0';
+		addr_len = offsetof(struct sockaddr_un, sun_path) + retval + 1;
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
@@ -1069,7 +1186,7 @@ EXPORT_SYMBOL(dump_align);
 void validate_coredump_safety(void)
 {
 	if (suid_dumpable == SUID_DUMP_ROOT &&
-	    core_pattern[0] != '/' && core_pattern[0] != '|') {
+	    core_pattern[0] != '/' && core_pattern[0] != '|' && core_pattern[0] != '@') {
 
 		coredump_report_failure("Unsafe core_pattern used with fs.suid_dumpable=2: "
 			"pipe handler or fully qualified core dump path required. "
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 76e41805b92d..3e4b52c769e3 100644
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
diff --git a/include/linux/net.h b/include/linux/net.h
index 0ff950eecc6b..3f467786bdc9 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -82,6 +82,8 @@ enum sock_type {
 #define SOCK_NONBLOCK	O_NONBLOCK
 #endif
 
+#define SOCK_COREDUMP O_NOCTTY
+
 #endif /* ARCH_HAS_SOCKET_TYPES */
 
 /**
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 472f8aa9ea15..944248d7c5be 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -101,6 +101,7 @@
 #include <linux/string.h>
 #include <linux/uaccess.h>
 #include <linux/pidfs.h>
+#include <linux/kstrtox.h>
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
+		u64 cookie;
+
+		if (kstrtou64(sunaddr->sun_path, 0, &cookie))
+			return ERR_PTR(-ECONNREFUSED);
+		if (cookie != atomic64_read(&sk->sk_cookie))
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
+		other = unix_find_other(sock_net(sk), sunaddr, alen, sock->type, flags);
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


--cvtza4xbbllnzmw3--

