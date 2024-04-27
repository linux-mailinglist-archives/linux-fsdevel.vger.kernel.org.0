Return-Path: <linux-fsdevel+bounces-17972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E8B8B4623
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C79287F7C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD314CB38;
	Sat, 27 Apr 2024 11:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="YZps4iP4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward205a.mail.yandex.net (forward205a.mail.yandex.net [178.154.239.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E4945C18;
	Sat, 27 Apr 2024 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217505; cv=none; b=ju5d+0xU9uGqvbox+1nAXYwLncqZgC0ZDWn6sL3ts000pfQ8yx42xMA3JHt/ZGiQKOk2hW0a1X8P0w/FyQh3gXNYI2Re28PZT5LYlRZb5del1U3/Vbt7t3Pu/vUYPGzjm9Ab7OwBw/HJGo487oGwwb77D7etl4TeyYFJttmAbAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217505; c=relaxed/simple;
	bh=rGiiYWN0bwz8S7WshuQ1nUQQHIR1C44r//9xZQ8agl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0djdXOo1IncBXu5e40ZmpQN0PG6OiXQa9R1IsrMXkAKlRV9XWNstCYt18PBdSfyITExXIERlnaodtkZOCAChoSFVhUkUHh/BiUEKVmJ2KAK3aVCLfGlj7248no9Ldwf4iRaMVAqXjUHJ8kRNk/QFn6nPFlNN0jNP4fssfg2qVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=YZps4iP4; arc=none smtp.client-ip=178.154.239.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d100])
	by forward205a.mail.yandex.net (Yandex) with ESMTPS id 80A27667F1;
	Sat, 27 Apr 2024 14:25:10 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 9BCFC46D54;
	Sat, 27 Apr 2024 14:25:02 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uOMFvPQXlqM0-AesOqMtr;
	Sat, 27 Apr 2024 14:25:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714217101; bh=7Tx4MmiVvo3dc9P2ErVjG5tVev7EKB9T5e2ufGJi1cs=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=YZps4iP4CGkv2ggh0f3DO0HVDeqSwgnYAErWpgIjxVz/CDvq7BdKyxmpEAld8lg+E
	 hnwVE3pUtohKTItUyHDqP1R3Qk7WcvA13W+/BXBAaX2ojROpq1xcvd38EoKRciX9pj
	 PnVbkTIm0i5XS36BksrJwJ9Dt6JcHom4DEHFosIg=
Authentication-Results: mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 2/3] open: add O_CRED_ALLOW flag
Date: Sat, 27 Apr 2024 14:24:50 +0300
Message-ID: <20240427112451.1609471-3-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag prevents an fd from being passed via unix socket, and
makes it to be always closed on exec().

Selftest is added to check for both properties.

