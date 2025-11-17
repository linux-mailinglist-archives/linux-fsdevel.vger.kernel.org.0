Return-Path: <linux-fsdevel+bounces-68721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B78C641B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 13:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DF494E5F5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C387A286412;
	Mon, 17 Nov 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewLXecs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D6261581
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 12:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763382981; cv=none; b=WjkPjS2N/tuokFWro0LIDJYwtZadtK7nZ/GWrMQSKSCO34MEAvqhXPP24XDczGOrnn9/xusubWZUA1eP5ZgKqsBWomQAfWG8JcUC6JoHmJBfEbJOwvWUfWBIbtc+r5bsEl3wfLp1Juk8gWbr6UCcbzdV0nCIg97ovujOYnXbp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763382981; c=relaxed/simple;
	bh=6kO9POWyAuOT7CLxbpUEZsnseM/qK0Hex7MatMaldq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxnTLyQTh9+T3SIz2LFTKyZWygEiVn814uggoTo91U4ndbjAYzf+EKQyM0IC0nUd7L/zdAWP5ZKob+0Ocn/bqp6/oKrHm/2QnK7EvbJ2Tq036BLwApgJ6hFxWwU1l9nLFbPN7nMbx3+QTvYMJYCEyOLF9xwJUep2oELpfm1kVK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewLXecs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D54C113D0;
	Mon, 17 Nov 2025 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763382981;
	bh=6kO9POWyAuOT7CLxbpUEZsnseM/qK0Hex7MatMaldq0=;
	h=From:To:Cc:Subject:Date:From;
	b=ewLXecs8KHOSmvBoz2HZGSaXee6YeD82MDBdO/hPoMXh08the7Lr7IW6RKHYmYsOB
	 jBu1lmnos7yYK3PejzaDKnFU5kkl7D/t1MzaWPQPh26mDVxyAxBGRBNIGtYL0Wkckc
	 KGa5yNkduz3z3CDp/8wvrvgx1sBzAcS4S53/Y2c1IGBNLLjBKf0mmU2qL5BTDWalZp
	 esyZfXsmqku4r4FF/t9pOOW9Z3bbJmY8hYXQGKhslPppyyxD1g6WdH4iSEIBlbGHwd
	 TlM6d/w4s/fYgLVQPGUS29cUir5HtVZtFkorEmFX69s43Y4iHIiWD8UJ1FR44Ktk9q
	 EOuMjBZvtLb2A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
Date: Mon, 17 Nov 2025 13:36:13 +0100
Message-ID: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3838; i=brauner@kernel.org; h=from:subject:message-id; bh=6kO9POWyAuOT7CLxbpUEZsnseM/qK0Hex7MatMaldq0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKi+13+j5nxsnHTNOeXD+xLeHjcffvpT+ip20Ql+ao3 nWTy2uedkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEfAoZ/gqWidlvDL3lsNG7 Zq3/su4FCYbh08Kz9vct2sTHFpCxbQvD/yreq5v6E93nm84OrLC9IRp7+Nwtp9N6pgpXb8w7xGW 4lgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

We have reworked namespaces sufficiently that all this special-casing
shouldn't be needed anymore

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 75 ++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index db236427fc2c..78dee3c201af 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -454,7 +454,6 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct ns_common *ns_common = NULL;
-	struct pid_namespace *pid_ns;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -496,66 +495,64 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
 	case PIDFD_GET_CGROUP_NAMESPACE:
-		if (IS_ENABLED(CONFIG_CGROUPS)) {
-			get_cgroup_ns(nsp->cgroup_ns);
-			ns_common = to_ns_common(nsp->cgroup_ns);
-		}
+		if (!ns_ref_get(nsp->cgroup_ns))
+			break;
+		ns_common = to_ns_common(nsp->cgroup_ns);
 		break;
 	case PIDFD_GET_IPC_NAMESPACE:
-		if (IS_ENABLED(CONFIG_IPC_NS)) {
-			get_ipc_ns(nsp->ipc_ns);
-			ns_common = to_ns_common(nsp->ipc_ns);
-		}
+		if (!ns_ref_get(nsp->ipc_ns))
+			break;
+		ns_common = to_ns_common(nsp->ipc_ns);
 		break;
 	case PIDFD_GET_MNT_NAMESPACE:
-		get_mnt_ns(nsp->mnt_ns);
+		if (!ns_ref_get(nsp->mnt_ns))
+			break;
 		ns_common = to_ns_common(nsp->mnt_ns);
 		break;
 	case PIDFD_GET_NET_NAMESPACE:
-		if (IS_ENABLED(CONFIG_NET_NS)) {
-			ns_common = to_ns_common(nsp->net_ns);
-			get_net_ns(ns_common);
-		}
+		if (!ns_ref_get(nsp->net_ns))
+			break;
+		ns_common = to_ns_common(nsp->net_ns);
 		break;
 	case PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE:
-		if (IS_ENABLED(CONFIG_PID_NS)) {
-			get_pid_ns(nsp->pid_ns_for_children);
-			ns_common = to_ns_common(nsp->pid_ns_for_children);
-		}
+		if (!ns_ref_get(nsp->pid_ns_for_children))
+			break;
+		ns_common = to_ns_common(nsp->pid_ns_for_children);
 		break;
 	case PIDFD_GET_TIME_NAMESPACE:
-		if (IS_ENABLED(CONFIG_TIME_NS)) {
-			get_time_ns(nsp->time_ns);
-			ns_common = to_ns_common(nsp->time_ns);
-		}
+		if (!ns_ref_get(nsp->time_ns))
+			break;
+		ns_common = to_ns_common(nsp->time_ns);
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
-		if (IS_ENABLED(CONFIG_TIME_NS)) {
-			get_time_ns(nsp->time_ns_for_children);
-			ns_common = to_ns_common(nsp->time_ns_for_children);
-		}
+		if (!ns_ref_get(nsp->time_ns_for_children))
+			break;
+		ns_common = to_ns_common(nsp->time_ns_for_children);
 		break;
 	case PIDFD_GET_UTS_NAMESPACE:
-		if (IS_ENABLED(CONFIG_UTS_NS)) {
-			get_uts_ns(nsp->uts_ns);
-			ns_common = to_ns_common(nsp->uts_ns);
-		}
+		if (!ns_ref_get(nsp->uts_ns))
+			break;
+		ns_common = to_ns_common(nsp->uts_ns);
 		break;
 	/* Namespaces that don't hang of nsproxy. */
 	case PIDFD_GET_USER_NAMESPACE:
-		if (IS_ENABLED(CONFIG_USER_NS)) {
-			rcu_read_lock();
-			ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
-			rcu_read_unlock();
+		scoped_guard(rcu) {
+			struct user_namespace *user_ns;
+
+			user_ns = task_cred_xxx(task, user_ns);
+			if (!ns_ref_get(user_ns))
+				break;
+			ns_common = to_ns_common(user_ns);
 		}
 		break;
 	case PIDFD_GET_PID_NAMESPACE:
-		if (IS_ENABLED(CONFIG_PID_NS)) {
-			rcu_read_lock();
+		scoped_guard(rcu) {
+			struct pid_namespace *pid_ns;
+
 			pid_ns = task_active_pid_ns(task);
-			if (pid_ns)
-				ns_common = to_ns_common(get_pid_ns(pid_ns));
-			rcu_read_unlock();
+			if (!ns_ref_get(pid_ns))
+				break;
+			ns_common = to_ns_common(pid_ns);
 		}
 		break;
 	default:
-- 
2.47.3


