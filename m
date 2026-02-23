Return-Path: <linux-fsdevel+bounces-77933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEkJJyZUnGktDwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB100176B11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 098633003715
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5C91F3BAC;
	Mon, 23 Feb 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOamIrlZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5241E5714;
	Mon, 23 Feb 2026 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852818; cv=none; b=UEo5yl9iAJnAobe7EzeehvcK6ag+xL7Xq0Ewz58tIryUmgUmT5b9Vk+juvFy28Kd8itvAcD9UlpNFd3rLY0j4Mw1ENXhC40+zS/84wGE4WIkCTbpqFEBC1ir+6aR//xfWtq3oS51HJiaNhC74C1eveoOLHmZhCajxlFbFk8Wy0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852818; c=relaxed/simple;
	bh=+qgQYnwfB2gngyjRy2a9+KA/iJByrUnbrOUc+xPRuaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nnkvl8PPiBg46GAVpZZJEseXWT5DuSwRvMXAh53BjPliFhyAE/vq2twJ/ilWiDJmU4theFy2O0WJ7qMOzVQVpNGqtep9qcvpofneb6eu2BpYcL/6JSQXlrCDcYVwZQgRGXB+jlA4qEbmXhTneFb8MsqzNxGh1lMpKZs9EzXLXG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOamIrlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C267C116C6;
	Mon, 23 Feb 2026 13:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771852818;
	bh=+qgQYnwfB2gngyjRy2a9+KA/iJByrUnbrOUc+xPRuaY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VOamIrlZrX/1NtIBpnwiuMz1jeyJb2HiwGEitbvg5HiLv1oFN8W6wGnTkGqiNOjeH
	 MVjJHz3eWxiNQth/Zpr8GCmwYN8GogEU+alF6ZmR9E1Rst5sXjrZOTJ3tR/8ZWlYxF
	 x/sanBlO2leCdO8N3XrEcfENbQlwmpFL1/kbd9TxV191njZYvcx7ClqinORVQ0V0BL
	 3nru7bCjFyNM72OJ31owuDZutXXvQQZGyZRHV4Hw7yNfvPi7IjDjnqcZD3NZM3Ulk8
	 NISToIpUp51Kb2IGAdnNVN0LwyUP59IVlxlaQQWKOmS7d+Yk1TS8G6SejHiTctiavs
	 f1FVRcLjVNSDQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Feb 2026 14:20:08 +0100
Subject: [PATCH RFC v3 1/2] pidfs: add inode ownership and permission
 checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-work-pidfs-inode-owner-v3-1-490855c59999@kernel.org>
References: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
In-Reply-To: <20260223-work-pidfs-inode-owner-v3-0-490855c59999@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=10071; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+qgQYnwfB2gngyjRy2a9+KA/iJByrUnbrOUc+xPRuaY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOCeFrsX3H/ZWld+Yq//sz1JIF/j3fLFPPumtncdyn+
 1nMZs2MHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPpfsjwv2byUo243eX33HbV
 dhzefJBLcUnNticrN58rW3QmefqBPzWMDMvFH/K8sAiZ1Oq+eNH0pR6aPNFikyc3L6p786yj2WB
 lPSsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77933-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AB100176B11
X-Rspamd-Action: no action

Right now we only support trusted.* xattrs which require CAP_SYS_ADMIN
which doesn't really require any meaningful permission checking. But in
order to support user.* xattrs and custom pidfs.* xattrs in the future
we need permission checking for pidfs inodes. Add baseline permission
checking that can later be extended with additional write-time checks
for specific pidfs.* xattrs.

Make the effective {u,g}id of the task the owner of the pidfs inode
(like procfs does). The ownership is set when the dentry is first
stashed and reported dynamically via getattr since credentials may
change due to setuid() and similar operations. For kernel threads use
root, for exited tasks use the credentials saved at exit time.

The inode's ownership is updated via WRITE_ONCE() from the getattr()
and permission() callbacks. This doesn't serialize against
inode->i_op->setattr() but since pidfs rejects setattr() this isn't
currently an issue. A seqcount-based approach can be used if setattr()
support is added in the future [1].

Save the task's credentials and thread group pid inode number at exit
time so that ownership and permission checks remain functional after
the task has been reaped.

