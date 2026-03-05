Return-Path: <linux-fsdevel+bounces-79541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPbhMGQUqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57095219673
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF9E130A1E20
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8F36AB5F;
	Thu,  5 Mar 2026 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6Q6/k0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD436AB45;
	Thu,  5 Mar 2026 23:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753461; cv=none; b=YK/TdKR0sFqNslboKQMyk1GHYBPthr7b4xFTP0vQxn578+73MAbXmeQgYEOEGZ+78tFRPVJezjk18x1BdIdYFTURdmau5DJkZVRjhn/YRYhsIPxBPf4o6QLG1CLMNIX89p9sx6JqK3UYQYQKymPYC6I+6UCRR+nDqLcuMYQZZ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753461; c=relaxed/simple;
	bh=T1PF8uR+tmSj9N7iVtpiuxKAI5ZeF6Hs12ZPEywHqNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jveo0zA4QzdcdCtPVFJFzBffcFNUAyN1x/v7z+htDF/sEmHFEi8HETRZY3YIa9QAHFo2/K6qkiQWP2/tmaKY1hkXWsQUGW9UW/5Ao8P5X0SSvHwfbjrXgfzCswLvoGvvgbSJ6gadqZNtJ4u1Q5uIAsYa0vsU9ELlx40qt5SA2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6Q6/k0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28CAC19423;
	Thu,  5 Mar 2026 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753461;
	bh=T1PF8uR+tmSj9N7iVtpiuxKAI5ZeF6Hs12ZPEywHqNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B6Q6/k0lI+q0auN/tK/+UrqoZUPOlhQDvCgu9kSK4nU9p4zE3bhsgFy89Uoh4F2pm
	 r4iEgT+3Tp/EVTFxmSkXKtTwTmb1hiKs2Oserqls7iUygjZGJx/59o9jCtVRDLMBMs
	 SCwgcVUGnSnqDnuDK4q9o8hYSRmm9fNz9kdWcPgKwgUhVMvZNyeL9WABOWANSEu1UX
	 4pu8oXXrwJ3SxlMqtbOaseoSZUrSVOKNGbhYpCpg9A0OZHVHogOfCRi0lUxUcVayCb
	 8CDOjmw2jdjf1qWhPcujsm5NOcSqvgg3f/tQK2tXWGUzIV6GCTbkCZr/fcg2NNrRYv
	 yDAR/Ay2T1W6w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:19 +0100
Subject: [PATCH RFC v2 16/23] fs: make userspace_init_fs a
 dynamically-initialized pointer
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-16-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=5749; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T1PF8uR+tmSj9N7iVtpiuxKAI5ZeF6Hs12ZPEywHqNU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuKasLD8143C9/tut9ofPvuE7Z3w1e8Hch7NuWVfp
 PLqBtPWzo5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJZLkwMky69Ob87RnfJv44
 7848u+VpSvCFMPO3bb8mLNIvnFujkaXDyLC2unTTrskfJpWJsdhlPNNf2HLy7ey9Vm+P3v+pOvH
 ipw8cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 57095219673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79541-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Change userspace_init_fs from a declared-but-unused extern struct to
a dynamically initialized pointer. Add init_userspace_fs() which is
called early in kernel_init() (PID 1) to record PID 1's fs_struct
as the canonical userspace filesystem state.

Wire up __override_init_fs() and __revert_init_fs() to actually swap
current->fs to/from userspace_init_fs. Previously these were no-ops
that stored current->fs back to itself.

Fix nullfs_userspace_init() to compare against userspace_init_fs
instead of &init_fs. When PID 1 unshares its filesystem state, revert
userspace_init_fs to init_fs's root (nullfs) so that stale filesystem
state is not silently inherited by kworkers and usermodehelpers.

At this stage PID 1's fs still points to rootfs (set by
init_mount_tree), so userspace_init_fs points to rootfs and
scoped_with_init_fs() is functionally equivalent to its previous no-op
behavior.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs_struct.h |  5 +++--
 include/linux/init_task.h |  1 +
 init/main.c               |  3 +++
 4 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index b9b9a327f299..c1afa7513e34 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -8,6 +8,7 @@
 #include <linux/fs_struct.h>
 #include <linux/init_task.h>
 #include "internal.h"
+#include "mount.h"
 
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
@@ -163,15 +164,32 @@ EXPORT_SYMBOL_GPL(unshare_fs_struct);
  * fs_struct state. Breaking that contract sucks for both sides.
  * So just don't bother with extra work for this. No sane init
  * system should ever do this.
