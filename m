Return-Path: <linux-fsdevel+bounces-58848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDBEB3212F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BC0BB0845D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FA1321431;
	Fri, 22 Aug 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="APfe4TuR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B408D313554;
	Fri, 22 Aug 2025 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882504; cv=none; b=CHAdma42vCmgIAokS0USCsKWozKG08YvdcrSQMgv9FDtbdHba/nOtW/35yCvbFHgupTpHFe5j4E/zV17+5Ufke+qgW7W56V9kY4UOrIyT6vryAVyXg6zmG1wPwuOZauW4ub4fkFzGM49Gl9EfTs6D1/D5nmDYKlQf3LxaGm5/BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882504; c=relaxed/simple;
	bh=a0bfPIZilwtzdMjRhg2FvF4FRux6GrPkvAFHgegPRWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNVOaDo/LlQtXxea1ZvRGnKIkvpmPEA2wtle0cD6BLtY9QNe0UWAfauSPJt8hNleg96I38sv3CWHPHWzD+HnwRd0Th+ZB0p2NHKVqkxOJvBPjAeAqchnk9eAx1FI288/iieYK7U3XJIhMeGaHH2x53HpykMDIVpUoTtSFtB7W9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=APfe4TuR; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c7mq14Y0Sz1165;
	Fri, 22 Aug 2025 19:08:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1755882493;
	bh=4Pohfi350pEoPU/zQg61jutpwKFWUO6VrrmrOVVvjEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=APfe4TuRZ8GRVIc6wtAriNhinbsnaFb80/g+PAYZK5y1ijvDyKgUrOGg8Z6sMzHBm
	 XUzd6/DsMx4itm5EMSqx1SxeYAwh4mcvdQnzQz/BLDE6sxYHAQ7GayducB/U4S3NVL
	 L5Vp0PIJThySseul7YYLSaDqfOgnaBC25FoZbeC0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4c7mq04JRvznCZ;
	Fri, 22 Aug 2025 19:08:12 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Luca Boccassi <bluca@debian.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Robert Waite <rowait@microsoft.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Scott Shell <scottsh@microsoft.com>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v1 2/2] selftests/exec: Add O_DENY_WRITE tests
Date: Fri, 22 Aug 2025 19:08:00 +0200
Message-ID: <20250822170800.2116980-3-mic@digikod.net>
In-Reply-To: <20250822170800.2116980-1-mic@digikod.net>
References: <20250822170800.2116980-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Add 6 test suites to check O_DENY_WRITE used through open(2) and
fcntl(2).  Check that it fills its purpose, that it only applies to
regular files, and that setting this flag several times is not an issue.

The O_DENY_WRITE flag is useful in conjunction with AT_EXECVE_CHECK for
systems that don't enforce a write-xor-execute policy.  Extend related
tests to also use them as examples.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Robert Waite <rowait@microsoft.com>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250822170800.2116980-3-mic@digikod.net
---
 tools/testing/selftests/exec/check-exec.c | 219 ++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
index 55bce47e56b7..9db1d7b9aa97 100644
--- a/tools/testing/selftests/exec/check-exec.c
+++ b/tools/testing/selftests/exec/check-exec.c
@@ -30,6 +30,10 @@
 #define _ASM_GENERIC_FCNTL_H
 #include <linux/fcntl.h>
 
+#ifndef O_DENY_WRITE
+#define O_DENY_WRITE 040000000
+#endif
+
 #include "../kselftest_harness.h"
 
 static int sys_execveat(int dirfd, const char *pathname, char *const argv[],
@@ -319,6 +323,221 @@ TEST_F(access, non_regular_files)
 	test_exec_fd(_metadata, self->pipefd, EACCES);
 }
 