Add a permission callback that checks access in two steps:

 (1) Verify the caller is either in the same thread group as the target
     or has equivalent signal permissions. This reuses the same
     uid-based logic as kill() by extracting may_signal_creds() from
     kill_ok_by_cred() so it can operate on credential pointers
     directly. For exited tasks the check uses the saved exit
     credentials and compares thread group identity.

 (2) Perform standard POSIX permission checking via generic_permission()
     against the inode's ownership and mode bits.

This is intentionally less strict than ptrace_may_access() because pidfs
currently does not allow operating on data that is completely private to
the process such as its mm or file descriptors. Additional checks will
be needed once that changes.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.inode.seqcount [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c           | 133 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/cred.h |   2 +
 kernel/signal.c      |  19 ++++----
 3 files changed, 136 insertions(+), 18 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..16a3cfa84af4 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -14,6 +14,7 @@
 #include <linux/proc_ns.h>
 #include <linux/pseudo_fs.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 #include <linux/seq_file.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/ipc_namespace.h>
@@ -46,15 +47,23 @@ enum pidfs_attr_mask_bits {
 	PIDFS_ATTR_BIT_COREDUMP	= 1,
 };
 
+struct pidfs_exit_attr {
+	__u64 cgroupid;
+	__s32 exit_code;
+	const struct cred *exit_cred;
+	u64 exit_tgid_ino;
+};
+
+struct pidfs_coredump_attr {
+	__u32 coredump_mask;
+	__u32 coredump_signal;
+};
+
 struct pidfs_attr {
 	unsigned long attr_mask;
 	struct simple_xattrs *xattrs;
-	struct /* exit info */ {
-		__u64 cgroupid;
-		__s32 exit_code;
-	};
-	__u32 coredump_mask;
-	__u32 coredump_signal;
+	struct pidfs_exit_attr;
+	struct pidfs_coredump_attr;
 };
 
 static struct rhashtable pidfs_ino_ht;
@@ -200,6 +209,7 @@ void pidfs_free_pid(struct pid *pid)
 	if (IS_ERR(attr))
 		return;
 
+	put_cred(attr->exit_cred);
 	xattrs = no_free_ptr(attr->xattrs);
 	if (xattrs)
 		simple_xattrs_free(xattrs, NULL);
@@ -703,12 +713,14 @@ void pidfs_exit(struct task_struct *tsk)
 	 * is put
 	 */
 
-#ifdef CONFIG_CGROUPS
 	rcu_read_lock();
+#ifdef CONFIG_CGROUPS
 	cgrp = task_dfl_cgroup(tsk);
 	attr->cgroupid = cgroup_id(cgrp);
-	rcu_read_unlock();
 #endif
+	attr->exit_cred = get_cred(__task_cred(tsk));
+	rcu_read_unlock();
+	attr->exit_tgid_ino = task_tgid(tsk)->ino;
 	attr->exit_code = tsk->exit_code;
 
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
@@ -741,6 +753,47 @@ void pidfs_coredump(const struct coredump_params *cprm)
 
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
+static void pidfs_update_owner(struct inode *inode)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+	const struct cred *cred;
+	kuid_t kuid;
+	kgid_t kgid;
+
+	VFS_WARN_ON_ONCE(!pid);
+
+	guard(rcu)();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (!task) {
+		struct pidfs_attr *attr = READ_ONCE(pid->attr);
+
+		VFS_WARN_ON_ONCE(!attr);
+		/*
+		 * During copy_process() with CLONE_PIDFD the
+		 * task hasn't been attached to the pid yet so
+		 * pid_task() returns NULL and there's no
+		 * exit_cred as the task obviously hasn't
+		 * exited. Use the parent's credentials.
+		 */
+		cred = attr->exit_cred;
+		if (!cred)
+			cred = current_cred();
+		kuid = cred->euid;
+		kgid = cred->egid;
+	} else if (unlikely(task->flags & PF_KTHREAD)) {
+		kuid = GLOBAL_ROOT_UID;
+		kgid = GLOBAL_ROOT_GID;
+	} else {
+		cred = __task_cred(task);
+		kuid = cred->euid;
+		kgid = cred->egid;
+	}
+
+	WRITE_ONCE(inode->i_uid, kuid);
+	WRITE_ONCE(inode->i_gid, kgid);
+}
+
 /*
  * The vfs falls back to simple_setattr() if i_op->setattr() isn't
  * implemented. Let's reject it completely until we have a clean
@@ -756,7 +809,11 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
 {
-	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
+	struct inode *inode = d_inode(path->dentry);
+
+	pidfs_update_owner(inode);
+	anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
+	return 0;
 }
 
 static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
@@ -773,10 +830,64 @@ static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
 	return simple_xattr_list(inode, xattrs, buf, size);
 }
 
+static int pidfs_permission(struct mnt_idmap *idmap, struct inode *inode,
+			    int mask)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+	const struct cred *cred;
+	u64 pid_tg_ino;
+
+	scoped_guard(rcu) {
+		task = pid_task(pid, PIDTYPE_PID);
+		if (task) {
+			if (unlikely(task->flags & PF_KTHREAD))
+				return -EPERM;
+
+			cred = __task_cred(task);
+			pid_tg_ino = task_tgid(task)->ino;
+		} else {
+			struct pidfs_attr *attr;
+
+			attr = READ_ONCE(pid->attr);
+			VFS_WARN_ON_ONCE(!attr);
+			/*
+			 * During copy_process() with CLONE_PIDFD the
+			 * task hasn't been attached to the pid yet so
+			 * pid_task() returns NULL and there's no
+			 * exit_cred as the task obviously hasn't
+			 * exited. Use the parent's credentials.
+			 */
+			cred = attr->exit_cred;
+			if (!cred)
+				cred = current_cred();
+			pid_tg_ino = attr->exit_tgid_ino;
+		}
+
+		/*
+		 * If the caller and the target are in the same
+		 * thread-group or the caller can signal the target
+		 * we're good.
+		 */
+		if (pid_tg_ino != task_tgid(current)->ino &&
+		    !may_signal_creds(current_cred(), cred))
+			return -EPERM;
+
+		/*
+		 * This is racy but not more racy then what we generally
+		 * do for permission checking.
+		 */
+		WRITE_ONCE(inode->i_uid, cred->euid);
+		WRITE_ONCE(inode->i_gid, cred->egid);
+	}
+	return generic_permission(&nop_mnt_idmap, inode, mask);
+}
+
 static const struct inode_operations pidfs_inode_operations = {
 	.getattr	= pidfs_getattr,
 	.setattr	= pidfs_setattr,
 	.listxattr	= pidfs_listxattr,
+	.permission	= pidfs_permission,
 };
 
 static void pidfs_evict_inode(struct inode *inode)
