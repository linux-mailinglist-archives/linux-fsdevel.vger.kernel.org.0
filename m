Return-Path: <linux-fsdevel+bounces-55936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB5B103A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB78917F7E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF89274B29;
	Thu, 24 Jul 2025 08:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="pZBaZxko"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836C2276038;
	Thu, 24 Jul 2025 08:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345968; cv=none; b=QI9+ho+VCHcCSCq/2uAcIW5WVT5/LFNh44Xmn8KiMMiWI5Z/6kIFYBXsdU74vddrX6O/Lic2U1qREsv+DCKoA/cSOrvd2SJhb2jN3c38ryNd58PRaJbGy5dQ4pDHykp9vGgByAbZYOrXyQ6YYPLKB60z0N2zJFJr26/eGHafKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345968; c=relaxed/simple;
	bh=qnzDffrtOhieCifIQALbR9Yq8NuI1rDh8ygAqZ4PCnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKZqMFzZnoZiKRrubfj4BdF8dZ29oPWiQmPnbuO3rtFWOGYxhUC9YWLLMN4XfXfw5vNnUurGBEWZudywAUfawiB2fn2IRIUlAU8uuh2FmBgaoj/HmDAs6IuOBjRHclqMP6Tft/YucpVOQPlq824op2AMIFhYe/gC+vl/gpqqMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=pZBaZxko; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bnklZ6y3Jz9svR;
	Thu, 24 Jul 2025 10:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753345963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTi/FGmUyVjfXcqveVu9fsI9YOLQ9+kwvijsaczxosQ=;
	b=pZBaZxkorZi22C+ucatZAoKGZxcF2LWH23PGp4pyYVFRlEenmH897gnq0eTz9IFvk/cCYE
	2H7ZbqGdabt/s1PJurOqX9y0Lm9RuYRGV2RysHmGczm3CyGfYbIMkr3hQsfTB/Y9rhpJNK
	/hzPznfO2yGPX1JKKWmoTAaJVIGjPHOWHUgZzsjW5MyrOPq7FL/V0+M+myzyFdG1uVTDgC
	Cs2fYafIgQfBq6uQDaw/MdM39mZiicO2NWLqOfTAU3By+iWPj9ZngkXGeFTP0d/0i1abf3
	Y6UrHuz9IVB3om5RKZmSO6cPuFjm2+tEa9mbX2P6NWqVMqlo9M6f0rEhX6FTIA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 24 Jul 2025 18:32:06 +1000
Subject: [PATCH v3 4/4] selftests/proc: add tests for new pidns APIs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-procfs-pidns-api-v3-4-4c685c910923@cyphar.com>
References: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
In-Reply-To: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8964; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=qnzDffrtOhieCifIQALbR9Yq8NuI1rDh8ygAqZ4PCnw=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0vu8y1VD3UBJN+GUQGOl3xDHuwXXbN40TPlUcubBrG
 2vFqd8RHaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiCyYy/DP9GzXd53xb3tHg
 EP44aVeHZVtz9k3MNboqtrkuc/mlb7UMf/he3X/H75K618my5kv6y2WT4zNCfyasrbe7db/pZ+u
 +WDYA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/proc/.gitignore   |   1 +
 tools/testing/selftests/proc/Makefile     |   1 +
 tools/testing/selftests/proc/proc-pidns.c | 252 ++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 973968f45bba..2dced03e9e0e 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -17,6 +17,7 @@
 /proc-tid0
 /proc-uptime-001
 /proc-uptime-002
+/proc-pidns
 /read
 /self
 /setns-dcache
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index b12921b9794b..c6f7046b9860 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -27,5 +27,6 @@ TEST_GEN_PROGS += setns-sysvipc
 TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