+TEST_F(access, deny_write_check_open)
+{
+	int fd_deny, fd_read, fd_write;
+
+	fd_deny = open(reg_file_path, O_DENY_WRITE | O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd_deny);
+
+	/* Concurrent reads are always allowed. */
+	fd_read = open(reg_file_path, O_RDONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_read);
+	EXPECT_EQ(0, close(fd_read));
+
+	/* Concurrent writes are denied. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_EQ(-1, fd_write);
+	EXPECT_EQ(ETXTBSY, errno);
+
+	/* Drops O_DENY_WRITE. */
+	EXPECT_EQ(0, close(fd_deny));
+
+	/* The restriction is now gone. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_write);
+	EXPECT_EQ(0, close(fd_write));
+}
+
+TEST_F(access, deny_write_check_open_and_fcntl)
+{
+	int fd_deny, fd_read, fd_write, flags;
+
+	fd_deny = open(reg_file_path, O_DENY_WRITE | O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd_deny);
+
+	/* Sets O_DENY_WRITE a "second" time. */
+	flags = fcntl(fd_deny, F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(0, fcntl(fd_deny, F_SETFL, flags | O_DENY_WRITE));
+
+	/* Concurrent reads are always allowed. */
+	fd_read = open(reg_file_path, O_RDONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_read);
+	EXPECT_EQ(0, close(fd_read));
+
+	/* Concurrent writes are denied. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_EQ(-1, fd_write);
+	EXPECT_EQ(ETXTBSY, errno);
+
+	/* Drops O_DENY_WRITE. */
+	EXPECT_EQ(0, close(fd_deny));
+
+	/* The restriction is now gone. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_write);
+	EXPECT_EQ(0, close(fd_write));
+}
+
+TEST_F(access, deny_write_check_fcntl)
+{
+	int fd_deny, fd_read, fd_write, flags;
+
+	fd_deny = open(reg_file_path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, fd_deny);
+
+	/* Sets O_DENY_WRITE a first time. */
+	flags = fcntl(fd_deny, F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(0, fcntl(fd_deny, F_SETFL, flags | O_DENY_WRITE));
+
+	/* Sets O_DENY_WRITE a "second" time. */
+	EXPECT_EQ(0, fcntl(fd_deny, F_SETFL, flags | O_DENY_WRITE));
+
+	/* Concurrent reads are always allowed. */
+	fd_read = open(reg_file_path, O_RDONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_read);
+	EXPECT_EQ(0, close(fd_read));
+
+	/* Concurrent writes are denied. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_EQ(-1, fd_write);
+	EXPECT_EQ(ETXTBSY, errno);
+
+	/* Drops O_DENY_WRITE. */
+	EXPECT_EQ(0, fcntl(fd_deny, F_SETFL, flags & ~O_DENY_WRITE));
+
+	/* The restriction is now gone. */
+	fd_write = open(reg_file_path, O_WRONLY | O_CLOEXEC);
+	EXPECT_LE(0, fd_write);
+	EXPECT_EQ(0, close(fd_write));
+
+	EXPECT_EQ(0, close(fd_deny));
+}
+
+static void test_deny_write_open(struct __test_metadata *_metadata,
+				 const char *const path, int flags,
+				 const int err_code)
+{
+	int fd;
+
+	flags |= O_CLOEXEC;
+
+	/* Do not block on pipes. */
+	if (path == fifo_path)
+		flags |= O_NONBLOCK;
+
+	fd = open(path, flags | O_RDONLY);
+	if (err_code) {
+		ASSERT_EQ(-1, fd)
+		{
+			TH_LOG("Successfully opened %s", path);
+		}
+		EXPECT_EQ(errno, err_code)
+		{
+			TH_LOG("Wrong error code for %s: %s", path,
+			       strerror(errno));
+		}
+	} else {
+		ASSERT_LE(0, fd)
+		{
+			TH_LOG("Failed to open %s: %s", path, strerror(errno));
+		}
+		EXPECT_EQ(0, close(fd));
+	}
+}
+
+TEST_F(access, deny_write_type_open)
+{
+	test_deny_write_open(_metadata, reg_file_path, O_DENY_WRITE, 0);
+	test_deny_write_open(_metadata, dir_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_open(_metadata, block_dev_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_open(_metadata, char_dev_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_open(_metadata, fifo_path, O_DENY_WRITE, EINVAL);
+}
+
+static void test_deny_write_fcntl(struct __test_metadata *_metadata,
+				  const char *const path, int setfl,
+				  const int err_code)
+{
+	int fd, ret;
+	int getfl, flags = O_CLOEXEC;
+
+	/* Do not block on pipes. */
+	if (path == fifo_path)
+		flags |= O_NONBLOCK;
+
+	fd = open(path, flags | O_RDONLY);
+	ASSERT_LE(0, fd)
+	{
+		TH_LOG("Failed to open %s: %s", path, strerror(errno));
+	}
+	getfl = fcntl(fd, F_GETFL);
+	ASSERT_NE(-1, getfl);
+	ret = fcntl(fd, F_SETFL, getfl | setfl);
+	if (err_code) {
+		ASSERT_EQ(-1, ret)
+		{
+			TH_LOG("Successfully updated flags for %s", path);
+		}
+		EXPECT_EQ(errno, err_code)
+		{
+			TH_LOG("Wrong error code for %s: %s", path,
+			       strerror(errno));
+		}
+	} else {
+		ASSERT_LE(0, ret)
+		{
+			TH_LOG("Failed to update flags for %s: %s", path,
+			       strerror(errno));
+		}
+		EXPECT_EQ(0, close(fd));
+	}
+}
+
+TEST_F(access, deny_write_type_fcntl)
+{
+	int flags;
+
+	test_deny_write_fcntl(_metadata, reg_file_path, O_DENY_WRITE, 0);
+	test_deny_write_fcntl(_metadata, dir_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_fcntl(_metadata, block_dev_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_fcntl(_metadata, char_dev_path, O_DENY_WRITE, EINVAL);
+	test_deny_write_fcntl(_metadata, fifo_path, O_DENY_WRITE, EINVAL);
+
+	flags = fcntl(self->socket_fds[0], F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(-1,
+		  fcntl(self->socket_fds[0], F_SETFL, flags | O_DENY_WRITE));
+	EXPECT_EQ(EINVAL, errno);
+
+	flags = fcntl(self->pipefd, F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(-1, fcntl(self->pipefd, F_SETFL, flags | O_DENY_WRITE));
+	EXPECT_EQ(EINVAL, errno);
+}
+
+TEST_F(access, allow_write_type_fcntl)
+{
+	int flags;
+
+	test_deny_write_fcntl(_metadata, reg_file_path, 0, 0);
+	test_deny_write_fcntl(_metadata, dir_path, 0, 0);
+	test_deny_write_fcntl(_metadata, block_dev_path, 0, 0);
+	test_deny_write_fcntl(_metadata, char_dev_path, 0, 0);
+	test_deny_write_fcntl(_metadata, fifo_path, 0, 0);
+
+	flags = fcntl(self->socket_fds[0], F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(0,
+		  fcntl(self->socket_fds[0], F_SETFL, flags & ~O_DENY_WRITE));
+
+	flags = fcntl(self->pipefd, F_GETFL);
+	ASSERT_NE(-1, flags);
+	EXPECT_EQ(0, fcntl(self->pipefd, F_SETFL, flags & ~O_DENY_WRITE));
+}
+
 /* clang-format off */
 FIXTURE(secbits) {};
 /* clang-format on */
-- 
2.50.1


