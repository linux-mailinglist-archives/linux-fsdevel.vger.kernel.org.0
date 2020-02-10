Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEF157E25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 16:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgBJPGJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 10:06:09 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:53828 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729098AbgBJPGI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:08 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id AF60FC61B1C;
        Mon, 10 Feb 2020 15:06:05 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Subject: [PATCH v8 03/11] proc: move /proc/{self|thread-self} dentries to proc_fs_info
Date:   Mon, 10 Feb 2020 16:05:11 +0100
Message-Id: <20200210150519.538333-4-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210150519.538333-1-gladkov.alexey@gmail.com>
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a preparation patch that moves /proc/{self|thread-self} dentries
to be stored inside procfs fs_info struct instead of making them per pid
namespace. Since we want to support multiple procfs instances we need to
make sure that these dentries are also per-superblock instead of
per-pidns, unmounting a private procfs won't clash with other procfs
mounts.

Cc: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Djalal Harouni <tixxdz@gmail.com>
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/base.c                | 5 +++--
 fs/proc/root.c                | 8 ++++----
 fs/proc/self.c                | 4 ++--
 fs/proc/thread_self.c         | 6 +++---
 include/linux/pid_namespace.h | 4 +---
 include/linux/proc_fs.h       | 2 ++
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 672e71c52dbd..1eb366ad8b06 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3316,6 +3316,7 @@ static struct tgid_iter next_tgid(struct pid_namespace *ns, struct tgid_iter ite
 int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct tgid_iter iter;
+	struct proc_fs_info *fs_info = proc_sb_info(file_inode(file)->i_sb);
 	struct pid_namespace *ns = proc_pid_ns(file_inode(file));
 	loff_t pos = ctx->pos;
 
@@ -3323,13 +3324,13 @@ int proc_pid_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	if (pos == TGID_OFFSET - 2) {
-		struct inode *inode = d_inode(ns->proc_self);
+		struct inode *inode = d_inode(fs_info->proc_self);
 		if (!dir_emit(ctx, "self", 4, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
 	}
 	if (pos == TGID_OFFSET - 1) {
-		struct inode *inode = d_inode(ns->proc_thread_self);
+		struct inode *inode = d_inode(fs_info->proc_thread_self);
 		if (!dir_emit(ctx, "thread-self", 11, inode->i_ino, DT_LNK))
 			return 0;
 		ctx->pos = pos = pos + 1;
diff --git a/fs/proc/root.c b/fs/proc/root.c
index d449f095f0f7..637e26cc795e 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -210,10 +210,10 @@ static void proc_kill_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	if (fs_info->pid_ns->proc_self)
-		dput(fs_info->pid_ns->proc_self);
-	if (fs_info->pid_ns->proc_thread_self)
-		dput(fs_info->pid_ns->proc_thread_self);
+	if (fs_info->proc_self)
+		dput(fs_info->proc_self);
+	if (fs_info->proc_thread_self)
+		dput(fs_info->proc_thread_self);
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
 	kfree(fs_info);
diff --git a/fs/proc/self.c b/fs/proc/self.c
index 57c0a1047250..846fc2b7c8a8 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -36,7 +36,7 @@ static unsigned self_inum __ro_after_init;
 int proc_setup_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = proc_pid_ns(root_inode);
+	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *self;
 	int ret = -ENOMEM;
 	
@@ -62,7 +62,7 @@ int proc_setup_self(struct super_block *s)
 	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
 	else
-		ns->proc_self = self;
+		fs_info->proc_self = self;
 
 	return ret;
 }
diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index f61ae53533f5..2493cbbdfa6f 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -36,7 +36,7 @@ static unsigned thread_self_inum __ro_after_init;
 int proc_setup_thread_self(struct super_block *s)
 {
 	struct inode *root_inode = d_inode(s->s_root);
-	struct pid_namespace *ns = proc_pid_ns(root_inode);
+	struct proc_fs_info *fs_info = proc_sb_info(s);
 	struct dentry *thread_self;
 	int ret = -ENOMEM;
 
@@ -60,9 +60,9 @@ int proc_setup_thread_self(struct super_block *s)
 	inode_unlock(root_inode);
 
 	if (ret)
-		pr_err("proc_fill_super: can't allocate /proc/thread_self\n");
+		pr_err("proc_fill_super: can't allocate /proc/thread-self\n");
 	else
-		ns->proc_thread_self = thread_self;
+		fs_info->proc_thread_self = thread_self;
 
 	return ret;
 }
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 49538b172483..f91a8bf6e09e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -31,9 +31,7 @@ struct pid_namespace {
 	unsigned int level;
 	struct pid_namespace *parent;
 #ifdef CONFIG_PROC_FS
-	struct vfsmount *proc_mnt;
-	struct dentry *proc_self;
-	struct dentry *proc_thread_self;
+	struct vfsmount *proc_mnt; /* Internal proc mounted during each new pidns */
 #endif
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	struct fs_pin *bacct;
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index 2d79489e55aa..59162988998e 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -14,6 +14,8 @@ struct seq_operations;
 
 struct proc_fs_info {
 	struct pid_namespace *pid_ns;
+	struct dentry *proc_self;        /* For /proc/self */
+	struct dentry *proc_thread_self; /* For /proc/thread-self */
 };
 
 static inline struct proc_fs_info *proc_sb_info(struct super_block *sb)
-- 
2.24.1

