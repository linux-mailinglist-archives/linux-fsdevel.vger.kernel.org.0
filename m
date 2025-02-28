Return-Path: <linux-fsdevel+bounces-42848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD75A499AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE52A1730CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A1A26B2B1;
	Fri, 28 Feb 2025 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIXv3Sf+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2092026E14F
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746671; cv=none; b=p+8QpvNLXTRAIA4XiM+i17fTel1qh9T334nTfgnl5QHgoD4Xr8pxqantP4KhBe66G4TwSkFUHAUt6UQhl2xRkRI7DaZCOtzT4BODtZ8Tao6R+3m/OeilM5GQ2KdLTtZ+OAIcg7tKlyRRTMxzcHyQNk706+Q/mEF46aU4F2T8ehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746671; c=relaxed/simple;
	bh=UO80nWRJ1sBDNhKE3ZSEwFMcq8tF25zOfV4tpADWWjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eov/mndV0Ebt83D2LrMNWXUFZwiVMB1zK77HWo46v9jY7qM3+t5FueMTAHzcxq8kRgLvPZ833WHOyBpIt9HaUDmt7mDr4HRuGwcL0fNLxBIxqmIbCm39o7h4uJqsAYqyv8AWxkms7EegXADPOQPu8abnjWY0odrt2tONgUBRuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIXv3Sf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13F64C4CED6;
	Fri, 28 Feb 2025 12:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746670;
	bh=UO80nWRJ1sBDNhKE3ZSEwFMcq8tF25zOfV4tpADWWjs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIXv3Sf+8zZPzcUGZD1cABrbGS0vgKaXBq9liQUuR+mnERMbuR/QPt/6ZcApCIPAQ
	 1FcQVKijcEtIw0VF+bSY56qG2QowxC5gHm0SSTKYSOr8qhIhob6KjU0wdHYAO0a+sU
	 xsq/BM+rgh/X7hZcm5YeTtzk5vrDsHKGwVJD8aB24vOd6uQW31aS39EIbHjaBMrNmR
	 cxiouq3U4AiSIGUQD0ButvamQzFwcdxX4uaaBiG8ecSbsja5mSjw7mUbPtMyWhd9yv
	 KnZwAepVEO7U2gKFbvUqHd6vK328PBvMqq0OVUjuppOZV37+Yb7H2iuSWGqB/ia1fO
	 35Ku+QDaIpcug==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:05 +0100
Subject: [PATCH RFC 05/10] pidfs: record exit code and cgroupid at exit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-5-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4689; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UO80nWRJ1sBDNhKE3ZSEwFMcq8tF25zOfV4tpADWWjs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/osNa9HMnZj0xTH74+oeFc8LRI9MopsYCmXycXf
 7wv5H85o6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiU00ZGfZ8TXw97d0Bzkn3
 DztahJVei/uf6TGVufTFXnvrkHVeVzMZGZY9X/vW4H72ptarDotP3whhvcq+oYlpeZTsCWOVlXP
 ff+YFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Record the exit code and cgroupid in do_exit() and stash in struct
pidfs_exit_info so it can be retrieved even after the task has been
reaped.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h         |  1 +
 fs/libfs.c            |  4 ++--
 fs/pidfs.c            | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pidfs.h |  1 +
 kernel/exit.c         |  2 ++
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index e7f02ae1e098..c1e6d8b294cb 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -325,6 +325,7 @@ struct stashed_operations {
 int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		      struct path *path);
 void stashed_dentry_prune(struct dentry *dentry);
+struct dentry *stashed_dentry_get(struct dentry **stashed);
 /**
  * path_mounted - check whether path is mounted
  * @path: path to check
diff --git a/fs/libfs.c b/fs/libfs.c
index 8444f5cc4064..cf5a267aafe4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2113,7 +2113,7 @@ struct timespec64 simple_inode_init_ts(struct inode *inode)
 }
 EXPORT_SYMBOL(simple_inode_init_ts);
 
-static inline struct dentry *get_stashed_dentry(struct dentry **stashed)
+struct dentry *stashed_dentry_get(struct dentry **stashed)
 {
 	struct dentry *dentry;
 
@@ -2215,7 +2215,7 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
 
 	/* See if dentry can be reused. */
-	path->dentry = get_stashed_dentry(stashed);
+	path->dentry = stashed_dentry_get(stashed);
 	if (path->dentry) {
 		sops->put_data(data);
 		goto out_path;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 64428697996f..433f676c066c 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -458,6 +458,53 @@ struct pid *pidfd_pid(const struct file *file)
 	return file_inode(file)->i_private;
 }
 
+/*
+ * We're called from do_exit(). We know there's at least one reference
+ * to struct pid being held that won't be released until the task has
+ * been reaped which cannot happen until we're out of do_exit().
+ *
+ * If this struct pid is refered to by a pidfd then stashed_dentry_get()
+ * will return the dentry and inode for that struct pid. Since we've
+ * taken a reference on it there's now an additional reference from the
+ * exit path on it. Which is fine. We're going to put it again in a
+ * second and we know that the pid is kept alive anyway.
+ *
+ * Worst case is that we've filled in the info and immediately free the
+ * dentry and inode afterwards since the pidfd has been closed. Since
+ * pidfs_exit() currently is placed after exit_task_work() we know that
+ * it cannot be us aka the exiting task holding a pidfd to ourselves.
+ */
+void pidfs_exit(struct task_struct *tsk)
+{
+	struct dentry *dentry;
+
+	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
+	if (dentry) {
+		struct inode *inode;
+		struct pidfs_exit_info *exit_info;
+#ifdef CONFIG_CGROUPS
+		struct cgroup *cgrp;
+#endif
+		inode = d_inode(dentry);
+		exit_info = &pidfs_i(inode)->exit_info;
+
+		/* TODO: Annoy Oleg to tell me how to do this correctly. */
+		if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+			exit_info->exit_code = tsk->signal->group_exit_code;
+		else
+			exit_info->exit_code = tsk->exit_code;
+
+#ifdef CONFIG_CGROUPS
+		rcu_read_lock();
+		cgrp = task_dfl_cgroup(tsk);
+		exit_info->cgroupid = cgroup_id(cgrp);
+		rcu_read_unlock();
+#endif
+
+		dput(dentry);
+	}
+}
+
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
 /*
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 7c830d0dec9a..05e6f8f4a026 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -6,6 +6,7 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
+void pidfs_exit(struct task_struct *tsk);
 extern const struct dentry_operations pidfs_dentry_operations;
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 3485e5fc499e..cae475e7858c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -69,6 +69,7 @@
 #include <linux/sysfs.h>
 #include <linux/user_events.h>
 #include <linux/uaccess.h>
+#include <linux/pidfs.h>
 
 #include <uapi/linux/wait.h>
 
@@ -948,6 +949,7 @@ void __noreturn do_exit(long code)
 
 	sched_autogroup_exit_task(tsk);
 	cgroup_exit(tsk);
+	pidfs_exit(tsk);
 
 	/*
 	 * FIXME: do that only when needed, using sched_exit tracepoint

-- 
2.47.2


