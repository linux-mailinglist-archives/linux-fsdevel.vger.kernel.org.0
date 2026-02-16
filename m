Return-Path: <linux-fsdevel+bounces-77291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCAtKMUdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77291-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:38:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DF143E62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD121300EFBC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F52EE607;
	Mon, 16 Feb 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD+Lt3r5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381E12309B9;
	Mon, 16 Feb 2026 13:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771249086; cv=none; b=ld6earGfl5LAeX+9fgGqIWtenK+ra6X48JUyvpll5+qWvlVjppluPcew1qxqpqkfavPsA9/eae81PadbmCVOBMM9r3w+VUoTxeWPYt4tRR8sOvlUvr2Mfvaou1boTJMu0auCPlyQQwJdpwYdeXYFp9yne2tYRdvriiiqOma4eY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771249086; c=relaxed/simple;
	bh=u0vkx9hJ4IY71G3Mcv1iREEN1uFMoXZT/MgnLs13by4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B3+8lFmUJsr//Xs6Qp9kayhod95xeoIpT9Zd5lGmD7ryzwi+39t+BFfqzETeaAV5kGMjNu38dJfMmLJB/Z5AztBUhOIMNcCIQ4Axjucu4f4mvBpHbjZ1VWcpt0aPUwika+m4fkiYcceHmtFLjxbSCWLkY/PTEtTOvtaGciJMifI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD+Lt3r5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A7EC116C6;
	Mon, 16 Feb 2026 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771249085;
	bh=u0vkx9hJ4IY71G3Mcv1iREEN1uFMoXZT/MgnLs13by4=;
	h=From:Date:Subject:To:Cc:From;
	b=nD+Lt3r5nPw4lGyKUCGAkihXhKI6n7s0/XEdA0yW6J8SgA3ZFGoYLUxBDhYZ/2dOt
	 uQGLTyr9oiXfVconsXc2rMBEWkhkIbGme7HDKtV5RMx2nONUSh2jkvX0ku+oDWkR+y
	 4uKspwzRy4ijpjgQZoQHpaju2NB/v5BRyH2hwI3BFjk/SmOJG7O7sX7qg12K+XBDP4
	 0+sjC/Ff0mXRfhM2aVRsQVmxoVpUpuORwHsWTkkdSR2uKMJN9DanreGTZ5nh5xkIrx
	 kN5s4cI00MoecdxaEl/H+20VXqB0Slrray5S/2u66kSGM8yZ5+/H71HNKRSfI9baiu
	 Ip3v6amL8bkaw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:37:42 +0100
Subject: [PATCH RFC] pidfs: add inode ownership and permission checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-pidfs-inode-owner-v1-1-f8faa6b73983@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKUdk2kC/x2MywrCMBAAf0X2bGSzaVLqVfADvIqHPDY2iGlJx
 Aql/270OAMzK1QuiSscdysUfqeaptxA7nfgR5vvLFJoDIRkkKQUy1QeYk4hVpHyFFhMS+Yi0Fv
 CwANHUtDiuXBMn//4CpfzCW5NOltZuGKzH3/Pp60vLoeevBo0Uhes10xSS2W8i7EfVKd1RKMNK
 ocGtu0LCQPzXa8AAAA=
X-Change-ID: 20260211-work-pidfs-inode-owner-0ca20de9ef23
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9532; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u0vkx9hJ4IY71G3Mcv1iREEN1uFMoXZT/MgnLs13by4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlt29VYT91ZOpSW1PNDi9Ek9Ghm7ZbCfke7QuQNjvT
 9HsaqeOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIksKmVk2C7qF3gg6Y2QhhNL
 Xcm5G+/3BezS0/dTau9mTt1QfE/QhJHhpbAj4/uy3+dd4jYdfvvIqadz+enuz/+/Cex3S6+xdMr
 lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-77291-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 032DF143E62
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

Note that I explicitly avoid just writing to the inode during getattr()
or similar operations to update it. Some filesystems do this but this is
just terrible as this doesn't serialize against inode->i_op->seattr:: at
all. I have a patch series that uses seqcounts to make it possible to
serialize such users against inode->i_op->setattr:: but it's not really
that much of a pressing need. But fwiw [1].

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
Hey Jann,
hey Andy,

It would be nice if you could take a look at the permission model.
This is the first thing that came to my mind and I wrote it down so we
have something to look at.

