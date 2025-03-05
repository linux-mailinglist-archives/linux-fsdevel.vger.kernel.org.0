Return-Path: <linux-fsdevel+bounces-43226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AE0A4FB47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB09188D675
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E16B2066C8;
	Wed,  5 Mar 2025 10:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyZFrUB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06291FC7FA
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169321; cv=none; b=o3MWL2EoZwa4HRSER7XjXp2oiaq49aqQT+bxBbJs3ly74buZ9zHgmnqjW+tSKlfGAqfS/rE53Nia6oDZaGZRDHdRoOEwnhnAkCZB86sm33aibmeQVl12YkDUD0TBMDZ7CCswaOAzye/kVeHCXYjntAMsZEkv3vWHYstb1vAhp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169321; c=relaxed/simple;
	bh=MU9P1LuAS44Pqncz+mL3Fa55AI+n2W090XTUwfkKvik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QoqOLOOhv55AxcB3M7FAnl9FuYIa0K2iDYXR86sAlbIdQNG1TWNqko93utAfxpiDCtF5i9A1oIh7bcjMmTA4Ev71pwKZzIFxnO0ofOzd97XhK09PR0oQBdt4VIsrMycdaeDDcEyQmAWNV8TQ+pld/movRs3WC97uOBztB40u9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyZFrUB2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC532C4CEEB;
	Wed,  5 Mar 2025 10:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169319;
	bh=MU9P1LuAS44Pqncz+mL3Fa55AI+n2W090XTUwfkKvik=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DyZFrUB23pwK/5URRcu1Zah/5wlf6EnTh7Uy6tD7Ly94VgjPr4B6eotvQv7i/e+Ng
	 2O7FzEz6VLEikjcaCEUsV/xR5j1t9XydnlrGanX0c1kATMTWmbL7p652rNVqcmHQxl
	 bWYgc9UN8BxhTy1R/fDcNgvJv2U4hSHe8agNXNt5rnP8z8TNY6GM8gruDBhUIE2BC/
	 NLizSIpYolWdB0BBkAU7jGWld04jOSYExrQuNsZhyDI/RMlV5lG3y4fPrkDUvvp7jW
	 ciqCqTy8t87hCfRF1O0ItR/PA4Xh2DLoLmUR+T8eqJ9d38FsgKl2jENAQ05cHcPayA
	 np2mmmW0YohqA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:16 +0100
Subject: [PATCH v3 06/16] pidfs: allow to retrieve exit information
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-6-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6403; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MU9P1LuAS44Pqncz+mL3Fa55AI+n2W090XTUwfkKvik=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJrRxHG/Sn7Z1BkBZ8y5Q85+DG/l/NV1/UuyWmHh9
 zthn9uXd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykjoOR4Z74sf7ZL12WnVPL
 V9EwOMYpcbpqdpfsn68r5F+LOEUF5jEybLEKecjKpZ++UvbJ1lXJD0W2qV/8pPp/8rUJ029+Obg
 kmQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Some tools like systemd's jounral need to retrieve the exit and cgroup
information after a process has already been reaped. This can e.g.,
happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 86 ++++++++++++++++++++++++++++++++++++----------
 include/uapi/linux/pidfd.h |  3 +-
 2 files changed, 70 insertions(+), 19 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c4e6527013e7..3c630e9d4a62 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -36,7 +36,8 @@ struct pidfs_exit_info {
 };
 
 struct pidfs_inode {
-	struct pidfs_exit_info exit_info;
+	struct pidfs_exit_info __pei;
+	struct pidfs_exit_info *exit_info;
 	struct inode vfs_inode;
 };
 
@@ -228,17 +229,28 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
-static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
+static inline bool pid_in_current_pidns(const struct pid *pid)
+{
+	const struct pid_namespace *ns = task_active_pid_ns(current);
+
+	if (ns->level <= pid->level)
+		return pid->numbers[ns->level].ns == ns;
+
+	return false;
+}
+
+static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
+	struct inode *inode = file_inode(file);
+	struct pid *pid = pidfd_pid(file);
 	size_t usize = _IOC_SIZE(cmd);
 	struct pidfd_info kinfo = {};
