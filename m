Return-Path: <linux-fsdevel+bounces-43065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F314A4D923
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8F63A95C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761191FC7E1;
	Tue,  4 Mar 2025 09:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWtAqNL4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77531FCD00
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081295; cv=none; b=IS1k2NbwNRJ405/ghlwBCsPWE8RJO+lRNgNa8leO9N6zFMaWgHM4B3la/1FNyvpN1nTEyDMNuGF5b8/T40hwtcR+48FFs4ynA4bTU1EHrsIKdfhEPOfZK8lGgi9XpvTOKB8R0NNGdeIba8iNX+Q18TxtM81DvU+ampt5lsR0KZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081295; c=relaxed/simple;
	bh=kI9PHcpZLd1x1Zp1Ulfs9kJOBzg2BGQ5YC6LK+/p+6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7jXZ8UQ7n/6TGSDLicd6gsJm7FrX51qg4rCFhe7TrbDBXxGtUbhcccpbNMp3nlT6KeTHh/wpneSH7iXy9lNgQdQGzrD/hWmYtJwjgtb1Exd6If9T+4k6WJsGafnM5XDaXGceRfwzi/era/a6s2MjV9SjKxxOupconW0uVxd9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWtAqNL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FDAC4CEED;
	Tue,  4 Mar 2025 09:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081295;
	bh=kI9PHcpZLd1x1Zp1Ulfs9kJOBzg2BGQ5YC6LK+/p+6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YWtAqNL4cdj0CpV/u9kvnd+AH/KIFCtumuxv/0d3sjK+dUyOwvkeO/msAx51pfF3/
	 pkiWN1LXeZrEEYjEChYkegxH88q5eKlakAvQByVMg3e4rli7Mfh7XbsLE3K5pLZP00
	 jvG2t2jdWZEoJu2Qk2kFbbf4lC3TQWVgEL2K7n5FsU8rwOAxDuoJdnvzaLLThP+j+u
	 Z9VnGk9Tjko77sh2o5jF39GPfy3vu0gZZQES6HtD1RtrWBNsIav0NbFBdF8mPCm5wh
	 wEMlBuJoMEzmFiyDYZ59lCGDuKaK7aeSU4l+wOdR3E6Lz7g6gos8Pz80llu7/7R2Ge
	 G7kgAFqseZyGQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:09 +0100
Subject: [PATCH v2 09/15] selftests/pidfd: move more defines to common
 header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-9-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=5710; i=brauner@kernel.org;
 h=from:subject:message-id; bh=kI9PHcpZLd1x1Zp1Ulfs9kJOBzg2BGQ5YC6LK+/p+6g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Xbcv3363WCR0Vu+SaHWSv6L/j++bgO87lpc7Mak
 sOdvJxPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEVo/hf8n6sisPvp7zOKwh
 z6OYZ9S/Yc+F/er8r/M53ZeLnjjeKMnwzz7Kz/ZdRNK8c/8+nL/jxdkcv2NGsF7N3tLe0I074p9
 d4gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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


