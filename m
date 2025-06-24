Return-Path: <linux-fsdevel+bounces-52706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19184AE5F66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA509406AEB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9321625BEE9;
	Tue, 24 Jun 2025 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgStYn58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B22571BF;
	Tue, 24 Jun 2025 08:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753796; cv=none; b=upX1VqkIYJfdWzUdzJAd66CQEGhtF9iwpoi2qTx4edUOZ2xBYErKStua3eo/l89Y9xExYT4ewiMig6tOsmd9J2x1VBGL/NMhHJxrlPeLfUDyBcQfKhZ7PHc+yW2murdBoQtbzu6zQOYYJQ+rQ1JJ2SwlE8pvv6zi/MJwc/KlxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753796; c=relaxed/simple;
	bh=BRfVxX6EK5nWsUtCe5pSN4QPrbbhGpRxaZHe9PA0+3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tT6cdSzxKr4+XxHAozOc3xQzbQgg7KDbTIX5h859Ot9cmgYfYK8hz0pnpOo3Tjq8a75/+Hhv437bd/O7aRrf4mqrftbqp4KSWsBpgMz6uNO/DTMiUf4v8TbNCsQBXNW60p5Aox3v62pFkA/96BzqbfRVPw8cn4vXt8nlnAMUKoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgStYn58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE373C4CEF1;
	Tue, 24 Jun 2025 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753794;
	bh=BRfVxX6EK5nWsUtCe5pSN4QPrbbhGpRxaZHe9PA0+3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QgStYn58+j4EZAAzhfcBObwqQNnczzvT5LbssVGSjR7AjRAJJnWogyGNLLeslhZUN
	 0F3uVcoLuKzYkkh4e5Pymht8n92RsSe5pyrT2vFM6QpvFFteaQShRiTPmXxEOxUfau
	 cKoaQBXLUC2l9VdFTOHZabXueMouAFqnN8K5BxXZoLRs+K/J8qFFYInosSREUGRmSp
	 2cGnfCirMqqyPCmoV48KjFj9yclGfUcBpfLAdilGxWj24hRs0oXqIzuqeXklu+2048
	 5oEsDQDHEaQREM+3T2m0yo6GHflIgzS4zr0uCSY44pu1EG1L2JLvKLVZLNMYXYDnZk
	 HETXsgv7RX4Gg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:14 +0200
Subject: [PATCH v2 11/11] selftests/pidfd: decode pidfd file handles withou
 having to specify an fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-11-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3368; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BRfVxX6EK5nWsUtCe5pSN4QPrbbhGpRxaZHe9PA0+3s=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb5g2bWy+bRRIlNT8i6RfT0zZxqlqf65/9lfwLDM+
 sAKVV6TjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgJu8nuF/iUlq19YLC5tPeQja
 Jcp94Q9rlsw76KciEBar2KYsskKXkWH90UkWFxN/K1fUVvJH5Z6ftEY0IfxU+vqLwpMWrY3p9GY
 DAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/Makefile             |  2 +-
 tools/testing/selftests/pidfd/pidfd.h              |  4 ++
 .../selftests/pidfd/pidfd_file_handle_test.c       | 60 ++++++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
index 03a6eede9c9e..764a8f9ecefa 100644
--- a/tools/testing/selftests/pidfd/Makefile
+++ b/tools/testing/selftests/pidfd/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
+CFLAGS += -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
 
 TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
 	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 5dfeb1bdf399..b427a2636402 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -19,6 +19,10 @@
 #include "../kselftest.h"
 #include "../clone3/clone3_selftests.h"
 
+#ifndef FD_INVALID
+#define FD_INVALID -10009 /* Invalid file descriptor. */
+#endif
+
 #ifndef P_PIDFD
 #define P_PIDFD 3
 #endif
diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
index 439b9c6c0457..ff1bf51bca5e 100644
--- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
@@ -500,4 +500,64 @@ TEST_F(file_handle, valid_name_to_handle_at_flags)
 	ASSERT_EQ(close(pidfd), 0);
 }
 
+/*
+ * That we decode a file handle without having to pass a pidfd.
+ */
+TEST_F(file_handle, decode_purely_based_on_file_handle)
+{
+	int mnt_id;
+	struct file_handle *fh;
+	int pidfd = -EBADF;
+	struct stat st1, st2;
+
+	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	ASSERT_NE(fh, NULL);
+	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
+	fh->handle_bytes = MAX_HANDLE_SZ;
+
+	ASSERT_EQ(name_to_handle_at(self->child_pidfd1, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
+
+	ASSERT_EQ(fstat(self->child_pidfd1, &st1), 0);
+
+	pidfd = open_by_handle_at(FD_INVALID, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(FD_INVALID, fh, O_CLOEXEC);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(FD_INVALID, fh, O_NONBLOCK);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(self->pidfd, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(-EBADF, fh, 0);
+	ASSERT_LT(pidfd, 0);
+
+	pidfd = open_by_handle_at(AT_FDCWD, fh, 0);
+	ASSERT_LT(pidfd, 0);
+
+	free(fh);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


