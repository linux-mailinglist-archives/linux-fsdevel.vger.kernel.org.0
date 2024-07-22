Return-Path: <linux-fsdevel+bounces-24071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C139938FBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC461F2192C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F3116D9DC;
	Mon, 22 Jul 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUU5iP9V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C41816D9D7;
	Mon, 22 Jul 2024 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654061; cv=none; b=GHlJLmrkDcE6XNaFND6/ZJNpMb+q/EPwCpKsiuZy5H633rurnAIfQj5w3lQdRAjOjQHRiopwX1UbhHGowsmzaTIwSR2rJgoqlpc4lwu4C4TNmVnrPLO0c1p4DUUzKciwvaxcpjfmJ019NZta2xNd4Fnu4p/PRqiuJhxRPDdjwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654061; c=relaxed/simple;
	bh=dqpLosddG7EtY/vs8NmCcOcC70XcK0ETm1ZsoNbsQ/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvPxdMq5UWh1i46iafMZgO4DMv1kRe51PwHaNpWqaPu1/3lVkI4PHpXrv5GLpS7w2DDGD1ky610Ml2QqtzybxKKjDPtPQDsAHBeeu6zirgstvZN8Cx89pXrGuJ0xlvffhq+imEERjpQYvrBh5oK4F0QJhe+kqZBLHu+wSPC7udk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUU5iP9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED39FC116B1;
	Mon, 22 Jul 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721654060;
	bh=dqpLosddG7EtY/vs8NmCcOcC70XcK0ETm1ZsoNbsQ/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iUU5iP9Vcu9HlwT9EQw2Ls3X1MjjYr6LKWiFmgTjjeNdAolKos2W1F/i+fcAk0MV0
	 hRzn1MCS+qa6WrRzOKZfA0s2I4VJU0aiSPT6atwd19dMR3qoiBZKuzTsWzomLkDDoZ
	 JnsylhFYRk1/YZ++WZsknchCEtkC9cdzdsGw1BnQQFnt/kgwbZElah1gp/6J9EYgXm
	 VzCifQYCMZw7PXoSYpTw7JXdNBsqcTixFgxVG0uAJqRbkVkMGO9qKMPdKQIjG2uqJW
	 vVfvDpamO+7dDkUbOXYXA06Ocmv0N863TMF4NILEsONboBH6Y37ErUFWwGObssxUWU
	 b6WZXHDZjlNRQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH 2/2] pidfs: add selftests for new namespace ioctls
