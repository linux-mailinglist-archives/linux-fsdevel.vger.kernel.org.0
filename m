Return-Path: <linux-fsdevel+bounces-24070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00A938FB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CB71C213CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB1416D9A6;
	Mon, 22 Jul 2024 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUaQ4vDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9916A38B;
	Mon, 22 Jul 2024 13:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654056; cv=none; b=l3t5W95qwj2yo1eXTOjlLmQuQpQfuWtKSJ8BugyK+ypc1KF/5DFc4nOvTLFTDUgxT0Gbx7IkSGRLVUJVbiL2ZDXTsA9pBrsZZAoTIydhVZGjPBzOegnbgF0Bk66oa1qKH6CJNkDiyRSOZWgAiHNAjfSK3XZMwU13Ou/FJbzJ9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654056; c=relaxed/simple;
	bh=D0RxZYASpCCQKAC5UTydCFu3Tp1+vhfN386aUNTQLnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSUUVxdMpTco25QqZr74qdQhzbtsT/cC6iQ2F/VAunv2jb173XLiK1MCGw3EoL+PMx3JaZMRvVPirp5AkNo0VNKJXYy4L9Mrhi1Zi8L458Oy2fz1Wy+Cpm5wNkrJ12fLeF4LSDBSlhJFjUrIEfiQFy+weZiMOg4o3Xz1SEiMfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUaQ4vDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC6E1C116B1;
	Mon, 22 Jul 2024 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721654055;
	bh=D0RxZYASpCCQKAC5UTydCFu3Tp1+vhfN386aUNTQLnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WUaQ4vDydyxXmNNhyCXrkdssaDZ0GspWER5TWaufbWFgSyPp69Fv9RD1v9Vt1wjOf
	 FIk/sj2wX+epmwdWlAiudVOZwEB+GtGYgdWWnXxR5jRj7ULLbFuBcWn9pppbKvbkSq
	 RT+RT1jOvMVXGxVr3W7pyWMd027WF4v3Bg7DQP5rs/QlUQNfPsxJ84X1b/Y6+YqgB7
	 HO6ptpGC0m/i0ALKyH2PXr31yZFEEYa4hzkp5s6mtz2B8SwhD3mHiQltqoC+lOUsmu
	 4wyCBOiPptir9VC7Vw9ch+Hbsh0iawEMiBwjfQj4fV0laD+e45AcWWQduim41jZ6N4
	 ZzsDnLwPl/46g==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+34a0ee986f61f15da35d@syzkaller.appspotmail.com,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH 1/2] pidfs: handle kernels without namespaces cleanly
Date: Mon, 22 Jul 2024 15:13:54 +0200
Message-ID: <20240722-work-pidfs-e6a83030f63e@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
References: <tencent_7FAE8DB725EE0DD69236DDABDDDE195E4F07@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4320; i=brauner@kernel.org; h=from:subject:message-id; bh=D0RxZYASpCCQKAC5UTydCFu3Tp1+vhfN386aUNTQLnI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNi5bunnlWI/VajsNEN+4LRwSLylKk/pj0HJL+tPpOA R/jna2GHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJ+MbwP/KF7LM/u4LeOKTJ /eMLND70NUklSPZQ3DOLdU8m1C2bX8zwT8OVX/G5VWaZqF7Xd7XfdxSMc7IrX4rXbLk9J41pTfB ePgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The nsproxy structure contains nearly all of the namespaces associated
with a task. When a given namespace type is not supported by this kernel
the rules whether the corresponding pointer in struct nsproxy is NULL or
always init_<ns_type>_ns differ per namespace. Ideally, that wouldn't be
the case and for all namespace types we'd always set it to
init_<ns_type>_ns when the corresponding namespace type isn't supported.

Make sure we handle all namespaces where the pointer in struct nsproxy
can be NULL when the namespace type isn't supported.

Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors") # mainline only
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 65 +++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index fe0ddab48f57..7ffdc88dfb52 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -119,7 +119,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct pid *pid = pidfd_pid(file);
-	struct ns_common *ns_common;
+	struct ns_common *ns_common = NULL;
 
 	if (arg)
 		return -EINVAL;
