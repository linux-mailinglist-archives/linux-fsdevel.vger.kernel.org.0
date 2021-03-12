Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D003393C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 17:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhCLQmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 11:42:38 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:49790 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232950AbhCLQmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:42:04 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 2FBDB40CA0;
        Fri, 12 Mar 2021 16:42:02 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v6 2/5] proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
Date:   Fri, 12 Mar 2021 17:41:45 +0100
Message-Id: <c7039af1d054dce069845f303bbbc026636f3971.1615567183.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1615567183.git.gladkov.alexey@gmail.com>
References: <cover.1615567183.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Fri, 12 Mar 2021 16:42:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cache the mounters credentials and allow access to the net directories
contingent of the permissions of the mounter of proc.

Do not show /proc/self/net when proc is mounted with subset=pid option
and the mounter does not have CAP_NET_ADMIN.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
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

