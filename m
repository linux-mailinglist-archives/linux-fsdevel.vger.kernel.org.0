Return-Path: <linux-fsdevel+bounces-74676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCXrNXSkb2n0DgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:51:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DD46BD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 227D690476E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F6243637D;
	Tue, 20 Jan 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj7pUq6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23209449ECB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768920770; cv=none; b=MEPV0Bt5WD4qHFzY2xa63sFuBQLLxBzi0k0pWnAr7AUIT0cbrBZLTI8Uc1OMJglbnVwlTSSe+UIPqBIfiO8jFVr5aPeF9pDSIk34LN4fKdD/4gEMQfbgSiz4ryvymPIgMBp48t1RMXhNRW6q9RfSliCLlp2IlvHnLMgaBWK4gPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768920770; c=relaxed/simple;
	bh=zKF9/JEeSGnquHIMuxhKf0A2xCHrC46js/V2rPc2EE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RfREjTQtmFHP6lzKIv285eUh6szDuVLsDtVEDP/INyrcJc7dntVOgPRQtbfRo4sreZKLacJfAOvB2lm067yhVCHK1ySHuKsyLdvaKbmxJRBsyTdRdIXeHAK1R/zXX0PxtdCRlvjK4BCyxeyQc3qssHbbufp+BHwQ06n1j7sW7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj7pUq6+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86067C16AAE;
	Tue, 20 Jan 2026 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768920768;
	bh=zKF9/JEeSGnquHIMuxhKf0A2xCHrC46js/V2rPc2EE8=;
	h=From:Date:Subject:To:Cc:From;
	b=Nj7pUq6+WbiRyycBxuIWfB2dx8moqeJxDcbmUTY5wpjhzvwG53bxNEvoah6yfsqXb
	 4gjDAlIz31mYUo1yoglq60Q4YaozTuiM0OOe5g8UlmIEnIMl1B4RSiY7dfUPVSPiC4
	 QMcYnbv7GxhbnbgQLG1fREWR+BTJhg8OebBf5J4Yq4JARhoUGbmGbcaUELDjty8q/Q
	 pgb99qM8vygrZAbzYfYbVs2z0bW7GZlkYHRPsxGrRk2qQswMfyXhxw/eJo08M92bLf
	 3FJjDmChIuJi5QTUkD1RvNlwcBfmlW2Otypt3wNB32otN+0EJ0uBp78uMIVTKwyjuX
	 7B3jQpihyJXtA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 20 Jan 2026 15:52:35 +0100
Subject: [PATCH RFC v2] pidfs: convert rb-tree to rhashtable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
X-B4-Tracking: v=1; b=H4sIALKWb2kC/4WOTQqDMBCFryKzbiSxP8GuCoUeoNviIjGjCdpEJ
 mJbxLs32gOUWb0H3/dmhojkMMI5m4FwctEFn0Kxy6C2yrfInEkZCl6cuBAlewXq2OBMExlZFe2
 odI+sNOLApdBGSgWJHQgb9968D7jfrlClUquITJPytV2VHZLHnsmc508X6xWzLo6BPts3k9jgP
 8OTYOmOZS0l53vO1eWnzQO1UC3L8gW2Emjn4gAAAA==
X-Change-ID: 20260119-work-pidfs-rhashtable-9d14071bd77a
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8910; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zKF9/JEeSGnquHIMuxhKf0A2xCHrC46js/V2rPc2EE8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTmT9uf161iGLFkafmTG2/5X/euFf+/o+rZwQkqWhEvW
 N72JGlUdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExE9yojw2Utr54nf20ct5T1
 8uXlJ95dmijK76DbfKY+/Ij4Q7mQV4wMn9yPJPAU7Tjwede1ijl/f7yN8OpgeTHroFnLl/NcW4W
 YuAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74676-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 478DD46BD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mateusz reported performance penalties [1] during task creation because
pidfs uses pidmap_lock to add elements into the rbtree. Switch to an
rhashtable to have separate fine-grained locking and to decouple from
pidmap_lock moving all heavy manipulations outside of it.

Convert the pidfs inode-to-pid mapping from an rb-tree with seqcount
protection to an rhashtable. This removes the global pidmap_lock
contention from pidfs_ino_get_pid() lookups and allows the hashtable
insert to happen outside the pidmap_lock.

pidfs_add_pid() is split. pidfs_prepare_pid() allocates inode number and
initializes pid fields and is called inside pidmap_lock. pidfs_add_pid()
inserts pid into rhashtable and is called outside pidmap_lock. Insertion
into the rhashtable can fail and memory allocation may happen so we need
to drop the spinlock.

