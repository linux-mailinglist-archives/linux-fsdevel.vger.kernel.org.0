Return-Path: <linux-fsdevel+bounces-37429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483219F20DF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 22:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D997A10EF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD31B0F30;
	Sat, 14 Dec 2024 21:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TpNf66Sr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA019D07C
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734210108; cv=none; b=h2XnMfC8IMHAhzscuBnCwgLIf7rFh5ZjMRZzncuoW1wOKLhcL+M6x3Ilft3sbMhGcjh/I9sViyloqzd1k78+zJO04h95rWEkaw6Kk/ZUxRHc3f9gm1QFLmTx6qdj9DTt/T+dUl2m9Rt31WhNweLVkrS7Gd+S5RCzJBN90GMicmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734210108; c=relaxed/simple;
	bh=tC+0qXQjqP4M/OjJabdxOIkRkoMlS9K8YwwVg8Nh3rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GutCzTo2sErkKurwWp2TmBwrf3cXDo4QJXTI4+YCLJu3o2RWz/++NNN8QIeBpovHNv6oEgIF4Y6vg4LZ9QVaSpqrOj+OSWZlLsIpoPSM8yvnHBMTUh1mDY8ESFh8mi0PGou+vCJvNtid4wTUXJa7xQVvyJebaTQ7x3b1UINKXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TpNf66Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8336C4CED1;
	Sat, 14 Dec 2024 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734210108;
	bh=tC+0qXQjqP4M/OjJabdxOIkRkoMlS9K8YwwVg8Nh3rA=;
	h=From:To:Cc:Subject:Date:From;
	b=TpNf66SrclnWM5w6gO1X21JsGC5k13b1LiCnCOVvXmclAuHNCqtRyugAtSHAYRjQS
	 bh54iESaYKdfMj/n69e2sHMzYRO3GkcAxyv613c1nU/d5ECoCghI8Tqfl9p5LNHX/s
	 cSt9fLvExXegXImd7ieitWN0Z27v2PW2z5ienKdHMFTWHLJyvTkttCQJv26ugf9nIh
	 deQ4Cub8P73ZsZC7obkE/9mJMoBjwjNuX/gHppzY2d6opzBYKs4cbzS7Ne4nv0wk13
	 jMlfkjLF+9jIBTJNIw47mq8hKGEpguX0lmvpkXS4jtIWXxtzLAaXQGtJL7b4vJLYKg
	 ainQ/JfsJlw3w==
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] pidfs: lookup pid through rbtree
Date: Sat, 14 Dec 2024 22:01:28 +0100
Message-ID: <20241214-gekoppelt-erdarbeiten-a1f9a982a5a6@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10367; i=brauner@kernel.org; h=from:subject:message-id; bh=tC+0qXQjqP4M/OjJabdxOIkRkoMlS9K8YwwVg8Nh3rA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTHftLilzNkysiKiG+t4RVnu/OEdfJ+d53PtfOr9eQat xvdZnnWUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGKKwx/uKNLRe9p80t6lccW CHzoVfEz+Sp37n3UlfvLw1ZeZjnIy/BXbnuSfNfkz4/CZ1ycNks5YobGp8CjH2+aSN++czv8ebQ OFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The new pid inode number allocation scheme is neat but I overlooked a
possible, even though unlikely, attack that can be used to trigger an
overflow on both 32bit and 64bit.

An unique 64 bit identifier was constructed for each struct pid by two
combining a 32 bit idr with a 32 bit generation number. A 32bit number
was allocated using the idr_alloc_cyclic() infrastructure. When the idr
wrapped around a 32 bit wraparound counter was incremented. The 32 bit
wraparound counter served as the upper 32 bits and the allocated idr
number as the lower 32 bits.

Since the idr can only allocate up to INT_MAX entries everytime a
wraparound happens INT_MAX - 1 entries are lost (Ignoring that numbering
always starts at 2 to avoid theoretical collisions with the root inode
number.).

If userspace fully populates the idr such that and puts itself into
control of two entries such that one entry is somewhere in the middle
and the other entry is the INT_MAX entry then it is possible to overflow
the wraparound counter. That is probably difficult to pull off but the
mere possibility is annoying.

The problem could be contained to 32 bit by switching to a data
structure such as the maple tree that allows allocating 64 bit numbers
on 64 bit machines. That would leave 32 bit in a lurch but that probably
doesn't matter that much. The other problem is that removing entries
form the maple tree is somewhat non-trivial because the removal code can
be called under the irq write lock of tasklist_lock and
irq{save,restore} code.

Instead, allocate unique identifiers for struct pid by simply
incrementing a 64 bit counter and insert each struct pid into the rbtree
so it can be looked up to decode file handles avoiding to leak actual
pids across pid namespaces in file handles.

On both 64 bit and 32 bit the same 64 bit identifier is used to lookup
struct pid in the rbtree. On 64 bit the unique identifier for struct pid
simply becomes the inode number. Comparing two pidfds continues to be as
simple as comparing inode numbers.

