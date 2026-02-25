Return-Path: <linux-fsdevel+bounces-78413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB9uLnKEn2mVcgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2712B19EC27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 00:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39ED43072DB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Feb 2026 23:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BB0377556;
	Wed, 25 Feb 2026 23:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nY482vpc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F93815EF;
	Wed, 25 Feb 2026 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061775; cv=none; b=UuK+gcenMbWGsusTjzrjlwdc2yHEks6vTzXAwfz3tspaNLAtLkT2BXjfn19Pd8l9z7dRW9hXRbARp0uEVotdUt713bSuPVaiAuQOaltGfeEYz8RZMWgTZnw1HJWUbR8fG9bIJZsenPa/z6Byp8QgG6P45sOg9olERuSFvQN6ueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061775; c=relaxed/simple;
	bh=rRBHQ5Tj/mkAX07rI6Q3wXDtZyOHOyBYMgozaxdM7Pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SuF/xdnPXHVZf9srZtbsBIWgcmWVzADzQcgyWdYoPrxJKwy/Sy0ukw0Mxhe2BKalAV0XMNwVmnKVbIRQqPA66jvEEzVdO8eIEU8fcP25zPMj8HRFsPkmSsW75rlKxNXGr3XKKSuibH5OUNB2xqQXVl+A9ck1kCnL5M/IR+QhwxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nY482vpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F05C19423;
	Wed, 25 Feb 2026 23:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061774;
	bh=rRBHQ5Tj/mkAX07rI6Q3wXDtZyOHOyBYMgozaxdM7Pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nY482vpcquKA6zKf3Vak+GopmiancyFXH7dezb4Y40hg1uhToem28F591K1gYOeqv
	 mUei71zGeBf3ZqnGlMd1MmXTT/qavbxiEgKFqjZdnnGFrQOi6UcFjyD2WsJ1lkv4Rn
	 yDtSjGU/6raxKnIstLHAZ8eI8OOiOVBKfHWp0TMXlRrfYMU50jINQWmcqwIWVyZ8KL
	 9ldYtl+mFKPTFYbWBSW8lZ1sfkBm3ve1ZOdTlgnRr8rcscXh2IIp1ustLb0Kk+rbk0
	 IXI+VbGocKcP4tVBeQoLwZhxP14KsnUPmfBqcHSLfAWgMV5Go0F0jULl4bPKL6BUqS
	 0oILJDRvZQWMw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 00:22:44 +0100
Subject: [PATCH RFC v4 1/2] pidfs: add inode ownership and permission
 checks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-pidfs-inode-owner-v4-1-990032ec9700@kernel.org>
References: <20260226-work-pidfs-inode-owner-v4-0-990032ec9700@kernel.org>
In-Reply-To: <20260226-work-pidfs-inode-owner-v4-0-990032ec9700@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=9051; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rRBHQ5Tj/mkAX07rI6Q3wXDtZyOHOyBYMgozaxdM7Pg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTOb/FqmcjXvFuffct60QX7f66b2NcmMk8tYmrWjO1Ha
 vZXis550VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRFVsZGa4JmmtPTSiRED+z
 2uyPWlk/l6b9bf/If89nt7EsPMu91JCRYb+Miv7UVi3fw77bGXeaWJ6+8/dI5t6rs3li5+7s229
 cxg4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-78413-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2712B19EC27
X-Rspamd-Action: no action

Right now we only support trusted.* xattrs which require CAP_SYS_ADMIN
which doesn't really require any meaningful permission checking. But in
order to support user.* xattrs and custom pidfs.* xattrs in the future
we need permission checking for pidfs inodes. Add baseline permission
checking that can later be extended with additional write-time checks
for specific pidfs.* xattrs.

Make the {u,g}id of the task the owner of the pidfs inode. The ownership
is set when the dentry is first stashed and reported dynamically via
getattr since credentials may change due to setuid() and similar
operations. For kernel threads use root, for exited tasks use the
credentials saved at exit time.

The inode's ownership is dynamically updated via pidfs_update_owner()
which is called from the getattr() and permission() callbacks. It writes
the uid/gid directly to the inode via WRITE_ONCE(). This doesn't
serialize against inode->i_op->setattr() but since pidfs rejects
setattr() this isn't currently an issue. A seqcount-based approach can
be used if setattr() support is added in the future [1].

