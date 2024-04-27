Return-Path: <linux-fsdevel+bounces-17971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 961598B461C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 13:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81BA1C23669
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Apr 2024 11:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427464E1C3;
	Sat, 27 Apr 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="adGg37hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929EC4AEE6;
	Sat, 27 Apr 2024 11:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714217110; cv=none; b=NiaxJUhrd/eb4By6MviK8NnjePqnwMN43C9UAUMvVRDPWRSkUmP6tPGZnSDbXVsu4qWh0BxCLh8X4XGW5T//AhEg9uunPY/AyRPaROL0rWRUqtsJajn6YmBO65euA3ZBSQMviPYUd4dGyCgTyp+NgOE4Z3iopqUA0AyJxGNdEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714217110; c=relaxed/simple;
	bh=W7PssKyiRaYEQB5YHrsW1/XTUqJyt5uCS+o+ZGyF7XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYrD3N4/EbZ2n3vW9sN6v6yuvFXVlXxJFIlCDjs3t7lC+6vCOG5nWFdpb95mR1LTq2VHDMRAOHUr4SWTN4DeUpoKAT85gFYomRf5ihMmz3M/bICNLcrrLDOeFpoXvInOiNuDi6OpVWH1N0lZj+GGR7bjOG41XuR4Zid/4cBEi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=adGg37hg; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:2a02:0:640:77d9:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id D77E060B3E;
	Sat, 27 Apr 2024 14:25:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-51.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id uOMFvPQXlqM0-loBR5XnJ;
	Sat, 27 Apr 2024 14:25:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714217102; bh=WN9hMK6T6laeTAn39mP2s0GnYEpzPpKo/cK8/O3HMGs=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=adGg37hger9WzzkUg+MntVW6ndkwqBel40+o4inpuy5H4x/4KSaRXxmL2puJOTWX5
	 DT3l2MZCIfCNo5HSjsRY9Wq7Z6ZoDiUxDEKPBhyu+mto2OUjjjYuCieVFTQSz9BxDN
	 qpKwhjz0hUw+w3ZApsutO7obQ0C7HjF//gG0S6jU=
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
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v6 3/3] openat2: add OA2_CRED_INHERIT flag
Date: Sat, 27 Apr 2024 14:24:51 +0300
Message-ID: <20240427112451.1609471-4-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240427112451.1609471-1-stsp2@yandex.ru>
References: <20240427112451.1609471-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This flag performs the open operation with the fs credentials
(fsuid, fsgid, group_info) that were in effect when dir_fd was opened.
dir_fd must be opened with O_CRED_ALLOW, or EPERM is returned.

Selftests are added to check for these properties as well as for
the invalid flag combinations.

This allows the process to pre-open some directories and then
change eUID (and all other UIDs/GIDs) to a less-privileged user,
retaining the ability to open/create files within these directories.

Design goal:
The idea is to provide a very light-weight sandboxing, where the
process, without the use of any heavy-weight techniques like chroot
within namespaces, can restrict the access to the set of pre-opened
directories.
This patch is just a first step to such sandboxing. If things go
well, in the future the same extension can be added to more syscalls.
These should include at least unlinkat(), renameat2() and the
not-yet-upstreamed setxattrat().

Security considerations:
- Only the bare minimal set of credentials is overridden:
  fsuid, fsgid and group_info. The rest, for example capabilities,
  are not overridden to avoid unneeded security risks.
- To avoid sandboxing escape, this patch makes sure the restricted
  lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
- Magic /proc symlinks are discarded, as suggested by
  Andy Lutomirski <luto@kernel.org>
- O_CRED_ALLOW fds cannot be passed via unix socket and are always
  closed on exec() to prevent "unsuspecting userspace" from not being
  able to fully drop privs.

Use cases:
Virtual machines that deal with untrusted code, can use that
instead of a more heavy-weighted approaches.
Currently the approach is being tested on a dosemu2 VM.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Stefan Metzmacher <metze@samba.org>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Andy Lutomirski <luto@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Aring <alex.aring@gmail.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>
---
 fs/fcntl.c                                    |   2 +
 fs/namei.c                                    |  56 +++++++++-
 fs/open.c                                     |  10 +-
 include/linux/fcntl.h                         |   2 +
 include/uapi/linux/openat2.h                  |   2 +
 tools/testing/selftests/openat2/Makefile      |   2 +-
 .../testing/selftests/openat2/cred_inherit.c  | 105 ++++++++++++++++++
 .../testing/selftests/openat2/openat2_test.c  |  12 +-
 8 files changed, 186 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/openat2/cred_inherit.c

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 78c96b1293c2..283c2e65fc2c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1043,6 +1043,8 @@ static int __init fcntl_init(void)
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
+	BUILD_BUG_ON(HWEIGHT32(VALID_OPENAT2_FLAGS) !=
+			HWEIGHT32(VALID_OPEN_FLAGS) + 1);
 
 	fasync_cache = kmem_cache_create("fasync_cache",
 					 sizeof(struct fasync_struct), 0,
diff --git a/fs/namei.c b/fs/namei.c
index dd50345f7260..aa5dcf57851b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3776,6 +3776,43 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	return error;
 }
 
