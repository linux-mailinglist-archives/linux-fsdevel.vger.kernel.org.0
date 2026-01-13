Return-Path: <linux-fsdevel+bounces-73400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323CD179F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C12C230B3704
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BC138B9A6;
	Tue, 13 Jan 2026 09:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlffVeKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0382DCBF8;
	Tue, 13 Jan 2026 09:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296079; cv=none; b=nVRJh8CE1D3yR+Me1eK4/9HF29k/y/MoIfiDZvtRvbyg23uY7agZjl6Mi6rH9Pmy+BFClaz3scsYqIatz6DVt4Hvx0EqjTU8k56h3H2GMYBnTgTEERRLVamYPzkGrVJm7pgEjCc0lsTcvILMaapW6hMcSS3mllOGClGnHQp3f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296079; c=relaxed/simple;
	bh=udmo2LCuIit5b9kJ4na+SmQh196MbKm4OupPlijFkDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZbOQZ1lVep+9wHueWku/grk25tgc26o8HTuX/uCypfK06qO0m8xqRF5fgYPkWuVaIBPMudLRGChT6O1MqlVTzHh6i07Ylwz/29p1NJwWzvlxJdK9TjgNMqnj/rlAOCboG+cGPJHjlPVbHqOKki2+9j3gDfiPqnKgPMWvPqxx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlffVeKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB93C116C6;
	Tue, 13 Jan 2026 09:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768296075;
	bh=udmo2LCuIit5b9kJ4na+SmQh196MbKm4OupPlijFkDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlffVeKuc7HdJL/E7SL3QSaJxFsCS44zPqOVN9deur/ORmRf4Rqcm7+g6ae9UychK
	 HTCPmEnG7jgYoSCvwTn4s/HTY5nPD9xQ2SuAL6eNvonBBa9oFZEcXQZYlwrDq15ZNp
	 qHtOAJzIJTQfXkbB0z2zKPqkOwRr/6HFAkEbeIfoonfXYwXEcX5cHwOMuSC615+ZNX
	 WbsoT2qUMFgpBp6NIK0LNhfobLM3njY/igW5we+3DPiIXh/UDLC2jEyVcVhcuaPkpt
	 vwCwrn5Wh9JHgcBpyBEGsqHeXZ+J12cdDsXIw6B1ndIIl2hHeuH/qW3uoUIWCUw+DI
	 ZUNo1af/h4Rog==
From: Alexey Gladkov <legion@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Dan Klishch <danilklishch@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	containers@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/5] proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
Date: Tue, 13 Jan 2026 10:20:34 +0100
Message-ID: <e14856f2c5f4635ddf72de61ecc59851c131489c.1768295900.git.legion@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768295900.git.legion@kernel.org>
References: <20251213050639.735940-1-danilklishch@gmail.com> <cover.1768295900.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cache the mounters credentials and allow access to the net directories
contingent of the permissions of the mounter of proc.

Do not show /proc/self/net when proc is mounted with subset=pid option
and the mounter does not have CAP_NET_ADMIN.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 fs/proc/proc_net.c      | 8 ++++++++
 fs/proc/root.c          | 5 +++++
 include/linux/proc_fs.h | 1 +
 3 files changed, 14 insertions(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index 52f0b75cbce2..6e0ccef0169f 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -23,6 +23,7 @@
 #include <linux/uidgid.h>
 #include <net/net_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -270,6 +271,7 @@ static struct net *get_proc_task_net(struct inode *dir)
 	struct task_struct *task;
 	struct nsproxy *ns;
 	struct net *net = NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
 	rcu_read_lock();
 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
@@ -282,6 +284,12 @@ static struct net *get_proc_task_net(struct inode *dir)
 	}
 	rcu_read_unlock();
 
+	if (net && (fs_info->pidonly == PROC_PIDONLY_ON) &&
+	    security_capable(fs_info->mounter_cred, net->user_ns, CAP_NET_ADMIN, CAP_OPT_NONE) < 0) {
+		put_net(net);
+		net = NULL;
+	}
+
 	return net;
 }
 
diff --git a/fs/proc/root.c b/fs/proc/root.c
index d8ca41d823e4..ed8a101d09d3 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -254,6 +254,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	fs_info->mounter_cred = get_cred(fc->cred);
 	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
@@ -303,6 +304,9 @@ static int proc_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
+	put_cred(fs_info->mounter_cred);
+	fs_info->mounter_cred = get_cred(fc->cred);
+
 	proc_apply_options(fs_info, fc, current_user_ns());
 	return 0;
 }
@@ -350,6 +354,7 @@ static void proc_kill_sb(struct super_block *sb)
 	kill_anon_super(sb);
 	if (fs_info) {
 		put_pid_ns(fs_info->pid_ns);
+		put_cred(fs_info->mounter_cred);
 		kfree_rcu(fs_info, rcu);
 	}
 }
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 19d1c5e5f335..ec123c277d49 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -67,6 +67,7 @@ enum proc_pidonly {
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
 	kgid_t pid_gid;
+	const struct cred *mounter_cred;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
 	struct rcu_head rcu;
-- 
2.52.0