Save the task's credentials and thread group pid inode number at exit
time so that ownership and permission checks remain functional after the
task has been reaped.

The permission callback updates the inode's ownership via
pidfs_update_owner() and then performs standard POSIX permission checking
via generic_permission() against the inode's ownership and mode bits
(S_IRWXU / 0700).

This is intentionally less strict than ptrace_may_access() because pidfs
currently does not allow operating on data that is completely private to
the process such as its mm or file descriptors. Additional checks will
be needed once that changes.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.inode.seqcount [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 110 +++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 17 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 318253344b5c..4f480a814c5a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -42,21 +42,30 @@ void pidfs_get_root(struct path *path)
 }
 
 enum pidfs_attr_mask_bits {
-	PIDFS_ATTR_BIT_EXIT	= 0,
-	PIDFS_ATTR_BIT_COREDUMP	= 1,
+	PIDFS_ATTR_BIT_EXIT	= (1U << 0),
+	PIDFS_ATTR_BIT_COREDUMP	= (1U << 1),
+	PIDFS_ATTR_BIT_KTHREAD	= (1U << 2),
 };
 
-struct pidfs_attr {
-	unsigned long attr_mask;
-	struct simple_xattrs *xattrs;
-	struct /* exit info */ {
-		__u64 cgroupid;
-		__s32 exit_code;
-	};
+struct pidfs_exit_attr {
+	__u64 cgroupid;
+	__s32 exit_code;
+	const struct cred *exit_cred;
+	u64 exit_tgid_ino;
+};
+
+struct pidfs_coredump_attr {
 	__u32 coredump_mask;
 	__u32 coredump_signal;
 };
 
+struct pidfs_attr {
+	atomic_t attr_mask;
+	struct simple_xattrs *xattrs;
+	struct pidfs_exit_attr;
+	struct pidfs_coredump_attr;
+};
+
 static struct rhashtable pidfs_ino_ht;
 
 static const struct rhashtable_params pidfs_ino_ht_params = {
@@ -200,6 +209,7 @@ void pidfs_free_pid(struct pid *pid)
 	if (IS_ERR(attr))
 		return;
 
+	put_cred(attr->exit_cred);
 	xattrs = no_free_ptr(attr->xattrs);
 	if (xattrs)
 		simple_xattrs_free(xattrs, NULL);
@@ -364,7 +374,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 
 	attr = READ_ONCE(pid->attr);
 	if (mask & PIDFD_INFO_EXIT) {
-		if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask)) {
+		if (atomic_read(&attr->attr_mask) & PIDFS_ATTR_BIT_EXIT) {
 			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_EXIT;
 #ifdef CONFIG_CGROUPS
@@ -376,7 +386,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 
 	if (mask & PIDFD_INFO_COREDUMP) {
-		if (test_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask)) {
+		if (atomic_read(&attr->attr_mask) & PIDFS_ATTR_BIT_COREDUMP) {
 			smp_rmb();
 			kinfo.mask |= PIDFD_INFO_COREDUMP | PIDFD_INFO_COREDUMP_SIGNAL;
 			kinfo.coredump_mask = attr->coredump_mask;
@@ -674,6 +684,7 @@ void pidfs_exit(struct task_struct *tsk)
 {
 	struct pid *pid = task_pid(tsk);
 	struct pidfs_attr *attr;
+	unsigned int mask;
 #ifdef CONFIG_CGROUPS
 	struct cgroup *cgrp;
 #endif
@@ -703,17 +714,22 @@ void pidfs_exit(struct task_struct *tsk)
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
 	smp_wmb();
-	set_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask);
+	mask = PIDFS_ATTR_BIT_EXIT;
+	if (unlikely(tsk->flags & PF_KTHREAD))
+		mask |= PIDFS_ATTR_BIT_KTHREAD;
+	atomic_or(mask, &attr->attr_mask);
 }
 
 #ifdef CONFIG_COREDUMP
@@ -735,12 +751,49 @@ void pidfs_coredump(const struct coredump_params *cprm)
 	/* Expose the signal number that caused the coredump. */
 	attr->coredump_signal = cprm->siginfo->si_signo;
 	smp_wmb();
-	set_bit(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
+	atomic_or(PIDFS_ATTR_BIT_COREDUMP, &attr->attr_mask);
 }
 #endif
 
 static struct vfsmount *pidfs_mnt __ro_after_init;
 
+static void pidfs_update_owner(struct inode *inode)
+{
+	struct pid *pid = inode->i_private;
+	struct task_struct *task;
+	struct pidfs_attr *attr;
+	const struct cred *cred;
+
+	VFS_WARN_ON_ONCE(!pid);
+
+	attr = READ_ONCE(pid->attr);
+	VFS_WARN_ON_ONCE(!attr);
+
+	if (unlikely(atomic_read(&attr->attr_mask) & PIDFS_ATTR_BIT_KTHREAD))
+		return;
+
+	guard(rcu)();
+	task = pid_task(pid, PIDTYPE_PID);
+	if (task) {
+		cred = __task_cred(task);
+		WRITE_ONCE(inode->i_uid, cred->uid);
+		WRITE_ONCE(inode->i_gid, cred->gid);
+		return;
+	}
+
+	/*
+	 * During copy_process() with CLONE_PIDFD the task hasn't been
+	 * attached to the pid yet so pid_task() returns NULL and
+	 * there's no exit_cred as the task obviously hasn't exited. Use
+	 * the parent's credentials.
+	 */
+	cred = attr->exit_cred;
+	if (!cred)
+		cred = current_cred();
+	WRITE_ONCE(inode->i_uid, cred->uid);
+	WRITE_ONCE(inode->i_gid, cred->gid);
+}
+
 /*
  * The vfs falls back to simple_setattr() if i_op->setattr() isn't
  * implemented. Let's reject it completely until we have a clean
@@ -756,6 +809,9 @@ static int pidfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 			 struct kstat *stat, u32 request_mask,
 			 unsigned int query_flags)
 {
+	struct inode *inode = d_inode(path->dentry);
+
+	pidfs_update_owner(inode);
 	return anon_inode_getattr(idmap, path, stat, request_mask, query_flags);
 }
 
@@ -773,10 +829,24 @@ static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
 	return simple_xattr_list(inode, xattrs, buf, size);
 }
 
+static int pidfs_permission(struct mnt_idmap *idmap, struct inode *inode,
+			    int mask)
+{
+	struct pid *pid = inode->i_private;
+	struct pidfs_attr *attr = READ_ONCE(pid->attr);
+
+	if (unlikely(atomic_read(&attr->attr_mask) & PIDFS_ATTR_BIT_KTHREAD))
+		return -EPERM;
+
+	pidfs_update_owner(inode);
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
@@ -835,7 +905,7 @@ static struct pid *pidfs_ino_get_pid(u64 ino)
 	attr = READ_ONCE(pid->attr);
 	if (IS_ERR_OR_NULL(attr))
 		return NULL;
-	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
+	if (atomic_read(&attr->attr_mask) & PIDFS_ATTR_BIT_EXIT)
 		return NULL;
 	/* Within our pid namespace hierarchy? */
 	if (pid_vnr(pid) == 0)
@@ -949,6 +1019,7 @@ static void pidfs_put_data(void *data)
 int pidfs_register_pid(struct pid *pid)
 {
 	struct pidfs_attr *new_attr __free(kfree) = NULL;
+	struct task_struct *task;
 	struct pidfs_attr *attr;
 
 	might_sleep();
@@ -975,6 +1046,9 @@ int pidfs_register_pid(struct pid *pid)
 	if (unlikely(attr))
 		return 0;
 
+	task = pid_task(pid, PIDTYPE_PID);
+	if (task && (task->flags & PF_KTHREAD))
+		atomic_or(PIDFS_ATTR_BIT_KTHREAD, &new_attr->attr_mask);
 	pid->attr = no_free_ptr(new_attr);
 	return 0;
 }
@@ -983,7 +1057,8 @@ static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 					 struct dentry *dentry)
 {
 	int ret;
-	struct pid *pid = d_inode(dentry)->i_private;
+	struct inode *inode = d_inode(dentry);
+	struct pid *pid = inode->i_private;
 
 	VFS_WARN_ON_ONCE(stashed != &pid->stashed);
 
@@ -991,6 +1066,7 @@ static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
 	if (ret)
 		return ERR_PTR(ret);
 
+	pidfs_update_owner(inode);
 	return stash_dentry(stashed, dentry);
 }
 

-- 
2.47.3