+static const struct cred *openat2_init_creds(int dfd)
+{
+	struct cred *cred;
+	struct fd f;
+
+	if (dfd == AT_FDCWD)
+		return ERR_PTR(-EINVAL);
+
+	f = fdget_raw(dfd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	cred = ERR_PTR(-EPERM);
+	if (!(f.file->f_flags & O_CRED_ALLOW))
+		goto done;
+
+	cred = prepare_creds();
+	if (!cred) {
+		cred = ERR_PTR(-ENOMEM);
+		goto done;
+	}
+
+	cred->fsuid = f.file->f_cred->fsuid;
+	cred->fsgid = f.file->f_cred->fsgid;
+	cred->group_info = get_group_info(f.file->f_cred->group_info);
+
+done:
+	fdput(f);
+	return cred;
+}
+
+static void openat2_done_creds(const struct cred *cred)
+{
+	put_group_info(cred->group_info);
+	put_cred(cred);
+}
+
 static struct file *path_openat(struct nameidata *nd,
 			const struct open_flags *op, unsigned flags)
 {
@@ -3793,18 +3830,33 @@ static struct file *path_openat(struct nameidata *nd,
 			error = do_o_path(nd, flags, file);
 	} else {
 		const char *s;
+		const struct cred *old_cred = NULL, *cred = NULL;
 
-		file = alloc_empty_file(open_flags, current_cred());
-		if (IS_ERR(file))
+		if (open_flags & OA2_CRED_INHERIT) {
+			cred = openat2_init_creds(nd->dfd);
+			if (IS_ERR(cred))
+				return ERR_CAST(cred);
+		}
+		file = alloc_empty_file(open_flags, cred ?: current_cred());
+		if (IS_ERR(file)) {
+			if (cred)
+				openat2_done_creds(cred);
 			return file;
+		}
 
 		s = path_init(nd, flags);
+		if (cred)
+			old_cred = override_creds(cred);
 		while (!(error = link_path_walk(s, nd)) &&
 		       (s = open_last_lookups(nd, file, op)) != NULL)
 			;
 		if (!error)
 			error = do_open(nd, file, op);
+		if (old_cred)
+			revert_creds(old_cred);
 		terminate_walk(nd);
+		if (cred)
+			openat2_done_creds(cred);
 	}
 	if (likely(!error)) {
 		if (likely(file->f_mode & FMODE_OPENED))
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..dd4fab536135 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1225,7 +1225,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1326,6 +1326,14 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_CACHED;
 	}
 
+	if (flags & OA2_CRED_INHERIT) {
+		/* Inherit creds only with scoped look-up modes. */
+		if (!(lookup_flags & LOOKUP_IS_SCOPED))
+			return -EPERM;
+		/* Reject /proc "magic" links if inheriting creds. */
+		lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	}
+
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index e074ee9c1e36..33b9c7ad056b 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_CRED_ALLOW)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OA2_CRED_INHERIT)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..f803558ad62f 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,6 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+#define OA2_CRED_INHERIT		(1UL << 28)
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 254d676a2689..a1f4b5395f82 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
-TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
+TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test cred_inherit
 
 include ../lib.mk
 
