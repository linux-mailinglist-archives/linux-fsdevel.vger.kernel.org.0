Return-Path: <linux-fsdevel+bounces-43229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3ECA4FB46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E0168A7E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF652066F0;
	Wed,  5 Mar 2025 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWMJhGrn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F789205AA3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169326; cv=none; b=hhcngd17u+juT/P+mAuTLjVx4MRQi5D4G7ARvDmygeNKDzZ0XvJlXwhGEOblDU3MaKtp02ozcl2FqgHxNbjnU0O+u1yMDzMTxqtzi8FcFVq+9IP+XKcV3ZZ65F9hUTFgAU9JYY2vaLr1SUSGd6vEse8L6+f7WW77jhbr9S7Edio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169326; c=relaxed/simple;
	bh=rD54OjvB+N4UDMewV/wtgZlMH5v5u62O60YfQKkfHs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n7nM74MEUW2fq1pNV4ZKaP5hvImsYR4VAZt50GRhwKN+6w8eqNZT9hdtYZhGbr5M0JZE6MHAAE7Q16lJnpeWl22tw+2k3UfT/DD2bZYpsxG6ZOxhmtJ91pLuhuAJWJN8FHfyLwO8t7Lvk71uwt6QvKeV30RE7MoSFFqsi7lGX+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWMJhGrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17588C4CEE8;
	Wed,  5 Mar 2025 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169325;
	bh=rD54OjvB+N4UDMewV/wtgZlMH5v5u62O60YfQKkfHs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NWMJhGrnvCHu139oTjOg30YO3D0EZ6Kxu8PQ5iiyuh/4O5tEIj37A+MNtOOJUbJKe
	 aUw6zVkXRt0Xq413TxaSiuTKaPpzp3WIJgQgmlH4jBGQ/2JF8LSu4jnwWVUpecQfni
	 2GIID6MjxPTXG//WMw7vzvILJy0GvMoZAQ9UinFiMKRFcohH2HElb0XCLhHN/ubc5t
	 H8Ua/DOSgNhuM3qGbuHooVd8M+Bz5J3XqTxqZYvVZ/iPbCoPIX2xpdWDX4Ino0GRO6
	 I3VZT3/J5RSPT/562BhOsb8EdaR6TcEqpAUqqlUCHUa1PQolIQ7+YzB2ZnOBhIX0DJ
	 khn4aEEB5raMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:19 +0100
Subject: [PATCH v3 09/16] selftests/pidfd: expand common pidfd header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-9-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5860; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rD54OjvB+N4UDMewV/wtgZlMH5v5u62O60YfQKkfHs0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJohbMT0ZuFW5e61s1RP/uYy9OMW/K69eZfKFOVl7
 ktWyx361VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRnisM/4MM2IuefLdN69KJ
 l/ASytikxrXF5/7i3PMaec83tq3nTmBkePZrb5SjN091tJ1KjuxqptmaDHFLPk6fmG+mOPHH509
 XeAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Move more infrastructure to the pidfd header.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-9-44fdacfaa7b7@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/testing/selftests/pidfd/pidfd.h            | 78 ++++++++++++++++++++++++
 tools/testing/selftests/pidfd/pidfd_open_test.c  | 26 --------
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 45 --------------
 3 files changed, 78 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 027ebaf14844..bad518766aa5 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -12,6 +12,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <syscall.h>
+#include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/wait.h>
 
@@ -66,6 +67,83 @@
 #define PIDFD_SELF_PROCESS	PIDFD_SELF_THREAD_GROUP
 #endif
 
