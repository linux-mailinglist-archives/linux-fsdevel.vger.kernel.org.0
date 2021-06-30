Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FBD3B8AB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 00:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbhF3XBC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 19:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhF3XA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:00:59 -0400
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA62C061756
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 15:58:29 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GFc3P6tRFzMqJHc;
        Thu,  1 Jul 2021 00:49:21 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4GFc3P02DPzlh8T2;
        Thu,  1 Jul 2021 00:49:20 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 1/4] fs,security: Add resolve_path_at() hook
Date:   Thu,  1 Jul 2021 00:48:53 +0200
Message-Id: <20210630224856.1313928-2-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210630224856.1313928-1-mic@digikod.net>
References: <20210630224856.1313928-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

This new resolve_path_at() security hook enables checking absolute and
relative pathname resolutions according to the task's root directory,
the task's working directory, or an open file descriptor (e.g. thanks to
*at() syscalls).

It is useful to (efficiently) restrict access to file hierarchies (e.g.
leveraging openat2()'s resolve flags) according to file descriptors, and
to improve path access check time, which is used by Landlock in the
following commit.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20210630224856.1313928-2-mic@digikod.net
---
 fs/namei.c                    | 9 +++++++++
 include/linux/lsm_hook_defs.h | 2 ++
 include/linux/lsm_hooks.h     | 8 ++++++++
 include/linux/security.h      | 9 +++++++++
 security/security.c           | 6 ++++++
 5 files changed, 34 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 79b0ff9b151e..6efdd0b8e2b1 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2331,6 +2331,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 		error = nd_jump_root(nd);
 		if (unlikely(error))
 			return ERR_PTR(error);
+		error = security_resolve_path_at(&nd->path, NULL, flags);
+		if (error)
+			return ERR_PTR(error);
 		return s;
 	}
 
@@ -2350,6 +2353,9 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			get_fs_pwd(current->fs, &nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		error = security_resolve_path_at(&nd->path, NULL, flags);
+		if (error)
+			return ERR_PTR(error);
 	} else {
 		/* Caller must check execute permissions on the starting path component */
 		struct fd f = fdget_raw(nd->dfd);
@@ -2373,7 +2379,10 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			path_get(&nd->path);
 			nd->inode = nd->path.dentry->d_inode;
 		}
+		error = security_resolve_path_at(&nd->path, f.file, flags);
 		fdput(f);
+		if (error)
+			return ERR_PTR(error);
 	}
 
 	/* For scoped-lookups we need to set the root to the dirfd as well. */
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 04c01794de83..1db6d53b1dfb 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -178,6 +178,8 @@ LSM_HOOK(int, 0, file_send_sigiotask, struct task_struct *tsk,
 	 struct fown_struct *fown, int sig)
 LSM_HOOK(int, 0, file_receive, struct file *file)
 LSM_HOOK(int, 0, file_open, struct file *file)
+LSM_HOOK(int, 0, resolve_path_at, const struct path *path_at,
+	 struct file *file_at, int lookup_flags)
 LSM_HOOK(int, 0, task_alloc, struct task_struct *task,
 	 unsigned long clone_flags)
 LSM_HOOK(void, LSM_RET_VOID, task_free, struct task_struct *task)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 5c4c5c0602cb..2ef130e36309 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -600,6 +600,14 @@
  *	Save open-time permission checking state for later use upon
  *	file_permission, and recheck access if anything has changed
  *	since inode_permission.
+ * @resolve_path_at:
+ *	Check path resolution from a file descriptor, or the current working
+ *      directory, or the current root directory.
+ *      Can be called in RCU read-side critical section.
+ *      @path_at points to the base path.
+ *      @file_at can point to the file descriptor used to resolve the path, or
+ *      be NULL for AT_FDCWD.
+ *      @lookup_flags contains the lookup options (e.g. LOOKUP_IS_SCOPED).
  *
  * Security hooks for task operations.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index 06f7c50ce77f..e3ae93b9189d 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -391,6 +391,8 @@ int security_file_send_sigiotask(struct task_struct *tsk,
 				 struct fown_struct *fown, int sig);
 int security_file_receive(struct file *file);
 int security_file_open(struct file *file);
+int security_resolve_path_at(const struct path *path_at, struct file *file_at,
+		int lookup_flags);
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
 void security_task_free(struct task_struct *task);
 int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
@@ -1011,6 +1013,13 @@ static inline int security_file_open(struct file *file)
 	return 0;
 }
 
+static inline int security_resolve_path_at(const struct path *path_at,
+					   struct file *file_at,
+					   int lookup_flags)
+{
+	return 0;
+}
+
 static inline int security_task_alloc(struct task_struct *task,
 				      unsigned long clone_flags)
 {
diff --git a/security/security.c b/security/security.c
index b38155b2de83..98161f5919ee 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1637,6 +1637,12 @@ int security_file_open(struct file *file)
 	return fsnotify_perm(file, MAY_OPEN);
 }
 
+int security_resolve_path_at(const struct path *path_at, struct file *file_at,
+		int lookup_flags)
+{
+	return call_int_hook(resolve_path_at, 0, path_at, file_at, lookup_flags);
+}
+
 int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
 {
 	int rc = lsm_task_alloc(task);
-- 
2.32.0

