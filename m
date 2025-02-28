Return-Path: <linux-fsdevel+bounces-42849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D97F4A499AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D915817302B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C1926BD8F;
	Fri, 28 Feb 2025 12:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrAojW4p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0690626B966
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746673; cv=none; b=hOa+yPg4Wr4KhSy3ahXffRLjYwTKpvjwyXVGuryT3YTBZo2WMZqBckNam0tvI7kuGbbKcE7IdHLHmwS4eNYyfIYAPp37Xu/HcQ8msMRTZebCbVAcvYiHiP4Yoyr7Y5XXNyh1PvvHo+2KWxJZu/vJ7djLg2Phrp4Qu0wVdM9EOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746673; c=relaxed/simple;
	bh=zSf5I/rkkApHBPJh7QzGwiMekGpq1+7N8GRWK2zaElA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pKgILcjgKR1n/QgqvFu57o5VG/MHw9ntHNviF93vIfsOsK5w3hqHXvFPADPjlcXLmp012OdhokSC/s0z24ZDyZGwtXu7LDhZ1N+Pctoud0O1iyhy41dol0p1A9klOA8tN6DP9xqVVivUyPqGTXy9Hfl11N3hwC6ddzvti9VKcGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrAojW4p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137DFC4CEE9;
	Fri, 28 Feb 2025 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746672;
	bh=zSf5I/rkkApHBPJh7QzGwiMekGpq1+7N8GRWK2zaElA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NrAojW4pKSRHVghGLXbjZjuVoDA5/fF6gFU8yB48UeXEi2I1xS5xjWh0WWx73TOPv
	 2PaI4HaumTIL47090Pss5S9SE3K5PlDix8YRgrK4NUxTZ1xJAkvCSda8or9/Er8KwT
	 y+sJwV6FGUxS20wK18OvCr3clOF3K7xjONxMsXWPriXwx9yojsAtvYV/R7o7e0lwol
	 1S4lhUeWKW55i5A4rKyF5J7UwmVbOsngUxImxljDuVR7GnhyUkGS9ONis8suwYUTRt
	 dzZn1GJJJg0PfNiIDQwGZMofp999qc3vRS+aUw9k0OimY/nwMhUDmMeRCxfExykj7r
	 BBf0Dx9/qHvlQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:06 +0100
Subject: [PATCH RFC 06/10] pidfs: allow to retrieve exit information
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-6-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=6043; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zSf5I/rkkApHBPJh7QzGwiMekGpq1+7N8GRWK2zaElA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL/o+9TiHhWj9bySfCo8y9wFVlT/fXRoavn8RtdgW
 davT58f6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI2ShGhhWF4t8WZSs/sHs3
 s+Tz4WtXjgZ0WfBE9vZ9mP5u2v9yh1qG36xzd3Ou8/G7846nY+dTgYjvy79sepFyudDshMSGyBd
 F77kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Some tools like systemd's jounral need to retrieve the exit and cgroup
information after a process has already been reaped. This can e.g.,
happen when retrieving a pidfd via SCM_PIDFD or SCM_PEERPIDFD.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 70 +++++++++++++++++++++++++++++++++++++---------
 include/uapi/linux/pidfd.h |  3 +-
 2 files changed, 59 insertions(+), 14 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 433f676c066c..e500bc4c5af2 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -32,11 +32,12 @@ static struct kmem_cache *pidfs_cachep __ro_after_init;
  */
 struct pidfs_exit_info {
 	__u64 cgroupid;
-	__u64 exit_code;
+	__s32 exit_code;
 };
 
 struct pidfs_inode {
-	struct pidfs_exit_info exit_info;
+	struct pidfs_exit_info __pei;
+	struct pidfs_exit_info *exit_info;
 	struct inode vfs_inode;
 };
 