+TEST_GEN_PROGS += proc-pidns
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
new file mode 100644
index 000000000000..5994375e2377
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pidns.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2025 SUSE LLC.
+ */
+
+#include <assert.h>
+#include <errno.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <sys/mount.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+
+#include "../kselftest_harness.h"
+
+#define ASSERT_ERRNO(expected, _t, seen)				\
+	__EXPECT(expected, #expected,					\
+		({__typeof__(seen) _tmp_seen = (seen);			\
+		  _tmp_seen >= 0 ? _tmp_seen : -errno; }), #seen, _t, 1)
+
+#define ASSERT_ERRNO_EQ(expected, seen) \
+	ASSERT_ERRNO(expected, ==, seen)
+
+#define ASSERT_SUCCESS(seen) \
+	ASSERT_ERRNO(0, <=, seen)
+
+static int touch(char *path)
+{
+	int fd = open(path, O_WRONLY|O_CREAT|O_CLOEXEC, 0644);
+	if (fd < 0)
+		return -1;
+	return close(fd);
+}
+
+FIXTURE(ns)
+{
+	int host_mntns, host_pidns;
+	int dummy_pidns;
+};
+
+FIXTURE_SETUP(ns)
+{
+	/* Stash the old mntns. */
+	self->host_mntns = open("/proc/self/ns/mnt", O_RDONLY|O_CLOEXEC);
+	ASSERT_SUCCESS(self->host_mntns);
+
+	/* Create a new mount namespace and make it private. */
+	ASSERT_SUCCESS(unshare(CLONE_NEWNS));
+	ASSERT_SUCCESS(mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL));
+
+	/*
+	 * Create a proper tmpfs that we can use and will disappear once we
+	 * leave this mntns.
+	 */
+	ASSERT_SUCCESS(mount("tmpfs", "/tmp", "tmpfs", 0, NULL));
+
+	/*
+	 * Create a pidns we can use for later tests. We need to fork off a
+	 * child so that we get a usable nsfd that we can bind-mount and open.
+	 */
+	ASSERT_SUCCESS(touch("/tmp/dummy-pidns"));
+
+	self->host_pidns = open("/proc/self/ns/pid", O_RDONLY|O_CLOEXEC);
+	ASSERT_SUCCESS(self->host_pidns);
+	ASSERT_SUCCESS(unshare(CLONE_NEWPID));
+
+	pid_t pid = fork();
+	ASSERT_SUCCESS(pid);
+	if (!pid) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL);
+		ASSERT_SUCCESS(mount("/proc/self/ns/pid", "/tmp/dummy-pidns", NULL, MS_BIND, 0));
+		exit(0);
+	}
+
+	int wstatus;
+	ASSERT_EQ(waitpid(pid, &wstatus, 0), pid);
+	ASSERT_TRUE(WIFEXITED(wstatus));
+	ASSERT_EQ(WEXITSTATUS(wstatus), 0);
+
+	ASSERT_SUCCESS(setns(self->host_pidns, CLONE_NEWPID));
+
+	self->dummy_pidns = open("/tmp/dummy-pidns", O_RDONLY|O_CLOEXEC);
+	ASSERT_SUCCESS(self->dummy_pidns);
+}
+
+FIXTURE_TEARDOWN(ns)
+{
+	ASSERT_SUCCESS(setns(self->host_mntns, CLONE_NEWNS));
+	ASSERT_SUCCESS(close(self->host_mntns));
+
+	ASSERT_SUCCESS(close(self->host_pidns));
+	ASSERT_SUCCESS(close(self->dummy_pidns));
+}
+
+TEST_F(ns, pidns_mount_string_path)
+{
+	ASSERT_SUCCESS(mkdir("/tmp/proc-host", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc-host", "proc", 0, "pidns=/proc/self/ns/pid"));
+	ASSERT_SUCCESS(access("/tmp/proc-host/self/", X_OK));
+
+	ASSERT_SUCCESS(mkdir("/tmp/proc-dummy", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc-dummy", "proc", 0, "pidns=/tmp/dummy-pidns"));
+	ASSERT_ERRNO_EQ(-ENOENT, access("/tmp/proc-dummy/1/", X_OK));
+	ASSERT_ERRNO_EQ(-ENOENT, access("/tmp/proc-dummy/self/", X_OK));
+}
+
+TEST_F(ns, pidns_fsconfig_string_path)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy-pidns", 0));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_SUCCESS(mountfd);
+
+	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_fsconfig_fd)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_SUCCESS(mountfd);
+
+	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_reconfigure_remount)
+{
+	ASSERT_SUCCESS(mkdir("/tmp/proc", 0755));
+	ASSERT_SUCCESS(mount("proc", "/tmp/proc", "proc", 0, ""));
+
+	ASSERT_SUCCESS(access("/tmp/proc/1/", X_OK));
+	ASSERT_SUCCESS(access("/tmp/proc/self/", X_OK));
+
+	ASSERT_ERRNO_EQ(-EBUSY, mount(NULL, "/tmp/proc", NULL, MS_REMOUNT, "pidns=/tmp/dummy-pidns"));
+
+	ASSERT_SUCCESS(access("/tmp/proc/1/", X_OK));
+	ASSERT_SUCCESS(access("/tmp/proc/self/", X_OK));
+}
+
+TEST_F(ns, pidns_reconfigure_fsconfig_string_path)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_SUCCESS(mountfd);
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_ERRNO_EQ(-EBUSY, fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy-pidns", 0));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+TEST_F(ns, pidns_reconfigure_fsconfig_fd)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_SUCCESS(mountfd);
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_ERRNO_EQ(-EBUSY, fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
+
+	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
+	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(mountfd));
+}
+
+int is_same_inode(int fd1, int fd2)
+{
+	struct stat stat1, stat2;
+
+	assert(fstat(fd1, &stat1) == 0);
+	assert(fstat(fd2, &stat2) == 0);
+
+	return stat1.st_ino == stat2.st_ino && stat1.st_dev == stat2.st_dev;
+}
+
+#define PROCFS_IOCTL_MAGIC 'f'
+#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 1)
+
+TEST_F(ns, get_pidns_ioctl)
+{
+	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	ASSERT_SUCCESS(fsfd);
+
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+
+	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	ASSERT_SUCCESS(mountfd);
+
+	/* fsmount returns an O_PATH, which ioctl(2) doesn't accept. */
+	int new_mountfd = openat(mountfd, ".", O_RDONLY|O_DIRECTORY|O_CLOEXEC);
+	ASSERT_SUCCESS(new_mountfd);
+
+	ASSERT_SUCCESS(close(mountfd));
+	mountfd = -EBADF;
+
+	int procfs_pidns = ioctl(new_mountfd, PROCFS_GET_PID_NAMESPACE);
+	ASSERT_SUCCESS(procfs_pidns);
+
+	ASSERT_NE(self->dummy_pidns, procfs_pidns);
+	ASSERT_FALSE(is_same_inode(self->host_pidns, procfs_pidns));
+	ASSERT_TRUE(is_same_inode(self->dummy_pidns, procfs_pidns));
+
+	ASSERT_SUCCESS(close(fsfd));
+	ASSERT_SUCCESS(close(new_mountfd));
+	ASSERT_SUCCESS(close(procfs_pidns));
+}
+
+TEST_HARNESS_MAIN

-- 
2.50.0


