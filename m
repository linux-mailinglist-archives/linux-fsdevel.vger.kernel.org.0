Return-Path: <linux-fsdevel+bounces-31871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E0699C605
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2531F22DC3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9A156968;
	Mon, 14 Oct 2024 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoFyqtd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A35915CD60;
	Mon, 14 Oct 2024 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728898874; cv=none; b=e63xSiAaGZrVGDm+eGJ7Th6u7g4TBCusjg3aEeku5lWGzw8Wpn80zOG8huJZEQhq588J4mwF6tBO1Al4eK+yxmogKMa+JqEmPF8Wch8uDZPF3fM0+KgMqwV4Uir0u0QInu5U/NhAUQPchMAn3hZxu55RtKYKybOdvBWjpuZ+4KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728898874; c=relaxed/simple;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/+ly+QThgMrMPC3pIYH/cEkZxfujy7At1zg6YoIJJ850PSyFe03MflrGa4cfbLr2BKp1AyzhdzqoNe057mwResla3/zGgO5MXHQXX2uDaNJHS34VGbxIc4pZqCzRJQ2rzYc+M7um0kUS0BGfPOVeaAJxiyh3X5XlhYwADuOdcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoFyqtd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02798C4CEC3;
	Mon, 14 Oct 2024 09:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728898874;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CoFyqtd593pbti6vA7WDDqDR9wIfIgZDlqMI9162QReGdF8+5yhHXsZ3o9oXJAA09
	 H/EOLDy+jDnqfQ8aS4NWYz53+v36dDueOIjilkbQqPVscYCImU8hf0MO6wpMJxXPQx
	 JJqvZSHlYxgxbF/U4gNQh9vIU7CkgeS7u+8B8kuszFpb9KZInJrGd5yKUU9tVHTV4b
	 s5vkZAd37Y0QIomA9yDU2BwZRgeyzkUdkmKql2i/fNkLOfxGLmkxDchflHfLeMI6N2
	 O6XvlYd8dhTAPw8NnrzPi7ltAwtRAvOMMQ2RYshr59bZ4mJAW7f65keIJ7DwNpRCl5
	 E5PDF+ThA5/Ng==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 14 Oct 2024 11:40:59 +0200
Subject: [PATCH v3 4/5] selftests: use shared header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-work-overlayfs-v3-4-32b3fed1286e@kernel.org>
References: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
In-Reply-To: <20241014-work-overlayfs-v3-0-32b3fed1286e@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzPDecsOWoT8sfEcY5KWwnRR99WWLqfNDhwKXz/8sqe
 4RlXPT8OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCEMfwP7vgxcbDrQ6Xf+k3
 CYq99XgYt2bL5xdL3+3MKGQtf12RpsLIsFy3Xmfl6f6Xzza5Fzxs3ZW3bv6WFOP6q7bCiS+bwo0
 VGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

So that we don't have to redefine the same system calls over and over.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/overlayfs/dev_in_maps.c  | 27 +-------------
 .../selftests/filesystems/overlayfs/wrappers.h     | 43 ++++++++++++++++++++++
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
index 2862aae58b79acbe175ab6b36b42798bb99a2225..3b796264223f81fc753d0adaeccc04077023520b 100644
--- a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
+++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
@@ -17,32 +17,7 @@
 
 #include "../../kselftest.h"
 #include "log.h"
-
-static int sys_fsopen(const char *fsname, unsigned int flags)
-{
-	return syscall(__NR_fsopen, fsname, flags);
-}
-
-static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const char *value, int aux)
-{
-	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
-}
-
-static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_flags)
-{
-	return syscall(__NR_fsmount, fd, flags, attr_flags);
-}
-static int sys_mount(const char *src, const char *tgt, const char *fst,
-		unsigned long flags, const void *data)
-{
-	return syscall(__NR_mount, src, tgt, fst, flags, data);
-}
-static int sys_move_mount(int from_dfd, const char *from_pathname,
-			  int to_dfd, const char *to_pathname,
-			  unsigned int flags)
-{
-	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, to_pathname, flags);
-}
+#include "wrappers.h"
 
 static long get_file_dev_and_inode(void *addr, struct statx *stx)
 {
diff --git a/tools/testing/selftests/filesystems/overlayfs/wrappers.h b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
new file mode 100644
index 0000000000000000000000000000000000000000..4f99e10f7f018fd9a7be5263f68d34807da4c53c
--- /dev/null
+++ b/tools/testing/selftests/filesystems/overlayfs/wrappers.h
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+#ifndef __SELFTEST_OVERLAYFS_WRAPPERS_H__
+#define __SELFTEST_OVERLAYFS_WRAPPERS_H__
+
+#define _GNU_SOURCE
+
+#include <linux/types.h>
+#include <linux/mount.h>
+#include <sys/syscall.h>
+
+static inline int sys_fsopen(const char *fsname, unsigned int flags)
+{
+	return syscall(__NR_fsopen, fsname, flags);
+}
+
+static inline int sys_fsconfig(int fd, unsigned int cmd, const char *key,
+			       const char *value, int aux)
+{
+	return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
+}
+
+static inline int sys_fsmount(int fd, unsigned int flags,
+			      unsigned int attr_flags)
+{
+	return syscall(__NR_fsmount, fd, flags, attr_flags);
+}
+
+static inline int sys_mount(const char *src, const char *tgt, const char *fst,
+			    unsigned long flags, const void *data)
+{
+	return syscall(__NR_mount, src, tgt, fst, flags, data);
+}
+
+static inline int sys_move_mount(int from_dfd, const char *from_pathname,
+				 int to_dfd, const char *to_pathname,
+				 unsigned int flags)
+{
+	return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd,
+		       to_pathname, flags);
+}
+
+#endif

-- 
2.45.2


