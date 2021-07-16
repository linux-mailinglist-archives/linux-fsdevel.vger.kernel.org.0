Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF113CB648
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbhGPKtn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 06:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239574AbhGPKtm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 06:49:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E419613FA;
        Fri, 16 Jul 2021 10:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626432407;
        bh=k94Nu9x4NfJTP2j35vA7U1lCV+pD0uPq7Q7Q46LODhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9TPjGZK1UCZwhURm34297lo4Z4vXjM8WQXFSsTvUHCkucMGSlLL87RiN9ivzav2p
         gt6EgzD1kMAvkyoOIHhEE0cf44jqPbc/yaLA9/IusaD1fwkJ7jeq7w73pWVTsQtWl8
         VGTG2ik2x4N+4UnHjZchWM7v4zABcAV3ayETXMztdRRCNBg4U0rK4oqTLfHuF0chz1
         PNiYGYS3FpFmPc4/X9ZQ5cpzO5l+L2hBbG1z5SIgT5GpQ1zcYwhkALDZe3MKOJ3ij+
         MRv+xQhZwklfQvyDedo1dS/fV0rO3/69FXZQxVFQ0LBq93lJguOOjTS96hPgHQUfOZ
         ZgCtwZDrEzbug==
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [RESEND PATCH v6 2/5] proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
Date:   Fri, 16 Jul 2021 12:46:00 +0200
Message-Id: <bd9f5c153bf9b9d79c2d5b3fcd1a305a9e10e5d1.1626432185.git.legion@kernel.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1626432185.git.legion@kernel.org>
References: <cover.1626432185.git.legion@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 18601042af99..a198f74cdb3b 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -26,6 +26,7 @@
 #include <linux/uidgid.h>
 #include <net/net_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -259,6 +260,7 @@ static struct net *get_proc_task_net(struct inode *dir)
 	struct task_struct *task;
 	struct nsproxy *ns;
 	struct net *net = NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
 	rcu_read_lock();
 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
@@ -271,6 +273,12 @@ static struct net *get_proc_task_net(struct inode *dir)
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
index 5e444d4f9717..6a75ac717455 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -171,6 +171,7 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 		return -ENOMEM;
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	fs_info->mounter_cred = get_cred(fc->cred);
 	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
@@ -220,6 +221,9 @@ static int proc_reconfigure(struct fs_context *fc)
 
 	sync_filesystem(sb);
 
+	put_cred(fs_info->mounter_cred);
+	fs_info->mounter_cred = get_cred(fc->cred);
+
 	proc_apply_options(fs_info, fc, current_user_ns());
 	return 0;
 }
@@ -274,6 +278,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
+	put_cred(fs_info->mounter_cred);
 	kfree(fs_info);
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 000cc0533c33..ffa871941bd0 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -64,6 +64,7 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	const struct cred *mounter_cred;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.29.3