To guard against accidently opening an already reaped task
pidfs_ino_get_pid() uses additional checks beyond pid_vnr(). If
pid->attr is PIDFS_PID_DEAD or NULL the pid either never had a pidfd or
it already went through pidfs_exit() aka the process as already reaped.
If pid->attr is valid check PIDFS_ATTR_BIT_EXIT to figure out whether
the task has exited.

This slightly changes visibility semantics: pidfd creation is denied
after pidfs_exit() runs, which is just before the pid number is removed
from the via free_pid(). That should not be an issue though.

Link: https://lore.kernel.org/20251206131955.780557-1-mjguzik@gmail.com [1]
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Changes in v2:
- Ensure that pid is removed before call_rcu() from pidfs.
- Don't drop and reacquire spinlock.
- Link to v1: https://patch.msgid.link/20260119-work-pidfs-rhashtable-v1-1-159c7700300a@kernel.org
---
 fs/pidfs.c            | 81 +++++++++++++++++++++------------------------------
 include/linux/pid.h   |  4 +--
 include/linux/pidfs.h |  3 +-
 kernel/pid.c          | 13 ++++++---
 4 files changed, 46 insertions(+), 55 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dba703d4ce4a..ee0e36dd29d2 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -21,6 +21,7 @@
 #include <linux/utsname.h>
 #include <net/net_namespace.h>
 #include <linux/coredump.h>
+#include <linux/rhashtable.h>
 #include <linux/xattr.h>
 
 #include "internal.h"
@@ -55,7 +56,14 @@ struct pidfs_attr {
 	__u32 coredump_signal;
 };
 
-static struct rb_root pidfs_ino_tree = RB_ROOT;
+static struct rhashtable pidfs_ino_ht;
+
+static const struct rhashtable_params pidfs_ino_ht_params = {
+	.key_offset		= offsetof(struct pid, ino),
+	.key_len		= sizeof(u64),
+	.head_offset		= offsetof(struct pid, pidfs_hash),
+	.automatic_shrinking	= true,
+};
 
 #if BITS_PER_LONG == 32
 static inline unsigned long pidfs_ino(u64 ino)
@@ -84,21 +92,11 @@ static inline u32 pidfs_gen(u64 ino)
 }
 #endif
 
-static int pidfs_ino_cmp(struct rb_node *a, const struct rb_node *b)
-{
-	struct pid *pid_a = rb_entry(a, struct pid, pidfs_node);
-	struct pid *pid_b = rb_entry(b, struct pid, pidfs_node);
-	u64 pid_ino_a = pid_a->ino;
-	u64 pid_ino_b = pid_b->ino;
-
-	if (pid_ino_a < pid_ino_b)
-		return -1;
-	if (pid_ino_a > pid_ino_b)
-		return 1;
-	return 0;
-}
-
-void pidfs_add_pid(struct pid *pid)
+/*
+ * Allocate inode number and initialize pidfs fields.
+ * Called with pidmap_lock held.
+ */
+void pidfs_prepare_pid(struct pid *pid)
 {
 	static u64 pidfs_ino_nr = 2;
 
@@ -131,20 +129,22 @@ void pidfs_add_pid(struct pid *pid)
 		pidfs_ino_nr += 2;
 
 	pid->ino = pidfs_ino_nr;
+	pid->pidfs_hash.next = NULL;
 	pid->stashed = NULL;
 	pid->attr = NULL;
 	pidfs_ino_nr++;
+}
 
-	write_seqcount_begin(&pidmap_lock_seq);
-	rb_find_add_rcu(&pid->pidfs_node, &pidfs_ino_tree, pidfs_ino_cmp);
-	write_seqcount_end(&pidmap_lock_seq);
+int pidfs_add_pid(struct pid *pid)
+{
+	return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
+				      pidfs_ino_ht_params);
 }
 
 void pidfs_remove_pid(struct pid *pid)
 {
-	write_seqcount_begin(&pidmap_lock_seq);
-	rb_erase(&pid->pidfs_node, &pidfs_ino_tree);
-	write_seqcount_end(&pidmap_lock_seq);
+	rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
+			       pidfs_ino_ht_params);
 }
 
 void pidfs_free_pid(struct pid *pid)
@@ -773,42 +773,24 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return FILEID_KERNFS;
 }
 
