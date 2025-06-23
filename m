Return-Path: <linux-fsdevel+bounces-52505-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B14AE395B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388B43B9501
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC9238C35;
	Mon, 23 Jun 2025 09:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdgcH2cg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D2238C16;
	Mon, 23 Jun 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669318; cv=none; b=YpTr/4XinzQwI7vjmLtQlIjAasfyrwcorh8ERVCl0E01SA0ZQv96PDHZi8BqdS9AjpIRx92oqzYK175EFqJTfNzVuYReNbFCASO+MVJs/GfDLKN3k9vw8uTqBU/3iQuhAY0lSYWJGD44ZEiFSoy4ABtydeazN+SLLmo/MXn4Hts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669318; c=relaxed/simple;
	bh=TVFVDLeM3Mz4Xq7wpzRyDiOJmxnCx9C5H6NrmYAME0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JChC3IP0O5yUqLMzee/UL6zAEAWyx/IA7y8SiglzbiHxilKGa+AnHzC7dVgOyqmFURZhCYlJGWRJefnM0vJNmwIOJfAvT/cj0W9ezbj2/QXxnXXPUldHcHKUVmepkiJ/JmgXv1R3fDXWIbBYc78OBc3Q5klwiXiLZG5nvDB4OeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdgcH2cg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E62EC4CEF2;
	Mon, 23 Jun 2025 09:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669317;
	bh=TVFVDLeM3Mz4Xq7wpzRyDiOJmxnCx9C5H6NrmYAME0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PdgcH2cg553/NKwNkHyYRgxC4m4eYRSqgANr6KxxIaboejGN9lLslUMxhIh/rlv3L
	 Fx2V4C53EtFmNn+FNg0UiMMZ5KWOMh+jeIgc5wGEf1+XcIppGU1xY7Gh9gCu8Okq9v
	 rSrEYSwTZcHuMnZNrqzHe8mMZQu/2nJ7xYMPzzbgZDNEuSI3s0wR+wXw4jAfOREylv
	 ogKa2MTqeuZcmh0toVovEKjE9o6PR290+Dxcs2HKsfYpFxkwJRmzTxFtynYMaxQI7N
	 RvJPQ+6E9gjq3xXsaRpoXn2BydI/CGDw6HLdh5P8Z7WJr5l3h/9pabeJKOv+KnRn/c
	 8aONxuQpvxq7w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:31 +0200
Subject: [PATCH 9/9] selftests/pidfd: decode pidfd file handles withou
 having to specify an fd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-9-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2694; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TVFVDLeM3Mz4Xq7wpzRyDiOJmxnCx9C5H6NrmYAME0Q=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir9+wx9/74j9QXaL6u39ZgsuX+g1Yjy/ebGZYmRA3
 +ncrm1lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJ+8nIcP7G7rs1s7hbtV74
 CcQxs+9Ys0xKIkL1VWXA4f5ToVKBhkAVby6KLJ7Q7H5YuS7EIvDRLZ1tte9+zVlwTdZr9uktSQd
 ZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/Makefile             |  2 +-
 .../selftests/pidfd/pidfd_file_handle_test.c       | 54 ++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

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
diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
index 439b9c6c0457..f7e29416152c 100644
--- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
@@ -500,4 +500,58 @@ TEST_F(file_handle, valid_name_to_handle_at_flags)
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
+	pidfd = open_by_handle_at(-EBADF, fh, 0);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(-EBADF, fh, O_CLOEXEC);
+	ASSERT_GE(pidfd, 0);
+
+	ASSERT_EQ(fstat(pidfd, &st2), 0);
+	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
+
+	ASSERT_EQ(close(pidfd), 0);
+
+	pidfd = open_by_handle_at(-EBADF, fh, O_NONBLOCK);
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
+	free(fh);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.2


