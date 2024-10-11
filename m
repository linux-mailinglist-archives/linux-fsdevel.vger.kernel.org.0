Return-Path: <linux-fsdevel+bounces-31734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6A399A819
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 17:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE63282F55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F02194AE8;
	Fri, 11 Oct 2024 15:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ly1NKGef"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D165B188CB1;
	Fri, 11 Oct 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661425; cv=none; b=OyYLmxLKTYeIHMExaGe5wR0li9ljvZ65RNjXDftlrLLKuIB1WQ2GJucrNn5GVC0wvDZchGmhL60b4grQ8dYtMyVSmBdwoeskD42kjyLzRDCgbiFDM/DbfxeEQDWTBEP7YHSBNVA/hiaXAlcovR9Q2aBRSY2+Hp7hyZx7M9ufUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661425; c=relaxed/simple;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DCXxAWoNoIDMVrIoY5AKK8BL/WmcS2UStggcJvLHQ+LrMbIE9GbBtQ754FwqpPmrl4bg8ZulqucsarFGlEcYFzMxvLcGJJ8wZkya7tP9NHaZcEDvopnDGRIzDY3ME4MP1Ed57EWQPQKI9JYqMSSvIR4741ws/B+QpTG00vc6v7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ly1NKGef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C7C4CECE;
	Fri, 11 Oct 2024 15:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728661425;
	bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ly1NKGef4G0L8o03BqQ7sOla1D8XAYJ9k1H2z6dYUCEft3u5bt5GAoeyul8ue/0tE
	 SoO3KDaNXkxXQ0HBHBZDse+J6BEnqe7zuOl1SNywtEQqaYWxi/EHBInk1NHbdkMxhQ
	 I9cjZHpaJJvSHc0LIs67TN6X1+jS3a0rTKn3D0eBoVVJJcq/JO8PzQJAyVabelnUof
	 g4LTleKbbMU461uRfW0W9lVZjOph5yoLMCjr9JbMQabNfed9YXJMHMWbeE1thCoEFF
	 9xsABc2Kf6y7TAPMejvE/jsSu0j5f3wuksyUYLJFZl+/tAkWEM92/OzOdIKPgzYrOE
	 UwESOuSw32Ydw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 11 Oct 2024 17:43:36 +0200
Subject: [PATCH RFC 2/3] selftests: use shared header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-work-overlayfs-v1-2-e34243841279@kernel.org>
References: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
In-Reply-To: <20241011-work-overlayfs-v1-0-e34243841279@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-unionfs@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KRWLagaS4YguCRS2vcI21OA10tbn8Q0Kj2MV+AwTbjI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRzuq/pL/7J68/2d9Hctx+1Iw9xlG2JWFNf49G/o2WSd
 W25j35iRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQubGD4H/G0207soYv95Nl8
 TN33FZ7Zf+MMFNQTdHok5vNj2evKKYwMB+7dmqS4aJNDVtrz5e3Nczne9E+6ulCs68VU9/maQSu
 62QE=
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


