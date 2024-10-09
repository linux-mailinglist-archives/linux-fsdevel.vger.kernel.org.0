Return-Path: <linux-fsdevel+bounces-31485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902719976CC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FE285970
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820C51E907C;
	Wed,  9 Oct 2024 20:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="qwi4ma0s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5B11E2855;
	Wed,  9 Oct 2024 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506561; cv=none; b=HW6h1Gj0YInAwlil6c3lSpQqFZT5HJsT/uOdZCo2uVxUR8Rr04ZxB9v+UeTiNTEOBN2J0RGkXx6To50HdUcxXtn2eeDSVrjTJlVbeIPsARsAd9dyITW/26YCac68lVL86wRAsJdc2TNWRV2L5bIJO9Q6Omf40xpn7Ijms7XAGBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506561; c=relaxed/simple;
	bh=bqTMmhf8qrPFVj65H2ybVQSoLCqAb/vZq4GN2tCr55c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=egQkBtA+W7eS6BT/hfkZCPENk/GRA5yREJfXbw3N7f0MLARGsvOFOkKVyTVYmJf6il5RJPJKk61kzgFtRRl/5vS6ff1kv+c6XYZBj5q+BS52iFgx/k3F5xcahBdCeZFfMl4X5tDq08YK81E9xBUHkDSTpRMyEgPLqZfh2BjwysI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=qwi4ma0s; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4XP4Zh1bXQz9sxv;
	Wed,  9 Oct 2024 22:42:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fL5eft/0SEqgXy8IyhgJaBCjETWOZ9/n50x90uqdKGE=;
	b=qwi4ma0sVjfL983232CndOb2Fdyuw72EPEifNfjns9iNqyZrmOyN/W5dOMy0X2DSquavK4
	2okrRqQqahZXZGlbi59PvPjYL3DVjpaJZ6X0IMPqwXiTPd++xyCkxpYRHIIZfZ/2v+QI9S
	BiKkJzKNenauPj0NqsOQ3KcfwZlDrG0eCxMVM6/RWoxiGguZJi/OMgBemjq6IRzQhECHzD
	E+TqPZumX2so1n6Sl1H3VzXrPJ1sY++0YThpQAf7Q8ru5/fa2pLHsT3IY2t+pvIRwT8vRI
	B0GGefbonDVP8CrU2vxIA4DG8fwPLPJMaLGCiV/JQd3a7iwK2AP6J2P73gL5GA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:43 +1100
Subject: [PATCH RFC v3 10/10] selftests: mount_setattr: add CHECK_FIELDS
 selftest
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-10-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7253; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=bqTMmhf8qrPFVj65H2ybVQSoLCqAb/vZq4GN2tCr55c=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQq6rlcTWGQ8fVFgcf/xvdEbNAv4Hc+dYfmx9foVb
 hG9pEsnO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEXmkzMlycnLia72ZG7/uz
 CbKBke5rnU8ef/VnxeHVB6S+LVvJqGbE8L/qxP2C/lfPovb3rH+ndOjKkdsRO9zceDb+ujqFffl
 nhpn8AA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4XP4Zh1bXQz9sxv

While we're at it -- to make testing for error codes with ASSERT_*
easier, make the sys_* wrappers return -errno in case of an error.