On 32 bit the 64 bit number assigned to struct pid is split into two 32
bit numbers. The lower 32 bits are used as the inode number and the
upper 32 bits are used as the inode generation number. Whenever a
wraparound happens on 32 bit the 64 bit number will be incremented by 2
so inode numbering starts at 2 again.

When a wraparound happens on 32 bit multiple pidfds with the same inode
number are likely to exist. This isn't a problem since before pidfs
pidfds used the anonymous inode meaning all pidfds had the same inode
number. On 32 bit sserspace can thus reconstruct the 64 bit identifier
by retrieving both the inode number and the inode generation number to
compare, or use file handles. This gives the same guarantees on both 32
bit and 64 bit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c            | 129 ++++++++++++++++++++++++++----------------
 include/linux/pid.h   |   2 +
 include/linux/pidfs.h |   2 +-
 kernel/pid.c          |   6 +-
 4 files changed, 86 insertions(+), 53 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index fe10d2a126a2..c5a51c69acc8 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -24,18 +24,9 @@
 #include "internal.h"
 #include "mount.h"
 
-static DEFINE_IDR(pidfs_ino_idr);
-
-static u32 pidfs_ino_upper_32_bits = 0;
+static struct rb_root pidfs_ino_tree = RB_ROOT;
 
 #if BITS_PER_LONG == 32
-/*
- * On 32 bit systems the lower 32 bits are the inode number and
- * the higher 32 bits are the generation number. The starting
- * value for the inode number and the generation number is one.
- */
-static u32 pidfs_ino_lower_32_bits = 1;
-
 static inline unsigned long pidfs_ino(u64 ino)
 {
 	return lower_32_bits(ino);
@@ -49,52 +40,79 @@ static inline u32 pidfs_gen(u64 ino)
 
 #else
 
-static u32 pidfs_ino_lower_32_bits = 0;
-
 /* On 64 bit simply return ino. */
 static inline unsigned long pidfs_ino(u64 ino)
 {
 	return ino;
 }
 
-/* On 64 bit the generation number is 1. */
+/* On 64 bit the generation number is 0. */
 static inline u32 pidfs_gen(u64 ino)
 {
-	return 1;
+	return 0;
 }
 #endif
 
-/*
- * Construct an inode number for struct pid in a way that we can use the
- * lower 32bit to lookup struct pid independent of any pid numbers that
- * could be leaked into userspace (e.g., via file handle encoding).
- */
-int pidfs_add_pid(struct pid *pid)
+static int pidfs_ino_cmp(struct rb_node *a, const struct rb_node *b)
 {
-	u32 upper;
-	int lower;
-
-        /*
-	 * Inode numbering for pidfs start at 2. This avoids collisions
-	 * with the root inode which is 1 for pseudo filesystems.
-         */
-	lower = idr_alloc_cyclic(&pidfs_ino_idr, pid, 2, 0, GFP_ATOMIC);
-	if (lower >= 0 && lower < pidfs_ino_lower_32_bits)
-		pidfs_ino_upper_32_bits++;
-	upper = pidfs_ino_upper_32_bits;
-	pidfs_ino_lower_32_bits = lower;
-	if (lower < 0)
-		return lower;
-
-	pid->ino = ((u64)upper << 32) | lower;
-	pid->stashed = NULL;
+	struct pid *pid_a = rb_entry(a, struct pid, pidfs_node);
+	struct pid *pid_b = rb_entry(b, struct pid, pidfs_node);
+	u64 pid_ino_a = pid_a->ino;
+	u64 pid_ino_b = pid_b->ino;
+
+	if (pid_ino_a < pid_ino_b)
+		return -1;
+	if (pid_ino_a > pid_ino_b)
+		return 1;
 	return 0;
 }
 
-/* The idr number to remove is the lower 32 bits of the inode. */
+void pidfs_add_pid(struct pid *pid)
+{
+	static u64 pidfs_ino_nr = 2;
+
+	/*
+	 * On 64 bit nothing special happens. The 64bit number assigned
+	 * to struct pid is the inode number.
+	 *
+	 * On 32 bit the 64 bit number assigned to struct pid is split
+	 * into two 32 bit numbers. The lower 32 bits are used as the
+	 * inode number and the upper 32 bits are used as the inode
+	 * generation number.
+	 *
+	 * On 32 bit pidfs_ino() will return the lower 32 bit. When
+	 * pidfs_ino() returns zero a wrap around happened. When a
+	 * wraparound happens the 64 bit number will be incremented by 2
+	 * so inode numbering starts at 2 again.
+	 *
+	 * On 64 bit comparing two pidfds is as simple as comparing
+	 * inode numbers.
+	 *
+	 * When a wraparound happens on 32 bit multiple pidfds with the
+	 * same inode number are likely to exist (This isn't a problem
+	 * since before pidfs pidfds used the anonymous inode meaning
+	 * all pidfds had the same inode number.). Userspace can
+	 * reconstruct the 64 bit identifier by retrieving both the
+	 * inode number and the inode generation number to compare or
+	 * use file handles.
+	 */
+	if (pidfs_ino(pidfs_ino_nr) == 0)
+		pidfs_ino_nr += 2;
+
+	pid->ino = pidfs_ino_nr;
+	pid->stashed = NULL;
+	pidfs_ino_nr++;
+
+	write_seqcount_begin(&pidmap_lock_seq);
+	rb_find_add_rcu(&pid->pidfs_node, &pidfs_ino_tree, pidfs_ino_cmp);
+	write_seqcount_end(&pidmap_lock_seq);
+}
+
 void pidfs_remove_pid(struct pid *pid)
 {
-	idr_remove(&pidfs_ino_idr, lower_32_bits(pid->ino));
+	write_seqcount_begin(&pidmap_lock_seq);
+	rb_erase(&pid->pidfs_node, &pidfs_ino_tree);
+	write_seqcount_end(&pidmap_lock_seq);
 }
 
 #ifdef CONFIG_PROC_FS
@@ -513,24 +531,37 @@ static int pidfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
 	return FILEID_KERNFS;
 }
 
