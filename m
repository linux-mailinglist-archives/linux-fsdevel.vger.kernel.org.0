Return-Path: <linux-fsdevel+bounces-62219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D29CB88C15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A12F528391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0212C029D;
	Fri, 19 Sep 2025 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJgcLZZ1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AA2381BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276389; cv=none; b=IzAiUdz+s1oM3dbVzPCPCU6QruY+BrLwZqm84gOQko39OxqeoKt5MR+5KLrm5LwAXKLC9AQorcbg2Q3jsPyOZj6ncu2gHqP+wD+IuNuTBYsHDoo5OTHWRzjhdnaBqv//7XOtIj78qvetuNP+OTvsIEw07UMsps5uYzbgccKZXlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276389; c=relaxed/simple;
	bh=II77BoWGthqmfnHZJL8n8n6y7+7q073yQy40lHfI88A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/BR50wdtAJ2AENnkfvNDf962yIei4ovqfctXUYSgxGS6FPYaO5I7DF1aK4w1HtOy3IpLtWjDs9PyYZolNq0RuO7Z1i905N3oe94c9c3iLpuYz2iAva6Yd14RCZZUjW5JFaiGw8VsVyF67YPSPvYpBbkgRP4YAuGcjPYg+0MITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJgcLZZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D16C4CEF1;
	Fri, 19 Sep 2025 10:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758276388;
	bh=II77BoWGthqmfnHZJL8n8n6y7+7q073yQy40lHfI88A=;
	h=From:To:Cc:Subject:Date:From;
	b=mJgcLZZ1XFB1e6o3WsrGBlvHDAFQMWe7BazzaoTds8GAgShKO15imR2svneNEURl+
	 QvtNk+8sqVdg+gwgvWBoKrBlvnHeozk68OUkbEMQDLVTlCMDo6NySyNf8vhi8MKNGt
	 YId8GcK9qVaFZq+hB6wB7v3HTmyspttfIveNupD+HaKTJQMr9Yi8FKP7okIQ8HAhWo
	 0mir/jgunlh6S3knXUPj9hetLJw4d5/iNn2FyWDdAiDiLP18vgi7aOEdzvk3lBBY+Z
	 bJKalqS12A8STI1MmOyd3rcCj+sY4WunrR7C1/9Yl8XtQgP4NBCKLgAVaI95sx+gWR
	 w/gLrEQHB6ZUw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jeff Layton <jlayton@kernel.org>,
	Mike Yuan <me@yhndnzj.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ns: use inode initializer for initial namespaces
Date: Fri, 19 Sep 2025 12:06:11 +0200
Message-ID: <20250919-erbeben-wirken-283389ef529b@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3444; i=brauner@kernel.org; h=from:subject:message-id; bh=II77BoWGthqmfnHZJL8n8n6y7+7q073yQy40lHfI88A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSc1Raz7ja5nT1VRf1TafqLlTesN7AfZjdwCT1fY32+i S3655odHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZ8IKRofW5AtcXAy5/3WDO AsaNSxfOrPb23moWGb3wXe3VuT4nVjMyLHPQmZOueWCdqqn7dePVykXf7Vf4JQRcLXXvuupUJiD FAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Just use the common helper we have.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c           | 2 +-
 init/version-timestamp.c | 2 +-
 ipc/msgutil.c            | 2 +-
 kernel/cgroup/cgroup.c   | 2 +-
 kernel/pid.c             | 2 +-
 kernel/time/namespace.c  | 2 +-
 kernel/user.c            | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 699b8c770c47..410b5fce1633 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6012,7 +6012,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 }
 
 struct mnt_namespace init_mnt_ns = {
-	.ns.inum	= PROC_MNT_INIT_INO,
+	.ns.inum	= ns_init_inum(&init_mnt_ns),
 	.ns.ops		= &mntns_operations,
 	.user_ns	= &init_user_ns,
 	.ns.count	= REFCOUNT_INIT(1),
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 043cbf80a766..8e335d54745d 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -18,7 +18,7 @@ struct uts_namespace init_uts_ns = {
 		.domainname	= UTS_DOMAINNAME,
 	},
 	.user_ns = &init_user_ns,
-	.ns.inum = PROC_UTS_INIT_INO,
+	.ns.inum = ns_init_inum(&init_uts_ns),
 #ifdef CONFIG_UTS_NS
 	.ns.ops = &utsns_operations,
 #endif
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index bbf61275df41..0fa5aef5fc03 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -29,7 +29,7 @@ DEFINE_SPINLOCK(mq_lock);
 struct ipc_namespace init_ipc_ns = {
 	.ns.count = REFCOUNT_INIT(1),
 	.user_ns = &init_user_ns,
-	.ns.inum = PROC_IPC_INIT_INO,
+	.ns.inum = ns_init_inum(&init_ipc_ns),
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 092e6bf081ed..1f2dde3ffc15 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -222,7 +222,7 @@ struct cgroup_namespace init_cgroup_ns = {
 	.ns.count	= REFCOUNT_INIT(2),
 	.user_ns	= &init_user_ns,
 	.ns.ops		= &cgroupns_operations,
-	.ns.inum	= PROC_CGROUP_INIT_INO,
+	.ns.inum	= ns_init_inum(&init_cgroup_ns),
 	.root_cset	= &init_css_set,
 };
 
diff --git a/kernel/pid.c b/kernel/pid.c
index c45a28c16cd2..9a803a511d63 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -77,7 +77,7 @@ struct pid_namespace init_pid_ns = {
 	.level = 0,
 	.child_reaper = &init_task,
 	.user_ns = &init_user_ns,
-	.ns.inum = PROC_PID_INIT_INO,
+	.ns.inum = ns_init_inum(&init_pid_ns),
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index ce8e952104a7..f58f64bab28b 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -482,7 +482,7 @@ const struct proc_ns_operations timens_for_children_operations = {
 struct time_namespace init_time_ns = {
 	.ns.count	= REFCOUNT_INIT(3),
 	.user_ns	= &init_user_ns,
-	.ns.inum	= PROC_TIME_INIT_INO,
+	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
 	.frozen_offsets	= true,
 };
diff --git a/kernel/user.c b/kernel/user.c
index f46b1d41163b..14a59e53b20c 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -68,7 +68,7 @@ struct user_namespace init_user_ns = {
 	.ns.count = REFCOUNT_INIT(3),
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
-	.ns.inum = PROC_USER_INIT_INO,
+	.ns.inum = ns_init_inum(&init_user_ns),
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
 #endif
-- 
2.47.3