+#ifndef PIDFS_IOCTL_MAGIC
+#define PIDFS_IOCTL_MAGIC 0xFF
+#endif
+
+#ifndef PIDFD_GET_CGROUP_NAMESPACE
+#define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
+#endif
+
+#ifndef PIDFD_GET_IPC_NAMESPACE
+#define PIDFD_GET_IPC_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 2)
+#endif
+
+#ifndef PIDFD_GET_MNT_NAMESPACE
+#define PIDFD_GET_MNT_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 3)
+#endif
+
+#ifndef PIDFD_GET_NET_NAMESPACE
+#define PIDFD_GET_NET_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 4)
+#endif
+
+#ifndef PIDFD_GET_PID_NAMESPACE
+#define PIDFD_GET_PID_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 5)
+#endif
+
+#ifndef PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE
+#define PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE  _IO(PIDFS_IOCTL_MAGIC, 6)
+#endif
+
+#ifndef PIDFD_GET_TIME_NAMESPACE
+#define PIDFD_GET_TIME_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 7)
+#endif
+
+#ifndef PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE
+#define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
+#endif
+
+#ifndef PIDFD_GET_USER_NAMESPACE
+#define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
+#endif
+
+#ifndef PIDFD_GET_UTS_NAMESPACE
+#define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
+#endif
+
+#ifndef PIDFD_GET_INFO
+#define PIDFD_GET_INFO			      _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
+#endif
+
+#ifndef PIDFD_INFO_PID
+#define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
+#endif
+
+#ifndef PIDFD_INFO_CREDS
+#define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
+#endif
+
+#ifndef PIDFD_INFO_CGROUPID
+#define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
+#endif
+
+struct pidfd_info {
+	__u64 mask;
+	__u64 cgroupid;
+	__u32 pid;
+	__u32 tgid;
+	__u32 ppid;
+	__u32 ruid;
+	__u32 rgid;
+	__u32 euid;
+	__u32 egid;
+	__u32 suid;
+	__u32 sgid;
+	__u32 fsuid;
+	__u32 fsgid;
+	__u32 spare0[1];
+};
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 9a40ccb1ff6d..cd3de40e4977 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -22,32 +22,6 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-#ifndef PIDFS_IOCTL_MAGIC
-#define PIDFS_IOCTL_MAGIC 0xFF
-#endif
-
-#ifndef PIDFD_GET_INFO
-#define PIDFD_GET_INFO _IOWR(PIDFS_IOCTL_MAGIC, 11, struct pidfd_info)
-#define PIDFD_INFO_CGROUPID		(1UL << 0)
-
-struct pidfd_info {
-	__u64 mask;
-	__u64 cgroupid;
-	__u32 pid;
-	__u32 tgid;
-	__u32 ppid;
-	__u32 ruid;
-	__u32 rgid;
-	__u32 euid;
-	__u32 egid;
-	__u32 suid;
-	__u32 sgid;
-	__u32 fsuid;
-	__u32 fsgid;
-	__u32 spare0[1];
-};
-#endif
-
 static int safe_int(const char *numstr, int *converted)
 {
 	char *err = NULL;
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index d9e715de68b3..e6a079b3d5e2 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,55 +16,10 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
-#include <sys/ioctl.h>
 
 #include "pidfd.h"
 #include "../kselftest_harness.h"
 
-#ifndef PIDFS_IOCTL_MAGIC
-#define PIDFS_IOCTL_MAGIC 0xFF
-#endif
-
-#ifndef PIDFD_GET_CGROUP_NAMESPACE
-#define PIDFD_GET_CGROUP_NAMESPACE            _IO(PIDFS_IOCTL_MAGIC, 1)
-#endif
-
-#ifndef PIDFD_GET_IPC_NAMESPACE
-#define PIDFD_GET_IPC_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 2)
-#endif
-
-#ifndef PIDFD_GET_MNT_NAMESPACE
-#define PIDFD_GET_MNT_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 3)
-#endif
-
-#ifndef PIDFD_GET_NET_NAMESPACE
-#define PIDFD_GET_NET_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 4)
-#endif
-
-#ifndef PIDFD_GET_PID_NAMESPACE
-#define PIDFD_GET_PID_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 5)
-#endif
-
-#ifndef PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE
-#define PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE  _IO(PIDFS_IOCTL_MAGIC, 6)
-#endif
-
-#ifndef PIDFD_GET_TIME_NAMESPACE
-#define PIDFD_GET_TIME_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 7)
-#endif
-
-#ifndef PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE
-#define PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE _IO(PIDFS_IOCTL_MAGIC, 8)
-#endif
-
-#ifndef PIDFD_GET_USER_NAMESPACE
-#define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
-#endif
-
-#ifndef PIDFD_GET_UTS_NAMESPACE
-#define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
-#endif
-
 enum {
 	PIDFD_NS_USER,
 	PIDFD_NS_MNT,

-- 
2.47.2