+	struct pidfs_exit_info *exit_info;
 	struct user_namespace *user_ns;
+	struct task_struct *task;
 	const struct cred *c;
 	__u64 mask;
-#ifdef CONFIG_CGROUPS
-	struct cgroup *cgrp;
-#endif
 
 	if (!uinfo)
 		return -EINVAL;
@@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
 		return -EFAULT;
 
+	/*
+	 * Restrict information retrieval to tasks within the caller's pid
+	 * namespace hierarchy.
+	 */
+	if (!pid_in_current_pidns(pid))
+		return -ESRCH;
+
+	if (mask & PIDFD_INFO_EXIT) {
+		exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
+		if (exit_info) {
+			kinfo.mask |= PIDFD_INFO_EXIT;
+#ifdef CONFIG_CGROUPS
+			kinfo.cgroupid = exit_info->cgroupid;
+			kinfo.mask |= PIDFD_INFO_CGROUPID;
+#endif
+			kinfo.exit_code = exit_info->exit_code;
+		}
+	}
+
+	task = get_pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		/*
+		 * If the task has already been reaped, only exit
+		 * information is available
+		 */
+		if (!(mask & PIDFD_INFO_EXIT))
+			return -ESRCH;
+
+		goto copy_out;
+	}
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
@@ -267,11 +310,15 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	put_cred(c);
 
 #ifdef CONFIG_CGROUPS
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(task);
-	kinfo.cgroupid = cgroup_id(cgrp);
-	kinfo.mask |= PIDFD_INFO_CGROUPID;
-	rcu_read_unlock();
+	if (!kinfo.cgroupid) {
+		struct cgroup *cgrp;
+
+		rcu_read_lock();
+		cgrp = task_dfl_cgroup(task);
+		kinfo.cgroupid = cgroup_id(cgrp);
+		kinfo.mask |= PIDFD_INFO_CGROUPID;
+		rcu_read_unlock();
+	}
 #endif
 
 	/*
@@ -291,6 +338,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
 		return -ESRCH;
 
+copy_out:
 	/*
 	 * If userspace and the kernel have the same struct size it can just
 	 * be copied. If userspace provides an older struct, only the bits that
@@ -325,7 +373,6 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
-	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
 	struct pid_namespace *pid_ns;
 
@@ -340,13 +387,13 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return put_user(file_inode(file)->i_generation, argp);
 	}
 
-	task = get_pid_task(pid, PIDTYPE_PID);
-	if (!task)
-		return -ESRCH;
-
 	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
 	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
-		return pidfd_info(task, cmd, arg);
+		return pidfd_info(file, cmd, arg);
+
+	task = get_pid_task(pidfd_pid(file), PIDTYPE_PID);
+	if (!task)
+		return -ESRCH;
 
 	if (arg)
 		return -EINVAL;
@@ -484,7 +531,7 @@ void pidfs_exit(struct task_struct *tsk)
 	dentry = stashed_dentry_get(&task_pid(tsk)->stashed);
 	if (dentry) {
 		struct inode *inode = d_inode(dentry);
-		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->exit_info;
+		struct pidfs_exit_info *exit_info = &pidfs_i(inode)->__pei;
 #ifdef CONFIG_CGROUPS
 		struct cgroup *cgrp;
 
@@ -495,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
 #endif
 		exit_info->exit_code = tsk->exit_code;
 
+		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
+		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
 		dput(dentry);
 	}
 }
@@ -562,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
 	if (!pi)
 		return NULL;
 
-	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
+	memset(&pi->__pei, 0, sizeof(pi->__pei));
+	pi->exit_info = NULL;
 
 	return &pi->vfs_inode;
 }
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index e0abd0b18841..5cd5dcbfe884 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -20,6 +20,7 @@
 #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
+#define PIDFD_INFO_EXIT			(1UL << 3) /* Only returned if requested. */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 
@@ -86,7 +87,7 @@ struct pidfd_info {
 	__u32 sgid;
 	__u32 fsuid;
 	__u32 fsgid;
-	__u32 spare0[1];
+	__s32 exit_code;
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF

-- 
2.47.2


