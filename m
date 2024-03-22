Return-Path: <linux-fsdevel+bounces-15095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8EF6886F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614EC1F22CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67F4F615;
	Fri, 22 Mar 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZXDtZmIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FF94F897
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120231; cv=none; b=FW2Gu1izvancmnm6eKzXuTwofqIh779KGWFXvYujI9dlKCqtxv0UQrVILGF3hvvlD4Gxf15b7EXK63TvDkgbBV5+X9sRxtXKXoJiHJz+9+4wW+m9B5fcjolxmIQUvr7LkRpsR3SjfOfD7tu4Uwi/Qee5E4azrXOCUETmOX8FEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120231; c=relaxed/simple;
	bh=Zui2v1od/elMRFrLL3WvczuYkqdRJ607JihPTYWoBxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MDBNzkbQl4sTvJPHnbzyHZNet5pdDucYuBNHXk6CWkhDCsLb0kqtqbzIRytW4UwiuMdsw9g7HXYpTJLfEyzqZRbTQiTT7gZQQJ0dDCIdm0nzL4mZ7YOFLYX52DG7QcDMzSQVbCJQl9nSzNUaJSvQytLCcgQ2pe7Ld3vjTtsAylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZXDtZmIg; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a47103b2261so115311466b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120228; x=1711725028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9e1vLBZyU81CA03W1c5FAr2hW3zhJCc3KJ54WTxEPY=;
        b=ZXDtZmIguQVMivdv/eOsPXtjuDZHr9Zqhl9lzMxoNPQaM6bghCdX9BR9HjPo0/d6TB
         gC3YxZht84HQh5/8MNoktYxrWaot4+JcaCjOaHpRFF0OX7cNA411EuVySrRLMJ9l+Rf0
         guGWShjFk36qUjkkgPoCKYnnuD3SwxAl8VkHPSuvkCb2TVtMAB2fJ4BcJvjsPWe6kLIL
         32Q6ahNBOudnMXoMvoTzeuoELpL8UsnS7I2aOh2UpJbPdbnKfivHlDVXOSNlxejByaYK
         LVjBIaJCbJVbt1UdrF0qW0YLSWUq1Dr51DazQFCnmw5foedCFL1ZzK4wXLPrH2u5Uxs4
         B2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120228; x=1711725028;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9e1vLBZyU81CA03W1c5FAr2hW3zhJCc3KJ54WTxEPY=;
        b=Ug4h+evgOmBbU8NSUPsNo8ep2s0x5NX+GpaVaOgqcZTq75dbSUVpsyea1Yd+jKqO8j
         KcDeBX7lK6pro6C86dsx4jCvM1Ho6bGe6JPSobEUGkCaf7RrUJJh+UBJQK4LHG5Xpz33
         QfxIJewyS9kFiozl45sTSkio7YWO9z4K82a37Q0SFelGjH8V+61LOH+Z2AkiTbFz1RfL
         qekQCVJ1l18ZgUGdBO62YdnXIqCOD74w9sdSXsG4xcixSsSlBYLptzGcUmkxAe0mzzQf
         1AF5o3Uz6eCOV1IWHOD5Qd39OPdbpRF2QpsXDK8BS0BdnTm/I832/wVAWfuMFtjSCi7T
         c0nQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1lvooHsIBhaPQ30N7Xyz/BpEwwu+zrrV7WIiQqpgoZ/zTa2tCTdswBMZk/hnYCGD3bYObbAKdqgCpOCIjdorxJnCHwuNJrKgBcGCW9w==
X-Gm-Message-State: AOJu0Yx3QykXqH51b94a0XiGhmUwhwlFiXZmgOi4Mi+lWtzKISq2dAhw
	X2XQ1uHeBlIIFEqgbJcAw12ZLTO5WZyTC8QD6PvcmspqMQHvcdcI7QDiG5CD0wJgLUN4oIoOTOa
	4oQ==
X-Google-Smtp-Source: AGHT+IG6Ca8DZ4cAM6ldO7A7OzePRWTyWzZ4f5MoTIu+1T3g5D4zS1hMo9S/KsL/azFqdsCMVJKywOvmTqo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:2669:b0:a47:33f1:3ba with SMTP id
 ci9-20020a170907266900b00a4733f103bamr3ejc.10.1711120227818; Fri, 22 Mar 2024
 08:10:27 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:56 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-4-gnoack@google.com>
Subject: [PATCH v11 3/9] selftests/landlock: Test IOCTL support
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Exercises Landlock's IOCTL feature in different combinations of
handling and permitting the LANDLOCK_ACCESS_FS_IOCTL_DEV right, and in
different combinations of using files and directories.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 236 ++++++++++++++++++++-
 1 file changed, 233 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 0bcbbf594fd7..22229fe3e403 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -8,6 +8,7 @@
  */
=20
 #define _GNU_SOURCE
+#include <asm/termbits.h>
 #include <fcntl.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
@@ -15,6 +16,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <sys/capability.h>
+#include <sys/ioctl.h>
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/sendfile.h>
@@ -23,6 +25,12 @@
 #include <sys/vfs.h>
 #include <unistd.h>
=20
+/*
+ * Intentionally included last to work around header conflict.
+ * See https://sourceware.org/glibc/wiki/Synchronizing_Headers.
+ */
+#include <linux/fs.h>
+
 #include "common.h"
=20
 #ifndef renameat2
@@ -735,6 +743,9 @@ static int create_ruleset(struct __test_metadata *const=
 _metadata,
 	}
