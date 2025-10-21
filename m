Return-Path: <linux-fsdevel+bounces-64858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE114BF6235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B62B502995
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA936337119;
	Tue, 21 Oct 2025 11:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNIfXkyV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F159732E681;
	Tue, 21 Oct 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047066; cv=none; b=A8s4xZMrRePACAd10SyxeVC0GSWxlkXSxN8rJPWmn9nQLgW8j7uZMj3/ZZWub7KqA5CYs/8FKw6j3e3nE8pK/vAxYaISMbwCJLKNVKpzUy3kwK4mbxZ3vjT3BpFMUnM7Am8Zm9vvOvsr5WGDVXanJ8ynjCDclrJl3JA0/tzlE+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047066; c=relaxed/simple;
	bh=GmTU8Q/fclIPwxUSGwafLrmOAHz2L+FN5rNlGUSGB9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XqMylGEFzci5Yk3gQgnxiT3Te0jjPNGgfQ3+SpGyT6dzlfJhlaHdsdul5ese/7XuraR9jeGe7JILK63VbxcJR5C8e/2taBPXnbvPSaaeNR4jHj4YBkL/xOBl6yWaTo7LBHNi83ZNOSZFlieQ9fX/VKP+I7UvqX9jrY7V/PbEUaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNIfXkyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEC4C4CEF1;
	Tue, 21 Oct 2025 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761047065;
	bh=GmTU8Q/fclIPwxUSGwafLrmOAHz2L+FN5rNlGUSGB9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hNIfXkyVS2T600rPJfW0QEO0GGCxLcg8JUUGgqln/i2NzVuJJ78s4AGZHo8lTM/wz
	 4ZdqYgleuFDLbuHhq5N0aiw6ex7B+S1vmq0JSSJ0IrsF/UClq5LntEafqXerxpwWUL
	 h0Gc4uwB1RACqVqJ//++XE7h7PqnWxF+X7aqqNyi2WUp/cQKQjvqlEWFHbhPNRGioj
	 DTfUClzu3SQlktOBFmWO+sMw3PzXiuRYCXBvtYpNvT1eGs9lerQBYnRIvX80TpBefc
	 G0PcZsrgDYRnY7x/f4ss8pXa2GqI3ceZUszDr+POvHLhbvtcJ1n5MuZX8a86JAFTbt
	 Och95hBGtRcTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 21 Oct 2025 13:43:13 +0200
Subject: [PATCH RFC DRAFT 07/50] ns: initialize ns_list_node for initial
 namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-work-namespace-nstree-listns-v1-7-ad44261a8a5b@kernel.org>
References: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
In-Reply-To: <20251021-work-namespace-nstree-listns-v1-0-ad44261a8a5b@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3505; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GmTU8Q/fclIPwxUSGwafLrmOAHz2L+FN5rNlGUSGB9Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR8L3zz9SmnZ63k6e3e56zjz5n5l/Wrn9rdvIK57FPTE
 +7oT/UzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSe5bhf6KG2tvdCjt2lBRP
 8w53+/nHY1eY16QHQvzaF18fd761aSYjw7VLrvemnjzN4+TyyL/okltoovs2gdlbq0u2BGfavP2
 oxAkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make sure that the list is always initialized for initial namespaces.

Fixes: 885fc8ac0a4d ("nstree: make iterator generic")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c           | 1 +
 init/version-timestamp.c | 1 +
 ipc/msgutil.c            | 1 +
 kernel/cgroup/cgroup.c   | 1 +
 kernel/pid.c             | 1 +
 kernel/time/namespace.c  | 1 +
 kernel/user.c            | 1 +
 7 files changed, 7 insertions(+)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..8ef8ba3dd316 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5993,6 +5993,7 @@ struct mnt_namespace init_mnt_ns = {
 	.passive	= REFCOUNT_INIT(1),
 	.mounts		= RB_ROOT,
 	.poll		= __WAIT_QUEUE_HEAD_INITIALIZER(init_mnt_ns.poll),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_mnt_ns.ns.ns_list_node),
 };
 
 static void __init init_mount_tree(void)
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index d071835121c2..61b2405d97f9 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -20,6 +20,7 @@ struct uts_namespace init_uts_ns = {
 	},
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_uts_ns),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_uts_ns.ns.ns_list_node),
 #ifdef CONFIG_UTS_NS
 	.ns.ops = &utsns_operations,
 #endif
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 7a03f6d03de3..c9469fbce27c 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -30,6 +30,7 @@ struct ipc_namespace init_ipc_ns = {
 	.ns.__ns_ref = REFCOUNT_INIT(1),
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_ipc_ns),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_ipc_ns.ns.ns_list_node),
 #ifdef CONFIG_IPC_NS
 	.ns.ops = &ipcns_operations,
 #endif
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae5f48cf64e..a82918da8bae 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -256,6 +256,7 @@ struct cgroup_namespace init_cgroup_ns = {
 	.ns.inum	= ns_init_inum(&init_cgroup_ns),
 	.root_cset	= &init_css_set,
 	.ns.ns_type	= ns_common_type(&init_cgroup_ns),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_cgroup_ns.ns.ns_list_node),
 };
 
 static struct file_system_type cgroup2_fs_type;
diff --git a/kernel/pid.c b/kernel/pid.c
index 4fffec767a63..cb7574ca00f7 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -78,6 +78,7 @@ struct pid_namespace init_pid_ns = {
 	.child_reaper = &init_task,
 	.user_ns = &init_user_ns,
 	.ns.inum = ns_init_inum(&init_pid_ns),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_pid_ns.ns.ns_list_node),
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 5b6997f4dc3d..ee05cad288da 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -484,6 +484,7 @@ struct time_namespace init_time_ns = {
 	.ns.inum	= ns_init_inum(&init_time_ns),
 	.ns.ops		= &timens_operations,
 	.frozen_offsets	= true,
+	.ns.ns_list_node = LIST_HEAD_INIT(init_time_ns.ns.ns_list_node),
 };
 
 void __init time_ns_init(void)
diff --git a/kernel/user.c b/kernel/user.c
index 0163665914c9..b9cf3b056a71 100644
--- a/kernel/user.c
+++ b/kernel/user.c
@@ -70,6 +70,7 @@ struct user_namespace init_user_ns = {
 	.owner = GLOBAL_ROOT_UID,
 	.group = GLOBAL_ROOT_GID,
 	.ns.inum = ns_init_inum(&init_user_ns),
+	.ns.ns_list_node = LIST_HEAD_INIT(init_user_ns.ns.ns_list_node),
 #ifdef CONFIG_USER_NS
 	.ns.ops = &userns_operations,
 #endif

-- 
2.47.3


