Return-Path: <linux-fsdevel+bounces-79634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BadAB4Cq2nDZQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:34:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FC522503F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 17:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 604D1300BC86
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 16:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F13F0763;
	Fri,  6 Mar 2026 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bM7Fazce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C13F0744
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772814525; cv=none; b=iQAHVbVR+k7kIMgWlArSK7HvhvhhpUEc0g0cJ0y67/6h+sl1fdRMgAl/TfAQ06ehaz65ZmfhAJ7vvF04iELHDuRIit6y31ZhMdTe8LXIEppMD9WqA1qywwJpZ9MGh54CdOVS+L01sLMj7nPk7G36h5zF8H/HFHQJGpzJ4SWjgFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772814525; c=relaxed/simple;
	bh=dnDUogYrE1NkrZev9TMKA09+vyccSiPhkNHsxCKq5fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=KQOtbDgFoH2VudSgdc4Sl6yvWgCGRvQhCQ+ODYExF4nliv7I+mKECx7dMwtevIPkPMeZw4i/UAzqT+dAT4JJP2rcRDUCqAXEdQe1uXPzfIgaX/pob+7PlEDSdp+tT+4U8LSc3RDA9+j/lU5YTnaRky4calMIBnexyzJWD9D6kJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bM7Fazce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865E1C2BC86;
	Fri,  6 Mar 2026 16:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772814525;
	bh=dnDUogYrE1NkrZev9TMKA09+vyccSiPhkNHsxCKq5fo=;
	h=From:Date:Subject:References:In-Reply-To:To:From;
	b=bM7Fazcee21r8E1ESogGx29YNMiBpG8Bk7fd0ncceimPk9tESWgna/v/e1lj6OAcK
	 8AyS6VMosfwQTSPV5KFovCeoSVCzCfPFmBvce6O/UpKSvYyU6ThO34olSZb5Ea26fI
	 FtfNCUwQODtzHRMU39rP34L2h+6l1lMCI/YuPwp8jiyHk7t+9Y9n3HZNeqFf4XdUyU
	 Dr8xk362FLGP4AGcF6mmfwC3oBr2XOwNv8DxXoQM3gDIyXoMDD0zhl56EoWbf39YGt
	 Xlfzs6iD/13etIFhS216xGJprLD76am8OfzwZUpQy8RtwmxZsBuqmPgVpPoZQLp0DQ
	 49iZVydF9GUnA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 17:28:37 +0100
Subject: [PATCH 1/3] namespace: allow creating empty mount namespaces
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-empty-mntns-consolidated-v1-1-6eb30529bbb0@kernel.org>
References: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
In-Reply-To: <20260306-work-empty-mntns-consolidated-v1-0-6eb30529bbb0@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-e55a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=9795; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dnDUogYrE1NkrZev9TMKA09+vyccSiPhkNHsxCKq5fo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuZtjhUHGI3/DN5LdNTsldz+J3lKaFiyVprfJi57190
 Js7g9muo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKHFzIyzNtRP6P/24sYx87g
 3z492vNmBbbO2/2J9VKClLKv4fmyckaG5eUpXN4v9P+fD1TbeGHm3G/r/Zfnbbr0OI+58E+4+dc
 AVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 52FC522503F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79634-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for creating a mount namespace that contains only a copy of
the root mount from the caller's mount namespace, with none of the
child mounts.  This is useful for containers and sandboxes that want to
start with a minimal mount table and populate it from scratch rather
than inheriting and then tearing down the full mount tree.

Two new flags are introduced:

- CLONE_EMPTY_MNTNS (0x400000000) for clone3(), using the 64-bit
  flag space.

- UNSHARE_EMPTY_MNTNS (0x00100000) for unshare(), reusing the
  CLONE_PARENT_SETTID bit which has no meaning for unshare.

Both flags imply CLONE_NEWNS.  For the unshare path,
UNSHARE_EMPTY_MNTNS is converted to CLONE_EMPTY_MNTNS in
unshare_nsproxy_namespaces() before it reaches copy_mnt_ns(), so the
mount namespace code only needs to handle a single flag.

In copy_mnt_ns(), when CLONE_EMPTY_MNTNS is set, clone_mnt() is used
instead of copy_tree() to clone only the root mount.  The caller's root
and working directory are both reset to the root dentry of the new
mount.