Date: Mon, 22 Jul 2024 15:13:55 +0200
Message-ID: <20240722-work-pidfs-69dbea91edab@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
References: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com> <20240722-work-pidfs-e6a83030f63e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=14601; i=brauner@kernel.org; h=from:subject:message-id; bh=dqpLosddG7EtY/vs8NmCcOcC70XcK0ETm1ZsoNbsQ/8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNi5bZoLajumfH6+Zbd8sUG91E5V5Yf2jpu2/cVPSrP MmTNeJJRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESacxkZ1iruepQwa7/bKr25 /17qRlYfe/2iYTfb5fgbCwTSrhYuKmL4Zy99b31tHOvC35ybd895nuVbON2muSqB70t/ff9cVqE DzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Add selftests to verify that deriving namespace file descriptors from
pidfd file descriptors works correctly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/pidfd/pidfd_setns_test.c        | 258 +++++++++++++++---
 1 file changed, 227 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 47746b0c6acd..7c2a4349170a 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -16,11 +16,56 @@
 #include <unistd.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <linux/ioctl.h>
 
 #include "pidfd.h"
 #include "../clone3/clone3_selftests.h"
 #include "../kselftest_harness.h"
 
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
 enum {
 	PIDFD_NS_USER,
 	PIDFD_NS_MNT,
@@ -31,22 +76,25 @@ enum {
 	PIDFD_NS_CGROUP,
 	PIDFD_NS_PIDCLD,
 	PIDFD_NS_TIME,
+	PIDFD_NS_TIMECLD,
 	PIDFD_NS_MAX
 };
 
 const struct ns_info {
 	const char *name;
 	int flag;
+	unsigned int pidfd_ioctl;
 } ns_info[] = {
-	[PIDFD_NS_USER]   = { "user",             CLONE_NEWUSER,   },
-	[PIDFD_NS_MNT]    = { "mnt",              CLONE_NEWNS,     },
-	[PIDFD_NS_PID]    = { "pid",              CLONE_NEWPID,    },
-	[PIDFD_NS_UTS]    = { "uts",              CLONE_NEWUTS,    },
-	[PIDFD_NS_IPC]    = { "ipc",              CLONE_NEWIPC,    },
-	[PIDFD_NS_NET]    = { "net",              CLONE_NEWNET,    },
-	[PIDFD_NS_CGROUP] = { "cgroup",           CLONE_NEWCGROUP, },
-	[PIDFD_NS_PIDCLD] = { "pid_for_children", 0,               },
-	[PIDFD_NS_TIME]	  = { "time",             CLONE_NEWTIME,   },
+	[PIDFD_NS_USER]    = { "user",              CLONE_NEWUSER,   PIDFD_GET_USER_NAMESPACE,              },
+	[PIDFD_NS_MNT]     = { "mnt",               CLONE_NEWNS,     PIDFD_GET_MNT_NAMESPACE,               },
+	[PIDFD_NS_PID]     = { "pid",               CLONE_NEWPID,    PIDFD_GET_PID_NAMESPACE,               },
+	[PIDFD_NS_UTS]     = { "uts",               CLONE_NEWUTS,    PIDFD_GET_UTS_NAMESPACE,               },
+	[PIDFD_NS_IPC]     = { "ipc",               CLONE_NEWIPC,    PIDFD_GET_IPC_NAMESPACE,               },
+	[PIDFD_NS_NET]     = { "net",               CLONE_NEWNET,    PIDFD_GET_NET_NAMESPACE,               },
+	[PIDFD_NS_CGROUP]  = { "cgroup",            CLONE_NEWCGROUP, PIDFD_GET_CGROUP_NAMESPACE,            },
+	[PIDFD_NS_TIME]	   = { "time",              CLONE_NEWTIME,   PIDFD_GET_TIME_NAMESPACE,              },
+	[PIDFD_NS_PIDCLD]  = { "pid_for_children",  0,               PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE,  },
+	[PIDFD_NS_TIMECLD] = { "time_for_children", 0,               PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE, },
 };
 
 FIXTURE(current_nsset)
@@ -54,6 +102,7 @@ FIXTURE(current_nsset)
 	pid_t pid;
 	int pidfd;
 	int nsfds[PIDFD_NS_MAX];
+	int child_pidfd_derived_nsfds[PIDFD_NS_MAX];
 
 	pid_t child_pid_exited;
 	int child_pidfd_exited;
@@ -61,10 +110,12 @@ FIXTURE(current_nsset)
 	pid_t child_pid1;
 	int child_pidfd1;
 	int child_nsfds1[PIDFD_NS_MAX];
+	int child_pidfd_derived_nsfds1[PIDFD_NS_MAX];
 
 	pid_t child_pid2;
 	int child_pidfd2;
 	int child_nsfds2[PIDFD_NS_MAX];
+	int child_pidfd_derived_nsfds2[PIDFD_NS_MAX];
 };
 
 static int sys_waitid(int which, pid_t pid, int options)
@@ -128,9 +179,12 @@ FIXTURE_SETUP(current_nsset)
 	char c;
 
 	for (i = 0; i < PIDFD_NS_MAX; i++) {
-		self->nsfds[i]		= -EBADF;
-		self->child_nsfds1[i]	= -EBADF;
-		self->child_nsfds2[i]	= -EBADF;
+		self->nsfds[i]				= -EBADF;
+		self->child_nsfds1[i]			= -EBADF;
+		self->child_nsfds2[i]			= -EBADF;
+		self->child_pidfd_derived_nsfds[i]	= -EBADF;
+		self->child_pidfd_derived_nsfds1[i]	= -EBADF;
+		self->child_pidfd_derived_nsfds2[i]	= -EBADF;
 	}
 
 	proc_fd = open("/proc/self/ns", O_DIRECTORY | O_CLOEXEC);