For some reason, the <sys/sysinfo.h> include doesn't correct import
<asm/posix_types.h>, leading to compilation errors -- so just import
<asm/posix_types.h> manually.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/include/uapi/asm-generic/posix_types.h       | 101 +++++++++++++++++++++
 tools/testing/selftests/mount_setattr/Makefile     |   2 +-
 .../selftests/mount_setattr/mount_setattr_test.c   |  53 ++++++++++-
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/tools/include/uapi/asm-generic/posix_types.h b/tools/include/uapi/asm-generic/posix_types.h
new file mode 100644
index 000000000000..b5f7594eee7a
--- /dev/null
+++ b/tools/include/uapi/asm-generic/posix_types.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __ASM_GENERIC_POSIX_TYPES_H
+#define __ASM_GENERIC_POSIX_TYPES_H
+
+#include <asm/bitsperlong.h>
+/*
+ * This file is generally used by user-level software, so you need to
+ * be a little careful about namespace pollution etc.
+ *
+ * First the types that are often defined in different ways across
+ * architectures, so that you can override them.
+ */
+
+#ifndef __kernel_long_t
+typedef long		__kernel_long_t;
+typedef unsigned long	__kernel_ulong_t;
+#endif
+
+#ifndef __kernel_ino_t
+typedef __kernel_ulong_t __kernel_ino_t;
+#endif
+
+#ifndef __kernel_mode_t
+typedef unsigned int	__kernel_mode_t;
+#endif
+
+#ifndef __kernel_pid_t
+typedef int		__kernel_pid_t;
+#endif
+
+#ifndef __kernel_ipc_pid_t
+typedef int		__kernel_ipc_pid_t;
+#endif
+
+#ifndef __kernel_uid_t
+typedef unsigned int	__kernel_uid_t;
+typedef unsigned int	__kernel_gid_t;
+#endif
+
+#ifndef __kernel_suseconds_t
+typedef __kernel_long_t		__kernel_suseconds_t;
+#endif
+
+#ifndef __kernel_daddr_t
+typedef int		__kernel_daddr_t;
+#endif
+
+#ifndef __kernel_uid32_t
+typedef unsigned int	__kernel_uid32_t;
+typedef unsigned int	__kernel_gid32_t;
+#endif
+
+#ifndef __kernel_old_uid_t
+typedef __kernel_uid_t	__kernel_old_uid_t;
+typedef __kernel_gid_t	__kernel_old_gid_t;
+#endif
+
+#ifndef __kernel_old_dev_t
+typedef unsigned int	__kernel_old_dev_t;
+#endif
+
+/*
+ * Most 32 bit architectures use "unsigned int" size_t,
+ * and all 64 bit architectures use "unsigned long" size_t.
+ */
+#ifndef __kernel_size_t
+#if __BITS_PER_LONG != 64
+typedef unsigned int	__kernel_size_t;
+typedef int		__kernel_ssize_t;
+typedef int		__kernel_ptrdiff_t;
+#else
+typedef __kernel_ulong_t __kernel_size_t;
+typedef __kernel_long_t	__kernel_ssize_t;
+typedef __kernel_long_t	__kernel_ptrdiff_t;
+#endif
+#endif
+
+#ifndef __kernel_fsid_t
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#endif
+
+/*
+ * anything below here should be completely generic
+ */
+typedef __kernel_long_t	__kernel_off_t;
+typedef long long	__kernel_loff_t;
+typedef __kernel_long_t	__kernel_old_time_t;
+#ifndef __KERNEL__
+typedef __kernel_long_t	__kernel_time_t;
+#endif
+typedef long long __kernel_time64_t;
+typedef __kernel_long_t	__kernel_clock_t;
+typedef int		__kernel_timer_t;
+typedef int		__kernel_clockid_t;
+typedef char *		__kernel_caddr_t;
+typedef unsigned short	__kernel_uid16_t;
+typedef unsigned short	__kernel_gid16_t;
+
+#endif /* __ASM_GENERIC_POSIX_TYPES_H */
diff --git a/tools/testing/selftests/mount_setattr/Makefile b/tools/testing/selftests/mount_setattr/Makefile
index 0c0d7b1234c1..3f260506fe60 100644
--- a/tools/testing/selftests/mount_setattr/Makefile
+++ b/tools/testing/selftests/mount_setattr/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for mount selftests.
-CFLAGS = -g $(KHDR_INCLUDES) -Wall -O2 -pthread
+CFLAGS = -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -Wall -O2 -pthread
 
 TEST_GEN_PROGS := mount_setattr_test
 
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..36b8286e5f43 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -11,6 +11,7 @@
 #include <sys/wait.h>
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
+#include <asm/posix_types.h> /* get __kernel_* typedefs */
 #include <sys/sysinfo.h>
 #include <stdlib.h>
 #include <unistd.h>
