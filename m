Return-Path: <linux-fsdevel+bounces-31785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D199AE42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2683D1F255B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC21D173F;
	Fri, 11 Oct 2024 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxFK2R8e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF91D173A;
	Fri, 11 Oct 2024 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728683178; cv=none; b=b+2/VOJkbtnRBJbTGGZmWJbYG3Ogx/1nziGwrFCc3K9wEDKDODzx+vGjH6eBALYbFQ271KtJZ3Fssmsx/CKjN77t3D9tSwhiEQNpvp11IDQRdetiUP+7iI9vcX03Kg/5nSMbebxQqf/VE/JzjVhdbRYp8aN9Hl0XCIEC7CdzQJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728683178; c=relaxed/simple;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0tBfBamW5iDeNGh5W5BlmvyDqT/vdxu4N3alOo18KlEzWnx8Ciy5vpCrOaUPjZdpKZZs1hNvhqdn7i6glSV5Wg390scGk6RrjwTL/B84VoaTr5WIDATlbkO3uiqYN8wTqmWTQ62pniUVYEY3GGIRFLzg9qJ0GuVkAJY+Euz/Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxFK2R8e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F294AC4CECF;
	Fri, 11 Oct 2024 21:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728683178;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxFK2R8eKAYp5oZ1EUesIU8MHXSrfaZsSxUZrCjp2+Xxqu6sF39a6e38D3ykIEGFZ
	 Gg51aYECxDrOs4CSA+kOc0AShBzba/+xfyODhiClf9i9cizBGh5QvPG9C/oeni/L7l
	 GNW+wl52HPWUQwK2vAwiNu0Lq9asxJYbJrBBQjqViGvHq94B82jN40T3tOSPuX0jAJ
	 XHfKFGpi/5VCC+jfDTQk3D+ke9zYFelhj2sBrdqtrJSZ5Um56QMZZ8E97pZZ9X4JrO
	 Wlw+5CugpsIV2N5zbAcJlkXH3TorNaGIpATmnVVw/T5azHaenxWGplYDdDbXVK7yWy
	 cqnXIQeuYtuyA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 23:45:52 +0200
Subject: [PATCH RFC v2 3/4] selftests: use shared header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v2-3-1b43328c5a31@kernel.org>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzzlmst2jTqhkTnPob9yS0Cc9n8J0a8KJj/3rx9AdZy
 Yacy/7VdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkuwwjw40WsWmLgvuT0/44
 lljJMxctOmgc8794c4Lyx4KzEQvkKhkZpnLtM6kPPfLp/qUwE73M5esbuQXuhfKvmfPK9yz/soW
 f2AE=
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