@@ -139,6 +193,11 @@ FIXTURE_SETUP(current_nsset)
 	}
 
 	self->pid = getpid();
+	self->pidfd = sys_pidfd_open(self->pid, 0);
+	EXPECT_GT(self->pidfd, 0) {
+		TH_LOG("%m - Failed to open pidfd for process %d", self->pid);
+	}
+
 	for (i = 0; i < PIDFD_NS_MAX; i++) {
 		const struct ns_info *info = &ns_info[i];
 		self->nsfds[i] = openat(proc_fd, info->name, O_RDONLY | O_CLOEXEC);
@@ -148,20 +207,27 @@ FIXTURE_SETUP(current_nsset)
 				       info->name, self->pid);
 			}
 		}
-	}
 
-	self->pidfd = sys_pidfd_open(self->pid, 0);
-	EXPECT_GT(self->pidfd, 0) {
-		TH_LOG("%m - Failed to open pidfd for process %d", self->pid);
+		self->child_pidfd_derived_nsfds[i] = ioctl(self->pidfd, info->pidfd_ioctl, 0);
+		if (self->child_pidfd_derived_nsfds[i] < 0) {
+			EXPECT_EQ(errno, EOPNOTSUPP) {
+				TH_LOG("%m - Failed to derive %s namespace from pidfd of process %d",
+				       info->name, self->pid);
+			}
+		}
 	}
 
 	/* Create task that exits right away. */
-	self->child_pid_exited = create_child(&self->child_pidfd_exited,
-					      CLONE_NEWUSER | CLONE_NEWNET);
+	self->child_pid_exited = create_child(&self->child_pidfd_exited, 0);
 	EXPECT_GE(self->child_pid_exited, 0);
 
-	if (self->child_pid_exited == 0)
+	if (self->child_pid_exited == 0) {
+		if (self->nsfds[PIDFD_NS_USER] >= 0 && unshare(CLONE_NEWUSER) < 0)
+			_exit(EXIT_FAILURE);
+		if (self->nsfds[PIDFD_NS_NET] >= 0 && unshare(CLONE_NEWNET) < 0)
+			_exit(EXIT_FAILURE);
 		_exit(EXIT_SUCCESS);
+	}
 
 	ASSERT_EQ(sys_waitid(P_PID, self->child_pid_exited, WEXITED | WNOWAIT), 0);
 
@@ -174,18 +240,43 @@ FIXTURE_SETUP(current_nsset)
 	EXPECT_EQ(ret, 0);
 
 	/* Create tasks that will be stopped. */