The cleanup variables are changed from vfsmount pointers with
__free(mntput) to struct path with __free(path_put) because the empty
mount namespace path needs to release both mount and dentry references
when replacing the caller's root and pwd.  In the normal (non-empty)
path only the mount component is set, and dput(NULL) is a no-op so
path_put remains correct there as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c             | 85 ++++++++++++++++++++++++++++++----------------
 include/uapi/linux/sched.h |  7 ++++
 kernel/fork.c              | 17 ++++++++--
 kernel/nsproxy.c           | 21 +++++++++---
 4 files changed, 94 insertions(+), 36 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 854f4fc66469..9fcfab6c3cb5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4231,8 +4231,8 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 		struct user_namespace *user_ns, struct fs_struct *new_fs)
 {
 	struct mnt_namespace *new_ns;
-	struct vfsmount *rootmnt __free(mntput) = NULL;
-	struct vfsmount *pwdmnt __free(mntput) = NULL;
+	struct path old_root __free(path_put) = {};
+	struct path old_pwd __free(path_put) = {};
 	struct mount *p, *q;
 	struct mount *old;
 	struct mount *new;
@@ -4252,11 +4252,18 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 		return new_ns;
 
 	guard(namespace_excl)();
-	/* First pass: copy the tree topology */
-	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
+
+	if (flags & CLONE_EMPTY_MNTNS)
+		copy_flags = 0;
+	else
+		copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
 		copy_flags |= CL_SLAVE;
-	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
+
+	if (flags & CLONE_EMPTY_MNTNS)
+		new = clone_mnt(old, old->mnt.mnt_root, copy_flags);
+	else
+		new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
 		return ERR_CAST(new);
@@ -4267,33 +4274,53 @@ struct mnt_namespace *copy_mnt_ns(u64 flags, struct mnt_namespace *ns,
 	}
 	new_ns->root = new;
 
-	/*
-	 * Second pass: switch the tsk->fs->* elements and mark new vfsmounts
-	 * as belonging to new namespace.  We have already acquired a private
-	 * fs_struct, so tsk->fs->lock is not needed.
-	 */
-	p = old;
-	q = new;
-	while (p) {
-		mnt_add_to_ns(new_ns, q);
-		new_ns->nr_mounts++;
+	if (flags & CLONE_EMPTY_MNTNS) {
+		/*
+		 * Empty mount namespace: only the root mount exists.
+		 * Reset root and pwd to the cloned mount's root dentry.
+		 */
 		if (new_fs) {
-			if (&p->mnt == new_fs->root.mnt) {
-				new_fs->root.mnt = mntget(&q->mnt);
-				rootmnt = &p->mnt;
-			}
-			if (&p->mnt == new_fs->pwd.mnt) {
-				new_fs->pwd.mnt = mntget(&q->mnt);
-				pwdmnt = &p->mnt;
+			old_root = new_fs->root;
+			old_pwd = new_fs->pwd;
+
+			new_fs->root.mnt = mntget(&new->mnt);
+			new_fs->root.dentry = dget(new->mnt.mnt_root);
+
+			new_fs->pwd.mnt = mntget(&new->mnt);
+			new_fs->pwd.dentry = dget(new->mnt.mnt_root);
+		}
+		mnt_add_to_ns(new_ns, new);
+		new_ns->nr_mounts++;
+	} else {
+		/*
+		 * Full copy: walk old and new trees in parallel, switching
+		 * the tsk->fs->* elements and marking new vfsmounts as
+		 * belonging to new namespace.  We have already acquired a
+		 * private fs_struct, so tsk->fs->lock is not needed.
+		 */
+		p = old;
+		q = new;
+		while (p) {
+			mnt_add_to_ns(new_ns, q);
+			new_ns->nr_mounts++;
+			if (new_fs) {
+				if (&p->mnt == new_fs->root.mnt) {
+					old_root.mnt = new_fs->root.mnt;
+					new_fs->root.mnt = mntget(&q->mnt);
+				}
+				if (&p->mnt == new_fs->pwd.mnt) {
+					old_pwd.mnt = new_fs->pwd.mnt;
+					new_fs->pwd.mnt = mntget(&q->mnt);
+				}
 			}
+			p = next_mnt(p, old);
+			q = next_mnt(q, new);
+			if (!q)
+				break;
+			// an mntns binding we'd skipped?
+			while (p->mnt.mnt_root != q->mnt.mnt_root)
+				p = next_mnt(skip_mnt_tree(p), old);
 		}
-		p = next_mnt(p, old);
-		q = next_mnt(q, new);
-		if (!q)
-			break;
-		// an mntns binding we'd skipped?
-		while (p->mnt.mnt_root != q->mnt.mnt_root)
-			p = next_mnt(skip_mnt_tree(p), old);
 	}
 	ns_tree_add_raw(new_ns);
 	return new_ns;
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 359a14cc76a4..1926374a933e 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_EMPTY_MNTNS 0x400000000ULL /* Create an empty mount namespace. */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
@@ -43,6 +44,12 @@
  */
 #define CLONE_NEWTIME	0x00000080	/* New time namespace */
 
+/*
+ * unshare flags share the bit space with clone flags but only apply to the
+ * unshare syscall:
+ */
+#define UNSHARE_EMPTY_MNTNS 0x00100000 /* Unshare an empty mount namespace. */
+
 #ifndef __ASSEMBLY__
 /**
  * struct clone_args - arguments for the clone3 syscall
diff --git a/kernel/fork.c b/kernel/fork.c
index 65113a304518..dea6b3454447 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2619,6 +2619,16 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 	int trace = 0;
 	pid_t nr;
 
+	/*
+	 * Creating an empty mount namespace implies creating a new mount
+	 * namespace.  Set this before copy_process() so that the
+	 * CLONE_NEWNS|CLONE_FS mutual exclusion check works correctly.
+	 */
+	if (clone_flags & CLONE_EMPTY_MNTNS) {
+		clone_flags |= CLONE_NEWNS;
+		args->flags = clone_flags;
+	}
+
 	/*
 	 * For legacy clone() calls, CLONE_PIDFD uses the parent_tid argument
 	 * to return the pidfd. Hence, CLONE_PIDFD and CLONE_PARENT_SETTID are
@@ -2897,7 +2907,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND |
+	      CLONE_INTO_CGROUP | CLONE_EMPTY_MNTNS))
 		return false;
 
 	/*
@@ -3050,7 +3061,7 @@ static int check_unshare_flags(unsigned long unshare_flags)
 				CLONE_VM|CLONE_FILES|CLONE_SYSVSEM|
 				CLONE_NEWUTS|CLONE_NEWIPC|CLONE_NEWNET|
 				CLONE_NEWUSER|CLONE_NEWPID|CLONE_NEWCGROUP|
-				CLONE_NEWTIME))
+				CLONE_NEWTIME | UNSHARE_EMPTY_MNTNS))
 		return -EINVAL;
 	/*
 	 * Not implemented, but pretend it works if there is nothing
@@ -3149,6 +3160,8 @@ int ksys_unshare(unsigned long unshare_flags)
 	/*
 	 * If unsharing namespace, must also unshare filesystem information.
 	 */
+	if (unshare_flags & UNSHARE_EMPTY_MNTNS)
+		unshare_flags |= CLONE_NEWNS;
 	if (unshare_flags & CLONE_NEWNS)
 		unshare_flags |= CLONE_FS;
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 259c4b4f1eeb..1bdc5be2dd20 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -95,7 +95,8 @@ static struct nsproxy *create_new_namespaces(u64 flags,
 	if (!new_nsp)
 		return ERR_PTR(-ENOMEM);
 
-	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns, user_ns, new_fs);
+	new_nsp->mnt_ns = copy_mnt_ns(flags, tsk->nsproxy->mnt_ns,
+				      user_ns, new_fs);
 	if (IS_ERR(new_nsp->mnt_ns)) {
 		err = PTR_ERR(new_nsp->mnt_ns);
 		goto out_ns;
@@ -212,18 +213,28 @@ int unshare_nsproxy_namespaces(unsigned long unshare_flags,
 	struct nsproxy **new_nsp, struct cred *new_cred, struct fs_struct *new_fs)
 {
 	struct user_namespace *user_ns;
+	u64 flags = unshare_flags;
 	int err = 0;
 
-	if (!(unshare_flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
-			       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
-			       CLONE_NEWTIME)))
+	if (!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
+		       CLONE_NEWNET | CLONE_NEWPID | CLONE_NEWCGROUP |
+		       CLONE_NEWTIME)))
 		return 0;
 
 	user_ns = new_cred ? new_cred->user_ns : current_user_ns();
 	if (!ns_capable(user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
-	*new_nsp = create_new_namespaces(unshare_flags, current, user_ns,
+	/*
+	 * Convert the 32-bit UNSHARE_EMPTY_MNTNS (which aliases
+	 * CLONE_PARENT_SETTID) to the unique 64-bit CLONE_EMPTY_MNTNS.
+	 */
+	if (flags & UNSHARE_EMPTY_MNTNS) {
+		flags &= ~(u64)UNSHARE_EMPTY_MNTNS;
+		flags |= CLONE_EMPTY_MNTNS;
+	}
+
+	*new_nsp = create_new_namespaces(flags, current, user_ns,
 					 new_fs ? new_fs : current->fs);
 	if (IS_ERR(*new_nsp)) {
 		err = PTR_ERR(*new_nsp);

-- 
2.47.3