@@ -137,7 +138,8 @@
 static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flags,
 				    struct mount_attr *attr, size_t size)
 {
-	return syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+	int ret = syscall(__NR_mount_setattr, dfd, path, flags, attr, size);
+	return ret >= 0 ? ret : -errno;
 }
 
 #ifndef OPEN_TREE_CLONE
@@ -152,9 +154,24 @@ static inline int sys_mount_setattr(int dfd, const char *path, unsigned int flag
 #define AT_RECURSIVE 0x8000 /* Apply to the entire subtree */
 #endif
 
+#define FSMOUNT_VALID_FLAGS                                                    \
+	(MOUNT_ATTR_RDONLY | MOUNT_ATTR_NOSUID | MOUNT_ATTR_NODEV |            \
+	 MOUNT_ATTR_NOEXEC | MOUNT_ATTR__ATIME | MOUNT_ATTR_NODIRATIME |       \
+	 MOUNT_ATTR_NOSYMFOLLOW)
+
+#define MOUNT_SETATTR_VALID_FLAGS (FSMOUNT_VALID_FLAGS | MOUNT_ATTR_IDMAP)
+
+#define MOUNT_SETATTR_PROPAGATION_FLAGS \
+	(MS_UNBINDABLE | MS_PRIVATE | MS_SLAVE | MS_SHARED)
+
+#ifndef CHECK_FIELDS
+#define CHECK_FIELDS (1ULL << 63)
+#endif
+
 static inline int sys_open_tree(int dfd, const char *filename, unsigned int flags)
 {
-	return syscall(__NR_open_tree, dfd, filename, flags);
+	int ret = syscall(__NR_open_tree, dfd, filename, flags);
+	return ret >= 0 ? ret : -errno;
 }
 
 static ssize_t write_nointr(int fd, const void *buf, size_t count)
@@ -1497,4 +1514,36 @@ TEST_F(mount_setattr, mount_attr_nosymfollow)
 	ASSERT_EQ(close(fd), 0);
 }
 
+TEST_F(mount_setattr, check_fields)
+{
+	struct mount_attr_ext {
+		struct mount_attr inner;
+		uint64_t extra1;
+		uint64_t extra2;
+		uint64_t extra3;
+	} attr;
+
+	/* Set the structure to dummy values. */
+	memset(&attr, 0xAB, sizeof(attr));
+
+	if (!mount_setattr_supported())
+		SKIP(return, "mount_setattr syscall not supported");
+
+	/* Make sure that invalid sizes are detected even with CHECK_FIELDS. */
+	EXPECT_EQ(sys_mount_setattr(-1, "", 0, (struct mount_attr *) &attr, CHECK_FIELDS), -EINVAL);
+	EXPECT_EQ(sys_mount_setattr(-1, "", 0, (struct mount_attr *) &attr, CHECK_FIELDS | 0xF000), -E2BIG);
+
+	/* Actually get the CHECK_FIELDS results. */
+	ASSERT_EQ(sys_mount_setattr(-1, "", 0, (struct mount_attr *) &attr, CHECK_FIELDS | sizeof(attr)), -EEXTSYS_NOOP);
+
+	EXPECT_EQ(attr.inner.attr_set, MOUNT_SETATTR_VALID_FLAGS);
+	EXPECT_EQ(attr.inner.attr_clr, MOUNT_SETATTR_VALID_FLAGS);
+	EXPECT_EQ(attr.inner.propagation, MOUNT_SETATTR_PROPAGATION_FLAGS);
+	EXPECT_EQ(attr.inner.userns_fd, 0xFFFFFFFFFFFFFFFF);
+	/* Trailing fields outside ksize must be zeroed. */
+	EXPECT_EQ(attr.extra1, 0);
+	EXPECT_EQ(attr.extra2, 0);
+	EXPECT_EQ(attr.extra3, 0);
+}
+
 TEST_HARNESS_MAIN

-- 
2.46.1