@@ -146,54 +146,73 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
 	case PIDFD_GET_CGROUP_NAMESPACE:
-		get_cgroup_ns(nsp->cgroup_ns);
-		ns_common = to_ns_common(nsp->cgroup_ns);
+		if (IS_ENABLED(CONFIG_CGROUPS)) {
+			get_cgroup_ns(nsp->cgroup_ns);
+			ns_common = to_ns_common(nsp->cgroup_ns);
+		}
 		break;
 	case PIDFD_GET_IPC_NAMESPACE:
-		get_ipc_ns(nsp->ipc_ns);
-		ns_common = to_ns_common(nsp->ipc_ns);
+		if (IS_ENABLED(CONFIG_IPC_NS)) {
+			get_ipc_ns(nsp->ipc_ns);
+			ns_common = to_ns_common(nsp->ipc_ns);
+		}
 		break;
 	case PIDFD_GET_MNT_NAMESPACE:
 		get_mnt_ns(nsp->mnt_ns);
 		ns_common = to_ns_common(nsp->mnt_ns);
 		break;
 	case PIDFD_GET_NET_NAMESPACE:
-		ns_common = to_ns_common(nsp->net_ns);
-		get_net_ns(ns_common);
+		if (IS_ENABLED(CONFIG_NET_NS)) {
+			ns_common = to_ns_common(nsp->net_ns);
+			get_net_ns(ns_common);
+		}
 		break;
 	case PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE:
-		get_pid_ns(nsp->pid_ns_for_children);
-		ns_common = to_ns_common(nsp->pid_ns_for_children);
+		if (IS_ENABLED(CONFIG_PID_NS)) {
+			get_pid_ns(nsp->pid_ns_for_children);
+			ns_common = to_ns_common(nsp->pid_ns_for_children);
+		}
 		break;
 	case PIDFD_GET_TIME_NAMESPACE:
-		get_time_ns(nsp->time_ns);
-		ns_common = to_ns_common(nsp->time_ns);
-		if (!nsp->time_ns)
-			return -EINVAL;
+		if (IS_ENABLED(CONFIG_TIME_NS)) {
+			get_time_ns(nsp->time_ns);
+			ns_common = to_ns_common(nsp->time_ns);
+		}
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
-		get_time_ns(nsp->time_ns_for_children);
-		ns_common = to_ns_common(nsp->time_ns_for_children);
+		if (IS_ENABLED(CONFIG_TIME_NS)) {
+			get_time_ns(nsp->time_ns_for_children);
+			ns_common = to_ns_common(nsp->time_ns_for_children);
+		}
 		break;
 	case PIDFD_GET_UTS_NAMESPACE:
-		get_uts_ns(nsp->uts_ns);
-		ns_common = to_ns_common(nsp->uts_ns);
+		if (IS_ENABLED(CONFIG_UTS_NS)) {
+			get_uts_ns(nsp->uts_ns);
+			ns_common = to_ns_common(nsp->uts_ns);
+		}
 		break;
 	/* Namespaces that don't hang of nsproxy. */
 	case PIDFD_GET_USER_NAMESPACE:
-		rcu_read_lock();
-		ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
-		rcu_read_unlock();
+		if (IS_ENABLED(CONFIG_USER_NS)) {
+			rcu_read_lock();
+			ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
+			rcu_read_unlock();
+		}
 		break;
 	case PIDFD_GET_PID_NAMESPACE:
-		rcu_read_lock();
-		ns_common = to_ns_common(get_pid_ns(task_active_pid_ns(task)));
-		rcu_read_unlock();
+		if (IS_ENABLED(CONFIG_PID_NS)) {
+			rcu_read_lock();
+			ns_common = to_ns_common( get_pid_ns(task_active_pid_ns(task)));
+			rcu_read_unlock();
+		}
 		break;
 	default:
 		return -ENOIOCTLCMD;
 	}
 
+	if (!ns_common)
+		return -EOPNOTSUPP;
+
 	/* open_namespace() unconditionally consumes the reference */
 	return open_namespace(ns_common);
 }
-- 
2.43.0