diff --git a/tools/testing/selftests/openat2/cred_inherit.c b/tools/testing/selftests/openat2/cred_inherit.c
new file mode 100644
index 000000000000..550a06763ac7
--- /dev/null
+++ b/tools/testing/selftests/openat2/cred_inherit.c
@@ -0,0 +1,105 @@
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
+#include "helpers.h"
+
+#ifndef O_CRED_ALLOW
+#define O_CRED_ALLOW 0x2000000
+#endif
+
+#ifndef OA2_CRED_INHERIT
+#define OA2_CRED_INHERIT (1UL << 28)
+#endif
+
+enum { FD_NORM, FD_NCA, FD_DIR, FD_DCA, FD_MAX };
+
+int main(int argc, char *argv[], char *env[])
+{
+	struct open_how how1 = {
+				.flags = O_RDONLY,
+				.resolve = RESOLVE_BENEATH,
+			       };
+	struct open_how how2 = {
+				.flags = O_RDONLY | OA2_CRED_INHERIT,
+				.resolve = RESOLVE_BENEATH,
+			       };
+	int size = sizeof(struct open_how);
+	int i;
+	int fd;
+	int err;
+	int fds[FD_MAX];
+#define NFD(n) ((n) + 3)
+#define FD_OK(n) (NFD(n) == fds[n])
+
+	if (!openat2_supported) {
+		ksft_print_msg("openat2(2) unsupported\n");
+		return 0;
+	}
+
+	ksft_set_plan(14);
+
+	fds[FD_NORM] = open("/proc/self/maps", O_RDONLY);
+	fds[FD_NCA] = open("/proc/self/maps", O_RDONLY | O_CRED_ALLOW);
+	fds[FD_DIR] = open("/proc/self", O_RDONLY | O_DIRECTORY);
+	fds[FD_DCA] = open("/proc/self", O_RDONLY | O_DIRECTORY | O_CRED_ALLOW);
+	ksft_test_result(FD_OK(FD_NORM), "file open\n");
+	ksft_test_result(FD_OK(FD_NCA), "file open with O_CRED_ALLOW\n");
+	ksft_test_result(FD_OK(FD_DIR), "directory open\n");
+	ksft_test_result(FD_OK(FD_DCA), "directory open with O_CRED_ALLOW\n");
+
+	err = fchdir(fds[FD_DIR]);
+	if (err) {
+		ksft_perror("fchdir() failed");
+		ksft_exit_fail_msg("fchdir\n");
+		return 1;
+	}
+	fd = syscall(SYS_openat2, AT_FDCWD, "maps", &how1, size);
+	ksft_test_result(fd != -1, "AT_FDCWD success\n");
+	close(fd);
+	/* OA2_CRED_INHERIT fails with AT_FDCWD */
+	fd = syscall(SYS_openat2, AT_FDCWD, "maps", &how2, size);
+	ksft_test_result(fd == -1 && errno == EINVAL, "AT_FDCWD EINVAL\n");
+
+	fd = syscall(SYS_openat2, fds[FD_NORM], "maps", &how1, size);
+	ksft_test_result(fd == -1 && errno == ENOTDIR, "regilar file ENOTDIR\n");
+	/* No O_CRED_ALLOW -> EPERM */
+	fd = syscall(SYS_openat2, fds[FD_NORM], "maps", &how2, size);
+	ksft_test_result(fd == -1 && errno == EPERM, "regilar file EPERM\n");
+
+	fd = syscall(SYS_openat2, fds[FD_NCA], "maps", &how1, size);
+	ksft_test_result(fd == -1 && errno == ENOTDIR, "regilar file ENOTDIR\n");
+	fd = syscall(SYS_openat2, fds[FD_NCA], "maps", &how2, size);
+	ksft_test_result(fd == -1 && errno == ENOTDIR, "regilar file ENOTDIR\n");
+
+	fd = syscall(SYS_openat2, fds[FD_DIR], "maps", &how1, size);
+	ksft_test_result(fd != -1, "dir fd success\n");
+	close(fd);
+	/* No O_CRED_ALLOW -> EPERM */
+	fd = syscall(SYS_openat2, fds[FD_DIR], "maps", &how2, size);
+	ksft_test_result(fd == -1 && errno == EPERM, "dir fd EPERM\n");
+
+	fd = syscall(SYS_openat2, fds[FD_DCA], "maps", &how1, size);
+	ksft_test_result(fd != -1, "dir O_CRED_ALLOW fd success\n");
+	close(fd);
+	fd = syscall(SYS_openat2, fds[FD_DCA], "maps", &how2, size);
+	ksft_test_result(fd != -1, "dir O_CRED_ALLOW fd O_CRED_INHERIT success\n");
+	close(fd);
+
+	for (i = 0; i < FD_MAX; i++)
+		close(fds[i]);
+	ksft_finished();
+	return 0;
+}
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 9024754530b2..5095288fe1ac 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -28,6 +28,10 @@
 #define	O_LARGEFILE 0x8000
 #endif
 
+#ifndef OA2_CRED_INHERIT
+#define OA2_CRED_INHERIT (1UL << 28)
+#endif
+
 struct open_how_ext {
 	struct open_how inner;
 	uint32_t extra1;
@@ -159,7 +163,7 @@ struct flag_test {
 	int err;
 };
 
-#define NUM_OPENAT2_FLAG_TESTS 25
+#define NUM_OPENAT2_FLAG_TESTS 27
 
 void test_openat2_flags(void)
 {
@@ -233,6 +237,12 @@ void test_openat2_flags(void)
 		{ .name = "invalid how.resolve and O_PATH",
 		  .how.flags = O_PATH,
 		  .how.resolve = 0x1337, .err = -EINVAL },
+		{ .name = "invalid how.resolve and OA2_CRED_INHERIT",
+		  .how.flags = OA2_CRED_INHERIT,
+		  .how.resolve = 0, .err = -EPERM },
+		{ .name = "invalid AT_FDCWD and OA2_CRED_INHERIT",
+		  .how.flags = OA2_CRED_INHERIT,
+		  .how.resolve = 0x08, .err = -EINVAL },
 
 		/* currently unknown upper 32 bit rejected. */
 		{ .name = "currently unknown bit (1 << 63)",
-- 
2.44.0