=20
 	for (i =3D 0; rules[i].path; i++) {
+		if (!rules[i].access)
+			continue;
+
 		add_path_beneath(_metadata, ruleset_fd, rules[i].access,
 				 rules[i].path);
 	}
@@ -3443,7 +3454,7 @@ TEST_F_FORK(layout1, truncate_unhandled)
 			      LANDLOCK_ACCESS_FS_WRITE_FILE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3526,7 +3537,7 @@ TEST_F_FORK(layout1, truncate)
 			      LANDLOCK_ACCESS_FS_TRUNCATE;
 	int ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, handled, rules);
=20
 	ASSERT_LE(0, ruleset_fd);
@@ -3752,7 +3763,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate)
 	};
 	int fd, ruleset_fd;
=20
-	/* Enable Landlock. */
+	/* Enables Landlock. */
 	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
 	ASSERT_LE(0, ruleset_fd);
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -3829,6 +3840,16 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
+{
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
+
 TEST(memfd_ftruncate)
 {
 	int fd;
@@ -3845,6 +3866,215 @@ TEST(memfd_ftruncate)
 	ASSERT_EQ(0, close(fd));
 }
=20
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+/* clang-format off */
+FIXTURE(ioctl) {};
+
+FIXTURE_SETUP(ioctl) {};
+
+FIXTURE_TEARDOWN(ioctl) {};
+/* clang-format on */
+
+FIXTURE_VARIANT(ioctl)
+{
+	const __u64 handled;
+	const __u64 allowed;
+	const mode_t open_mode;
+	/*
+	 * TCGETS is used as a characteristic device-specific IOCTL command.
+	 * The logic is the same for other IOCTL commands as well.
+	 */
+	const int expected_tcgets_result; /* terminal device IOCTL */
+	/*
+	 * FIONREAD is implemented in fs/ioctl.c for regular files,
+	 * but we do not blanket-permit it for devices.
+	 */
+	const int expected_fionread_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_none) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D 0,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D EACCES,
+	.expected_fionread_result =3D EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, handled_i_allowed_i) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.allowed =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ioctl, unhandled) {
+	/* clang-format on */
+	.handled =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.allowed =3D LANDLOCK_ACCESS_FS_EXECUTE,
+	.open_mode =3D O_RDWR,
+	.expected_tcgets_result =3D 0,
+	.expected_fionread_result =3D 0,
+};
+
+static int test_fioqsize_ioctl(int fd)
+{
+	size_t sz;
+
+	if (ioctl(fd, FIOQSIZE, &sz) < 0)
+		return errno;
+	return 0;
+}
+
+static int test_tcgets_ioctl(int fd)
+{
+	struct termios info;
+
+	if (ioctl(fd, TCGETS, &info) < 0)
+		return errno;
+	return 0;
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open("/dev/tty", variant->open_mode);
+	ASSERT_LE(0, file_fd);
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(ENOTTY, test_fioqsize_ioctl(file_fd));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
+TEST_F_FORK(ioctl, handle_dir_access_dir)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int dir_fd, ruleset_fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Ignore variant->open_mode for this test, as we intend to open a
+	 * directory.  If the directory can not be opened, the variant is
+	 * infeasible to test with an opened directory.
+	 */
+	dir_fd =3D open("/dev", O_RDONLY);
+	if (dir_fd < 0)
+		return;
+
+	/*
+	 * Checks that IOCTL commands return the expected errors.
+	 * We do not use the expected values from the fixture here.
+	 *
+	 * When using IOCTL on a directory, no Landlock restrictions apply.
+	 * TCGETS will fail anyway because it is not invoked on a TTY device.
+	 */
+	EXPECT_EQ(ENOTTY, test_tcgets_ioctl(dir_fd));
+	EXPECT_EQ(0, test_fionread_ioctl(dir_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(dir_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(dir_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(dir_fd, FIOASYNC, &flag));
+	EXPECT_EQ(0, test_fioqsize_ioctl(dir_fd));
+
+	ASSERT_EQ(0, close(dir_fd));
+}
+
+TEST_F_FORK(ioctl, handle_file_access_file)
+{
+	const int flag =3D 0;
+	const struct rule rules[] =3D {
+		{
+			.path =3D "/dev/tty0",
+			.access =3D variant->allowed,
+		},
+		{},
+	};
+	int file_fd, ruleset_fd;
+
+	if (variant->allowed & LANDLOCK_ACCESS_FS_READ_DIR) {
+		SKIP(return, "LANDLOCK_ACCESS_FS_READ_DIR "
+			     "can not be granted on files");
+	}
+
+	/* Enables Landlock. */
+	ruleset_fd =3D create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	file_fd =3D open("/dev/tty0", variant->open_mode);
+	ASSERT_LE(0, file_fd)
+	{
+		TH_LOG("Failed to open /dev/tty0: %s", strerror(errno));
+	}
+
+	/* Checks that IOCTL commands return the expected errors. */
+	EXPECT_EQ(variant->expected_tcgets_result, test_tcgets_ioctl(file_fd));
+	EXPECT_EQ(variant->expected_fionread_result,
+		  test_fionread_ioctl(file_fd));
+
+	/* Checks that unrestrictable commands are unrestricted. */
+	EXPECT_EQ(0, ioctl(file_fd, FIOCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONCLEX));
+	EXPECT_EQ(0, ioctl(file_fd, FIONBIO, &flag));
+	EXPECT_EQ(0, ioctl(file_fd, FIOASYNC, &flag));
+	EXPECT_EQ(ENOTTY, test_fioqsize_ioctl(file_fd));
+
+	ASSERT_EQ(0, close(file_fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
--=20
2.44.0.396.g6e790dbe36-goog