@@ -228,11 +229,14 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
-static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long arg)
+static long pidfd_info(struct file *file, struct task_struct *task,
+		       unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
 	size_t usize = _IOC_SIZE(cmd);
 	struct pidfd_info kinfo = {};
+	struct pidfs_exit_info *exit_info;
+	struct inode *inode = file_inode(file);
 	struct user_namespace *user_ns;
 	const struct cred *c;
 	__u64 mask;
@@ -248,6 +252,39 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
 		return -EFAULT;
 
+	exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
+	if (exit_info) {
+		/*
+		 * TODO: Oleg, I didn't see a reason for putting
+		 * retrieval of the exit status of a task behind some
+		 * form of permission check. Maybe there's some
+		 * potential concerns with seeing the exit status of a
+		 * SIGKILLed suid binary or something but even then I'm
+		 * not sure that's a problem.
+		 *
+		 * If we want this we could put this behind some *uid
+		 * check similar to what ptrace access does by recording
+		 * parts of the creds we'd need for checking this. But
+		 * only if we really need it.
+		 */
+		kinfo.exit_code = exit_info->exit_code;
+#ifdef CONFIG_CGROUPS
+		kinfo.cgroupid = exit_info->cgroupid;
+		kinfo.mask |= PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
+#endif
+	}
+
+	/*
+	 * If the task has already been reaped only exit information
+	 * can be provided. It's entirely possible that the task has
+	 * already been reaped but we managed to grab a reference to it
+	 * before that. So a full set of information about @task doesn't
+	 * mean it hasn't been waited upon. Similarly, a full set of
+	 * information doesn't mean that the task hasn't already exited.
+	 */
+	if (!task)
+		goto copy_out;
+
 	c = get_task_cred(task);
 	if (!c)
 		return -ESRCH;
@@ -267,11 +304,13 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	put_cred(c);
 
 #ifdef CONFIG_CGROUPS
-	rcu_read_lock();
-	cgrp = task_dfl_cgroup(task);
-	kinfo.cgroupid = cgroup_id(cgrp);
-	kinfo.mask |= PIDFD_INFO_CGROUPID;
-	rcu_read_unlock();
+	if (!kinfo.cgroupid) {
+		rcu_read_lock();
+		cgrp = task_dfl_cgroup(task);
+		kinfo.cgroupid = cgroup_id(cgrp);
+		kinfo.mask |= PIDFD_INFO_CGROUPID;
+		rcu_read_unlock();
+	}
 #endif
 
 	/*
@@ -291,6 +330,7 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
 	if (kinfo.pid == 0 || kinfo.tgid == 0 || (kinfo.ppid == 0 && kinfo.pid != 1))
 		return -ESRCH;
 
+copy_out:
 	/*
 	 * If userspace and the kernel have the same struct size it can just
 	 * be copied. If userspace provides an older struct, only the bits that
@@ -341,12 +381,13 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	task = get_pid_task(pid, PIDTYPE_PID);
-	if (!task)
-		return -ESRCH;
 
 	/* Extensible IOCTL that does not open namespace FDs, take a shortcut */
 	if (_IOC_NR(cmd) == _IOC_NR(PIDFD_GET_INFO))
-		return pidfd_info(task, cmd, arg);
+		return pidfd_info(file, task, cmd, arg);
+
+	if (!task)
+		return -ESRCH;
 
 	if (arg)
 		return -EINVAL;
@@ -486,7 +527,7 @@ void pidfs_exit(struct task_struct *tsk)
 		struct cgroup *cgrp;
 #endif
 		inode = d_inode(dentry);
-		exit_info = &pidfs_i(inode)->exit_info;
+		exit_info = &pidfs_i(inode)->__pei;
 
 		/* TODO: Annoy Oleg to tell me how to do this correctly. */
 		if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
@@ -501,6 +542,8 @@ void pidfs_exit(struct task_struct *tsk)
 		rcu_read_unlock();
 #endif
 
+		/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
+		smp_store_release(&pidfs_i(inode)->exit_info, &pidfs_i(inode)->__pei);
 		dput(dentry);
 	}
 }
@@ -568,7 +611,8 @@ static struct inode *pidfs_alloc_inode(struct super_block *sb)
 	if (!pi)
 		return NULL;
 
-	memset(&pi->exit_info, 0, sizeof(pi->exit_info));
+	memset(&pi->__pei, 0, sizeof(pi->__pei));
+	pi->exit_info = NULL;
 
 	return &pi->vfs_inode;
 }
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index e0abd0b18841..e5966f1a7743 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -20,6 +20,7 @@
 #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
 #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
+#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
 
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