Thanks!
Christian
---
 fs/pidfs.c           | 107 +++++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/cred.h |   2 +
 kernel/signal.c      |  19 +++++----
 3 files changed, 113 insertions(+), 15 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1e20e36e0ed5..da9d18fa5425 100644
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
@@ -44,15 +45,23 @@ enum pidfs_attr_mask_bits {
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
 
 static struct rb_root pidfs_ino_tree = RB_ROOT;
@@ -169,6 +178,7 @@ void pidfs_free_pid(struct pid *pid)
 	if (IS_ERR(attr))
 		return;
 
+	put_cred(attr->exit_cred);
 	xattrs = no_free_ptr(attr->xattrs);
 	if (xattrs)
 		simple_xattrs_free(xattrs, NULL);
@@ -678,6 +688,8 @@ void pidfs_exit(struct task_struct *tsk)
 	attr->cgroupid = cgroup_id(cgrp);
 	rcu_read_unlock();
 #endif
+	attr->exit_cred = get_cred(__task_cred(tsk));
+	attr->exit_tgid_ino = task_tgid(tsk)->ino;
 	attr->exit_code = tsk->exit_code;
 
 	/* Ensure that PIDFD_GET_INFO sees either all or nothing. */
@@ -710,6 +722,55 @@ void pidfs_coredump(const struct coredump_params *cprm)
 
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
+/*
+ * Fill in the effective {u,g}id of the task referred to by the pidfs
+ * inode. The task's credentials may change due to setuid(), etc.
+ */
+static void pidfs_fill_owner(struct inode *inode, kuid_t *uid, kgid_t *gid)
+{
+	struct pid *pid = inode->i_private;
+
+	VFS_WARN_ON_ONCE(!pid);
+
+	scoped_guard(rcu) {
+		struct task_struct *task;
+
+		task = pid_task(pid, PIDTYPE_PID);
+		if (!task) {
+			struct pidfs_attr *attr = READ_ONCE(pid->attr);
+
+			VFS_WARN_ON_ONCE(!attr);
+			*uid = attr->exit_cred->euid;
+			*gid = attr->exit_cred->egid;
+		} else if (unlikely(task->flags & PF_KTHREAD)) {
+			*uid = GLOBAL_ROOT_UID;
+			*gid = GLOBAL_ROOT_GID;
+		} else {
+			const struct cred *cred = __task_cred(task);
+
+			*uid = cred->euid;
+			*gid = cred->egid;
+		}
+	}
+}
+
+/*
+ * Set pidfs inode ownership and security label. Called once when the
+ * dentry is first stashed.
+ */
+static void pidfs_update_inode(struct inode *inode)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+
+	pidfs_fill_owner(inode, &inode->i_uid, &inode->i_gid);
+
+	guard(rcu)();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (task)
+		security_task_to_inode(task, inode);
+}
+
 /*
  * The vfs falls back to simple_setattr() if i_op->setattr() isn't
  * implemented. Let's reject it completely until we have a clean
@@ -725,7 +786,11 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
 {
-	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
+	struct inode *inode = d_inode(path->dentry);
+
+	anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
+	pidfs_fill_owner(inode, &stat->uid, &stat->gid);
+	return 0;
 }
 
 static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
@@ -742,10 +807,37 @@ static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
 	return simple_xattr_list(inode, xattrs, buf, size);
 }
 
+static int pidfs_permission(struct mnt_idmap *idmap, struct inode *inode,
+			    int mask)
+{
+	struct pid *pid = inode->i_private;
+	struct pidfs_attr *attr = pid->attr;
+
+	VFS_WARN_ON_ONCE(idmap != &nop_mnt_idmap);
+
+	scoped_guard(rcu) {
+		struct task_struct *task;
+
+		task = pid_task(pid, PIDTYPE_PID);
+		if (task) {
+			if (!same_thread_group(current, task) &&
+			    !may_signal_creds(current_cred(), __task_cred(task)))
+				return -EPERM;
+		} else {
+			if (task_tgid(current)->ino != attr->exit_tgid_ino &&
+			    !may_signal_creds(current_cred(), attr->exit_cred))
+				return -EPERM;
+		}
+	}
+
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
@@ -978,6 +1070,7 @@ static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 	if (ret)
 		return ERR_PTR(ret);
 
+	pidfs_update_inode(d_inode(dentry));
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
index e42b8bd6922f..9182d1ad19b7 100644
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

---
base-commit: 72c395024dac5e215136cbff793455f065603b06
change-id: 20260211-work-pidfs-inode-owner-0ca20de9ef23