-	self->child_pid1 = create_child(&self->child_pidfd1,
-					CLONE_NEWUSER | CLONE_NEWNS |
-					CLONE_NEWCGROUP | CLONE_NEWIPC |
-					CLONE_NEWUTS | CLONE_NEWPID |
-					CLONE_NEWNET);
+	if (self->nsfds[PIDFD_NS_USER] >= 0 && self->nsfds[PIDFD_NS_PID] >= 0)
+		self->child_pid1 = create_child(&self->child_pidfd1, CLONE_NEWUSER | CLONE_NEWPID);
+	else if (self->nsfds[PIDFD_NS_PID] >= 0)
+		self->child_pid1 = create_child(&self->child_pidfd1, CLONE_NEWPID);
+	else if (self->nsfds[PIDFD_NS_USER] >= 0)
+		self->child_pid1 = create_child(&self->child_pidfd1, CLONE_NEWUSER);
+	else
+		self->child_pid1 = create_child(&self->child_pidfd1, 0);
 	EXPECT_GE(self->child_pid1, 0);
 
 	if (self->child_pid1 == 0) {
 		close(ipc_sockets[0]);
 
-		if (!switch_timens())
+		if (self->nsfds[PIDFD_NS_MNT] >= 0 && unshare(CLONE_NEWNS) < 0) {
+			TH_LOG("%m - Failed to unshare mount namespace for process %d", self->pid);
 			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_CGROUP] >= 0 && unshare(CLONE_NEWCGROUP) < 0) {
+			TH_LOG("%m - Failed to unshare cgroup namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_IPC] >= 0 && unshare(CLONE_NEWIPC) < 0) {
+			TH_LOG("%m - Failed to unshare ipc namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_UTS] >= 0 && unshare(CLONE_NEWUTS) < 0) {
+			TH_LOG("%m - Failed to unshare uts namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_NET] >= 0 && unshare(CLONE_NEWNET) < 0) {
+			TH_LOG("%m - Failed to unshare net namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_TIME] >= 0 && !switch_timens()) {
+			TH_LOG("%m - Failed to unshare time namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
 
 		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
 			_exit(EXIT_FAILURE);
@@ -203,18 +294,43 @@ FIXTURE_SETUP(current_nsset)
 	ret = socketpair(AF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
 	EXPECT_EQ(ret, 0);
 
-	self->child_pid2 = create_child(&self->child_pidfd2,
-					CLONE_NEWUSER | CLONE_NEWNS |
-					CLONE_NEWCGROUP | CLONE_NEWIPC |
-					CLONE_NEWUTS | CLONE_NEWPID |
-					CLONE_NEWNET);
+	if (self->nsfds[PIDFD_NS_USER] >= 0 && self->nsfds[PIDFD_NS_PID] >= 0)
+		self->child_pid2 = create_child(&self->child_pidfd2, CLONE_NEWUSER | CLONE_NEWPID);
+	else if (self->nsfds[PIDFD_NS_PID] >= 0)
+		self->child_pid2 = create_child(&self->child_pidfd2, CLONE_NEWPID);
+	else if (self->nsfds[PIDFD_NS_USER] >= 0)
+		self->child_pid2 = create_child(&self->child_pidfd2, CLONE_NEWUSER);
+	else
+		self->child_pid2 = create_child(&self->child_pidfd2, 0);
 	EXPECT_GE(self->child_pid2, 0);
 
 	if (self->child_pid2 == 0) {
 		close(ipc_sockets[0]);
 
-		if (!switch_timens())
+		if (self->nsfds[PIDFD_NS_MNT] >= 0 && unshare(CLONE_NEWNS) < 0) {
+			TH_LOG("%m - Failed to unshare mount namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_CGROUP] >= 0 && unshare(CLONE_NEWCGROUP) < 0) {
+			TH_LOG("%m - Failed to unshare cgroup namespace for process %d", self->pid);
 			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_IPC] >= 0 && unshare(CLONE_NEWIPC) < 0) {
+			TH_LOG("%m - Failed to unshare ipc namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_UTS] >= 0 && unshare(CLONE_NEWUTS) < 0) {
+			TH_LOG("%m - Failed to unshare uts namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_NET] >= 0 && unshare(CLONE_NEWNET) < 0) {
+			TH_LOG("%m - Failed to unshare net namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
+		if (self->nsfds[PIDFD_NS_TIME] >= 0 && !switch_timens()) {
+			TH_LOG("%m - Failed to unshare time namespace for process %d", self->pid);
+			_exit(EXIT_FAILURE);
+		}
 
 		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
 			_exit(EXIT_FAILURE);
@@ -267,6 +383,22 @@ FIXTURE_SETUP(current_nsset)
 				       info->name, self->child_pid1);
 			}
 		}
+
+		self->child_pidfd_derived_nsfds1[i] = ioctl(self->child_pidfd1, info->pidfd_ioctl, 0);
+		if (self->child_pidfd_derived_nsfds1[i] < 0) {
+			EXPECT_EQ(errno, EOPNOTSUPP) {
+				TH_LOG("%m - Failed to derive %s namespace from pidfd of process %d",
+				       info->name, self->child_pid1);
+			}
+		}
+
+		self->child_pidfd_derived_nsfds2[i] = ioctl(self->child_pidfd2, info->pidfd_ioctl, 0);
+		if (self->child_pidfd_derived_nsfds2[i] < 0) {
+			EXPECT_EQ(errno, EOPNOTSUPP) {
+				TH_LOG("%m - Failed to derive %s namespace from pidfd of process %d",
+				       info->name, self->child_pid2);
+			}
+		}
 	}
 
 	close(proc_fd);
@@ -288,6 +420,12 @@ FIXTURE_TEARDOWN(current_nsset)
 			close(self->child_nsfds1[i]);
 		if (self->child_nsfds2[i] >= 0)
 			close(self->child_nsfds2[i]);
+		if (self->child_pidfd_derived_nsfds[i] >= 0)
+			close(self->child_pidfd_derived_nsfds[i]);
+		if (self->child_pidfd_derived_nsfds1[i] >= 0)
+			close(self->child_pidfd_derived_nsfds1[i]);
+		if (self->child_pidfd_derived_nsfds2[i] >= 0)
+			close(self->child_pidfd_derived_nsfds2[i]);
 	}
 
 	if (self->child_pidfd1 >= 0)
@@ -446,6 +584,42 @@ TEST_F(current_nsset, nsfd_incremental_setns)
 	}
 }
 
+TEST_F(current_nsset, pidfd_derived_nsfd_incremental_setns)
+{
+	int i;
+	pid_t pid;
+
+	pid = getpid();
+	for (i = 0; i < PIDFD_NS_MAX; i++) {
+		const struct ns_info *info = &ns_info[i];
+		int nsfd;
+
+		if (self->child_pidfd_derived_nsfds1[i] < 0)
+			continue;
+
+		if (info->flag) {
+			ASSERT_EQ(setns(self->child_pidfd_derived_nsfds1[i], info->flag), 0) {
+				TH_LOG("%m - Failed to setns to %s namespace of %d via nsfd %d",
+				       info->name, self->child_pid1,
+				       self->child_pidfd_derived_nsfds1[i]);
+			}
+		}
+
+		/* Verify that we have changed to the correct namespaces. */
+		if (info->flag == CLONE_NEWPID)
+			nsfd = self->child_pidfd_derived_nsfds[i];
+		else
+			nsfd = self->child_pidfd_derived_nsfds1[i];
+		ASSERT_EQ(in_same_namespace(nsfd, pid, info->name), 1) {
+			TH_LOG("setns failed to place us correctly into %s namespace of %d via nsfd %d",
+			       info->name, self->child_pid1,
+			       self->child_pidfd_derived_nsfds1[i]);
+		}
+		TH_LOG("Managed to correctly setns to %s namespace of %d via nsfd %d",
+		       info->name, self->child_pid1, self->child_pidfd_derived_nsfds1[i]);
+	}
+}
+
 TEST_F(current_nsset, pidfd_one_shot_setns)
 {
 	unsigned flags = 0;
@@ -542,6 +716,28 @@ TEST_F(current_nsset, no_foul_play)
 		       info->name, self->child_pid2,
 		       self->child_nsfds2[i]);
 	}
+
+	/*
+	 * Can't setns to a user namespace outside of our hierarchy since we
+	 * don't have caps in there and didn't create it. That means that under
+	 * no circumstances should we be able to setns to any of the other
+	 * ones since they aren't owned by our user namespace.
+	 */
+	for (i = 0; i < PIDFD_NS_MAX; i++) {
+		const struct ns_info *info = &ns_info[i];
+
+		if (self->child_pidfd_derived_nsfds2[i] < 0 || !info->flag)
+			continue;
+
+		ASSERT_NE(setns(self->child_pidfd_derived_nsfds2[i], info->flag), 0) {
+			TH_LOG("Managed to setns to %s namespace of %d via nsfd %d",
+			       info->name, self->child_pid2,
+			       self->child_pidfd_derived_nsfds2[i]);
+		}
+		TH_LOG("%m - Correctly failed to setns to %s namespace of %d via nsfd %d",
+		       info->name, self->child_pid2,
+		       self->child_pidfd_derived_nsfds2[i]);
+	}
 }
 
 TEST(setns_einval)
-- 
2.43.0