It is needed for the subsequent OA2_CRED_INHERIT addition, to work
as an "opt-in" for the new cred-inherit functionality. Without using
O_CRED_ALLOW when opening dir fd, OA2_CRED_INHERIT is going to return
EPERM.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Andy Lutomirski <luto@kernel.org>
CC: David Laight <David.Laight@ACULAB.COM>
CC: Arnd Bergmann <arnd@arndb.de>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Pavel Begunkov <asml.silence@gmail.com>
CC: linux-arch@vger.kernel.org
CC: netdev@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
 fs/fcntl.c                                |   2 +-
 fs/file.c                                 |  15 +--
 include/linux/fcntl.h                     |   2 +-
 include/uapi/asm-generic/fcntl.h          |   5 +
 net/core/scm.c                            |   5 +
 tools/testing/selftests/core/Makefile     |   2 +-
 tools/testing/selftests/core/cred_allow.c | 139 ++++++++++++++++++++++
 7 files changed, 160 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/core/cred_allow.c

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 54cc85d3338e..78c96b1293c2 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1039,7 +1039,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/file.c b/fs/file.c
index 3b683b9101d8..2a09d5276676 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -827,22 +827,23 @@ void do_close_on_exec(struct files_struct *files)
 	/* exec unshares first */
 	spin_lock(&files->file_lock);
 	for (i = 0; ; i++) {
+		int j;
 		unsigned long set;
 		unsigned fd = i * BITS_PER_LONG;
 		fdt = files_fdtable(files);
 		if (fd >= fdt->max_fds)
 			break;
 		set = fdt->close_on_exec[i];
-		if (!set)
-			continue;
 		fdt->close_on_exec[i] = 0;
-		for ( ; set ; fd++, set >>= 1) {
-			struct file *file;
-			if (!(set & 1))
-				continue;
-			file = fdt->fd[fd];
+		for (j = 0; j < BITS_PER_LONG; j++, fd++, set >>= 1) {
+			struct file *file = fdt->fd[fd];
 			if (!file)
 				continue;
+			/* Close all cred-allow files. */
+			if (file->f_flags & O_CRED_ALLOW)
+				set |= 1;
+			if (!(set & 1))
+				continue;
 			rcu_assign_pointer(fdt->fd[fd], NULL);
 			__put_unused_fd(files, fd);
 			spin_unlock(&files->file_lock);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..e074ee9c1e36 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_CRED_ALLOW)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..9244c54bb933 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,11 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_CRED_ALLOW
+/* On parisc bit 23 is taken. On alpha bit 24 is also taken. Try bit 25. */
+#define O_CRED_ALLOW	0200000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
diff --git a/net/core/scm.c b/net/core/scm.c
index 9cd4b0a01cd6..f54fb0ee9727 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -111,6 +111,11 @@ static int scm_fp_copy(struct cmsghdr *cmsg, struct scm_fp_list **fplp)
 			fput(file);
 			return -EINVAL;
 		}
+		/* don't allow files with creds */
+		if (file->f_flags & O_CRED_ALLOW) {
+			fput(file);
+			return -EPERM;
+		}
 		if (unix_get_socket(file))
 			fpl->count_unix++;
 
diff --git a/tools/testing/selftests/core/Makefile b/tools/testing/selftests/core/Makefile
index ce262d097269..347a5a9d3f29 100644
--- a/tools/testing/selftests/core/Makefile
+++ b/tools/testing/selftests/core/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -g $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := close_range_test
+TEST_GEN_PROGS := close_range_test cred_allow
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/core/cred_allow.c b/tools/testing/selftests/core/cred_allow.c
new file mode 100644
index 000000000000..07d533207a2c
--- /dev/null
+++ b/tools/testing/selftests/core/cred_allow.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+#include <time.h>
+#include <unistd.h>
+#include <string.h>
+
+#include "../kselftest.h"
+
+#ifndef O_CRED_ALLOW
+#define O_CRED_ALLOW 0x2000000
+#endif
+
+enum { FD_NORM, FD_CE, FD_CA, FD_MAX };
+
+static int is_opened(int n)
+{
+	char buf[256];
+
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", n);
+	return (access(buf, F_OK) == 0);
+}
+
+/* Sends an FD on a UNIX socket. Returns 0 on success or -errno. */
+static int send_fd(int usock, int fd_tx)
+{
+	union {
+		/* Aligned ancillary data buffer. */
+		char buf[CMSG_SPACE(sizeof(fd_tx))];
+		struct cmsghdr _align;
+	} cmsg_tx = {};
+	char data_tx = '.';
+	struct iovec io = {
+		.iov_base = &data_tx,
+		.iov_len = sizeof(data_tx),
+	};
+	struct msghdr msg = {
+		.msg_iov = &io,
+		.msg_iovlen = 1,
+		.msg_control = &cmsg_tx.buf,
+		.msg_controllen = sizeof(cmsg_tx.buf),
+	};
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+
+	cmsg->cmsg_len = CMSG_LEN(sizeof(fd_tx));
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_RIGHTS;
+	memcpy(CMSG_DATA(cmsg), &fd_tx, sizeof(fd_tx));
+
+	if (sendmsg(usock, &msg, 0) < 0)
+		return -errno;
+	return 0;
+}
+
+int main(int argc, char *argv[], char *env[])
+{
+	int status;
+	int err;
+	pid_t pid;
+	int socket_fds[2];
+	int fds[FD_MAX];
+#define NFD(n) ((n) + 3)
+#define FD_OK(n) (NFD(n) == fds[n] && is_opened(fds[n]))
+
+	if (argc > 1 && strcmp(argv[1], "--child") == 0) {
+		int nfd = 0;
+		ksft_print_msg("we are child\n");
+		ksft_set_plan(3);
+		nfd += is_opened(NFD(FD_NORM));
+		ksft_test_result(nfd == 1, "normal fd opened\n");
+		nfd += is_opened(NFD(FD_CE));
+		ksft_test_result(nfd == 1, "O_CLOEXEC fd closed\n");
+		nfd += is_opened(NFD(FD_CA));
+		ksft_test_result(nfd == 1, "O_CRED_ALLOW fd closed\n");
+		/* exit with non-zero status propagates to parent's failure */
+		ksft_finished();
+		return 0;
+	}
+
+	ksft_set_plan(7);
+
+	fds[FD_NORM] = open("/proc/self/exe", O_RDONLY);
+	fds[FD_CE] = open("/proc/self/exe", O_RDONLY | O_CLOEXEC);
+	fds[FD_CA] = open("/proc/self/exe", O_RDONLY | O_CRED_ALLOW);
+	ksft_test_result(FD_OK(FD_NORM), "regular open\n");
+	ksft_test_result(FD_OK(FD_CE), "O_CLOEXEC open\n");
+	ksft_test_result(FD_OK(FD_CA), "O_CRED_ALLOW open\n");
+
+	err = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, socket_fds);
+	if (err) {
+		ksft_perror("socketpair() failed");
+		ksft_exit_fail_msg("socketpair\n");
+		return 1;
+	}
+	err = send_fd(socket_fds[0], fds[FD_NORM]);
+	ksft_test_result(err == 0, "normal fd sent\n");
+	err = send_fd(socket_fds[0], fds[FD_CE]);
+	ksft_test_result(err == 0, "O_CLOEXEC fd sent\n");
+	err = send_fd(socket_fds[0], fds[FD_CA]);
+	ksft_test_result(err == -EPERM, "O_CRED_ALLOW fd not sent, EPERM\n");
+	close(socket_fds[0]);
+	close(socket_fds[1]);
+
+	pid = fork();
+	if (pid < 0) {
+		ksft_perror("fork() failed");
+		ksft_exit_fail_msg("fork\n");
+		return 1;
+	}
+
+	if (pid == 0) {
+		char *cargv[] = {"cred_allow", "--child", NULL};
+
+		execve("/proc/self/exe", cargv, env);
+		ksft_perror("execve() failed");
+		ksft_exit_fail_msg("execve\n");
+		return 1;
+	}
+
+	if (waitpid(pid, &status, 0) != pid) {
+		ksft_perror("waitpid() failed");
+		ksft_exit_fail_msg("waitpid\n");
+		return 1;
+	}
+	ksft_print_msg("back to parent\n");
+
+	ksft_test_result(status == 0, "child success\n");
+
+	ksft_finished();
+	return 0;
+}
-- 
2.44.0


