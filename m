Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29224BFE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgHTN4j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:56:39 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:41986 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729930AbgHTN4E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:56:04 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 8FCFB20A09;
        Thu, 20 Aug 2020 13:55:55 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 2/2] Show /proc/self/net only for CAP_NET_ADMIN
Date:   Thu, 20 Aug 2020 15:53:34 +0200
Message-Id: <2f6b3a1da70907eef5c29131d44acc10f477cc79.1597931457.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1597931457.git.gladkov.alexey@gmail.com>
References: <cover.1597931457.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 20 Aug 2020 13:55:56 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cache the mounters credentials and make access to the net directories
contingent of the permissions of the mounter of proc.

Show /proc/self/net only if mounter has CAP_NET_ADMIN and if proc is
mounted with subset=pid option.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/proc_net.c      | 8 ++++++++
 fs/proc/root.c          | 7 +++++++
 include/linux/proc_fs.h | 1 +
 3 files changed, 16 insertions(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index dba63b2429f0..c43fc5c907db 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -26,6 +26,7 @@
 #include <linux/uidgid.h>
 #include <net/net_namespace.h>
 #include <linux/seq_file.h>
+#include <linux/security.h>
 
 #include "internal.h"
 
@@ -275,6 +276,7 @@ static struct net *get_proc_task_net(struct inode *dir)
 	struct task_struct *task;
 	struct nsproxy *ns;
 	struct net *net = NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
 
 	rcu_read_lock();
 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
@@ -287,6 +289,12 @@ static struct net *get_proc_task_net(struct inode *dir)
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
index c6bf74de1906..eeeda375cf85 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -184,6 +184,8 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	s->s_fs_info = fs_info;
 
 	fs_info->pid_ns = get_pid_ns(ctx->pid_ns);
+	fs_info->mounter_cred = get_cred(fc->cred);
+
 	proc_apply_options(s, fc, current_user_ns());
 
 	/*
@@ -219,9 +221,13 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 static int proc_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
 	sync_filesystem(sb);
 
+	put_cred(fs_info->mounter_cred);
+	fs_info->mounter_cred = get_cred(fc->cred);
+
 	proc_apply_options(sb, fc, current_user_ns());
 	return 0;
 }
@@ -276,6 +282,7 @@ static void proc_kill_sb(struct super_block *sb)
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
+	put_cred(fs_info->mounter_cred);
 	kfree(fs_info);
 }
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index d1eed1b43651..ce00560789f6 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -63,6 +63,7 @@ struct proc_fs_info {
 	kgid_t pid_gid;
 	enum proc_hidepid hide_pid;
 	enum proc_pidonly pidonly;
+	const struct cred *mounter_cred;
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.25.4