-static int pidfs_ino_find(const void *key, const struct rb_node *node)
-{
-	const u64 pid_ino = *(u64 *)key;
-	const struct pid *pid = rb_entry(node, struct pid, pidfs_node);
-
-	if (pid_ino < pid->ino)
-		return -1;
-	if (pid_ino > pid->ino)
-		return 1;
-	return 0;
-}
-
 /* Find a struct pid based on the inode number. */
 static struct pid *pidfs_ino_get_pid(u64 ino)
 {
 	struct pid *pid;
-	struct rb_node *node;
-	unsigned int seq;
+	struct pidfs_attr *attr;
 
 	guard(rcu)();
-	do {
-		seq = read_seqcount_begin(&pidmap_lock_seq);
-		node = rb_find_rcu(&ino, &pidfs_ino_tree, pidfs_ino_find);
-		if (node)
-			break;
-	} while (read_seqcount_retry(&pidmap_lock_seq, seq));
-
-	if (!node)
+	pid = rhashtable_lookup(&pidfs_ino_ht, &ino, pidfs_ino_ht_params);
+	if (!pid)
+		return NULL;
+	attr = READ_ONCE(pid->attr);
+	if (IS_ERR_OR_NULL(attr))
+		return NULL;
+	if (test_bit(PIDFS_ATTR_BIT_EXIT, &attr->attr_mask))
 		return NULL;
-
-	pid = rb_entry(node, struct pid, pidfs_node);
-
 	/* Within our pid namespace hierarchy? */
 	if (pid_vnr(pid) == 0)
 		return NULL;
-
 	return get_pid(pid);
 }
 
@@ -1086,6 +1068,9 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 
 void __init pidfs_init(void)
 {
+	if (rhashtable_init(&pidfs_ino_ht, &pidfs_ino_ht_params))
+		panic("Failed to initialize pidfs hashtable");
+
 	pidfs_attr_cachep = kmem_cache_create("pidfs_attr_cache", sizeof(struct pidfs_attr), 0,
 					 (SLAB_HWCACHE_ALIGN | SLAB_RECLAIM_ACCOUNT |
 					  SLAB_ACCOUNT | SLAB_PANIC), NULL);
diff --git a/include/linux/pid.h b/include/linux/pid.h
index 003a1027d219..ce9b5cb7560b 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -6,6 +6,7 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
+#include <linux/rhashtable-types.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 
@@ -60,7 +61,7 @@ struct pid {
 	spinlock_t lock;
 	struct {
 		u64 ino;
-		struct rb_node pidfs_node;
+		struct rhash_head pidfs_hash;
 		struct dentry *stashed;
 		struct pidfs_attr *attr;
 	};
@@ -73,7 +74,6 @@ struct pid {
 	struct upid numbers[];
 };
 
-extern seqcount_spinlock_t pidmap_lock_seq;
 extern struct pid init_struct_pid;
 
 struct file;
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 3e08c33da2df..416bdff4d6ce 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -6,7 +6,8 @@ struct coredump_params;
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
-void pidfs_add_pid(struct pid *pid);
+void pidfs_prepare_pid(struct pid *pid);
+int pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 void pidfs_exit(struct task_struct *tsk);
 #ifdef CONFIG_COREDUMP
diff --git a/kernel/pid.c b/kernel/pid.c
index ad4400a9f15f..6077da774652 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -43,7 +43,6 @@
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 #include <linux/pidfs.h>
-#include <linux/seqlock.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -85,7 +84,6 @@ struct pid_namespace init_pid_ns = {
 EXPORT_SYMBOL_GPL(init_pid_ns);
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
-seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
 
 void put_pid(struct pid *pid)
 {
@@ -141,9 +139,9 @@ void free_pid(struct pid *pid)
 
 		idr_remove(&ns->idr, upid->nr);
 	}
-	pidfs_remove_pid(pid);
 	spin_unlock(&pidmap_lock);
 
+	pidfs_remove_pid(pid);
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
@@ -315,7 +313,8 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	retval = -ENOMEM;
 	if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
 		goto out_free;
-	pidfs_add_pid(pid);
+	pidfs_prepare_pid(pid);
+
 	for (upid = pid->numbers + ns->level; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
@@ -325,6 +324,12 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *arg_set_tid,
 	idr_preload_end();
 	ns_ref_active_get(ns);
 
+	retval = pidfs_add_pid(pid);
+	if (unlikely(retval)) {
+		free_pid(pid);
+		pid = ERR_PTR(-ENOMEM);
+	}
+
 	return pid;
 
 out_free:

---
base-commit: f54c7e54d2de2d7b58aa54604218a6fc00bb2e77
change-id: 20260119-work-pidfs-rhashtable-9d14071bd77a