@@ -983,7 +1094,8 @@ static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 					 struct dentry *dentry)
 {
 	int ret;
-	struct pid *pid = d_inode(dentry)->i_private;
+	struct inode *inode = d_inode(dentry);
+	struct pid *pid = inode->i_private;
 
 	VFS_WARN_ON_ONCE(stashed != &pid->stashed);
 
@@ -991,6 +1103,7 @@ static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 	if (ret)
 		return ERR_PTR(ret);
 
+	pidfs_update_owner(inode);
 	return stash_dentry(stashed, dentry);
 }
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index ed1609d78cd7..d14b29fe9fee 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -168,6 +168,8 @@ extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
 extern int set_cred_ucounts(struct cred *);
+bool may_signal_creds(const struct cred *signaler_cred,
+		      const struct cred *signalee_cred);
 
 static inline bool cap_ambient_invariant_ok(const struct cred *cred)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index d65d0fe24bfb..e20dabf143c2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -777,19 +777,22 @@ static inline bool si_fromuser(const struct kernel_siginfo *info)
 		(!is_si_special(info) && SI_FROMUSER(info));
 }
 
+bool may_signal_creds(const struct cred *signaler_cred,
+		      const struct cred *signalee_cred)
+{
+	return uid_eq(signaler_cred->euid, signalee_cred->suid) ||
+	       uid_eq(signaler_cred->euid, signalee_cred->uid) ||
+	       uid_eq(signaler_cred->uid, signalee_cred->suid) ||
+	       uid_eq(signaler_cred->uid, signalee_cred->uid) ||
+	       ns_capable(signalee_cred->user_ns, CAP_KILL);
+}
+
 /*
  * called with RCU read lock from check_kill_permission()
  */
 static bool kill_ok_by_cred(struct task_struct *t)
 {
-	const struct cred *cred = current_cred();
-	const struct cred *tcred = __task_cred(t);
-
-	return uid_eq(cred->euid, tcred->suid) ||
-	       uid_eq(cred->euid, tcred->uid) ||
-	       uid_eq(cred->uid, tcred->suid) ||
-	       uid_eq(cred->uid, tcred->uid) ||
-	       ns_capable(tcred->user_ns, CAP_KILL);
+	return may_signal_creds(current_cred(), __task_cred(t));
 }
 
 /*

-- 
2.47.3


