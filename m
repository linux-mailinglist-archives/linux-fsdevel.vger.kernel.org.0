Return-Path: <linux-fsdevel+bounces-52701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472FFAE5F59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E38E4064FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14125A659;
	Tue, 24 Jun 2025 08:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bA44xuq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75420258CE5;
	Tue, 24 Jun 2025 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753784; cv=none; b=jnURClK3h500dT71lZGz0aqwfbnYOh/LWVZ3Q3CtcsgbgPnIL1/rlpNyJZMVdyM3kvxgbmi/rkGKhCSG7e2RgHTAr4EmGy33W/CztS6T4CYHTZlZVE3QKWbY4BO0/nTNrwwjkq7S5419Xn8hMe4AxIViEaDiSSj9sC4nGfVzL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753784; c=relaxed/simple;
	bh=gbtXyj1cE8RlKMVthcprmKA/ddIv2JrosL6kvlVfAb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUgQ5RrVciD3MBSFVI9wMKEtyYyuSUJXc8u3uTQK41BdXjZ4iM4h8By3PBqCTjqOpR1J7Q7KTBuoE0Cf+Z7ICLm1ip7srwCdUvZtPUudi0HKU2f699Jz+hUlyhLjOmT0Rcr8aV8u1gZRC2z1sVvG0p7QWObmYvm0sLlsqiOTAMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bA44xuq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6195DC4CEE3;
	Tue, 24 Jun 2025 08:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753784;
	bh=gbtXyj1cE8RlKMVthcprmKA/ddIv2JrosL6kvlVfAb0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bA44xuq8qqYKjnAw7LUodAFl+JfsbT7Jnvkb3MTQGB1jWKGms1QXM034lXMDS/qox
	 kkY0uM5OzqxJcyDPqpvzJBJSkkQWCTSzl6RKGhk8eMCsvNV9NRXemYHqqf4MRxx+UI
	 sevdHuoMhzX+uEOrjFj453DJK1UQoKvyd8HpMwaaKIogJthV+UsZ4zSRaU8r82oWKd
	 WnJNzIupQOGFuBpsffoZ4RdmFeDUZDdFx5eIvcd+SnreNGK4eY9gSwDEUisSoyp0ux
	 WEM42CzZFesmAJe5cWPwUGO/R+hBqNYUxDnb0gik3hFdm+4oqMFYQKsYuMiIFCYB4t
	 NxF5XHoa4FgVQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:09 +0200
Subject: [PATCH v2 06/11] uapi/fcntl: mark range as reserved
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-6-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3535; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gbtXyj1cE8RlKMVthcprmKA/ddIv2JrosL6kvlVfAb0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb4IlDdepOYjfLNOzyHS9nplpnrJktW1L104tE5oS
 4n1Gh7pKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIjKDkaGX2xzmap1bpzYdDp2
 jaR5ed/xmkN54j0fJPXqK8pKZm65x8iw+uvmShapbccNLjlmMUx9+//m+7mlTp+qbxx7vIYz2jK
 cEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Mark the range from -10000 to -40000 as a range reserved for special
in-kernel values. Move the PIDFD_SELF_*/PIDFD_THREAD_* sentinels over so
all the special values are in one place.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/uapi/linux/fcntl.h            | 16 ++++++++++++++++
 include/uapi/linux/pidfd.h            | 15 ---------------
 tools/testing/selftests/pidfd/pidfd.h |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index a15ac2fa4b20..ba4a698d2f33 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -90,10 +90,26 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+/* Reserved kernel ranges [-100], [-10000, -40000]. */
 #define AT_FDCWD		-100    /* Special value for dirfd used to
 					   indicate openat should use the
 					   current working directory. */
 
+/*
+ * The concept of process and threads in userland and the kernel is a confusing
+ * one - within the kernel every thread is a 'task' with its own individual PID,
+ * however from userland's point of view threads are grouped by a single PID,
+ * which is that of the 'thread group leader', typically the first thread
+ * spawned.
+ *
+ * To cut the Gideon knot, for internal kernel usage, we refer to
+ * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
+ * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
+ * group leader...
+ */
+#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
+
 
 /* Generic flags for the *at(2) family of syscalls. */
 
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index c27a4e238e4b..957db425d459 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -42,21 +42,6 @@
 #define PIDFD_COREDUMP_USER	(1U << 2) /* coredump was done as the user. */
 #define PIDFD_COREDUMP_ROOT	(1U << 3) /* coredump was done as root. */
 
-/*
- * The concept of process and threads in userland and the kernel is a confusing
- * one - within the kernel every thread is a 'task' with its own individual PID,
- * however from userland's point of view threads are grouped by a single PID,
- * which is that of the 'thread group leader', typically the first thread
- * spawned.
- *
- * To cut the Gideon knot, for internal kernel usage, we refer to
- * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
- * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
- * group leader...
- */
-#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
-#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
-
 /*
  * ...and for userland we make life simpler - PIDFD_SELF refers to the current
  * thread, PIDFD_SELF_PROCESS refers to the process thread group leader.
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index efd74063126e..5dfeb1bdf399 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -56,7 +56,7 @@
 #endif
 
 #ifndef PIDFD_SELF_THREAD_GROUP
-#define PIDFD_SELF_THREAD_GROUP		-20000 /* Current thread group leader. */
+#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
 #endif
 
 #ifndef PIDFD_SELF

-- 
2.47.2