+ *
+ * On older kernels if PID 1 unshared its filesystem state with us the
+ * kernel simply used the stale fs_struct state implicitly pinning
+ * anything that PID 1 had last used. Even if PID 1 might've moved on to
+ * some completely different fs_struct state and might've even unmounted
+ * the old root.
+ *
+ * This has hilarious consequences: Think continuing to dump coredump
+ * state into an implicitly pinned directory somewhere. Calling random
+ * binaries in the old rootfs via usermodehelpers.
+ *
+ * Be aggressive about this: We simply reject operating on stale
+ * fs_struct state by reverting to nullfs. Every kworker that does
+ * lookups after this point will fail. Every usermodehelper call will
+ * fail. Tough luck but let's be kind and emit a warning to userspace.
  */
 static inline void nullfs_userspace_init(struct fs_struct *old_fs)
 {
 	if (likely(current->pid != 1))
 		return;
 	/* @old_fs may be dangling but for comparison it's fine */
-	if (old_fs != &init_fs)
+	if (old_fs != userspace_init_fs)
 		return;
 	pr_warn("VFS: Pid 1 stopped sharing filesystem state\n");
+	set_fs_root(userspace_init_fs, &init_fs.root);
+	set_fs_pwd(userspace_init_fs, &init_fs.root);
 }
 
 struct fs_struct *switch_fs_struct(struct fs_struct *new_fs)
@@ -198,3 +216,29 @@ struct fs_struct init_fs = {
 	.seq		= __SEQLOCK_UNLOCKED(init_fs.seq),
 	.umask		= 0022,
 };
+
+struct fs_struct *userspace_init_fs __ro_after_init;
+EXPORT_SYMBOL_GPL(userspace_init_fs);
+
+void __init init_userspace_fs(void)
+{
+	struct mount *m;
+	struct path root;
+
+	/* Move PID 1 from nullfs into the initramfs. */
+	m = topmost_overmount(current->nsproxy->mnt_ns->root);
+	root.mnt = &m->mnt;
+	root.dentry = root.mnt->mnt_root;
+
+	VFS_WARN_ON_ONCE(current->pid != 1);
+
+	set_fs_root(current->fs, &root);
+	set_fs_pwd(current->fs, &root);
+
+	/* Hold a reference for the global pointer. */
+	read_seqlock_excl(&current->fs->seq);
+	current->fs->users++;
+	read_sequnlock_excl(&current->fs->seq);
+
+	userspace_init_fs = current->fs;
+}
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index ff525a1e45d4..51d335924029 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -17,6 +17,7 @@ struct fs_struct {
 } __randomize_layout;
 
 extern struct kmem_cache *fs_cachep;
+extern struct fs_struct *userspace_init_fs;
 
 extern void exit_fs(struct task_struct *);
 extern void set_fs_root(struct fs_struct *, const struct path *);
@@ -60,13 +61,13 @@ static inline struct fs_struct *__override_init_fs(void)
 	struct fs_struct *fs;
 
 	fs = current->fs;
-	smp_store_release(&current->fs, current->fs);
+	smp_store_release(&current->fs, userspace_init_fs);
 	return fs;
 }
 
 static inline void __revert_init_fs(struct fs_struct *revert_fs)
 {
-	VFS_WARN_ON_ONCE(current->fs != current->fs);
+	VFS_WARN_ON_ONCE(current->fs != userspace_init_fs);
 	smp_store_release(&current->fs, revert_fs);
 }
 
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index a6cb241ea00c..61536be773f5 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -24,6 +24,7 @@
 
 extern struct files_struct init_files;
 extern struct fs_struct init_fs;
+extern struct fs_struct *userspace_init_fs;
 extern struct nsproxy init_nsproxy;
 
 #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
diff --git a/init/main.c b/init/main.c
index 1cb395dd94e4..5ccc642a5aa7 100644
--- a/init/main.c
+++ b/init/main.c
@@ -102,6 +102,7 @@
 #include <linux/stackdepot.h>
 #include <linux/randomize_kstack.h>
 #include <linux/pidfs.h>
+#include <linux/fs_struct.h>
 #include <linux/ptdump.h>
 #include <linux/time_namespace.h>
 #include <linux/unaligned.h>
@@ -1574,6 +1575,8 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	init_userspace_fs();
+
 	/*
 	 * Wait until kthreadd is all set-up.
 	 */

-- 
2.47.3