+static int pidfs_ino_find(const void *key, const struct rb_node *node)
+{
+	const u64 pid_ino = *(u64 *)key;
+	const struct pid *pid = rb_entry(node, struct pid, pidfs_node);
+
+	if (pid_ino < pid->ino)
+		return -1;
+	if (pid_ino > pid->ino)
+		return 1;
+	return 0;
+}
+
 /* Find a struct pid based on the inode number. */
 static struct pid *pidfs_ino_get_pid(u64 ino)
 {
-	unsigned long pid_ino = pidfs_ino(ino);
-	u32 gen = pidfs_gen(ino);
 	struct pid *pid;
+	struct rb_node *node;
+	unsigned int seq;
 
 	guard(rcu)();
-
-	pid = idr_find(&pidfs_ino_idr, lower_32_bits(pid_ino));
-	if (!pid)
+	do {
+		seq = read_seqcount_begin(&pidmap_lock_seq);
+		node = rb_find_rcu(&ino, &pidfs_ino_tree, pidfs_ino_find);
+		if (node)
+			break;
+	} while (read_seqcount_retry(&pidmap_lock_seq, seq));
+
+	if (!node)
 		return NULL;
 
-	if (pidfs_ino(pid->ino) != pid_ino)
-		return NULL;
-
-	if (pidfs_gen(pid->ino) != gen)
-		return NULL;
+	pid = rb_entry(node, struct pid, pidfs_node);
 
 	/* Within our pid namespace hierarchy? */
 	if (pid_vnr(pid) == 0)
diff --git a/include/linux/pid.h b/include/linux/pid.h
index a3aad9b4074c..fe575fcdb4af 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -59,6 +59,7 @@ struct pid
 	spinlock_t lock;
 	struct dentry *stashed;
 	u64 ino;
+	struct rb_node pidfs_node;
 	/* lists of tasks that use this pid */
 	struct hlist_head tasks[PIDTYPE_MAX];
 	struct hlist_head inodes;
@@ -68,6 +69,7 @@ struct pid
 	struct upid numbers[];
 };
 
+extern seqcount_spinlock_t pidmap_lock_seq;
 extern struct pid init_struct_pid;
 
 struct file;
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 2958652bb108..df574d6708d4 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -4,7 +4,7 @@
 
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
-int pidfs_add_pid(struct pid *pid);
+void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
 
 #endif /* _LINUX_PID_FS_H */
diff --git a/kernel/pid.c b/kernel/pid.c
index 58567d6904b2..aa2a7d4da455 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -43,6 +43,7 @@
 #include <linux/sched/task.h>
 #include <linux/idr.h>
 #include <linux/pidfs.h>
+#include <linux/seqlock.h>
 #include <net/sock.h>
 #include <uapi/linux/pidfd.h>
 
@@ -103,6 +104,7 @@ EXPORT_SYMBOL_GPL(init_pid_ns);
  */
 
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(pidmap_lock);
+seqcount_spinlock_t pidmap_lock_seq = SEQCNT_SPINLOCK_ZERO(pidmap_lock_seq, &pidmap_lock);
 
 void put_pid(struct pid *pid)
 {
@@ -273,9 +275,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t *set_tid,
 	spin_lock_irq(&pidmap_lock);
 	if (!(ns->pid_allocated & PIDNS_ADDING))
 		goto out_unlock;
-	retval = pidfs_add_pid(pid);
-	if (retval)
-		goto out_unlock;
+	pidfs_add_pid(pid);
 	for ( ; upid >= pid->numbers; --upid) {
 		/* Make the PID visible to find_pid_ns. */
 		idr_replace(&upid->ns->idr, pid, upid->nr);
-- 
2.45.2


